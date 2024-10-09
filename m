Return-Path: <linux-pci+bounces-14089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEB199698F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 14:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582A11F2331E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782E318FDC2;
	Wed,  9 Oct 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X69qDuRV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885318EFE0
	for <linux-pci@vger.kernel.org>; Wed,  9 Oct 2024 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475726; cv=none; b=uBb+EEF5zFq0DO6ULBEdEXZtiTwD+OaXKH2T2dlvyPl2+4lgJcXLlNafP1KBEhsrXAuhBAlXl/N+twhiOHkxYNV1EbcyL00i40hXfSmKjV3UwMedet4/wW0Lsb4Ix0fuQ8AKJ/yOSarBjT9nkKIKT3ly7nZrqQZB1Lk/zf7b9YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475726; c=relaxed/simple;
	bh=hyxvPDjwvzfkO1r5w5GjhwqA2TisiReOH7BQPS6IIuQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=D+cpQZ049AgKNwcc4nhOiA5tvvN7jmENQW2JdH5qE68IsrfP0S+D/O+qOSqKfiSnV47jjl0nKYinCATe6s5jFU81Ey3BG7SuErpZwyX346GnDa6tzCuUVtq2f0vrL5Eye6IHMTCE2HayHUgUUlOK0XLVVDBswU82D+Uc/+XvHWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X69qDuRV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728475725; x=1760011725;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hyxvPDjwvzfkO1r5w5GjhwqA2TisiReOH7BQPS6IIuQ=;
  b=X69qDuRV9SQCHLMrZUEVVe0nJ221cN5bCUP2AyCO4JAIYv/yVKB0Fkof
   xYpRSbW0O7tzumGislOhLW9RQB+GLCtT7FMDF7641dub2uazJ4TZCxQwG
   pZNZMzap+DkFnVSgU6SOKNOls9qL/MnAnWhZ+iRy5f3zJWI35Ca6s42BB
   yeIEW2LN/CO5r6zG/xZlDgTGuU0hp1CmYU9u5HubkhuUEegDM/izM1pYk
   qR3leZDaCp0QTwrrJzmRuKeuriYdNFUABSIG83qG/16ceIohRqQH8np33
   vCPe50I4gkfJRnNxMX2+wBtuO+p7tJwLR+WaBSVT6GxB9R6IrYlIZros+
   Q==;
X-CSE-ConnectionGUID: 1hIgjsvuT3KpyDfMwh4otQ==
X-CSE-MsgGUID: jMO+Z7p6SjaJHX6SgB75zA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="45290213"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="45290213"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 05:08:44 -0700
X-CSE-ConnectionGUID: MqYY7DpzRfmJSUL+Wus3Jg==
X-CSE-MsgGUID: HG6LNKgwTjGKqh5Frj3I5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="99556231"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.41])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 05:08:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 9 Oct 2024 15:08:38 +0300 (EEST)
To: Keith Busch <kbusch@meta.com>
cc: linux-pci@vger.kernel.org, bhelgaas@google.com, 
    Keith Busch <kbusch@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCHv2 4/5] pci: walk bus recursively
In-Reply-To: <20240827192826.710031-5-kbusch@meta.com>
Message-ID: <9750491b-f198-a195-eb39-1365bad39b5f@linux.intel.com>
References: <20240827192826.710031-1-kbusch@meta.com> <20240827192826.710031-5-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1899273694-1728475718=:930"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1899273694-1728475718=:930
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 27 Aug 2024, Keith Busch wrote:

> From: Keith Busch <kbusch@kernel.org>
>=20
> The original implementation purposefully chose a non-recursive walk,
> presumably as a precaution on stack use. We do recursive bus walking in
> other places though. For example:
>=20
>   pci_bus_resettable
>   pci_stop_bus_device
>   pci_remove_bus_device
>   pci_bus_allocate_dev_resources
>=20
> So, recursive pci bus walking is well tested and safe, and the
> implementation is easier to follow. The motivation for changing it now
> is to make it easier to introduce finer grain locking in the future.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/bus.c | 36 +++++++++++-------------------------
>  1 file changed, 11 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 7c07a141e8772..8491e9c7f0586 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -389,37 +389,23 @@ void pci_bus_add_devices(const struct pci_bus *bus)
>  }
>  EXPORT_SYMBOL(pci_bus_add_devices);
> =20
> -static void __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev=
 *, void *),
> -=09=09=09   void *userdata)
> +static int __pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev =
*, void *),

I guess the reason why this parameter was called "top" is now gone so you=
=20
could just name it "bus"?

Other than that, the change looks okay,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> +=09=09=09  void *userdata)
>  {
>  =09struct pci_dev *dev;
> -=09struct pci_bus *bus;
> -=09struct list_head *next;
> -=09int retval;
> +=09int ret =3D 0;
> =20
> -=09bus =3D top;
> -=09next =3D top->devices.next;
> -=09for (;;) {
> -=09=09if (next =3D=3D &bus->devices) {
> -=09=09=09/* end of this bus, go up or finish */
> -=09=09=09if (bus =3D=3D top)
> +=09list_for_each_entry(dev, &top->devices, bus_list) {
> +=09=09ret =3D cb(dev, userdata);
> +=09=09if (ret)
> +=09=09=09break;
> +=09=09if (dev->subordinate) {
> +=09=09=09ret =3D __pci_walk_bus(dev->subordinate, cb, userdata);
> +=09=09=09if (ret)
>  =09=09=09=09break;
> -=09=09=09next =3D bus->self->bus_list.next;
> -=09=09=09bus =3D bus->self->bus;
> -=09=09=09continue;
>  =09=09}
> -=09=09dev =3D list_entry(next, struct pci_dev, bus_list);
> -=09=09if (dev->subordinate) {
> -=09=09=09/* this is a pci-pci bridge, do its devices next */
> -=09=09=09next =3D dev->subordinate->devices.next;
> -=09=09=09bus =3D dev->subordinate;
> -=09=09} else
> -=09=09=09next =3D dev->bus_list.next;
> -
> -=09=09retval =3D cb(dev, userdata);
> -=09=09if (retval)
> -=09=09=09break;
>  =09}
> +=09return ret;
>  }
> =20
>  /**
>=20

--8323328-1899273694-1728475718=:930--

