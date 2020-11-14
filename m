Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E652B3102
	for <lists+linux-pci@lfdr.de>; Sat, 14 Nov 2020 22:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgKNVWR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 14 Nov 2020 16:22:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgKNVWR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 14 Nov 2020 16:22:17 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 688BC2240B;
        Sat, 14 Nov 2020 21:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605388936;
        bh=U+w0akawZaU6a1+oFAjGYagwhHnCG8PqAfvSWaWCkEo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=zj6IGCEauGEvVOfSfq/G9CmGrwnf22AFECJo3La1cAKC6tvbg0z/n+iVqlDYDHLN3
         /9faAf5KUrLqBYplxFHsgz657aacU8RbUZ4o2CcE8VA3TCkxfxAm0Lx+Cp+0bKSipQ
         bzj9Zn20mpEiaIsQHCjwo6JiqhYhIbzFixJI1QtI=
Date:   Sat, 14 Nov 2020 15:22:15 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, andi@firstfloor.org,
        lukas@wunner.de, okaya@kernel.org, kernelfans@gmail.com,
        ddstreet@canonical.com, gavin.guo@canonical.com,
        jay.vosburgh@canonical.com, kernel@gpiccoli.net,
        shan.gavin@linux.alibaba.com,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
Message-ID: <20201114212215.GA1194074@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7prac67.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael for question about ACPI method for PCI host bridge reset]

On Sat, Nov 14, 2020 at 09:58:08PM +0100, Thomas Gleixner wrote:
> On Sat, Nov 14 2020 at 14:39, Bjorn Helgaas wrote:
> > On Sat, Nov 14, 2020 at 12:40:10AM +0100, Thomas Gleixner wrote:
> >> On Sat, Nov 14 2020 at 00:31, Thomas Gleixner wrote:
> >> > On Fri, Nov 13 2020 at 10:46, Bjorn Helgaas wrote:
> >> >> pci_device_shutdown() still clears the Bus Master Enable bit if we're
> >> >> doing a kexec and the device is in D0-D3hot, which should also disable
> >> >> MSI/MSI-X.  Why doesn't this solve the problem?  Is this because the
> >> >> device causing the storm was in PCI_UNKNOWN state?
> >> >
> >> > That's indeed a really good question.
> >> 
> >> So we do that on kexec, but is that true when starting a kdump kernel
> >> from a kernel crash? I doubt it.
> >
> > Ah, right, I bet that's it, thanks.  The kdump path is basically this:
> >
> >   crash_kexec
> >     machine_kexec
> >
> > while the usual kexec path is:
> >
> >   kernel_kexec
> >     kernel_restart_prepare
> >       device_shutdown
> >         while (!list_empty(&devices_kset->list))
> >           dev->bus->shutdown
> >             pci_device_shutdown            # pci_bus_type.shutdown
> >     machine_kexec
> >
> > So maybe we need to explore doing some or all of device_shutdown() in
> > the crash_kexec() path as well as in the kernel_kexec() path.
> 
> The problem is that if the machine crashed anything you try to attempt
> before starting the crash kernel is reducing the chance that the crash
> kernel actually starts.

Right.

> Is there something at the root bridge level which allows to tell the
> underlying busses to shut up, reset or go into a defined state? That
> might avoid chasing lists which might be already unreliable.

Maybe we need some kind of crash_device_shutdown() that does the
minimal thing to protect the kdump kernel from devices.

The programming model for conventional PCI host bridges and PCIe Root
Complexes is device-specific since they're outside the PCI domain.
There probably *are* ways to do those things, but you would need a
native host bridge driver or something like an ACPI method.  I'm not
aware of an ACPI way to do this, but I added Rafael in case he is.

A crash_device_shutdown() could do something at the host bridge level
if that's possible, or reset/disable bus mastering/disable MSI/etc on
individual PCI devices if necessary.

Bjorn
