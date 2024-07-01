Return-Path: <linux-pci+bounces-9522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B062691E6B1
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 19:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34450B23BB0
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 17:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19E216D4E4;
	Mon,  1 Jul 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkbPs9kW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3E346434;
	Mon,  1 Jul 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719855139; cv=none; b=l0yn/2ICXi6GHQ6kGDwGlhyzqndNioDiaaoTqtojvTICFf343qA5vGUVbURupX4FE67yQaC/nuYLmuoH3IzB5Q1d+mPRzTTcN8PFbZysuAaIHfieteCIxzy881U31TsQp2rR1uWtaD85ISfJw5kwRK9Rgpy/6aaYL7yidjg/1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719855139; c=relaxed/simple;
	bh=duLF429OqK4+yYUi2wJlbgb+Kc0mzXjX7pP0HDXNojM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AKxqWiN4MB9+xMyRvw61Y90kwTZSjeSJCMZdDkdgH6I0fWTHvsy5KSv/c/2rEwrYipksH0B0DyHZNIaBRE/CAWUOOV8LJFEJF8zJanwnCnnIjxraaQxivXNCSXLsO08JpXCxe+QU9pZzCMpVwGCZcgl0KaPhb99bpwntcPW7RQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkbPs9kW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD2EC116B1;
	Mon,  1 Jul 2024 17:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719855139;
	bh=duLF429OqK4+yYUi2wJlbgb+Kc0mzXjX7pP0HDXNojM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VkbPs9kWg4u9U81VCDle7qKzAN8phFWFUnSr0ylXUWhDOj4fOOOlvD6CZSF/+tPsg
	 ht1QYzjMrpFSUpTUR6ULvs4LfanOrFW6QXr+1sgSwFd0X0g7pzCL+B/gB7FqHtEujy
	 QBZfv16I44earRPzQI3vCmd7ydjwdp5ldDPfUZw6AHusiWBsKND/9kTIafB2JKQrm9
	 QyVyMe9/4CUKI+aNANmyivoC8yHeu9QlfFK5f5UUxICrLkg38M36daQGQsiPCUDXb1
	 NCm4IpTX6vzY7VDKlJG0gdFVSPz9Q0va/HTzAiMnVC5ptSbacTq+xJKsri2B0jySFG
	 zlasoIEfOUb1g==
Date: Mon, 1 Jul 2024 12:32:17 -0500
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
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 5/8] PCI: brcmstb: Two more register offsets vary by
 SOC
Message-ID: <20240701173217.GA10563@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628205430.24775-6-james.quinlan@broadcom.com>

Could mention the registers in the subject, e.g.,

  PCI: brcmstb: Make HARD_DEBUG, INTR2_CPU_BASE offsets SoC-specific

On Fri, Jun 28, 2024 at 04:54:24PM -0400, Jim Quinlan wrote:
> Our HW design has again changed a register offset which used to be standard
> for all Broadcom SOCs with PCIe cores.  This difference is now reconciled.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

