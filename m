Return-Path: <linux-pci+bounces-32240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95DCB06F3A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 09:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497FB1661A0
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 07:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5D328CF65;
	Wed, 16 Jul 2025 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MebXlxNv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230428CF5C;
	Wed, 16 Jul 2025 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651721; cv=none; b=oE+U6yjdAK8c8fJAftXrUrwKpoduyI/0PtxObmTEM4enC63VZgMJzjojsG1iJdX0rO0l8q/29seb58P+SdJVVSJPgzCTAtjkBUxv5cRttQK9bfRh3xxOPirBi1Fn6ckF/Zgzpa+p+zd2jAGvs/u7vlLHG4XBazlSLpwgNFcftuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651721; c=relaxed/simple;
	bh=zdIsE8zMh+Q9b21Tzn+0aEdVw4+F6kLYzxIztPzl06U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFoG4jV4UjB+DcSIK1QDjriBmrpgaIRC2axARfGfY4ZETMovlIxnErEKd/PTsNc2ctBcRZb1X8y5SqB2d3H3m+NpX5W+fVlASG8pkiqe2rgn4TvxEKhI7Jc1oaUOlB8TP3BZyfetMW3vgjBtlvrF5UZdWCI5EtzM1R1aVZOZQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MebXlxNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0D5C4CEF0;
	Wed, 16 Jul 2025 07:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752651721;
	bh=zdIsE8zMh+Q9b21Tzn+0aEdVw4+F6kLYzxIztPzl06U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MebXlxNvdo6y4CMS/mqxoQ2xFLxVMUEkAK0nDRI0znnVgjscwpAL6eKw1ElxcNis5
	 pLFwQ0fTbKA0C3pg4H1dXXyd2CgXFKAmwJY0D3nZ9rQsTE++t4819Eh7/xs/UQ21Wp
	 mF/RS3IztXa6/ELVGb+PZyJU5a+lbXiGZCXzR8TjQxHROo1+8SKuQe/ucCZa0TM/DX
	 QORRzVFEHTsMl0upK+DPMk+xfPXU/C2a8Zkk7qxy4fgB78RtKf3fKeqk5WT/YvI8sS
	 Na/gdoRKRqq8+/pzlFC+zCHX5N/rjrZD/g2HApXyRkgVKadQGvaxU1KDUfYrPOtZlq
	 0zkTAF5CD23ZA==
Date: Wed, 16 Jul 2025 09:41:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, mani@kernel.org, yue.wang@amlogic.com,
	pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 0/2] Configure root port MPS during host probing
Message-ID: <aHdXwr-UZz6jZX3f@ryzen>
References: <20250620155507.1022099-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620155507.1022099-1-18255117159@163.com>

On Fri, Jun 20, 2025 at 11:55:05PM +0800, Hans Zhang wrote:
(snip)
> ---
> 
> Hans Zhang (2):
>   PCI: Configure root port MPS during host probing
>   PCI: dwc: Remove redundant MPS configuration
> 
>  drivers/pci/controller/dwc/pci-meson.c | 17 -----------------
>  drivers/pci/probe.c                    | 10 ++++++++++
>  2 files changed, 10 insertions(+), 17 deletions(-)
> 
> 
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> -- 
> 2.25.1
> 

Any chance of this series getting picked up?


Kind regards,
Niklas

