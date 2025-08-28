Return-Path: <linux-pci+bounces-34961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F19B3919B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 04:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B9C47B6580
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 02:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BF81DF75D;
	Thu, 28 Aug 2025 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2Cuiw58"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A2F7260A;
	Thu, 28 Aug 2025 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756347491; cv=none; b=equfo4UkvyVqo4nTj4PWKGNAAo58pDvqu7MGOLesA9Y80koBk8pnYtL6fUeDX14UZVtjvIbhOBiCvXYs7W1UybDqED1HdZitsBPlf8/o/JWmOCKC8XKxUR8aTpCQ0Lvap6N0ENJaWfF7emhDr681MKZOZRbirUj19Yl9zlMFA/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756347491; c=relaxed/simple;
	bh=TVeTlkxDwqekJxD6/BHcDv8RS0hvaJMteIaNKw3WWyM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dTl9+gOijawxBAKa0sX5njLfYIufPJUtpxQ73G5PF21xUOYYs1j4ex+Bj3u5Tn94N2WHxK0iJwAn7i5S1IzlTboftFUKjQ+ElQeSy7CWS24ZeSc5ldIAs2aH1SQI2decaz1BpA9N5XJm2gFUzLhbGY2tEyzuI0QsGd2ntysUvm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2Cuiw58; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-74381efd643so209046a34.1;
        Wed, 27 Aug 2025 19:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756347489; x=1756952289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lw9R9KQylny50IUlY0ox7tSDg7XfT5zo+Jx/4FOsYMk=;
        b=b2Cuiw58bTwPX13TdEW8rVx+NiMV1mVsHSM+HKp7nG2WXGvfePOdjymr5CdVTOtCeA
         /WywCnqGIQw4Z+Kt2zQOrU39PDdUc1XS3/gKmhb1MUonVYbeaAAWRStaHvFAAiLrlYz4
         gFe+uHXPw/jYz8JXw5jJHGxtbk8Crq61QMpN6XuKpnF11qDVAbTiTlFKK8Ezf73UFqkq
         CTcKnFFY5GVz+QZrabIv5LfbPIM2o9DCe/jvrGLqrHYFR2L+ynC5e+QYM7Jm7MgCgG2F
         sEvmS0joHKbu9+keR+g93Jq3RumaI6pbv7XgmEM8YyWWy/sN7aj3FiAXMaGztXWeWsTi
         SQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756347489; x=1756952289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lw9R9KQylny50IUlY0ox7tSDg7XfT5zo+Jx/4FOsYMk=;
        b=G20hRhqoNjoJcR/3DgXtZANneujSIHQp9NbWe/l5AEailPivqU1X0cOtZOBR1ISKIe
         vR5ez+J5p1YGkAYAJp2G2A6Han4d5Gb+1+YOe7L3H+eRNwfo8zil/YmLKVpOpV7+ycaA
         ZZn4kufMaDtEFc2BjBePcfZAVaIpYnCoxO+6ceiBFUu96WwSgWBMNKYkqpAPKAdIV9/f
         rC1D5ftwI4j/nrh0A9vlM9vExsDbK7t1r0uIr9BMF8iJdEQoZDbZ2v5ityggV6e7Qbny
         JJI11ZMx8raU8AOcSx1iE3twxMf/U9WrPyLbs9O/dI+uqZjAT4e+ekT4Xv+GZ7ywAGU7
         eLXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3IvRAvdZ8lYaaGfcANvCs53V+NSBugGXExWRFP9rnXvOeGrNVUazpeAYtz3pVAZVqicMGXNrIoovD@vger.kernel.org, AJvYcCVYbvU1t8vMxtlK0tipiEBRNwqDBqren+IDk9CWkLwoSYiFzCFndYSjNL+xogJVqSWAwrxSUJJH2cxx@vger.kernel.org, AJvYcCVmZbC+2x/OWjVsOkTzPAK6ophNiX4bk3NS3PV1oMyPdDLFHqtAzcUPIpao7mHnAhtYLzVxjS5DQMT7QZ7p@vger.kernel.org
X-Gm-Message-State: AOJu0YxdhiFWKXlD2+FKNEz7OMKl7lJMqTnLVNlNVle+T4M7ipiA2SJO
	zSQjkUw5gDg2fun35YQPMatJ1cCRsJ+OSZiDbMKdKYmNXyTMAHfKs3oH
X-Gm-Gg: ASbGncuQu3LZmrEsp9ZzRBwOA+55KL85lg3+ONYkTPUNZUNKhYf+wmuJTTaKZd1jWBC
	q0y4QPhKTiVwHHuEzZkg2JUTIcjj5ip3NbBQM6stKdlIUpYxjs2bFDDOxqjagATaTzgFxX4nRhL
	bN9uvSspU470VfGy45jl/YuotB0KMM4sHMQLDyxMFIX6yvaL8Y2p2M2KOKxezj83POXkIbrZ3mP
	Q5u8+9kwoxulJ2Cuq+DgP8bdqN8Ri4nA3N+7UzToZhxmqIA/OQGfYfRg9tP7b7sUroSaIbZNS+F
	m3zRC6ueGsLsOjxlQSTi7sooM7L43W/JBi6uNTN7Hn8hQQu0kQgThlywwyGZwjAvBLrHVEPPJJe
	DU6S4cwU863wwBW7Bjc1vlrWqb170Took
X-Google-Smtp-Source: AGHT+IGLh44dGgjMBAdZ8+L1YTxNe6vactvoL8NAqKvzlPhnz8iFt3JVHKV663JR1fRhVGA14N15DQ==
X-Received: by 2002:a05:6808:118d:b0:435:6cc4:9753 with SMTP id 5614622812f47-43785190f04mr9072791b6e.8.1756347489002;
        Wed, 27 Aug 2025 19:18:09 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-437967be68bsm2311340b6e.4.2025.08.27.19.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 19:18:08 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: kwilczynski@kernel.org,
	u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	arnd@arndb.de,
	bwawrzyn@cisco.com,
	bhelgaas@google.com,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	18255117159@163.com,
	inochiama@gmail.com,
	kishon@kernel.org,
	krzk+dt@kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	s-vadapalli@ti.com,
	tglx@linutronix.de,
	thomas.richard@bootlin.com,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	rabenda.cn@gmail.com,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: [PATCH 4/5] riscv: sophgo: dts: add pcie controllers for SG2042
Date: Thu, 28 Aug 2025 10:18:00 +0800
Message-Id: <96df911a622547c6c987895fefde9110f3fcac03.1756344464.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756344464.git.unicorn_wang@outlook.com>
References: <cover.1756344464.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add PCIe controller nodes in DTS for Sophgo SG2042.
Default they are disabled.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 66 ++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index b3e4d3c18fdc..346aba5bd9bf 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -220,6 +220,72 @@ clkgen: clock-controller@7030012000 {
 			#clock-cells = <1>;
 		};
 
+		pcie_rc0: pcie@7060000000 {
+			compatible = "sophgo,sg2042-pcie-host";
+			device_type = "pci";
+			reg = <0x70 0x60000000  0x0 0x02000000>,
+			      <0x40 0x00000000  0x0 0x00001000>;
+			reg-names = "reg", "cfg";
+			linux,pci-domain = <0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0  0xc0000000  0x40 0xc0000000  0x0 0x00400000>,
+				 <0x42000000 0x0  0xd0000000  0x40 0xd0000000  0x0 0x10000000>,
+				 <0x02000000 0x0  0xe0000000  0x40 0xe0000000  0x0 0x20000000>,
+				 <0x43000000 0x42 0x00000000  0x42 0x00000000  0x2 0x00000000>,
+				 <0x03000000 0x41 0x00000000  0x41 0x00000000  0x1 0x00000000>;
+			bus-range = <0x0 0xff>;
+			vendor-id = <0x1f1c>;
+			device-id = <0x2042>;
+			cdns,no-bar-match-nbits = <48>;
+			msi-parent = <&msi>;
+			status = "disabled";
+		};
+
+		pcie_rc1: pcie@7062000000 {
+			compatible = "sophgo,sg2042-pcie-host";
+			device_type = "pci";
+			reg = <0x70 0x62000000  0x0 0x00800000>,
+			      <0x48 0x00000000  0x0 0x00001000>;
+			reg-names = "reg", "cfg";
+			linux,pci-domain = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0  0xc0800000  0x48 0xc0800000  0x0 0x00400000>,
+				 <0x42000000 0x0  0xd0000000  0x48 0xd0000000  0x0 0x10000000>,
+				 <0x02000000 0x0  0xe0000000  0x48 0xe0000000  0x0 0x20000000>,
+				 <0x03000000 0x49 0x00000000  0x49 0x00000000  0x1 0x00000000>,
+				 <0x43000000 0x4a 0x00000000  0x4a 0x00000000  0x2 0x00000000>;
+			bus-range = <0x0 0xff>;
+			vendor-id = <0x1f1c>;
+			device-id = <0x2042>;
+			cdns,no-bar-match-nbits = <48>;
+			msi-parent = <&msi>;
+			status = "disabled";
+		};
+
+		pcie_rc2: pcie@7062800000 {
+			compatible = "sophgo,sg2042-pcie-host";
+			device_type = "pci";
+			reg = <0x70 0x62800000  0x0 0x00800000>,
+			      <0x4c 0x00000000  0x0 0x00001000>;
+			reg-names = "reg", "cfg";
+			linux,pci-domain = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0  0xc0c00000  0x4c 0xc0c00000  0x0 0x00400000>,
+				 <0x42000000 0x0  0xf8000000  0x4c 0xf8000000  0x0 0x04000000>,
+				 <0x02000000 0x0  0xfc000000  0x4c 0xfc000000  0x0 0x04000000>,
+				 <0x43000000 0x4e 0x00000000  0x4e 0x00000000  0x2 0x00000000>,
+				 <0x03000000 0x4d 0x00000000  0x4d 0x00000000  0x1 0x00000000>;
+			bus-range = <0x0 0xff>;
+			vendor-id = <0x1f1c>;
+			device-id = <0x2042>;
+			cdns,no-bar-match-nbits = <48>;
+			msi-parent = <&msi>;
+			status = "disabled";
+		};
+
 		clint_mswi: interrupt-controller@7094000000 {
 			compatible = "sophgo,sg2042-aclint-mswi", "thead,c900-aclint-mswi";
 			reg = <0x00000070 0x94000000 0x00000000 0x00004000>;
-- 
2.34.1


