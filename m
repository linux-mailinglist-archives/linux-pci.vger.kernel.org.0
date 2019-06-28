Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9887F5A469
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jun 2019 20:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbfF1Sor (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jun 2019 14:44:47 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34489 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfF1Sor (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jun 2019 14:44:47 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so6995339otk.1
        for <linux-pci@vger.kernel.org>; Fri, 28 Jun 2019 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNY+UkoJVrKxCjM2c24Xgrzfzfk/Z55i3p1E82IfUT4=;
        b=zI1Rfkj72TaacEJj7GZa9aQH2dQpodMnoVTwnXEaBlMSZNhY5OVVCjVG5znvL8YDvw
         /w4yi2CZ3bmDcg8+jo0W3xW8odrHcZ2aCHGJ87xs+2ltcljxDeJN66gvtxIzrVxNLxkg
         pL7hur4fQE0hdbPpJ33d47KRUWZSM8qnBIPWODQs6LDS5RSktDpzI29k0ILuZRejss34
         xnFlTPIYvocsrjjzZCQI/0Yj+GNH//C0I7LZJ/r3XYMiRT+Tq5iZQhNf2bG7bpRfCfUN
         VI7eLoWpW+vIxkXl125Fq7E2Z95KiI815ewg7Kq0wfihaAtAnAzS1E/XQAxSbE8m8Iyo
         kZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNY+UkoJVrKxCjM2c24Xgrzfzfk/Z55i3p1E82IfUT4=;
        b=HsNaSSOkzY+A9hH0VhukcuAK9LwgiByaQcR00PR/J/h+ykryeM4wFr7+yArF/n1b6x
         sLsHHg/FFBMmdOUGy3x25lxCzGPTZ5KuYMwO2WmbIVfu+8W6Gf+H6xBUX6V4k1QXLHSQ
         ST7moSIcKG3GblyrJYuAjVlTdhrGWJi8Z5KHX91ibPuMqW+zKMrCE2Pqit0GSM494Icm
         /Krs9VjdVr8NSfu/CZZE6oct0GIt2CMWVrAF04VLqHQW/ChtgsKqcPkfHRPaVkvtUXa5
         VA3SepjTxL+nvf4Ptar+t4rAf+tmz8+lHEGQH3B3LS14wCVlHj8UHsZeH1HGy8s0is9+
         MVww==
X-Gm-Message-State: APjAAAXEbpPACEqzCIMKAiuzQHJ7cS0gwoIDYx2awJXYurLcTomi4cA6
        JrEv+z/BZEM7c7G3Krn2lCSDjYH5YgDm8T41FzJjCA==
X-Google-Smtp-Source: APXvYqy1WcVZusxQT3gsMqR8FxlPuXMWtxZvhAO+zU3jLT7QJNrvbdWUjpng3sXAK8TgdSWU7HjEXIzdeabvXlDD8go=
X-Received: by 2002:a9d:7b48:: with SMTP id f8mr9063478oto.207.1561747486699;
 Fri, 28 Jun 2019 11:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190626122724.13313-1-hch@lst.de> <20190626122724.13313-17-hch@lst.de>
 <20190628153827.GA5373@mellanox.com> <CAPcyv4joSiFMeYq=D08C-QZSkHz0kRpvRfseNQWrN34Rrm+S7g@mail.gmail.com>
 <20190628170219.GA3608@mellanox.com> <CAPcyv4ja9DVL2zuxuSup8x3VOT_dKAOS8uBQweE9R81vnYRNWg@mail.gmail.com>
 <CAPcyv4iWTe=vOXUqkr_CguFrFRqgA7hJSt4J0B3RpuP-Okz0Vw@mail.gmail.com> <20190628182922.GA15242@mellanox.com>
In-Reply-To: <20190628182922.GA15242@mellanox.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Jun 2019 11:44:35 -0700
Message-ID: <CAPcyv4g+zk9pnLcj6Xvwh-svKM+w4hxfYGikcmuoBAFGCr-HAw@mail.gmail.com>
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

On Fri, Jun 28, 2019 at 11:29 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Fri, Jun 28, 2019 at 10:10:12AM -0700, Dan Williams wrote:
> > On Fri, Jun 28, 2019 at 10:08 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Fri, Jun 28, 2019 at 10:02 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > > >
> > > > On Fri, Jun 28, 2019 at 09:27:44AM -0700, Dan Williams wrote:
> > > > > On Fri, Jun 28, 2019 at 8:39 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > > > > >
> > > > > > On Wed, Jun 26, 2019 at 02:27:15PM +0200, Christoph Hellwig wrote:
> > > > > > > The functionality is identical to the one currently open coded in
> > > > > > > device-dax.
> > > > > > >
> > > > > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > > > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > > > > >  drivers/dax/dax-private.h |  4 ----
> > > > > > >  drivers/dax/device.c      | 43 ---------------------------------------
> > > > > > >  2 files changed, 47 deletions(-)
> > > > > >
> > > > > > DanW: I think this series has reached enough review, did you want
> > > > > > to ack/test any further?
> > > > > >
> > > > > > This needs to land in hmm.git soon to make the merge window.
> > > > >
> > > > > I was awaiting a decision about resolving the collision with Ira's
> > > > > patch before testing the final result again [1]. You can go ahead and
> > > > > add my reviewed-by for the series, but my tested-by should be on the
> > > > > final state of the series.
> > > >
> > > > The conflict looks OK to me, I think we can let Andrew and Linus
> > > > resolve it.
> > >
> > > Andrew's tree effectively always rebases since it's a quilt series.
> > > I'd recommend pulling Ira's patch out of -mm and applying it with the
> > > rest of hmm reworks. Any other git tree I'd agree with just doing the
> > > late conflict resolution, but I'm not clear on what's the best
> > > practice when conflicting with -mm.
>
> What happens depends on timing as things arrive to Linus. I promised
> to send hmm.git early, so I understand that Andrew will quilt rebase
> his tree to Linus's and fix the conflict in Ira's patch before he
> sends it.
>
> > Regardless the patch is buggy. If you want to do the conflict
> > resolution it should be because the DEVICE_PUBLIC removal effectively
> > does the same fix otherwise we're knowingly leaving a broken point in
> > the history.
>
> I'm not sure I understand your concern, is there something wrong with
> CH's series as it stands? hmm is a non-rebasing git tree, so as long
> as the series is correct *when I apply it* there is no broken history.
>
> I assumed the conflict resolution for Ira's patch was to simply take
> the deletion of the if block from CH's series - right?
>
> If we do need to take Ira's patch into hmm.git it will go after CH's
> series (and Ira will have to rebase/repost it), so I think there is
> nothing to do at this moment - unless you are saying there is a
> problem with the series in CH's git tree?

There is a problem with the series in CH's tree. It removes the
->page_free() callback from the release_pages() path because it goes
too far and removes the put_devmap_managed_page() call.
