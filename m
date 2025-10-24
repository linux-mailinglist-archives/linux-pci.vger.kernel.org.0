Return-Path: <linux-pci+bounces-39273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C425C06EE2
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 17:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38028343A57
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 15:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F488322C60;
	Fri, 24 Oct 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGUsf/Vb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576572E62D8;
	Fri, 24 Oct 2025 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319227; cv=none; b=WZEluylIhNJAOSa3EmadDSu8g0Um6buKwfUaQiBeJ54k2KJiOdG3gBPEjiQ4QAkDMMAyqpQlkZHiwRhOX5yJ1ggTMt8Seqm6dd83Eg6GuaeZgwXqkXlVMmpdSZ5G+iwo18RC3mGHu1QYvqwkL525pUgzffsCcEdIut6kws142XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319227; c=relaxed/simple;
	bh=n5BEv7tANXuEeHLRiXCQjQbiBaE91Lb87LGC2gdxV0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0FAofoeqUvASEYjlvTi0uaWPhtZQtElHku3ewcczPR8UXryxpSz9gbPGAEG5jFuqL8oPChDHkSzh5ia2iNknNvuqkSfYnUnydj/rYwQUbGEa2MMxVt6zRFgntDoVQQ9uaFPTTZbvJ8tCHJ1lAbA7uunwWFelDKWbPW/CI5KFlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGUsf/Vb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE237C4CEF1;
	Fri, 24 Oct 2025 15:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761319226;
	bh=n5BEv7tANXuEeHLRiXCQjQbiBaE91Lb87LGC2gdxV0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NGUsf/VbMr2BwAimYh6NTwmgavBP72r0G6D+vLaMYigU+2+nH7MUlivK4RJuChuZp
	 xZ12OeBKaEElwRy34Dw9eaPIER0IgnB3Ai9vo3FnbQBwIZIFGG7WCcpxQakNobzlhz
	 NNcngL+ZI2dqWBAh5mHGIrWPsVvX51zKYDn2lWq3nlbMQAfXOIf2fXSbD4niC42B7a
	 CSNwxQqgVIuGpGB0WfwT3RBQGiFs3w46Pd2KmSG2lBuH3CzkpY0eWICQYg4Sh6qoSv
	 jaFQaAM1sR76uspjFTfjnmC6LtQJdc24DiF1O7zcgnxDcKw3lND5+3j5P5wiT4OeUx
	 Ga8L3Iu/gwg4Q==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vCJaj-000000004RQ-3bNr;
	Fri, 24 Oct 2025 17:20:33 +0200
Date: Fri, 24 Oct 2025 17:20:33 +0200
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
Message-ID: <aPuZQRaTN2tAwkb5@hovoldconsulting.com>
References: <20251023180645.1304701-1-helgaas@kernel.org>
 <aPuXZlaawFmmsLmX@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPuXZlaawFmmsLmX@hovoldconsulting.com>

On Fri, Oct 24, 2025 at 05:12:38PM +0200, Johan Hovold wrote:
> On Thu, Oct 23, 2025 at 01:06:26PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree
> > platforms") enabled Clock Power Management and L1 PM Substates, but those
> > features depend on CLKREQ# and possibly other device-specific
> > configuration.  We don't know whether CLKREQ# is supported, so we shouldn't
> > blindly enable Clock PM and L1 PM Substates.
> > 
> > Enable only ASPM L0s and L1, and only when both ends of the link advertise
> > support for them.
> > 
> > Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> > Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> > Link: https://lore.kernel.org/r/db5c95a1-cf3e-46f9-8045-a1b04908051a@xenosoft.de/
> > Reported-by: FUKAUMI Naoki <naoki@radxa.com>
> > Closes: https://lore.kernel.org/r/22594781424C5C98+22cb5d61-19b1-4353-9818-3bb2b311da0b@radxa.com/
> > Reported-by: Herve Codina <herve.codina@bootlin.com>
> > Link: https://lore.kernel.org/r/20251015101304.3ec03e6b@bootlin.com/
> > Reported-by: Diederik de Haas <diederik@cknow-tech.com>
> > Link: https://lore.kernel.org/r/DDJXHRIRGTW9.GYC2ULZ5WQAL@cknow-tech.com/
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > Tested-by: FUKAUMI Naoki <naoki@radxa.com>
> > ---
> > I intend this for v6.18-rc3.
> 
> Note that this will regress ASPM on Qualcomm platforms further by
> disabling L1SS for devices that do not use pwrctrl (e.g. NVMe). ASPM
> with pwrctrl is already broken since 6.15. [1]

Actually, the 6.15 regression was fixed in 6.18-rc1 by the offending
commit, but pwrctrl devices will now also regress again.

> Reverting also a729c1664619 ("PCI: qcom: Remove custom ASPM enablement
> code") should avoid the new regression until a proper fix for the 6.15
> regression is in place.
 
Johan

> [1] https://lore.kernel.org/lkml/aH4JPBIk_GEoAezy@hovoldconsulting.com/

