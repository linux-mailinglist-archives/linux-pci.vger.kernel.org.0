Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B7141F754
	for <lists+linux-pci@lfdr.de>; Sat,  2 Oct 2021 00:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355629AbhJAWPw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 18:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355605AbhJAWPw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 18:15:52 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B36C06177E
        for <linux-pci@vger.kernel.org>; Fri,  1 Oct 2021 15:14:07 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id cv2so6456522qvb.5
        for <linux-pci@vger.kernel.org>; Fri, 01 Oct 2021 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dlj3GwcHZB/hfgpWys67iaiDnLMMEzD7BT0/JUJOZSA=;
        b=EYJBCgdxRWFQwama5Ss0sx2D4qnIU/NFx7XF8E6GPLVVfNfvYaFMHC2BJIcCXsVoIF
         iCVvjpeBI3ImpoxruP60EpxdKHxMF088MpggWRWO7IYnFWYmW7H6nN3tO2gp7dE0tPcr
         PZxWZiHqQ0kOXeNKhD0DGvipG0AB/RuuNPtsQvgGuq0gEvYHfaW0BPvSOUVVBNQSYbh9
         0YWWGW3L+w61nc7KMA8GAJec757jPzc4w6+ESAcdFTN5R3q4fIgS/oiFDTnJz8JfMv7h
         ts1ZBK4JepAEgYw1PQejU7GFCd4skwXqph1TdAhgLH6c2/iHJ7h16XxYT4AhYwcn5M99
         FT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dlj3GwcHZB/hfgpWys67iaiDnLMMEzD7BT0/JUJOZSA=;
        b=KuYPHF1MclOQLAAOyBHHsVk/93YWH1gPonJ8aZLJ4Bbl9MwyQwg5dnJWzwOKauzm6w
         khaCqXaoAFY0ybNiSejKtkSVfdMlyfFtW4f7iHf0oTQST1keed2yg0Oz/U7sF+mHvmPk
         rP0p1rwXmiewzOHhuOawY/wP30Hs1yJ7jT0Mh59Y4Qukldoa2mSZ4wTcUPvPNlgYNl9B
         ajRbXhf21GC66axvpPhN71GZP6oEWbWw++I609Ugw/0G2bd2E8JG/HrEcDPPyNmubLRW
         xmZ8j1V56Gj648RyOvXuKEi00iSyu3H4r91fnJtaFAfSNKrou9/F7OS7y/ih74L6o8GH
         0rEg==
X-Gm-Message-State: AOAM531MhG7UEzwZRtAAJpUIiNP35ZLMcr60hz0QAkWAYVO8BDVkfx+f
        QOidNdLP0AxZDtEr0HL1sD486w==
X-Google-Smtp-Source: ABdhPJxstfy2KGuFAOeM51qITA8tU2CEYk8H/V5BgLnRDG7386cROIjg8GYfgca/wk61maljwb6gxg==
X-Received: by 2002:a05:6214:dac:: with SMTP id h12mr7351043qvh.39.1633126446714;
        Fri, 01 Oct 2021 15:14:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id p9sm3635312qkm.23.2021.10.01.15.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 15:14:05 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mWQn7-009XgW-9E; Fri, 01 Oct 2021 19:14:05 -0300
Date:   Fri, 1 Oct 2021 19:14:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
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
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20211001221405.GR3544071@ziepe.ca>
References: <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca>
 <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <95ada0ac-08cc-5b77-8675-b955b1b6d488@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ada0ac-08cc-5b77-8675-b955b1b6d488@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 01, 2021 at 02:13:14PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2021-10-01 11:45 a.m., Jason Gunthorpe wrote:
> >> Before the invalidation, an active flag is cleared to ensure no new
> >> mappings can be created while the unmap is proceeding.
> >> unmap_mapping_range() should sequence itself with the TLB flush and
> > 
> > AFIAK unmap_mapping_range() kicks off the TLB flush and then
> > returns. It doesn't always wait for the flush to fully finish. Ie some
> > cases use RCU to lock the page table against GUP fast and so the
> > put_page() doesn't happen until the call_rcu completes - after a grace
> > period. The unmap_mapping_range() does not wait for grace periods.
> 
> Admittedly, the tlb flush code isn't the easiest code to understand.
> But, yes it seems at least on some arches the pages are freed by
> call_rcu(). But can't this be fixed easily by adding a synchronize_rcu()
> call after calling unmap_mapping_range()? Certainly after a
> synchronize_rcu(), the TLB has been flushed and it is safe to free those
> pages.

It would close this issue, however synchronize_rcu() is very slow
(think > 1second) in some cases and thus cannot be inserted here.

I'm also not completely sure that rcu is the only case, I don't know
how every arch handles its gather structure.. I have a feeling the
general intention was for this to be asynchronous

My preferences are to either remove devmap from gup_fast, or fix it to
not use special pages - the latter being obviously better.

Jason
