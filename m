Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE7783FFB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Aug 2023 13:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbjHVLtB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Aug 2023 07:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbjHVLtB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Aug 2023 07:49:01 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4B4E5B;
        Tue, 22 Aug 2023 04:48:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bcc846fed0so15079121fa.2;
        Tue, 22 Aug 2023 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692704909; x=1693309709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n2vkQhIBJuICpR6F/uL5UbGlY9YwnhUGNJbxEQL/IU0=;
        b=sIu3cY0iyuLcFPWB+pL+wN3sP8xlJZ+svTycRx41Awrhr91XUtsaGW/FYce9MHMCZ5
         qmNLgfbiFVP83ptiZf30f7Oc5/NBWVcrG90NfH+ENyAHbTUmta4HYZg5ga8gbXnRzY0F
         U/b1hNaq6mG2TzTxWcqosCW7FSc4nxNpGSKFTXbduFdQjykFGXhVE0LGNSwB7LtjmCYC
         6/iVjVWVW+qa/1OFNB6logil5ytmmr5dQkfkZmtpvNKo9c+nzd3g6hBGoiAHkZlOYc+Q
         ftdylGGry/aIV9boJy3PXISGfCg3z8JtpWPcjyleqb0ISS9xT832UzaUtIcz05xBfcBt
         lVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692704909; x=1693309709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n2vkQhIBJuICpR6F/uL5UbGlY9YwnhUGNJbxEQL/IU0=;
        b=c7QKBrJdXcwBifr6XRkSiIst5mboaqoVn18KmBDMv+jDGMO8VCCaN751XJpLxC/EDR
         zp+eNku6bUob0oqMg6a1Y1IF8+gjccRWzEK9Cbs+VaF1mCHt1sll2Iqe6261r6Cn/Tjr
         RiQhEYrVAcZsQlXArA/D6JJctJ+75766eNA7dU2rBPNODzqrZMaCPrA6VfywHR8+59oY
         s0xqA5croe8j6SF4ykimxRtH17OjdP7G4IoAxCtY6b9zg3SEgF3FfJ1QjxQd4w1eAksL
         IcjhmHg69rxW4Z35mqg13FRUS+ApDFYnUMvbVimlCZQt6unQwgNhYxKBwG3HmKjxwMRw
         cuNg==
X-Gm-Message-State: AOJu0YyR4KCFwcOsmG5Coj8bBa1dihX7jzElLCVFAaGdPStGNpO+fl1T
        dcrtFkwIAoiTXJ7yzBsTr5FYHTREiJC+OdjqmQDdd2aH
X-Google-Smtp-Source: AGHT+IFpFLJAbDzq6Uq/IjclbKxpyDwfRyw5FUs76NsT3wsWuv3N1M4HuwXxr6KkQgc/1vZGyUuOk/NuWzzESWzJkSA=
X-Received: by 2002:ac2:4f15:0:b0:4fb:911b:4e19 with SMTP id
 k21-20020ac24f15000000b004fb911b4e19mr7492858lfr.35.1692704909135; Tue, 22
 Aug 2023 04:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230822094136.621740-1-chenfeiyang@loongson.cn> <CAJZ5v0hJ8AnaKrk=zeZHOm00YWqF2dYZGkDurDoMJHHVXZP8rg@mail.gmail.com>
In-Reply-To: <CAJZ5v0hJ8AnaKrk=zeZHOm00YWqF2dYZGkDurDoMJHHVXZP8rg@mail.gmail.com>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Tue, 22 Aug 2023 19:48:17 +0800
Message-ID: <CACWXhK=oLTD2gaM3n1Jz4Q51aeH_56OggmKOW5YWLOaXaDLGiw@mail.gmail.com>
Subject: Re: [PATCH] PCI/PM: Only read PCI_PM_CTRL register when available
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, bhelgaas@google.com,
        rafael.j.wysocki@intel.com, mika.westerberg@linux.intel.com,
        helgaas@kernel.org, anders.roxell@linaro.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        guyinggang@loongson.cn, siyanteng@loongson.cn,
        chenhuacai@loongson.cn, loongson-kernel@lists.loongnix.cn
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

On Tue, Aug 22, 2023 at 6:23=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Tue, Aug 22, 2023 at 11:41=E2=80=AFAM Feiyang Chen <chenfeiyang@loongs=
on.cn> wrote:
> >
> > If the pm_cap of the PCI device is unset, do not read the
> > PCI_PM_CTRL register in pci_set_full_power_state().
>
> So this is the case when the current state is already 0 and so
> pci_power_up() returns 0 even though dev->pm_cap is not set.  This
> should be mentioned in the changelog.
>

OK.

> > Fixes: e200904b275c ("PCI/PM: Split pci_power_up()")
> > Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> > ---
> >  drivers/pci/pci.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 60230da957e0..d6671cefcfa7 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -1305,8 +1305,10 @@ static int pci_set_full_power_state(struct pci_d=
ev *dev)
> >         if (ret < 0)
> >                 return ret;
>
> IMO it would be better to move the dev->current_state =3D=3D PCI_D0 check
> from pci_power_up() to this place, that is
>
> if (ret < 0) {
>         if (dev->current_state =3D=3D PCI_D0)
>                 return 0;
>
>         return ret;
> }
>
> because nothing more needs to be done below in that case.
>

OK.

> >
> > -       pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > -       dev->current_state =3D pmcsr & PCI_PM_CTRL_STATE_MASK;
> > +       if (dev->pm_cap) {
> > +               pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &p=
mcsr);
> > +               dev->current_state =3D pmcsr & PCI_PM_CTRL_STATE_MASK;
> > +       }
> >         if (dev->current_state !=3D PCI_D0) {
> >                 pci_info_ratelimited(dev, "Refused to change power stat=
e from %s to D0\n",
> >                                      pci_power_name(dev->current_state)=
);
> > --
> > 2.39.3
> >
