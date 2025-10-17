Return-Path: <linux-pci+bounces-38448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2AFBE83D5
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF2F574004A
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 10:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53164324B1F;
	Fri, 17 Oct 2025 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TTSL3Ywp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463A329C7C;
	Fri, 17 Oct 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698703; cv=none; b=Quwr2LRHjL4ZBm1hHLOAUPnAzKSA2UHwowD+cCK/ubKVdgHXVZK3JMSJZeKIpcDOtTXz9Lg5ctmE2JM6qSJz++GQi0bQ4jMExtQ7PxDZ7wTCCHfVcHjT7RTWXzRJtEGHEzmXWKaB1NqhlSSP/knELbVpKby4Gt4/J42rH/pugfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698703; c=relaxed/simple;
	bh=ZVZghmxi9QE/MfK2mqwWcibyEGOnNbsyScZcEJvlyDo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iBLBo3TKdgC+aQVlVjk44yOCNtq4qgS9c+rrVihqWwb4EY3ek4CdZReknPNt8441A23FS9I82Ztqu4+OwKjj5XaaLVtU3l2HhET0jGQixfNddh48AaKwZJo5hNr/iZmUBSAqxwFfj4Vr7+WLsM+d0VjHuqz1ZNSYSxx89yxglM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TTSL3Ywp; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760698702; x=1792234702;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZVZghmxi9QE/MfK2mqwWcibyEGOnNbsyScZcEJvlyDo=;
  b=TTSL3YwpROcFUGTplcXfMl1ZEdnnZ3wrgPt1ajVko9AXDkwdgfJe33sK
   knBeoIychhIQEmMmCSh62zcGR33QVawzOEVXOu4rcHJsDnnLsoc+bdYuU
   FibERPPSDpnBisOPaZugHsa4UGrZgPtOFSFw30n8BV3eWft3VuTZoPMGc
   bL2VtzhFadw51OxwzO6WClzngZJOkAiQDVHKE0hMRAfZqRH05ZJhVRqzE
   NFymf28gRW8Ho62h2um2a8K7yorY6XsqwkRzP2Wc+X/wSVf8WexUnZS6K
   Bi12+GHdy8I2qeJTU30f02/pvrvl5Q1+dN/De+nw0P4vfxlT00QmVhQDU
   Q==;
X-CSE-ConnectionGUID: y5bhJcDNS/u7U+eORze6bg==
X-CSE-MsgGUID: JOymB36fSqmtmlEeWjGesg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="65521328"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="65521328"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 03:58:21 -0700
X-CSE-ConnectionGUID: J9lZwTOsQOiDlwVC1TVtrA==
X-CSE-MsgGUID: S/pj3kJZQFS1SIpJz1EHCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="182651716"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 03:58:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 17 Oct 2025 13:58:13 +0300 (EEST)
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Guenter Roeck <linux@roeck-us.net>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/24] MIPS: PCI: Use pci_enable_resources()
In-Reply-To: <aPIfSvhqhc9wxzGi@alpha.franken.de>
Message-ID: <21079c94-cd49-bcd7-6f5d-7d5cd9d61432@linux.intel.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com> <20250829131113.36754-4-ilpo.jarvinen@linux.intel.com> <9085ab12-1559-4462-9b18-f03dcb9a4088@roeck-us.net> <aO1sWdliSd03a2WC@alpha.franken.de> <alpine.DEB.2.21.2510132229120.39634@angie.orcam.me.uk>
 <74ed2ce0-744a-264f-6042-df4bbec0f58e@linux.intel.com> <alpine.DEB.2.21.2510141232400.39634@angie.orcam.me.uk> <9f80ba5e-726b-ad68-b71f-ab23470bfa36@linux.intel.com> <aPIfSvhqhc9wxzGi@alpha.franken.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1515501763-1760698693=:1052"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1515501763-1760698693=:1052
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 17 Oct 2025, Thomas Bogendoerfer wrote:

> On Tue, Oct 14, 2025 at 03:41:42PM +0300, Ilpo J=E4rvinen wrote:
> > [...]
> > It was "good enough" only because the arch specific=20
> > pcibios_enable_resources() was lacking the check for whether the resour=
ce=20
> > truly got assigned or not. The PIIX4 driver must worked just fine witho=
ut=20
> > those IO resources which is what most drivers do despite using=20
> > pci(m)_enable_device() and not pci_enable_device_mem() (the latter=20
> > doesn't even seem to come with m variant).
>=20
> will you send a v2 of the patch ?

Without the the if ()? I can do that, I was unsure how people wanted to=20
progress with this.

--=20
 i.

--8323328-1515501763-1760698693=:1052--

