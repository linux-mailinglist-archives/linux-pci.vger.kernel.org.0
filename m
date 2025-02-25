Return-Path: <linux-pci+bounces-22316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BB1A43BBF
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 11:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D1D3BF4B5
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 10:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE6E266EFF;
	Tue, 25 Feb 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="gXJOMJzs";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="eNqu3TvP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B652673AA;
	Tue, 25 Feb 2025 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479276; cv=none; b=GyReN5xFNmi+YBZrYAs6jbm4rOl3U+3aoM353oHDShMPyUxL0saUt5LuS/dpQEUFwB6P7xI9Z3kU0RfeJR4UsD6VDG0Hn/MfouyE4gbh6Xg+49mfGPa1x2brrUQE2rOMNmjhajsi6SANKLfkXd8VXV9abGA95PL/nJW4DEIozXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479276; c=relaxed/simple;
	bh=YU/yYLpMwhdoPEk/QylytAsRFsZhz1duro+rMYsCFXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOQmDe7f6UPuwWwCnbjeLwWA15uOy/CDNUTufqqouzSdCX1vu/hrTlGm3vfeYpzk7z4fiKMxC9zz70EnKLuWURyjtGJeCTn9fqUaMq45MwN/dRN9zGsbbmIehovjegsE7AD00SE9BeAmNIEhmsK7mOoeHN1S9ZODqlNarmZgKiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=gXJOMJzs; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=eNqu3TvP reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740479274; x=1772015274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fqAYBDAVCYCQi9MMMbeyCHhhscUCDXvB1ISPevufvf0=;
  b=gXJOMJzs8kdTGf2Gyetjs1P5r/7LYLBHCtX5QWkklJ3OMTCxmwxJSx2N
   IAyAIIDQpPdPqveQyPqghOrNrECdAETDkSdHCVXDYanK+A41YZgLGMBMo
   +Gtu3g6+9HlEksu6zsfiorOiS8R4voHB3Ro4zdGyw84hGjbZC3NZp9PPu
   orZXkMuORhCKGAQ44/gjs3tDkH/tEyt1o6oKs7hgQKF1s7XN1KKMjtsTC
   cMBA3zbjdKzGPiEgGH2jQLGKUAESuvkDidMRt2aDqzUqPt0F8OOmOoivo
   lPdJyWvZ++vzy6H9A5MuohF1PkS2ab8dHqEAaywHipz3fh+5vt6dcox/C
   w==;
X-CSE-ConnectionGUID: b7gwE+2dQ3io9DJjdqHNgA==
X-CSE-MsgGUID: /yDPvrG9T0Wv3Xt0KwMUNQ==
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="42067836"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Feb 2025 11:27:53 +0100
X-CheckPoint: {67BD9B29-C-28232521-C0C2250B}
X-MAIL-CPID: 498C7020E3CB29D871E592514CF28AC0_4
X-Control-Analysis: str=0001.0A00211A.67BD9B28.005D,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4AA071686BB;
	Tue, 25 Feb 2025 11:27:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740479269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fqAYBDAVCYCQi9MMMbeyCHhhscUCDXvB1ISPevufvf0=;
	b=eNqu3TvP8uyJl7sLxEQ/ahL7dSqnuRZO2267pF8q42Tjb0trgN6q++9Jh6NfTQPH2UuqPx
	+iVs/E0O4zuK9HvLCxylypzT++uq4x0H/Wh2N7F0ckZbigC40iVAC05SFA+OpiGbg81+n/
	bmGtXjgQMkIJsRDxeK+xgYR3YucIV8t34HpmFt5+m67rmCxyK2IufsP72WQ2qeADg0f0ix
	dolfZLytlwFt5j3A9Z8jfce85F8PPOyeo6Ik7Qd6aLQnE13jIG+ywNCSFjdONC4wk6rGX9
	MkCLJ9/gYCr667DKhRyWM7VHftTDE7OBwnfVysdssP9092f58FqTk9eIVFv1Yw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Frank Li <Frank.li@nxp.com>
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Subject: [PATCH 2/3] arm64: dts: imx8qm-ss-hsio: Wire up DMA IRQ for PCIe
Date: Tue, 25 Feb 2025 11:27:22 +0100
Message-ID: <20250225102726.654070-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225102726.654070-1-alexander.stein@ew.tq-group.com>
References: <20250225102726.654070-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

IRQ mapping is already present. Add the missing DMA interrupt. This is
similar to commit 9d9c56025e429 ("arm64: dts: imx8-ss-hsio: Wire up DMA
IRQ for PCIe")

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
index d52609e4fc455..e80f722dbe65f 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-hsio.dtsi
@@ -69,8 +69,9 @@ pcieb: pcie@5f010000 {
 		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
 			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
 		#interrupt-cells = <1>;
-		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "msi";
+		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "msi", "dma";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		clocks = <&pcieb_lpcg IMX_LPCG_CLK_6>,
-- 
2.43.0


