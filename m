Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB55567C7C
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 05:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiGFDPy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 23:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiGFDPx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 23:15:53 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772811BE8E
        for <linux-pci@vger.kernel.org>; Tue,  5 Jul 2022 20:15:52 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id w2so478136ljj.7
        for <linux-pci@vger.kernel.org>; Tue, 05 Jul 2022 20:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3G8AJUPNdeXHxdK11v2ens9rp8pWF9KEJuCg9Xy8WOI=;
        b=UQXvkK3e0+BUuLrhVL9zEaoMNJgJ/1uW7iD9TZYFbvle2tITMyV1culntFFAk7Hmkj
         cVGlCapiIK2i8juSYgtsF6Y0zITaiL8K7z5Wx+vcJrHM1CKwkJEykqkLKYf73Zgrz76H
         /BIVVNK2V8zb5vw3K/fXUwYgahiowXZh0b1V6xLPStvKZJkYmsz6rk75F3PrY8eO8vyo
         G1cambYG1XfxOtZAvPQzRrJ9Tv3HyI1YZtjXDZG8kbyd95XI4/fIUDZ564ffjD5Xy/sX
         uwCg33tg7iSNl+BX1u6Zv+pJ2P+/FVk+tPJE4xmJlJ8KNeSH35syZHhFXGTHhwjoOfBU
         ZBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3G8AJUPNdeXHxdK11v2ens9rp8pWF9KEJuCg9Xy8WOI=;
        b=U+HXHZ3rVNJxsJGsIp07ig8t6hF08E1G0uBdnXvJoOP+oDOvKmrHPUp3xXPUTqJZdU
         +bSIqwK4KcUGaA0KaJJEpWiFkowKEkBxtivY2Xe2IKtnNq1BADlx3bCdXsfdF0rL7oYo
         AAb5dU9vC8SPcETun2LhWDUgUxnVnPzB4iZisZUfXaWijeymIhaNIO9u+ovYd4EkjjuX
         qG+RCl3+Efj4h5pbocx5+vPdHqQybLJVid/SS2CprcD3kw/zdlg+mvVMgDb3/1Lg8hpz
         R+0ms/oqHqqUy7nFcv0aQoUvPuQcBQhTbVbR08Ffr+SrNs1OpRYSq8LDgPrgg6M0Cps1
         vxMg==
X-Gm-Message-State: AJIora80LnmPBq3u5ZwEL44D+99PQEx2zdRkDjjQJuMtAdVMi3mteKXP
        IlX+zXMR8+7lOTOs8chcj7Ry4TSLhtFQDxicrhRM4w==
X-Google-Smtp-Source: AGRyM1vAX5WpM+PWUidEjVteiohH2A9OnZY9W6tH18+Y6jl+xCfnaMAWQ+tE55YbvX2n4CNqwjWtuxBWykJfU5KsFtM=
X-Received: by 2002:a2e:bb88:0:b0:25a:6ec7:a1a0 with SMTP id
 y8-20020a2ebb88000000b0025a6ec7a1a0mr22324641lje.360.1657077350779; Tue, 05
 Jul 2022 20:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <CANXvt5qjx6gXhBZD3ndBPCxx++i2oxd5X7=MRgUGrXUj4kRgfw@mail.gmail.com>
 <20220706030812.GA109866@bhelgaas>
In-Reply-To: <20220706030812.GA109866@bhelgaas>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Wed, 6 Jul 2022 12:15:38 +0900
Message-ID: <CANXvt5rn3NdV63c6-22UqxBpxCNeSdog6Sr+SiZjt7K5pkKbLw@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: Don't stop EP controller by EP function
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Li Chen <lchen@ambarella.com>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

2022=E5=B9=B47=E6=9C=886=E6=97=A5(=E6=B0=B4) 12:08 Bjorn Helgaas <helgaas@k=
ernel.org>:
>
> On Wed, Jul 06, 2022 at 11:37:29AM +0900, Shunsuke Mie wrote:
> > 2022=E5=B9=B47=E6=9C=886=E6=97=A5(=E6=B0=B4) 7:40 Bjorn Helgaas <helgaa=
s@kernel.org>:
> > > On Wed, Jun 22, 2022 at 01:09:24PM +0900, Shunsuke Mie wrote:
> > > > For multi-function endpoint device, an ep function shouldn't stop E=
P
> > > > controller. Nomally the controller is stopped via configfs.
> > >
> > > Can you please clarify this for me?
> > >
> > > An endpoint function by itself wouldn't stop an endpoint controller.
> > > I assume that some *operation* on an endpoint function currently stop=
s
> > > the endpoint controller, but that operation should not stop the
> > > controller?
> > >
> > > I guess the operation is an "unbind" that detaches an EPF device from
> > > an EPC device?
> >
> > It is likely that after all of the endpoint functions are unbound, the
> > controller can be stopped safely, but I'm not sure if it is desired beh=
avior
> > for endpoint framework.
>
> I'm not asking about the patch itself.  I'm asking about the commit
> log because "an EP function shouldn't stop EP controller" doesn't
> quite make sense in English.
I'm sorry.

> I suspect it should say something like "unbinding one endpoint
> function of a multi-function device from the endpoint controller
> should not stop the controller."
Yes, it is correct and represents the commit clearly.

> But I don't know enough about EPF/EPC binding to know whether that
> makes sense either.
>
> > Kishon, could you please comment?
> >
> > > > Fixes: 349e7a85b25f ("PCI: endpoint: functions: Add an EP function =
to test PCI")
> > > > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > > > ---
> > > >  drivers/pci/endpoint/functions/pci-epf-test.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/driver=
s/pci/endpoint/functions/pci-epf-test.c
> > > > index 5b833f00e980..a5ed779b0a51 100644
> > > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > @@ -627,7 +627,6 @@ static void pci_epf_test_unbind(struct pci_epf =
*epf)
> > > >
> > > >       cancel_delayed_work(&epf_test->cmd_handler);
> > > >       pci_epf_test_clean_dma_chan(epf_test);
> > > > -     pci_epc_stop(epc);
> > > >       for (bar =3D 0; bar < PCI_STD_NUM_BARS; bar++) {
> > > >               epf_bar =3D &epf->bar[bar];
> > > >
> > > > --
> > > > 2.17.1
> > > >
> >
> > Thanks,
> > Shunsuke
