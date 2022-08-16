Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9906159616C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 19:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235798AbiHPRs6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 13:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236401AbiHPRsn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 13:48:43 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCFF543FE
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 10:48:41 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3246910dac3so170671707b3.12
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 10:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xCUo5ghGBN36x13Vo60s6urxbHjmkwgMk2UJKBoDPSc=;
        b=BrQH5to406+L1OEUgMNxmmvkZQuSxp9nF3jApbNCLdiW/ZiGF6rcXuvDuKmpTQqbCv
         oyKLk6QUIUVXIh+yX95xjLttCbc1SHP4rNxX2+A0uCBT6gIYEj35ibARBn4pTV5X9dVz
         AohEgLFTsAfjr+xAQ3XNc7LOQQC7oxsH4kI/pCHW0DBfM7SSpHp1uQHRYF+D0K3nI0EP
         IfkpQ2IDPBr4qC0IP0YKeZajX29dBMOOiLAo7EoQ/OVPuA8394k2ipYK3PYDOe/idGw6
         pEQVFzZh206sYsysqWkJrv82bLOGQHJw6pLunDEPte2JsGz1urPDXZBgaVcKti2Bof9q
         RJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xCUo5ghGBN36x13Vo60s6urxbHjmkwgMk2UJKBoDPSc=;
        b=egvV+98HSbhmjYC6KLt6a4OE54wjBEz7F9Kv95bVHZEgvrSkMc/shHAl8ugIVegbJa
         YZGBIG7H5i076+UNmgZ1HgTXI7OMFDnj7YoBahim423X6iLt38rFFZasPvuL+GpnsXwO
         fhe1j2tU7qaq+ISx1pKWSv2Fe1bE9jwfAUig204clN0e5FzmRv0DOGM6dnhDgI+P6tDH
         ug7UQpazROTTbcYSyLImdkAEoDebpvObYIW0dmLi/7h5eM0pOpPsE0DBZmEZm+ybDPs0
         vhsSmZJCl2Gl+shAGY0FHN23pwHt+XlscONPSXE6pTxWivZi6eh6wJS0ABK5CqMuZ4si
         TWxw==
X-Gm-Message-State: ACgBeo2nwybZA27FDNgiy5ML6oAwnZLLjchZrj+juS60/4KXUVdbvFfV
        RluEJ9sfDr2deudqukaCxH9PwC18TjaC9AZtBErB/HlOPTdAnw==
X-Google-Smtp-Source: AA6agR6Kfqj1kWnCUUQDDdduwfGblb8sOLyEIIrOLXzGYQ7ULfW6OHmFe3kUydTRkzZayQfKl+gaUr3WRco5jOLItJE=
X-Received: by 2002:a81:998c:0:b0:326:5dab:df3f with SMTP id
 q134-20020a81998c000000b003265dabdf3fmr18327536ywg.126.1660672120215; Tue, 16
 Aug 2022 10:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <62eed399.170a0220.2503a.1c64@mx.google.com> <YvEAF1ZvFwkNDs01@sirena.org.uk>
 <deda4eb1592cb61504c9d42765998653@walle.cc> <YvEEidOZ62igUYrR@sirena.org.uk>
 <CAGETcx_JSViBcySNp+Rany2osBiKL7ON+tooPKW8TOTP6+t_HA@mail.gmail.com> <YvvTKkR4sOIsFxA4@sirena.org.uk>
In-Reply-To: <YvvTKkR4sOIsFxA4@sirena.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Aug 2022 10:48:04 -0700
Message-ID: <CAGETcx8vwDd3m3DZFJK7h0jjHMZhOfChRKHPt5qj8O8cJ_ReHA@mail.gmail.com>
Subject: Re: next/master bisection: baseline.bootrr.intel-igb-probed on kontron-pitx-imx8m
To:     Mark Brown <broonie@kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 16, 2022 at 10:26 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Aug 12, 2022 at 04:54:25PM -0700, Saravana Kannan wrote:
>
> > While you are here, I'm working towards patches on top of [1] where
> > fw_devlink will tie the sync_state() callback to each regulator. Also,
> > i realized that if you can convert the regulator_class to a
> > regulator_bus, we could remove a lot of the "find the supply for this
> > regulator when it's registered" code and let device links handle it.
> > Let me know if that's something you'd be okay with. It would change
> > the sysfs path for /sys/class/regulator and moves it to
> > /sys/bus/regulator, but not sure if that's considered an ABI breakage
> > (sysfs paths change all the time).
>
> That *does* sound like it'd be an ABI issue TBH.  I thought there was
> support for keeping class around even when converting to a bus

Ah, this is news to me. I'll poke around to see if the path can be
maintained even after converting a class to a bus.

(though
> TBH given how entirely virtual this stuff us it seems odd that we'd be
> going for a bus).

I'm going for a bus because class doesn't have a distinction between
"device has been added" and "device is ready if these things happen".
There's nothing to say that a "bus" has to be a real hardware bus.

-Saravana
