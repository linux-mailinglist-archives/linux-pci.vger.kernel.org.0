Return-Path: <linux-pci+bounces-31430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7F2AF7D44
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 18:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C8258269F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 16:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D912EE5F3;
	Thu,  3 Jul 2025 16:04:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BC32EACE5;
	Thu,  3 Jul 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558651; cv=none; b=FBMcLo0xr6in5QclWWXq211SAn2MIo2eWL91i3QXH0Mz8HHenIQw2DZxv/pBwi6fBpF2LWRsvggSKwmQ8u8xDh4vX9s8WSLlSG/ln0y/MQMGMJO8a8BpKk48Vqy8k+MkxgBFNsycpAeEHHe0ab+u4WnQwWAhv0Jbsl4LNswf/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558651; c=relaxed/simple;
	bh=s2/nGBBEP7bZ3lSWJC29htjbGekPxtZdCcjiexlqQ+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GD2/+jbhIeWVXCVkp2ktSePgpgtTWJVG1tPYmoW+0BpN9gpv2JFnS4p76MPgePIgfBIADuWdw4YBeYU0Zt6DAQh/rk4Ugx4e3hhWpGiHyP0DFYgDauxMz9cAaoN6irGgb0XPQbNWVqzs9smO3mwVpArZXz8a1GfTOxkjD4Yr0x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A984C4CEE3;
	Thu,  3 Jul 2025 16:04:06 +0000 (UTC)
Date: Thu, 3 Jul 2025 17:04:04 +0100
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
Subject: Re: [PATCH v7 17/31] arm64: cpucaps: Add GICv5 CPU interface (GCIE)
 capability
Message-ID: <aGap9JWMRDk_BIG1@arm.com>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
 <20250703-gicv5-host-v7-17-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-gicv5-host-v7-17-12e71f1b3528@kernel.org>

On Thu, Jul 03, 2025 at 12:25:07PM +0200, Lorenzo Pieralisi wrote:
> Implement the GCIE capability as a strict boot cpu capability to
> detect whether architectural GICv5 support is available in HW.
> 
> Plug it in with a naming consistent with the existing GICv3
> CPU interface capability.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

