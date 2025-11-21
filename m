Return-Path: <linux-pci+bounces-41859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ABFC78E0A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 12:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CE1F348CE8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 11:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6EA26A0C7;
	Fri, 21 Nov 2025 11:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9c/w66o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EF23242B0
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763725215; cv=none; b=NNMhXQw8v+xEj0E9TxlnNdzdqHjY0wEhQJX2P6fnTakPf/JOQpLNqLYh9Yl+nnNrDp2xT0dgOJLyadoIlnwRA/gNJm48rygA1H71g3GKUbpY3jWKq0oUi+Yw0Alr+9eOAvfZem3vtL1Z6AmbeKiPQM1+cbyJE6wNjgoENeoqwg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763725215; c=relaxed/simple;
	bh=HGXswDgXJMicfTsEVVNexmqOrNQpK3JgOS05+Xqudd4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FCzL5mFKTm51cfz4tMIarslwP+vudpYafPknxMcaE4T8R7f8QD4XCA0iet8YMwzjTYd1wX93l3UEzcl2ez0eRgccOEqq7oK9mj/aQ5o6ZsqfCnpxO8ISmYrq4S84CM2ltGJGz36xMGLAI3cMto/kzc2ii0JlSyp0SGQl8GF/RZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9c/w66o; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763725213; x=1795261213;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=HGXswDgXJMicfTsEVVNexmqOrNQpK3JgOS05+Xqudd4=;
  b=N9c/w66obsp3FgEE4RwqCMoEmC96s2uhemeXG01H5J8okS+ZaJEVZVYR
   P71V4Gwz4HPepu9KttHOq7KwBm1MamsWK4Yp16zQnokO3syI+y2nSN2b3
   CGlI8mdXwn8qiyNMGZw+6rFerTv/Ku7tPunhT8PNmACZtIQ3qnMVP1+RV
   lH9eiwU//1u16Mei1GuIOq2/uEgEuoRpdT/LUnYpK6FF8XVfIPzlzuTFQ
   gmAgmk5Mf4yBGv3sSST0dDIQKXWO/TsqN8lalqBiimQwDQKBccRtg2IxH
   Nuno+jFVp+v0MyKzC8fA/uo9fw+ub8R0gWQ3DYN72E/ZGzq/vKObjHtk2
   w==;
X-CSE-ConnectionGUID: C7wxNJBFSbOO4b5392d7Dw==
X-CSE-MsgGUID: ux8SYBKjTli2+PkKAZD5gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="83439140"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="83439140"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 03:40:12 -0800
X-CSE-ConnectionGUID: PWTE7upwT9WvAVvptpKuJw==
X-CSE-MsgGUID: VbiWpCMEQuChMHIyeormTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="192448093"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2025 03:40:11 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 21 Nov 2025 13:38:01 +0200 (EET)
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: linux-pci@vger.kernel.org
Subject: Re: [bug report] PCI: Add pci_rebar_size_supported() helper
In-Reply-To: <aSA1WiRG3RuhqZMY@stanley.mountain>
Message-ID: <a2e52d2e-fe9e-6f55-454a-4e7710c2c1ca@linux.intel.com>
References: <aSA1WiRG3RuhqZMY@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1957514103-1763720726=:965"
Content-ID: <d5cc8df2-b22a-489a-cc2d-c7fa2b656a80@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1957514103-1763720726=:965
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <aab4ce21-c491-e38e-6091-05f2c1a07a96@linux.intel.com>

On Fri, 21 Nov 2025, Dan Carpenter wrote:

> Hello Ilpo J=E4rvinen,
>=20
> Commit bb1fabd0d94e ("PCI: Add pci_rebar_size_supported() helper")
> from Nov 13, 2025 (linux-next), leads to the following Smatch static
> checker warning:
>=20
> =09drivers/pci/rebar.c:142 pci_rebar_size_supported()
> =09error: undefined (user controlled) shift '(((1))) << size'
>=20
> The problem is this call tree:
> __resource_resize_store() <- takes an unsigned long from the user
>   -> pci_resize_resource() <- truncates it to int
>      -> pci_rebar_size_supported()
>=20
> drivers/pci/rebar.c
>     138 bool pci_rebar_size_supported(struct pci_dev *pdev, int bar, int =
size)
>     139 {
>     140         u64 sizes =3D pci_rebar_get_possible_sizes(pdev, bar);
>     141=20
> --> 142         return BIT(size) & sizes;
>     143 }
>=20
> So here size could be negative or >=3D BITS_PER_LONG which leads to
> shift wrapping.  But also truncating the ulong to int in
> __resource_resize_store() is not beautiful.

Thanks Dan!

I've not liked using int for those size parameters as the field on PCIe=20
side is obviously unsigned (less than u8 actually, PCIe r7.0, sec 7.8.6.3)=
=20
but haven't yet spent time on converting them either.

The issue seems older though than introduction of=20
pci_rebar_size_supported() in the commit bb1fabd0d94e ("PCI: Add=20
pci_rebar_size_supported() helper") that just moved that BIT() inside the=
=20
newly introduced function.

I'll send the fix next week (I wrote it already but they seem to be doing=
=20
some electric work over this weekend so I can't easily do testing for it=20
with systems I normally play with BAR resizing).

--=20
 i.
--8323328-1957514103-1763720726=:965--

