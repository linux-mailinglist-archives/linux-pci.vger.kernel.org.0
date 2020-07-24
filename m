Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1441722C6A7
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 15:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGXNgI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 09:36:08 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59163 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXNgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jul 2020 09:36:07 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1N2Unv-1kwxDf44zv-013xIE; Fri, 24 Jul 2020 15:36:05 +0200
Received: by mail-qk1-f180.google.com with SMTP id h7so8575895qkk.7;
        Fri, 24 Jul 2020 06:36:04 -0700 (PDT)
X-Gm-Message-State: AOAM532hYaDo6t+trYK+KCT+JMsg5jycchuLnjo51AAU19Wp3gLf8Ncu
        35WOXYGXfPYuI7U6enw6YYbLwiplR8D/VkeqtT0=
X-Google-Smtp-Source: ABdhPJw8PDUAcsa19D0JsA1UiJ+7gWd1V/OX8unaG7ilwuCw9y8HfDDcLAZ6+8VBtnlLCvi1Km+wsSFZgRokoxK9dkY=
X-Received: by 2002:a37:9004:: with SMTP id s4mr10380921qkd.286.1595597763603;
 Fri, 24 Jul 2020 06:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200716141534.30241-1-ulf.hansson@linaro.org>
 <CAK8P3a1+rwY5uFpUMijgET_W78Tj+tqqKDevgqstjUmmhxdKuA@mail.gmail.com> <CAPDyKFp3D8xZCSGNMm2ZOpa5f5wMwderCuAA5yLMXdjoKFoxQw@mail.gmail.com>
In-Reply-To: <CAPDyKFp3D8xZCSGNMm2ZOpa5f5wMwderCuAA5yLMXdjoKFoxQw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 24 Jul 2020 15:35:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3wLPv58uqTqyXk7+0Cxoe4vdfahzCxXOp2pdGZDkeFsw@mail.gmail.com>
Message-ID: <CAK8P3a3wLPv58uqTqyXk7+0Cxoe4vdfahzCxXOp2pdGZDkeFsw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Initial support for SD express card/host
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Rui Feng <rui_feng@realsil.com.cn>,
        linux-nvme@lists.infradead.org,
        linux-pci <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:sWySF2uPvNfnIJt2RYlZ05DeyB1/MWpKkxM0ZjPNdOei7NQaBl2
 qjvVQFmCkkg7AiyOwRHvceQS4gdf9GbXdpE8DiWykSINr04WTI6S7WEtOIxgzGPIhmLZw94
 Gftycli4cnN2AhZzNWTL/vt2w6qTOh41yvxPS+POCgoVcP/j6UwbbxPSkoAtDaOo7DUg2JM
 PkSMVcg0M/8DNCgT1bkxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xMpLX/THuQI=:xzY2tk0dNhSRXdDJ17jQpp
 sGaBDDQKEIO2siPv7Z7qubu2rUnrbrGZMHlfkMd2XVA4H38r5NBxREpgqE+HsC7E2sjf1mHdB
 SqVHokrnHo9G8GpqEwl9TPoq/jb6HB4zCr6fwEAmvtld9E/VxEDTpGss+8n1G2ciQaCKI6KpP
 ihcf8h8TC+S8b3lkpjK2NSM45yTIYVteVvnaqoE/wLPpQrwKw4WkwkLwDRwc4GxBzKXIG3sUl
 d4HRC/eDuVg5XKsqElXkEoEZvxpfIjAPlagZwpQRtmLFbPUGAw8cuHHtj1I7uv0ZD6Ph/rKnz
 c5dLzbq2jXhYJKvib/ovnxHc9G3GiaIWEGT8bEIFATykHSY2hTz6ys3hjHj4JxajqOFM8JaJk
 xqrNyn8jLzc9N3A4WA0XoCbQc8xJMlV3a3StdsM+TjokKoOFW+k0R1LJpN2INh+x+7wZflcl6
 skRNeRL5hEXsFwsYYdDLHfMosb4sZbMb7JH8cRwma0eV1RSixBt3avzJ+NslyRN+GaeVhPHg0
 piBzi2zBN+yDfiTxoBP51ASzPrrOattSJbATN+Ihll3ApuN9r9Tulr0kNKwLzTMO3xCH9HPJx
 QxbOuro2Z2Wp3fH5terEPRI4E4aQWL2y5aqRVJLTXF9uqFdYaNqhH+4RM4GWzsaFTyL0Jdr5K
 Trg5mNStOwW+xm/N30I7HhPnamJkZQWzoImXrSTEweuPT3FY+KQCFzFo3oBaF49wIhi+QUnzm
 lq0h8v2rlLm7xPQiRXfbiNEHo1+wKSX/d+YePicTbbniKoNnWUsDKXT2hq/p6kOD6AYn+FUYL
 T06vam23PeXJnSCGSiKEpWAEkmMLek6q+6KJeVaxnyaJYtVbvVlSmDgswQajm1KeZD7A/ezF7
 u555Ld0Z5flYmYVofLp0ZvbDx8QFhwkQLEBBC7Weoos1IKpg4IJTv6PAahryVQPacfWgXewfw
 pCfFH51zFlaVLZ/jL8c35flUsd3n0jclNR0cDp9gMtJL/KXzMCq0G
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 24, 2020 at 12:06 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Thu, 16 Jul 2020 at 20:23, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Jul 16, 2020 at 4:16 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > > +       /* Continue with the SD express init, if the card supports it. */
> > > +       resp &= 0x3000;
> > > +       if (pcie_bits && resp) {
> > > +               if (resp == 0x3000)
> > > +                       host->ios.timing = MMC_TIMING_SD_EXP_1_2V;
> > > +               else
> > > +                       host->ios.timing = MMC_TIMING_SD_EXP;
> > > +
> > > +               /*
> > > +                * According to the spec the clock shall also be gated, but
> > > +                * let's leave this to the host driver for more flexibility.
> > > +                */
> > > +               return host->ops->init_sd_express(host, &host->ios);
> > > +       }
> > > +
> > >         return 0;
> > >  }
> >
> > Does this need an additional handshake or timeout to see if the
> > device was successfully probed by the nvme driver?
> >
> > It looks like the card would just disappear here if e.g. the nvme driver
> > is not loaded or runs into a runtime error.
>
> You are correct! In principle, the card would not be detected (it
> doesn't disappear as it never gets registered). Instead, it's left in
> "half-initialized" state, waiting for the nvme driver to take over.
>
> I simply didn't want to go that far, to introduce synchronizations
> steps between the nvme driver and mmc driver, but rather started
> simple. Perhaps we can discuss these things as improvements on top
> instead?
>
> What do you think?

Starting simple is generally a good idea, yes.

It would be good to have feedback from the nvme driver maintainers.

One way I can see the handshake working would be to have
an sdexpress class_driver that provides interfaces for both mmc
and nvme to link against. The mmc core can then create a
class device when it finds an sd-express device and that
class device contains a simple state machine that keeps track of
what either side think is going on, possibly also providing
a way to perform callbacks between the two sides.

      Arnd
