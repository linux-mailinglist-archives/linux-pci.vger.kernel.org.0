Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30FF85DA5E
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 03:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfGCBKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 21:10:19 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42544 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGCBKT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Jul 2019 21:10:19 -0400
Received: by mail-oi1-f193.google.com with SMTP id s184so603168oie.9
        for <linux-pci@vger.kernel.org>; Tue, 02 Jul 2019 18:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u5UwRiHjXkEAlhFHmvxN8ePNlS4fXC/47jr2WEGpIzo=;
        b=OuN/4ptiyR+plJoUbh14HMfrLiUOlvumFP0tzROycbsFqfygYxNO3xqFi028k9qP6U
         2hsxYQ/2r3+ffTRQvqv/sCf8RYf+3AvuvLqH7ogDKbeVFyv/k7MsfBkCxG4uRyEvLytD
         3hBMhCKOWYcfttKhsfT8Y19T3NlQHBTeuu1o3bC0SKi1LDuyTUAXjHnls8TPzw595KLC
         nNTom92Iwyk5ROjrmSXSDkHChpxbNbnGWGRWyw3laBL4fIp/E7U50dYgr8AGkfNKV1ux
         j9NiIvFe4orlhguGifJ7Su4YhO973/sL8kBVtipoBIsWxN1zYFyjnK/YO/aROHHw66yH
         203w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u5UwRiHjXkEAlhFHmvxN8ePNlS4fXC/47jr2WEGpIzo=;
        b=pgjLyXTgx4VOkBRq2I/+OP3xfttXa0zy69F+3dYNgtOfNOdNEGKo72FAkLUKpZA1tb
         jCYa2zIEftCsqITk1lTwNWiwiZ9JdTvpcWIlYoYsR6eIm9kiE8ejUPe66anUV5Qgk7vR
         SljXsaeb3P2nW1detvcIMS1l31bXckBJ3sGu08vUtKdcCOANE+1YdOfug+BIn+/w2Gt2
         paRJgY4wvFhVTp5LsTkvB7IOEbyejbiUo+x4OJCwWH9vb6r9x3zyeqWpaADAt2IQhPbh
         P6UhwxmmVASVJ2aWdZN/b+IiHUbwNYGMAWmZatbJMvaT4/yo9sT3vwpHufLotLfhqZOI
         j3Dw==
X-Gm-Message-State: APjAAAWp9SfnedZz07kW2iCLH0Vu2uuJ+vHB5cEWct3o0eSZszfDu4BJ
        7hWmVC2JI+9HpRK6vBWbwq9/q2blAWNB4DaOXiYnif10
X-Google-Smtp-Source: APXvYqyLlYpHy9+AMc/X38t5BFMinZJQ01XTqDg0vHmjdWTN0eXoTzXdkzMkhqYvcnewmJArWXl9rZoSGD4d6S4ISik=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr4183998oih.73.1562109479302;
 Tue, 02 Jul 2019 16:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190701062020.19239-1-hch@lst.de> <20190701082517.GA22461@lst.de>
 <20190702184201.GO31718@mellanox.com>
In-Reply-To: <20190702184201.GO31718@mellanox.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 2 Jul 2019 16:17:48 -0700
Message-ID: <CAPcyv4iWXJ-c7LahPD=Qt4RuDNTU7w_8HjsitDuj3cxngzb56g@mail.gmail.com>
Subject: Re: dev_pagemap related cleanups v4
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 2, 2019 at 11:42 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Mon, Jul 01, 2019 at 10:25:17AM +0200, Christoph Hellwig wrote:
> > And I've demonstrated that I can't send patch series..  While this
> > has all the right patches, it also has the extra patches already
> > in the hmm tree, and four extra patches I wanted to send once
> > this series is merged.  I'll give up for now, please use the git
> > url for anything serious, as it contains the right thing.
>
> Okay, I sorted it all out and temporarily put it here:
>
> https://github.com/jgunthorpe/linux/commits/hmm
>
> Bit involved job:
> - Took Ira's v4 patch into hmm.git and confirmed it matches what
>   Andrew has in linux-next after all the fixups
> - Checked your github v4 and the v3 that hit the mailing list were
>   substantially similar (I never did get a clean v4) and largely
>   went with the github version
> - Based CH's v4 series on -rc7 and put back the removal hunk in swap.c
>   so it compiles
> - Merge'd CH's series to hmm.git and fixed all the conflicts with Ira
>   and Ralph's patches (such that swap.c remains unchanged)
> - Added Dan's ack's and tested-by's

Looks good. Test merge (with some collisions, see below) also passes
my test suite.

>
> I think this fairly closely follows what was posted to the mailing
> list.
>
> As it was more than a simple 'git am', I'll let it sit on github until
> I hear OK's then I'll move it to kernel.org's hmm.git and it will hit
> linux-next. 0-day should also run on this whole thing from my github.
>
> What I know is outstanding:
>  - The conflicting ARM patches, I understand Andrew will handle these
>    post-linux-next
>  - The conflict with AMD GPU in -next, I am waiting to hear from AMD

Just a heads up that this also collides with the "sub-section" patches
in Andrew's tree. The resolution is straightforward, mostly just
colliding updates to arch_{add,remove}_memory() call sites in
kernel/memremap.c and collisions with pgmap_altmap() usage.
