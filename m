Return-Path: <linux-pci+bounces-7161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2768C8BE029
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 12:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7521F20FD0
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 10:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8823F14EC77;
	Tue,  7 May 2024 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOYinbve"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868A7828B;
	Tue,  7 May 2024 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715079047; cv=none; b=L5vpO0IVp+ua5c9EM7zbObgRZjxqvdnBl6391MuTMNUphno34HhoafMdsbU0aHjz8LyeyAcnRvsH65yQdm+43A2xDbZ3lvSWcS6MOJt9sRLooQCArDtlpis9El6WByeQ9SMEe2+sAFNxaDna9rJdK/P9yOwo12NyzNYsKqMIGyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715079047; c=relaxed/simple;
	bh=z4D6Vnf7+LvZ/qQU3Quvq+0Ws0qf/yQ7HwNAvPmxhuo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GyFxn0CJaKw05Fo/n7n8g39ojrxEaFeQDicBk/J1nOKKZKzlD5/PSjC/IWUXpW+tRhJloX17wOQY4kJnIaYwHvQuSTDbwW4MC00hkZbLwtzk75QVIvqm2df5QxXQ4ka7bH60zwCslOrqFV11urhq49gr6n2fj2Kk6VTXEeq0MYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOYinbve; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715079046; x=1746615046;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=z4D6Vnf7+LvZ/qQU3Quvq+0Ws0qf/yQ7HwNAvPmxhuo=;
  b=WOYinbvewsYe5UXTuef0NmGC0pcqg2yDuQWVGozbWlYMG4HcUuWSRwbX
   c/oUX7PCUWSbVuX9JyGdXCuPvMdpC1xgif0rr8A17tDpuqjHlDb5/aeJh
   aClYrdhZTN8lf4IF+AYGf3bR4hbRnM6phsqSmcMTqgvWUTEYCsD6x0goU
   nTmuR0Q58lv95ro+H3//23GjQvZ1JQtJwqmtml5sxOa1L+DfCAJNl2z5r
   Pe2Oi3uOPpknB9GuKX6jRyaRuibY+bRi60/13I9YJR9vIUegc7M+mAcr3
   hd9UG3PQK7MwzlrVH489vT5m5+mg9Mi6qxjEc4L5k9XwbcbKauBg6cL6/
   Q==;
X-CSE-ConnectionGUID: e0Mzo3GYQgez2jkb37VobQ==
X-CSE-MsgGUID: PPK5vzEpQaSLTmT2kbAQfQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="21532106"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="21532106"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:50:45 -0700
X-CSE-ConnectionGUID: EHoKTEy9T5CT1M24yDnx6A==
X-CSE-MsgGUID: vd5LBFtsQtmm5xNCJ+T8wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="29068057"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.74])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:50:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 7 May 2024 13:50:36 +0300 (EEST)
To: Mika Westerberg <mika.westerberg@linux.intel.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Igor Mammedov <imammedo@redhat.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/8] PCI: Make minimum bridge window alignment reference
 more obvious
In-Reply-To: <20240507103656.GA4162345@black.fi.intel.com>
Message-ID: <11515b48-6cea-f71e-4ecc-d683ee46bc93@linux.intel.com>
References: <20240507102523.57320-1-ilpo.jarvinen@linux.intel.com> <20240507102523.57320-8-ilpo.jarvinen@linux.intel.com> <20240507103656.GA4162345@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-558912366-1715079036=:7551"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-558912366-1715079036=:7551
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 7 May 2024, Mika Westerberg wrote:

> On Tue, May 07, 2024 at 01:25:22PM +0300, Ilpo J=C3=A4rvinen wrote:
> > Calculations related to bridge window size contain literal 20 that is
> > the minimum alignment for a bridge window. Make the code more obvious
> > by converting the literal 20 to __ffs(SZ_1MB).
>=20
> I think that's SZ_1M not SZ_1MB :)

Of course, that's the only place which is not checked by the compiler so=20
it's the place where I type it wrong and forget to use backspace. :-)

> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> Looks good, may be even add a #define for this but either way,

I considered that but I could not find a good name for the whole construct=
=20
(with the __ffs() I mean). Perhaps PCI_BRIDGE_WINDOW_LSB could be an=20
option but that feels somewhat clumsy to me.

--=20
 i.
--8323328-558912366-1715079036=:7551--

