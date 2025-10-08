Return-Path: <linux-pci+bounces-37698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5288DBC3C48
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 10:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADCF3B9377
	for <lists+linux-pci@lfdr.de>; Wed,  8 Oct 2025 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3362F2913;
	Wed,  8 Oct 2025 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iGNrkvM/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EC934BA3C
	for <linux-pci@vger.kernel.org>; Wed,  8 Oct 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759911068; cv=none; b=AYLUeiZ/Otbn83cSMn3jX7VldL/LCCk6mtkIChFwrrydbW+U1sJ5YMhO5lGPsUb9WLZOcvyZr4XDY2qTzyEJy8asy3YKCqD0kgBgDT/pecluBaxCMGcdW6pyH/6OK2FY6JYlIYtbNXnr5kwxWEn5lht5Kl4hH5FPfHDyac/jcxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759911068; c=relaxed/simple;
	bh=wgSWMxgdcXqF94FERSmVSkeXxZHnYZPpOoOd/L2IJv8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oWwsFIlMLcn7mJDhhwLLczfM9fnAT1SNtHPht3EciO4WZWQgNv912+NQiIqzhwsbthsKjxJAylgPqj5KNKwYtjyHN0tBSUTA3wAKOYW66i1wiZT/0nHCwpHiJWxgwPpMHf8GnssiIcTHBkBqF7sFZoo376Men5cZbrrW0pF08sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iGNrkvM/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759911066; x=1791447066;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wgSWMxgdcXqF94FERSmVSkeXxZHnYZPpOoOd/L2IJv8=;
  b=iGNrkvM/stXmrpVQpW8rXLEdOlyTuNeMHvBYSlWE9yTlQ5gIjrpLeKAy
   WBg0KGwUQ46BePOAUcot0gYMRpaUl2Ni1ciV9q/SvCLsu5FikIYv183Wu
   FzwR2mTC3oPTKx4mqiFuzFsMEDGtzln856/iA+zeEY4fmX7FKpJCJkUhW
   xDnNfF74TQvfbTC2ZBeMADIMkGPNXA6tZ0VCNZgtlVODGXJ67VJb+c2EQ
   HwVhiLZ94LuktuSGzN68KMGGYSa/H9cxKNrpasd08o/FpnDsRnkexmmJW
   QrQU7l8WcYNb+2ZAeIuezJ1PfR0jrEWftDZBw20Udd+GHVroCwbTQyOT/
   g==;
X-CSE-ConnectionGUID: ZEPIMwQ2R+y5z5cZKCt/1Q==
X-CSE-MsgGUID: L42NEOgfQVi075mr7tmvrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65924765"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65924765"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 01:11:04 -0700
X-CSE-ConnectionGUID: XIm9JdxISeip0pnvWC8E7A==
X-CSE-MsgGUID: 9agu5EsiSESJGIZvXHFluA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,323,1751266800"; 
   d="scan'208";a="180207814"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.117])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 01:11:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 8 Oct 2025 11:10:59 +0300 (EEST)
To: Kenneth Crudup <kenny@panix.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: Commit 4292a1e45fd4 ("PCI: Refactor distributing available memory
 to use loops") gives errors enumerating TBolt devices behind my TB dock
In-Reply-To: <dd551b81-9e81-480b-aab3-7cf8b8bbc1d0@panix.com>
Message-ID: <d314cdfd-372c-62ff-4304-70c27b489e9a@linux.intel.com>
References: <dd551b81-9e81-480b-aab3-7cf8b8bbc1d0@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 7 Oct 2025, Kenneth Crudup wrote:

> I'm running Linus' master (as of a8cdf51cda30).
> 
> I have a Thunderbolt dock (Amazon Basics generic thing, but it also happens on
> my CalDigit TB4). With the above commit (and aaae2863e731 ("PCI: Refactor
> remove_dev_resources() to use pbus_select_window()), so the Subject: commit
> would come out cleanly) if I plug in a TB device past my TB Dock, they don't
> fully enumerate (i.e., no DP tunneling, no partitions created, etc.)
> 
> I've attached the syslog from both bad runs, and good runs (i.e., after the
> reverts).
> 
> LMK if you need any further info,

Hi,

Thanks for the report.

Could you test if this patch helps:

https://lore.kernel.org/linux-pci/eb70b817-175c-7a34-d2bf-9472019afa47@linux.intel.com/

(I'm not sure if it's the same problem as these snippet around the problem 
spot seem to only show symptoms of an earlier problem which is not 
visible in those logs.)

If it doesn't help, I need more information:

- /proc/iomem

- dmesg that contains all PCI related messages, not just a snippet around 
the problem spot. Please enable dynamic debugging with
  dyndbg="file drivers/pci/*.c +p"
on the kernel command line so that the dmesg shows more information.

- lspci -vvv might be useful as well but often /proc/iomem is enough.

Preferrable from both good and bad cases so that it's easier to compare 
them efficiently.

-- 
 i.


