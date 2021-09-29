Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AA241CF76
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 00:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347342AbhI2WuR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 18:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347353AbhI2WuQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 18:50:16 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF3BC061768
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 15:48:34 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id m7so3942633qke.8
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 15:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B0sV1qVbbjrF0PysKkzPgbfO3+Me62Wpz2WIVsVwuoE=;
        b=P9N1xixIbU2CQZqPgthtCxabWVb1WaKJas+T5Bbtlr4fD7rztRWCIEl7HQ9hsYT8aF
         41wF7TSRaJ3f9seP9f0KrtpHt8gvV/9kf7XUzRs3fIottSWd5Jos1b7FSN+JKsFTdWUh
         cQmc0BxR1at5W66It0VtetEvP3kxr6TgFG71lefSWpCHrqHfP2E1T4XXYFzcdwOAnPpb
         WlKs8E3Ae/btD+bQUn9uA6WCV6uRLRFmutfEb0Vg/FCMMltR8qwOKBC/i/xs0Mi5ciI7
         QAuN+ydzCbvdhC6HuPboTTSd7wkOyLMNyDUAGQreZfH9ZakjqoboD9OYItawKLMdXBtS
         NwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B0sV1qVbbjrF0PysKkzPgbfO3+Me62Wpz2WIVsVwuoE=;
        b=V+OG+AGjcnsajwr05snNHRjowlmhwlNaaPmPjLXzY/c8SSX5YTj1VKH3U9HOuQA+2I
         G8ERT/8KzXIf2RYmoqikxsSTTbvBqzZ5zwjHDu9N8qtXIREqV83EXAaEnIVLH6uIb9IO
         ZAy4Q5Qb5Bp1MKPMurysY5scGljyIsiz465W+15dOlh2YLQTsWyGVeks4Wi3C9VNfaQ6
         Jy3gahgBUBtsAb2ByBznfrmjnaShiVxtSpjye/cNysOLvp5kfLQiBZaMgrBdjuaPVn5u
         fV0DlWZH+1HC6xtnnN08FMGXBNt62XPjP4CJ5ofOBzHJ40I+ecrZT3AiR+wOeZTaUkTX
         6/ow==
X-Gm-Message-State: AOAM530t5BoXL2SxTc9uOugbmflBhDQp61kbAeP9Dqe9Grmc1F4OMGtF
        cPp6OwgtzEZBbPcsr7TTqMjQQg==
X-Google-Smtp-Source: ABdhPJzspya2uDxnOQP6RHXKg0GJNOh86aMtX4Pki+BqPF0YRta2WtTuRpyPIif49H7Hs8Tu/MZ3xw==
X-Received: by 2002:a37:8ec6:: with SMTP id q189mr2083152qkd.145.1632955713476;
        Wed, 29 Sep 2021 15:48:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id q14sm748591qtw.82.2021.09.29.15.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 15:48:32 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mViNL-007i7c-U2; Wed, 29 Sep 2021 19:48:31 -0300
Date:   Wed, 29 Sep 2021 19:48:31 -0300
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
Subject: Re: [PATCH v3 14/20] mm: introduce FOLL_PCI_P2PDMA to gate getting
 PCI P2PDMA pages
Message-ID: <20210929224831.GA3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-15-logang@deltatee.com>
 <20210928194707.GU3544071@ziepe.ca>
 <9c40347c-f9a8-af86-71a5-2156359e15ce@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c40347c-f9a8-af86-71a5-2156359e15ce@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 03:34:22PM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2021-09-28 1:47 p.m., Jason Gunthorpe wrote:
> > On Thu, Sep 16, 2021 at 05:40:54PM -0600, Logan Gunthorpe wrote:
> >> Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
> >> allow obtaining P2PDMA pages. If a caller does not set this flag
> >> and tries to map P2PDMA pages it will fail.
> >>
> >> This is implemented by adding a flag and a check to get_dev_pagemap().
> > 
> > I would like to see the get_dev_pagemap() deleted from GUP in the
> > first place.
> > 
> > Why isn't this just a simple check of the page->pgmap type after
> > acquiring a valid page reference? See my prior note
> 
> It could be, but that will mean dereferencing the pgmap for every page
> to determine the type of page and then comparing with FOLL_PCI_P2PDMA.

It would be done under the pte devmap test and this is less expensive
than the xarray search.

Jason
