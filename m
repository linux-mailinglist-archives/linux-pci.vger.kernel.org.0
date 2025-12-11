Return-Path: <linux-pci+bounces-42970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BDDCB6A78
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 18:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2397030011BC
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 17:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0355E288CA3;
	Thu, 11 Dec 2025 17:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U9HAiojO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A3C22CBC6
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765473568; cv=none; b=b0aMwBdcw6gi/ljqHZzhRHai0C7GfEnG/z0f1NiV87QnG9PkZsA72JFCy+rXw4JuaDQcXgAGRC6dW/AeaKq03pYmbZVdl9E3ZeXw/Ai7wKvt3mR+JxR53G1XuXc9GHTBYpNcx7QqTW6ZEPos+AdKIVvbYURlgfopz3WSImIP6aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765473568; c=relaxed/simple;
	bh=Co2c/ZaQJYuzgaUGiY4SShwrlkebtN9khYnUGAaoohs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sleLCma0EtRITGuHwwRwBJt23JdaEV+tmnwytH8JmJEX725DzPoeQjod2bk0xuHWvFqDdDqPnbsZoUxCEreUoty+ley/5wGMrWHveuTIY7ZjYYzBc8LOHp6kcfGxTsTeojGqlozbp2xI3UjbRCwf5j/w3LQTrHBatMU1s5nlQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U9HAiojO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765473567; x=1797009567;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Co2c/ZaQJYuzgaUGiY4SShwrlkebtN9khYnUGAaoohs=;
  b=U9HAiojOKTdlZlIv89/57+AfvA3Ri1+FbsbvoYxKtfiJ5itzi8xdrEhG
   EKdxc1TqrBzCq3CiS8RcbVqYqCl941x/CJe5a9D1Ew2UMsCsvCl5f02ht
   iPz1pvnPLsdui0kDFKHjwoHKlP+v8RqCzdnYmALoVHpgqFa6+fBA0y67G
   bM/6WIA9hVajUkfv2eVPMFWGxipSB0lVcBDqrwGBE/AOiy5F6zDwfYDc8
   fm9kNgNXZ5AZGkVfjozYqMMH+hbZoF9vgx7/zGZ3D+Q45g9crrMbZAfUW
   N2rpYZUfbxSW32ERwc2DaTNY5HpWCH3ZLQPRhIqULoS1MCt+ZMfXE8Y1Q
   Q==;
X-CSE-ConnectionGUID: 18aCOiQNRtSJMCVQ0zk6GQ==
X-CSE-MsgGUID: ldtIM8OQQoW2f9/ncfhBNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="71327897"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="71327897"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 09:19:27 -0800
X-CSE-ConnectionGUID: VaNpLQ8XR3e6lrSHu30LOg==
X-CSE-MsgGUID: YPUJH/kyS/+8/IqewMoVeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="197672116"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.219])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 09:19:23 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Dec 2025 19:19:18 +0200 (EET)
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    Feng Tang <feng.tang@linux.alibaba.com>, 
    Jonathan Cameron <Jonthan.Cameron@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/6] PCI/portdrv: Fix potential resource leak
In-Reply-To: <e1c68c3b3f1af8427e98ca5e2c79f8bf0ebe2ce4.1764688034.git.u.kleine-koenig@baylibre.com>
Message-ID: <80d02471-f1b8-fad2-07e1-9c54bd99af9c@linux.intel.com>
References: <cover.1764688034.git.u.kleine-koenig@baylibre.com> <e1c68c3b3f1af8427e98ca5e2c79f8bf0ebe2ce4.1764688034.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1016569929-1765473558=:8649"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1016569929-1765473558=:8649
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 2 Dec 2025, Uwe Kleine-K=C3=B6nig wrote:

> pcie_port_probe_service() unconditionally calls get_device() (unless it
> fails). So drop that reference also unconditionally as it's fine for a
> pcie driver to not have a remove callback.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> This isn't very urgent as I think there is no pcie driver without a
> remove callback
> ---
>  drivers/pci/pcie/portdrv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index d1b68c18444f..f13039378908 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -557,10 +557,10 @@ static int pcie_port_remove_service(struct device *=
dev)
> =20
>  =09pciedev =3D to_pcie_device(dev);
>  =09driver =3D to_service_driver(dev->driver);
> -=09if (driver && driver->remove) {
> +=09if (driver && driver->remove)
>  =09=09driver->remove(pciedev);
> -=09=09put_device(dev);
> -=09}
> +
> +=09put_device(dev);
>  =09return 0;
>  }
> =20
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1016569929-1765473558=:8649--

