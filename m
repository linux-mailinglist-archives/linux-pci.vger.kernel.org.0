Return-Path: <linux-pci+bounces-4848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F02787CAFE
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 10:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C551C217A5
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 09:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E92D182C3;
	Fri, 15 Mar 2024 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TELJs5vG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD4F18041;
	Fri, 15 Mar 2024 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496723; cv=none; b=bPvWLk4vxJWhq8c6F7DEa8oUuyrs9hgQBLj2z5a/Yd9vVeBATYSF3tvESIE1ud+hLNnS5s1v7283kACTPHsFdeuQhgTrXLgU5KOHXXI4Sdm7ro//33MAxxkcGcKhYFvXQZ1Qzuqp+ldclbZkpvFIH9Z8ZiKTFn3uPec2l8o4/ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496723; c=relaxed/simple;
	bh=UorXTGu+AcCu4hDCxmYjcKqMuP8YVTSZD/Jao3gQpVU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ui8rl2MXGKl4Ok/QrC09yLCuzQZtnv2PF64g/uEOl0Rj7mkyDkbvvoF5rzYEmV4zv4CkGynyybth1qHq+iYfi5T7nUaEZ3IRLZZDEYeym9IrdWo5m1Sz7msEbvxhMXc6s32o1vj/s1PNGbg9q4VyGbPYjqPXKHMuA9X+8bGdgRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TELJs5vG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710496721; x=1742032721;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=UorXTGu+AcCu4hDCxmYjcKqMuP8YVTSZD/Jao3gQpVU=;
  b=TELJs5vGA51eQiripYBHr0ScNQm6t47JJPnA4ZLdZsFMcxX0jd0gXi9T
   AGLDDDVMqpviztoWcO0hQV5T+mo6FUEhIR5zC48u8MA3AM//N438aOmn3
   W7ta6XAoLUE5a4/W/at4lQ76ul+hqSdzd/oh8IS4BWXDCaGgnKFryMtcg
   3GsuskFxlDrGdPM02NCpyHshZuZJ4ckC7Q9Ka3Za/eX6pKVMKhnYYuLud
   knmYecjK3hMeWgDZW+R62cHtpVwhjXkUAsFUHHcDZ+XHFOHccw91sk8Of
   SfIVLrKz0ErI5OohIO86qV82kpkYiesjqm3mYHKKEJIZLTGKhiwOe8BG8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="8296194"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="8296194"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 02:58:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="12523729"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.9])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 02:58:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 15 Mar 2024 11:58:31 +0200 (EET)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI: Use the correct bit in Link Training not active
 check
In-Reply-To: <alpine.DEB.2.21.2403142145010.37739@angie.orcam.me.uk>
Message-ID: <c81ecb2a-9365-dbb0-2207-ed692c8c7487@linux.intel.com>
References: <20240301150641.4037-1-ilpo.jarvinen@linux.intel.com> <alpine.DEB.2.21.2403011622560.42226@angie.orcam.me.uk> <c740c6e4-ca1a-33ad-8437-4a1219c16eb1@linux.intel.com> <alpine.DEB.2.21.2403060951310.43702@angie.orcam.me.uk>
 <01666075-504d-a434-d039-2e25db931f23@linux.intel.com> <c4fe9080-245f-7089-84c1-bb47dcf2cd83@linux.intel.com> <alpine.DEB.2.21.2403142145010.37739@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1935341792-1710496711=:1018"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1935341792-1710496711=:1018
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 14 Mar 2024, Maciej W. Rozycki wrote:

> On Thu, 14 Mar 2024, Ilpo J=C3=A4rvinen wrote:
>=20
> > One more point to add here, I started to wonder today why that use_lt=
=20
> > parameter is needed at all for pcie_retrain_link()?
> >=20
> > Once the Target Speed has been changed to 2.5GT/s which is what the qui=
rk=20
> > does before calling retraining, LT too should work "normally" after tha=
t.
>=20
>  We don't know if the link is going to become stable with the TLS update=
=20
> to 2.5GT/s and we want to ensure that the link has reached the active=20
> state before claiming victory; LT clear does not mean the link is active,=
=20
> it only means what it means, that is that the link isn't being trained at=
=20
> the moment.

LT clear means retraining has ended which is the condition=20
pcie_retrain_link() should terminate at. It tried and finished retraining=
=20
as proven by LT clear.

>  Also we don't want to reset the TLS to the maximum before the link has=
=20
> become active.

I'm not suggesting to change the if DLLLA check that is within the quirk=20
so it will remain the same even if pcie_retrain_link() would no longer=20
have the use_lt parameter.

If LT clear after retraining does not imply DLLLA set, then this again=20
falls into the quirk territory and IMO the quirk itself should be what=20
makes the additional call to wait for DLLLA, not pcie_retrain_link().
I suspect though that DL clear does imply DLLLA set (after the target=20
speed was lowered) so my expectation is that the extra wait wouldn't be=20
necessary at that point.

>  Does this answer your question?

What I'm trying to achieve is having pcie_retrain_link() focus on=20
retraining and quirk on steps required by the quirk. Currently they're=20
kind of mixed if we assume the assumption that LT clear doesn't imply=20
active link is true. That tells quirk would need additional step,=20
that is, wait for DLLLA after the retraining has completed which is=20
currently hidden into pcie_retrain_link() rather than explicitly=20
called by the quirk.

--=20
 i.

--8323328-1935341792-1710496711=:1018--

