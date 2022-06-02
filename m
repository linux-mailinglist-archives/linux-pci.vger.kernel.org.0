Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852F753BD1C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 19:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbiFBRTT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 13:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbiFBRTS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 13:19:18 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8206E20873B
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 10:19:17 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id u8so3984299qvj.2
        for <linux-pci@vger.kernel.org>; Thu, 02 Jun 2022 10:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s4YbZJYHvK3nVAxdvdm+/MuYfvjkcChJJ4+lAokhsws=;
        b=oY3UkNUXzvT4gdwz2capbciaRVMUwQe4uTXMNLZq5rB+SzgWV5Y9KoY1sDKwk8gWEZ
         3+Q6uw1zQKFy/Unx4HtSstHVhLVkyZWxIMc80Ov1HAVUKCwD358EREeYDHhZDZ8k2MZs
         bhOn53kb4QxCMIITNdm+0c1NDnpndPfQjTJuD8TnE5Uv3cFfjqWJqQft0Z4nj9YH3uBX
         nPBbjR1L9pvnoVrAHHIKs0Q9BrMid/o8PxXfUbP6XGG/0m5N+an4nPqyjM2uURiJ8hW5
         nebfcv+yWDiGXnYLe+dR4uJdRKeLgQOn7tZfDT3mAn3r317E5qS4d++iGATXbWfBN5kK
         ZpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s4YbZJYHvK3nVAxdvdm+/MuYfvjkcChJJ4+lAokhsws=;
        b=1OzuXrA5o/hnFQKyvkhqCeUrSWgL9OVe+K6IeCSS8VpkOPOmOjYbkxKnRHWCmz3Sbo
         bE3oD7tYVdnrpC3S40JpSqgpf3zn7zHp/u8PHAz9f8btlNlh9CT32dV/GoJiQu2d4FPm
         axN+jFSuNzGbk8kUCFFJyKgpGvqz5t/T7TfEHAQeFXHtexhe5+QN4cn7lrYvNjBNby6i
         IsUoxJ4n47mI4ehiLwfbxk9ndIf3uUcjOVnpB1cQfpTocoZAZt3xIVcr6QZfQjfLJWaF
         cFpxJMRTS/2sUTn1PJ9j9kBPSCVHs5seuSEPXIB3uX8euPUm2f8a/+FsfaWODxSSzCL2
         83HA==
X-Gm-Message-State: AOAM5312HzpLjnlWUyQg2+UfJP3YjMGqdizCEy/AS0tsKhjeL+xZAapH
        V3+hT1TLnPtFAt/64hY/MCR5Sg==
X-Google-Smtp-Source: ABdhPJyTeRjkxp4FkIVBkBdxqYlIi1Ql4U5vaRWOEfB4UJA8nUT6ExwG7uYWv1AjNIltcvnn29cQ7w==
X-Received: by 2002:ad4:5b81:0:b0:465:ded8:780 with SMTP id 1-20020ad45b81000000b00465ded80780mr6281647qvp.119.1654190356566;
        Thu, 02 Jun 2022 10:19:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id p200-20020a3742d1000000b0069fc13ce1e7sm3510487qka.24.2022.06.02.10.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 10:18:55 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nwoSV-00GUM1-QB; Thu, 02 Jun 2022 14:18:07 -0300
Date:   Thu, 2 Jun 2022 14:18:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220602171807.GM2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
 <20220527190307.GG2960187@ziepe.ca>
 <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
 <20220602000038.GK2960187@ziepe.ca>
 <400baba7-1cd6-09d4-4de9-2a73f08afc79@deltatee.com>
 <20220602163059.GL2960187@ziepe.ca>
 <28824558-4fd5-e054-6c8d-5e045d52f795@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28824558-4fd5-e054-6c8d-5e045d52f795@deltatee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 02, 2022 at 10:45:55AM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2022-06-02 10:30, Jason Gunthorpe wrote:
> > On Thu, Jun 02, 2022 at 10:16:10AM -0600, Logan Gunthorpe wrote:
> > 
> >>> Just stuff the pages into the mmap, and your driver unprobe will
> >>> automatically block until all the mmaps are closed - no different than
> >>> having an open file descriptor or something.
> >>
> >> Oh is that what we want?
> > 
> > Yes, it is the typical case - eg if you have a sysfs file open unbind
> > hangs indefinitely. Many drivers can't unbind while they have open file
> > descriptors/etc.
> > 
> > A couple drivers go out of their way to allow unbinding while a live
> > userspace exists but this can get complicated. Usually there should be
> > a good reason.
> 
> This is not my experience. All the drivers I've worked with do not block
> unbind with open file descriptors (at least for char devices). I know,
> for example, that having a file descriptor open of /dev/nvmeX does not
> cause unbinding to block.

So there are lots of bugs in the kernel, and I've seen many drivers
that think calling cdev_device_del() is all they need to do - and then
happily allow cdev ioctl's/etc on a de-initialized driver struct.

Drivers that do take care of this usually have to put a lock around
all their fops to serialize against unbind. RDMA uses SRCU, iirc TPM
used a rwlock. But this is tricky and hurts fops performance.

I don't know what nvme did to protect against this, I didn't notice
an obvious lock.

> I figured this was the expectation as the userspace process doing
> the unbind won't be able to be interrupted seeing there's no way to
> fail on that path. Though, it certainly would make things a lot
> easier if the unbind can block indefinitely as it usually requires
> some complicated locking.

As I said, this is what sysfs does today and I don't see that ever
changing. If you userspace has a sysfs file open then the driver
unbind hangs until the file is closed.

So, doing as bad as sysfs seems like a reasonable baseline to me.

> Do you have an example of this? What mechanisms are developers using to
> block unbind with open file descriptors?

Sysfs maintains a refcount with a bias that is basically a fancied
rwlock. Most places use some kind of refcount triggering a
completion. Sleep on the completion until refcount is 0 on unbind kind
of thing.

Jason
