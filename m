Return-Path: <linux-pci+bounces-12024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC3E95B9E3
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 17:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4DF1C21B64
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328CA3BB25;
	Thu, 22 Aug 2024 15:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIwl65FS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BF62CCAA;
	Thu, 22 Aug 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339821; cv=none; b=QPE9mMJ33RSkbR2LlrjXp9meBY1audIMP94PdPOcALIVEW4RgbiCRIu+FRJN2WqzNj1moRX1zPuC83G/BYr3Izhh0nRxhh1IxJSfjlxB2qg+YR2XeM3NXR0sxMvX0C1y4JrxC3EiNNYZfmzL8g8SIWO4sQperTAWidfxaGmfKKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339821; c=relaxed/simple;
	bh=6MzyrLk662e38FzPLcufarsBm2Sb6mLumpo7mjlQ/9o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UTjZ0cigoUFiR46S6pHX9PmqEqC2uDXgT8dqv+aFAoC60gyt9sozY0Y+pbQrYNZbHwNOinFfrnw4B2kXjhGg2f/u5RObOqdwHuTvOhEMAsBXPv2i/sIR+dBxzJtZgBWm+qMmOnhCKKkdVNyzsf6VRZpQ8AtMekrWs+1IzJZjxI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIwl65FS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8D0C32782;
	Thu, 22 Aug 2024 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724339820;
	bh=6MzyrLk662e38FzPLcufarsBm2Sb6mLumpo7mjlQ/9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RIwl65FSGRsY7r4QBp8NgZcC2DkVtfPKtx72QTMqQJ0XT/krTZqlO/HmJ4DlDddop
	 WZRnQmHw8QGtTNJmkNQG5u15HWpUqHqL4E08NkdxgrL4mbO/1SKrohJcYJnrV9Mmk6
	 66B2nSr8TgRh0keKvrndQDSAqHEyHP90e5/SMbTJ2dCwhzGEsgGtXDGDuqNpT/s9NO
	 YOqtka9e/aY0wozYIlf+6+5xb0t7L3Y8b0+ahwmyUA3AS+B66bmx1BFEy5CGHVR4qR
	 qodWY/cuSwaYNGGVxA1+behj2Ono3fOzgiTNBCOtdOQ9cdk/QwGonTqFv9FnJBlIRc
	 6VOtbIZDSEVYw==
Date: Thu, 22 Aug 2024 10:16:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Message-ID: <20240822151658.GA305162@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822064823.x26bjqev6ye32v5j@thinkpad>

On Thu, Aug 22, 2024 at 12:18:23PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Aug 21, 2024 at 05:56:18PM -0500, Bjorn Helgaas wrote:
> ...

> > Although I do have the question of what happens if the RC deasserts
> > PERST# before qcom-ep is loaded.  We probably don't execute
> > qcom_pcie_perst_deassert() in that case, so how does the init happen?
> 
> PERST# is a level trigger signal. So even if the host has asserted
> it before EP booted, the level will stay low and ep will detect it
> while booting.

The PERST# signal itself is definitely level oriented.

I'm still skeptical about the *interrupt* from the PCIe controller
being level-triggered, as I mentioned here:
https://lore.kernel.org/r/20240815224735.GA57931@bhelgaas

tegra194 is also dwc-based and has a similar PERST# interrupt but it's
edge-triggered (tegra_pcie_ep_pex_rst_irq()), which I think is a
cleaner implementation.  Then you don't have to remember the current
state, switch between high and low trigger, worry about races and
missing a pulse, etc.

> If it is an edge trigger signal, then ep wouldn't be able to catch
> it as you suspected.

Bjorn

