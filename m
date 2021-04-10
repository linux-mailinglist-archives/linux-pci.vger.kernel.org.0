Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AF135AF0E
	for <lists+linux-pci@lfdr.de>; Sat, 10 Apr 2021 18:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhDJQ0k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Apr 2021 12:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234334AbhDJQ0k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Apr 2021 12:26:40 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D683C06138A
        for <linux-pci@vger.kernel.org>; Sat, 10 Apr 2021 09:26:25 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id A2CCC300002CB;
        Sat, 10 Apr 2021 18:26:22 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 8D2154C22F; Sat, 10 Apr 2021 18:26:22 +0200 (CEST)
Date:   Sat, 10 Apr 2021 18:26:22 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     linux-pci@vger.kernel.org
Subject: Re: PCI service interrupt handlers & access to PCI config space
Message-ID: <20210410162622.GA23381@wunner.de>
References: <20210410122845.nhenihbygmcjlegn@pali>
 <20210410142524.GA31187@wunner.de>
 <20210410151709.yb42uloq3aiwcoog@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210410151709.yb42uloq3aiwcoog@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Apr 10, 2021 at 05:17:09PM +0200, Pali Rohár wrote:
> On Saturday 10 April 2021 16:25:24 Lukas Wunner wrote:
> > raw_spin_locks are not supposed to be held for a prolonged
> > period of time.
> 
> What is "prolonged period of time"? Because for example PCIe controller
> on A3720 has upper limit about 1.5s when accessing config space. This is
> what I measured in real example. It really took PCIe HW more than 1s to
> return error code if it happens.

Linux Device Drivers (2005) says:

   "The last important rule for spinlock usage is that spinlocks must
    always be held for the minimum time possible. The longer you hold
    a lock, the longer another processor may have to spin waiting for
    you to release it, and the chance of it having to spin at all is
    greater. Long lock hold times also keep the current processor from
    scheduling, meaning that a higher priority process -- which really
    should be able to get the CPU -- may have to wait. The kernel
    developers put a great deal of effort into reducing kernel latency
    (the time a process may have to wait to be scheduled) in the 2.5
    development series. A poorly written driver can wipe out all that
    progress just by holding a lock for too long. To avoid creating
    this sort of problem, make a point of keeping your lock-hold times
    short."

1.5 sec is definitely too long.  This sounds like a quirk of this
specific hardware.  Try to find out if the hardware can be configured
differently to respond quicker.


> > The interrupt is masked when it triggers and until it's been handled,
> > so the interrupt handler never runs multiple times concurrently.
> > See e.g. handle_level_irq() in kernel/irq/chip.c.
> 
> I'm thinking if it is really safe here. On dual-core system, there may
> be two tasks (on each CPU) which calls pcie_capability_read_word() (or
> other access function). Exactly one pass pci lock. And after that two
> different interrupts (for each CPU) may occur which handlers would like
> to call pcie_capability_read_word(). raw_spin_lock_irqsave (which is
> called from pci_lock_config()) disable interrupts on local CPU, right?
> But what with second CPU? Could not be there issue?

No.


> And what would happen if pcie_capability_read_word() is locked for 1.5s
> as described above? Does not look safe for me.

It's safe, but performs poorly.

Thanks,

Lukas
