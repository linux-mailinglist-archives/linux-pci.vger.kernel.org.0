Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1200F2C3175
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 20:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgKXTxI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 14:53:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:34698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbgKXTxH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Nov 2020 14:53:07 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28F9C206D4;
        Tue, 24 Nov 2020 19:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606247587;
        bh=zE+2MmKDRI9sbrGlq7BkuT6Mkm+WrAFVxPD0rd7A6wU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=1yYpmRyq/UEAZAec4JEVeWrxcK3k4oEXBlVgKHW3hukB0gmcv5/OfqVAgY8jKeM9r
         Xpk7upd2rteVBwLSny6HTcY4FazU/l89Me9l6GEh5dPQUgQCfnkbrK9xPqwoglU2O7
         zj45MJgXq/FUUcQ15AYuEzjnBiAn6uR+wEbNK+P8=
Date:   Tue, 24 Nov 2020 13:53:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     bjorn@helgaas.com, linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH] PCI: Change return type of pci_find_capability()
Message-ID: <20201124195305.GA584380@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117191718.17885-1-puranjay12@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 18, 2020 at 12:47:18AM +0530, Puranjay Mohan wrote:
> PCI Capabilities are linked in a list that must appear in the first 256 bytes of config space.
> The Capabilities Pointer register at 0x34 contains the address of the first Capability in the list.
> Each Capability contains an 8 bit "Next Capability Pointer" that is set to 0x00 in the last item of the list.
> 
> Change the return type of pci_find_capability() from int to u8 to match the specification.

Nits: Be more specific in subject, e.g., "Return u8 from
pci_find_capability()".   Wrap commit log to fit in 78 columns.  Add
blank lines between paragraphs.  The 0x34 address is accurate but not
relevant to this patch.

> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  drivers/pci/pci.c   | 4 ++--
>  include/linux/pci.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6d4d5a2f923d..05ac8a493e6b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -477,9 +477,9 @@ static int __pci_bus_find_cap_start(struct pci_bus *bus,
>   *  %PCI_CAP_ID_PCIX         PCI-X
>   *  %PCI_CAP_ID_EXP          PCI Express
>   */
> -int pci_find_capability(struct pci_dev *dev, int cap)
> +u8 pci_find_capability(struct pci_dev *dev, int cap)
>  {
> -	int pos;
> +	u8 pos;
>  
>  	pos = __pci_bus_find_cap_start(dev->bus, dev->devfn, dev->hdr_type);

Also change the signatures of __pci_bus_find_cap_start(),
__pci_find_next_cap(), __pci_find_next_cap_ttl() to match.

>  	if (pos)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 22207a79762c..19a817702ea9 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1063,7 +1063,7 @@ void pci_sort_breadthfirst(void);
>  
>  /* Generic PCI functions exported to card drivers */
>  
> -int pci_find_capability(struct pci_dev *dev, int cap);
> +u8 pci_find_capability(struct pci_dev *dev, int cap);
>  int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
>  int pci_find_ext_capability(struct pci_dev *dev, int cap);
>  int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
> @@ -1719,7 +1719,7 @@ static inline int __pci_register_driver(struct pci_driver *drv,
>  static inline int pci_register_driver(struct pci_driver *drv)
>  { return 0; }
>  static inline void pci_unregister_driver(struct pci_driver *drv) { }
> -static inline int pci_find_capability(struct pci_dev *dev, int cap)
> +static inline u8 pci_find_capability(struct pci_dev *dev, int cap)
>  { return 0; }
>  static inline int pci_find_next_capability(struct pci_dev *dev, u8 post,
>  					   int cap)
> -- 
> 2.27.0
> 
