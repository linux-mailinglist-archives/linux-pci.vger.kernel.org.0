Return-Path: <linux-pci+bounces-10024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C150D92C50C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 22:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F841C21798
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 20:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B390B5FB8A;
	Tue,  9 Jul 2024 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mn+8JYl2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD491B86DD;
	Tue,  9 Jul 2024 20:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720558781; cv=none; b=k+0LNy7A67aUSi3pJsWJVZ9UUyGWJt/ohfcwOOusSStNSozC6nY0/s6ji8FKUrZ8Cnr/5ZlTW+YtrxafB44wVU1LXgD9rwS7Lq6Zc25E55m/EJT5oqfIpqlStArJtYiKff28Msgf1cc8IDMRkwvQfOZzw50BMzT8YfvFUFuI8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720558781; c=relaxed/simple;
	bh=HNdKvXLI7TM6d3cSHLxTHT3u4cUef/wDMLp/LvR/pSI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EnnMcoHz1zR62eALS+XHsFiJ8CucGN+zIVgvK9gwzE/ukZDcx83ga29rx1M97YpkA56IwGOvwVLalufElE6khBxsv2+IgrEBS+5mHg+0dwMP7BWvIzIApngmFN0Yz/pCygZNT8lnHpL8ndFmjbr2TkysTciqqAe0ia2nI9A3sD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mn+8JYl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBD0C3277B;
	Tue,  9 Jul 2024 20:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720558781;
	bh=HNdKvXLI7TM6d3cSHLxTHT3u4cUef/wDMLp/LvR/pSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mn+8JYl2FfrXayOEfIf4H1W0qJyAEYOJonZj2sptzGs8meU6UBBR0Qoj8Gt71Z0lE
	 q+JS2ps8nvCppTzRrpxnOb3VvVIN8rRdO/iZSX1rhTEJB6nhkauxc6tMqDMJCgmLpc
	 zDELXtiLhsDq6UN8QtpHaJGjY8Kjl7mtKFpLiT6fHmnz7AZzOb4bAQ6j9x7t9JXBqo
	 p1kwmhQhuONOx878EZp79wrgGhfzfZScv8xEsSPn3uzz77p7B1iFKcVKTjium6U03t
	 2h7K5Rm0za1PH1NjGqpfrDGk1BfabuqfbU6Ev6RVZ/ztGJS8fqPJM7V7l2oB/zCDZ8
	 4/IAAVb20HvzQ==
Date: Tue, 9 Jul 2024 15:59:38 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiwei Sun <sjiwei@163.com>
Cc: nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
	paul.m.stillwell.jr@intel.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, sunjw10@lenovo.com,
	ahuang12@lenovo.com, Pawel Baldysiak <pawel.baldysiak@intel.com>,
	Alexey Obitotskiy <aleksey.obitotskiy@intel.com>,
	Tomasz Majchrzak <tomasz.majchrzak@intel.com>
Subject: Re: [PATCH v3] PCI: vmd: Create domain symlink before
 pci_bus_add_devices()
Message-ID: <20240709205938.GA194355@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605124844.24293-1-sjiwei@163.com>

[+cc Pawel, Alexey, Tomasz for mdadm history]

On Wed, Jun 05, 2024 at 08:48:44PM +0800, Jiwei Sun wrote:
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

I guess the root filesystem must be on a RAID device, and it's the
failure to assemble that RAID device that prevents OS boot?  The
messages are just details about why the assembly failed?

> After a NVMe disk is probed/added by the nvme driver, the udevd executes
> some rule scripts by invoking mdadm command to detect if there is a
> mdraid associated with this NVMe disk. The mdadm determines if one
> NVMe devce is connected to a particular VMD domain by checking the
> domain symlink. Here is the root cause:

Can you tell us something about what makes this a vmd-specific issue?

I guess vmd is the only driver that creates a "domain" symlink, so
*that* part is vmd-specific.  But I guess there's something in mdadm
or its configuration that looks for that symlink?

I suppose it has to do with the mdadm code at [1] and the commit at
[2]?

[1] https://github.com/md-raid-utilities/mdadm/blob/96b8035a09b6449ea99f2eb91f9ba4f6912e5bd6/platform-intel.c#L199
[2] https://github.com/md-raid-utilities/mdadm/commit/60f0f54d6f5227f229e7131d34f93f76688b085f

I assume this is a race between vmd_enable_domain() and mdadm?  And
vmd_enable_domain() only loses the race sometimes?  Trying to figure
out why this hasn't been reported before or on non-VMD configurations.
Now that I found [2], the non-VMD part is obvious, but I'm still
curious about why we haven't seen it before.

The VMD device is sort of like another host bridge, and I wouldn't
think mdadm would normally care about a host bridge, but it looks like
mdadm does need to know about VMD for some reason.

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
> sysfs_create_link() is invoked at the end of vmd_enable_domain().
> However, this implementation introduces a timing issue, where mdadm
> might fail to retrieve the vmd symlink path because the symlink has not
> been created yet.
> 
> Fix the issue by creating VMD domain symlinks before invoking
> pci_bus_add_devices().
> 
> Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
> Suggested-by: Adrian Huang <ahuang12@lenovo.com>
> ---
> v3 changes:
>  - Per Paul's comment, move sysfs_remove_link() after
>    pci_stop_root_bus()
> 
> v2 changes:
>  - Add "()" after function names in subject and commit log
>  - Move sysfs_create_link() after vmd_attach_resources()
> 
>  drivers/pci/controller/vmd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 87b7856f375a..4e7fe2e13cac 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -925,6 +925,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  		dev_set_msi_domain(&vmd->bus->dev,
>  				   dev_get_msi_domain(&vmd->dev->dev));
>  
> +	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
> +			       "domain"), "Can't create symlink to domain\n");
> +
>  	vmd_acpi_begin();
>  
>  	pci_scan_child_bus(vmd->bus);
> @@ -964,9 +967,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
>  	pci_bus_add_devices(vmd->bus);
>  
>  	vmd_acpi_end();
> -
> -	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
> -			       "domain"), "Can't create symlink to domain\n");
>  	return 0;
>  }
>  
> @@ -1042,8 +1042,8 @@ static void vmd_remove(struct pci_dev *dev)
>  {
>  	struct vmd_dev *vmd = pci_get_drvdata(dev);
>  
> -	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
>  	pci_stop_root_bus(vmd->bus);
> +	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
>  	pci_remove_root_bus(vmd->bus);
>  	vmd_cleanup_srcu(vmd);
>  	vmd_detach_resources(vmd);
> -- 
> 2.27.0
> 

