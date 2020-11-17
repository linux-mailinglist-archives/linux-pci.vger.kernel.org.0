Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332CE2B55A0
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 01:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgKQATL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 19:19:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:39736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKQATK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Nov 2020 19:19:10 -0500
Received: from localhost (189.sub-72-105-114.myvzw.com [72.105.114.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1975124671;
        Tue, 17 Nov 2020 00:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605572349;
        bh=kDKrqYodYxESN/4WV8ScVeWnpTJ+xCMtC3M2GeCGgHI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aS9/l0pmLpn8h38XirPFiboslNrGtRHtv9HdhUgbQphJ9Q6YUSHgyzEb+eTOjafNv
         Ue52B+CUz9NVq+zWbQJNe9cVeiMlmy6PpQIAxM86dOH8t/01KjIg9cfKzmgj7xGoM+
         LvAOsSY+/fo6ZzOgajNMD+dObBCQY0HImu+TXfks=
Date:   Mon, 16 Nov 2020 18:19:07 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>, lukas@wunner.de,
        linux-pci@vger.kernel.org, kernelfans@gmail.com,
        andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org,
        okaya@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com,
        dyoung@redhat.com, gavin.guo@canonical.com, bp@alien8.de,
        bhelgaas@google.com, Guowen Shan <gshan@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel@gpiccoli.net,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        ddstreet@canonical.com, vgoyal@redhat.com
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
Message-ID: <20201117001907.GA1342260@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8238524-4197-c22d-7bae-df61133fcbfe@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 16, 2020 at 05:31:36PM -0300, Guilherme G. Piccoli wrote:
> First of all, thanks everybody for the great insights/discussion! This
> thread ended-up being a great learning for (at least) me.
> 
> Given the big amount of replies and intermixed comments, I wouldn't be
> able to respond inline to all, so I'll try another approach below.
> 
> 
> From Bjorn:
> "I think [0] proposes using early_quirks() to disable MSIs at boot-time.
> That doesn't seem like a robust solution because (a) the problem affects
> all arches but early_quirks() is x86-specific and (b) even on x86
> early_quirks() only works for PCI segment 0 because it relies on the
> 0xCF8/0xCFC I/O ports."
> 
> Ah. I wasn't aware of that limitation, I thought enhancing the
> early_quirks() search to go through all buses would fix that, thanks for
> the clarification! And again, worth to clarify that this is not a
> problem affecting all arches _in practice_ - PowerPC for example has the
> FW primitives allowing a powerful PCI controller (out-of-band) reset,
> preventing this kind of issue usually.
> 
> [0]
> https://lore.kernel.org/linux-pci/20181018183721.27467-1-gpiccoli@canonical.com
> 
> 
> From Bjorn:
> "A crash_device_shutdown() could do something at the host bridge level
> if that's possible, or reset/disable bus mastering/disable MSI/etc on
> individual PCI devices if necessary."
> 
> From Lukas:
> "Guilherme's original patches from 2018 iterate over all 256 PCI buses.
> That might impact boot time negatively.  The reason he has to do that is
> because the crashing kernel doesn't know which devices exist and which
> have interrupts enabled.  However the crashing kernel has that
> information.  It should either disable interrupts itself or pass the
> necessary information to the crashing kernel as setup_data or whatever.

I don't think passing the device information to the kdump kernel is
really practical.  The kdump kernel would use it to do PCI config
writes to disable MSIs before enabling IRQs, and it doesn't know how
to access config space that early.

We could invent special "early config access" things, but that gets
really complicated really fast.  Config access depends on ACPI MCFG
tables, firmware interfaces, and in many cases, on the native host
bridge drivers in drivers/pci/controllers/.

I think we need to disable MSIs in the crashing kernel before the
kexec.  It adds a little more code in the crash_kexec() path, but it
seems like a worthwhile tradeoff.

Bjorn
