Return-Path: <linux-pci+bounces-16421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 818EA9C381F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 07:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A4A7B216CF
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 06:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF3D147C86;
	Mon, 11 Nov 2024 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W37Msxwu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD7A482DD;
	Mon, 11 Nov 2024 06:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731304826; cv=none; b=lhTniPsgqYBw41khTzjqIXYRhwgdWgDwwkzl8nB20jld4ewYXKlNJ6fwuER76TOT1vNT0b8D/IzgfZ+RvFcy4sOZWH6KBfM+BWvab05MHya+KSV+WAxwZdFGOqp4tqOmEFzuNIzopabRh6/O8fFQR+ViWNOJlqpF/iZadt2nsDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731304826; c=relaxed/simple;
	bh=x35E8KjaM3+OTgr9O3Ohn16lmeATUcDBGMW6GJqFciM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mn9YRHwNxdcU8Be0Zz0kraP2q5kjmeI2Vunw2V8s8n+y/QvpCLXIMOCHvbSqywK63XfWahb9IRYYOrWhVgME+CFqTu6fbXoeAZI6Xdzt2Mnaa/itMsLiF7lk2MVssfU4zwJ4Te5Zwj57iTwEex6f2YdO18j6LlgusOzCRNb9aPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W37Msxwu; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-718066adb47so2471055a34.0;
        Sun, 10 Nov 2024 22:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731304824; x=1731909624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HB3qPjMrBpNHrB9kYUUmbwc232oS7W4EAFSAt7K/O60=;
        b=W37MsxwuDeJ34Pc5PvLaLpNE+EKjXJLAj6qi2tFV+8LVZdf8mH5CeQPSDJIheDwv6J
         Mj4f2QCfUjibbbx7fKyrehgKslba7H51XDDnMxv6g+w8fBqh/6zDtqY7Yy5uG5TSe7g5
         rAg8nVPtdOf6ZViz1iIXnZ5RvkbM5VWP3gkpcXVMHPZpl8+Lo+2eL7pP5amnwBzrGdH1
         vhKJcz+eHISlF5L9QlPELxYiNc/xDL+/iiNKGROOV9Eii5CAmJPiVqsqelzmbqSOn3fC
         evagc7QY4O++xBzk8QdX1NyiliAucWoPnmGoVtgP1NtEtI3Ue3QOakUqF0i9cyJ/okiK
         Ngbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731304824; x=1731909624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HB3qPjMrBpNHrB9kYUUmbwc232oS7W4EAFSAt7K/O60=;
        b=SLfH4YkoLi1GDd2POsvS4PQU7mXMRtjBRN62lc0/C5fcYGCpUtCx/pq2hkEZBeDmsc
         Ryn9g1EdkvYxWTw71JTlg/hbgYlrR8WTJ77JpZ6rdVOq3twSk15PgmYtzwa0GMCxcD7J
         08GX6mwAftTqB4mCdyF1G0RcJnJuYUcWg0xji78S7pQDaldjMsZvz2rbbQJRIjsKdl0A
         Kf6yOXjcgg3gTQHwFxIYhejkyGRx7Qq7/OKbUgObCnaU4gh4EuOOb6qp/BmjOAzOF+N+
         kmdjUPFMe3DRecBHZNHs/BH9fy1VckfrrZNBLlFL7IW0Vp9lSil5Ofmp3xeiyZFHW09a
         Egpw==
X-Forwarded-Encrypted: i=1; AJvYcCUsiAJtMU/dnjtohokA/796TNsuFMfj+wuG6Lrp+55eE2efGi8/ftuiGcX46uvgrDzMPnEVXzNMUmfYsbJ8@vger.kernel.org, AJvYcCWDYwf0vY0Qzq28QIGKRTYVyQyLj4Bs6BNdRO0+95MNwa64jkMBhutnigEIeTYxSVZ94kqjxhTbG9ij@vger.kernel.org, AJvYcCX4M2DVgraQ7FAi3dct3vJuaUN/Jc4/Q/0TVCd7NNFwde6/IOWICHDU0wOjchWPfaiUZxvJQQ9tE7Fl@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc6RTOF2keYnT6TY4Ha3q7Otsqh/mh1zegMfaZBJNx6WbHZmQm
	XnwMBRpLPuLtn/bfpAchmm9KLYB2J+F6mnxZxS8+xkznLL9BqySI
X-Google-Smtp-Source: AGHT+IHlyAOfWAKE5ev2UjvU1fNznXmdq+01HKo2SJuPfm+QU62k9qG+BkGkD8K2V8IYTqwnw4le0w==
X-Received: by 2002:a05:6830:631a:b0:718:bdd:d1d8 with SMTP id 46e09a7af769-71a1c1fc074mr9175544a34.8.1731304823786;
        Sun, 10 Nov 2024 22:00:23 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a10920002sm2116864a34.65.2024.11.10.22.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:00:22 -0800 (PST)
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
Subject: [PATCH 3/5] dt-bindings: mfd: syscon: Add sg2042 pcie ctrl compatible
Date: Mon, 11 Nov 2024 14:00:15 +0800
Message-Id: <4f030066767c2a3b3acabe24e3dfbb8d87b42bfe.1731303328.git.unicorn_wang@outlook.com>
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

Document SOPHGO SG2042 compatible for PCIe control registers.
These registers are shared by pcie controller nodes.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index cc9b17ad69f2..55f919690001 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -106,6 +106,7 @@ select:
           - rockchip,rk3576-qos
           - rockchip,rk3588-qos
           - rockchip,rv1126-qos
+          - sophgo,sg2042-pcie-ctrl
           - st,spear1340-misc
           - stericsson,nomadik-pmu
           - starfive,jh7100-sysmain
@@ -203,6 +204,7 @@ properties:
           - rockchip,rk3576-qos
           - rockchip,rk3588-qos
           - rockchip,rv1126-qos
+          - sophgo,sg2042-pcie-ctrl
           - st,spear1340-misc
           - stericsson,nomadik-pmu
           - starfive,jh7100-sysmain
-- 
2.34.1


