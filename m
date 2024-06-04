Return-Path: <linux-pci+bounces-8234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6038FAF7F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 12:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DCF1F2151C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 10:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3AD7FBDD;
	Tue,  4 Jun 2024 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qPiU3yZ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2002613BC39;
	Tue,  4 Jun 2024 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495245; cv=none; b=m/czUxiS4SF4VVxcJNVi96M3PYRroYPv6nKZBiKd5vBVgf8Gn1ZwGr536MkW7cjrxpOMujfr6HPwWN4hG99b+5pOUKx2ZR9ywdPvq/v0DFZjUCAgI/b8d1PffYbSR5Ez4vKq/3mS9POEKu1VS4fTTRDtDKDbJri7sdwy+viS4M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495245; c=relaxed/simple;
	bh=a+/pXEb0n+Lxm+BrKmisw+Kn7zWpdQvG+7DWDNmT3Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Chx5Mq8MrQJ9EgJSjJyxWweab6w/naFJOPEJU9L1z496/zsK5ca7sppSpK/OJo1HtPHxkSQtm0xfG/Z7a70KLjgyitu/3/9niaW5AkTtbQK2Sc4y6LMntPHcWPJ/NCV0vmUkOU+PeoyjSJeWp8oFVrTEMDtCYp7IYFHk3D5WlOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qPiU3yZ8; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=UZzpK7RAnvb5v4Rf56gbIEbrxmYlFHstUELrFhF6ayM=;
	b=qPiU3yZ83ANkNuG6yPgEXyIspmAFFuieu1Zq6mkUrdO4xB44xMh6AO6rHW4W6M
	1FX0+E77tSySYdaDdjAGXkXjXS2HdKBPVAmgAcwukRdkUi//ajFVEZh2fuXR3oTY
	xPnzfZdX1gmONgcWyT43dalOp2+Z1XUKELF4iCSQtgAcI=
Received: from [10.0.2.15] (unknown [111.205.43.230])
	by gzga-smtp-mta-g3-2 (Coremail) with SMTP id _____wC3X0yk5V5mlhwCBw--.18854S2;
	Tue, 04 Jun 2024 18:00:05 +0800 (CST)
Message-ID: <67c92052-24d0-4bce-858a-ebed0aab5738@163.com>
Date: Tue, 4 Jun 2024 18:00:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: vmd: Create domain symlink before
 pci_bus_add_devices
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
 nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, sunjw10@lenovo.com, ahuang12@lenovo.com
References: <20240603140329.7222-1-sjiwei@163.com>
 <e10398dc-53b7-446f-b22f-f992ba1cc37e@intel.com>
Content-Language: en-US
From: Jiwei Sun <sjiwei@163.com>
In-Reply-To: <e10398dc-53b7-446f-b22f-f992ba1cc37e@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3X0yk5V5mlhwCBw--.18854S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCrWDuw43GFyrXFWUWw1kuFg_yoWrGw1kpF
	W5GayjyFsrKr47XayDA3y8Xa4Yva1vv3y5J3s8K347Zr9xAFyI9rW0gF45AFWqvF4q93W2
	vwsrXF1a9rs0kaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYD7-UUUUU=
X-CM-SenderInfo: 5vml4vrl6rljoofrz/1tbiWxnzmWV4JQdC4wABs3



On 6/3/24 23:47, Paul M Stillwell Jr wrote:
> On 6/3/2024 7:03 AM, Jiwei Sun wrote:
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
> 
> I'm just curious: has this been doing this forever or has this just started recently?

Thanks for your reply. 

The issue was only reproduced in certain specific servers (VROC configuration
with RAID1 in two NVMe drives, 7mm NVME 2-bay rear RAID enablement kits),
and the VROC RAID1 disk was installed with SLES15.6 (kernel 6.4). According
to our test, the issue has been easily reproduced on this configured server
since kernel 6.2. 
And according to the journalctl log, we found that the systemd-udevd starts 
running earlier than NVMe device added, it exposes this timing issue.

Thanks,
Regards,
Jiwei

> 
> Paul
> 
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
>> sysfs_create_link is invoked at the end of vmd_enable_domain. However,
>> this implementation introduces a timing issue, where mdadm might fail
>> to retrieve the vmd symlink path because the symlink has not been
>> created yet.
>>
>> Fix the issue by creating VMD domain symlinks before invoking
>> pci_bus_add_devices.
>>
>> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
>> Suggested-by: Adrian Huang <ahuang12@lenovo.com>
>> ---
>>   drivers/pci/controller/vmd.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index 87b7856f375a..3f208c5f9ec9 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -961,12 +961,12 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>       list_for_each_entry(child, &vmd->bus->children, node)
>>           pcie_bus_configure_settings(child);
>>   +    WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
>> +                   "domain"), "Can't create symlink to domain\n");
>> +
>>       pci_bus_add_devices(vmd->bus);
>>         vmd_acpi_end();
>> -
>> -    WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
>> -                   "domain"), "Can't create symlink to domain\n");
>>       return 0;
>>   }
>>   


