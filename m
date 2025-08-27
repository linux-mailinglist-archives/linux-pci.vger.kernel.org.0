Return-Path: <linux-pci+bounces-34946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB81FB38EDF
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 00:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93945361264
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 22:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B532B30F935;
	Wed, 27 Aug 2025 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPDYWmjo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8D92BEFF3;
	Wed, 27 Aug 2025 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756335500; cv=none; b=Yhwa3O1bWd2sqRycQ0AaThaRh0dksnpxOImsYd1XwJfp6Hx55BHSnZm0GXafX5rkwAq42I7cot0YYtlvzGHv/IP8WLMUTunDhNxf+zJqfAN7ESb+XP4pJZTSvYyU5dCBc0m9Q/fL3bH1+bLqpVwnCdAf5ucVqx98QD3DArH6NPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756335500; c=relaxed/simple;
	bh=bE7zXK2epdS1PcPUcz8I2ocXdbtAEedtMJj0bTOPTOA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RDDqb2fWAVBlaffC5jsZ7dzIbDT6jim/qe7InjwFybbMrzSr5/prKXSZJlqxi9IF7C5Aocg6OoPsjUhxN2+Fcc49MpYdRCTkIkZISu0O5UmwHs2UxeiSc1f0+x+FL/m7SaZgAY9q+10LvT9o63IjKtLLCAvS/YKwRvVIZeJi32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPDYWmjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E586AC4CEF5;
	Wed, 27 Aug 2025 22:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756335500;
	bh=bE7zXK2epdS1PcPUcz8I2ocXdbtAEedtMJj0bTOPTOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cPDYWmjodYV78gD/jjGsiD7Motnh49H8tq86+2InGDu5eIuaxjGPJqjfwXbkhFpu+
	 cfxUddP3AUp9Kh2OhI0ct1y6+HQmGZf4O/M5KOebo4sNbiZPbrLDpy/EfSDMOVB/MG
	 WwvvXV2ntn7S7FX5kHu+jTQkeAu+By52XHJGNk9pdj6zc+DfQVStx5sZLUZAKkpwkW
	 Ymiqee+ke+kgy0ZsDeSPS2H7NC4y+gRDLBDZVdfpZ4W5PMO794J4wSDo0iOxhJOgZQ
	 sLOKe8V9dROLeJJ23jFy0rYDQaM0780e9cRs6Y0O8wLLfDPY4q//lgSpyPK8+GYWuz
	 N3lpaxSj3z/qg==
Date: Wed, 27 Aug 2025 17:58:18 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Anders Roxell <anders.roxell@linaro.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Longbin Li <looong.bin@gmail.com>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] PCI/MSI: Check MSI_FLAG_PCI_MSI_MASK_PARENT in
 cond_[startup|shutdown]_parent()
Message-ID: <20250827225818.GA916741@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zlhxt6zqvweklyknmmrlheg3ojy4lildosfjoginliggdtdf5x@zent5qnnawvb>

On Thu, Aug 28, 2025 at 06:52:39AM +0800, Inochi Amaoto wrote:
> On Wed, Aug 27, 2025 at 01:32:02PM -0500, Bjorn Helgaas wrote:
> > On Wed, Aug 27, 2025 at 02:29:07PM +0800, Inochi Amaoto wrote:
> > > For msi controller that only supports MSI_FLAG_PCI_MSI_MASK_PARENT,
> > > the newly added callback irq_startup() and irq_shutdown() for
> > > pci_msi[x]_templete will not unmask/mask the interrupt when startup/
> > > shutdown the interrupt. This will prevent the interrupt from being
> > > enabled/disabled normally.
> > 
> > s/templete/template/
> 
> > AFAICS cond_startup_parent() is used by pci_irq_startup_msi() and
> > pci_irq_startup_msix() in pci_msi_template; cond_shutdown_parent() is
> > used by pci_irq_shutdown_msi() and pci_irq_shutdown_msix() in
> > pci_msix_template.
> 
> cond_startup_parent() is used by pci_irq_startup_msi() in
> pci_msi_template and pci_irq_startup_msix() in pci_msix_template;
> cond_shutdown_parent() is used by pci_irq_shutdown_msi() in
> pci_msi_template and pci_irq_shutdown_msix() in pci_msix_template.

Right, I really screwed that up when I noticed the "*_template"
structure names and added them to my description.

