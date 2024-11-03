Return-Path: <linux-pci+bounces-15889-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1820D9BA803
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 21:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C08302815F1
	for <lists+linux-pci@lfdr.de>; Sun,  3 Nov 2024 20:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F7817DFF5;
	Sun,  3 Nov 2024 20:47:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D813B791;
	Sun,  3 Nov 2024 20:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730666841; cv=none; b=MV4IezJyMdLvHqvUDyPVVe00ro8VXDeD1MV458Pp/eKyacr3vxnuXyB6EyeU2NYm3EHIxNlCdvHtbi68OrxuKxlA89n33qxtRkuRS246u7CbkdPr2htHAavF7lfklJIJ2uxurS/5vATMZi1jFIgWT3wV+ybvCjIqpqVA/KKoHlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730666841; c=relaxed/simple;
	bh=B7DYdppyjVmq7o1gonHzJnUTsB2KzuZArwlo90VIdDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMTINWNd7TinDed8NqjVEGBhrDZM3m9nHvl9itShPUq24b6RWXa5wAzaTeuzO2AkPmuZlQ69HDvSQpuhsCSQGVl74deDK22I1zAvktDWnB6GojJRXPTk1czN6hhykDJ3rR1GDRvjQr14lwN9YVmsfH2tvylA3CWW9/pu6R3EwT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20e6981ca77so36959675ad.2;
        Sun, 03 Nov 2024 12:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730666839; x=1731271639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xBgnTjz58DPOb19bkfTurkVdZgiccAOKYI2cdjA1Pc=;
        b=NycFpSTHB/tjtle9M4/TbexDgTA9OUqn9RgUSFLHYRD1nmannVUHAvcBRP+rwBwLF8
         3r6jbsamNm9sCsjb2KuRq/sMtmjoQj5NAOnBXeSFYlFNHOBjR3v+SBi4XP4/BD1g3MlI
         S2Pq/34f/Oa+5XOXS9KiFqbMoBeK6YvUzUB6YRuQfZd0KJDkBiBLDNP9cDRtE4+2Wqv9
         zImr6M5uH22akZ4zeNrvMoDeBL9yAxis0JYevSSsHTTWzE2iyyytfj9MADSbcwY47qfB
         xvtxaUB4JjMOojrGgZSh9OMZ8OLyh3i0YfYxnIePf9X1f6fLt3PHhjUKCq4r+Puhf8+2
         YVcg==
X-Forwarded-Encrypted: i=1; AJvYcCVeVCsj9u1VPasoCF8BKq92CbI2bZpYJPDC1izWA5u6OjyKWS4CS095kWwcvaIE+yEn5F4fqmDQQUJx+RU=@vger.kernel.org, AJvYcCVqyn9jxW/Ku4EonJIfjWLPWsgV+XYia8Ww+Q4q9SjrgSjauQm7zJVCrgCq/WVMbZipR+eST7v/agAq@vger.kernel.org
X-Gm-Message-State: AOJu0YylnP6EnJy3ZspcL+ZbuDz7vwGQGk1lcDz0F+XZK/4GBomLzU1c
	8cDmtUN/BiSBWAa7Lq5/k1KxEQTXVfUOTOMWzImySle9sgK+v8PpuBCtmRx6
X-Google-Smtp-Source: AGHT+IEVNo61h4V8Yh6Yz8mkVGSd33hMAVRAiX8loVR6GnM8WKPqNLwl6KwgqtaoDoPy2hnRJ9SlQg==
X-Received: by 2002:a17:902:cec9:b0:20c:872f:6963 with SMTP id d9443c01a7336-21103b1ce5amr196997705ad.33.1730666838766;
        Sun, 03 Nov 2024 12:47:18 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056eda38sm49800595ad.48.2024.11.03.12.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 12:47:18 -0800 (PST)
Date: Mon, 4 Nov 2024 05:47:16 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jian-Hong Pan <jhp@endlessos.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>,
	David Box <david.e.box@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@endlessos.org
Subject: Re: [PATCH v12 3/3] PCI/ASPM: Make pci_save_aspm_l1ss_state save
 both child and parent's L1SS configuration
Message-ID: <20241103204716.GE237624@rocinante>
References: <20241001083438.10070-2-jhp@endlessos.org>
 <20241001083438.10070-8-jhp@endlessos.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001083438.10070-8-jhp@endlessos.org>

Hello,

> PCI devices' parameters on the VMD bus have been programmed properly
> originally. But, cleared after pci_reset_bus() and have not been restored
> correctly. This leads the link's L1.2 between PCIe Root Port and child
> device gets wrong configs.
> 
> Here is a failed example on ASUS B1400CEAE with enabled VMD. Both PCIe
> bridge and NVMe device should have the same LTR1.2_Threshold value.
> However, they are configured as different values in this case:
> 
> 10000:e0:06.0 PCI bridge [0604]: Intel Corporation 11th Gen Core Processor PCIe Controller [8086:9a09] (rev 01) (prog-if 00 [Normal decode])
>   ...
>   Capabilities: [200 v1] L1 PM Substates
>     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>       PortCommonModeRestoreTime=45us PortTPowerOnTime=50us
>     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>       T_CommonMode=0us LTR1.2_Threshold=0ns
>     L1SubCtl2: T_PwrOn=0us
> 
> 10000:e1:00.0 Non-Volatile memory controller [0108]: Sandisk Corp WD Blue SN550 NVMe SSD [15b7:5009] (rev 01) (prog-if 02 [NVM Express])
>   ...
>   Capabilities: [900 v1] L1 PM Substates
>     L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1- L1_PM_Substates+
>       PortCommonModeRestoreTime=32us PortTPowerOnTime=10us
>     L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2+ ASPM_L1.1-
>       T_CommonMode=0us LTR1.2_Threshold=101376ns
>     L1SubCtl2: T_PwrOn=50us
> 
> Here is VMD mapped PCI device tree:
> 
> -+-[0000:00]-+-00.0  Intel Corporation Device 9a04
>  | ...
>  \-[10000:e0]-+-06.0-[e1]----00.0  Sandisk Corp WD Blue SN550 NVMe SSD
>               \-17.0  Intel Corporation Tiger Lake-LP SATA Controller
> 
> When pci_reset_bus() resets the bus [e1] of the NVMe, it only saves and
> restores NVMe's state before and after reset. Then, when it restores the
> NVMe's state, ASPM code restores L1SS for both the parent bridge and the
> NVMe in pci_restore_aspm_l1ss_state(). The NVMe's L1SS is restored
> correctly. But, the parent bridge's L1SS is restored with a wrong value 0x0
> because the parent bridge's L1SS wasn't saved by pci_save_aspm_l1ss_state()
> before reset.
> 
> So, if the PCI device has a parent, make pci_save_aspm_l1ss_state() save
> the parent's L1SS configuration, too. This is symmetric on
> pci_restore_aspm_l1ss_state().

Applied to aspm, thank you!

[01/02] PCI/ASPM: Add notes about enabling PCI-PM L1SS to pci_enable_link_state(_locked)
        https://git.kernel.org/pci/pci/c/4681da23786a

[02/02] PCI/ASPM: Make pci_save_aspm_l1ss_state save both child and parent's L1SS configuration
        https://git.kernel.org/pci/pci/c/1f37e72d586f

	Krzysztof

