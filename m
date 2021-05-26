Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99758392156
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 22:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhEZUUc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 16:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbhEZUUc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 16:20:32 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA91C061574
        for <linux-pci@vger.kernel.org>; Wed, 26 May 2021 13:18:59 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id f9so3865317ybo.6
        for <linux-pci@vger.kernel.org>; Wed, 26 May 2021 13:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O0Ka4vBpdAyBWG8p8PcO/rjMwhjvUsXlTA1ts+xUeXQ=;
        b=lhiT/wAQpaU17DcX8sLxSf/H5gZKylSp3iz+OTJw4vaXVWrk/85EubveBZ1o/mm+Mr
         nDIR2Iw3BhSER8FZSPs3TkAsSpgEqlB+cVc6RqDBXxy3njg4zKZFYqMpWs2hp31QJ/KN
         h7VhDOBKS88RgJwl63pJ8iZX/SefPscfvaCd71FaL3cew/moQefAKPO1ArmR/eozDiOG
         htR8oTVk3bMHutK2ec3QkPkzipkgDmK6PvyMQH3M/ey1JsmKJA988dqj83iPcdjfTzGR
         e3qvB74G8K89jYNbts3iGBR13uo+gwm8ex46n63lijPkTE0aQFeh8hEUBrjuz8MfWoLr
         Kohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O0Ka4vBpdAyBWG8p8PcO/rjMwhjvUsXlTA1ts+xUeXQ=;
        b=KJ0K9YGYrjtRwW7y2bV5Ov4pCxaKBsfMsaQURJRmYuxCL2KDHV1P5F6vBxLy15azl7
         J53LDkhF7ioauAh89I0mEsAh5U1t/AU86YRDu8z6ETSVRepf13j6EjxxbxtYEkB5mpC8
         Ccfuv9WrY7ME4O7FoZNYWK9ASzNzzQAHzkpw91CC7dbODc+qlRyMrgs1WSswfFjKAnLe
         Ok2szMW/lqv1cIkUouNl1ywFE5BxzncaPNmevwWhk37LZSpyJQNypO/TKAYbVIDPmIbB
         U0IXCZYCaSz/MhrDyWXHlTg2c/r1Ll7EHZiFM9YKe5qBU0n5hu2yoji30X/1m0e2MXR+
         3p1Q==
X-Gm-Message-State: AOAM530Lxr4J9kLgQu2xvCxND45Ow32nD5yrJFxgc2V7BqciZ/HwJBVe
        QldEWzxGxcma594Rnycy6RUdRrUoTK3e1055gCUxzwNBIwo=
X-Google-Smtp-Source: ABdhPJxIy7DPGux6JC6GejgNMpeDZZc1iQbKluGiAvpRAxutBjFV8k2r7A1KKToWGiwXMexs4JZU34/D7kpN87m4ld4=
X-Received: by 2002:a25:4f05:: with SMTP id d5mr51533969ybb.473.1622060339198;
 Wed, 26 May 2021 13:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210520120055.jl7vkqanv7wzeipq@pali> <CABLWAfQbKy=fpaY6J=gqtJy5L+pqNeqwU6qkVswYaWnVjiwAHw@mail.gmail.com>
 <20210520140529.rczoz3npjoadzfqc@pali> <CABLWAfSct8Kn1etyJtZhFc5A33thE-s6=Cz-Gd6+j04S4pfD_A@mail.gmail.com>
 <4e972ecb-43df-639f-052d-8d1518bae9c0@broadcom.com> <87pmxgwh7o.wl-maz@kernel.org>
 <13a7e409-646d-40a7-17a0-4e4be011efb2@broadcom.com> <874keqvsf2.wl-maz@kernel.org>
 <964cc65e-5c44-8d29-9c08-013a64a5c6fd@broadcom.com>
In-Reply-To: <964cc65e-5c44-8d29-9c08-013a64a5c6fd@broadcom.com>
From:   Sandor Bodo-Merle <sbodomerle@gmail.com>
Date:   Wed, 26 May 2021 22:18:47 +0200
Message-ID: <CABLWAfR1SFoDUWQtvSOohvT36YeDQLpJ-B40cE_4vMbWKsarFw@mail.gmail.com>
Subject: Re: pcie-iproc-msi.c: Bug in Multi-MSI support?
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 26, 2021 at 7:34 PM Ray Jui <ray.jui@broadcom.com> wrote:
>
>
> Here's the thing. All Broadcom ARMv8 based SoCs have migrated to use
> either gicv2m or gicv3-its for MSI/MSIX support. The platforms that
> still use iProc event queue based MSI are only legacy ARMv7 based
> platforms. Out of them:
>
> NSP - dual core
> Cygnus - single core
> HR2 - single core
>
> So based on this, it seems to me that it still makes sense to allow
> multi-msi to be supported on single core platforms, and Sandor's company
> seems to need such support in their particular use case. Sandor, can you
> confirm?

Right - we are using it in production on legacy ARMv7 SOCs.

>
>
> Thanks. This makes sense. And it looks like this can be addressed
> separately from the above issue. I'll have to allocate time to work on
> this. In addition, I'd also need someone else with the NSP dual-core
> platform to test it for me since we don't have these legacy platforms in
> our office anymore.
>

I will be able to test patches on the XGS Katana2 SOC - which is dual core.
