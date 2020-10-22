Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA201295F4F
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 15:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899247AbgJVNE1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 09:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507448AbgJVNE0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Oct 2020 09:04:26 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E950C0613D4
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2020 06:04:26 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id i12so1404822ota.5
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2020 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZyNrxU7+apn6xOGNK6avkKI1+/ers9vOGia4XvYK0qo=;
        b=hFupg462AQWF/3SYEGt7TdCBz7vmVV24cGf5H3PsZJ3NHOF7ARTtk1Xj9pQ6xHZuZX
         osgTY+1RlCMoExun5CEMIKW0/Q22JFrGKszrr35SoM6z+n1XQ4DOZb0ztKWF8FqsQ0rj
         YYO9Ror43OTX+8WLAdJnTsM4HmBRXtLFYIBBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZyNrxU7+apn6xOGNK6avkKI1+/ers9vOGia4XvYK0qo=;
        b=s2r+5ASe9IRv7QhjsC3YxQoKVCWhpYzU1Q47zuh51kbCIGSomrZSuxH+H4PWZO7JZ+
         v5Vev/ri37a2W4rkh684M2jmoiIJ2nT5x04kR9RNUGG57s/cSpYHsGlVgcGLS6TCWfXm
         GBCHw4JNAOCdxWnjpCp+9hBk1M3z3KNiNRcXq0+n/NaZ8tD+ZvdpQt9X/Sg0EueC9AGm
         XgMAmJn3m6D87O+B3mEnS+bansa43t/GfEwPWVm/om5dbFncweoN8dM9Q3HEU3PME1Ex
         MV5BMX3vMgjJdi/x143tCpAjhO8tOm1RatEAg5Ljbm8HOJdi5sXNQTnp8mg2kH48WlKY
         ggOg==
X-Gm-Message-State: AOAM530Dqxke5ikC++v2jQALyUB+trkz8dBzkPxc+ljHDoUENPAwFyt9
        LQVvc2vrTNh9ymHxWgc/ON0fhyxFEkuZAJM5PBwYew==
X-Google-Smtp-Source: ABdhPJx8bjchuHtk5X5j8AOy5uSsJ+M716njPCO+bint+3P1gD9xIsXgxoepgb7cnqWbI4FroPmfqz6vrX/g4fdQHsY=
X-Received: by 2002:a05:6830:1647:: with SMTP id h7mr1916643otr.281.1603371865933;
 Thu, 22 Oct 2020 06:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201021085655.1192025-1-daniel.vetter@ffwll.ch>
 <20201021085655.1192025-13-daniel.vetter@ffwll.ch> <20201021125030.GK36674@ziepe.ca>
 <CAKMK7uEWe8CaT7zjcZ6dJAKHxtxtqzjVB35fCFviwhcnqksDfw@mail.gmail.com>
 <20201021151352.GL36674@ziepe.ca> <CAKMK7uGq0=ks7Zj1Et44k7x9FwE9u_ua4zANSqrLRri0v01V+Q@mail.gmail.com>
 <20201021163702.GM36674@ziepe.ca> <CAKMK7uEjE5sHUq0hV_bnYjPKRxYyBnty0sLre+owANGZjLJg9Q@mail.gmail.com>
 <20201021232022.GN36674@ziepe.ca> <CAKMK7uEkAK42+19KRo06XzJFuMCVriEEg0jxqXq8oAdt2ExLsQ@mail.gmail.com>
 <20201022114345.GO36674@ziepe.ca>
In-Reply-To: <20201022114345.GO36674@ziepe.ca>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 22 Oct 2020 15:04:14 +0200
Message-ID: <CAKMK7uHUufuyCXF5jUZG1zZ8SeaAFOi-9dA1sejc2R5fnLTJVA@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] PCI: Obey iomem restrictions for procfs mmap
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 22, 2020 at 1:43 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Oct 22, 2020 at 09:00:44AM +0200, Daniel Vetter wrote:
> > On Thu, Oct 22, 2020 at 1:20 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Wed, Oct 21, 2020 at 09:24:08PM +0200, Daniel Vetter wrote:
> > > > On Wed, Oct 21, 2020 at 6:37 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > > >
> > > > > On Wed, Oct 21, 2020 at 05:54:54PM +0200, Daniel Vetter wrote:
> > > > >
> > > > > > The trouble is that io_remap_pfn adjust vma->pgoff, so we'd need to
> > > > > > split that. So ideally ->mmap would never set up any ptes.
> > > > >
> > > > > /dev/mem makes pgoff == pfn so it doesn't get changed by remap.
> > > > >
> > > > > pgoff doesn't get touched for MAP_SHARED either, so there are other
> > > > > users that could work like this - eg anyone mmaping IO memory is
> > > > > probably OK.
> > > >
> > > > I was more generally thinking for io_remap_pfn_users because of the
> > > > mkwrite use-case we might have in fbdev emulation in drm.
> > >
> > > You have a use case for MAP_PRIVATE and io_remap_pfn_range()??
> >
> > Uh no :-)
>
> So it is fine, the pgoff mangling only happens for MAP_PRIVATE

Ah right I got confused, thanks for clarifying.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
