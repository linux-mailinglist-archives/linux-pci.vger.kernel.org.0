Return-Path: <linux-pci+bounces-4527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AC48722EE
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 16:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143381C21A76
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195DD86648;
	Tue,  5 Mar 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHUaJC8j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A5885944;
	Tue,  5 Mar 2024 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653080; cv=none; b=SMGFvGB6O11vTqKQz77655xVgon9tJs2nydVZlcv9BNrG8Ol0s2z2DpqFDdFwqgY1uBvPEs/Jxj5xBBPC5on1+607s4QqrDODAGqxLx103aeEVCNj6IS5GYTkMLsUDn+0ZyJcxPI/sFPvcuMn023jZWCthTXD7umheovawVk1d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653080; c=relaxed/simple;
	bh=xwm84H4f4tjwcSxxtvgbASvINMVOSckg9bf0UJkq3EY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kSoTN9nF871z0xC9eqXZRNGusAxV1MKA23Ce8/3482/4DlxTIyM+gZjRIJ4XPxGbFOhSLcsHdqzYFLBeDRkP7EJ9XACUl88kFoAu9+r5+fHi6me85mO2JW+RVKMaBeNLL1pCL4M4rJahLCJNmrwFH1IYX2rQWeVj0VTGaKjk9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHUaJC8j; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709653078; x=1741189078;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=xwm84H4f4tjwcSxxtvgbASvINMVOSckg9bf0UJkq3EY=;
  b=mHUaJC8jd/X65cvPRoO4/q8f56v2rjc0LO9ho0usS0PtDTtK5PVzi0Vl
   k/Ey6JABbhA3uBxmyZgFgypqY8Rt/UX5XuEHP9HxRIvcWilnhAQsHsO19
   bNsbXKmB1CNurqrgH/VhiDRvhSem6avJbg0R5jgxZrN75V1S4aiyZzgCp
   zdxx4qrUiiBlG2cT72zMEXZA8oPZsrGfCYJuVn51XjFEMXou/h79uvpNE
   Oet4+fklPRw4VlZLQIb3W2had6AxXhQquV1hsr7b0kl5NtR26soeNfS+N
   2cglipKrvTSDQgLYs5QoNh3IyrXVD3Hs2CBzOZBQmZ/duNGEdbXhZ3sXW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="21670783"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="21670783"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 07:37:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="40301723"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.51.37])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 07:37:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 5 Mar 2024 17:37:49 +0200 (EET)
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Igor Mammedov <imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] PCI: Solve two bridge window sizing issues
In-Reply-To: <20231222122901.49538-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <cdda64e3-3454-406d-55a2-cf79f7650b45@linux.intel.com>
References: <20231222122901.49538-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1729510199-1709652635=:1003"
Content-ID: <cc693734-3506-af03-e013-e615672682bd@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1729510199-1709652635=:1003
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <c95136c0-b742-0650-6c3d-b4247b7f2e47@linux.intel.com>

On Fri, 22 Dec 2023, Ilpo J=E4rvinen wrote:

> Hi all,
>=20
> Here's a series that contains two fixes to PCI bridge window sizing
> algorithm. Together, they should enable remove & rescan cycle to work
> for a PCI bus that has PCI devices with optional resources and/or
> disparity in BAR sizes.
>=20
> For the second fix, I chose to expose find_empty_resource_slot() from
> kernel/resource.c because it should increase accuracy of the cannot-fit
> decision (currently that function is called find_resource()). In order
> to do that sensibly, a few improvements seemed in order to make its
> interface and name of the function sane before exposing it. Thus, the
> few extra patches on resource side.

Hi Bjorn,

Can you consider applying this series or do you have some comments on it?

I'm a bit unsure these days if my emails even reach you successfully as I=
=20
tend to often receive complaints from Gmail that it has blocked the emails=
=20
I send with git send-email detecting them as "unsolicited mail".

--=20
 i.


> Unfortunately I don't have a reason to suspect these would help with
> the issues related to the currently ongoing resource regression
> thread [1].
>=20
> [1] https://lore.kernel.org/linux-pci/ZXpaNCLiDM+Kv38H@marvin.atrad.com.a=
u/
>=20
> Ilpo J=E4rvinen (7):
>   PCI: Fix resource double counting on remove & rescan
>   resource: Rename find_resource() to find_empty_resource_slot()
>   resource: Document find_empty_resource_slot() and resource_constraint
>   resource: Use typedef for alignf callback
>   resource: Handle simple alignment inside __find_empty_resource_slot()
>   resource: Export find_empty_resource_slot()
>   PCI: Relax bridge window tail sizing rules

--8323328-1729510199-1709652635=:1003--

