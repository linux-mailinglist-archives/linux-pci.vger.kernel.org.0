Return-Path: <linux-pci+bounces-8202-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C058D8B15
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 22:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01C91C21E68
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jun 2024 20:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EC246436;
	Mon,  3 Jun 2024 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDyEutqp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A4CB651;
	Mon,  3 Jun 2024 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448114; cv=none; b=tGjgzG/QlKR6KBpJ8EbeyZMHmRfAy86aPqkOCD8MWu0fmNJtYnGcskZPh3xJxkkV/zSHTtT6YJR9tmnFWoTa7sapRJDP+uyqlk424WouwoSVSpofuHV5F1P/9FH6NxFa7T9pxX0+F/AMUR9vnUWtfuXcdMhwEskEkgEZAOigLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448114; c=relaxed/simple;
	bh=e1Wa7H9oZRv5OJi/Dfq+GIl0QsVGQOnJwkBTjlncu04=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cNmo1JXtq77HnZfKmJDLy05jfdVbfrpM8/HEk8B25qFo6Uj+eFlFafJOgr5Feu8Q6rNeGBfsEzWjX+6/ftNO31CwdRiH9FoocsM/1SF5f79k8+xVXjGTZbePZzrgdb6b8/ekPVSUsDB2vr8GhkuPMIwzFrr0C8MRNAbc3SLCPLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDyEutqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A80C2BD10;
	Mon,  3 Jun 2024 20:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717448113;
	bh=e1Wa7H9oZRv5OJi/Dfq+GIl0QsVGQOnJwkBTjlncu04=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GDyEutqpwhllhwg5on9ZxtZUmUN2TugxIT87TekGPEiju3rtJhSvSObWjgQurn62L
	 8HKWqYBm7NtYzAxFTma0DuyTvQSSRUMDAHDAoMimgvPCdmgbmd5wGKmsnVjWX536Xy
	 yzvHnqY0BkC6iJCjUGUMwvhREslSldEQw4hoTD3mlfQU/qZ8Vlh7u0/xhAMPgmvbA0
	 EeqEfHWJmylej3sE7OCuzzp7nxuRWjfxhtuv3Dpl0mzvdz3DKttPHiFwC1FS/zft7+
	 dcflda4o2HFn5rRMbMhXk7/nyUeYu+TkWZGMWo+VSnpiYvmimOm5hLmH+XwIv3He30
	 LEXWMV1tnLhAQ==
Date: Mon, 3 Jun 2024 15:55:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiwei Sun <sjiwei@163.com>
Cc: nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, sunjw10@lenovo.com,
	ahuang12@lenovo.com
Subject: Re: [PATCH] PCI: vmd: Create domain symlink before
 pci_bus_add_devices
Message-ID: <20240603205511.GA692326@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603140329.7222-1-sjiwei@163.com>

On Mon, Jun 03, 2024 at 10:03:29PM +0800, Jiwei Sun wrote:
> From: Jiwei Sun <sunjw10@lenovo.com>
> 
> During booting into the kernel, the following error message appears:
> 
>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: Unable to get real path for '/sys/bus/pci/drivers/vmd/0000:c7:00.5/domain/device''
>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: /dev/nvme1n1 is not attached to Intel(R) RAID controller.'
>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: No OROM/EFI properties for /dev/nvme1n1'
>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: no RAID superblock on /dev/nvme1n1.'
>   (udev-worker)[2149]: nvme1n1: Process '/sbin/mdadm -I /dev/nvme1n1' failed with exit code 1.
> 
> This symptom prevents the OS from booting successfully.
> 
> After a NVMe disk is probed/added by the nvme driver, the udevd executes
> some rule scripts by invoking mdadm command to detect if there is a
> mdraid associated with this NVMe disk. The mdadm determines if one
> NVMe devce is connected to a particular VMD domain by checking the
       device

> domain symlink. Here is the root cause:
> 
> Thread A                   Thread B             Thread mdadm
> vmd_enable_domain
>   pci_bus_add_devices
>     __driver_probe_device
>      ...
>      work_on_cpu
>        schedule_work_on
>        : wakeup Thread B
>                            nvme_probe
>                            : wakeup scan_work
>                              to scan nvme disk
>                              and add nvme disk
>                              then wakeup udevd
>                                                 : udevd executes
>                                                   mdadm command
>        flush_work                               main
>        : wait for nvme_probe done                ...
>     __driver_probe_device                        find_driver_devices
>     : probe next nvme device                     : 1) Detect the domain
>     ...                                            symlink; 2) Find the
>     ...                                            domain symlink from
>     ...                                            vmd sysfs; 3) The
>     ...                                            domain symlink is not
>     ...                                            created yet, failed
>   sysfs_create_link
>   : create domain symlink
> 
> sysfs_create_link is invoked at the end of vmd_enable_domain. However,
> this implementation introduces a timing issue, where mdadm might fail
> to retrieve the vmd symlink path because the symlink has not been
> created yet.
> 
> Fix the issue by creating VMD domain symlinks before invoking
> pci_bus_add_devices.

Add "()" after function names in subject and commit log.

> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
> Suggested-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  drivers/pci/controller/vmd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 87b7856f375a..3f208c5f9ec9 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -961,12 +961,12 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	list_for_each_entry(child, &vmd->bus->children, node)
>  		pcie_bus_configure_settings(child);
>  
> +	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
> +			       "domain"), "Can't create symlink to domain\n");

Seems OK to me.  IIUC, this "domain" link is created in the directory
of the VMD pci_dev, and it points to the directory of the new "root
bus" behind the VMD.

Since it's unrelated to the *devices* on that new root bus, I would
probably move this even earlier, so it's with the other code that sets
up the new root bus, e.g., somewhere around vmd_attach_resources().

>  	pci_bus_add_devices(vmd->bus);
>  
>  	vmd_acpi_end();
> -
> -	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
> -			       "domain"), "Can't create symlink to domain\n");
>  	return 0;
>  }
>  
> -- 
> 2.27.0
> 

