Return-Path: <linux-pci+bounces-6866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EC98B7369
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 13:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91C7AB21DFA
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 11:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1700212D1F1;
	Tue, 30 Apr 2024 11:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKIn5fwu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FBD17592
	for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2024 11:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475923; cv=none; b=UxkRSkh6q2oqBVSkqGJR0Qa4p5Ws9uyvUP1ridepr+AmocLgHMS5hegjPT5NvBilRSFALUi9NPX+vlbO76G52J0kA5YFSi8k1GNkCkq+oEAalmt7QWwrlG9WgSDrNOeiiZqjFiLtyh7GK7aBnmPWX3F2YOsPibI4GdgfySiqSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475923; c=relaxed/simple;
	bh=f2jgz72JRSL8OrvQF2nzt/ULkzjY60b6oo6OXtUMqns=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=O71wv1M1MegwKp6OFUZxNoIRxLNVmtTuZCAUqP3MnEwDeGy/ZNEuQhgmSHG4V3/pG6JQ+EmpGez4+/TNDlk9nCWN1EyXTTDFYrslhpx0MIzzru4CvCIbpN2jwl/g7bVz5kjBCjsdWP2/yvOt98p4C1AVnI4SDNsQo0VINpl5ZDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKIn5fwu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714475921; x=1746011921;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=f2jgz72JRSL8OrvQF2nzt/ULkzjY60b6oo6OXtUMqns=;
  b=lKIn5fwuf+MM5/b2WEyQ+Dv+3im+VfliI8a50eRiMvSheQ3QS47BZQne
   C2dVAhDbrvfBa1vDfup2J17/ol73AgSSjjboQceBP2C/jCVkhdcdu3yQQ
   xLXTY/YFGriZLsIRGS37BLI0fJ6/LtnitsHtPzPZNDiS8XYLR5dB43z9u
   TIMGUjRCPaTP+uQGi3wFKo5waoVwZ4bScNHy3diVtP80o0SfAoGG4bCfa
   hVI4RzMXYZmCwGMUMRLhQ1NLhULWfqv8zmvkZHEckqZHqsGB5+USgrIyo
   joseEatZRM1p3jJVbL/yUpRN33PMleR0XzaqNbr+Lp9y4v0iK3mdYsep4
   g==;
X-CSE-ConnectionGUID: o3jceJIlQpaFoa3LbYzonA==
X-CSE-MsgGUID: ftscffN3S6qRsqUIzaAFqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10338705"
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="10338705"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 04:18:40 -0700
X-CSE-ConnectionGUID: 0M9N/YXjRlyxgSdNaPI9OQ==
X-CSE-MsgGUID: fIdQGQEuQk+bDfiChGKOsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,242,1708416000"; 
   d="scan'208";a="27045120"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.49])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 04:18:38 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 30 Apr 2024 14:18:32 +0300 (EEST)
To: =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH 00/10] PCI: Add generic Conf Type 0/1 helpers
In-Reply-To: <20240429182325.r2ppmwbiy6zvtwsl@pali>
Message-ID: <864fb6d7-ba56-bb3a-1e2c-3083e66db735@linux.intel.com>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com> <20240429182325.r2ppmwbiy6zvtwsl@pali>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1996310878-1714475731=:1349"
Content-ID: <f8fa5a69-ca01-ab51-5162-280bb8e445d7@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1996310878-1714475731=:1349
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <10755af6-e212-2ba1-a38a-eb37564b6c4e@linux.intel.com>

On Mon, 29 Apr 2024, Pali Roh=E1r wrote:

> On Monday 29 April 2024 13:46:23 Ilpo J=E4rvinen wrote:
> > This series replaces PCI_CONF1{,_EXT}_ADDRESS() with more generic
> > helpers and makes them more widely available by placing the new helpers
> > into include/linux/pci.h.
>=20
> There was a request to move these macros from include/linux/pci.h file
> to the driver/pci/pci.h file...
>=20
> https://lore.kernel.org/linux-pci/20220913211143.GA624473@bhelgaas/
>=20
> Something was changed that it has to be moved back?

I wasn't aware of this thread.

I'm actually a bit surprised by that suggestion because of the abundance=20
of arch/ examples but maybe this too boils down to the configuration=20
mechanism vs configuration commands thing.

--=20
 i.
--8323328-1996310878-1714475731=:1349--

