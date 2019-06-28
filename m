Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E460B5A1EB
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2019 19:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfF1RIm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jun 2019 13:08:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45014 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfF1RIl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jun 2019 13:08:41 -0400
Received: by mail-ot1-f65.google.com with SMTP id b7so6644458otl.11
        for <linux-pci@vger.kernel.org>; Fri, 28 Jun 2019 10:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LA7BcUYMgiPM4LhkTkot3xLWQxZ9GymJ/I3cshi8054=;
        b=aWEsAGzc2Yh3JREBeLfqCnbjuH6gFhlIwpqtRUdyIB6fGEGjp0c/9cteoNu7mVTPYk
         k7v3tmKRFxuMhqWzggOKwBghog33HajwgNHqZGgt7yBZssqkujvFSdmZ6oFP073o8bd1
         ZFWE8m7Q/mY3rKQ0JO12vTiImwp/mNsQn0+1FPDFmxgJqZwFVHptf+HajNjWmdXZdyi/
         sXfT7o1lOMP8oP6O1xqR5I5TKSGwy+YYZ/aXoZ4EnNCmm8t/FhivsI3LpEb/JP77AiWP
         Hl/nPelTzud50IIzNwJksYSVmktcqKvzLaRjqqynqcF7HJ5XeVfEHEzsPm9koUpO7D/j
         z+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LA7BcUYMgiPM4LhkTkot3xLWQxZ9GymJ/I3cshi8054=;
        b=dF/cfL8nmCAUZ1+ZLjW1Mkgh5RblSAAjDuy9fJTituOdKL+t5SsgSmcReJK+kVRJy8
         ouoNAUA5+Clrvbc6w2sPhLOwJO+tKq8RryAWrBMY/v+m9rGPLTDP44pRi2E07Q8++EUU
         TdcDBQN2Hspt2OvLxvSpdFTmUUiaJxqw5ld490nGkFbPm3Wnf7/WBKkKgRCZJ9/Q95QF
         IAhL6uDPHy8Lc1lXyv+7YEoBrrTbbOYuR+G00Od+9hwg5euXhSB9wQYQi1NICRxsRNyV
         1bf9/kjwr7NEHzZcZzKf/1UVjA0r0uh4zZguvoKcbVbErlQh0OHWmo+4MjZMMpByVFyI
         0AzQ==
X-Gm-Message-State: APjAAAVGaoRD8OY0XZ4JW0F2N/hq9N3UrZXr2iVLICb7Pg51oZk9GTQb
        yXqmiMgNkaOKiAlhuNcW7yKYX96M3wtqRwnjYOk/kA==
X-Google-Smtp-Source: APXvYqx9NDQoyUwfceLcBzkU2NvzJ3YM6qn8RS5E95TlC5H3OILwJGHGUQARUz+LN1VfbIDPOiU7HWfaHbo1PzKN6QA=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr8719655oto.207.1561741721035;
 Fri, 28 Jun 2019 10:08:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190626122724.13313-1-hch@lst.de> <20190626122724.13313-17-hch@lst.de>
 <20190628153827.GA5373@mellanox.com> <CAPcyv4joSiFMeYq=D08C-QZSkHz0kRpvRfseNQWrN34Rrm+S7g@mail.gmail.com>
 <20190628170219.GA3608@mellanox.com>
In-Reply-To: <20190628170219.GA3608@mellanox.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Jun 2019 10:08:30 -0700
Message-ID: <CAPcyv4ja9DVL2zuxuSup8x3VOT_dKAOS8uBQweE9R81vnYRNWg@mail.gmail.com>
Subject: Re: [PATCH 16/25] device-dax: use the dev_pagemap internal refcount
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
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

On Fri, Jun 28, 2019 at 10:02 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Fri, Jun 28, 2019 at 09:27:44AM -0700, Dan Williams wrote:
> > On Fri, Jun 28, 2019 at 8:39 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > >
> > > On Wed, Jun 26, 2019 at 02:27:15PM +0200, Christoph Hellwig wrote:
> > > > The functionality is identical to the one currently open coded in
> > > > device-dax.
> > > >
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > >  drivers/dax/dax-private.h |  4 ----
> > > >  drivers/dax/device.c      | 43 ---------------------------------------
> > > >  2 files changed, 47 deletions(-)
> > >
> > > DanW: I think this series has reached enough review, did you want
> > > to ack/test any further?
> > >
> > > This needs to land in hmm.git soon to make the merge window.
> >
> > I was awaiting a decision about resolving the collision with Ira's
> > patch before testing the final result again [1]. You can go ahead and
> > add my reviewed-by for the series, but my tested-by should be on the
> > final state of the series.
>
> The conflict looks OK to me, I think we can let Andrew and Linus
> resolve it.
>

Andrew's tree effectively always rebases since it's a quilt series.
I'd recommend pulling Ira's patch out of -mm and applying it with the
rest of hmm reworks. Any other git tree I'd agree with just doing the
late conflict resolution, but I'm not clear on what's the best
practice when conflicting with -mm.
