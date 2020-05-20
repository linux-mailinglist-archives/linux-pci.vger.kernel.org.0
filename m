Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E531A1DABFD
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 09:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgETH2I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 03:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETH2I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 03:28:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5AEC061A0E
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 00:28:08 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1jbJ8m-0005fd-1O; Wed, 20 May 2020 09:27:48 +0200
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1jbJ8l-00021e-8e; Wed, 20 May 2020 09:27:47 +0200
Date:   Wed, 20 May 2020 09:27:47 +0200
From:   Philipp Zabel <pza@pengutronix.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/15] PCI: brcmstb: Add control of rescal reset
Message-ID: <20200520072747.GB5213@pengutronix.de>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
 <20200519203419.12369-8-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200519203419.12369-8-james.quinlan@broadcom.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:17:38 up 90 days, 14:48, 112 users,  load average: 0.07, 0.35,
 0.32
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jim,

On Tue, May 19, 2020 at 04:34:05PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> Some STB chips have a special purpose reset controller named
> RESCAL (reset calibration).  This commit adds the control
> of RESCAL as well as the ability to start and stop its
> operation for PCIe HW.
> 
> Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 81 ++++++++++++++++++++++++++-
>  1 file changed, 80 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 2c470104ba38..0787e8f6f7e5 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
[...]
> @@ -1100,6 +1164,21 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "could not enable clock\n");
>  		return ret;
>  	}
> +	pcie->rescal = devm_reset_control_get_shared(&pdev->dev, "rescal");
> +	if (IS_ERR(pcie->rescal)) {
> +		if (PTR_ERR(pcie->rescal) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		pcie->rescal = NULL;

This is effectively an optional reset control, so it is better to use:
↵
	pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev,
							      "rescal");↵
	if (IS_ERR(pcie->rescal))
		return PTR_ERR(pcie->rescal);

> +	} else {
> +		ret = reset_control_deassert(pcie->rescal);
> +		if (ret)
> +			dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> +	}

reset_control_* can handle rstc == NULL parameters for optional reset
controls, so this can be done unconditionally:

	ret = reset_control_deassert(pcie->rescal);↵
	if (ret)↵
		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");↵

Is rescal handled by the reset-brcmstb-rescal driver? Since that only
implements the .reset op, I would expect reset_control_reset() here.
Otherwise this looks like it'd be missing a reset_control_assert in
remove.

regards
Philipp
