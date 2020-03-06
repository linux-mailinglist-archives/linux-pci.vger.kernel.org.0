Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACEFF17BDC0
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 14:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgCFNIu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 08:08:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53331 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbgCFNIt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2020 08:08:49 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jACiU-0003fj-TI; Fri, 06 Mar 2020 14:08:38 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 1125CFF8FB;
        Fri,  6 Mar 2020 14:08:38 +0100 (CET)
Message-Id: <20200306130341.199467200@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 06 Mar 2020 14:03:41 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [patch 0/7] genirq/PCI: Sanitize interrupt injection
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kuppuswamy triggered a NULL pointer dereference via the AER error injection
mechanism in the low level APIC code.

 https://lore.kernel.org/r/f54208d62407901b5de15ce8c3d078c70fc7a1d0.1582313239.git.sathyanarayanan.kuppuswamy@linux.intel.com

It turned out that AER error injection is calling generic_handle_irq() from
task context which is unsafe for x86 interrupts which end up being handled
by the APIC. The fragile interrupt affinity handling which is imposed by
the x86 hardware does not allow to call into this code except from actual
interrupt context.

While the pointer could be checked this would just paper over the problem
and still be able to trigger warnings or silently corrupting state.

This series addresses the problem:

  - Prevent the invocation of generic_handle_irq() from non interrupt
    context on affected interrupts.

  - Add a few missing sanity checks to the existing debugfs injection
    mechanism

  - Convert the debugfs injection into a function which can be invoked from
    other places.
  
    This provides a halfways safe interface to inject interrupts via the
    irq_retrigger mechanism which does the injection via IPI.

    This interface is solely for debug and testing purposes as it still can
    make a device interrupts stale on x86 under very obscure and hard to
    hit circumstances. For debug and error injection testing this is
    acceptable. For any other use not.

  - Change the AER code to use the new interface. 

Thanks,

	tglx
----
 arch/x86/kernel/apic/vector.c |    6 +
 drivers/pci/pcie/Kconfig      |    1 
 drivers/pci/pcie/aer_inject.c |    6 -
 include/linux/interrupt.h     |    2 
 include/linux/irq.h           |   13 +++
 kernel/irq/Kconfig            |    5 +
 kernel/irq/chip.c             |    2 
 kernel/irq/debugfs.c          |   28 --------
 kernel/irq/internals.h        |   10 ++
 kernel/irq/irqdesc.c          |    6 +
 kernel/irq/resend.c           |  143 +++++++++++++++++++++++++++++++-----------
 11 files changed, 153 insertions(+), 69 deletions(-)
