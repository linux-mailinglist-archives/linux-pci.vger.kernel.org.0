Return-Path: <linux-pci+bounces-34957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E47B3918B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 04:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02D5162B32
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 02:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3735778F36;
	Thu, 28 Aug 2025 02:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr/2zXmL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982CD72627;
	Thu, 28 Aug 2025 02:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756347373; cv=none; b=IJMIDkf+x1TIeDjP0u3wJa4J1OBjlJtwYdmaJ/TaM49Ibg6AqmhgULFvi8Z7TfnkvNDdv7TlU2YAG3j0pnjkH4LEqg4CIOsYZiCniv+bTnVFncqVsf8XYwk3hB4lUHx0fxeioa7Y4tywEvu3w7zqWVdWsFpjo0xMwq5N9uj4r1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756347373; c=relaxed/simple;
	bh=hQA5+HMhBQRr5xtsFYZe4R2Zx9gyn1TFM720u0MLzb8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=sowBjI0Ff+U8q73yF+m8ABr8Zg6d8TZY/qyBBpO4hoJStX0p3S/nuNikWLhBhp4qTfgFclXCGbZt3gMSqz3vBG+bwKW14i/SBcmRyj+LkRTD77zClG/LJo6lQq3POyoTjw41yBzW5EarKuXNKLilJ024iSO4LKkgl5XDyRMoCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr/2zXmL; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74542b1b2bcso499415a34.3;
        Wed, 27 Aug 2025 19:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756347369; x=1756952169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KyDnSuhDjQ8VOJ+mJFnTBacGVMg4yY+Nne4s1ctZDzo=;
        b=Gr/2zXmL0h9Mw8FPM/a9IXvNJgI466iX5jddLotnLGWqCmQTOVbnYvJqd9Iu+vNng5
         B/Ub2RpZqMWYRSN0gAlNLOPtZBebMJw33NHkvMM68LF1qUKrVOx6wog7f/NCTJsrBegb
         xsDTMWg/5fNKigIdGCfiszDbqrVGPjJQINiT3tvkBo8DKkd7G/SPKS8ZHAStAM+bVKxH
         A2IoB6+hI3Aths0/XeB5D2S8WdlNzt5anoPdnuqLWNG2IzJY2GpHQKJlU5/DXxpWdptp
         xW/bQ+rAkSLSAynk0O6Ssf6UpO5t0uRihDfsZkDq4p5mql6D8tE2u7U6BFCH3GbCilRc
         YFoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756347369; x=1756952169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyDnSuhDjQ8VOJ+mJFnTBacGVMg4yY+Nne4s1ctZDzo=;
        b=pFMIWLxZDPK6Q2gr6p20dWoLdnmL4xp96/nOTK9krGs9W/+lQqgWweEjXNNbR6azxt
         NqjvZ1+m+d0EqfzJbFueQlyHUt0stzOtWfrd+ZcAOuDqFAdvzmT0PK3m0FBzaw3oM1YD
         JT+lKw5nD2ayJoBK+4rr1YydUCQt2iB367BVkumMM4mGy3e8Ty+uZa9Lr+ETZO3U196X
         V5s5pwILxw/dqcpxcEF41fFmOPXAHkff8Ontr7EnCsOODVmd8xPzrHVzb72fXhrNi3at
         JxIDSmNI5IFlYHuTObfXzks1F6i0+tgS9Tzo+RRuNYTFncD9JXmDL37Bb8Y8ElnZz3Nx
         1+8w==
X-Forwarded-Encrypted: i=1; AJvYcCUzkGSs0FVWHt9gNBOQXR0vqoj6ScP9grwAE7QZVTByVRJ5I3J9HnSr8d2tpuXPRND9WVkHpSqNbKBb@vger.kernel.org, AJvYcCVCBtsXNLR5OUDzB1ku5ee+wRqvgIXiaVI3VoisDbcjkTPOgS6hXrcW4X8RHeddv+njZPi0NFVrv4lu7l87@vger.kernel.org, AJvYcCX31OFX4fCb+aE/IR+SdZiiVw8eTmUIBsIBFdnWVfCI1jergcPfURUisj3AHtJDvc3XnD7KPVM0oB71@vger.kernel.org
X-Gm-Message-State: AOJu0YwIIHVUiWSVt+nzrwjaqA4rbfHh/HuzROH1Du29DFm5+fa6hJ1F
	VEhJqyEmat9MVW9dFCw9D+VOS563hxiV1Br58/uPvDL9+9Za0aMUgq0K
X-Gm-Gg: ASbGncuPkr6EFZS2XaxHBpNDpMVs31nNf0K/YgJhC6ZryCExsxPz9bp1BVJXt9EWIMD
	ux5lxOqtt4aPd5o+d6MobWg9pvsYuXsMD3i7gj77Ka6y+5wFLfU5jlZjJk22ASBBFKpuJmVTlhA
	SyKUVV9Obiz0r0s/9/XODVgzcAPPUHV8uNTLMrhph8ikyojJmglwBxgEn+UasEYxzDHi5NMY/no
	i19Gg4l3F1iyJ0zt0icqVzK5/gvpcppl7ggYJseJRVzHU954vSlFDfJYdvMJH33pMaZpnfvXKxK
	Gew8wRG7Bd1rLdTTHjQlQHHPFfhGSaEEHjGZl4QYbma49JBMgQc+LVaGFPy3YQcVBKQk9fdeFdp
	WqvdkW33ISDPf+JMwQAfi7NbqHaQxy5WfeaNAL5KEVoE=
X-Google-Smtp-Source: AGHT+IGTwvNOSas/djEs+uapV36wAJNWQmeyipG2QXZwMOf63seTufF1qhsaw+7FW+qp86Wa2UCa6g==
X-Received: by 2002:a05:6830:6b0f:b0:745:2adc:af4d with SMTP id 46e09a7af769-7452adcb1admr5051880a34.29.1756347369587;
        Wed, 27 Aug 2025 19:16:09 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e474c97sm3505230a34.23.2025.08.27.19.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 19:16:08 -0700 (PDT)
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
Subject: [PATCH 0/5] Add PCIe support to Sophgo SG2042 SoC
Date: Thu, 28 Aug 2025 10:15:58 +0800
Message-Id: <cover.1756344464.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Sophgo's SG2042 SoC uses Cadence PCIe core to implement RC mode.

This is a completely rewritten PCIe driver for SG2042. It inherits
some previously submitted patch codes (not merged into the upstream
mainline), but the biggest difference is that the support for
compatibility with old 32-bit PCIe devices has been removed in this
new version. This is because after discussing with community users,
we felt that there was not much demand for support for old devices,
so we made a new design based on the simplified design and practical
needs. If someone really needs to play with old devices, we can provide
them with some necessary hack patches in the downstream repository.

Since the new design is quite different from the old code, I will
release it as a new patch series. The old patch series can be found in
here [old-series].

Note, regarding [2/5] of this patchset, this fix is introduced because
the pcie->ops pointer is not filled in SG2042 PCIe driver. This is not
a must-have parameter, if we use it w/o checking will cause a null
pointer access error during runtime.

Link: https://lore.kernel.org/linux-riscv/cover.1736923025.git.unicorn_wang@outlook.com/ [old-series]

This patchset is based on v6.17-rc1.

Thanks,
Chen

---

Chen Wang (5):
  dt-bindings: pci: Add Sophgo SG2042 PCIe host
  PCI: cadence: Fix NULL pointer error for ops
  PCI: sg2042: Add Sophgo SG2042 PCIe driver
  riscv: sophgo: dts: add pcie controllers for SG2042
  riscv: sophgo: dts: enable pcie for PioneerBox

 .../bindings/pci/sophgo,sg2042-pcie-host.yaml |  66 +++++++++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  12 ++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  66 +++++++++
 drivers/pci/controller/cadence/Kconfig        |  12 ++
 drivers/pci/controller/cadence/Makefile       |   1 +
 .../controller/cadence/pcie-cadence-host.c    |   2 +-
 drivers/pci/controller/cadence/pcie-cadence.c |   4 +-
 drivers/pci/controller/cadence/pcie-cadence.h |   6 +-
 drivers/pci/controller/cadence/pcie-sg2042.c  | 134 ++++++++++++++++++
 9 files changed, 297 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
 create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.34.1


