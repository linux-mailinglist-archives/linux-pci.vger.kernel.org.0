Return-Path: <linux-pci+bounces-16418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5077D9C3816
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 06:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084511F21D2B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 05:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC37146D7F;
	Mon, 11 Nov 2024 05:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WR9h4wNn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B3118E1F;
	Mon, 11 Nov 2024 05:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731304770; cv=none; b=qRUGJlMyEb5nMR13Ar4esbCzgDqYPj60PH+/VsqNwXW+SsB0qbBHriRukosiJZ3qetJ9Y2icE7Nk/fLA3nZL071VeHrswTT7BAzhiVTwA4884QNpVGs/UMUyMOCCA7ngaCU2Ek+AiynBDjD8+FeyxvA1ZkR5Vm5xJhT3nIo55gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731304770; c=relaxed/simple;
	bh=j2SNyl1g5cRizpqO+Mu3H/8wRQvmj+CRMvJzcCV9goA=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=RIFM6pOblWl99AhAF1VGS9RmRmeFiRdI6gla/+4hj6FfY8ZP1dIEPPTykIeMulOTM+wIBxSgl1xBR3QZyC9i+cpEWGx35OniephSZ/8LTFeo33jAvYdn/7gbzxOEn7GfFHG9YtZihKxxlvi8yUP6rkVbgKKUdlpsWIIDoc98vNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WR9h4wNn; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-718066adb47so2470759a34.0;
        Sun, 10 Nov 2024 21:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731304768; x=1731909568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSEc6Dywfy2yzj6E+ULeDFzZ//XDuzEbifzyz4badc4=;
        b=WR9h4wNn4KbNcXIps4aX3n8ThAtmWW3bPhzY9sFuJ5wRoqQQ6dgCgzzCQg1W1fs4u8
         jJ4jA4GKFU621AFWHXxo/Y7TQpz93igovOd4jPBmPE746Yy/Go07Q21uRBKwm06ZflWa
         0sldpmG8BIdK366lkicD+/z4r/MRnTLvZchr5GRsPxT63m+8CvJOfAVP5aRYOvcK0R0o
         fHmKP4sG197OjvxFWz+IjdTwEDDZl0qEFQKG6iBAPoEVeeA/EdAfQFzDJ56pRBGjbpwF
         nONf+zsa2FTw51mv9GepJhYqIf/nWDDraJUkgmELLkrhKc3hdagp0xMymgTocv4UHgKz
         yT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731304768; x=1731909568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSEc6Dywfy2yzj6E+ULeDFzZ//XDuzEbifzyz4badc4=;
        b=FOOvckIox8JVvziA0j4VlPrchpy+aMIRVxlUc45CgTbVWFq6jMK9Q7ixONGcVHiQPG
         UMf6P/Baa2BXBcl6DgebkuXOPcdmZ7zHrMp2QvEyme6gu+Wtj6oRstBWQwL+0xjfjN64
         LbJ5OLA0yDDEDjrnMUQosLU+blTdtrUwRHZlZvOxX8H6G9oejZ6gmJmSj8zLn4JXbCUQ
         bryB9nh9YgqGe4Kq1SgVTup5wON6y/bO8F2jPQq/MNYRypvwJp0ZEqMln/Vfs7g+R29z
         AegwKGQVhKu18ZatkImdXDcAqYkhBMUve7tkqVmkXtRceFWiuQrV+0Vzom/HmledCq7W
         e7zQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3CL6XhZ40Ik+zN6mgfdh+qcCfytoeRffjehZ4oL72W+NQw6ouaDseUccvuGdW9m9YTzOhOIE3Hyv3CAoo@vger.kernel.org, AJvYcCXBSWAy3OSRzlrkZxOegh5Ujsb/dgABLTkO9jUkzyGyCZK5Cc5dgh18jsaI98andHfL3Jl8om73n6Bi@vger.kernel.org, AJvYcCXtRo0C/qT4uJi6LQ6eAy0kQC+Mqg17x8Em6OfrwdI8v2wvqzGL/LmvAgExCa0VKKOATA3tEbPH/voa@vger.kernel.org
X-Gm-Message-State: AOJu0YwMe3MAo34xvYqe5+25pWPn0m9wYNnXJ9Inat0UWePp6pHv17jS
	tBj0VPRpyjMDbPo677dYmaWk+5NzG0GQMAhJuYmu072b+kylfAHB
X-Google-Smtp-Source: AGHT+IF4wa34kPK0D2j4YiwZgM0PWB0bX/gx1QEPBQEvPCwAAOOwKKwE2xLSY6u7rz/iBj7/3S5myQ==
X-Received: by 2002:a05:6830:6c10:b0:710:f3cb:5b9d with SMTP id 46e09a7af769-71a1c298638mr9014021a34.24.1731304767775;
        Sun, 10 Nov 2024 21:59:27 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a107ebea1sm2125534a34.14.2024.11.10.21.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 21:59:26 -0800 (PST)
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
Subject: [PATCH 0/5] Add PCIe support to Sophgo SG2042 SoC
Date: Mon, 11 Nov 2024 13:59:17 +0800
Message-Id: <cover.1731303328.git.unicorn_wang@outlook.com>
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

Link: https://lore.kernel.org/linux-riscv/cover.1731296803.git.unicorn_wang@outlook.com/ [msi]

Thanks,
Chen

Chen Wang (5):
  dt-bindings: pci: Add Sophgo SG2042 PCIe host
  PCI: sg2042: Add Sophgo SG2042 PCIe driver
  dt-bindings: mfd: syscon: Add sg2042 pcie ctrl compatible
  riscv: sophgo: dts: add pcie controllers for SG2042
  riscv: sophgo: dts: enable pcie for PioneerBox

 .../devicetree/bindings/mfd/syscon.yaml       |   2 +
 .../bindings/pci/sophgo,sg2042-pcie-host.yaml |  88 +++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  |  12 +
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |  82 +++
 drivers/pci/controller/cadence/Kconfig        |  11 +
 drivers/pci/controller/cadence/Makefile       |   1 +
 drivers/pci/controller/cadence/pcie-sg2042.c  | 611 ++++++++++++++++++
 7 files changed, 807 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
 create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c


base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
-- 
2.34.1


