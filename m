Return-Path: <linux-pci+bounces-27282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4C2AAC80B
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 16:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220BC1C07151
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 14:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB57267712;
	Tue,  6 May 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAb/q3om"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13111862;
	Tue,  6 May 2025 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542024; cv=none; b=hSH7puHmU06UDAAcu12LfxP95S7pRQNkQXSsvz2Sm4e5FC1vRbpvPFHOabkhtSa8t9mm3TfKEANbExfUhKNxIEirLbbZoqoTnw7b1qM6ZewIuSHuRFKgojl5pw+jFHmkmN9rt3sxgkHkH68NfGUbVv7lp7vR1Xa/wZhf41oiMrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542024; c=relaxed/simple;
	bh=Ae+qgp3ezP7Fi0sm8hyAz2/8J0K1eY7HWQaSgwOxXYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+vG/eZmlz9OnzytrCYB4j9KqEzAdnFv5EiaFR7/dXMY4oI7Doh31w/So4r6P7GaYdcjndvaGdgUvqChCgFpXFt3BhAZdHjZVHpg1uUwH6hDONdSDt4zqYxpJ9dPxV6jNsPL5QDTFGaF6AzBnds7VnjO4LOsWBxrzrlqARRtY74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAb/q3om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36DFC4CEE4;
	Tue,  6 May 2025 14:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746542024;
	bh=Ae+qgp3ezP7Fi0sm8hyAz2/8J0K1eY7HWQaSgwOxXYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kAb/q3omJ8TdawZx7/zBfo/iFU8nrgajSiRkRAKoLGyhNoFexuVua01KYeTsUVwRs
	 LbmSujNuq8FtyoXVCTb0o1eOjzEc3MKmiH3vpqBlOAHh/mn0EKFCiUWFbno528dK+u
	 VRTEsZw79XSDR5S9YUyyatjxNZ3iC3YP9i7rGspz6DgW8QHXhK+wOdsVOkW0sqxE/O
	 RgLy/dwohXLWNt0fuB1QFUCgSuHr17xsMlK04MPfM6OxuMnPTtSOyqU32nsrf3mndo
	 6O+eQXI7AD3sIWLJrxlmsUbzwndhxhDKeEYfAGQy8EoPD73drEWJf27aPVY6pdLxpg
	 cs/TKa8PSCgLQ==
Date: Tue, 6 May 2025 16:33:38 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hans Zhang <18255117159@163.com>,
	Laszlo Fiat <laszlo.fiat@proton.me>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PCI: dwc: Link Up IRQ fixes
Message-ID: <aBodwvmG6ENM7haH@ryzen>
References: <20250506073934.433176-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506073934.433176-6-cassel@kernel.org>

On Tue, May 06, 2025 at 09:39:35AM +0200, Niklas Cassel wrote:
> Hello there,
> 
> Commit 8d3bf19f1b58 ("PCI: dwc: Don't wait for link up if driver can detect
> Link Up event") added support for DWC to not wait for link up before
> enumerating the bus. However, we cannot simply enumerate the bus after
> receiving a Link Up IRQ, we still need to wait PCIE_T_RRS_READY_MS time
> to allow a device to become ready after deasserting PERST. To avoid
> bringing back an conditional delay during probe, perform the wait in the
> threaded IRQ handler instead.
> 
> Please review.
> 
> 
> Kind regards,
> Niklas

Hello Laszlo,

Since you have a RK3588 based board, sending a Tested-by
tag on testing patches 1-2 makes sense.

However, patches 3-4 are for Qualcomm based boards.
I'm not sure if you also have a Qualcomm board at your disposal.

If you don't, Manivannan can probably drop your Tested-by tags
on patches 3-4, but it might be good to know until next time.

Thank you for testing!


Kind regards,
Niklas

