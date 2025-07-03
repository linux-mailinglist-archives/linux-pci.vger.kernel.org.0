Return-Path: <linux-pci+bounces-31436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64493AF7D71
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 18:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC856E1D20
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 16:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BF223BCF5;
	Thu,  3 Jul 2025 16:08:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC6239099;
	Thu,  3 Jul 2025 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558927; cv=none; b=g93RbjYESpDGSWCsIOhmeSa+E9YQ8oxeThZ4rOTPPKWVFkNQQCFwmnLXT9k8edQFkIC16dnfTq496YinGZnZqV1fJ8NH4NqETR09T8gwZvQCsKiE9mNRso1jtNvNXRAsbNpPqBxQoSae1PKAfAgqEccIzrIu0dBEuHvhe/hsol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558927; c=relaxed/simple;
	bh=mEgQLYXfXzch6bgNjB1voNYl/NNJOCNJzD1dj4U6510=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLARZfQWjyA6FW5bWTHgGN7Uw/2396bc94ZP3QosmVNueV2miBtlYjyldZd/8cgOHtc4JrpVENZi3k2UgHC1/I/EWvYKgLgr5BMn+Ml92Y9vBjiIfNyNvGfMMulkz2Zku+gBNpblRCf9rfrws5V11MAuGth9U8fRWmlvRLOJGuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB7DC4CEED;
	Thu,  3 Jul 2025 16:08:42 +0000 (UTC)
Date: Thu, 3 Jul 2025 17:08:40 +0100
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
Subject: Re: [PATCH v7 30/31] docs: arm64: gic-v5: Document booting
 requirements for GICv5
Message-ID: <aGarCGAW3czympE1@arm.com>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
 <20250703-gicv5-host-v7-30-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-gicv5-host-v7-30-12e71f1b3528@kernel.org>

On Thu, Jul 03, 2025 at 12:25:20PM +0200, Lorenzo Pieralisi wrote:
> Document the requirements for booting a kernel on a system implementing
> a GICv5 interrupt controller.
> 
> Specifically, other than DT/ACPI providing the required firmware
> representation, define what traps must be disabled if the kernel is
> booted at EL1 on a system where EL2 is implemented.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

