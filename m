Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A35E41CFDB
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 01:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347551AbhI2XXd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 19:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347539AbhI2XXb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 19:23:31 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75375C061769
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 16:21:49 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 138so4000424qko.10
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 16:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Hmlahc/i9658U3YzBDCjabD8lk1Mv+/ZOzt2omk2Ho=;
        b=SJtWHdnGo9L4mdll+qKaZsmtvpn7ds7Jqf9UErLrQmOsqRP3sxU8o3aw5o2MvhL5Mj
         lM03toh8ImPud8H7vh/AGGkl+3vURvGKxRBh5yeP3iqYJ3RXD4HkzTzjBF6Mgc3CyYL4
         NPwaDU2c+i54bQ4atNBSa63XnbDUvexvPwjoCQkmNEdCUAl1T+QvgnRV98lCDddMEe7S
         LVFALRCv3M02kPjD9ocMpxen45b3XXJIbEyj72HfycWLiBpEdaWRxZc5TzgjO4IW95ia
         6tYGEjCfhjevDUh3QKMgzT1YEh/Dp9tLfgFk0cHBocInRv2rBNOuuogJ3/Vn3OANJNLH
         kWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Hmlahc/i9658U3YzBDCjabD8lk1Mv+/ZOzt2omk2Ho=;
        b=Tm7WcpIV+jLiq+RFbdP8TjERMMLKqq8WgqUIlo4Wm6z9luRPSrtX7hYrEPFAEa9KFd
         QmWumLgCogrP/GarjNARwHP1Pz2Tw/o9wXJC8eBz0sxvzfJFnQFJw274FtpUqclwo+hD
         fz4851nPgeKVTtVV/TmGQo/7PmuIkeb2lbBfkh/zmvwTxG6JRJLJvnf4gIF3Kh5Ahkel
         VeV3ucrJIzK/7yS31Q3xa1AE591n+h9Fow13nlKuBZ6eivnUoZyWw2uhS9Ee8P8d0E53
         ptgwOrw66OL0gENUutpdb4GahJsIVuclSe1hbtiXXdRROM/W25ZMDGRQQSJRLO6UG3s1
         R8Sg==
X-Gm-Message-State: AOAM533jtHifI8cYSzXECW/RsBwgjDrPti6q2HkBJhSVoxxapDyQv80z
        fc2iMQHiBVFt1J0pU5SA2TpF4Q==
X-Google-Smtp-Source: ABdhPJxjfksXX9RBzjsealxa+5cO5Ph50HuUSNxxHRV+6R5kI7btDIJAlC0cqyNxWaWuBVsQ1jP8wA==
X-Received: by 2002:a37:b386:: with SMTP id c128mr2193672qkf.426.1632957708587;
        Wed, 29 Sep 2021 16:21:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id x3sm631017qkl.107.2021.09.29.16.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 16:21:48 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVitX-007ii8-Gm; Wed, 29 Sep 2021 20:21:47 -0300
Date:   Wed, 29 Sep 2021 20:21:47 -0300
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
Subject: Re: [PATCH v3 00/20] Userspace P2PDMA with O_DIRECT NVMe devices
Message-ID: <20210929232147.GD3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210928200216.GW3544071@ziepe.ca>
 <06d75fcb-ce8b-30a5-db36-b6c108460d3d@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06d75fcb-ce8b-30a5-db36-b6c108460d3d@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 03:50:02PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2021-09-28 2:02 p.m., Jason Gunthorpe wrote:
> > On Thu, Sep 16, 2021 at 05:40:40PM -0600, Logan Gunthorpe wrote:
> >> Hi,
> >>
> >> This patchset continues my work to add userspace P2PDMA access using
> >> O_DIRECT NVMe devices. My last posting[1] just included the first 13
> >> patches in this series, but the early P2PDMA cleanup and map_sg error
> >> changes from that series have been merged into v5.15-rc1. To address
> >> concerns that that series did not add any new functionality, I've added
> >> back the userspcae functionality from the original RFC[2] (but improved
> >> based on the original feedback).
> > 
> > I really think this is the best series yet, it really looks nice
> > overall. I know the sg flag was a bit of a debate at the start, but it
> > serves an undeniable purpose and the resulting standard DMA APIs 'just
> > working' is really clean.
> 
> Actually, so far, nobody has said anything negative about using the SG flag.
> 
> > There is more possible here, we could also pass the new GUP flag in the
> > ib_umem code..
> 
> Yes, that would be very useful.

You might actually prefer to do that then the bio changes to get the
infrastructur merged as it seems less "core"

Jason
