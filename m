Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AED1C6EA4
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 12:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgEFKnF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 06:43:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgEFKnF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 May 2020 06:43:05 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9094220663;
        Wed,  6 May 2020 10:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588761784;
        bh=qjFxbQJhwnjLswkECG7XON/LpTe8nEe02+5NBDCvjtA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cSbK4h9sQzP5m7pYiJdwdOo8ET3iaMr1rZpcO1x03ZxG4zrp7HgG27gc5E7iKlYBV
         z2CtAHjpeUw4uiCUovjFTfPrPUqzcEN6baYqdqmiSR5ifUKXGAwuafruomAwTALY0U
         9LXU2MHGZNFu4pBSupEbhF2T4zGWwTpkr0kniM8g=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jWHW2-009vEj-UY; Wed, 06 May 2020 11:43:03 +0100
Date:   Wed, 6 May 2020 11:43:01 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Yue Wang <yue.wang@Amlogic.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] PCI: amlogic: meson: Don't use FAST_LINK_MODE to set up
 link
Message-ID: <20200506114301.7288c02d@why>
In-Reply-To: <20200429164230.309922-1-maz@kernel.org>
References: <20200429164230.309922-1-maz@kernel.org>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, robh@kernel.org, lorenzo.pieralisi@arm.com, khilman@baylibre.com, yue.wang@Amlogic.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 29 Apr 2020 17:42:30 +0100
Marc Zyngier <maz@kernel.org> wrote:

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
> 
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

Yue, Kevin: any comment on this?

I found that the issue is reproducible even without a PCIe switch,
depending on the single device I plug in this machine (an Intel SSD
works fine, while a Marvell Ethernet adapter never shows up) as the
LTSSM times out much earlier than it really should (HW timers running
too quickly). Applying this patch makes every single device I have
lying around work fine.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
