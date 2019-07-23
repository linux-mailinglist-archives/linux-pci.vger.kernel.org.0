Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD397231A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 01:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfGWXe2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jul 2019 19:34:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbfGWXe2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Jul 2019 19:34:28 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10B6720840;
        Tue, 23 Jul 2019 23:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563924867;
        bh=6nro+HW40HHUSY8sV0sgwe6UpT0lTXr6jwd8m+kpwaw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eUQEXCtVBv4Jo9f8LpNglLj+NDQg/ivaxg20oPxdbsu79qLq/ecVEM0ibTT3wdLkf
         qUqWQ7LSnMyxebujwcEmdX/X0IvO1OLMq3KZEyt2G3vgej4kj1Cv+MwJwWA5v7rj8I
         GEGHrO2YLBTjsugKV8jBtMGdoGZn2Fzh4HpPS9Cw=
Date:   Tue, 23 Jul 2019 18:34:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH v3] PCI: Remove functions not
 called in include/linux/pci.h
Message-ID: <20190723233424.GC47047@google.com>
References: <20190715181312.31403-1-skunberg.kelsey@gmail.com>
 <20190715203416.37547-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715203416.37547-1-skunberg.kelsey@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 15, 2019 at 02:34:16PM -0600, Kelsey Skunberg wrote:
> Remove the following uncalled functions from include/linux/pci.h:
> 
>         pci_block_cfg_access()
>         pci_block_cfg_access_in_atomic()
>         pci_unblock_cfg_access()
> 
> Functions were added in commit fb51ccbf217c ("PCI: Rework config space
> blocking services"), though no callers were added. Code continues to be
> unused and should be removed.
> 
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>

Applied with Lukas' reviewed-by (thank you!) to pci/hide for v5.4,
thanks!

> ---
> 
> Changes since v1:
>   - Fixed Signed-off-by line to show full name
> 
> Changes since v2:
>   - Change commit message to reference prior commit properly with the
>     following format:
> 	commit <12-character sha prefix> ("<commit message>")
> 
>  include/linux/pci.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cf380544c700..3c9ba6133bea 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1656,11 +1656,6 @@ static inline void pci_release_regions(struct pci_dev *dev) { }
>  
>  static inline unsigned long pci_address_to_pio(phys_addr_t addr) { return -1; }
>  
> -static inline void pci_block_cfg_access(struct pci_dev *dev) { }
> -static inline int pci_block_cfg_access_in_atomic(struct pci_dev *dev)
> -{ return 0; }
> -static inline void pci_unblock_cfg_access(struct pci_dev *dev) { }
> -
>  static inline struct pci_bus *pci_find_next_bus(const struct pci_bus *from)
>  { return NULL; }
>  static inline struct pci_dev *pci_get_slot(struct pci_bus *bus,
> -- 
> 2.20.1
> 
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
