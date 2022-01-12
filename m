Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C5148C6CC
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jan 2022 16:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354444AbiALPJv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 10:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354436AbiALPJs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jan 2022 10:09:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FCFC06173F;
        Wed, 12 Jan 2022 07:09:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C48A0B81F6B;
        Wed, 12 Jan 2022 15:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907B5C36AF4;
        Wed, 12 Jan 2022 15:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642000185;
        bh=h3fkWHCAV5x/zKoNsPAzmv82eux9e2j7e/NxPgQfh1M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JG62vFRG3wB6eOg09wBugRwH2nfjhWQ0G+KxTZhrXnBwv89TtUPwgRM80yqULqeDL
         73WtIoWuLnrBmHvX4ydu7j+b5Gsr7VDGd8F075SH+MB/R8fWspV/0sQ/l0f2MQEsMG
         24e2z+3ESDRF9sYJfcHt1as9VdMGxxpHRXWl10LuWCBQj/Nu9DSIoqDWQKVmbRQjMD
         m0MgfsPsDFn1g1EEitum3nxhz9BGJiLCQyjMaF6CazpVBrSqQbIu/c6inTQUQYHZgW
         MFLJ59oa8csaRknpHTTXiY/FJTzj+EvwA3C7Hf1YGspgZxPUOAs5EMPDRGR+K/6Yop
         6VlXxIKCy5ooA==
Received: by mail-ed1-f51.google.com with SMTP id k15so11074425edk.13;
        Wed, 12 Jan 2022 07:09:45 -0800 (PST)
X-Gm-Message-State: AOAM531H4S09Rbq6IiwmgMdHr479zKayBVWc6FaiMjBbYTq7ZBZEqxI0
        KBK0pSQIB4LyXiaCZedBFhyufWO1gmEpStRIVA==
X-Google-Smtp-Source: ABdhPJxhV+LT9DDlm1+3GiwpmO7VFy5DgD7sf7a99AA056uQov7A+ISg5Ea1HKqaqM6NQJvF4mZDcCg7lCeayFF+yAk=
X-Received: by 2002:a05:6402:4315:: with SMTP id m21mr79460edc.67.1642000183813;
 Wed, 12 Jan 2022 07:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20200722022514.1283916-20-robh@kernel.org> <20220111214608.GA169999@bhelgaas>
In-Reply-To: <20220111214608.GA169999@bhelgaas>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 12 Jan 2022 09:09:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKoK6Vewwn4X0L+TKAz-UdK4n7CQ+OKpiEwGe2HqR5L8g@mail.gmail.com>
Message-ID: <CAL_JsqKoK6Vewwn4X0L+TKAz-UdK4n7CQ+OKpiEwGe2HqR5L8g@mail.gmail.com>
Subject: Re: [PATCH 19/19] PCI: Set bridge map_irq and swizzle_irq to default functions
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 11, 2022 at 3:46 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [-cc many, +cc iproc, loongson, tegra maintainers]
>
> On Tue, Jul 21, 2020 at 08:25:14PM -0600, Rob Herring wrote:
> > The majority of DT based host drivers use the default .map_irq() and
> > .swizzle_irq() functions, so let's initialize the function pointers to
> > the default and drop setting them in the host drivers.
> >
> > Drivers like iProc which don't support legacy interrupts need to set
> > .map_irq() back to NULL.
>
> Probably a dumb question...
>
> This patch removed all the ->swizzle_irq users in drivers/pci/, which
> is great -- IIUC swizzling is specified by the PCI-to-PCI Bridge Spec,
> r1.2, sec 9.1, and should not be device-specific.  I assume the few
> remaining arch/ users (arm and alpha) are either bugs or workarounds
> for broken devices.
>
> My question is why we still have a few users of ->map_irq: loongson,
> tegra, iproc.  Shouldn't this mapping be described somehow via DT?

Tegra could perhaps be written another way. The mapping is standard,
but it's disabling an idle state when PCI interrupts are used. It just
needs some way to know if legacy interrupts are being used.

iproc looks pretty special with its bcma bus.

Adding something to DT doesn't really help because we'd still have to
support the old way.

Rob
