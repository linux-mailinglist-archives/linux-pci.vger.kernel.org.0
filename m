Return-Path: <linux-pci+bounces-18775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE549F7B8A
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 13:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9067516CD37
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE33022489F;
	Thu, 19 Dec 2024 12:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLU+SNvT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F5A2080F1
	for <linux-pci@vger.kernel.org>; Thu, 19 Dec 2024 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734611800; cv=none; b=IzSCX7mbmsxTmv4+Hfydk4dkkD3fUFEZjtMjjxWAoemsuP0EyYB6zCeF9dRUEkFG1WclSseJm2Yh/nTqYSyFb00bJXF4p3Spo/zeLOmRt6E4KJBkr1bwyZELTQQxko7UJ/7hTW/2PjNt99YdbNFhOPZIrS6yzhrp67eBJ8OcDxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734611800; c=relaxed/simple;
	bh=bBr3lALq5cCWIpYZ17zHxAz4c/s5xZUjcT0IoPAj8Ds=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Tn4vvqvDkOWXUtq8BVt0QmSzydylfuL1TFWGAS82B0pjfGST9JvymBuZyZstIX4PbG7jQInC4+dy3h6jqbs7p5tRe10fEkSkKboIdh1Nk2dHRMARNXT6A9dE90fg0Ez181VWdYcuiRRVIAUSDZtV5/ZvLqeDHpAK5SgnX2XC2n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BLU+SNvT; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734611800; x=1766147800;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=bBr3lALq5cCWIpYZ17zHxAz4c/s5xZUjcT0IoPAj8Ds=;
  b=BLU+SNvTFfs+YP54Z7eS6G8LncKTUugMnnfaWiMBTm5oTU2pw7btPcFi
   36yyROpACSV/or4pBZkq0GIMT9gLy7VS9lqPwsswMM0uPG08aPRlNw2wV
   vo2mqeGnZyQqcCoGFZU8221IPs632CgzWNKFoyqL02dzshYGrbF3q5qb9
   4TuwhetZYxtYdKdDnnr3+ALToIxFV2ckAXpuL4UrM6WCTcZ8MkTS3+L8u
   bYnKn5vy4ZA0SdR6X3wQ6TqQuUMSUyFDPG7N6E2oKO8AVBPWC0BYE3rfW
   SMCOS7+ZuGBcRSbzYIrI80tHgljhloQ6ItESY9tmFt4IQm+d2LaB/v8D3
   Q==;
X-CSE-ConnectionGUID: IiqOIJRyQYSz0mdD/NOqIQ==
X-CSE-MsgGUID: Y8y/BK56RvC2e+je+MrrlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46506243"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="46506243"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 04:36:39 -0800
X-CSE-ConnectionGUID: aSJz2unjSy+tH2oGQ2s6vA==
X-CSE-MsgGUID: AQvOcARURNC8e4gCXi7L4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="98245608"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.7])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 04:36:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 19 Dec 2024 14:36:31 +0200 (EET)
To: Hans Zhang <18255117159@163.com>
cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org, 
    arnd@arndb.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-pci@vger.kernel.org, inux-kernel@vger.kernel.org, 
    rockswang7@gmail.com
Subject: Re: [PATCH] misc: pci_endpoint_test: fixed pci_resource_len return
 value out of bounds.
In-Reply-To: <ca7e3d52-c60d-ee19-ca6b-8fa5674197c2@163.com>
Message-ID: <fcac2f00-3d68-a398-4d47-2858272849f8@linux.intel.com>
References: <20241217121220.19676-1-18255117159@163.com> <4ed0496c-329b-ae7e-dce4-5d822e652d46@linux.intel.com> <ca7e3d52-c60d-ee19-ca6b-8fa5674197c2@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-520623811-1734611569=:932"
Content-ID: <4dcc57fa-fb57-3764-fbd0-b142f8096920@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-520623811-1734611569=:932
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <5261a918-252c-3a22-3d63-905eb2d1b900@linux.intel.com>

On Thu, 19 Dec 2024, Hans Zhang wrote:
> On 12/18/24 10:00, Ilpo J=E4rvinen wrote:
>=20
> > I'm not sure how out-of-bounds access would happen. On which line you s=
ee
> > that possibility?
> Please see #L291
> https://elixir.bootlin.com/linux/v6.13-rc3/source/drivers/misc/pci_endpoi=
nt_test.c#L291

Ah, so this was just a language confusion (understandable, we're not=20
perfect in expressing ourselves in English, me included).

So you didn't mean "out-of-bound access" at all but that the value is too=
=20
large to fit the int sized variable.

Could you please try to phrase it better so it's clear what you mean with=
=20
it. And it feels that said multiple times as there's also the 2G thing=20
mentioned elsewhere in the changelog. It would be nice if you could try to=
=20
avoid such duplication. So try to structure changelog so that you first=20
describe the problem and its impact. And the how the patch solves the=20
issue.

> > > If the bar size of the EP device exceeds
> >=20
> > BAR size
> >=20
> > > 4G, this bar_Size will be equal to 0.
> >=20
> > bar_size
> >=20
> > I think bar0 and bar1 information could simply be dropped since they're
> > unrelated. I think this would be enough information:
> >=20
> > With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".
> >=20
>=20
> Do I need to add the patch version?

Yes, when you change the patch in anyway, please create a new version.

--=20
 i.
--8323328-520623811-1734611569=:932--

