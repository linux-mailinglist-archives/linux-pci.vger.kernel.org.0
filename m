Return-Path: <linux-pci+bounces-20454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B15AA20A2D
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 13:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA2D3A5052
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 12:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C120219C552;
	Tue, 28 Jan 2025 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrP7TSZY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958A91A23A1;
	Tue, 28 Jan 2025 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738065878; cv=none; b=kuHzfn8TEO6opdWQaXNtdorROyAymF/LWtKPTzLP8l60gjg3UnsuyUUeaNTrOO9qXEX0/TAlMlVSMWEDERNYZozN4tRSJ7yUGCQpUQRKCG1sn7CrLfjWh/DWNm3JkcCfWMQUlWTpazupsG2YhS6ALmlh/Q6+J6Qq3P+wAtZ9/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738065878; c=relaxed/simple;
	bh=xrCGdGKW5rp4Inj+mxs5c8zCwp3016KPF96b0NrC7Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBsX7oInRVxIbk7rWGOTxJIRdtCU94LInY4CetPVBnDYcviCEJTh4YaEc78hs7FZGfBsHltCHH/msIzF8nQSARzujcBD7YUaZKGFzZepuQfs2Ad/zzPlTKtojSUkbp8SNQaP855bsnMmUl0kxE49A2HGKRNHdHW2aRfJ2qDQJos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrP7TSZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBCFC4CED3;
	Tue, 28 Jan 2025 12:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738065878;
	bh=xrCGdGKW5rp4Inj+mxs5c8zCwp3016KPF96b0NrC7Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SrP7TSZYh4A2UCnBx/FYxwN72wSwjt2Fdf/6XnFrzeWLZM1ARzqGXa/I7r5q8JeuX
	 ZyGhJUP1WN6/bE++U7/8mLuwVl3KMwrr2y6sfbzvxZLhU00MmrTRYcKpa/N7bCW/Sy
	 WNOHuDKRRcLZIlX2eZ1MrukjfFF8c1i+Wcz16X8/GV03FdRqMMJhkj3D2j7aScTunU
	 lKTMD/C4fgnEyJFFbOIatH8jlCaTuFB1vLav3A+t+rtaSYQpAhTBnGHkugpYrMK1rr
	 1T7ifUkIFOcY4RNXhuwXHkqLIwRaC61GIGxoQocxzj3/dz3Z8+k3sZ+GuYBfIWLW6s
	 ZPiQSbMV3myAg==
Date: Tue, 28 Jan 2025 13:04:32 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, quic_schintav@quicinc.com,
	johan+linaro@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
	sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: tegra194: Add support for PCIe RC & EP in
 Tegra234 Platforms
Message-ID: <Z5jH0G3V7fPXk0BG@ryzen>
References: <20250128044244.2766334-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128044244.2766334-1-vidyas@nvidia.com>

Hello Vidya,

On Tue, Jan 28, 2025 at 10:12:44AM +0530, Vidya Sagar wrote:
> Add PCIe RC & EP support for Tegra234 Platforms.

The commit log does leave quite a few questions unanswered.

Since you are just updating the Kconfig and nothing else:
Does the DT binding already have support for the Tegra234 SoC?
Does the driver already have support for the Tegra234 SoC?

Looking at the DT binding and driver, the answer to both questions
is yes. (This should have been in the commit message IMO.)


But that leads me to the question, since there is support for Tegra234
SoC in the driver, does this means that this fixes a regression, e.g.
the Kconfig ARCH_TEGRA_234_SOC was added after the driver support in
this driver was added. In this case, you should have a Fixes: tag that
points to the commit that added ARCH_TEGRA_234_SOC.

Or has the the driver support for Tegra234 been "dead-code" since it
was originally added? (Because without this patch, no one can have
tested it, at least not without COMPILE_TEST.)
In this case, you should add:
Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")


Kind regards,
Niklas

