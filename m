Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5ABE763448
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 12:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjGZKvj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jul 2023 06:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjGZKvg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jul 2023 06:51:36 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9789B
        for <linux-pci@vger.kernel.org>; Wed, 26 Jul 2023 03:51:35 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a1d9b64837so4560263b6e.0
        for <linux-pci@vger.kernel.org>; Wed, 26 Jul 2023 03:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690368694; x=1690973494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CZTtpzIiuK1AETB2vADwBKUbLtqg5KfLHMSdy41Ytto=;
        b=h0RWUfckruSir+Bt+RHX9cKNs51q/Xt8uBkPMKqZIvNxG5nIV2FiVLEwGl0n4oWJwh
         XmURT5sHCYl38Ak8fysjpSk4JS4QPv9REtIBlmsPBg6uXON0FXyRe2inYIFJP6tkV5hR
         0IbtZv61tVlP34jnOg/lpS3C5KNJCXTF3enNrB1HPRGRL/G4QG7MBrtnA6QLj5cxHAlS
         KYtHQBbCJd97fvlKFWIqd0R48t7WCp+DN2phoqPTS5urC+7y8nypvpwTep4vDgJ3KH3W
         0DzAUFrj//hz/KcKIVIXl+oZI0sYKmL+A5d/02SUrjTrNP9F74SxYnqpmd/jP6upOv6v
         AYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690368694; x=1690973494;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZTtpzIiuK1AETB2vADwBKUbLtqg5KfLHMSdy41Ytto=;
        b=e3zHuqpAF326gE8r9ySodkPfDuGB4YZ2cXfyD094miECyOxGHTVMr3Hkish7pW/Hlx
         NTd/cwKL/Zw/z8vj1/5lM4uyKnmEuILaoDHCiCQh4XgXxvpu8KXNdRhEPg52pLWdRnqN
         iN4Fp2Ox+ZIQBp53vyVCC6NpLdcM9LszxNWvJZLBhfv9lw3RhSnEhyN6OOedkEN8Ru3n
         bcpsYsfp/ClzRiexvn0H9YJhyqh3QIth4Y+tWhuH3GwXMv01zpRVfDHTI+lH8nwTk4k2
         mFZw1sG14+IzErcJnbn+GM/1kg4t/C6w+b/wOI4NMoniRfT+gHecvWO11P0e4FdM/bvr
         7bCw==
X-Gm-Message-State: ABy/qLYFBjNmY9lYVmickwbbuOIBgPVk1EtgKQK8lasSS971T60ijGtr
        9Qb28aDwm1GeEpWIW3Eg3lDi5Zt8DAiyheWPbgx3aw==
X-Google-Smtp-Source: APBJJlEZRYsJijGWZj0AQQkID81DiZA6zTvLQmJVKjCjSDRsSHRi20fBJcacAwhgScdzgJBpYX4Qo39UfsylKQfZk1M=
X-Received: by 2002:a05:6808:1923:b0:3a1:f047:6314 with SMTP id
 bf35-20020a056808192300b003a1f0476314mr2376204oib.13.1690368694580; Wed, 26
 Jul 2023 03:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtAi8NQ_5LNku3oik6b0243xhGFt2WyxERNE+eNqLbNOw@mail.gmail.com>
 <76665dd9-1cbc-4b3a-b466-18a54cd74c1c@app.fastmail.com> <CA+G9fYuEVLeJX485ZbPNnvbViYUecNsewGiMi+54mNVnL-XBGA@mail.gmail.com>
 <40807832-9e26-403a-b7b7-3979d4984b23@app.fastmail.com>
In-Reply-To: <40807832-9e26-403a-b7b7-3979d4984b23@app.fastmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 26 Jul 2023 16:21:23 +0530
Message-ID: <CA+G9fYuAZp21xcJNJB=GtbRzPm2Y0pPkBR1Dff4-8s9wu53phg@mail.gmail.com>
Subject: Re: x15: Unable to handle kernel NULL pointer dereference at virtual
 address 00000004 when read : pci_generic_config_read
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-pci@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Benjamin Copeland <ben.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 26 Jul 2023 at 16:04, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jul 26, 2023, at 11:59, Naresh Kamboju wrote:
> > On Tue, 20 Jun 2023 at 14:10, Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> On Tue, Jun 20, 2023, at 10:00, Naresh Kamboju wrote:
> >> > We have been noticing the following kernel crash on x15 device while running
> >> > LTP fs proc01 testing with Linux stable rc 6.x kernels.
> >>
> >> Do you know if this is a regression with this kernel version compared
> >> to older kernels running the same tests, or an added testcase in LTP
> >> that exercises a code path that may have been broken for longer?
> ...
> >>
> >> I have not disassembled the vmlinux file, but I can see that the
> >> offset into the NULL pointer is '4', which does not match the
> >> structur offsets for bus->ops or ops->map_bus.
> >>
> >> I also see that if map_bus returns NULL, we treat that as
> >> an error, but if it returns '4', that is taken as a pointer,
> >> which is my best guess at what is happening here.
> >>
> >> map_bus() seems to be either dw_pcie_other_conf_map_bus() or
> >> dw_pcie_own_conf_map_bus(), since the dra7 does not have its
> >> own variant but inherits these from the dwc pci driver.
> >>
> >> I think this is caused by the combination of two bugs:
> >>
> >> - something prevents the dra7-pcie driver from probing the
> >>   device correctly, ultimately failing with the "failed to
> >>   request irq" message.
> >>
> >> - The error handling in dra7xx_pcie_probe() fails to clean
> >>   up after the first problem, leaving the PCIe host
> >>   in a broken state instead of removing it entirely.
> >
> > The reported kernel crash is continuously happening on the
> > BeagleBoard x15 device while running LTP fs tests on stable rc 6.4.7-rc1.
>
> Ok, so you think there is an additional regression between
> 6.4.6 and 6.4.7-rc1? on top of the two that you have not bisected?

Sure.
We need to find out more details like when it got started
and need to check this crash on the mainline kernel and
stable rc branches.


>
> I don't see any changes in drivers/pci/ after 6.4.5, so I'm
> even more confused now.
>
> > soundcore display_connector
> > [ 1195.601104] CPU: 0 PID: 4876 Comm: proc01 Not tainted 6.4.7-rc1 #1
> > [ 1195.607330] Hardware name: Generic DRA74X (Flattened Device Tree)
> > [ 1195.613464] PC is at pci_generic_config_read+0x34/0x8c
> > [ 1195.618621] LR is at pci_generic_config_read+0x1c/0x8c
>
> This looks identical to the first bugs that you reported, so I'd
> suggest you keep trying to narrow down when that one started rather
> than looking at the latest stable-rc.

Thanks for the suggestions.

>
>      Arnd

-Naresh
