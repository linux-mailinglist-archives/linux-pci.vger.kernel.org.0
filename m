Return-Path: <linux-pci+bounces-35977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E39B5407B
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 04:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED447A9EDE
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 02:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F5F1D5146;
	Fri, 12 Sep 2025 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdXvyRrH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB4B1E3DDB
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 02:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644668; cv=none; b=gGN9eYFLXvMfi9Vqfu8kqUihWH5JTKqzZjmF0wnsd5JdDBrM6eTm4b13+G7L0t6dxQr3Ra0z4CGuLeeVUP+dRrHd/kM/lrmPqZlhuPW8H269j0i78KagqvUdQe8wJ9xBPrSdmK3qhPCy6z5PqoxuWssGm/3CXIIZ0MOzrgdqMwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644668; c=relaxed/simple;
	bh=7ZMKBRn7WTwBL6qsn+lHI9SZa+lKRdoNg2FdbjpyDqE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ioVHXj/yzNrfP8mU07oWTm+Jum1VXBjptkiYili7KCrppEiSyGI33D2j/wKIk6PEcpAvXJXL7OvyzI803ksZHdRk/8PLRinv1iWCJMjiT2AGDrOl04GTbQQUozFuLuPTccevlYhxrKeJvpQYCEJee/t5ImpH8c6SRxwop43IKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdXvyRrH; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-746dae5ff93so1551412a34.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 19:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757644666; x=1758249466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0NX4YDlfnF2moHa0Gi9m7awPoXSV0rkM143rN50kIc=;
        b=hdXvyRrHc5YVCn7WlVNjOl4HsPgAykdmV0jOS1WpZfcsUsn1dRd9/DESpg3TY9nPJN
         DhvPoLOzCAIR+J0VWUY0LXkeSZ7IKrwGt2uhLE87rjrZq2l+HwRsKLyQGJabzPL0GAW4
         CEkQAMNwK++4Rrf4uiYJcncS5Hjc03C2JI2vNPJy/Imu+tAvQnmfdulMuDSZOnKB/mif
         1wecv/UtYrCbiu7FqUb6Nf6Bz8AD1XzfAEMANOW2kgLuEy1eiNUIEjl4hbFh/w6yMvhO
         U1yJZQq7AliAzhNfKJ2rIbpievQRuePcZkOuPRVUobHkthoOri8joTl4GyduhaiK3Tg4
         Nz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757644666; x=1758249466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0NX4YDlfnF2moHa0Gi9m7awPoXSV0rkM143rN50kIc=;
        b=IUEiONi6ArygtuPTVUq0Q2a6m/gME9R7DErwDYRGhu9RL99F54plZlZnX9rXiZd5wT
         bWLx1P2+Az2zsNj2fM9roJXN4hVLz5+dIqVwmaUSCI+Al3bmoC272HpZYMgwQ8hg7ywf
         9BR+rqARL0PusJNa8rUxWE++N9mLKB1pvtnOkOGujetgYvarAx1kb1BLf+ItdhSWlGXE
         jFrP3g+DQy3IBeXWz+rEFZsE3SIepEr2tslybYaOykDoqmCU04hGBGN9ZYh3bWYV7Y2g
         pEs223Hexm5Gf39e2t9onVgw7b6l95FierdBzLAvGixedSJlLAdgEOYehNTuy6jA+oWq
         COrg==
X-Forwarded-Encrypted: i=1; AJvYcCUrsyLfZ+mmWtzEekf7hLhchTx4oTr5ZBrq1RWVO7+ZHe0z8YPanLpfzSHRAPM4nTofHIJO3l+brnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPScBSRcETqyGxzAcNYLUksVuo45U2bmMVr2qYCD0pfhdpHyWq
	xK7/jrSe5oEh2V5u7afy/fEC6OA0w0mcOaiOeEvi1+8kuevQgtx/IpJv
X-Gm-Gg: ASbGncvAKBOQ6BXXXHXNyVIokQCo7xSfZ3WzJufg2pIh19bVg2Dl4py0+rXP4RMF1i1
	k89icWR4eADU7LOx9brbmU8G2bhSTl4Bzh1OH7u+yOC5NToZrkgD5GREaTIIirOUO5qgihbKNvi
	LmZv57rsk6JcpVPFzHrT3CPS7zX5GSKLPasDJNXdD9bW24ywOzsghmIvzCd17Tv7TJGSq8wKc2U
	XW2HG6ZHxYX9VnvGpneDRGZ8EYkquGShrHjA8B0woWhMwzPjmWRiHy5JpqU8V9BWd7zIprMcB+5
	z5NAf5Z1RhhoOSBqUJH9v3Vo2Go/SaEfYNzi1yyqVY8CHd7L58Y7DBfLaOH0l8mqjbolW6fnEdP
	7+O7iLABQOaaIAwE3+3v/as9FLeJ6HoiewzeeOjk5Xdo=
X-Google-Smtp-Source: AGHT+IG0TQa2WVbWUOjIbbfIZ5nePfOY9XArUERpTrkKtked//q7vNW0k55MNp1jMcZH67KflOuh+Q==
X-Received: by 2002:a05:6808:4f24:b0:439:b198:23ab with SMTP id 5614622812f47-43b8d8cff2cmr506892b6e.18.1757644666012;
        Thu, 11 Sep 2025 19:37:46 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b82a7264asm586173b6e.21.2025.09.11.19.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:37:44 -0700 (PDT)
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
Subject: [PATCH v3 6/7] riscv: sophgo: dts: enable PCIe for SG2042_EVB_V1.X
Date: Fri, 12 Sep 2025 10:37:35 +0800
Message-Id: <76d4012e515dc3c3d4e406a237eadc55203f77b6.1757643388.git.unicorn_wang@outlook.com>
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


