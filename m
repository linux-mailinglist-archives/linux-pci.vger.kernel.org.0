Return-Path: <linux-pci+bounces-35787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5DBB50ADC
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 04:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61E894E1C0B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 02:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD802367B3;
	Wed, 10 Sep 2025 02:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ah8HW70j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA68722FE18;
	Wed, 10 Sep 2025 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470232; cv=none; b=HYFXT2lRF9mb33rNwYKvjQv/ikMnGx3TTYqew249jMwHB/6YXuY84mMfe1jNpXbzvKZay0ZnrjcE5OTrit77J7bJDya9a3RxauRbOoO0ckNhBsuKFXRyB5/v+hTgROKPMyuvkfNmtsiiKg6WE/SOZ5ln1QWwfz9uLSAVPV/Ebo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470232; c=relaxed/simple;
	bh=+sDUkA3o71u4xm0yCZaBibtMSUQ/NK+r5JUrUR+q7Ew=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fIPPFDr6Ag5l4+vZ0jJAjwNpjcZ68FhxVKmCdxEKoKIDPtSUOggJY+aGdM4fguZliDTESKkZxJHk/F7OlS+p7BYA2/8Bcypb+cOzvmbKY4YctqjNOkW1XkKazHCpYtdGROEv3wYR5fHevrz3Tbc1y9jL5DyRYJjk2/mRhc0D1pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ah8HW70j; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b548745253so88293971cf.0;
        Tue, 09 Sep 2025 19:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757470230; x=1758075030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8dXK+URwMz/QYwLwmlxkiqTgmS0zDdGrSZfnYxwO4o=;
        b=ah8HW70jQ+ObeAxiUDARjVjetj1gzYjI18vEL0mmaYs1/fSvDRzzsq9DMA1+Wj0l3K
         CgvtNzLSaOJLGmArbscuNM09fQq/YQVp1vWzIwREYVBetDGoqNrwe7PNnoBcm7YLYz2V
         hIAGBHMYquKTtgi+cb5k4iWEREBQOyCA1Aeqa/il3VN1HOGcDoNNco36UPcuppgMcyZD
         MVzRHCJORwdJTWkX6bJm9ev/d9OLcotTistvUqLGawVo70l9i2UnkBtBUkG/iJFlVR70
         AnH2r1tD0qx5r/ye/hhAN9JaMmjKG/WNDa7TxjeTNis+wGKFYHK1azKACjhqU/bGaHmc
         bGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757470230; x=1758075030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8dXK+URwMz/QYwLwmlxkiqTgmS0zDdGrSZfnYxwO4o=;
        b=B9ubKGJLz3tOTExCmz4Ghd4TJ3Pr6LtijILXHyefJg1vGJMBY9yD4m1FifqH3xQ/Fd
         2IRyC26dhzKdv/+KSAPSlW9+gj76+mcJIRtw/zzfiqky4YbhUdrylueYee4HMft3BV7w
         Ku6H6V1H0HkMoQhN0XnxxbxrA/EsaIQQLwSjU7sSe/OFZN7ZUmnqgpvkXNu+JzJQb52h
         tQ3Cfo9Fr5snIDXfRHlMBy0YScTecOODsnSDOudeBYrEvPUoWdeKYAp+si+y4gnfAkxC
         O7kyCwz2Q7n4KyBTO4diOLvhN6Cozx3TwGWlSavpNkv7Xywc6Se1XlfOFsp20mlHax+1
         8DyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8i1i86IQms5NhydqQ87mvtDCVh9ccLbl3ES4JUfD/QF+ZAJo/Q3X1DeFYbqOaqpSYp+NNAUh75JF1e1Bn@vger.kernel.org, AJvYcCVDtD7uw4MT59jDfSoXFhPDp9HVJtlXhMMtAMd0QAumRT5PzJBSwk+tkaZ6elzy+IXBWYKwoxdEd+Lp@vger.kernel.org, AJvYcCXLXWglWhS/WE5nyuOngr50WjjqipaWMg5SK0d2iIWXqrDnwhHHZK9baSGyKiL7hhNgT4MdILjvf112@vger.kernel.org
X-Gm-Message-State: AOJu0YxWoeO/Cfg6xdDmrWobVlm8jG04qgpnS88JNR5SbExBi14hiwCH
	quUHPOH4v69vN7hTksv+pLGQQE5Qgo7hgVIW4zzb9yrCrWIu5Wp2MGLI
X-Gm-Gg: ASbGncu+3kEbuVcNEQx00Fwb324Ka0x6aJaTMM15Idzm1Wbst7nZG55XPVKaOFk8aMc
	WMRAY7Ca4ocrDMQK5g73uKi/aBN5UhhgUe2Gp5KTjMnde86SWw/HF38BwpzVa/hrI0TWXdSCWKL
	H0PMmvTYPFoHBRd6+w4BTPiZgT5Mv8F6rzLLp9ZfpfD6fjzzrt3IV4HRozfjcnGWr90BBQiOaUZ
	6dm2VjmBba9+vN8XEoEXxCyPdIM3KolBV6uF6VQ0GfiRewUGP8v002J89X6v9+Vf2mvfFrlIltc
	28OpkmpJBIuc9o9HJyP0J9fNnaXNEj9/TlYbXqv40UGJu6nw6Xu46nvGHxWNgtbkwCYIEKkz1uK
	l9w/2JtT9v4Ykho1Tsi2R8rZ2YgYrvL48
X-Google-Smtp-Source: AGHT+IEQT6CbOd2QsWi0+OjHaJf57cY/Drb66adJD+cAQ0n8TdhI1gbx+/J0LeyepotKxmQzV1314g==
X-Received: by 2002:ac8:57d6:0:b0:4b4:2d3a:8902 with SMTP id d75a77b69052e-4b5f836707emr165034461cf.5.1757470229614;
        Tue, 09 Sep 2025 19:10:29 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5ed71ad8sm210106585a.50.2025.09.09.19.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:10:29 -0700 (PDT)
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
Subject: [PATCH v2 7/7] riscv: sophgo: dts: enable PCIe for SG2042_EVB_V2.0
Date: Wed, 10 Sep 2025 10:10:20 +0800
Message-Id: <023eb6dbd2d9d808c3992e954ad7eb3840da8260.1757467895.git.unicorn_wang@outlook.com>
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

Enable PCIe controllers for Sophgo SG2042_EVB_V2.0 board,
which uses SG2042 SoC.

Signed-off-by: Han Gao <rabenda.cn@gmail.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts b/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
index 46980e41b886..0cd0dc0f537c 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
@@ -152,6 +152,18 @@ phy0: phy@0 {
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


