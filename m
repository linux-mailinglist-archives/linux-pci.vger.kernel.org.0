Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657C7295DA5
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 13:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897495AbgJVLnt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 07:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897496AbgJVLnr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Oct 2020 07:43:47 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8873EC0613D2
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2020 04:43:47 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id w9so664606qvj.0
        for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2020 04:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tn5VStmyr19eg0AHWkg65WyZIMHvKO6plAVuAqOgPDQ=;
        b=W2W63+Km46WNPYtkSR3igfnV7TEUq5madmsiNOsLljJ4hXhwY+tNpYNU0U98RMc/Ra
         N/OqT1bclh4ytLL1rVRfHDNQXuCClycUHEstVDTB13O2SeX7rcenP16ZDtQZwB1W1jcc
         qY+V9dfylqzLN5PiDQabSjcYMeIPMV8H3MvDBIvqP9uVDzx0l3+DGSbt51z70fKAGBps
         MOgHN8p+THySDXKSzKDRAxFER+JAglmr7hGRyvf9N5t7jpnIarxCymOKiSFfwhwoQKR+
         3E88SiMtx1h9HdY+LUkd3T5LmcI1LTVNdrFdFYFYlKXO0Wntp7OMh6vxttQFR1tsYI0Q
         kJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tn5VStmyr19eg0AHWkg65WyZIMHvKO6plAVuAqOgPDQ=;
        b=qvj8UPTm+oQ2iU1AR8Py3rDiDFXgNQoDq/0m5fKIx6BTcXR37SZ8gvMLfKqMvM6Pl4
         GWF/mh1IRWxMPiIL0v0ZKLsF6jYXwmnAymgkLZbx60nP7uVXrTIKMbDBdUoGQsL2t6hW
         wnQAPZBt2CUsiEkto2YBdWupXv8v5J6jjpwL0eeyLzN8F9cwLT85Q/1EOywNfsJJY203
         NQL5UR6GzVprDUTJGrcfL31ws1/ylVNa98IfDbzoG0lxIDTqoLtKVnT3yVJD349/Plsw
         HGgWVQ3CTjp/V0anPZG4fo5C3nvB6kCl06QpK7PC6niSIrmVuhk7zRo7TqGvyQOfnXF2
         rFVQ==
X-Gm-Message-State: AOAM53045VXw8164tk8jRxCglIMLOFRAsEFyU3fkgKyoNsOXZahmVjau
        Z+0QbWDB8uIu2KkUqGzq6x6bnQ==
X-Google-Smtp-Source: ABdhPJw6OYYGIWsKIpwZGlvXqWx4K8ij3H0LBJb/eEFtxBXIO8uo2emBiN1PSKDxC0xVD0g026FmxA==
X-Received: by 2002:ad4:45a5:: with SMTP id y5mr1935405qvu.40.1603367026713;
        Thu, 22 Oct 2020 04:43:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l25sm820821qtf.18.2020.10.22.04.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 04:43:45 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kVZ0T-0040bW-1W; Thu, 22 Oct 2020 08:43:45 -0300
Date:   Thu, 22 Oct 2020 08:43:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
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
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.com>
Subject: Re: [PATCH v3 12/16] PCI: Obey iomem restrictions for procfs mmap
Message-ID: <20201022114345.GO36674@ziepe.ca>
References: <20201021085655.1192025-1-daniel.vetter@ffwll.ch>
 <20201021085655.1192025-13-daniel.vetter@ffwll.ch>
 <20201021125030.GK36674@ziepe.ca>
 <CAKMK7uEWe8CaT7zjcZ6dJAKHxtxtqzjVB35fCFviwhcnqksDfw@mail.gmail.com>
 <20201021151352.GL36674@ziepe.ca>
 <CAKMK7uGq0=ks7Zj1Et44k7x9FwE9u_ua4zANSqrLRri0v01V+Q@mail.gmail.com>
 <20201021163702.GM36674@ziepe.ca>
 <CAKMK7uEjE5sHUq0hV_bnYjPKRxYyBnty0sLre+owANGZjLJg9Q@mail.gmail.com>
 <20201021232022.GN36674@ziepe.ca>
 <CAKMK7uEkAK42+19KRo06XzJFuMCVriEEg0jxqXq8oAdt2ExLsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEkAK42+19KRo06XzJFuMCVriEEg0jxqXq8oAdt2ExLsQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 22, 2020 at 09:00:44AM +0200, Daniel Vetter wrote:
> On Thu, Oct 22, 2020 at 1:20 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Oct 21, 2020 at 09:24:08PM +0200, Daniel Vetter wrote:
> > > On Wed, Oct 21, 2020 at 6:37 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Wed, Oct 21, 2020 at 05:54:54PM +0200, Daniel Vetter wrote:
> > > >
> > > > > The trouble is that io_remap_pfn adjust vma->pgoff, so we'd need to
> > > > > split that. So ideally ->mmap would never set up any ptes.
> > > >
> > > > /dev/mem makes pgoff == pfn so it doesn't get changed by remap.
> > > >
> > > > pgoff doesn't get touched for MAP_SHARED either, so there are other
> > > > users that could work like this - eg anyone mmaping IO memory is
> > > > probably OK.
> > >
> > > I was more generally thinking for io_remap_pfn_users because of the
> > > mkwrite use-case we might have in fbdev emulation in drm.
> >
> > You have a use case for MAP_PRIVATE and io_remap_pfn_range()??
> 
> Uh no :-)

So it is fine, the pgoff mangling only happens for MAP_PRIVATE

Jason
