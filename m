Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908781CD6C7
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 12:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgEKKpv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 06:45:51 -0400
Received: from foss.arm.com ([217.140.110.172]:56070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgEKKpv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 06:45:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AB041FB;
        Mon, 11 May 2020 03:45:50 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C49693F305;
        Mon, 11 May 2020 03:45:48 -0700 (PDT)
Date:   Mon, 11 May 2020 11:45:38 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jeremy Linton <jeremy.linton@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        s.nawrocki@samsung.com, tim.gover@raspberrypi.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: brcmstb: Assert fundamental reset on initialization
Message-ID: <20200511104527.GA24954@e121166-lin.cambridge.arm.com>
References: <20200507172020.18000-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507172020.18000-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 07, 2020 at 07:20:20PM +0200, Nicolas Saenz Julienne wrote:
> While preparing the driver for upstream this detail was missed.
> 
> If not asserted during the initialization process, devices connected on
> the bus will not be made aware of the internal reset happening. This,
> potentially resulting in unexpected behavior.
> 
> Fixes: c0452137034b ("PCI: brcmstb: Add Broadcom STB PCIe host controller driver")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to pci/brcmstb, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 0b97b94c4a9a..795a03be4150 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -699,6 +699,7 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
>  
>  	/* Reset the bridge */
>  	brcm_pcie_bridge_sw_init_set(pcie, 1);
> +	brcm_pcie_perst_set(pcie, 1);
>  
>  	usleep_range(100, 200);
>  
> -- 
> 2.26.2
> 
