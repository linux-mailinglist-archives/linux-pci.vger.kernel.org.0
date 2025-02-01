Return-Path: <linux-pci+bounces-20629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F2AA24B64
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 19:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AAE13A6003
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 18:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527601CAA7C;
	Sat,  1 Feb 2025 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFJrHebZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84F81BD9C7;
	Sat,  1 Feb 2025 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738433502; cv=none; b=czgYo79I9tBsMzbWA+Pc/rdkrDuhB0rkqe772LUqqQ5ATnx2znd1a1eNt4YNh+xHTjruZMfDbFONPLDr6ngyvrAYPyFFM7Ncwit+gybW5oi9FoDsVvyOBFRmVHnf94fGIoPLRH4RIahmhspE1aw5MyBZiO1sIkHykSMLXHdoE14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738433502; c=relaxed/simple;
	bh=Lnzd8MaG1ouAXH8MntDLLOlleFitDtAqnB+917zfvpU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dKY7Di7uGccM5er46xeFlZcPJCR/dqEzqZECvxi9XIeRBrYZFfyexUoWIDuSL21H+zy+sm3wfZPYwOSAx3ErFbGPqRWpGU1jZHEbv5qYHrYESns1c9fhoSuKmy5av45fSOOmZW8CbBt63ykJIF4ZEHUghp6GRTleT8oM56huqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFJrHebZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738433502; x=1769969502;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Lnzd8MaG1ouAXH8MntDLLOlleFitDtAqnB+917zfvpU=;
  b=hFJrHebZfvBTpEAHWxQeOdiqlnaXiTQQWzEmSIaJHPRNKQSuAZVQGusL
   NmLktn6KASA6tIPpzDsVxXD0sD+S5sL/Im993dqzBjrzlJGONtufyQgTN
   3/BRODChmjocAFVf12ZnD3bn8LPVojybBj2hAeYn2tIZv4IpdpDOKoEcd
   wi7M7tw6n8VpxkRXykLq3LiY5sNWLt4nqmeUAyBAMA+z0WoM9GVuPOnyV
   1ZiQa5k5Mf5FxX1j1zr4rBd6JTUY6pB1G+0a7bY9lM9q3H9QVnAoGYoah
   eIv3QkKumEirFYIBQWOsXv4ZXJhBqeGg+wbGN4faT++bn/h4FiNtd2GU2
   g==;
X-CSE-ConnectionGUID: Z09k90ESRb+ZX6iKRLYQ5g==
X-CSE-MsgGUID: yayG/K8jRQ6gXyqLgipIbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11333"; a="42631751"
X-IronPort-AV: E=Sophos;i="6.13,252,1732608000"; 
   d="scan'208";a="42631751"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2025 10:11:41 -0800
X-CSE-ConnectionGUID: xR9iPobLSrOy1o8FJIb6CA==
X-CSE-MsgGUID: AyYf2VILTrm7gk/yVTP13g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147110368"
Received: from sj-2308-osc3.sj.altera.com ([10.244.138.69])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2025 10:11:38 -0800
Date: Sat, 1 Feb 2025 10:11:39 -0800 (PST)
From: matthew.gerlach@linux.intel.com
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
    robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
    conor+dt@kernel.org, dinguyen@kernel.org, joyce.ooi@intel.com, 
    linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-kernel@vger.kernel.org, matthew.gerlach@altera.com, 
    peter.colberg@altera.com
Subject: Re: [PATCH v5 1/5] dt-bindings: PCI: altera: Add binding for
 Agilex
In-Reply-To: <40adf7c3-7c02-4520-9e99-ea797143f454@kernel.org>
Message-ID: <c51817d4-a971-4aea-5f24-5c3dc1401db0@linux.intel.com>
References: <20250127173550.1222427-1-matthew.gerlach@linux.intel.com> <20250127173550.1222427-2-matthew.gerlach@linux.intel.com> <40adf7c3-7c02-4520-9e99-ea797143f454@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed



On Thu, 30 Jan 2025, Krzysztof Kozlowski wrote:

> On 27/01/2025 18:35, Matthew Gerlach wrote:
>> Add the compatible bindings for the three variants of Agilex
>> PCIe Hard IP.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>> ---
>> v3:
>>  - Remove accepted patches from patch set.
>> ---
>>  .../devicetree/bindings/pci/altr,pcie-root-port.yaml     | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>> index 52533fccc134..ca9691ec87d2 100644
>> --- a/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>> +++ b/Documentation/devicetree/bindings/pci/altr,pcie-root-port.yaml
>> @@ -12,9 +12,18 @@ maintainers:
>>
>>  properties:
>>    compatible:
>> +    description: altr,pcie-root-port-1.0 is used for the Cyclone5
>> +      family of chips. The Stratix10 family of chips is supported
>> +      by altr,pcie-root-port-2.0. The Agilex family of chips has
>> +      three variants of PCIe Hard IP referred to as the f-tile, p-tile,
>> +      and r-tile.
>
>
> Has three in the same time? Or one of three? Your board DTS said you
> have exactly one, so this comment is confusing.

I will clarify this comment to reflect that a particular instantiantion 
will only have one of the tiles.

>
>
> Best regards,
> Krzysztof
>

Thanks for the feedback,
Matthew Gerlach

