Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCB75A4AB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2019 20:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfF1S7b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jun 2019 14:59:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45221 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfF1S7b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jun 2019 14:59:31 -0400
Received: by mail-ot1-f68.google.com with SMTP id x21so6990651otq.12
        for <linux-pci@vger.kernel.org>; Fri, 28 Jun 2019 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZKi8dPs5bce5TA+lDYDR67LZgo76bXK/epIzKFvivc=;
        b=w73nxePK59nSfEruxrF1M0kHpQTfXV+T0BR3rvgPNUWzxDsJQPeaM7uFD7eKRrxE9Y
         9ImwGmBtt6yXJ6nlctHx0FbYi1ua/8g/5ZblEqYZrPEU8IkQx9AAwyacMH73KkUPSZW4
         2CnxLw8FBn5LZR6QuLzXXkPegk+n9WnVTkvOy7EQwUeDTJ/KqrjyTyioxg0mlKF5l5Fl
         pBgbtoepm7/tvV+XTP8uNL6F6V5682w/nGp9yu+fmrqAAOl3CXi6A8E63DaUmygnIHBK
         Lo3TxfO9CsdVEHmVkApvqnki+XHSFnPPV047Ep963nO0SUi6VwELdrivAHXWP8JUXEYH
         XM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZKi8dPs5bce5TA+lDYDR67LZgo76bXK/epIzKFvivc=;
        b=FU6xxyg8sPI0y1lpfACkA7JmM4bcoqrA2XWDa+rpyksIGIYVadSqZvJ1bnG7bxE/Ra
         iWnG6pA9snqN3CHouSvKUh1VtahwfE4MkHMtnahJAhnWubq7loqgHEhzMsHXkAEHzNkl
         xYCxbtezRJ6xb/KvcJ1XYMztR9ezRvvQGm04RsAfZZn1ZCokH7/da6Ux9e+iifYE9wBz
         ICsfdHfM738dvMZOI3VPcKUEqtB8orjLaypaMNrl6IShTraxk7yOwdtxPZq35LFEvs/d
         oeIvpUbEmxeuxjeHdJt1jN5hRQcy03hRNFWqj/0v++aRvQu3udDMLaxx5unyDrJ1/ONk
         nahA==
X-Gm-Message-State: APjAAAUOUuEPeFhAs9SAGY7MNJhrjzbrLN06vVJlT+FxJJJkTKZH+79q
        cPRsfU1OxX1ehrxPNdatexU2AvpilXHa3ofiHIjshh0bDGo=
X-Google-Smtp-Source: APXvYqxUAlE0PhQVf+kI2qGh3xwcV/BdcPGn6HCqEnYJmqo0MIx4gI+EfnCAuColBmsblnHh366HyPqaX1Z8NdWYLok=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr8858325otn.247.1561748370285;
 Fri, 28 Jun 2019 11:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190626122724.13313-1-hch@lst.de> <20190626122724.13313-17-hch@lst.de>
 <20190628153827.GA5373@mellanox.com> <CAPcyv4joSiFMeYq=D08C-QZSkHz0kRpvRfseNQWrN34Rrm+S7g@mail.gmail.com>
 <20190628170219.GA3608@mellanox.com> <CAPcyv4ja9DVL2zuxuSup8x3VOT_dKAOS8uBQweE9R81vnYRNWg@mail.gmail.com>
 <CAPcyv4iWTe=vOXUqkr_CguFrFRqgA7hJSt4J0B3RpuP-Okz0Vw@mail.gmail.com>
 <20190628182922.GA15242@mellanox.com> <CAPcyv4g+zk9pnLcj6Xvwh-svKM+w4hxfYGikcmuoBAFGCr-HAw@mail.gmail.com>
 <20190628185152.GA9117@lst.de>
In-Reply-To: <20190628185152.GA9117@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Jun 2019 11:59:19 -0700
Message-ID: <CAPcyv4i+b6bKhSF2+z7Wcw4OUAvb1=m289u9QF8zPwLk402JVg@mail.gmail.com>
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

On Fri, Jun 28, 2019 at 11:52 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Jun 28, 2019 at 11:44:35AM -0700, Dan Williams wrote:
> > There is a problem with the series in CH's tree. It removes the
> > ->page_free() callback from the release_pages() path because it goes
> > too far and removes the put_devmap_managed_page() call.
>
> release_pages only called put_devmap_managed_page for device public
> pages.  So I can't see how that is in any way a problem.

It's a bug that the call to put_devmap_managed_page() was gated by
MEMORY_DEVICE_PUBLIC in release_pages(). That path is also applicable
to MEMORY_DEVICE_FSDAX because it needs to trigger the ->page_free()
callback to wake up wait_on_var() via fsdax_pagefree().

So I guess you could argue that the MEMORY_DEVICE_PUBLIC removal patch
left the original bug in place. In that sense we're no worse off, but
since we know about the bug, the fix and the patches have not been
applied yet, why not fix it now?
