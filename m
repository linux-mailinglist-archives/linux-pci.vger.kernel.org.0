Return-Path: <linux-pci+bounces-28140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41AAABE4E8
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 22:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3648A4C64D9
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 20:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CE428C861;
	Tue, 20 May 2025 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cbD7q3db"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACC528C853;
	Tue, 20 May 2025 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747773407; cv=none; b=eOS4NnLK2GOwfe7ly0+YoPSZwzDmUT5kmguqTVUQr887t0rlEd79apvTBWdpgOq+aveI09JcS0Q3uVjjUL1sVD0vQZDPMV7ynwIpwKwU4E7qIlww+th8MzAYPeDh1z9npaI8QqLPOge5X0sfidX2WFPM2uvnFvN/BDzuB/1V+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747773407; c=relaxed/simple;
	bh=J/efGUmqy7oN9EoBIMU7rLAuBqz4R6qisInic/jNCRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFWHoQJx4ResJ9nSXyeJAsCBouYfhi8k2z1t9wYArs9YTHs+iEP6dvNQhBRXFNKTlqZr6jT/IxN3Z3RkTr2lFEPad0uLz66NNsIz87fvk2lwBVCQmabeWGxoSmmMAvv04jO9U0CjYuUQFg1J2BbOfRLFSy5+ES77dcKZmK4xkCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cbD7q3db; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747773406; x=1779309406;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J/efGUmqy7oN9EoBIMU7rLAuBqz4R6qisInic/jNCRY=;
  b=cbD7q3dbvZvEKmdaG/22uLKi6lfcLSDfzc71LNp4PsM5xDLQqMec/k3k
   d9Gqj/kvBudpqj+fOWyiF+O7RYxSzwdYrfN6qT6AC9Mi1+BEOsjeXDv5r
   wfmmeOvFEylCnizewWk9+KYljlsdYvLcHH+LuQwDhV5esNgwtHXPX8aIg
   ej/OVQtybZ96fikAlNLyRLN/gyRzIxByQJtEaPdsckwqDBIKC0UAPdb4y
   URel6d6QGEGkdwTF2aWBSZu5IqIu9Vxpd8x3OD363ou2iXbeN5l9A3Vp4
   8twk2AIG7eTZk5QaUyFleP1MF96DCCCaVl5Wg64/7Xwkx4J9/ShXtyXnn
   g==;
X-CSE-ConnectionGUID: vsbFeP6XQ6uya1UG4M5QSQ==
X-CSE-MsgGUID: /AJ/Ieo5QuCK+pLf4nKTnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="37343336"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="37343336"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 13:36:45 -0700
X-CSE-ConnectionGUID: rDiCkEmuTjCvvuNZyc9FvQ==
X-CSE-MsgGUID: QnrewdnpRn2V8+b6oxjOpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140215561"
Received: from iweiny-desk3.amr.corp.intel.com (HELO [10.124.222.89]) ([10.124.222.89])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 13:36:44 -0700
Message-ID: <63e93c1c-9330-43ae-b381-fffde3864da3@linux.intel.com>
Date: Tue, 20 May 2025 13:36:43 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/16] PCI/AER: Add ratelimits to PCI AER Documentation
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
References: <20250520194841.GA1322094@bhelgaas>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250520194841.GA1322094@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/20/25 12:48 PM, Bjorn Helgaas wrote:
> On Mon, May 19, 2025 at 10:01:09PM -0700, Sathyanarayanan Kuppuswamy wrote:
>> On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
>>> From: Jon Pan-Doh <pandoh@google.com>
>>>
>>> Add ratelimits section for rationale and defaults.
>>> +AER Ratelimits
>>> +--------------
>>> +
>>> +Since error messages can be generated for each transaction, we may see
>>> +large volumes of errors reported. To prevent spammy devices from flooding
>>> +the console/stalling execution, messages are throttled by device and error
>>> +type (correctable vs. uncorrectable).
>> Can we list exceptions like DPC and FATAL errors (if added) ?
> Like this?
>
>    +... messages are throttled by device and error
>    +type (correctable vs. non-fatal uncorrectable).  Fatal errors, including
>    +DPC errors, are not ratelimited.
>
> DPC is currently only triggered for fatal errors.

Yes.  I think it is good enough.


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


