Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A596BDCA5
	for <lists+linux-pci@lfdr.de>; Fri, 17 Mar 2023 00:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCPXFS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Mar 2023 19:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCPXFQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Mar 2023 19:05:16 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5EE5E63CA
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 16:05:14 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id z18so1880506pgj.13
        for <linux-pci@vger.kernel.org>; Thu, 16 Mar 2023 16:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679007914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UX/KTPHcDdcu6dbgU5HB9yD5ykeUvMNlEFlUDYk+cCA=;
        b=SF5xfB6kSG39cncDovV1pyUCNotzNarkCKr42WsrRqrv+9fidcfNcsYPs/E/nLYTPi
         sgP/iHBm74AvHzfnMrAzzmUWvrn9SNnbrKYc5WBLnRJ8pwuz/PqVPl9lzDBLAVPAPU5A
         Id8hV68bUKBptVKA3NUQfarZihMw+hUjU9uxVsun49Ne/HblwfQ+O1QNHpaX+KBVjxU/
         r22m9lmL4OaosAsU5R6KT2QaddJbY9rG+XSNWbWml8bryeqMeZnwijl9K4jd0Ucws+qk
         8Q1XJ3Gb+bsrtNOownn3Vxf3W0lbgbCggKodhNKtDgw7Y8Zu7e1tDbGpgJSIFTiUkDzC
         Vunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679007914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UX/KTPHcDdcu6dbgU5HB9yD5ykeUvMNlEFlUDYk+cCA=;
        b=hb37nz8Uvg/JsAgnBSeyrMhAIyDFqE1KGBTGjHH08ogO+u+ewGRWxgLcJ9rZihOlKT
         0vBf44Q8Q2TCALNBZFYH/Si7Xtk1XR1qk87V/LMZRcXgp5oUpQCOwIBwoCSKMpUaeNEz
         kFHHrKCAeuU+JhMajQvFYo0VH5bQWPcNVrcaB5wCTcOp6z8Iun3z3r9rMELu82oqs9lx
         hgF5l96hoAkxAso35lri5ybGZz16kCpq6htnXYB3DgTZt9iALYw7mvuI/E3EbsUYs1to
         W9rf1UkWWorXaPCY0u9DCE/lp33Q6ikpQreHOZapY3J0k6D/udsKH4H85ChFafB6L3YB
         TRig==
X-Gm-Message-State: AO0yUKV/GLETiyQS+Nv6LDOED/dYFskqE5/V6OaTihLvw7ObQWyN2QKc
        +4yHKksH0mPEzmau0cL2mQG+LZfYzwIh5s7HJjPCWw==
X-Google-Smtp-Source: AK7set9xMU7SWH6Z2EQZMeJm478KkEPP57LvIRya986B0PASt62FSyyKX2NMFas/FBsNA5R+wN1CExGxMYRivLbhMTs=
X-Received: by 2002:aa7:88c4:0:b0:624:6e5:1a2a with SMTP id
 k4-20020aa788c4000000b0062406e51a2amr2437655pff.0.1679007913947; Thu, 16 Mar
 2023 16:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230227201340.2087605-1-sdalvi@google.com> <CAPOBaE4U4rCJ+4CcSoj597LsP-0ESBhiKKHz00bk+SvNHrOzKQ@mail.gmail.com>
 <CAEbtx1mhMqZjJeU0L99xpwY9W5caJmpv69aRZG+b-hLfstK-Ww@mail.gmail.com>
In-Reply-To: <CAEbtx1mhMqZjJeU0L99xpwY9W5caJmpv69aRZG+b-hLfstK-Ww@mail.gmail.com>
From:   Sajid Dalvi <sdalvi@google.com>
Date:   Thu, 16 Mar 2023 18:05:02 -0500
Message-ID: <CAEbtx1kNMY5xH435=Rw0QoDebyRL=RYi+dfkqs4WRG7DS5f3dA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dwc: Wait for link up only if link is started
To:     Han Jingoo <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, kernel-team@android.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 28, 2023 at 10:36=E2=80=AFPM Sajid Dalvi <sdalvi@google.com> wr=
ote:
>
> Thanks for your review Jingoo.
> Sajid
>
> On Tue, Feb 28, 2023 at 4:04=E2=80=AFPM Han Jingoo <jingoohan1@gmail.com>=
 wrote:
> >
> > On Mon, Feb 27, 2023, Sajid Dalvi <sdalvi@google.com> wrote:
> > >
> > > In dw_pcie_host_init() regardless of whether the link has been starte=
d
> > > or not, the code waits for the link to come up. Even in cases where
> > > start_link() is not defined the code ends up spinning in a loop for 1
> > > second. Since in some systems dw_pcie_host_init() gets called during
> > > probe, this one second loop for each pcie interface instance ends up
> > > extending the boot time.
> > >
> > > Call trace when start_link() is not defined:
> > > dw_pcie_wait_for_link << spins in a loop for 1 second
> > > dw_pcie_host_init
> > >
> > > Signed-off-by: Sajid Dalvi <sdalvi@google.com>
> >
> > (CC'ed Krzysztof Kozlowski)
> >
> > Acked-by: Jingoo Han <jingoohan1@gmail.com>
> >
> > It looks good to me. I also checked the previous thread.
> > I agree with Krzysztof's opinion that we should include
> > only hardware-related features into DT.
> > Thank you.
> >
> > Best regards,
> > Jingoo Han
> >
> > > ---
> > >  drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/driv=
ers/pci/controller/dwc/pcie-designware-host.c
> > > index 9952057c8819..9709f69f173e 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -489,10 +489,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
> > >                 ret =3D dw_pcie_start_link(pci);
> > >                 if (ret)
> > >                         goto err_remove_edma;
> > > -       }
> > >
> > > -       /* Ignore errors, the link may come up later */
> > > -       dw_pcie_wait_for_link(pci);
> > > +               /* Ignore errors, the link may come up later */
> > > +               dw_pcie_wait_for_link(pci);
> > > +       }
> > >
> > >         bridge->sysdata =3D pp;
> > >
> > > --
> > > 2.39.2.722.g9855ee24e9-goog
> > >

@bhelgaas Can this be picked up in your tree:
 https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/

Thanks
Sajid
