Return-Path: <linux-pci+bounces-33975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1018B25334
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 20:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3755A72E3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 18:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853CA28D828;
	Wed, 13 Aug 2025 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="HrriX0Ew"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7DF187332
	for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2025 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110830; cv=none; b=rHaippm47zB3qlqRHKwF3/p12OL5xCsZ3cNczHCYjnx1O/Gs9t7VKm5cLUXuhtXjspfOtrhclQw9LzaYj2BzrqrlFStXS3JUHSwj4D4EeeIkNm64NNSHat6EqsGG/UEOjCpIY4WK0oRoudb/eTc3OHzXPPNF0pc4AXM/OZ7Jsjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110830; c=relaxed/simple;
	bh=rRD7cCEqQsfqIWRQE+8gNwUvzHsQOHHZ6SWAdO9fsqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AWvkn4WcaeECVyfi5/hOqKogn57kTPCs78r836WYMm/OdNh/E9Xf11/uJ/XbdlTl3Xk4C9DB2zQossdHpvKLjc6jqG5TpRgBkssCL2CL6cnO4/sxw5hOR2nFcPvZ0jTukTTsIt5hRGWdHj1ZyCI4W0u4rDATlZGHOG3703/q99c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=HrriX0Ew; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e56ffccadaso1555825ab.1
        for <linux-pci@vger.kernel.org>; Wed, 13 Aug 2025 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755110827; x=1755715627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KXgtHtogm5A4R/WnbeHN7aFUW9InK5mQEbz2x1R9n64=;
        b=HrriX0EwMBuR7YynIrA9SQ7aXVro+2jK0n8n8KXDMC5HGZB4R5DAbT5Hia/lx8L8hh
         xYKY2KklD6JYpmJ4ktrbm+i31dHHoenscdBHYqlYeKhVQAMGWSSccgr2sGGHlVn8rKOu
         w39OFDZXn29IJB6dH7MXg2WFwOlWFDX4RpRbTuVDFXLFL+pzKosPQEhvXYsgk1m7ENkC
         RwKyGaLsjJ4eEWRme5rtMLo16KxZEF+JaqjOtkxyYQuFhucSFRB3m0KZnpnusgUXub+K
         lKsNqa4cwGDGdhGnQOHktCETMTSmXgFFORAtZFnQ0mrNU7vDuuxmjXZt2Jstlm/zjmxk
         zznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755110827; x=1755715627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXgtHtogm5A4R/WnbeHN7aFUW9InK5mQEbz2x1R9n64=;
        b=RHMnSqeDHwD+qWf9dKD4OLQod3FcngFFj5rlLgBdlfOvQfN9v8O+qmS6nn6cJqEybQ
         okO+FWUMCVjMvpgmKLWtnnq+4cfRdI84q94eplU4srpVeHr8qdUn5OlG7x/pHkrUvr28
         buIIaa+pFTqwQ1pxuu7pqgsY2i+gTD5/I6QLTI0+y2ZcvjsRV6Ay1rClw1KeaLuYunvG
         S0dtFyG5UEafK7suzdpACBoVUno30+WpdFN3MGhxhUNI0pM7FHGieh6gDyBI/Gzm+p0c
         vPpJZtE0XNqOrWv9jLUvN+TkSlDTKP1mhw4xfGhzyjc8yrr9JYICWrXEsGESMNBwhJE1
         piaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq07VzORex0GmfLdCOBeSUJoLAEL9adhg9EJ5Ggvd00ZG1vng/pW3CvRRXXOyc931A483E2zC7meI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVe6hmZtfTyDEAK0UOi72FUe8YAnO02ZEUl3GyygMOPTu7o5DB
	4sb0c4VBv0sZBQ5sS4bsybc5a+OZ5a8AQIhw3ol0TSllH0jmICbJ7SoMJY5OmwE35Rw=
X-Gm-Gg: ASbGncsFPGZCdLsCl4lu/aUcc6vFWTyVn9F2x+i1iSiyQHabJwTL9fbaL9g7H7bYHPX
	pgLritFNcujIHGeNBT9i9SttusFIHgBd5GXacuKPXg2Ong4QrBk6sBf0eHjbabeMj2PIHqV2GDF
	/VuPj8Fe7rEAOI8tEp0K7djDXiPner1iC7jlJhGojMlzlp+K7owSr9PeB6bx8sYjbe5x/Fb6g8Y
	j4Y9zv3EdL55QiMRMV65GwsCzZew8lWizcbvRCTDbcF9kvMnQLlPMMknNzH6Q/Xa7XWsP+AW+eG
	kO3zEvOc0/JLIFWVxMkQYLynnPALlZk+Mr7o+HP6JinNP0L4efHTYhc7yFiZV7c/0q7eHzbSZvH
	62r5e2e3s+zKMvgtxJoctaFR4EopUzUOIkVVxM32a5P6/BbLBfr0OJ6pvIDnqo7lPEw==
X-Google-Smtp-Source: AGHT+IE4C3i9M8kXUz9O4UxOKjpcYn8lEZvQJ6gg/sXkMzZkGV6K8yFbp3z2/m0TNzRFI95fCD98Hg==
X-Received: by 2002:a92:cd8f:0:b0:3e5:4002:e822 with SMTP id e9e14a558f8ab-3e57091642dmr4986915ab.12.1755110826731;
        Wed, 13 Aug 2025 11:47:06 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9bd89d7sm3933104173.59.2025.08.13.11.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 11:47:06 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	bhelgaas@google.com,
	vkoul@kernel.org,
	kishon@kernel.org
Cc: dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	tglx@linutronix.de,
	johan+linaro@kernel.org,
	thippeswamy.havalige@amd.com,
	namcao@linutronix.de,
	mayank.rana@oss.qualcomm.com,
	shradha.t@samsung.com,
	inochiama@gmail.com,
	quic_schintav@quicinc.com,
	fan.ni@samsung.com,
	devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pci@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] Introduce SpacemiT K1 PCIe phy and host controller
Date: Wed, 13 Aug 2025 13:46:54 -0500
Message-ID: <20250813184701.2444372-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a PHY driver and a PCIe driver to support PCIe
on the SpacemiT K1 SoC.  The PCIe implementation is derived from a
Synopsys DesignWare PCIe IP.  The PHY driver supports one combination
PCIe/USB PHY as well as two PCIe-only PHYs.  The combo PHY port uses
one PCIe lane, and the other two ports each have two lanes.  All PCIe
ports operate at 5 GT/second.

The PCIe PHYs must be configured using a value that can only be
determined using the combo PHY, operating in PCIe mode.  To allow
that PHY to be used for USB, the calibration step is performed by
the PHY driver automatically at probe time.  Once this step is done,
the PHY can be used for either PCIe or USB.

					-Alex

Alex Elder (6):
  dt-bindings: phy: spacemit: add SpacemiT PCIe/combo PHY
  dt-bindings: phy: spacemit: introduce PCIe PHY
  dt-bindings: phy: spacemit: introduce PCIe root complex
  phy: spacemit: introduce PCIe/combo PHY
  PCI: spacemit: introduce SpacemiT PCIe host driver
  riscv: dts: spacemit: PCIe and PHY-related updates

 .../bindings/pci/spacemit,k1-pcie-rc.yaml     | 141 ++++
 .../bindings/phy/spacemit,k1-combo-phy.yaml   | 110 +++
 .../bindings/phy/spacemit,k1-pcie-phy.yaml    |  49 ++
 .../boot/dts/spacemit/k1-bananapi-f3.dts      |  28 +
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |  33 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 169 +++++
 drivers/pci/controller/dwc/Kconfig            |  10 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-k1.c          | 355 ++++++++++
 drivers/phy/Kconfig                           |  11 +
 drivers/phy/Makefile                          |   1 +
 drivers/phy/phy-spacemit-k1-pcie.c            | 639 ++++++++++++++++++
 12 files changed, 1547 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-rc.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-combo-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-k1.c
 create mode 100644 drivers/phy/phy-spacemit-k1-pcie.c


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.48.1


