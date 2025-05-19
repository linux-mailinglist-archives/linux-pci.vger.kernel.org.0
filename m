Return-Path: <linux-pci+bounces-27918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E7DABB63C
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 09:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3115C3B3580
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 07:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C0C265CC9;
	Mon, 19 May 2025 07:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Au2uNYvC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C309E1D7984;
	Mon, 19 May 2025 07:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747640053; cv=none; b=L3zY4gxsBwkiVI2S0Z4oBny1yuGbtiLF6iDogIb1eBdjWOwYosXpU70ZKMQWkdAkCx8IQiYOVIIWNv91dRnt3fY+bJqpADboMjWxg6GfiG0SXEbeShdq7J0dVoXT9i9uy1EifNhCqRJG/tSuSPwmj13niHGYH5u1LyFYRH9lWj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747640053; c=relaxed/simple;
	bh=/3jyY8EaPqYWCfl9T6e6GP8F7HGKgaH/UbDfbRPWE1A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F32wFhWS1p/bV8cYD/DnSTsaRjLVDGZIAmwUYkxJpWsPyBANEok9yMCa37F4BWU5PivN5euiLfMBX5r+asLwOFImtVo6zkhVtTxtHVpveZ4q/3SDj+Yuf0tCbK4HLPQQd+1taCx0ttEroOkQlhJ4tv/fRb3jWUvN4VToLk3t9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Au2uNYvC; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4b18ZL5Mgxz9tWZ;
	Mon, 19 May 2025 09:34:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1747640042; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJfj7xVO3OOXnCMoWaraCXpMPd3XjqE+bOFqual4HVc=;
	b=Au2uNYvCB8myXOv5wrotOcmLbQT4P8TbBs1pNYcBeRdwDkK3mR5cpd1DShmf5JYJM3FomA
	QTMLH8SCXGWcAzpbx4zKavkZaXjQJ+fuF5fe0fT+TcM5Lomq8FBO9LZtJ0tcHA3gKYHhMP
	qnVlNu5oPnQyCKlAuhRm9LC7A6KQrOxIp2z22/YWFnW+BrbLBEMqSHJqxgL2e/ufyqyDSs
	/yUWcA1ks0sBdngq8INTC4TADk/+YHX+Eqvci5/5W5N1Zk8u0saUE4YRbo+I9GJ6WV9B72
	JPw7CAHnZHca5V69oqD3nRryO3JfspRUThlQOIdDGcMDG1YkaX14RgPfhsrXAQ==
Message-ID: <2041935387a5bdb61dcd4bdffb7084655c9af98d.camel@mailbox.org>
Subject: Re: [PATCH v2 1/6] PCI: Remove hybrid devres nature from request
 functions
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
  Philipp Stanner <phasta@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Bjorn Helgaas <bhelgaas@google.com>, Mark Brown <broonie@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Yang Yingliang <yangyingliang@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Date: Mon, 19 May 2025 09:33:55 +0200
In-Reply-To: <99dba1da-4fc6-4e35-a6fc-40233144f7dd@linux.intel.com>
References: <20250516174141.42527-1-phasta@kernel.org>
	 <20250516174141.42527-2-phasta@kernel.org>
	 <99dba1da-4fc6-4e35-a6fc-40233144f7dd@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: f8a973dd6fce6a1971b
X-MBO-RS-META: utuoshy8h6rmg3c4f63b4fajqf7pe1et

On Fri, 2025-05-16 at 15:58 -0700, Sathyanarayanan Kuppuswamy wrote:
> Hi,
>=20
> On 5/16/25 10:41 AM, Philipp Stanner wrote:
> > All functions based on __pci_request_region() and its release
> > counter
> > part support "hybrid mode", where the functions become managed if
> > the
> > PCI device was enabled with pcim_enable_device().
> >=20
> > Removing this undesirable feature requires to remove all users who
> > activated their device with that function and use one of the
> > affected
> > request functions.
> >=20
> > These users were:
> > 	ASoC
> > 	alsa
> > 	cardreader
> > 	cirrus
> > 	i2c
> > 	mmc
> > 	mtd
> > 	mtd
> > 	mxser
> > 	net
> > 	spi
> > 	vdpa
> > 	vmwgfx
> >=20
> > all of which have been ported to always-managed pcim_ functions by
> > now.
> >=20
> > The hybrid nature can, thus, be removed from the aforementioned PCI
> > functions.
> >=20
> > Remove all function guards and documentation in pci.c related to
> > the
> > hybrid redirection. Adjust the visibility of pcim_release_region().
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
>=20
> Reviewed-by: Kuppuswamy Sathyanarayanan=20
> <sathyanarayanan.kuppuswamy@linux.intel.com>
>=20
> > =C2=A0 drivers/pci/devres.c | 39 ++++++++++++--------------------------=
-
> > =C2=A0 drivers/pci/pci.c=C2=A0=C2=A0=C2=A0 | 42 -----------------------=
----------------
> > ---
> > =C2=A0 drivers/pci/pci.h=C2=A0=C2=A0=C2=A0 |=C2=A0 1 -
> > =C2=A0 3 files changed, 12 insertions(+), 70 deletions(-)
> >=20
> > diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
> > index 73047316889e..5480d537f400 100644
> > --- a/drivers/pci/devres.c
> > +++ b/drivers/pci/devres.c
> > @@ -6,30 +6,13 @@
> > =C2=A0 /*
> > =C2=A0=C2=A0 * On the state of PCI's devres implementation:
> > =C2=A0=C2=A0 *
> > - * The older devres API for PCI has two significant problems:
> > + * The older PCI devres API has one significant problem:
> > =C2=A0=C2=A0 *
> > - * 1. It is very strongly tied to the statically allocated mapping
> > table in
> > - *=C2=A0=C2=A0=C2=A0 struct pcim_iomap_devres below. This is mostly so=
lved in the
> > sense of the
> > - *=C2=A0=C2=A0=C2=A0 pcim_ functions in this file providing things lik=
e ranged
> > mapping by
> > - *=C2=A0=C2=A0=C2=A0 bypassing this table, whereas the functions that =
were
> > present in the old
> > - *=C2=A0=C2=A0=C2=A0 API still enter the mapping addresses into the ta=
ble for
> > users of the old
> > - *=C2=A0=C2=A0=C2=A0 API.
> > - *
> > - * 2. The region-request-functions in pci.c do become managed IF
> > the device has
> > - *=C2=A0=C2=A0=C2=A0 been enabled with pcim_enable_device() instead of
> > pci_enable_device().
> > - *=C2=A0=C2=A0=C2=A0 This resulted in the API becoming inconsistent: S=
ome
> > functions have an
> > - *=C2=A0=C2=A0=C2=A0 obviously managed counter-part (e.g., pci_iomap()=
 <->
> > pcim_iomap()),
> > - *=C2=A0=C2=A0=C2=A0 whereas some don't and are never managed, while o=
thers don't
> > and are
> > - *=C2=A0=C2=A0=C2=A0 _sometimes_ managed (e.g. pci_request_region()).
> > - *
> > - *=C2=A0=C2=A0=C2=A0 Consequently, in the new API, region requests per=
formed by
> > the pcim_
> > - *=C2=A0=C2=A0=C2=A0 functions are automatically cleaned up through th=
e devres
> > callback
> > - *=C2=A0=C2=A0=C2=A0 pcim_addr_resource_release().
> > - *
> > - *=C2=A0=C2=A0=C2=A0 Users of pcim_enable_device() + pci_*region*() ar=
e
> > redirected in
> > - *=C2=A0=C2=A0=C2=A0 pci.c to the managed functions here in this file.=
 This isn't
> > exactly
> > - *=C2=A0=C2=A0=C2=A0 perfect, but the only alternative way would be to=
 port ALL
> > drivers
> > - *=C2=A0=C2=A0=C2=A0 using said combination to pcim_ functions.
> > + * It is very strongly tied to the statically allocated mapping
> > table in struct
> > + * pcim_iomap_devres below. This is mostly solved in the sense of
> > the pcim_
> > + * functions in this file providing things like ranged mapping by
> > bypassing
> > + * this table, whereas the functions that were present in the old
> > API still
> > + * enter the mapping addresses into the table for users of the old
> > API.
> > =C2=A0=C2=A0 *
> > =C2=A0=C2=A0 * TODO:
> > =C2=A0=C2=A0 * Remove the legacy table entirely once all calls to
> > pcim_iomap_table() in
> > @@ -89,10 +72,12 @@ static inline void
> > pcim_addr_devres_clear(struct pcim_addr_devres *res)
> > =C2=A0=20
> > =C2=A0 /*
> > =C2=A0=C2=A0 * The following functions, __pcim_*_region*, exist as
> > counterparts to the
> > - * versions from pci.c - which, unfortunately, can be in "hybrid
> > mode", i.e.,
> > - * sometimes managed, sometimes not.
> > + * versions from pci.c - which, unfortunately, were in the past in
> > "hybrid
> > + * mode", i.e., sometimes managed, sometimes not.
>=20
> Why not remove "hybrid mode"=C2=A0 reference like other places?
>=20
> > =C2=A0=C2=A0 *
> > - * To separate the APIs cleanly, we define our own, simplified
> > versions here.
> > + * To separate the APIs cleanly, we defined our own, simplified
> > versions here.
> > + *
> > + * TODO: unify those functions with the counterparts in pci.c
> > =C2=A0=C2=A0 */
> > =C2=A0=20
> > =C2=A0 /**
> > @@ -893,7 +878,7 @@ int pcim_request_region_exclusive(struct
> > pci_dev *pdev, int bar, const char *nam
> > =C2=A0=C2=A0 * Release a region manually that was previously requested =
by
> > =C2=A0=C2=A0 * pcim_request_region().
> > =C2=A0=C2=A0 */
> > -void pcim_release_region(struct pci_dev *pdev, int bar)
> > +static void pcim_release_region(struct pci_dev *pdev, int bar)
> > =C2=A0 {
> > =C2=A0=C2=A0	struct pcim_addr_devres res_searched;
> > =C2=A0=20
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index e77d5b53c0ce..4acc23823637 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -3937,16 +3937,6 @@ void pci_release_region(struct pci_dev
> > *pdev, int bar)
> > =C2=A0=C2=A0	if (!pci_bar_index_is_valid(bar))
> > =C2=A0=C2=A0		return;
> > =C2=A0=20
> > -	/*
> > -	 * This is done for backwards compatibility, because the
> > old PCI devres
> > -	 * API had a mode in which the function became managed if
> > it had been
> > -	 * enabled with pcim_enable_device() instead of
> > pci_enable_device().
> > -	 */
> > -	if (pci_is_managed(pdev)) {
> > -		pcim_release_region(pdev, bar);
> > -		return;
> > -	}
> > -
> > =C2=A0=C2=A0	if (pci_resource_len(pdev, bar) =3D=3D 0)
> > =C2=A0=C2=A0		return;
> > =C2=A0=C2=A0	if (pci_resource_flags(pdev, bar) & IORESOURCE_IO)
> > @@ -3984,13 +3974,6 @@ static int __pci_request_region(struct
> > pci_dev *pdev, int bar,
> > =C2=A0=C2=A0	if (!pci_bar_index_is_valid(bar))
> > =C2=A0=C2=A0		return -EINVAL;
> > =C2=A0=20
> > -	if (pci_is_managed(pdev)) {
> > -		if (exclusive =3D=3D IORESOURCE_EXCLUSIVE)
> > -			return pcim_request_region_exclusive(pdev,
> > bar, name);
> > -
> > -		return pcim_request_region(pdev, bar, name);
> > -	}
> > -
> > =C2=A0=C2=A0	if (pci_resource_len(pdev, bar) =3D=3D 0)
> > =C2=A0=C2=A0		return 0;
> > =C2=A0=20
> > @@ -4027,11 +4010,6 @@ static int __pci_request_region(struct
> > pci_dev *pdev, int bar,
> > =C2=A0=C2=A0 *
> > =C2=A0=C2=A0 * Returns 0 on success, or %EBUSY on error.=C2=A0 A warnin=
g
> > =C2=A0=C2=A0 * message is also printed on failure.
> > - *
> > - * NOTE:
> > - * This is a "hybrid" function: It's normally unmanaged, but
> > becomes managed
> > - * when pcim_enable_device() has been called in advance. This
> > hybrid feature is
> > - * DEPRECATED! If you want managed cleanup, use the pcim_*
> > functions instead.
> > =C2=A0=C2=A0 */
> > =C2=A0 int pci_request_region(struct pci_dev *pdev, int bar, const char
> > *name)
> > =C2=A0 {
> > @@ -4084,11 +4062,6 @@ static int
> > __pci_request_selected_regions(struct pci_dev *pdev, int bars,
> > =C2=A0=C2=A0 * @name: Name of the driver requesting the resources
> > =C2=A0=C2=A0 *
> > =C2=A0=C2=A0 * Returns: 0 on success, negative error code on failure.
> > - *
> > - * NOTE:
> > - * This is a "hybrid" function: It's normally unmanaged, but
> > becomes managed
> > - * when pcim_enable_device() has been called in advance. This
> > hybrid feature is
> > - * DEPRECATED! If you want managed cleanup, use the pcim_*
> > functions instead.
> > =C2=A0=C2=A0 */
> > =C2=A0 int pci_request_selected_regions(struct pci_dev *pdev, int bars,
> > =C2=A0=C2=A0				 const char *name)
> > @@ -4104,11 +4077,6 @@ EXPORT_SYMBOL(pci_request_selected_regions);
> > =C2=A0=C2=A0 * @name: name of the driver requesting the resources
> > =C2=A0=C2=A0 *
> > =C2=A0=C2=A0 * Returns: 0 on success, negative error code on failure.
> > - *
> > - * NOTE:
> > - * This is a "hybrid" function: It's normally unmanaged, but
> > becomes managed
> > - * when pcim_enable_device() has been called in advance. This
> > hybrid feature is
> > - * DEPRECATED! If you want managed cleanup, use the pcim_*
> > functions instead.
> > =C2=A0=C2=A0 */
> > =C2=A0 int pci_request_selected_regions_exclusive(struct pci_dev *pdev,
> > int bars,
> > =C2=A0=C2=A0					=C2=A0=C2=A0 const char *name)
> > @@ -4144,11 +4112,6 @@ EXPORT_SYMBOL(pci_release_regions);
> > =C2=A0=C2=A0 *
> > =C2=A0=C2=A0 * Returns 0 on success, or %EBUSY on error.=C2=A0 A warnin=
g
> > =C2=A0=C2=A0 * message is also printed on failure.
> > - *
> > - * NOTE:
> > - * This is a "hybrid" function: It's normally unmanaged, but
> > becomes managed
> > - * when pcim_enable_device() has been called in advance. This
> > hybrid feature is
> > - * DEPRECATED! If you want managed cleanup, use the pcim_*
> > functions instead.
> > =C2=A0=C2=A0 */
> > =C2=A0 int pci_request_regions(struct pci_dev *pdev, const char *name)
> > =C2=A0 {
> > @@ -4173,11 +4136,6 @@ EXPORT_SYMBOL(pci_request_regions);
> > =C2=A0=C2=A0 *
> > =C2=A0=C2=A0 * Returns 0 on success, or %EBUSY on error.=C2=A0 A warnin=
g message
> > is also
> > =C2=A0=C2=A0 * printed on failure.
> > - *
> > - * NOTE:
> > - * This is a "hybrid" function: It's normally unmanaged, but
> > becomes managed
> > - * when pcim_enable_device() has been called in advance. This
> > hybrid feature is
> > - * DEPRECATED! If you want managed cleanup, use the pcim_*
> > functions instead.
> > =C2=A0=C2=A0 */
> > =C2=A0 int pci_request_regions_exclusive(struct pci_dev *pdev, const
> > char *name)
> > =C2=A0 {
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index b81e99cd4b62..8c3e5fb2443a 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -1062,7 +1062,6 @@ static inline pci_power_t
> > mid_pci_get_power_state(struct pci_dev *pdev)
> > =C2=A0 int pcim_intx(struct pci_dev *dev, int enable);
> > =C2=A0 int pcim_request_region_exclusive(struct pci_dev *pdev, int bar,
> > =C2=A0=C2=A0				=C2=A0 const char *name);
> > -void pcim_release_region(struct pci_dev *pdev, int bar);
> > =C2=A0=20
>=20
> Since you removed the only use of pcim_request_region_exclusive(),
> why=20
> not remove the definition in the same patch?

Each maintainer has his own philosophy there =E2=80=93 in previous patch
series's the feedback from Bjorn was to provide series's which rather
contain more small atomic patches than larger summarizing ones.

That said, the PCI maintainers of course can squash the patches as they
see fit. But this way around it's easier for me, because providing
something small that will be squashed is more simple than splitting
something large into smaller chunks after being told so.


Regards
P.

> > =C2=A0 /*
> > =C2=A0=C2=A0 * Config Address for PCI Configuration Mechanism #1
>=20


