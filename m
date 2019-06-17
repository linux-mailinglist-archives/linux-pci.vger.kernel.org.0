Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94CAE491FD
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 23:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfFQVJg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 17:09:36 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35544 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfFQVJg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 17:09:36 -0400
Received: by mail-ot1-f66.google.com with SMTP id j19so11210304otq.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Jun 2019 14:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WJY8mRWNKYbMrxiqtcC6On1cSl2WUj/ZIwS4ootoQak=;
        b=1CPoHsv8eJYyjii0r2v+tpwEGCkSWwSYtZacx/AqtzGMRs3fZPgZrV7RbEeA45KDwP
         lsJvq7QgmiqEwVzp5wdQHibzWroOdc9btguH5MJ/BTdcEtQKRrkY2A644oJ5v1entk28
         jQX1i10dz7Bzaag9WMXeIi4g9aL/drgYMGhz0EwOOdHkXNcNmVY9Lux9aw2TbX6HsoFA
         rgd+c/SR//qS9xH7huYep7vdqcSElSiqUL7CnczUCly0wMqqGAQdyboSJvis9joomSOv
         KyK08LiIatM0igaxt5Yo3ksIlA7sTKvevIo1tgB6DFbvKhgZgBfO8B1hLUl5bdDehAB/
         2KGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WJY8mRWNKYbMrxiqtcC6On1cSl2WUj/ZIwS4ootoQak=;
        b=qKgQFyJjkTLup1of6EGXxgOvAroaNnAU8sfNLN8napu3M2MRaZcEkDZU0c4tJJSInT
         RtjL6ZXIfh2oz0yQ786MV9/bDJQQKLXRS6I5PoHofW894mXajSTV/tK2nZl+5S4/wpG2
         A9ClyRcOsJkzr7qg8mWwkSQa3K85EOwPLzLJjRoMSqJXJSTKUbXVNlYCQ0pxL9aUu1TI
         i1uc++Lau1jeF4F7ojg4TKewl+sDZ8aKvfzLfMS6ZdwAc3aMG1eMP0h7tkS+RvB3vPXJ
         fiOEG/xCu3HYeg36wh5M4JOzUBIEbNy+hG9j1Y/n+6aAYDlMcX9BG9yTNhdkuCdLudqg
         Sjcw==
X-Gm-Message-State: APjAAAUiEvEVEt0pcO6V8OTWz099MToa6WbgaNuWhAsHgM5fJTCydEOJ
        xP7gHeGXT6AOXeFuUkd5Wgm1/4p1ErL3mYGEC3fjjQ==
X-Google-Smtp-Source: APXvYqyAU1TcMvPiGYVYhBbyC0eVXwwhkAqKTWqXoLyuFCBz8f0kthsk9jFJXToSNfs33gSFBQCmV/94ID8R2le9oJQ=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr55835238otn.247.1560805775819;
 Mon, 17 Jun 2019 14:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122733.22432-1-hch@lst.de> <20190617122733.22432-9-hch@lst.de>
 <CAPcyv4i_0wUJHDqY91R=x5M2o_De+_QKZxPyob5=E9CCv8rM7A@mail.gmail.com> <20190617195526.GB20275@lst.de>
In-Reply-To: <20190617195526.GB20275@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 Jun 2019 14:09:24 -0700
Message-ID: <CAPcyv4iYP-7QtO7hDkAeaxJsfUCrCTBSJi3bK6e5v-VVAKQz-w@mail.gmail.com>
Subject: Re: [PATCH 08/25] memremap: move dev_pagemap callbacks into a
 separate structure
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 17, 2019 at 12:59 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 17, 2019 at 10:51:35AM -0700, Dan Williams wrote:
> > > -       struct dev_pagemap *pgmap =3D _pgmap;
> >
> > Whoops, needed to keep this line to avoid:
> >
> > tools/testing/nvdimm/test/iomap.c:109:11: error: =E2=80=98pgmap=E2=80=
=99 undeclared
> > (first use in this function); did you mean =E2=80=98_pgmap=E2=80=99?
>
> So I really shouldn't be tripping over this anymore, but can we somehow
> this mess?
>
>  - at least add it to the normal build system and kconfig deps instead
>    of stashing it away so that things like buildbot can build it?
>  - at least allow building it (under COMPILE_TEST) if needed even when
>    pmem.ko and friends are built in the kernel?

Done: https://patchwork.kernel.org/patch/11000477/
