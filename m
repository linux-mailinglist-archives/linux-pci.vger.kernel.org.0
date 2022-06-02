Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B1953B0CC
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 02:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiFBAAp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 20:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbiFBAAm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 20:00:42 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29702941C9
        for <linux-pci@vger.kernel.org>; Wed,  1 Jun 2022 17:00:40 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id p8so2371577qtx.9
        for <linux-pci@vger.kernel.org>; Wed, 01 Jun 2022 17:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XHclFl6TiOnpsdbRTbpf8I5ef93NwLHxOT7ZftAP5OQ=;
        b=PNI9gR5OxCMLK2wesmPP7beTza1LVUIA9KonYJGbDAFowaWR1+gOMSPFQyILlCbdK9
         gUfn5ltQQND4Igpr1PcoJgKaxcD5dBAwzrvhneuGmR5cB6Xf3NpyEwE9pIIgcm5WsDfj
         OMBTPHZn69Csi4sdfYc+o9dQdNtlWVyz5OxRR+X8nyDPYF6K2ahO4BRlxiavJkdgkk5b
         vBCAgX831wn8MMIkjC+ZBM62WCGcevuCk6vOX7Pr2o1vHeySgvRlg6SFXHlD9BjBBgRR
         tgzeldcoyTnuS2Xyrkl/LEo9UbgD40oyCdtA/wA5nQPC/hTnaLXrjoV5QjIEjd2lSEr7
         qhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XHclFl6TiOnpsdbRTbpf8I5ef93NwLHxOT7ZftAP5OQ=;
        b=0Nu6LAZVXvTDmQ4jJht6PJtLbdE4xEI+WlEao1NK/+zgBcmM82HydrtegpUeekH9kB
         exUw/34zA6gbfNcGVny+DcVTiSdOlU2Xs8ZTFyrAGmriY7+vQy25ZVswtpzqx74iYIne
         R3NmqJ2EQjP1aCwrWoNkyMn5JUZ4iIBegPXBJUhImgowjWsqcBKQtvZbIM0V+G+Y88XY
         CduO+AQ3GwbDx2ZRcWDmHWwP2gwg/tXRX5gHf+Q420dW/m6M6fF/sGpoB277O/SHwcrz
         nkur+d0UUx5kMDy7KGENi2lxGFMO7MnK8PpXBlaYyHcAj91CiP5EU45lXOXi+Ph1ylEf
         1GHw==
X-Gm-Message-State: AOAM531ttZrQjvXWFO8X0RG9K0V++gkC0T7dtZG5FBMJln0hvgV5gaH0
        b3Qr93goh7qq1s6d/JXvEGxQtw==
X-Google-Smtp-Source: ABdhPJyvPa7jsnbpw9EbFCPQVbuxZnWhMX7Sx5D9T0fweaGvqMgcaf7CabbpUfVwopaFMLH+hIknjw==
X-Received: by 2002:a05:622a:313:b0:2f3:b9a1:dd4a with SMTP id q19-20020a05622a031300b002f3b9a1dd4amr1870963qtw.536.1654128040009;
        Wed, 01 Jun 2022 17:00:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b16-20020a05620a04f000b006a38debe62csm1867208qkh.89.2022.06.01.17.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 17:00:39 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nwYGU-00GCY4-Af; Wed, 01 Jun 2022 21:00:38 -0300
Date:   Wed, 1 Jun 2022 21:00:38 -0300
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
Message-ID: <20220602000038.GK2960187@ziepe.ca>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
 <20220527190307.GG2960187@ziepe.ca>
 <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 27, 2022 at 04:41:08PM -0600, Logan Gunthorpe wrote:
> > 
> > IIRC this is the last part:
> > 
> > https://lore.kernel.org/linux-mm/20220524190632.3304-1-alex.sierra@amd.com/
> > 
> > And the earlier bit with Christoph's pieces looks like it might get
> > merged to v5.19..
> > 
> > The general idea is once pte_devmap is not set then all the
> > refcounting works the way it should. This is what all new ZONE_DEVICE
> > users should do..
> 
> Ok, I don't actually follow how those patches relate to this.
> 
> Based on your description I guess I don't need to set PFN_DEV and

Yes

> perhaps not use vmf_insert_mixed()? And then just use vm_normal_page()?

I'm not sure ATM the best function to use, but yes, a function that
doesn't set PFN_DEV is needed here.
 
> But the refcounting of the pages seemed like it was already sane to me,
> unless you mean that the code no longer has to synchronize_rcu() before
> returning the pages... 

Right. It also doesn't need to call unmap range or keep track of the
inode, or do any of that stuff unless it really needs mmap revokation
semantics (which I doubt this use case does)

unmap range was only necessary because the refcounting is wrong -
since the pte's don't hold a ref on the page in PFN_DEV mode it is
necessary to wipe all the PTE explicitly before going ahead to
decrement the refcount on this path.

Just stuff the pages into the mmap, and your driver unprobe will
automatically block until all the mmaps are closed - no different than
having an open file descriptor or something.

Jason
