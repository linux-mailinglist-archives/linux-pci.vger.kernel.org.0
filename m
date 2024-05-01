Return-Path: <linux-pci+bounces-6931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 364F38B84FE
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 06:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4632DB21594
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 04:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937BB4F60D;
	Wed,  1 May 2024 04:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcOxE6aV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602A4E1DD;
	Wed,  1 May 2024 04:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714537752; cv=none; b=C3qOmHu0RD5nvu5bVZIcqFIdyLGKNsjLVktaJIT2uFDfOobd5td2FHvhTBfwd8lLVE9oISSy1Eii0jaQsgracp+h0CxrlvA6jYnA5mrigsKUOJpE0vjZdH2jOAtkwmyawiIR5i33SMn5N9Rcq7Fi1u79zOOYP1YvdTZoQDjuRH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714537752; c=relaxed/simple;
	bh=SGFo0nYVaGclh6uWy9vzUTrAnYsZxkd5dvKmm42KMDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XFcZLMayxemrU/MuRqt8lwUtzXaUGtJdJQTcc0VsqkixwPUhij09e6XAob57gqeKNjXrVHJ7860Zhqu2yRJTUuodCzja9EjHX2R6+5Z5wnhJQucp/J2sQiCLVH8ES5vlE323g4J6rQTguuWN9GIoY27ciBKoe/0j+P1Dsy0S3Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcOxE6aV; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ee2fda66easo1542799a34.3;
        Tue, 30 Apr 2024 21:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714537750; x=1715142550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lS+64DkLIQ8nbNaGoMXOJ1Gbc+Q4ngs9pfz0WhHIiSc=;
        b=PcOxE6aVyVoVzI7eWwpBaJtFGmrTA8ejLu3boRu9fMrAUVG7UrDZC8GHrOrcMYa/ZA
         VB3J9XD8sfaZi2yDztuuRPpdsRF5RPxPwWIMn2MDUSB794EwhK+9z2DKwCJwlZdeZatR
         M4CaTQrfaMJPV4A2RksOmiNH4eMyYhGvkzDzQ1UWYOHcq9qrsbob8cqTr0XMGE9F6r/5
         U8qPyOt4XYOOjJxMMZbN6JNQ5atCZwecn+IvpcspE/B1yCT/x3KiPYyzPpf6VR3Z5G51
         pVoPA+RFBAMSkKjLOlEGs4iL9wVNdL2dQ3GPa84jrFn1gS+PlmZYtCS+NHf4xl8cg92S
         P2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714537750; x=1715142550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lS+64DkLIQ8nbNaGoMXOJ1Gbc+Q4ngs9pfz0WhHIiSc=;
        b=A7RN/XJOmIj9rvYCNFcU3mAY6I6CkJ4z71Es0DOjrcke1K1r60i+5DAmX/GI/iJYN4
         oWBwXUiI9F8U1QNDIa1FDbfTKaXn3gXvPdjsKHdJBvHl68q63yVdftlPiRErsSaQFb55
         5qd8M5pVGa7O4DU/CDB1ihbAoNmhwSc/3CvL8np7nTGIfuUQv7G1yl1Jotmmu/U+hUMy
         aLVsNZb8+wzdh+t7E0c1wZNPKXOh8gSr9J3I5Zm8VqGIwP+/XZv8ViNAvnZitdBOOS1R
         vkUx0snQ1EX3xPTeb4UzDSqaezdC7MqBeSkgC9QFVSU6UoP8Ta3eEFvgnPNGjyE7jlic
         bJDw==
X-Forwarded-Encrypted: i=1; AJvYcCWkpJHBzJy5KWecAXCJHdym1MuB0fYLz0fzcQZa2H7WpHG0WtkSC8s9RFwFSajK/x8Jro7ELXgrSLrzp7jXeI2yLk4djzozJESfGz0cXPf7wnhpZvW8CF/VKpnvOBuf1dcJ5clvA6fMX/CYAabUqecgYdGrwva+1e/yK7shSHpB6sz12wcbdoirI5Mi1oD4So6oBqoA8v+I69Hp60Et/SbjMLf5j4zHcBjAJ7gKbpaXCBfvomaRYJnkR0SG60g=
X-Gm-Message-State: AOJu0YxKDPJf7aNL4hiqyy0alz3yseBYbCJIS4MQ/wZ1hpDF4S/eSftv
	/mLm6su/ASve38F8f2ikiGCGXYne9Qu1lYFEK0czhUFECuKXQTen
X-Google-Smtp-Source: AGHT+IGIrAKyP/bGpH/Jtpq/owhHBsB2H5z0Uq8LIuVBmhtjxaoJpsLgICttbWudaLL6KNIRsTBjMw==
X-Received: by 2002:a05:6830:100f:b0:6ee:575b:8dd5 with SMTP id a15-20020a056830100f00b006ee575b8dd5mr1499213otp.20.1714537750061;
        Tue, 30 Apr 2024 21:29:10 -0700 (PDT)
Received: from nukework.lan (c-98-197-58-203.hsd1.tx.comcast.net. [98.197.58.203])
        by smtp.gmail.com with ESMTPSA id do26-20020a0568300e1a00b006ed6dc9fd54sm2719058otb.25.2024.04.30.21.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 21:29:09 -0700 (PDT)
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
Subject: [PATCH v4 RESEND 8/8] arm64: dts: qcom: ipq9574: add PCIe2 and PCIe3 nodes
Date: Tue, 30 Apr 2024 23:28:47 -0500
Message-Id: <20240501042847.1545145-9-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
References: <20240501042847.1545145-1-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On ipq9574, there are 4 PCIe controllers. Describe the pcie2 and pcie3
nodes, and their PHYs in devicetree.

The pcie0 and pcie1 controllers use a gen3x1 PHY, which is not
currently supported. Hence, only pcie2 and pcie3 are described. Only
pcie2 was tested because my devboard only has conenctions to pcie2.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 178 +++++++++++++++++++++++++-
 1 file changed, 176 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 7f2e5cbf3bbb..c391886cf9ab 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -300,8 +300,8 @@ gcc: clock-controller@1800000 {
 				 <0>,
 				 <0>,
 				 <0>,
-				 <0>,
-				 <0>,
+				 <&pcie2_phy>,
+				 <&pcie3_phy>,
 				 <0>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -745,6 +745,180 @@ frame@b128000 {
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
+				 <&gcc GCC_PCIE2_PIPE_CLK>;
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "pipe";
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
+		pcie3_phy: phy@f4000 {
+			compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
+			reg = <0x000f4000 0x14f4>;
+
+			clocks = <&gcc GCC_PCIE3_AUX_CLK>,
+				 <&gcc GCC_PCIE3_AHB_CLK>,
+				 <&gcc GCC_PCIE3_PIPE_CLK>;
+			clock-names = "aux",
+				      "cfg_ahb",
+				      "pipe";
+
+			clock-output-names = "pcie_phy3_pipe_clk";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+
+			resets = <&gcc GCC_PCIE3_PHY_BCR>,
+				 <&gcc GCC_PCIE3PHY_PHY_BCR>;
+			reset-names = "phy",
+				      "common";
+			status = "disabled";
+		};
+
+		/* TODO: Populate pcie0/pcie1 when gen3x1 phy support is added. */
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
+			ranges = <0x81000000 0x0 0x20200000 0x20200000 0x0 0x00100000>,
+				 <0x82000000 0x0 0x20300000 0x20300000 0x0 0x07d00000>;
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
+			interrupt-map = <0 0 0 1 &intc 0 0 164 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 165 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 186 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 187 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE2_AXI_M_CLK>,
+				 <&gcc GCC_PCIE2_AXI_S_CLK>,
+				 <&gcc GCC_PCIE2_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_ANOC_PCIE2_2LANE_M_CLK>,
+				 <&gcc GCC_SNOC_PCIE2_2LANE_S_CLK>,
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
+
+		pcie3: pcie@18000000 {
+			compatible = "qcom,pcie-ipq9574";
+			reg = <0x18000000 0xf1d>,
+			      <0x18000f20 0xa8>,
+			      <0x18001000 0x1000>,
+			      <0x000f0000 0x4000>,
+			      <0x18100000 0x1000>;
+			reg-names = "dbi", "elbi", "atu", "parf", "config";
+
+			ranges = <0x81000000 0x0 0x18200000 0x18200000 0x0 0x00100000>,
+				 <0x82000000 0x0 0x18300000 0x18300000 0x0 0x07d00000>;
+
+			device_type = "pci";
+			linux,pci-domain = <4>;
+			bus-range = <0x00 0xff>;
+			num-lanes = <2>;
+			max-link-speed = <3>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+
+			phys = <&pcie3_phy>;
+			phy-names = "pciephy";
+
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0x7>;
+			interrupt-map = <0 0 0 1 &intc 0 0 189 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &intc 0 0 190 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &intc 0 0 192 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &intc 0 0 192 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_PCIE3_AXI_M_CLK>,
+				 <&gcc GCC_PCIE3_AXI_S_CLK>,
+				 <&gcc GCC_PCIE3_AXI_S_BRIDGE_CLK>,
+				 <&gcc GCC_ANOC_PCIE3_2LANE_M_CLK>,
+				 <&gcc GCC_SNOC_PCIE3_2LANE_S_CLK>,
+				 <&gcc GCC_PCIE3_RCHNG_CLK>;
+			clock-names = "axi_m",
+				      "axi_s",
+				      "axi_bridge",
+				      "anoc",
+				      "snoc",
+				      "rchng";
+
+			resets = <&gcc GCC_PCIE3_PIPE_ARES>,
+				 <&gcc GCC_PCIE3_AUX_ARES>,
+				 <&gcc GCC_PCIE3_CORE_STICKY_ARES>,
+				 <&gcc GCC_PCIE3_AXI_M_ARES>,
+				 <&gcc GCC_PCIE3_AXI_S_ARES>,
+				 <&gcc GCC_PCIE3_AXI_S_STICKY_ARES>,
+				 <&gcc GCC_PCIE3_AXI_M_STICKY_ARES>,
+				 <&gcc GCC_PCIE3_AHB_ARES>;
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


