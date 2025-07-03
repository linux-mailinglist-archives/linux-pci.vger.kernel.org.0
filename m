Return-Path: <linux-pci+bounces-31425-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E36ACAF7D68
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 18:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1721CA3DC3
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C098923E336;
	Thu,  3 Jul 2025 16:02:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E822836C;
	Thu,  3 Jul 2025 16:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558537; cv=none; b=abcV2I6j/av69ALKDO0RBkA8nYmFBi7B0v/esyNjR5zoFugJrvezhH9jutIBho9f4gEZJgEMSqIAI8FE+p4iDzJXZlaB9xCdNGKWXTHipI92s4Fd1RxrFmxx11dSpFEsRM99EIgWnvLKijtOK+YBOPTYoJO9VkYaNFaaSFbNONc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558537; c=relaxed/simple;
	bh=FTNkaCWRXPflpJ+cRMPiQSBO++TYxWCOg8OjHyyfH0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5q28iW4tIXXbnUuK5awHFGzu0jfMbAKolh2wAZKSV8Qhw5IN5LmQASM8DURdFcnzSa3g+38/sW5ja7TxCHBHzZL+l2gj69K1y077KYhXMQvCFSZX1USnawXBcNoL8nTOvghYNTb1tBIV3SGocV3pRYX3kbquCsL4XmgrUYyppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FF8C4CEED;
	Thu,  3 Jul 2025 16:02:12 +0000 (UTC)
Date: Thu, 3 Jul 2025 17:02:10 +0100
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
Subject: Re: [PATCH v7 12/31] arm64/sysreg: Add ICH_HFGRTR_EL2
Message-ID: <aGapghVMJYz4xB5a@arm.com>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
 <20250703-gicv5-host-v7-12-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-gicv5-host-v7-12-12e71f1b3528@kernel.org>

On Thu, Jul 03, 2025 at 12:25:02PM +0200, Lorenzo Pieralisi wrote:
> Add ICH_HFGRTR_EL2 register description.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

