Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5988C44D2D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 22:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfFMUP0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 16:15:26 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43305 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfFMUP0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 16:15:26 -0400
Received: by mail-oi1-f196.google.com with SMTP id w79so289138oif.10
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2019 13:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gYvi3JENt5xjT7/oQoCCDRRyhuGQKrPeHYLl1e4tUxo=;
        b=HiQM8Oj8L+VS1a8Hidw0xr9iYYaQmKDaapqQQLP3xBSAjW2G7zF8GCiMqjGr/ym+Mo
         M+OqlxjvRB4nsYJvbsbx5Z3ifuAo0JozSHiAbNq39t8D2waMsSabG6FDy40WGT4oYy8V
         L96EPmLmkBZ66RnBr04w7xeY6utWIJLm5CrypM9lYrEcqa9F/Z5nPa4IShCeMmTv0t0L
         gS2NRGRi4wYn5eA9ZuBqSXqoz8gXypGTSbll9Wp2Y8UNYHgTyBR1qyLVx2ig9t9lcYmD
         HVaPJZLwJOeNsVJ9c9ozc803Mh/zRF+OxcMsrpFkoEYk0fk+301QRIAXIyrgvI3K0bkW
         VbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYvi3JENt5xjT7/oQoCCDRRyhuGQKrPeHYLl1e4tUxo=;
        b=eFFhyHj/c3xVCkNWAggyDnw+1724txDYoJzsIy69OEAY1f3qrr2bY6JRAiWmDT/ygj
         0SNTEQ/HxPQaQD8HA3BnqRgnFxMcanhM3DXQ7CAjJ7Zzg47S8ei5AKENvBb+5E/p5I/A
         UuY0XEildj54L92J47tSXrIGJlLBzFKRipibI099JXCMlC0hRS5OWsCmngdQ1+sFxQoU
         1xmUpTLKqTfAXPH3du/gVaUgxhUTMWMEdBk4Vas+ri1DIQZcMncsWsfjrv0NK8y1f1Ml
         f93qAs9G94n1pRhXrv88/eQeWvYzJX7Tnjoivn6PFn+PmlEpmAohST5UWthpOBUlZLBS
         A5sQ==
X-Gm-Message-State: APjAAAXvReEUjWUPmV1mrtl0NQNQavVm/y4p3vnBFXWoKtKMZ/76ccY+
        vzjDmCm6CTeUGf7Sq6kK67rTKCUXHGPIPykZxdjkHg==
X-Google-Smtp-Source: APXvYqyS333Lp+D4vjCDNGXf2txUSus++eUTfldGM7ZmElD6Qov2BJs1+/5zSo9qFUO6PniS7TXRoikGBTwqET2Ahjo=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr4014371oih.73.1560456925540;
 Thu, 13 Jun 2019 13:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190613094326.24093-1-hch@lst.de> <20190613094326.24093-9-hch@lst.de>
 <d9e24f8e-986d-e7b8-cf1d-9344ba51719e@deltatee.com>
In-Reply-To: <d9e24f8e-986d-e7b8-cf1d-9344ba51719e@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 13 Jun 2019 13:15:14 -0700
Message-ID: <CAPcyv4gApj=5eYCVSLidDJqF2V1YZiqUht1P26mSzUOjW-ykqA@mail.gmail.com>
Subject: Re: [PATCH 08/22] memremap: pass a struct dev_pagemap to ->kill
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Linux MM <linux-mm@kvack.org>,
        nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 1:12 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-06-13 3:43 a.m., Christoph Hellwig wrote:
> > Passing the actual typed structure leads to more understandable code
> > vs the actual references.
>
> Ha, ok, I originally suggested this to Dan when he introduced the
> callback[1].
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reported-by: Logan Gunthorpe <logang@deltatee.com> :)


>
> Logan
>
> [1]
> https://lore.kernel.org/lkml/8f0cae82-130f-8a64-cfbd-fda5fd76bb79@deltatee.com/T/#u
>
