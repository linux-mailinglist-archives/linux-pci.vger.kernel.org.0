Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1724D44631C
	for <lists+linux-pci@lfdr.de>; Fri,  5 Nov 2021 13:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhKEMHD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Nov 2021 08:07:03 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:50819 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232693AbhKEMHD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Nov 2021 08:07:03 -0400
Received: from [192.168.0.2] (ip5f5ae8e7.dynamic.kabel-deutschland.de [95.90.232.231])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7AEEE61EA191E;
        Fri,  5 Nov 2021 13:04:22 +0100 (CET)
Message-ID: <0f86c80b-aa6b-e1fd-5fda-0a4e4093250d@molgen.mpg.de>
Date:   Fri, 5 Nov 2021 13:04:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: How to reduce PCI initialization from 5 s (1.5 s adding them to
 IOMMU groups)s
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     iommu@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
References: <de6706b2-4ea5-ce68-6b72-02090b98630f@molgen.mpg.de>
In-Reply-To: <de6706b2-4ea5-ce68-6b72-02090b98630f@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Linux folks,


Am 05.11.21 um 12:56 schrieb Paul Menzel:

> On a PowerEdge T440/021KCD, BIOS 2.11.2 04/22/2021, Linux 5.10.70 takes 
> almost five seconds to initialize PCI. According to the timestamps, 1.5 
> s are from assigning the PCI devices to the 142 IOMMU groups.
> 
> ```
> $ lspci | wc -l
> 281
> $ dmesg
> […]
> [    2.918411] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    2.933841] ACPI: Enabled 5 GPEs in block 00 to 7F
> [    2.973739] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-16])
> [    2.980398] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [    2.989457] acpi PNP0A08:00: _OSC: platform does not support [LTR]
> [    2.995451] acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability]
> [    3.001394] acpi PNP0A08:00: FADT indicates ASPM is unsupported, 
> using BIOS configuration
> [    3.010511] PCI host bridge to bus 0000:00
> […]
> [    6.233508] system 00:05: [io  0x1000-0x10fe] has been reserved
> [    6.239420] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    6.239906] pnp: PnP ACPI: found 6 devices
> […]
> [    6.989016] pci 0000:d7:05.0: disabled boot interrupts on device [8086:2034]
> [    6.996063] PCI: CLS 0 bytes, default 64
> [    7.000008] Trying to unpack rootfs image as initramfs...
> [    7.065281] Freeing initrd memory: 5136K
> […]
> [    7.079098] DMAR: dmar7: Using Queued invalidation
> [    7.083983] pci 0000:00:00.0: Adding to iommu group 0
> […]
> [    8.537808] pci 0000:d7:17.1: Adding to iommu group 141
> [    8.571191] DMAR: Intel(R) Virtualization Technology for Directed I/O
> [    8.577618] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> […]
> ```
> 
> Is there anything that could be done to reduce the time?

I created an issue at the Kernel.org Bugzilla, and attached the output 
of `dmesg` there [1].


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=214953
