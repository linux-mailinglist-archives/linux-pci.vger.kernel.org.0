Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDEC76F02A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 18:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjHCQ5e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 12:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjHCQ5N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 12:57:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3D344B5;
        Thu,  3 Aug 2023 09:56:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D664E61E57;
        Thu,  3 Aug 2023 16:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE62C433C7;
        Thu,  3 Aug 2023 16:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691081752;
        bh=0CBnNT6EVkBwTo+BPc2FqKAVkt1Cu1bKt1yLNDXR0WE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=QZxchw4Il/uKkB53Tl7dvZPzTdws/Av7D8/soPQDYkXz5wjmd3wktjcyh7Emn/IX0
         h+xEZkKvhNbUiJZBAgM/6Rsk3e6P/BpjSz9kZCq2EKE2UQfy8S5I4qJkxfRhFnKMlU
         jG7BpMjlcHVD/GKuAkbZwyvi57bo99kiIvmtCgD3lcTHyEh7vzzOU+I4y0rFAjlVru
         lrvADWaJZGh++tOTXJ4cV547OLOpj7YmGT61Sj+gMdNBdWz/8cuIwxgXvz1RizHRPF
         HHXJA6Zq6hQ2yQBPjDzLUWQKpvJbMCKFA/U5o3HluaRuDpUMU+pH0rsys6x5AAe7vM
         k75MsHn9MA1zA==
Date:   Thu, 3 Aug 2023 11:55:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, lpieralisi@kernel.org,
        bharat.kumar.gogada@amd.com, michal.simek@amd.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: xilinx-nwl: Remove unnecessary code and updating
 ecam default value.
Message-ID: <20230803165549.GA102529@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803115016.4266-1-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 03, 2023 at 05:20:16PM +0530, Thippeswamy Havalige wrote:
> Remove reduntant code.
> Change NWL_ECAM_VALUE_DEFAULT to 16 to support maximum 256 buses.

Remove period from subject line.

Please mention the most important part first in the subject -- the
ECAM change sounds more important than removing redundant code.

s/ecam/ECAM/
s/reduntant/redundant/

Please elaborate on why this code is redundant.  What makes it
redundant?  Apparently the bus number registers default to the correct
values or some other software programs them?

I don't see the point of the struct nwl_pcie.ecam_value member.  It is
set once and never updated, so we could just use
NWL_ECAM_VALUE_DEFAULT instead.

"ECAM_VALUE" is not a very informative name.  I don't know what an
"ECAM value" would be.  How is the value 16 related to a maximum of
256 buses?  We only need 8 bits to address 256 buses, so it must be
something else.  The bus number appears at bits 20-27
(PCIE_ECAM_BUS_SHIFT) in a standard ECAM address, so probably not the
bit location?

Does this fix a problem?

> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 176686b..6d40543 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -126,7 +126,7 @@
>  #define E_ECAM_CR_ENABLE		BIT(0)
>  #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
>  #define E_ECAM_SIZE_SHIFT		16
> -#define NWL_ECAM_VALUE_DEFAULT		12
> +#define NWL_ECAM_VALUE_DEFAULT		16
>  
>  #define CFG_DMA_REG_BAR			GENMASK(2, 0)
>  #define CFG_PCIE_CACHE			GENMASK(7, 0)
> @@ -683,15 +683,6 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
>  	nwl_bridge_writel(pcie, upper_32_bits(pcie->phys_ecam_base),
>  			  E_ECAM_BASE_HI);
>  
> -	/* Get bus range */
> -	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CONTROL);
> -	pcie->last_busno = (ecam_val & E_ECAM_SIZE_LOC) >> E_ECAM_SIZE_SHIFT;
> -	/* Write primary, secondary and subordinate bus numbers */
> -	ecam_val = first_busno;
> -	ecam_val |= (first_busno + 1) << 8;
> -	ecam_val |= (pcie->last_busno << E_ECAM_SIZE_SHIFT);
> -	writel(ecam_val, (pcie->ecam_base + PCI_PRIMARY_BUS));

"ecam_val" looks like it's supposed to be the 32-bit value containing
PCI_PRIMARY_BUS (low 8 bits, from the pointless "first_busno" that is
always 0), PCI_SECONDARY_BUS (bits 8-15, always bus 1),
PCI_SUBORDINATE_BUS (bits 16-23, totally unrelated to
E_ECAM_SIZE_SHIFT although E_ECAM_SIZE_SHIFT happens to be the correct
value (16)), and PCI_SEC_LATENCY_TIMER (not applicable for PCIe).

So I guess the assumption is that these registers already contain the
correct values?

It looks like previously PCI_SUBORDINATE_BUS (i.e., pcie->last_busno)
was 12, since we wrote NWL_ECAM_VALUE_DEFAULT to E_ECAM_CONTROL and
then read it back?

And now pcie->last_busno is competely unused?

This all seems not quite baked.  Am I missing something?

Bjorn
