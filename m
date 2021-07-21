Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9473D09A4
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 09:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbhGUGo7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 02:44:59 -0400
Received: from verein.lst.de ([213.95.11.211]:57658 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235969AbhGUGoQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 21 Jul 2021 02:44:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B573767373; Wed, 21 Jul 2021 09:24:45 +0200 (CEST)
Date:   Wed, 21 Jul 2021 09:24:45 +0200
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
Message-ID: <20210721072445.GA11257@lst.de>
References: <20210715120844.636968-1-ming.lei@redhat.com> <20210715120844.636968-2-ming.lei@redhat.com> <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com> <20210719094414.GC431@lst.de> <87lf60cevz.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf60cevz.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21, 2021 at 09:20:00AM +0200, Thomas Gleixner wrote:
> > Just walking the list seems fine to me given that this is not a
> > performance criticial path.  But what are the locking implications?
> 
> At the moment there are none because the list is initialized in the
> setup path and never modified afterwards. Though that might change
> sooner than later to fix the virtio wreckage vs. MSI-X.

What is the issue there?  Either way, if we keep the helper in the
IRQ code it should be easy to spot for anyone adding the locking.

> > Also does the above imply this won't work for your platform MSI case?
> 
> The msi descriptors are attached to struct device and independent of
> platform/PCI/whatever.

That's what I assumed, but this text from John suggested there is
something odd about the platform case:

"Did you consider that for PCI .."
