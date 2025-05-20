Return-Path: <linux-pci+bounces-28134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F9FABE305
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 20:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 078DF8A4F8D
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 18:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E0F27AC30;
	Tue, 20 May 2025 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fRTTuP2N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0611C8633;
	Tue, 20 May 2025 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747766534; cv=none; b=oiI7Cy3YollCUv+S0t9kcR8bsZRRzalTjrpR8cSYl62IdX0j2NrOzURGvYgl+XIB4SroRMp0Yea5mNOOuMA6UIYBy4KexqzbiksVRMszF5Bxwh1PavUFMc5q4bQ+LsNLJDIuySpmmbGdqCMCEMrQUZoRBItMw/Jk4ZYTyLdZRBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747766534; c=relaxed/simple;
	bh=j22GacXfS2puntGe7vITacA5IsbpeagcjvvcW8TiD7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+rg2hKYfTYmzYcVZKaj4dROkvquhf7c+4wWv2bMKVkCjdpsQthldAbmszlwJ/Fqi4MT53AKRGQKkTwxfwZYnnE4iMbTkQn96KXZjBg7SShujOn6hePCF8wHdHt/ChlLvZDU7Wu63pwnIhIJRgP0PWN+Yz8IeNIpxxqCn9GvB04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fRTTuP2N; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747766533; x=1779302533;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j22GacXfS2puntGe7vITacA5IsbpeagcjvvcW8TiD7c=;
  b=fRTTuP2NOSxGv1fFS2h+LGzK4kbjk5bM06f3CxFKKbw2Js3aVWPNlc8i
   tAqNWBMj3qYl82Ni04Sp9fVaamW111Zvuo5Rj0AN/UMYOpUHZ9gBSWlNP
   pjKpRz5yQTIHRgCUz+MVvPSq05n9/Vy2MgqG1evNxxnhochdJfkhEXklG
   b5TsJDU6N8Y3Lrcj95oIebxFoE/am+SUq5VhXptz6XX9iPiZ5dA03HXp4
   EEMIa7rJAybCvO793lK5dGzI2wpzs7yhdHZfihbe9R9tqtniN2k06SS+Z
   NdpXj0aRTrhbwB1r6un9BTWCknZ/djRLMm7FZj9TqQyZPKTEUyJLzp3GC
   g==;
X-CSE-ConnectionGUID: R4nKCxV6T+CwTJ6CMs3ZCQ==
X-CSE-MsgGUID: TMjfSYRETgKnNBW7IGYsqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="48971296"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="48971296"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:42:12 -0700
X-CSE-ConnectionGUID: i6W+Ui8ES9yf7P8IDuCFIA==
X-CSE-MsgGUID: A6tollxAQ1yMbnP5Wg4XsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139680669"
Received: from iweiny-desk3.amr.corp.intel.com (HELO [10.124.222.89]) ([10.124.222.89])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:42:12 -0700
Message-ID: <c771e3de-b945-49cd-b078-762164d6ac5d@linux.intel.com>
Date: Tue, 20 May 2025 11:42:10 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/16] PCI/AER: Introduce ratelimit for error logs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20250520183153.GA1316070@bhelgaas>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250520183153.GA1316070@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/20/25 11:31 AM, Bjorn Helgaas wrote:
> On Mon, May 19, 2025 at 09:59:29PM -0700, Sathyanarayanan Kuppuswamy wrote:
>> On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
>>> From: Jon Pan-Doh <pandoh@google.com>
>>>
>>> Spammy devices can flood kernel logs with AER errors and slow/stall
>>> execution. Add per-device ratelimits for AER correctable and uncorrectable
>>> errors that use the kernel defaults (10 per 5s).
>>>
>>> There are two AER logging entry points:
>>>
>>>     - aer_print_error() is used by DPC and native AER
>>>
>>>     - pci_print_aer() is used by GHES and CXL
>>>
>>> The native AER aer_print_error() case includes a loop that may log details
>>> from multiple devices.  This is ratelimited by the union of ratelimits for
>>> these devices, set by add_error_device(), which collects the devices.  If
>>> no such device is found, the Error Source message is ratelimited by the
>>> Root Port or RCEC that received the ERR_* message.
>>>
>>> The DPC aer_print_error() case is currently not ratelimited.
>> Can we also not rate limit fatal errors in AER driver?
> In other words, only rate limit AER_CORRECTABLE and AER_NONFATAL for
> AER?  Seems plausible to me.
Yes, we might lose important information by rate-limiting FATAL errors. I
believe FATAL errors should be infrequent, so it's reasonable to allow them
through without rate limiting. Once you make this change, please also
update the related SysFS documentation and update code accordingly.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


