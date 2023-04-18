Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA9D6E5A23
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 09:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjDRHLp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 03:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjDRHLo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 03:11:44 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83561713;
        Tue, 18 Apr 2023 00:11:43 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38be7a5ab37so203086b6e.3;
        Tue, 18 Apr 2023 00:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681801903; x=1684393903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eTWib7JxQgRfPP7nkQkRpwdyPsWxBj+IL3VbidooW0M=;
        b=hVUcF1oeFKWWGWNtlbS0nussKF65jhn4dl3su18uwaKlEFYNbn9AzxAimO05juCoyM
         SOzC/5V49vwQhx5oOvjVsiuX3DNzd8fjNFzEvDhb3FUmMFyiuZ3a5caQmC0Ic6w2pyyS
         m5sW/WXoqRsxgRBCg/Dso40zZJ2+qAYKe66v7aktSGuLBf1PFfK3s8RLoSPeMw+hvEvh
         90nbYjRMCvhJ6WwELi7bByENsM9LyQNq0jkn8JjKMbOkkbC7yykbhELYktynIBEFy+1F
         eCmZwd4PR9Pesm1OMHBqR1X4/BQAhiVAC/jKEnhHz12jwCgOlhxVWsob4arYHJLRhOz5
         DV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681801903; x=1684393903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eTWib7JxQgRfPP7nkQkRpwdyPsWxBj+IL3VbidooW0M=;
        b=Vgn2qpreq2eawLugudYMljzZoTPrPMFqJ0SiXucbjXP4iVigoGPFBWEyqQjcgwI2Me
         Rw+z3XUFYidXPz4xyY54t6fHy9b+dvJP65tVA64bVjjdf8lwzVNFfAtn22nYT/vLW5P7
         NJ58sX503iFZMh0W8wDKZoUVWgn0UOuYXY/8/prJpI2RDtBvZA7oIAKNbRbw+9HczOwW
         jrkbZU5wdKU+YtQU/42S4I6wDPWq8iwMeziGJh5SUwWqbQ/Cvtt0FnzJB2ldS6OEMFsi
         hfo8T5B+GmuyqlaxK2HEZ7JSjHUpoRKabnFjM8a6hg7qLrt8c656Z6jDpKy53DRID/jK
         C6mQ==
X-Gm-Message-State: AAQBX9cLHpuXkPKoN47jPH4dL3/1yVYJ2ozSnWG3PuulmnniiOv3eDMr
        vKbT5hIvnTwjdhEhF4p5A1BgAoNK8vqiKFyPOoheCE7u/Cg=
X-Google-Smtp-Source: AKy350aMS52U0BpcvRun1qRMCtVKhTYvV6yb/hI65EaQPrxsqIVekJ5kylKFKvwKZcLodcwL9kc3njD3myEsrtI+Nyw=
X-Received: by 2002:aca:db54:0:b0:38b:c09e:500f with SMTP id
 s81-20020acadb54000000b0038bc09e500fmr248261oig.10.1681801903242; Tue, 18 Apr
 2023 00:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230417092631.347976-1-rick.wertenbroek@gmail.com>
 <20230417092631.347976-12-rick.wertenbroek@gmail.com> <cf47e154-1a48-58a9-b139-95b51b87d356@kernel.org>
In-Reply-To: <cf47e154-1a48-58a9-b139-95b51b87d356@kernel.org>
From:   Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date:   Tue, 18 Apr 2023 09:11:07 +0200
Message-ID: <CAAEEuhq0nCT0XVuEeiHxY=tAsHipJPY=Uq59B=vZAwrXXjMzcg@mail.gmail.com>
Subject: Re: [PATCH v4 11/11] PCI: rockchip: Set address alignment for
 endpoint mode
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Brian Norris <briannorris@chromium.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 1:51=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 4/17/23 18:26, Rick Wertenbroek wrote:
> > From: Damien Le Moal <dlemoal@kernel.org>
> >
> > The address translation unit of the rockchip EP controller does not use
> > the lower 8 bits of a PCIe-space address to map local memory. Thus we
> > must set the align feature field to 256 to let the user know about this
> > constraint.
> >
> > Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>
> I think this one also needs the tag:
>
> Fixes: cf590b078391 ("...")
> Cc: stable@vger.kernel.org
>
> And you forgot to add you Signed-off-by tag (when sending someones else p=
atch,
> you must add your own SoB tag after the author's tag).
>

Thank you for all your comments, I'll add the tags.
I reread the documentation, I missed it, it's the first
time I sent someone elses patch.

> > ---
> >  drivers/pci/controller/pcie-rockchip-ep.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/co=
ntroller/pcie-rockchip-ep.c
> > index edfced311a9f..0af0e965fb57 100644
> > --- a/drivers/pci/controller/pcie-rockchip-ep.c
> > +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> > @@ -442,6 +442,7 @@ static const struct pci_epc_features rockchip_pcie_=
epc_features =3D {
> >       .linkup_notifier =3D false,
> >       .msi_capable =3D true,
> >       .msix_capable =3D false,
> > +     .align =3D 256,
> >  };
> >
> >  static const struct pci_epc_features*
>
