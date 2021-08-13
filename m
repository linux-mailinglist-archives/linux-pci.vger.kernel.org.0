Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8902C3EB99E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Aug 2021 17:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241152AbhHMP60 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Aug 2021 11:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241089AbhHMP60 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Aug 2021 11:58:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6508761038;
        Fri, 13 Aug 2021 15:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628870279;
        bh=pY+Zqp963icDROpevltpSJJAR69cOdOt+bXbLF0MeIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NBua0hL2wLvzxP6HrYAvZnxiNgtH4qsQqRY6RucoaV7bNIS/7dzMoUHHjb2iLJ4OS
         xNZl8EbVd5kAqWkX0zJFXWaGY8rjdbMYiwVC685ry27Lcj4KcPUGHAG6G8wnoDvLYa
         ngdXRpRLpez9PUgtoaBukuaM/WSKQcrL0b36AKjL+hRQwBrroz1ACQuz4Mm4OaQtbH
         kgLJCeMPxoMDK2u52+Eh1YxwH4YhyID5KZUwF8HetYYzXF9TBDkdQm4Qx8PxPZY6u9
         hr3VmYb0MLDDbN7/7ar4kcaNgR51zp+yHVL5yBzWzjNsvNysmxXbiVfqIh/TJbL2FK
         CJv51K4HL2zeg==
Received: by mail-ed1-f50.google.com with SMTP id z11so16062356edb.11;
        Fri, 13 Aug 2021 08:57:59 -0700 (PDT)
X-Gm-Message-State: AOAM5311YqH1CqjJSKd95O/JgGGpCGbD8w2puZ5AfydxnaDtDqtmncH8
        NjKYGY0beY1vVQadUnakJsMI/GEx+F5sn0lwvw==
X-Google-Smtp-Source: ABdhPJzGb/GgbXDVHZTmqzulqvJERz/jWWIhITrpEQe00RTcREbvrBDSwmoXTlx2OUnRARI/JvACJ/JQOgQrTZnANvc=
X-Received: by 2002:aa7:cb19:: with SMTP id s25mr4083549edt.194.1628870276974;
 Fri, 13 Aug 2021 08:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210813113338.GA30697@kili> <01b7c3da-1c58-c1d9-6a54-0ce30ca76097@arm.com>
 <CAL_JsqJ4Dadf00pJxEDd14zbWyN99s1A2L4fxZSkZddeg2pV6g@mail.gmail.com> <81b9a25d-f12f-90e0-0b05-b5e396f14c08@arm.com>
In-Reply-To: <81b9a25d-f12f-90e0-0b05-b5e396f14c08@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 13 Aug 2021 10:57:44 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLWVLRDdkR62BSv69oW3QCLVebgpU1TKtxvzZmD4wuP4Q@mail.gmail.com>
Message-ID: <CAL_JsqLWVLRDdkR62BSv69oW3QCLVebgpU1TKtxvzZmD4wuP4Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: rockchip-dwc: Potential error pointer dereference in probe
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Simon Xue <xxm@rock-chips.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 13, 2021 at 8:47 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-08-13 14:34, Rob Herring wrote:
> > On Fri, Aug 13, 2021 at 7:55 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 2021-08-13 12:33, Dan Carpenter wrote:
> >>> If devm_regulator_get_optional() returns an error pointer, then we
> >>> should return it to the user.  The current code makes an exception
> >>> for -ENODEV that will result in an error pointer dereference on the
> >>> next line when it calls regulator_enable().  Remove the exception.
> >>
> >> Doesn't this break the apparent intent of the regulator being optional,
> >> though?
> >
> > I'm pretty sure 'optional' means ENODEV is never returned. So there
> > wasn't any real problem, but the check was unnecessary.
>
> In fact it's the other way round - "optional" in this case is for when
> the supply may legitimately not exist so the driver may or may not need
> to handle it, so it can return -ENODEV if a regulator isn't described by
> firmware. A non-optional regulator is assumed to represent a necessary
> supply, so if there's nothing described by firmware you get the (valid)
> dummy regulator back.

Ah yes, regulators is the oddball. Surely no one else will assume the
same behavior of _optional() variants across subsystems... ;)
