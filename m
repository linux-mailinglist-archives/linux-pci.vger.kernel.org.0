Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05D55E8197
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 20:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiIWSNG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 14:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiIWSNF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 14:13:05 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9674CFA0EC
        for <linux-pci@vger.kernel.org>; Fri, 23 Sep 2022 11:13:03 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id ay9so600978qtb.0
        for <linux-pci@vger.kernel.org>; Fri, 23 Sep 2022 11:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ESjxMV4FxoH+Qzt/uSGYOPflTsCgLENu7dcc3YowE6k=;
        b=kY7MMNDmdRDXgBREGl1n+cj9EEOun4Jy+ls14IMPSV0csWh1NDhj6Y4IB13T7BfdUg
         Wi26eUp33Pa5tk7zFyBI2Mq+szalxQ6Q7xLkG63kAED5icqyWvausogbFqMjBz0Q3OAh
         8jqc4H2+05KPQwocTeDkku8kSoajsIwV/5IYLvCARPSewr33UpGNeEeIiU9QvvDqKKWA
         39NJUXg4YGPg3p8VI/Tc5XyFrJVFGr/E8X/vqYnNdWZ2ScfDLSTdMHKUBAKg0NCPBOg6
         IuCIVAumakjRmdj960aYL4S9ORJZ+CwZb7srEB3nY3ZBFIp+qJ2V46gkbAaTq221ryrS
         b8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ESjxMV4FxoH+Qzt/uSGYOPflTsCgLENu7dcc3YowE6k=;
        b=4pwnTEgiGlZhWnRgtFG4MQWV7C2PFuTnXm9pJ3TNBaSx+f+nempDDe7jBJlJPc2Osh
         KpzefdOw1xzshDfRY1yDAzszFm5VmoZSk1jOqArqwslWcG8wiBOJjcgK8qf5CWMw1T9I
         /FUm08BD5pYtTqD5lxaF1S/iQluveFLkr65Gx0Sqn3HI06k50aSMWTApDNuqQYTQ3Ttk
         g6/fbZB4PFmC2T7cWk0/nYgDFeH4v8vQ9oG3brYvVuLTOtzqsU6lCrwKVOAp3MVXrjDA
         uhXFCWmNIww2df+xGlR4gMTtTXwHcQxkXhjKg15I9mAuRyKYin5Ra6HlEPMYFXnNDCKG
         ntlA==
X-Gm-Message-State: ACrzQf3kCllygBJVyLoR+Zed1Uvbi+KFkn+Ikef9X1Y2JQMLudq24B1R
        XF3q+w4L0L9RWIfqsGrdCyIZ5A==
X-Google-Smtp-Source: AMsMyM70jy04UOYomyiLCRjAafYD9I2h2rthRpjbDcZ+gaI+Pe3GK1nBzDBvaI6cptEThcPFiSijKQ==
X-Received: by 2002:a05:622a:1053:b0:35c:bab4:bd80 with SMTP id f19-20020a05622a105300b0035cbab4bd80mr8343380qte.189.1663956782680;
        Fri, 23 Sep 2022 11:13:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id r13-20020ac87eed000000b0034035e73be0sm5730575qtc.4.2022.09.23.11.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 11:13:01 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1obnAb-002jAI-6N;
        Fri, 23 Sep 2022 15:13:01 -0300
Date:   Fri, 23 Sep 2022 15:13:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
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
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v10 1/8] mm: introduce FOLL_PCI_P2PDMA to gate getting
 PCI P2PDMA pages
Message-ID: <Yy33LUqvDLSOqoKa@ziepe.ca>
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220922163926.7077-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922163926.7077-2-logang@deltatee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 22, 2022 at 10:39:19AM -0600, Logan Gunthorpe wrote:
> GUP Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
> allow obtaining P2PDMA pages. If GUP is called without the flag and a
> P2PDMA page is found, it will return an error.
> 
> FOLL_PCI_P2PDMA cannot be set if FOLL_LONGTERM is set.

What is causing this? It is really troublesome, I would like to fix
it. eg I would like to have P2PDMA pages in VFIO iommu page tables and
in RDMA MR's - both require longterm.

Is it just because ZONE_DEVICE was created for DAX and carried that
revocable assumption over? Does anything in your series require
revocable?

> @@ -2383,6 +2392,10 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
>  		page = pte_page(pte);
>  
> +		if (unlikely(!(flags & FOLL_PCI_P2PDMA) &&
> +			     is_pci_p2pdma_page(page)))
> +			goto pte_unmap;
> +
>  		folio = try_grab_folio(page, 1, flags);
>  		if (!folio)
>  			goto pte_unmap;

On closer look this is not in the right place, we cannot touch the
content of *page without holding a ref, and that doesn't happen until
until try_grab_folio() completes.

It would be simpler to put this check in try_grab_folio/try_grab_page
after the ref has been obtained. That will naturally cover all the
places that need it.

Jason
