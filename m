Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61E48E73
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 21:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbfFQTZ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 15:25:29 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34495 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFQTZ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 15:25:29 -0400
Received: by mail-ot1-f67.google.com with SMTP id n5so10723494otk.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Jun 2019 12:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HNxPoXz08Bkv6XLKAsIWbiHb1gnesryRGgT+tAFHLoc=;
        b=zsU6x4/n004yGk33kbKQd/6ii5ctCApqWKr2xXu2QHfi+ncPf+6aOer/hnDk2UAkcB
         jGunUn0he2nTR0uU2859WbUUtlv6pvLc41AXK2T6AWHriY76vgq0YRD//La6/nHXzo1Z
         YPIa/GBGOk0VXAfuIX+0DmRt+mlbZWG/S7zDJ2J1W8prL2gnJon9QkcM3fcOMMdwSo4e
         4OrGQSbgcfUmMeefb3e2ZPd0f7T54UdNfjjuNpUJ/GMYEaMNtkVI6YVgubTvq1/bIgZo
         qVrNws/T9AqY75DGEixSkuSqStvevZuszwTUzd/rSGi9BdsaPARyVCoYryGFhOd3HmF5
         Pgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HNxPoXz08Bkv6XLKAsIWbiHb1gnesryRGgT+tAFHLoc=;
        b=gzCf1bnCb34/uKNY2rPWIfyDG5VSvhGqQF7xVqA6UukvJqYbwRh+lL92kJu6jEYQ0W
         dhD06XMutnZDsSvRMbaK5TSk8uuSZD4hHA78wtO0QaCDc8SWwsiAofRtVz/F52PWH7v7
         cKSLGcinug1raaDvIBUhDSn6eu8QRqwcz9F0TpgqmsMgIDf7iRlb7oEECuaNQrh789bE
         yNzICLX8zMK/M0kvBxkXxo1Jn9zY5fHzk52kJBKv0pDt5ADVzmkRkZmqMbxONQ4oHX9Y
         +h+vl7MLflFd3+XkRoFAprpGX1nAsp95DcUw/ttX4r/hWCYEp6O8swm306owTGEjIJhF
         c69g==
X-Gm-Message-State: APjAAAW8Tq3hCDm9zPzJf4HDbBxD3IPNLg8onrijE0lo2q3/lsBKJCD6
        t65ZU05ywpHpfGHZ94olw3XB1ypKjeFyXykHbaSZKg==
X-Google-Smtp-Source: APXvYqyQusXzMIvOnOSDlzozCSKeY3iIGkQ0PmM8jIAxg1c9m+Lhh4LXmnIB3y6iM6i/y/0k5RVphJmN2SXJiVLtpbU=
X-Received: by 2002:a9d:7a8b:: with SMTP id l11mr55333952otn.247.1560799528939;
 Mon, 17 Jun 2019 12:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190617122733.22432-1-hch@lst.de> <20190617122733.22432-11-hch@lst.de>
In-Reply-To: <20190617122733.22432-11-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 17 Jun 2019 12:25:17 -0700
Message-ID: <CAPcyv4jtZSK7bgQX_Sm1E-Thqmyhs30SrZKoSApjghRLL12Ngg@mail.gmail.com>
Subject: Re: [PATCH 10/25] memremap: lift the devmap_enable manipulation into devm_memremap_pages
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 17, 2019 at 5:28 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Just check if there is a ->page_free operation set and take care of the
> static key enable, as well as the put using device managed resources.
> Also check that a ->page_free is provided for the pgmaps types that
> require it, and check for a valid type as well while we are at it.
>
> Note that this also fixes the fact that hmm never called
> dev_pagemap_put_ops and thus would leave the slow path enabled forever,
> even after a device driver unload or disable.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvdimm/pmem.c | 23 +++--------------
>  include/linux/mm.h    | 10 --------
>  kernel/memremap.c     | 57 ++++++++++++++++++++++++++-----------------
>  mm/hmm.c              |  2 --
>  4 files changed, 39 insertions(+), 53 deletions(-)
>
[..]
> diff --git a/kernel/memremap.c b/kernel/memremap.c
> index ba7156bd52d1..7272027fbdd7 100644
> --- a/kernel/memremap.c
> +++ b/kernel/memremap.c
[..]
> @@ -190,6 +219,12 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
>                 return ERR_PTR(-EINVAL);
>         }
>
> +       if (pgmap->type != MEMORY_DEVICE_PCI_P2PDMA) {

Once we have MEMORY_DEVICE_DEVDAX then this check needs to be fixed up
to skip that case as well, otherwise:

 Missing page_free method
 WARNING: CPU: 19 PID: 1518 at kernel/memremap.c:33
devm_memremap_pages+0x745/0x7d0
 RIP: 0010:devm_memremap_pages+0x745/0x7d0
 Call Trace:
  dev_dax_probe+0xc6/0x1e0 [device_dax]
  really_probe+0xef/0x390
  ? driver_allows_async_probing+0x50/0x50
  driver_probe_device+0xb4/0x100
