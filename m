Return-Path: <linux-pci+bounces-27620-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CA0AB4D86
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 10:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 594AA466C0D
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 08:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67931F3D56;
	Tue, 13 May 2025 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDvUdjce"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6041F3B98;
	Tue, 13 May 2025 08:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123258; cv=none; b=J6nV56XE+xk52mtIxFDsfuvqnwUV1PZL2hLz6x5U7JwtHDSL7RlNkFUds6eHzGHySVmn45cacVMJckFny8D7a9Nf0bKAkKwCAcDPjziNTjgsc9/6ZpsYJ884T6vpYXs/485l2VSsOjE1qfbUX0fFygzHflAPuQRRDcVJavZbqWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123258; c=relaxed/simple;
	bh=mYFJ32WsfC9wkSmRmduXmQGmb1wMcgm5Ip2j2pQZI1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klN/XHlmk3OHVSo/39mtJ2uBWENdUmooru+ktEe7C43rwh4/CuiV4h41HcpHS8Fpz9Hh3RxnecBdsgJ+bl2G0mAPXkbgk+srN2WCn0XS97y+iy0R+aGjy633ZRBbxyQeKYOJRlY0O5WCAUm2wLpGOYL1Tk8Y0h/JSYjrdcuHMug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDvUdjce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD104C4CEE4;
	Tue, 13 May 2025 08:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747123258;
	bh=mYFJ32WsfC9wkSmRmduXmQGmb1wMcgm5Ip2j2pQZI1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UDvUdjceaV3WkGMMmN2ujS7dpstRHbeBOOt50zeR6W9KcVrOoH5wTxf/KNjiF0kRs
	 wSPk/AaECYimzkLa0gMXV2Rnia1tR/KMHWPbt/PV3RGu/j5I1yE7YqDhg9F4SK+IuO
	 J7pdba83ac7Ybv+4h97AwGOASWT1SPhn1fz3XF0VhDiwvHE4hr1NdWTYxsicYpJMVV
	 ei6PK17fa9y7yY5nmU8BN8IrXjpTqDivk2Ojyq07VpqrocVYBvJbe5G9tthH2oX2Jl
	 5d8NZl4qIcmiIW8c9ZIDf5WtXp7+Pq+kOarcJQHFezkgSv7RkCXmKDuLUkQf3sN54+
	 kF2oupQf88dTA==
Date: Tue, 13 May 2025 10:00:53 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 2/3] PCI: mobiveil: Refactor link status check
Message-ID: <aCL8NXYC5mbGDRIX@ryzen>
References: <20250510160710.392122-1-18255117159@163.com>
 <20250510160710.392122-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510160710.392122-3-18255117159@163.com>

On Sun, May 11, 2025 at 12:07:09AM +0800, Hans Zhang wrote:
> Update ls_g4_pcie_link_up() to return bool and simplify the LTSSM state
> check. Align function signature in pcie-mobiveil.h to match the change,
> ensuring consistency across the Mobiveil PCIe driver.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

