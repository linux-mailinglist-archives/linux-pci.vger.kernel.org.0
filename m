Return-Path: <linux-pci+bounces-18177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940FA9ED72E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 21:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E4C16120C
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 20:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BB81FECD6;
	Wed, 11 Dec 2024 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx2r9xO8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7373B1C4A36;
	Wed, 11 Dec 2024 20:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948651; cv=none; b=GB/367GEDqBbpNT2tklxGY/KVW/vcqbFBtfex7J7xj066NiuDc7xowC4b1Uyy89lvolXYZvKpmn3LqBzGgL8Vq+iGF0D9hvTj38vscKma8BqhWuRtqg+3ax/YswHuaNf69Q2esKXGpuweb+GGgSkPSif9tH88PWHs4cQ26ThnxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948651; c=relaxed/simple;
	bh=yOVE+KCLnL0G/rxLAXTZ9ej8maw36A8IfDnAQICINJI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hfkP/rB83YDHp4NkgCDcMnZ/Pusg2wDGjiCXrE7vbymykVwl8t3aswBHQbKrqzPQk5E9i9M8QB33VVE+l9SDvsccf62bHr8OCC2RyEWmqV3x5gqXVV6MdPZhImcA5I0acssXXtUmm3yFBWkEeBFROwOuHkRJ1gBuD+oVsLWzgtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cx2r9xO8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC91C4CED2;
	Wed, 11 Dec 2024 20:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733948651;
	bh=yOVE+KCLnL0G/rxLAXTZ9ej8maw36A8IfDnAQICINJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Cx2r9xO8BA+5R3kqdtPbHgKc0SB+T8twQUdgeeilcmsRt3ODTEfboCsRxO+qRbWA0
	 ZBgzobKuPR0r7SGnjNNQhdt9mZ0Tb4eTkBAkDrSWtbjQQhUIV3EhINgYoUK3aqV3Wi
	 OOTZgU8ulJhEWbXIpQBDymEbR1Yu5TKJhTdp6kG4yZRc1XuIZGbOKpSDx/R7QDFK1R
	 IgjhIwV96L4AsNBCw6FzNgDp3xEwi8KEbXyiENt7HHQQ0Oj0UMd+fl/VjgBUnE22qN
	 3ER2inDG3/8ORfjHmnFu5HM2TkP8f/uMKBuZN3yTh7NxCxuY1ylnhHggM8g0XRJeFX
	 bX229EITTmyGw==
Date: Wed, 11 Dec 2024 14:24:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Thomas Richard <thomas.richard@bootlin.com>, vigneshr@ti.com,
	s-vadapalli@ti.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, theo.lebrun@bootlin.com,
	thomas.petazzoni@bootlin.com, kwilczynski@kernel.org,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	gregory.clement@bootlin.com, u-kumar1@ti.com,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH] PCI: j721e: In j721e_pcie_suspend_noirq() check
 reset_gpio before to use it
Message-ID: <20241211202409.GA3305505@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211091421.4empou7mbm35ynxq@thinkpad>

[+cc GPIO folks in case they think it's worthwhile to document that
it's safe to pass NULL pointers to gpiod_*() interfaces]

On Wed, Dec 11, 2024 at 02:44:21PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Dec 11, 2024 at 09:59:30AM +0100, Thomas Richard wrote:
> > On 12/10/24 16:42, Bjorn Helgaas wrote:
> > > On Mon, Dec 09, 2024 at 12:23:21PM +0100, Thomas Richard wrote:
> > >> The reset_gpio is optional, so in j721e_pcie_suspend_noirq()
> > >> check if it is not NULL before to use it.

> > >> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > >> @@ -644,7 +644,9 @@ static int j721e_pcie_suspend_noirq(struct device *dev)
> > >>         struct j721e_pcie *pcie = dev_get_drvdata(dev);
> > >> 
> > >>         if (pcie->mode == PCI_MODE_RC) {
> > >> -               gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> > >> +               if (pcie->reset_gpio)
> > >> +                       gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> > >> +
> > >>                 clk_disable_unprepare(pcie->refclk);
> > >>         }

> > > It looks like gpiod_set_value_cansleep(desc) *should* be a no-op if
> > > desc is NULL, based on this comment [1]:
> > > 
> > >  * This descriptor validation needs to be inserted verbatim into each
> > >  * function taking a descriptor, so we need to use a preprocessor
> > >  * macro to avoid endless duplication. If the desc is NULL it is an
> > >  * optional GPIO and calls should just bail out.
> > > 
> > > and the fact that the VALIDATE_DESC_VOID() macro looks like it would
> > > return early in that case.
> > > 
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpio/gpiolib.c?id=v6.12#n2316

> Yes. Almost all of the GPIO APIs accepting desc (except few) use
> VALIDATE_DESC() to check for NULL descriptor. So explicit check is
> not needed.

I think it would be nice if the kernel-doc for these functions
mentioned this somewhere.  It's kind of a pain for every user to have
to deduce this.

Bjorn

