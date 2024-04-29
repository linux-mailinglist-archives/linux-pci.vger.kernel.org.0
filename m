Return-Path: <linux-pci+bounces-6796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C518B5E0F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 17:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A1B1C2154F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 15:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C73482881;
	Mon, 29 Apr 2024 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQq2uY5V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653508287F;
	Mon, 29 Apr 2024 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405743; cv=none; b=fshgcOx5ElNrhgG0oYcWuwJU71F7aTKqXTDkuvnkNg/+sGS6Lt+Kq+gyhRgFNdFwhW0O3aV0mBe07nwrwDpN76PVz0LJVYMkDNHZ4AilcPaiakHzjfVrcYtSwEtOIXKxs0nfpttFTmwuw8O+uYu1DQwNCY6ueZqLYYRsPzp3Pds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405743; c=relaxed/simple;
	bh=8E8eNvQXs6uHqJ8k+Aav3jvAptQ6JiP41PMJ+zDi4VU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lbB+5OsgMzXhlGVE9SrT6ozg8Uj5XjV8RxaPdqHqAKUIUCIERv9Dz8C84+iUgqKDh7bgfYpyd1wjM1XLZHj2q9Qb+jE6YEoW0DGeMSg3QCCnf1vMT/v4wtBLGCzICeZv3ouyjTUVq0xUGoz5Ijf+7IfxmxF052JOcspXqPy0G08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQq2uY5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BB9C113CD;
	Mon, 29 Apr 2024 15:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714405743;
	bh=8E8eNvQXs6uHqJ8k+Aav3jvAptQ6JiP41PMJ+zDi4VU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AQq2uY5VqamOTBnaqj7R4UBuor7VdWaMJYTYEO4TPNsLYTy4dj0pf0zJGe/fEYP7s
	 3H/d7cqjY2P1D9bfaBM2XFrR76iDukxfknhHPNjUrfIRjMdBf+YIZlaEXFcsqvJmzX
	 9On2yapbCUVTBNGupLREu1gqLCSr73EjI6QfwlwePwT7wfRQseNu5c1puZ/5JH4Yfx
	 nnXznfesmMPq0XBTAVsEX19z4KPaLh+RuJuSRua5R6MhKPmfzupmq37upVA51Kyakv
	 U1bdJaK6bh0zrZ/bTYLH4O4rhcdWZG5Fst7lMrHMi4WKdkGU+st8vU7QZmPlCw85u/
	 oRwRXmuziPQaw==
Date: Mon, 29 Apr 2024 10:49:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: Cleanup accessor macros formatting
Message-ID: <20240429154901.GA682729@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429094707.2529-2-ilpo.jarvinen@linux.intel.com>

On Mon, Apr 29, 2024 at 12:47:07PM +0300, Ilpo Järvinen wrote:
> Cleanup formatting of PCI accessor macros:
> 
> - Put return statements on own line
> - Add a few empty lines for better readability
> - Align macro continuation backslashes
> - Correct function call argument indentation level
> - Reorder variable declarations to reverse xmas tree
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Both applied to pci/misc for v6.10, thanks!

I tweaked the PCI_USER_READ_CONFIG variable declaration from the
existing reverse xmas tree to order of use because xmas tree orders
look nice but carry no useful information.  In the cases you updated,
reverse xmas tree and order of use happen to be the same.

Also dropped "ret" initialization in PCI_USER_READ_CONFIG and
PCI_USER_WRITE_CONFIG since it's always set before being used anyway.

> ---
>  drivers/pci/access.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 6449056b57dd..4962a841fa35 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -36,10 +36,13 @@ DEFINE_RAW_SPINLOCK(pci_lock);
>  int noinline pci_bus_read_config_##size \
>  	(struct pci_bus *bus, unsigned int devfn, int pos, type *value)	\
>  {									\
> -	int res;							\
>  	unsigned long flags;						\
>  	u32 data = 0;							\
> -	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
> +	int res;							\
> +									\
> +	if (PCI_##size##_BAD)						\
> +		return PCIBIOS_BAD_REGISTER_NUMBER;			\
> +									\
>  	pci_lock_config(flags);						\
>  	res = bus->ops->read(bus, devfn, pos, len, &data);		\
>  	if (res)							\
> @@ -47,6 +50,7 @@ int noinline pci_bus_read_config_##size \
>  	else								\
>  		*value = (type)data;					\
>  	pci_unlock_config(flags);					\
> +									\
>  	return res;							\
>  }
>  
> @@ -54,12 +58,16 @@ int noinline pci_bus_read_config_##size \
>  int noinline pci_bus_write_config_##size \
>  	(struct pci_bus *bus, unsigned int devfn, int pos, type value)	\
>  {									\
> -	int res;							\
>  	unsigned long flags;						\
> -	if (PCI_##size##_BAD) return PCIBIOS_BAD_REGISTER_NUMBER;	\
> +	int res;							\
> +									\
> +	if (PCI_##size##_BAD)						\
> +		return PCIBIOS_BAD_REGISTER_NUMBER;			\
> +									\
>  	pci_lock_config(flags);						\
>  	res = bus->ops->write(bus, devfn, pos, len, value);		\
>  	pci_unlock_config(flags);					\
> +									\
>  	return res;							\
>  }
>  
> @@ -216,24 +224,27 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
>  }
>  
>  /* Returns 0 on success, negative values indicate error. */
> -#define PCI_USER_READ_CONFIG(size, type)					\
> +#define PCI_USER_READ_CONFIG(size, type)				\
>  int pci_user_read_config_##size						\
>  	(struct pci_dev *dev, int pos, type *val)			\
>  {									\
>  	int ret = PCIBIOS_SUCCESSFUL;					\
>  	u32 data = -1;							\
> +									\
>  	if (PCI_##size##_BAD)						\
>  		return -EINVAL;						\
> -	raw_spin_lock_irq(&pci_lock);				\
> +									\
> +	raw_spin_lock_irq(&pci_lock);					\
>  	if (unlikely(dev->block_cfg_access))				\
>  		pci_wait_cfg(dev);					\
>  	ret = dev->bus->ops->read(dev->bus, dev->devfn,			\
> -					pos, sizeof(type), &data);	\
> -	raw_spin_unlock_irq(&pci_lock);				\
> +				  pos, sizeof(type), &data);		\
> +	raw_spin_unlock_irq(&pci_lock);					\
>  	if (ret)							\
>  		PCI_SET_ERROR_RESPONSE(val);				\
>  	else								\
>  		*val = (type)data;					\
> +									\
>  	return pcibios_err_to_errno(ret);				\
>  }									\
>  EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
> @@ -244,14 +255,17 @@ int pci_user_write_config_##size					\
>  	(struct pci_dev *dev, int pos, type val)			\
>  {									\
>  	int ret = PCIBIOS_SUCCESSFUL;					\
> +									\
>  	if (PCI_##size##_BAD)						\
>  		return -EINVAL;						\
> -	raw_spin_lock_irq(&pci_lock);				\
> +									\
> +	raw_spin_lock_irq(&pci_lock);					\
>  	if (unlikely(dev->block_cfg_access))				\
>  		pci_wait_cfg(dev);					\
>  	ret = dev->bus->ops->write(dev->bus, dev->devfn,		\
> -					pos, sizeof(type), val);	\
> -	raw_spin_unlock_irq(&pci_lock);				\
> +				   pos, sizeof(type), val);		\
> +	raw_spin_unlock_irq(&pci_lock);					\
> +									\
>  	return pcibios_err_to_errno(ret);				\
>  }									\
>  EXPORT_SYMBOL_GPL(pci_user_write_config_##size);
> -- 
> 2.39.2
> 

