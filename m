Return-Path: <linux-pci+bounces-31422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BBCAF7D11
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 18:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80066567158
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF6B2F0042;
	Thu,  3 Jul 2025 15:59:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC092F0035;
	Thu,  3 Jul 2025 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558388; cv=none; b=Y6B/tNbIkuUtp4VVRlm9jVwS19zumf3sxYiTft0hW85J5gxRDms80ozFzRCJZQCas5lOwhEenO7nJ6hK66bzwkNGVJohJ5gzoK2KKUiuyyCLXoHLtA21GLh1JIByvoBuHS8hIQiQIRX3tzjPIboRn9dJp5v4nvnwIGIsJPntP9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558388; c=relaxed/simple;
	bh=MwIcVeJuV9/wgIYS9RL1D1uLyXta5FsCYrKlXtGye5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4a++fbjlTPh27NZl+kpGavQpvMlqKInb/dy2w1WikOtEq3x52sItAtUyNHKZAIHMZIf+JGIX+pwbYFb5qBanykI6a5d5vzMXqANEuJ1NtXLxmA0skmr/Bi8sM30h30ZRlOAZScA1qljSZEYHzMppflQfFEocLoY8fTlzJp5/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536E6C4CEED;
	Thu,  3 Jul 2025 15:59:44 +0000 (UTC)
Date: Thu, 3 Jul 2025 16:59:42 +0100
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
Subject: Re: [PATCH v7 09/31] arm64/sysreg: Add ICC_CR0_EL1
Message-ID: <aGao7h-WfHU-nQ6u@arm.com>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
 <20250703-gicv5-host-v7-9-12e71f1b3528@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-gicv5-host-v7-9-12e71f1b3528@kernel.org>

On Thu, Jul 03, 2025 at 12:24:59PM +0200, Lorenzo Pieralisi wrote:
> Add ICC_CR0_EL1 register description.
> 
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

