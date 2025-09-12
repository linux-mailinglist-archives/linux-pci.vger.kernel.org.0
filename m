Return-Path: <linux-pci+bounces-36011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BAEB54D9E
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 14:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D804846C0
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 12:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BF8305E2D;
	Fri, 12 Sep 2025 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LYXxq3oC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF7C305046
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679893; cv=none; b=X7ICqe3yECWklfjwo2n7OmxbNcMhA/PZKE895LEN2kqCa3Sqy6/KGVrnZprU1wpuB38XTH7msm/V1eH7rndsPNeHg9e2gwc9u2JqrA32585uz/RcSatHDJCUD3+G32wIyq9DFEsMxWQVpn8qQaBBbrCSGPXngntMKjfPbQAFns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679893; c=relaxed/simple;
	bh=1X+it+zTAdvHtkVDC9ptPSL7qX6EXCsJqZ3em9dxcto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ovkYlhs5pRdkRqpWhCzmxfNCLjnEPc9inxyNiqiUPcnwxcMivPOMcalgRvyBwqdyTXu6Awlmji/u63T+rOUQ7UuxNZDmAg1g3ecWngQxA2SBDrroa9x4Rpur5//TQUHAxbCLtfsO5RTchK2NiWW09LwMkhoNMfzlCShhknNiD5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LYXxq3oC; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso1457954f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 05:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757679889; x=1758284689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ljjbIvIvj2Q1tUtMUPNsqGBDwVAciETje0nuBmAVX84=;
        b=LYXxq3oC0dEWpu9X74BmLte1MieUYonva1ud5qIXeCaQhUbbMMdy0y5Do5AxXSQfLR
         i9fvviVaY225e5Q5DzhdIrdq57neIT45rAcATb/DxvPa3KETSmsbQ4ZSrgvmQYAoEDVV
         fNeLLQ5c7C4MVcf4uxU6KvAuyTZOZvXJ3fwZDy8kaMXZNCEgjskZ+hAeRC47b43W7y3C
         XBcwZ3NiKCO3VeMmIFAk8er1UiMKxXSVQs36rt4ls7tT7RvWq8eG1Lt5SLIp7/hIbcm+
         rHDDvoO5SDezZS7OLAloLt3eaMwh/xOCTgqcyJMtvyyCx+UbL2gsELIo065We11pQQJL
         uZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757679889; x=1758284689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ljjbIvIvj2Q1tUtMUPNsqGBDwVAciETje0nuBmAVX84=;
        b=mCOwgps/z6U1/5qCpCUPVcw33W/f0n+/h48AcIbFjKd30Koxz1XQI7kdytuGX9VQd0
         tA0wnHIDt+fzkZOL2Q1XonH+fb9uDJbElBaRfA5s0Tml9P+kzfMNV8CK5K995d0UBWgv
         0t3NMp13Cuf9iqh7wfGBd2Gchln2xQhib0rQiLSkVegI0TjBU+SSMmkijMAMumNydp/C
         d83Tx4MStwvdUdBWYuWgyMY1DnX6Upn2iyTJdpsE6vbXJ313KzckzCi/05qYpRiL1XiC
         MMSC0El8aM/7palNrE/JYvCDT9d40h/pRMs+ElRkPzZxsu0yTG4rvJGcTflOoThiVL1B
         N0LQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+32MiDYtuwPumTafXpTsLE6CzfBhi4yHF0mfoYUETSmF18zs34gzA6lhJKHmFfqpx4DYFj2bkZ+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT5hcl+SGmNeHFIdtp91VHSdCWZeu47nAuO9mRQTwQSyHTYhN8
	nWJ1ce7rFyoYgruoxA01nmQOYhdyC8MO/crJ6FPL4bED/NXi+HecttwZ2qY0YklKNrk=
X-Gm-Gg: ASbGncvm+wVh3jo1VGF68wp9QqHqOkHWE94zpPgdcM3Ffre3dD3zbBo0vJEhkEz6Uhd
	p4Bcd6AskkqZ0BJHiSnpnUk52Ddz2MWIBU1PBUrvsxlVA22c+3iv3NI3A8WuRHGvdOb3wfU/LnX
	EE2uTT+d53okKFkXLnrRPGk3BkiMkFRdR8c+HmMcd9Vc7p5wH0wF/rLvvOWKkSkHKHyhCg4rkqA
	e7K6nyOS5rm3hobuivsCYgT8Yb6AEFEfmXkQpjfOnqHezyUmqEs80Mn+W0krTbcItbbIXL0HKWa
	v1aqH6oJMihadBmK5ca6EE1JM4FfwL9F74uxZVqj7zBeTLS0c9zUoBlYmANy2gXuQpxLocG4luz
	OoBwB9naMcaOaBQKiMHO4a0F8nYdBEHdph0Opzo4SkIlpqla8Avg4
X-Google-Smtp-Source: AGHT+IEYppUYO/8aAZsKn0b0DcJjcfxTnMO/idgXekJXbeD6ctIiByRvNUh0evCMuK6Sg67U0omW4A==
X-Received: by 2002:a05:6000:2086:b0:3e0:152a:87a9 with SMTP id ffacd0b85a97d-3e7659e20bemr2983464f8f.28.1757679889474;
        Fri, 12 Sep 2025 05:24:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607770c2sm6320091f8f.8.2025.09.12.05.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:24:49 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 0/6] PCI: rzg3s-host: Add PCIe driver for Renesas RZ/G3S SoC
Date: Fri, 12 Sep 2025 15:24:38 +0300
Message-ID: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds a PCIe driver for the Renesas RZ/G3S SoC.
It is split as follows:
- patches 1-2/6:	add PCIe support for the RZ/G3S SoC
- patches 3-6/6:	add device tree support and defconfig flag

Please provide your feedback.

Merge strategy, if any:
- patches 1-2/6 can go through the PCI tree
- patches 3-6/6 can go through the Renesas tree

Thank you,
Claudiu Beznea

Changes in v4:
- dropped v3 patches:
  - "clk: renesas: r9a08g045: Add clocks and resets support for PCIe"
  - "soc: renesas: rz-sysc: Add syscon/regmap support"
  as they are already integrated
- dropped v3 patch "PCI: of_property: Restore the arguments of the
  next level parent" as it is not needed anymore in this version due
  port being added in device tree
- addressed review comments
- per-patch changes are described in each individual patch

Changes in v3:
- added patch "PCI: of_property: Restore the arguments of the next level parent"
  to fix the legacy interrupt request
- addressed review comments
- per-patch changes are described in each individual patch

Changes in v2:
- dropped "of/irq: Export of_irq_count()" as it is not needed anymore
  in this version
- added "arm64: dts: renesas: rzg3s-smarc-som: Update dma-ranges for PCIe"
  to reflect the board specific memory constraints
- addressed review comments
- updated patch "soc: renesas: rz-sysc: Add syscon/regmap support"
- per-patch changes are described in each individual patch


Claudiu Beznea (6):
  dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add documentation for the
    PCIe IP on Renesas RZ/G3S
  PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver
  arm64: dts: renesas: r9a08g045: Add PCIe node
  arm64: dts: renesas: rzg3s-smarc-som: Update dma-ranges for PCIe
  arm64: dts: renesas: rzg3s-smarc: Enable PCIe
  arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  |  240 +++
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |   66 +
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   10 +
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |   11 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/pci/controller/Kconfig                |    8 +
 drivers/pci/controller/Makefile               |    1 +
 drivers/pci/controller/pcie-rzg3s-host.c      | 1792 +++++++++++++++++
 9 files changed, 2137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
 create mode 100644 drivers/pci/controller/pcie-rzg3s-host.c

-- 
2.43.0


