Return-Path: <linux-pci+bounces-27980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E54ABC014
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 16:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C3FD3B0554
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B537D515;
	Mon, 19 May 2025 14:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ho9vJb/F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AE227CCDF;
	Mon, 19 May 2025 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663200; cv=none; b=KGBpRRY87vlhNum3blpOtvwqXvGEqXzAGUD6otWpO+YDKf9Miy6vyT4q4W68EAi1mKdpe0nph6vX7kvnjGTvDRXQDxXhDip8Pu799md5UJpesXie44HaCzdWaJ5sTgi0JlVfZDI6y8iKC5DQjUk2urZZdZkCXBH2gFRD4qDrSsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663200; c=relaxed/simple;
	bh=nlwaRiZByqL7DWe+ve7Y0BHWr11JoqCF+RIeqCTnuZE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I/b3CHMegX2bAwSUEEch3mPvfVkp3fbX4jFaIMbTRkOGhtnvgLPFfao7i8XeFzvTvnYzyLvtAjlWIKRF/S1mvyIrHSrvKhT8ltL/Kd7RqiPW0ccbCsGd0/ANq4hfBanxaf7ttikmpQkReyCUE7fe+YsD7Ylk2QtVTujZW1TLQvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ho9vJb/F; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747663199; x=1779199199;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=nlwaRiZByqL7DWe+ve7Y0BHWr11JoqCF+RIeqCTnuZE=;
  b=Ho9vJb/FzpdK3xHcX81ZyKv/ztn9+i0mQQkCyPvuYr3OHYg1fbQ+5OHW
   FS5MfHvyLP4FMVZ2Mqn9IjVfIW49lFQMM70jWjHNJq09iE6mHPfJLCHja
   A43PpwrWar/h9pZi8UvVYuBnToS25z8EMkvU8ZXg5CwbtdArzW/q/qZGb
   RQMcnOPxltDxP2lpzGkozswDLy0PtcqJk/ssljmU39e1q9muCYva1zt63
   +LGrpn/Hi7aQSRcUVT0eQCbV69dOBIZ/OLmrOuKBamA5sgFeaFVbIl2lX
   gP7MtBaWZvYELDIB0UEUi2Z8Yav5Iur43GGac8EiVW1mclBQ43fMHGMRz
   w==;
X-CSE-ConnectionGUID: ApSHDQLwSxSMjfulxOQ1uA==
X-CSE-MsgGUID: 6PHOi5GmQ92n1XMWab8saw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49544733"
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="49544733"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:59:58 -0700
X-CSE-ConnectionGUID: y46un7LQRCqX8tvFcuVLKw==
X-CSE-MsgGUID: EC5RLrF6Qxy8zga0ybz5zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,301,1739865600"; 
   d="scan'208";a="144259736"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:59:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 19 May 2025 16:59:53 +0300 (EEST)
To: =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: Unnecessary linesplit in __pci_setup_bridge()
In-Reply-To: <20250516132016.GA2390647@rocinante>
Message-ID: <9dd35654-e6eb-a531-457c-93ddc5ff371d@linux.intel.com>
References: <20250404124547.51185-1-ilpo.jarvinen@linux.intel.com> <20250516132016.GA2390647@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-737852547-1747507212=:9295"
Content-ID: <70f50449-3f92-f192-8219-db931bacd20f@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-737852547-1747507212=:9295
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <47939a5e-e033-f463-045e-b9e82fb95da0@linux.intel.com>

On Fri, 16 May 2025, Krzysztof Wilczy=F1ski wrote:

> [...]
> > -=09pci_info(bridge, "PCI bridge to %pR\n",
> > -=09=09 &bus->busn_res);
> > +=09pci_info(bridge, "PCI bridge to %pR\n", &bus->busn_res);
>=20
> I don't know if there still exists such a thing as "trivial patches
> maintainer" any more, so I will pull this.
>=20
> I gather, it must have bothered you a bit. That said, Ilpo... your
> expertise and time could have been spent differently. :)

It doesn't take long to do patches like this and I don't search for things=
=20
like this intentionally nor focus on them. It's just that I do encounter=20
these simple ones too while I'm spending my expertise differently :-). You=
=20
can check my track record on discovering e.g. real concurrency issues=20
recently so I hope you can give a bit slack on a few trivial patches here=
=20
and there ;-).

--=20
 i.
--8323328-737852547-1747507212=:9295--

