Return-Path: <linux-pci+bounces-10132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E49C92DDFE
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 03:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84082822BB
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 01:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF14801;
	Thu, 11 Jul 2024 01:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="lvFzi6m6"
X-Original-To: linux-pci@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B78D50F;
	Thu, 11 Jul 2024 01:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720661676; cv=none; b=J3QvMFwAsLLoz5mGuVgzLtWJ6q+Hph8EttIV4wNA4xCPevG50Zhv3GKPQnGh7FLN0r5LeGhtfwvrUlg5EI9zwOCNU87d9qLa2AlhsRS5MSLoMGvUTFzaDu54IvmSBMrcWUNn7qFicrubzSl6gI590210SHhT0qWmru8sc958Ja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720661676; c=relaxed/simple;
	bh=pA6vmWSm/iDojky5Zc/QjwIbNgw6dhnTrgRAW/qu/lQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kPCr5WMf2E3p6RDSHesX/2W6Ydr4p/P8i4SFTIYMISrJF+VIIl8nJ9lp0z2LSt2b+oLvKPIWyL1z2uBmowDQlbRjdbaQadYjjZo7a4viR6wtO1Z3Ohw61gsC3x2TSmgMQ0/MsCRprU+HXDdeuTsiq1MqPJ3Ecm7j/9O224E6Isc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=lvFzi6m6; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=GoF5Tvs4M62Ghtrmmmiuuadjx57wxduzEtdRGXczzNU=;
	b=lvFzi6m6Dn65MTU77OKLdKPFbPSLljB4ZTDDv1jV4TwV9Bu+08j96ILnSw3Jse
	t7ApJoAj4e9snkpZDKHbOmun6DRBxQVo5hpJDj6Xws9LGMLGRidAT+dmHtROFKGd
	wz0lTCDfU6CQ+BzDYD6c+VyMawB/LGSv1JYjjXRbow7eI=
Received: from [10.0.2.15] (unknown [111.205.43.230])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wD3_2c_No9mV3JWCg--.57692S2;
	Thu, 11 Jul 2024 09:32:48 +0800 (CST)
Message-ID: <db1d3c1d-de04-401e-a03e-a8bc8cce639e@163.com>
Date: Thu, 11 Jul 2024 09:32:46 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: vmd: Create domain symlink before
 pci_bus_add_devices()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
 paul.m.stillwell.jr@intel.com, lpieralisi@kernel.org, kw@linux.com,
 robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, sunjw10@lenovo.com, ahuang12@lenovo.com
References: <20240710221659.GA262309@bhelgaas>
Content-Language: en-US
From: Jiwei Sun <sjiwei@163.com>
In-Reply-To: <20240710221659.GA262309@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3_2c_No9mV3JWCg--.57692S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw4rAr45JFy5WFW5Jr13Arb_yoW5GF1xpF
	sxWa4jyF4kGr4Ig3Wjy3y8Xa40kw1vvrWYqryrtrWa9r98ZFyF9F4rKr45CFW2yF1vva42
	va1DWry7W3srWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYD7-UUUUU=
X-CM-SenderInfo: 5vml4vrl6rljoofrz/1tbiDwQZmWVOFJTG5AAAsC


On 7/11/24 06:16, Bjorn Helgaas wrote:
> [-cc Pawel, Alexey, Tomasz, which all bounced]
> 
> On Wed, Jul 10, 2024 at 09:29:25PM +0800, Jiwei Sun wrote:
>> On 7/10/24 04:59, Bjorn Helgaas wrote:
>>> [+cc Pawel, Alexey, Tomasz for mdadm history]
>>> On Wed, Jun 05, 2024 at 08:48:44PM +0800, Jiwei Sun wrote:
>>>> From: Jiwei Sun <sunjw10@lenovo.com>
>>>>
>>>> During booting into the kernel, the following error message appears:
>>>>
>>>>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: Unable to get real path for '/sys/bus/pci/drivers/vmd/0000:c7:00.5/domain/device''
>>>>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: /dev/nvme1n1 is not attached to Intel(R) RAID controller.'
>>>>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: No OROM/EFI properties for /dev/nvme1n1'
>>>>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: no RAID superblock on /dev/nvme1n1.'
>>>>   (udev-worker)[2149]: nvme1n1: Process '/sbin/mdadm -I /dev/nvme1n1' failed with exit code 1.
>>>>
>>>> This symptom prevents the OS from booting successfully.
>>>
>>> I guess the root filesystem must be on a RAID device, and it's the
>>> failure to assemble that RAID device that prevents OS boot?  The
>>> messages are just details about why the assembly failed?
>>
>> Yes, you are right, in our test environment, we installed the SLES15SP6
>> on a VROC RAID 1 device which is set up by two NVME hard drivers. And
>> there is also a hardware RAID kit on the motherboard with other two NVME 
>> hard drivers.
> 
> OK, thanks for all the details.  What would you think of updating the
> commit log like this?

Thanks, I think this commit log is clearer than before. Do I need to 
send another v4 patch for the changes?

Thanks,
Regards,
Jiwei

> 
>   The vmd driver creates a "domain" symlink in sysfs for each VMD bridge.
>   Previously this symlink was created after pci_bus_add_devices() added
>   devices below the VMD bridge and emitted udev events to announce them to
>   userspace.
> 
>   This led to a race between userspace consumers of the udev events and the
>   kernel creation of the symlink.  One such consumer is mdadm, which
>   assembles block devices into a RAID array, and for devices below a VMD
>   bridge, mdadm depends on the "domain" symlink.
> 
>   If mdadm loses the race, it may be unable to assemble a RAID array, which
>   may cause a boot failure or other issues, with complaints like this:
> 
>   ...
> 
>   Create the VMD "domain" symlink before invoking pci_bus_add_devices() to
>   avoid this race.


