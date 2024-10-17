Return-Path: <linux-pci+bounces-14772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0939A21F6
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 14:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363241F28D8D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 12:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A451D517D;
	Thu, 17 Oct 2024 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IwaY3xoW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC41C695;
	Thu, 17 Oct 2024 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729167378; cv=none; b=cMiYwk8buTBIAAzEbIOanSsvXxmkhX+HJurRDXLytzXueJlSyKJxP+AXigRNk7k80tjdLjyYukY3pi/0gYQq336MfbxD6aj1FUwSjh4woxl83nl3ldRsX5fegD333h2hadIeBxSd4QQwhzzUzYiQqoaT2MdiO6JuGkwFzAIDGo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729167378; c=relaxed/simple;
	bh=r699opwE5cI3RI97j611dEI351nYk3EOgzUdlm6XyKk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XvOXrlXNecj3odTOMaJeaYF+6hkJjYLFmvkDUx0XA9fqBqrt/OikRZlJ468INBqvoENDiTQcr7SyWxgnwynRxns54w/sBLl9ezS/vkgjI8S0PEoNXBzSzmBju7cP8OX0NlN3xFhAiNM9PpHWxcB09B8H1WQLf8PlptWffL7SIiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IwaY3xoW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729167376; x=1760703376;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=r699opwE5cI3RI97j611dEI351nYk3EOgzUdlm6XyKk=;
  b=IwaY3xoW4nvtSuzpo/eXbqgCVTMNl+YPaovHlrp1XOROvfBxPc7tBOMx
   WzBAnF41TzuOk7NYACfjkpfgLCel1C1Eqkrj+5g8t3Rw0JFB4R6uLFXhR
   elRZjgvwKmA+wq4vvNPvee/gEID0rEK/lVJYEueCe26iro9xt8O9OtWzA
   aN46HAz/TY3jSZ73Nyyqg8Ixs0jOe+NK7WCaqEAXZ0Oa0Uart5TT4oi7C
   WP94fmJSYRLKdA7ECTN9T/2DJcaAF+Ld9dVvkpvPGzo/eaFUgf2it++bH
   VnOyH790V+uBx31pFb7pvSVThfwowUknjwWu/eB3e0pTNe7gEVBfngXk1
   g==;
X-CSE-ConnectionGUID: uO+olYbvRAGhIubSzu4Ghg==
X-CSE-MsgGUID: VncSiW1wRZWX829SE5Af0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28602231"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28602231"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 05:16:15 -0700
X-CSE-ConnectionGUID: 4nku0nykSze3HPAq7Vd0dA==
X-CSE-MsgGUID: Fh0len5uThKXjLSVZHMQ6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="109279521"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.91])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 05:16:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 17 Oct 2024 15:16:05 +0300 (EEST)
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, Lukas Wunner <lukas@wunner.de>, 
    Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
    Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
    Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
    LKML <linux-kernel@vger.kernel.org>, Amit Kucheria <amitk@kernel.org>, 
    Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v8 7/8] thermal: Add PCIe cooling driver
In-Reply-To: <20241017120456.00006023@Huawei.com>
Message-ID: <70507175-dc7d-d334-4a2a-988239f380a6@linux.intel.com>
References: <20241009095223.7093-1-ilpo.jarvinen@linux.intel.com> <20241009095223.7093-8-ilpo.jarvinen@linux.intel.com> <20241017120456.00006023@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1607255192-1729166156=:929"
Content-ID: <a0c6e8f3-199d-7cb3-0dcc-2482a8a155dc@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1607255192-1729166156=:929
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <eb80756d-b968-ed5f-aa9b-f7e5a2ae5b42@linux.intel.com>

On Thu, 17 Oct 2024, Jonathan Cameron wrote:

> On Wed,  9 Oct 2024 12:52:22 +0300
> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > Add a thermal cooling driver to provide path to access PCIe bandwidth
> > controller using the usual thermal interfaces.
> >=20
> > A cooling device is instantiated for controllable PCIe Ports from the
> > bwctrl service driver.
> >=20
> > If registering the cooling device fails, allow bwctrl's probe to
> > succeed regardless. As cdev in that case contains IS_ERR() pseudo
> > "pointer", clean that up inside the probe function so the remove side
> > doesn't need to suddenly make an odd looking IS_ERR() check.
> >=20
> > The thermal side state 0 means no throttling, i.e., maximum supported
> > PCIe Link Speed.
> >=20
> > Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Acked-by: Rafael J. Wysocki <rafael@kernel.org> # From the cooling devi=
ce interface perspective
>=20
> Trivial thing noticed on a reread.
>=20
>=20
> > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > index 61e7ae524b1f..d3f9686e26e7 100644
> > --- a/drivers/thermal/Kconfig
> > +++ b/drivers/thermal/Kconfig
> > @@ -220,6 +220,15 @@ config DEVFREQ_THERMAL
> > =20
> >  =09  If you want this support, you should say Y here.
> > =20
> > +config PCIE_THERMAL
> > +=09bool "PCIe cooling support"
> > +=09depends on PCIEPORTBUS
> > +=09help
> > +=09  This implements PCIe cooling mechanism through bandwidth reductio=
n
> > +=09  for PCIe devices.
>=20
> Technically links not devices, but don't think that matters much

That distinction would be splitting hairs beyond what seems useful from=20
ordinary user's point of view. If there's no device attached, BW=20
controller cannot do anything since the link is not going to train.
The link speed reduction is going to impact the speed the device
can communicate with even if it technically occurs on the link.

--=20
 i.
--8323328-1607255192-1729166156=:929--

