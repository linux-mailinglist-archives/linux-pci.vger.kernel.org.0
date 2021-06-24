Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D3B3B39C7
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 01:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbhFXXhM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 19:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhFXXhL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 19:37:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D13836137D;
        Thu, 24 Jun 2021 23:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624577692;
        bh=cFcIRSs+l1wpkVLSYjkwgNxYxHAbpyjM6dC702Ch3+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R57W2wJgiu7M5tjbORxxmFZF8SVr1VmX//sWX4FdBJ7N2wdqBLQNXOCR7wm4NRvFF
         M4bO2zCBN4v5TlCb49ZuqpbG6KI0c6XGqq9F1EBhgE7kqoB/iilybz7AxIOYUKTErG
         OYwLMC41L0hlxjof72PR/iA2cPpWpx2KMUwZ4kIj1i0VxUGWkuz1K8AEKWvp9SrbUR
         +6TYwSMmsraBuk5UFHzmhOfcTfTI1i9HpWanxGJRMNyeenKkyRRxFEvh7p8Z2BBi8H
         m4wdzByWeeacE75cVlju8tlaWfoZfBDgBvUey4vHHh0/Th0N38RtOKDXyB1a/bd3CJ
         V1nQcJvl/YIIw==
Received: by pali.im (Postfix)
        id 0A3BB8A3; Fri, 25 Jun 2021 01:34:48 +0200 (CEST)
Date:   Fri, 25 Jun 2021 01:34:48 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2] PCI: dra7xx: Fix reset behaviour
Message-ID: <20210624233448.ouvczfbogmtnbrye@pali>
References: <20210622115604.GA25503@lpieralisi>
 <20210622121649.ouiaecdvwutgdyy5@pali>
 <18a104a9-2cb8-7535-a5b2-f5f049adff47@lucaceresoli.net>
 <4d4c0d4d-41b4-4756-5189-bffa15f88406@ti.com>
 <20210622205220.ypu22tuxhpdn2jwz@pali>
 <2873969e-ac56-a41f-0cc9-38e387542aa1@lucaceresoli.net>
 <20210622211901.ikulpy32d6qlr4yw@pali>
 <588741e4-b085-8ae2-3311-27037c040a57@lucaceresoli.net>
 <20210622222328.3lfgkrhsdy6izedv@pali>
 <CACRpkdai2cvoNFR8yH2MHP+R27nQm1HZNK4-mJ50mE7DHrBmXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdai2cvoNFR8yH2MHP+R27nQm1HZNK4-mJ50mE7DHrBmXw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 25 June 2021 01:18:43 Linus Walleij wrote:
> On Wed, Jun 23, 2021 at 12:23 AM Pali Rohár <pali@kernel.org> wrote:
> 
> > Lorenzo asked a good question how GPIO drives PERST#. And maybe it would
> > be a good idea to unify all pci controller drivers to use same GPIO
> > value for asserting PERST# pin. If it is possible. As we can see it is a
> > big mess.
> >
> > Personally I would like to a see two helper functions like
> >
> >   void pcie_assert_perst(struct gpio_desc *gpio);
> >   void pcie_deassert_perst(struct gpio_desc *gpio);
> >
> > which pci controller driver will use and we will not more handle active
> > high / low state or polarity inversion and meditate if gpio set to zero
> > means assert or de-assert.
> 
> GPIO descriptors (as are used in this driver) are supposed to hide
> and encapsulate polarity inversion so:
> 
> gpiod_set_value(gpiod, 1) == assert the line
> gpiod_set_value(gpiod, 0) == de-assert the line

Problem is that some pci controller drivers (e.g. pci-j721e.c or
pcie-rockchip-host.c) expects that gpiod_set_value_cansleep(gpiod, 1)
de-asserts the line and it is already used in this way.

Which is opposite of the behavior which you wrote above.

> Whether the line is asserted by physically driving the line low or
> high should not be a concern, that is handled in the machine
> description, we support OF, ACPI and even board files to
> define this.
> 
> I would use gpiod_set_value() directly as above and maybe
> add some comments explaining what is going on and that
> the resulting polarity inversion is handled inside gpiolib.
> 
> Because of common misunderstandings we have pondered to just
> search/replace the last argument of gpiod_set_value() from
> an (int value) to a (bool asserted) to make things clear.
> I just never get around to do that.

I would suggest to define enum/macro with word ASSERT and DEASSERT in
its name instead of just true/false boolean or 0/1 int.

In case of this PERST# misunderstanding, having assert/deassert in name
should really help.

> 
> Yours,
> Linus Walleij
