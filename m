Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9D82B35A7
	for <lists+linux-pci@lfdr.de>; Sun, 15 Nov 2020 16:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgKOPLq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Nov 2020 10:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgKOPLq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Nov 2020 10:11:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC4BC0613D1;
        Sun, 15 Nov 2020 07:11:46 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605453104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BiZgDCmSDSxFhb+kif0umV6sJo4+v4DAm7HzC6Uu7YE=;
        b=pUgU0cAnlQBXxUyB3cNYGu1WF0g/EettZwT5S15yQQ6f1/D9zAR5sDgO7Azdh3/eEB1Jkq
        tB8nIaOOs+OfjKtFfhQnE0sJVsHtufu8FT5Ba6gK7rrZ4ADETO6m8Lvc5QPZP2bAT4vMO+
        rQH2ZldFdcLpMU760Aw3GDGUVcwXsWAfxbKixZkCY0FyblgSeCfdcQYTn1mAJnFTfWX/vP
        Hdqyi9bdN2V9hfXWGRcx8lKTpjJoduaxXCcBg1dtvjNT3t4MHS9Qbq6zPXm++nE8EAOUb6
        IvcDKgfStp6BFm6gMMku2tBb5sFsrV6p/VHJ73w0TSRz3uNgEPlOy2aKSpGu4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605453104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BiZgDCmSDSxFhb+kif0umV6sJo4+v4DAm7HzC6Uu7YE=;
        b=W2pTExk0gsbMHLbIitLdUNMJTp/0jOTWLFrWWBeFMegpYuUxW4Yz4c/5CsI7FWJj3wHGTT
        4FLSrYGdk2AB1xBw==
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, kernelfans@gmail.com,
        andi@firstfloor.org, hpa@zytor.com, bhe@redhat.com, x86@kernel.org,
        okaya@kernel.org, mingo@redhat.com, jay.vosburgh@canonical.com,
        dyoung@redhat.com, gavin.guo@canonical.com,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>, bp@alien8.de,
        bhelgaas@google.com, shan.gavin@linux.alibaba.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel@gpiccoli.net,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        ddstreet@canonical.com, lukas@wunner.de, vgoyal@redhat.com
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
In-Reply-To: <87sg9almmg.fsf@x220.int.ebiederm.org>
References: <20201114212215.GA1194074@bjorn-Precision-5520> <87v9e6n2b2.fsf@x220.int.ebiederm.org> <87sg9almmg.fsf@x220.int.ebiederm.org>
Date:   Sun, 15 Nov 2020 16:11:43 +0100
Message-ID: <874klqac40.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 15 2020 at 08:29, Eric W. Biederman wrote:
> ebiederm@xmission.com (Eric W. Biederman) writes:
> For ordinary irqs you can have this with level triggered irqs
> and the kernel has code that will shutdown the irq at the ioapic
> level.  Then the kernel continues by polling the irq source.
>
> I am still missing details but my first question is can our general
> solution to screaming level triggered irqs apply?

No.

> How can edge triggered MSI irqs be screaming?
>
> Is there something we can do in enabling the APICs or IOAPICs that
> would allow this to be handled better.  My memory when we enable
> the APICs and IOAPICs we completely clear the APIC entries and so
> should be disabling sources.

Yes, but MSI has nothing to do with APIC/IOAPIC

> Is the problem perhaps that we wind up using an APIC entry that was
> previously used for the MSI interrupt as something else when we
> reprogram them?  Even with this why doesn't the generic code
> to stop screaming irqs apply here?

Again. No. The problem cannot be solved at the APIC level. The APIC is
the receiving end of MSI and has absolutely no control over it.

An MSI interrupt is a (DMA) write to the local APIC base address
0xfeexxxxx which has the target CPU and control bits encoded in the
lower bits. The written data is the vector and more control bits.

The only way to stop that is to shut it up at the PCI device level.

Assume the following situation:

  - PCI device has MSI enabled and a valid target vector assigned

  - Kernel crashes

  - Kdump kernel starts

  - PCI device raises interrupts which result in the MSI write

  - Kdump kernel enables interrupts and the pending vector is raised in
    the CPU.

  - The CPU has no interrupt descriptor assigned to the vector
    and does not even know where the interrupt originated from. So it
    treats it like any other spurious interrupt to an unassigned vector,
    emits a ratelimited message and ACKs the interrupt at the APIC.

  - PCI device behaves stupid and reraises the interrupt for whatever
    reason.

  - Lather, rinse and repeat.

Unfortunately there is no way to tell the APIC "Mask vector X" and the
dump kernel does neither know which device it comes from nor does it
have enumerated PCI completely which would reset the device and shutup
the spew. Due to the interrupt storm it does not get that far.

Thanks,

        tglx
