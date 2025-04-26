Return-Path: <linux-pci+bounces-26803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD88BA9DAF2
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 15:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF4E179FC1
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 13:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA87F81724;
	Sat, 26 Apr 2025 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEoTnsf6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E774120B;
	Sat, 26 Apr 2025 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745672829; cv=none; b=uMgPkZCBvfZ+ZJ9xX48pqTB1W0LCg1pKjYsOm3TGObVXoHPS3IughHNr/CVyxPZqRI3m5crXp/NrgonUdXMdrvEEs0c2gvA/QXT2zqqBfYZ2v0ywVZ8NUtDk/oWbEiYHJSspcuLSWCHgFbfofBT/je4UtM8s3ZFPQ0RsoDMFETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745672829; c=relaxed/simple;
	bh=tP+8zaOhxz1rLnbBTSygHoqJ133ZXSPGoXBXXm9NE0c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LUZVL6V/N59kFq+cpgT1PtrT3L2sooRrF1nLVKa9Bqf+z2oXn223tTEe90XyJlKvSgbhXVjZbWEg6R3zBWcBuiafT4qcs+mOYmrxcjY1yAZZYDPK4xY+TVZyNg6YRHaMIuFowgWBEDpWbYlPRQ7p3ZQMpsPD2ITe8cFiCanNJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEoTnsf6; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745672828; x=1777208828;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tP+8zaOhxz1rLnbBTSygHoqJ133ZXSPGoXBXXm9NE0c=;
  b=JEoTnsf6XV+YbYv2J+hzq3JhJorMtdp9WfH9xaMkMYno4lLFQKh0lg6g
   sJbbG+fkNCcmLcmhDAXU4UBnd9GaFmL1v34sgro0YqrCD/E+7qewKQOd7
   6SC+/pvS7PrI5hvw/FtNZiY157/hONZWBW2J17cWL+ImTMdTQwQBfVMDY
   CL0OPsCihSY62Jnnfbxnu8P92qzWABwl5atxHt8XWwYXzGyN0us0//ilA
   QFiUrMMtg+GgzhsAWgeiOmNbn1f48ZCkfWv9eIKC/SsWl0yD2Dr75kp/M
   Hz2JX+KS1TXnl/t72rwVhNnCTUULBSxAtqZIIUhjHd7BURf8tU/QfBzcB
   A==;
X-CSE-ConnectionGUID: dB1Zm1HxSuqlWw+H07LW9A==
X-CSE-MsgGUID: GwEpi+r4SSqh5nZ9NQ8LDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="57964027"
X-IronPort-AV: E=Sophos;i="6.15,241,1739865600"; 
   d="scan'208";a="57964027"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 06:07:05 -0700
X-CSE-ConnectionGUID: RGjYzt7ASDeYdX+vRbDOVw==
X-CSE-MsgGUID: 6QrmOG/mR8aeRL3O0vgrHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,241,1739865600"; 
   d="scan'208";a="134057442"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 06:07:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sat, 26 Apr 2025 16:06:56 +0300 (EEST)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: corbet@lwn.net, bhelgaas@google.com, kuurtb@gmail.com, 
    Hans de Goede <hdegoede@redhat.com>, vkoul@kernel.org, 
    yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev, 
    sanyog.r.kale@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, dakr@kernel.org, 
    dan.j.williams@intel.com, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    Dell.Client.Kernel@dell.com, linux-sound@vger.kernel.org
Subject: Re: [PATCH 4/7] pci: doe: Replace sysfs visibility macro
In-Reply-To: <5546db361d2d474b97d80345473628d0e5a55093.camel@linux.intel.com>
Message-ID: <a8581a58-e994-ff5e-6bdc-ca9efe319da1@linux.intel.com>
References: <20250423175040.784680-1-david.e.box@linux.intel.com>  <20250423175040.784680-5-david.e.box@linux.intel.com>  <8d261613-60d3-8825-e073-1b39daadc29a@linux.intel.com> <5546db361d2d474b97d80345473628d0e5a55093.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1919316634-1745672816=:944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1919316634-1745672816=:944
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 25 Apr 2025, David E. Box wrote:

> On Fri, 2025-04-25 at 13:57 +0300, Ilpo J=C3=A4rvinen wrote:
> > On Wed, 23 Apr 2025, David E. Box wrote:
> >=20
> > > Replace deprecated DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() call with the =
new
> > > DEFINE_SYSFS_GROUP_VISIBILITY() helper for the pci_doe_features_sysfs=
 group
> > > in drivers/pci/doe.c.
> > >=20
> > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > ---
> > > =C2=A0drivers/pci/doe.c | 2 +-
> > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > > index aae9a8a00406..18b355506dc1 100644
> > > --- a/drivers/pci/doe.c
> > > +++ b/drivers/pci/doe.c
> > > @@ -119,7 +119,7 @@ static bool pci_doe_features_sysfs_group_visible(=
struct
> > > kobject *kobj)
> > > =C2=A0
> > > =C2=A0=09return !xa_empty(&pdev->doe_mbs);
> > > =C2=A0}
> > > -DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(pci_doe_features_sysfs)
> > > +DEFINE_SYSFS_GROUP_VISIBILITY(pci_doe_features_sysfs)
> >=20
> > Hi David,
> >=20
> > Is it intentional to not have semicolon at the end?
>=20
> Hi Ilpo,
>=20
> I was just doing a straight name swap and didn't not notice the lack of a
> semicolon. Of course, since DEFINE_SYSFS_GROUP_VISIBILITY() expands to a
> function definition, a trailing semicolon isn't necessary.
>=20
> I suspect the issue is with the other instances where it was added, which=
 makes
> the usage inconsistent. What would you suggest?

Hi,

When I saw that lack of semicolon, my first assumption was there's=20
something special here that _requires_ leaving the semicolon out, which=20
turned out untrue after an unnecessary roundtrip to read the macro. So IMO=
=20
it would be better to have the semicolon there to tell the reader there's=
=20
nothing of special interest here.

Also, you used semicolon in the example. :-)

--=20
 i.

--8323328-1919316634-1745672816=:944--

