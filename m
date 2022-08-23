Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE4B59EB3E
	for <lists+linux-pci@lfdr.de>; Tue, 23 Aug 2022 20:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiHWSlj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Aug 2022 14:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiHWSlN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Aug 2022 14:41:13 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7335F11826C
        for <linux-pci@vger.kernel.org>; Tue, 23 Aug 2022 10:04:16 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id p123-20020a4a4881000000b0043cd86b5434so2531755ooa.8
        for <linux-pci@vger.kernel.org>; Tue, 23 Aug 2022 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TUg/MW+5uwqkPY+MLc70krjM60VBeEeGCfnySwldiwg=;
        b=Yy1D2HftO+eOzV0Ic0suR8nmcNMTHLyik3FZY7MaTj4OFyv37SMhw+ej0wDA23ngLK
         CwPEql8zfjyGvUi1VFcpICjJgqQarDgcFZR9hRz3/yVobuA7vkCOixudjUYpUjO9hnyc
         VKoQIrnb47IwnDpZQRCOJ1H9GsWAFI62J/s+A9N+K7W4VLtyIV/px6P4JE1a83SnvVcY
         /MmLgVj3fmUHPZnUiV3DQgvCSIAWGOWJ7gSZJ4CidRmYHVPEjauK54QtR5J0fE18VFKt
         MBigCSfySQ4qcEKE9R4EMOLNaN2pbepP4uwpqVN+hsX+v6ihxoD3KNc5HX3dgdLm+Ko9
         XKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TUg/MW+5uwqkPY+MLc70krjM60VBeEeGCfnySwldiwg=;
        b=5lvKrTUUH2Al0PWr5MtnNRBGMfYAYjGcj+R1amHkI/qQ/7CLPBMa8MBQelwSBVw0RV
         04ttzO39MTBGOoqWHdJ+A262uEhJVa0S5pqcBqK3MdYsKb50ZvCfzCk0t9o5OEh4++RW
         EBz1bDCGgTum/LJGmk3YfEGFxAfweNfStQiCNT4t5gyAxsC9giezFHzr9GZn3T7MIsTU
         JzcocFhGixPYT4+4OK5bkqc0mW37iDnEPFb4KmqbnhfWPnX+Dn+oJbGyOauxxAqZSRrV
         WV1wL/78FYtY+J0F9usogEbYz6qCKhJrrXfmbE8NjGtGCqTHbwjK8tT/Ms/KmEHdqdFj
         5tgw==
X-Gm-Message-State: ACgBeo3nQTkjpv8ZochEVzvmQNK2hqx2wc3cOE9OXpUHUBIqARUFCn+S
        CZHEH96L1pMieQs9WV3bmYfTVdcKust2ueqPPVbz6HN6Y2sKCg==
X-Google-Smtp-Source: AA6agR6XgQsau2DY6uzmKYWsDA7bVUlGQKf7jxT6ApzcWlbpOaCrokpE4iUclQ4NqT06TmpMl49uQQYc0O0JgDYZNgg=
X-Received: by 2002:a4a:b607:0:b0:44a:f4e7:4808 with SMTP id
 z7-20020a4ab607000000b0044af4e74808mr8239529oon.37.1661274255415; Tue, 23 Aug
 2022 10:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220819190725.GA2499154@bhelgaas> <6aad506b-5324-649e-9700-7ceaaf7ef94b@amd.com>
In-Reply-To: <6aad506b-5324-649e-9700-7ceaaf7ef94b@amd.com>
From:   Tom Seewald <tseewald@gmail.com>
Date:   Tue, 23 Aug 2022 12:04:04 -0500
Message-ID: <CAARYdbhVwD1m1rAzbR=K60O=_A3wFsb1ya=zRV_bmF8s3Kb02A@mail.gmail.com>
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
To:     "Lazar, Lijo" <lijo.lazar@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, regressions@lists.linux.dev,
        David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
        Xinhui Pan <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Stefan Roese <sr@denx.de>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 20, 2022 at 2:53 AM Lazar, Lijo <lijo.lazar@amd.com> wrote:
>
> Missed the remap part, the offset is here -
>
> https://elixir.bootlin.com/linux/v6.0-rc1/source/drivers/gpu/drm/amd/amdgpu/nv.c#L680
>
>
> The trace is coming from *_flush_hdp.
>
> You may also check if *_remap_hdp_registers() is getting called. It is
> done in nbio_vx_y files, most likely this one for your device -
> https://elixir.bootlin.com/linux/v6.0-rc1/source/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c#L68
>
> Thanks,
> Lijo

Hi Lijo,

I would be happy to test any patches that you think would shed some
light on this.
