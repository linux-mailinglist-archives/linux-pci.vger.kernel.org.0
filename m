Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A4238E8D3
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 16:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhEXOi0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 10:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232662AbhEXOi0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 May 2021 10:38:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AFDE6113B;
        Mon, 24 May 2021 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621867018;
        bh=7T5VX2eQcaYMrUtpjWz5Rw7UAowD4vaCkcvMGSv9CLY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lYQYVFCL8VKYYj+I7P5lXR/fEWcKfESZSYswCk6cBqi2dVqV4FDeJ01CaPmYR0c5p
         475s+QM2SYE06LeHVprIlr/bmRwkPz55tk9npPU3WcKSezVxcl7/Xezyia8NEt5tVB
         +Xne0S/GIk+n0H7BgpVU83wrUMObmMXOvDCJBHtSO7SB7Ui9+nLP0M35+fQH/iSQBI
         SO2UvJ8/ljhSqTYKyaTeo9o63VBErtNr/azqKvzXoq0S7m0Bfe1mUwPI4uSwkbh9ze
         FmUGXl80AU48ijvowJbmCAxSmUlC/1cromjnyX0bSVuLuHDlRnXMiUUeqEv/FUjmMc
         Va3JCe1EynV2g==
Date:   Mon, 24 May 2021 16:36:51 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/42] PCI: aardvark: Change name of INTx irq_chip to
 advk-INT
Message-ID: <20210524163651.430e5497@thinkpad>
In-Reply-To: <87im3uq5bx.wl-maz@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
        <20210506153153.30454-16-pali@kernel.org>
        <87im3uq5bx.wl-maz@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 07 May 2021 10:08:18 +0100
Marc Zyngier <maz@kernel.org> wrote:

> On Thu, 06 May 2021 16:31:26 +0100,
> Pali Roh=C3=A1r <pali@kernel.org> wrote:
> >=20
> > This name is visible in /proc/interrupts file and for better reading it
> > should have at most 8 characters. Also there is no need to allocate this
> > name dynamically, since there is only one PCIe controller on Armada 37x=
x.
> > This aligns with how the MSI irq_chip in this driver names it's interru=
pt
> > ("advk-MSI"). =20
>=20
> And *because* the name is visible in /proc/interrupts, it has become
> an ABI, and cannot be changed anymore.
>=20
> We had the exact same issue with Tegra this merge window as I
> accidentally changed "Tegra" to "tegra", resulting in userspace
> programs failing find stuff in /proc/interrupts.
>=20
> Please keep the name as is, no matter how ugly it is.

Hmm, I am 99% sure that for the A3720 platform this ABI change would not
affect anybody. And it does make the driver's irq names confusing.
Can't we really do anything here?

Note that there were suggestions from some people to completely remove
this driver due to the many problems it has which Pali is trying to
solve. But if the driver was removed and then later introduced again
without these problems, the new version would use the "advk-INT" IRQ
name...

Marek
