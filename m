Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFA86FF685
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 17:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbjEKPzP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 11:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbjEKPzO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 11:55:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D54976BB;
        Thu, 11 May 2023 08:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A57164F73;
        Thu, 11 May 2023 15:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A512EC433D2;
        Thu, 11 May 2023 15:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683820508;
        bh=QRaJ2wFNH9rmkUNsYI7EcEVD2fVj4LcKgN5B3/qU0LM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=u5qEG5bDdT5fTqcwhgWFwqAxaItJBe1PkoHlu/D+Agi7TF6WCVZ9UZQ/SQBge9+NX
         jN84pzJ56EIPh3mwk6QueC8qrdANgORcY9dXiWbY8SP+zdYohj+4QMKOw7aTLmNvH1
         XdxHOmiN0eib6pj78tmb/fqZaGD/ZJ3nClRffqEcaT+44+u9nLW3tT1tQhFgCHfLW2
         W8/j/wSgP8zIX73jKvNaTnJClfF9Tm4EWe1xaMJKFdDLh/zSr2l3d4PHxMW1XVqn5X
         +1iIPitqfXG+KiaD+ZWKCUUYcJL4lQuD8cRUOuDXCFvREwU5aa7VlSk1XZEuGiwp+M
         qFLZIyNUEwlig==
Date:   Thu, 11 May 2023 10:55:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/17] PCI: Add concurrency safe clear_and_set variants
 for LNKCTL{,2}
Message-ID: <ZF0P2hedTFXPv8IK@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511131441.45704-2-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 11, 2023 at 04:14:25PM +0300, Ilpo Järvinen wrote:
> A few places write LNKCTL and LNKCTL2 registers without proper
> concurrency control and this could result in losing the changes
> one of the writers intended to make.
> 
> Add pcie_capability_clear_and_set_word_locked() and helpers to use it
> with LNKCTL and LNKCTL2. The concurrency control is provided using a
> spinlock in the struct pci_dev.
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks for raising this issue!  Definitely looks like something that
needs attention.

> ---
>  drivers/pci/access.c | 14 ++++++++++++++
>  drivers/pci/probe.c  |  1 +
>  include/linux/pci.h  | 17 +++++++++++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 3c230ca3de58..d92a3daadd0c 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -531,6 +531,20 @@ int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
>  }
>  EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
>  
> +int pcie_capability_clear_and_set_word_locked(struct pci_dev *dev, int pos,
> +					      u16 clear, u16 set)
> +{
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&dev->cap_lock, flags);
> +	ret = pcie_capability_clear_and_set_word(dev, pos, clear, set);
> +	spin_unlock_irqrestore(&dev->cap_lock, flags);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(pcie_capability_clear_and_set_word_locked);

I didn't see the prior discussion with Lukas, so maybe this was
answered there, but is there any reason not to add locking to
pcie_capability_clear_and_set_word() and friends directly?  

It would be nice to avoid having to decide whether to use the locked
or unlocked versions.  It would also be nice to preserve the use of
PCI_EXP_LNKCTL directly, for grep purposes.  And it would obviate the
need for some of these patches, e.g., the use of
pcie_capability_clear_word(), where it's not obvious at the call site
why a change is needed.

Bjorn

>  int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
>  {
>  	if (pci_dev_is_disconnected(dev)) {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0b2826c4a832..0c14a283f1c7 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2318,6 +2318,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
>  		.end = -1,
>  	};
>  
> +	spin_lock_init(&dev->cap_lock);
>  #ifdef CONFIG_PCI_MSI
>  	raw_spin_lock_init(&dev->msi_lock);
>  #endif
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60b8772b5bd4..82faea085d95 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -467,6 +467,7 @@ struct pci_dev {
>  	pci_dev_flags_t dev_flags;
>  	atomic_t	enable_cnt;	/* pci_enable_device has been called */
>  
> +	spinlock_t	cap_lock;		/* Protects RMW ops done with locked RMW capability accessors */
>  	u32		saved_config_space[16]; /* Config space saved at suspend time */
>  	struct hlist_head saved_cap_space;
>  	int		rom_attr_enabled;	/* Display of ROM attribute enabled? */
> @@ -1221,6 +1222,8 @@ int pcie_capability_clear_and_set_word(struct pci_dev *dev, int pos,
>  				       u16 clear, u16 set);
>  int pcie_capability_clear_and_set_dword(struct pci_dev *dev, int pos,
>  					u32 clear, u32 set);
> +int pcie_capability_clear_and_set_word_locked(struct pci_dev *dev, int pos,
> +					      u16 clear, u16 set);
>  
>  static inline int pcie_capability_set_word(struct pci_dev *dev, int pos,
>  					   u16 set)
> @@ -1246,6 +1249,20 @@ static inline int pcie_capability_clear_dword(struct pci_dev *dev, int pos,
>  	return pcie_capability_clear_and_set_dword(dev, pos, clear, 0);
>  }
>  
> +static inline int pcie_lnkctl_clear_and_set(struct pci_dev *dev, u16 clear,
> +					    u16 set)
> +{
> +	return pcie_capability_clear_and_set_word_locked(dev, PCI_EXP_LNKCTL,
> +							 clear, set);
> +}
> +
> +static inline int pcie_lnkctl2_clear_and_set(struct pci_dev *dev, u16 clear,
> +					    u16 set)
> +{
> +	return pcie_capability_clear_and_set_word_locked(dev, PCI_EXP_LNKCTL2,
> +							 clear, set);
> +}
> +
>  /* User-space driven config access */
>  int pci_user_read_config_byte(struct pci_dev *dev, int where, u8 *val);
>  int pci_user_read_config_word(struct pci_dev *dev, int where, u16 *val);
> -- 
> 2.30.2
> 
