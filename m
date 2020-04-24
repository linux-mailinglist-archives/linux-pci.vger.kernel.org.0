Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0161B70C6
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 11:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgDXJZt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 05:25:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgDXJZt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 05:25:49 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B200D20724;
        Fri, 24 Apr 2020 09:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587720348;
        bh=t7xTZ9J4en/MjkiMHZhzp48oDSHJbtjCC8DX8NgHS6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X4YgCg8G/j90ojHlYaCmhVdLvy25pkyqmH/enHwEAuRNnICzXcXsRWhSuZAlrrfZB
         u3VEuVXG3U2gImJ6i671jlC7l+AiWade3PHeqQozSDdgkkrTBZU3DQhCbAswCSW0b/
         EWifhAaDjPP22grjvC7Q0MuGBtNbC87MtW1O9ZlY=
Received: by pali.im (Postfix)
        id 5B27C82E; Fri, 24 Apr 2020 11:25:46 +0200 (CEST)
Date:   Fri, 24 Apr 2020 11:25:46 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>
Subject: Re: [PATCH v2 4/9] PCI: aardvark: issue PERST via GPIO
Message-ID: <20200424092546.25p3hdtkehohe3xw@pali>
References: <20200421111701.17088-1-marek.behun@nic.cz>
 <20200421111701.17088-5-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200421111701.17088-5-marek.behun@nic.cz>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 21 April 2020 13:16:56 Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> Add support for issuing PERST via GPIO specified in 'reset-gpios'
> property (as described in PCI device tree bindings).
> 
> Some buggy cards (e.g. Compex WLE900VX or WLE1216) are not detected
> after reboot when PERST is not issued during driver initialization.
> 
> Tested on Turris MOX.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/pci/controller/pci-aardvark.c | 32 +++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 606bae1e7a88..e2d18094d8ca 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
...
> +static void advk_pcie_issue_perst(struct advk_pcie *pcie)
> +{
> +	if (!pcie->reset_gpio)
> +		return;
> +
> +	dev_info(&pcie->pdev->dev, "issuing PERST via reset GPIO for 1ms\n");
> +	gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> +	usleep_range(1000, 2000);
> +	gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> +}

After more testing we will have to increase this timeout to 10ms as some
Compex cards are sometimes not detected with current 1ms timeout. I will
do it in V3 patch series.


Bjorn, do you know if there is a defined timeout in PCIE specification
how long should be card in PERST?

I looked into others pci kernel drivers and basically every driver is
using its own timeout.

pcie-kirin.c --> usleep_range(20000, 25000);
pcie-qcom.c --> usleep_range(1000, 1000 + 500); msleep(100);
pci-mvebu.c --> udelay(100);
pci-tegra.c --> usleep_range(1000, 2000);
pcie-iproc.c --> udelay(250);
pcie-mediatek.c --> no delay
pci-imx6.c --> msleep(100);

But I guess that this timeout should not depend on driver or pci
controller, but rather on connected card or on some recommended value if
defined by PCIE specification.
