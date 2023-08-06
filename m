Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4657716CF
	for <lists+linux-pci@lfdr.de>; Sun,  6 Aug 2023 23:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjHFVnp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Aug 2023 17:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHFVno (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Aug 2023 17:43:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2CF10FC
        for <linux-pci@vger.kernel.org>; Sun,  6 Aug 2023 14:43:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C79B36125A
        for <linux-pci@vger.kernel.org>; Sun,  6 Aug 2023 21:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09C4C433C7;
        Sun,  6 Aug 2023 21:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691358222;
        bh=Qy4JjRp+ieqLqWdWedXOywxTrgR4i+3kQ6nDGUh7PJA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNOdH3uQiLUnC5v+v7mMzvox3GP8Gn/umxe9B7m+rX4P+Zs1DhTVnq2dMOaSckbfB
         nEtx1fXVevAFXneQSDa6n7AIc3XvRTFbRg3PfI6TnfmdVyDZIzhgSqQD1nbO4SSwwD
         foC+fNFdq/HlW0FrNJ7Cl/J2yplhQtpVx/5U9P1aAXbvC+YxnCjqpOnepXL6Oyrelj
         T7DQcsTZCFWGHiMoeT1QG+FhE0ZvO63wHNyLieSz/hlyn90qeyCPxToRFGnjh5JQtr
         LVUFTARjmfNYLHAAOhZA8qceDAlgLi3B2VxLOhLZ5kxXFV61ZhK2k/2r7PeNMg9dpA
         XDvpeG/sMQWcA==
Received: by pali.im (Postfix)
        id E6E02AE3; Sun,  6 Aug 2023 23:43:38 +0200 (CEST)
Date:   Sun, 6 Aug 2023 23:43:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
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
Message-ID: <20230806214338.7ylsi6aj6medp3us@pali>
References: <385baf9dbfb6b65112803998dfc0cd6f84a5e6ba.1691296765.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <385baf9dbfb6b65112803998dfc0cd6f84a5e6ba.1691296765.git.lukas@wunner.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday 06 August 2023 06:44:50 Lukas Wunner wrote:
> The Broadcom Set Top Box PCIe controller signals an Asynchronous SError
> Interrupt

This is little incorrect wording. PCIe controller cannot send Async
SError, this is ARMv8 specific thing. In this case PCIe controller is
connected to ARM core via AXI bus and on PCIe transaction timeout it
sends AXI Slave Error, which then ARMv8 core reports to kernel as Async
SError interrupt.

The proper fix is to configure PCIe controller to never send AXI Slave
Error and neither AXI Decode Error (to prevent SErrors at all). For
example Synopsys PCIe controllers have proprietary hidden configuration
bits for enabling/disabling this AXI error reporting behavior.

Or second option is to access affected memory from the ARMv8 core via
synchronous operations and map memory as nGnRnE. Then ARMv8 core reports
AXI Slave Error as Synchronous Abort Exception which you can catch,
examine that was caused on PCIe memory region and fabricate all-ones
response. But the second option is not available for some licensed ARMv8
Cortex cores (e.g. A53) as they do not implement nE (non Early Write
Acknowledgement) memory mapping correctly.

The patch below does not fix the issue at all, instead it opens a new
race condition that if link state is changed _after_ the check and
_before_ accessing config space.

> and thus causes a kernel panic when non-posted transactions
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
> 
> Check the Link Training bit in addition to the PCIE_MISC_PCIE_STATUS
> register before performing downstream accesses.
> 
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
>  }
>  
>  static void __iomem *brcm_pcie_map_bus(struct pci_bus *bus,
> -- 
> 2.39.2
> 
