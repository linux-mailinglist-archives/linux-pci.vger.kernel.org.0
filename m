Return-Path: <linux-pci+bounces-14695-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655209A12F8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 21:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29801282B0A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 19:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1CF210C38;
	Wed, 16 Oct 2024 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWYIaCGq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655120605A;
	Wed, 16 Oct 2024 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729108522; cv=none; b=DeN6jUnNLySlW15CSRreqJ+4Ciiyttq2A8RimA2nJHwORUrX0oYJCpc5rwEn1WMnPX9fgPacSYFaL4iq2E4mNiDwGnuTbqZffl7tIgtG5T4TkjKlsLfUOemd9Xd5+3UjxjJFQIs5VPG29L0p//ApKTtbX0v1Y2fVK+WEM9ljREk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729108522; c=relaxed/simple;
	bh=ZiwDKcccpmSvuqWCu6YQOcI9Jl8IlIIZv33czqaIoj0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BElqzmXKiF2UQDeA1REKUJGQY+dRDwR1CyaS5fpl6y7NzCtP9GxzDxsXPCGm4pBR5TM0lqlbhj4MkPurS14g8QyWntvMHelEef++N4dY6zPlhHPYn0UDZ4xQioSda2KDHSZqGBHyrZ+/Da2+3ve+38oJbOkbotpyX3sRQl6Yyso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWYIaCGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4815C4CEC5;
	Wed, 16 Oct 2024 19:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729108522;
	bh=ZiwDKcccpmSvuqWCu6YQOcI9Jl8IlIIZv33czqaIoj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IWYIaCGqroH5yIR/0mJGOFtj4UZeicBHalefzbDbF/fjw+/nZwSLTl++SRgLuAL26
	 M/hNjRzEBHWoxQ5xP10w1WZHUpKOzkWRPU3Jt2zAgF4KQHYvn5uhGVLfPgbFrfUfsq
	 FQeOjFE+meLgRkV032V3fVSjvNCQatn7k+dtujbuaPYJlxskCXiIPDlROwTKKNgB5B
	 T1Nx8e1TkEqjXv7jJk5ynHskF/Siabc5kDerOGleVTfqE71m7mCqJDO5QKr3MbNK1o
	 GSHEPFz/muUt+7WxV9jAotsFuBbSjUqieDjK9Lf5S3g1NuoLwNvuLWT4sysYdogTjV
	 E1ZSyFO37ygOg==
Date: Wed, 16 Oct 2024 14:55:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Constify pci_register_io_range stub fwnode_handle
Message-ID: <20241016195520.GA647036@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016062410.2581152-1-arnd@kernel.org>

On Wed, Oct 16, 2024 at 06:24:04AM +0000, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The patch to change the argument types for pci_register_io_range()
> only caught one of the two implementations, but missed the empty
> version:
> 
> drivers/of/address.c: In function 'of_pci_range_to_resource':
> drivers/of/address.c:244:45: error: passing argument 1 of 'pci_register_io_range' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>   244 |                 err = pci_register_io_range(&np->fwnode, range->cpu_addr,
>       |                                             ^~~~~~~~~~~
> In file included from drivers/of/address.c:12:
> include/linux/pci.h:1559:49: note: expected 'struct fwnode_handle *' but argument is of type 'const struct fwnode_handle *'
>  1559 | int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
>       |                           ~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> 
> Change this the same way.
> 
> Fixes: 6ad99a07e6d2 ("PCI: Constify pci_register_io_range() fwnode_handle")

I assume Rob took the original and will take care of this as well:

  https://lore.kernel.org/all/20241010220747.GA579765@bhelgaas/

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> If possible, please fold this fixup into the original patch
> ---
>  include/linux/pci.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 11421ae5c558..733ff6570e2d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2019,7 +2019,7 @@ static inline int pci_request_regions(struct pci_dev *dev, const char *res_name)
>  { return -EIO; }
>  static inline void pci_release_regions(struct pci_dev *dev) { }
>  
> -static inline int pci_register_io_range(struct fwnode_handle *fwnode,
> +static inline int pci_register_io_range(const struct fwnode_handle *fwnode,
>  					phys_addr_t addr, resource_size_t size)
>  { return -EINVAL; }
>  
> -- 
> 2.39.5
> 

