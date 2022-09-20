Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1835BE2D2
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 12:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiITKOF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 06:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiITKNq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 06:13:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC30970E75
        for <linux-pci@vger.kernel.org>; Tue, 20 Sep 2022 03:13:18 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x27so3033493lfu.0
        for <linux-pci@vger.kernel.org>; Tue, 20 Sep 2022 03:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=Kj8G7tQXp3dB2CskDYDfYJI+6PpZ7oU+0ic/ZP4IQy4=;
        b=VTTlqqsAIS6WArmTLHA68hWn7TJ4vlFNMWzhSyFGAYhOfla3D27i4EMKgcppiv4eO2
         fnXiXx5JyOSyxf8pZa11wyl0A1bZaIlby15dkwXlzbTaRD7i1YMKKo8PUdVDVvvkdh1e
         mZhQgEj3rT4OGkPhmf85Dwla6Fsts7du69InDTEpiqcC43HftCmXlF545MstqA0/+dQF
         hZ05hv0ZUkGOO7Ul+VpjE+0ULdV41Jv99aqtPz0RXwmDV74ZItMF5v1onlDmb82AQsLO
         uJzfhh3l8GhpWSM6LkaSo02AhRVIUjQ66ghKx+WCL3vXLVX22CEKJAh2Sp//c3JHE/st
         6HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Kj8G7tQXp3dB2CskDYDfYJI+6PpZ7oU+0ic/ZP4IQy4=;
        b=yDRyw/ew1bz5BOAIWcVgrJc05n7Ru4kylUJQjnJ+9ZQMm96px/X70cxO1w3l9OdbAd
         5kwli4LO8GdjBHKPJbrIAm4CX6K5byauJRJASkmJnc8WpSaHeVdYnNlpynenXQ0UmY2O
         YeOQmlft/ePxfcDIVmrDi86MGqiB0I4lCPtpHM0Nb5sovWieQENgxkczohlvjoewaPFF
         x3zsIcg3JwT7e2ef5OMFOiXCoqeGKJGYgUj6io/Y/ERCEWnxzYn3Z/uMRQk5hH/jTVnO
         uvokDGLhMXi4hc924Bh/ikTZSekGGTKwpSFvrS0fcWGBjvlObDr1NFOBJZFuL5mVD9yA
         pc2Q==
X-Gm-Message-State: ACrzQf1DxRk80mI87MY7vNhBneIjofmak7CswLDmQeXnKrjEPnKp8Zba
        /a0OQtOix/KJ+OmWTUdEx9t1bLIjShx/w5Zqjg5PMw==
X-Google-Smtp-Source: AMsMyM7lM95/SWWgu+uEQ5wpzRiVAE+KO6sg3f85kueFZza2jw62yeG4FNCpANipI6vltZ8i4/+KJBjvx/FkixK4Ce8=
X-Received: by 2002:a05:6512:3183:b0:498:fa29:35fe with SMTP id
 i3-20020a056512318300b00498fa2935femr7658789lfe.523.1663668778693; Tue, 20
 Sep 2022 03:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220916075651.64957-1-mie@igel.co.jp> <20220919185545.GA1022691@bhelgaas>
In-Reply-To: <20220919185545.GA1022691@bhelgaas>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Tue, 20 Sep 2022 19:12:47 +0900
Message-ID: <CANXvt5oWtyh8KiEpk2Ad1sbn9e8FNoy3A99k+xkoujOFA3DhdA@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-{,v}ntb: fix a check for no epc
 alignment constraint
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

2022=E5=B9=B49=E6=9C=8820=E6=97=A5(=E7=81=AB) 3:55 Bjorn Helgaas <helgaas@k=
ernel.org>:
>
> On Fri, Sep 16, 2022 at 04:56:51PM +0900, Shunsuke Mie wrote:
> > Some pci endpoint controllers has not alignment constraint, and the
>
> s/pci/PCI/
> s/has not/have no/
> s/constraint/constraints/
>
> > epc_features->align becomes 0. In this case, IS_ALIGNED() in
> > epf_ntb_config_spad_bar_alloc() doesn't work well. So this patch adds t=
he 0
> > checking before the IS_ALIGNED().
>
> s/So this patch adds .../Check for this before IS_ALIGNED()/
Thank you. I'll fix these.
>
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2 +-
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci=
/endpoint/functions/pci-epf-ntb.c
> > index 9a00448c7e61..f74155ee8d72 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> > @@ -1021,7 +1021,7 @@ static int epf_ntb_config_spad_bar_alloc(struct e=
pf_ntb *ntb,
> >       peer_size =3D peer_epc_features->bar_fixed_size[peer_barno];
> >
> >       /* Check if epc_features is populated incorrectly */
> > -     if ((!IS_ALIGNED(size, align)))
> > +     if (align && (!IS_ALIGNED(size, align)))
> >               return -EINVAL;
> >
> >       spad_count =3D ntb->spad_count;
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pc=
i/endpoint/functions/pci-epf-vntb.c
> > index 0ea85e1d292e..5e346c0a0f05 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> > @@ -418,7 +418,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf=
_ntb *ntb)
> >       size =3D epc_features->bar_fixed_size[barno];
> >       align =3D epc_features->align;
> >
> > -     if ((!IS_ALIGNED(size, align)))
> > +     if (align && !IS_ALIGNED(size, align))
> >               return -EINVAL;
> >
> >       spad_count =3D ntb->spad_count;
> > --
> > 2.17.1
> >

Best,
Shunsuke
