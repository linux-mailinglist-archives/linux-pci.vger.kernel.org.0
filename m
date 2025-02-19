Return-Path: <linux-pci+bounces-21855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE10EA3CDEE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 00:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6F63B0C0A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 23:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77E425EF8B;
	Wed, 19 Feb 2025 23:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V6a03BCC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF1A22ACD3;
	Wed, 19 Feb 2025 23:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009209; cv=none; b=LP/5glY7p2EVEWSoQ2oleunEG7HC4KDW6W/ynhcpzHs+swJ5Wn83UzjVEJU47EtyVjgnBsWEwFhYGYVnjR0EsLrtr4ndopl0oVeYev5NoIC4PCbLdtc2yMpFxCpXIWbMMFth6GJJEYnUa3uF2BUWS/SC/yhcyOITdIx0hBVnjQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009209; c=relaxed/simple;
	bh=i0Rp9LuxpN8z5adg/8KRCvBQDnqcW6wz9SN9DFPPd1s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W8HUKpJM3QfnN9UJz77G+SJ7I8ZB4ETav48NwabrmTP5OkmJv+DymfJdDfVJvcBz07AR2oiSa/WOuN3FB+am0rrrHmfHKXgXLe+kyhZACsfHaNgs8AUwbXKtk5fHiDqaIRBy/NJjPftOJceL4KhwIBbaesVHX9TTt7Mdv46Rbo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V6a03BCC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740009208; x=1771545208;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=i0Rp9LuxpN8z5adg/8KRCvBQDnqcW6wz9SN9DFPPd1s=;
  b=V6a03BCCtBlpDsRFf//+BXvdR1ZeZiCj34fJj8XOAuK7W3Vb6MFEkQoD
   R6cakuxd6FjA9HJaqMQepIYz8XEo2/2jQJ9vYK7fxZUYnIfzRq4oEFq24
   gcMZfWArghlu739yhQBaaO0Txv7e7kfvFYDsXA7exux61KgYSrAMOjLfW
   h/azSCZFSZ6oNvFZOFLXOTorx+my1mAF3kcGoG9fBUXqCsFstG4FsNV1N
   ohtX74/YN86sxI/clwxlFUYOk5zRRq9PG5/FclPU9u8QsppBKUQH/95Xy
   q2m7opntxpPFa4AxQiCbqYrcTGrVuQ/3k3OsUTKYrHRMN6G1TY12pciXU
   A==;
X-CSE-ConnectionGUID: mnPfVF5jT8KIsYQESxaCHg==
X-CSE-MsgGUID: Zqwd5fQdQcCGTtrm7lhUpw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="43600402"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="43600402"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:53:27 -0800
X-CSE-ConnectionGUID: Fehi+BFDRUKfPTErQ/RApw==
X-CSE-MsgGUID: VILevhSPQQKs9KucMsEizg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="119806694"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 15:53:26 -0800
Date: Wed, 19 Feb 2025 15:53:25 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
    peter.colberg@altera.com
Subject: Re: [PATCH v7 3/7] arm64: dts: agilex: Fix fixed-clock schema
 warnings
In-Reply-To: <c5755f14-3efd-d4ef-4e34-6446608dedfd@linux.intel.com>
Message-ID: <75f74b7d-659-7c51-9ee5-6cb7b1bafeac@linux.intel.com>
References: <20250215155359.321513-1-matthew.gerlach@linux.intel.com> <20250215155359.321513-4-matthew.gerlach@linux.intel.com> <20250216-astonishing-funky-skylark-c64bba@krzk-bin> <c5755f14-3efd-d4ef-4e34-6446608dedfd@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Tue, 18 Feb 2025, matthew.gerlach@linux.intel.com wrote:

>
>
> On Sun, 16 Feb 2025, Krzysztof Kozlowski wrote:
>
>> On Sat, Feb 15, 2025 at 09:53:55AM -0600, Matthew Gerlach wrote:
>>> All Agilex SoCs have the fixed-clocks defined in socfpga_agilex.dsti,
>> 
>> 
>> That's not what I asked / talked about. If the clocks are in SoC, they
>> cannot be disabled.
>
> There are two clocks, cb_intoosc_hs_div2_clk and cb_intosc_ls_clk, in the SoC 
> with a known frequency. These warnings can be fixed in the DTSI.
>
>> 
>> If they clocks are not in SoC, they should not be in DTSI.
>
> The two clocks, f2s_free_clk and osc1, are not in the SoC; so they should be 
> removed from DTSI.

Since these clock changes are not directly related to adding PCIe Root 
Port support to Agilex chips, I think they should be in their patch set.

Matthew Gerlach

>
>> 
>> These were my statements last time and this patch does not comple.
>> Commit msg does not explain why this should be done differently.
>> 
>> Best regards,
>> Krzysztof
>> 
>> 
>
> Thanks for the feedback,
> Matthew Gerlach
>

