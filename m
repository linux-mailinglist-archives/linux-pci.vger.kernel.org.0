Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8F53D182C
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 22:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhGUTw0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 15:52:26 -0400
Received: from verein.lst.de ([213.95.11.211]:60006 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230173AbhGUTw0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Jul 2021 15:52:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 691A967373; Wed, 21 Jul 2021 22:32:59 +0200 (CEST)
Date:   Wed, 21 Jul 2021 22:32:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Christoph Hellwig <hch@lst.de>, John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity
 managed if any irq is managed
Message-ID: <20210721203259.GA18960@lst.de>
References: <20210715120844.636968-1-ming.lei@redhat.com> <20210715120844.636968-2-ming.lei@redhat.com> <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com> <20210719094414.GC431@lst.de> <87lf60cevz.ffs@nanos.tec.linutronix.de> <20210721072445.GA11257@lst.de> <871r7rqva6.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r7rqva6.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 10:14:25PM +0200, Thomas Gleixner wrote:
>   https://lore.kernel.org/r/87o8bxcuxv.ffs@nanos.tec.linutronix.de
> 
> TLDR: virtio allocates ONE irq on msix_enable() and then when the guest
> actually unmasks another entry (e.g. request_irq()), it tears down the
> allocated one and set's up two. On the third one this repeats ....
> 
> There are only two options:
> 
>   1) allocate everything upfront, which is undesired
>   2) append entries, which might need locking, but I'm still trying to
>      avoid that
> 
> There is another problem vs. vector exhaustion which can't be fixed that
> way, but that's a different story.

FTI, NVMe is similar.  We need one IRQ to setup the admin queue,
which is used to query/set how many I/O queues are supported.  Just
two steps though and not unbound.
