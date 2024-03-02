Return-Path: <linux-pci+bounces-4374-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE5786F12F
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 17:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0371C2103E
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 16:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EEB182DA;
	Sat,  2 Mar 2024 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cBjk/7RJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D25231;
	Sat,  2 Mar 2024 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709396546; cv=none; b=ptL4GICEpJ4uUW+xTfYKwsfJbowHqEw5AO+4IHs8Xi2nbe7QFh3LWbFd63s/xvtIByIerSeB7vN6ImTU8TOm0e9DLeWBOQ0LlbOlW612H1+sukLhfaQdgYmDIuvwqDdEMO1q11lFaf/PpXKXrEIcugobSmucsGg7LtECfsQ0ELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709396546; c=relaxed/simple;
	bh=O7Metv/cKZxMqHAr7xMIKgbBm2eQl686+CzdtJnXHdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aIee1cQxjyfw52R8vm2KQ3LJ67Ns+SeeguzTUJa01E6Md61yvmnzdwxD6ezzd688DIrVPuALY2XhyLQTaf5kU+UewGA436jdqN3HgNzGAQeqeGGA1CcZaopiiQqMsNVQfev6OGlVCKh7mxHinDEJ8smBbILkybTGAEeaTDhVlgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cBjk/7RJ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709396544; x=1740932544;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O7Metv/cKZxMqHAr7xMIKgbBm2eQl686+CzdtJnXHdE=;
  b=cBjk/7RJ8SY5LQPIiDjBNk9IS8KZfBLEE7M+PTI9ocxzl5kZneRrggnP
   BV/VtWMUybOZRA6Z3bKdHHAIHelR54yh7dsjR08dWbd+0s6wCJ7xCnGYm
   Xz1RrORt94qSqYxplwNzM0tYpEjKDQqiLF7A/NfzYy6iamEKZ0/xG8g+m
   +aPpxNnqgmmz8s1L8ZotOMKi3bteVb6RdEw8MEL7ytZ3yYmM+iNKiqu2v
   peKPHiMrfSEIwrEV/fbUae9A99njRYTUe7pKE5I2Hg2SrrBM9J1U64wiW
   xBB/gfP+pLvbN9UTjrDdWCZxE2yPwaFWB8aS+TqdjwHk65IOVm2m3Bkfa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11001"; a="4508976"
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="4508976"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2024 08:22:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,199,1705392000"; 
   d="scan'208";a="8596834"
Received: from avandeve-mobl1.amr.corp.intel.com (HELO [10.125.99.137]) ([10.125.99.137])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2024 08:22:23 -0800
Message-ID: <d6275e31-9ceb-4d8c-9018-e30857c31bba@linux.intel.com>
Date: Sat, 2 Mar 2024 08:22:19 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Dell XPS 13 9360: Two PCI devices with disabled power management
 by default
To: Paul Menzel <pmenzel@molgen.mpg.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20240301215148.GA409221@bhelgaas>
 <eeccc05b-3341-4bc5-bdc7-27cd9e6eb104@molgen.mpg.de>
Content-Language: en-US
From: Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <eeccc05b-3341-4bc5-bdc7-27cd9e6eb104@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/2/2024 8:19 AM, Paul Menzel wrote:
> [Cc: +Arjan]
> 
> Dear Bjorn,
> 
> 
> Thank you for your reply.
> 
> Am 01.03.24 um 22:51 schrieb Bjorn Helgaas:
>> On Fri, Mar 01, 2024 at 12:32:12PM +0100, Paul Menzel wrote:
> 
>>> I noticed on the Dell XPS 13 9360 some devices do not have power management
>>> enabled by default. From PowerTOP:
>>>
>>>         Bad           Runtime PM for PCI Device Intel Corporation Sunrise Point-LP PCI Express Root Port #1
>>>         Bad           Runtime PM for PCI Device Intel Corporation Sunrise Point-LP LPC Controller
>>
>> I don't know what this "Bad" is based on, so I don't know where to
>> look for something Linux might be doing.  I don't see any code that
>> mentions 9d10 or 9d58 Device IDs in relation to power.
> 
> Turns out that PowerTOP marks all devices as *Bad* where `power/control` differs from `auto`. In this case these are set to `on`, which should be good from a power 
> management perspective.

ok just fixed this in powertop git

thanks for the report!



