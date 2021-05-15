Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4DD38159C
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 05:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhEODyS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 23:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhEODyR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 23:54:17 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ACEC06174A
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 20:53:05 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z24so746824ioi.3
        for <linux-pci@vger.kernel.org>; Fri, 14 May 2021 20:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uAD8A8lJr0vikjTZM2e6FXBQPhrCKjkuOem0eNrnPxo=;
        b=R3dzyvVurP/xZbglYFdMh3Y4T17tKqg/JeKme7w09LC6cjnESFQGN4+Tzx5hnIkoj7
         h7ElRUM8auBPbdTPc28jew8tHAPCOgRI6r7rpAc20VcsNx7nDPKhe2wUEdRqVk9Tg/dt
         S5cNSzkpvMPY+Ou6HNidUwZGDnXnfMeXUnZLSLLyCNsRb6Ag97V/PJXrMS7Umf2wwo45
         x12hew4DmpaWs5+62KGxNxkpqa9Jheez7gR3My0GEd/paRa2TsRjc6SnmMxLNF5fr1Zy
         FxioLkwLiSKxVzpE3mpj2SxNNiyve22HIhSwiF9s9lL+qY9nPqwtJHlyKoKKLL4PzePY
         yMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uAD8A8lJr0vikjTZM2e6FXBQPhrCKjkuOem0eNrnPxo=;
        b=eOr9j1UzuiT6cDEWnSsLJjz2YD9T1dZHpLQDmuRTItVS7wcg0KQCPpGf4COWk0f3zI
         b/6ajaOzJEthL+vaOF0ek0ynknvbHopcmcVMfIOk2LyDL4jOsORWs1Z00mZMW7YHxB8v
         reYLMAv6I3RNNTS8W53+xhEam1dJ4Tbd6bcJURAXBHiMPR0+Dftn65LUpjPnTdy8OKN1
         9z4d7K46xUwLv5XyjL89ISo1Z1sfXQvt2NW9qERw2A3dFqGwqEaomNpCQleq0NY/5htP
         Juxx356wzIm9ttVuOZ5hBoFJyf7S+byD/4OzFmLEj9gMLy/tP1f+xQsjD1+pDZ1nzIDn
         oQLw==
X-Gm-Message-State: AOAM531HQyyoFYZwh7jMyJ7GDA98ImRWbTUVf651uC5ZqIhnJhwIHyot
        hgKDzQrujd/FfwelLAUrKcWfjDpGImlqRhIEVt0=
X-Google-Smtp-Source: ABdhPJyylNtwgQ3N7Q00Qcm7/DpC0U9TmtObGJtAcD3YyH6qbmTwwyzYP1WUcNckga5VnwbBKg2J2c3JTTYyr+x3cKM=
X-Received: by 2002:a02:cb0c:: with SMTP id j12mr45382266jap.92.1621050784890;
 Fri, 14 May 2021 20:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210514080025.1828197-1-chenhuacai@loongson.cn>
 <20210514080025.1828197-5-chenhuacai@loongson.cn> <c3de05bd-91c9-dcd7-5b9a-87de91e480bf@flygoat.com>
In-Reply-To: <c3de05bd-91c9-dcd7-5b9a-87de91e480bf@flygoat.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sat, 15 May 2021 11:52:53 +0800
Message-ID: <CAAhV-H61Uc5D7+1pMR5xSJeBVXHwPttTtaPg6_gwJoYBywHjPA@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI: Add quirk for multifunction devices of LS7A
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Jiaxun,

On Fri, May 14, 2021 at 10:52 PM Jiaxun Yang <jiaxun.yang@flygoat.com> wrot=
e:
>
>
>
> =E5=9C=A8 2021/5/14 16:00, Huacai Chen =E5=86=99=E9=81=93:
> > From: Jianmin Lv <lvjianmin@loongson.cn>
> >
> > In LS7A, multifunction device use same pci PIN and different
> > irq for different function, so fix it for standard pci PIN
> > usage.
>
> Hmm, I'm unsure about this change.
> The PCIe port, or PCI-to-PCI bridge on LS7A only have a single
> upstream interrupt specified in DeviceTree, how can this quirk
> work?
LS7A will be shared by MIPS-based Loongson and LoongArch-based
Loongson, LoongArch use ACPI rather than FDT, so this quirk is needed.

Huacai
>
> Thanks.
>
> - Jiaxun
>
> >
> > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
>
