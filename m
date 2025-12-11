Return-Path: <linux-pci+bounces-42971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED1ECB6A8D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 18:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40AFC3003BD5
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 17:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE8F248166;
	Thu, 11 Dec 2025 17:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dc2nvJ2B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ECD1CAA78
	for <linux-pci@vger.kernel.org>; Thu, 11 Dec 2025 17:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765473660; cv=none; b=cPmXlZqQK43Vj642VS2SGbKTAXOdhk6Cdp6VbcAqi1NPKLr3M99tVoy20cXpZEGEx8jFyRVbOXIapiQN/BxOjqTOLy5LcRe3OWrJqryTsPIeyEecZvqnsP043GXf4o6qWM/JA41g4avee254BsArUbWn1e1igCFR7fvfJ92iFGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765473660; c=relaxed/simple;
	bh=kYXMa1k3rNoFJCKls9pAjzltdpBwxUZle9fk/UD29H4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kKwXbu5MTfCxJuLCgKeMCzKIwJYjmM0gg1OTwrfCTd+wACBYzckxs00DoZqa98wul0eASwQ4ja6hjUBKZUgcQOjFA5lc4FWAk+lmPxO6VHnX4B6i03Ec0ZdhzcYj7oJa/4HQBsnYaG7TsA95J8vj44ovVQBkWhR/db+m9Wff+44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dc2nvJ2B; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765473658; x=1797009658;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kYXMa1k3rNoFJCKls9pAjzltdpBwxUZle9fk/UD29H4=;
  b=Dc2nvJ2BjPXc/KQujx6lLEuHyn+ttykVLGpTwwmfJrcwtMX4hJ6eoS2R
   JQ9pJGBa29qFdr+yqThm2O2bJBidg3jz50PS5rsJQYLQGiwQ/SbGBqTC2
   T91A6p12lzz9BQ39I1iJDrl3TAGmaVgwl0pZDJQonaPWaYaQ73St/Ucwc
   Qz4ZANOqwuqRjYQtBIiUTVQWCoHcRmS3JvhNh2+xtF2466sdX1PxD3g17
   ikPfS55cpnZ/wUm0oXKGQigSsC35RJZV0mc+n/gad0K7iF/EOngOJ1EZV
   ThEE4r5J14s49TzPjS2kk3lIv2uQMx4o3iG+3CxHI1nO7x5ljsYs8kykm
   g==;
X-CSE-ConnectionGUID: qTqzkB+bQ3iq9urkoNui0g==
X-CSE-MsgGUID: +XKesqr6SL+JrZ74fEnx1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11639"; a="78167616"
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="78167616"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 09:20:58 -0800
X-CSE-ConnectionGUID: GFcy99V1Sl68YvE2J+bcmw==
X-CSE-MsgGUID: hZNo0icMSfmQxr/jtXLBXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,141,1763452800"; 
   d="scan'208";a="197324492"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.219])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 09:20:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Dec 2025 19:20:51 +0200 (EET)
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    Feng Tang <feng.tang@linux.alibaba.com>, 
    Jonathan Cameron <Jonthan.Cameron@huawei.com>, linux-pci@vger.kernel.org, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH 2/6] PCI/portdrv: Drop empty shutdown callback
In-Reply-To: <283fef06ac51efbb7df25f347d6f3a2967f96429.1764688034.git.u.kleine-koenig@baylibre.com>
Message-ID: <41a353ff-3c02-9b92-61e4-650d9d48da04@linux.intel.com>
References: <cover.1764688034.git.u.kleine-koenig@baylibre.com> <283fef06ac51efbb7df25f347d6f3a2967f96429.1764688034.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-293809186-1765473651=:8649"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-293809186-1765473651=:8649
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 2 Dec 2025, Uwe Kleine-K=C3=B6nig wrote:

> .shutdown() is an optional callback and the core only calls it if the
> pointer in struct device_driver is non-NULL. So make nothing in a bit
> shorter time and remove the empty function.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> ---
>  drivers/pci/pcie/portdrv.c | 12 ------------
>  1 file changed, 12 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index f13039378908..63492c3d3565 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -564,17 +564,6 @@ static int pcie_port_remove_service(struct device *d=
ev)
>  =09return 0;
>  }
> =20
> -/**
> - * pcie_port_shutdown_service - shut down given PCI Express port service
> - * @dev: PCI Express port service device to handle
> - *
> - * If PCI Express port service driver is registered with
> - * pcie_port_service_register(), this function will be called by the dri=
ver core
> - * when device_shutdown() is called for the port service device associat=
ed
> - * with the driver.
> - */
> -static void pcie_port_shutdown_service(struct device *dev) {}
> -
>  /**
>   * pcie_port_service_register - register PCI Express port service driver
>   * @new: PCI Express port service driver to register
> @@ -588,7 +577,6 @@ int pcie_port_service_register(struct pcie_port_servi=
ce_driver *new)
>  =09new->driver.bus =3D &pcie_port_bus_type;
>  =09new->driver.probe =3D pcie_port_probe_service;
>  =09new->driver.remove =3D pcie_port_remove_service;
> -=09new->driver.shutdown =3D pcie_port_shutdown_service;
> =20
>  =09return driver_register(&new->driver);
>  }
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-293809186-1765473651=:8649--

