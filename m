Return-Path: <linux-pci+bounces-33516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A10B5B1D1FB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 07:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7EF8580B13
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 05:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406C41A23AC;
	Thu,  7 Aug 2025 05:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNzBxySl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178759478;
	Thu,  7 Aug 2025 05:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754544416; cv=none; b=ieLg638JAztTgLsiyZIYCO8HVWzhmcCKEeiMr+TYTArkqhgvLDU5PYu5ViN55LpO8peXTJd+1EJb2/MWFTTL7il6UNF5Yaj52Z2EFLEmKVbttfaEx5w/l/YWEDQWkShIUNTJOSyqWCQdvTXkS/pJ3i6fERPjBJ43dy/XnvdzemM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754544416; c=relaxed/simple;
	bh=DA+RdVvSTs6M4sCjuqioqJz44R7iAMq+lOuhcUm3W1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oktIRGoE0TFwGGFiv0awm5EzhaBnwuXuJUvksI0qPexLCgV0/62HGgGHRt7hgcsWNh2Wd7Msw0TsTmhKRVl0f5BGXEY2w2uBH4U6L54K/Xh6PsImLaTpP/vBWbpwq7heE6YFrZgchL1E2+lezV3R+Np/sCTfVniaNH2q1Ux9/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNzBxySl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB711C4CEEB;
	Thu,  7 Aug 2025 05:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754544415;
	bh=DA+RdVvSTs6M4sCjuqioqJz44R7iAMq+lOuhcUm3W1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNzBxySlD9SAhiXo1+8OFDocyJI5nuXkNkkoMtzucyRzkXCOlgqY1alVZQx4xsjD3
	 lc0quQjSyQx7cTJ5gbHz3zEZa9noi9VkbmGiOFTU/zaJqBa9I6BEXkda4XrqkdJxk6
	 RBVLBT2FBeDLCrW91TSZxZKDSQ9CdDlwj+9SP1uvSHNCZNPjjzaEB1/Af4SW0eQ4yN
	 Pf4DG1k+GeDTBLDvUrJPl0r7nzAVt6/Loqu5MduaMuWXWShCMElmIqEKuzJjAMtiDc
	 zOE60faAuO1AffQonkSpLbA7QAHumSm3ek++l+SVpP6OzhOqASzwr8dhZbsjhHqgcH
	 35vDIJQs9GbGA==
Date: Thu, 7 Aug 2025 10:56:46 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Cyril Brulebois <kibi@debian.org>, 
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>, 
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] PCI: brcmstb: Add panic/die handler to driver
Message-ID: <yqtfhokgfgiwk62lhxkxna26lpexgnlvcmwgfopewlj5u74drt@q6adhcvm7hqz>
References: <20250806185051.GA10150@bhelgaas>
 <0a518bd3-0a20-4b69-a29f-04b5cd3c3ea8@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a518bd3-0a20-4b69-a29f-04b5cd3c3ea8@broadcom.com>

On Wed, Aug 06, 2025 at 01:41:35PM GMT, Florian Fainelli wrote:
> On 8/6/25 11:50, Bjorn Helgaas wrote:
> > > I'm not sure I understand the "racy" comment.  If the PCIe bridge is
> > > off, we do not read the PCIe error registers.  In this case, PCIe is
> > > probably not the cause of the panic.   In the rare case the PCIe
> > > bridge is off  and it was the PCIe that caused the panic, nothing
> > > gets reported, and this is where we are without this commit.
> > > Perhaps this is what you mean by "mostly-works".  But this is the
> > > best that can be done with SW given our HW.
> > 
> > Right, my fault.  The error report registers don't look like standard
> > PCIe things, so I suppose they are on the host side, not the PCIe
> > side, so they're probably guaranteed to be accessible and non-racy
> > unless the bridge is in reset.
> 
> To expand upon that part, the situation that I ran in we had the PCIe link
> down and therefore clock gated the PCIe root complex hardware to conserve
> power. Eventually I did hit a voluntary panic, and since all panic notifiers
> registered are invoked in succession, the one registered for the PCIe RC was
> invoked as well and accessing clock gated registers would not work and
> trigger another fault which would be confusing and mingle with the panic I
> was trying to debug initially. Hence this check, and a clock gated PCIe RC
> would not be logging any errors anyway.

May I ask how you are recovering from link down? Can the driver detect link down
using any platform IRQ?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

