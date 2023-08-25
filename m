Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150F8787ED1
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 05:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjHYD5o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 23:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbjHYD5Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 23:57:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7131F1FD0;
        Thu, 24 Aug 2023 20:57:14 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-500a398cda5so730919e87.0;
        Thu, 24 Aug 2023 20:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692935833; x=1693540633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3aiMVXtgxLUKAnBwJFLxkNXC0ELKqaEOEAXJ+cSOAE=;
        b=VQx3J+kpts+XqPfFEWm0jC30Fe2CYNS5pfG++3AGlA5bAMcmy+vgrafWAe9YNuRZKH
         ZS48462A3+F2BdJAI9SUAj22rdstK6g8cqdxZpMG79EX7/ZNkjUgypXtyDQkw9CHPwpr
         cfKXVZPMk5x9rZhenDnBfhQyVgt8Qsx9kRyal6+3hKEtP1g5sFbev85o2ILJQrqE6qRy
         wfiSoIrfdGHp+bx5S5I9et8z5WFmQzhwPrwGcJDWXe2B43J5TDL7+pFj4vE8oB1c3ouL
         X7+ybhNMPpSWc5kpJG5U5FBScZr4wW7F6P8+rbHhVgyj9ljiiI4EnQftCp6FN9TSD+FZ
         wXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692935833; x=1693540633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3aiMVXtgxLUKAnBwJFLxkNXC0ELKqaEOEAXJ+cSOAE=;
        b=KpaYtd+TOmrp4u7KG/Zokrh2c6bWVb02TeoWoX6ws7/MvPPlP5uD9uTFgXrRr+Hx/m
         wBf80byVPPCQyAbFCM+NK3Cp9Ps7lJuG4YX7Ut37HpWd6rqkvfQnYwe/4KKNat9OFYCq
         Iv3gdWfcOinWSd0wbayXgeNijVjq2Fxh1IU1LMxNG01HZUqfAo3NGLali0VTJ2BvCeAH
         rrATUNinstoq4Xjgr3v1RT5wjOkfLb/a1dxL9JLLH6FONqcDNMyB/Vz1I8pFkItxaJ6P
         tHwNm45FwMjPa5qWSwmeBrlkpno7nAWoPcuo6Q/4FKRqeu2+p0NYGp3Co8qu9dVAyjQB
         MxzA==
X-Gm-Message-State: AOJu0YzBW4BHpQ//5HMqGg43XHwM3y6LXYT13YtpR1CRIX+TLw06q1eZ
        yRTaw1okUhj5OMHjv96qb+kQAODV1DxZcVuQrIk=
X-Google-Smtp-Source: AGHT+IFnzdbO7zeBDwHrFNo7dbksrsB/geohTsIWWpQ1xGeaooFVOPphakNoGDrLCHbAToPyg88UJnrBDxcfb/CJa+U=
X-Received: by 2002:a05:6512:3191:b0:4fb:9f93:365f with SMTP id
 i17-20020a056512319100b004fb9f93365fmr16497912lfe.38.1692935832393; Thu, 24
 Aug 2023 20:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230824013738.1894965-1-chenfeiyang@loongson.cn> <20230824215904.GA604126@bhelgaas>
In-Reply-To: <20230824215904.GA604126@bhelgaas>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Fri, 25 Aug 2023 11:57:00 +0800
Message-ID: <CACWXhKnyq_-Y_NSWznEr+gV7z0Uoo+dqT5jd-OygtdEmZWCW5A@mail.gmail.com>
Subject: Re: [PATCH v3] PCI/PM: Only read PCI_PM_CTRL register when available
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, bhelgaas@google.com,
        rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com,
        anders.roxell@linaro.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, guyinggang@loongson.cn,
        siyanteng@loongson.cn, chenhuacai@loongson.cn,
        loongson-kernel@lists.loongnix.cn,
        "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 25, 2023 at 5:59=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Aug 24, 2023 at 09:37:38AM +0800, Feiyang Chen wrote:
> > When the current state is already PCI_D0, pci_power_up() will return
> > 0 even though dev->pm_cap is not set. In that case, we should not
> > read the PCI_PM_CTRL register in pci_set_full_power_state().
> >
> > There is nothing more needs to be done below in that case.
> > Additionally, pci_power_up() has two callers only and the other one
> > ignores the return value, so we can safely move the current state
> > check from pci_power_up() to pci_set_full_power_state().
>
> Does this fix a bug?  I guess it does, because previously
> pci_set_full_power_state() did a config read at 0 + PCI_PM_CTRL, i.e.,
> offset 4, which is actually PCI_COMMAND, and set dev->current_state
> based on that.  So dev->current_state is now junk, right?
>

Yes.

> This might account for some "Refused to change power state from %s to D0"
> messages.
>
> How did you find this?  It's nice if we can mention a symptom so
> people can connect the problem with this fix.
>

We are attempting to add MSI support for our stmmac driver, but the
pci_alloc_irq_vectors() function always fails.
After looking into it more, we came across the message "Refused to
change power state from D3hot to D0" :)

> This sounds like something that probably should have a stable tag?
>

Do I need to include the symptom and Cc in the commit message and then send=
 v4?

> > Fixes: e200904b275c ("PCI/PM: Split pci_power_up()")
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> > ---
> >  drivers/pci/pci.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 60230da957e0..7e90ab7b47a1 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1242,9 +1242,6 @@ int pci_power_up(struct pci_dev *dev)
> >               else
> >                       dev->current_state =3D state;
> >
> > -             if (state =3D=3D PCI_D0)
> > -                     return 0;
> > -
> >               return -EIO;
> >       }
> >
> > @@ -1302,8 +1299,12 @@ static int pci_set_full_power_state(struct pci_d=
ev *dev)
> >       int ret;
> >
> >       ret =3D pci_power_up(dev);
> > -     if (ret < 0)
> > +     if (ret < 0) {
> > +             if (dev->current_state =3D=3D PCI_D0)
> > +                     return 0;
> > +
> >               return ret;
> > +     }
> >
> >       pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> >       dev->current_state =3D pmcsr & PCI_PM_CTRL_STATE_MASK;
> > --
> > 2.39.3
> >
