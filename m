Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3CE5A4F8
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2019 21:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfF1TOz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jun 2019 15:14:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40525 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfF1TOz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jun 2019 15:14:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id e8so7031159otl.7
        for <linux-pci@vger.kernel.org>; Fri, 28 Jun 2019 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3EPvpztsPK7520nxsbDhjXQoNlIusJTLU8rYF+ocke4=;
        b=jX7l/aScOnNag6NN8PLCh3f8Z8jWQa8rXqdmRFTm19zC5cGsMg4bGsXFEunae/2WjS
         ovvvaTeYJH2utyMhChKwGiGq8ZBoeIIKayiImspczzJ8SDCf8XDDL3viRbXyjtD1lYaK
         kzh/gY0uzN3viGFbDD3U65We27uV73cZy9DpexfMTRSqDZy8x6zljmPhhW1gZcx2hqFe
         GQ/mPFT2QGn+yrEJgjwPpeYXNTM2MxsKsrWYit2Wtxn/cph7hWSIQxFHWHLu8ToPNVuS
         0Ys9z5mBN7oGuoBHQrTDBIA0uIvuwg0tIL5G5RHXTDvUcDFV767ifaCgmnx0wSkTm7cV
         iWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3EPvpztsPK7520nxsbDhjXQoNlIusJTLU8rYF+ocke4=;
        b=psNsvP1E7qpAapixEACfNPClznF9OEOeo7jjbIQwxjiQIOWQHHuJ64FJ4m3Z8BjL8n
         iyAhvLrq9ftZg4TBf0Ks5mR8QxM8mnLkfapDlGN9jp+Exr4dtm5Yi/dXPQeeqTLILf+C
         OKjJEi9BlJuVhvP4HRWXNymb99+HiU0hQ0r/xFwaSILbdofB+HJk6/hC6xjGjBrhydFa
         99qXRaGLVmejEpHpw445kUp5zzQe2q8hvkZfY42PpJ+wiM/ttwmlj6OeyOwCj6cEhy00
         0Q1Cvy+WMlbfF+Q/FMLM5zxohTdiXvyzfIybfgDnBdqgd/mXK1Nyn8qFyjPI6H/hHU5Y
         kXkQ==
X-Gm-Message-State: APjAAAVylo3zY0Wt6XVGOKsXNUpkvxWAt+ES989+IVEU1jbI9aevp5nl
        yCCxkl0P5lWllOM7uVwpLsZ9jLmgGLzl4jkAI+srLw==
X-Google-Smtp-Source: APXvYqwk0yjTvQhVqTpz4jl7ioGiwvBTeiygz26S4gTf6ee6guEN0yjq3zRwNg6EKq8iXaiv+Kpq8rgpgiSlzbcUkgY=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr8541745otn.71.1561749295055;
 Fri, 28 Jun 2019 12:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190626122724.13313-17-hch@lst.de> <20190628153827.GA5373@mellanox.com>
 <CAPcyv4joSiFMeYq=D08C-QZSkHz0kRpvRfseNQWrN34Rrm+S7g@mail.gmail.com>
 <20190628170219.GA3608@mellanox.com> <CAPcyv4ja9DVL2zuxuSup8x3VOT_dKAOS8uBQweE9R81vnYRNWg@mail.gmail.com>
 <CAPcyv4iWTe=vOXUqkr_CguFrFRqgA7hJSt4J0B3RpuP-Okz0Vw@mail.gmail.com>
 <20190628182922.GA15242@mellanox.com> <CAPcyv4g+zk9pnLcj6Xvwh-svKM+w4hxfYGikcmuoBAFGCr-HAw@mail.gmail.com>
 <20190628185152.GA9117@lst.de> <CAPcyv4i+b6bKhSF2+z7Wcw4OUAvb1=m289u9QF8zPwLk402JVg@mail.gmail.com>
 <20190628190207.GA9317@lst.de>
In-Reply-To: <20190628190207.GA9317@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Jun 2019 12:14:44 -0700
Message-ID: <CAPcyv4h90DAVHbZ4bgvJwpfB8wr2K28oEes6HcdQOpf02+NL=g@mail.gmail.com>
Subject: Re: [PATCH 16/25] device-dax: use the dev_pagemap internal refcount
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 28, 2019 at 12:02 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jun 28, 2019 at 11:59:19AM -0700, Dan Williams wrote:
> > It's a bug that the call to put_devmap_managed_page() was gated by
> > MEMORY_DEVICE_PUBLIC in release_pages(). That path is also applicable
> > to MEMORY_DEVICE_FSDAX because it needs to trigger the ->page_free()
> > callback to wake up wait_on_var() via fsdax_pagefree().
> >
> > So I guess you could argue that the MEMORY_DEVICE_PUBLIC removal patch
> > left the original bug in place. In that sense we're no worse off, but
> > since we know about the bug, the fix and the patches have not been
> > applied yet, why not fix it now?
>
> The fix it now would simply be to apply Ira original patch now, but
> given that we are at -rc6 is this really a good time?  And if we don't
> apply it now based on the quilt based -mm worflow it just seems a lot
> easier to apply it after my series.  Unless we want to include it in
> the series, in which case I can do a quick rebase, we'd just need to
> make sure Andrew pulls it from -mm.

I believe -mm auto drops patches when they appear in the -next
baseline. So it should "just work" to pull it into the series and send
it along for -next inclusion.
