Return-Path: <linux-pci+bounces-36176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27804B580C2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 17:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E2273A9D28
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A648C30BF60;
	Mon, 15 Sep 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AxUyv6P4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52B41EA7C9;
	Mon, 15 Sep 2025 15:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949920; cv=none; b=b6gjRj/ZZfOhbyiMClu/5Nv4fwM9+h55QdjBgEhkiZj7aNLbbgpnn2pjl5oPupNWhn+0PGpwtajk8RHkoJA7H8xm2zsiYrFpbXLDM/D+BuHqixmuAV1T2RuIAHhwdQ1VSDUfYMCS6ZZfPwUOXQImdk65SO2qZcQtSrlxNXq5oCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949920; c=relaxed/simple;
	bh=lqzlRfwaJUOAuO1rrEWyHnOChM0Uch2t4oYltMqbmtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnnsM7OHwuosqU7EWMPptOpy09Ja61iiVMPyiQL5qJU21G4DkzSJA6GtGXwbni8wlCNBa7eF+TT2Vomkhd4v2odP1y3dAU2UeIwi8Ca6/htIPo0/w4qHqTTA8aWy72OmjxACzqkv/XCGMYZtmxrN04lqJd6u0+U+oVSXDPPNfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AxUyv6P4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757949919; x=1789485919;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lqzlRfwaJUOAuO1rrEWyHnOChM0Uch2t4oYltMqbmtc=;
  b=AxUyv6P4tICFX85aWefa8XfCe31ltSkOGT5xBB05/jxo4LDQBbe6oHHN
   pOJUutDPQIW5C5wd/qC4BGNQeQ0UWoJ9SBi+7ykB/j8r4CP//OZ4Uf+lI
   SzEoQ3UEgj9VtqslytXlbgSDT1siW/k6Rn7xc9GOihmxEZRLsn3NAZtAw
   W8yWgcdrydXsI5rYRnL3amziNhyw82rLFmjj50L2v5KV1nyayYctJb21Z
   EZ2Rou3wvXUeRRXXAUPxxHTpDlgr/NGBQiHdEFijgiZkxujrXqenoz0sp
   CANatdFN1GrRC1YzKhygPSvxWbu49VqUgFrpopsC75eDm4w0slZiBX/N5
   g==;
X-CSE-ConnectionGUID: o/1hllkdSZa4me3Sow285A==
X-CSE-MsgGUID: OrVEfcI5RmqMZ88OlVZx1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="60353395"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="60353395"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 08:25:18 -0700
X-CSE-ConnectionGUID: cWnfxEnpQLWp0gtBrnX5UA==
X-CSE-MsgGUID: GG7Xy7HEQdiOwhJQpGi/JQ==
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 08:25:17 -0700
Received: from [10.124.221.155] (unknown [10.124.221.155])
	by linux.intel.com (Postfix) with ESMTP id 273DD20B5713;
	Mon, 15 Sep 2025 08:25:16 -0700 (PDT)
Message-ID: <ece967cb-d7fa-4f8b-b6ba-a4192e534936@linux.intel.com>
Date: Mon, 15 Sep 2025 08:25:15 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Documentation: PCI: Update error recovery docs
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Terry Bowman <terry.bowman@amd.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Linas Vepstas <linasvepstas@gmail.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 Brian Norris <briannorris@chromium.org>
References: <cover.1757942121.git.lukas@wunner.de>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <cover.1757942121.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/15/25 6:50 AM, Lukas Wunner wrote:
> Fix deviations between the code and the documentation on
> PCIe Advanced Error Reporting.  Add minor clarifications
> and make a few small cleanups.
>
> Changes v1 -> v2:
> * In all patches, change subject prefix to "Documentation: PCI: ".
> * In patch [3/4], mention s390 alongside powerpc (Niklas).

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Link to v1:
> https://lore.kernel.org/all/cover.1756451884.git.lukas@wunner.de/
>
> Lukas Wunner (4):
>    Documentation: PCI: Sync AER doc with code
>    Documentation: PCI: Sync error recovery doc with code
>    Documentation: PCI: Amend error recovery doc with DPC/AER specifics
>    Documentation: PCI: Tidy error recovery doc's PCIe nomenclature
>
>   Documentation/PCI/pci-error-recovery.rst | 43 ++++++++++---
>   Documentation/PCI/pcieaer-howto.rst      | 81 +++++++++++-------------
>   2 files changed, 72 insertions(+), 52 deletions(-)
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


