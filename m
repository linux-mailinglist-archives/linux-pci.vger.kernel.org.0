Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C766D3D17BD
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 22:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhGUTdv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 15:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhGUTdv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 15:33:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94347C061575;
        Wed, 21 Jul 2021 13:14:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626898465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ak+Uz43ZCaKXyDfbDB4j2Tp/dhk7l2jrFbDe0ZeXqe8=;
        b=vVaCphZ/jjIrDSH1QTS7rs6NyR5B0Ujii1SubrsFPHXLn+QIQzFjgkzYTpOIXa+px6gD/n
        4nI5KvVtN36fMSJAm+55kRDNNseodmKhGi2jyj4qb/7p5CyJeQqfZ8DSeYuKpaChbe5MS2
        S+mIohlnzf7AwnCGGQwMc+M3Y1mkxx6Jh6obdSjb4Y39FdoY7FMySyeLefpXzkJrkhv/nL
        me7MkFb1iPhqRFQoEJ7PjKtJ7rIFY2c18bJuIQJbgyMMjwX2ObgzAZZkxdD5sASUgvrWL+
        iTMJqAT7yZXGZion8cRVyfbb0j4219BMrVbN3U18XWyvpISwDTFtJMBIOFN81A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626898465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ak+Uz43ZCaKXyDfbDB4j2Tp/dhk7l2jrFbDe0ZeXqe8=;
        b=XCIdlprRE3sr0wL5gMBZtUbRE+wbS41wXwE+yCmyf3noZk6JUIUaUb0jMMrOyCc00BmY10
        NFogrSbcr1D42gAw==
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
In-Reply-To: <20210721072445.GA11257@lst.de>
References: <20210715120844.636968-1-ming.lei@redhat.com> <20210715120844.636968-2-ming.lei@redhat.com> <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com> <20210719094414.GC431@lst.de> <87lf60cevz.ffs@nanos.tec.linutronix.de> <20210721072445.GA11257@lst.de>
Date:   Wed, 21 Jul 2021 22:14:25 +0200
Message-ID: <871r7rqva6.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21 2021 at 09:24, Christoph Hellwig wrote:

> On Wed, Jul 21, 2021 at 09:20:00AM +0200, Thomas Gleixner wrote:
>> > Just walking the list seems fine to me given that this is not a
>> > performance criticial path.  But what are the locking implications?
>> 
>> At the moment there are none because the list is initialized in the
>> setup path and never modified afterwards. Though that might change
>> sooner than later to fix the virtio wreckage vs. MSI-X.
>
> What is the issue there?  Either way, if we keep the helper in the
> IRQ code it should be easy to spot for anyone adding the locking.

  https://lore.kernel.org/r/87o8bxcuxv.ffs@nanos.tec.linutronix.de

TLDR: virtio allocates ONE irq on msix_enable() and then when the guest
actually unmasks another entry (e.g. request_irq()), it tears down the
allocated one and set's up two. On the third one this repeats ....

There are only two options:

  1) allocate everything upfront, which is undesired
  2) append entries, which might need locking, but I'm still trying to
     avoid that

There is another problem vs. vector exhaustion which can't be fixed that
way, but that's a different story.

Thanks,

        tglx
