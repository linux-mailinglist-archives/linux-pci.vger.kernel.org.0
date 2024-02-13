Return-Path: <linux-pci+bounces-3408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B3C853955
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 19:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EEAD2831BC
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 18:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D36605AC;
	Tue, 13 Feb 2024 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/JZMrtl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A105FF0A;
	Tue, 13 Feb 2024 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707847233; cv=none; b=eguagYaFZ5M30cUOZCJAp3O8JsBOx2p354Gty9bx9l/VBJKCyctCrvTkT3ZC4ItDNrJSh4X8ZTyDwg3OObgvqQPNEXPbXPv+sEW9RrsZj0N8VkgUfCdc0iSox1Ug4D0cT6DkEwmaTz/pogCxWX1FmNvfrGI6wi04vXtLbMTxGDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707847233; c=relaxed/simple;
	bh=asjNO/+3OqJpmSX/1gpnpaggYMXnQkSRk9ngzopq/8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7oSqdZb3KC1Oie3Pg2QDsNB6AL9NyNydumuAaKTHvsbKFbgPQOTKP4R1f/4PGlnclv0C3FEiQlJ/lCZz9E/UB34xh2d0cW4rR09wDCS5y9GfxRuQAAwFpbjYRgkFT+QE547NEvF8+FpidWsDsyJmYxhRHJvtTOiPjzny0Jstaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/JZMrtl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707847232; x=1739383232;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=asjNO/+3OqJpmSX/1gpnpaggYMXnQkSRk9ngzopq/8k=;
  b=n/JZMrtl9vcAmet6WwPcJKCELN2mJM5r9JU33bFlAs1DittkyeEWTCBD
   LhUcdyXmmAkchzfrJhMKlJYGxIx+fUB8JNbwIcjz8gc8Yf11NrSSNMfIj
   7mBsa2snY/YlIp1JhHhrbx6/7tNqmHKsCQHcqaGlvazf6wEErJbUPY+QP
   8bLmcI6izb7QTuOT+C+dlVPfTjeHJEakKx/r3XtKXUrEKrSWqSCyGq5Na
   XYHPPtEMT2qgWrg0MYiIfDGtNqno7zPzFT882iJbAxbQ/UbL8sQvfuNA4
   AxVCocBVjrchmh+mhiEzVNORYmbTUzygoV+RtpMZYR7Gf7rQtnw08lsgb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="12959098"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="12959098"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 10:00:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="7601829"
Received: from maleekmc-mobl.amr.corp.intel.com (HELO [10.209.16.85]) ([10.209.16.85])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 10:00:30 -0800
Message-ID: <af43e9bd-8772-4495-87cc-285b38411bcb@linux.intel.com>
Date: Tue, 13 Feb 2024 10:00:29 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI/IOV: Revert "PCI/IOV: Serialize sysfs
 sriov_numvfs reads vs writes"
Content-Language: en-US
To: Leon Romanovsky <leonro@nvidia.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Jim Harris <jim.harris@samsung.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Pierre_Cr=C3=A9gut?= <pierre.cregut@orange.com>
References: <20240213073450.GA52640@unreal>
 <20240213155954.GA1210633@bhelgaas> <20240213174602.GD52640@unreal>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240213174602.GD52640@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/13/24 9:46 AM, Leon Romanovsky wrote:
> On Tue, Feb 13, 2024 at 09:59:54AM -0600, Bjorn Helgaas wrote:
>> On Tue, Feb 13, 2024 at 09:34:50AM +0200, Leon Romanovsky wrote:
>>> On Mon, Feb 12, 2024 at 02:27:14PM -0600, Bjorn Helgaas wrote:
>>>> On Sun, Feb 11, 2024 at 10:48:44AM +0200, Leon Romanovsky wrote:
>>>>> On Fri, Feb 09, 2024 at 07:20:28PM -0800, Kuppuswamy Sathyanarayanan wrote:
>>>>>> On 2/9/24 3:52 PM, Jim Harris wrote:
>>>>>>> If an SR-IOV enabled device is held by vfio, and the device
>>>>>>> is removed, vfio will hold device lock and notify userspace
>>>>>>> of the removal. If userspace reads the sriov_numvfs sysfs
>>>>>>> entry, that thread will be blocked since sriov_numvfs_show()
>>>>>>> also tries to acquire the device lock. If that same thread
>>>>>>> is responsible for releasing the device to vfio, it results
>>>>>>> in a deadlock.
>>>>>>>
>>>>>>> The proper way to detect a change to the num_VFs value is to
>>>>>>> listen for a sysfs event, not to add a device_lock() on the
>>>>>>> attribute _show() in the kernel.
>>>> The lock was not about detecting a change; Pierre did this:
>>>>
>>>>   ip monitor dev ${DEVICE} | grep --line-buffered "^${id}:" | while read line; do \
>>>>     cat ${path}/device/sriov_numvfs; \
>>>>
>>>> which I assume works by listening for sysfs events.  
>>> It is not, "ip monitor ..." listens to netlink events emitted by
>>> netdev core and not sysfs events. Sysfs events are not involved in
>>> this case.
>> Thanks for correcting my hasty assumption!
>>
>>>> The problem was that after the event occurred, the sriov_numvfs
>>>> read got a stale value (see https://bugzilla.kernel.org/show_bug.cgi?id=202991).
>>> Yes, and it is outcome of such cross-subsytem involvement, which
>>> is racy by definition. Someone can come with even simpler example of why
>>> locking sysfs read and write is not a good idea. 
>>>
>>> For example, let's consider the following scenario with two CPUs and
>>> locks on sysfs read and write:
>>>
>>>  CPU1					CPU2
>>>  echo 1 > ${path}/device/sriov_numvfs
>>> 		 context_switch ->
>>>  					cat ${path}/device/sriov_numvfs
>>> 					lock
>>> 					return 0
>>> 					unlock
>>> 		context_switch <-
>>>  lock
>>>  set 1
>>>  unlock
>>>
>>>  CPU1					CPU2
>>>  echo 1 > ${path}/device/sriov_numvfs
>>>  lock
>>>  set 1
>>>  unlock
>>> 		 context_switch ->
>>>  					cat ${path}/device/sriov_numvfs
>>> 					lock
>>> 					return 1
>>> 					unlock
>>>
>>> So same scenario will return different values if user doesn't protect
>>> such case with external to the kernel lock.
>>>
>>> But if we return back to Pierre report and if you want to provide
>>> completely bullet proof solution to solve cross-subsystem interaction,
>>> you will need to prohibit device probe till sriov_numvfs update is completed.
>>> However, it is overkill for something that is not a real issue.
>> Pierre wanted to detect the configuration change and learn the new
>> num_vfs, which seems like a reasonable thing to do.  Is there a way to
>> do both via netlink or some other mechanism?
> Please pay attention that Pierre listened to specific netdevice and not
> to something general. After patch #2 in Jim's series, he will be able to
> rely on "udevadm monitor" instead of "ip monitor".
>
>>>> So I would drop this sentence because I don't think it accurately
>>>> reflects the reason for 35ff867b7657.
>>>>
>>>>>> Since you are reverting a commit that synchronizes SysFS read
>>>>>> /write, please add some comments about why it is not an
>>>>>> issue anymore.
>>>>> It was never an issue, the idea that sysfs read and write should be
>>>>> serialized by kernel is not correct by definition. 
>>>> I think it *was* an issue.  The behavior Pierre observed at was
>>>> clearly wrong, 
>>> I disagree with this sentence. 
>>>
>>>> and we added 35ff867b7657 ("PCI/IOV: Serialize sysfs
>>>> sriov_numvfs reads vs writes") to resolve it.
>>>>
>>>> We should try to avoid reintroducing the problem, so I think we should
>>>> probably squash these two patches and describe it as a deadlock fix
>>>> instead of dismissing 35ff867b7657 as being based on false premises.
>>>>
>>>> It would be awesome if you had time to verify that these patches also
>>>> resolve the problem you saw, Pierre.
>>> They won't resolve his problem, because he is not listening to sysfs
>>> events, but rely on something from netdev side.
>> I guess that means that if we apply this revert, the problem Pierre
>> reported will return.  Obviously the deadlock is more important than
>> the inconsistency Pierre observed, but from the user's point of view
>> this will look like a regression.
>>
>> Maybe listening to netlink and then looking at sysfs isn't the
>> "correct" way to do this, but I don't want to just casually break
>> existing user code.  If we do contemplate doing the revert, at the
>> very least we should include specific details about what the user code
>> *should* do instead, at the level of the actual commands to use
>> instead of "ip monitor dev; cat ${path}/device/sriov_numvfs".
> udevadm monitor will do the trick.
>
> Another possible solution is to refactor the code to make sure that
> .probe on VFs happens only after sriov_numvfs is updated.
>
> Thanks


IMO,  we can update the sriov_numvfs documentation to let users
aware of the possible race condition between read/write, and also
suggestion about using uevents for device changes.


>> Bjorn
>>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


