Return-Path: <linux-pci+bounces-26785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 249F2A9D048
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 20:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 396E018996A8
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47D221576A;
	Fri, 25 Apr 2025 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AyJmEsca"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1447134CF;
	Fri, 25 Apr 2025 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604807; cv=none; b=NYd3SFB+ZFgmV69+3ND45EQJioGwlK8WKNK9ueWqfmCnN9bjmLJM/HdfqfYtRjYkvPKIctc3HJX6I0Q/VXetzkazhx47ZCb7dQb/SThMUvVm3+xztiqEfa6w5yfhpMtNDc7zQp6nBNtxb2BlaQr5fJgu0xjjht/3+sTp7eEMrrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604807; c=relaxed/simple;
	bh=JkpxNkCzkYh0Du/1121be6BqpejJcBjTTxXTHMqZE60=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dD+6Vlx7m9bkiPJjJiUPcELwlTAaGdMB7C1LhXwmhZhFqGUSHSWnwP5fuSXWKt3sqEBo5HVkO0lHJb5aLjbgtDWx/lAKljBRN9fbqJPniLoQl3Q4jYClhsenG4QaHXDQWP3wJjFHs8Y9eozkD/hL7reX9a6tur6FT/OGMeOtM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AyJmEsca; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745604806; x=1777140806;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=JkpxNkCzkYh0Du/1121be6BqpejJcBjTTxXTHMqZE60=;
  b=AyJmEscaWN2JlX2usDZsDaueCuITQ4HvoOSXS/0j4teaO2u4OtA8nJzs
   qsmMwwXC4Abz5o58qc6aliXDVoPIIovE6UaXSzCpbad47q4pBl+jUP+pd
   XuXFSLRVnNqEjr528AH3kBEOxdRmNCJ4yOQqQSXTM1NxOVw5lLRa7o4WD
   DgYwUVZyxdHKWoy3fzTEHqzIkmJvSYUIH+G9xosXre3vbLPHifB2l54AA
   qmwhMUasKCjdPy4rQFZUYGGgzRGWkp19mmTgDgh+oX4vx1n105s1hAJtM
   xkyA49A0X/GmdDx6D/jNxaxKDhVUnDto8jZoIzqpBhmbKGbrUhYjfoXs3
   Q==;
X-CSE-ConnectionGUID: 0jX8ZZhCTYCH9pI/ZDGhHA==
X-CSE-MsgGUID: Z+oeGnsGQWuRNuOsN4AAyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="64804437"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="64804437"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 11:13:25 -0700
X-CSE-ConnectionGUID: vMfdYYlFQwmGqd0SAGxs2A==
X-CSE-MsgGUID: TCZ9agQpQ1GCtyMidk/+YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="133903167"
Received: from iherna2-mobl4.amr.corp.intel.com ([10.125.108.191])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 11:13:23 -0700
Message-ID: <5546db361d2d474b97d80345473628d0e5a55093.camel@linux.intel.com>
Subject: Re: [PATCH 4/7] pci: doe: Replace sysfs visibility macro
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: corbet@lwn.net, bhelgaas@google.com, kuurtb@gmail.com, Hans de Goede
	 <hdegoede@redhat.com>, vkoul@kernel.org, yung-chuan.liao@linux.intel.com, 
	pierre-louis.bossart@linux.dev, sanyog.r.kale@intel.com, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	dakr@kernel.org, dan.j.williams@intel.com, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>, linux-doc@vger.kernel.org, LKML
	 <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
	linux-sound@vger.kernel.org
Date: Fri, 25 Apr 2025 11:13:22 -0700
In-Reply-To: <8d261613-60d3-8825-e073-1b39daadc29a@linux.intel.com>
References: <20250423175040.784680-1-david.e.box@linux.intel.com>
	 <20250423175040.784680-5-david.e.box@linux.intel.com>
	 <8d261613-60d3-8825-e073-1b39daadc29a@linux.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-25 at 13:57 +0300, Ilpo J=C3=A4rvinen wrote:
> On Wed, 23 Apr 2025, David E. Box wrote:
>=20
> > Replace deprecated DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() call with the ne=
w
> > DEFINE_SYSFS_GROUP_VISIBILITY() helper for the pci_doe_features_sysfs g=
roup
> > in drivers/pci/doe.c.
> >=20
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> > =C2=A0drivers/pci/doe.c | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index aae9a8a00406..18b355506dc1 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -119,7 +119,7 @@ static bool pci_doe_features_sysfs_group_visible(st=
ruct
> > kobject *kobj)
> > =C2=A0
> > =C2=A0	return !xa_empty(&pdev->doe_mbs);
> > =C2=A0}
> > -DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_doe_features_sysfs)
> > +DEFINE_SYSFS_GROUP_VISIBILITY(pci_doe_features_sysfs)
>=20
> Hi David,
>=20
> Is it intentional to not have semicolon at the end?

Hi Ilpo,

I was just doing a straight name swap and didn't not notice the lack of a
semicolon. Of course, since DEFINE_SYSFS_GROUP_VISIBILITY() expands to a
function definition, a trailing semicolon isn't necessary.

I suspect the issue is with the other instances where it was added, which m=
akes
the usage inconsistent. What would you suggest?

David


