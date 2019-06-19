Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD7FF4C1AB
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 21:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfFSTqO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 15:46:14 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37558 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfFSTqN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 15:46:13 -0400
Received: by mail-ot1-f66.google.com with SMTP id s20so266138otp.4
        for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2019 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AppOhepgnEe0jjnJnZQBJyzyqCwLm69rPfFkLY+t1bc=;
        b=L+LW3co1OBHWplV01UpK1fvt6NIcRF2qR2+gyrISeEZDbLPi91YZXqNIJExJQhxjVL
         7NO7u5O4wqUQFCjZA8X/xN5IC6nTONNL0PLEmadz1t01bknVW+LPFjhIpUDlZICWj1OK
         Gog3pb+AQtERVqv6j7fTaoTVYFpk5W1Hfef0DgmAjMPes0MNZ9hclPMHOd3R6z/1niZy
         xhltfPQTbipOo4AOyWvfdtdcgObLiRuElMk7blxcxcA8+NrVrohUYIrXM1xWntr04dh1
         fdyvcy8a9IUZO0qDkJUM7+nBLab/Ub+ZVWPgR39zFgOFrotnlWhaK61bEldeFuweA1TX
         hgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AppOhepgnEe0jjnJnZQBJyzyqCwLm69rPfFkLY+t1bc=;
        b=MQtsKOhNnSYh5LR/zsNgHOuMGLqWBjU5D3WfBZYxDmGjEQe/dJUSujvmLzFfJ9Zbt2
         xk/mpKBRWaPm+oZuFHfLTPviEPu8VVcPDqDba0JnUchf9euiDA+ULJEQZdcS/VK3elSw
         wrCsdAlFSaSWK09EV4cYKvSzZ7eZSOXCZJXwhxawwiJRNsVrwlYZUEiE9MrjBb9QGGtL
         hCfFbWAeAhFyCzRGCjahPUEiW4lKkkbQf2sq2wtidn3DAl9qukw1NUETbrjRHp9+vzaZ
         gxYoHQBZTEm2+E9jrYwge1ePduOsr/DvNAnjp4mcBZ/u6BkwCblDeZuw8jmR1872yKVV
         CK7g==
X-Gm-Message-State: APjAAAWfk4h3Hq+pRnRyaJ3TD0YC5/S9YbrLaOhFmuhz599D8fPL4FmT
        5OepW9rYZ6mRAbMyasyEnlaYpg7AmMqWyWZTaGtWCw==
X-Google-Smtp-Source: APXvYqyF4/fQjVQSHjLx0TTlLSRvNfoC1XWgfZBLjCA5t1eNPRU75djqD3lZLhJzoRPj37ekmpc9LL5nqKSkBxWsIsE=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr36193657otf.126.1560973572970;
 Wed, 19 Jun 2019 12:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-19-hch@lst.de>
 <20190613194430.GY22062@mellanox.com> <a27251ad-a152-f84d-139d-e1a3bf01c153@nvidia.com>
 <20190613195819.GA22062@mellanox.com> <20190614004314.GD783@iweiny-DESK2.sc.intel.com>
 <d2b77ea1-7b27-e37d-c248-267a57441374@nvidia.com> <20190619192719.GO9374@mellanox.com>
In-Reply-To: <20190619192719.GO9374@mellanox.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 Jun 2019 12:46:01 -0700
Message-ID: <CAPcyv4j+zk_5WvFXbUbQ7bWisjWSwzwLsXide1AuVL4kLX8iyQ@mail.gmail.com>
Subject: Re: [PATCH 18/22] mm: mark DEVICE_PUBLIC as broken
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 19, 2019 at 12:42 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Thu, Jun 13, 2019 at 06:23:04PM -0700, John Hubbard wrote:
> > On 6/13/19 5:43 PM, Ira Weiny wrote:
> > > On Thu, Jun 13, 2019 at 07:58:29PM +0000, Jason Gunthorpe wrote:
> > >> On Thu, Jun 13, 2019 at 12:53:02PM -0700, Ralph Campbell wrote:
> > >>>
> > ...
> > >> Hum, so the only thing this config does is short circuit here:
> > >>
> > >> static inline bool is_device_public_page(const struct page *page)
> > >> {
> > >>         return IS_ENABLED(CONFIG_DEV_PAGEMAP_OPS) &&
> > >>                 IS_ENABLED(CONFIG_DEVICE_PUBLIC) &&
> > >>                 is_zone_device_page(page) &&
> > >>                 page->pgmap->type == MEMORY_DEVICE_PUBLIC;
> > >> }
> > >>
> > >> Which is called all over the place..
> > >
> > > <sigh>  yes but the earlier patch:
> > >
> > > [PATCH 03/22] mm: remove hmm_devmem_add_resource
> > >
> > > Removes the only place type is set to MEMORY_DEVICE_PUBLIC.
> > >
> > > So I think it is ok.  Frankly I was wondering if we should remove the public
> > > type altogether but conceptually it seems ok.  But I don't see any users of it
> > > so...  should we get rid of it in the code rather than turning the config off?
> > >
> > > Ira
> >
> > That seems reasonable. I recall that the hope was for those IBM Power 9
> > systems to use _PUBLIC, as they have hardware-based coherent device (GPU)
> > memory, and so the memory really is visible to the CPU. And the IBM team
> > was thinking of taking advantage of it. But I haven't seen anything on
> > that front for a while.
>
> Does anyone know who those people are and can we encourage them to
> send some patches? :)

I expect marking it CONFIG_BROKEN with the threat of deleting it if no
patches show up *is* the encouragement.
