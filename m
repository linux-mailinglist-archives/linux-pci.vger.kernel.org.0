Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90A776BEF3
	for <lists+linux-pci@lfdr.de>; Tue,  1 Aug 2023 23:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjHAVGh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Aug 2023 17:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjHAVGW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Aug 2023 17:06:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9926129
        for <linux-pci@vger.kernel.org>; Tue,  1 Aug 2023 14:06:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D4F661712
        for <linux-pci@vger.kernel.org>; Tue,  1 Aug 2023 21:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FE0C433C7;
        Tue,  1 Aug 2023 21:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690923980;
        bh=ArT61hXgPy4KiHQ7AdKz/XNWfP/u42PomPG4+jN8BCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=S9JwinoSfZH8A3BJLosg9sIPdpfJO3t4sR+34zawnXaM0BHXwYENbUuKzc9H0hTcy
         uXvZWoR/CP4xjvORITBU76aOHlgQC26p/dGPF85aCjjVCHSLaQer/mFcNOHgl/BRl/
         vwJjugdwBYu8SpozeG549W9WmL9ZGQTEr4bJYYLKvgzKv3ZunPhJOBAVaDW8TpbTui
         hr1EUpVR4XI4Z/8PduELt2gE+CwLqjyZXXqNwdhCEoIPetf2R5QVzAG6u0D2S+Oyc5
         j84jyV7FZV1hgI42eaEWV122I8sPOt2PCCAgmtBFCuEUCyedgtak1Xv/I/ctQFhf/x
         IlsuV6ieSKdSg==
Date:   Tue, 1 Aug 2023 16:06:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH 1/2] PCI: Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX
Message-ID: <20230801210618.GA50659@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731012550.728070-2-dlemoal@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Krzysztof]

On Mon, Jul 31, 2023 at 10:25:49AM +0900, Damien Le Moal wrote:
> From: Bjorn Helgaas <helgaas@kernel.org>
> 
> Rename PCI_IRQ_LEGACY to PCI_IRQ_INTX to be more explicit about the type
> of IRQ being referenced as well as to match the PCI specifications
> terms. The macro PCI_IRQ_LEGACY is redefined as an alias to PCI_IRQ_INTX
> to avoid the need for doing the renaming tree-wide. New drivers and new
> code should now prefer using PCI_IRQ_INTX instead of PCI_IRQ_LEGACY.
> 
> Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>

Looks good to me, but instead of the kernel.org address, please use:

  Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Also:

  Redefine PCI_IRQ_LEGACY as an alias to PCI_IRQ_INTX to avoid the
  need for doing the renaming tree-wide.

ISTR other pci/controller/ patches that may come on top of these?  If
so, probably makes sense for Krzysztof to apply these?

> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  include/linux/pci.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0ff7500772e6..7692d73719e0 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1048,11 +1048,13 @@ enum {
>  	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
>  };
>  
> -#define PCI_IRQ_LEGACY		(1 << 0) /* Allow legacy interrupts */
> +#define PCI_IRQ_INTX		(1 << 0) /* Allow INTx interrupts */
>  #define PCI_IRQ_MSI		(1 << 1) /* Allow MSI interrupts */
>  #define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
>  #define PCI_IRQ_AFFINITY	(1 << 3) /* Auto-assign affinity */
>  
> +#define PCI_IRQ_LEGACY		PCI_IRQ_INTX	/* prefer PCI_IRQ_INTX */
> +
>  /* These external functions are only available when PCI support is enabled */
>  #ifdef CONFIG_PCI
>  
> -- 
> 2.41.0
> 
