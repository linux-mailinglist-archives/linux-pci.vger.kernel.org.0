Return-Path: <linux-pci+bounces-33469-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C824B1CBC2
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 20:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546F87A3555
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 18:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD0B1C7017;
	Wed,  6 Aug 2025 18:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh1E9NLO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDE235959;
	Wed,  6 Aug 2025 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754504142; cv=none; b=sXfBzcVVab8uaxxdSdNShEpdM2POkm4Xrr38s/kB/PT829sgcdFAVhdvv/lcxH3eHmX8b+G/6g5jvR0Ut2jVbpXvr9FpWYhg3XijANefqdfXJgInCixuT8cm4vtMj7gG39vy2hHF4WWiFy+F5GY4cMgrMV27eWF0+Ivl2wPzwz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754504142; c=relaxed/simple;
	bh=YenbEi95ht30tqGvYsUcW/iuqIr6ntv4AaPCVyIWjKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=m22iaf9GXh/qCLR8QJ0zPiS3fLL7jl6hKdnl+wMxvWupC2sM6AqosdIIaKugGMQ0ekTXP8EyeX6SS9xxjkktALxm+4zmjXwWMK7s61kIporl69MKdX00tSG3zQBL62L6CN8EgFwmGrwvvzy7nZ/ewzoAzu4Ovl2wbPBQTDPS8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh1E9NLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9517DC4CEE7;
	Wed,  6 Aug 2025 18:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754504141;
	bh=YenbEi95ht30tqGvYsUcW/iuqIr6ntv4AaPCVyIWjKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Kh1E9NLODFAYRkV2jJl5UxGQfHDp/VYvJz9snIu0KlC0BLt45MtiIGlWUlg8Qh62u
	 6v3Ytq11UOaCtwfAYSaWFqGSlrL54FeA8j2dPXj95qsvG72tuD1RdmR6PUI0XPLdcz
	 asbLfqDGi1KMwYVQf4lzcGSH18It7/7cqgn9XFkSwbTMtUXpL7Gt8nxItWVsfE/u7R
	 zI5TskldXNQ02Jlin6O7hiv1H2umRdvwTYjzLTQ9plWAsLTGunj3/ALSlp0XLY1UgR
	 joRyNNz3NntvTIXKqzZevfDiMhwmLD3t1SdydA7AAnU0eZ6fpFpNRD0foYPuLIFn3c
	 Rzf/Upj23IbKw==
Date: Wed, 6 Aug 2025 13:15:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: brcmstb: Add panic/die handler to driver
Message-ID: <20250806181540.GA8692@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613220843.698227-3-james.quinlan@broadcom.com>

On Fri, Jun 13, 2025 at 06:08:43PM -0400, Jim Quinlan wrote:
> Whereas most PCIe HW returns 0xffffffff on illegal accesses and the like,
> by default Broadcom's STB PCIe controller effects an abort.  Some SoCs --
> 7216 and its descendants -- have new HW that identifies error details.

What's the long term plan for this?  This abort is a huge problem that
we're seeing across arm64 platforms.  Forcing a panic and reboot for
every uncorrectable error is pretty hard to deal with.

Is there a plan to someday recover from these aborts?  Or change the
hardware so it can at least be configured to return ~0 data after
logging the error in the hardware registers?

> This simple handler determines if the PCIe controller was the cause of the
> abort and if so, prints out diagnostic info.  Unfortunately, an abort still
> occurs.
> 
> Care is taken to read the error registers only when the PCIe bridge is
> active and the PCIe registers are acceptable.  Otherwise, a "die" event
> caused by something other than the PCIe could cause an abort if the PCIe
> "die" handler tried to access registers when the bridge is off.

Checking whether the bridge is active is a "mostly-works" situation
since it's always racy.

> Example error output:
>   brcm-pcie 8b20000.pcie: Error: Mem Acc: 32bit, Read, @0x38000000
>   brcm-pcie 8b20000.pcie:  Type: TO=0 Abt=0 UnspReq=1 AccDsble=0 BadAddr=0

