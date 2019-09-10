Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4C60AEFC6
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2019 18:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436803AbfIJQle (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Sep 2019 12:41:34 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36179 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbfIJQld (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Sep 2019 12:41:33 -0400
Received: by mail-io1-f65.google.com with SMTP id b136so39066544iof.3
        for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2019 09:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PuYC847frxgHINuOOhOoZA3oEgF84P0aotCSUtzOwyE=;
        b=We/JeeLSpFGQIN3oI+YX0ZmIGMBD/BvYCC5rXZYpTdk5GwMlZ0UAuo7WDhz4zNk4te
         B6PDV93PovykItWCG05wcFNwFdwTkJEPBX1Viz4/d+fGhYxpGw/68mLE5PxWuR1weWcC
         MoFnH5sNDl17TV0AEGlpoJ9VS0EFKmWIv7Txn+kLn0qhtstWxUnti+aDxX9Swe+UkXmI
         S3m+tAaEDBBhqlw14dKBlI5zeeSaa7BWY4meUkBCkNNSDCLJ36SbvzWd683kRyydsY8W
         41Tsljpj4QN/kuGNypUuFh/P00HxhxkFFPXQhoJbz83e0VcCokYIl0NQHy+e1PZXZFrd
         raMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PuYC847frxgHINuOOhOoZA3oEgF84P0aotCSUtzOwyE=;
        b=nQf6ODyyyf6d0GvgcDryJ/3mRooo+CGCcv4dEM5O80bs2Dw/J+RHv4PGju6JxI5hfN
         jXfYerhrwPda4s4Rv7JH8qoFehXL394hsbO6S2YEYoGCaXrlrbxNjEYsrKWcFK6TRzVd
         l4Q2zTgSKIqePR30yLEN4n/NUh6AU5IdgWt9HWWoVfvBCFF82Iev+YBv0LcJSIsFs49W
         /SsbSj8P8vbip9vnINBQPA5DPTIgYZSHxruoXk2c/qOm/6cD3lyNKruj1h3XqKTjY+vP
         vp2uFN/RkOvJbd1ia1t5ouC0B2LpUNjhLu3tH3Jmxd5w9R9E0z3Zw+zPVXC7OopnVcYa
         prTg==
X-Gm-Message-State: APjAAAUMNc0BZVE2ACM5fe8xa51TwYtDo58xaWUHKZR3JPm4ogcEBZbo
        zqUVFeha6wu7SAWh8krCmiEOmAlz8TJvSlKuKPkt3g==
X-Google-Smtp-Source: APXvYqxROhJ3fm9H1em04hVFrGU84MgcmLV2y9LjuszRFdZ+1fVjqDcud7QdlNneQxAk/rIG0VSfcUycOIj0tbhMF/s=
X-Received: by 2002:a6b:7215:: with SMTP id n21mr6285570ioc.238.1568133691620;
 Tue, 10 Sep 2019 09:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190716173448.eswemneatvjwnxny@yadro.com> <9428e069-19dd-d020-1a47-f33d99bd01ac@deltatee.com>
In-Reply-To: <9428e069-19dd-d020-1a47-f33d99bd01ac@deltatee.com>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Tue, 10 Sep 2019 17:41:23 +0100
Message-ID: <CAPoiz9x4Gb6hZg3GBfOjw_zMShOJHmXGmCOm2Nj+-vCaOzDCMg@mail.gmail.com>
Subject: Re: [PATCH] ntb_hw_switchtec: make ntb_mw_set_trans() work when addr
 == 0
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Alexander Fomichev <fomichev.ru@gmail.com>,
        linux-ntb <linux-ntb@googlegroups.com>,
        linux-pci@vger.kernel.org, Allen Hubbe <allenbh@gmail.com>,
        linux@yadro.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 16, 2019 at 6:41 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-07-16 11:34 a.m., Alexander Fomichev wrote:
> > On switchtec_ntb_mw_set_trans() call, when (only) address == 0, it acts as
> > ntb_mw_clear_trans(). Fix this, since address == 0 and size != 0 is valid
> > combination for setting translation.
> >
> > Signed-off-by: Alexander Fomichev <fomichev.ru@gmail.com>
>
> Looks good, thanks.
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Applied to ntb-next, thanks

>
> > ---
> >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > index db49677..45b9513 100644
> > --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> > @@ -305,7 +305,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
> >       if (rc)
> >               return rc;
> >
> > -     if (addr == 0 || size == 0) {
> > +     if (size == 0) {
> >               if (widx < nr_direct_mw)
> >                       switchtec_ntb_mw_clr_direct(sndev, widx);
> >               else
> >
