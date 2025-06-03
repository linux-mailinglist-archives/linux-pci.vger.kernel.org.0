Return-Path: <linux-pci+bounces-28863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE773ACC96C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 16:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A885716D25E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F29239561;
	Tue,  3 Jun 2025 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cr/R559a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D687E17A2EA;
	Tue,  3 Jun 2025 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748961817; cv=none; b=MkKOn5/pN0m/EjUIhM1J//3eDVi93LS7WraDIDJi5M/qYLljG0QbU7rEky1Ez9sxA7LhFhii/JiwJtvRjOHhKM0QLw97BLoxZqtdSIBXSxah1ZZ86da+lqQQG2P4YY5ElMi1m9wEA8aGopMB1f/Qpk6V8mwEt7B9hSnhdFVCHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748961817; c=relaxed/simple;
	bh=z2Ey+9eAkrxDyJHcYoeI+VcGZ12BalGXWl8qfdHCsBg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ma5/xw9+ukne1ZET7/MFcNI/QsTngdpaDwtBUpOLb0Ir55UgbdEUNCDOYhZgns1YlN+hq0bjIwAc37gFJomrMCUYWA2ZAzTfY+pfhOQlGBljarE9fg8DnnBxSC4Pn0m/5qR4AGcydJ0mNb1UNM7J14PunMskZgJW9XFmv354IuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cr/R559a; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748961816; x=1780497816;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=z2Ey+9eAkrxDyJHcYoeI+VcGZ12BalGXWl8qfdHCsBg=;
  b=Cr/R559aKBXNvhsI/UE0N6qWz5UjK7s3owxfcTWJ/q+WMOZXs4/ZSZ6L
   X2o3eF91crySmLb4yu51Wgt33iA7K+wrSse1OZgAPDbzt0R9Aq0abF+Am
   2K7YCrpEhjNtNFtB/DPlxTUERztzkEM5U1QM+5YGlKba5z1O3FBuA6UsO
   2uemE7917xy/O3v28EmY/FVE/P3o7EsaAtcVBf/eXcZcuB9pktOlC8HfH
   zuqx+zzKQI4K0UsMbybr7Yl1wac+nXKWifNld/e4hqHhq8x4E97fE/zP/
   NSr2Rwpmeiir4ORyd4K9QdVnKsm9ek3QPgCpAlYvxcXw9deyf0oAwph0c
   g==;
X-CSE-ConnectionGUID: X7OCtacMRMybL+VZt2lRWA==
X-CSE-MsgGUID: jOmHPviIQHa3qhAedUUIUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="61626356"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="61626356"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 07:43:14 -0700
X-CSE-ConnectionGUID: TA6fL8yGTyauOPwLCs93aA==
X-CSE-MsgGUID: pOTNvgFKSNW+O4/B1v8E2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="145373523"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.141])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 07:43:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Jun 2025 17:43:02 +0300 (EEST)
To: Tudor Ambarus <tudor.ambarus@linaro.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    William McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <e0833d0d-cf1c-b036-c9f4-d27b933330f0@linux.intel.com>
Message-ID: <765f092e-10e9-6ac0-5aa4-964cdf3e60ad@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com> <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com> <5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org> <8f281667-b4ef-9385-868f-93893b9d6611@linux.intel.com> <3a47fc82-dc21-46c3-873d-68e713304af3@linaro.org>
 <f6ee05f7-174b-76d4-3dbe-12473f676e4d@linux.intel.com> <867e47dc-9454-c00f-6d80-9718e5705480@linux.intel.com> <a56284a4-755d-4eb4-ba77-9ea30e18d08f@linaro.org> <7e882cfb-a35a-bab0-c333-76a4e79243b6@linux.intel.com> <f2d149c6-41a4-4a9a-9739-1ea1c4b06f4b@linaro.org>
 <19ccc09c-1d6b-930e-6ed6-398b34020ca1@linux.intel.com> <c1c0bacd-7842-4e9e-aec4-66eb481aa43f@linaro.org> <f8f15489-8b31-4672-9fb9-161c7c4599dc@linaro.org> <a4a5855c-6d58-4fc5-85d7-4727d27efbe0@linaro.org>
 <e0833d0d-cf1c-b036-c9f4-d27b933330f0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1106287541-1748961782=:937"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1106287541-1748961782=:937
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 3 Jun 2025, Ilpo J=E4rvinen wrote:

> On Tue, 3 Jun 2025, Tudor Ambarus wrote:
> > On 6/3/25 11:48 AM, Tudor Ambarus wrote:
> > > On 6/3/25 11:36 AM, Tudor Ambarus wrote:
> > >> On 6/3/25 9:13 AM, Ilpo J=E4rvinen wrote:
> > >>> So please test if this patch solves your problem:
> > >>
> > >> It fails in a different way, the bridge window resource never gets
> > >> assigned with the proposed patch.
> > >>
> > >> With the patch applied: https://termbin.com/h3w0
> > >=20
> > > above is no revert and with the proposed fix. It also contains the
> > > prints https://termbin.com/g4zn
> > >=20
> > > It seems the prints in pbus_size_mem are not longer hit, likely becau=
se
> > > of the new condition added: ``!pdev_resources_assignable(dev) ||``,
> > > pci_dev_for_each_resource() finishes without doing anything.
> > >=20
> > >> With the blamed commit reverted: https://termbin.com/3rh6
> > >=20
> >=20
> > I think I found the inconsistency.
> >=20
> > __pci_bus_assign_resources()
> > =09pbus_assign_resources_sorted()
> > =09=09pdev_sort_resources(dev, &head);
> >=20
> > But pdev_sort_resources() is called with a newly LIST_HEAD(head), not
> > with realloc_head, thus the resources never get sorted.
>=20
> pdev_sort_resources() is not supposed to add resources into realloc_head=
=20
> but just collects all the relevant resources in the descending order by
> size.

Small correction, they're ordered by alignment, not by size. For other=20
than iov resources and bridge window, alignment order effectively the same=
=20
as size order.

> There are two main lists here. The head list contains all relevant=20
> resources we're going to process and realloc_head keeps track which of=20
> them are optional (or optional in part, that is, some resources have the=
=20
> base size and the optional size).
>=20
> __assign_resources_sorted() will apply the optional sizes from=20
> realloc_head and re-sorts the head list while changing the sizes.
> If not all resources can be assigned, rollback happens and base sizes are=
=20
> assigned first, and then reassign_resources_sorted() handles the=20
> realloc_head ones afterwards for as many resources as possible.
>=20
> > pdev_sort_resources() exits early at
> > =09``if (!pdev_resources_assignable(dev))``
>=20
> Yes it does, for 0001:01:00.0.
>=20
>=20

--=20
 i.

--8323328-1106287541-1748961782=:937--

