Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9BEF17BDCF
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 14:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgCFNJW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 08:09:22 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:43759 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgCFNJW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2020 08:09:22 -0500
Received: by mail-qv1-f68.google.com with SMTP id eb12so860500qvb.10
        for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2020 05:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XKKq26i7LXXgJsW46mcbcSbPq8I/xYnL2HpEPyMqw1w=;
        b=foqmJvTUw2Rd/dJAzqjnhmFuMbsk1LtzLOifzjHgdZQbMzZ0fHXAAsUe/GdCO1ZYAj
         7Bn2iIOTlWGut2weejRp8AcX3VG/Qn4/y/RQG0WtfMqv+MReV5P5jcMiLxOXdqYalZiA
         /dVdSm1Sf6SyyIudvVIwFow4eMDAUcfiWaT/zF3cFXtW4JnKM0JErPEQqyhqPtB0Hhdr
         ol2bHUU9KfkJM+O1Bn3ayXm8dujSMw6pcJy7+pV2WuGXVVhtWpVQF3na2JpDadwaG7Lv
         FiGiNN5hAg+eY9U2557t7Y1y8aKkxx39cX6l7OgYqp4+v+dicxqKElU/9QEPZ5LM/fig
         63hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XKKq26i7LXXgJsW46mcbcSbPq8I/xYnL2HpEPyMqw1w=;
        b=R/1eRWTDbmXbC9AV7JeQ4pBePeJpxNEYSBCJ37EiNPCHpBrWslAwxHa9yCuv/uuJjF
         KI7kHtDBRY8YtRVnLTK2yYEFqvLfaZZC+5wVN9lP5cv0j0YldLJn8jRTOkAXY375GE8A
         qTQbVqfk4PdosaTlt7aHzoMVUC0EbFAVlEc5JSocqlAUbp/95dSIm+GMaVRz/RFbIb1s
         Y1H3Bz+Ds5RwJETmjEpXuXlH/TVM/4bHNAjbcC7TYVkdniOk3cuB8FkWcPFO0rqvmUqW
         LqyJHW55qg6KatBRD3Rp0TMqJpDBQf20zj4Eu3SyhK2cF74wX20dHCQiCVj+oAoBD7gs
         Axvw==
X-Gm-Message-State: ANhLgQ3o6uTwkVa8QZXYBSywLweCyDgWa56UZ2afxszmT9YUC+d0rZ3A
        KojFLTnq1vR28lxxHzZIyISInA==
X-Google-Smtp-Source: ADFU+vtl8tdBNaG32n8uRFCoIw2vjaXoLHT1yzW1F89T5e4eGpjKwith2OB8kDL1Ro6OTXnkI3ffpw==
X-Received: by 2002:a0c:f5ce:: with SMTP id q14mr2642141qvm.191.1583500160921;
        Fri, 06 Mar 2020 05:09:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id e7sm8754949qtp.0.2020.03.06.05.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Mar 2020 05:09:20 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jACj9-0002zi-Hm; Fri, 06 Mar 2020 09:09:19 -0400
Date:   Fri, 6 Mar 2020 09:09:19 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     mark.rutland@arm.com, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, will@kernel.org,
        Dimitri Sivanich <sivanich@sgi.com>, catalin.marinas@arm.com,
        zhangfei.gao@linaro.org, devicetree@vger.kernel.org,
        kevin.tian@intel.com, Arnd Bergmann <arnd@arndb.de>,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        robin.murphy@arm.com, christian.koenig@amd.com
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200306130919.GJ31668@ziepe.ca>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
 <20200224190056.GT31668@ziepe.ca>
 <20200225092439.GB375953@myrica>
 <20200225140814.GW31668@ziepe.ca>
 <20200228143935.GA2156@myrica>
 <20200228144844.GQ31668@ziepe.ca>
 <20200228150427.GF2156@myrica>
 <20200228151339.GS31668@ziepe.ca>
 <20200306095614.GA50020@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306095614.GA50020@myrica>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 06, 2020 at 10:56:14AM +0100, Jean-Philippe Brucker wrote:
> I tried to keep it simple like that: normally mmu_notifier_get() is called
> in bind(), and mmu_notifier_put() is called in unbind(). 
> 
> Multiple device drivers may call bind() with the same mm. Each bind()
> calls mmu_notifier_get(), obtains the same io_mm, and returns a new bond
> (a device<->mm link). Each bond is freed by calling unbind(), which calls
> mmu_notifier_put().
> 
> That's the most common case. Now if the process is killed and the mm
> disappears, we do need to avoid use-after-free caused by DMA of the
> mappings and the page tables. 

This is why release must do invalidate all - but it doesn't need to do
any more - as no SPTE can be established without a mmget() - and
mmget() is no longer possible past release.

> So the release() callback, before doing invalidate_all, stops DMA
> and clears the page table pointer on the IOMMU side. It detaches all
> bonds from the io_mm, calling mmu_notifier_put() for each of
> them. After release(), bond objects still exists and device drivers
> still need to free them with unbind(), but they don't point to an
> io_mm anymore.

Why is so much work needed in release? It really should just be
invalidate all, usually trying to sort out all the locking for the
more complicated stuff is not worthwhile.

If other stuff is implicitly relying on the mm being alive and release
to fence against that then it is already racy. If it doesn't, then why
bother doing complicated work in release?

> > Then you can never get a stale
> > pointer. Don't worry about exit_mmap().
> > 
> > release() is an unusual callback and I see alot of places using it
> > wrong. The purpose of release is to invalidate_all, that is it.
> > 
> > Also, confusingly release may be called multiple times in some
> > situations, so it shouldn't disturb anything that might impact a 2nd
> > call.
> 
> I hadn't realized that. The current implementation should be safe against
> it, as release() is a nop if the io_mm doesn't have bonds anymore. Do you
> have an example of such a situation?  I'm trying to write tests for this
> kind of corner cases.

Hmm, let me think. Ah, you have to be using mmu_notifier_unregister()
to get that race. This is one of the things that get/put don't suffer
from - but they conversely don't guarantee that release() will be
called, so it is up to the caller to ensure everything is fenced
before calling put.

Jason
