Return-Path: <linux-pci+bounces-43520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B895CD5E17
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 12:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58CA3300A358
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 11:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F1532F743;
	Mon, 22 Dec 2025 11:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNw7RytL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8425F32E730;
	Mon, 22 Dec 2025 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766404352; cv=none; b=PGjHLsHFqy++TXZOxQOWgp61tIMZ+L8EIxhKQig4xBeYJQJ+9zCaDE79/6KzNc9vrSFh1+T6l491BfrwHJVf2Nn5VouITN/POdQ28bWB6xBABqOGoUpPAoFwYVU4vTrQlap2f8KoY4obFR/8G2KSeVSMTW2yIW9HiieVBBply+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766404352; c=relaxed/simple;
	bh=vg7/adpD/1uCZFZ5FETf5AMIGjbfdcAZDucMWV87Hzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+L7aKAiRsR1JWO1NV4B4Jz+X3o/R74EfhQZNWF4g3gSwOnpGIuS1/2nhZxN1X6fbe/vd0YUQPXw4Iv7Wk9P8dP8mPZ87Sjey3F7Rbl7VhQKJBsCnticzjHn97Yq9yYFSUOJkFYlfSjV2RbNhbRV1tdC+o34edtxpMf2EBCltqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNw7RytL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2AAC116C6;
	Mon, 22 Dec 2025 11:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766404352;
	bh=vg7/adpD/1uCZFZ5FETf5AMIGjbfdcAZDucMWV87Hzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNw7RytL0T22OBM0RlgrShS40Ffh4GGreYAu9fE930EHChGuPXlRHHsH9ZaxfxbBO
	 J4VrHHDQFuPe9+8bfw/CBX4Fr0AM85r8bwb8QzHN8iUUrhTiUiQ7RMv0bnkMJVBoU0
	 efDSWoa5GMWVsTmdFYjuBB4KahHLWPFInOZZwjomKiGoc0OW7QBH/VVFqGKyEWPd2r
	 J2U4sXrNbh8g0mr/kdUyDMlOs/8vvV1O6FTEkVVDPOGiwFCOlyPYUnE/tzw96TuOxK
	 W4MTkYlhRyetbKHqYN2VrOyzfvcEm5IyrLPvmnwEIsRFCouo2JQqit0Auw71DlVZx8
	 TqTPStguUYjFQ==
Date: Mon, 22 Dec 2025 17:22:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>, Damien Le Moal <dlemoal@kernel.org>, stable@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 5/6] Revert "PCI: qcom: Enumerate endpoints based on
 Link up event in 'global_irq' interrupt"
Message-ID: <xgmb6yllvoowfap5j55x4pd2j6a5k547s2qb72ektrddh2kujo@ueohphquccve>
References: <20251222064207.3246632-8-cassel@kernel.org>
 <20251222064207.3246632-13-cassel@kernel.org>
 <efa4b3e2-7239-4002-ad92-5ce4f3d1611b@oss.qualcomm.com>
 <aUjv2FwfoDqNMKoR@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aUjv2FwfoDqNMKoR@ryzen>

On Mon, Dec 22, 2025 at 08:14:32AM +0100, Niklas Cassel wrote:
> Hello Krishna,
> 
> On Mon, Dec 22, 2025 at 12:21:16PM +0530, Krishna Chaitanya Chundru wrote:
> > Removing patch 3/6 should be sufficient, don't remove global IRQ patch, this
> > will be helpful
> > when endpoint is connected at later point of time.
> 
> Please see Mani's reply here:
> https://lore.kernel.org/linux-pci/fle74skju2rorxmfdvosmeyrx3g75rysuszov5ofvde2exj4ir@3kfjyfyhczmn/
> 
> "And neither the controller driver."
> 
> Sounds to me like he still wants this patch
> (which removes the support from the controller driver).
> 

Yes, allowing hotplug for a non-hotplug Root Port is a bad idea. Too bad that I
proposed it in the first place... Let's revert for all platforms to avoid
setting bad precedence.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

