Return-Path: <linux-pci+bounces-2303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8E98310A7
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 01:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85871F22533
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 00:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F0E138A;
	Thu, 18 Jan 2024 00:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U17CO2b+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2958185D;
	Thu, 18 Jan 2024 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705539142; cv=none; b=tahq2OIT2b4znSUfnoDwijYLxT+pRzuq/KB/HdpexjkF+WeYMJZxaEsaH5GfGgl6S08ZcuQt2+SUVekPLD0R4D+v+ZdhkHDpNULkUSFW0sMI+sPZHiGtyqjumrzvMwL2kGRjmVCJPNNNsJgU98PPUMa/6dsw8urXNdHBKzDv3RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705539142; c=relaxed/simple;
	bh=FirjylFd2MCTFO58V4vn7pDh9CrJrYnIJwrr78O9IR8=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:Received:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:Content-Language:To:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=cgt/Htnb2p+g/MftM7jDS7Nxt43fMFatNwQXmjCh04bH70g+k1dxajif33HRZ2+1kmpitEALr2VfzhsVpciMinqUJjm8uuZ9yrPKOfozhT9No8qQx9FQGoXzXjYAPi1bZ455zoy2ExD05eroWUVGVSNvVtwkh0oud4H++P6wDn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U17CO2b+; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705539141; x=1737075141;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FirjylFd2MCTFO58V4vn7pDh9CrJrYnIJwrr78O9IR8=;
  b=U17CO2b+PAZoZLRfRXr5ILSxGFwyOyAj2MFpqs1MvTBVQsFoAvGFP+Yu
   kYYuKXXsDB1h7txbiOU3zAQRZJj5QO07hV9S9sjsLom5KORJXUh3+GspM
   nfNcKJMAYK581U7/008Ou7/VLyrWJ/5HlLjITjeKUv7boIaZe0vseh4Mw
   bI5Jl/5mPqnUur8Rzhfd5v3dzM62l5uvgjavOj3m1yYepG3y17hvVR89S
   e1YXexN/6yatSE0nV4Uy0x5ROymB+3DrpDTUCII3m0MUm/TScAt7xfV/C
   +6pMdiYgfCYZ38dx/tOdtJD11B7/Xe6wvyyDbGalBK7myMbtqwl/8M53y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="397467481"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="397467481"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 16:52:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="186466"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 17 Jan 2024 16:52:17 -0800
Message-ID: <5a9c38ec-1dc2-40d3-99eb-02b87be660a6@linux.intel.com>
Date: Thu, 18 Jan 2024 08:46:50 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, linux-pci@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v10 0/5] fix vt-d hard lockup when hotplug ATS capable
 device
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, kevin.tian@intel.com,
 bhelgaas@google.com, dwmw2@infradead.org, will@kernel.org,
 robin.murphy@arm.com, lukas@wunner.de
References: <20231228170206.720675-1-haifeng.zhao@linux.intel.com>
 <1a2a4069-c737-4a3c-a2f6-cce06823331b@linux.intel.com>
 <3ee904e9-8a93-4bd9-8df7-6294885589e4@linux.intel.com>
 <42f7848a-0262-4871-b5dc-0e87beebfd11@linux.intel.com>
 <dcd27bc8-5eca-41ae-bb86-fd8e657ccfed@linux.intel.com>
 <d72d0a12-f3a4-4b4d-8b3b-5e59937a21d3@linux.intel.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <d72d0a12-f3a4-4b4d-8b3b-5e59937a21d3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/17/24 5:00 PM, Ethan Zhao wrote:
> +       /*
> +        * If the ATS invalidation target device is gone this moment 
> (surprise
> +        * removed, died, no response) don't try this request again. this
> +        * request will not get valid result anymore. but the request was
> +        * already submitted to hardware and we predict to get a ITE in
> +        * followed batch of request, if so, it will get handled then.
> +        */
> +       if (target_pdev && !pci_device_is_present(target_pdev))
> +               return -EINVAL;

Again, we should not ignore the error triggered by the current request.
Do not leave it to the next one. The WAIT descriptor is a fence. Handle
everything within its boundary.

Best regards,
baolu

