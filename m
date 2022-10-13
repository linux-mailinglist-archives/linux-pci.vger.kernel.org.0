Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BE75FDC25
	for <lists+linux-pci@lfdr.de>; Thu, 13 Oct 2022 16:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJMOLk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Oct 2022 10:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJMOLj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Oct 2022 10:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B5223176;
        Thu, 13 Oct 2022 07:11:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5937D617EE;
        Thu, 13 Oct 2022 14:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6416DC433D6;
        Thu, 13 Oct 2022 14:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665670297;
        bh=mpFbZHArAaQgmD7RTxwwRekiQKVwpKraUwtRqWMUdYY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=B77rUDC5VLnYV3z9CTVT9A86ODZkirniB9tdWCE3MZPO3snv90muE8TJdSM+Gx0BZ
         9BDPSmcxbSE0jcQL9z9ZD3EqOUTBDGGJF2qbCem2lwwBk0yb+8Tu3EeMI2nJsxYV1Z
         XcRKnVh0jVtOWrH64ZQdluPGA7RLBxEABBDUFvJz4E9yPdikzqLBGiktSoUpSELuIa
         eHDYW2A2BtZlYto2Gx0X16y5LDi2FoQuA3wFTuJXHoJhu5gFn35nn/X9j8MCIKA6HQ
         sMRun6/oeuxYbaEgrDIuQELrn7TGjgkpoqNPT7NoF04HLifCNU/DkvqrE2p1/F81F6
         mk9cOFUUZF36g==
Date:   Thu, 13 Oct 2022 09:11:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] PCI: brcmstb: Functions needlessly specified as
 "inline"
Message-ID: <20221013141135.GA3245411@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011184211.18128-5-jim2101024@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If you have occasion to revise this series, update the subject to be a
sentence like the others, e.g., something like

  PCI: brcmstb: Drop needless 'inline' annotations

On Tue, Oct 11, 2022 at 02:42:09PM -0400, Jim Quinlan wrote:
> A number of inline functions are called rarely and/or are not
> time-critical.  Take out the "inline" and let the compiler do its work.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks, looks good to me!

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/controller/pcie-brcmstb.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c7210cec1f58..e3045f1eadbc 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -723,7 +723,7 @@ static void __iomem *brcm7425_pcie_map_bus(struct pci_bus *bus,
>  	return base + DATA_ADDR(pcie);
>  }
>  
> -static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
> +static void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
>  {
>  	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
>  	u32 shift = RGR1_SW_INIT_1_INIT_GENERIC_SHIFT;
> @@ -733,7 +733,7 @@ static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie,
>  	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>  }
>  
> -static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
> +static void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val)
>  {
>  	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_7278_MASK;
>  	u32 shift = RGR1_SW_INIT_1_INIT_7278_SHIFT;
> @@ -743,7 +743,7 @@ static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32
>  	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>  }
>  
> -static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
> +static void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
>  {
>  	if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset controller\n"))
>  		return;
> @@ -754,7 +754,7 @@ static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
>  		reset_control_deassert(pcie->perst_reset);
>  }
>  
> -static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
> +static void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
>  {
>  	u32 tmp;
>  
> @@ -764,7 +764,7 @@ static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
>  	writel(tmp, pcie->base +  PCIE_MISC_PCIE_CTRL);
>  }
>  
> -static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
> +static void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
>  {
>  	u32 tmp;
>  
> @@ -773,7 +773,7 @@ static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val)
>  	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
>  }
>  
> -static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
> +static int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
>  							u64 *rc_bar2_size,
>  							u64 *rc_bar2_offset)
>  {
> -- 
> 2.17.1
> 
