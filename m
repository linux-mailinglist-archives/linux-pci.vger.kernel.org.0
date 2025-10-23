Return-Path: <linux-pci+bounces-39201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BA2C03665
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 22:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E5EEE4EC52F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 20:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A74218AD4;
	Thu, 23 Oct 2025 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3ytV2vZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A302917C21C;
	Thu, 23 Oct 2025 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761251865; cv=none; b=Jc6wPfKv/vqMWao3efsBX7+NYLHz6j8EPOCpPadacFUv5aBgRf/w3EH6XbFUrcdB3s/yIV1FsT7VMYC9QqwE1e06HTaMVUuZFKW+omwFtDY+OcYWBYLyVT2uo1Jz9IyBJhrY62QJDSz1rvQu/qvTfZFX9gIyhh2oMKxHOyxQlTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761251865; c=relaxed/simple;
	bh=2YM0+zsZqGChetS9GwXiepmm69IizY2zwtiVz39WIsI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GsK5HiPWpzgOJm9aRy15MzMDwzeX6vcwfbuyD++dkZcU51QIa8Hj3GxdpFKH4pfelFpGaa2ohGpEZ27i76v/AFffmoqKKPZ0n44tjGpMN6XhscWxuIQTFkWNWWOH/PgeDX2ygBIy8Ek3DEyqD6gfXnvaAtxAD1HoGS5wL5GA9Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3ytV2vZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB97C4CEE7;
	Thu, 23 Oct 2025 20:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761251865;
	bh=2YM0+zsZqGChetS9GwXiepmm69IizY2zwtiVz39WIsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=h3ytV2vZuMNv8NoTWdIl5ICqjQTyzWf22mdhyoQLj6r6nQTkeuImhgjjVp+9kAsea
	 u/KtDwgCJX7Rv5r5N8EmyG/qFIzkjgRzfL79dc5OSALqP4VnXy+rk7HVW73zoDfRm3
	 MLD5BEPsiDjqUXqb627Wsfl+m8sUplWrlcPyHz9YkdbTXB7LKnj49VlwA99i5KbSNj
	 g36nO+KzdgUVocdlOSqwj7dZfHLbJgV7FuGC1O12G3dJaX/okmmegIjm0SA9ByE0YL
	 WcNv4RrCiz868Z38yxnQ0rQXAFQcBAaVHfsK6Se/ACNsHmKKVCspkE0nuLYKvLtkBV
	 bWYzcXP4eN/ew==
Date: Thu, 23 Oct 2025 15:37:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	linuxppc-dev@lists.ozlabs.org, linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
Message-ID: <20251023203744.GA1314513@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da79f38f-fdb9-0101-67cc-144ef8d6e1d1@manjaro.org>

On Thu, Oct 23, 2025 at 08:27:25PM +0200, Dragan Simic wrote:
> On Thursday, October 23, 2025 20:06 CEST, Bjorn Helgaas <helgaas@kernel.org> wrote:
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
> > 
> > I think it will fix the issues reported by Diederik and FUKAUMI Naoki (both
> > on Rockchip).  I hope it will fix Christian's report on powerpc, but don't
> > have confirmation.  I think the performance regression Herve reported is
> > related, but this patch doesn't seem to fix it.
> > 
> > FUKAUMI Naoki's successful testing report:
> > https://lore.kernel.org/r/4B275FBD7B747BE6+a3e5b367-9710-4b67-9d66-3ea34fc30866@radxa.com/
> 
> I'm more than happy with the way ASPM patches for DT platforms and
> Rockchip SoCs in particular are unfolding!  Admittedly, we've had
> a rough start with the blanket enabling of ASPM, which followed the
> theory, but the theory often differs from practice, so the combined
> state of this and associated patches from Shawn should be fine.
> 
> Thank you very much for all the effort that included quite a lot
> of back and forth, and please feel free to include
> 
> Acked-by: Dragan Simic <dsimic@manjaro.org>

Added your ack; thanks for all your help!

