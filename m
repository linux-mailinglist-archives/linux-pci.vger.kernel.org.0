Return-Path: <linux-pci+bounces-10076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 722B792D2DB
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 15:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1941C20B18
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA72190076;
	Wed, 10 Jul 2024 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SDAMP48G"
X-Original-To: linux-pci@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288FE1CA9C;
	Wed, 10 Jul 2024 13:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720618350; cv=none; b=WulDiyPPoYdJ73hQG/GiziKM4cyutH8uiWPEwqgeFu/LuhnDLVGxOBT1lc6fsIOdgBQ9IyYqOTnUKu9KIxD27Mxkcu+JvSwgOGDEvpPwnRCaBu0zNJ1oqAiFByP3cxXTNmZRkc429he9jns5t9qhCAYIL93NBSz9EUsAo5H8oEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720618350; c=relaxed/simple;
	bh=1sQbIrS1JVYEEZ8wsStgULcn7YAsrepfKI36ed3D5FI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AQup+a2bvTWsNRVU08PADFGjb03ist3utE1tuwdwiBhJG5CKZRcn+RWo1KPdaTgafhhxoloT+Ofy2QmR1w3Rb4sEwrkiM90WnG+vV1BZKOBI8FxplnZtaFHbrOXHdwcI+8zung+nswS+ItEJ0z4iLeWfDpJLAEAYArfNLRp4o/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SDAMP48G; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=hcluSJjCmhnWXX8YTDLv8feP55y3/EV9PtZgqhLBZl8=;
	b=SDAMP48GpwvMjb58QXp8GEGj44RTz7mlOO8xCFH7BY2iqW9p9OK/lcQMmDZyYE
	V428UhzNIKOqn7e0q+nDWYXml9IweBrAB9MZUIgXES5dOjYkutIE55zQc/jpU+Sx
	ZJqQl/8Bwq9b60PPfy5+2gMqb+zMuqJoXWAAtEXqtuUgM=
Received: from [10.0.2.15] (unknown [111.205.43.230])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wD3X5a2jI5mqCcSCg--.45966S2;
	Wed, 10 Jul 2024 21:29:27 +0800 (CST)
Message-ID: <b5d99ec8-9e4d-494a-bf62-02b992a042e8@163.com>
Date: Wed, 10 Jul 2024 21:29:25 +0800
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
 linux-kernel@vger.kernel.org, sunjw10@lenovo.com, ahuang12@lenovo.com,
 Pawel Baldysiak <pawel.baldysiak@intel.com>,
 Alexey Obitotskiy <aleksey.obitotskiy@intel.com>,
 Tomasz Majchrzak <tomasz.majchrzak@intel.com>
References: <20240709205938.GA194355@bhelgaas>
Content-Language: en-US
From: Jiwei Sun <sjiwei@163.com>
In-Reply-To: <20240709205938.GA194355@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X5a2jI5mqCcSCg--.45966S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3XryfurWrAr4UKF17Aw48Crg_yoWftF48pF
	ZxW3W5tFs7Gr43XayUu3y8WFyayw4vvry5try5Kw1jv3yDAFy09FW0kF45Cr42vF1DKasF
	vw4qgrn09Fn0kaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UnmRUUUUUU=
X-CM-SenderInfo: 5vml4vrl6rljoofrz/1tbiDxoYmWVOFIrZegAAsC


On 7/10/24 04:59, Bjorn Helgaas wrote:
> [+cc Pawel, Alexey, Tomasz for mdadm history]
> 
> On Wed, Jun 05, 2024 at 08:48:44PM +0800, Jiwei Sun wrote:
>> From: Jiwei Sun <sunjw10@lenovo.com>
>>
>> During booting into the kernel, the following error message appears:
>>
>>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: Unable to get real path for '/sys/bus/pci/drivers/vmd/0000:c7:00.5/domain/device''
>>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: /dev/nvme1n1 is not attached to Intel(R) RAID controller.'
>>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: No OROM/EFI properties for /dev/nvme1n1'
>>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: no RAID superblock on /dev/nvme1n1.'
>>   (udev-worker)[2149]: nvme1n1: Process '/sbin/mdadm -I /dev/nvme1n1' failed with exit code 1.
>>
>> This symptom prevents the OS from booting successfully.
> 
> I guess the root filesystem must be on a RAID device, and it's the
> failure to assemble that RAID device that prevents OS boot?  The
> messages are just details about why the assembly failed?

Yes, you are right, in our test environment, we installed the SLES15SP6
on a VROC RAID 1 device which is set up by two NVME hard drivers. And
there is also a hardware RAID kit on the motherboard with other two NVME 
hard drivers.

# lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
nvme0n1     259:1    0     7T  0 disk
├─nvme0n1p1 259:2    0   512M  0 part
├─nvme0n1p2 259:3    0    40G  0 part
└─nvme0n1p3 259:4    0   6.9T  0 part
nvme1n1     259:6    0   1.7T  0 disk
├─md126       9:126  0   1.7T  0 raid1
│ ├─md126p1 259:9    0   600M  0 part  /boot/efi
│ ├─md126p2 259:10   0     1G  0 part
│ ├─md126p3 259:11   0    40G  0 part  /usr/local
│ │                                    /var
│ │                                    /tmp
│ │                                    /srv
│ │                                    /root
│ │                                    /opt
│ │                                    /boot/grub2/x86_64-efi
│ │                                    /boot/grub2/i386-pc
│ │                                    /.snapshots
│ │                                    /
│ ├─md126p4 259:12   0   1.5T  0 part  /home
│ └─md126p5 259:13   0 125.5G  0 part  [SWAP]
└─md127       9:127  0     0B  0 md
nvme2n1     259:8    0   1.7T  0 disk
├─md126       9:126  0   1.7T  0 raid1
│ ├─md126p1 259:9    0   600M  0 part  /boot/efi
│ ├─md126p2 259:10   0     1G  0 part
│ ├─md126p3 259:11   0    40G  0 part  /usr/local
│ │                                    /var
│ │                                    /tmp
│ │                                    /srv
│ │                                    /root
│ │                                    /opt
│ │                                    /boot/grub2/x86_64-efi
│ │                                    /boot/grub2/i386-pc
│ │                                    /.snapshots
│ │                                    /
│ ├─md126p4 259:12   0   1.5T  0 part  /home
│ └─md126p5 259:13   0 125.5G  0 part  [SWAP]
└─md127       9:127  0     0B  0 md

And the nvme0n1 is hardware RAID kit,
the nvme1n1 and nvme2n1 is VROC.

The OS entered emergency mode after installation and restart. And we
found that no RAID was detected on the first NVME hard driver according
to the emergency mode log, but when we try to detect it manually by 
using the following command

#/sbin/mdadm -I /dev/nvme1n1

It works, the RAID device was found, it tells us that the RAID is just
not detected in the booting process. We added the "rd.udev.debug" to 
kernel's cmdline, the error logs appears.

  (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: Unable to get real path for '/sys/bus/pci/drivers/vmd/0000:c7:00.5/domain/device''
  (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: /dev/nvme1n1 is not attached to Intel(R) RAID controller.'
  (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: No OROM/EFI properties for /dev/nvme1n1'
  (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: no RAID superblock on /dev/nvme1n1.'
  (udev-worker)[2149]: nvme1n1: Process '/sbin/mdadm -I /dev/nvme1n1' failed with exit code 1.

> 
>> After a NVMe disk is probed/added by the nvme driver, the udevd executes
>> some rule scripts by invoking mdadm command to detect if there is a
>> mdraid associated with this NVMe disk. The mdadm determines if one
>> NVMe devce is connected to a particular VMD domain by checking the
>> domain symlink. Here is the root cause:
> 
> Can you tell us something about what makes this a vmd-specific issue?
> 
> I guess vmd is the only driver that creates a "domain" symlink, so
> *that* part is vmd-specific.  But I guess there's something in mdadm
> or its configuration that looks for that symlink?

According to the following error log,

  mdadm: Unable to get real path for '/sys/bus/pci/drivers/vmd/0000:c7:00.5/domain/device

We enable the dyndbg log of the drivers/base/*(add dyndbg="file drivers/base/* +p" to cmdline),
and add some debug logs in the find_driver_devices() of the madam source code [1],
We found that the "domain" has not been created when the error log appears.
And as you stated, the "domain" symlink is created by vmd driver.

> 
> I suppose it has to do with the mdadm code at [1] and the commit at
> [2]?

Yes, you are right, mdadm determine which NVMe dev is connected to the VMD
domain by checking "/sys/bus/%s/drivers/%s/%s/domain/device", according to the following mdadm code[1],
              /*
              * Each VMD device (domain) adds separate PCI bus, it is better
              * to store path as a path to that bus (easier further
              * determination which NVMe dev is connected to this particular
              * VMD domain).
              */
              if (type == SYS_DEV_VMD) {
                     sprintf(path, "/sys/bus/%s/drivers/%s/%s/domain/device",
                            bus, driver, de->d_name);
              }
              p = realpath(path, NULL);
              if (p == NULL) {
                     pr_err("Unable to get real path for '%s'\n", path);
                     continue;
              }

[1] https://github.com/md-raid-utilities/mdadm/blob/main/platform-intel.c#L208

> 
> [1] https://github.com/md-raid-utilities/mdadm/blob/96b8035a09b6449ea99f2eb91f9ba4f6912e5bd6/platform-intel.c#L199
> [2] https://github.com/md-raid-utilities/mdadm/commit/60f0f54d6f5227f229e7131d34f93f76688b085f
> 
> I assume this is a race between vmd_enable_domain() and mdadm?  And
> vmd_enable_domain() only loses the race sometimes?  Trying to figure

Yes, you are right, what you said is the conclusion of our investigation.

> out why this hasn't been reported before or on non-VMD configurations.
> Now that I found [2], the non-VMD part is obvious, but I'm still
> curious about why we haven't seen it before.

According to our test, if we remove that hardware RAID kit, the issue
can't be reproduced, the driver name on the hardware RAID kit is nvme0, 
and the driver name on VROC is nvme1 and nvme2. It seems the special 
configuration makes the problem more apparent.

> 
> The VMD device is sort of like another host bridge, and I wouldn't
> think mdadm would normally care about a host bridge, but it looks like
> mdadm does need to know about VMD for some reason.

I think so, it is better if the application doesn't have to pay too 
much attention to hardware details. Just we can see, the mdadm uses 
the "domain" symlink.

Thanks,
Regards,
Jiwei

> 
>> Thread A                   Thread B             Thread mdadm
>> vmd_enable_domain
>>   pci_bus_add_devices
>>     __driver_probe_device
>>      ...
>>      work_on_cpu
>>        schedule_work_on
>>        : wakeup Thread B
>>                            nvme_probe
>>                            : wakeup scan_work
>>                              to scan nvme disk
>>                              and add nvme disk
>>                              then wakeup udevd
>>                                                 : udevd executes
>>                                                   mdadm command
>>        flush_work                               main
>>        : wait for nvme_probe done                ...
>>     __driver_probe_device                        find_driver_devices
>>     : probe next nvme device                     : 1) Detect the domain
>>     ...                                            symlink; 2) Find the
>>     ...                                            domain symlink from
>>     ...                                            vmd sysfs; 3) The
>>     ...                                            domain symlink is not
>>     ...                                            created yet, failed
>>   sysfs_create_link
>>   : create domain symlink
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
>> v3 changes:
>>  - Per Paul's comment, move sysfs_remove_link() after
>>    pci_stop_root_bus()
>>
>> v2 changes:
>>  - Add "()" after function names in subject and commit log
>>  - Move sysfs_create_link() after vmd_attach_resources()
>>
>>  drivers/pci/controller/vmd.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
>> index 87b7856f375a..4e7fe2e13cac 100644
>> --- a/drivers/pci/controller/vmd.c
>> +++ b/drivers/pci/controller/vmd.c
>> @@ -925,6 +925,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>  		dev_set_msi_domain(&vmd->bus->dev,
>>  				   dev_get_msi_domain(&vmd->dev->dev));
>>  
>> +	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
>> +			       "domain"), "Can't create symlink to domain\n");
>> +
>>  	vmd_acpi_begin();
>>  
>>  	pci_scan_child_bus(vmd->bus);
>> @@ -964,9 +967,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>>  	pci_bus_add_devices(vmd->bus);
>>  
>>  	vmd_acpi_end();
>> -
>> -	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
>> -			       "domain"), "Can't create symlink to domain\n");
>>  	return 0;
>>  }
>>  
>> @@ -1042,8 +1042,8 @@ static void vmd_remove(struct pci_dev *dev)
>>  {
>>  	struct vmd_dev *vmd = pci_get_drvdata(dev);
>>  
>> -	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
>>  	pci_stop_root_bus(vmd->bus);
>> +	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
>>  	pci_remove_root_bus(vmd->bus);
>>  	vmd_cleanup_srcu(vmd);
>>  	vmd_detach_resources(vmd);
>> -- 
>> 2.27.0
>>


