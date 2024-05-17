Return-Path: <linux-pci+bounces-7595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9468C84AD
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 12:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46671283EF5
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 10:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5F5364AB;
	Fri, 17 May 2024 10:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS25gVTo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DA72C848;
	Fri, 17 May 2024 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715941356; cv=none; b=iPT6cr8ITTsmOZsr4rNV7OS+jg3nzBHg7x4QbtO0oQY+F3ktSDR2J1w5QDdDyOgd6OrYUeRjuQNCDmSIrjS6+7DdrhbvhCT5IYaJHFUnB4Feg4o/+R4MoJVUfpDDO2HWPfGy/HX+JPcPA/FcANmtRoWqDe5FT8/3mqy65eyihzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715941356; c=relaxed/simple;
	bh=Siin2KDdrw9IZXPxUcVfzq/13heNRE814alBNBZNmm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4Z9L4jgda0x5wigbTN+Fdfi4KvFQ/8ZVTKRz0DhOK0MZWfpDi3NpK/sdplXP3oS53+gBoc/Ho0q7+9Mr4sIVrJBtG2OpxzbGJZ58pvflWgLA46RGiIoRwxhZ81fN/wUieXnD/GQOMwE2tpxDU3cjJ1BysELcdKtgqy4ZzDuTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS25gVTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B174C2BD10;
	Fri, 17 May 2024 10:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715941356;
	bh=Siin2KDdrw9IZXPxUcVfzq/13heNRE814alBNBZNmm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JS25gVToNhvMMNg7hxuTZL0tG/HBKNKC/y60z1180iBSmkkiAF93gz8IahYLICpPR
	 dD1+BEZrCmEKnkC5poMsAVMb7azHUcJlbh6I/eYx0PbexCe7SzuCwDZcIo8GM0NuOK
	 2zEaUbHpY/T5Xr5iUZl/JnXGgHjK9EnqS3ofKZchWLgEiup7M4RCempgYeRsm+CF9T
	 YScRQXb5iBIlzjUx+Z91JS8yRRDzn8SM2kvgnEuQKFoMun9ZO6vcKuU3CsT9csKK9C
	 TGUgJSrW+N27RSEIGXFCe6+/LNwj9cNO9fHoLPEtsBw0tPIrDu1Nu83x25aXj2QGIW
	 FkUWzfs0Qm5lg==
Date: Fri, 17 May 2024 19:22:34 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Frank Li <Frank.Li@nxp.com>, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Yue Wang <yue.wang@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 0/5] PCI: controller: Move to agnostic GPIO API
Message-ID: <20240517102234.GA333779@rocinante>
References: <20240506142142.4042810-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506142142.4042810-1-andriy.shevchenko@linux.intel.com>

Hello,

> While at it, remove of_gpio.h leftover from some of the drivers.

Applied to gpio, thank you!

[01/05] PCI: dra7xx: Add missing chained IRQ header inclusion
        https://git.kernel.org/pci/pci/c/1d1efd131cc1
[02/05] PCI: aardvark: Remove unused of_gpio.h inclusion
        https://git.kernel.org/pci/pci/c/83bf80dc8e2f
[03/05] PCI: dwc: Remove unused of_gpio.h inclusion
        https://git.kernel.org/pci/pci/c/8f69a807234b
[04/05] PCI: imx6: Convert to use agnostic GPIO API
        https://git.kernel.org/pci/pci/c/7dfa559abc93
[05/05] PCI: kirin: Convert to use agnostic GPIO API
        https://git.kernel.org/pci/pci/c/7ca698ff686c

	Krzysztof

