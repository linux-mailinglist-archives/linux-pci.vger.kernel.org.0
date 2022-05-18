Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBC952C342
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 21:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241899AbiERTXb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 15:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241903AbiERTXa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 15:23:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64F621271
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 12:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 356DD618FA
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 19:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F348EC36AE2;
        Wed, 18 May 2022 19:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652901804;
        bh=GfJu7dQBwFQci22KG5K0sfCnkvzqKSWVHCrllpzLtJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XwlJQmmmTLIyPwqqEPkBVzx3dBt6acZ9bSmjQ+3hzgCDipUst4ptbj8wZhmWBiBci
         b0fQ02uFAqGXLQrSlZEquJ12EifOA/dsrX1CFmFStBVMh5JMa5OPH7mD6G18pGr0zv
         xrNl9y6Va9d76IW2S+oMFC/I7/7owpJQ2pcvYgcNzYxHBoF3s09sizwDtgXIg83leD
         oKVYBhO2B8nsOMAfxTlek8T+di6KabnoAePy0sl7c8esakTuo/SjIGv0a5NHvi5vzX
         SoMVfSt7ZIv34zb0y0oLThXXiMuAnVmZBfI4n7VvKa/e7m73p3cnGI7sf5u+ZJqcM5
         kCQPzGZERhgxA==
Date:   Wed, 18 May 2022 14:23:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 04/18] PCI: Add PCI_EXP_SLTCAP_*_SHIFT macros
Message-ID: <20220518192322.GA1155024@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220220193346.23789-5-kabel@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 20, 2022 at 08:33:32PM +0100, Marek Behún wrote:
> From: Pali Rohár <pali@kernel.org>
> 
> These macros allows to easily compose and extract Slot Power Limit and
> Physical Slot Number values from Slot Capability Register.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

We talked about using FIELD_PREP() / FIELD_GET(), which I think would
remove the need for the *_SHIFT macros.  But we can always do that
later.

> ---
>  include/uapi/linux/pci_regs.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index bee1a9ed6e66..d825e17e448c 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -591,10 +591,13 @@
>  #define  PCI_EXP_SLTCAP_HPS	0x00000020 /* Hot-Plug Surprise */
>  #define  PCI_EXP_SLTCAP_HPC	0x00000040 /* Hot-Plug Capable */
>  #define  PCI_EXP_SLTCAP_SPLV	0x00007f80 /* Slot Power Limit Value */
> +#define  PCI_EXP_SLTCAP_SPLV_SHIFT	7  /* Slot Power Limit Value shift */
>  #define  PCI_EXP_SLTCAP_SPLS	0x00018000 /* Slot Power Limit Scale */
> +#define  PCI_EXP_SLTCAP_SPLS_SHIFT	15 /* Slot Power Limit Scale shift */
>  #define  PCI_EXP_SLTCAP_EIP	0x00020000 /* Electromechanical Interlock Present */
>  #define  PCI_EXP_SLTCAP_NCCS	0x00040000 /* No Command Completed Support */
>  #define  PCI_EXP_SLTCAP_PSN	0xfff80000 /* Physical Slot Number */
> +#define  PCI_EXP_SLTCAP_PSN_SHIFT	19 /* Physical Slot Number shift */
>  #define PCI_EXP_SLTCTL		0x18	/* Slot Control */
>  #define  PCI_EXP_SLTCTL_ABPE	0x0001	/* Attention Button Pressed Enable */
>  #define  PCI_EXP_SLTCTL_PFDE	0x0002	/* Power Fault Detected Enable */
> -- 
> 2.34.1
> 
