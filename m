Return-Path: <linux-pci+bounces-31293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF8BAF5F5A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 19:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DC63B2E6C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 17:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30882D374D;
	Wed,  2 Jul 2025 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="I8yStWsb"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5B52F50AA;
	Wed,  2 Jul 2025 17:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475783; cv=none; b=iSAJHUokdYCXp6MagCyk+VE+lSuu/Y+C1mj6mFP2SLrJhDu8EUsWTeGzzm9UclufgvRD/XUwxAFN8syoJ0JtpQ5/WARIWwnMxirwt3/NWUEq3ahelKvrOT8URuQSGBsOSjE2RbfeCIj/MqG9AakRT/qHWzD2+ONZ8+VJ75tLhPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475783; c=relaxed/simple;
	bh=aNb8Jo05IlhvYWus7qI8e6hB83PPs0BVSd2VAGTFDnw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OP0A0fyK/rg9JyXy6obAofGybGbOWc83MtV43hSXASC+SNwR/J/ixqzJ3rZIfyDot3Yn3bJEKNRw8iJ9bZYTapLGVEA0BHT5eTfRQEpmwuv189NHuIRTlXiC7UDTNeQPFjySWPuO0Lqa+64XBRNpfYu8EnxCHDv1/vMhLU7ML44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=I8yStWsb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.201.133] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id E8FC3201B1A1;
	Wed,  2 Jul 2025 10:03:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E8FC3201B1A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1751475782;
	bh=rBNBX0hmwvIxL4Bz04/uy+wy+svBh5lvviAOi9RO3yI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=I8yStWsb/6/3CLjF9Y0rQzHLlSYBtNyEJVJ1anM7YX8mNe2pUajWUSAqsdicMSe1W
	 KN7bdXa63Fo5Gvu/FZj9c2f0rtzPH0ljFk8X+wPPo+4yIKLfQuzd5EWDan3yYfD2LP
	 fC1wqYIuLwvaNSVbs3DvSMFV1UsM3sy1Cr9HiHLQ=
Message-ID: <4a176d9f-3a05-4eb4-b64d-b6b7f5ed2413@linux.microsoft.com>
Date: Wed, 2 Jul 2025 10:03:01 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] PCI: Reduce FLR delay to 10ms for MSFT devices
From: Graham Whyte <grwhyte@linux.microsoft.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Niklas Cassel <cassel@kernel.org>,
 linux-pci@vger.kernel.org, shyamsaini@linux.microsoft.com, code@tyhicks.com,
 Okaya@kernel.org, bhelgaas@google.com, linux-kernel@vger.kernel.org
References: <20250616210530.GA1106466@bhelgaas>
 <2dfbbd15-c03a-45b6-99a6-fa36772676bc@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <2dfbbd15-c03a-45b6-99a6-fa36772676bc@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/18/2025 9:42 AM, Graham Whyte wrote:
> 
> 
> On 6/16/2025 2:05 PM, Bjorn Helgaas wrote:
>> On Mon, Jun 16, 2025 at 12:02:41PM -0700, Graham Whyte wrote:
>>> On 6/13/2025 8:33 AM, Bjorn Helgaas wrote:
>>>> On Thu, Jun 12, 2025 at 09:41:45AM -0700, Graham Whyte wrote:
>>>>> On 6/11/2025 11:31 PM, Christoph Hellwig wrote:
>>>>>> On Wed, Jun 11, 2025 at 01:08:21PM -0700, Graham Whyte wrote:
>>>>>>> We can ask our HW engineers to implement function readiness but we need
>>>>>>> to be able to support exiting products, hence why posting it as a quirk.
>>>>>>
>>>>>> Your report sounds like it works perfectly fine, it's just that you
>>>>>> want to reduce the delay.  For that you'll need to stick to the standard
>>>>>> methods instead of adding quirks, which are for buggy hardware that does
>>>>>> not otherwise work.
>>>>>
>>>>> Bjorn, what would you recommend as next steps here?
>>>>
>>>> This is a tough call and I don't pretend to have an obvious answer.  I
>>>> understand the desire to improve performance.  On the other hand, PCI
>>>> has been successful over the long term because devices adhere to
>>>> standardized ways of doing things, which makes generic software
>>>> possible.  Quirks degrade that story, of course, especially when there
>>>> is an existing standardized solution that isn't being used.  I'm not
>>>> at all happy about vendors that decide against the standard solution
>>>> and then ask OS folks to do extra work to compensate.
>>>
>>> Should someone want to implement readiness time reporting down the road,
>>> they'll need to do the same work as patch 1 in this series (making the
>>> flr delay a configurable parameter).
>>
>> Sure.  That's a trivial change.  The problem is the quirk itself.
>>
>> The Readiness Time Reporting Extended Capability is read-only with no
>> control bits in it so it requires no actual logic in the device.
>> Maybe you can just implement that capability with a firmware change on
>> the device and add the corresponding Linux support for it.
> 
> Hi Bjorn,
> 
> We checked with our HW folks, it's not possible for us to update the pci
> register components with this particular card, they are read only. What
> are your thoughts on the sysfs approach mentioned in the previous email?
> 
> Thanks,
> Graham

Hi Bjorn, just wanted to follow up on this here.

