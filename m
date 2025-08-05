Return-Path: <linux-pci+bounces-33426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A606EB1B5D8
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 16:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BED9B7B0768
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 14:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF822798F0;
	Tue,  5 Aug 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+msLCQb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15CC277011;
	Tue,  5 Aug 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402370; cv=none; b=Ti1ZysyA7TVZbHvklq6OW5GN6GhSuTjW1fm+Fa0BTWFKtyWVAc98KyzfKGXeU70ijDKVHll/qA8HIo7I2yWfp3qvpM2VuSY0be9nN/i00RyP+0zwQt9KDgUPdCPCf+dzIXZE6PNkXoyhKSO0z5LjjJuoN1+4xNbMGj9bHKfnvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402370; c=relaxed/simple;
	bh=4V5dBQ+eBPCJ1smNjnAgZUg0T+QL4DB32r+LUoylzy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg95L7L/gyiiFisnU5GT9MuB/FMyAqojUy4pYQngJRYQEjL1OEMGwoeMTJt9NPad3eCHHfjTBFrIocJbn6fbQdEvpsmfHOe6ES9uqgcsSXDJp4vad+kXgKBWN9a4PrWDqHNd9YngREeKh6Yi0BkIS1eKGbuiw8z45VD0qlq8j5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+msLCQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6031C4CEF0;
	Tue,  5 Aug 2025 13:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754402370;
	bh=4V5dBQ+eBPCJ1smNjnAgZUg0T+QL4DB32r+LUoylzy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C+msLCQbJWncbbFJjxOGuHXbektWQ58Zvp45zhgaQzMpnkHSZ2xCeZuWcw1DzgacE
	 D6vkoQycXuMJZrNOS8IZH+cGe6O6m5hOEVEinLUVzNNwCFqvdclDd/ztaH6f5NzFLe
	 xKIwv5Tk5jsQyAontMhaPkrHI2TCLgRo776taGXBe+Elqu0bbqXDr6WhAg85KpyJcY
	 Oi+Y6VS8rFsoRQTqtGwfsOd1pA+g+ME+x0yWYakW5uDjczwXMMQLIUSBGH9DbtvH1D
	 Tgn7bYwqbrJPd6NP5qK0n34074NDyHK5/3VMpDXFvbigSWZefKkFeWNHUVXQlXwaAV
	 HQj3URE/YfcIA==
Date: Tue, 5 Aug 2025 09:59:27 -0400
From: Sasha Levin <sashal@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, toan@os.amperecomputing.com,
	kwilczynski@kernel.org, mani@kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.16-6.6] PCI: xgene-msi: Resend an MSI racing
 with itself on a different CPU
Message-ID: <aJIOP1GO8LumDZOJ@lappy>
References: <20250805130945.471732-1-sashal@kernel.org>
 <20250805130945.471732-59-sashal@kernel.org>
 <86fre5aoqz.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <86fre5aoqz.wl-maz@kernel.org>

On Tue, Aug 05, 2025 at 02:20:52PM +0100, Marc Zyngier wrote:
>On Tue, 05 Aug 2025 14:09:34 +0100,
>Sasha Levin <sashal@kernel.org> wrote:
>>
>> From: Marc Zyngier <maz@kernel.org>
>>
>> [ Upstream commit 3cc8f625e4c6a0e9f936da6b94166e62e387fe1d ]
>>
>> Since changing the affinity of an MSI really is about changing
>> the target address and that it isn't possible to mask an individual
>> MSI, it is completely possible for an interrupt to race with itself,
>> usually resulting in a lost interrupt.
>>
>> Paper over the design blunder by informing the core code of this
>> sad state of affairs.
>>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> Link: https://lore.kernel.org/r/20250708173404.1278635-11-maz@kernel.org
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>
>> LLM Generated explanations, may be completely bogus:
>
>s/may be//. It is an amusing read though, specially when quoting
>totally unrelated patches, so thumbs up for the comical value.

Yeah, it's still very much at the "junior engineer" level, but honestly
I think that just the boolean yes/no answers out of it provides a better
noise to signal ratio than the older AUTOSEL.

>But I'm not even going to entertain explaining *why* backporting this
>patch on its own is nonsense. Reading the original series should be
>enlightening enough.

Sadly it doesn't have the context to understand that that specific
conmit is part of a larger series. That information just disappears when
patches are applied into git.

I'll drop it, thanks!

-- 
Thanks,
Sasha

