Return-Path: <linux-pci+bounces-28862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE15FACC905
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 16:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7C03A7A3B
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A228C22A7E0;
	Tue,  3 Jun 2025 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U5thkw33"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5B116F265;
	Tue,  3 Jun 2025 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748960593; cv=none; b=JDcENl7rU9oissRLnDGsjRXKlmbqcYXBGutpYu7YGhqwldPYOZ+HkEiRsOwhJRUrnwxhDch7os8mhkhJguFMpgwQJuHSYrnQf/XOeW6vqYZEEjc4k5I5BnZVR6m9PcUAHWNv/nqa8Jsww5crTVCnghSReZPIj8QboFZoyrgsMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748960593; c=relaxed/simple;
	bh=NlWl7a3wFvZKvfFyfM6OWivl5MZ1iDz04JjQdHs6kQ0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bg0/dZHlKHLFYOFSQFiylES90VNAoVlDDPprBbw0f9AOqmBNePWWVDPV772oSvvQ57x4Ox3FaDkOYT5iNdyp120B1AmpGQWA+kVk+V3+EKQizrclxMl0SCM6yygKIUkUVXToxAFrzphlTHyYvk2BIOL3pxfdvV2q+KT6edtwWT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U5thkw33; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748960592; x=1780496592;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=NlWl7a3wFvZKvfFyfM6OWivl5MZ1iDz04JjQdHs6kQ0=;
  b=U5thkw33EsQ/WLnjD3DYmHlkAXUApYjM+ccFgp6Qz3kFLaiJr4KRimCz
   nnh3r/G3QRftEwZl38EOjqyjBfHekDaGA0ki4h3ccsr6Ovk3PG+3DxzNf
   PFHxHi4gVxK7sLGQ3UfgCy9b2zcjWMkjGp2m9nkrGsZVtSIYUMRl25ren
   OM9CAuCY9iZv3ilaL15gfRoEuRfXL4t+qyZKAJWE7/tEbU6gEa6RFIyUE
   x68R7YMhBEfqSnGWo1P/TQl/pltiyFAbHcoVQrVNTyedgz8kiR/HPgQM+
   Z9BgciOUduuPUs7Vv5VfetcvNGj2kO4w9M5esnM8LXUQS1IRXzBzlSNMZ
   A==;
X-CSE-ConnectionGUID: 31D6/OZqQ9uuc5G2Z4uSsw==
X-CSE-MsgGUID: KXu8NOYtS9WYa6TOudcnCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="54662928"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="54662928"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 07:23:11 -0700
X-CSE-ConnectionGUID: Jr+EHcFaRsyguEqjY01W/Q==
X-CSE-MsgGUID: gjiUFl1USyCleeRHXFixzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; 
   d="scan'208";a="145836666"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.141])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 07:23:07 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Jun 2025 17:23:04 +0300 (EEST)
To: Tudor Ambarus <tudor.ambarus@linaro.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    William McVicker <willmcvicker@google.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
In-Reply-To: <a4a5855c-6d58-4fc5-85d7-4727d27efbe0@linaro.org>
Message-ID: <e0833d0d-cf1c-b036-c9f4-d27b933330f0@linux.intel.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com> <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com> <5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org> <8f281667-b4ef-9385-868f-93893b9d6611@linux.intel.com> <3a47fc82-dc21-46c3-873d-68e713304af3@linaro.org>
 <f6ee05f7-174b-76d4-3dbe-12473f676e4d@linux.intel.com> <867e47dc-9454-c00f-6d80-9718e5705480@linux.intel.com> <a56284a4-755d-4eb4-ba77-9ea30e18d08f@linaro.org> <7e882cfb-a35a-bab0-c333-76a4e79243b6@linux.intel.com> <f2d149c6-41a4-4a9a-9739-1ea1c4b06f4b@linaro.org>
 <19ccc09c-1d6b-930e-6ed6-398b34020ca1@linux.intel.com> <c1c0bacd-7842-4e9e-aec4-66eb481aa43f@linaro.org> <f8f15489-8b31-4672-9fb9-161c7c4599dc@linaro.org> <a4a5855c-6d58-4fc5-85d7-4727d27efbe0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-643506472-1748960221=:937"
Content-ID: <9240f5a8-bfe9-8fb6-c912-f3d6e2108718@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-643506472-1748960221=:937
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <d97beb54-0e1e-84fe-90fe-278100d12192@linux.intel.com>

On Tue, 3 Jun 2025, Tudor Ambarus wrote:
> On 6/3/25 11:48 AM, Tudor Ambarus wrote:
> > On 6/3/25 11:36 AM, Tudor Ambarus wrote:
> >> On 6/3/25 9:13 AM, Ilpo J=E4rvinen wrote:
> >>> So please test if this patch solves your problem:
> >>
> >> It fails in a different way, the bridge window resource never gets
> >> assigned with the proposed patch.
> >>
> >> With the patch applied: https://termbin.com/h3w0
> >=20
> > above is no revert and with the proposed fix. It also contains the
> > prints https://termbin.com/g4zn
> >=20
> > It seems the prints in pbus_size_mem are not longer hit, likely because
> > of the new condition added: ``!pdev_resources_assignable(dev) ||``,
> > pci_dev_for_each_resource() finishes without doing anything.
> >=20
> >> With the blamed commit reverted: https://termbin.com/3rh6
> >=20
>=20
> I think I found the inconsistency.
>=20
> __pci_bus_assign_resources()
> =09pbus_assign_resources_sorted()
> =09=09pdev_sort_resources(dev, &head);
>=20
> But pdev_sort_resources() is called with a newly LIST_HEAD(head), not
> with realloc_head, thus the resources never get sorted.

pdev_sort_resources() is not supposed to add resources into realloc_head=20
but just collects all the relevant resources in the descending order by
size.

There are two main lists here. The head list contains all relevant=20
resources we're going to process and realloc_head keeps track which of=20
them are optional (or optional in part, that is, some resources have the=20
base size and the optional size).

__assign_resources_sorted() will apply the optional sizes from=20
realloc_head and re-sorts the head list while changing the sizes.
If not all resources can be assigned, rollback happens and base sizes are=
=20
assigned first, and then reassign_resources_sorted() handles the=20
realloc_head ones afterwards for as many resources as possible.

> pdev_sort_resources() exits early at
> =09``if (!pdev_resources_assignable(dev))``

Yes it does, for 0001:01:00.0.

--=20
 i.
--8323328-643506472-1748960221=:937--

