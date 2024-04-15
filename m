Return-Path: <linux-pci+bounces-6286-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85CB8A59D0
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 20:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF00281BBE
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 18:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9C113C830;
	Mon, 15 Apr 2024 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DasJJ/Su"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E9B13C68A;
	Mon, 15 Apr 2024 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205288; cv=none; b=pG+knBSqWIJxJPCfjKCbxlw65OCcKpzpw+6GT/GIzj7ET226ZzzLOfsU++OoozTOdVaxn1WojLdZDCPMlGRXGFUJ5wpt1R/2TcnQMDLJSXKIjfykLWgiQeZyJu/LWR9dB/A8tgSMS5t6D7PSce0rQt0n73tHyf8S62I8nsR+mIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205288; c=relaxed/simple;
	bh=AQI/LvmjE4IEpy1RdNz2zpAKf1LZ2lytZtsviYqCPIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LBsH+ECrGKCn9TMeuH+B6UXWnrB0cPDend9qgPzfAMJ2yvChvU3j8gXRG9Kqi45XDfLJOLUYiIS+9ALLDvz7VkowtPKqAe8EAJYKAbUPhTuJrAjmIuCE8tDm3a1aG4izpOL3JKguw+FOOw4IpYZwu3Ew8OgpGQB+g62hrbHtzVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DasJJ/Su; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5ac61cf3fffso2284216eaf.3;
        Mon, 15 Apr 2024 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713205286; x=1713810086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzgGDQmklEWFrISIR4IcwxoAKiKCzk4r1Ppmvkj7XiQ=;
        b=DasJJ/SuEyk5U8eyV8CwJGBs+NiZSfuC6fyIHE+BiD3SIliH8KjNbLDA1z9e5WrEtQ
         iIFw/IEdJsK7F3Erl8VBEaWjVSnCqrP5+YVU9VihFGczyUYPWHWt1ddVZjj6XDwuC389
         rjYc/xk0HSFY1s0ALNft4HE42KPV4moZF7GjJEoo3QTm2C2npM78spyaY4dVjGyKFp24
         BPYg4eYi5drWcsMgaJpBRU5SQKvZ/3mqiRen5Ljq15Qi1Ixv6d0vAOdEq8aWabobd/Go
         QQOq1nmX+9CER7byveGH9YVW6V7zJAovCc/BR6tbNbIxh2rzRip3Q9FCAXcnv9MaoR+e
         rJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205286; x=1713810086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzgGDQmklEWFrISIR4IcwxoAKiKCzk4r1Ppmvkj7XiQ=;
        b=ATuwCKp/oUWegcQzwl3roIh4iDuj9Ghr1lNkOkoMrt91VMl6piIzZyyBjBWGAbVn+R
         Hz7nVyUYm4Wr0LkBvb/XcDTqaob7k+WlK1GUOumed2CQozTV5y+nQ8FyNi3ivToKYe3h
         6qteAasedrvg8ovcMDQrI33eFXYiTCg2GMO273ek0+yfuX7MgkvgUJtqlhTSXtSXbZ/c
         wvmHR5CkLHjqoMQfl1lB9tifx8K+jWSPdL9HJGmdchlvQbgssUK8O5jTDv9+YOAqvTIX
         Vfjfqq18HHMbVQnnndajChnT84rbvG+F5SZSy84508XYx0nkJQqXPHrWEP0Qm3OCQoIB
         j8YQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4YiqlDfFAk2k8a9JVdJD6OaQ3MiNWJ5/U6pwfGfGuPxJz1vWTMmuEIv/YWJyTx7u8Tqan006a4B5vk5nkv0ACHWdbARpXzZ5yl1/YyBKfAPURhXhGloQj9bu45wnUwpR8gfis5DHEsjwWdYx+Fz+lpZNPv784JWvajZPD0BE6Idb4B+F270AMRw6RUV72UHn9mKxO84r4Vx8PRQAZrbswKb9ZIcPoqfBgV17vmbhnWotzR3DHaNI9SgtBzjM=
X-Gm-Message-State: AOJu0YxwcGumhWy151CsnXPwcRP7jjNAmaz40kT2Z1zgHA+55Y7AkVLc
	5Gr8crHTUVFNqBBXIeWDxlkK00cH70fWY/1hyY0dJDMtqCjxg8Iv
X-Google-Smtp-Source: AGHT+IFzBspjAQ4rLg81eFZJL29bkc3W+mz4hD/gAWcReSsmqzSYHyKiD0HMSDTzbp14adcuHiezMg==
X-Received: by 2002:a4a:1ac3:0:b0:5ac:9ff2:8ca4 with SMTP id 186-20020a4a1ac3000000b005ac9ff28ca4mr4669479oof.6.1713205285937;
        Mon, 15 Apr 2024 11:21:25 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id x4-20020a056820104400b005a4dc7abc01sm2177494oot.11.2024.04.15.11.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:21:25 -0700 (PDT)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org
Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Subject: [PATCH v3 7/7] arm64: dts: qcom: ipq9574: add PCIe2 nodes
Date: Mon, 15 Apr 2024 13:20:52 -0500
Message-Id: <20240415182052.374494-8-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415182052.374494-1-mr.nuke.me@gmail.com>
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On ipq9574, there are 4 PCIe controllers. Describe the pcie2 node, and
its PHY in devicetree.

Only pcie2 is described, because only hardware using that controller
was available for testing.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 93 ++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 7f2e5cbf3bbb..f075e2715300 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -300,7 +300,7 @@ gcc: clock-controller@1800000 {
 				 <0>,
 				 <0>,
 				 <0>,
-				 <0>,
+				 <&pcie2_phy>,
 				 <0>,
 				 <0>;
 			#clock-cells = <1>;
@@ -745,6 +745,97 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		pcie2_phy: phy@8c000 {
+			compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
+			reg = <0x0008c000 0x14f4>;
+
+			clocks = <&gcc GCC_PCIE2_AUX_CLK>,
+				 <&gcc GCC_PCIE2_AHB_CLK>,
+				 <&gcc GCC_PCIE2_PIPE_CLK>,
+				 <&gcc GCC_ANOC_PCIE2_2LANE_M_CLK>,
+				 <&gcc GCC_SNOC_PCIE2_2LANE_S_CLK>;
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "pipe",
+				      "anoc",
+				      "snoc";
+
+			clock-output-names = "pcie_phy2_pipe_clk";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+
+			resets = <&gcc GCC_PCIE2_PHY_BCR>,
+				 <&gcc GCC_PCIE2PHY_PHY_BCR>;
+			reset-names = "phy",
+				      "common";
+			status = "disabled";
+		};
+
+		pcie2: pcie@20000000 {
+			compatible = "qcom,pcie-ipq9574";
+			reg = <0x20000000 0xf1d>,
+			      <0x20000f20 0xa8>,
+			      <0x20001000 0x1000>,
+			      <0x00088000 0x4000>,
+			      <0x20100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+
+			ranges = <0x81000000 0x0 0x20200000 0x20200000 0x0 0x00100000>,	/* I/O */
+				 <0x82000000 0x0 0x20300000 0x20300000 0x0 0x07d00000>;	/* MEM */
+
+			device_type = "pci";
+			linux,pci-domain = <3>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+			max-link-speed = <3>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			phys = <&pcie2_phy>;
+			phy-names = "pciephy";
+
+			interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 164
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 0 165
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 0 186
+					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 0 187
+					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+			clocks = <&gcc GCC_PCIE2_AXI_M_CLK>,
+				 <&gcc GCC_PCIE2_AXI_S_CLK>,
+				 <&gcc GCC_PCIE2_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_PCIE2_RCHNG_CLK>;
+			clock-names = "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "rchng";
+
+			resets = <&gcc GCC_PCIE2_PIPE_ARES>,
+				 <&gcc GCC_PCIE2_AUX_ARES>,
+				 <&gcc GCC_PCIE2_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE2_AXI_M_ARES>,
+				 <&gcc GCC_PCIE2_AXI_S_ARES>,
+				 <&gcc GCC_PCIE2_AXI_S_STICKY_ARES>,
+				 <&gcc GCC_PCIE2_AXI_M_STICKY_ARES>,
+				 <&gcc GCC_PCIE2_AHB_ARES>;
+			reset-names = "pipe",
+				      "aux",
+				      "sticky",
+				      "axi_m",
+				      "axi_s",
+				      "axi_s_sticky",
+				      "axi_m_sticky",
+				      "ahb";
+			status = "disabled";
+		};
 	};
 
 	thermal-zones {
-- 
2.40.1


