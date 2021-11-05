Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EE54468A8
	for <lists+linux-pci@lfdr.de>; Fri,  5 Nov 2021 19:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbhKESzr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Nov 2021 14:55:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhKESzq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Nov 2021 14:55:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DA4861215;
        Fri,  5 Nov 2021 18:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636138386;
        bh=hV76Xvv6i74dZtaHM89S+SSEowZvftfggWJ/QqvgC9A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CWKwmniUzpPJBNFQqPVW84z1S1LeA9Ybf8lyPWOKfKteIJ/hJduQzc7aPDHTO9Xtu
         VgmaFnsGK2q0Q3NyhjpyjzImoy8AcZ67iCozwO35kfCVlJzxuNeCFMiBWhm+N1kFu7
         j9eNWuvKukTYliq0SGSdpe/IRRdHckZEPy7Foj7w9CsIM9dcy5b7N0Mh8ce77qauqr
         jh0EqjsyEPtUSqvckX2itIJXG6i/bKH2ygC2X6g/8qdvQzK0dXPyg1gslA0FFuh+RW
         lqzNKfqEJJ6/Bw/jcPokr12IGlU/85FUCO1zzDSxBxLyjq+QpH8x3xYaAZULuE2S+M
         433SIGs6Xb1uA==
Date:   Fri, 5 Nov 2021 13:53:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     =?iso-8859-1?Q?J=F6rg_R=F6del?= <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        iommu@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: Re: How to reduce PCI initialization from 5 s (1.5 s adding them to
 IOMMU groups)
Message-ID: <20211105185304.GA936068@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de6706b2-4ea5-ce68-6b72-02090b98630f@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 05, 2021 at 12:56:09PM +0100, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On a PowerEdge T440/021KCD, BIOS 2.11.2 04/22/2021, Linux 5.10.70 takes
> almost five seconds to initialize PCI. According to the timestamps, 1.5 s
> are from assigning the PCI devices to the 142 IOMMU groups.
> 
> ```
> $ lspci | wc -l
> 281
> $ dmesg
> […]
> [    2.918411] PCI: Using host bridge windows from ACPI; if necessary, use
> "pci=nocrs" and report a bug
> [    2.933841] ACPI: Enabled 5 GPEs in block 00 to 7F
> [    2.973739] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-16])
> [    2.980398] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
> ClockPM Segments MSI HPX-Type3]
> [    2.989457] acpi PNP0A08:00: _OSC: platform does not support [LTR]
> [    2.995451] acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability]
> [    3.001394] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using
> BIOS configuration
> [    3.010511] PCI host bridge to bus 0000:00
> […]
> [    6.233508] system 00:05: [io  0x1000-0x10fe] has been reserved
> [    6.239420] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    6.239906] pnp: PnP ACPI: found 6 devices

For ~280 PCI devices, (6.24-2.92)/280 = 0.012 s/dev.  On my laptop I
have about (.66-.37)/36 = 0.008 s/dev (on v5.4), so about the same
ballpark.

Faster would always be better, of course.  I assume this is not really
a regression?

> [    6.989016] pci 0000:d7:05.0: disabled boot interrupts on device
> [8086:2034]
> [    6.996063] PCI: CLS 0 bytes, default 64
> [    7.000008] Trying to unpack rootfs image as initramfs...
> [    7.065281] Freeing initrd memory: 5136K
> […]
> [    7.079098] DMAR: dmar7: Using Queued invalidation
> [    7.083983] pci 0000:00:00.0: Adding to iommu group 0
> […]
> [    8.537808] pci 0000:d7:17.1: Adding to iommu group 141

I don't have this iommu stuff turned on and don't know what's
happening here.

> Is there anything that could be done to reduce the time?
> 
> 
> Kind regards,
> 
> Paul
