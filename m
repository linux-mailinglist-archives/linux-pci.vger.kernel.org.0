Return-Path: <linux-pci+bounces-22317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2FBA43BCA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 11:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20FF19E255C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 10:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5693B266B4F;
	Tue, 25 Feb 2025 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="SfHiDG8l";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Jm6bf+RG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D89265CAB;
	Tue, 25 Feb 2025 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479282; cv=none; b=aii6FXE8o5g6p9PqfiDQadg6bCdmf+5oQdN67mHe5HEqUSvT4kRQlT8tucYL5zu7Im3xbS12LzqgimtvmbnXNGnpcblQZnTvImBBcVJbSlvIJ8y6aGufmyM8cHB/6mrdf68lCCaMvYFeGLS9OzCVeEEIw6t17ebcAWh6/ycWHz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479282; c=relaxed/simple;
	bh=wYTkk5joZcekNVfsj7HpZZCqNDj2THYxlEr2GQK5qXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdpFa7I+NZl0uHAZO5ywPQX7JLmdUWR0q3pc71XFGinCiR3hhpVkVFoIUJRIM/odNIMjXRmFFllzaqCfBP4ev9AUZ01cgROxYYsn+ETyPYYNNj1eX697FiroYBBro2rhnMbuCYuPD09kwIR75Z8CbTsXYXJk0j5dmxe6WW5TBXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=SfHiDG8l; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Jm6bf+RG reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740479280; x=1772015280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7WPlvrF7bTDr6Uv4dt2INKqCTAaWqXTlyvruekoPxeI=;
  b=SfHiDG8l5v4fNxZsznIUkXAY7GCFjfPc9R7o3pohEBwj5JiquZzPODnP
   IgBWUSkb/H+qwc0cv7geixeWRkJ9svbVYawSC9vVlfouXlLDMm5LKHyF4
   dJw2hiExLgoIMrcEeCinAptQRMrHrf6kypWHIH9q+3wFobNHlmttPgfl+
   ZXtU3TBXIdhdQGkaUcRNNH4ORGV/0lmHAWw6tSEYoqwKMolOFwIo36aaV
   pwrTGsg08vylCTIVLQt9Qi+6maQjDfXlaLqWOlYjWskv8z5RScpFrq0/Y
   rnmrOKCIyggwMLnhi7VqGQxMzM0Xr3QvqB5yU1ANswElVKWc2CqrFOEHL
   Q==;
X-CSE-ConnectionGUID: /UBrKjp4R1GZK4S6Y90w9w==
X-CSE-MsgGUID: z0wGLHc1SY2iC7hblTXfkQ==
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="42067837"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Feb 2025 11:27:58 +0100
X-CheckPoint: {67BD9B2E-3D-28232521-C0C2250B}
X-MAIL-CPID: 4232913E294A967EECF1F9D2E5748447_4
X-Control-Analysis: str=0001.0A00211E.67BD9B2E.0027,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C57B61686C1;
	Tue, 25 Feb 2025 11:27:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740479274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WPlvrF7bTDr6Uv4dt2INKqCTAaWqXTlyvruekoPxeI=;
	b=Jm6bf+RGwm8llVKo1gknWYQP2i23wSfG1Pk5HFTeRlMw4zzEN7WKb8Sd20LeDWfcziafjc
	18XZvRlsnLVvl8xtWp0M3XTxCONAC3/nge78ja/5GX/GQzCd/xeAxYm6/YShi5BZ5TCiYl
	jkX6ZFkmrp7PJIwI7DCSBSN67dDeKRVQjxsV/ELJhbzeAcSszcuFtQZX569LWSG7656udf
	AiyxJNW/loaqf9yKXmgh92ED8eaBqoI91xLtIHuuO2nVbCc33ZJDa3mNTZC1vePYVEc/+Z
	ehH9Tp4AlPFrmq92QFHTJ0xDNevhYO+LQnCYHEUOwgqwz3Td4Setqol18ekUEg==
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
Subject: [PATCH 3/3] arm64: dts: mba8xx: Remove invalid propert
Date: Tue, 25 Feb 2025 11:27:23 +0100
Message-ID: <20250225102726.654070-4-alexander.stein@ew.tq-group.com>
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

disable-gpio is an (old) downstream kernel property, which slipped into
DT. Remove it.

Fixes: c01a26b8897a ("arm64: dts: mba8xx: Add PCIe support")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/mba8xx.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/mba8xx.dtsi b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
index 117f657283191..c4b5663949ade 100644
--- a/arch/arm64/boot/dts/freescale/mba8xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
@@ -328,7 +328,6 @@ &pcieb {
 	pinctrl-0 = <&pinctrl_pcieb>;
 	pinctrl-names = "default";
 	reset-gpios = <&lsio_gpio4 0 GPIO_ACTIVE_LOW>;
-	disable-gpio = <&expander 7 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie_1v5>;
 	status = "okay";
 };
-- 
2.43.0


