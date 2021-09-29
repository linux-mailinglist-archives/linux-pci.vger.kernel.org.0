Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1AC41D00A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 01:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347592AbhI2XhZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 19:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347590AbhI2XhY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 19:37:24 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627A6C06161C
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 16:35:42 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c7so4083070qka.2
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 16:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wzv2Y27ogc32S6oHMWAfyL0EMJPS0sYiDo6umdEuZ90=;
        b=S4PKYlTphsjTeGSO6MfruYx4DLjFDyu6ZBDQXU7sgBQUZglbnWFts2iTn8upvshkwO
         /dxY5MJJ3K9bbBOWdcCpUDQryqEQ6B6xsCI4XTkHAaouYDnzj48xV27k94PZY12XJM5q
         EV90TNvBvPJrxWONr5qi4YLqPbT6TkJpX2ov+sLJirRsIUAvrOi36HyZfvihTjc8VRvy
         y9qkzSc3lHxRJ2joe2EKnBI4kW39e2li3GiaMVt6OA83/KD9UTxgkGPf5QdOygqePR/u
         RbANXP74mA2FQxLulY5GQdT3oKcIiqhjOBThg85Hi5BfdV/hy7RpkZ8VNDP3qSTgV52G
         3oKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wzv2Y27ogc32S6oHMWAfyL0EMJPS0sYiDo6umdEuZ90=;
        b=aJKVi2z1QE6hRWF9YpE9Bpo8yt8OjR5BoHexjxe2AhsEntEEUk/E0mWpv5UYd2B7Bh
         tNnCQy3GfJiMeCWXsoFOKjEuX2RTY1oD5+ndCZHxPILhpOnR+ClUHB+4tqO2E/pcebIV
         Q97dTZe0Vpk62/YZSpfWh7Kp1JE+x5oN5h7+qFnB1I3k6V7jP4K5ECYP86vTgquUzAKf
         rPDvtkYHfZJELBc60/alx6QXRQREyilOAF51vDE0iV8xHhlBWvwzAhWAwoaiz5su189I
         GfYZzhdmmZecIuX1jn8xg2duW9l17MtSV6thMBHWWkqroaQYNxXyMNNUoPE6U5NNVWBe
         4CsA==
X-Gm-Message-State: AOAM533fALt8v34VuWlWw3eDSt4qtDP8cIeJGHIaA7A4GuVHupAkc1Fq
        yzNIK0/Tv/0kvx0e5rZe2aL1sg==
X-Google-Smtp-Source: ABdhPJxG17Iq4sMkmS8x7eqi3cbKInix861xKtGJRezs+18cQeCiP6r35EC+3tlGMr1TedfVtU4v5g==
X-Received: by 2002:a37:afc4:: with SMTP id y187mr2254066qke.520.1632958541600;
        Wed, 29 Sep 2021 16:35:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id j184sm705904qkd.74.2021.09.29.16.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 16:35:41 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVj6y-007ivO-CU; Wed, 29 Sep 2021 20:35:40 -0300
Date:   Wed, 29 Sep 2021 20:35:40 -0300
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
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20210929233540.GF3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 05:27:22PM -0600, Logan Gunthorpe wrote:

> > finish_fault() should set the pte_devmap - eg by passing the
> > PFN_DEV|PFN_MAP somehow through the vma->vm_page_prot to mk_pte() or
> > otherwise signaling do_set_pte() that it should set those PTE bits
> > when it creates the entry.
> > 
> > (or there should be a vmf_* helper for this special case, but using
> > the vmf->page seems righter to me)
> 
> I'm not opposed to this. Though I'm not sure what's best here.
> 
> >> If we don't set pte_devmap(), then every single page that GUP
> >> processes needs to check if it's a ZONE_DEVICE page and also if it's
> >> a P2PDMA page (thus dereferencing pgmap) in order to satisfy the
> >> requirements of FOLL_PCI_P2PDMA.
> > 
> > Definately not suggesting not to set pte_devmap(), only that
> > VM_MIXEDMAP should not be set on VMAs that only contain struct
> > pages. That is an abuse of what it is intended for.
> > 
> > At the very least there should be a big comment above the usage
> > explaining that this is just working around a limitation in
> > finish_fault() where it cannot set the PFN_DEV|PFN_MAP bits today.
> 
> Is it? Documentation on vmf_insert_mixed() and VM_MIXEDMAP is not good
> and the intention is not clear. I got the impression that mm people
> wanted those interfaces used for users of pte_devmap().

I thought VM_MIXEDMAP was quite clear:

#define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */

This VMA does not include PFN pages, so it should not be tagged
VM_MIXEDMAP.

Aside from enabling the special vmf_ API, it only controls some
special behavior in vm_normal_page:

 * VM_MIXEDMAP mappings can likewise contain memory with or without "struct
 * page" backing, however the difference is that _all_ pages with a struct
 * page (that is, those where pfn_valid is true) are refcounted and considered
 * normal pages by the VM. The disadvantage is that pages are refcounted
 * (which can be slower and simply not an option for some PFNMAP users). The
 * advantage is that we don't have to follow the strict linearity rule of
 * PFNMAP mappings in order to support COWable mappings.

Which again does not describe this case.

> device-dax uses these interfaces and as far as I can see it also only
> contains struct pages (or at least  dev_dax_huge_fault() calls
> pfn_to_page() on every page when VM_FAULT_NOPAGE happens).

hacky hacky :)

I think DAX probably did it that way for the same reason you are
doing it that way - no other choice without changing something

Jason
