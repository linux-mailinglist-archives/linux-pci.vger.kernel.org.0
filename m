Return-Path: <linux-pci+bounces-33299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A493DB18501
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 17:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490BDA80DDF
	for <lists+linux-pci@lfdr.de>; Fri,  1 Aug 2025 15:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D420125A322;
	Fri,  1 Aug 2025 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vr5g86bw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DDA1B7F4
	for <linux-pci@vger.kernel.org>; Fri,  1 Aug 2025 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754062388; cv=none; b=GLq2MiYSM5cdVZgih1PvfL/5UM5UpyhvABkFm8TQnCHnOKZZecpNr9V5HRY9V3s6TqYIzyzUIqcRpboLYx5m2nsptIvB/7oY6YKMXcbAUGjJWOCNJ9Jxx+XATKTo5sfXD+eSlDXcfrdbc7MYcHTVOed+7PrD12JFDsp1IvY4xn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754062388; c=relaxed/simple;
	bh=76zm5mLsx7bheh6RWXQy50AwQ/nwArGGKpe4OQEkatM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GOjInSwFb1yzaCC5uBzS3mGFF7Fhz6bfsnMutYzrXTk5afhZ60jCQHi0iCpoFjpRZvdiY/n2URInVZTxAjHhMf+Jv9/c1IBXmT0V/Gp91OpqpH2QyJwwWgwBjj8n03HnPMtLMh6AG4yP8Yhbm29vcBH/6COH3eFD4i5wEInDtWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vr5g86bw; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3323d8e0ac4so15603801fa.0
        for <linux-pci@vger.kernel.org>; Fri, 01 Aug 2025 08:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754062385; x=1754667185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8l68DoeiceI3IKbSzGhlcOAyQDPZ9AokScWPeUJfCvI=;
        b=vr5g86bwpIl2LXDIebUD37qzLFb3f7UA3VvE+fZoqf2Dwv+CuI/cj0ohNBRTqQ0sJT
         JKYotsrCyOTTXYZifeMjV8CwSRqCvMSLA+whf/aIv8WuVP1tWWzxE/gl89SkDmFtvoOC
         UgUxJ84puM4iAWrwe5m2mMsaU2qcKokWtfWvkdmIAvKFz1b0+3SOp5JQuXaATD0yF9RK
         8o3s+lxJ/iN2bUbZowFkh8Aw/SM8+dTOQYCeEYsstroSsqXRqNPd9d4u9qtgXYutuUqQ
         86tr/wMRnRqNWq3z3AmogE9YALuUB6LX/VD/6/hEz4SQ/9OIQg8D5Nd4fOV2PsN7OKsS
         OgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754062385; x=1754667185;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8l68DoeiceI3IKbSzGhlcOAyQDPZ9AokScWPeUJfCvI=;
        b=C5h6Tx2PRmo9N9UCTt5osAjtDg9H+T9uh77wLjFvRixDUi0BmKLwkloS2F2Z0XOYU8
         qrtPhrKeo9ZcvqWxQ2rCX/bK70ikLCxXsbTy+6IBlsOmY52a7t5z1hJFefqcVPI4J4Lv
         mdJyFf74LvgccB1PMH2zVAF9xG4FdqLaEqJWBMbrzuGbl6tEGpaN9m13HM+l+WhTEP7A
         mYBm6lrmaJ7m9e2ry4ctrIjBCGRbw4SGN4sBKcovUYnbxltQz+RtNkZOmZ2DYpbJuHje
         eLzpd3yfbed9B7jlvmhKCjouGKap08FAiYFuzBNqqyMmg6Qup7XH/MNBj68GUbtSQcz/
         5XbA==
X-Forwarded-Encrypted: i=1; AJvYcCUs9MrHQ1h3IsDEZL3gHZ/8tClIVLHMMG1Hvm3dFUfVplKWWrZv6wAQMrkQHsPvpvdTyAQ9tjqc0/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWf4okDa1w+NR9QuVk/SusZb9OIw0nFmGhE4XAh/CzZ2Bt76Ou
	mwA7Nwx7qoM8e6f557yKtDQZxwppaXWdLrT4tiuQVR35ESQJWNfRznOGfZGJ1JbgY6hdLkB8iRS
	ZiW9wpW9wa6bDFOdK1mEemIH3IIVtmqOhnz128vSt
X-Gm-Gg: ASbGncsmO8AalpkfnE6OXlvY4+5QgYoZWi/gDnCNHik9PbZmw6iIaIl5yXzLq7FtVsU
	bHQYxd6LC4CQCDzZhyw5dGs9mAb3nmErt1YSGZhc8WEf0PwFWlSPdL28d15mO9kQRn3Sx8JDCqH
	M21FOKGy+FBGslUyVv5al+2E0wH4J/q349ljxxsaTa4i1N6dNHnycXJpShFc6OgPRLIDQdv+VZg
	0AMl+2jTAyPUB1E8g==
X-Google-Smtp-Source: AGHT+IElqGqJCtZOhO3R6EOALjhIxAosCdG4c6JAw0Ii5GIvvlZsjTd7NWmVyt9CTRdEgA600P6iKWvTGZcKiA6jmn0=
X-Received: by 2002:a05:651c:4117:b0:32e:aaa0:b06a with SMTP id
 38308e7fff4ca-33224a5e95emr27853181fa.8.1754062384765; Fri, 01 Aug 2025
 08:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: David Matlack <dmatlack@google.com>
Date: Fri, 1 Aug 2025 08:32:37 -0700
X-Gm-Features: Ac12FXzLKnSwpLBskXSaJfx0o2ePwkZV7fNIT0lZA44HGFkBJgr6jkivWR4r114
Message-ID: <CALzav=d_Bjfy=6if+rPmxgGJfUV8ijnQ5hf40HoH6Yozg_H6Ew@mail.gmail.com>
Subject: Live Update MC (LPC): Call for Presentations
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, kexec@lists.infradead.org, 
	Linux MM Mailing List <linux-mm@kvack.org>, linux-pci@vger.kernel.org, X86 ML <x86@kernel.org>
Cc: "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>, David Rientjes <rientjes@google.com>, 
	Chris Li <chriscli@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Josh Hilke <jrhilke@google.com>, Changyuan Lyu <changyuanl@google.com>, 
	"graf@amazon.com" <graf@amazon.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>, 
	"jgowans@amazon.com" <jgowans@amazon.com>, "ptyadav@amazon.de" <ptyadav@amazon.de>, 
	"jgg@nvidia.com" <jgg@nvidia.com>, "rppt@kernel.org" <rppt@kernel.org>, 
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu US <witu@nvidia.com>, 
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>, dave.hansen@intel.com, 
	David Hildenbrand <david@redhat.com>, Frank van der Linden <fvdl@google.com>, jork.loeser@microsoft.com, 
	Junaid Shahid <junaids@google.com>, pankaj.gupta.linux@gmail.com, 
	Pratyush Yadav <pratyush@kernel.org>, kpraveen.lkml@gmail.com, 
	Vishal Annapurve <vannapurve@google.com>, Steve Sistare <steven.sistare@oracle.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"

We are pleased to announce that there will be a Live Update Microconference at
Linux Plumbers 2025: https://lpc.events/event/19/contributions/2004/

This microconference aims to bring together developers from across the kernel
to discuss topics related to Live Update support in Linux. Live Update is a
specialized reboot process where selected devices are kept operational and
kernel state is preserved and recreated across a kexec. For devices, DMA and
interrupts may continue during the reboot.

The primary use-case of Live Update is to enable hypervisor updates in cloud
environments with minimal disruption to running virtual machines. During a Live
Update, a VM can pause and its state is stored to memory while the hypervisor
reboots. PCIe devices attached to those VMs (such as GPUs, NICs, and SSDs), are
kept running during the Live Update. After the reboot, VMs are recreated and
restored from memory, reattached to devices, and resumed. The disruption is
limited to the time it takes to complete this entire process.

With Live Update infrastructure in place, other use-cases may emerge, like for
example preserving the state of GPU doing LLM, freezing running containers with
CRIU, and preserving large in-memory databases.

Topics to be discussed at the microconference include:
  - Live Update Orchestrator (state machine, userspace API, implementation)
  - Generic infrastructure for preserving file descriptors across Live Updates
  - Live Update support for specific files (memfd, iommufd, VFIO cdev, etc.)
  - Integration of Live Update with the PCI subsystem and Linux device model
  - Integration of Live Update with IOMMU and Interrupt Remapping drivers
  - Serializing, deserializing, and versioning kernel state that is passed
    across Live Update
  - Persistence of movable memory
  - Leveraging suspend/resume functionality for device state preservation
  - Optimizing kernel shutdown and boot times
  - Support for Confidential VMs
  - Automated testing

Please submit your proposals at https://lpc.events/event/19/abstracts/ and
select "Live Update MC" as the track. Submissions are due on or before 11:59PM
UTC on Wednesday, September 10, 2025.

We look forward to seeing you at LPC!

