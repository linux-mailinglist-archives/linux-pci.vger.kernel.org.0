Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200F341B7BE
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 21:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242541AbhI1Tst (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 15:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242535AbhI1Tst (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 15:48:49 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B287C061746
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 12:47:09 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id m7so25034950qke.8
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EVzDoSDqJZmi4ToqJEIddbvRD+vlWsRISaT7f2OXukE=;
        b=EO1kDwzeZuMv1jUFt2pmKX8GvyZQAUMBJiLy1x1SVytxwcplVnv2ywT1ffuJvbGzDe
         SqreChLnqXdZ3bmpOGx1lq6jv+yPr/cOeERvwxCekQ+2pAL/hPpshqhIf/ZGdT33EAIM
         lOon8sIgHYjE/rwWroGijsvQ3Sfl16uYtuTJKv69ByO+2IJKaQCkRs4E+itlOn/VuGnJ
         ObcFwFaFhFQuJrFju9q8374g29cj0NSSZZgWhx88Ckt7Rqd+521BC3qoxSNjSsHzeMSW
         tdbGfXJrW/lc1jL/isk876EABn7Hc3z0lVBV5inoZjNRJpGnlQE9c49iUQf8C8yixnTL
         5Dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EVzDoSDqJZmi4ToqJEIddbvRD+vlWsRISaT7f2OXukE=;
        b=jDuY/6GCer3cnHcvY2NIqGsotRzamxBLZkFvwjXpi6AYHnanNKkdbfAGxf4W7O9DIq
         iFY2kgp55h3cSANsIoSQHAQyMF8mxk/leyfQRWZE542jPo2u681D7iTj1nNnPou7dwLZ
         I3NDgJiMC4JY+9LhB1JwL0XYyXCjI+nDEqhs6niQLN9ODqq9DTikrhgCgfw1ufaFOrqp
         0FlNiuZ/QfoSqWo7i/Jah7V+pQdYyoayzgRBLdWMhgPojUyihA0qvCqNNBDydFWlTLBV
         2M4B3vAYtW3zo2ePBiMw81eTNCmIIK8/huTsI0hAhbRF4neOXUUJIhNWcusjtTxLkngQ
         +X9Q==
X-Gm-Message-State: AOAM530a2MJgsnUEg8P8KiwIig4l33/bqY+ukApr+7FgIWDA9D4bAaFL
        sOWukn1n16oX0NmRgqgIWGO2TA==
X-Google-Smtp-Source: ABdhPJxxZpC5AepjHCbAmIQaz4Zogx1HRof8bzNZRXH/My30paIzwcLwvreCcb7Df5Gio9BelRE2TQ==
X-Received: by 2002:a37:8242:: with SMTP id e63mr1886625qkd.294.1632858428465;
        Tue, 28 Sep 2021 12:47:08 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d14sm79297qkg.49.2021.09.28.12.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 12:47:08 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVJ4F-007GbK-31; Tue, 28 Sep 2021 16:47:07 -0300
Date:   Tue, 28 Sep 2021 16:47:07 -0300
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
Message-ID: <20210928194707.GU3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-15-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-15-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:54PM -0600, Logan Gunthorpe wrote:
> Callers that expect PCI P2PDMA pages can now set FOLL_PCI_P2PDMA to
> allow obtaining P2PDMA pages. If a caller does not set this flag
> and tries to map P2PDMA pages it will fail.
> 
> This is implemented by adding a flag and a check to get_dev_pagemap().

I would like to see the get_dev_pagemap() deleted from GUP in the
first place.

Why isn't this just a simple check of the page->pgmap type after
acquiring a valid page reference? See my prior note

Jason
