Return-Path: <linux-pci+bounces-27717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C9BAB6C08
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 15:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA108C1FDD
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 13:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3769E27816B;
	Wed, 14 May 2025 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuYrbhUJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D273274672;
	Wed, 14 May 2025 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227781; cv=none; b=UeZpDyHqIWJzIB0iTq+HvaJ4NM94MnB6MLT8rYqVnHVG0z1KT0w3rtfJK49wPA1U4FbL/z9d9HqCVkHo7sNUqvSLza46mpYTxDXBFF/1VUI/6281w+KuIlZGJZ3yUvcTm7iyyTntGg1l7eVEBWLi5ND/w5ubKwqR+Ua/pETjqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227781; c=relaxed/simple;
	bh=H+aOSXeP9x6b6RxJ88qAfN/mlcVs9pMe2ySIZAbUipE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpfHmzZKg7/NLx9SmfEJYJOKCWIT142P5+krMIxr2dtQuXxB7wdFXs87fQ5n/F0Rzz1HiLBwUTR4zwKF3WwNl+Xy/7pQeiyDDeCZzcivLjgHcYLKvYFJehW403nIxnFuv9QhrqhCFhxlNizxlM9Fu9JUQTewIkR4Bhoc9Lo5bWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuYrbhUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FB9C4CEE9;
	Wed, 14 May 2025 13:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747227780;
	bh=H+aOSXeP9x6b6RxJ88qAfN/mlcVs9pMe2ySIZAbUipE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GuYrbhUJTm7DKsaMNNeuwd7ZS65ark1VWQ4rCgQrEENaQQPTQvx8ke3W2iwN4dXmv
	 DA0gTYpqD0YAtTfg+FbPNNphxSerEGqkZRDI+pjXUaJxeUzXLA33Jx1A9N0Ikq7Img
	 4jXzvn/HsjE0iNXypvB7yQKf+MaJet2gCERj09z5dQ9zlVUyJnAUjeG1+4FFAVn1Vz
	 /Lv2ctunjW6YkXNV9u9nvxL2KQP5forSo5qUgOaCdNUVmGtOYr9Yr6ZQuauRn3Yz6M
	 ZdNwNjYu4cSIsd8I/9i+uDXXV507XGlX6F5EsZhbX+Wmau2pzkh0h0GnkK/cLBe2pD
	 rP0PwKYVVjIoQ==
Date: Wed, 14 May 2025 15:02:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com,
	Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, treding@nvidia.com,
	jonathanh@nvidia.com, kthota@nvidia.com, mmaddireddy@nvidia.com,
	sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI: dwc: tegra194: Broaden architecture dependency
Message-ID: <aCSUfiwnZRTgMKGT@ryzen>
References: <20250417074607.2281010-1-vidyas@nvidia.com>
 <20250508051922.4134041-1-vidyas@nvidia.com>
 <174722268141.85510.14696275121588719556.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174722268141.85510.14696275121588719556.b4-ty@kernel.org>

Hello Vinod, Krzysztof,

On Wed, May 14, 2025 at 12:38:01PM +0100, Vinod Koul wrote:
> 
> On Thu, 08 May 2025 10:49:22 +0530, Vidya Sagar wrote:
> > Replace ARCH_TEGRA_194_SOC dependency with a more generic ARCH_TEGRA
> > check for the Tegra194 PCIe controller, allowing it to be built on
> > Tegra platforms beyond Tegra194. Additionally, ensure compatibility
> > by requiring ARM64 or COMPILE_TEST.
> > 
> > 
> 
> Applied, thanks!
> 
> [1/1] PCI: dwc: tegra194: Broaden architecture dependency
>       (no commit info)
> [1/1] phy: tegra: p2u: Broaden architecture dependency
>       commit: 0c22287319741b4e7c7beaedac1f14fbe01a03b9
> 
> Best regards,
> -- 

I see that Vinod has queued patch 1/2.

Please don't forget that this series requires coordination.

There are many ways to solve it.

1) One tree takes both patches.

2) PHY tree puts the PHY patch on an immutable branch with just that
commit, and PCI merges that branch, so the same SHA1 of the PHY patch
is in both trees.

3) Send PHY patch for the upcoming merge window. Send PCI patch for
merge window + 1.


Kind regards,
Niklas

