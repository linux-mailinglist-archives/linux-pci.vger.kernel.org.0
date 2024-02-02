Return-Path: <linux-pci+bounces-3023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505378471F1
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 15:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF052B22BB8
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 14:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBE720DE7;
	Fri,  2 Feb 2024 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5AguqSU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F0E1798F;
	Fri,  2 Feb 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884318; cv=none; b=pxhrTL7FMh7FsaoeiKbfG/BGHWHotOe///xMRNZwmp9lp5d9wuRFkD9FuYon4V9VIT70eg2b0Kbmolwete28GhNFERzYnRInGpBeIkY8moH4DX5tO36203d+akfHpAvaHw0zqa76xN2yEI2lgbc8XD9KcfHt/R3HKvRAFiiJDxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884318; c=relaxed/simple;
	bh=z6F1Vqx6GtWdDy310WShoLrVHNDidoWv2Wvi/+HfaQc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r+z8R2zyS7sMHqvMq85H+VFvkwzVxm1q8dbbxBv7VbiJgnjxM7F31LzcwaYtwn/zaT0v2D6ME5NZrR5Cfxufjv1MNIoaBEcmhva9KF7ZvPz6a3caxyBJ68cCVOaTQxxECOAsWACRmAXIppgN9NpDtCDm0WQjrEdpri2x/TxtDF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5AguqSU; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706884317; x=1738420317;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=z6F1Vqx6GtWdDy310WShoLrVHNDidoWv2Wvi/+HfaQc=;
  b=T5AguqSUE35gqnSYhA30rq/0VIHybQscSkzgdPREVZlGzL8RLYdyYlpB
   E0qPD+6qr+sNm1EE109n1GB46OWCc3MmU8Re2EZIwfu/ATh6M2X+on6se
   EpgEj01ZAMBIxZPMtCrWvWmj561g8XSw0fY5osmYx/lfDBDbR+fUZThzD
   iYhack2+yk9Q5L0oc1cBSz2PYEdz3vPXduUD3lV8z2qiEya7XTiLcboSU
   eP5nBC2fAKIZnegSVAd8+ZERXauPYpvrJxKKK2x24Q4y00dUXbdUq5mC8
   Hb4lmhuM69PAddqWP9DsAu+FZqoarEmyv1w2T/NJXctGCEN7YFxERZ03h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="394600759"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="394600759"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 06:31:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="393298"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.66])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 06:31:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 2 Feb 2024 16:31:49 +0200 (EET)
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/1] PCI: Cleanup link activation wait logic
In-Reply-To: <alpine.DEB.2.21.2402021359450.15781@angie.orcam.me.uk>
Message-ID: <a0e8ae37-cc11-2219-201e-d6740028b735@linux.intel.com>
References: <20240202134108.4096-1-ilpo.jarvinen@linux.intel.com> <alpine.DEB.2.21.2402021359450.15781@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-687759446-1706884309=:1020"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-687759446-1706884309=:1020
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 2 Feb 2024, Maciej W. Rozycki wrote:

> On Fri, 2 Feb 2024, Ilpo J=C3=A4rvinen wrote:
>=20
> > 1. Change pcie_failed_link_retrain() to return true only if link was
> >    retrained successfully due to the Target Speed quirk. If there is no
> >    LBMS set, return false instead of true because no retraining was
> >    even attempted. This seems correct considering expectations of both
> >    callers of pcie_failed_link_retrain().
>=20
>  You change the logic here in that the second conditional isn't run if th=
e=20
> first has not.  This is wrong, unclamping is not supposed to rely on LBMS=
=2E=20
> It is supposed to be always run and any failure has to be reported too, a=
s=20
> a retraining error.  I'll send an update according to what I have outline=
d=20
> before then, with some testing done first.

Oh I see now, I'm sorry, I didn't read all the way to the last paragraph=20
of the commit message because the earlier one in the commit message hinted=
=20
the restriction is removed afterwards so I thought it was only linked to=20
the first part of the quirk.

> > 2. Handle link-was-not-retrained-successfully return (false) from
> >    pcie_failed_link_retrain() properly in pcie_wait_for_link_delay() by
> >    directly returning false.
>=20
>  I think it has to be a separate change, as a fix to what I can see is an=
=20
> issue with a three-way-merge done with commit 1abb47390350 ("Merge branch=
=20
> 'pci/enumeration'"); surely a bool result wasn't supposed to be assigned=
=20
> to an int variable carrying an error code.
>=20
>  Either or both changes may have to be backported independently.

But can it be? Won't the intermediate state cause more breakage? (although=
=20
that obviously can only hit some very unfortunate bisecter so perhaps not=
=20
a big deal because one would need many holes to align, the biggest being=20
the link has to fail training which is rare to begin with).

--=20
 i.

--8323328-687759446-1706884309=:1020--

