Return-Path: <linux-pci+bounces-37278-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5E7BAE0BD
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 18:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDC73AECE9
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0200A3C465;
	Tue, 30 Sep 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btZxeuap"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D91BF58;
	Tue, 30 Sep 2025 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759249950; cv=none; b=rBACOL8YO92PrDaRw/0ifJSvzwi9FOvZwn3FOIhYFU8esnag9c7WNpNM+K6OWaHajl1lejgwc1Hyf4I4C93sAnYJgLvyNbCVwIq5KaplfZcL1mqY9lhNWoVrOPhdCR/ayCIVJiUOrTOKz0VydWanwtJALMcTuvCEGRDUFDnbBWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759249950; c=relaxed/simple;
	bh=jdVuehLsO2BbsXchfGIueYIfBtAAqPbDLFHoBeD0ySM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PQtIcmwx4RjaenvKUtBQ5goIbVI+Duepf6eCLayaRSSIRnX2sD4gOkw7itLOwSSolW+6w8L9C3fuJqpvhlPY9gaTQj3ZsAPQ5NXIizp+McDPndtnMJRf/1WDH/AnPpCBUgOvyrVTPVwJBpktBXDYOQM/yusjYPYux2r2aaGUEdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btZxeuap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDA54C4CEF0;
	Tue, 30 Sep 2025 16:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759249950;
	bh=jdVuehLsO2BbsXchfGIueYIfBtAAqPbDLFHoBeD0ySM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=btZxeuapgJ8cVMgABl2IrN7ULEYD/efA61/d6uFEPKikOD4Qv9PgFdecqs2WarnKh
	 fM/lVEJ4DBWpwkaQELBbkgx9/+wjjv4ZO7+XaBKUX7vOpvL6JWPt60FgXI1GM4SUJJ
	 rv4cMHFUzfTYQPe4wZv1LfqsvCW83Dj1iT04iPPdWXiJ9XaPUeCwD10mKq/8QKRTl2
	 GG1UY6m+ZqyJxgEx17Pnrni2JmWvcPCaCXpMK/zVLAQOfhtC3fe34Kx3TWIVKhTQbn
	 WSLpRsCuESis8oIaNeur0ZilZNqBIVwPOOjkG/X2tAIfoROkY+tvDVTdS5PLiBafuH
	 iV+2vLz4an3Dw==
Date: Tue, 30 Sep 2025 11:32:28 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	Christian Bruel <christian.bruel@foss.st.com>,
	linux-pci@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: stm32: Remove link_status in PCIe EP.
Message-ID: <20250930163228.GA183263@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175915669921.12348.6942864048975237850.b4-ty@kernel.org>

On Mon, Sep 29, 2025 at 08:08:19PM +0530, Manivannan Sadhasivam wrote:
> 
> On Tue, 02 Sep 2025 14:26:41 +0200, Christian Bruel wrote:
> > Guarding enable_irq/disable_irq against successive link start
> > link does not seem necessary, since it is not possible to start
> > the link twice. Similarly for stop.
> 
> Applied, thanks!
> 
> [1/1] PCI: stm32: Remove link_status in PCIe EP.
>       commit: 7d1c807cd2ddf8ef771f214ae4dab9bebbc61522

Since this is essentially a fix to "PCI: stm32-ep: Add PCIe Endpoint
support for STM32MP25", which hasn't been merged upstream yet, I
squashed it into that patch:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=013d82bb62c0

