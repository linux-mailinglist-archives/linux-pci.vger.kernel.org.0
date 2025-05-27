Return-Path: <linux-pci+bounces-28479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B9DAC5D05
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 00:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86604A7EAB
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 22:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C3820E6ED;
	Tue, 27 May 2025 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3knMOWW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772DA2110;
	Tue, 27 May 2025 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748384724; cv=none; b=cvkD6Bxqah+guyFXCWOyx94AIg9AczvPff15UO8YL9fNeiwALVPpZ6bGugExiGOSICNLjhNlFHI/hvKNXLRZQJnH9Hz0MSk3mbGnUYO7vBtgXifwWBjKNT3DvtKWXVh0eWEQdmQGJle5Q6e2VlDpk1H6D1JDDcB8gzmYN5u5I5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748384724; c=relaxed/simple;
	bh=5gazFJDNuUtF4MCBJs82TJld3xU0ehd+jU/yCtaE4fM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WchXAIM6+9mwvAl7GZwUeHMPJhJCkei8Euk1UioCdMA5mr/aQ8FB3GeOodQPqxhk25is8QSN8DWFP6eXZ03bv91X3Rmsnifkpe8THuBLprAOaSA1AgpX56FKkvjF8XD1PxeafNG0ebsE/jWC7wRXEERieLEDv1qVg/5sr6Fqxm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3knMOWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF57C4CEE9;
	Tue, 27 May 2025 22:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748384723;
	bh=5gazFJDNuUtF4MCBJs82TJld3xU0ehd+jU/yCtaE4fM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=V3knMOWW/Tv57lQ6BUk+ybsrQ8QKwakUs5lz3aI2ImDA7Rs4+S1qAYurwpg78kmZx
	 khG7Q/RhFv43DfnqsFGYjRtHfwTmVLX1am0HyM0+uBwmTtpMgvUcTsirbUYO7i+Oq1
	 LXZwWNqCqvRdJxW2z4IR7LUCY7fEplhSM6zkuW90TBxGuk8vHBKUUS8ooG52v7PP9W
	 DDs27THIYu/R2NVL/dHMBMr0nPj2Pck0F2oIa3HL3cSGSpWLGYLopNZZjiPv/oFRSr
	 CEy9lSUgsjkp0gqozODVulqSCD10m3+PZXQgH4TMThBGp0609QtfVzVPePvBFEIGHh
	 5fK4JiMkUCDPA==
Date: Tue, 27 May 2025 17:25:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	Cyril Brulebois <kibi@debian.org>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Jim Quinlan <james.quinlan@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/pwrctrl: Skip creating platform device unless
 CONFIG_PCI_PWRCTL enabled
Message-ID: <20250527222522.GA12969@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nt2e4gqhefkqqhce62chepz7atytai2anymrn6ce47vcgubwsq@a6baualpdmty>

On Sat, May 24, 2025 at 02:21:04PM +0530, Manivannan Sadhasivam wrote:
> On Sat, May 24, 2025 at 08:29:46AM +0200, Lukas Wunner wrote:
> > On Fri, May 23, 2025 at 09:42:07PM -0500, Bjorn Helgaas wrote:
> > > What I would prefer is something like the first paragraph in that
> > > section: the #ifdef in a header file that declares the function and
> > > defines a no-op stub, with the implementation in some pwrctrl file.
> > 
> > pci_pwrctrl_create_device() is static, but it is possible to #ifdef
> > the whole function in the .c file and provide the stub in an #else
> > branch.  That's easier to follow than #ifdef'ing portions of the
> > function.
> > 
> 
> +1

I dropped the ball here and didn't get any fix for this in v6.15.

Why do we need pci_pwrctrl_create_device() in drivers/pci/probe.c?
The obvious thing would have been to put the implementation in
drivers/pci/pwrctrl with a stub in drivers/pci/pci.h, so I assume
there's some reason we can't do that?

