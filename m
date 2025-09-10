Return-Path: <linux-pci+bounces-35784-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC20B50ACF
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 04:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75BBB4E1AEE
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 02:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4722231826;
	Wed, 10 Sep 2025 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFbFFxeK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E462309B3;
	Wed, 10 Sep 2025 02:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470165; cv=none; b=bdXkbayQOBRvLh//TljB+R/2OEVjoTpuKOFTdZMG7LDsfYIXJxjJGFJrsCEWia01whj9r98ielzm8p4xNeQvBmvLKKYbLS3+0DywjMpJdGQVZbnCMAAbsywbQresGxXecDiUSc+niddj0JE1XNqfDEgYR/hx+ZX36wEXu6rlAZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470165; c=relaxed/simple;
	bh=7smwJj7dQIrNWzLpxsZgOxIEd7UE823bj8z0yhG3OBw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iOMVJGLADnnbFBQS65rYouRnxBI5OcXpbNitILvDCpEoO1mmqlhnBUwjYPRykpMKXQyNGROxULsRAwf1jOOk+TnvQ1RTRikUmQXRODVUM3Le3kRJGhb15HTLdyNkkB1PiJTRrjBShtviUoWxoZQW99I7UvtILYJoSgJqJa8vCaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFbFFxeK; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b5eee40cc0so47621351cf.0;
        Tue, 09 Sep 2025 19:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757470163; x=1758074963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvwjuScXFIOkNO4l0NAjh5hmUBFBDILktbVX+sGXQiQ=;
        b=lFbFFxeKgXDB80ofWy3SANZinrYgWkLv8s5BtrVOM95jPdB44nrBrqDGfh2OeaRXHc
         iuniyKTdHZMtwwitpLbQ6PPLZws4nzVblGbEQd1UnP0h1Lfb7ENPkw1uFan0kFJ2XwUn
         iejFgeyHmQgtyX7+dDd7pUQjBKPu2d6iNijrSWucjsfvPYmZv86n7ZIL1vRY0NT8mXSG
         69jtyeYCA0Bo5F2l6B+2cqoGfyrp6Mm0lphHPDdqOTIZMaGTyHEk9NjSy+0fLe0jS6w5
         qE2v17B8052hKBWOWmXVcH8LlAVFtpNfmPoRCqM3YJK27zZOKuYzlNZ6Nux7aHLuYw3V
         MhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757470163; x=1758074963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvwjuScXFIOkNO4l0NAjh5hmUBFBDILktbVX+sGXQiQ=;
        b=UjtxqKenB84K1RlIRGtd/8Vb0AmT0/tKW3yGX8qlEdtJd9ykEQb1GdN2SsdUQLMf+t
         9Drs1FYJ1Tx5TeKRtnkgBuh6UpuaFKVa9sa34F0OtE0uLulWgp5bo6ggbhdlRMDvjtP0
         iGWV5h4h94Qf2FE0uT+s2tazCp+nlZe4f5CK1UaETVUyUmklp8MwA96PLdU1HJrsUj3n
         tZFeze4VMOkwW8gjLHp7CKvx0nr2JBefPmHLYAd5HCs3qReFR/Kfkicth7ZNLYhHTo5o
         kYq9cPjr3mnkXmUYu92JglSXUUHC56aQGd4+hTJS14+LxMuL9UPkOiMhpn8OdAK+9qA3
         n6vg==
X-Forwarded-Encrypted: i=1; AJvYcCURla8qyrWm2gi3CG0Uuvz9TH0JhZ/fVXZa39Pj4vCcwkqyluUAQ4O1k9c0J6JMwB+XS58ZSPuEfwNxhTfM@vger.kernel.org, AJvYcCUrU6sWr5RCjVST/2rhYxqdptdSC+GZ3nb882tpBqVNAfPcEzFPRPlzUwm7HuvVr6xQ3yurOFA5v0Z/@vger.kernel.org, AJvYcCWSr4xch4/O34E6Ge/WLgofe+Y9bAbfmyo/FWiUoRq1Ilq031HdpT1ajOPgjmVmG8bBkFA0RKj5z0ga@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ZUiLS1hk+r4KQQgW1/KcX8rfCglbuaLUcSyXUt6mjupkdIqA
	76BYbWhLGI9SFRHyKkk/TJONxmQNBDboli/4xQfJOcC+qu/sn+lNwLc8
X-Gm-Gg: ASbGncuaDzkzrcOpBW9JDfzBa9ydtVL2sfz8gv/CfHL4rw/ARPyZk8j75dERLGRfvuc
	MMv6TmWXy3JmXNM5XXvAZB+UbkfvrwftR05nOlZHytW7Nt/rPG6egl4eoviBmRbEYGf5dJc9Owl
	CFk21u3zOJ/5nOBShB2limSP5uPxvGc/aoih0BhyHKt9o2AqguDHBgFxsHMv9cvYpN9Hs241BsC
	lwGMKOQ7qvde4jADfB4uRQ240VB1M27hDnZdsclN1kqY8HNdpylQ0bZFJTAVVOShfw2L6XDM1g0
	MK1Q79WR4SRnJDZNYtn75CkGXsgKxrqYmKEbb2cSiwe8S48UMoZGh0/YJRXGWQpD5jh7b//vesj
	FQzujTAQA1zH4K90TNu3mNAkE4HWGg6EK
X-Google-Smtp-Source: AGHT+IGWK15y3cJ0ySkBVFDMFIUT+JGKHEf8Zddz6BKl48R5eLCXjRJsTMqwRryUollNpWDOlRLpqQ==
X-Received: by 2002:a05:622a:409:b0:4b4:9666:f1d0 with SMTP id d75a77b69052e-4b5f8445a7emr145405181cf.49.1757470163006;
        Tue, 09 Sep 2025 19:09:23 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b61ba742f9sm17682681cf.10.2025.09.09.19.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:09:22 -0700 (PDT)
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
Subject: [PATCH v2 4/7] riscv: sophgo: dts: add PCIe controllers for SG2042
Date: Wed, 10 Sep 2025 10:09:13 +0800
Message-Id: <5cecf3c854253e508a88995011dd4631fa0c6eae.1757467895.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1757467895.git.unicorn_wang@outlook.com>
References: <cover.1757467895.git.unicorn_wang@outlook.com>
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


