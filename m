Return-Path: <linux-pci+bounces-34461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E6EB2FDB6
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 17:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFAD3A8560
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 14:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D86C2EDD40;
	Thu, 21 Aug 2025 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JV1cHWwF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3298C281378;
	Thu, 21 Aug 2025 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788298; cv=none; b=nYdUpwK2e5TcGCA+iVpSSbtsRxOGWpMsRYj1CQw5ULrwS6bY5vvslsWdnVouAHS44rKw+Q7XsfnSzSXyKtUZRs5K2X4fyxlCrBEkTDYI1SzD+GqlEvVskK34uQc5MZwOLX8ih0ugqrMBR6oVubXWOIL5f+Ja9Lv1oggnKc3KWOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788298; c=relaxed/simple;
	bh=Z/gzAbasFa+AZqdw/nW3cMEkH5QJ+aFAU3QURDOwygs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sXv9Rp4n3JLCV0XJG55WP2Z5UDsGVnL/23oEkUrtfg/h4tZDEmp1aX8AK9IdtWPD3Fsx1uDtiQ3h3CV2Aj6+apLqMMVq05/x1aX/hrJvxfunacvC6+Cu3Qrt4Ak/sysgTTOi9kfbZIfMALPPGh1Wk89ycYX7U7uP4f78ig5ap0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JV1cHWwF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755788296; x=1787324296;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Z/gzAbasFa+AZqdw/nW3cMEkH5QJ+aFAU3QURDOwygs=;
  b=JV1cHWwFKbXVLY4XNBn4lyn3h8haTpiwQbDmWzW0P0S8CHIw4b4C4esv
   ZSZuJBkY8+JFLdax2lU7ijyGZXUbx4D8OdbzXTQzqnG3GgmRzSr9Cv6lz
   h9y2QmjNmeIZbjI2U03zwuV8BT19YWWDp6LbMjoKWAbng5XS43rCgxYyD
   mAAjc0ygj/xIrAO2PgH9h1+9wNZQ+VCAhgnz5rDiE26kV9SByGqqw6VfE
   lYIhRW1RU8DgSRwMv7m/TjCTU2qSvvK8wJBlejdRhkatiZsxHHt0uHxdR
   fysnu5Y+yZtQL8Z/UsKMP7abbf7i4HsXD+WD1S1s7eT3uelR7GDf+gy94
   g==;
X-CSE-ConnectionGUID: u5lbW/NOSome24tmXVgt5A==
X-CSE-MsgGUID: hztIKp87ScCxykqWzYgocw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58146960"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="58146960"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 07:58:15 -0700
X-CSE-ConnectionGUID: geccJIc2TUaO7Dv/lefTTw==
X-CSE-MsgGUID: EbEvc5V8Ta258Vs0SPQ3ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="199307451"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.192])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 07:58:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 21 Aug 2025 17:58:09 +0300 (EEST)
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Tudor Ambarus <tudor.ambarus@linaro.org>, Rio <rio@r26.me>, 
    D Scott Phillips <scott@os.amperecomputing.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 0/3] PCI: Resource fitting algorith fixes
In-Reply-To: <9d141c1d-9cc0-30b4-e345-b3d458ccb1fc@linux.intel.com>
Message-ID: <971961bd-cc19-1933-5fec-39ab201b88c1@linux.intel.com>
References: <20250630142641.3516-1-ilpo.jarvinen@linux.intel.com> <9d141c1d-9cc0-30b4-e345-b3d458ccb1fc@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2013826386-1755788289=:933"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2013826386-1755788289=:933
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 23 Jul 2025, Ilpo J=C3=A4rvinen wrote:
> On Mon, 30 Jun 2025, Ilpo J=C3=A4rvinen wrote:
>=20
> > This series addresses three issues in the PCI resource fitting and
> > assignment algorithm.
> >=20
> > v2:
> > - Add fix to resize problem (new patch)
> >=20
> > Ilpo J=C3=A4rvinen (3):
> >   PCI: Relaxed tail alignment should never increase min_align
> >   PCI: Fix pdev_resources_assignable() disparity
> >   PCI: Fix failure detection during resource resize
> >=20
> >  drivers/pci/setup-bus.c | 38 ++++++++++++++++++++++++++------------
> >  1 file changed, 26 insertions(+), 12 deletions(-)
>=20
> Hi Bjorn,
>=20
> You might have perhaps forgotten this series that addresses issues people=
=20
> have reported over the last few months.

Hi again,

Another ping.

--=20
 i.

--8323328-2013826386-1755788289=:933--

