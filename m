Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F336397486
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 15:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhFANse (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 09:48:34 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:38333 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbhFANsd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Jun 2021 09:48:33 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1McpaE-1lESnR1NXm-00ZxC2 for <linux-pci@vger.kernel.org>; Tue, 01 Jun 2021
 15:46:51 +0200
Received: by mail-wm1-f54.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so1976064wmq.0
        for <linux-pci@vger.kernel.org>; Tue, 01 Jun 2021 06:46:51 -0700 (PDT)
X-Gm-Message-State: AOAM533KQNjQkYF8XJFeak6Porq5CZPHLI8NEP4ItexEw2RNZcpaMUF8
        gBBUoZ88KqxyvMB7TxdJlYz8mVd0gVWiDuuYM8s=
X-Google-Smtp-Source: ABdhPJx6u4miI+578Nb8PF2/rgMeGb/TbM4aNfInTgJlC95cjYtIvQpxtS59pDl2y93JkahgF51uukN9/QcUB14Zmi4=
X-Received: by 2002:a7b:c849:: with SMTP id c9mr5103wml.84.1622555211018; Tue,
 01 Jun 2021 06:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210601114301.2685875-1-linus.walleij@linaro.org>
In-Reply-To: <20210601114301.2685875-1-linus.walleij@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 1 Jun 2021 15:45:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a26kU6W_JK6NmQtCPRWrv12-pYtTLUP3xcE5fNqK5oW3Q@mail.gmail.com>
Message-ID: <CAK8P3a26kU6W_JK6NmQtCPRWrv12-pYtTLUP3xcE5fNqK5oW3Q@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: ixp4xx: Add a new driver for IXP4xx
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Zoltan HERPAI <wigyori@uid0.hu>,
        Raylynn Knight <rayknight@me.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PN2n/OJ1YJe4ntr6iv7QJL2id/xjiKZQAShrZ3mfIzc7QSXDLqA
 MBnuux89ynXuNCrzeg2MKdO8z7T1PD3eOFbt7Rh8APEhOeA9vrcRG6UW9caHsUa7a2H+TYH
 FS8FdELQSP51kkYKGJGFdrgjz+s1s9QsyPshT8vEQu3GPA03sSuZ+2AdAxsNSGdP3ZlFB7/
 NIlRl+pDSdu1zsi1IH5dA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hfiglnce4og=:c1h+Fz9a9yZWT3NlpgPfw6
 8hnwmJUHPsm6/FmYszdp27ldyROLKdg5Imk0VrkV3rzp52zGM2nA7htI2R/ohyq6C+Gq8U9jE
 Kk6Xa/4P45SegZdaK7L8MY34CzT7eVsL26VVNnDuvdIhh0I85zWjloMe0uU1Jgo8TpLWthg8T
 rPe3u0n8mxTP7mcdcfptUyeDkNtcaxaOPi4Ksq6ecKlVuizwl3OraA4lGEA141KRCwSzrzKOv
 1VydYbtX9AGEBT1BqkksINisdaOL5md3jUxM2h2CEQO/kZjeAlReoOHG58XtnLPpeM6VKpmoL
 xu/hwF1lbfcKjM+wtLSWUbRHGsuvVTJ1uIPJc2ZhDVVFxr+cohAZ04e36eX+CCHdr/BTdYgcr
 HPaTbOPQPASidEl1Y3OzcUHNGJ5PmI5umFuFNTUTVSOgkgH+rSXSDITskTaMToX0ujuWRdd9b
 XWXRAOnixbRaC3P6uhNo/09/MVWRRTys76MMJpeJ0ZgQHhLtiZSCOpHHHyTukgn+ErX9g9Ogd
 yGqouj5KfoHJWjk4mUGfAEgPbPx6//z615z84MzEf9+iOKVgdqHx6QdvvphyJWInWX3UQdoUJ
 JXLW1DdBpvazmVg9SXIbiCLyMC0QStXplhI+WummzOeCjLPnxVvfPjYEXdIFCoi5Akm72T15u
 GKiA=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +static int ixp4xx_pci_read(struct ixp4xx_pci *p, u32 addr, u32 cmd, u32 *data)
> +{
> +       unsigned long flags;
> +       int ret;
> +
> +       raw_spin_lock_irqsave(&p->lock, flags);

You should not need an extra spinlock on arm, as CONFIG_PCI_LOCKLESS_CONFIG
is not set here.

> +
> +/*
> + * This driver needs to be a builtin module with suppressed bind
> + * attributes since the probe() is initializing a hard exception
> + * handler and this can only be done from __init-tagged code
> + * sections. This module cannot be removed and inserted at all.
> + */
> +static struct platform_driver ixp4xx_pci_driver = {
> +       .driver = {
> +               .name = "ixp4xx-pci",
> +               .suppress_bind_attrs = true,
> +               .of_match_table = of_match_ptr(ixp4xx_pci_of_match),
> +       },
> +};
> +/*
> + * This is the only way to have an __init tagged probe that does
> + * not cause link errors.
> + */
> +builtin_platform_driver_probe(ixp4xx_pci_driver, ixp4xx_pci_probe);

I guess you could install the fault handler from a module init
function and at least allow unbind, or possibly forced module removal
(which would leave an invalid pointer in the fault handler until it
is loaded again).

         Arnd
