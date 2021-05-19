Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35F83884BE
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 04:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhESC1r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 22:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhESC1r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 22:27:47 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A58C06175F
        for <linux-pci@vger.kernel.org>; Tue, 18 May 2021 19:26:28 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z24so11511343ioi.3
        for <linux-pci@vger.kernel.org>; Tue, 18 May 2021 19:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dZRU34TEa7zPnYOaDO4MbeWNvIE7RWLVNwNVARHpVOo=;
        b=agc80B6RGq4CteuFeUrl/CufCW1qKXRoR6I60rShQk3WMSfrF4dIuCyW8gitdx+Rkp
         Pg9ZzpSaJulqlz7FdUX5VF/iry4SLbGhmHrTJ5Lacf5/SemoL73Enb4umYUukD+qjjMi
         FfeKMkBA2sC/vD0/EbNjM5qKdUpcxP/q9ERocvCk1spqx0ao4P939woJn3DlvLV0olDq
         +zNHRsdhCnlwoGaBTSA9SjJ76vVssaYokXR5Ott3C4K8zOgcJJqngj10Y6dWTJJos5vC
         54jU+o4g6AIDpx+C38qqBTCnppLhLc9U64jRSrO9hNL6C1pImMPBIm43fef73E1i9XTO
         +yEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dZRU34TEa7zPnYOaDO4MbeWNvIE7RWLVNwNVARHpVOo=;
        b=C4z8eV0vl/NXFIx31XQclNUVvQDa/QqkXckk3MT9OB2FgvWYujd+u3/kBqfQV1M7Xr
         wumBSC9oFuoiZCvaYo2L9oiRquzEMLrqn5DxMGXvI1ZzBn60SDdchD+AwqEll4aJJx7h
         UxEg1XAHIzpGGimVy5lhsw0SDyvsjxY19kp0NNlXKgYMBNPUS7SlniURzYOQOn3ADjZ8
         dXZJQMPeZX4ygYwwhBFNAt3F6li7V5KNl9OQOFkNJEw/eoioLYM3tNcN2CQ6mTCkn+bR
         IXH1HYrZ4wAwAvIMNkgTIP+a/MEnphiMaSJ+JaCJa8g1ID/Jsna2p2Y1CCo/ZZHOJjf5
         u1Uw==
X-Gm-Message-State: AOAM532Xwp29BkbL1p6Bhee9zTbuqUB24B7+GRlwb3ouEW9ljE4kwaNE
        bsJOmMFb8UxiFggP8iG7x3CTL/OtHdaFuUg3cD9/aJf5Rb0=
X-Google-Smtp-Source: ABdhPJyuWCMhHBNA4h9Xzz3A9envR8YpIDpTB/ZPbgJ2NXdqdzmLyvTQ9J9gw72pyfwm2Ivs9TPJrCrHxRC3EOZpdO4=
X-Received: by 2002:a05:6638:3827:: with SMTP id i39mr9722974jav.96.1621391187790;
 Tue, 18 May 2021 19:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H61Uc5D7+1pMR5xSJeBVXHwPttTtaPg6_gwJoYBywHjPA@mail.gmail.com>
 <20210518135925.GA116106@bjorn-Precision-5520>
In-Reply-To: <20210518135925.GA116106@bjorn-Precision-5520>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Wed, 19 May 2021 10:26:16 +0800
Message-ID: <CAAhV-H7DfZffubU_rxoMXdbk_j9p0LwA5S7wF7qvAPOJn=YEdw@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI: Add quirk for multifunction devices of LS7A
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjorn,

On Tue, May 18, 2021 at 9:59 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rob, beginning of thread
> https://lore.kernel.org/r/20210514080025.1828197-5-chenhuacai@loongson.cn=
]
>
> On Sat, May 15, 2021 at 11:52:53AM +0800, Huacai Chen wrote:
> > On Fri, May 14, 2021 at 10:52 PM Jiaxun Yang <jiaxun.yang@flygoat.com> =
wrote:
> > > =E5=9C=A8 2021/5/14 16:00, Huacai Chen =E5=86=99=E9=81=93:
> > > > From: Jianmin Lv <lvjianmin@loongson.cn>
> > > >
> > > > In LS7A, multifunction device use same pci PIN and different
> > > > irq for different function, so fix it for standard pci PIN
> > > > usage.
> > >
> > > Hmm, I'm unsure about this change.
> > > The PCIe port, or PCI-to-PCI bridge on LS7A only have a single
> > > upstream interrupt specified in DeviceTree, how can this quirk
> > > work?
> >
> > LS7A will be shared by MIPS-based Loongson and LoongArch-based
> > Loongson, LoongArch use ACPI rather than FDT, so this quirk is needed.
>
> Can you expand on this a little bit?
>
> Which DT binding are you referring to?  Is it in the Linux source
> tree?
I referring to arch/mips/boot/dts/loongson/ls7a-pch.dtsi, it is
already in Linux source tree.

>
> I think Linux reads Interrupt Pin for both FDT and ACPI systems, and
> apparently that register contains the same value for all functions of
> this multi-function device.
>
> The quirk will be applied for both FDT and ACPI systems, but it sounds
> like you're saying this is needed *because* LoongArch uses ACPI.
Jiaxun said that FDT system doesn't need this quirk, maybe he know more.

Huacai
>
> Bjorn
