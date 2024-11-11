Return-Path: <linux-pci+bounces-16422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 919079C3822
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 07:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3748B216B8
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 06:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2CD149DF4;
	Mon, 11 Nov 2024 06:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/vZyCx2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF146EB7C;
	Mon, 11 Nov 2024 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731304846; cv=none; b=Yo1p/ySPlEYBG3vOkFiHIokbUNFnIeCV9oRj532/qW94z9364jazerGSW4JQwbOQrCjcVe34iN/zqyvb5GhiNAdkX17RuhpRiKtU4eW9lhIgpMEbys+T5Gls2s0YB5NbHEiBxIhTubB5WCXWDH1cnm1taEXD+fUQQfiDuJAffsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731304846; c=relaxed/simple;
	bh=8/c8h4T6tYg8XhBBU8i8Sf3Fr6JsxUqaQ5ZDI/ympjU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aDFb6d0X8Uj2VAedj9YoYgrs4162hsePraHkef/aUzdlQXDNcvUaROT4ykS7Adz+IxGapnRuVjLdndS3oozifPVuZ+o6Clakk91Tj2gCxGZKfURuRWK/Ay40IgsRAinrz7LQu4aXw6LjSy7hwMR75NvAvM23UfR7995qEsR4jDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/vZyCx2; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e5f86e59f1so2282237b6e.1;
        Sun, 10 Nov 2024 22:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731304844; x=1731909644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0rmRpGSKuaRk3Cztraml8ttOGifpWQdN9oAXrvgVN5A=;
        b=l/vZyCx2yxK7jKUU3Fu0CnSo7B7DRqIiD3nDk1u8YRD0evGOG/RPpDnsdlBj9wKnAI
         6jyd699t9rSsaircqttYLQejinWEYH+nTbFUO1lEwqBSdJvMQrOKq0ASKXrhrHMi5slH
         ETo+wgO8QUTrl3yEgm+ijYLr0UT+1s3MhzSiyOfUyygJsAM3CVoht3BzsR3zG+pOE/vj
         VO3YHp+n0zrIau8HlWF3jFYjUMn6esPnm3LnOYP5jEBVipAepbMZ76ubUnvM7iNFd8+C
         lZd9eFmbacly1+cq329q4mzGKfMws3g7JRnz9TOycAKNY6pGHhJn1XCvsxP9+AL/hcs0
         aY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731304844; x=1731909644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0rmRpGSKuaRk3Cztraml8ttOGifpWQdN9oAXrvgVN5A=;
        b=eP9SDrBhlBHkJkY+h2RRkBB2NzV9I/14wZNxjm3P8qcd22zWHYMxlfdLWsTyef7I0Z
         OA1NfF6xAjoNRRL4JG7SVS83fkppIJtHOSzLSjpxvc6oR17/unrufJ09dx1ESS1m7jUD
         JCo9osZfMBqlNQbD62Naq6Ptnl2pvukpu4jqESWOr11X/GHPJmTGYve/b2OqiAquJfD9
         Vm62Bp5f8WBWW/JqNrv/mPe2b2fLCxjTejV3P5M989sJklPoOZzpE4v5n89r8X8V8JAr
         v9R8GcfKemVMZJqTxurOAQQR1TFxToXGtUQ7ltyzZ4BWfKeQ9Wb+vELYCNq5/ekUwwmp
         3N4w==
X-Forwarded-Encrypted: i=1; AJvYcCUuid133GWPhP5jTWyBIyvI86D/HFL1CcErrx1mxAUKWHYJK6zKPiFDXSHjDV19BB6nKdRWtBuXX8hL@vger.kernel.org, AJvYcCXeDUFcM4B4jtwfxEks1QbAifq4CAGZbrLNWlQv23zZetzfHkGFgxrJPerAw2zYW114p4C2fNKAvj6rMwvn@vger.kernel.org, AJvYcCXuxnHfqpNjL2SlbzEfjE2dlUs9ySyP3UnjvQ2+CvA4t1lanOU6BsfzbDh4larjzgbh2OLp5KM2Gj8W@vger.kernel.org
X-Gm-Message-State: AOJu0YyY+38NHJEqIAlYZ6SSn5Ld/NJtWmaACmQx+8XfSzgtrJ1+mBRG
	P9ZrlfJxqjrTnp9QYsZnX2jDQC14jRJy0xJeSAw2uFr4e/JSLCjd
X-Google-Smtp-Source: AGHT+IEkrA8U43EbLL8PtUg0l0K7tH8rQnspDeNnyVtzBYeMx8cJznQw5STblElKQlJzO9mLz8DLLw==
X-Received: by 2002:a05:6808:1825:b0:3e6:63bb:ed4e with SMTP id 5614622812f47-3e7946c80b4mr8480393b6e.27.1731304844207;
        Sun, 10 Nov 2024 22:00:44 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e78cd4ce88sm1976673b6e.44.2024.11.10.22.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:00:43 -0800 (PST)
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
	fengchun.li@sophgo.com
Subject: [PATCH 4/5] riscv: sophgo: dts: add pcie controllers for SG2042
Date: Mon, 11 Nov 2024 14:00:34 +0800
Message-Id: <c8d05d3a4cf620ec4fcbf1050dea7c77f834c87a.1731303328.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1731303328.git.unicorn_wang@outlook.com>
References: <cover.1731303328.git.unicorn_wang@outlook.com>
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
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 82 ++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index e62ac51ac55a..dca51fa9381b 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -195,6 +195,88 @@ clkgen: clock-controller@7030012000 {
 			#clock-cells = <1>;
 		};
 
+		pcie_rc0: pcie@7060000000 {
+			compatible = "sophgo,sg2042-pcie-host";
+			device_type = "pci";
+			reg = <0x70 0x60000000  0x0 0x02000000>,
+			      <0x40 0x00000000  0x0 0x00001000>;
+			reg-names = "reg", "cfg";
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
+			sophgo,link-id = <0>;
+			sophgo,syscon-pcie-ctrl = <&cdns_pcie0_ctrl>;
+			interrupt-parent = <&msi>;
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
+			sophgo,link-id = <0>;
+			sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
+			sophgo,internal-msi;
+			interrupt-parent = <&intc>;
+			interrupts = <123 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi";
+			status = "disabled";
+		};
+
+		pcie_rc2: pcie@7062800000 {
+			compatible = "sophgo,sg2042-pcie-host";
+			device_type = "pci";
+			reg = <0x70 0x62800000  0x0 0x00800000>,
+			      <0x4c 0x00000000  0x0 0x00001000>;
+			reg-names = "reg", "cfg";
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
+			sophgo,link-id = <1>;
+			sophgo,syscon-pcie-ctrl = <&cdns_pcie1_ctrl>;
+			interrupt-parent = <&msi>;
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


