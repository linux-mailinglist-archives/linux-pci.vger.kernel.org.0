Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82633D7F59
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 22:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhG0Ui7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 16:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhG0Ui6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jul 2021 16:38:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366DAC061757;
        Tue, 27 Jul 2021 13:38:58 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627418336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=XrDU59J2chpqqCbqiqs6ep6N/JCC9F6maT4GjD59HFg=;
        b=jTE/ZIuhOTfR8FQx+kS0I276+IP4amFfrt9i66ikwlve94UltC+YX0xdcDJtujfK7UvmnN
        61s0yAm5fvWvNBSVZJmUMvrvSMas2KelOWBsnsZoowFowxskqP8D+o2KiWEvTI3k9JdL3d
        LNVYcjtx/gSnM2QVGp6sWvBDdBZy96e9vsM35o7vZpC4gLqESS6jKf1Z6oDDjbIHuwheaB
        65zOoeuGQJXwjz3+GKVy9LOQKtQ1ZHmMPDVajdP4COraqVgDtP8W98iiHlFs3kYp+NUmxs
        NIyYjtJ6tvlB4H4yugFr4J9NYA6rAbXzIyDpkLEjw2zHqA5uPud8C3yGSF8Uig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627418336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=XrDU59J2chpqqCbqiqs6ep6N/JCC9F6maT4GjD59HFg=;
        b=LG5DrvckwlNy7Zdo7uKtPW0SmeOo4w737W6WcII54oSotqWOrCEdWT3T0tkRxhFKV369rG
        CkAUgdsLoFfRXcDw==
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj\, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: Re: [patch 0/8] PCI/MSI, x86: Cure a couple of inconsistencies
In-Reply-To: <20210722214350.GA349746@bjorn-Precision-5520>
Date:   Tue, 27 Jul 2021 22:38:56 +0200
Message-ID: <87sfzz331b.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn,

On Thu, Jul 22 2021 at 16:43, Bjorn Helgaas wrote:
> On Wed, Jul 21, 2021 at 09:11:26PM +0200, Thomas Gleixner wrote:
>> A recent discussion about the PCI/MSI management for virtio unearthed a
>> violation of the MSI-X specification vs. writing the MSI-X message: under
>> certain circumstances the entry is written without being masked.
>> 
>> While looking at that and the related violation of the x86 non-remapped
>> interrupt affinity mechanism a few other issues were discovered by
>> inspection.
>> 
>> The following series addresses these.
>> 
>> Note this does not fix the virtio issue, but while staring at the above
>> problems I came up with a plan to address this. I'm still trying to
>> convince myself that I can get away without sprinkling locking all over the
>> place, so don't hold your breath that this will materialize tomorrow.
>> 
>> The series is also available from git:
>> 
>>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git irq/msi
>> 
>> Thanks,
>> 
>> 	tglx
>> ---
>>  arch/x86/kernel/apic/io_apic.c |    6 +-
>>  arch/x86/kernel/apic/msi.c     |   11 +++-
>>  arch/x86/kernel/hpet.c         |    2 
>>  drivers/pci/msi.c              |   98 +++++++++++++++++++++++++++--------------
>>  include/linux/irq.h            |    2 
>>  kernel/irq/chip.c              |    5 +-
>>  6 files changed, 85 insertions(+), 39 deletions(-)
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> for the PCI pieces.
>
> I'm happy to take the whole series via PCI, given an x86 ack.  Or you
> can merge with my ack.

Let me repost it first with the various review comments fixed. I'm also
having a fix for the VFIO muck in the pipeline which will be based on
this and also requires changes to the irq core. Let me think about the
best way to get this routed.

Thanks,

        tglx


