Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2209F4028A5
	for <lists+linux-pci@lfdr.de>; Tue,  7 Sep 2021 14:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344049AbhIGMWT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Sep 2021 08:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344515AbhIGMVy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Sep 2021 08:21:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01B8060F45;
        Tue,  7 Sep 2021 12:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631017248;
        bh=Y8xoyYNHQT9hL1aC3E66re6pRQOGIaA/FYV2Jm5dkZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dS4YHtbOLThghB2ymsHInAGdLC6u6g2NinLze9FqN/20AQWb3EaYk9gO8pRVAcNc3
         JfsL30fLR5w32a9n7mtThT0NP5UZcP0aeLGmmkYTkUeoHKvRHLFxrucBxrvd8wJ2MG
         7h9yeIjC5rkcrqz8lVVMZLb9OsTgzgOGj1fjQb53U1vkeVEVabkjahtRfrf3yjE+sT
         J02FP9f+FEJ/fMBhGQawS14pv/+0vSTC5fe8HbHKk6hy4TlGI69la3Po5gbgAkha97
         FKg8PD1sWyqY0asTB+kH9woDXIA9LBKG5k7rMqdZWIedbclC1VKnbQxr1xO6VhbH9t
         pCln3tQHyCd/w==
Received: by pali.im (Postfix)
        id A31D57FB; Tue,  7 Sep 2021 14:20:45 +0200 (CEST)
Date:   Tue, 7 Sep 2021 14:20:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pci-ftpci100: race condition in masking/unmasking interrupts
Message-ID: <20210907122045.x6jyanqaf43rasnq@pali>
References: <20210818114743.kksb7tydqjkww67h@pali>
 <CACRpkdYe-Y-1YstovrJd7b8iNCDeX312mB4gLGcG1y6dE6di=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYe-Y-1YstovrJd7b8iNCDeX312mB4gLGcG1y6dE6di=A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 07 September 2021 13:22:37 Linus Walleij wrote:
> On Wed, Aug 18, 2021 at 1:47 PM Pali Rohár <pali@kernel.org> wrote:
> 
> > I do not see any entry in MAINTAINERS file for pci-ftpci100.c driver, so
> > I'm not sure to whom should I address this issue...
> 
> It's me.

Ok! So could you send update for MAINTAINERS file for this driver?

> > During pci-aardvark review, Marc pointed one issue which is currently
> > available also in pci-ftpci100.c driver.
> >
> > When masking or unmasking interrupts there is read-modify-write sequence
> > for FARADAY_PCI_CTRL2 register without any locking and is not atomic:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pci-ftpci100.c?h=v5.13#n270
> >
> > So there is race condition when masking/unmasking more interrupts at the
> > same time.
> 
> I thought those operations were called in atomic context.

I guess that they cannot be as for performance reasons you could want to
mask or unmask more interrupts in parallel on more CPUs.

> How did you fix it?

Guarding all read-modify-write operations on register by raw spin lock. See:
https://lore.kernel.org/linux-pci/20210820155020.3000-1-pali@kernel.org/
