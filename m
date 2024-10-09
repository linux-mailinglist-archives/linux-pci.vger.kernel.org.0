Return-Path: <linux-pci+bounces-14087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56810996810
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 13:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85EA28BDC3
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 11:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26B6190051;
	Wed,  9 Oct 2024 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GqyRtRgq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059A118E76E
	for <linux-pci@vger.kernel.org>; Wed,  9 Oct 2024 11:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728472186; cv=none; b=VhJ8sQlZhWFj9RRMhNTQrm3zPsogmTk5mgpi941bwNuWMZVq+Pd/oeNtUCZ0rKzldMzG0ghUvg+0HcuzcZWV5L5IH6yTETBZLKnZAPg71LtnKQG8Z+xbZOVB8Pzj590W78RX2+E62sVh77qZuDAnjR/vcOT2pAURbpSxUr9NUaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728472186; c=relaxed/simple;
	bh=qZpZMRQQ+xlixICANxcpy3oSa/Y9MHgxHQ1oAId7kSk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lH2crGTv6bwSZVRBIcsw5q48jrnhrw69/ZYNOnPLReol679l+pmM9rEwrVFtrNDHG8jBqIJmMjYMsw6O7NRScazgKxBOdQRFrBVNLEemto/K/KbApuYI932b62h9dZevQbvfNsdRMlhwiUYSb5rJSVWWbGRY5k0pa1TRvbj67qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GqyRtRgq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728472186; x=1760008186;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qZpZMRQQ+xlixICANxcpy3oSa/Y9MHgxHQ1oAId7kSk=;
  b=GqyRtRgq83lsXKcace1jZzMvxRzXLPnKDlWUIOoIlVGKEJ7C9uR7D/Ur
   haJYp4LibkZBxw3OAtsscTTXsa9q3rkUc0Sy+kMzWgXrqZAC3z9aQ0v0k
   SaIAiF49xA/fbIylfoU9jAIMYKHo1FHWb3avPLuLR78YeTZ1A5TszOzuF
   WNhQ+dFNHvDbQwo3AuijDl810Eve7fjfneaaNJZc4bqrVJRCTfTOVYXQl
   CY/eegO1nQf72s3W9ESRCsFYXFJ+89RSKIDVuK3X1h6/HkYfmh+VmOE+1
   S/Hi6vX8LmvqvVaGMu3l6kCOCfpiwn7T90szh6VCtRyqPeMLqH4pwaaG/
   Q==;
X-CSE-ConnectionGUID: o0RTVMyyQSOt4UqXLBJPdA==
X-CSE-MsgGUID: 8i4WTTEeQGepXX9UyzSlkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="45231561"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="45231561"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 04:09:24 -0700
X-CSE-ConnectionGUID: +PFUL0AvRP6GU/4e6VSxXg==
X-CSE-MsgGUID: sQTEdOROQf203Fkn8filrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="75814819"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.41])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 04:09:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 9 Oct 2024 14:09:18 +0300 (EEST)
To: Keith Busch <kbusch@meta.com>
cc: linux-pci@vger.kernel.org, bhelgaas@google.com, 
    Keith Busch <kbusch@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCHv2 3/5] pci: move the walk bus lock to where its needed
In-Reply-To: <20240827192826.710031-4-kbusch@meta.com>
Message-ID: <d9d552ed-d5d3-1d3e-2020-11de8c2b1c14@linux.intel.com>
References: <20240827192826.710031-1-kbusch@meta.com> <20240827192826.710031-4-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-438438734-1728472158=:930"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-438438734-1728472158=:930
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Aug 2024, Keith Busch wrote:

> From: Keith Busch <kbusch@kernel.org>
>=20
> Simplify the common function by removing an unnecessary parameter that
> can be more easily handled in the only caller that wants it.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.


> ---
>  drivers/pci/bus.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index e41dfece0d969..7c07a141e8772 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -390,7 +390,7 @@ void pci_bus_add_devices(const struct pci_bus *bus)
>  EXPORT_SYMBOL(pci_bus_add_devices);
> =20
>  static void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev=
 *, void *),
> -=09=09=09   void *userdata, bool locked)
> +=09=09=09   void *userdata)
>  {
>  =09struct pci_dev *dev;
>  =09struct pci_bus *bus;
> @@ -398,8 +398,6 @@ static void __pci_walk_bus(struct pci_bus *top, int (=
*cb)(struct pci_dev *, void
>  =09int retval;
> =20
>  =09bus =3D top;
> -=09if (!locked)
> -=09=09down_read(&pci_bus_sem);
>  =09next =3D top->devices.next;
>  =09for (;;) {
>  =09=09if (next =3D=3D &bus->devices) {
> @@ -422,8 +420,6 @@ static void __pci_walk_bus(struct pci_bus *top, int (=
*cb)(struct pci_dev *, void
>  =09=09if (retval)
>  =09=09=09break;
>  =09}
> -=09if (!locked)
> -=09=09up_read(&pci_bus_sem);
>  }
> =20
>  /**
> @@ -441,7 +437,9 @@ static void __pci_walk_bus(struct pci_bus *top, int (=
*cb)(struct pci_dev *, void
>   */
>  void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void =
*), void *userdata)
>  {
> -=09__pci_walk_bus(top, cb, userdata, false);
> +=09down_read(&pci_bus_sem);
> +=09__pci_walk_bus(top, cb, userdata);
> +=09up_read(&pci_bus_sem);
>  }
>  EXPORT_SYMBOL_GPL(pci_walk_bus);
> =20
> @@ -449,7 +447,7 @@ void pci_walk_bus_locked(struct pci_bus *top, int (*c=
b)(struct pci_dev *, void *
>  {
>  =09lockdep_assert_held(&pci_bus_sem);
> =20
> -=09__pci_walk_bus(top, cb, userdata, true);
> +=09__pci_walk_bus(top, cb, userdata);
>  }
>  EXPORT_SYMBOL_GPL(pci_walk_bus_locked);
> =20
>=20
--8323328-438438734-1728472158=:930--

