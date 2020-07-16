Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEAE2228AB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 19:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgGPRFB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 13:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbgGPRFA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Jul 2020 13:05:00 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF74C08C5C0
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2020 10:04:59 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id x205so3373099vsc.11
        for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2020 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yXCXHIokDzodhKUObyVjOxa03jfGTBYMvv8WAppwfWw=;
        b=OMAZ17R5F4R2ot+nESDlRmF/PsTGBo0nI3RT7xp1G/cqE2oqUY3bc9Fb+ugMS80xrb
         znXaX4PAarGdFPR4LBReIhms/8bt9bKPhyvwhSRlY7CU0GUd57x4rIKKEuvgWWBKz69x
         i4xQ0ZoPWC36Gw/dqdOsafiQp1tUyNns5fk/cRljFa68IvfNSHwcTnQ9lYZzLLPNsfPk
         PWK9Mi4QjWU6/kksGKdQKviiSIGSdka8ufAadG90A+Y7rITCQ8IDj/3BXZUBVKib3mkE
         LA2ISGCmf/Id/n0XHdIlXCmmGZ/EntO1PICDf4G+PB6Vr1opRAuVYeK7+34wA+8GrRfo
         rWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yXCXHIokDzodhKUObyVjOxa03jfGTBYMvv8WAppwfWw=;
        b=ZIPRfmDggZbjhfrRD5E6fak3KsZrL1cHjQemvg3FgfU1yz1yz7Ybtg24UHB9aBHGyh
         qMsRze6eNkTUKRSpgPaaYs5E7qnIQckb7ICiPpYSjGhMbpLXyIfReYmhujcAO+4Jr5jM
         zRcuO+Z1ucXxlft9jAGUzedl3O6qJ80O5NE4/esioVSygmuYHqzKya6XHBqu6O7H8ZaP
         duI/ELI0Zu6519ZYlyld7yP7GLY5BaLYELfHmMLPsB1DtSzeGe6/qFKXk6ufNTIikMCJ
         2W3x8mio2otrg17UGyGBGMKGjOE8WCMoxa3wpiMQjX9x7oO+oWmH9wtRjKo+sqn38RkR
         poOw==
X-Gm-Message-State: AOAM533iM2uvPK5JM8/P1CRuANkX1+cRKjj4WkD60Ac7wLGHhM4c7u2t
        rANUN1M1kQITNnHuk1cdtHbb+IucYr8CwYMZcxQFbg==
X-Google-Smtp-Source: ABdhPJy+joudz+/azfNGzNGeAboNVq0ccJyFmfsvE4PWZBNI06UJy8K3PCy86RDOtundUZK2A9jXmpiX35sAbL82qYw=
X-Received: by 2002:a67:d01a:: with SMTP id r26mr4172278vsi.200.1594919098955;
 Thu, 16 Jul 2020 10:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200716141534.30241-1-ulf.hansson@linaro.org> <20200716161358.GA3135454@kroah.com>
In-Reply-To: <20200716161358.GA3135454@kroah.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Jul 2020 19:04:21 +0200
Message-ID: <CAPDyKFr6eSZr2V-=YvAEZH9SmsE2SZ9j5ZS5zZEFHBqwyWRfpw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Initial support for SD express card/host
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Rui Feng <rui_feng@realsil.com.cn>,
        linux-nvme@lists.infradead.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 16 Jul 2020 at 18:14, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 16, 2020 at 04:15:34PM +0200, Ulf Hansson wrote:
> > +int mmc_send_if_cond_pcie(struct mmc_host *host, u32 ocr)
> > +{
> > +     u32 resp = 0;
> > +     u8 pcie_bits = 0;
> > +     int ret;
> > +
> > +     if (host->caps2 & MMC_CAP2_SD_EXP) {
> > +             /* Probe card for SD express support via PCIe. */
> > +             pcie_bits = 0x10;
> > +             if (host->caps2 & MMC_CAP2_SD_EXP_1_2V)
> > +                     /* Probe also for 1.2V support. */
> > +                     pcie_bits = 0x30;
> > +     }
> > +
> > +     ret = __mmc_send_if_cond(host, ocr, pcie_bits, &resp);
> > +     if (ret)
> > +             return 0;
> > +
> > +     /* Continue with the SD express init, if the card supports it. */
> > +     resp &= 0x3000;
> > +     if (pcie_bits && resp) {
> > +             if (resp == 0x3000)
>
> 0x3000 should be some defined value, right?  Otherwise it just looks
> like magic bits :)

Yeah, I was considering that, but there are already lots of magic bits
around here in this code. On top of that, the bits are shifted,
depending on how they are used.

We should probably look into doing a cleanup, so this gets clearer overall.

>
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -60,6 +60,8 @@ struct mmc_ios {
> >  #define MMC_TIMING_MMC_DDR52 8
> >  #define MMC_TIMING_MMC_HS200 9
> >  #define MMC_TIMING_MMC_HS400 10
> > +#define MMC_TIMING_SD_EXP    11
> > +#define MMC_TIMING_SD_EXP_1_2V       12
> >
> >       unsigned char   signal_voltage;         /* signalling voltage (1.8V or 3.3V) */
> >
> > @@ -172,6 +174,9 @@ struct mmc_host_ops {
> >        */
> >       int     (*multi_io_quirk)(struct mmc_card *card,
> >                                 unsigned int direction, int blk_size);
> > +
> > +     /* Initialize an SD express card, mandatory for MMC_CAP2_SD_EXP. */
> > +     int     (*init_sd_express)(struct mmc_host *host, struct mmc_ios *ios);
> >  };
> >
> >  struct mmc_cqe_ops {
> > @@ -357,6 +362,8 @@ struct mmc_host {
> >  #define MMC_CAP2_HS200_1_2V_SDR      (1 << 6)        /* can support */
> >  #define MMC_CAP2_HS200               (MMC_CAP2_HS200_1_8V_SDR | \
> >                                MMC_CAP2_HS200_1_2V_SDR)
> > +#define MMC_CAP2_SD_EXP              (1 << 7)        /* SD express via PCIe */
>
> BIT(7)?
>
> > +#define MMC_CAP2_SD_EXP_1_2V (1 << 8)        /* SD express 1.2V */
>
> BIT(8)?

I can change to that, but it wouldn't be consistent with existing
code. Again, probably better targeted as a separate bigger cleanup on
top.

>
> thanks,
>
> greg k-h

Thanks for reviewing!

Kind regards
Uffe
