Return-Path: <linux-pci+bounces-43728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CF2CDED1B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 17:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 611083005FC7
	for <lists+linux-pci@lfdr.de>; Fri, 26 Dec 2025 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7047B1EB9E1;
	Fri, 26 Dec 2025 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI7CnZ5Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472B31419A9;
	Fri, 26 Dec 2025 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766766633; cv=none; b=BSHWTVZ9DyPaQ9EEK3ExJejhY1AFtADxvazlCGVFXBlH5FACxNENIJz1eC0g1EKTlreL+ChBBmEHNANfbapgjY1AFaRbg5BlDjA1vt4aN/ov7OXja3R0t6wNsscnXAXschVtUOcmAyCsurrgM/RjzKySmU8aljR3mJLs4seSLDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766766633; c=relaxed/simple;
	bh=uvsx8WxLRZ3PtN1KZABwOvkS92CrI/Tm2GTJsLeWG00=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fMaI+kNN6/4GsPMx3blPIxzjs9SWbspxZ58aD1SstUXF71tg2gwMZRjx/HGDklYA0eUfXxcCJTixZdsSyym2h5J1hCjEzD2WZem1mh67sE9Q1dNy3ki8CBHcYMxaqVUK3kSTrZdZ7HKTkgotWws59yobL//AWKaY7E8NxeicKAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aI7CnZ5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2098C4CEF7;
	Fri, 26 Dec 2025 16:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766766632;
	bh=uvsx8WxLRZ3PtN1KZABwOvkS92CrI/Tm2GTJsLeWG00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aI7CnZ5YCc8+hQKM5/GzyJyXdDwd8UxwqnEyn+0b2+wHXBJeCVSY77PNQIenZRzqG
	 oFZo6Z1OWcnPnANpvUWbGG2NvyZK+f7R018SiQtaYUlYiFHnadXvRbUHiLAncTcbv/
	 KWytvq4h5Zp+MdODG7JvneIW8CBJV/R/6Oc7Of0EsZVQU6j5h0KxDR18wACrNTL/hj
	 KDbxIGjvePzrFp5iy27jSLzJbteUBJQkubYOcOxcvaC4xrUa1PXMbRepLRpHpm5KvP
	 1CXNlX5SkiqXHQRbcA9mwk/fSvsvPb51cPsrAh+kPtnn0Wvxww3Fpw04WgKImN5SEI
	 B3ucN4wet+0hA==
Date: Fri, 26 Dec 2025 10:30:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 0/2] PCI/ASPM: Avoid L0s and L1 on Sophgo 2042/2044 PCIe
 Root Ports
Message-ID: <20251226163031.GA4128882@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251225100530.1301625-1-inochiama@gmail.com>

On Thu, Dec 25, 2025 at 06:05:27PM +0800, Inochi Amaoto wrote:
> Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> states for devicetree platforms") force enable ASPM on all device tree
> platform, the SG2042/SG2044 PCIe Root Ports breaks as it advertises L0s
> and L1 capabilities without supporting it.
> 
> Override the L0s and L1 Support advertised in Link Capabilities by the
> SG2042/SG2044 Root Ports so we don't try to enable those states.
> 
> Inochi Amaoto (2):
>   PCI/ASPM: Avoid L0s and L1 on Sophgo 2042 PCIe [1f1c:2042] Root Ports
>   PCI/ASPM: Avoid L0s and L1 on Sophgo 2044 PCIe [1f1c:2044] Root Ports
> 
>  drivers/pci/quirks.c    | 2 ++
>  include/linux/pci_ids.h | 2 ++
>  2 files changed, 4 insertions(+)

1) Can somebody at Sophgo confirm that this is a hardware erratum?  I
just want to make rule out some kind of OS bug in configuring L0s/L1.

2) Why don't we have a MAINTAINERS entry for this driver?  I failed to
notice that the series we applied
(https://lore.kernel.org/all/cover.1757643388.git.unicorn_wang@outlook.com/)
does not include a maintainer.  Chen, since you posted that series,
are you willing to sign up to maintain it?

Bjorn

