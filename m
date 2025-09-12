Return-Path: <linux-pci+bounces-35971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B33B54066
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 04:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C757AB932
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 02:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54051DDC2A;
	Fri, 12 Sep 2025 02:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKp+ypH0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C1945948
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 02:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644523; cv=none; b=KvsNdfRYG1gxF1V7z9UK3Yvvu529x3yKtz5UMZQlCVMGeZyJN2CqKhL9WDV99naEYVOfK7B5C/YIHm1/82w8vDRXYGbpKCopzNuDcjkaVtrXMtgUqzajqrfsBmo5CgpoetbJy83fXDkTqArrAYG45+xS2gJH0X9lKPRUqO3uuMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644523; c=relaxed/simple;
	bh=gH9mXsZ1NreP7BRLCz/KnwpMOnnbb5r27TVVPsD+/H8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=XrRbnPVuWz0RLgw8/RIjGCj7YGYB0pvtrKlaoUsBNDRI1jP8WWMinIEIKPeDIh/UMdXwMPGc3h0WHVWX4j8mbLDMhs8775BQHIlu9c9htagvNDmkvrC1pVC/RCUKvomn9oZJ+2JmAWRqLhCVfy69Xkluslr0yyu2BUW2uq/1frw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKp+ypH0; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-43832e0c40fso64151b6e.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 19:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757644521; x=1758249321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=adSqTL8NuaakTvHTADgBkkDWAaGQjbxG9j1BynMCSQU=;
        b=VKp+ypH093oI8Ktp341QcMLUOJjacimTQNFUh4Tr9Odze586piRXkqVfvGhC7Uq2ti
         SrEp6pMPczWAR/bAqUdXwtQ6XZDFeb11Pnfcv2LjgxRK9BBk0c9dqGpg+s3VIJjG0O3C
         Yr55K7d6rgxt+SxWyxkp1bc00/1LG443YtF/AWrFzsJgXjapwguxff+1cTLYzobAMrbQ
         hFKbLZ2R3i9IaYJ1xHXnCAhmFHoDSC5OpjDUFHx8dXs0NVCcZSCUUmv4W0xBjs6PbDy+
         k9rnHGj9yu7FLNwYaxshje3VDVzM6A4+DGwLdoZgvfdCBkHsAO8uwPy4HhDUC072+bt4
         Hf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757644521; x=1758249321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adSqTL8NuaakTvHTADgBkkDWAaGQjbxG9j1BynMCSQU=;
        b=ZM+5gWoRAsL1Uyvfj1P8pCk6e1CAL3LIgcvWJc3tpnvKEH7xfMePRxwcDZwBqnmZZ2
         5bbOafmk1fvZF618XopZns7v/vLlD+FY4z9Ka4vXT3r1HlQmitNfeiTtNwXmO/jUR8PQ
         SSVaa5MlLGB34Xd6Cd1XvtKNNSkI4JRDdp6+vbfzAwBeEpCSlDOL6pZiOVKRvVhmtMKM
         FhTSbnP9fsEMpIQe9HPEvEwWNjY/ygXOcOzFPYy5zhSH+1cKtO1VJGc564Omy4yTp/nb
         V9vPM8vhS18UJG3wAELtk3+t30GsFyVJFYjMjmDKah5BAsQDZrqnKuDW+eFECxBv7WVU
         3CLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCxN9XdSitQSBq38AEodX2u+aF0X4l+MYg1iTxu8EtO+qgCYWpFjeptF6vGhkpghmy5Pmy3btOoLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/G4fjpwtBu55O9qAF2XcsOGLrrMWNdkLvHZtk9W2qH3ZLr6g
	CCGCwRTZN7Q+Ok0LMoY5rPNPFpWBZI4yXkRCGCUlIDK/woU3JxTdrLvr
X-Gm-Gg: ASbGncsY9rS0u2jo4uwjPTF2OjsVi8ff+v0PwmB2flqIcaCYwMKtq35o7Pp+7BgPJQr
	YxTGSkAgvEVQY21/iU1NywvFPaUpHEm6Hf5CQ591nnlWyMLIEvKs6okHv747SbCmj7gJzbnWRhp
	cRtE4BYpdCQS9yV5gjJhRT83DpDf9SytrL4oCO0Ii5P00SqD0qdlQ/Klz6TCITGdFJIBGqSHKI+
	1ONVlOEnU6qdcrNN/G7N0tyB2iDKENSR3/4TrbhuoI4Os2v1CqYkYu2HRAZDE5F7ss/JA+dZC5u
	esXnH82kOgvdJhzoowwrNL0UWPqYwLlvwWstSkScqI2Hb8ezRBRVFmQQVt63hKTXWg+Wf32f/m+
	rEFqscenDn/ioNbPF4VxkeFnnuYBPyTic
X-Google-Smtp-Source: AGHT+IGWQK39i39FWL4qHMCK2JcI2v7l2UTe5cu2Hfp1wmFQwUNAPDH21RFBHh1BoHV6V+GM7HwRsg==
X-Received: by 2002:a05:6808:1244:b0:437:eb1d:cdde with SMTP id 5614622812f47-43b8da33f47mr464232b6e.33.1757644520618;
        Thu, 11 Sep 2025 19:35:20 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b82aa7b97sm559913b6e.24.2025.09.11.19.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:35:19 -0700 (PDT)
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
Subject: [PATCH v3 0/7] Add PCIe support to Sophgo SG2042 SoC
Date: Fri, 12 Sep 2025 10:35:10 +0800
Message-Id: <cover.1757643388.git.unicorn_wang@outlook.com>
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

Note, regarding [2/7] of this patchset, this fix is introduced because
the pcie->ops pointer is not filled in SG2042 PCIe driver. This is not
a must-have parameter, if we use it w/o checking will cause a null
pointer access error during runtime.

Link: https://lore.kernel.org/linux-riscv/cover.1736923025.git.unicorn_wang@outlook.com/ [old-series]

Thanks,
Chen

---

Changes in v3:

  This patchset is based on v6.17-rc1.

  Fixed following issues for driver code based on feedbacks from Bjorn Helgaas,
  Mingcong Bai, thanks.

  - Fixed the issue when building the driver as a module. Define own pm_ops
    inside driver, don't use the ops defined in other built-in drivers.
  - Improve .remove() function to properly disable the host.

Changes in v2:

  This patchset is based on v6.17-rc1. You can simply review or test the
  patches at the link [2].

  Fixed following issues based on feedbacks from Rob Herring, Manivannan Sadhasivam,
  Bjorn Helgaas, ALOK TIWARI, thanks.

  - Driver binding:
    - Removed vendor-id/device-id from "required" property.
  - Improve drivers code:
    - Have separated pci_ops for the root bus and child buses.
    - Make the driver tristate and as a module.
    - Change the configuration name from PCIE_SG2042 to PCIE_SG2042_HOST.
    - Removed "Fixes" tag from commit [2/7], since this is not for an existing bug fix.
    - Other code cleanups and optimizations
  - DT:
    - Add PCIe support for SG2042 EVB boards.    

Changes in v1:

  The patch series is based on v6.17-rc1. You can simply review or test the
  patches at the link [1].

Link: https://lore.kernel.org/linux-riscv/cover.1756344464.git.unicorn_wang@outlook.com/ [1]
Link: https://lore.kernel.org/linux-riscv/cover.1757467895.git.unicorn_wang@outlook.com/ [2]

---

Chen Wang (7):
  dt-bindings: pci: Add Sophgo SG2042 PCIe host
  PCI: cadence: Check pcie-ops before using it
  PCI: sg2042: Add Sophgo SG2042 PCIe driver
  riscv: sophgo: dts: add PCIe controllers for SG2042
  riscv: sophgo: dts: enable PCIe for PioneerBox
  riscv: sophgo: dts: enable PCIe for SG2042_EVB_V1.X
  riscv: sophgo: dts: enable PCIe for SG2042_EVB_V2.0

 .../bindings/pci/sophgo,sg2042-pcie-host.yaml |  64 ++++++++
 arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts  |  12 ++
 arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts  |  12 ++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  12 ++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  88 +++++++++++
 drivers/pci/controller/cadence/Kconfig        |  10 ++
 drivers/pci/controller/cadence/Makefile       |   1 +
 .../controller/cadence/pcie-cadence-host.c    |   2 +-
 drivers/pci/controller/cadence/pcie-cadence.c |   4 +-
 drivers/pci/controller/cadence/pcie-cadence.h |   6 +-
 drivers/pci/controller/cadence/pcie-sg2042.c  | 138 ++++++++++++++++++
 11 files changed, 343 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
 create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.34.1


