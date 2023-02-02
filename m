Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECBC687EAC
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 14:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjBBN3Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 08:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjBBN2k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 08:28:40 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B018FB4A
        for <linux-pci@vger.kernel.org>; Thu,  2 Feb 2023 05:28:17 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id be12so1995159edb.4
        for <linux-pci@vger.kernel.org>; Thu, 02 Feb 2023 05:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HTC38HibZXEn7Wv2s8sWxb7XNeo7IRQmKvZZDFrxcxc=;
        b=kxSF8j+IP/x+QcvUIwav/vGV3zV4kk3dq9Ofn9Zpj8u1xj/EDo25N+twGntVC4B8JY
         roYJA7/wvbESGZ5mfIrcmJfj43joP3ovk8IBWazSwOt/kQfbFQ/majoPpMEIIHv7ybhg
         cCCVFNrwHWsqTmuZQEGSY1EW8HD7v13gfntiY3+pJmIn1HhQHVDCrfKFkqsetgW/SymB
         8kB5UQCcWJvDMZXGMPXUnkBqbjxuqwMc1XcUFY+kN4ZAXwW1cw7yGqHOoqB+UmkEya1R
         ccm5GTXOgn133tv5QRsKNAfE0V8ZzQItLJJyuVIR0WB1OKLOtDoqlbdz9geOihfjkxK7
         ZTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTC38HibZXEn7Wv2s8sWxb7XNeo7IRQmKvZZDFrxcxc=;
        b=i7B4qCGSRnQM4WMMcNFhw7AY/u7I1K7HDPFVUJ9jWhX9wleHoxvEj0cLO0orkYYeVw
         q6uMYzSy8zagm4SZ1b9+bf77U76S38qJ9RxCEfls412KrVKGvfeE+NkoS0VH2t1fDUnt
         Ex4+zL1Ea90z1VZZ/RbCygMtPKLGiJxQqU4qgb2azTuMXLoxdDj//bBruGyqEu7+VdC7
         Kg+vlFwJJA+IAJwZn325zXH83XPv4U2laUjnrGmT8KLWdy6bun+GIOd78R0+M9KtZnkZ
         Vb7c9V5oVO/Cz4K7Tb6SKAS7BiXD5YnuxZyjUWQ7ossu1POl/GdUrIKI8C/txnUA5aBP
         TqDg==
X-Gm-Message-State: AO0yUKXIUkdNPINIS0lDbhpeF11ctuSebm5DHUvyBrWAFZJgucqz02Ck
        aOOq0viYAx9p7tQWg8P9ZuppvEA9/DPhxUPE3S7c3jrTrduqBGib
X-Google-Smtp-Source: AK7set+06Zl334319Ms5zHEjpXBQTjiaHLySZ1ItGk2geu600DNgORbLdTt3uA/EQeENTaWmvpsSlRKPHBE16OaBza4=
X-Received: by 2002:a05:6402:d62:b0:4a2:c40:58e4 with SMTP id
 ec34-20020a0564020d6200b004a20c4058e4mr1750853edb.7.1675344495580; Thu, 02
 Feb 2023 05:28:15 -0800 (PST)
MIME-Version: 1.0
References: <20230201043018.778499-1-chenhuacai@loongson.cn> <20230201185756.GA1882554@bhelgaas>
In-Reply-To: <20230201185756.GA1882554@bhelgaas>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 2 Feb 2023 21:28:05 +0800
Message-ID: <CAAhV-H4+A54iSA6jUH3BPm=Zf6tDezELsjCk9c=UEPCJqrvN6g@mail.gmail.com>
Subject: Re: [PATCH V4 0/2] PCI: Resolve Loongson's LS7A PCI problems
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 2, 2023 at 2:58 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Feb 01, 2023 at 12:30:16PM +0800, Huacai Chen wrote:
> > This patchset attempt to resolves Loongson's LS7A PCI problems: the
> > first patch remove pci_disable_device() in pcie_portdrv_remove() to
> > avoid poweroff/reboot failure; the second patch improves the mrrs quirk
> > for LS7A chipset;
> >
> > V1 -> V2:
> > 1, Update commit messages and comments.
> >
> > V2 -> V3:
> > 1, Simply remove pci_disable_device() in pcie_port_device_remove() to
> >    solve poweroff/reboot failure.
> > 2, Update commit messages and comments.
> >
> > V3 -> V4:
> > 1, Just remove pci_disable_device() in pcie_portdrv_shutdown() and keep
> >    pcie_portdrv_remove() be the same logic as before.
> >
> > Huacai Chen, Tiezhu Yang and Jianmin Lv(2):
> >  PCI: Omit pci_disable_device() in .shutdown().
> >  PCI: loongson: Improve the MRRS quirk for LS7A.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>
> I applied both to pci/enumeration for v6.3, thanks!
>
> I added a diagnostic message in pcie_set_readq() and reworked the
> commit logs, so take a look and make sure I didn't mess it up:
>
> https://git.kernel.org/cgit/linux/kernel/git/pci/pci.git/log/?h=pci/enumeration&id=8b3517f88ff2
OK, thanks.

Huacai
