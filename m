Return-Path: <linux-pci+bounces-20423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68808A1DDA1
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 21:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B920D3A2F3D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 20:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397BB198E6F;
	Mon, 27 Jan 2025 20:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1iDzKU/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD2019343E
	for <linux-pci@vger.kernel.org>; Mon, 27 Jan 2025 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738011584; cv=none; b=hHn/eiJq21U0odwkB6UjBJgjZHc9EzM+gsTFWveRLTKP0Yun1jZ6Kv/QScKZxCI310UhahLItnsIgfbajPmqvrzsGY7xEX4BYK6vjFZLs01dfu3xMcRZlyZbo1LXXIu651ECehL9bNuXl0k5Kk5DRCQTc9MHTxRq1eWsbDzkiw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738011584; c=relaxed/simple;
	bh=3MJVnD+U17sJCzLHFk+w45NI2rVNIo+llwRfCAOIMsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6tVUW/cw+MXPIi+NGTysdB7E2zzorj4tlB8/+wcKVUIsBgraqLZdO+7rYAVIXVYPr/zFemvoh7SgdKYPJ48Kj5l/rogcROrnsB3q/n893Y7A+f8sCwqmwE5yniqPMtVGp8RZNtO8DdxsrrNTMYP6uIbI07dyOHq3WFamX8j2X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1iDzKU/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738011582; x=1769547582;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3MJVnD+U17sJCzLHFk+w45NI2rVNIo+llwRfCAOIMsA=;
  b=J1iDzKU/4JqpZmsI+K30NwFVnhS7mfT2VcAvA0VzW1Ns+QLk30Di0vwz
   0ryf4lrMX3HdY1xQkYHFU7a5uSdguaZ7XRAuYKyQBQSnpADV+tdo2IZcw
   oJdy42ybmdVtezd7RAQvhvvp65TugzJyeETpxr/FvI5HAD9SUcy7Illv/
   FO7/TdtHQFSNSD9j71ZcH8AjYIxJXDXBiRjr75xB2wY1g6DkVZ/f1qX7Y
   VSuojaBNgGlPa/Yhtbl2+Ka/d9QLzoT1HLhy4MNpZkFTfGeX9FaLDEBsi
   SAekFgmJuRvhqu0OuA/7aXqGJpXxO2A/mpdr9b7cZ53BNY3qDHudAF/bI
   w==;
X-CSE-ConnectionGUID: bWNGTFZJSfKcCOJvRs/CKw==
X-CSE-MsgGUID: DeK2r7MuRJ+EQUip0LLyQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="55915615"
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="55915615"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 12:59:41 -0800
X-CSE-ConnectionGUID: 0e4T5BfxQpSYwFPdzgrekA==
X-CSE-MsgGUID: vYCTvwnuRp+/WbRplbzJVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="108445270"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 12:59:40 -0800
Received: from [10.245.86.111] (sdurawa-mobl2.ger.corp.intel.com [10.245.86.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 1D07D20B5713;
	Mon, 27 Jan 2025 12:59:37 -0800 (PST)
Message-ID: <91b733bf-b133-47f1-9dff-440d75bd6fd4@linux.intel.com>
Date: Mon, 27 Jan 2025 21:59:35 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] VMD add second rootbus support
To: helgaas@kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <dan.j.williams@intel.com>, Lukas Wunner <lukas@wunner.de>,
 linux-pci@vger.kernel.org, Nirmal Patel <nirmal.patel@linux.intel.com>,
 Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
References: <20241122085215.424736-1-szymon.durawa@linux.intel.com>
Content-Language: pl
From: "Durawa, Szymon" <szymon.durawa@linux.intel.com>
In-Reply-To: <20241122085215.424736-1-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/22/2024 9:52 AM, Szymon Durawa wrote:
> This patch series implements second rootbus support inside Intel VMD module.
> Current implementation allows VMD to take ownership of devices only on first
> bus (Rootbus0). Starting from Intel Arrow Lake, VMD exposes second bus
> (Rootbus1) to allow VMD to own devices on this bus as well. VMD MMIO BARs
> (CFGBAR. MEMBAR1 and MEMBAR2) are now shared between Rootbus0 and Rootbus1.
> Reconfiguration of 3 MMIO BARs is required by resizing current MMIO BARs ranges.
> It allows to find/register VMD Rootbus1 and discovers devices or root
> ports under it.
>
> Patches 1 to 6 introduce code refactoring without functional changes.
> Patch 7 implements VMD Rootbus1 support and patch 8 provides workaround for
> rootbus number hardwired to fixed non-zero value. Patch 8 is necessary for
> correct enumeration attached devices under VMD Rootbus1. Without it user cannot
> access those devices as they are not visible in the system, only drives under
> VMD Rootbus0 are available to the user.
>
> Changes from v1:
> - splitting series into more commits, requested by Bjorn
> - adding helper functions, suggested by Bjorn
> - minor typos and unclear wording updated, suggested by Bjorn
>
> Changes from v2:
> - wording update in commit logs, suggested by Bjorn
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: linux-pci@vger.kernel.org
> Suggested-by: Nirmal Patel <nirmal.patel@linux.intel.com>
> Reviewed-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
> Signed-off-by: Szymon Durawa <szymon.durawa@linux.intel.com>
>
> Szymon Durawa (8):
>    PCI: vmd: Add vmd_bus_enumeration()
>    PCI: vmd: Add vmd_configure_cfgbar()
>    PCI: vmd: Add vmd_configure_membar() and
>      vmd_configure_membar1_membar2()
>    PCI: vmd: Add vmd_create_bus()
>    PCI: vmd: Replace hardcoded values with enum and defines
>    PCI: vmd: Convert bus and busn_start to an array
>    PCI: vmd: Add support for second rootbus under VMD
>    PCI: vmd: Add workaround for bus number hardwired to fixed non-zero
>      value
>
>   drivers/pci/controller/vmd.c | 470 +++++++++++++++++++++++++++--------
>   1 file changed, 360 insertions(+), 110 deletions(-)
>   mode change 100644 => 100755 drivers/pci/controller/vmd.c

Hello Bjorn,

Gentle ping. I addressed all of your previous comments, please take a 
look at v3 patch.

Thanks,

Szymon


