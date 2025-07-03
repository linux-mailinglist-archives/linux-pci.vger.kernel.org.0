Return-Path: <linux-pci+bounces-31429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADADDAF7D88
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 18:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3174D1C863DD
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 16:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8E12EFD99;
	Thu,  3 Jul 2025 16:03:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5321BD4F7;
	Thu,  3 Jul 2025 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558630; cv=none; b=K0JkifbkDwTHa+p72q56lB1Dg7IkQgaMZzDdyKzN9lFj8MsAAE7LrIpBwGM+ZMcnJP7mEWQo6eS0izxD0zxyZO+u0wXS+Isg/y4Twnw0LKZIog8+LddyWuQuiQ//Z9HwPe8mxRHd7Sgk+rX2GAdWwckya8A4ldQ7h9OH9VMkwys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558630; c=relaxed/simple;
	bh=XiThgsLVHyPbWCf27l9EbbGu7qy3k/OlkanRRNo/RS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThhNphaf2zXwHAcigjGlRR1mnvyubrbdDNCD5tygCDLjxROT5ERlB6I18sWeLxhDEChKtX9a9IUxmfRLGdi9zTqmUXQLAmdps9DpQVTrHmKedziDVcWGkXx7fT5U0iNjmz7p9p5Tp3tCMbMmQmKVGV2KXADVyGlwhxK6kGx1iXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8FAC4CEED;
	Thu,  3 Jul 2025 16:03:46 +0000 (UTC)
Date: Thu, 3 Jul 2025 17:03:45 +0100
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
Subject: Re: [PATCH v7 16/31] arm64: cpucaps: Rename GICv3 CPU interface
 capability
Message-ID: <aGap4RilZskz-L7F@arm.com>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
 <20250703-gicv5-host-v7-16-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-gicv5-host-v7-16-12e71f1b3528@kernel.org>

On Thu, Jul 03, 2025 at 12:25:06PM +0200, Lorenzo Pieralisi wrote:
> In preparation for adding a GICv5 CPU interface capability,
> rework the existing GICv3 CPUIF capability - change its name and
> description so that the subsequent GICv5 CPUIF capability
> can be added with a more consistent naming on top.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

