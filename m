Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E413D1F3D
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 09:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhGVHFo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 03:05:44 -0400
Received: from verein.lst.de ([213.95.11.211]:33081 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230048AbhGVHFn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 03:05:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DFF7167373; Thu, 22 Jul 2021 09:46:15 +0200 (CEST)
Date:   Thu, 22 Jul 2021 09:46:15 +0200
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
Message-ID: <20210722074615.GA2292@lst.de>
References: <20210715120844.636968-1-ming.lei@redhat.com> <20210715120844.636968-2-ming.lei@redhat.com> <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com> <20210719094414.GC431@lst.de> <87lf60cevz.ffs@nanos.tec.linutronix.de> <20210721072445.GA11257@lst.de> <871r7rqva6.ffs@nanos.tec.linutronix.de> <20210721203259.GA18960@lst.de> <878s1zpa28.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s1zpa28.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 22, 2021 at 12:38:07AM +0200, Thomas Gleixner wrote:
> That's fine because that's controlled by the driver consistently and it
> (hopefully) makes sure that the admin queue is quiesced before
> everything is torn down after the initial query.

Yes, it is.

> The above can be fixed by adding an 'append' mode to the MSI code.

So IFF we get that append mode I think it would help to simplify
drivers that have unmanaged pre and post vectors, and/or do the above
proving.

So instead of currently requesting a single unmanaged vector, do
basic setup, tear it down, request N managed vectors with an unmanaged
pre-vector we could just keep the unmanaged vector, never tear it down
and just append the post vectors.  In the long run this could remove
the need to do the pre and post vectors entirely.
