Return-Path: <linux-pci+bounces-35780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61500B50ABE
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 04:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F271346016D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 02:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E389A22FDFF;
	Wed, 10 Sep 2025 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjJvk7sF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868411F463C;
	Wed, 10 Sep 2025 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757470047; cv=none; b=B49UCUkR6vvW1f5G0Puw4C5RnqdKXIYxL2lHWBraWxYRVzM954t4DaKvVHJMTiKlE0t/GgyAkQoY8RuOjUb7RHdNoO2OVcn1pDWwA56HxG0HS0bE0FmgTih0O7YZpTxjr7uBemwl0rETQ5xecDHcOEMw8O6Hk2KeglrNby7x7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757470047; c=relaxed/simple;
	bh=Qjlsg5Y7usK9zBPXnwvbzpofibaz7RXIvBEDyIrNx6Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=E3pn1K/VVu/Cw/T6WVml4ndKnfOWBoKs9TY6JUCyZc5Pres2OYXmOv91wwzW35D+MFjqmQUnbr2k+mRqB63YUtODtdzihhUfwobe4DynCt1hyAKEgCH7y+BodNHCdGDzfnayy+g//L732d0Ex/EtNnKku6JH0rgvJ/+xg21qcmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjJvk7sF; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b5e88d9994so43642151cf.1;
        Tue, 09 Sep 2025 19:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757470044; x=1758074844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JupvMSKgb1rw1zIHQW+fGueHkoJ8uYm/8I5zPauDxTU=;
        b=UjJvk7sFrg2co2qP+xf8jiYO2E+FuC650YrD7dfpQhHSRh3rUTC+Fj9d2aw3MIin/C
         ny2aV1J/yaAZeKXJh3qgtYID4NL8kHYs5C4/pyUmbO+2vr/wRGkSZ8KLJk6Ovj1VDoPe
         s8PQekBuzL+jC5beM3RX1ubHvriKk0dsSMn7HxtQ3bfh2WJnxsKtPCCbR+Qs+nSDYy3y
         oI6cyEK6cN2MXqP0YaUlIwmBJsua8+t1eJZIH9a6ALnP6CsPX4k/MikQ3CtEjVnUvg3P
         1Z7FA+3y+3Hr45/eHNTpe6/OgEYh+04UBwCQr33StBPossv/ttQhzPMqJ/dZeNAYjgH/
         8pmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757470044; x=1758074844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JupvMSKgb1rw1zIHQW+fGueHkoJ8uYm/8I5zPauDxTU=;
        b=L8gg7W1935TQah1Pz6UvX+cqR/7coNdKzV0GC21iJXvG6YKRgUj8T23qNWdRpCq+2f
         bGArH0hr07gDih9ZesE2S/eFcDjD9d58JKq3zM7GJ7ew6AsifxSjmOU50U/jze+DIBY/
         MbmSCExw3jP4d1AEdUx9kLkci9770+bfuncDN6WOT/+XZ/xd75IBVoX8wGaKI/QAhPvb
         g7ZkHwoAccvJDcAFRY0xQbA/87NEyQxgMJzgAoleLFCXs/Fb2RK29ngylXIbKS7ScLg3
         ad1NX1vivIhw60OCJzoiWx8oCnr08D8zs0lgBH43iaf8yXPEp5en7qjX41UVDrWU6XGS
         MpzA==
X-Forwarded-Encrypted: i=1; AJvYcCVY+3F9kiYOt3ynoX5lKI116EUbefcIqgfkLZlozKbp5NJn66Rh1VV+YJ5xxz2zwXHr0CouxZJGW+gb4Csk@vger.kernel.org, AJvYcCX/E7U/8UwL8+uNykjlBu5OeF5ZXVbLNDIaaynDmke9Z/Hwx5TRgOglQrb0AfiKvZRNxIM7LYkn3tsF@vger.kernel.org, AJvYcCXxhcZzvTJTmndOPF2xpNDwMDXZcMhqFgt4VyfwkpZkC9pUIVqKJEqAZ2gi1lwOfR2oJyLNuCwZ8j7T@vger.kernel.org
X-Gm-Message-State: AOJu0YxwhVeuEmC1whWq82obPyMH+MFm3JIvaCSeNHv3pk/kfQQNnQyg
	yIvZNJG5g4qfqI9JWfnfl81tWXxjESP9OhF8/ztldURNdMx/XKICXxGM
X-Gm-Gg: ASbGncsKCuueZHdJdYQ8bv4Ls7mxRiudVg/Z4rn5Tj/0FtqtVM2+RKzbjRUENEyijf2
	MfTdhSIRvn5ejSzKMJYj2NGzF0m/KZTNV6QhOluM6HYwJryaZbmQYTcxfxFKyZiKvXfZPHuQ/MI
	wKn8bchRX3r882Eq2eXri1Uof4asGPAcVGSumz6euzbBdkYn6aQ0XU1GzD2DmPoHNouO/whR+z2
	DRqbB8ARmkop0ru/iuHMpEEoXQhd5tIDDgggdqsxHjoG/UUUgRP8u92tExqLRyKhXQIKayV/GRR
	M7C5ypWCHqAjaSGQe90+U7SU/oQhr7Dc8z6Ha9yvEp62s+oepgsBGrUu36wJj7pX6huMdfMfcpw
	NAhAvN54t3anrLdfTyrSCAy26h90V6rL6
X-Google-Smtp-Source: AGHT+IEjRNv9cyUm69QgMJCJnQnyhEp01tNG6SttjuPNziAGSPXCkaLL31LMoOKqtBh6Pvi3fZ7WJQ==
X-Received: by 2002:ac8:578d:0:b0:4b0:80c7:ba32 with SMTP id d75a77b69052e-4b5f843c29amr155667861cf.38.1757470044192;
        Tue, 09 Sep 2025 19:07:24 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b5ec7d5d1sm212773085a.48.2025.09.09.19.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:07:23 -0700 (PDT)
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
Subject: [PATCH v2 0/7] Add PCIe support to Sophgo SG2042 SoC
Date: Wed, 10 Sep 2025 10:07:11 +0800
Message-Id: <cover.1757467895.git.unicorn_wang@outlook.com>
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

Changes in v2:

  This patchset is based on v6.17-rc1.

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

---

Chen Wang (7):
  dt-bindings: pci: Add Sophgo SG2042 PCIe host
  PCI: cadence: Check pcie-ops before using it.
  PCI: sg2042: Add Sophgo SG2042 PCIe driver
  riscv: sophgo: dts: add PCIe controllers for SG2042
  riscv: sophgo: dts: enable PCIe for PioneerBox
  riscv: sophgo: dts: enable PCIe for SG2042_EVB_V1.X
  riscv: sophgo: dts: enable PCIe for SG2042_EVB_V2.0

 .../bindings/pci/sophgo,sg2042-pcie-host.yaml |  64 +++++++++++
 arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts  |  12 ++
 arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts  |  12 ++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  12 ++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  88 +++++++++++++++
 drivers/pci/controller/cadence/Kconfig        |  10 ++
 drivers/pci/controller/cadence/Makefile       |   1 +
 .../controller/cadence/pcie-cadence-host.c    |   2 +-
 drivers/pci/controller/cadence/pcie-cadence.c |   4 +-
 drivers/pci/controller/cadence/pcie-cadence.h |   6 +-
 drivers/pci/controller/cadence/pcie-sg2042.c  | 104 ++++++++++++++++++
 11 files changed, 309 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
 create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.34.1


