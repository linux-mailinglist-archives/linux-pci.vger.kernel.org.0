Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B363A3D19CE
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 00:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhGUV5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 17:57:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhGUV5i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 17:57:38 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626907093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TQLRh+7qGE3VP3wBrZZJmZAEZQxMZFNHuu8FDoGr7e4=;
        b=ppUhdihsnmeHgT0VRBl5aEdERmntnpUGzJB5+6r2tVwqko/N7pm3Q4GLvLTL0dNSfMRfsG
        oODtwJF4ieA/wnsOYYMJAs1mD+NFHv+avmmbGiYmNXY+viV5X3dNFczzCtVYSXR/kh82GH
        AyYg1e356trh5/VaETln7KcZeU4q2rtayTkCC6UK/1NEYgOZV4IKNIQw7h1ZBCjzSvIRDT
        Ue/Jxnvu31y/LXl7t6fQ0XVupJnZbF4BKwK8VgHatCNSt4Gm98IjULU77aBPaKcYbf7zT5
        N+F8RvXwKJX0ULXCIAIln6Sm8if1o3cRFQq8QfeoshKm5l7KioZgOwTKe11zRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626907093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TQLRh+7qGE3VP3wBrZZJmZAEZQxMZFNHuu8FDoGr7e4=;
        b=FrFj5ZapdfSAF5URVUJzeKUnhZgI5j3n/xmpgAAZ7GRVpjqtPUXOHOvlzIzZ7pcohGxaMN
        bVobF87paNH7rSCg==
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@lst.de>, John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed if any irq is managed
In-Reply-To: <20210721203259.GA18960@lst.de>
References: <20210715120844.636968-1-ming.lei@redhat.com> <20210715120844.636968-2-ming.lei@redhat.com> <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com> <20210719094414.GC431@lst.de> <87lf60cevz.ffs@nanos.tec.linutronix.de> <20210721072445.GA11257@lst.de> <871r7rqva6.ffs@nanos.tec.linutronix.de> <20210721203259.GA18960@lst.de>
Date:   Thu, 22 Jul 2021 00:38:07 +0200
Message-ID: <878s1zpa28.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21 2021 at 22:32, Christoph Hellwig wrote:
> On Wed, Jul 21, 2021 at 10:14:25PM +0200, Thomas Gleixner wrote:
>>   https://lore.kernel.org/r/87o8bxcuxv.ffs@nanos.tec.linutronix.de
>> 
>> TLDR: virtio allocates ONE irq on msix_enable() and then when the
>> guest

OOps, sorry that should have been VFIO not virtio.

>> actually unmasks another entry (e.g. request_irq()), it tears down the
>> allocated one and set's up two. On the third one this repeats ....
>> 
>> There are only two options:
>> 
>>   1) allocate everything upfront, which is undesired
>>   2) append entries, which might need locking, but I'm still trying to
>>      avoid that
>> 
>> There is another problem vs. vector exhaustion which can't be fixed that
>> way, but that's a different story.
>
> FTI, NVMe is similar.  We need one IRQ to setup the admin queue,
> which is used to query/set how many I/O queues are supported.  Just
> two steps though and not unbound.

That's fine because that's controlled by the driver consistently and it
(hopefully) makes sure that the admin queue is quiesced before
everything is torn down after the initial query.

But that's not the case for VFIO. It tears down all in use interrupts
and the guest driver is completely oblivious of that.

Assume the following situation:

 1) VM boots with 8 present CPUs and 16 possible CPUs

 2) The passed through card (PF or VF) supports multiqueue and the
    driver uses managed interrupts which e.g. allocates one queue and
    one interrupt per possible CPU.

    Initial setup requests all the interrupts, but only the first 8
    queue interrupts are unmasked and therefore reallocated by the host
    which works by some definition of works because the device is quiet
    at that point.

 3) Host admin plugs the other 8 CPUs into the guest

    Onlining these CPUs in the guest will unmask the dormant managed
    queue interrupts and cause the host to allocate the remaining 8 per
    queue interrupts one by one thereby tearing down _all_ previously
    allocated ones and then allocating one more than before.

    Assume that while this goes on the guest has I/O running on the
    already online CPUs and their associated queues. Depending on the
    device this either will lose interrupts or reroute them to the
    legacy INTx which is not handled. This might in the best case result
    in a few "timedout" requests, but I managed it at least once to make
    the device go into lala land state, i.e. it did not recover.

The above can be fixed by adding an 'append' mode to the MSI code.

But that does not fix the overcommit issue where the host runs out of
vector space. The result is simply that the guest does not know and just
continues to work on device/queues which will never ever recieve an
interrupt (again).

I got educated that all of this is considered unlikely and my argument
that the concept of unlikely simply does not exist at cloud scale got
ignored. Sure, I know it's VIRT and therefore not subject to common
sense.

Thanks,

        tglx



    
    
