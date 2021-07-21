Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F683D180F
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 22:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240557AbhGUTlh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 15:41:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49336 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240512AbhGUTlf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 15:41:35 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626898930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=13AKBfJpRbWB/hAHCzyxNaRiYHnfqT7SMZklEKL2SbM=;
        b=IZ8vGcjKDv10xjNMxbvG9JXHQONzSs/4lNNhSqj1OtMgkdz3l7Lvm6Rpbiqp3SMOUR9tUI
        eeoitoqe7bYwxX2/g7W2/I41DeaDVbn8G34zxPOe47CwhVPb6SecWtntqacylntcIgYlcI
        Ujs0M4eAeBuegH0FeBSlmv8kqgv5Q9H2c9vRkV7ZsmzuMhcoBDK/jSUpYMFPp2SMq0bfWI
        J0Reg8glcWZEcqigQOTy/k5+A3io6AyYbyM0CRwS9C69XiXREz7EoDIE/kUo++N8+RcG4K
        gv4u8DeLuG5kHz8e7/aeju+0ZV+hc1Nyxh2XTdu9/+jpZzOOLMFNsCZskMORXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626898930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=13AKBfJpRbWB/hAHCzyxNaRiYHnfqT7SMZklEKL2SbM=;
        b=ghlz/kVNYaYUjvjhF4jkU+7xzhPV9t+wujENU+wbeyY5GDazP0D7JYCidPSx2gVdW+I7lL
        bkSzuKI8xSefxaBw==
To:     John Garry <john.garry@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed if any irq is managed
In-Reply-To: <fe34623e-1074-862d-e822-7359ae4def0f@huawei.com>
References: <20210715120844.636968-1-ming.lei@redhat.com> <20210715120844.636968-2-ming.lei@redhat.com> <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com> <20210719094414.GC431@lst.de> <87lf60cevz.ffs@nanos.tec.linutronix.de> <20210721072445.GA11257@lst.de> <fe34623e-1074-862d-e822-7359ae4def0f@huawei.com>
Date:   Wed, 21 Jul 2021 22:22:10 +0200
Message-ID: <87y29zpgct.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 21 2021 at 10:44, John Garry wrote:
> On 21/07/2021 08:24, Christoph Hellwig wrote:
>> On Wed, Jul 21, 2021 at 09:20:00AM +0200, Thomas Gleixner wrote:
>>>> Also does the above imply this won't work for your platform MSI case?
>>> The msi descriptors are attached to struct device and independent of
>>> platform/PCI/whatever.
>> That's what I assumed, but this text from John suggested there is
>> something odd about the platform case:
>> 
>> "Did you consider that for PCI .."
>> .
>
> For this special platform MSI case there is a secondary interrupt 
> controller (called mbigen) which generates the MSI on behalf of the 
> device, which I think the MSI belongs to (and not the device, itself).

MBIGEN is a different story because it converts wired interrupts into
MSI interrupts, IOW a MSI based interrupt pin extender.

I might be wrong, but I seriously doubt that any multiqueue device which
wants to use affinity managed interrupts is built on top of that.

Thanks,

        tglx
