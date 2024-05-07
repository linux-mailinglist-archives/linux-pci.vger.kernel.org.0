Return-Path: <linux-pci+bounces-7204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DED88BF32B
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 02:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23DEA1F2116B
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 00:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C383E85C5E;
	Tue,  7 May 2024 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPH4ucDh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE1A86268;
	Tue,  7 May 2024 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715125740; cv=none; b=J+FhxT8O7kDOjFVMPqlphZk7omfG337b45DXlsNvv2wdNzdgRgHiDFbXOkNyFfhPgNJ6sbTa8b2B+G5MzV8rSXvHCEcgIQ2YTTTr7MA2ebFvLo8qxEJtVBHz8eyMXg9mM6r7eZ97lFBGfXMfP3uwC72LOqS8v1pVJfI7/McVLrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715125740; c=relaxed/simple;
	bh=noVNgvWjzAT0Hiwx4C0UMc3fu1gXKLlhnK+/oON4fBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWzQfPUnLe0fyHEPqAEA0FIlbnF4zN/eTnkKEqJXqXewy+qoNpVwLnKJNR0nIAWoLGBwW/Lf6kDQm6kNMgVS5P3Lm0HU+83vSZ8fOTEvt95iwMpFeycz/H5nXQy4FP+4q7Kttje7UtLAYCfnglBrJJcJBJZxiixQ8HBCmwc0uuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPH4ucDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5C1C2BBFC;
	Tue,  7 May 2024 23:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715125740;
	bh=noVNgvWjzAT0Hiwx4C0UMc3fu1gXKLlhnK+/oON4fBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PPH4ucDhv4ZX/JyqUyq9R/QxhYRa1e5eDijcrK4DpNHrMSpsqfnLlWPAU/QSZS1VG
	 Cz551IMTUFtu8kQhE54Xkp3RRWwhUJRwZyEVlJ0s9+Hj6b+wvP5tTSEYZScaXQasAo
	 /fRsOXMjjvbriUxX0qYT/a9G5ub6USYADmMSwOwxD1K/oQSGfJF+LX1byrKjUY/xUS
	 gukVTkqNEIMK18Twypr8FXDLFDsy34uRX2Otw1UbUJrVu/fR/SRPoRCNnZAMHFLa+1
	 ECDODpcuLdFVud7/Y9fasVd5n70zGfWAH550ZATQeR8ReAHe6T0LeNWmiMC4Z4bkMF
	 u1pV70A2xmLjg==
Date: Wed, 8 May 2024 01:48:53 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 00/14] PCI: dw-rockchip: Add endpoint mode support
Message-ID: <Zjq95dc1odHpNRn7@ryzen.lan>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
 <20240504170537.GC4315@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240504170537.GC4315@thinkpad>

Hello Mani,

On Sat, May 04, 2024 at 10:35:37PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 30, 2024 at 02:00:57PM +0200, Niklas Cassel wrote:
> > Hello all,
> > 
> > This series adds PCIe endpoint mode support for the rockchip rk3588 and
> > rk3568 SoCs.
> > 
> > This series is based on: pci/next
> > (git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git)
> > 
> > This series has the following dependencies:
> > 1) https://lore.kernel.org/linux-pci/20240430-pci-epf-rework-v4-0-22832d0d456f@linaro.org/
> > The series in 1) has not been merged to pci/next yet.
> > 
> > 2) https://lore.kernel.org/linux-phy/20240412125818.17052-1-cassel@kernel.org/
> > The series in 2) has already been merged to phy/next.
> > 
> > Even though this series (the series in $subject) has a runtime dependency
> > on the changes that are currently queued in the PHY tree, there is no need
> > to coordinate between the PCI tree and the PHY tree (i.e. this series can
> > be merged via the PCI tree even for the coming merge window (v6.10-rc1)).
> > 
> > This is because there is no compile time dependency between the changes in
> > the PHY tree and this series. Likewise, the device tree overlays in this
> > series passes "make CHECK_DTBS=y" even without the changes in the PHY tree.
> > 
> > This series (including dependencies) can also be found in git:
> > https://github.com/floatious/linux/commits/rockchip-pcie-ep-v2
> > 
> > Testing done:
> > This series has been tested with two rock5b:s, one running in RC mode and
> > one running in EP mode. This series has also been tested with an Intel x86
> > host and rock5b running in EP mode.
> > 
> > BAR4 exposes the ATU Port Logic Structure and the DMA Port Logic Structure
> 
> Is this for configuring the EP from host? Just curious.

That is what I assume as well.
(As I cannot come up with any other reason why they have done this.)


> > pci_epf_test pci_epf_test.0: READ => Size: 1024 B, DMA: YES, Time: 0.000177625 s, Rate: 5764 KB/s
> > pci_epf_test pci_epf_test.0: READ => Size: 1025 B, DMA: YES, Time: 0.000171208 s, Rate: 5986 KB/s
> > pci_epf_test pci_epf_test.0: READ => Size: 1024000 B, DMA: YES, Time: 0.000701167 s, Rate: 1460422 KB/s
> > pci_epf_test pci_epf_test.0: READ => Size: 1024001 B, DMA: YES, Time: 0.000702625 s, Rate: 1457393 KB/s
> > 
> 
> Thanks a lot for sharing the pcitest results in the cover letter.

Thank you for the review!


Kind regards,
Niklas

