Return-Path: <linux-pci+bounces-38755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E8DBF17CC
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 15:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9947D1894645
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24582FB0BC;
	Mon, 20 Oct 2025 13:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="uELIpQfi"
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9642FB615;
	Mon, 20 Oct 2025 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966093; cv=none; b=nI8HN1tfCnJebBC/yj0rAXVHQqFH2IwnH9FUX4ktu0UvRucoCfg9SYV09XZWqfgh4xmKqxcYuhD0kwW+nfuVmp4qiVr3S0faoRPkpCeEzUN5heQmPu81MKyna/48hI+hAixUai76S2CmEhJSe7+G12bcp6GKoXYb/gG7umIQMpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966093; c=relaxed/simple;
	bh=Xj85pLtL4OkDv4RF/Km8r7P8VEO+S8gk2Bni8WVS4+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WctZZGIIvPmT5ka0saETAAnZXurQPyDe7I8HA9BXeEOaw8gFGBQo9ZjWvoAvhkgeq9Qgt5mmPIBUURRS6VfzH1/X2h2GO3esnbLi51RDwTk29GpGwsj5JtKpFAU0BvEA1VHO4ePLDy6wDbPWBx+wlcv5tjJPPR5yiHTcGDiJQlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=uELIpQfi; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=CuQNCifUktlMCAA4v8tmCWank1/HSzSiksw1WUKqzUc=; b=uELIpQfigKvvT9McDvhdbiIu/c
	zlGP7XcXJrLNQcPukS4BU+SgL7bIIFazM0OVpQ/HbL2H7+59YcHeZm4Q1D4mI3pCLAB+P4TJcn9HI
	A7fV1OifN1hw2ERuqgWa3o9PogVvleK7G6EtM1R5+N2IwjTo9IYgTd9c0VIbRK/LynLllv1hk5buy
	WqgHQYzgysvNldEUCUTUSniEajLmisXl0JUo50ccLUNSn5dvP0lDMbqXKVCalpiLPOKIvcdlyqpYP
	MW8XLCKz5Kzq90Tx5xPHAY1gJ/9Y4wYS7H/QZyFKxgR8pX7xMaoQhut98GvAgq77NKBtS+0wO1wQg
	lH6z4rgw==;
Received: from [141.76.253.240] (helo=phil.eduroam.local)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vApim-0001Qj-4C; Mon, 20 Oct 2025 15:14:44 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>,
	Yao Zi <ziyao@disroot.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: Re: (subset) [PATCH v2 0/3] Add PCIe Gen2x1 controller support for RK3528
Date: Mon, 20 Oct 2025 15:14:41 +0200
Message-ID: <176096606936.3742628.8434480469163363343.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250918153057.56023-1-ziyao@disroot.org>
References: <20250918153057.56023-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 18 Sep 2025 15:30:54 +0000, Yao Zi wrote:
> Rockchip RK3528 ships one PCIe Gen2x1 controller that operates in RC
> mode only. The SoC doesn't provide a separate MSI controller, thus the
> one integrated in designware PCIe IP must be used. This series documents
> the PCIe controller in dt-binding and describes it in the SoC devicetree.
> 
> Radxa E20C board is used for testing, whose LAN GbE port is provided
> through an RTL8111H chip connected to PCIe controller. Its devicetree
> is adjusted to enable the controller, and IPERF3 shows the interface
> runs at full-speed. A typical result looks like
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: rockchip: Add PCIe Gen2x1 controller for RK3528
      commit: 263fac6b09b42a1b077c21354370d38758237ab0
[3/3] arm64: dts: rockchip: Enable PCIe controller on Radxa E20C
      commit: 047bac0be317e68b89d0deed4f659f8e080df6e8

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

