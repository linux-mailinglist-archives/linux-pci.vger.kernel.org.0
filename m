Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9E544D23
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 22:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfFMUNx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 16:13:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43836 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfFMUNw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 16:13:52 -0400
Received: by mail-ot1-f66.google.com with SMTP id i8so398559oth.10
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2019 13:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DdSbzBj3GN9lmFE97uLhhDp9bhFpPD/Ri2wBNX09PfQ=;
        b=OSBqGRX5/KZ8rtnYLy8/+VzWXJoy8dOkJHihIoyUXY2eP7FoiV7nziOVkOw4+nZKoB
         8BX3vQfUbWi26DrxuPJOZQTkwLvG8bcvI5bR3K46S8XaTPV6uYDB19u7pEoWDIMGVXIT
         76Gat4HdmnE0UfZtW6tDnTRkZMx/UjOMIIhYc/M0re4EVEJMI//Xgzy79OcW2RngZAFY
         Ex/a+k84aj46psorP2SyODhm0RWUknVG0v09x5bcP8Nl31V8edNccp6WpICo1yfvAEqk
         4PlHWylrgwZOgDTADWj7FVO4iX7LA9uouJaVlZvN2+vo54OtBLhCAxLVmuocFehTb/fy
         IX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DdSbzBj3GN9lmFE97uLhhDp9bhFpPD/Ri2wBNX09PfQ=;
        b=ZJPTISq7mJVP2bOgtd9MHNvRMKPa3Vzvmk8nkvf0PlQV2tdxNxrepI2wTnG9KbmzvH
         Y8dEW3W7sTSAXGW7B13uSoitVWNB2T0Qi2bsV1gEOZzePKrX7OIsyN8A5fLHenBP1n8p
         7I07uqvIt9ARgDStWg1Asilv/Le2Tcan61tK6ZauXkoL9ORBg4jUzhbjcrh8rQw7xKQY
         hMW791CILcayIxh+8PALwY2519br9xih8s2+h8RVuyvOB4Cnpbf3d/BXJskePkEPmngb
         huvuoUv8baDvR5e/ZtY5SrseECiwyofmOdKWzqu5Rk7jahfU8NNTuHfMdHk+qnJEG7UR
         gqqQ==
X-Gm-Message-State: APjAAAUf6HJoECHs1EQCPvaaAKQJ708rV+WhX0tQEC3ghIHbr2edpEOE
        tBNH3ykurKAmlomiCHKdiC3wREMVzGSTKwzpdZdR1Q==
X-Google-Smtp-Source: APXvYqykaGayuOdeZmPun6lqMah28WqyaWO5bFenPtOzBFg0qXVTvO/T6gfkniMpvZVUXEcVxeJc+t1pW1I4QrwLh2Q=
X-Received: by 2002:a9d:7a9a:: with SMTP id l26mr37784514otn.71.1560456832159;
 Thu, 13 Jun 2019 13:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-10-hch@lst.de>
 <20190613193427.GU22062@mellanox.com>
In-Reply-To: <20190613193427.GU22062@mellanox.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Jun 2019 13:13:41 -0700
Message-ID: <CAPcyv4iwVPm2XBviR8E32VJG+ZZTHZLGxDdXS3et22CTT_3qNA@mail.gmail.com>
Subject: Re: [PATCH 09/22] memremap: lift the devmap_enable manipulation into devm_memremap_pages
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
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

On Thu, Jun 13, 2019 at 12:35 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Thu, Jun 13, 2019 at 11:43:12AM +0200, Christoph Hellwig wrote:
> > Just check if there is a ->page_free operation set and take care of the
> > static key enable, as well as the put using device managed resources.
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index c76a1b5defda..6dc769feb2e1 100644
> > +++ b/mm/hmm.c
> > @@ -1378,8 +1378,6 @@ struct hmm_devmem *hmm_devmem_add(const struct hmm_devmem_ops *ops,
> >       void *result;
> >       int ret;
> >
> > -     dev_pagemap_get_ops();
> > -
>
> Where was the matching dev_pagemap_put_ops() for this hmm case? This
> is a bug fix too?
>

It never existed. HMM turned on the facility and made everyone's
put_page() operations slower regardless of whether HMM was in active
use.

> The nouveau driver is the only one to actually call this hmm function
> and it does it as part of a probe function.
>
> Seems reasonable, however, in the unlikely event that it fails to init
> 'dmem' the driver will retain a dev_pagemap_get_ops until it unloads.
> This imbalance doesn't seem worth worrying about.

Right, unless/until the overhead of checking for put_page() callbacks
starts to hurt leaving pagemap_ops tied to lifetime of the driver load
seems acceptable because who unbinds their GPU device at runtime? On
the other hand it was simple enough for the pmem driver to drop the
reference each time a device was unbound just to close the loop.

>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

...minor typo.
