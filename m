Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D47DE5EB14
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 20:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfGCSD6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 14:03:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34713 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfGCSD6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jul 2019 14:03:58 -0400
Received: by mail-qk1-f195.google.com with SMTP id t8so3555345qkt.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Jul 2019 11:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=lYX4hArZqbN+eTGDydHx247smNMZP20ckzpDZYDyj70=;
        b=GdaPl4pS25oGRqKqhYVZvbGMctmnAHGdnVDY5M9r5E2gXod6kvV8ztPBkFUZyGMM4s
         clYw/MlR3HpP4fUWkXGOqUyErs3qjITlzLbXXg12O9Tm+nYZZaTCWOpGAzeQajKuGTZU
         0wZmmTjqvm2YnyiIapY0xjU8UbEcBknZzuv1w7IATnd4Sq1IJThXnD3h4aGhqzdo2ww1
         6dYcSuMv9naAdmn53AoZUwIOgY2ixkhgWUgG5M3h3qNUG7OVco2Jf970+GkH9fxchzv1
         Bwym1bXm36Zd5IvXjxpJKkA7FdRhwbFO3vyAQP2p0NEj/n2Yq8GEnqIn5HF5aibZNjgw
         i3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lYX4hArZqbN+eTGDydHx247smNMZP20ckzpDZYDyj70=;
        b=CWYRRmMtxXw/0HJj0Z38wX/d7C4sI5WeEt2ArT4JklQf42NKXpgtaumtCLD+1cia+9
         lL/Brl7gUHXhMsLQGzXI86qiBHePpnDo6+LkBbNEwGYDETCw62APvpGDpUk8mCXZ1WQI
         FUzeR5qhnfi3t9pmlTTIn4lBX3Ds6pM54hXuep7OCYyr7Xtzx+BowVZu2KSCKKeKVGr4
         BUp27SOmSaYpM33NsZDiGdxOBmnCwwp3ostNGuvUVfZ+CJkD4IqiYihO9T3y56753frY
         0jAT/V2zlO4LqVE5V2jpKwgk2sg1o85XF7hOYeqYK2x+DK+WJNGs8I/xq+xK35qERgt1
         4HFg==
X-Gm-Message-State: APjAAAUeZyj7jtNEHQoiLFDJTWO/lq88Zuh0jTdxUUxIgENCc72IlH+m
        tnoOPRkl0I0ZaYLR7sML+VFodw==
X-Google-Smtp-Source: APXvYqwAIbwqmaDg6afMKDuszd1tCKqefer9BuJ/SUVOZEN2k8Xz9Vx5WhWvm0C4hIeiM5DGRjiLAw==
X-Received: by 2002:a37:a10b:: with SMTP id k11mr29660901qke.76.1562177037895;
        Wed, 03 Jul 2019 11:03:57 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id f132sm1237440qke.88.2019.07.03.11.03.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 11:03:57 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hijbp-0006qR-01; Wed, 03 Jul 2019 15:03:57 -0300
Date:   Wed, 3 Jul 2019 15:03:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>,
        AlexDeucher <alexander.deucher@amd.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/22] mm: move hmm_vma_fault to nouveau
Message-ID: <20190703180356.GB18673@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701062020.19239-21-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 01, 2019 at 08:20:18AM +0200, Christoph Hellwig wrote:
> hmm_vma_fault is marked as a legacy API to get rid of, but quite suites
> the current nouvea flow.  Move it to the only user in preparation for
> fixing a locking bug involving caller and callee.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  drivers/gpu/drm/nouveau/nouveau_svm.c | 54 ++++++++++++++++++++++++++-
>  include/linux/hmm.h                   | 54 ---------------------------
>  2 files changed, 53 insertions(+), 55 deletions(-)

I was thinking about doing exactly this too, but amdgpu started using
this already obsolete API in their latest driver :(

So, we now need to get both drivers to move to the modern API.

Jason
