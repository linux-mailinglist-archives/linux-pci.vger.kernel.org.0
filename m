Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB39451A77
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2019 20:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbfFXSZA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 14:25:00 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37437 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbfFXSZA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jun 2019 14:25:00 -0400
Received: by mail-oi1-f195.google.com with SMTP id t76so10532177oih.4
        for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2019 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NsFsqmCeB4cJxbUvEFO6xcZSO/kARHjBGNTe6zm2OGk=;
        b=ISIKS+QlpEyn1hNfgdDi5hMHKw8iit0945EcE3yN7j+0wsgacWlTs5VS/2eHyNPn4P
         zFzHaSyW66Yiy2RhkTwuJ3InCkBlGpTPkGdBxkYOWHXgUlVbX7KrnXrnxhmbl79B80YX
         fCQYLMQ6T4q3GxjWwuuuag5EPhpGhA+skRXUiofVA4jxcOoybEtzKs47HHrVewo4aeOH
         xEgr2mAYq4kDK9twlyulxuXtH8x20UgS6h2b36rjnfm3Zpe3kyRxJhg0wXN2sl5N3Gx9
         a1ANzgYTbnIct0aX4IAsj7uocTALXH4slbfh3ZtWL5Y9qp3yWn0Ovu6E52I1ME72busN
         XZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NsFsqmCeB4cJxbUvEFO6xcZSO/kARHjBGNTe6zm2OGk=;
        b=RMGrD612Wyo+27m0bF38DiAQ7LFhx7rjcn5Hy0UzHDQMoIS+NaAs0kRYp7qK10sP56
         q7m/ZSVzzgZEfhzC0i0ZYBkKgjgZn2WQ+nAR2RnKgUd8EOd8RK8TC/vicryYfZvmH0se
         WZXS2etytw/IG0kPwxZLkuYF7y5TER++N/dWRdgOZc9qa4FMbj3XuabJh4yZKkNd/yLM
         hQ6nx8/8jwwMtv5W1dH3N0ligp+NK/sG6A+INgjiaug71p82hz6t+q8MH5xHj2L5HCpa
         dw00kGXPV2HudABlohFE/HFffZpIVD0+eaYksLX6el3QwWC5cpvFlMWfgDH2IeBRoCxO
         UWgA==
X-Gm-Message-State: APjAAAXI7GKwyUfCNoGuTMmPZHyfY6pPtFjxWXcV0rmKXu/J3UYh7Nbh
        cVhPf5q7gx157zDXFheBrONdy+bhJAsUDlfq5ch0pA==
X-Google-Smtp-Source: APXvYqxMfIu+2D2MtYcv2E7EXzI2zB57kKNYjO9p4H9g9zR42W2XzhT13YcbI1eS8VOBT1jN50QqXbLB+mAAmyIYdBg=
X-Received: by 2002:aca:fc50:: with SMTP id a77mr11696883oii.0.1561400699583;
 Mon, 24 Jun 2019 11:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-6-hch@lst.de>
 <20190620191733.GH12083@dhcp22.suse.cz>
In-Reply-To: <20190620191733.GH12083@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 24 Jun 2019 11:24:48 -0700
Message-ID: <CAPcyv4h9+Ha4FVrvDAe-YAr1wBOjc4yi7CAzVuASv=JCxPcFaw@mail.gmail.com>
Subject: Re: [PATCH 05/22] mm: export alloc_pages_vma
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 20, 2019 at 12:17 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 13-06-19 11:43:08, Christoph Hellwig wrote:
> > noveau is currently using this through an odd hmm wrapper, and I plan
> > to switch it to the real thing later in this series.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  mm/mempolicy.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index 01600d80ae01..f9023b5fba37 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -2098,6 +2098,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
> >  out:
> >       return page;
> >  }
> > +EXPORT_SYMBOL_GPL(alloc_pages_vma);
>
> All allocator exported symbols are EXPORT_SYMBOL, what is a reason to
> have this one special?

I asked for this simply because it was not exported historically. In
general I want to establish explicit export-type criteria so the
community can spend less time debating when to use EXPORT_SYMBOL_GPL
[1].

The thought in this instance is that it is not historically exported
to modules and it is safer from a maintenance perspective to start
with GPL-only for new symbols in case we don't want to maintain that
interface long-term for out-of-tree modules.

Yes, we always reserve the right to remove / change interfaces
regardless of the export type, but history has shown that external
pressure to keep an interface stable (contrary to
Documentation/process/stable-api-nonsense.rst) tends to be less for
GPL-only exports.

[1]: https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2018-September/005688.html
