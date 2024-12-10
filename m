Return-Path: <linux-pci+bounces-18042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51929EB931
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 19:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B9A1889C9A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 18:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1A81A01B0;
	Tue, 10 Dec 2024 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fN47Kc/h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EC723ED59;
	Tue, 10 Dec 2024 18:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733854783; cv=none; b=L6rdmt9y9lw6syIqpPS/KXmn3TKoyPpCHUUdm0hsW+HnyfALwR8b/N5sepI5StNDpJOE4Py4R+kBWKIOXffei46Snf7IJgUdvEQm59ZKkWaLTd8ASD5B3DkKloJCZN/5lg4yNouPslSShBRVW9r+erI0FKCnrFfysU0v2N8abq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733854783; c=relaxed/simple;
	bh=bOl88BIrBVQcyS4UvrQpTwuyM5PF7qtNXyWSrImey1s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=F4DMPa4IO5GDMfJiXmfZ+iWhLajclA8G0rf4V4ehkSvCkstZgellNe/tIieEb2ON1yhYHD82hcmQpnMIowChze+4OB1TQEV1L7srTwbwehn9+ZFHsIK/mVX4YzvXmuK4PIODqokjU6XbRqZB5yY2fn/D2taCHAMsi+GOZ6isbvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fN47Kc/h; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733854782; x=1765390782;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bOl88BIrBVQcyS4UvrQpTwuyM5PF7qtNXyWSrImey1s=;
  b=fN47Kc/hybgERyI6vFVhrDCKPyi8u87yHVYF8slGlLNgoy1tb+NGdNeF
   E8B8YbvoDxOeoAM5tlsx1otADXKHuOlt+me11dB3DiZvEKTJcJG7tBdvk
   D2tYzz9LP72xLGkfVA0WWTvzGDaWcSEVK+5s0/Y5apd5a1kn9L654eQyY
   dXHpRz/xz7EOmCwPPP695KYJ0BlRrLyM0W0PQX2SNZqn89QbNjfTMa3Sb
   vL/e1GBcepBmh4qn/ODXyFwyLLnWJahmWgnosdunvfIAr8W+8FNXmsK2A
   BZsBzkjcIwOZ6rEdJ8qfXzbXF+yFM89wgW7BuGL+DjAGPjXsx6qoTbtPe
   g==;
X-CSE-ConnectionGUID: rS77Tem4Skudzdg9/9bzjA==
X-CSE-MsgGUID: 9qtFp5zJTlaNOZSwF/y+tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="51626751"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="51626751"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 10:19:42 -0800
X-CSE-ConnectionGUID: V8DJcyq5QXmnIWhcgVU0TA==
X-CSE-MsgGUID: M4jpkmM9QUmVBhSJX0WQWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="99986249"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 10:19:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 10 Dec 2024 20:19:36 +0200 (EET)
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Lukas Wunner <lukas@wunner.de>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v6 0/8] PCI: Consolidate TLP Log reading and printing
In-Reply-To: <cb44bafe-a7ec-889b-5c1c-ee8ca6c540a0@linux.intel.com>
Message-ID: <38a03e53-789e-363a-c336-dc939161d7d7@linux.intel.com>
References: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com> <cb44bafe-a7ec-889b-5c1c-ee8ca6c540a0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1421109454-1733854776=:905"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1421109454-1733854776=:905
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 23 Oct 2024, Ilpo J=E4rvinen wrote:

> On Fri, 13 Sep 2024, Ilpo J=E4rvinen wrote:
>=20
> > This series has the remaining patches of the AER & DPC TLP Log handling
> > consolidation and now includes a few minor improvements to the earlier
> > accepted TLP Logging code.
> >=20
> > v6:
> > - Preserve "AER:"/"DPC:" prefix on the printed TLP line
> > - New patch to add "AER:" also  on other lines of the AER error dump
>=20
> Hi Bjorn,
>=20
> A small reminder this series exists.

Another reminder about this series. :-)

--=20
 i.

--8323328-1421109454-1733854776=:905--

