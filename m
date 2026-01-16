Return-Path: <linux-pci+bounces-45045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A26D316DA
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 13:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 050723047406
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 12:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA8D227E82;
	Fri, 16 Jan 2026 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1wNdbOI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC58B21ABC9;
	Fri, 16 Jan 2026 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568372; cv=none; b=g9FKOWGkye01H5bszyOtBAODBI2sbfVP3VieyyD1nac4RIqr8qfh9qppRg2JHE/8Ly4m7v9G0FzTpMTjf7miIEQVbPrAFi54LNQH8ikJ1bOmxQwCw8nSQLnloM17kI0eahso7BfDPKk1COGmTzr/qiD9p+O7GZ+jb9BTpEOdWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568372; c=relaxed/simple;
	bh=NhdU1DVx1w8XT7ec6D99S8jBh8GOHeU4d2LPrQF709k=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=B5+BFHx8t7Ghmjpu6ye623wBiBzj1WMW5q3NLeDdatic/266t26s9JuA7+8jdn54ScbARm+TiKyXTWuPZOq78fHRLzAwv4VvEnrNp/oSo/Hf5/3s8W/nOTzjwKr1/H5K0o4Kl8p3SJkIhvlZCUslF9qxaCwyQJ+DI8kxXLiV4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1wNdbOI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768568371; x=1800104371;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NhdU1DVx1w8XT7ec6D99S8jBh8GOHeU4d2LPrQF709k=;
  b=Q1wNdbOIQ5MYAShlSOQyohSF91lq5mQJ3xWXGcgK20DneWClf6be7G56
   99b0BIuz9ebJFwP8bcU8yeqsg1z3LxzDRJiIGLT9k7maT6DHPhxs2pyZL
   oL9GxF0FGKn3NILODJDkHP0cEnCYj4N3Z9JdrTAx6iH5b7yPgUsxZVE0e
   w9rws2wTQAbtqNiV5AhRsPHcGDDwGov60IlD2mjO+vyKyrIUnPBNDQZhm
   GCcywW3p788ykPKkz0oPxSff5u+rztz1XIC0MX4NY+4A44320XQknEzxM
   O161zpzotqhOFh8OjqK6ncCRXSM6+pwPJGNPZgLHKuttKkGX9Vvhk/GJS
   Q==;
X-CSE-ConnectionGUID: Swqbp40qTHaZmtzu4YZwUg==
X-CSE-MsgGUID: xa+TnGfxQaS3SaYxLP1rQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="92544960"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="92544960"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 04:59:30 -0800
X-CSE-ConnectionGUID: AYmAM6g+TDi7KcVHdSnAPQ==
X-CSE-MsgGUID: dntiHN11Qg6cLTNR9dqEng==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 04:59:27 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 16 Jan 2026 14:59:23 +0200 (EET)
To: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
cc: Jinhui Guo <guojinhui.liam@bytedance.com>, Keith Busch <kbusch@kernel.org>, 
    "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>, 
    Alex Williamson <alex@shazbot.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] PCI: Locking related improvements
In-Reply-To: <20260116125742.1890-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <02bc8a1f-2630-847f-8371-8f39d65b01a7@linux.intel.com>
References: <20260116125742.1890-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1606155674-1768568363=:12176"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1606155674-1768568363=:12176
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 16 Jan 2026, Ilpo J=C3=A4rvinen wrote:

> Hi all,
>=20
> Here are a few locking related coding quality improvements, none of
> them aims to introduce any function changes. First two convert "must be

s/function change/functional change/

--
 i.

> asserted" comments into lockdep asserts for easier detection of
> violations. The last patch consolidates almost duplicated code in the
> bus/slot locking function.
>=20
> This series based is based on top of the fix (the last change would
> obviously conflict with it):
>=20
> https://patchwork.kernel.org/project/linux-pci/patch/20251212145528.2555-=
1-guojinhui.liam@bytedance.com/
>=20
>=20
> Ilpo J=C3=A4rvinen (3):
>   PCI: Use lockdep_assert_held(pci_bus_sem) to verify lock is held
>   PCI: Use device_lock_assert() to verify device lock is held
>   PCI: Consolidate pci_bus/slot_lock/unlock/trylock()
>=20
>  drivers/pci/pci.c | 120 ++++++++++++++++++++++++----------------------
>  1 file changed, 63 insertions(+), 57 deletions(-)
>=20
>=20
> base-commit: 270f0a8620a2d8fac3bcab3779df782d85b3b4bf
>=20
--8323328-1606155674-1768568363=:12176--

