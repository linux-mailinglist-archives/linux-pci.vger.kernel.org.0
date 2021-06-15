Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0373A3A8B17
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 23:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhFOVba (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 17:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229689AbhFOVba (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jun 2021 17:31:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07F8361078;
        Tue, 15 Jun 2021 21:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623792565;
        bh=Z8l5pyigZ4sAnWmGuyoEt4UlPIHTvZnCXuw0L/8f19g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a2814pRmpC9A/dY7FIW1TXMw+SNYEGGICYHjniea7HulIIKgftR8IWPa4cllk80KJ
         bnKFSdaFURxllZ9BqaeUwoCXTuQVadtvDiRWIQlTG554bqzN/zGLTgSsJj/7jeFZnb
         E7ydAA47Zyq274qGLkcf1ov3tzuhI6t65y6lAHOpKxRS6qt1ce9JlvSwk6E/ehP8Yg
         XfXrG47A6zNZQw2JOVJd5KhQWpqbtmYG367TdFCBXkX7X7JkbfBzbcT9OQgCt0Ijk7
         M5Jj8+K5ya3+0/J3YG+cIulZx4CIqH9CqiWEL5VomGw2CSGI07JLvTa1ftKzL4o2RI
         MHXvxCHK2grQA==
Received: by mail-ej1-f53.google.com with SMTP id gt18so75364ejc.11;
        Tue, 15 Jun 2021 14:29:24 -0700 (PDT)
X-Gm-Message-State: AOAM530GwU7zVYx79tIsjeljTQL1yQnk9iFU3oxMShHVqCMcVnLDqsCD
        dntBqdy0qGaHDLArwwS6ZKRqjmHdLHYsEq7PNg==
X-Google-Smtp-Source: ABdhPJwVoFobxS8FdlynGYavo4IkXRj2LN6HkJlOKOVRHthoC5S/usa5DZkbknsweAGrYK/QFnylIoeJu0eNrrbuMcQ=
X-Received: by 2002:a17:907:3da4:: with SMTP id he36mr1668881ejc.108.1623792563457;
 Tue, 15 Jun 2021 14:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210607112856.3499682-1-punitagrawal@gmail.com>
 <20210607112856.3499682-5-punitagrawal@gmail.com> <3105233.izSxrag8PF@diego>
In-Reply-To: <3105233.izSxrag8PF@diego>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Jun 2021 15:29:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL8iDo5sLmgNVuXs5wt3TpVJbKHfk7gE740DidmvLOwiQ@mail.gmail.com>
Message-ID: <CAL_JsqL8iDo5sLmgNVuXs5wt3TpVJbKHfk7gE740DidmvLOwiQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: rockchip: Update PCI host bridge
 window to 32-bit address memory
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Punit Agrawal <punitagrawal@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>, wqu@suse.com,
        Robin Murphy <robin.murphy@arm.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 10, 2021 at 3:50 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Montag, 7. Juni 2021, 13:28:56 CEST schrieb Punit Agrawal:
> > The PCIe host bridge on RK3399 advertises a single 64-bit memory
> > address range even though it lies entirely below 4GB.
> >
> > Previously the OF PCI range parser treated 64-bit ranges more
> > leniently (i.e., as 32-bit), but since commit 9d57e61bf723 ("of/pci:
> > Add IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses")
> > the code takes a stricter view and treats the ranges as advertised in
> > the device tree (i.e, as 64-bit).
> >
> > The change in behaviour causes failure when allocating bus addresses
> > to devices connected behind a PCI-to-PCI bridge that require
> > non-prefetchable memory ranges. The allocation failure was observed
> > for certain Samsung NVMe drives connected to RockPro64 boards.
> >
> > Update the host bridge window attributes to treat it as 32-bit address
> > memory. This fixes the allocation failure observed since commit
> > 9d57e61bf723.
> >
> > Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > Link: https://lore.kernel.org/r/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@ar=
m.com
> > Suggested-by: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> > Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Rob Herring <robh+dt@kernel.org>
>
> just for clarity, should I just pick this patch separately for 5.13-rc to
> make it easy for people using current kernel devicetrees, or should
> this wait for the update mentioned in the cover-letter response
> and should go all together through the PCI tree?

This was dropped from v4, but should still be applied IMO.

Acked-by: Rob Herring <robh@kernel.org>
