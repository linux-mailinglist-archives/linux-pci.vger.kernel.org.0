Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F17393870
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 23:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbhE0V4l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 17:56:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhE0V4k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 17:56:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C90A4613D1;
        Thu, 27 May 2021 21:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622152507;
        bh=AjT1h4HUZ3FffkTqDsNqYaeb9+sCP5TkLx6RmrToMzU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZDAZ82/okm3DiaQ+YryriiB2Im0Ay0aAW8FK8HsmAXmWcd9LEuALHV7Ig2xQwgx6X
         OoLvpgJPViYg0Y5vG+zY/4v5KUUexWCaFK9PD38K5AMu+HfyQfbKB82UcF7BbmuVfc
         S38yuplQC9V2k0GZ7BR49ysPawnvyIWzMMrMrj7i/SWaPmF36GllDIrsTOWo1z4Uv5
         EDQmEw0PdhNc6PNGTHYjlTDNft6DQ7TYnz+Dogeubh9/FFeQC5pn0Syvn7OUbywXi7
         gDfkkGYCaST8C8b8pCqdFMfxCDQwci/GWnFBZA5D5L3UAaZR4AENZMjESgkrk7nGou
         wcjvua9peLMng==
Date:   Thu, 27 May 2021 16:55:05 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/4] PCI: Add empty stub for pci_register_io_range()
Message-ID: <20210527215505.GA1433874@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527194547.1287934-2-robh@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 27, 2021 at 02:45:44PM -0500, Rob Herring wrote:
> Add an empty stub for pci_register_io_range() when !CONFIG_PCI. It's needed
> to convert of_pci_range_to_resource() to use IS_ENABLED(CONFIG_PCI).
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume you'll merge these through your tree.

> ---
>  include/linux/pci.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c20211e59a57..29da7598f8d0 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1772,6 +1772,10 @@ static inline int pci_request_regions(struct pci_dev *dev, const char *res_name)
>  { return -EIO; }
>  static inline void pci_release_regions(struct pci_dev *dev) { }
>  
> +static inline int pci_register_io_range(struct fwnode_handle *fwnode,
> +					phys_addr_t addr, resource_size_t size)
> +{ return -EINVAL; }
> +
>  static inline unsigned long pci_address_to_pio(phys_addr_t addr) { return -1; }
>  
>  static inline struct pci_bus *pci_find_next_bus(const struct pci_bus *from)
> -- 
> 2.27.0
> 
