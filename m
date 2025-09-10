Return-Path: <linux-pci+bounces-35786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 952CEB50AD6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 04:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556AE3A803C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 02:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C27235061;
	Wed, 10 Sep 2025 02:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgyF6qnP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FC123535E;
	Wed, 10 Sep 2025 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470214; cv=none; b=Tr14vxHgfOkqfPCJnnCQa1vk0Qh8iExIBOy2BRt9/i641zB6INxwh28utUIZ5F2xYx/NkN5p94Ja4m4KYDcGXEowZwbkoKiV2jIcjg5P0tj13yOXBjjKQiuEVRYjdpJ3txvumYhlqNNCLPoml/B3dphjXQBrr4bP0AcDQzbDS0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470214; c=relaxed/simple;
	bh=7ZMKBRn7WTwBL6qsn+lHI9SZa+lKRdoNg2FdbjpyDqE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JE62UM2PSOFkp2yVMptYVDl4UVkiFEWyFw9VSvB86qI08rm28/TV8yGOTTKN/CygvOe/MyO2H4NJEjDFG5pKYvxqqxklKqZvloIyFCtehl7utOXz6wAk/rsTh6ShN5cjVuBSks7I2hAoZ/GyTZoDJirqyg3ffjml6Xfe22h4Y7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgyF6qnP; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b61161c32eso32309101cf.3;
        Tue, 09 Sep 2025 19:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757470211; x=1758075011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0NX4YDlfnF2moHa0Gi9m7awPoXSV0rkM143rN50kIc=;
        b=kgyF6qnPUSSJJzAVfk8JU9fg0gqHaHOCEwk84ZGi6P5CsGVw9LRuNycqc1TKYMzNQD
         vum4pdWboRiZVWHnXHMKtD/OPlacrHNU0Eo4aP8Aa7TUpn6lgf1rMCy2pqRiyvVJVOiK
         MLp/5bYq9R99sUje+aZRTO+YhAvJ699ZBmr0bPS4jcvDWM3vz/CM7XOv8KfCK9k7u3yH
         RhZKKlOxdnPrtFagoyLsF38LFwrYORYnfGwZLp/Y/gTwQ6a0Bk7aMfgtO0wNv2PId+K7
         PlqszS0ztG0e1OLXlefLf8ZPZ4wlGRn1Q8wYMovStA4na0ZAbjNOGc+wZyrLlh8LFTDI
         lvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757470211; x=1758075011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0NX4YDlfnF2moHa0Gi9m7awPoXSV0rkM143rN50kIc=;
        b=C8Zq5AJEwv9Nd0423hM3Z9ZYjU37Dg3Q4yjY+d3tKdsg8GCfysck5hRtPBUkMlPbLS
         y25gLSQEW7gsGkxRLMI5vXWrnkJ9XXROgmUUNYSn8tjiAQA6liwUMVkVJIGH7LDYSG5r
         qKhLO8RKt1zSG+oag3eSb5dZbD0LDfDo2Vn2zGCmqKRpqYmLVRHJGk+ngORVzLfGT4Yx
         hkvdi9hULtktDKgkIDeMEt1ja0nHEUy7IVG7LwaHNBQPxUwFRP5muyIFN90z4/AMLMjS
         BEVwSFynkyIyrUrjUkZV1kM7Dv7q56ptOhSUAjhyFHm+WQRu8Zdb8VEGwfJ9G5Ti2zk3
         sasw==
X-Forwarded-Encrypted: i=1; AJvYcCUhFTF6ZC3NbPDXJHFjPxgbK7XO24vN23jSyzBySL3FGeqnmr1ApM6sOcR12Kdrfu8DNNsSnkoMjkuY@vger.kernel.org, AJvYcCUvus6NzpoUMd0QWO2y5xYCVLJlSlEv3vSdHj8B1IiFH1oM9KzOjlYN7XeoYoLJD9wC0Wiv9uWVxWr8CXTy@vger.kernel.org, AJvYcCV5Doad1Wvhds2EJT/30hzxCrUhKlCVNyscxEHE7S+TlhQCW19/VBiG+Ebcu3zphUJN6xeGuOmxO99h@vger.kernel.org
X-Gm-Message-State: AOJu0YxPR41yna8mJTyKDYv2PVeioFt9dP4QsqEkNv4inCKUImFq2DDa
	pYl5zSZzxydemB58kRrHln/UBhfAuKie/wupTPsDmMGIlKGlIaGCc7/0
X-Gm-Gg: ASbGncukRheQ9I7HLTsjX3uS79liOoumkIJIVqoSkr84yGnEoas2LA+KxuUPnsAhhp3
	espvAlqBaLsaaQmiw+Dm/fJVnvkqaLp6GYw4LjwiulWR2tEnBQFk/1CnfsM7CcW9tJPlI2hLaCc
	uNg2h6lc4B+TodwX5U5iHRsEtfCaECHHSnRvGgLqhoQhG+dnlVVU1n84psT7vlXYkaSH5gzPbNC
	9snbSieLXG16BcwVLSvXqyskjp12q/5jy24fTa6jxn0DIh9PHWyh7KVXghwTn/Cuq2nkZjcnuTj
	G+Vhqm2Ez/WIJdY2mAnFTavaW+wn2QmmZ02rXAUD0tpbgPL9keXVsQA4QEK/ZjcZXbIvTtkbLoW
	zqGrKMMs/qJZZdwQpnX8SIqme/YZ33qbo
X-Google-Smtp-Source: AGHT+IFuaLhFcKitf9ZA1Gn5XpJiUTwI3uqTd3riF4+17FcbGqTmvMmJT20lOqveQiIDe1ADGGm6JA==
X-Received: by 2002:a05:622a:647:b0:4b3:cbc:18b9 with SMTP id d75a77b69052e-4b5f83c890dmr144732481cf.33.1757470210737;
        Tue, 09 Sep 2025 19:10:10 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b61bbbc0ecsm17446521cf.25.2025.09.09.19.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:10:10 -0700 (PDT)
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
Subject: [PATCH v2 6/7] riscv: sophgo: dts: enable PCIe for SG2042_EVB_V1.X
Date: Wed, 10 Sep 2025 10:10:01 +0800
Message-Id: <2d85c8b221bf4aceae6f3dfaef6d53221daf7e70.1757467895.git.unicorn_wang@outlook.com>
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

Enable PCIe controllers for Sophgo SG2042_EVB_V1.X board,
which uses SG2042 SoC.

Signed-off-by: Han Gao <rabenda.cn@gmail.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts b/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
index 3320bc1dd2c6..a186d036cf36 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
@@ -164,6 +164,18 @@ phy0: phy@0 {
 	};
 };
 
+&pcie_rc0 {
+	status = "okay";
+};
+
+&pcie_rc1 {
+	status = "okay";
+};
+
+&pcie_rc2 {
+	status = "okay";
+};
+
 &pinctrl {
 	emmc_cfg: sdhci-emmc-cfg {
 		sdhci-emmc-wp-pins {
-- 
2.34.1


