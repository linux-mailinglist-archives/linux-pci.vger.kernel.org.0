Return-Path: <linux-pci+bounces-35742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C3CB4FBE1
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 14:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A371C23194
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 12:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E1933CE90;
	Tue,  9 Sep 2025 12:55:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94751E6DC5;
	Tue,  9 Sep 2025 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757422548; cv=none; b=u19hp8xTfATLAWI7McwYK0sVdV7H1XBnMOyiRlp8BfaP4Wlimjv9XozGhIcfdWkRTFyEMB+6NQKmOvl8p5YDaMkQcelRf6I3emJMa5QIgamgilWolQC5qpMVhOh383sZW9O/I9a4mf0lrIg03SwnpgIbMmwXqcZ5LpXcMUSql5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757422548; c=relaxed/simple;
	bh=SlLZHi9hYyk1WIaBXHzSMrJKTaTE1+3dUiA7loanxl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pbpnDMBoMm2M514ZzbqJuEKsLsG2HYTei2S6A/gN7cfNtJkC7epxm5w09yMqA8PveXZ0yIc1ON7nEVMwHbKIRS/YQWTvTetQB5BtIyRxqRU1xdnuMwkRzmmqexrOv9hCj2mfU2JiIQAIxz++AJV77FF28IJP75T1EyeZwEJlHsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from localhost.localdomain (unknown [119.122.213.41])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2236a7561;
	Tue, 9 Sep 2025 20:50:32 +0800 (GMT+08:00)
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
Subject: Re: [PATCH 2/3] arm64: dts: rockchip: Add PCIe Gen2x1 controller for RK3528
Date: Tue,  9 Sep 2025 20:50:29 +0800
Message-Id: <20250909125029.2553286-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250906135246.19398-3-ziyao@disroot.org>
References: <20250906135246.19398-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a992e87231103a2kunm3ac1fea6a7ee9
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGEoYVhkYSx1DTkhJQ05JSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVPSllXWRYaDxIVHRRZQVlPS0hVSktJT09PS1VKS0tVS1
	kG

Hi,

> +			reg = <0x1 0x40000000 0x0 0x400000>,
> +			      <0x0 0xfe4f0000 0x0 0x10000>,
> +			      <0x0 0xfc000000 0x0 0x100000>;

Aligning the address for reg and ranges will look better:

		reg = <0x1 0x40000000 0x0 0x400000>,
		      <0x0 0xfe4f0000 0x0 0x010000>,
		      <0x0 0xfc000000 0x0 0x100000>;

BTW do we possibly need this?
https://github.com/rockchip-linux/kernel/commit/e9397245c4b1bd62ef929d221e20225d58467dc7

> +			clocks = <&cru ACLK_PCIE>, <&cru HCLK_PCIE_SLV>,
> +				 <&cru HCLK_PCIE_DBI>, <&cru PCLK_PCIE>,
> +				 <&cru CLK_PCIE_AUX>, <&cru PCLK_PCIE_PHY>;

<&cru PCLK_PCIE_PHY> has already been defined in the combphy node,
is it repeated here?

Thanks,
Chukun

