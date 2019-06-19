Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD2764C0AB
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 20:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbfFSSTZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 14:19:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43198 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSSTZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jun 2019 14:19:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id w17so105641qto.10
        for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2019 11:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j+sIitK0Ja8Ov8ieeJfPWbN0YkrvgCIASmHhWLMuHLw=;
        b=EoBDSvdHfhYd93z8CePBywWHH5bXHAGcXWzOuMLu3/Uzv0MQq7Oam+sAX1Fb7CAk0c
         TJxbr4Wv0/dsOhypCrBG1Gfvu19Gzh1Rl4YrdYTtyiZDVpGot3JGHQS4tKbhDA26+wlS
         NHg9l8u9uVqf2htEjwoSE6SLxVUtPcB5jBlkv236SpPAneNbIGgeXlwOnBB5O/O/foEB
         sQIAgR9sw9NI31785FF4XFeb1aYwjw7IbmedaRaHIZxAz3ePgaJLV84aScqYjsfBC/4L
         bnWCVKMh/fD+HbDYkyAoE78LoiM2L5ceAP3zZNYP8wXBSrgjxJLnv97UmhMOWJKLoWl3
         j/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j+sIitK0Ja8Ov8ieeJfPWbN0YkrvgCIASmHhWLMuHLw=;
        b=JhUz03ltb/EJLJH5jQiCm60RRAm11cFIGXT1VY+pAetOTpuann2NmZR2i44gRowkXO
         uDXn6Y6sdCFi0tYYzQaGzfIEJYccAmbt7tnF3Ui32pb7PEehGSULQTxK/hJxVQv6VjNq
         UM1PYkEZcqTkiqbh2pRrbv1N1C3+8GrnVPmFJ14s6Q8byvhB+kGidxRSCLotuxfVJKAc
         TVpSZ7OAFSubtGZUyShgOCY/5UnzGjqQzCSZlWXmVbMq1LOphTc+Djse4woQBFFECmhA
         sO4QkD96EkYEdYGADoqu6paqY9CsVPew/Lxy96T1bQ3V3AkpYE9Toe4jg7CqKFTc7a53
         Dqvw==
X-Gm-Message-State: APjAAAU0t4PIAxePMlfKEWwKEpPCAv4M0e7dem4t0b7Pp1Yoeko5xOhd
        iz1mO7PBjv1UlPSaOR4YLyEWRA==
X-Google-Smtp-Source: APXvYqwc1d95Ltcmqx/CriKy9P5GUR2ZkHf3pjzc5gWGdXWLliAR4hpwJBxDIhEgyrqz+pevhmgebw==
X-Received: by 2002:aed:3e7c:: with SMTP id m57mr102301688qtf.204.1560968364678;
        Wed, 19 Jun 2019 11:19:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id 15sm10668885qtf.2.2019.06.19.11.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 11:19:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hdfB5-0002ic-8m; Wed, 19 Jun 2019 15:19:23 -0300
Date:   Wed, 19 Jun 2019 15:19:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: dev_pagemap related cleanups v2
Message-ID: <20190619181923.GJ9360@ziepe.ca>
References: <20190617122733.22432-1-hch@lst.de>
 <CAPcyv4hBUJB2RxkDqHkfEGCupDdXfQSrEJmAdhLFwnDOwt8Lig@mail.gmail.com>
 <20190619094032.GA8928@lst.de>
 <20190619163655.GG9360@ziepe.ca>
 <CAPcyv4hYtQdg0DTYjrJxCNXNjadBSWQ5QaMJYsA-QSribKuwrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hYtQdg0DTYjrJxCNXNjadBSWQ5QaMJYsA-QSribKuwrQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 19, 2019 at 09:46:23AM -0700, Dan Williams wrote:
> On Wed, Jun 19, 2019 at 9:37 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Jun 19, 2019 at 11:40:32AM +0200, Christoph Hellwig wrote:
> > > On Tue, Jun 18, 2019 at 12:47:10PM -0700, Dan Williams wrote:
> > > > > Git tree:
> > > > >
> > > > >     git://git.infradead.org/users/hch/misc.git hmm-devmem-cleanup.2
> > > > >
> > > > > Gitweb:
> > > > >
> > > > >     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/hmm-devmem-cleanup.2
> > >
> > > >
> > > > Attached is my incremental fixups on top of this series, with those
> > > > integrated you can add:
> > >
> > > I've folded your incremental bits in and pushed out a new
> > > hmm-devmem-cleanup.3 to the repo above.  Let me know if I didn't mess
> > > up anything else.  I'll wait for a few more comments and Jason's
> > > planned rebase of the hmm branch before reposting.
> >
> > I said I wouldn't rebase the hmm.git (as it needs to go to DRM, AMD
> > and RDMA git trees)..
> >
> > Instead I will merge v5.2-rc5 to the tree before applying this series.
> >
> > I've understood this to be Linus's prefered workflow.
> >
> > So, please send the next iteration of this against either
> > plainv5.2-rc5 or v5.2-rc5 merged with hmm.git and I'll sort it out.
> 
> Just make sure that when you backmerge v5.2-rc5 you have a clear
> reason in the merge commit message about why you needed to do it.
> While needless rebasing is top of the pet peeve list, second place, as
> I found out, is mystery merges without explanations.

Yes, I always describe the merge commits. Linus also particular about
having *good reasons* for merges.

This is why I can't fix the hmm.git to have rc5 until I have patches
to apply..

Probbaly I will just put CH's series on rc5 and merge it with the
cover letter as the merge message. This avoid both rebasing and gives
purposeful merges.

Thanks,
Jason
