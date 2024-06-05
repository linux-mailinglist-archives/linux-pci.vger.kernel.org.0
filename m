Return-Path: <linux-pci+bounces-8290-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D779B8FC557
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 10:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F761C2036D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 08:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6281C14F113;
	Wed,  5 Jun 2024 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EsVF6wF+"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367D21922FC;
	Wed,  5 Jun 2024 08:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574764; cv=none; b=hDFc8RRYiYCYpgDKoLPllbbZtuz7tqto0DWaa2fAwdv7rPgwgtm/g9ZFh1Ap17wUGklYQLPJPYOik0qqzyw5DA5IgvmRvM8iHW+2ZxDmC7fnlX+9fgD1rwewsGZ4EIid8EVgbkkBmiawOKUBz9RRvUus8GnpkxmopMV2Suae4+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574764; c=relaxed/simple;
	bh=MEkf72hbkHlFJhXcMR6uH2GgppBTzzZuYu9Bj9tZ+aw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNzUIPk/ZfACMY9o5V75530YjATtiiOBvSSmKvqiSIOq7Prh8xJP62fTBxppiY7RrVXtfRKA4EBk7wbOcqqQfGFVDljAzDwDdRKOCsuqdxVL0aljjCdyxwTpVTJeGPygiFsF4yJtx39cn52uaQqEMA5zYr0omXKSZUwQq8od6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EsVF6wF+; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=PVpxHacadX3v1Jpi8ge1wxLL0LsNrEZCAoTEQu6/AwY=;
	b=EsVF6wF+sJPffZeWM1rhAChqEu4bITXYoFmrAnqS0mK4VKkvs9LSkCLg8f5DEH
	8eNfxwJKTS/K/4ilGTCFTHukBib8y1BS23Pqlv1f77nLI0IeWH7X9261vp3HbVPZ
	uwK43GaO4pVRvrK/XVhrjIhFKzEPMkILQvX/jZ3pT/85Q=
Received: from [10.0.2.15] (unknown [111.205.43.230])
	by gzga-smtp-mta-g1-4 (Coremail) with SMTP id _____wD3f6gCHGBmGz6GBw--.28481S2;
	Wed, 05 Jun 2024 16:04:19 +0800 (CST)
Message-ID: <ddfb1619-22bc-40f7-a595-f7600608da8a@163.com>
Date: Wed, 5 Jun 2024 16:04:18 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: vmd: Create domain symlink before
 pci_bus_add_devices()
Content-Language: en-US
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
 nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, sunjw10@lenovo.com, ahuang12@lenovo.com
References: <20240604135153.9182-1-sjiwei@163.com>
 <c1885394-9edf-47a7-a4f8-1e456ba52316@intel.com>
From: Jiwei Sun <sjiwei@163.com>
In-Reply-To: <c1885394-9edf-47a7-a4f8-1e456ba52316@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f6gCHGBmGz6GBw--.28481S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWftr1DKF17Gw47Wr47XFb_yoWrJFWrpF
	WrWa1jvFW7Gr47XayDZ3W8WryYvw4vv34UJ3sxK347Z34DAFy09FW0gFs8ArWqvF1q93W2
	vwsrXF1S9wn5KaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYD7-UUUUU=
X-CM-SenderInfo: 5vml4vrl6rljoofrz/1tbiWwb0mWV4JSWaTQAAs6



On 6/5/24 02:00, Paul M Stillwell Jr wrote:
> On 6/4/2024 6:51 AM, Jiwei Sun wrote:
>> From: Jiwei Sun <sunjw10@lenovo.com>
>>
>> During booting into the kernel, the following error message appears:
>>
>>    (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: Unable to get real path for '/sys/bus/pci/drivers/vmd/0000:c7:00.5/domain/device''
>>    (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: /dev/nvme1n1 is not attached to Intel(R) RAID controller.'
>>    (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: No OROM/EFI properties for /dev/nvme1n1'
>>    (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: no RAID superblock on /dev/nvme1n1.'
>>    (udev-worker)[2149]: nvme1n1: Process '/sbin/mdadm -I /dev/nvme1n1' failed with exit code 1.
>>
>> This symptom prevents the OS from booting successfully.
>>
>> After a NVMe disk is probed/added by the nvme driver, the udevd executes
>> some rule scripts by invoking mdadm command to detect if there is a
>> mdraid associated with this NVMe disk. The mdadm determines if one
>> NVMe devce is connected to a particular VMD domain by checking the
>> domain symlink. Here is the root cause:
>>
>> Thread A                   Thread B             Thread mdadm
>> vmd_enable_domain
>>    pci_bus_add_devices
>>      __driver_probe_device
>>       ...
>>       work_on_cpu
>>         schedule_work_on
>>         : wakeup Thread B
>>                             nvme_probe
>>                             : wakeup scan_work
>>                               to scan nvme disk
>>                               and add nvme disk
>>                               then wakeup udevd
>>                                                  : udevd executes
>>                                                    mdadm command
>>         flush_work                               main
>>         : wait for nvme_probe done                ...
>>      __driver_probe_device                        find_driver_devices
>>      : probe next nvme device                     : 1) Detect the domain
>>      ...                                            symlink; 2) Find the
>>      ...                                            domain symlink from
>>      ...                                            vmd sysfs; 3) The
>>      ...                                            domain symlink is not
>>      ...                                            created yet, failed
>>    sysfs_create_link
>>    : create domain symlink
>>
>> sysfs_create_link() is invoked at the end of vmd_enable_domain().
>> However, this implementation introduces a timing issue, where mdadm
>> might fail to retrieve the vmd symlink path because the symlink has not
>> been created yet.
>>
>> Fix the issue by creating VMD domain symlinks before invoking
>> pci_bus_add_devices().
>>
>> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
>> Suggested-by: Adrian Huang <ahuang12@lenovo.com>
>> ---
>> v2 changes:
>>   - Add "()" after function names in subject and commit log
>>   - Move sysfs_create_link() after vmd_attach_resources()
>>
>> ---
>>   drivers/pci/controller/vmd.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index 87b7856f375a..d0e33e798bb9 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -925,6 +925,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>           dev_set_msi_domain(&vmd->bus->dev,
>>                      dev_get_msi_domain(&vmd->dev->dev));
>>   +    WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
>> +                   "domain"), "Can't create symlink to domain\n");
>> +
> 
> I think you should move the sysfs_remove_link() line in vmd_remove() down as well.

Indeed, thanks for your suggestion. I will modify it in v3 patch.

Thanks,
Regards,
Jiwei

> 
> Paul
> 
>>       vmd_acpi_begin();
>>         pci_scan_child_bus(vmd->bus);
>> @@ -964,9 +967,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>       pci_bus_add_devices(vmd->bus);
>>         vmd_acpi_end();
>> -
>> -    WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
>> -                   "domain"), "Can't create symlink to domain\n");
>>       return 0;
>>   }
>>   


