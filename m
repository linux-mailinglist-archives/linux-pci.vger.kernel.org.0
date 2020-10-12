Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8476D28C0E5
	for <lists+linux-pci@lfdr.de>; Mon, 12 Oct 2020 21:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391456AbgJLTHb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Oct 2020 15:07:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391418AbgJLTH3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Oct 2020 15:07:29 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4584420757;
        Mon, 12 Oct 2020 19:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602529648;
        bh=N1Bz5SFUBtN33btTW4CFAYvDZVJs5i4/jF03Njc6Kcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eieYB6gSfhu9nNioTR91eaVn7xorKrvvSOwf+8h30F/RY2+cDB2HdxAz5xV6AUHyV
         RxtuTddN79/vIiU/Hvz9DSECR9Ctqq3gGSp12KeDT73lgzfS9B2GAcu2KqSiE8qnrN
         MJgpTpvificXntQ9o7T60feg6tOFF0zS4bFhCxBY=
Date:   Mon, 12 Oct 2020 12:07:26 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Chris Friesen <chris.friesen@windriver.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Subject: Re: PCI, isolcpus, and irq affinity
Message-ID: <20201012190726.GB1032142@dhcp-10-100-145-180.wdl.wdc.com>
References: <20201012165839.GA3732859@bjorn-Precision-5520>
 <87a6wrqqpf.fsf@nanos.tec.linutronix.de>
 <df1be4be-88b5-b848-97bf-4c38824e840a@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <df1be4be-88b5-b848-97bf-4c38824e840a@windriver.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 12, 2020 at 12:58:41PM -0600, Chris Friesen wrote:
> On 10/12/2020 11:50 AM, Thomas Gleixner wrote:
> > On Mon, Oct 12 2020 at 11:58, Bjorn Helgaas wrote:
> > > On Mon, Oct 12, 2020 at 09:49:37AM -0600, Chris Friesen wrote:
> > > > I've got a linux system running the RT kernel with threaded irqs.  On
> > > > startup we affine the various irq threads to the housekeeping CPUs, but I
> > > > recently hit a scenario where after some days of uptime we ended up with a
> > > > number of NVME irq threads affined to application cores instead (not good
> > > > when we're trying to run low-latency applications).
> > 
> > These threads and the associated interupt vectors are completely
> > harmless and fully idle as long as there is nothing on those isolated
> > CPUs which does disk I/O.
> 
> Some of the irq threads are affined (by the kernel presumably) to multiple
> CPUs (nvme1q2 and nvme0q2 were both affined 0x38000038, a couple of other
> queues were affined 0x1c00001c0).

That means you have more CPUs than your controller has queues. When that
happens, some sharing of the queue resources among CPUs is required.
 
> In this case could disk I/O submitted by one of those CPUs end up
> interrupting another one?

If you dispatch IO from any CPU in the mask, then the completion side
wakes the thread to run on one of the CPUs in the affinity mask.
