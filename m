Return-Path: <linux-pci+bounces-26386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFB6A9680C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 13:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9A9F3A4F33
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 11:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F88327BF9E;
	Tue, 22 Apr 2025 11:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="1le15bX3"
X-Original-To: linux-pci@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997A1BD01F;
	Tue, 22 Apr 2025 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745322284; cv=none; b=NBENtm1cOW+kyDHE+CipR/Q/2PQpHwSxbWNQ+fdQ967YmKI06e2i/LBHlLT0L4yaq3iKb8sude44ap8//IDiK2qFCEQAdgBwwpnJ7xf+7KxqO62ZVRevFl8JH1+rIcQsf4J1YgYldCHudkWo5hMEinewrFWzVIw9dXhMtr0ut/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745322284; c=relaxed/simple;
	bh=4+6Uck1wuf+x9FJYWRqaAdpe6qhjv2gI1bnK9Nfhl5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QpkfCiu1epJ5Uid4Kasp1BRCsJZy8vYUbqaU7DPMc/PPJ2Nunv8rlpUD87qD9RZWXcEjhmRM8pwxN7TunzKZacRTyVHMWvaHm83SiSK9UCokVSNEAFW/9TzFm1uFbzTiLv2MXGTXyJoeg7z5gSy1XOtb3ukdWnVyHvYLofDYHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=1le15bX3; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7sB1dmuD3GoUpGEiENNK8mtmzVT+tPo02Qc2OEU6BSI=; b=1le15bX3kNYT4sUNY2Wrjt/GOy
	ii2yyzYgWEbcGsSzMMBiQ+xE+hPzZwy8wUPqDMJEYntpikNZhzaXLFYecyMRHkQyjoPe8iIhrwKDE
	Ec8uTlmACS5xjGK94UqaO/TiTKUepSRje0NVodc+Vag4d5CYTfdP9egLdQFqHPtxBncnLeHmb3+nG
	qrhWQPKlZ63/m3gUBPMDeBv+glssWPXZHqLfJefm3WpMIUSzj7NH6BnmRZWd3D21X3381/PYvUJn1
	MgImJGhPrbFMBsW6YI1N7d7GgP7FioNbCJauCmJ05CR4/YwFl/aksPkTXqz9tACb+JMoeNobg391G
	fnzu0iwg==;
Received: from i53875b95.versanet.de ([83.135.91.149] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1u7C3I-0002kK-4j; Tue, 22 Apr 2025 13:44:36 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	andersson@kernel.org,
	Simon Xue <xxm@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Finley Xiao <finley.xiao@rock-chips.com>,
	Frank Wang <frank.wang@rock-chips.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Andy Yan <andy.yan@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH v9 0/2] rockchip: Add rk3576 pcie dts nodes
Date: Tue, 22 Apr 2025 13:44:24 +0200
Message-ID: <174532226023.263993.13596887054519094900.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250414145110.11275-1-kever.yang@rock-chips.com>
References: <20250414145110.11275-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 14 Apr 2025 22:51:08 +0800, Kever Yang wrote:
> This patch set adds support for rk3576 pcie by adding the dts node,
> and this series is a re-base on v6.15-rc1 and collect tags without code
> change.
> 
> Please help take the dt-binding to PCI tree if there is no more change request.
> 
> Thanks,
> Kever
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: rockchip: Add rk3576 pcie nodes
      commit: d4b9fc2af45d2b91b1654c4aaa1edcb4dd8f4918

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

