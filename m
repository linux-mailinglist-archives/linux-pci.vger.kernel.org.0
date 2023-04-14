Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052D66E2A5D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Apr 2023 20:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDNS7x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Apr 2023 14:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjDNS7w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Apr 2023 14:59:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08E993C5;
        Fri, 14 Apr 2023 11:59:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F02264A05;
        Fri, 14 Apr 2023 18:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6487FC433D2;
        Fri, 14 Apr 2023 18:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681498789;
        bh=i8s8tXUQPVTYzjFAhrtqW6nEeFJPABbd1JKI8bS1w78=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i55DYyTRdBm06GEdn0W7HWxpb5JKvPzYi9r0DMdTBBshsUpQDwbAkQCoKMm4EvRJ+
         4tceagmPoYSPBCg+Tza9cMqZdOYkE2fLnW6O+ozJ+7+sXr1WDB/+ZL09bBfU7DRKI7
         fuzLNup9mGR3sJWDIiZHXpwq10SpCIOstvyDJ/z1guI/U26rK6PHbdeTjQZNfhDj1A
         FMpBZY74kojb9hgDoTsRjP/i5OEM922U+ZfExpBL09uFB2dnuJU1VfeD5eKwuQluCb
         fO7rBuUF0XrwjWMYtsLvQWCulKyDA3DGy+yEAS3I+w2v1kTK7eZCz+Vsr+42MGROcK
         F/XBKIYR/+2uA==
Date:   Fri, 14 Apr 2023 13:59:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     jingoohan1@gmail.com, mani@kernel.org,
        gustavo.pimentel@synopsys.com, fancer.lancer@gmail.com,
        lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, kishon@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v12 02/19] PCI: Add INtx Mechanism Messages macros
Message-ID: <20230414185947.GA212493@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414061622.2930995-3-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/INtx/INTx/ in subject

On Fri, Apr 14, 2023 at 03:16:05PM +0900, Yoshihiro Shimoda wrote:
> Add "Message Routing" and "INTx Mechanism Messages" macros to send
> a message by a PCIe driver.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  include/linux/pci.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0b57e37d8e77..ada1047035a8 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1050,6 +1050,24 @@ enum {
>  #define PCI_IRQ_MSIX		(1 << 2) /* Allow MSI-X interrupts */
>  #define PCI_IRQ_AFFINITY	(1 << 3) /* Auto-assign affinity */
>  
> +/* Message Routing */
> +#define PCI_MSG_ROUTING_RC	0
> +#define PCI_MSG_ROUTING_ADDR	1
> +#define PCI_MSG_ROUTING_ID	2
> +#define PCI_MSG_ROUTING_BC	3
> +#define PCI_MSG_ROUTING_LOCAL	4
> +#define PCI_MSG_ROUTING_GATHER	5
> +
> +/* INTx Mechanism Messages */
> +#define PCI_CODE_ASSERT_INTA	0x20
> +#define PCI_CODE_ASSERT_INTB	0x21
> +#define PCI_CODE_ASSERT_INTC	0x22
> +#define PCI_CODE_ASSERT_INTD	0x23
> +#define PCI_CODE_DEASSERT_INTA	0x24
> +#define PCI_CODE_DEASSERT_INTB	0x25
> +#define PCI_CODE_DEASSERT_INTC	0x26
> +#define PCI_CODE_DEASSERT_INTD	0x27

These look like things that should not be needed outside drivers/pci.
If that's the case, they should go in drivers/pci/pci.h, not
include/linux/pci.h.

>  /* These external functions are only available when PCI support is enabled */
>  #ifdef CONFIG_PCI
>  
> -- 
> 2.25.1
> 
