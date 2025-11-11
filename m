Return-Path: <linux-pci+bounces-40914-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F312EC4E451
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 15:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72B2A4E896A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 14:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61C1359FAA;
	Tue, 11 Nov 2025 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK6yS3ik"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93733451C6;
	Tue, 11 Nov 2025 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869607; cv=none; b=aP8kodhbJk3p/J9PTDZR7RO+ull/SlYDVXm7yvJuBv/Bjsy8z1tLNlVkIKCHH/cepfX5f3lNRzFrN2y/JO7CkbxC7EfggL/hpVv5fFPP5/U88cUYvCzrUN86WWdDH7qdXcUzIBEUgjE3L2xUIwjvtzqtYbuyCa/shid2MEbVAQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869607; c=relaxed/simple;
	bh=D1S3OL4p0+J4mWcZ2dm1aw9L5R0M+rOLhxjglXPSaEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGaLNvVdQGE4K200Txnaaq+EGRGvjGLHGCVe0u4n84btaWTweJrnkjdQDP0uyLCVqHTzIGr3GfQ2SLKV1rA6XZQRDAmkRMPtM+qEm1IYu3aKiDcsVHQYKc+C4orfup06g29JQH8vKl5WAEDlfhYm7pJKbSyPRB3FPAyvbp/jW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK6yS3ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B6CC113D0;
	Tue, 11 Nov 2025 14:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762869607;
	bh=D1S3OL4p0+J4mWcZ2dm1aw9L5R0M+rOLhxjglXPSaEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BK6yS3ikNQGdeSm87kJZrIJJ2XY6POhOH7MZmL27V0Z5S3dw3nYncaxgaHcY1Lu+F
	 JfFL1HyiOjKsoFotilBRDoOwnVtfEN+Am17dFZfdhl0iJzjCla5OqcEAQDJEoJm/UW
	 zQl/cTwTmOjKHw9ttl9MFYwgAmc2524Srxq/IfABJDKxLrba4bc4JT3yXrBsZMKi5H
	 Da2hh7/+bYFZH+VSJUbPQjShpd8y+P5ZonC8DCmnRcV2ZQTaP9oh5X/y2e05XA9pX1
	 V2vT6CqyqJnODCdbHc0Dsnc313OsQ0rZJdxY80KZzyZZThukX8LeGbI/ySB71OPEQO
	 kUp8PlC3G+pJQ==
Date: Tue, 11 Nov 2025 15:00:01 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, Damien Le Moal <dlemoal@kernel.org>,
	Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	Dragan Simic <dsimic@manjaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [RESEND] Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
Message-ID: <aRNBYX8MbR7PtssY@ryzen>
References: <780a4209-f89f-43a9-9364-331d3b77e61e@rock-chips.com>
 <4487DA40249CC821+19232169-a096-4737-bc6a-5cec9592d65f@radxa.com>
 <363d6b4d-c999-43d4-866e-880ef7d0dec3@rock-chips.com>
 <0C31787C387488ED+fd39bfe6-0844-4a87-bf48-675dd6d6a2df@radxa.com>
 <dc932773-af5b-4af7-a0d0-8cc72dfbd3c7@rock-chips.com>
 <aRHb4S40a7ZUDop1@ryzen>
 <2n3wamm3txxc6xbmvf3nnrvaqpgsck3w4a6omxnhex3mqeujib@2tb4svn5d3z6>
 <aRJEDEEJr9Ic-RKN@fedora>
 <B721C8A516FDB604+a04b38d3-64ec-423f-9e4c-040c8d2aec76@radxa.com>
 <05bd0efe-9a84-40e9-af07-51c0b0d865bf@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05bd0efe-9a84-40e9-af07-51c0b0d865bf@rock-chips.com>

On Tue, Nov 11, 2025 at 11:17:23AM +0800, Shawn Lin wrote:
> > 
> > It works stably on the ROCK 5A. The link speed is 2Gb/s.
> > 
> > The ROCK 5C is unstable. It initially worked with a link speed of 4Gb/s,
> > but eventually started showing kernel oops. The dts files for the 5A and
> > 5C are compatible and interchangeable, but even using the 5A's dts on
> > the 5C, the operation remains unstable.
> 
> The link speed on ROCK 5A is 2Gb/s also means it's downgraded now. Did
> ROCK 5A work under the link speed of 4Gb/s before?
> 
> In case it's signal integrity relevant, you could enable PCIE_DW_DEBUGFS
> and refer to Documentation/ABI/testing/debugfs-dwc-pcie to collect
> RASDES info from there.

Just a quick note:
I've noticed that you cannot blindly look at the link speed in dmesg.

E.g. on my ROCK 5B boards, I can occasionally see something like:
[    1.417181] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x1 link

However, if I check the actual link speed with lspci after boot:

# lspci -vvv  -s 0000:01:00.0 | grep LnkSta:
                LnkSta: Speed 8GT/s, Width x4

I can see that the link is actually using the correct speed + number of lanes.


Kind regards,
Niklas

