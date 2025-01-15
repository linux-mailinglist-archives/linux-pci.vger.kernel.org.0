Return-Path: <linux-pci+bounces-19831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE0BA11A6D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F2F163743
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125F122FADE;
	Wed, 15 Jan 2025 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWUlc4Lp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F8C22F392;
	Wed, 15 Jan 2025 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924864; cv=none; b=DCk2TT8S8a4fZWe/SFu/cyuCb9pYFDgNCBF6/fE9Xlw2i61ROEydXhAY567blef0v2H3ASvHqnf3WNopmncZ0udAHlOSxs8Qimfg0xzTgh7+Eh+LY9f3H1+HfAzC3H/WscZ/ws27cJwnmWNHawy0Wts6GShXJ5JEUpkUa8clRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924864; c=relaxed/simple;
	bh=SlB0hnEn9u8stsy2BoPMV79lOHeHUA1/Xlh3UU238Tk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ha0o+drNCCBArdMDEjZCEq8HEij3o8Ed1yk2KC0DQ6XA4jgHpsRWesSpmBAlYV2K2cOhydvJV3RIIqx+yo0N77kCDSjJgMB2ssXEbF+bNIqxpPK7RRtou0NSnF4mP9XHO8vXCVDk075uiuj7NE6F7vfCr3A4veb/m5aXH1ei0E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWUlc4Lp; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-71e2a32297dso321420a34.0;
        Tue, 14 Jan 2025 23:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736924861; x=1737529661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0fASG0X/uQZD/W9OMmNQn0p1YDVNMMVIY7/O8Icnnw=;
        b=VWUlc4Lp7G5kuIMB8GfzRM5HNStuEzrYYwuKpmHRhXlKxw6TCpR0aLvdyFUsudVf7h
         L/oBbGZrYdGJy0TgM8mP9Qz77TMbAXAEOhQU0dPkT2v+7FLAcV681Br7Dp4IiKh8YtMx
         LahAwFPdptmIWkE/ZF4k+JeY0AU0RNlwX7Mz0Y8WWKGjhszIv6GC8/rBPgcvp2fORNA9
         QyMywN48002NWiv4bQdDiG5QP9sdLE0pO2um3p9+01ejMqeoMMo6SIQKQjsWPxvZEZvf
         z52oA+978YSKFMvhppUH1jt/JxBvijYscosMh61ORV4RnWHsqQovxrcu/PG618ymbaXk
         ROqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736924861; x=1737529661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0fASG0X/uQZD/W9OMmNQn0p1YDVNMMVIY7/O8Icnnw=;
        b=KAw51PB5QqUATs3vZitqJj4gDv+TMBS8ncVJmi6vqTIVy9jtpNdWSjKW0DNL8EWT1m
         ui1XEwBO/1YBQ18HT8SE3cxXpaI5dOqQ6FuMuPIHvSt2CZjs9lCwUt0nkgog71AyWIyQ
         nKj+IWLOlPTGq3v/BoC+6fGFJ+Ke3kObcI/EbcsgPIVOpLIbGebIhOXT6/kgFBWQonuw
         XzNpCXD0sUrqmB3eqVHhQJlPcNMXF35IY8jOZMMu2ABa0CrjWRj+ZZC4/qQEseK4MsdE
         UnIkv2BVHPhHf0XfNZBDNGOn2Os8QPVxRQL0SE7Y4ILpcZUpkKWKSnIL9LpO5WGzpKWW
         WsPw==
X-Forwarded-Encrypted: i=1; AJvYcCUBhdnpugdLGw2TKsZfVJOdmTAxtEi5uXeAB6dy3Ff99hWovmfo58+jlf5TGu0XjSzz0CtuoN1nSSviqqsJ@vger.kernel.org, AJvYcCWVpktOWvOH4omU7Ok2Jo1Xcnk+YeV6HV85TdvivtGyIhMyr8vhuWwqPyeQt+Ql9lrCyQPcmVWnrH+O@vger.kernel.org, AJvYcCXYDdLcyBB/qTMVTMo2yNcFF5YEKpqDIweUuEENpTSlkl2VOCNzpoC0/tRMzS6b07usPLZZ5YTco+zn@vger.kernel.org
X-Gm-Message-State: AOJu0YxnrcPRyWdS46GYFLqusxqJSqhUDRHCqZ+iTxJ+2ls0lbMyG0eg
	h1GcZmNoLAsRpaUrNW9cquZiGFNDN00MkbLDaxWe0lx79xFD3Acu
X-Gm-Gg: ASbGncvYklTCSMJerXXZhjOf7GsE8V/QLoosnE9cr7Fi/BK/03czXOT38x+ParCRBDR
	ywQGEc7dOhNSQUKgSijVL+IB7OA7zi5YYfTqkja0EJcDTRHdlXnQOpijlGdfygpIP8C2OxX0rZ0
	azFmaaeWIkiwK5ec/++eEJo2tre4y45zOJvVjyRBNItQrzas6yn5ATON1zjB2xbNNpJiGtkg54F
	JxwRLGhwJ13pd9q+mkE8lTzfqr0g/egRmp9yfWNnqxzRBmBeZdta/ji2sMjWbY5fdk=
X-Google-Smtp-Source: AGHT+IH3l04BzTwOQOVeVceAZhDLzmEf3VzEspec1E1UGUxl7qEL3KQJ4fTf/YoGkK/x9urtKw3yFw==
X-Received: by 2002:a05:6830:6882:b0:71d:f7d8:225 with SMTP id 46e09a7af769-7248594ac72mr939861a34.12.1736924861369;
        Tue, 14 Jan 2025 23:07:41 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-723185481b1sm5445257a34.22.2025.01.14.23.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:07:40 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: kw@linux.com,
	u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	bhelgaas@google.com,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	lee@kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	pbrobinson@gmail.com,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com,
	helgaas@kernel.org
Subject: [PATCH v3 4/5] riscv: sophgo: dts: add pcie controllers for SG2042
Date: Wed, 15 Jan 2025 15:07:32 +0800
Message-Id: <4a1f23e5426bfb56cad9c07f90d4efaad5eab976.1736923025.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736923025.git.unicorn_wang@outlook.com>
References: <cover.1736923025.git.unicorn_wang@outlook.com>
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
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 89 ++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 02fbb978973c..3db46bfa1a06 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -205,6 +205,95 @@ clkgen: clock-controller@7030012000 {
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
+			sophgo,link-id = <0>;
+			sophgo,syscon-pcie-ctrl = <&cdns_pcie0_ctrl>;
+			msi-parent = <&msi>;
+			status = "disabled";
+		};
+
+		cdns_pcie0_ctrl: syscon@7061800000 {
+			compatible = "sophgo,sg2042-pcie-ctrl", "syscon";
+			reg = <0x70 0x61800000 0x0 0x800000>;
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
+			sophgo,link-id = <0>;
+			sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
+			msi-parent = <&msi_pcie>;
+			status = "disabled";
+			msi_pcie: msi {
+				compatible = "sophgo,sg2042-pcie-msi";
+				msi-controller;
+				interrupt-parent = <&intc>;
+				interrupts = <123 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "msi";
+			};
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
+			sophgo,link-id = <1>;
+			sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
+			msi-parent = <&msi>;
+			status = "disabled";
+		};
+
+		cdns_pcie1_ctrl: syscon@7063800000 {
+			compatible = "sophgo,sg2042-pcie-ctrl", "syscon";
+			reg = <0x70 0x63800000 0x0 0x800000>;
+		};
+
 		clint_mswi: interrupt-controller@7094000000 {
 			compatible = "sophgo,sg2042-aclint-mswi", "thead,c900-aclint-mswi";
 			reg = <0x00000070 0x94000000 0x00000000 0x00004000>;
-- 
2.34.1


