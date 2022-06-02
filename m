Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FA853BD54
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 19:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbiFBR2Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 13:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiFBR2O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 13:28:14 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADFE21E3E
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 10:28:13 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id r84so4140470qke.10
        for <linux-pci@vger.kernel.org>; Thu, 02 Jun 2022 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GuOinXdzP0oJ6BfwGVGRF9opnqUN4LYO3Y/RmknOScs=;
        b=nERzx0gJZv2PpNEuSU7ZGuwa6QR4KAFkZQcX+7G15YcgRySvW6qb9+1khratoVExRd
         E2cV1E+y5eNUdrv7iEhYvw6adm9tR0J0w0Y5RG/qlzn3N/ExPpw5VFSVcBiyiAfseShj
         RtXbQnx/36eWCdWlBGeV1GIY74fg8syx0d0tBb6JCdM+OFqTrueuf3t4tmn+ivjrfwFi
         G+YqxQ/XoZIxp/zm5ZUgHxZvv3ENrre3J5G2iipdg5D6ioSBpapAVxA8rxNBc3hfH6JN
         xgR8Rb7bKKjuhDjx6rhbKloVBy4fbfQj9wlUkZziCVhgTTnOfjGMKfLsZNNy+YXFPJkc
         II8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GuOinXdzP0oJ6BfwGVGRF9opnqUN4LYO3Y/RmknOScs=;
        b=hXQuRDngy61y7eoPkGlMzPWCcsN+CI2PSbLaXiEyGhClMcssfwjbQn/vt8DNob3NTG
         qzKhlIaXkU57/IDBYkA/WNYM7rLkU7uNCTQhCueKd5V0Mk3D1cB96d9adVKVDp7dQLqd
         L7mb8+0VvNa9VTI/u4ZjVIu9IWfAnlsYZQXFpFlPWvCTIgs7vZYeLg1sSJkS4fGDrvVt
         4QtiIaOwlwYMv0LccwSln68nzLYGP0C/DuOM4Q3q3ArjxDIrZKzDul/tMI5obegxQn4X
         FjYsje/XInbLb1hYw/W7A93sOksHxe+p/nTEDVMnv48S3uPAD33FntTtVv3wZfOId5JS
         boXA==
X-Gm-Message-State: AOAM531YW1D+AHZEV1rWPQYWbAoWPCsC0ZIAnaaZuIk1aFBZNQRcadpD
        YDiZL4Qo1raM44rOmog+bsk/MA==
X-Google-Smtp-Source: ABdhPJxtqXs49dqqYwrrFL2D/sBWEpVH5naaCbeJ3Pryu+awdiRfY3cTorJuf9ghsWhGGy5AkAoh5A==
X-Received: by 2002:a05:620a:f0d:b0:67e:1c14:bc5e with SMTP id v13-20020a05620a0f0d00b0067e1c14bc5emr3899163qkl.502.1654190892765;
        Thu, 02 Jun 2022 10:28:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id q188-20020ae9dcc5000000b0069fc13ce1f2sm3649937qkf.35.2022.06.02.10.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 10:28:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nwocF-00GUaJ-Fg; Thu, 02 Jun 2022 14:28:11 -0300
Date:   Thu, 2 Jun 2022 14:28:11 -0300
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
Message-ID: <20220602172811.GN2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
 <20220527190307.GG2960187@ziepe.ca>
 <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
 <20220602000038.GK2960187@ziepe.ca>
 <400baba7-1cd6-09d4-4de9-2a73f08afc79@deltatee.com>
 <20220602163059.GL2960187@ziepe.ca>
 <51cc6645-2504-6d01-5626-238ed6ffff04@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51cc6645-2504-6d01-5626-238ed6ffff04@deltatee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 02, 2022 at 10:49:15AM -0600, Logan Gunthorpe wrote:
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
> > 
> > The module will already be refcounted anyhow because the mmap points
> > to a char file which holds a module reference - meaning a simple rmmod
> > of the driver shouldn't work already..
> 
> Also, I just tried it... If I open a sysfs file for an nvme device (ie.
> /sys/class/nvme/nvme4/cntlid) and unbind the device, it does not block.
> A subsequent read on that file descriptor returns ENODEV. Which is what
> I would have expected.

Oh interesting, this has been changed since years ago when I last
looked, the kernfs_get_active() is now more narrowed than it once
was. So manybe sysfs isn't the same concern it used to be!

Thanks,
Jason
