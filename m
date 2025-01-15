Return-Path: <linux-pci+bounces-19832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C204A11A72
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A71943A2347
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE36D22FE00;
	Wed, 15 Jan 2025 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amgsQF67"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2679622E406;
	Wed, 15 Jan 2025 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924882; cv=none; b=Ri64iRzitwO4K6gZ+tag56FaHyVVPKm/MJ8Fx3InmayJT+p9Tk5r1pP9F6eoDXR7hj56qH/hYhv8QIQOT2KGxZwqyVdvrP3MvMcDtx4sgzofUt0RI+ytbUCCN4oW7nAUnh8jRE2cEL+Q78Imqzysm0bBr/SLoO5MZZxaBXj/jTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924882; c=relaxed/simple;
	bh=3Y0qnShoAPTndhTD1AZiRjsbhyrdHNiZJdUViFf5U9Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H2e6wHwprPq1jYRLjS+i2QV2dB20QVFpghZfgTwXZyou1rgEpKDqt7ROeSyYhFr9RKbZ6Xp7quSEKhYJd+caTVhiFIrvfOLCAaWn8bFAM+mDHM61/DbwU03+WwqjnwScbabv3og9QBu0kqy4I4P9dyZJSzH2wYhq/b9Qj9g361E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amgsQF67; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71e3167b90dso3521625a34.0;
        Tue, 14 Jan 2025 23:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736924880; x=1737529680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sywd5ibf/76z5+rkZ7ijeWmGFF2MBuEBBfOcYOD/r6A=;
        b=amgsQF67BSJz3dEkGm+n4qxWddupfEQNg6KGhu9URXDnDTd6bmenXrWDM/x+N9WYvk
         BGSNQa22IDvh92La4DjSOWuRn9EvNnGC8emMOkVbRiHf3AutdtKFeMafdm0l9RRpjF41
         e4EpvsKrMn5DBhpxev44h2nkFcWdQ1UxQ2MI6iI2J7/Dz2XudjVarnBmrxxuNlmBsMHq
         IdKSOj/Q8XK1ZsXzLfPvL7kU5U9miRMr5ZWchiBRlYbUrFeGMaq3SDF8rzxlkkZxI3jZ
         YMaFReVMgsjS2RloXrA+IUarnxhI6wVdw0/LnmNxDq8h/NR5+nIcthZtaeIckcMBIAdH
         GvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736924880; x=1737529680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sywd5ibf/76z5+rkZ7ijeWmGFF2MBuEBBfOcYOD/r6A=;
        b=agpv7ZiuCAq75TQV/gIGhZR9qEm8/yAIalxbBe2JOHbJTGzfcqU0i1L2eP+ApyZyQH
         NLMo+yL8d1hWfqLtdh0WVGOTXVdwmwe30QX8u/PWNDk4NMzFdbse2TABsweIi/4vQaAt
         ttdKhB61aHgKFYIwj03HJv4eAi/LlzJyADhHXI9KBDZVEBzDMV1X17IQMdH3OylRahB2
         7sADa7AygTlg5qsvXmpNUvqfhh/KwAyjh81sYz7ZUHyBnGhGGet8J6tECWHRDdN0AvCe
         ddL5fgEcXkk3PIRzdgick+AsIBCZgNn4zal7bbqHxvW/U18m1/tLxhCZNTgSsc29WNdc
         FzmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkZhbipjmA4OE0JPdFgkjgfStuBjiNe24U9M1V3/SO1cjZ7psQBKM7A50FIgQe1nfcEJLgQZLPdosu+NNb@vger.kernel.org, AJvYcCXjvyWFmvHwWeIrC3vO9Hn7BCORqRUG2Z3AZYhy0+i0oqvH1PWRYty+W1UhA0AGxVhICcoE2GDeXH7g@vger.kernel.org, AJvYcCXqe3jBkYk0WDraZd3qXuW4M4wd6YPnPYfqlN7c7Nk7RH1as/faselRUwxnlkZ6Sdyl7vUcLz0sLEeB@vger.kernel.org
X-Gm-Message-State: AOJu0YwMgbfXxavDTlDYdnLKxOUdgieDy88l4LueFldaNSImNaoc+bPF
	xiiSfOsyiAHDW9LB8PycRo+1SLL3MY4pMrzRAiD3kMpu7HbRxvhp
X-Gm-Gg: ASbGncv7Gz2tSj3DZ3az2XvYzaKvdsi4MoQrztho5tBHO7GUnbkceTK8ghmbNRRDatt
	wBVGcHmh3btyqvTmyXsTqc9Ir3mkTkx3bzmYN+3RARyvf9zSs+XSdtcrN13DAwRdOL9zc44wihl
	h5293sdhGOr5hNWmKd5mFNEk15HOV+jwGvSEIAYjxyNNHqg/Gyc3ZLYKiunoUr7qYdhL4c63tcK
	5IxPfUOKgqjHkprsJ6srVaWM7UEYhPviyDllz8m5K5ZMCFY0Dsh37XdsF1b0n2KNNE=
X-Google-Smtp-Source: AGHT+IGnl0S3Vd8pXkdIN3HJE5SIE22G/XRqd7+QGJZecFn/BIUmK5lpK0e90tA5t6cvwvK4WGpw4g==
X-Received: by 2002:a05:6830:670f:b0:71d:6543:e83f with SMTP id 46e09a7af769-721e2e2e8f8mr16534130a34.11.1736924880145;
        Tue, 14 Jan 2025 23:08:00 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72318538401sm5407820a34.7.2025.01.14.23.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:07:59 -0800 (PST)
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
Subject: [PATCH v3 5/5] riscv: sophgo: dts: enable pcie for PioneerBox
Date: Wed, 15 Jan 2025 15:07:50 +0800
Message-Id: <eb2e8c619a4dd53f9bb1aa33add4f85d4ffa7d79.1736923025.git.unicorn_wang@outlook.com>
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


