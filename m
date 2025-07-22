Return-Path: <linux-pci+bounces-32763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E81B0E71E
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 01:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E66AA3380
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 23:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1687528C2A4;
	Tue, 22 Jul 2025 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQzkUCvi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C0B28C037;
	Tue, 22 Jul 2025 23:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226407; cv=none; b=JBCmPt5N6AvSScOWZFWQ8qREUaed9bmalUWKnIaPbwPx4b7BbB9T0BzRP9gEsr/GhGy33a47zQWb7pVF1d4iK06RYkigbxesAC/qMrl5R8L9GkZhyTM8SZ40IYHA7pmseeLjUubgrMdC+YFtJHpCU1bOJyhsS/b16S758RkDKYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226407; c=relaxed/simple;
	bh=8pybEgbErGd+tMQC9DyRAG2Z29bUyHeydTBP0D5gbzI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Mzk4aQBwfyQsSkwB3YJIhe34jXMyR4uWZ9zPL69qM9rFgZTWpzg9gr+jeJM+WbPXME24zVLbUYHIHAuGdkWeDe5LFT5lZgXITj8x2jLzxAgqYePT/cQq7Xv8qxpDXkON4c3XP6KE3BPlY1utDdsxWfIY93tgF7w7+fj3h7n8wqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQzkUCvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51096C4CEEB;
	Tue, 22 Jul 2025 23:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753226406;
	bh=8pybEgbErGd+tMQC9DyRAG2Z29bUyHeydTBP0D5gbzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rQzkUCvi2KWssfusM1lqDkexxy6Y0ssLH3rF7PKJuO3k5HlgQ7HWjMdOZ6goQwUCD
	 NcZtivABjEdNh9FV+ZSxmaDwoe1y5uM4SC5f2S8/1xX6uoiy5GKd3nOp0PNul7O8ha
	 8SEK/dCRmUu60LmXGpKD//V+ZxPJK4mzMo27jpHzsprC27v866Z8vf7Gu0hEfOJsyU
	 74zel6TVBIf98eDFOXGRWl+ie1fRayX3ZfpzHHuyAYbX0ee/zcvPSNuIJwiFEpUvP/
	 NeTH86kf4W84RCuhpTHM3a3PedkSXmRa96k+ubjHH8YTh+hkcBI2xHC5eqDpHlFRW6
	 pN/fG2JLDxljw==
Date: Tue, 22 Jul 2025 18:20:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH] pci/controller: Use dev_fwnode()
Message-ID: <20250722232005.GA2863060@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4ddaa9e-3ebd-4ef9-8db1-a8277e166b1b@kernel.org>

On Tue, Jul 22, 2025 at 08:24:26AM +0200, Jiri Slaby wrote:
> On 21. 07. 25, 19:08, Bjorn Helgaas wrote:
> > Jiri, question for you below about more possible drivers/pci/
> > conversions to use dev_fwnode() for struct device * cases.
> 
> Sorry, I am a way too occupied :/.
> 
> > Would like to get this in for v6.17 if these should be changed.
> 
> It's not necessary, but a good to have cleanup (opposed to the posted fixes,
> which were required). I will switch those eventually, but I don't promise
> 6.17. (If someone does not beat me to it.)

It's not clear from the commit log:

  irq_domain_create_simple() takes fwnode as the first argument. It can be
  extracted from the struct device using dev_fwnode() helper instead of
  using of_node with of_fwnode_handle().

  So use the dev_fwnode() helper.

why the posted fixes are required (other than Arnd's change to
altera_pcie_init_irq_domain(), which fixes an unused variable warning
when CONFIG_OF is not enabled).

Since it sounds like no changes are required for the other ones I
mentioned, I'm going to leave them alone for now:

  dw_pcie_allocate_domains()
  mobiveil_allocate_msi_domains()
  altera_allocate_domains()
  mtk_pcie_allocate_msi_domains()
  xilinx_pl_dma_pcie_init_msi_irq_domain()
  nwl_pcie_init_msi_irq_domain()
  plda_allocate_msi_domains()

Bjorn

