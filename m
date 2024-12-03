Return-Path: <linux-pci+bounces-17606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8149E2F03
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 23:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723FC283605
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 22:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58201204F77;
	Tue,  3 Dec 2024 22:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhLj8p8e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E571DF268;
	Tue,  3 Dec 2024 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264717; cv=none; b=tzJeEgcP3lHJN/Xl9//CHpCxg9ndNukWTTAwkoJVdk62xtvXCyiODw4zhfmT0W7ncRb7IoF61lxFMgFfg3QAgfRkCHDx6PEcH9g+80Dg3uWrsQCBWj3hft/9r53IIPIFFN799bpOMkRkHfF4i+RBSJ17+lWdWY7FupLCh/rK7dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264717; c=relaxed/simple;
	bh=Z15C0mt3XM7YpivR1T5/W0M5swvKfGcdZ7nyxNwhLoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZJ7TnyYwh3UlC9ONx6cJnCtV85XQSOGX6ZtzUwtgF64Ta2a5LA4ww2yjHJEadBznIYPEP61WacyMPI5bDTMclzkFSvYc8wMYHC/giJnaLeP5ILO0N7Qq0syxNv1npTsGiNLrm11qjIyad0JJu5DdX5zu3Vk/R3ieul2L+4k5PV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhLj8p8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81806C4CEDC;
	Tue,  3 Dec 2024 22:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733264716;
	bh=Z15C0mt3XM7YpivR1T5/W0M5swvKfGcdZ7nyxNwhLoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qhLj8p8eyWJXXP2R4fcik2XxZ1g4PpArVVeC4x2S0kXCH2O24HAt7vH4EuYcRZa9U
	 agS0BM2aYhGkfRoh8AXjL7O1WEuoUtSxGq8aIPSUqUqT7p5kfpOKmj6WTOkNfWb6ae
	 gesaNcOwa2CvKG0o081fcGYQyV1Aiw4aQQ57Md9Ffuda70Vw/Z/TP0AI/31q1JMnlr
	 R4TnoXjduLP3en1w119e6ZYjMoLmpmNHSCdjvW4PMO4Sika9XCgkDNvThTj90uvqnI
	 HFrNGoNAfsgTkVZtdnf4kK7COX0g/5hcp3ydpoWWf+O0KZ2vGTem5n36fzY7c/FExp
	 rrf6y623PwJTQ==
Date: Tue, 3 Dec 2024 16:25:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	p.zabel@pengutronix.de, cassel@kernel.org,
	quic_schintav@quicinc.com, fabrice.gasnier@foss.st.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: PCI: Add STM32MP25 PCIe root complex
 bindings
Message-ID: <20241203222515.GA2967814@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126155119.1574564-2-christian.bruel@foss.st.com>

On Tue, Nov 26, 2024 at 04:51:15PM +0100, Christian Bruel wrote:
> Document the bindings for STM32MP25 PCIe Controller configured in
> root complex mode.
> 
> Supports 4 legacy interrupts and MSI interrupts from the ARM
> GICv2m controller.

s/legacy/INTx/

> STM32 PCIe may be in a power domain which is the case for the STM32MP25
> based boards.
> 
> Supports wake# from wake-gpios

s/wake#/WAKE#/

> +  wake-gpios:
> +    description: GPIO controlled connection to WAKE# input signal

I'm not a hardware guy, but this sounds like a GPIO that *reads*
WAKE#, not controls it.

> +    pcie@48400000 {
> +        compatible = "st,stm32mp25-pcie-rc";
> +        device_type = "pci";
> +        num-lanes = <1>;

num-lanes applies to a Root Port, not to a Root Complex.  I know most
bindings conflate Root Ports with the Root Complex, maybe because many
of these controllers only support a single Root Port?

But are we ever going to separate these out?  I assume someday
controllers will support multiple Root Ports and/or additional devices
on the root bus, like RCiEPs, RCECs, etc., and we'll need per-RP phys,
max-link-speed, num-lanes, reset-gpios, etc.

Seems like it would be to our benefit to split out the Root Ports when
we can, even if the current hardware only supports one, so we can
start untangling the code and data structures.

Bjorn

