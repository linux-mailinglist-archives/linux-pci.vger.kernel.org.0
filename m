Return-Path: <linux-pci+bounces-9100-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92260912F63
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 23:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED442825A2
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 21:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F4816D311;
	Fri, 21 Jun 2024 21:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujtG17W2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F53D770FB;
	Fri, 21 Jun 2024 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004890; cv=none; b=oNfE5Mqp8sVmyblUPSBnV0u6GVZqO7ZnPk6a6bGtNPf3KrUeHv8nqSs9MUhKirqicXd2hoG/bUnzqMY4NirKf8oxNp7tWxwG31ysswYc0fqrPixxdwN9uJB//PCXKfWW2X7I3EpZrmwjEuTO0xZGo8Xnw8d2CHMvzOkZEb2P1eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004890; c=relaxed/simple;
	bh=3Yl0WPJPIj05IofoVrZnhvJaFAT511jGI04C/99sCP0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rARGG1RzNVg0MLSkl4jkf21teTCLTwdLt2IQRPOYnE31rbSWMQnHINXovoNTMVvnckbZhztpJ6wsr5D8NzfqTkDRfaQaevglkIBsNQv0LKLjxeSRNOb7wCk3e8RbU7hnhS8mlRwCmrLD5ztvTWWX3nykIVfVlIPPEmGw5MnTtAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujtG17W2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCD8C2BBFC;
	Fri, 21 Jun 2024 21:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719004889;
	bh=3Yl0WPJPIj05IofoVrZnhvJaFAT511jGI04C/99sCP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ujtG17W2bPpVngw8mYMS2vhlNoGV8bG4R+mqWWGDgLWqO3IsCag1r67m2HjqlK6D+
	 rAeRlLvw+Xf1kPKuIWInOhKw0k2Um2vDQ4I/s4W2eWTqCAdPFMXvc3G2uOmisdfl2/
	 CYQ7nfhiTWbkLdwWAYWI2wPEdX0L2ht0bwQ/31bpbwLeSK+gUn5qQfSJUdT2Lj/q7t
	 V1f7FvZBRanU1zZC2GHwa9nrv9OmZe2w6ZnOR2Q0weBNulhcRdJEeNqoOzzdUMnQgP
	 35avdcfL+q3TMS+YuICIx5zEQ1Nx1zBSuh/qxuyqxncOiUI5n/geDAzn1yeuZMFbJH
	 crKTzcrcp0NKg==
Date: Fri, 21 Jun 2024 16:21:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, kernel test robot <lkp@intel.com>,
	linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: rockchip: Simplify clock handling by using
 clk_bulk*() function
Message-ID: <20240621212125.GA1406213@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621064426.282048-1-linux.amoon@gmail.com>

On Fri, Jun 21, 2024 at 12:14:20PM +0530, Anand Moon wrote:
> Refactors the clock handling in the Rockchip PCIe driver,
> introducing a more robust and efficient method for enabling and
> disabling clocks using clk_bulk*() API. Using the clk_bulk APIs,
> the clock handling for the core clocks becomes much simpler.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406200818.CQ7DXNSZ-lkp@intel.com/

Drop these two lines, as suggested in the test robot report:

  If you fix the issue in a separate patch/commit (i.e. not just a new
  version of the same patch/commit), kindly add following tags ...

This is a new version of the same patch, so it doesn't need those
tags.

The problem you're solving with this patch is that the clock handling
is too complicated.  The test robot didn't report *that* problem.

Since you'll repost for this, also s/Refactors/Refactor/ in the commit
log so this is in imperative mood:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.9#n94
https://chris.beams.io/posts/git-commit/

>  drivers/pci/controller/pcie-rockchip.c | 64 ++++----------------------
>  drivers/pci/controller/pcie-rockchip.h | 15 ++++--
>  2 files changed, 21 insertions(+), 58 deletions(-)

Nice reduction in lines!

