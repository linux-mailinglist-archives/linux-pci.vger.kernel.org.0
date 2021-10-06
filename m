Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08704237BA
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 07:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhJFF6I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Oct 2021 01:58:08 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:35597 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbhJFF6I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Oct 2021 01:58:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HPNx844mYz4xR9;
        Wed,  6 Oct 2021 16:56:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1633499775;
        bh=yAmQoNe4QQh6i00NhuH34dqGowIW44cpaMTI9W4YrSU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hfVgrO7IF1qsS481zscMUiiK48SJzKENC+N3Ctiddk8MqqpJwPzIuFdUjBfq7Xm3v
         /gnsvRiospeRnRfb8N076aAlV/UeoXUK56yAV6cm/Dl+Dqp4yErjZNvwYxop/rk8o6
         6dXxyNH42jyYrIFFSY6E5BL3ercij5batzZN+L2XKaQ988U4LYykffnL/j9+8Agw/p
         ZdSXjbcUg5zc0oB3qcIDZIM6QjkEykPilZyoJ1d4zRKIsOvKWTjxdth5BPcZg+mv/J
         gqmVR9AoPsNHAZUhxlhfIsIB0+nhee8rOgyR44bVrDaUw+3okL07EmxboIbVD2/mYe
         41sqv6HoKV8Tw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
        opensuse-ppc@opensuse.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v5 00/14] PCI: Add support for Apple M1
In-Reply-To: <CACRpkdaL=YEfqSmAogLcP0Gn2gUqSaEXZQrJD1GR5QU+DyuyDQ@mail.gmail.com>
References: <20210929163847.2807812-1-maz@kernel.org>
 <20211004083845.GA22336@lpieralisi>
 <CAL_Jsq+4FF9QYy87aYhJ-AS78qyHp0NkLrL492+WmdyWj-NKaw@mail.gmail.com>
 <CACRpkdaL=YEfqSmAogLcP0Gn2gUqSaEXZQrJD1GR5QU+DyuyDQ@mail.gmail.com>
Date:   Wed, 06 Oct 2021 16:56:07 +1100
Message-ID: <87o882ofwo.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Linus Walleij <linus.walleij@linaro.org> writes:
> On Mon, Oct 4, 2021 at 9:52 PM Rob Herring <robh+dt@kernel.org> wrote:
>
>> FYI, I pushed patches 1-3 to kernelCI and didn't see any regressions.
>> I am a bit worried about changes to the DT interrupt parsing and
>> ancient platforms (such as PowerMacs). Most likely there wouldn't be
>> any report until -rc1 or months later on those old systems.
>
> Lets page the PPC lists to see if someone can test on some powermac.

It boots and everything seems fine on an iMac-G5 of mine.

I don't have access to any other powermac hardware at the moment due to
the lockdown here.

cheers
