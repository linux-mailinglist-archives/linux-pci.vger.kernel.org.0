Return-Path: <linux-pci+bounces-18504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482EB9F320E
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 14:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879931665EF
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 13:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF735205AB0;
	Mon, 16 Dec 2024 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CvNmGMQ6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF97B29CA;
	Mon, 16 Dec 2024 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734357452; cv=none; b=QU+PGKfC7ntNoP0R1MaNyM2FxnoMTR1M5H+pKmOI2Zn2Hsq11s5izX+ewi7IRctT+WThSzCM+iT8iraDtlml6KoLZAJtgY948Ud+MDZ4lL6NJEpDyxi8Z7OcPIYAZeyTvSD/ReMuTAU6/J33zkD1rIXjhwmPQzZjIfiBq1Z3L5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734357452; c=relaxed/simple;
	bh=asW/rEU97Lhupbtp+ldMp9ntQdvITH9HiMPFa8DHXXU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mjypnTvzrP0IL366geKqEU+B8JzOIRSXN/Kzkt/vxtnYl2FY39e61Yo279x9y24jbgn+0cv5FcqhWx/avif59qPR43qk3fLeaVNC+ouDPYlfScAD7GnmV6HEZjr43mt2rvGcdd7JOqAVOadSiTRC2fPkaAH1Cv29+prhv7l0lsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CvNmGMQ6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734357451; x=1765893451;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=asW/rEU97Lhupbtp+ldMp9ntQdvITH9HiMPFa8DHXXU=;
  b=CvNmGMQ6AYqJjGOyKKU6MoQACL9olKgfBKDe/64qjkJCd3T8i039axKt
   ufHiaOc4KD2xpMQJYkluiLzmXNVT/qOfhRtTUtYKbtaU0IURqvgn2U115
   9puY2fSfOR68tsv82fGgrqOsw4fujVDV1qErjd+9xlUa986u9802u6PfX
   JSD+gLuajdfzvvEgQ1R27cKDn6iCUERMhmNpbYVTnxbGYr0O1gTmTx+56
   JKDAftrsPCGdnAWDzqZHQ4y0neC9sbpfctM23ttVQJ8a44Res9EUo2ZES
   cOcBrnhVckRJw44MHyGWuwg1sv8UpvrYiN8YZIoQwnO/Sq+evUSndGiJk
   Q==;
X-CSE-ConnectionGUID: eWgx9HNnRAyfqGGWPMA4mw==
X-CSE-MsgGUID: Qh8+q7+2QX2eMtlP3MXnoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="22327530"
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="22327530"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 05:57:30 -0800
X-CSE-ConnectionGUID: XOBIYAXUQuSw0lBEwcrp+A==
X-CSE-MsgGUID: 76n3K51WRmioP0fo0HJzmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,238,1728975600"; 
   d="scan'208";a="96971982"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.29])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 05:57:25 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 16 Dec 2024 15:57:23 +0200 (EET)
To: Yazen Ghannam <yazen.ghannam@amd.com>
cc: x86@kernel.org, tony.luck@intel.com, mario.limonciello@amd.com, 
    bhelgaas@google.com, jdelvare@suse.com, linux@roeck-us.net, 
    clemens@ladisch.de, Shyam-sundar.S-k@amd.com, 
    Hans de Goede <hdegoede@redhat.com>, naveenkrishna.chatradhi@amd.com, 
    suma.hegde@amd.com, LKML <linux-kernel@vger.kernel.org>, 
    linux-edac@vger.kernel.org, linux-pci@vger.kernel.org, 
    linux-hwmon@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2.1] x86/amd_node, platform/x86/amd/hsmp: Have HSMP use
 SMN through AMD_NODE
In-Reply-To: <20241212214637.GA80677@yaz-khff2.amd.com>
Message-ID: <ff59d4e9-15da-37b3-1a8c-1ae688fa4094@linux.intel.com>
References: <20241212172711.1944927-1-yazen.ghannam@amd.com> <65375593-f2e0-e03b-7e7f-ad8be58772d4@linux.intel.com> <20241212214637.GA80677@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1223704678-1734357443=:941"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1223704678-1734357443=:941
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 12 Dec 2024, Yazen Ghannam wrote:

> On Thu, Dec 12, 2024 at 08:50:26PM +0200, Ilpo J=E4rvinen wrote:
> > On Thu, 12 Dec 2024, Yazen Ghannam wrote:
> > > @@ -95,7 +80,12 @@ static umode_t hsmp_is_sock_attr_visible(struct ko=
bject *kobj,
> > >   * Static array of 8 + 1(for NULL) elements is created below
> > >   * to create sysfs groups for sockets.
> > >   * is_bin_visible function is used to show / hide the necessary grou=
ps.
> > > + *
> > > + * Validate the maximum number against MAX_AMD_NUM_NODES. If this ch=
anges,
> > > + * then the attributes and groups below must be adjusted.
> > >   */
> > > +static_assert(MAX_AMD_NUM_NODES =3D=3D 8);
> >=20
> > Please also add the #include for it.
> >
>=20
> Just to confirm, you mean for static_assert()?
>=20
>   #include <linux/build_bug.h>

I saw you already made that change but yes, it is what I meant.

--=20
 i.

--8323328-1223704678-1734357443=:941--

