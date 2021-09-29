Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19C541CFB9
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 01:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347420AbhI2XH1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 19:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347397AbhI2XH1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 19:07:27 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD212C06161C
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 16:05:45 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d8so3951509qtd.5
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 16:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rb14cjSJqqt1iOg7v1WUt5AVmuRSH7cZOE8ujwxMcMg=;
        b=DIaskCn5WR5tA6jhdOqyO4JGz4+XatRitSbJTb+kmIqDsCr01GjZ0p3lPuKzblpDJT
         zhfIKMKyyPJmhP4fwKW9s1DOIPeWnXpgnGWww2ZsqZXMAXwagCxFkdbr/ZZNpdbvhNz6
         yhMxNtaJ4799pZOw9yof96R6NI1pis1TXcHgXiz2OGYJ2JTRjUBWxNfY9Bnx4SBlBLHZ
         NOkoZJeyzIFho5nhxKuuBqHTm7LkOuC/VLVY0i+EnUBy4CEUt/GqO7FcsIRDEUISOa/r
         ebsfSg+Kyd8gPXIldmrnVbOFPyE5xD126E/0FnMFaQl4NuKh0l+VCCKdHBolF0rJnHvM
         E9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rb14cjSJqqt1iOg7v1WUt5AVmuRSH7cZOE8ujwxMcMg=;
        b=q2QiH8xCVvWenr0ij7L6bpimXFGN533f0M4sBXBCRfYRw07D8vaQN8nCU/kTbo+V/Y
         vZjJIYrJRd2i4uBfgMLBU7sSRxdQ1RyNjUVgWFTEhHDGxQj9xXujYy00h226HnDfLW8p
         nre/86CvqOT4fCgR07/wfAwEZp2Ggvz/oPFangXYKWM7wesldWPyQHzG7yIC/OBccye9
         goQKdTghxyPdFfTtCrvdAlLy1OcAPWxA3GvtiNQgfcJ1vktStmbqy0+9W5qN/q7tHVkG
         DrDIqHKQW3U0/rFo1yy/UU6gzcF1KEYtivQf8xYDnbbMhOobfkGu17fjbAkKtWn4Fwfr
         bjaw==
X-Gm-Message-State: AOAM533tImWmhGV+mUWLDkDxY/VE3Q1wR3qZKpChyWpIrBRwY31nyFIq
        KwhGW2lDhYcKSh1PnZ8qKEgAew==
X-Google-Smtp-Source: ABdhPJyapID+TUOl/mUzGMXiMJpXeNaxe+8Z2o/bunUXmIm+EzT4IvoM8B4R+kDDMjzs5lMTxyRE3w==
X-Received: by 2002:ac8:7613:: with SMTP id t19mr2882513qtq.365.1632956745011;
        Wed, 29 Sep 2021 16:05:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id h4sm645980qtj.83.2021.09.29.16.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 16:05:44 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVidz-007iU5-Sx; Wed, 29 Sep 2021 20:05:43 -0300
Date:   Wed, 29 Sep 2021 20:05:43 -0300
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
Message-ID: <20210929230543.GB3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 03:42:00PM -0600, Logan Gunthorpe wrote:

> The main reason is probably this: if we don't use VM_MIXEDMAP, then we
> can't set pte_devmap(). 

I think that is an API limitation in the fault routines..

finish_fault() should set the pte_devmap - eg by passing the
PFN_DEV|PFN_MAP somehow through the vma->vm_page_prot to mk_pte() or
otherwise signaling do_set_pte() that it should set those PTE bits
when it creates the entry.

(or there should be a vmf_* helper for this special case, but using
the vmf->page seems righter to me)

> If we don't set pte_devmap(), then every single page that GUP
> processes needs to check if it's a ZONE_DEVICE page and also if it's
> a P2PDMA page (thus dereferencing pgmap) in order to satisfy the
> requirements of FOLL_PCI_P2PDMA.

Definately not suggesting not to set pte_devmap(), only that
VM_MIXEDMAP should not be set on VMAs that only contain struct
pages. That is an abuse of what it is intended for.

At the very least there should be a big comment above the usage
explaining that this is just working around a limitation in
finish_fault() where it cannot set the PFN_DEV|PFN_MAP bits today.

Jason

