Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B38B7D444F
	for <lists+linux-pci@lfdr.de>; Tue, 24 Oct 2023 02:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjJXAvm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Oct 2023 20:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjJXAvm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2023 20:51:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A30C0
        for <linux-pci@vger.kernel.org>; Mon, 23 Oct 2023 17:51:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58695C433C7;
        Tue, 24 Oct 2023 00:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698108698;
        bh=/ZeSAIQtSE4U5bQaKHX/0l8LrNl2SJylc5sSGye6lQ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rpexxQNBKbHEgMjRJC/kLd4pHXvaPRVqbYRoBAq+1UfjZMKJhzHzeMX/vqOOxp27H
         wcVESjnEl3qfVYAtCch8oivBAeWH4oBVWAxxEZYvP9BLY5+A08Nl+FkfkmKrW9JY4V
         cKxYbQv0DQ2Y0t3yy780YM9jYl1nJ/GCCbY10tgMmPYWVzS3RD/KQMzHBpdtYrWUHR
         9neXBUhIjhO2eHHyKbEPSqzKmmEAr3fAkSIpYR8E0+KuPVvPRXri7XlUyV7jww9Qlg
         S0cv9SOopqCG9JYH6Ss4bjWnoD/9HtjTZvXLpEWTDrKSwX9T63gmH8wKZT+6YbcKmb
         DMZwrav308n1w==
Date:   Mon, 23 Oct 2023 19:51:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Philipp Rosenberger <p.rosenberger@kunbus.com>,
        Cyril Brulebois <kibi@debian.org>
Subject: Re: [PATCH] PCI: brcmstb: Avoid downstream access during link
 training
Message-ID: <20231024005135.GA1636014@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <385baf9dbfb6b65112803998dfc0cd6f84a5e6ba.1691296765.git.lukas@wunner.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 06, 2023 at 06:44:50AM +0200, Lukas Wunner wrote:
> The Broadcom Set Top Box PCIe controller signals an Asynchronous SError
> Interrupt and thus causes a kernel panic when non-posted transactions
> time out.  This differs from most other PCIe controllers which return a
> fabricated "all ones" response instead.
> 
> To avoid gratuitous kernel panics, the driver reads the link status from
> a proprietary PCIE_MISC_PCIE_STATUS register and skips downstream
> accesses if the link is down.
> 
> However the bits in the proprietary register may purport that the link
> is up even though link training is still in progress (as indicated by
> the Link Training bit in the Link Status register).
> 
> This has been observed with various PCIe switches attached to a BCM2711
> (Raspberry Pi CM4):  The issue is most pronounced with the Pericom
> PI7C9X2G404SV, but has also occasionally been witnessed with the Pericom
> PI7C9X2G404SL and ASMedia ASM1184e.

So somebody is seeing kernel panics when these switches are connected?
Do we have pointers to those reports that we can reference here?

> Check the Link Training bit in addition to the PCIE_MISC_PCIE_STATUS
> register before performing downstream accesses.

I guess the theory is that link training takes longer than usual with
these devices?  Is the idea here that we wait longer in
brcm_pcie_start_link()?

Or is it that we avoid config accesses to downstream devices while the
link is not yet up?  This seems like it would be problematic (see
below).

> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index f593a422bd63..b4abfced8e9b 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -679,8 +679,10 @@ static bool brcm_pcie_link_up(struct brcm_pcie *pcie)
>  	u32 val = readl(pcie->base + PCIE_MISC_PCIE_STATUS);
>  	u32 dla = FIELD_GET(PCIE_MISC_PCIE_STATUS_PCIE_DL_ACTIVE_MASK, val);
>  	u32 plu = FIELD_GET(PCIE_MISC_PCIE_STATUS_PCIE_PHYLINKUP_MASK, val);
> +	u16 lnksta = readw(pcie->base + BRCM_PCIE_CAP_REGS + PCI_EXP_LNKSTA);
> +	u16 lt = FIELD_GET(PCI_EXP_LNKSTA_LT, lnksta);
>  
> -	return dla && plu;
> +	return dla && plu && !lt;

It looks like this will make config accesses to downstream devices
fail while PCI_EXP_LNKSTA_LT is set by making brcm_pcie_link_up()
return false, which makes brcm_pcie_map_bus() return NULL, which will
make pci_generic_config_read() return PCIBIOS_DEVICE_NOT_FOUND without
attempting the config read.

So this should avoid the SError (mostly, at least; I'm sure this is
still racy), but what about the config access?  Presumably the caller
depends on it happening, and it sounds like it *would* happen if we
tried a little later.  I don't think we can count on the caller to
retry a failed access, e.g., enumeration config reads that return ~0
are just interpreted as "there's no device here."

Maybe the real issue is that we need to make brcm_pcie_start_link()
wait longer, where we aren't attempting a config read?

Jim, are you still interested in testing this?

>  }
>  
>  static void __iomem *brcm_pcie_map_bus(struct pci_bus *bus,
> -- 
> 2.39.2
> 
