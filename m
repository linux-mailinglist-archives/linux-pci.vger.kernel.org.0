Return-Path: <linux-pci+bounces-40724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DECF6C485B5
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 18:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3C4188AC2C
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 17:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4912D949A;
	Mon, 10 Nov 2025 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uK9+db3+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32E12D780C
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762796021; cv=none; b=jpreJYDLj1Lvs5UncR42OXvcymRnNFrhpUHAe1kUaD0hVSUNp01oqklOWsvGU5jjU4xM+67LvvDTfCocbuZjw1J2tdAzajJQ/z5tPEFZhb9U5i3TDTUYFXu+X4XfOs9tg9tVq+vfpJe+hTPs3eN6DjgrYrXDcb1AUc4Xym54++8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762796021; c=relaxed/simple;
	bh=Nkg2h47lxF2qO8Gx0H85hCwngK8s040aUkwhgf7L8jU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tSrExcRtdG22r11PWGp4qUM5EoXDa6EfE1Qjrfe4Oi33VQpC5c9CuQ959HFyDtMuewjsCIgiMacUFMDEIJ7CK6MIqioSSnW/1q7kqecPjECNGViDQNuK7cHVQzxkMiic91ieRdEhNYzcw9n3Q7tHVEATHuwQz+78tn3WMHpbZz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uK9+db3+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so25745045e9.3
        for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 09:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762796016; x=1763400816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OF8+BNFL4niPqRVyKe1lX6yisr96vvFu6A5/iDrFJwc=;
        b=uK9+db3+8THbUlbUReIsYBoQ3BdxkXSWhD5Nql/QI576QsecCrz8XxJUwE8k4H5FOZ
         BRA/A8MWfmPfvhJ5ijF8IjtS7lGibOntwhlOJjN2pOXoUtoL/og47UMw0xmeeXbKNY6G
         CYIPNLL4qC3xCEYqlxAVKfLm762WPpi4TZf7Sy3QkGR5RaTNwuHNoGe2FGL3Dyyxj27R
         ITQE+Ivq124SpREu1B7RvQxNVKvQl9RBPOXkTHp+QC0RqVPSmqUy9qJ9vDokZ2B8CSyC
         PwTrwX0KlPAU5Br2qnMGk9VKGCTZbyzHT0dk9L05E0U8dlc9vZ+8utQ/t4OeT/nAEA/x
         peag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762796016; x=1763400816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OF8+BNFL4niPqRVyKe1lX6yisr96vvFu6A5/iDrFJwc=;
        b=DO2FD3EjtSw9KupmB7rx3fiR1nQ3ffh6ySWUcy88oj3GfigvkUpcLhcTEIa9Kkaqh8
         ciXJ86O7Z6p44CxBq+ubWf7hRPADuwCQ9mA1JUO/TuL+LfSdzkGcM25RdX5z1NZ0tR/d
         mlMZYUGQbyYyqLxyZmy8o/VkHM1d04CC07YJnrwZHRZR0sGHeDCy6yr0l+DdTJ3n2XLG
         SIDbjb49KfoBSgRMu2MiMgxfYC8egOA9F4PkTBJ0qQxkZBgovOAya0ch1Wqsxlaxy8dp
         DGV8B0Mxm01Qxzr1BogAy0Jtpv/hVaGNdQrBCCAa6PV0RRFNNPa+NUPpBU83qt+ic2Vz
         gMpw==
X-Forwarded-Encrypted: i=1; AJvYcCXPR6bS+Rgc72aQT6kXqej1hicWaHsI53hx08erglmwXrhFzKHFCu3fvM30ypBDkb2tR78ZSJtqtq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDIDKDa3fgesyixfN1kE6jCM9hN8u7MBOes2c5qvk76qV38LCX
	tjRy+Pv9JdgS21vVT6P+lrQSiMzCTj7+rowGQcPVdcflV/50SEatcaE7hksuJJzBtIc=
X-Gm-Gg: ASbGncvkkuL5RJAQqT/xiqFMP3RtSfB5Oq4u7Y6YuSB9t+NOPJ734GvWAy5aq2wFj0g
	wHGgc/XW/lPhrTre26rCq9OqLT+X6DZA04UsTytHWgS1yVgDn6Nntuv0cL4owxiCglaAgEIeL0m
	pnDo5af+rOjQ4ANhLFC36utAd18KyLs9vSS7qoYBo1XtCG186mYf74pVczNEC+nY2xD1hqedP+/
	8VLZ1R4IVNN0TEPrguhQzuXujCONIRygxI0RGjT9Yj5NJnSivNmGmwFVzZOEadud6MkfjGMdQzf
	BbShN4ojvcP/a9xex26QvBkEESimRV0kgL+2zgsYDEKFppMhtEXxk5rpCN2qwDspSMS0ifdgS0a
	kXRLGf9zGzFjKRvYvZSxwAr+i62H+T7jgvuu/VG5tn7EjsNNs2nCL+htII7so1XxyXKw+fJ2oN6
	YAjBsRhc1K
X-Google-Smtp-Source: AGHT+IFsBQQnkCxj/ZdeAOfnyhkqLUTn/qNT58RuOTuk9hbm4fBeIAtaCNjX2ecmWX+ye2/aVLU4cA==
X-Received: by 2002:a05:600c:3493:b0:475:f16b:bcbf with SMTP id 5b1f17b1804b1-47773237269mr64531415e9.14.1762796015765;
        Mon, 10 Nov 2025 09:33:35 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:d5ec:666a:8d59:87fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47774df2d80sm140111375e9.14.2025.11.10.09.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 09:33:35 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	s32@nxp.com,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Ionut.Vicovan@nxp.com,
	larisa.grigore@nxp.com,
	ciprianmarian.costea@nxp.com,
	bogdan.hamciuc@nxp.com,
	Frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Cc: cassel@kernel.org
Subject: [PATCH 0/4 v4] PCI: s32g: Add support for PCIe controller
Date: Mon, 10 Nov 2025 18:33:30 +0100
Message-ID: <20251110173334.234303-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S32G SoC family has 2 PCIe controllers based on Designware IP.

Add the support for Host mode.

Change since v3:

- Added Root Port node and reorder irq in binding
- Added Root Port management in driver 
- Fix Kconfig PCIE_NXP_S32G position
- Use default pme_turn_off method
- Use ops->init() to simplify init and suspend/resume sequence
- Fix some typos.
- Removed MPS and ERROR config. Let core code configs them.
- Removed s32g_pcie_disable_equalization() from internal team request
- Removed dw_pcie_link_up() from suspend/resume functions with [1]

- I'm still waiting feedback from internal team before removing
.get_ltssm() and .link_up() functions.

[1] https://lore.kernel.org/all/20251107044319.8356-1-manivannan.sadhasivam@oss.qualcomm.com/

Change since v2:

- More cleanup on DT binding to comply with schemas/pci/snps,dw-pcie.yaml
- Added new reg and bit fields in pcie-designware.h 
- Rename Kconfig PCIE_NXP_S32G and files to use pcie-nxp-s32g prefix
- Prefixed s32G registers with PCIE_S32G_ and use generic regs otherwise
- Use memblock_start_of_DRAM to set coherency boundary and add comments
- Fixed suspend/resume sequence by adding missing pme_turn_off function
- Added .probe_type = PROBE_PREFER_ASYNCHRONOUS to speedup probe
- Added pm_runtime_no_callbacks() as device doesn't have runtime ops
- Use writel/readl in ctrl function instead of dw_pcie_write/read
- Move Maintainer section in a dedicated entry

Change since v1:

- Cleanup DT binding
  - Removed useless description and fixed typo, naming and indentation.
  - Removed nxp,phy-mode binding until we agreed on a generic binding.
    Default (crnss) mode is used for now. Generic binding wil be discussed
    in a separate patch.
  - Removed max-link-speed and num-lanes which are coming from
    snps,dw-pcie-common.yaml. They are needed only if to restrict from the
    the default hw config.
  - Added unevaluatedProperties: false
  - Keep Phys in host node until dw support Root Port node.

- Removed nxp-s32g-pcie-phy-submode.h until there is a generic clock and
  spectrum binding.

- Rename files to start with pcie-s32g instead of pci-s32g

- Cleanup pcie-s32-reg.h and use dw_pcie_find_capability()

- cleanup and rename in s32g-pcie.c in addtion to remove useless check or
  duplicate code.

- dw_pcie_suspend/resume_noirq() doesn't woork, need to set child device
  to reach lowest state.

- Added L: imx@lists.linux.dev in MAINTAINERS


Vincent Guittot (4):
  dt-bindings: PCI: s32g: Add NXP PCIe controller
  PCI: dw: Add more registers and bitfield definition
  PCI: s32g: Add initial PCIe support (RC)
  MAINTAINERS: Add MAINTAINER for NXP S32G PCIe driver

 .../bindings/pci/nxp,s32g-pcie.yaml           | 130 ++++++
 MAINTAINERS                                   |   9 +
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-designware.h  |   8 +
 .../pci/controller/dwc/pcie-nxp-s32g-regs.h   |  27 ++
 drivers/pci/controller/dwc/pcie-nxp-s32g.c    | 435 ++++++++++++++++++
 7 files changed, 620 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/nxp,s32g-pcie.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g-regs.h
 create mode 100644 drivers/pci/controller/dwc/pcie-nxp-s32g.c

-- 
2.43.0


