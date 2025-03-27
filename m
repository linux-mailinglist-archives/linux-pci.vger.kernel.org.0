Return-Path: <linux-pci+bounces-24861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B151A736E7
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E163BC83D
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 16:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A247C165F16;
	Thu, 27 Mar 2025 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="FblBuMa7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C94919ADBA
	for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743093351; cv=none; b=m77wsiY8ZdKlwxl/rLFYFmfTbOA9qJohbWQdnQEbliTKcWqP62HL8Lfs+2lr5zxA8E82PT2pHXIQIiDphelMhy0iZA8IeBDxVOYV+jfgdWeG+RWhMRbGNxlwVa5/nTzlWLeBrn+J7vL3gXKtMJv628ZqIhzf5iUcnqOYivfn2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743093351; c=relaxed/simple;
	bh=eX7fgUh0Or+r6nCoeg2ASG+YN/fSSE0v52AVH35g1rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsa+CII3kLsR02NqtJIBNO3UQkl/8Jg25825rjgqUmSOS+DuUE9swH/gSO5n4tPZs5PGZQCj1H8eoHwRy5WzgOX8ix90t5XZaxZkHRu8JLfVIYL7vVS5sTipEAvQkgM56pFOldlKaTx7d0blx9uwgwEOLN+dfzmN//gCoFNnsCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=FblBuMa7; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so2279043a12.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 09:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1743093348; x=1743698148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w0w6uuCADAEtLYg3qcYN8l4lvMJUAkHjqpfFuC5QFZE=;
        b=FblBuMa7VolDTLsDkBI50xhxyjoDbN5jUQXs9Yc65+g/5S4t/BVIBgxLsO7AhdPyaI
         E4GgByhhujo5G2rSNZFH9dLYG7tVKOF3Bp8ahQLwNYkLPA3Z9NTOWDaynd+RBX/TUpd6
         aK6Zzk90YWjwv9mMSySIqR4OxfWOzKDppHsSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743093348; x=1743698148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0w6uuCADAEtLYg3qcYN8l4lvMJUAkHjqpfFuC5QFZE=;
        b=Go10KGkBulcAePriVDOGzn5uJDvpJ3DL+IuqRGABjAdq9QeuNckr+X7ud4AGToTgcS
         CCndgeMfpixw2b7r2l9ZnbFQikvOqBs/7uCxpYhytnj58XGdNa+aUWIlcM8/WAWmFO8Q
         dPLP+iyRTxPpcyVspuLbwGoR6a0vbNC03CWf2ziIAqICEXDtKmd7iLbyiANfJka6ZL3E
         PxPcSb4vQaNbnp4XueMV3KoDi9wc18h0ueRZqgWYoVZsHWNv1/SVciSFu5IqH/Kl2Nrl
         NuposfkRZrkU9TCwkARCDZa1PIty9iPnFJPOJigYvyQboirI/NNgrp2PJZNo6GjggYvP
         eHjw==
X-Forwarded-Encrypted: i=1; AJvYcCVrIsQdTUjxHSFJaxEZkfO1A2M0FvJySfYSxJbGh7LqDOM4GaE88KmQNO8nvQ1WghanSZK8Wo9Dfd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+lW7YCry0f0ztBrqJR81XnEQxJKIhXDKrAYIBe9HSgj77Xw7i
	YtDCHzLg55pce8Y/t5riGWoqVDm+M1d5THc3O5Ir1O1ZFJmZlVGamyu9ZsSg8Ds=
X-Gm-Gg: ASbGncumATJ5oLrOVR+vKTAYagviM/GH9x+qZ6J5xQLYQa8ksNfvKtWSl9KUkzKU3xi
	Kg56PZJXbMtTQP2p2gLzxAP6WZhF/KKVtnBwu/PKoo8sXYtWt6dyt6F3PmPKKD5thzLr3owh+JZ
	aaFimCx6ya61kIbvGKjvWdyjKYhKtAXE1frhWMCRiyR6hY7vTtaEF/vMSZ9is2XGlR0VYL0cqDL
	6g+IV2CYdpJRlDF+RfehGU/bsGto+T4+ZE8BV3cXPYV5L7vkgQ/4NJeSUfINyRwdD6yqsG6qKGU
	TwxRk8seNhbyElKzDI0BFeY2Le5W+flmuMWme8yyO5cSxGOaqA==
X-Google-Smtp-Source: AGHT+IHEvJFXsIv1KX0tOnrc1aD6jz56SsUPbPYvgNk+VtOonHYfrD/l+1uybG5HnmfkDNHxapuKvg==
X-Received: by 2002:a05:6402:90b:b0:5e5:9c04:777 with SMTP id 4fb4d7f45d1cf-5edbf31f039mr799501a12.6.1743093347754;
        Thu, 27 Mar 2025 09:35:47 -0700 (PDT)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5edc16aae16sm54762a12.13.2025.03.27.09.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 09:35:47 -0700 (PDT)
Date: Thu, 27 Mar 2025 17:35:46 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: bhelgaas@google.com, tglx@linutronix.de, jgross@suse.com,
	pstanner@redhat.com, andriy.shevchenko@linux.intel.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH] PCI/MSI: Fix x86 VMs crash due to dereferencing NULL
Message-ID: <Z-V-YkXwHQsqUBnm@macbook.local>
References: <20250327162155.11133-1-Ashish.Kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327162155.11133-1-Ashish.Kalra@amd.com>

On Thu, Mar 27, 2025 at 04:21:55PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Moving pci_msi_ignore_mask to per MSI domain flag is causing a panic
> with SEV-SNP VMs under KVM while booting and initializing virtio-scsi
> driver as below :
> 
> ...
> [    9.854554] virtio_scsi virtio1: 4/0/0 default/read/poll queues
> [    9.855670] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [    9.856840] #PF: supervisor read access in kernel mode
> [    9.857695] #PF: error_code(0x0000) - not-present page
> [    9.858501] PGD 0 P4D 0
> [    9.858501] Oops: Oops: 0000 [#1] SMP NOPTI
> [    9.858501] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-next-20250326-snp-host-f2a41ff576cc #379 VOLUNTARY
> [    9.858501] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
> [    9.858501] RIP: 0010:msix_prepare_msi_desc+0x3c/0x90
> [    9.858501] Code: 89 f0 48 8b 52 20 66 81 4e 4c 01 01 c7 46 04 01 00 00 00 8b 8f b4 03 00 00 48 89 e5 89 4e 50 48 8b b7 b0 09 00 00 48 89 70 58 <8b> 0a 81 e1 00 00 40 00 75 25 0f b6 50 4d d0 ea 83 f2 01 83 e2 01
> [    9.858501] RSP: 0018:ffffa37f4002b898 EFLAGS: 00010202
> [    9.858501] RAX: ffffa37f4002b8c8 RBX: ffffa37f4002b8c8 RCX: 0000000000000017
> [    9.858501] RDX: 0000000000000000 RSI: ffffa37f400b5000 RDI: ffff984802524000
> [    9.858501] RBP: ffffa37f4002b898 R08: 0000000000000002 R09: ffffa37f4002b854
> [    9.858501] R10: 0000000000000004 R11: 0000000000000018 R12: ffff984802924000
> [    9.858501] R13: ffff984802524000 R14: ffff9848025240c8 R15: 0000000000000000
> [    9.858501] FS:  0000000000000000(0000) GS:ffff984bae657000(0000) knlGS:0000000000000000
> [    9.858501] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    9.858501] CR2: 0000000000000000 CR3: 000800003c260000 CR4: 00000000003506f0
> [    9.858501] Call Trace:
> [    9.858501]  <TASK>
> [    9.858501]  msix_setup_interrupts+0x10e/0x290
> [    9.858501]  __pci_enable_msix_range+0x2ce/0x470
> [    9.858501]  pci_alloc_irq_vectors_affinity+0xb2/0x110
> [    9.858501]  vp_find_vqs_msix+0x228/0x530
> [    9.858501]  vp_find_vqs+0x41/0x290
> [    9.858501]  ? srso_return_thunk+0x5/0x5f
> [    9.858501]  ? __dev_printk+0x39/0x80
> [    9.858501]  ? srso_return_thunk+0x5/0x5f
> [    9.858501]  ? _dev_info+0x6f/0x90
> [    9.858501]  vp_modern_find_vqs+0x1c/0x70
> [    9.858501]  virtscsi_init+0x2d2/0x340
> [    9.858501]  ? __pfx_default_calc_sets+0x10/0x10
> [    9.858501]  virtscsi_probe+0x135/0x3c0
> [    9.858501]  virtio_dev_probe+0x1b6/0x2a0
> ...
> ...
> [    9.934826] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
> 
> This is happening as x86 VMs only have x86_vector_domain (irq_domain)
> created by native_create_pci_msi_domain() and that does not have an
> associated msi_domain_info. Thus accessing msi_domain_info causes a
> kernel NULL pointer dereference during msix_setup_interrupts() and
> breaks x86 VMs.
> 
> In comparison, for native x86, there is irq domain hierarchy created
> by interrupt remapping logic either by AMD IOMMU (AMD-IR) or Intel
> DMAR (DMAR-MSI) and they have an associated msi_domain_info, so
> moving pci_msi_ignore_mask to a per MSI domain flag works for
> native x86.
> 
> Also, Hyper-V and Xen x86 VMs create "virtual" irq domains
> (XEN-MSI) or (HV-PCI-MSI) with their associated msi_domain_info,
> and they can also access pci_msi_ignore_mask as per MSI domain flag.
> 
> Fixes: c3164d2e0d18 ("PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag")
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

Sorry for the breakage.  Already fixed upstream by commit:

3ece3e8e5976 ("PCI/MSI: Handle the NOMASK flag correctly for all PCI/MSI backends")

From Thomas.

Regards, Roger.

