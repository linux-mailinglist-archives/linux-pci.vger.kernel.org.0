Return-Path: <linux-pci+bounces-17904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 186F19E8C12
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 08:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E9E281C35
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 07:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAF9215045;
	Mon,  9 Dec 2024 07:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1S5aiDy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D99E214A84;
	Mon,  9 Dec 2024 07:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728842; cv=none; b=nMqyunpSUJhGaRJj4ty9RiUk4DURWdm2Y1gVqd6ICS2+qZ9BoDY16nIcM8yQ3JwoBP40GxIbKyCrvCJeXGxR+yTnDzOHK+8ejFPvOlOz+tTywwFy8s0GS4uIVBi3lORvU3EQvTtwCiUTWSyjyBcDb9C+APeSOSeUwDiE7bq+6Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728842; c=relaxed/simple;
	bh=QPprxf4AkFBK+fScYVC+h19VozXWB6kVUkMW1Kc+8vM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YVS5VB8tjokVt3+6zNXcMG1KzWTJC6o0Of6WcLgfceu5Ed6/3hhWlggXKeqEWEPXZyhebPCZXv9GbHuOq4XZ2WCkFRXwuC73wGlYgi3RcNWD9P56r2vmQxTSepxlyRNemXJ8OqPHaRiGbDQ/eV6QrhoqxKoPA+JlEk6MsW1HRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1S5aiDy; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-71df00181b2so430910a34.0;
        Sun, 08 Dec 2024 23:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733728839; x=1734333639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbDh/g3jGuzLNE1F/UbDJJl1YM6gN84aixwHJdNbJcM=;
        b=J1S5aiDy6sI3F0R5DXSGIq9xS3yP9EwHzJJcE5yvZ1+lmtKxXy0JYdQ6iQ3FQkhKk+
         01smSp8OkrM8s6aK0EMwU2R130bQ9PGkXa7Bm4B/uHDUBGL1z8Awjw6nA8AwTx5h/Tdo
         amZrsP07sGQFC6ozdubiOeQNUBRPyEl19djrz3G3L7nYRq+BKvpMDkSDWMNrS3/FSV3/
         aLCFo+0n8CuCfn6xZG7HIKWfBRcbVAXyJxfvdD1Qci0BogXdfRmBDDB6CkAxgXtV+auM
         914Ltj4B9jDnvfrpKXi/XbbQmzxV47wQpGEim+CcUogSGTZmDi9mfMAdsbLebSA7hYdD
         KTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733728839; x=1734333639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbDh/g3jGuzLNE1F/UbDJJl1YM6gN84aixwHJdNbJcM=;
        b=sHEhj6t2EcCJQQYFHWq1wY3ZT73hRyeURvb4hEt3X/kTR6gL59fljUVnk9tt9QZewA
         6KZy5RFc8aIY8mNIfbSgcaj4fAjFsvA6Y2FDoMhkqgtLuxC5WhAmbHO1WE8MFayY9rqH
         Qh2DZ4SRLaahi/3bxQHzQojwnZDe/G9U07Cj0nWWSdvzn6uIp4kByGCMVpcWBOkk9V/5
         rGEqS/h59s2GfBn7YECBIOwqMyUQkYbLhaUb3fkxlIvU2QWZaHDQmLihq73iL8/8CBOD
         LbwjdFtog8M/JKDHyNsFfz/hAz2+AdhEJlg1K5/do/0Uk7Gz/n2FNb7wVr2Bv+Wg7Dpd
         rEAA==
X-Forwarded-Encrypted: i=1; AJvYcCUPk0i8Qh76eTqRvggIi+uUzj9S/Bx8LQoyHVQpFmsRHzoogldxBw0rRCQBNFFNhEGh56ALrsNvhOgggbIY@vger.kernel.org, AJvYcCXTCeGxam1Q8LrpvHeQ7+pN/5kkxj1JQIkipAvzxflQbipr+y9TKIXD/wGywfr/8ITd9sxeLd3tBh3W@vger.kernel.org, AJvYcCXueTRXKFLbfVd7oJTCiCc3TL1E3KrSM+nbmaYNr5yeMBwyp2V9PRAinLr5NNOwbpEk9IMd9LKtekRM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+bLahN917tWxn5jk4FOr7JifqY4S1ssvL+bvzwMgJP6bsoHph
	wXogIi8BSMN+vm6hOmzP1FbrsSh03MDUwrrAMUZjTt/qo1+CaHrl
X-Gm-Gg: ASbGncsYP9Gzm0kLy/zEd383gkaG+46mPe4j5CVErXRJXZtU29hmSHbWDTZLOwGCZgY
	eggM+nmYn7WTZ6ezdeeerDRjKRSgJlFTgV22btJjShTbnvEJCAlw2BuAnqzh3Fn3PBhYGUw4dH1
	bo13MTR6XrrF77vHaf+ktEL+eWZE+eDIIhafTZL7azU8LrN6KxhjpUUntGHY9gnSLerap1J5kZT
	FXVLLxcJszPJFhCxQWx3bYVCn8p+MReV0LsPBltPEGRCThs1LsO68OcFilZ
X-Google-Smtp-Source: AGHT+IG5zrGT2pA4Mo08JycALnQE/jgwjzKHfeIfoQjjJ7auIuS4u+TvVuuWZ5bJxvnL2bTWFYRjOg==
X-Received: by 2002:a05:6830:b83:b0:71d:3e4d:becf with SMTP id 46e09a7af769-71dcf567efcmr10394977a34.27.1733728839444;
        Sun, 08 Dec 2024 23:20:39 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71dfd03aa13sm69807a34.8.2024.12.08.23.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:20:38 -0800 (PST)
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
Subject: [PATCH v2 4/5] riscv: sophgo: dts: add pcie controllers for SG2042
Date: Mon,  9 Dec 2024 15:20:30 +0800
Message-Id: <b4426c4762bd778873d204a2796885ccd98d7c69.1733726572.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733726572.git.unicorn_wang@outlook.com>
References: <cover.1733726572.git.unicorn_wang@outlook.com>
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
index e62ac51ac55a..bbb7cabab9de 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -195,6 +195,95 @@ clkgen: clock-controller@7030012000 {
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
+			bus-range = <0x0 0x3f>;
+			vendor-id = <0x1f1c>;
+			device-id = <0x2042>;
+			cdns,no-bar-match-nbits = <48>;
+			sophgo,pcie-port = <0>;
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
+			bus-range = <0x80 0xbf>;
+			vendor-id = <0x1f1c>;
+			device-id = <0x2042>;
+			cdns,no-bar-match-nbits = <48>;
+			sophgo,pcie-port = <0>;
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
+			bus-range = <0xc0 0xff>;
+			vendor-id = <0x1f1c>;
+			device-id = <0x2042>;
+			cdns,no-bar-match-nbits = <48>;
+			sophgo,pcie-port = <1>;
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


