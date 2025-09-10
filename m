Return-Path: <linux-pci+bounces-35785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74421B50AD3
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 04:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C94777A086E
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 02:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72E7231839;
	Wed, 10 Sep 2025 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLmlSe2f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2027322FE18;
	Wed, 10 Sep 2025 02:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470190; cv=none; b=h8ylcLvjZoKOVBK1Au+UKh5tmUtk6IyhzuPjXDVZJGxRu2+xDkRzC+zEGqxCNaL2DhOcmxZhjyDK+N9qwm8LzRcucX+J96UdZtYLberEKo251j7a32GNyKna7IEcwyBZVMhVoQKyeRPfvRZaufX2lBlPOs9DWAjy/qEa9Doivi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470190; c=relaxed/simple;
	bh=dgpNPFFxsdIAjczNzjU4PLG/4kOomJBC5GhTApKNwOw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fwvs/3YKZ5JTQgnumT1ZRj6X6ttejBiz3N/KCS8LEazUR2bI7twoIQXfVKZhDblIdpih5mCMMMUuQMq00o0Q5jT4Cht8uLfLYjYEeEH4dzuvVaoB35Fnd0Dd3/Ts8d4O4aO5yyiLn6cENvvYbxDrON9uZf7yGAOAQlryK+p8YR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLmlSe2f; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-80e3612e1a7so810608585a.0;
        Tue, 09 Sep 2025 19:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757470187; x=1758074987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rSqoF1bhRIMRZ/Ngttka/3cr36QgYmwYc1FwmVj14E=;
        b=aLmlSe2f9qrsFn6rrN3MX5AtKO8fSHQdjtGoxcOhdc5dmeHJ5APtXIzqngy3kROk9T
         7x+Zc4iaVZqVPZvwsu65keRnEdj6U6eTXKIoacWct7/BbMshuWlR3ieMa7Ete85TbKFA
         4+lFFuDs+EUrmeOKwuzd5FB+TeRNOg0f4UZoqeaNb6R1+VAZwRPyV4ZZCBs05emlOMeJ
         j34uAHcLRHV8qAxCtxyx/JxFx2WTVpslPXs+QxlmwP2/OQLjSlv8DrA98CEzkN3YOW80
         9Sxc+EUfSC4YVnGLOCKodQVGty/7m/16H7TApHl+wDRzxqGr4auz86kmJGrFSg/VZGXv
         3TnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757470187; x=1758074987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rSqoF1bhRIMRZ/Ngttka/3cr36QgYmwYc1FwmVj14E=;
        b=PVMJ5at3SC8pJ7VzZ/rFRkQ1l7b1d5x0BWn4XrV/XVO9EwBOytA0EnjOY+HJ3RLw76
         vJd/AvRqFVgUCyuh6T+7/hFvKg1veoCnoe7TZRMtKxYUEcldOrmnj8mEuZB+lzkj/ksi
         QhPxPxeLGKOH3F96iehlofpSto7FpM1xKVTOqXbwXnLJJlb9Ut2OK1oU/kKO+2+3TBfU
         mc7t1mRZum6ZeVRoX5LbMaEurK/zodmAgbCbtroMF8TlqfpfaX20yM/Zx50//tKskfif
         rlpf+BM9yc7hOwzESTlwThesTLEXlbZZF335QZGFvT3/b1KabsENJ7KW5HU21aX0iGci
         zihg==
X-Forwarded-Encrypted: i=1; AJvYcCVGn0ia1fDJV+8QU57stSz1XbFzPR6LIGG6xe5egAuyDUgPF+GPE5PvhEK5J6Q6Y2ZxaU1NilA6QPVk@vger.kernel.org, AJvYcCXOEVupTm4OEZzNGNSnVFdhiwF7RYTlRZ/S93hxwEgazyMubYicKp6T7vBsCt8u1gAyEbnHvXRAHsek@vger.kernel.org, AJvYcCXig7j3to/dorCVkuwLdozt9WRcWiSls/0uCTr/HTGdLQb4DsESli6Oxp1DwmyX5xm3NgnqrRf6s+fZ7/VW@vger.kernel.org
X-Gm-Message-State: AOJu0YwFO8z54qGvYVYio5LOiL3vtSnJUVRgtv3EI62O1BFKfa86ONXG
	2MB3qxsPY/gPq9lxuiQya7fTiLROk0V7QfhYpPs6RdgRB4bSxb980Jf6
X-Gm-Gg: ASbGnct2yh/OTX5VEJlxi+9/m2dV8XIcyXxg9LbcfASY3X1hZk4RxHLa6DDnetjwIAe
	3aQS5Tt/Op6pTh2BoTxkYPOL7sVMXbHg0MrzwFwx0vBXxKDksy13xYiHGv6HHKgO0U715fMCAs9
	fOx5M0gxJxSrpuyfVgxDXTEUOFSmD4ek3hnX35nbDnO86vICwpb9T3DAfjS2V9Wxm6j9nl29X3n
	FMkmfEGRA/Y9J+mjTsFg+AXMikr6YxujC2aMhdeE+BRA5Fm8QHahDT4qjMlY596Pez0BBUeBWaD
	q6oWpM5sPVR5wU9wVsIoNgXiqPHbRuO3EugMP+sVzxtSiV24espGDYn7TcbqUbL6f+cUCzgfTZX
	HFhlFldFrI08gkdSTMK4spPewD1LDFKla
X-Google-Smtp-Source: AGHT+IE5QuSz5qdsE3xoQsl6qbxguCNJz3fvFYDs9yiT61/n8SvvUWZyK/OkyKtb2ZUzmAhsv1j6mA==
X-Received: by 2002:a05:6214:130f:b0:711:b9f3:1fc2 with SMTP id 6a1803df08f44-739253e0b8bmr118544936d6.26.1757470187091;
        Tue, 09 Sep 2025 19:09:47 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-727d637082fsm117730896d6.34.2025.09.09.19.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:09:46 -0700 (PDT)
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
Subject: [PATCH v2 5/7] riscv: sophgo: dts: enable PCIe for PioneerBox
Date: Wed, 10 Sep 2025 10:09:38 +0800
Message-Id: <4e885f30470ea07f499c9a83ab5dd327e00774ca.1757467895.git.unicorn_wang@outlook.com>
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

Enable PCIe controllers for PioneerBox, which uses SG2042 SoC.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index ef3a602172b1..c4d5f8d7d4ad 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -128,6 +128,18 @@ uart0-rx-pins {
 	};
 };
 
+&pcie_rc0 {
+	status = "okay";
+};
+
+&pcie_rc2 {
+	status = "okay";
+};
+
+&pcie_rc3 {
+	status = "okay";
+};
+
 &sd {
 	pinctrl-0 = <&sd_cfg>;
 	pinctrl-names = "default";
-- 
2.34.1


