Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA96E28F912
	for <lists+linux-pci@lfdr.de>; Thu, 15 Oct 2020 21:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391395AbgJOTC7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 15:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391396AbgJOTC6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Oct 2020 15:02:58 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47795218AC;
        Thu, 15 Oct 2020 19:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602788577;
        bh=XmwWSMo0eELvBiJnmj7ArylEFgswqXPI6QRf3xrv1jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ib8+4E2YNq1DPNFHbPJcGFLj8FKhx2xIDrlha7Wy5CvXTm3zezxYDC+dIiTohTmh0
         dww+tPZDONHZJumO+k0jnrETmxf2iRyTQEmXpfp1pVeVpMm58i4zMAvfG5Zv5xmXYh
         7WFHejOtF2EBpd60fqqOlfau7EORfj7Dt8RPVHdY=
Date:   Thu, 15 Oct 2020 12:02:55 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Chris Friesen <chris.friesen@windriver.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Subject: Re: PCI, isolcpus, and irq affinity
Message-ID: <20201015190255.GA1424788@dhcp-10-100-145-180.wdl.wdc.com>
References: <20201012165839.GA3732859@bjorn-Precision-5520>
 <87a6wrqqpf.fsf@nanos.tec.linutronix.de>
 <df1be4be-88b5-b848-97bf-4c38824e840a@windriver.com>
 <20201012190726.GB1032142@dhcp-10-100-145-180.wdl.wdc.com>
 <c1747780-cfac-abe1-eb58-5de532c28fba@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1747780-cfac-abe1-eb58-5de532c28fba@windriver.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 15, 2020 at 12:47:23PM -0600, Chris Friesen wrote:
> On 10/12/2020 1:07 PM, Keith Busch wrote:
> > On Mon, Oct 12, 2020 at 12:58:41PM -0600, Chris Friesen wrote:
> > > On 10/12/2020 11:50 AM, Thomas Gleixner wrote:
> > > > On Mon, Oct 12 2020 at 11:58, Bjorn Helgaas wrote:
> > > > > On Mon, Oct 12, 2020 at 09:49:37AM -0600, Chris Friesen wrote:
> > > > > > I've got a linux system running the RT kernel with threaded irqs.  On
> > > > > > startup we affine the various irq threads to the housekeeping CPUs, but I
> > > > > > recently hit a scenario where after some days of uptime we ended up with a
> > > > > > number of NVME irq threads affined to application cores instead (not good
> > > > > > when we're trying to run low-latency applications).
> > > > 
> > > > These threads and the associated interupt vectors are completely
> > > > harmless and fully idle as long as there is nothing on those isolated
> > > > CPUs which does disk I/O.
> > > 
> > > Some of the irq threads are affined (by the kernel presumably) to multiple
> > > CPUs (nvme1q2 and nvme0q2 were both affined 0x38000038, a couple of other
> > > queues were affined 0x1c00001c0).
> > 
> > That means you have more CPUs than your controller has queues. When that
> > happens, some sharing of the queue resources among CPUs is required.
> 
> Is it required that every CPU is part of the mask for at least one queue?
>
> If we can preferentially route interrupts to the housekeeping CPUs (for
> queues with multiple CPUs in the mask), how is that different than just
> affining all the queues to the housekeeping CPUs and leaving the isolated
> CPUs out of the mask entirely?

The same mask is used for submission affinity. Any CPU can dispatch IO,
so every CPU has to affine to a queue.
