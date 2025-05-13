Return-Path: <linux-pci+bounces-27610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41937AB4BDA
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 08:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 905347A2715
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 06:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771991E9917;
	Tue, 13 May 2025 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/zd0tS2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599D51D6DB4;
	Tue, 13 May 2025 06:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747117335; cv=none; b=rFiMnCvXI/+WmDH8FMq5GvLRf3V+gU+moGaKIik6pF+afWTbfCJIoeehlTE6nS6zKO6FZsOer6/eGsCr3OPN+bqRtuTk4qBatq+R3mfiAv3yrHyhD+nofWRfNIhDqoUbJhhnTocQ8eVbvov0nf+rW7fKRZKg+iMBffsMIFAy908=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747117335; c=relaxed/simple;
	bh=F1Dc+MvNAUMUR1sJ7kUFlsLn2WNtlz1OKvBBhuM5kL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mr+HnJxfO7OqqpipgeENgR79jrCu3Aumcj+npLZ+bbNq0n7ld2NcxzMmPC3P/6qkqe7sJA+mvXRr5y4WSbMJQVwMFA2YtjwMVamvyDHHIry9WDi73z0/rqIsepIjibEoc5BkTxdQF5nZp7nL+yMxTaJjOfcgJ4lIHza6jgn6elg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/zd0tS2; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747117334; x=1778653334;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F1Dc+MvNAUMUR1sJ7kUFlsLn2WNtlz1OKvBBhuM5kL0=;
  b=Q/zd0tS2bkwoEnTMBrWBBlINtqWFuTGWk1upj5nrhWrDzjXRELOe/MIW
   RZPE2sElVcOtzSJw44f7vBKK1ocQVyjC+GpBJajU0QvWnayYym+Vs6TGV
   Knk2oSkax3q8PGpeDlRm0mK3beOo172T+BLgVh3gzaqTVE1LSv13aJgdk
   pIQqqzpRFRwcepCFR6KjkriPZsWcz68DRxjEuaqyUGTrflRyrZRrJhVLz
   Q601QPn7lxv8ZjVpWZQzbkpYxzNVUf3ey52WkUWGEG+xkMrYm9OA6hq0K
   ZzkRXvCOdiElnwcu3AiMfPaUdCu+fLwoSkKeuyRdwKWHGdK+ariaGemk0
   w==;
X-CSE-ConnectionGUID: Q3nu4yxmQtewYVs3csuTnA==
X-CSE-MsgGUID: tyfI+G9YTymvAcKot80qBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59582992"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="59582992"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 23:22:13 -0700
X-CSE-ConnectionGUID: f4OsESHLRUGcubGHkai75g==
X-CSE-MsgGUID: mzq1OOppSn+X0tOak6kzAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="142785867"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.246.168]) ([10.245.246.168])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 23:22:09 -0700
Message-ID: <bfb8e9a6-92c1-4079-aec0-b1ad2b245c70@linux.intel.com>
Date: Tue, 13 May 2025 09:23:22 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] ASoC/SOF/PCI/Intel: add Wildcat Lake support
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 lgirdwood@gmail.com, broonie@kernel.org
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
 guennadi.liakhovetski@linux.intel.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
 <0b01a3ae-4766-490e-939d-1d16c2748644@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <0b01a3ae-4766-490e-939d-1d16c2748644@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/05/2025 15:59, Pierre-Louis Bossart wrote:
> 
>> The audio IP in Wildcat Lake (WCL) is largely identical to the one in
>> Panther Lake, the main difference is the number of DSP cores, memory
>> and clocking.
>> It is based on the same ACE3 architecture.
>>
>> In SOF the PTL topologies can be re-used for WCL to reduce duplication
>> of code and topology files. 
> 
> Is this really true? I thought topology files are precisely the place where a specific pipeline is assigned to a specific core. If the number of cores is lower, then a PTL topology could fail when used on a WCL DSP, no?

Yes, that is true, however for generic (sdw, HDA) topologies this is not
an issue as we don't spread the modules (there is no customization per
platform).
When it comes to product topologies, they can still be named as PTL/WCL
if needed and have tailored core use.

It might be that WCL will not use audio configs common with PTL, in that
case we still can have sof-wcl-* topologies if desired.

Fwiw, in case of soundwire we are moving to a even more generic function
topology split, where all SDW device can us generic function fragments
stitched together to create a complete topology.
Those will have to be compatible with all platforms, so wide swing of
core use cannot be possible anymore.

-- 
Péter


