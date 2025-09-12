Return-Path: <linux-pci+bounces-35975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E059B54074
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 04:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13479A04CE1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 02:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21B61F2371;
	Fri, 12 Sep 2025 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXWnuwqD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1981B1D54E2
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644622; cv=none; b=TakPxNdjMf0ZoT9AWySMjHQW5gCiEK6gZCBCJvrKQ+Xnk/6Rbb3+OSYETzROl7zgCMtakSJEY90oT0b5WO1N+7pttIJhzL93CGRPekY39v8NdzO2YZkkzeze6HHsMkLk5Lw8IEF+ZInaohuG/GbewybY24cFuzEO0ASYmXQpgg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644622; c=relaxed/simple;
	bh=7smwJj7dQIrNWzLpxsZgOxIEd7UE823bj8z0yhG3OBw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BENV/W5VRGnjaZvt2O0n3hwioFIFaiP9FbnN//hL+Mw2HecKjFiEgLXgeQchD0ENhZUUA07qoa9sUK2gbNdnegsO0D6RI+n/I0Fdw1wQUWRPglIaZa7q6bpsNW7ObV8LIiVqovBZPTFz2TtuqXPblUEYULRcui1YAl3u60/H+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXWnuwqD; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7459d088020so757938a34.3
        for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 19:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757644620; x=1758249420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvwjuScXFIOkNO4l0NAjh5hmUBFBDILktbVX+sGXQiQ=;
        b=VXWnuwqDJN1x/FOS6HQyuxSPVdC6w3EBPWPd4JnozuYmzRJiEEj4zS68rS0/isQoin
         xb/4yVXAym60NWIZorM7vqgxKZU/tBkcsZR4oDDMs3okNZMzfwn5jgR4RXoytqKgK7Gp
         4tLoR8VT72xLralFun0wQO3MU00KMP38XOZgW/OHPbX2rKOohyyYCEOHiBHiEW8I4gPp
         gFGQV62voPVo6X+46oalGmu+i5ngi2NGzv5jNCPgcWTsgw4hiSNkn3lQzQ1qq2Uj2ji4
         EaXk5PE5cE0AsfOOheJEon2nro3BX0zU9Wc2Gvd0YG10rll0oiJXk2tMetPBxcuerYoR
         jVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757644620; x=1758249420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvwjuScXFIOkNO4l0NAjh5hmUBFBDILktbVX+sGXQiQ=;
        b=EFElz7DPKiPISc6Q5PQwvXdVos6CL0a4oXNvKmmdSTqfSpCyfKZctErYiQmxaNv/2G
         tRLLmjqutfgUt5UNZFPFiHOLFrvUq4Bnw31JHCLYRJ1IPRSWEaipjdCscyH0dEX2MudG
         +yuenNSuLi+N3RyA6v+gc/K4y8cb6SIukf3by3z4MfOfIa0ge+lPatE7LynGq7kYW4tm
         UWsDDq9mCJqLL2VqAVxiSAP92uxUJ67s6K3cHXDLEFdRpQRkEYjz+ICPchjd+4nZHeQD
         uBx+GDw4+srMPv/ZrWkrm3KuvUZrGDmjzMuwumFVLtx7twSCU7SQDufA+pFpSC0w2LvM
         0hpA==
X-Forwarded-Encrypted: i=1; AJvYcCXmFFWSW0QM0y31nxozlDgBkFDX4UCYDECJsM3D3exIWCUN+nrznuHYa8Din/tUfKahzC/KgVlI8HM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztd1IWtjm71T34hNDVNApzd6tn0+C/TbFtpF5ldJQgnl4iJ+OJ
	HvnIWLe3M2guyE8pbgWqWk6/U9s+jcoWATvSry8HRaQm7k/KbqTTzTUu
X-Gm-Gg: ASbGnctXmcgOpaFspCmWHOB7M1Yl3B+Sbj7FX5evCOoQiP4uuJ9+JO5lzOgRjWvToXE
	7MQmeq0YAaXjI7tEiU19XGbnGmnNp3tzQ6ZEivBJuc4T++3XeNGULMAuYMm9fMY2ANCsD9YrJHH
	RXP+s1bvT1r16MAGY2hP1AQbwuMuWwCvdjq6ctOkvbizPpOMbSnQrjT4ma1CPFH95m6SM1P+dyL
	QCyqkZVTBBDr1yQIPdt/37qm+PZOvCzpWK0IajFl+201nB9r6FAZCmUmvJnhqR/gZiKMr+UnXCa
	RtQiLvWTbSPLOETjQp/vqRRVMLRSeH32Qmmbw+wVeGKldMiW8IEpyslhK9xSk/SL/fwg22ha3P0
	kG7vk3cWvkKA2kAX1Q1iPMnkTOCQnhJjt
X-Google-Smtp-Source: AGHT+IGyuP3/R9DH/EcaxhL/iQY5WFNGJfVttr0Thdfkkw6lmjBCk6VyxF13AjSvDr/I+XJlRFCejA==
X-Received: by 2002:a05:6830:82f7:b0:745:9a08:c9b2 with SMTP id 46e09a7af769-75352d903f5mr897685a34.5.1757644620197;
        Thu, 11 Sep 2025 19:37:00 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-621b7bf520esm343900eaf.7.2025.09.11.19.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:36:59 -0700 (PDT)
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
	fengchun.li@sophgo.com,
	jeffbai@aosc.io
Subject: [PATCH v3 4/7] riscv: sophgo: dts: add PCIe controllers for SG2042
Date: Fri, 12 Sep 2025 10:36:50 +0800
Message-Id: <828860951ec4973285fe92fceb4b6f0ecb365a2f.1757643388.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1757643388.git.unicorn_wang@outlook.com>
References: <cover.1757643388.git.unicorn_wang@outlook.com>
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

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Han Gao <rabenda.cn@gmail.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 88 ++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index b3e4d3c18fdc..b521f674283e 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -220,6 +220,94 @@ clkgen: clock-controller@7030012000 {
 			#clock-cells = <1>;
 		};
 
+		pcie_rc0: pcie@7060000000 {
+			compatible = "sophgo,sg2042-pcie-host";
+			device_type = "pci";
+			reg = <0x70 0x60000000  0x0 0x00800000>,
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
+		pcie_rc1: pcie@7060800000 {
+			compatible = "sophgo,sg2042-pcie-host";
+			device_type = "pci";
+			reg = <0x70 0x60800000  0x0 0x00800000>,
+			      <0x44 0x00000000  0x0 0x00001000>;
+			reg-names = "reg", "cfg";
+			linux,pci-domain = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0  0xc0400000  0x44 0xc0400000  0x0 0x00400000>,
+				 <0x42000000 0x0  0xd0000000  0x44 0xd0000000  0x0 0x10000000>,
+				 <0x02000000 0x0  0xe0000000  0x44 0xe0000000  0x0 0x20000000>,
+				 <0x43000000 0x46 0x00000000  0x46 0x00000000  0x2 0x00000000>,
+				 <0x03000000 0x45 0x00000000  0x45 0x00000000  0x1 0x00000000>;
+			bus-range = <0x0 0xff>;
+			vendor-id = <0x1f1c>;
+			device-id = <0x2042>;
+			cdns,no-bar-match-nbits = <48>;
+			msi-parent = <&msi>;
+			status = "disabled";
+		};
+
+		pcie_rc2: pcie@7062000000 {
+			compatible = "sophgo,sg2042-pcie-host";
+			device_type = "pci";
+			reg = <0x70 0x62000000  0x0 0x00800000>,
+			      <0x48 0x00000000  0x0 0x00001000>;
+			reg-names = "reg", "cfg";
+			linux,pci-domain = <2>;
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
+		pcie_rc3: pcie@7062800000 {
+			compatible = "sophgo,sg2042-pcie-host";
+			device_type = "pci";
+			reg = <0x70 0x62800000  0x0 0x00800000>,
+			      <0x4c 0x00000000  0x0 0x00001000>;
+			reg-names = "reg", "cfg";
+			linux,pci-domain = <3>;
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


