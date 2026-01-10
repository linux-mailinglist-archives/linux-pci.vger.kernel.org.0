Return-Path: <linux-pci+bounces-44434-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED747D0DB31
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 20:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E56F63079EED
	for <lists+linux-pci@lfdr.de>; Sat, 10 Jan 2026 19:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EC62DCF43;
	Sat, 10 Jan 2026 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1yv9Q0c"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757A2C21F7;
	Sat, 10 Jan 2026 19:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768072306; cv=none; b=FH0j3/FivURbPznEt1dxo/68qqEjLXEauw0+3slVhfAr5FnKP10mtmLa3zqVO9r24mY8mESnnrsx/RBtKsHYAyDYDzjaoxlH6dgKj3nX57jflyaHyrKc1oz4Kx4TDaIZz6zP/CMkDMiEems2kYBDNO00+qtaHdKp4gvIZXQayE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768072306; c=relaxed/simple;
	bh=ORk9zLyAqSVC4BjhBEwJU6A588Pq49HoT3tn4kCPsqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FHQ/QP+pNRy18exhTEpO5OZ4GwuffcMaD98TYF036kSwfQj10FBQhMZQZrjJiKnJhp3DMEcLpT7OA8gGHlYkf0TJErWRygSHozzuJKSpCMMnvrvaHx7MHwMea5o1veaEIt+Dsf+8D2/NdxKaSeqij2tvRb0KeBsYdHtfs+BxQvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1yv9Q0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCA2C16AAE;
	Sat, 10 Jan 2026 19:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768072304;
	bh=ORk9zLyAqSVC4BjhBEwJU6A588Pq49HoT3tn4kCPsqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I1yv9Q0carRpGXDNN3gPGL/6wihqvcW/sidEG5pRQs+jlCNEUCOuPzP2vgKorGJz4
	 d9Fc0p5AGNOMIlD7YUmJVUI41zZ1o851XH4EeLuWu26VLB3ymmMCta/JvouLRSw8Ch
	 y3D54RMdtuOxrT/9r1CZfeQqCf1PsRy2HrfSaqb9nBAhRk2rcpD1x9Tnzf2QK7KSUK
	 FcgpNxwmMCKtNGQ5UcsbwPvi+Lj/oXR+VPyX322kBo43h9o/+D0mQIO1YLooTbe9V9
	 IiVrmKyeQmRN5aIuuGmH+nJPSii4TYweja+Fg1uDJyfPwnBc859maMxp1TiuHU8Nr5
	 0B1yUCS8X3/og==
From: Bjorn Andersson <andersson@kernel.org>
To: konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	johan+linaro@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	neil.armstrong@linaro.org,
	Abel Vesa <abelvesa@kernel.org>,
	Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com,
	quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com,
	Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: Re: [PATCH v4 0/3] Add PCIe3 and PCIe5 support for HAMOA-IOT-EVK board
Date: Sat, 10 Jan 2026 13:11:27 -0600
Message-ID: <176807228439.3708332.9264264204240911796.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109104504.3147745-1-ziyue.zhang@oss.qualcomm.com>
References: <20260109104504.3147745-1-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 09 Jan 2026 18:45:01 +0800, Ziyue Zhang wrote:
> From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> 
> This patch series adds support for PCIe3 and PCIe5 on the HAMOA-IOT-EVK
> board.
> 
> PCIe3 is a Gen4 x8 slot intended for sata controller.
> PCIe5 is a Gen3 x2 slot designed for external modem connectivity.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: hamoa: Move PHY, PERST, and Wake GPIOs to PCIe port nodes and add port Nodes for all PCIe ports
      commit: 960609b22be58baa16823103894de3c6858e6cf4
[2/3] arm64: dts: qcom: Add PCIe3 and PCIe5 support for HAMOA-IOT-SOM platform
      commit: a395b859ecacedc6ff28e6b62e43a7cd1abc34ee
[3/3] arm64: dts: qcom: Add PCIe3 and PCIe5 regulators for HAMAO-IOT-EVK board
      commit: ac62730dbc71e4e2320b368e86e0c6ea3e41f1f5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

