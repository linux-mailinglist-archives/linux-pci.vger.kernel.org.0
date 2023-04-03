Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB26D6D3DE0
	for <lists+linux-pci@lfdr.de>; Mon,  3 Apr 2023 09:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDCHMX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Apr 2023 03:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDCHMW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Apr 2023 03:12:22 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F1459D2;
        Mon,  3 Apr 2023 00:12:21 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w133so21004403oib.1;
        Mon, 03 Apr 2023 00:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680505940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1SfDNd+VrFwNjaXfizqk9NcTy81e6CW019Ll/yqoek=;
        b=I0SU7OovSTU8vdPUMuMFHukYDjMWTGVJNKgkDgIZUqr7l8Cs1IUs95+Aos8M2VjWuf
         9xF2wgRZgbebJaItTe1zpLP0lNjz+K+1v3sZ/QesigYDZIBeJtvY2iAfIMgm2MJGyu0r
         +vn2KEykuWroOtsIkqN2d/o0fH8vkNc/dwX5aXgp86Hbw2WySCfeUOxO5sZGgVB7dkzU
         xS7g087xANtTyUhNiNYvKyM9WiyXvkWdInzKImt1f1JMQvwbnVVYb+CHtPvuTik4etwc
         6SeqXzJkzzH8+2zREa3/P72jXQsKrFwmU8PH80Oraz/P77iNA1Idnf5d2rm8RsZf7X5m
         422Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680505940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1SfDNd+VrFwNjaXfizqk9NcTy81e6CW019Ll/yqoek=;
        b=tZQS0fsuPyNwd8MxYDMBjy+LYCYkHkPvnc6ziNhcOpzXtLlfr+zvEQLvWlJWk93xQt
         JvShELOKlEb3/qeeXvja74J0vyvSHpHjkIiC49ZcQ+yCAKjoKTx5qIFC2bV79oUBpuQ1
         2IZhQhbnw+2wbE9ugX3CGMlM6ejLodLa1EEr0okV5LdixtWRjnWBKHu5EDQZN069H4JY
         QEhcDpVSnLqiaTNFHODESZNy4/6I2bYZTmlUDjpq4F002SIY6ptnCP04+HaYx/9z4o8T
         KjvtE46TcOQq9v8hR9v2C/lUYLLPpzg2dLKWQFcTNqfH0SrUXKCNiRghAC9YlNLrwkcC
         Tcbg==
X-Gm-Message-State: AAQBX9ei6N6tHOGsy/PCQfRxp6LuK7OLCXsc7YWwmp9hdEfH3wkE397s
        9JXIE+XubwNrDudf6aHukCSUS42d65/uPyyJwsg=
X-Google-Smtp-Source: AKy350bEOx3+kI4bEFAmguRgGFpajFzMK1Xxy0w5PuU9zZohvNOMzY/4FC5QxTzdPtZiZxS5+G3G3MA6I0lkeSLVGUA=
X-Received: by 2002:a05:6808:3c8:b0:389:6b0e:9d94 with SMTP id
 o8-20020a05680803c800b003896b0e9d94mr4563991oie.0.1680505940475; Mon, 03 Apr
 2023 00:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <202303231145121987818@zte.com.cn> <CAMhs-H_-kQ0FGP3L1xJ=ec_xJ59a2OztMLLjEQmQfYFOEa4DfA@mail.gmail.com>
 <2e4f27f0-a4ac-4523-8f90-695a62973bd0@kili.mountain>
In-Reply-To: <2e4f27f0-a4ac-4523-8f90-695a62973bd0@kili.mountain>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 3 Apr 2023 09:12:08 +0200
Message-ID: <CAMhs-H8beY3AO83NkTM2_YYdcsqtv7Em01zqSE6wtPNdex8Dpw@mail.gmail.com>
Subject: Re: [PATCH] PCI: mt7621: Use dev_err_probe()
To:     Dan Carpenter <error27@gmail.com>
Cc:     ye.xingchen@zte.com.cn, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 3, 2023 at 6:50=E2=80=AFAM Dan Carpenter <error27@gmail.com> wr=
ote:
>
> On Thu, Mar 23, 2023 at 07:23:26AM +0100, Sergio Paracuellos wrote:
> > Hi,
> >
> > On Thu, Mar 23, 2023 at 4:45=E2=80=AFAM <ye.xingchen@zte.com.cn> wrote:
> > >
> > > From: Ye Xingchen <ye.xingchen@zte.com.cn>
> > >
> > > Replace the open-code with dev_err_probe() to simplify the code.
> > >
> > > Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> > > ---
> > >  drivers/pci/controller/pcie-mt7621.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/contr=
oller/pcie-mt7621.c
> > > index 63a5f4463a9f..964de0e8c6a0 100644
> > > --- a/drivers/pci/controller/pcie-mt7621.c
> > > +++ b/drivers/pci/controller/pcie-mt7621.c
> > > @@ -220,10 +220,9 @@ static int mt7621_pcie_parse_port(struct mt7621_=
pcie *pcie,
> > >         }
> > >
> > >         port->pcie_rst =3D of_reset_control_get_exclusive(node, NULL)=
;
> > > -       if (PTR_ERR(port->pcie_rst) =3D=3D -EPROBE_DEFER) {
>
> So the theory here is that -EPROBE_DEFER is recoverable but other errors
> are not so we just ignore them?  Error pointers will trigger a WARN() in
> mt7621_control_assert/deassert().
>
>
> > > --
> > > 2.25.1
> >
> > Also, this is not a probe(), so I don't see a point of using
> > dev_err_probe() here.
>
> It's a weird thing to return -EPROBE_DEFER from something which is not
> a probe function...  Someone told me I should write a Smatch check for
> it but I never got around to doing that.

I don't remember clearly why this was returned in the first instance.
I think I just took the idea from pcie-mediatek driver for arm64 SoCs
platforms here:

https://elixir.bootlin.com/linux/v6.3-rc5/source/drivers/pci/controller/pci=
e-mediatek.c#L967

Thanks,
    Sergio Paracuellos
>
> In this case, I guess the user is supposed to see the error message and
> manually fix the probe order?  The dev_err_probe() will change the error
> message into a debug message so the user will not see it and will not be
> able to fix it.  So using dev_err_probe() will break things for the
> user.
>
> regards,
> dan carpenter
>
