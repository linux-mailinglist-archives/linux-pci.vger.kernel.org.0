Return-Path: <linux-pci+bounces-17900-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E0A9E8BFF
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 08:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A08281B82
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 07:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CB7214A93;
	Mon,  9 Dec 2024 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiWQyFb/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C1214A77;
	Mon,  9 Dec 2024 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728770; cv=none; b=lTUf5bdG4YtrhAuUC7W85aC/25VOmLZIxYTAdBrw4naw3tw7KHkOEKLn8WeQdnnNyes3Ij0OFHInO+g+hFXeT/lRyhThFNxnNcQ05i1EcmvtMa0LR3qEbhqcCXczx5N+W7oy/08o6OVrtfERROAegi1s7U6n0qb9ddqsP4Htlzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728770; c=relaxed/simple;
	bh=UOc7E/fqi0ELmBt7Zgueeprf/PLKnMS5KHRUPqups58=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=LZMS/7Q3L/tFnwnDro1fRvSG6r8UbocIzJGxedTZluXwPFYR4dFik00tAfgtuuDhBO29i5mN2UrTMtyfCWTyOqCnNoe/Vnmh0xnOJ8G1+vilo1/MQyh91Jb0IleVS/NZ0/nJXT3rTkM3a2+3RuHeUWRgNDyy2D7YK5RPWjZ0eJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiWQyFb/; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-29fe83208a4so22382fac.0;
        Sun, 08 Dec 2024 23:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733728767; x=1734333567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=57haV1hL4VOUvIZiseouq+09JE1910goYy3qPq1Xmko=;
        b=TiWQyFb/ELgyW9HToxLgmkFqrVvGnHJGOICwZmn5H+o0PJzLZtCf/zezadZDJZU3sj
         ghU5QunlVf2uTUvhYl1D03piy7OMSkOpU8H7Tvf/COVuaLYtbk4k0N5ROOkGJpkbkaW1
         umi5unL1J/AAYFfXQgJXf3ZVigzleUB8gWrz4A0RO1A/TK2lhrqYmkBp+ydT3Uva8aI5
         oFAsKlEH1JrDdMIiYERmz2vqQsaBYvSjpTIN1mfLNPeVoMdisJoA0gp6fvIwlk9Yj8T5
         LmjU+gNsrE1swTu33pfr+Hc4TA1y9MrnpHcmVSYjqsvhNfJyaOw/O9x29U/Xv2iQTF2M
         VX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733728767; x=1734333567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57haV1hL4VOUvIZiseouq+09JE1910goYy3qPq1Xmko=;
        b=ORk4l+XEWQDPjtkVP4Fycq3gHlxofNf2nQn0k/F2hJZDw2ZEo7n3sa2NZxk6Ou97ya
         ivxU6JH8IRnMwIPPL7lz8RKxY7JsNZRO7YEk+kgW0WX8lxji22IB1oE/OPioU9K46C2y
         +yXfP9mzGeoHmU4pDRxWsSctgUnHUQoZAc/290lNBI8sqOc1gCgV1ykMruuMufCOo/ha
         /+mTLfmdS4iuPrtFS5nOasFaYc5g4M1+uyw5Hd9hjtmMPHFRJK8OASLupSeyDkh/kESa
         AEIJqzzAhaprwjTpAvrkl3Ol58IONXXwqarO7VuB+9EAqc2tROs4iEQo9dWG77ADAset
         tMDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKXMoQCnPwz6eVqwF8AYflR3vChXnr3b5T2n8DZqm9t1fOgwFy8iEUtbjSnv5A/y+acMV8qOSTLein@vger.kernel.org, AJvYcCWXxZOu6O5cDJgCwOw2VL1g0DJ/wYJYoS03UXtKDjj5lwcwDiRvSVS/qbR2Z7aKRW+vb00cM/DT9JTK@vger.kernel.org, AJvYcCX1ewf12ylETm891BGjqrdjdAzeEqG5KlAo3cXbzpisMsFmoNHsaAQ2nC9evAoyIky5Y3e1GbCsOfdYYZxF@vger.kernel.org
X-Gm-Message-State: AOJu0YxkODEnBjyYJ34YW5oKSQDadEdvXw3dVatAOtrmRPUQ1qX0GCrd
	CFLg0tj8Stg4J4G/gIc1yx4jv5Dlun53qKhCo2zMITiQ6KO2fSQL
X-Gm-Gg: ASbGncu0CSE8mbrrW/Vfftr0Sv9KwCntesS+tEdWSHuSH7ofCMegduRC9TNBSZ7LFeu
	phBvgK4YnFQon7DS+PzW9cdAm8Gc30y8VfA+j9qsqXxz8w+qAIEBNBtvQivnzbGt6Hg04Xc6Q8M
	VQb2lHVm5AHqmSLc0eIeHAHybYH02wVVpRGxBpsdrCC2+6q6h+5iDdZATKbDeKwpuGST/ByuJY5
	pihUffJeMUT3j3vz5LPE1VtUMvKUBNjA126hgLTszDhLvusS29FJtxl/9cN
X-Google-Smtp-Source: AGHT+IHAxPFhGdfgb685u348vhj4CVicXrWXrCLtKPo9QFaUPAstgj+S9PSpclTwWeED/WDNIQpYrA==
X-Received: by 2002:a05:6870:1cc:b0:29e:2bd6:2265 with SMTP id 586e51a60fabf-29f71b643c4mr6950283fac.7.1733728767595;
        Sun, 08 Dec 2024 23:19:27 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f566e5666sm2487711fac.18.2024.12.08.23.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:19:27 -0800 (PST)
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
Subject: [PATCH v2 0/5] Add PCIe support to Sophgo SG2042 SoC
Date: Mon,  9 Dec 2024 15:19:18 +0800
Message-Id: <cover.1733726572.git.unicorn_wang@outlook.com>
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
If you need to test the DTS part, you need to apply the corresponding
patchset.

Link: https://lore.kernel.org/linux-riscv/cover.1733726057.git.unicorn_wang@outlook.com/ [msi]

Thanks,
Chen

---

Changes in v2:
  The patch series is based on v6.13-rc2.

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
---

Chen Wang (5):
  dt-bindings: pci: Add Sophgo SG2042 PCIe host
  PCI: sg2042: Add Sophgo SG2042 PCIe driver
  dt-bindings: mfd: syscon: Add sg2042 pcie ctrl compatible
  riscv: sophgo: dts: add pcie controllers for SG2042
  riscv: sophgo: dts: enable pcie for PioneerBox

 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../bindings/pci/sophgo,sg2042-pcie-host.yaml | 141 +++++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  12 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  89 +++
 drivers/pci/controller/cadence/Kconfig        |  11 +
 drivers/pci/controller/cadence/Makefile       |   1 +
 drivers/pci/controller/cadence/pcie-sg2042.c  | 534 ++++++++++++++++++
 7 files changed, 790 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
 create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c


base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
-- 
2.34.1


