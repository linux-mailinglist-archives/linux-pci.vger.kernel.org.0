Return-Path: <linux-pci+bounces-17905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FD69E8C17
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 08:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5AC18859EC
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 07:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD3821504C;
	Mon,  9 Dec 2024 07:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BM15vfY/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549AF214A93;
	Mon,  9 Dec 2024 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728857; cv=none; b=K32FRaIeK/1lJ4f7aqQaYlz2QziGQ6EbYVwaZVuVi3xRAUAEdrVK855wSDC2op8o+MS5SOkJmfOPOc+q9gJfwR1xfhdHyMPeQJ+YTf0eYysUm2NeDLZr9cQz98sRtOLoDyQ1VqpCM1l5a+ms7EOdDmYAYMwxfrA/LwMamtQYdzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728857; c=relaxed/simple;
	bh=3Y0qnShoAPTndhTD1AZiRjsbhyrdHNiZJdUViFf5U9Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rQhFzKkVxuY83n9x152UugDkefLeZYdoX5z8wcdttyIqtOP9FU+RwlwJ583YV6C9afyuf9rAErdsLPEF9LCOM9wlbUviq5L9cuNIGyE8OdhA8Dy1tB4qJNbPIujd2VlvYLaoLa2yo7hDvswwPm+8xobNi0MjC8Uoie4+qVCD4qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BM15vfY/; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eb34620af9so702112b6e.1;
        Sun, 08 Dec 2024 23:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733728855; x=1734333655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sywd5ibf/76z5+rkZ7ijeWmGFF2MBuEBBfOcYOD/r6A=;
        b=BM15vfY/ju/uZQdRFdsYiT1LQ+jsCVE/3XltguyptBMqCaEQ0aeday8qhf8utQJq6L
         R5gF6mFpB9IjQjbkYCALNt4t6Axd6fKE0dWyFBW8KJqU4cenhUEhv8vJl8Ui5McioyEy
         DlIXIUKuMY6d1963QSWdCC+r0CTh3L9Fhy180vVIZDFBhFrqW5IKHWl7/yDmd9hd/Nta
         omSujZqqvlhaDjB2Vi7ca+/q9X4wuYh2ChMr5wzXMH8OhXBwaJHOVyv9SyqosYF5HV3c
         OyffMOfRgKRYLKJNAEG6sl/QSka0+QH4MDtb2qDbHw2pkz6qKdSSRU4CIYJa2H2Joz/E
         jjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733728855; x=1734333655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sywd5ibf/76z5+rkZ7ijeWmGFF2MBuEBBfOcYOD/r6A=;
        b=goZ4qNg/jhwR0p83TpAo+jnHnW4lbkBcDuNlqzgR/mS9O9oQ69M4OGTAjj5naUVBRj
         qrB5vhCHhzzv5DA07wNJJ4CTu+yaSivIWMHdHpb3goaY9womdZmD4CRguoyIKV7+2Ivt
         50pBOfch//xkqdbvHRG4Gt6om5Ww8PPN6wSBB1v0KrzoHwpWWuNcH0M3jm+g7c0Hr+vu
         8qHP/kkSbrnyx+5gB0MipsI12loAT0VrASyHoSIS/nyKipITacNQ1zdrspKFr4NAbq+W
         3qDvfE8+pZ1cYda0V3NL46y82Xc+JiWPitKRdCg/GYTl6fborIepVfEEimMGF2DVMNRd
         yKXw==
X-Forwarded-Encrypted: i=1; AJvYcCVyJk/GcxtXapAMY/E7mm4VlValwivC8QhRKbLS5nK7XzBHLq/qASFXecnsqC8J39FqSOaeSt6WEJbn@vger.kernel.org, AJvYcCWNdvioCQ3WT+l/FswWG5frvPQaVyJEt/5LESnyIbwBPMfBgyi8QbA1Q0td3RTeuekviakIKfkKDF+/MCUv@vger.kernel.org, AJvYcCWSfjQxP1662gDnp04+Manhm/zW0nL9toMMQmwCdNn8BFw1LmkuPkaPxDoG6qGCuyTDFtOlFi3ftbdI@vger.kernel.org
X-Gm-Message-State: AOJu0YwZqmP9uimLIg2aqIo0LEOOrx8HUZePjMyTqcl3Ns4P6lmvSAXH
	ZGKE9XoLaS4IAwWv7CJmNHVqkt/IHlfeBnlbY5VAFxxgkKoE7ubi
X-Gm-Gg: ASbGncuZLdnvr8OeZtH2MUOInfv8glbp9jb1Ga30ddEJHW5FCjvblVDhAOL9sxL6XtA
	fTZe7bSLf18p/DqU+7aRYpHJ/JutOnluK+nTcCz0Ly+aAFj0GcBMpP0RMlcaEdpO5XVzPxpfEL+
	yAISC9NZlq8RhgkOexiF4C50JZnkC6u21Gip5gzVF4saMhyuB+Mi803oABsTTCNKsukCYl/mMAM
	ejlc/aV48MruIC0uck3TXDsy9gT6EbgDrvt/qN7v39YY86af+nWq/kukW1x
X-Google-Smtp-Source: AGHT+IHWdeSWThVY+F+74ZdnjYKyllCPH28XhzCUMebKX0SZBBFPPV2lGMTSNickSlZKwyOtGT7n0A==
X-Received: by 2002:a05:6808:2384:b0:3ea:5705:2a2f with SMTP id 5614622812f47-3eb19e5d650mr7560012b6e.43.1733728855352;
        Sun, 08 Dec 2024 23:20:55 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f2c472a028sm62252eaf.33.2024.12.08.23.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:20:54 -0800 (PST)
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
Subject: [PATCH v2 5/5] riscv: sophgo: dts: enable pcie for PioneerBox
Date: Mon,  9 Dec 2024 15:20:46 +0800
Message-Id: <5887f31f8f8080e833d799bb4fae2c52d6739d76.1733726572.git.unicorn_wang@outlook.com>
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

Enable pcie controllers for PioneerBox, which uses SG2042 SoC.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index be596d01ff8d..e63445cc7d18 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -60,6 +60,18 @@ mcu: syscon@17 {
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
 &sd {
 	bus-width = <4>;
 	no-sdio;
-- 
2.34.1


