Return-Path: <linux-pci+bounces-9867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C42592904B
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 05:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA948283531
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 03:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD9AC8E9;
	Sat,  6 Jul 2024 03:22:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE20EAD5;
	Sat,  6 Jul 2024 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720236157; cv=none; b=byivD5fi+aQcLuWVB1xBOkPUyU8GT97HzjY2PuVhxZ0KIccFso9yohJhvRA+kmSGhkkuZEOMfTDpspmK5GwlZJigA1HWthoXtk+3DHqonJTGYzlzAm8Idnqi9IDpegprcqOtOxIJYGp2sGUf6qZvAxCy72eTOmTdpmXbmA8nMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720236157; c=relaxed/simple;
	bh=sA7B+iNw2xuMusvm2e3okoQMv4UhKxmy+eOpFeK2x/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NanpeRf25DxqjKSc/II82ZnE17YytwFs4jRDwnBrtLxfsxbG7w4IrkJg2c23Omn24yo54SUNv3eFyV1JjWVU3DiEvtn8b7vew8HjxRvKXkYb7WelIpZKAnubYLuFQ6LmzJxigyYv0eYjVnByGUKhcQvLSFRCq/SS3PA2MuNG+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f8d0a1e500so1938310a34.3;
        Fri, 05 Jul 2024 20:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720236155; x=1720840955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kViDtjI48qAi4ViPWEQg4elRMSra/E9uLXVSJsbLpOk=;
        b=XDpavHLX9YjuMVJGrsehRZYVGci1rZSmbGx+EbRjqJ/im4JLkeH3EctAVFjPlJW3VT
         ZQADzDnaLImgMJMeTKMFoje0wbIm8jS0wVKoOsnHNBGoH4ZyiiYh1Q0lp6AGkjl2VBm3
         lsA/oeYlK/vfaN4UadKeaTjeHqahFLBTMaV+NGdQeX6hTxWzR24QxXlnWh5p84idTSa6
         AYMI0D0mRedP/M5SyVtylgFUPvsbfexMH895yfQSSXFFIAeZCRB0DW8p9trYjBs4hd+7
         TNWHKnFMkP3h28Sh09b8F2Gm9PFgxcS5GvmO1fYuTR2ZCo8/vk9I7CcTEEr9nc28Ipz2
         nozQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqd5PIPfhBYLSpKo5du1iR82KWDu6InWopdtqltzthdcJDCUxGqcvxL2XUOBUB306Tlphj03IGp3bP+8DoK1IcAkwjVacfbeB6s0ZJJajcQhOfGUP92B8j+C4EHRTPQfmwEJUzJm/D
X-Gm-Message-State: AOJu0YwBJoWuhZRxAqoxQhujfJ65Wj5clsEpsGmyLV6VDIXuiTqmB8L0
	YN0ij4NPNFTEifom6M+R24wCiuZp5pCcSJzzLwKs9APEuWfZp7IB
X-Google-Smtp-Source: AGHT+IGe7njik8rjF99gr4V5oYm1PVycRTJ7GXTYxxX4DlfcZ7nRaGDsN9+k5GQnn0UPFFlwYb+KSQ==
X-Received: by 2002:a05:6358:8a3:b0:1aa:b769:846 with SMTP id e5c5f4694b2df-1aab7690a55mr112857155d.5.1720236154713;
        Fri, 05 Jul 2024 20:22:34 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a972815sm4131853a91.15.2024.07.05.20.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 20:22:34 -0700 (PDT)
Date: Sat, 6 Jul 2024 12:22:32 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jiwei Sun <sjiwei@163.com>
Cc: nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
	paul.m.stillwell.jr@intel.com, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, sunjw10@lenovo.com,
	ahuang12@lenovo.com
Subject: Re: [PATCH v3] PCI: vmd: Create domain symlink before
 pci_bus_add_devices()
Message-ID: <20240706032232.GG1195499@rocinante>
References: <20240605124844.24293-1-sjiwei@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605124844.24293-1-sjiwei@163.com>

Hello,

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
> sysfs_create_link() is invoked at the end of vmd_enable_domain().
> However, this implementation introduces a timing issue, where mdadm
> might fail to retrieve the vmd symlink path because the symlink has not
> been created yet.
> 
> Fix the issue by creating VMD domain symlinks before invoking
> pci_bus_add_devices().

Applied to vmd, thank you!

[1/1] PCI: vmd: Create domain symlink before pci_bus_add_devices()
      https://git.kernel.org/pci/pci/c/7a13782e6150

	Krzysztof

