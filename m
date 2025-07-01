Return-Path: <linux-pci+bounces-31208-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B052FAF05F1
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 23:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B255F44318A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 21:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C901F283FD4;
	Tue,  1 Jul 2025 21:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaCrrVFB"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC492701C8
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 21:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751406517; cv=none; b=d47QYeutUwKhf/vymq1VQ1Fns9pbI7mU3q6W8KPX/YpOPzAfOui2witXhF+gjSfJ2sb+Uzi0ytd+Oq6VtxFSYuWZrsqFgDrGw0l33qQlTEVDYf53ChKN40sE//S2uinV7cTm0enw4e5p138fg0wNl2PeRjeIDq3asxZW2kdBPUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751406517; c=relaxed/simple;
	bh=OSRDk5TdQFt3lomuSKxjTcjaQzZeDdR93yopsXKx6cM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FF25k7CORuF9/JjxlY9RdSvlH6lc8W6R+rwsM/IAswdIHGX5FDPTaTTUUHMxnb+x3O0XJTAj7jBJl+Y41XOVlwTEVSuGqmV6nFPExD75CFVa+gpgVxZ5yQOflharBGHlxNS1CqyjBxcWUsR00/AJYj3R35L81/0FxJr8qDYCuYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eaCrrVFB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751406512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m3bhp6Ha5yTO+37DaP3ZCEydHITdONPpySvqaXLBtLM=;
	b=eaCrrVFBNMzhprTlVGPaz/d8Gyx771lZiR8AuLQ2WLMHiERkFQ35shXUOHzE9qTMLIWQD5
	CgsVFAxc+Rv6HG+Rea77nDs1zn0KxpM0LU+WhEO53BqJp0kU1UVqiEfvqs+SeGkfPNRmaX
	DZWwIhKaxiHiHAnro8TJq4CUMMVkrGw=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-ZOvr6l-DOHOFYW0YbouNRw-1; Tue, 01 Jul 2025 17:48:31 -0400
X-MC-Unique: ZOvr6l-DOHOFYW0YbouNRw-1
X-Mimecast-MFC-AGG-ID: ZOvr6l-DOHOFYW0YbouNRw_1751406511
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86cf30a9be6so112276939f.0
        for <linux-pci@vger.kernel.org>; Tue, 01 Jul 2025 14:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751406511; x=1752011311;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3bhp6Ha5yTO+37DaP3ZCEydHITdONPpySvqaXLBtLM=;
        b=POStVaI25er/aLQjhk8Pvbqy0NGqcfrpdlBKpkJSU6lg2brpINyu+yPnCfmJ/N/uSI
         l+42FbMpnSxWqGmPrfQNxTPAnqoJOryD+p7VC+sDJJ2WBFDtlan/g6e1KCwWnaL/jOdp
         dPHqrITHRTuOI6AL4gVMT6/h7CNj8bDT3PUbteZCEPUKHjTW03I3EA4YuxK6JCz9o1RE
         Gzw8r/ZCF84lOa1xxXXpxQnM8TCKSFpaXh6pK1kI3RBK4OfuRKs99hPqYCwCDe1eSUNu
         CoRnHfp6hv1mheiLJT2HgtXIIUSr5Xn4u/PmIHR500ZmtkqDfnryPptp0zEl34dnuK2q
         kUxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxdbe+4jo16bb6COuKRuyPVxE2Brp/karWsI3Ob8gxSF+IkRopvEsBd7Ypk3yTgIzRGJnWbQI5Kag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyta/ByREWAB5g5UrNp4NpAVBFoeB5biN1B780kTAQFRIjMLZN
	taK0TGFPZS7jgdLy++m1Ko999fifHSetc71bSue6bEAMj9v1A7V15bWN2/RMzg0kUqTBWsq4ALK
	0uyRbNamxF3h8WupKy8j9p1j2FYSvj4hVFEbX9mswq0D84+0LTt9qDbCBuyLCVQ==
X-Gm-Gg: ASbGncteiqMODDkvHVJIFqfYkByYHuejgLNJDMjnJcsQA8514+KW/Io4Jm7rgUIDr+o
	w8EJC3VQMUKUl+MZvwnrXC6LThkzcM5UCnlx8t5Cd3brXy5bZIO1xDBeShuWx+t8/bs+RpfZLcy
	jCUj9Uyy3IGATgtrBqYZaAh4hCGOrVvGgWe0D9kb0G6P2WKTfWOVxinPVEqoVSkzcSQR1t6k6gh
	vhNeVOup6caltutONVeSIkQSCHc23zn5nZ7Vicl6jeJ06EihRCLGfBG9hxl8oFO6IAVHHy1NGUU
	HPkWRvcUVbXTtus35zZzozwINQ==
X-Received: by 2002:a05:6602:6c09:b0:873:13c6:f365 with SMTP id ca18e2360f4ac-876c6ac4208mr28276939f.5.1751406510600;
        Tue, 01 Jul 2025 14:48:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmrWyfpBmHZi2y801SAhlkWgQate/8F0oECz8JtWF6uLas5x68iNoKkuktF30C0qldXS88Pg==
X-Received: by 2002:a05:6602:6c09:b0:873:13c6:f365 with SMTP id ca18e2360f4ac-876c6ac4208mr28276339f.5.1751406510099;
        Tue, 01 Jul 2025 14:48:30 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87687a18102sm252006639f.14.2025.07.01.14.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 14:48:29 -0700 (PDT)
Date: Tue, 1 Jul 2025 15:48:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev, Joerg Roedel
 <joro@8bytes.org>, linux-pci@vger.kernel.org, Robin Murphy
 <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, galshalom@nvidia.com, Joerg Roedel
 <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 maorg@nvidia.com, patches@lists.linux.dev, tdave@nvidia.com, Tony Zhu
 <tony.zhu@intel.com>
Subject: Re: [PATCH 00/11] Fix incorrect iommu_groups with PCIe switches
Message-ID: <20250701154826.75a7aba6.alex.williamson@redhat.com>
In-Reply-To: <0-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
References: <0-v1-74184c5043c6+195-pcie_switch_groups_jgg@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Testing on some systems here...

I have an AMD system:

# lspci -tv
-[0000:00]-+-00.0  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Root Complex
           +-00.2  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge IOMMU
           +-01.0  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge
           +-01.1-[01-03]----00.0-[02-03]----00.0-[03]--+-00.0  Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 [Radeon Pro W5700]
           |                                            +-00.1  Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 HDMI Audio
           |                                            +-00.2  Advanced Micro Devices, Inc. [AMD/ATI] Device 7316
           |                                            \-00.3  Advanced Micro Devices, Inc. [AMD/ATI] Navi 10 USB
           +-01.2-[04]----00.0  Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
           +-02.0  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge
           +-02.1-[05]----00.0  Samsung Electronics Co Ltd NVMe SSD Controller PM9C1a (DRAM-less)
           +-02.2-[06-0b]----00.0-[07-0b]--+-01.0-[08]--+-00.0  MosChip Semiconductor Technology Ltd. MCS9922 PCIe Multi-I/O Controller
           |                               |            \-00.1  MosChip Semiconductor Technology Ltd. MCS9922 PCIe Multi-I/O Controller
           |                               +-02.0-[09-0a]--+-00.0  Intel Corporation 82576 Gigabit Network Connection
           |                               |               \-00.1  Intel Corporation 82576 Gigabit Network Connection
           |                               \-03.0-[0b]----00.0  Fresco Logic FL1100 USB 3.0 Host Controller
           +-03.0  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge
           +-03.1-[0c]----00.0  JMicron Technology Corp. JMB58x AHCI SATA controller
           +-03.2-[0d]----00.0  Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller
           +-04.0  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge
           +-08.0  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge
           +-08.1-[0e]--+-00.0  Advanced Micro Devices, Inc. [AMD/ATI] Raphael
           |            +-00.1  Advanced Micro Devices, Inc. [AMD/ATI] Radeon High Definition Audio Controller [Rembrandt/Strix]
           |            +-00.2  Advanced Micro Devices, Inc. [AMD] Family 19h PSP/CCP
           |            +-00.3  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge USB 3.1 xHCI
           |            +-00.4  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge USB 3.1 xHCI
           |            \-00.6  Advanced Micro Devices, Inc. [AMD] Family 17h/19h/1ah HD Audio Controller
           +-08.3-[0f]----00.0  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge USB 2.0 xHCI
           +-14.0  Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller
           +-14.3  Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge
           +-18.0  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 0
           +-18.1  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 1
           +-18.2  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 2
           +-18.3  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 3
           +-18.4  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 4
           +-18.5  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 5
           +-18.6  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 6
           \-18.7  Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 7

Notably, each case where there's a dummy host bridge followed by some
number of additional functions (ie. 01.0, 02.0, 03.0, 08.0), that dummy
host bridge is tainting the function isolation and merging the group.
For instance each of these were previously a separate group and are now
combined into one group.

# lspci -vvvs 00:01. [manually edited]
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge

00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge GPP Bridge (prog-if 00 [Normal decode])
	Capabilities: [58] Express (v2) Root Port (Slot+), IntMsgNum 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-

00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge GPP Bridge (prog-if 00 [Normal decode])
	Capabilities: [58] Express (v2) Root Port (Slot+), IntMsgNum 0
	Capabilities: [2a0 v1] Access Control Services
		ACSCap:	SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans+
		ACSCtl:	SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ EgressCtrl- DirectTrans-

The endpoints result in equivalent grouping, but this is a case where I
don't understand how we have non-isolated functions yet isolated
subordinate buses.

An Alder Lake system shows something similar:

# lspci -tv
-[0000:00]-+-00.0  Intel Corporation 12th Gen Core Processor Host Bridge
           +-01.0-[01-02]----00.0-[02]--
           +-02.0  Intel Corporation Alder Lake-S GT1 [UHD Graphics 770]
           +-04.0  Intel Corporation Alder Lake Innovation Platform Framework Processor Participant
           +-06.0-[03]----00.0  Sandisk Corp SanDisk Ultra 3D / WD PC SN530, IX SN530, Blue SN550 NVMe SSD (DRAM-less)
           +-08.0  Intel Corporation 12th Gen Core Processor Gaussian & Neural Accelerator
           +-14.0  Intel Corporation Raptor Lake USB 3.2 Gen 2x2 (20 Gb/s) XHCI Host Controller
           +-14.2  Intel Corporation Raptor Lake-S PCH Shared SRAM
           +-15.0  Intel Corporation Raptor Lake Serial IO I2C Host Controller #0
           +-15.1  Intel Corporation Raptor Lake Serial IO I2C Host Controller #1
           +-15.2  Intel Corporation Raptor Lake Serial IO I2C Host Controller #2
           +-15.3  Intel Corporation Device 7a4f
           +-16.0  Intel Corporation Raptor Lake CSME HECI #1
           +-17.0  Intel Corporation Raptor Lake SATA AHCI Controller
           +-19.0  Intel Corporation Device 7a7c
           +-19.1  Intel Corporation Device 7a7d
           +-1a.0-[04]----00.0  Sandisk Corp SanDisk Ultra 3D / WD PC SN530, IX SN530, Blue SN550 NVMe SSD (DRAM-less)
           +-1c.0-[05]--
           +-1c.1-[06]----00.0  Fresco Logic FL1100 USB 3.0 Host Controller
           +-1c.2-[07]----00.0  Realtek Semiconductor Co., Ltd. RTL8125 2.5GbE Controller
           +-1c.3-[08-0c]----00.0-[09-0c]--+-01.0-[0a]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller
           |                               +-02.0-[0b]--
           |                               \-03.0-[0c]----00.0  Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller
           +-1f.0  Intel Corporation Device 7a06
           +-1f.3  Intel Corporation Raptor Lake High Definition Audio Controller
           +-1f.4  Intel Corporation Raptor Lake-S PCH SMBus Controller
           \-1f.5  Intel Corporation Raptor Lake SPI (flash) Controller

00:1c. are all grouped together.  Here 1c.0 does not report ACS, but
the other root ports do:

# lspci -vvvs 1c. | grep -e ^0 -e "Access Control Services"
00:1c.0 PCI bridge: Intel Corporation Raptor Lake PCI Express Root Port #1 (rev 11) (prog-if 00 [Normal decode])
00:1c.1 PCI bridge: Intel Corporation Device 7a39 (rev 11) (prog-if 00 [Normal decode])
	Capabilities: [220 v1] Access Control Services
00:1c.2 PCI bridge: Intel Corporation Raptor Point-S PCH - PCI Express Root Port 3 (rev 11) (prog-if 00 [Normal decode])
	Capabilities: [220 v1] Access Control Services
00:1c.3 PCI bridge: Intel Corporation Raptor Lake PCI Express Root Port #4 (rev 11) (prog-if 00 [Normal decode])
	Capabilities: [220 v1] Access Control Services

So again the group is tainted by a device that cannot generate DMA, the
endpoint grouping remains equivalent, but isolated buses downstream of
this non-isolated group doesn't seem to make sense.

I'll try to generate further interesting configs.  Thanks,

Alex


