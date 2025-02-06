Return-Path: <linux-pci+bounces-20834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0C3A2B342
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 21:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B713A3189
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 20:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8617E1B21AA;
	Thu,  6 Feb 2025 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy7LgHXJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF351547F3;
	Thu,  6 Feb 2025 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738873099; cv=none; b=jycWkVjn5eudwxo2L5IrkhWyILLZjBOrxHERBJP7OPzTHA2X7od5AgepVsJdxqn/LE6f4YNPledY7wQcRcgvo+jS26Y0mePI1uq5ycF0Jjh2A3fYg+9q/Ek78EzWrMh9JcJ/8UuXxbbW/VqrmEyBWy+FIZtR6wR8YGFpZrOlIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738873099; c=relaxed/simple;
	bh=GvVXBTemD8hLI4sDIDJsvsxj1CuS5Lpg/Tdst6/Kwvc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eTeVBoQNIMP+A811CnBlU2qN7sR1KGqZQZ/u+Cavq/yZtTqiaFOruy5ECqTHw8uzxrSG9V2ceYbsqZrm9JHzPAqjehD5Rjg0NOBy0R68CqNII2UvaA6wENfT6+IrVdeEaML6MZshX8/35l6h4x7G4qJW1jVAtvGn3x7EkNUolMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy7LgHXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADADC4CEDF;
	Thu,  6 Feb 2025 20:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738873099;
	bh=GvVXBTemD8hLI4sDIDJsvsxj1CuS5Lpg/Tdst6/Kwvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iy7LgHXJkzA1mz/gw/rzfCaoVA9gfOKC2PdEO25m0bz1brGms1iGghSjJyHNO96N/
	 SQC0JlWX61TQXrbA0J2lZcvRUN97J8PKO27rcUymErg9BDru8+cTg5FdZJ8uZjE1hJ
	 ze0w/Zsc/iro165y5Rslt8nNSgsW4/aic0eMrn2Dv0T4Tb5SJgOuXrukly2f0Vb9kE
	 e603/OX9msz66Pp7ojWp7RO+8q0eZ3sXCtXnOEmZZJxyggbeovQ/+rPvPg7ImgqGnb
	 1WsVCCMPSTbswC3R4l6JHrCdx5osrOJL19XdkwE0BQVM94ZjJSZDDwRGz+638O3Irb
	 GkEXG1/YHyzng==
Date: Thu, 6 Feb 2025 14:18:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/6] PCI: brcmstb: Refactor max speed limit
 functionality
Message-ID: <20250206201816.GA1000559@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNwY-Fc-nfawc_EtDRBvYht_491v80THW=4F-iY7Nqa81w@mail.gmail.com>

On Thu, Feb 06, 2025 at 01:27:44PM -0500, Jim Quinlan wrote:
> On Thu, Feb 6, 2025 at 12:04 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Feb 05, 2025 at 02:12:01PM -0500, Jim Quinlan wrote:
> > > Make changes to the code that limits the PCIe max speed.
> ...

> And here I thought that uXX_replace_bits() was the up-and-coming
> solution to be used :-)

:)  Yeah, I was kind of surprised that it isn't used more, given that
it was merged in 2017.  And it *does* reduce some repetition, which is
definitely an advantage.  But the fact that those functions are hard
to find with grep is a big turnoff for me.

I wasn't really a fan of GENMASK() and FIELD_PREP() at first either,
but now I'm a big fan because you don't need _SHIFT #defines and it
reduces shift/mask errors.  So probably the same will happen with
uXX_replace_bits().

