Return-Path: <linux-pci+bounces-30091-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C81A1ADF2CB
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708A717720D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782A32ED174;
	Wed, 18 Jun 2025 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WrcT6sPN"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC6D2EF9DB;
	Wed, 18 Jun 2025 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750264947; cv=none; b=kqvxzQU+U4DvlLBcxxxcZTo9lgCS5sthRmuZJtC2r8X8eJ9IKqZLIqX7PJ58UZtTPQjf5PFIE+duksYmLgmzKW4gk4U4a4EuDARRmzWRj1BIrX6g+MLLamlFu6Q1/o78qk6QIbM7h/VRh5952w/svh6BCmBLJ+hrv1xKmSp3zA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750264947; c=relaxed/simple;
	bh=GrPdWztrLcvfik+ikUCqXAFSQYG38aLQDFyRskBUERc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2lnGpyJcX3t1OFZ1Q8UxPVOzZlMyIXqPp4ePTrBviRHe8Bcst6MceHOrNDfX0fsW7VJ9pvAbzZLDriZYDTiDzv9QOOcpV4P53tw0tNIPt3lkipDJyARcoZGhsRrugnMeulKdE2G6GO+oSXA0KUFi8Px4IVN7CHpGJdGuuKJaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WrcT6sPN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.14.36] (unknown [70.37.26.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6D4CD201FF5A;
	Wed, 18 Jun 2025 09:42:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6D4CD201FF5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750264945;
	bh=mVxb0QSI6AyjnEFleeIB05VSgTsCz7WxqgMx5n0EGac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WrcT6sPNNeIS6vgi2Kv6xL4rWlHXCEdPWWELgWTdkzea8ogMNOIFMgQWxJQxXPXad
	 x/edxO5AXlvYg3H3VWre3yaiV0Wh1OfNBGtzv+XBMwTNdJ3u7aU30JI10plyvr3pEW
	 NIYlRf70u9tu995Uh4sY5xTHu6XkLOuMtUTFhzWE=
Message-ID: <2dfbbd15-c03a-45b6-99a6-fa36772676bc@linux.microsoft.com>
Date: Wed, 18 Jun 2025 09:42:25 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] PCI: Reduce FLR delay to 10ms for MSFT devices
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Niklas Cassel <cassel@kernel.org>,
 linux-pci@vger.kernel.org, shyamsaini@linux.microsoft.com, code@tyhicks.com,
 Okaya@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org
References: <20250616210530.GA1106466@bhelgaas>
Content-Language: en-US
From: Graham Whyte <grwhyte@linux.microsoft.com>
In-Reply-To: <20250616210530.GA1106466@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/16/2025 2:05 PM, Bjorn Helgaas wrote:
> On Mon, Jun 16, 2025 at 12:02:41PM -0700, Graham Whyte wrote:
>> On 6/13/2025 8:33 AM, Bjorn Helgaas wrote:
>>> On Thu, Jun 12, 2025 at 09:41:45AM -0700, Graham Whyte wrote:
>>>> On 6/11/2025 11:31 PM, Christoph Hellwig wrote:
>>>>> On Wed, Jun 11, 2025 at 01:08:21PM -0700, Graham Whyte wrote:
>>>>>> We can ask our HW engineers to implement function readiness but we need
>>>>>> to be able to support exiting products, hence why posting it as a quirk.
>>>>>
>>>>> Your report sounds like it works perfectly fine, it's just that you
>>>>> want to reduce the delay.  For that you'll need to stick to the standard
>>>>> methods instead of adding quirks, which are for buggy hardware that does
>>>>> not otherwise work.
>>>>
>>>> Bjorn, what would you recommend as next steps here?
>>>
>>> This is a tough call and I don't pretend to have an obvious answer.  I
>>> understand the desire to improve performance.  On the other hand, PCI
>>> has been successful over the long term because devices adhere to
>>> standardized ways of doing things, which makes generic software
>>> possible.  Quirks degrade that story, of course, especially when there
>>> is an existing standardized solution that isn't being used.  I'm not
>>> at all happy about vendors that decide against the standard solution
>>> and then ask OS folks to do extra work to compensate.
>>
>> Should someone want to implement readiness time reporting down the road,
>> they'll need to do the same work as patch 1 in this series (making the
>> flr delay a configurable parameter).
> 
> Sure.  That's a trivial change.  The problem is the quirk itself.
> 
> The Readiness Time Reporting Extended Capability is read-only with no
> control bits in it so it requires no actual logic in the device.
> Maybe you can just implement that capability with a firmware change on
> the device and add the corresponding Linux support for it.

Hi Bjorn,

We checked with our HW folks, it's not possible for us to update the pci
register components with this particular card, they are read only. What
are your thoughts on the sysfs approach mentioned in the previous email?

Thanks,
Graham

