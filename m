Return-Path: <linux-pci+bounces-22948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B9AA4F792
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 08:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA81816E94C
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 07:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1311DB34C;
	Wed,  5 Mar 2025 07:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="aHc+QVBg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB2E1624F4;
	Wed,  5 Mar 2025 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741158229; cv=none; b=Ji2tEcAg0sQ8UFRUFzpev8Avv1+rWqmLEGob65yii6+KdCd5vHcLtpuUM3r3HKmzT3Kpo2X5tZUC1c7Ll0+fySiYzx1hj9o5Ul4fDOspYaHY/1exQYow7Yozh0leyx7KBvwFyl17L7+JNnpDX0kdeL6ncaqrAav8nS/3nzb166w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741158229; c=relaxed/simple;
	bh=q4xpQb+6+YSUnyImlArI6oWO4a/8VjfSPXyBOGk2qz8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QW+C5tOAGJLFRlqsYxz0et3B16pGEbqpKL3o9+lUg/s/r2M5qBnXWq6fUCALxRaMyV5fMzQSb+IWGpf/IO8x8WWoY3MhWWf6zFPd4rzTjJTEm8O7azUCX06W5lLaGrepBjLrDni5QGPQdgfxDL0/pCsrx++HSw2u30PLDGGYIQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=aHc+QVBg; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Z73Rt0TNyz9sSf;
	Wed,  5 Mar 2025 08:03:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1741158218; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DixBmUDBTMybbHMZPiht6bmfAxxM9bk/dkydsd/IiGA=;
	b=aHc+QVBgFG9RiL5iRcYoX7+bFjLQHHHrgiLW4uyiOsdjI8UDIEWgWOjAqHWDyJaU6EL+Bd
	1qbBTecUktEzysYmuVpRiiekiIt4VQw+vIbzNXqt0oX4+IIuWi80T5DBMb2KKJgtfkSSD3
	gXVGNEGc1SFGGwKxMT4L134idzhPBvx8Piq5Hm5eUhw0yelDnhGp2KrehwWjZojM+MbLqm
	Lu+0PieJ5zdm3LAYptcisTUbnGY7ToSYvm7qraw1+F4e4kYosEsapDgoswRwrJDQGC1i1L
	ONqyp8eQdMQURWDaWX2/UpPdvVdUOTfA109+KAfPUeaKqwwxQ46LcI44JtWuhg==
Message-ID: <d667d29337c49ebebb82d69b12bd48cad66ce595.camel@mailbox.org>
Subject: Re: [PATCH] PCI: Check BAR index for validity
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Philipp Stanner <phasta@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Bingbu Cao
	 <bingbu.cao@linux.intel.com>
Date: Wed, 05 Mar 2025 08:03:35 +0100
In-Reply-To: <20250304143112.104190-2-phasta@kernel.org>
References: <20250304143112.104190-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: e7f6647a2ca0481098c
X-MBO-RS-META: scmt9z1poqkpkg19ieq8njqowunirj85

On Tue, 2025-03-04 at 15:31 +0100, Philipp Stanner wrote:
> Many functions in PCI use accessor macros such as pci_resource_len(),
> which take a BAR index. That index, however, is never checked for
> validity, potentially resulting in undefined behavior by overflowing
> the
> array pci_dev.resource in the macro pci_resource_n().
>=20
> Since many users of those macros directly assign the accessed value
> to
> an unsigned integer, the macros cannot be changed easily anymore to
> return -EINVAL for invalid indexes. Consequently, the problem has to
> be
> mitigated in higher layers.
>=20
> Add pci_bar_index_valid(). Use it where appropriate.
>=20
> Reported-by: Bingbu Cao <bingbu.cao@linux.intel.com>
> Closes:
> https://lore.kernel.org/all/adb53b1f-29e1-3d14-0e61-351fd2d3ff0d@linux.in=
tel.com/
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
> =C2=A0drivers/pci/devres.c | 16 ++++++++++++++--
> =C2=A0drivers/pci/iomap.c=C2=A0 | 30 +++++++++++++++++++++---------
> =C2=A0drivers/pci/pci.c=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++++
> =C2=A0drivers/pci/pci.h=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++++++
> =C2=A04 files changed, 49 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> index 3431a7df3e0d..d2c09589c537 100644
> --- a/drivers/pci/devres.c
> +++ b/drivers/pci/devres.c
> @@ -577,7 +577,7 @@ static int
> pcim_add_mapping_to_legacy_table(struct pci_dev *pdev,
> =C2=A0{
> =C2=A0	void __iomem **legacy_iomap_table;
> =C2=A0
> -	if (bar >=3D PCI_STD_NUM_BARS)
> +	if (!pci_bar_index_is_valid(bar))
> =C2=A0		return -EINVAL;
> =C2=A0
> =C2=A0	legacy_iomap_table =3D (void __iomem
> **)pcim_iomap_table(pdev);
> @@ -622,7 +622,7 @@ static void
> pcim_remove_bar_from_legacy_table(struct pci_dev *pdev, int bar)
> =C2=A0{
> =C2=A0	void __iomem **legacy_iomap_table;
> =C2=A0
> -	if (bar >=3D PCI_STD_NUM_BARS)
> +	if (!pci_bar_index_is_valid(bar))
> =C2=A0		return;
> =C2=A0
> =C2=A0	legacy_iomap_table =3D (void __iomem
> **)pcim_iomap_table(pdev);
> @@ -655,6 +655,9 @@ void __iomem *pcim_iomap(struct pci_dev *pdev,
> int bar, unsigned long maxlen)
> =C2=A0	void __iomem *mapping;
> =C2=A0	struct pcim_addr_devres *res;
> =C2=A0
> +	if (!pci_bar_index_is_valid(bar))
> +		return NULL;
> +
> =C2=A0	res =3D pcim_addr_devres_alloc(pdev);
> =C2=A0	if (!res)
> =C2=A0		return NULL;
> @@ -722,6 +725,9 @@ void __iomem *pcim_iomap_region(struct pci_dev
> *pdev, int bar,
> =C2=A0	int ret;
> =C2=A0	struct pcim_addr_devres *res;
> =C2=A0
> +	if (!pci_bar_index_is_valid(bar))
> +		return IOMEM_ERR_PTR(-EINVAL);
> +
> =C2=A0	res =3D pcim_addr_devres_alloc(pdev);
> =C2=A0	if (!res)
> =C2=A0		return IOMEM_ERR_PTR(-ENOMEM);
> @@ -823,6 +829,9 @@ static int _pcim_request_region(struct pci_dev
> *pdev, int bar, const char *name,
> =C2=A0	int ret;
> =C2=A0	struct pcim_addr_devres *res;
> =C2=A0
> +	if (!pci_bar_index_is_valid(bar))
> +		return -EINVAL;
> +
> =C2=A0	res =3D pcim_addr_devres_alloc(pdev);
> =C2=A0	if (!res)
> =C2=A0		return -ENOMEM;
> @@ -991,6 +1000,9 @@ void __iomem *pcim_iomap_range(struct pci_dev
> *pdev, int bar,
> =C2=A0	void __iomem *mapping;
> =C2=A0	struct pcim_addr_devres *res;
> =C2=A0
> +	if (!pci_bar_index_is_valid(bar))
> +		return IOMEM_ERR_PTR(-EINVAL);
> +
> =C2=A0	res =3D pcim_addr_devres_alloc(pdev);
> =C2=A0	if (!res)
> =C2=A0		return IOMEM_ERR_PTR(-ENOMEM);
> diff --git a/drivers/pci/iomap.c b/drivers/pci/iomap.c
> index 9fb7cacc15cd..0cab82cbcc99 100644
> --- a/drivers/pci/iomap.c
> +++ b/drivers/pci/iomap.c
> @@ -9,6 +9,8 @@
> =C2=A0
> =C2=A0#include <linux/export.h>
> =C2=A0
> +#include "pci.h" /* for pci_bar_index_is_valid() */
> +
> =C2=A0/**
> =C2=A0 * pci_iomap_range - create a virtual mapping cookie for a PCI BAR
> =C2=A0 * @dev: PCI device that owns the BAR
> @@ -33,12 +35,18 @@ void __iomem *pci_iomap_range(struct pci_dev
> *dev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long offset,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long maxlen)
> =C2=A0{
> -	resource_size_t start =3D pci_resource_start(dev, bar);
> -	resource_size_t len =3D pci_resource_len(dev, bar);
> -	unsigned long flags =3D pci_resource_flags(dev, bar);
> +	resource_size_t start, len;
> +	unsigned long flags;
> =C2=A0
> +	if (!pci_bar_index_is_valid(bar))
> +		return NULL;
> =C2=A0	if (len <=3D offset || !start)
> =C2=A0		return NULL;

Argh, damn, this is a bug of course.
'start' is undefined at this point, as is 'len'.

> +
> +	start =3D pci_resource_start(dev, bar);
> +	len =3D pci_resource_len(dev, bar);
> +	flags =3D pci_resource_flags(dev, bar);
> +
> =C2=A0	len -=3D offset;
> =C2=A0	start +=3D offset;
> =C2=A0	if (maxlen && len > maxlen)
> @@ -77,17 +85,21 @@ void __iomem *pci_iomap_wc_range(struct pci_dev
> *dev,
> =C2=A0				 unsigned long offset,
> =C2=A0				 unsigned long maxlen)
> =C2=A0{
> -	resource_size_t start =3D pci_resource_start(dev, bar);
> -	resource_size_t len =3D pci_resource_len(dev, bar);
> -	unsigned long flags =3D pci_resource_flags(dev, bar);
> -
> +	resource_size_t start, len;
> +	unsigned long flags;
> =C2=A0
> -	if (flags & IORESOURCE_IO)
> +	if (!pci_bar_index_is_valid(bar))
> =C2=A0		return NULL;
> -
> =C2=A0	if (len <=3D offset || !start)
> =C2=A0		return NULL;

Same here.

Shall I send a v2 or do you want to rebase, Bjorn?

sry bout that.

P.

> =C2=A0
> +	start =3D pci_resource_start(dev, bar);
> +	len =3D pci_resource_len(dev, bar);
> +	flags =3D pci_resource_flags(dev, bar);
> +
> +	if (flags & IORESOURCE_IO)
> +		return NULL;
> +
> =C2=A0	len -=3D offset;
> =C2=A0	start +=3D offset;
> =C2=A0	if (maxlen && len > maxlen)
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 869d204a70a3..da82d734d09c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3921,6 +3921,9 @@ EXPORT_SYMBOL(pci_enable_atomic_ops_to_root);
> =C2=A0 */
> =C2=A0void pci_release_region(struct pci_dev *pdev, int bar)
> =C2=A0{
> +	if (!pci_bar_index_is_valid(bar))
> +		return;
> +
> =C2=A0	/*
> =C2=A0	 * This is done for backwards compatibility, because the old
> PCI devres
> =C2=A0	 * API had a mode in which the function became managed if it
> had been
> @@ -3965,6 +3968,9 @@ EXPORT_SYMBOL(pci_release_region);
> =C2=A0static int __pci_request_region(struct pci_dev *pdev, int bar,
> =C2=A0				const char *name, int exclusive)
> =C2=A0{
> +	if (!pci_bar_index_is_valid(bar))
> +		return -EINVAL;
> +
> =C2=A0	if (pci_is_managed(pdev)) {
> =C2=A0		if (exclusive =3D=3D IORESOURCE_EXCLUSIVE)
> =C2=A0			return pcim_request_region_exclusive(pdev,
> bar, name);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 01e51db8d285..ae8b2f5c118b 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -167,6 +167,14 @@ static inline void pci_wakeup_event(struct
> pci_dev *dev)
> =C2=A0	pm_wakeup_event(&dev->dev, 100);
> =C2=A0}
> =C2=A0
> +static inline bool pci_bar_index_is_valid(int bar)
> +{
> +	if (bar < 0 || bar >=3D PCI_NUM_RESOURCES)
> +		return false;
> +
> +	return true;
> +}
> +
> =C2=A0static inline bool pci_has_subordinate(struct pci_dev *pci_dev)
> =C2=A0{
> =C2=A0	return !!(pci_dev->subordinate);


