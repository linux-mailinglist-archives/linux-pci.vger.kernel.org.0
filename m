Return-Path: <linux-pci+bounces-8340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB36C8FD36D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 19:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A0B288B3E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 17:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAAC1953A8;
	Wed,  5 Jun 2024 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D79/A8ZF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB42F195393;
	Wed,  5 Jun 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606651; cv=none; b=svHtph5FcvhH7vcv1OyuLAXfZ0AYjGV4LgDyBL4TDH7ZEAAG3QRIxnsi09le5aaJwQPMaK3zX80bO7av2lGX2s4cKFDuC3GPRo1pgwQqAKZCUQpG6SUXPE0y3cCbXBlT/RbBJ+lggkXKPit+I9/5fxCgAs+aMeICRoXmNXwgkJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606651; c=relaxed/simple;
	bh=4rHy27m8piyLMkEo/rzpKHlHXzvsTtKAbsQff57nKUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phjQUXm/zbFgK1WqPDoWDSVAz3eCCeZDr1v7LotRbwZ2KcI53B7Bo6bkcX8hfwL2OkNsC7I0WJSf24qr0mSIexatJCo0tJnYVRGR6v6MxbcSFffHe1ZnkLtdlN5q8TxCr3l3mI5G0WIU3JajuLVVCUz4DQHWmKAgc0hp+ImWQPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D79/A8ZF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717606650; x=1749142650;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4rHy27m8piyLMkEo/rzpKHlHXzvsTtKAbsQff57nKUE=;
  b=D79/A8ZFuTy/wOHLLsDJMZPnI2k9MHws2docnKHB6WMfFiGTvzeOdS9c
   dnVl+28k87UgaXJ2e4T3VnnZSKcoczhd9s47/wLAUE7f7lbz0LS9pG+dj
   owtcX3Jyga2UN3qfGFB4xU5bw53FNhcKh3TeZWxkPyumfBbCyowt83jv/
   e15GXDcaMwqhSd+Xie1JRAsCDuwWgUiUYqHtjQs8QvckOj3Z8HuwGdA6k
   70ULHbFDmIyk0LudQyNmU/Ut+DEACSr2M/Dbu0NZF7JIcOQmraNfj9RyK
   URpwdN8D9/L9xAFv/zQpOMkOwYj184CInvsMv8quqanmUSvlZBWVfvXmc
   w==;
X-CSE-ConnectionGUID: 9bgcOBXlSMaH5DZzh0ElLA==
X-CSE-MsgGUID: 7OkVcCp/THeEBmf2eKRjZg==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14414661"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="14414661"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 09:57:29 -0700
X-CSE-ConnectionGUID: 0E0rwvLFRjGVbRstaHE48Q==
X-CSE-MsgGUID: DI6v9VMnR9KQl/GxeolI/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="75131043"
Received: from patelni-mobl1.amr.corp.intel.com (HELO localhost) ([10.124.1.210])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 09:57:29 -0700
Date: Wed, 5 Jun 2024 09:57:27 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Jiwei Sun <sjiwei@163.com>
Cc: jonathan.derrick@linux.dev, paul.m.stillwell.jr@intel.com,
 lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 sunjw10@lenovo.com, ahuang12@lenovo.com
Subject: Re: [PATCH v3] PCI: vmd: Create domain symlink before
 pci_bus_add_devices()
Message-ID: <20240605095727.000023e7@linux.intel.com>
In-Reply-To: <20240605124844.24293-1-sjiwei@163.com>
References: <20240605124844.24293-1-sjiwei@163.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Jun 2024 20:48:44 +0800
Jiwei Sun <sjiwei@163.com> wrote:

> From: Jiwei Sun <sunjw10@lenovo.com>
> 
> During booting into the kernel, the following error message appears:
> 
>   (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err)
> 'mdadm: Unable to get real path for
> '/sys/bus/pci/drivers/vmd/0000:c7:00.5/domain/device''
> (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err)
> 'mdadm: /dev/nvme1n1 is not attached to Intel(R) RAID controller.'
> (udev-worker)[2149]: nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err)
> 'mdadm: No OROM/EFI properties for /dev/nvme1n1' (udev-worker)[2149]:
> nvme1n1: '/sbin/mdadm -I /dev/nvme1n1'(err) 'mdadm: no RAID
> superblock on /dev/nvme1n1.' (udev-worker)[2149]: nvme1n1: Process
> '/sbin/mdadm -I /dev/nvme1n1' failed with exit code 1.
> 
> This symptom prevents the OS from booting successfully.
> 
> After a NVMe disk is probed/added by the nvme driver, the udevd
> executes some rule scripts by invoking mdadm command to detect if
> there is a mdraid associated with this NVMe disk. The mdadm
> determines if one NVMe devce is connected to a particular VMD domain
> by checking the domain symlink. Here is the root cause:
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
>     : probe next nvme device                     : 1) Detect the
> domain ...                                            symlink; 2)
> Find the ...                                            domain
> symlink from ...                                            vmd
> sysfs; 3) The ...                                            domain
> symlink is not ...                                            created
> yet, failed sysfs_create_link
>   : create domain symlink
> 
> sysfs_create_link() is invoked at the end of vmd_enable_domain().
> However, this implementation introduces a timing issue, where mdadm
> might fail to retrieve the vmd symlink path because the symlink has
> not been created yet.
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
> diff --git a/drivers/pci/controller/vmd.c
> b/drivers/pci/controller/vmd.c index 87b7856f375a..4e7fe2e13cac 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -925,6 +925,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> unsigned long features) dev_set_msi_domain(&vmd->bus->dev,
>  				   dev_get_msi_domain(&vmd->dev->dev));
>  
> +	WARN(sysfs_create_link(&vmd->dev->dev.kobj,
> &vmd->bus->dev.kobj,
> +			       "domain"), "Can't create symlink to
> domain\n"); +
>  	vmd_acpi_begin();
>  
>  	pci_scan_child_bus(vmd->bus);
> @@ -964,9 +967,6 @@ static int vmd_enable_domain(struct vmd_dev *vmd,
> unsigned long features) pci_bus_add_devices(vmd->bus);
>  
>  	vmd_acpi_end();
> -
> -	WARN(sysfs_create_link(&vmd->dev->dev.kobj,
> &vmd->bus->dev.kobj,
> -			       "domain"), "Can't create symlink to
> domain\n"); return 0;
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

Reviewed-by: Nirmal Patel <nirmal.patel@linux.intel.com>

Thanks

-nirmal

