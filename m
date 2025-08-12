Return-Path: <linux-pci+bounces-33886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB60B23977
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 22:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 271867B48A4
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 19:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4259E2D0609;
	Tue, 12 Aug 2025 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU/cStZi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198402D0600;
	Tue, 12 Aug 2025 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028800; cv=none; b=JksUknkrWTWa/Y9YvUztG3Mr1YrlVsLsmcX3+8CvxY/omvoD1NS1+PFEULw6bsHbf3a/y31q3ilVSoGNL0Pk3yXkJNnvzmRxPNfCdt31FCqcs9k1W/ynUMu+dJHv2ThOtGfy9zegRM94y2rA1up7EGnHOUJwCQJgDayQlS8g8hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028800; c=relaxed/simple;
	bh=r4UtzLEZzDFdqEPdAkRCVFDyO7h19h9CQnp/IMLpMkY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b/wk5YcyhNmVOwFZ+4hp5/QpLv6dGgZSSMyGgANEbNOrI+6+A8BY0ZH3jD38kipdP8evzokms6eFBITlGj5N4/KQDKXWpZRLTil3O0Mbn/5JbEMCT0Xn2V3+g7wQUjPwTp4DzUbUajw+LAeuZXkazfy3rX5af+G6wgfuFPzbA4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU/cStZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC4FC4CEF0;
	Tue, 12 Aug 2025 19:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755028799;
	bh=r4UtzLEZzDFdqEPdAkRCVFDyO7h19h9CQnp/IMLpMkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bU/cStZiVAT3SMZknsKUNcFwUnEg4K5bJQ9kwXG3ilkkR/pJBRdmbbb2D3fXb3qRf
	 Jfm+/CmioJ6VPgqhxkgx7Cu2/PScIOK81wcY4zpkxphGuRYFGwbFENXPreFo1e3Q31
	 HyEc1vrKRFmFK8niBTCpwiP8LcEWts6bBSmMPL7BnBmtnT9Tha8qHeB+xCrFXRHFag
	 7Nx0aZoS08psO1QOckrg5tudtjNR+buAHuvN9jxZ1oPx4VclfIDGWrMJLsjbXnPpbk
	 lQ4eR6pCRKoDli6La6JaNGR9cvkqLpSnf2FDmHsEEsVGLWNLdE1nK1oAD6fNTOd6Nu
	 hUDi5iD70pZ1g==
Date: Tue, 12 Aug 2025 14:59:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C2=B4nski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: Re: [PATCH] PCI: vmd: Remove MSI-X check on child devices
Message-ID: <20250812195958.GA203401@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812193219.9E_pRwle@linutronix.de>

On Tue, Aug 12, 2025 at 09:32:19PM +0200, Nam Cao wrote:
> On Tue, Aug 12, 2025 at 02:00:36PM -0500, Bjorn Helgaas wrote:
> > On Tue, Aug 12, 2025 at 08:22:09PM +0200, Nam Cao wrote:
> > > Minor correction, it is not just an unnecessary WARN_ON, but child devices'
> > > drivers couldn't enable MSI at all.
> > > 
> > > So perhaps something like "Remove the sanity check to allow child devices
> > > which only support MSI".
> > 
> > Thanks, updated.
> 
> Sorry for the extra work I have been putting on you this cycle. I
> trust you understand it is for good reason.

No worries, it's the nature of the beast :)  I appreciate all your
work!

