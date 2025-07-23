Return-Path: <linux-pci+bounces-32845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EDAB0FBFB
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 23:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E764A54752F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 21:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15282367A0;
	Wed, 23 Jul 2025 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gqi24Ydz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C420617C91;
	Wed, 23 Jul 2025 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753304875; cv=none; b=AYmoRxLkU9UcHUELgUNhouHW2HSIrHaXhu26FlK2ljlCMc8CAiqWzqpmUcU9r8k2BYPvasskC/RTw+ywvgCw8ldXGB9M5Y4+otMy+7XemmptdaIGJfbjY2mUUMIsOQzPUYbvZdSot9engkQ+rplIG9zJId5FVilJQPP3D2R4+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753304875; c=relaxed/simple;
	bh=hGZi/sGJfyKViWvaeWB9IxwYAFMpegznJ3FoUdmRua4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KEoXcSIMKzOv2H1B4W/imK0vlQM2P45MGdxl6Nk8haU5lX4U0IMdjyt8RRm8X6kwGzyAHyZLsb3NXcCHUogw/euRk0GxTeidtsCG3Gsxt6IFBro1sb9uTG8sBsHDujTnMJDALRztjK+y690ti81izGz0l8OlXtiRaI3Q+H+iIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gqi24Ydz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FF4C4CEE7;
	Wed, 23 Jul 2025 21:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753304875;
	bh=hGZi/sGJfyKViWvaeWB9IxwYAFMpegznJ3FoUdmRua4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Gqi24YdzNvYMSEIuuWnPsO3qvZPiXiuqNjVcRfI3ca+QDOlIcQVctCxQVwASMg5RX
	 kKSN+++vsYRtkShZ2jIn7n9mnmWan0sWyf9+j+FcP1OtPuxskwkhbcBrudkhSfoBKM
	 MwmwBIod8AjBdQ/hY1VSFZgckrvCYWKj/O2in06m0I/WanJYb1r1IR60YOAcAziIdW
	 QYWA/wf2slXq8an5oX99umRK55OTSZfqqlK7svVQ7zZjSWH1qmRk8TZE8MxVKrW29C
	 cWzdu9fXmeqRxFHvDhtl27/CeRoyfGjJNhBAnXRLQMGg+xL3G10u4SszsT4uTcCqVc
	 G6X77xbTuvtGQ==
Date: Wed, 23 Jul 2025 16:07:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Christian Bruel <christian.bruel@foss.st.com>, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, linux-pci@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [RESEND PATCH 0/2] Add pinctrl_pm_select_init_state helper
 function
Message-ID: <20250723210753.GA2911683@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZHw8am05Qcjp7FJyo7D7bZcvzZKVjdB7BUCq3FuQCy8A@mail.gmail.com>

On Wed, Jul 23, 2025 at 01:32:52PM +0200, Linus Walleij wrote:
> On Thu, Jul 17, 2025 at 8:33 AM Christian Bruel
> <christian.bruel@foss.st.com> wrote:
> 
> > We have the helper functions pinctrl_pm_select_default_state and
> > pinctrl_pm_select_sleep_state.
> > This patch adds the missing pinctrl_pm_select_init_state function.
> >
> > The STM32MP2 needs to set the pinctrl to an initial state during
> > pm_resume, just like in probe. To achieve this, the function
> > pinctrl_pm_select_init_state is added.
> >
> > This allows a driver to balance pinctrl_pm_select_sleep_state()
> > with pinctrl_pm_select_default_state() and
> > pinctrl_pm_select_init_state() in pm_runtime_suspend and pm_runtime_resume.
> >
> > Christian Bruel (2):
> >   pinctrl: Add pinctrl_pm_select_init_state helper function
> >   PCI: stm32: use pinctrl_pm_select_init_state() in
> >     stm32_pcie_resume_noirq()
> 
> If Bjorn Helgaas is OK with it I can apply this to the pinctrl tree.
> 
> Otherwise I can also just apply patch 1/2, but that doesn't solve
> any problem.

The stm32 driver has been posted and is on this branch of the PCI
tree:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dwc-stm32&id=5a972a01e24b

but it's not in mainline (or even in pci/next) yet, so you would only
be able to apply patch 2/2 if you took the whole driver, which is
probably more than you would want to do.

I haven't put it in pci/next yet because it doesn't build when
CONFIG_PINCTRL is not defined:

  https://lore.kernel.org/r/20250716192418.GA2550861@bhelgaas

I don't know enough about pinctrl to know why stm32 needs this when
nobody else seems to.  I doubt it's really unique, so maybe it's just
not doing the right thing here.

Bjorn

