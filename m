Return-Path: <linux-pci+bounces-31432-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A446AF7D5A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 18:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF2F46E1E6A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B582F235A;
	Thu,  3 Jul 2025 16:04:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7042F19BF;
	Thu,  3 Jul 2025 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558693; cv=none; b=iMqFnAYb2Z9FyUqvCz7h8iL6YBe33nZF2HP5fjomGPr0x8qYmGV/DzcPrXMcrLyf3rxkHwKhbFsZ83P+b5yrB3dk8sjgeCGabpg+00KPZ/xuojxVI/GX213yhHHZ1koRkBKzYC1WKzXdp/CEcScEea57Sw9/AHvffYxq8ipNRaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558693; c=relaxed/simple;
	bh=7YEdIucuH8BFWK8Fk19GH15zA29ZqNovoZb3gXXtXO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BimPqKkgHm8bfyWn3WEj5IYI3JcawhUePlTyjKm2cUCmIwCBddRx3kmsMO1PzInCMEuhfbsuk7mipp/dTYtQVGgvBO+Yy+xKW+10wpZGhlDsyGI5FhaZk5O2tgE88Ggz/SbhTxFqe2aGbu+plv9RbFxx8gy48f1ksKtB64B7FIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499FAC4CEE3;
	Thu,  3 Jul 2025 16:04:49 +0000 (UTC)
Date: Thu, 3 Jul 2025 17:04:47 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Sascha Bischoff <sascha.bischoff@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Timothy Hayes <timothy.hayes@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 19/31] arm64: Add support for GICv5 GSB barriers
Message-ID: <aGaqH4kJdlk3_qOf@arm.com>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
 <20250703-gicv5-host-v7-19-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-gicv5-host-v7-19-12e71f1b3528@kernel.org>

On Thu, Jul 03, 2025 at 12:25:09PM +0200, Lorenzo Pieralisi wrote:
> The GICv5 architecture introduces two barriers instructions
> (GSB SYS, GSB ACK) that are used to manage interrupt effects.
> 
> Rework macro used to emit the SB barrier instruction and implement
> the GSB barriers on top of it.
> 
> Suggested-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

