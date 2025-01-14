Return-Path: <linux-pci+bounces-19738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57B8A10CFA
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 18:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D57BA7A10AD
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 17:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A891AA1DC;
	Tue, 14 Jan 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDVH8Lkq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C201E529;
	Tue, 14 Jan 2025 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874334; cv=none; b=YxW66L+c0BnMcJo+T+pX1jU5kYo3dmsrWYToJFrx15FdM3XDasRu8xiXgLNY23Za2sBfN+66IAXSbHg6Gw4GFeBiMdEatQC4A3g8HFKqFOi39kezKmbkEa7OnV0mlYFCukBhoHH55xZRln/ydqLe3ldXije+fRcOMDOHqS8RhGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874334; c=relaxed/simple;
	bh=4l1I+oCpVV7aVqBA/IRj6rgmTYIBnLenVcNim925x0E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bM8wDhYK9uKMIzo3DQmeTlguKB8IQ3yrqlMgqDMlLjh48FqXo4IKKEH8c4hEfhhvG7CZnFFBI1leRnBIMnJNV12EIv8q+TgOvpUN2LUhHqW+05UxiINOA0M0OQ52qmHR9icgTduEIpz0gTAjHV68di4PCSBTcrzcDPgQHon2qPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDVH8Lkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AF4C4CEDD;
	Tue, 14 Jan 2025 17:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736874333;
	bh=4l1I+oCpVV7aVqBA/IRj6rgmTYIBnLenVcNim925x0E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lDVH8LkqBChhnuAGdV3aOQRdWR9sekjlr8og2bRGHplaBVZoyD1txgGW1pwALmvQq
	 Hk1pk0EOjmzDMuh8/NRG65sEqF9Zwc0gX7ZSucljn7YKUxU88Cu6j9F2fMYpBKNHNN
	 PqON+4tUWgo/5Dye6ShWYBh9PLNgsMKL6iYUwXOTED7Zf77Wsw8p8TmBJ/zR/X6uRA
	 zFEtYX0laUVdmC3xya+m5cgWeu5KI1rhgVN8bF3loS+XAGJa7YZoaWYUKaWs2ZE3cW
	 5sCdeKVBH8rbx29Dajlly0m5urNK3D3iTGsi5VlgvyP7nNh1EKXi9FSBRCftlmEDh9
	 TIqh1LgB7cS+g==
Date: Tue, 14 Jan 2025 11:05:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, p.zabel@pengutronix.de,
	cassel@kernel.org, quic_schintav@quicinc.com,
	fabrice.gasnier@foss.st.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] PCI: stm32: Add PCIe endpoint support for
 STM32MP25
Message-ID: <20250114170530.GA464935@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef02ddbf-0838-4616-a3c5-ef7ab55de3c9@foss.st.com>

On Mon, Dec 16, 2024 at 03:00:58PM +0100, Christian Bruel wrote:
> On 12/5/24 18:27, Bjorn Helgaas wrote:
> > On Tue, Nov 26, 2024 at 04:51:18PM +0100, Christian Bruel wrote:
> > > Add driver to configure the STM32MP25 SoC PCIe Gen2 controller based on the
> > > DesignWare PCIe core in endpoint mode.

> > > +static void stm32_pcie_ep_init(struct dw_pcie_ep *ep)
> > > +{
> > > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > > +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> > > +	enum pci_barno bar;
> > > +
> > > +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> > > +		dw_pcie_ep_reset_bar(pci, bar);
> > > +
> > > +	/* Defer Completion Requests until link started */
> > 
> > I asked about this before [1] but didn't finish the conversation.  My
> > main point is that I think "Completion Request" is a misnomer.
> > There's a "Configuration Request" and a "Completion," but no such
> > thing as a "Completion Request."
> > 
> > Based on your previous response, I think this should say something
> > like "respond to config requests with Request Retry Status (RRS) until
> > we're prepared to handle them."
> 
> OK thanks for the phrasing. This is inline with the DWC doc:
> "... controller completes incoming configuration requests with a
> configuration request retry status."
> The only thing is that the PCIe specs talks about CRS, not RRS.
> 
> so slightly change to
> "respond to config requests with Configuration Request Retry Status (CRS)
> until we're prepared to handle them."

This terminology between PCIe r5.0 and r6.0.  In r5.0, sec 2.2.9
labels Completion Status value 010b as "Configuration Request Retry
Status (CRS)", but in r6.0, sec 2.2.9.1 labels that same value as
"Request Retry Status (RRS)".

We changed most usage inside drivers/pci/ to align with the r6.0 term
with https://git.kernel.org/linus/87f10faf166a ("PCI: Rename CRS
Completion Status to RRS").

But with respect to this patch, changing "Completion Request" to
"Configuration Request" is the main thing.

Bjorn

