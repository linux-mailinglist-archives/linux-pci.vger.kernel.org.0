Return-Path: <linux-pci+bounces-27839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192A5AB981D
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 10:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A901D4A1174
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 08:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A6822D7B4;
	Fri, 16 May 2025 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOrz695A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6907922D4C7;
	Fri, 16 May 2025 08:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747385542; cv=none; b=aqIMJAh0pTpn/8Sfcb/jRMUAVQnBY8M9dBrO31W8OJWuabtKsqmn1eA8PDpwJeGKf8tSAVaHHPfCcft7Wb1lzDvSZCt8b1CM3KDv6Tal1ten/Jnn77SczDEyd7gpIuoDS9R/x5OR5mZSog8EW0TOVoiJMx4QWnAXPA1ds+OiDTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747385542; c=relaxed/simple;
	bh=0kC6rQVUs9z3NtsA1Czl/GjAKkE3YW7Ze66a6nN1qP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlpzrKhsGZZuQTF5QjXuo32r8PuW3xuR04RTZQgZqHlhbKGeM6URYy6rP4a498oHueVRpJc/1FaRmrGB7wBNCVCuQU8JEnY7LC3saFQdMzt9Tp/RtkAXXt6vWEur44ggW1IviE7QNZ0ykuGhN1/G6Fuemj4+VVq3WQ+JleAO/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOrz695A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E006BC4CEE4;
	Fri, 16 May 2025 08:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747385541;
	bh=0kC6rQVUs9z3NtsA1Czl/GjAKkE3YW7Ze66a6nN1qP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOrz695AsvEBq7UVAQQYINiMfAUnQec5uzOPYgu50wck9xNrT8C0m+UT8zFA9kqMg
	 uqgB3leMCYAgvneT5kIyf6ezGjU6R9O8oVI6IndJ5EK3x2XNQALZLOnr2SLK3yqSlr
	 jCqYgzMfOiMvvZstdaq+ABSosSxsXLt1atPrTmCCO6qk4QOdfGQ54vErvcDuFabHRY
	 6Gk3OC59TqzfztzdBQsbQGsKG9JUxHwTYGvBPMca+3xNNr47hI+AiaTUPy9Qwk/QGB
	 MT/qYtz0KgqjLW1uzkuBM9vsy5W5t8z95XVFa+vttj2M6uwVFFzOSWJwbC0VA03fK8
	 dWZjmjMfFYY7g==
Date: Fri, 16 May 2025 10:52:17 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	jingoohan1@gmail.com, Hans Zhang <18255117159@163.com>,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/3] Standardize link status check to return
 bool
Message-ID: <aCb8wauW4h85F8YS@ryzen>
References: <20250510160710.392122-1-18255117159@163.com>
 <174712882946.9059.1080501209546808704.b4-ty@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174712882946.9059.1080501209546808704.b4-ty@linaro.org>

Hello Mani,

On Tue, May 13, 2025 at 10:33:59AM +0100, Manivannan Sadhasivam wrote:
> 
> On Sun, 11 May 2025 00:07:07 +0800, Hans Zhang wrote:
> > 1. PCI: dwc: Standardize link status check to return bool.
> > 2. PCI: mobiveil: Refactor link status check.
> > 3. PCI: cadence: Simplify j721e link status check.
> > 
> 
> Applied, thanks!
> 
> [1/3] PCI: dwc: Standardize link status check to return bool
>       commit: f46bfb1d3c6a601caad90eb3c11a1e1e17cccb1a
> [2/3] PCI: mobiveil: Refactor link status check
>       commit: 0a9d6a3d0fd1650b9ee00bc8150828e19cadaf23
> [3/3] PCI: cadence: Simplify j721e link status check
>       commit: 1a176b25f5d6f00c6c44729c006379b9a6dbc703
> 

This was all applied to the dw-rockchip branch.

Was that intentional?

My guess is that perhaps you thought that
"PCI: dwc: Standardize link status check to return bool"
was going to conflict with Hans's other commit:
5e5a3bf48eed ("PCI: dw-rockchip: Use rockchip_pcie_link_up() to check link
up instead of open coding")

but at least from looking at the diff, they don't seem to touch the same
lines, but perhaps you got a conflict anyway?



mobiveil and cadence patches seem unrelated to dw-rockchip
(unrelated to DWC even).

If it was intentional, all is good, but perhaps the branch
should have a more generic name, rather than dw-rockchip,
especially now when the reset-slot and qcom-reset slot patches
are also on the same branch.


Kind regards,
Niklas

