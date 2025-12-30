Return-Path: <linux-pci+bounces-43830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA17CE9392
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 10:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AAFC3010A83
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 09:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892622BE032;
	Tue, 30 Dec 2025 09:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtKEPZ73"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA6B242D97;
	Tue, 30 Dec 2025 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767087241; cv=none; b=LTQTOdHvXSynSWZ9Ix13fla1TxB2I9juodHXQVn033zwgghP/xFrHjwZL+kuY2Wr0Co/Uk9sMNd5r7pcXeYbFaSt5QSjKX9ICMvtpij2gyzYmFczgupEI15Tk+phhotYpNaqOTMIEiOU37sIxBIy/r37Tx0SIJd9lmLhGC3D1z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767087241; c=relaxed/simple;
	bh=8IiH8oqG55XbOIGLcLkri2CLbZPYlF6u5isFFigIskk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCk1ZS88eGyesyna7a1zbToaJ7bFds56AZNlhEmU077Y1MiqQn2oAmW0DX0u6tOQiy8l56O2KHFs4oeXev4hCPN4bV8TBU+O2dB4HSOXn+KmEVZ2tTd6ZnSmyMMYd1flefS+6dexT4ibPKah3GCRhVJi423PMvFLpoIy+LnTz6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtKEPZ73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981FFC4CEFB;
	Tue, 30 Dec 2025 09:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767087239;
	bh=8IiH8oqG55XbOIGLcLkri2CLbZPYlF6u5isFFigIskk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mtKEPZ732UXITcojH8GEX1UCTVlYpDK95+M1pKrs+HZboz3eh9lVdc4tMszCLZFRg
	 1ViWWvM8CbMwiSXY6YpKHhphWCPGctiuu98W77K2zZrF3RxDvFXL0UCAHu8gqpNZeM
	 Xj/cgcuvEn1kuwcBTsC8GGFXKWfpBsXEYDbHMrly0fOYr3x4Fb7/lad8xNB1PLOaJv
	 TiHXznekgkpLdN0JCQbS6IKIGyp4WrX2EzerbxrvjfySYCqdsWiy0QpVwE/es3LP29
	 IuYYDZd8vwHfblnSmjZD19hTw2SeXNS7Q1nyJQuBObyMDpxMc413fibBk2WZBJ5aGx
	 PxeqUC1UeVSKg==
Date: Tue, 30 Dec 2025 10:33:52 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Damien Le Moal <dlemoal@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 0/5] PCI: Add initial support for handling PCIe M.2
 connectors in devicetree
Message-ID: <aVOcgDeOejO9m1zE@ryzen>
References: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251228-pci-m2-v4-0-5684868b0d5f@oss.qualcomm.com>

Hello Mani,

On Sun, Dec 28, 2025 at 10:31:00PM +0530, Manivannan Sadhasivam wrote:
> The Mechanical Key M connector is used to connect SSDs to the host machine over
> PCIe/SATA interfaces. Due to the hardware constraints, this series only adds
> support for driving the PCIe interface of the connector in the kernel.

Since this series does not add any support for SATA, do we really want to
modify the SATA device tree binding?

I know that device tree describes the hardware, but if there is no software
that makes use of this, the SATA DT binding change feels a bit unnecessary.

Do we perhaps want to defer modifying the SATA DT binding change until the
corresponding change in software is added?


Kind regards,
Niklas

