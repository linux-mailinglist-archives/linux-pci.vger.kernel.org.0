Return-Path: <linux-pci+bounces-39272-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D47C06E3F
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 17:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0219402435
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 15:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AD02580E4;
	Fri, 24 Oct 2025 15:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MidoN/rj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EF7218EB1;
	Fri, 24 Oct 2025 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318752; cv=none; b=TVnrnCVWbX4V/g69WB7aZX15wSn5EwEQHFj/gwsowdOaGIDJ87iSqFHxM3NMIyg9DEAOVuYt/PsI+4c9ar4tKuSQKY+vuEw93Bw8J2dSC9io3bDikM+7jXxitvSuYnTuS8c20Ai2iqgczewGVZZqBhHtJt4NGxHKNFOqeL2KBNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318752; c=relaxed/simple;
	bh=UZIPf66k/1+SxC28rDg1HdR6h2ZzeGZdZt38ixelz0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pP93pfswYC+qXqpSYKd1b7JGMYAtHbLAJn0EOaO/oY9WwT4PmXrDrInfZ+zytJKVRRpIn+l6uJLEwXjZLUJOzI9P97BgzURxQnVh89RF7XIKhQtOIvk1k4mtm05XWJ4hdUgcjMOiiNmZULPIrqVGI0kCxNP7l0yA4zOM0b11Ncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MidoN/rj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11BBC4CEF1;
	Fri, 24 Oct 2025 15:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761318751;
	bh=UZIPf66k/1+SxC28rDg1HdR6h2ZzeGZdZt38ixelz0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MidoN/rjVDsT2uZ0vhICv+XEKOtW7Bk+aov/uZhFq91KaJ0UMHT1VK6KiWJlid7Sk
	 ncU0CtDsFxZKgmN/5ncxknbGz+efAMnwXEET5Lc05JYzweDlZdhBxNTN0huGNRaFPX
	 KdVMri2sn2zcLNerlNe5EMph6C4R4dbYihIksTBf2YTZGocoevCPgb73SKSymGcal0
	 Pcmsn4UBYkgzG6PMribcDK5V8eTNCtkZ4PMfuQtyVP4vxL6c3dTG2qc6WQjDEtZ7HI
	 BrUqW1yNEsrIVeA9b7EBSWPatgdWguDrDWL9hUP8YzjWabWUR4vZIS01EY/wwVD/EM
	 NKQV0sztncCBQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vCJT4-000000003NV-3WvI;
	Fri, 24 Oct 2025 17:12:38 +0200
Date: Fri, 24 Oct 2025 17:12:38 +0200
From: Johan Hovold <johan@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Dragan Simic <dsimic@manjaro.org>, linuxppc-dev@lists.ozlabs.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
Message-ID: <aPuXZlaawFmmsLmX@hovoldconsulting.com>
References: <20251023180645.1304701-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023180645.1304701-1-helgaas@kernel.org>

On Thu, Oct 23, 2025 at 01:06:26PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree
> platforms") enabled Clock Power Management and L1 PM Substates, but those
> features depend on CLKREQ# and possibly other device-specific
> configuration.  We don't know whether CLKREQ# is supported, so we shouldn't
> blindly enable Clock PM and L1 PM Substates.
> 
> Enable only ASPM L0s and L1, and only when both ends of the link advertise
> support for them.
> 
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de/
> Reported-by: FUKAUMI Naoki <naoki@radxa.com>
> Closes: https://lore.kernel.org/r/22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com/
> Reported-by: Herve Codina <herve.codina@bootlin.com>
> Link: https://lore.kernel.org/r/20251015101304.3ec03e6b@bootlin.com/
> Reported-by: Diederik de Haas <diederik@cknow-tech.com>
> Link: https://lore.kernel.org/r/DDJXHRIRGTW9.GYC2ULZ5WQAL@cknow-tech.com/
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Tested-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
> I intend this for v6.18-rc3.

Note that this will regress ASPM on Qualcomm platforms further by
disabling L1SS for devices that do not use pwrctrl (e.g. NVMe). ASPM
with pwrctrl is already broken since 6.15. [1]

Reverting also a729c1664619 ("PCI: qcom: Remove custom ASPM enablement
code") should avoid the new regression until a proper fix for the 6.15
regression is in place.

Johan


[1] https://lore.kernel.org/lkml/aH4JPBIk_GEoAezy@hovoldconsulting.com/

