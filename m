Return-Path: <linux-pci+bounces-26086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE664A919C4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 12:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DA5E7A172A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 10:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CB522E011;
	Thu, 17 Apr 2025 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isynGMiG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C0422DFBC
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744887081; cv=none; b=EKdtj/pMSL9K1a1rq9RmXbJO7I+s8o+BhnbBeD/606HB9IRGd40zkWOYQgDYFlPLKvjEisnB+LTMKKUS1W7ZmnN3jy8ZeWRZOBEc3CKoPz3Ki45aJCdBupVSN1TiaPLkoAuwHSMWjUV+yBgwNI7GGMhWmTpQBBMu1oNVg/wYot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744887081; c=relaxed/simple;
	bh=w2+g1NX7wWlo9CSoPsjKyOrgEH+RDOELr9+ZARryBwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvUJUz2scpLcnJslr2l4cdLlhJHZr8ddV0LMSB1zNO6w+cHwh06fPwUc8+c488wA4KD5+0hpcRnOEINSXEYCYissEH3BSr1jAeKP3OnMM4hxDQtMqcbBye8iTFT04i//KTsaN+auyyy6rIiW8beqP4bzTJFBTx1bimwod7irLcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isynGMiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755DBC4CEE4;
	Thu, 17 Apr 2025 10:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744887079;
	bh=w2+g1NX7wWlo9CSoPsjKyOrgEH+RDOELr9+ZARryBwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isynGMiGn9RmDZubA0lSht3/BYsxom4Voy5egIQVnM9nsx5IEo5VclimHVHqjwz6V
	 4KRg9E/2hsTQ/4+zY5v0WkIeViFSvkZWvw0z/W55W4je2XhWLMv6JzTTGrp/Tvl+Kn
	 CqGz1P1c15huRSG4kqEyRjfyM2BvD9WPqTMKgHXawpknAQxLDvSUVMH4YfUuYV/Sxb
	 B9rcIt42RYPoEW+bUuLz2Whsh0Q/GztHfHgmPvMqxNFfv01Qw7NFqW90hSiGNkTDAk
	 C82u4pMfcJnHZkdezRgB7tyKqeVgbztlUgm7wVGonvXpheQK9QJ9OlEOBK7IjCdxhu
	 ftE/1M0ysA4Tw==
Date: Thu, 17 Apr 2025 12:51:15 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Add system PM support
Message-ID: <aADdI7ByEImYy3Pq@ryzen>
References: <1744352048-178994-1-git-send-email-shawn.lin@rock-chips.com>
 <Z_5aib0WGKfIANj_@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_5aib0WGKfIANj_@ryzen>

On Tue, Apr 15, 2025 at 03:09:29PM +0200, Niklas Cassel wrote:
> On Fri, Apr 11, 2025 at 02:14:08PM +0800, Shawn Lin wrote:

(snip)

> > +
> > +	rockchip_pcie_ltssm_enable_control_mode(rockchip, PCIE_CLIENT_RC_MODE);
> 
> Here you are setting PCIE_CLIENT_RC_MODE unconditionally.
> 
> I really don't think that you have tested these callbacks with EP mode.
> 
> If we look at pcie-qcom.c and pcie-qcom-ep.c, dev_pm_ops is defined in
> pcie-qcom.c, but not in pcie-qcom-ep.c.
> 
> Perhaps it is starting to be time to have two separate drivers also for
> rockchip?

Hmm.. looking at pcie-tegra194.c, they do still have both RC and EP in the
same file, but they simply return -ENOTSUPP in the EP case:
https://github.com/torvalds/linux/blob/v6.15-rc2/drivers/pci/controller/dwc/pcie-tegra194.c#L2381-L2384

Perhaps you could do something similar?


Kind regards,
Niklas

