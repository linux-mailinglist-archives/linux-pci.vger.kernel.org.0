Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7091E1CD674
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 12:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgEKKWo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 06:22:44 -0400
Received: from foss.arm.com ([217.140.110.172]:55588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729232AbgEKKWo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 06:22:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D3A51FB;
        Mon, 11 May 2020 03:22:43 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4790F3F305;
        Mon, 11 May 2020 03:22:42 -0700 (PDT)
Date:   Mon, 11 May 2020 11:22:40 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yue Wang <yue.wang@Amlogic.com>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] PCI: amlogic: meson: Don't use FAST_LINK_MODE to set up
 link
Message-ID: <20200511102239.GC24149@e121166-lin.cambridge.arm.com>
References: <20200429164230.309922-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429164230.309922-1-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 29, 2020 at 05:42:30PM +0100, Marc Zyngier wrote:
> My vim3l board stubbornly refuses to play ball with a bog
> standard PCIe switch (ASM1184e), spitting all kind of errors
> ranging from link never coming up to crazy things like downstream
> ports falling off the face of the planet.
> 
> Upon investigating how the PCIe RC is configured, I found the
> following nugget: the Sysnopsys DWC PCIe Reference Manual, in the
> section dedicated to the PLCR register, describes bit 7 (FAST_LINK_MODE)
> as:
> 
> "Sets all internal timers to fast mode for simulation purposes."
> 
> I completely understand the need for setting this bit from a simulation
> perspective, but what I have on my desk is actual silicon, which
> expects timers to have a nominal value (and I expect this is the
> case for most people).
> 
> Making sure the FAST_LINK_MODE bit is cleared when configuring the RC
> solves this problem.
> 
> Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/pci/controller/dwc/pci-meson.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reworded the commit log (even if yours was more fun :)) and applied
to pci/dwc, thanks !

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 3715dceca1bf..ca59ba9e0ecd 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -289,11 +289,11 @@ static void meson_pcie_init_dw(struct meson_pcie *mp)
>  	meson_cfg_writel(mp, val, PCIE_CFG0);
>  
>  	val = meson_elb_readl(mp, PCIE_PORT_LINK_CTRL_OFF);
> -	val &= ~LINK_CAPABLE_MASK;
> +	val &= ~(LINK_CAPABLE_MASK | FAST_LINK_MODE);
>  	meson_elb_writel(mp, val, PCIE_PORT_LINK_CTRL_OFF);
>  
>  	val = meson_elb_readl(mp, PCIE_PORT_LINK_CTRL_OFF);
> -	val |= LINK_CAPABLE_X1 | FAST_LINK_MODE;
> +	val |= LINK_CAPABLE_X1;
>  	meson_elb_writel(mp, val, PCIE_PORT_LINK_CTRL_OFF);
>  
>  	val = meson_elb_readl(mp, PCIE_GEN2_CTRL_OFF);
> -- 
> 2.26.2
> 
