Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF8F752837
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 18:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235071AbjGMQYY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 12:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjGMQYX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 12:24:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEDBE65;
        Thu, 13 Jul 2023 09:24:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82F0C61A5E;
        Thu, 13 Jul 2023 16:24:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11C0C433C8;
        Thu, 13 Jul 2023 16:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689265461;
        bh=AZtkSlN6HOFWqWpaw/7rUZ2iYgSQ7gyCFHv5rfl8mdg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=esZu5r4uC08yeLmBddbgsRaBbAqZTAPh5xHgLceETYHVhFqeOZzClIDGta83yxedB
         BhdMpCh/LPjpfo+7+8FfmKArb6rVILE0zfIB15Nt8bJua/s4X9RqSHjyCB7ch73iB9
         JxcuWN5D1TzIxw4ymvz6bNG71C6bdempvNTIYT7PGZbXbeGiSFhXjkJgdiIg+GW817
         Mp1FrZocZ3kH41zEq8XOZK1VulDS6wSseTw8O7Xe+bs5c1koagoKBe/a++lZyA+Wii
         Tb0K3zhZCzByYbPoe0Ov/puWM363mj2Iwh+Jkrs3nCYbvmt6/3dG8qWpKBLSwPXter
         2yOuoxbb11fxg==
Date:   Thu, 13 Jul 2023 11:24:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Reorder some fields in 'struct pci_dev'
Message-ID: <20230713162419.GA321515@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407b17c3e56764ef2c558898d4ff4c6c04b2d757.1687105455.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 18, 2023 at 06:24:54PM +0200, Christophe JAILLET wrote:
> Group some bitfield variables to reduce hole.
> On x86_64, this shrinks the size of 'struct pci_dev' by 16 bytes when
> compiled with 'allmodconfig'. This goes from 3576 to 3560.
> 
> The move related to CONFIG_PCIEASPM depends on the config. But it gives
> the opportunity to merge to bitfields.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Both patches applies to pci/misc for v6.6, thanks!

> ---
>  include/linux/pci.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c69a2cc1f412..106754757279 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -366,8 +366,8 @@ struct pci_dev {
>  	pci_power_t	current_state;	/* Current operating state. In ACPI,
>  					   this is D0-D3, D0 being fully
>  					   functional, and D3 being off. */
> -	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
>  	u8		pm_cap;		/* PM capability offset */
> +	unsigned int	imm_ready:1;	/* Supports Immediate Readiness */
>  	unsigned int	pme_support:5;	/* Bitmask of states from which PME#
>  					   can be generated */
>  	unsigned int	pme_poll:1;	/* Poll device's PME status bit */
> @@ -392,9 +392,9 @@ struct pci_dev {
>  
>  #ifdef CONFIG_PCIEASPM
>  	struct pcie_link_state	*link_state;	/* ASPM link state */
> +	u16		l1ss;		/* L1SS Capability pointer */
>  	unsigned int	ltr_path:1;	/* Latency Tolerance Reporting
>  					   supported from root to here */
> -	u16		l1ss;		/* L1SS Capability pointer */
>  #endif
>  	unsigned int	pasid_no_tlp:1;		/* PASID works without TLP Prefix */
>  	unsigned int	eetlp_prefix_path:1;	/* End-to-End TLP Prefix */
> -- 
> 2.34.1
> 
