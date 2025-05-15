Return-Path: <linux-pci+bounces-27786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A0BAB8655
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 14:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42693A2DF3
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 12:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CC5227BA2;
	Thu, 15 May 2025 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WCwb5CRf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CAC2253B5;
	Thu, 15 May 2025 12:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311706; cv=none; b=k6tiITZi6sYl6wo+gpc6M+idezYCahGh3ndH3UbUlGgc/3jOwNCbyfoNqyxHaX4Zt1N5GVecB0w6jYJxQcR+RKjszRaikW5zFYvYftarerTqcbLu9xVPYDj6T4cmSMqiSRUArvKizSlui3NEFdPURYam0XUHX0GhxwRFTZizo4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311706; c=relaxed/simple;
	bh=H5OUDY4VUdGZ+JC9sKFI1wmGIEcMLTNEvBIbA1UBAV8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jxmNKiwnALfFI6xF/amz3v0gvBPlXXMaSCSIYKggJHGiTsj+g0ls1tf9gU6OMEwG2y2BAebi9qlGr+xpN7UFLCpRFQqbx43+GFftmL6sqKoQcgaFJFuo3o1iC7c5Yp4k8BMuzrAlOBNi4vNvfwv7hzy9456q1gHzLjV4+eVHiGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WCwb5CRf; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747311704; x=1778847704;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=H5OUDY4VUdGZ+JC9sKFI1wmGIEcMLTNEvBIbA1UBAV8=;
  b=WCwb5CRfHk4kYEutc/ZArfViw93AdppDmXE/UcNEAdOydhma0NlzrLim
   2TXYdtTDpO2o4UKy2EKNmZOJ63Bk12/lVv5xZKnW9RPjYRetbyivYTEwR
   DsJGFABJ7bxn88BecTpSUdhcbaQJ82Q7VCotN2vNnDtIhAJu55aneBx3u
   2Z+/Ve5fLKmiM/7RN9/jtogxlTHYnnDk9ZlYpt0Geg8fVq0geiqWdTtI/
   oocVV+J1MevPEFtcOzznddMRKSkzzmLwICsegOgsR1ilpQbcYJIVEzeir
   zlAXqYWxpTDNyaaReZx8jss5hnMMig1O7lZEJoAxWw5ck0oNobCVyY9Gf
   w==;
X-CSE-ConnectionGUID: VGsph2AFRUOF45G3S1f6Kw==
X-CSE-MsgGUID: jOPnrJYSQ9OLILEdKgn3Uw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="66648996"
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="66648996"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 05:21:44 -0700
X-CSE-ConnectionGUID: jwl3g36KT8mu57b9DLQk9g==
X-CSE-MsgGUID: DBnZdkS3R+6ikPr8oO/BXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,291,1739865600"; 
   d="scan'208";a="138218107"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 05:21:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 15 May 2025 15:21:39 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>
cc: Krzysztof Wilczy??ski <kwilczynski@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    "Paul E. McKenney" <paulmck@kernel.org>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] PCI/bwctrl: Remove also pcie_bwctrl_lbms_rwsem
In-Reply-To: <aCXZdfOA8bme-qra@wunner.de>
Message-ID: <98fa31e7-db86-35f0-a71c-a1ebf27f93f0@linux.intel.com>
References: <20250508090036.1528-1-ilpo.jarvinen@linux.intel.com> <174724335628.23991.985637450230528945.b4-ty@kernel.org> <aCTyFtJJcgorjzDv@wunner.de> <20250515084346.GA51912@rocinante> <aCXZdfOA8bme-qra@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-897030319-1747311132=:1298"
Content-ID: <47489e41-ed37-3c1f-1e17-a553084d6fa9@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-897030319-1747311132=:1298
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <386129cc-51a7-2100-9e0c-9f28fd6cea44@linux.intel.com>

On Thu, 15 May 2025, Lukas Wunner wrote:

> On Thu, May 15, 2025 at 05:43:46PM +0900, Krzysztof Wilczy??ski wrote:
> > Done.  Squashed with the first commit from Ilpo, see:

Thanks Krzysztof for handling this, I should have put the note about=20
squashing it to the resubmission but I forgot (this time I didn't do=20
the diff against the previous version before sending it which I normally=20
do).

> >   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=
=3Dbwctrl&id=3D2389d8dc38fee18176c49e9c4804f5ecc55807fa
>=20
> Awesome, thank you!
>=20
> > Let me know if there is anything else needed.
>=20
> Actually, two small things:
>=20
> - That patch on the pci/bwctrl topic branch is still marked "New"
>   in patchwork, even though it's been applied:
>   https://patchwork.kernel.org/project/linux-pci/patch/20250422115548.148=
3-1-ilpo.jarvinen@linux.intel.com/
>=20
> - Version 1 of the same patch is likewise marked "New", even though
>   it's been superseded:
>   https://patchwork.kernel.org/project/linux-pci/patch/20250417124633.114=
70-1-ilpo.jarvinen@linux.intel.com/
>=20
> Unfortunately I can't update it myself because I'm not the submitter.
> (Ilpo could do it if he has a patchwork.kernel.org account.)

I'm a pdx86 maintainer so I do have an account, yes. I actually had the=20
patchwork page listing my PCI patches already open, but I just hadn't hit=
=20
"update" button yet.

I've done those two changes now.

I'm a bit hesitant to mark "Accepted" state though, I did it this time=20
but in general I feel I might be overstepping my authority even if I know=
=20
some patches have been accepted.

> Something unrelated (only if you feel like doing it):
>=20
> On the pci/enumeration branch, Bjorn queued up a revert which was
> waiting to be ack'ed by AMD IOMMU maintainers:
> https://lore.kernel.org/r/20250425163259.GA546441@bhelgaas/
>=20
> In the meantime the ack has arrived:
> https://lore.kernel.org/r/aCLv7cN_s1Z4abEl@8bytes.org/
>=20
> So the remaining housekeeping items are:
>=20
> - Add J=F6rg's Acked-by to commit e86c7278eba8 on pci/enumeration
> - Remove the "XXX" marker from the subject line
> - Remove "Needs AMD IOMMU ack" from the commit message
>=20
> Again, only if you feel like doing it.  No urgency.


--=20
 i.
--8323328-897030319-1747311132=:1298--

