Return-Path: <linux-pci+bounces-41520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B0AC6B0F0
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 18:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B80964E2E88
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 17:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A66334D906;
	Tue, 18 Nov 2025 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/loyg9u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24E2349AE0;
	Tue, 18 Nov 2025 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763488213; cv=none; b=Uoo9/9WXkPTCtdtkoDUMK2v+N3qjAXuIL4JtkS89+cqHD9He/hd2Cw7Xf8q/fBLRnidBeX6/rV4wODjWVsuQQVEwHVb2643wy95YiLnXFy7bXO5St2YaIpeTbHyStt9vL66elKQVAMHLc4ji2/LRUlB7OjsFGI+q1fHoT8ebM/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763488213; c=relaxed/simple;
	bh=ZEunj4yri52IXhHshxtw1VSYREUT24C/11HBul8gL2I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=o3muGjlf5IHC0wtv6ogzD48Ida+XpuRFpt4R2fY2vzCQDakpQ/bbGNmlSxu0MtCXFhjNXiT01P+Gfnd5ZFUwp1fcxngTlG2J7FZPGSRA34x+4wkh6JVsqkbAlR2RFSOIrcq5rA4eiyHTwLklh9VfiDgEY4MDx2YbJxC+KOJ9k+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/loyg9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85E5C4CEFB;
	Tue, 18 Nov 2025 17:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763488212;
	bh=ZEunj4yri52IXhHshxtw1VSYREUT24C/11HBul8gL2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=h/loyg9uuJtbmzU0qLZHUeq/bPldjF+SJX+hIIS69jmmAVgKRbifIDQhy4R4a0TPP
	 sKPpLSg4GAGsxyTWzhtOUelUF7f16PVYkFnlWD/UXDJvKmURSTFSysmunxcEkPd1pR
	 +M/OjQOHmiY5F2vRusLxR9aFEl9We8xo6oRM9cVsF8LfDzypFUyuN/ILlFzAMZgqRd
	 jeCj5w4uJaErorKIH+KPl5h8i6YK4X3Gw/tNS0EQMbZb2zfud1sL7GZnQlpU77jjCc
	 tWjGZJMOawRsyz2UjAvguMUZDlHM1/tMjgccQuV//AzHwCH+CwZtEVJoMril070gA1
	 8IX3w4OqLCHrw==
Date: Tue, 18 Nov 2025 11:50:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-pci@vger.kernel.org>,
	"open list:PCIE DRIVER FOR ROCKCHIP" <linux-rockchip@lists.infradead.org>,
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v1 1/5] PCI: rockchip: Fix Link Control register offset and
 enable ASPM/CLKREQ
Message-ID: <20251118175010.GA2540980@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117181023.482138-2-linux.amoon@gmail.com>

On Mon, Nov 17, 2025 at 11:40:09PM +0530, Anand Moon wrote:
> As per the RK3399 TRM (Part 2, 17.6.6.1.31), the Link Control register
> (RC_CONFIG_LC) resides at an offset of 0xd0 within the Root Complex (RC)
> configuration space, not at the offset of the PCI Express Capability List
> (0xc0). Following changes correct the register offset to use
> PCIE_RC_CONFIG_LC (0xd0) to configure link control.
> 
> Additionally, this commit explicitly enables ASPM (Active State Power
> Management) control and the CLKREQ# (Clock Request) mechanism as part of
> the Link Control register programming when enabling bandwidth
> notifications.

Don't do two things at once in the same patch.  Fix the register
offset in one patch.  Actually, as I mentioned at [1], there's a lot
of fixing to do there, and I'm not even going to consider other
changes until the #define mess is cleaned up.

What I'd really like to see is at least two patches here: one that
clearly makes no functional change -- don't try to fix anything, just
make it 100% obvious that all the offsets stay the same.  Then make a
separate patch that *only* changes any of the offsets that are wrong.

I don't think there should even be an ASPM change.  The PCI core
should be enabling L0s and L1 itself for DT systems like this.  And
ASPM needs to be enabled only when both ends of the link support it,
and only in a specific order.  The PCI core pays attention to that,
but this patch does not.

Bjorn

[1] https://lore.kernel.org/r/20251118005056.GA2541796@bhelgaas

