Return-Path: <linux-pci+bounces-34478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27862B30069
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 18:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9265C176B30
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E28A2E5412;
	Thu, 21 Aug 2025 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jjf6gZiu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC802E425F;
	Thu, 21 Aug 2025 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794725; cv=none; b=Wfv3ltIYWw6I7DxMOEFjX3omZBZT7LiFgoNjPDmBjxbGRUymZdJ/rZICiSGDjbiahX+MWVRg93dfXBQZxvvcUDfyY6rI84N99fkng/zuu8HJMR5igqTCDJsbedq087HOZLqVA34SrfZGKKv+a+umkUyfCPjXeNtfThicG6z6ehg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794725; c=relaxed/simple;
	bh=WyKn3BDOpcCAD6Fuy69UuDdyk4y6Ek+DhsMO5uPWEQY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bwHhm9wKaqw75lt0v8Wh2/1yUSFLWUZYI2CS12AtghBpiFM96WZ2wZrNeXCV/veLrR6R2tlwe3UBipGRdITRzCpyPkgaUXhnvLkfVWhVQGDXkuMPwnFzFCX897UjNoHOjUdV9/Oq9baxtU0R9VdDQmHKauZLPqRZMdsCBRA1OEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jjf6gZiu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755794724; x=1787330724;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WyKn3BDOpcCAD6Fuy69UuDdyk4y6Ek+DhsMO5uPWEQY=;
  b=Jjf6gZiuO0ZZHuBo8kN0yvMqh2pSpIai7RS/G1mhuEqzwt0vor5UijHG
   tGq3HUJ5nFjaQ2s7r6gKFotUJNPwCycmFiOt58Zinrl+tO9hDuiucemwC
   kvMDd0rCjLHcbLlHm2pWg/9p7+xgXfkrci8cExYWkm2FOsdgJh9jqax8m
   vf7RsGn/3elapWoBsZQtInUPGtf5J85ZyhQCBqw2x4E0mNR1cKqDUYRdp
   OKX7C2gDmS7tXAEu7d9q8F7bSWsd9UbJGL1KxpEGQHR0zdt/AHWmOxjNI
   2L0nWEdjlA2m2FVp+Pqlf+xLnMx03Zd65SLXYtsdH1ULnS0mdDMBVQlmK
   w==;
X-CSE-ConnectionGUID: ZPZTHoKJQbm7KJNDik3z4g==
X-CSE-MsgGUID: 4eTO7RlDR1u6scdwebCy1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69531221"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="69531221"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 09:45:23 -0700
X-CSE-ConnectionGUID: HVt0nzi6TyKGfYzTGLP0Uw==
X-CSE-MsgGUID: EJjiqd8UQcSWgWGcjQABNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168879136"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.192])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 09:45:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 21 Aug 2025 19:45:17 +0300 (EEST)
To: Markus Elfring <Markus.Elfring@web.de>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    stable@vger.kernel.org, tudor.ambarus@linaro.org, 
    LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, 
    D Scott Phillips <scott@os.amperecomputing.com>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Rio Liu <rio@r26.me>
Subject: Re: [PATCH v2 1/3] PCI: Relaxed tail alignment should never increase
 min_align
In-Reply-To: <8e9936e5-d720-4ded-8961-b9475aeb2ac7@web.de>
Message-ID: <21e11870-f125-e9e7-04f3-ade94d6be6b1@linux.intel.com>
References: <20250630142641.3516-2-ilpo.jarvinen@linux.intel.com> <8e9936e5-d720-4ded-8961-b9475aeb2ac7@web.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1152484891-1755794717=:933"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1152484891-1755794717=:933
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 21 Aug 2025, Markus Elfring wrote:

> =E2=80=A6
> > Ensure min_align is not increased by the relaxed tail alignment.
> =E2=80=A6
>=20
>=20
> =E2=80=A6
> +++ b/drivers/pci/setup-bus.c
> =E2=80=A6
> @@ -1261,8 +1263,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsig=
ned long mask,
>  =09=09if (bus->self && size1 &&
>  =09=09    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH=
, type,
>  =09=09=09=09=09=09   size1, add_align)) {
> -=09=09=09min_align =3D 1ULL << (max_order + __ffs(SZ_1M));
> -=09=09=09min_align =3D max(min_align, win_align);
> +=09=09=09relaxed_align =3D 1ULL << (max_order + __ffs(SZ_1M));
> +=09=09=09relaxed_align =3D max(min_align, win_align);
> =E2=80=A6
>=20
> I wonder why a variable content would be overwritten here
> without using the previous value.
> https://cwe.mitre.org/data/definitions/563.html

Hi Markus,

This looks a very good catch. I think it too should have been:

relaxed_align =3D max(relaxed_align, win_align);

=2E..like in the other case.

--=20
 i.

--8323328-1152484891-1755794717=:933--

