Return-Path: <linux-pci+bounces-37923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9642DBD4997
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 17:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3487534FC43
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 15:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1825A31AF01;
	Mon, 13 Oct 2025 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="WUoKgkRq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CDD313547
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369746; cv=none; b=V325KLIgnaSBvWrKw/tmSBfnDpFEsviwn9YDdyl8taS2C8nigNvWyyw2o/n1Q6i7FBB8F4S+OpGa/rD7jXDhZTi4+c+/i6iOYYcY9E+zmWuLgo/1CR5LCBLTWBBOeQZA84TL9bQGOuKuN+C14zBiClugWFk/Ujlze52QFF1D0eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369746; c=relaxed/simple;
	bh=WJWs+NFUcGbJALoN3wXML39lAbVPkKGzBxDYg5OA8Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgtbyjJ+P4LDik7IzBus+/M2uim7K8uK7jpkOTm9RPq+jwIF0ezFkMEsvhDCFkytuHsa67E+gJMz+8d1B/q4IHrhlLpjqiWoqAMKJLMNx7pv2qpUjWB9jrwYjDcGTH4dN/Sju/wJOpxFP9ULoxhUQOPQhMWxH5EfpeUBMSQfi00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=WUoKgkRq; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-911520e43edso189727539f.0
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760369743; x=1760974543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbPxvqkXmDdFxjU8mZBTBK/T+YiYjBFrlI/xnqdkqi8=;
        b=WUoKgkRqAJkfF1tMhRYKer0fra8bVJZ9xJqk9hGZ9WmsqgNg4iaaWd3nKWvbQJpBGz
         ASggX2PyiyVoKaUZFbuSwooJ3AIFyo0DNAWqKcsTxhfx8pEUBLR2iEsGyyk9QD3p0SFU
         cjZ+tHmoiYYLEYkscN3YGOuDI7gaw2Rc6H8ARkuUadXxus3UShc/TzN+KrkXfs3eYLD8
         mF6HlkyHvQVwo1wIwxXDZ2jEjaw8Rnm5HKmIYQF6Unq73NOxZsKg286AsHseVCqfGQLw
         Hq60x0xfIi569ooypm27zNiLmLGs6eT5e2vP7fCdck4CWuRxe44s+Huqr5BBkZbh/yRA
         cTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369743; x=1760974543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xbPxvqkXmDdFxjU8mZBTBK/T+YiYjBFrlI/xnqdkqi8=;
        b=J3sAWoQL2vmVGmBMLUL/vxHVOA7Uj5fOWWT19uxiHU1pMVV61+jRFhel4hhXtxzIVm
         JULFNUzhzQnIVFqCPxUlfnBtuoBWlQ/tlwPUX2BXh0h2kqDfGTaNv5kbabm+jXR2qGFG
         S64dj2QVHfLvsFUH5oBPk/tLTXHouLgpcwcRoj2Vs03ErMB0p1iKqOSpDhKf5huEz//k
         0c7lNxkcOMQ3eOg2hjcNl00o5GeDU9xZGyN0+eiFj5JFYWZYhXsayPOhYeciwj2zcGOb
         76zx6BFI+NDKqF8HzA0pCgiLy5NmY3HPo2opSFnUOP59p1bMP2zthekKhOtHndPDFZlZ
         XhMg==
X-Forwarded-Encrypted: i=1; AJvYcCWM0mC7mxuGeJgFd+n01v6VVqdBV2b57d0S90BxOyVyns/MtEXdfHFa73lJhvHKekGsNN78qcJxg1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ5T/drDK0wd82iK8ryMym+aSeAkcz1rZHG6vkB7WCfGRcueTA
	b3ZfqdiZ5zibP5cK68a+YXU813XBs4QZAtpa3wNlEWGevU1uuSwAhI+ufgu1iyMV/n4=
X-Gm-Gg: ASbGncvnG9C8C5hzVLRP7vnt67I3PlC/daiat1+n99CowFcDF9tIEIzJ4b3D1tOdB2k
	mxie7MkyRc/QMgSDkuOOxLMD8paEkKgIaEnyqJoF2Y45DlwaONoETVRAM/3slxDjalgNA/ZAttU
	uyDnOunSbbhsxzSYlrWEVEEn2ih96ncnEBrOME8DeXXqbHApw0B59VMv4g4BQNih6CeKttz0q5I
	DiadEvovZYYNwzO07XdLaKdnQYwYf53xfJ71Dxi6e1QNbRROMVDgIlubIDp1X+GsKIcSojIJbOS
	NJXOlltCjgWzyx4/bR5C/eWOYHJTBpHyD8QWxWh0otJhlgVPWuAZnK4PSdWfGS7Pxnt3yFr4TXh
	Pr1+kTbuf8Yzg9RQEqN0g1lXH1mu6mkZlZ0TfryKss8N+Mn3RHyGrTZ7605jCov6PieT43XPzWW
	ru6d7DbJfo
X-Google-Smtp-Source: AGHT+IE+RgkOmKUAmZ+h2lR6Ri91hcZZDy7nYDDMDTZK5PVvcsi3GRbcTYzKlh5jsPOXdbbG42NjVw==
X-Received: by 2002:a05:6e02:4918:b0:430:9bc3:e1d3 with SMTP id e9e14a558f8ab-4309bc3e4b3mr13658895ab.12.1760369743033;
        Mon, 13 Oct 2025 08:35:43 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6c49b522sm3910266173.1.2025.10.13.08.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:35:42 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	christian.bruel@foss.st.com,
	shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com,
	namcao@linutronix.de,
	thippeswamy.havalige@amd.com,
	inochiama@gmail.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] riscv: dts: spacemit: add a PCIe regulator
Date: Mon, 13 Oct 2025 10:35:23 -0500
Message-ID: <20251013153526.2276556-7-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013153526.2276556-1-elder@riscstar.com>
References: <20251013153526.2276556-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a 3.3v fixed voltage regulator to be used by PCIe on the
Banana Pi BPI-F3.  On this platform, this regulator is always on.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - New patch, for a newly-added regulator

 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 2aaaff77831e1..046ad441b7b4e 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -30,6 +30,14 @@ led1 {
 			default-state = "on";
 		};
 	};
+
+	pcie_vcc_3v3: pcie-vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "PCIE_VCC3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
 };
 
 &emmc {
-- 
2.48.1


