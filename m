Return-Path: <linux-pci+bounces-30186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37193AE075B
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 15:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3233B45BA
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 13:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B993525C6E2;
	Thu, 19 Jun 2025 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE8KLk4w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8942125A2C8;
	Thu, 19 Jun 2025 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339613; cv=none; b=QGKZ6ZdjLAoPeA+SksTo3Ss3A+4O41s5jBPUwX1WHIJboPIf5quwRoetCwjG2grBGs9+KcbHSr5G1uM5kTW8zt8Jwk5uORk7Kpo5JbX1N9/mogKvE9N7wUjMoe1tdBg1dcugyDgC0SelffIcvDRYTFdw7mEMenTOn2z1VTd40Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339613; c=relaxed/simple;
	bh=q+uqHkfAKvy4Mf6N9v81KLtza9u4cH3BHIbiedbi4R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TquBnBUnYsj2b7DDszPzeEq/I9yeuXMI5BGLJ1pvlUf6TpubMjUD3dNh+fen8j9KnmCyDskemVRqGOvV4SHb00crg7FB0pVdy7BZbnppGjnFq8wK7Bank7Iz6zqj4OsZwiRmfxPbUut6Ai/w/TqAgpvyJCm3xFH3T22jxS9Uw28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE8KLk4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DA7C4CEEA;
	Thu, 19 Jun 2025 13:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750339613;
	bh=q+uqHkfAKvy4Mf6N9v81KLtza9u4cH3BHIbiedbi4R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oE8KLk4wAQhv+DMIZJ3hHPPSv6Xdwl7VQxKWfDp+KwHErU7x3XNHNEShUUlXltmCP
	 ASPX4NrWmAjTmxTmaCK2N+NDBBqGFEdB2FqwL5kkCroZuLWrQ4QeAxUpgtQFN6eY8/
	 mnwxhCbk9yeiU6dGDioirxFoeHyvw6juH0RhE/QtJdiopNKyu9Bub7/Q33vnOvakgt
	 iASXBZ+fQVq1oX175RPypsR5gX172t6EY8OiYv1Q5LOQrREQE8fqpRB902kpe9V+Lf
	 mqqAvxy8jp6wzujEWpc1HvA41b8XUdWKIlSOtIgyz3QSpIaRBYs8IhtoD32dwKE0RE
	 mxGqlall2jpaQ==
Date: Thu, 19 Jun 2025 18:56:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	kwilczynski@kernel.org, ilpo.jarvinen@linux.intel.com, jingoohan1@gmail.com, 
	robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCIe: Refactor link speed configuration with
 unified macro
Message-ID: <v75tmnr2lvvdgilt7se2ymbrkl7y6ieqmrjnoqmuixgtoaptxr@v4cglwz4vo2m>
References: <20250607155545.806496-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250607155545.806496-1-18255117159@163.com>

On Sat, Jun 07, 2025 at 11:55:42PM +0800, Hans Zhang wrote:
> This series standardizes PCIe link speed handling across multiple drivers
> by introducing a common conversion macro PCIE_SPEED2LNKCTL2_TLS(). The
> changes eliminate redundant speed-to-register mappings and simplify code
> maintenance:
> 
> The refactoring improves code consistency and reduces conditional
> branching, while maintaining full backward compatibility with existing
> speed settings.
> 

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> Changes for v2:
> - s/PCIE_SPEED2LNKCTL2_TLS_ENC/PCIE_SPEED2LNKCTL2_TLS
> - The patch commit message were modified.
> ---
> 
> Hans Zhang (3):
>   PCI: Add PCIE_SPEED2LNKCTL2_TLS conversion macro
>   PCI: dwc: Simplify link speed configuration with macro
>   PCI/bwctrl: Replace legacy speed conversion with shared macro
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 18 +++---------------
>  drivers/pci/pci.h                            |  9 +++++++++
>  drivers/pci/pcie/bwctrl.c                    | 19 +------------------
>  3 files changed, 13 insertions(+), 33 deletions(-)
> 
> 
> base-commit: ec7714e4947909190ffb3041a03311a975350fe0
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

