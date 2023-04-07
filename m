Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4EB6DB3B9
	for <lists+linux-pci@lfdr.de>; Fri,  7 Apr 2023 20:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbjDGS4l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Apr 2023 14:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbjDGS4X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Apr 2023 14:56:23 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19CEC664
        for <linux-pci@vger.kernel.org>; Fri,  7 Apr 2023 11:54:24 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3e392e10cc4so664001cf.0
        for <linux-pci@vger.kernel.org>; Fri, 07 Apr 2023 11:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680893619; x=1683485619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57OqYugB2/xhFeaBFwZjJ6ChuTE8oOboxRR8GaV91vE=;
        b=TTSj0mzMY+NkQG1mVVWkjrpeEJe22SBs+5ls6QopGa0lxcGn/GwU01nepzLSuVPzNB
         8no7JrjKTpa0ymH1gaOkPBr6kopN/SCCyvRzZgtXou5sbAxWknszaGEFsDhSlpeHtuV+
         kRi9QrjEzZqXk72HVh/58tb7Jt4q56Rci39NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680893619; x=1683485619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57OqYugB2/xhFeaBFwZjJ6ChuTE8oOboxRR8GaV91vE=;
        b=HbWf3zi719d1LLvcHkz/6/xs//gF/bgSyORA/zf/sk6C8uOmZe6JbsSKS2WpX78ZfQ
         gMRhPyHXkjNrCVFm5LOotichmHvSnoeAov4IB6eQS0nI34AB6OxzVEKg/CKEpCFT42fR
         8YCzfFtYtqb8p/P2jr1uT2l8uXy/8VAew1uHHNlzk0R8xf+5NZJa065/snkpaRys3LUN
         ztFc3t4Uff7AldEkLRv2VqDG3uw5kCFWz/sCSesQQBc0xGzcF/ezUFQjp0wJNJK4PyfK
         hHJGxUWldmn5aNUTqfjpsbOi/ytwLuRsKiCFQAzcFwlXI+TjRHonGNfszy9Zmys8M2r3
         SBqg==
X-Gm-Message-State: AAQBX9ddAE5eWjl0vknzn8HEK9A3noXZ0wnKLS/3Wm8gQJoZogT+Nz76
        9ykg2dFLDEeBRwfaIn61LVFtmyG17g7xWJdossK+Yw==
X-Google-Smtp-Source: AKy350ZtWAr2QY3eX7hVagcxGmdJv/0DNwDmSkCvY4XSOkr1NBpHiZpBP+LftgmtRLLmihz4Bwl6MKYQ8qz5+81T5dU=
X-Received: by 2002:a05:622a:1b86:b0:3e2:3de:3732 with SMTP id
 bp6-20020a05622a1b8600b003e203de3732mr27107qtb.7.1680893618577; Fri, 07 Apr
 2023 11:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230317175109.3859943-2-grundler@chromium.org> <20230406195045.GA3729127@bhelgaas>
In-Reply-To: <20230406195045.GA3729127@bhelgaas>
From:   Grant Grundler <grundler@chromium.org>
Date:   Fri, 7 Apr 2023 11:53:27 -0700
Message-ID: <CANEJEGvKRVGLYPmD3kujg6veq5KR7J+rAu6ni92wUz72KGtyBA@mail.gmail.com>
Subject: Re: [PATCHv2 pci-next 2/2] PCI/AER: Rate limit the reporting of the
 correctable errors
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Grant Grundler <grundler@chromium.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O 'Halloran" <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rajat Jain <rajatja@chromium.org>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 6, 2023 at 12:50=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Mar 17, 2023 at 10:51:09AM -0700, Grant Grundler wrote:
> > From: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> >
> > There are many instances where correctable errors tend to inundate
> > the message buffer. We observe such instances during thunderbolt PCIe
> > tunneling.
> >
> > It's true that they are mitigated by the hardware and are non-fatal
> > but we shouldn't be spamming the logs with such correctable errors as i=
t
> > confuses other kernel developers less familiar with PCI errors, support
> > staff, and users who happen to look at the logs, hence rate limit them.
> >
> > A typical example log inside an HP TBT4 dock:
> > [54912.661142] pcieport 0000:00:07.0: AER: Multiple Corrected error rec=
eived: 0000:2b:00.0
> > [54912.661194] igc 0000:2b:00.0: PCIe Bus Error: severity=3DCorrected, =
type=3DData Link Layer, (Transmitter ID)
> > [54912.661203] igc 0000:2b:00.0:   device [8086:5502] error status/mask=
=3D00001100/00002000
> > [54912.661211] igc 0000:2b:00.0:    [ 8] Rollover
> > [54912.661219] igc 0000:2b:00.0:    [12] Timeout
> > [54982.838760] pcieport 0000:00:07.0: AER: Corrected error received: 00=
00:2b:00.0
> > [54982.838798] igc 0000:2b:00.0: PCIe Bus Error: severity=3DCorrected, =
type=3DData Link Layer, (Transmitter ID)
> > [54982.838808] igc 0000:2b:00.0:   device [8086:5502] error status/mask=
=3D00001000/00002000
> > [54982.838817] igc 0000:2b:00.0:    [12] Timeout
>
> The timestamps don't contribute to understanding the problem, so we
> can omit them.

Ok.

> > This gets repeated continuously, thus inundating the buffer.
> >
> > Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> > Signed-off-by: Grant Grundler <grundler@chromium.org>
> > ---
> >  drivers/pci/pcie/aer.c | 42 ++++++++++++++++++++++++++++--------------
> >  1 file changed, 28 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index cb6b96233967..b592cea8bffe 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -706,8 +706,8 @@ static void __aer_print_error(struct pci_dev *dev,
> >                       errmsg =3D "Unknown Error Bit";
> >
> >               if (info->severity =3D=3D AER_CORRECTABLE)
> > -                     pci_info(dev, "   [%2d] %-22s%s\n", i, errmsg,
> > -                             info->first_error =3D=3D i ? " (First)" :=
 "");
> > +                     pci_info_ratelimited(dev, "   [%2d] %-22s%s\n", i=
, errmsg,
> > +                                          info->first_error =3D=3D i ?=
 " (First)" : "");
>
> I don't think this is going to reliably work the way we want.  We have
> a bunch of pci_info_ratelimited() calls, and each caller has its own
> ratelimit_state data.  Unless we call pci_info_ratelimited() exactly
> the same number of times for each error, the ratelimit counters will
> get out of sync and we'll end up printing fragments from error A mixed
> with fragments from error B.

Ok - what I'm reading between the lines here is the output should be
emitted in one step, not multiple pci_info_ratelimited() calls. if the
code built an output string (using sprintnf()), and then called
pci_info_ratelimited() exactly once at the bottom, would that be
sufficient?

> I think we need to explicitly manage the ratelimiting ourselves,
> similar to print_hmi_event_info() or print_extlog_rcd().  Then we can
> have a *single* ratelimit_state, and we can check it once to determine
> whether to log this correctable error.

Is the rate limiting per call location or per device? From above, I
understood rate limiting is "per call location".
If the code only has one call location, it should achieve the same goal, ri=
ght?

cheers,
grant
>
> >               else
> >                       pci_err(dev, "   [%2d] %-22s%s\n", i, errmsg,
> >                               info->first_error =3D=3D i ? " (First)" :=
 "");
> > @@ -719,7 +719,6 @@ void aer_print_error(struct pci_dev *dev, struct ae=
r_err_info *info)
> >  {
> >       int layer, agent;
> >       int id =3D ((dev->bus->number << 8) | dev->devfn);
> > -     const char *level;
> >
> >       if (!info->status) {
> >               pci_err(dev, "PCIe Bus Error: severity=3D%s, type=3DInacc=
essible, (Unregistered Agent ID)\n",
> > @@ -730,14 +729,21 @@ void aer_print_error(struct pci_dev *dev, struct =
aer_err_info *info)
> >       layer =3D AER_GET_LAYER_ERROR(info->severity, info->status);
> >       agent =3D AER_GET_AGENT(info->severity, info->status);
> >
> > -     level =3D (info->severity =3D=3D AER_CORRECTABLE) ? KERN_INFO : K=
ERN_ERR;
> > +     if (info->severity =3D=3D AER_CORRECTABLE) {
> > +             pci_info_ratelimited(dev, "PCIe Bus Error: severity=3D%s,=
 type=3D%s, (%s)\n",
> > +                                  aer_error_severity_string[info->seve=
rity],
> > +                                  aer_error_layer[layer], aer_agent_st=
ring[agent]);
> >
> > -     pci_printk(level, dev, "PCIe Bus Error: severity=3D%s, type=3D%s,=
 (%s)\n",
> > -                aer_error_severity_string[info->severity],
> > -                aer_error_layer[layer], aer_agent_string[agent]);
> > +             pci_info_ratelimited(dev, "  device [%04x:%04x] error sta=
tus/mask=3D%08x/%08x\n",
> > +                                  dev->vendor, dev->device, info->stat=
us, info->mask);
> > +     } else {
> > +             pci_err(dev, "PCIe Bus Error: severity=3D%s, type=3D%s, (=
%s)\n",
> > +                     aer_error_severity_string[info->severity],
> > +                     aer_error_layer[layer], aer_agent_string[agent]);
> >
> > -     pci_printk(level, dev, "  device [%04x:%04x] error status/mask=3D=
%08x/%08x\n",
> > -                dev->vendor, dev->device, info->status, info->mask);
> > +             pci_err(dev, "  device [%04x:%04x] error status/mask=3D%0=
8x/%08x\n",
> > +                     dev->vendor, dev->device, info->status, info->mas=
k);
> > +     }
> >
> >       __aer_print_error(dev, info);
> >
> > @@ -757,11 +763,19 @@ static void aer_print_port_info(struct pci_dev *d=
ev, struct aer_err_info *info)
> >       u8 bus =3D info->id >> 8;
> >       u8 devfn =3D info->id & 0xff;
> >
> > -     pci_info(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
> > -              info->multi_error_valid ? "Multiple " : "",
> > -              aer_error_severity_string[info->severity],
> > -              pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> > -              PCI_FUNC(devfn));
> > +     if (info->severity =3D=3D AER_CORRECTABLE)
> > +             pci_info_ratelimited(dev, "%s%s error received: %04x:%02x=
:%02x.%d\n",
> > +                                  info->multi_error_valid ? "Multiple =
" : "",
> > +                                  aer_error_severity_string[info->seve=
rity],
> > +                                  pci_domain_nr(dev->bus), bus, PCI_SL=
OT(devfn),
> > +                                  PCI_FUNC(devfn));
> > +     else
> > +             pci_info(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
> > +                      info->multi_error_valid ? "Multiple " : "",
> > +                      aer_error_severity_string[info->severity],
> > +                      pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> > +                      PCI_FUNC(devfn));
> > +
> >  }
> >
> >  #ifdef CONFIG_ACPI_APEI_PCIEAER
> > --
> > 2.40.0.rc1.284.g88254d51c5-goog
> >
