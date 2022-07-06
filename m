Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BC1567BF7
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jul 2022 04:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiGFCho (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 22:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiGFCho (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 22:37:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FA4192A3
        for <linux-pci@vger.kernel.org>; Tue,  5 Jul 2022 19:37:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t25so23615397lfg.7
        for <linux-pci@vger.kernel.org>; Tue, 05 Jul 2022 19:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=emiR8o/UQR5w8WuS4yBByTW8/kBqRL/MkaDBR+7tZUM=;
        b=ZDAbVaBdb6JWaypB6MUdJBd3icqZkN9Syz5Eg8Y9Z7SDjm0dzENMBXJVnnE+p5l7/g
         dtx//SKvB5Vu+bKnB8TdkcpAHjcyq/xx0KoDyHMcIMB0us20Ws36vkvIWes8KwRfUq+A
         BiEKRFu3Cuu5hAALcJ3VZmDivAolfkmsBcmwe8ReK3KQXcZZZYQfE+n1G7uzm/zVY1f9
         qoQgusprL1m3w+acx2rYh/X3bLAjJFGjhti7FRmMYjraIiR1VSIrx744jfslCz6+KZxM
         8OebKQK7b1WI+1F/wceBWUoXB7INbLOHA/rLBUvxE8bU/m2X6FeIMlFKzeJkGXDfU3ON
         b0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=emiR8o/UQR5w8WuS4yBByTW8/kBqRL/MkaDBR+7tZUM=;
        b=6M50QMXeUSxBa8bzRrmHDFMb+alFr8UG4k7CslbRez6MZY76p0QxMk4C4T35xQDQGx
         +sqv8ybJt+4iLvH+nx8t6KM/akPoeI4651zPaBKkw385vqS71lhHtmX1H4+iEUhOaM32
         VyGE6yhEsWu495xVI8eDHBq5/USp02HAPzoGOqVY9WPdvnpM43RPaV2cdwjirgpgk0jt
         4+UtKom10RzkC9kjIVSkzW+WBnNqODvGUk9JjARLWir7zKXp6JBk3TINzHEivKy+ZG9u
         F56400KdpcEgGAK1v1LArLMBfFjkkpLyfiRaYbB9YsZB4X4s8thXIjpQaeMtng3AqAtM
         mciw==
X-Gm-Message-State: AJIora/PAPeYyjFUHWYbM05N0jQiukknLbet7YFRMnqGa7GqP8pwbgkE
        CXXVSDnUH0rx1Hvg7QzEPxIsC/L7kyruG/QhglOgig==
X-Google-Smtp-Source: AGRyM1uoTxQkoL9/Rrok+c4rGFrKk0qxoW5GxDlW4rP1FjAoAY2VRPdA9C1LXZtD8n1z2vMNATnnjJWnnG+tttrHkUU=
X-Received: by 2002:a05:6512:22cd:b0:47f:6e84:f51c with SMTP id
 g13-20020a05651222cd00b0047f6e84f51cmr23532318lfu.175.1657075060834; Tue, 05
 Jul 2022 19:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220622040924.113279-1-mie@igel.co.jp> <20220705224028.GA90560@bhelgaas>
In-Reply-To: <20220705224028.GA90560@bhelgaas>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Wed, 6 Jul 2022 11:37:29 +0900
Message-ID: <CANXvt5qjx6gXhBZD3ndBPCxx++i2oxd5X7=MRgUGrXUj4kRgfw@mail.gmail.com>
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

2022=E5=B9=B47=E6=9C=886=E6=97=A5(=E6=B0=B4) 7:40 Bjorn Helgaas <helgaas@ke=
rnel.org>:

>
> On Wed, Jun 22, 2022 at 01:09:24PM +0900, Shunsuke Mie wrote:
> > For multi-function endpoint device, an ep function shouldn't stop EP
> > controller. Nomally the controller is stopped via configfs.
>
> Can you please clarify this for me?
>
> An endpoint function by itself wouldn't stop an endpoint controller.
> I assume that some *operation* on an endpoint function currently stops
> the endpoint controller, but that operation should not stop the
> controller?
>
> I guess the operation is an "unbind" that detaches an EPF device from
> an EPC device?
It is likely that after all of the endpoint functions are unbound, the
controller can be stopped safely, but I'm not sure if it is desired behavio=
r
for endpoint framework.

Kishon, could you please comment?

> > Fixes: 349e7a85b25f ("PCI: endpoint: functions: Add an EP function to t=
est PCI")
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pc=
i/endpoint/functions/pci-epf-test.c
> > index 5b833f00e980..a5ed779b0a51 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -627,7 +627,6 @@ static void pci_epf_test_unbind(struct pci_epf *epf=
)
> >
> >       cancel_delayed_work(&epf_test->cmd_handler);
> >       pci_epf_test_clean_dma_chan(epf_test);
> > -     pci_epc_stop(epc);
> >       for (bar =3D 0; bar < PCI_STD_NUM_BARS; bar++) {
> >               epf_bar =3D &epf->bar[bar];
> >
> > --
> > 2.17.1
> >

Thanks,
Shunsuke
