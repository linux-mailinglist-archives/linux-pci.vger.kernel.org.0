Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF722950E1
	for <lists+linux-pci@lfdr.de>; Wed, 21 Oct 2020 18:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502984AbgJUQhH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Oct 2020 12:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502977AbgJUQhG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Oct 2020 12:37:06 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AC1C0613D4
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2020 09:37:04 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 188so3041867qkk.12
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2020 09:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BzRdHxhoEjnpcVyZTB9k2I2+fkzcE70kBpksBajHHPg=;
        b=c06LmWtB/eBV/fSiYmdEtL9GPYUkBEwiw6eScZ5dk4Sur880r0RUDUdOasWQ2KsUGe
         bZgM/0p8jMLFa+ikbb0dWN5Ow5CevA+xGmpM9sZNHVumRdO1Tl6lKH78eEdBiQO/7MSc
         SyBxogrPHboOf7N/zRQinZbDgCQncGQf+B3tCHdeRI6jhJnIAAoc2n5M0i1ORD3y+prI
         vtMVVV6QAXuny3nyioqppKj86tWO1HhufpTOjkK/v2RsEfqLugKDikZxGHBEJZrzkhBg
         lGNMu1/vnxQxiUuVEAydazAgNl/YziHidKE+BchWShczAu98wiVxpsNR+uw83dVIq+/q
         VdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BzRdHxhoEjnpcVyZTB9k2I2+fkzcE70kBpksBajHHPg=;
        b=roJ+vsQ2hzjoyGb/F8kNbSOaSIwyJSWNiDg8Hs4AtLG5E31i9Xjr6zWe7pfUPbVZwC
         Yh21oriR96h/CpEhm6GUHF+nhdvs134O5zMfPi00l6otkG6xq86EqYoKYbsHXUKS9cF0
         jzpnAJbjZJfueDGYtN4aLIe4IuVC/UaqMs/TXoaskorVSKlACxDhIIUoCetJZXG7Axw7
         KEPGbFH7Gzp1SXEa5L0xg/E72bfCpIjkbIM9oZqMw9t4e7iZxa1dlFp1w+rcmhWwReJA
         vEV0rNxWX94EYlVwPbONstnk0UIP/DrEgTHdFDijnFYyUVsDq8ntFZ/Lu5btF6xgbZA8
         8QQA==
X-Gm-Message-State: AOAM531fCY19r4NyrtJliCP8U6jU8Ual89TaJjigWoOrdLvZA/bu2SOA
        H/znX39JByRBeupF4igmTmk8/A==
X-Google-Smtp-Source: ABdhPJzGADmR3Upv87Rf5RxP6nvmSwt5ZnM0S0wnKL/4oE2AOzzQDQjF/MbwQajcSGEwpbzdpDuubQ==
X-Received: by 2002:a37:4244:: with SMTP id p65mr3998477qka.141.1603298223560;
        Wed, 21 Oct 2020 09:37:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id r58sm1532749qte.94.2020.10.21.09.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 09:37:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kVH6k-003YkE-3P; Wed, 21 Oct 2020 13:37:02 -0300
Date:   Wed, 21 Oct 2020 13:37:02 -0300
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
Message-ID: <20201021163702.GM36674@ziepe.ca>
References: <20201021085655.1192025-1-daniel.vetter@ffwll.ch>
 <20201021085655.1192025-13-daniel.vetter@ffwll.ch>
 <20201021125030.GK36674@ziepe.ca>
 <CAKMK7uEWe8CaT7zjcZ6dJAKHxtxtqzjVB35fCFviwhcnqksDfw@mail.gmail.com>
 <20201021151352.GL36674@ziepe.ca>
 <CAKMK7uGq0=ks7Zj1Et44k7x9FwE9u_ua4zANSqrLRri0v01V+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uGq0=ks7Zj1Et44k7x9FwE9u_ua4zANSqrLRri0v01V+Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 21, 2020 at 05:54:54PM +0200, Daniel Vetter wrote:

> The trouble is that io_remap_pfn adjust vma->pgoff, so we'd need to
> split that. So ideally ->mmap would never set up any ptes.

/dev/mem makes pgoff == pfn so it doesn't get changed by remap.

pgoff doesn't get touched for MAP_SHARED either, so there are other
users that could work like this - eg anyone mmaping IO memory is
probably OK.

> I guess one option would be if remap_pfn_range would steal the
> vma->vm_ops pointer for itself, then it could set up the correct
> ->install_ptes hook. But there's tons of callers for that, so not sure
> that's a bright idea.

The caller has to check that the mapping is still live, and I think
hold a lock across the remap? Auto-defering it doesn't seem feasible.

Jason
