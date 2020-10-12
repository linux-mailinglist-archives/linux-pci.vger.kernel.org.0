Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47CB28BE8D
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 18:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390670AbgJLQ6l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 12:58:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390355AbgJLQ6l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Oct 2020 12:58:41 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09E032080A;
        Mon, 12 Oct 2020 16:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602521921;
        bh=nzpHeNWIPNFLwlpS7guO9b9cQhtrmtR1h1vftSjYN8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=t1yECkYpJdNoXc2bxC11umM0kvwjNdyDY+lIc7fSDCqia40P/wwnkaX9sjwBcDs6r
         dnm+OJw9/o2tXrlBLr1BUGvE1Y7pcbW04ye4Fk6jDghvhvZc60HNBWWQ4iGQgsMHZS
         EIyicoFbgDtHnMZL0dy/VFS5Vqjf6ByKYHvYfKJU=
Date:   Mon, 12 Oct 2020 11:58:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Chris Friesen <chris.friesen@windriver.com>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Subject: Re: PCI, isolcpus, and irq affinity
Message-ID: <20201012165839.GA3732859@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83d03f27-d92d-1b28-ad28-cbe5d011fe33@windriver.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Christoph, Thomas, Nitesh]

On Mon, Oct 12, 2020 at 09:49:37AM -0600, Chris Friesen wrote:
> I've got a linux system running the RT kernel with threaded irqs.  On
> startup we affine the various irq threads to the housekeeping CPUs, but I
> recently hit a scenario where after some days of uptime we ended up with a
> number of NVME irq threads affined to application cores instead (not good
> when we're trying to run low-latency applications).

pci_alloc_irq_vectors_affinity() basically just passes affinity
information through to kernel/irq/affinity.c, and the PCI core doesn't
change affinity after that.

> Looking at the code, it appears that the NVME driver can in some scenarios
> end up calling pci_alloc_irq_vectors_affinity() after initial system
> startup, which seems to determine CPU affinity without any regard for things
> like "isolcpus" or "cset shield".
> 
> There seem to be other reports of similar issues:
> 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1831566
> 
> It looks like some SCSI drivers and virtio_pci_common.c will also call
> pci_alloc_irq_vectors_affinity(), though I'm not sure if they would ever do
> it after system startup.
> 
> How does it make sense for the PCI subsystem to affine interrupts to CPUs
> which have explicitly been designated as "isolated"?

This recent thread may be useful:

  https://lore.kernel.org/linux-pci/20200928183529.471328-1-nitesh@redhat.com/

It contains a patch to "Limit pci_alloc_irq_vectors() to housekeeping
CPUs".  I'm not sure that patch summary is 100% accurate because IIUC
that particular patch only reduces the *number* of vectors allocated
and does not actually *limit* them to housekeeping CPUs.

Bjorn
