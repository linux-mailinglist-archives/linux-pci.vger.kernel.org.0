Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA5724F291
	for <lists+linux-pci@lfdr.de>; Mon, 24 Aug 2020 08:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgHXGeg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Aug 2020 02:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgHXGee (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Aug 2020 02:34:34 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9E5C061574
        for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2020 23:34:34 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g11so2279191ual.2
        for <linux-pci@vger.kernel.org>; Sun, 23 Aug 2020 23:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g0O7JTTEG8zhra8Bmg9qzPY8D1AcZ5n76o6w8ixndyc=;
        b=Nc6vsHNoA7tyvTeoyEk/516QqWonlIVTa5PIghtJCkIBB60ctW7pnM6s1MxqOYQRzj
         9flK76JLPqsVr6jgcvEENxKMZhBMdpyVoz46hcu7lELf8vbsU+U0P8W6krU52IU0IE7c
         y8Aizy9JTOnPM7Qf7hTY1hltjtojdKO7qWriIEWDJS5MI2/L0tkV0tBHLQn6IWc+DJzs
         xESjMdyDNixzBEK8TXDNbQB0+SsO9CSRn4g2tGoDi4VKi138BqetjefnMfS1HwlFE78X
         XLE4wmIEHeBSmK99rJxKE4oxirb97De0wSCI9XTBfzsXh1KACd+3xTrGw6evmXQdyN0G
         czAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g0O7JTTEG8zhra8Bmg9qzPY8D1AcZ5n76o6w8ixndyc=;
        b=p3FWsniiTV+YzR/9qEct+SxcEp4mvQ5xO/QPqOzzjPLNV7LdjYbQ3jIhSxU1mmdczD
         lQsu2XonPaM7iUNvYxBKba9r7fDrxffc2YFJ0h7ZUx9lzsvzNwzwB6JyirYovOTDblqV
         UUI3C+1zb/1u0C1WJDvycHsEAOuN2v1oL3nqO0yz+8ka7Sq2MBTN1xLNLuLocwtC/Idu
         kaTkH5fq3TvEwSOQ3udcc8fyI4Sj8gU0dcGmEHZtfxzbu+JaxscLCVvwuola/YKN33DA
         XP8Cl6INEQvZIL9zWdA8+wIxHt/UQtqmbcfom/O+nVew2CefLR4Ii8p1MxYSN2Nw7AdS
         WwLA==
X-Gm-Message-State: AOAM53068aJfVmFm3c9g+wow3ETDKrYtZ00i4tMDcMr+j4WoHRCKbjhQ
        O1ACBmXWF2Y/+b/1lyEMeFLSD08PNiIqAnTMNYGXag==
X-Google-Smtp-Source: ABdhPJzUK/zzpLyTaZNUq3D08AEPc3DpsY8FmM6IbHqVYAv0DvFNoLUEzWRZ5xuxYKq6Rno77e4i5E7HnKfw3Agv8hI=
X-Received: by 2002:ab0:3a85:: with SMTP id r5mr1733713uaw.100.1598250873271;
 Sun, 23 Aug 2020 23:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200716141534.30241-1-ulf.hansson@linaro.org>
 <CAPDyKFr5WQ1kpFguDe2e8G7t7p_99CFbqwRQFZPCSuMV2eYsMQ@mail.gmail.com> <f4d74498a8c246a595e56b8daa09ece8@realsil.com.cn>
In-Reply-To: <f4d74498a8c246a595e56b8daa09ece8@realsil.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Aug 2020 08:33:57 +0200
Message-ID: <CAPDyKFqwcQO2E2b4h7kmgHYRBQJAJ5N1RgW3Kk5hR2ccZ34VAA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Initial support for SD express card/host
To:     =?UTF-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Aug 2020 at 03:04, =E5=86=AF=E9=94=90 <rui_feng@realsil.com.cn> =
wrote:
>
> Hi Hansson:
>
> If this patch will not be changed, I will post a patch for rtsx driver ac=
cording your patch.

I don't think there is any change needed, unless you think so.

Kind regards
Uffe

>
> >
> > Rui,
> >
> > On Thu, 16 Jul 2020 at 16:16, Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:
> > >
> > > In the SD specification v7.10 the SD express card has been added. Thi=
s
> > > new type of removable SD card, can be managed via a PCIe/NVMe based
> > > interface, while also allowing backwards compatibility towards the
> > > legacy SD interface.
> > >
> > > To keep the backwards compatibility, it's required to start the
> > > initialization through the legacy SD interface. If it turns out that
> > > the mmc host and the SD card, both supports the PCIe/NVMe interface,
> > > then a switch should be allowed.
> > >
> > > Therefore, let's introduce some basic support for this type of SD
> > > cards to the mmc core. The mmc host, should set MMC_CAP2_SD_EXP if it
> > > supports this interface and MMC_CAP2_SD_EXP_1_2V, if also 1.2V is
> > > supported, as to inform the core about it.
> > >
> > > To deal with the switch to the PCIe/NVMe interface, the mmc host is
> > > required to implement a new host ops, ->init_sd_express(). Based on
> > > the initial communication between the host and the card,
> > > host->ios.timing is set to either MMC_TIMING_SD_EXP or
> > > MMC_TIMING_SD_EXP_1_2V, depending on if 1.2V is supported or not. In
> > > this way, the mmc host can check these values in its ->init_sd_expres=
s() ops,
> > to know how to proceed with the handover.
> > >
> > > Note that, to manage card insert/removal, the mmc core sticks with
> > > using the ->get_cd() callback, which means it's the host's
> > > responsibility to make sure it provides valid data, even if the card
> > > may be managed by PCIe/NVMe at the moment. As long as the card seems
> > > to be present, the mmc core keeps the card powered on.
> > >
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Rui Feng <rui_feng@realsil.com.cn>
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > Rui, did you manage to get some time to look at $subject patch?
> >
> > If you need some help to understand what's needed to implement the
> > corresponding support in drivers/mmc/host/rtsx_pci_sdmmc.c, then please
> > just ask.
> >
> > I think it would make sense to queue changes for rtsx_pci at the same p=
oint as
> > the mmc core changes. That's because I don't want to maintain code in t=
he
> > mmc core that's left unused.
> >
> > Kind regards
> > Uffe
> >
> > > ---
> > >  drivers/mmc/core/core.c   | 15 ++++++++++--
> > >  drivers/mmc/core/host.h   |  6 +++++
> > >  drivers/mmc/core/sd_ops.c | 49
> > > +++++++++++++++++++++++++++++++++++++--
> > >  drivers/mmc/core/sd_ops.h |  1 +
> > >  include/linux/mmc/host.h  |  7 ++++++
> > >  5 files changed, 74 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> > > 8ccae6452b9c..6673c0f33cc7 100644
> > > --- a/drivers/mmc/core/core.c
> > > +++ b/drivers/mmc/core/core.c
> > > @@ -2137,8 +2137,12 @@ static int mmc_rescan_try_freq(struct
> > mmc_host
> > > *host, unsigned freq)
> > >
> > >         mmc_go_idle(host);
> > >
> > > -       if (!(host->caps2 & MMC_CAP2_NO_SD))
> > > -               mmc_send_if_cond(host, host->ocr_avail);
> > > +       if (!(host->caps2 & MMC_CAP2_NO_SD)) {
> > > +               if (mmc_send_if_cond_pcie(host, host->ocr_avail))
> > > +                       goto out;
> > > +               if (mmc_card_sd_express(host))
> > > +                       return 0;
> > > +       }
> > >
> > >         /* Order's important: probe SDIO, then SD, then MMC */
> > >         if (!(host->caps2 & MMC_CAP2_NO_SDIO)) @@ -2153,6 +2157,7
> > @@
> > > static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
> > >                 if (!mmc_attach_mmc(host))
> > >                         return 0;
> > >
> > > +out:
> > >         mmc_power_off(host);
> > >         return -EIO;
> > >  }
> > > @@ -2280,6 +2285,12 @@ void mmc_rescan(struct work_struct *work)
> > >                 goto out;
> > >         }
> > >
> > > +       /* If an SD express card is present, then leave it as is. */
> > > +       if (mmc_card_sd_express(host)) {
> > > +               mmc_release_host(host);
> > > +               goto out;
> > > +       }
> > > +
> > >         for (i =3D 0; i < ARRAY_SIZE(freqs); i++) {
> > >                 unsigned int freq =3D freqs[i];
> > >                 if (freq > host->f_max) { diff --git
> > > a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h index
> > > 5e3b9534ffb2..ba407617ed23 100644
> > > --- a/drivers/mmc/core/host.h
> > > +++ b/drivers/mmc/core/host.h
> > > @@ -77,5 +77,11 @@ static inline bool mmc_card_hs400es(struct
> > mmc_card *card)
> > >         return card->host->ios.enhanced_strobe;  }
> > >
> > > +static inline bool mmc_card_sd_express(struct mmc_host *host) {
> > > +       return host->ios.timing =3D=3D MMC_TIMING_SD_EXP ||
> > > +               host->ios.timing =3D=3D MMC_TIMING_SD_EXP_1_2V; }
> > > +
> > >  #endif
> > >
> > > diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> > > index 22bf528294b9..d61ff811218c 100644
> > > --- a/drivers/mmc/core/sd_ops.c
> > > +++ b/drivers/mmc/core/sd_ops.c
> > > @@ -158,7 +158,8 @@ int mmc_send_app_op_cond(struct mmc_host *host,
> > u32 ocr, u32 *rocr)
> > >         return err;
> > >  }
> > >
> > > -int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
> > > +static int __mmc_send_if_cond(struct mmc_host *host, u32 ocr, u8
> > pcie_bits,
> > > +                             u32 *resp)
> > >  {
> > >         struct mmc_command cmd =3D {};
> > >         int err;
> > > @@ -171,7 +172,7 @@ int mmc_send_if_cond(struct mmc_host *host, u32
> > ocr)
> > >          * SD 1.0 cards.
> > >          */
> > >         cmd.opcode =3D SD_SEND_IF_COND;
> > > -       cmd.arg =3D ((ocr & 0xFF8000) !=3D 0) << 8 | test_pattern;
> > > +       cmd.arg =3D ((ocr & 0xFF8000) !=3D 0) << 8 | pcie_bits << 8 |
> > > + test_pattern;
> > >         cmd.flags =3D MMC_RSP_SPI_R7 | MMC_RSP_R7 |
> > MMC_CMD_BCR;
> > >
> > >         err =3D mmc_wait_for_cmd(host, &cmd, 0); @@ -186,6 +187,50
> > @@
> > > int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
> > >         if (result_pattern !=3D test_pattern)
> > >                 return -EIO;
> > >
> > > +       if (resp)
> > > +               *resp =3D cmd.resp[0];
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +int mmc_send_if_cond(struct mmc_host *host, u32 ocr) {
> > > +       return __mmc_send_if_cond(host, ocr, 0, NULL); }
> > > +
> > > +int mmc_send_if_cond_pcie(struct mmc_host *host, u32 ocr) {
> > > +       u32 resp =3D 0;
> > > +       u8 pcie_bits =3D 0;
> > > +       int ret;
> > > +
> > > +       if (host->caps2 & MMC_CAP2_SD_EXP) {
> > > +               /* Probe card for SD express support via PCIe. */
> > > +               pcie_bits =3D 0x10;
> > > +               if (host->caps2 & MMC_CAP2_SD_EXP_1_2V)
> > > +                       /* Probe also for 1.2V support. */
> > > +                       pcie_bits =3D 0x30;
> > > +       }
> > > +
> > > +       ret =3D __mmc_send_if_cond(host, ocr, pcie_bits, &resp);
> > > +       if (ret)
> > > +               return 0;
> > > +
> > > +       /* Continue with the SD express init, if the card supports it=
. */
> > > +       resp &=3D 0x3000;
> > > +       if (pcie_bits && resp) {
> > > +               if (resp =3D=3D 0x3000)
> > > +                       host->ios.timing =3D
> > MMC_TIMING_SD_EXP_1_2V;
> > > +               else
> > > +                       host->ios.timing =3D MMC_TIMING_SD_EXP;
> > > +
> > > +               /*
> > > +                * According to the spec the clock shall also be gate=
d, but
> > > +                * let's leave this to the host driver for more flexi=
bility.
> > > +                */
> > > +               return host->ops->init_sd_express(host, &host->ios);
> > > +       }
> > > +
> > >         return 0;
> > >  }
> > >
> > > diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> > > index 2194cabfcfc5..3ba7b3cf4652 100644
> > > --- a/drivers/mmc/core/sd_ops.h
> > > +++ b/drivers/mmc/core/sd_ops.h
> > > @@ -16,6 +16,7 @@ struct mmc_host;
> > >  int mmc_app_set_bus_width(struct mmc_card *card, int width);  int
> > > mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);  int
> > > mmc_send_if_cond(struct mmc_host *host, u32 ocr);
> > > +int mmc_send_if_cond_pcie(struct mmc_host *host, u32 ocr);
> > >  int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca)=
;
> > > int mmc_app_send_scr(struct mmc_card *card);  int mmc_sd_switch(struc=
t
> > > mmc_card *card, int mode, int group, diff --git
> > > a/include/linux/mmc/host.h b/include/linux/mmc/host.h index
> > > c5b6e97cb21a..905cddc5e6f3 100644
> > > --- a/include/linux/mmc/host.h
> > > +++ b/include/linux/mmc/host.h
> > > @@ -60,6 +60,8 @@ struct mmc_ios {
> > >  #define MMC_TIMING_MMC_DDR52   8
> > >  #define MMC_TIMING_MMC_HS200   9
> > >  #define MMC_TIMING_MMC_HS400   10
> > > +#define MMC_TIMING_SD_EXP      11
> > > +#define MMC_TIMING_SD_EXP_1_2V 12
> > >
> > >         unsigned char   signal_voltage;         /* signalling voltage
> > (1.8V or 3.3V) */
> > >
> > > @@ -172,6 +174,9 @@ struct mmc_host_ops {
> > >          */
> > >         int     (*multi_io_quirk)(struct mmc_card *card,
> > >                                   unsigned int direction, int
> > > blk_size);
> > > +
> > > +       /* Initialize an SD express card, mandatory for MMC_CAP2_SD_E=
XP.
> > */
> > > +       int     (*init_sd_express)(struct mmc_host *host, struct
> > mmc_ios *ios);
> > >  };
> > >
> > >  struct mmc_cqe_ops {
> > > @@ -357,6 +362,8 @@ struct mmc_host {
> > >  #define MMC_CAP2_HS200_1_2V_SDR        (1 << 6)        /* can
> > support */
> > >  #define MMC_CAP2_HS200         (MMC_CAP2_HS200_1_8V_SDR | \
> > >                                  MMC_CAP2_HS200_1_2V_SDR)
> > > +#define MMC_CAP2_SD_EXP                (1 << 7)        /* SD
> > express via PCIe */
> > > +#define MMC_CAP2_SD_EXP_1_2V   (1 << 8)        /* SD express 1.2V
> > */
> > >  #define MMC_CAP2_CD_ACTIVE_HIGH        (1 << 10)       /*
> > Card-detect signal active high */
> > >  #define MMC_CAP2_RO_ACTIVE_HIGH        (1 << 11)       /*
> > Write-protect signal active high */
> > >  #define MMC_CAP2_NO_PRESCAN_POWERUP (1 << 14)  /* Don't power
> > up
> > > before scan */
> > > --
> > > 2.20.1
> > >
> >
> > ------Please consider the environment before printing this e-mail.
