Return-Path: <linux-pci+bounces-35743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F5EB4FBF0
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 15:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 950611C231FC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 13:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6314A3E;
	Tue,  9 Sep 2025 13:00:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C501DB127;
	Tue,  9 Sep 2025 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422821; cv=none; b=f0tBep69yNdo5oOFrS/kTN+A7LZPpQ5Goo6XlhxRnTrmka2I4mElLFECEzoqY+qihFc/iC7XCI2+7moKEGBepuNEXiFWSR4eBPeE7pC8D0+sXfW8gGEdjEmcUHdkaz0hriXqqrOhnjpC2I2rdjimxxxGd/QXLY4nshmF9yCqSmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422821; c=relaxed/simple;
	bh=nJa1dT6LPmH/j9fOey3qeOBaK6YsLHpwi/V8uKgMUzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lkSA7V00q+gQxMNSLxWnJLCLLfZ5/SWTaMSEuHP3qcu9ojFabnruPhyZhm0M/gA/gAcRRZN0ioq8cS0KCEXLdmcf/JsJajqycyr8aA9aKhsEYcfyDghYdOWHA6+Uvrz50IOIpjhKdbvIumuwxQviTTsxAZjnAk+ax4/Cv5eXbp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.41])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2236a7739;
	Tue, 9 Sep 2025 21:00:13 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: ziyao@disroot.org
Cc: amadeus@jmu.edu.cn,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	jonas@kwiboo.se,
	krzk+dt@kernel.org,
	kwilczynski@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Enable PCIe controller on Radxa E20C
Date: Tue,  9 Sep 2025 21:00:09 +0800
Message-Id: <20250909130009.2555706-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250906135246.19398-4-ziyao@disroot.org>
References: <20250906135246.19398-4-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a992e9000b703a2kunmf083b8f4a90bb
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTUxCVh1OT08YQk9JTh5MSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVPSllXWRYaDxIVHRRZQVlPS0hVSktJT09PS1VKS0tVS1
	kG

Hi,

> +&pcie {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pciem1_pins>, <&pcie_reset_g>;

The pciem1_pins contains PCIE20_PERSTn_M1 (GPIO1_A2)
This will cause conflicts, "pinctrl-0 = <&pciem1_pins>" is enough.

[    0.115608] rockchip-pinctrl pinctrl: not freeing pin 34 (gpio1-2) as part of deactivating group pciem1-pins - it is already used for some other setting
[    0.191042] rockchip-pinctrl pinctrl: pin gpio1-2 already requeste by pll_gpll; cannot claim for 140000000.pcie
[    0.191949] rockchip-pinctrl pinctrl: error -EINVAL: pin-34 (140000000.pcie)
[    0.192570] rockchip-pinctrl pinctrl: error -EINVAL: could not request pin 34 (gpio1-2) from group pciem1-pins on device rockchip-pinctrl

> +	reset-gpios = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;

Missing supply: "vpcie3v3-supply = <&vcc_3v3>;"

> +	status = "okay";
> +};
> +

Thanks,
Chukun

