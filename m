Return-Path: <linux-pci+bounces-35976-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AB4B5407A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 04:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6501D161970
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 02:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420B81FFC46;
	Fri, 12 Sep 2025 02:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3IKT1ye"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493AB1DDC2A
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 02:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644646; cv=none; b=UFyKoajcnu3kG93rRYqzK9w5JWWzzhnUmrFs7sjWnzncu+x1NZrQ5xo2ZjNvwVEoTvTcs9Aa0bdCz13iovigkP0uyTJsEWsIkCfmXdefl+CvnEXLJYsI2dCADop4dYDyUt7NPgACRImCyDNyO8tpDBsB6rIc+lMO6aJDVFq6Qnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644646; c=relaxed/simple;
	bh=dgpNPFFxsdIAjczNzjU4PLG/4kOomJBC5GhTApKNwOw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S0x3iW1GwnunZkYthRv4bSSRoEMUQccbRUmv2Rk1j+BLKukmbI4WCQBJbN0VnH7+zH1WPrZ+cco2wCL22tbeONkp8THQmDFxnQ95x5t3b8fXtAH5tdgllri45JziOFjf3KhjK3+dbogJttDvbF8CfdOD08A76Q3/INadNzY8qj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3IKT1ye; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-31d6e39817fso1893447fac.3
        for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 19:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757644642; x=1758249442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rSqoF1bhRIMRZ/Ngttka/3cr36QgYmwYc1FwmVj14E=;
        b=T3IKT1yeV7eN6n5TExZxfQfQakjM1wZeabZoi1rq+7P1jsBXhZo2TbPOTbZjXxyXmG
         Xxra69XqJvW7IgnWCWJd2GEYFvM5HkxOacE+8oPcbReRI/0kR2ljyWt81s7TXZOb4X1P
         MIvBvJOQSHV+338IdxjYh3Lr7FMHGZkpKGEzwbpVI4LjdbBVOtvqPiZIvf7VqfBt2OxF
         VVdA/BdsHkfjD/+tKsRPSNGnhRXETfJqKHGplxxEnkHufwFc9Gc0ZLQ5xl/dF24lM0RB
         M14dYanxriEiQDg+e1AP9IqH4wNtzDaVLweBnK8ozXOd700MoDXnhGmsiL2uIbJ9Cgud
         yrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757644642; x=1758249442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rSqoF1bhRIMRZ/Ngttka/3cr36QgYmwYc1FwmVj14E=;
        b=d0kPZnLwbsUallidg9t5ikcH4cbuelmGnZMmoSEd0/fl7Um2jDGyq7R7NIhNQMBMj2
         puwspbgrokvikSLC35c60d2LU1gBfjJMRWLRXxu0yGXYuU62wvFR/evHBtC2OBR1geHT
         zAAX1ypxX7rTMHa5+pDcKdY2SO2Zz+OmZOC7bJpYXTDwUS81xpWn7xzcf6Q8fGUlNOh5
         M3t2ZDx01GsuHX9MEFhvDwkqK/bhD0077lar5MLv31YlR9qD7xYzc24htiOsywIaUubI
         P9F/34stp7WreabRK4q82Ha9M5wuEeJ5Mg7wsifOKseIjNw68qLX22Lq7QPMBMjaugLL
         f+yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkWPbJXrUMvx9Y/azkuWq3hz5ybX4wS/oaRD7DjHELXWsAgv9pVxHMz1wN1pJVZdRFj0KcptsMxb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyITLia2LND2fRCXaJIhdTfwTxeJV+mCogM3uESkbP+bgukOA6X
	vikcj1N4+G5guA5kuKmWoyYvlb5lLppdtGbPbzY54rIWcGFLfUlWSVa4
X-Gm-Gg: ASbGncvaI8n8/5KWpUitRBq8H+dW4y1pYE88MzvjEw8mPqWVXcLFmc/sTnjacuEvxQ7
	KD5CcJJiXVijwQ5PmyL3sOngQPPGOPmni5OoUtvQ5Es2IPIL66K4UHOnDRwCt6qKrR+nKzyTMRE
	ZYntpdFq1rKmotKKNcwgaYAFKDWlkSmB929AhgzzlS5c9sdtvqt/rG+orzg9LX7rzLSSZ4ltVFI
	vln8onqEl8bmhsjhC37TrJnK0EHJy+EG8ZCgFOha9jdTmaaz9LRGGF6yHTH7w0c4wk3dFjZME4B
	HGEsLNXxRVA5bQWPrVrpZKK8E3haCP26dUdGOas8KsHn6z0AHmgb/JcCUXFLlYCkHVYoGYUBT0R
	t5s4+wZdrZKMJL9A6uLU0X1ot7BKclL9u0JPe82T28OU=
X-Google-Smtp-Source: AGHT+IFJlDg83j9kDJr9JJPfps+eRdqlRn3OyrAApBvHJZ97334vhQbAuQiDLCanW42L2b91pkrT9A==
X-Received: by 2002:a05:6808:6552:20b0:43b:6639:7307 with SMTP id 5614622812f47-43b8da12395mr687917b6e.23.1757644642421;
        Thu, 11 Sep 2025 19:37:22 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b828d2ee3sm565466b6e.5.2025.09.11.19.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:37:21 -0700 (PDT)
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
Subject: [PATCH v3 5/7] riscv: sophgo: dts: enable PCIe for PioneerBox
Date: Fri, 12 Sep 2025 10:37:13 +0800
Message-Id: <a499a1c17f317ea57de8769032ec65e1e18b4b36.1757643388.git.unicorn_wang@outlook.com>
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


