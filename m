Return-Path: <linux-pci+bounces-19827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE80A11A5A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 08:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED1C3A8C29
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 07:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5E822FACE;
	Wed, 15 Jan 2025 07:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rfe7+HPs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4718D22E3E1;
	Wed, 15 Jan 2025 07:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924765; cv=none; b=p4kqeaB8xqDwr4kLLEQMgMUHqkxfIz+ZaEpTBLwnaiyycWVJ9NoNkAnA8wZwhpccoEejFry5hA5n0dwgag3yh60bfJ49YCvv6RfIlRYazl48eE5MbfkKGsyLcXLhK1Cd+8k3Li6D43Mwv+nXaOxMpXgWDMWPCzzLT/p1eMSpAe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924765; c=relaxed/simple;
	bh=pAGdabZkwYiFEeXRaPXEn8T+VPtNpxHNcGYYo35edqk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=kuIKN5pNuZbJL7LOd6BrkFwGMU76OuBTfDpl2FOMmRHJ6HV3va4T0wDdnAmTdbGRQlU3wM2GUhsxKCeJ55flDOY+xKHPCtAVPZXlk1X+8kfrqQ6TV6wX0xidtW4MmlXfGrJjapj1heACjstvR9MWtt4qKDZkaTLl7NIT/Vy5xfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rfe7+HPs; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3eba50d6da7so1585140b6e.2;
        Tue, 14 Jan 2025 23:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736924763; x=1737529563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oI5ZjcuPckd6Ch/6DIyVBb1ek8gxp9mfdlh3C8bbL+g=;
        b=Rfe7+HPs2SXJdzllKEv0i9kditr0LM8PZ57nK/hbBfSJjhdd++Vowe163OwyxU9bpr
         7vZ7l5Hy9iQvzVDbAKC9nt6aeMXPlf58VYOh9hR048xGzQJRrFixsc7VOtHTEgO72WU3
         8sfuif4WvZyhRA9Fnpv2uXfD4dNr0FbQcHO/lMmUN3tk7FpYVrUoYFVYHbiugVjLQApT
         jwzsTB8pFS8k88ptxmAqOLunb9n82EMNal8h884FDLJrZWPdGRoasvWGZ5Ss8Cd3aaWt
         x1/+lHjl/QWzJoZoHazTQU4UG0/26ILb/xn56zIMg9IPdXipywekf8jP8DQn41+87mBC
         pVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736924763; x=1737529563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oI5ZjcuPckd6Ch/6DIyVBb1ek8gxp9mfdlh3C8bbL+g=;
        b=qP0e3/QZBHSfs0TUNXtIXEqJ4wWvYbs3mTSYRRVvWe2HpjZE7dbu6Z3R5zALGCMAZg
         K3kdTxvi5Z5BOKZFKu1d2Qp8QgPBcGxpH+oPuvEi6T4/w9JWLYgrj1ngVouon0vVLQow
         SqfvLHIRCMmE6Dr264oL83Rj9jgs4wM1WM3ivXVoeWihywrLG4gcwmovCoz7W85o589d
         aAxy2bZLuCSGDz1DIInCH9g1BjGsNjX0+DbfvdbKhi6YsRxVhiI4QdyhoOpkFIPAlLaj
         OUArIyMQ8VzgbPuZwjOt/cWMrNrG+xcq7aqclsVMpa4D/ltEeynlIxgm5/zvdD8gKoJw
         wd+w==
X-Forwarded-Encrypted: i=1; AJvYcCWxqx1w/rQg216maaPQ5rQ4WE+ZssYEzHFl+Nzrun/zUcPkSDjypp6eLOIJOFNU/6ApxFxs6yl/0V9QNrUD@vger.kernel.org, AJvYcCX0Ay5V45dlLy3sls3DtBENRT5pAUMKjq0sUi8guHxgQj9eIr/1GCIZspLPnC3ELcClDgHQPkii/ssB@vger.kernel.org, AJvYcCX1FkuVEIf5SYwn/eqn//iONc4HmX0YMVmvqR0/1nhMQMs1Adu10ggdHuUIh9w1hlOzwinfSzgo54Z1@vger.kernel.org
X-Gm-Message-State: AOJu0YzU2ZZOOZU7MBJz12EMi8X1e75OvluwmIl3QxX2hvOo/SMfflnI
	yvMNmOqFbuV6zqPBURTLDiUPkyvCvT+J5nYCCeFDmKq3wbi3AjNF
X-Gm-Gg: ASbGncsRVm9BuT7brBugG0GoOG6OH6A3uX7u0LCUNmM+PJ8mIiTMsvXISX/0vmMsJoC
	lTNeRKUbePkmPsSFLlIHkr3k538uoVElHt5rUg2XXY8XNDU1COxYXmOc1BkPi5c7MsoXh7EmDtd
	oaktqmi6+iiUlw9ObRAVaQHfeJ5VcMsKf0XCGcjIvgJYK/rmx7/iVnai9HuOD34Mi2653GrPfIx
	npvlbi4eIY/8k5kFk+O0A0z4ACxZHjGe1Pw5gY6vRU2tRhqvaK3nbLEY2+DHDUayJM=
X-Google-Smtp-Source: AGHT+IFkR6nnCpwOXELoB6VRu3HqkfESX5AtlZc9JkL6/31ySuvemmaJeL/mLBsU0qBVg79TjKGu2w==
X-Received: by 2002:a05:6808:398c:b0:3ea:6149:d6fd with SMTP id 5614622812f47-3ef2ebb9028mr20514321b6e.2.1736924763079;
        Tue, 14 Jan 2025 23:06:03 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f0379eff52sm4779278b6e.40.2025.01.14.23.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:06:01 -0800 (PST)
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
Subject: [PATCH v3 0/5] Add PCIe support to Sophgo SG2042 SoC
Date: Wed, 15 Jan 2025 15:05:52 +0800
Message-Id: <cover.1736923025.git.unicorn_wang@outlook.com>
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

SG2042 PCIe controller supports two ways to report MSI:

Method A, the PICe controller implements an MSI interrupt controller
inside, and connect to PLIC upward through one interrupt line. Provides
memory-mapped msi address, and by programming the upper 32 bits of the
address to zero, it can be compatible with old pcie devices that only
support 32-bit msi address.

Method B, the PICe controller connects to PLIC upward through an
independent MSI controller "sophgo,sg2042-msi" on the SOC. The MSI
controller provides multiple(up to 32) interrupt sources to PLIC.
Compared with the first method, the advantage is that the interrupt
source is expanded, but because for SG2042, the msi address provided
by the MSI controller is fixed and only supports 64-bit address(> 2^32),
it is not compatible with old pcie devices that only support 32-bit
msi address.

This patchset depends on another patchset for the SG2042 MSI controller[msi].
If you want to have a test, you need to apply the corresponding patchset.

Link: https://lore.kernel.org/linux-riscv/cover.1736921549.git.unicorn_wang@outlook.com/ [msi]

Thanks,
Chen

---

Changes in v3:

  The patch series is based on v6.13-rc7.

  Fixed following issues as per comments from Rob Herring, Bjorn Helgaas, thanks.

  - Driver binding:
    - Fallback to still using "sophgo,link-id" instead of "sophgo,pcie-port",
      and improve the description of this property.
    - Some text improvements.
  - Improve driver code:
    - Removed CONFIG_SMP.
    - Removed checking of CONFIG_PCIE_CADENCE_HOST
    - Improved Kconfig to select some dependencies explicitly.
    - Some text improvements.

Changes in v2:

  The patch series is based on v6.13-rc2. You can simply review or test the
  patches at the link [2].

  Fixed following issues as per comments from Rob Herring, Bjorn Helgaas, thanks.

  - Improve driver binding description
    - Define a new embeded object property msi to replace the "sophgo,internal-msi".
    - Rename "sophgo,link-id" to "sophgo,pcie-port" as per suggestion from Bjorn,
      and add more explanaion for this property.
    - Use msi-parent.
  - Improve driver code:
    - Improve coding style.
    - Fix a bug and make sure num_applied_vecs updated with the max value.
    - Use the MSI parent model.
    - Remove .cpu_addr_fixup.
    - Reorder Kconfig menu item to keep them in alphabetical order by vendor.

Changes in v1:

  The patch series is based on v6.12-rc7. You can simply review or test the
  patches at the link [1].

Link: https://lore.kernel.org/linux-riscv/cover.1731303328.git.unicorn_wang@outlook.com/ [1]
Link: https://lore.kernel.org/linux-riscv/cover.1733726572.git.unicorn_wang@outlook.com/ [2]
---

Chen Wang (5):
  dt-bindings: pci: Add Sophgo SG2042 PCIe host
  PCI: sg2042: Add Sophgo SG2042 PCIe driver
  dt-bindings: mfd: syscon: Add sg2042 pcie ctrl compatible
  riscv: sophgo: dts: add pcie controllers for SG2042
  riscv: sophgo: dts: enable pcie for PioneerBox

 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../bindings/pci/sophgo,sg2042-pcie-host.yaml | 147 +++++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  12 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  89 +++
 drivers/pci/controller/cadence/Kconfig        |  13 +
 drivers/pci/controller/cadence/Makefile       |   1 +
 drivers/pci/controller/cadence/pcie-sg2042.c  | 528 ++++++++++++++++++
 7 files changed, 792 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
 create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c


base-commit: 5bc55a333a2f7316b58edc7573e8e893f7acb532
prerequisite-patch-id: d3c733a9ccc3fb4c62f145edcc692a0ca9484e53
prerequisite-patch-id: bd8d797ce40a6c2b460872eda31a7685ddba0d67
prerequisite-patch-id: f9b3c6061c52320f85ca4144e3d580fa6d0e54ef
-- 
2.34.1


