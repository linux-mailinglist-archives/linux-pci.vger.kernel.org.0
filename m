Return-Path: <linux-pci+bounces-43835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F8ACE94E1
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 11:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1EBE300C0DD
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 10:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5C42D46D6;
	Tue, 30 Dec 2025 10:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQmWpnpv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EB82798F8;
	Tue, 30 Dec 2025 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767089298; cv=none; b=mnz7MvKUjTpFzpgQeqdNevevj8ZNnxhIg+6A1WZ+Y+ygfgpl/uKtxavWEmMG5iq9lsqO5h3cv08nuhgAcrjEi98Ufh01JtHWrQUNu4vJhDJxRPd+rluyk7FKClkFWUfKwd6kDs2ZayC6bu4VClP8dwtAtOjKYXpKxiXXGvVFB6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767089298; c=relaxed/simple;
	bh=VCYZ1Ywk8/iqxbTOPfsc7ToHjrPNV6mQNg/6UVuTfXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBhb12AJIj31mz3M/67hOEX4utiOMmvyBQ7lJ9MymvxnN4tmqGhbSIfR+4OZU41ueEgdJpTltdEElsgmgeC184bv4TPIjaKC8qa5SrXSb/CfwOW/M+Q4n7N7Zx0hDOryGSjRnbMnkLA39XnglozwO7XfN7/CJbEkehlG/9euCxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQmWpnpv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FC5C4CEFB;
	Tue, 30 Dec 2025 10:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767089297;
	bh=VCYZ1Ywk8/iqxbTOPfsc7ToHjrPNV6mQNg/6UVuTfXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQmWpnpvWO7tsqHZwjF9MUVUJaJcEuXbkfW+IaMC7ODXUqFp9SDr/zAxDLbWFUAyb
	 rw83Ald30cQGxv60vspfVJZlYD1xWG89WazAgXeJ8QZUj1lGq0H9qa+g20zg5tgVWX
	 o8DoYUryUD0MSLTh9I2tmfZYKvW12lJviIw8u/3/sDhjyTSGkPudIT33yLaOrOEO/d
	 6BkV15t3h2c+8brjiB1KChjXv2X6vzI6ubW1jeBw1YGQ/JwNm1l5yQft0B2a97tMNy
	 mkIEC9vERbzIR9WIXhqM//9AjJMLMmFucY8TpiEqaZ2dhgTpG9CFhKZSvKrN/Y5Ohq
	 Xn6ZOiLV5QHBw==
Date: Tue, 30 Dec 2025 15:38:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chen Wang <unicorn_wang@outlook.com>, 
	Han Gao <rabenda.cn@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 0/2] PCI/ASPM: Avoid L0s and L1 on Sophgo 2042/2044 PCIe
 Root Ports
Message-ID: <yko2amyugikkuo2fa4plmkghx3ygxlzjw5nmerw4jl5ah6jyi5@qos2t2y356ot>
References: <20251225100530.1301625-1-inochiama@gmail.com>
 <20251226163031.GA4128882@bhelgaas>
 <aVOfBNP3vy4Q52bZ@inochi.infowork>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aVOfBNP3vy4Q52bZ@inochi.infowork>

On Tue, Dec 30, 2025 at 05:45:39PM +0800, Inochi Amaoto wrote:
> On Fri, Dec 26, 2025 at 10:30:31AM -0600, Bjorn Helgaas wrote:
> > On Thu, Dec 25, 2025 at 06:05:27PM +0800, Inochi Amaoto wrote:
> > > Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> > > states for devicetree platforms") force enable ASPM on all device tree
> > > platform, the SG2042/SG2044 PCIe Root Ports breaks as it advertises L0s
> > > and L1 capabilities without supporting it.
> > > 
> > > Override the L0s and L1 Support advertised in Link Capabilities by the
> > > SG2042/SG2044 Root Ports so we don't try to enable those states.
> > > 
> > > Inochi Amaoto (2):
> > >   PCI/ASPM: Avoid L0s and L1 on Sophgo 2042 PCIe [1f1c:2042] Root Ports
> > >   PCI/ASPM: Avoid L0s and L1 on Sophgo 2044 PCIe [1f1c:2044] Root Ports
> > > 
> > >  drivers/pci/quirks.c    | 2 ++
> > >  include/linux/pci_ids.h | 2 ++
> > >  2 files changed, 4 insertions(+)
> > 
> > 1) Can somebody at Sophgo confirm that this is a hardware erratum?  I
> > just want to make rule out some kind of OS bug in configuring L0s/L1.
> > 
> 
> Hi Bjorn,
> 
> I have asked for the Sophgo staff, and they already confirmed this 
> hardware errata.
> 

Okay. If the hardware (Root Port) doesn't support L0s and L1, you should disable
the capability in the sophgo controller driver instead. You can use this as a
reference: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-qcom.c#n331

Quirks is mostly meant for PCI endpoint devices (sometimes Root Ports also if
there is no host controller driver).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

