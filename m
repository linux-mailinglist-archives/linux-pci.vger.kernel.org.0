Return-Path: <linux-pci+bounces-45153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B46AD3A16F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 09:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EBAA306C741
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 08:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB984242D86;
	Mon, 19 Jan 2026 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcrbC98R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948033FEF;
	Mon, 19 Jan 2026 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768810758; cv=none; b=AguxmpNUv/angHIlkbDvYtqBfzPM5E0fL+KdbytSnZEcHzT1LCYICyspB656NvFHRMMvuQUju8zAkwE3LW3IjOWvxFsFeYpxuFrfSwORyTA7gYA8x/HAjCeSZ/pAlwVSDk6tlSr3Ut+QUmLzGificq6KAHXAlUoiFHrtA5z53k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768810758; c=relaxed/simple;
	bh=KnZdaxE92jWhgcahWpcW1Rw0cpfimRfmShRC4yQuhFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCwH76zQFmftvUf7k8p5mreu6KAEd6YdvnUOvrNhVVXDKc8sMeux/+MJGJOmUxe3G+KYnz4AOKmApkT4rBAUs6QQv66XEjzYh7YPTFrgLyxrCF360rtg7Bmv6cZB2+Xyv1dxVx8ZSEk1fLjeJONNdM6i3cF0iKckkwb/Rl6Ebtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcrbC98R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E46C116C6;
	Mon, 19 Jan 2026 08:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768810758;
	bh=KnZdaxE92jWhgcahWpcW1Rw0cpfimRfmShRC4yQuhFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XcrbC98RoIX7bAtmn6KsYQ5JJuJKDZp+ID7EqV3TmcY7ENSUA0pMyi3XccUImgNcu
	 1e+C2iuXfVsurXF1vopPUnMH/Z69SZdydbBpB+P8jOuIH3f1y/dXRIU9X+iFbMF6uz
	 6Zo2qC3PkIrqj3e1xzJQFcbf7epFyjEgroYrAtk7UHAN6oQAVGZCTYRm0ZochvWAck
	 djeizrCyv3JYK17pqNfPOU0a9omzW5w/SrCwH2CGaU06EqLddKRzevMqV5uiRkBFiZ
	 8KHjbJPA9YFNDnK/n3beVOV3mWhACZ3r1NG6itw2xOKcE/UzAIyyQp7GCXxs0d4JCN
	 0LtpfDO81RYaA==
Date: Mon, 19 Jan 2026 09:19:12 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/6] irqchip/gic-v5: Code first ACPI boot support
Message-ID: <aW3pALPxn4i9fiDO@lpieralisi>
References: <20260115-gicv5-host-acpi-v3-0-c13a9a150388@kernel.org>
 <aWy9T3VDyXpVG41z@lpieralisi>
 <87sec30yhk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sec30yhk.ffs@tglx>

On Sun, Jan 18, 2026 at 03:47:03PM +0100, Thomas Gleixner wrote:
> On Sun, Jan 18 2026 at 12:00, Lorenzo Pieralisi wrote:
> > I have noticed you pulled this seris into tip (thanks !) - there
> > is a strict dependency on ACPICA patches in [6] though as I tried
> > to convey with the paragraph above and dependencies below:
> >
> > prerequisite-message-id: <12822121.O9o76ZdvQC@rafael.j.wysocki>
> 
> Duh. I completely missed that.
> 
> > I don't know what's best/easier to handle this dependency but it is there,
> > I don't want it to cause you any trouble so I reported it as soon
> > as I noticed.
> 
> I zap it from my tree for now until that's sorted.

Hi Rafael,

I think the simplest way to sort this out is for this series to go via
the ACPI tree if that's OK for Thomas, given that the ACPICA code will
go via the ACPI tree anyway and there are other dependencies on it there
I assume (this series is fairly self-contained).

Or I can hack together a patch that provides the ACPICA structs needed in an
irqchip header file, conditional on the ACPICA version, add it to this series
and remove it at 7.0-rc1, it does not make much sense to create this churn
given that ACPICA code will be merged this cycle but it is doable.

Please let me know how we can handle it.

Thanks both !
Lorenzo

