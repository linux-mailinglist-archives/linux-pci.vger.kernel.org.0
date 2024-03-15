Return-Path: <linux-pci+bounces-4850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F6A87CB84
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 11:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75773B21B68
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 10:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25C6182D4;
	Fri, 15 Mar 2024 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AI0M9V20"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B05618B14;
	Fri, 15 Mar 2024 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710498835; cv=none; b=fCnNWNBalyteb3xX9He8EiZtAUDT6etkbYZfBtLaxyVtwcdO1YqC+OSV1LcEsYweJU1q+Tr8Fp89XnLnPeveIbbYCYDhaEb3Lmj5Ihi/JyiCeUKvy8oV1L4d9lYW4eYmnBgjYQzPYRjyTt2CYun6iqHhExUy4ybx8LVwg0RB6mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710498835; c=relaxed/simple;
	bh=kcQQZ3fECg6d3AWK40O/TrWoNIgfDzKzhb3Lc7Cdme8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TwTdTVVubU2NqLfRGwLMQlDnq1L6LUPcWqjH7xxaYgRhnGdnSNGRwdmb8y9I83BsMR91ID0G6wNSH10b0pdy1D8sjERcIgwzOTf94GT1bY+Gm26CdJmIOFqU4e13//XrI88QQSPxWNlZi6JX0AxL5xW0hjHi7zy6ooi19DuURMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AI0M9V20; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710498834; x=1742034834;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=kcQQZ3fECg6d3AWK40O/TrWoNIgfDzKzhb3Lc7Cdme8=;
  b=AI0M9V202ELcMmZczi+SY5XXxeiB45KSHCaQSW9O8VGRX+q40i0OPb5K
   qdiF/BAXLOjNYaTb5Hz7UqFLxf9oleecMHbCSNwwNveKPKfz10fUFaiXY
   hzqCYU00S8Ptj+uW19WNy+q2Z/kSstWMgBcSFwM8mmiyL/ceoDBi2Bbk2
   sga4BkEW9wimkw0X9rMcAoB34OW0dlaAPo/rJNNYW4/3hH5cZkqfaxpbA
   piuZOceXV/6A3ftxIeFgD9LDkO/sEjaRhFD/w3vk68nRLyKjhfyxaZF19
   hVf2EpVREi1htAjxYPbbR1L6LQi79HviE4AYhd5wVYaW6XpKClZcusNE2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5568580"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="5568580"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 03:33:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="12666277"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.9])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 03:33:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 15 Mar 2024 12:33:43 +0200 (EET)
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Igor Mammedov <imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] PCI: Solve two bridge window sizing issues
In-Reply-To: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <453df04f-45ee-7619-1731-511b9cac26f4@linux.intel.com>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1175014617-1710498250=:1018"
Content-ID: <2eddac9a-f566-df32-562e-7745a5905cd6@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1175014617-1710498250=:1018
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <e277728e-9d66-fffa-40a7-15cfb1ce21e0@linux.intel.com>

On Thu, 28 Dec 2023, Ilpo J=E4rvinen wrote:

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
>=20
> Unfortunately I don't have a reason to suspect these would help with
> the issues related to the currently ongoing resource regression
> thread [1].
>=20
> [1] https://lore.kernel.org/linux-pci/ZXpaNCLiDM+Kv38H@marvin.atrad.com.a=
u/
>=20
> v2:
> - Add "typedef" to kerneldoc to get correct formatting
> - Use RESOURCE_SIZE_MAX instead of literal
> - Remove unnecessary checks for io{port/mem}_resource
> - Apply a few style tweaks from Andy
>=20
> Ilpo J=E4rvinen (7):
>   PCI: Fix resource double counting on remove & rescan
>   resource: Rename find_resource() to find_empty_resource_slot()
>   resource: Document find_empty_resource_slot() and resource_constraint
>   resource: Use typedef for alignf callback
>   resource: Handle simple alignment inside __find_empty_resource_slot()
>   resource: Export find_empty_resource_slot()
>   PCI: Relax bridge window tail sizing rules

I finally managed to get the group of people who reported this initially=20
here to go and test to confirm these did solve the issues they're seeing,=
=20
so for all the patches:

Tested-by: Lidong Wang <lidong.wang@intel.com>=20

(If needed, I can send v3 with that tag).

--=20
 i.

ps. Bjorn, I realized I pointed you earlier to v1 of this patchset, not=20
this v2 one. I'm sorry about that confusion (it was too far back I didn't=
=20
immediately even remember I did v2).
--8323328-1175014617-1710498250=:1018--

