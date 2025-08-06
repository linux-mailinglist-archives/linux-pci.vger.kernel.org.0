Return-Path: <linux-pci+bounces-33490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51C1B1CEAE
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 23:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D55A179425
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 21:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62F322C32D;
	Wed,  6 Aug 2025 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTNl1MEG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C77C1E5B88;
	Wed,  6 Aug 2025 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754517150; cv=none; b=t+9z9HdqC1q3TsqGwXPhh7sUkiy39UH2jH674PATOA6gVufn75Sd97J0T1DAOhhQIlJdKH7T0VWgVwV+oGVCgm+P4lnApshANn/nbZpbFVF4szbI3V0duxFszR73jIx2zFJLPEYfILQbpvWVVK7BjBNa+fc1SGrTicfmMHtk6BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754517150; c=relaxed/simple;
	bh=T0eitd60fDJRGs9O0BFk1ub1fCf0+D8W5+IKuaDejwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Biu+qHC4qupt/17oiLZ9wsEoUzCKABLa51xBgoJtId4jD90pHHl0LRsWZ5isj/sDieRV4ISYm86xz480Ek0vyJXxdQfcrUXq9rVC2ojN+N+WO4QrnNLm5uuQ67esG8t6vcTMgOTeNeB7c0AQ3Eh6JgiSBho8OeIhdc/zpESGm6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTNl1MEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628CEC4CEE7;
	Wed,  6 Aug 2025 21:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754517150;
	bh=T0eitd60fDJRGs9O0BFk1ub1fCf0+D8W5+IKuaDejwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DTNl1MEGWsAdp8Vvj2gAMfCMRW13XzWTPSGRugZh7JXJXCfZToMb3ktraA4qn1W32
	 2iV45QpnzV0UmjYR3dooM+A+4JV3HWU2KknmgpetavTqOrzRcqhvEydiisdMEWKZgo
	 nrQqfu0ajHTfAX1OG4hOye5Iv805Mn9MDSthtAq/0ioNszit+Fdgx8TVmBB4ySgdvc
	 ETGsS5dgmhpgOJL99ijo7ajrdYXE7yuyLIwdaQ76whzjegkflNS08AYYiPS7n0RVMY
	 nhHmCUPwkKPvL8ILTVlyOEH4T8GZ1WzhDmH3zYTfGQ2MmE/G8rSFzzqqUW5zs21Avi
	 PKbdUa7RtnsZA==
Date: Wed, 6 Aug 2025 15:52:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Hongbo Yao <andy.xu@hj-micro.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	jemma.zhang@hj-micro.com, peter.du@hj-micro.com
Subject: Re: [PATCH] PCI/DPC: Extend DPC recovery timeout
Message-ID: <aJPOmw2c8LGW2qN7@kbusch-mbp>
References: <aHCPTU03s-SkAsPs@wunner.de>
 <20250806213409.GA19037@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806213409.GA19037@bhelgaas>

On Wed, Aug 06, 2025 at 04:34:09PM -0500, Bjorn Helgaas wrote:
> > > However, the current 4 seconds timeout in pci_dpc_recovered() is indeed
> > > an empirical value rather than a hard requirement from the PCIe
> > > specification. In real-world scenarios, like with Mellanox ConnectX-5/7
> > > adapters, we've observed that full DPC recovery can take more than 5-6
> > > seconds, which leads to premature hotplug processing and device removal.
> > 
> > I think Sathya's point was:  Have you made an effort to talk to the
> > vendor and ask them to root-cause and fix the issue e.g. with a firmware
> > update.
> 
> Would definitely be great, but unless we have a number in the spec to
> point to, they might just shrug and ask what the requirement is.

I agree, and I have similar problems with other arbitrary kernel timing
decicsions. Specifically RRL where there's no spec defined number yet my
patch to modify it has not received much consideration.

  https://lore.kernel.org/linux-pci/20250218165444.2406119-1-kbusch@meta.com/

