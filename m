Return-Path: <linux-pci+bounces-29355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377E0AD4223
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 20:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E417E7A952C
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 18:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF2724679B;
	Tue, 10 Jun 2025 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IR8Z198K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CE7221262;
	Tue, 10 Jun 2025 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749581091; cv=none; b=EYuoWbIDzh161xMXoUVBJcT3aZAx+JNRaBobMW9UIERqcNflTvv1OvTz8NzqaAr61IlESrz+ITkyk/ZFOTTXXgXnGZx8pPHtQIV1sxwNZR01dzQfD5mWs/aaefdaHhEwoPg71nP0uOfCME7kPAm5rYZf6YLWAn5VEoS7ICrQd7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749581091; c=relaxed/simple;
	bh=joj/ZjLFg+NBtbJ9iqvbjqCoxWFWArbEFXoFWaKYYBc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JbvgJ9khmmyCamOIGAEGc9Mn0x/Gya1Z3FuUfILqSr2qXLEuOanZrf3OcXH65N/wP45hhlONwDS7x71ZXHdGPpZT1rjLsyVgDYlkHUNwv9WPJfPLtXvEq5IZ93Mat8zZR/RWHZXOCVZ2/ZXd7BGBRrBQQCv8HKpHqV6EaD2vdbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IR8Z198K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F070C4CEED;
	Tue, 10 Jun 2025 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749581091;
	bh=joj/ZjLFg+NBtbJ9iqvbjqCoxWFWArbEFXoFWaKYYBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IR8Z198Ks7LgP8Zr1K0TzyqrbxOmz1AnrckCdFX1UFZxj6XqJYw+H3SkpnglH7fw1
	 7di9Jnz3jA85BbcW4Y+Hh7gLq/hmo7tI8OgRmTAGh2+kSFIj/0GJPAqxdomg5vc9Jg
	 XmT3ONIwah7+lDvloqeVaqh4HTczwqvFFEpbUkd8fdzBAdGWj1x/sGcmQglv82A2LW
	 5CU8FiMK//EImFO6sNfsiapjvKjfme0I7u2cxN0TuxFP3R7TegAJK96DOR0hNV0gy8
	 ATJdQ2Pc6vJ+faC71tgFx+zgvksU3SnUjT8FgXHiBr6PWEkCx8oFREuwT19ThQrtrk
	 v7zvhIC4+GGHw==
Date: Tue, 10 Jun 2025 13:44:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: linux-rockchip@lists.infradead.org,
	Hugh Cole-Baker <sigmaris@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] PCI: rockchip-host: Retry link training on
 failure without PERST#
Message-ID: <20250610184449.GA819185@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <810f533e9e8f6844df2f9f2eda28fdbeb11db05e.1749572238.git.geraldogabriel@gmail.com>

On Tue, Jun 10, 2025 at 01:37:12PM -0300, Geraldo Nascimento wrote:
> After almost 30 days of battling with RK3399 buggy PCIe on my Rock Pi
> N10 through trial-and-error debugging, I finally got positive results
> with enumeration on the PCI bus for both a Realtek 8111E NIC and a
> Samsung PM981a SSD.

> +static int rockchip_pcie_set_vpcie(struct rockchip_pcie *rockchip)
> +{
> +	struct device *dev = rockchip->dev;
> +	int err;
> +
> +	if (!IS_ERR(rockchip->vpcie12v)) {
> +		err = regulator_enable(rockchip->vpcie12v);
> +		if (err) {
> +			dev_err(dev, "fail to enable vpcie12v regulator\n");
> +			goto err_out;
> +		}
> +	}
> +
> +	if (!IS_ERR(rockchip->vpcie3v3)) {
> +		err = regulator_enable(rockchip->vpcie3v3);
> +		if (err) {
> +			dev_err(dev, "fail to enable vpcie3v3 regulator\n");
> +			goto err_disable_12v;
> +		}
> +	}
> +
> +	err = regulator_enable(rockchip->vpcie1v8);
> +	if (err) {
> +		dev_err(dev, "fail to enable vpcie1v8 regulator\n");
> +		goto err_disable_3v3;
> +	}
> +
> +	err = regulator_enable(rockchip->vpcie0v9);
> +	if (err) {
> +		dev_err(dev, "fail to enable vpcie0v9 regulator\n");
> +		goto err_disable_1v8;
> +	}
> +
> +	return 0;
> +
> +err_disable_1v8:
> +	regulator_disable(rockchip->vpcie1v8);
> +err_disable_3v3:
> +	if (!IS_ERR(rockchip->vpcie3v3))
> +		regulator_disable(rockchip->vpcie3v3);
> +err_disable_12v:
> +	if (!IS_ERR(rockchip->vpcie12v))
> +		regulator_disable(rockchip->vpcie12v);
> +err_out:
> +	return err;
> +}

This *looks* like it could be strictly a move of
rockchip_pcie_set_vpcie(), without changing it at all.

If that's the case, please make the move a separate patch so it's more
obvious what the interesting changes that actually make a difference
are.

