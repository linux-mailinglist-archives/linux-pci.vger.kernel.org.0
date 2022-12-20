Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1074F6524DD
	for <lists+linux-pci@lfdr.de>; Tue, 20 Dec 2022 17:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiLTQrP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Dec 2022 11:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiLTQrI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Dec 2022 11:47:08 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6BDB850
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 08:46:58 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id e190so4260224pgc.9
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 08:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S9MYeEEvKypc4mpQnza4+BeXfUFl1039ZqekhzchkzA=;
        b=gC92C0srqh0bzt3sZl8p90ERaBFv3q+IPEHBDqiAr8Gl6w7ssHuuRnrkIo//rjBc0+
         NMz5S9Q6XtOZi3FBx0E4TRU7spQ80ylSiU/NxJnUr/h377BcLdzO84mLlTUDTWoU/hU5
         H5dlKsnn5YiA+baudcN6twCWz2MT+yKYBKya4HsSRisHj0AI9Km4laR1jl1d96uWv4hi
         +u/Rw/vtvudGmC3fXdcTMh2BVpVP6r6DGm4X+w9i+NmCdlo/MvWp/aC+XJw8m4uKIlR7
         p5DY7y+Qy2vvXMyM3VzWeYwuraPTqOaX25iKSnMpYOl4l1BQup2SR/jySluyKyi+45pk
         cLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9MYeEEvKypc4mpQnza4+BeXfUFl1039ZqekhzchkzA=;
        b=4kG8VBTREi58l4tDLora9eQByxvbezcdil9ALNfLpTpvV4Rhy0ooJ596DaWjiyAvM/
         +IXh3LdUJxHOU3ZSazRTw52DZAUmFKMN6grwAoYw0UW5O31ES3fztbgmWgVeJf8CrcMc
         7SVRG6yKO/upvVF2eGQgX8AzE41nvJ0Dh4fFC+2CbuqJbX54uNwniabzPVTKW9jokV3x
         0xzlomAqSV5NEBH6DueZEhScMFM5yH37fjIShHWD/OAAiJdSNRoVNad6d38WsJkmuitf
         mMVc7KhInLvTxkGQ9Y13c7iTvfmwiHtTZMSaRS5u2qu8cVMUYyfkE5NwTaNhW8INJqkG
         uEkg==
X-Gm-Message-State: ANoB5pn5VsP/DVmIDgY7Zuen/pwzSS8QUHJR5Vr47mXYEvule1AA32Y0
        5Iluv/VuZ5H66H63GqG2XIduwkF8bcmy13A/ret/9sp1KiLGYXso
X-Google-Smtp-Source: AA0mqf4Ey+s+5l8jI3qYvVeBn8nM7I7QUh+8bTEBMtc1ra/8US8uJ2wgBMg7DP97/O+NPnVsIALqABdGhJE1Hd+5H6I=
X-Received: by 2002:a63:2226:0:b0:478:54e2:ecb1 with SMTP id
 i38-20020a632226000000b0047854e2ecb1mr39520530pgi.550.1671554817603; Tue, 20
 Dec 2022 08:46:57 -0800 (PST)
MIME-Version: 1.0
References: <20221219083511.73205-1-alvaro.karsz@solid-run.com>
 <20221219083511.73205-4-alvaro.karsz@solid-run.com> <Y6HjpvDfIusAz2uS@dev-arch.thelio-3990X>
In-Reply-To: <Y6HjpvDfIusAz2uS@dev-arch.thelio-3990X>
From:   Alvaro Karsz <alvaro.karsz@solid-run.com>
Date:   Tue, 20 Dec 2022 18:46:20 +0200
Message-ID: <CAJs=3_B7WoERAiXPyvz=6d7O5rcwXMfWZJFsi_ds-OAemvfcgQ@mail.gmail.com>
Subject: Re: [PATCH 3/3 v6] virtio: vdpa: new SolidNET DPU driver.
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, bhelgaas@google.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nathan,

> This does not appear to be a false positive but what was the intent
> here? Should the local name variables increase their length or should
> the buffer length be reduced?

You're right, the local name variables and snprintf argument don't match.
Thanks for noticing.
I think that we should increase the name variables  to be
SNET_NAME_SIZE bytes long.

How should I proceed from here?
Should I create a new version for this patch, or should I fix it in a
follow up patch?

Thanks,
Alvaro
