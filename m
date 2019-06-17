Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74AA048A48
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 19:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfFQRhZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 13:37:25 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42458 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfFQRhZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 13:37:25 -0400
Received: by mail-ot1-f68.google.com with SMTP id l15so444943otn.9
        for <linux-pci@vger.kernel.org>; Mon, 17 Jun 2019 10:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gBoBuo4G3FSgEhDC+FoktVJNloMg07m1kebASNjaow0=;
        b=GEy6EGCLZL0UwYQ9PkUNByAPZFrQNOY55J4Isr3tPIqQ98XVq0fsFEiJHE9y337UnR
         z0ckb3F0Q8bUBMwOxk3FMovLMeLeRhGzCH4bMfXl//v4SZneAiWL2E3nXGQ0kfcbkMQ5
         r05Q0aOOGSCIoONjGAUc0NUdIqrqwt9uOKpttnI5/W0wpWZ0UjI/eMzHv96YMzDyw6ea
         Iw2XLIDHbY2xAKMBDynID8VFE/XZYZnxY6Kobfxb5Ee621xVhNNWauS73uuIqKg8WlP8
         DC4G2oI80ceWohUqqQoEpsB1uZSHUXQoqzfwbmLCxnomOs9Nh6gRUrBB4UmmNwcz2q++
         zoow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gBoBuo4G3FSgEhDC+FoktVJNloMg07m1kebASNjaow0=;
        b=AXgbnbUA0MZZ9F3ON5tljJeIehMOYgkNZrAiF+yOLGnwnuQa3jWErPtW2S8IVEeba4
         qC2UdUD2znznPvBmYq5pbztOBjX4qj1FylnR0VAAzOASAHq+qDZfhKd92Gz3baIgTIRn
         zRt2axvLUTYhsXXGzAe3LoEBfGDZhRhtoqLjDekfb7DO5YN/+mXitaKheQ0nZbT14vKf
         IpiBo+n5gRoHiQU5YGHOc6sRBYei0rEWsvsi9X3FVKiYqbx6VddbDvp25MW7MOnwFPeD
         1gUbJX/Y+u4/7+y8wDWsjqCIO5mBLYoUgRoQcpG/K3I1OuS+DLo4ov+cPs0W1uxCn9Q8
         wiTw==
X-Gm-Message-State: APjAAAWYh/M6+KE5NclhgfEQfcDFjHCR+yGMN6dxIu+lkIFa9kGtBsta
        RP7994yTnOjaXkY/q0hbszywlD00O/iIN+oPKdOTMA==
X-Google-Smtp-Source: APXvYqy6UHQ+8+yRan8DQxrtjWFO0AeHWuMCd0MZM6YFNNcDvh4g1h/fJSpQjjAZ+ZTnayEmtlW26P14xfxTxsyl170=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr25335686otf.126.1560793043776;
 Mon, 17 Jun 2019 10:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122733.22432-1-hch@lst.de> <20190617122733.22432-7-hch@lst.de>
In-Reply-To: <20190617122733.22432-7-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 Jun 2019 10:37:12 -0700
Message-ID: <CAPcyv4hoRR6gzTSkWnwMiUtX6jCKz2NMOhCUfXTji8f2H1v+rg@mail.gmail.com>
Subject: Re: [PATCH 06/25] mm: factor out a devm_request_free_mem_region helper
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 17, 2019 at 5:27 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Keep the physical address allocation that hmm_add_device does with the
> rest of the resource code, and allow future reuse of it without the hmm
> wrapper.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/ioport.h |  2 ++
>  kernel/resource.c      | 39 +++++++++++++++++++++++++++++++++++++++
>  mm/hmm.c               | 33 ++++-----------------------------
>  3 files changed, 45 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index da0ebaec25f0..76a33ae3bf6c 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -286,6 +286,8 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
>         return (r1->start <= r2->end && r1->end >= r2->start);
>  }
>
> +struct resource *devm_request_free_mem_region(struct device *dev,
> +               struct resource *base, unsigned long size);

This appears to need a 'static inline' helper stub in the
CONFIG_DEVICE_PRIVATE=n case, otherwise this compile error triggers:

ld: mm/hmm.o: in function `hmm_devmem_add':
/home/dwillia2/git/linux/mm/hmm.c:1427: undefined reference to
`devm_request_free_mem_region'
