Return-Path: <linux-pci+bounces-28701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394DFAC8CBD
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 13:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BBA4E5AD8
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F5121FF45;
	Fri, 30 May 2025 11:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jWorY0ZH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7AA21D3D2
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603988; cv=none; b=jiTqTUwr1G3aYHXhVfovpwCNpxrz2KPsqzbtjm5anBvB4UGjl2Iyh5tstk7EpQQuK9+ZBDBzWusfpi5SKthxuW5kNBAdJoZQmos2ppqQkonFpt6mj5WMzPVswhbagH6gfRQCUMi1nJhYAgV46OrfgIu9eCYpEIFUSaUxmu+clZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603988; c=relaxed/simple;
	bh=63UqaY8eo1/+MF5TIlcrSnoAO41a1hgwgM6ht8qQvFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Om9ukwNfqln6yvLQjh5E77IwL9Tm6mmNeMvnjsnBJrzcWq5bRIIQEpsetNrh19+p6eDe7EHi6A10zno50jkNMjt5bYVc0egxPN8wjE9oz7K3NpYkWbQ9idJXAguIPQE0i8TRUbKAlw23mNIc3LZgXlybb4Y3TAcZEaUrAtzELMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jWorY0ZH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450cfb6a794so10536535e9.1
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 04:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748603984; x=1749208784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=USDzPWtwfClWp+wqP7p23s9TnEvWK9VkLl4tGpc0TUk=;
        b=jWorY0ZH/zS8Ls/jGVG9FKanOq/kN3EEFQ5Qf6XhS1aIsAXzecnH7jrfPVWv+QzHaS
         GVWPYEAEeTM3a6im1jZPzfJfCkDQbjFG/BIuESEa4WHCg1Q11mDhX35Zl9tyXR0aKM70
         zE9dWcYuPrMinVQqb4cWWoQIvstYJNZ+eKgFampZ0ZToRJi45TfaarCG3XneIAAbzEtu
         1YnkZvKUKxImO1PkU3QIU1LcSQDEW6gA97BypyLY1fUAtNQpKoxIE4sploUguyiNyuE8
         tuFIdbT41K56KKo+AzKGMIK6Nqw1sRiffd8sC1meEnOm6lH4LDWRl8UMWxlI0nfoWfxS
         4+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748603984; x=1749208784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USDzPWtwfClWp+wqP7p23s9TnEvWK9VkLl4tGpc0TUk=;
        b=aHar90HCZMSu09dwsS6wyuSb0164ziC0E2Z2uz21FOyQDZcheb0WlTzmBi6kNYtfnf
         7gwALuK5W20izrvbDIeZdpBcm/+loPD+UY9fLfCxV3a0kJtx94IjdVx1Et2Wq8oG0r7b
         4+yx23s61G0ciXP28YUvQxsJVMCLiyHbHt8J5Brh1mCvH5ggeTR2v0DLt7pxfmWn3eXB
         Xch2TUPziVTm2x+ktjWSKfgWr/7saEFU4nMfk7gGJmUm2UZAgjPjrvoQnaPwxPRvxbkR
         YCZFoOwaYg352uZEdunfGaq9sEyKVxEsXLh+iCa20VriGEK4A7mxWAc2kKhOHUxjmb7K
         Bjvg==
X-Forwarded-Encrypted: i=1; AJvYcCVWCzJeT8F0OdJVw3puek6JvqvR/1XvaV15A5zsdKNW9Z86EvovdPKwbDxhEYrSddaVF++8ffJUisc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx74YsARg+Hnj/j5GzQtMUxdUVpqRFx8cIrLJ7be/xysC02xYJL
	vDGWePenCI+n0AI3u0CybUq1PRKfUu982VnOhzf4q6sAJMQ4UoaRH+sZcdjcojBaqUc=
X-Gm-Gg: ASbGncte7EJqPftuCvDgP3sk/zH2g7Gl2OKk0eS5QPxNWQhDr7za1vo94eGfFgxJDMY
	Ny09VciMWljrfjc2GpUdTvpBs1lcw7bS5Q1mElfsWGBDjlKauQVZE+ihiFzDG39Vc3fGrWI6Kzy
	rB+7a3qIBk68ByGHMgsbfuORp5Mjq7RLYcbJ/AcDV101RtnLp+T7u+pvsD5BcH/dt4tdCYoDLq1
	JJw0lUjeOIquao0TkWbZoTrUHhzlA0bDbZpMfHq0HxiVg0p0cRRdAaLEXig3QHw6386Y0BJ24fl
	Fu2HKTRhseNU03hyqPV+yMQecauF8efW2aN1Kb0v0dVgZM/EJ3bH2ZcQ7Xi/JtqtSi0ujrBOWM6
	LUORxUQ==
X-Google-Smtp-Source: AGHT+IEbp0QcHOdy/Wep78m1G3gFrb9KOos/vWXOjVVBlX3y+lsRN5K2Os1MzG3FOYd4Bwb4BIL7Jw==
X-Received: by 2002:a05:600c:1c96:b0:450:d386:1afb with SMTP id 5b1f17b1804b1-450d64d63d1mr31026995e9.9.1748603983832;
        Fri, 30 May 2025 04:19:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450dc818f27sm3986435e9.18.2025.05.30.04.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 04:19:42 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	john.madieu.xa@bp.renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 0/8] PCI: rzg3s-host: Add PCIe driver for Renesas RZ/G3S SoC
Date: Fri, 30 May 2025 14:19:09 +0300
Message-ID: <20250530111917.1495023-1-claudiu.beznea.uj@bp.renesas.com>
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
- patch 1/8:		updates the max register offset for RZ/G3S SYSC;
			this is necessary as the PCIe need to setup the
			SYSC for proper functioning
- patch 2/8:		adds clock, reset and power domain support for
			the PCIe IP
- patches 3-4/8:	add PCIe support for the RZ/G3S SoC
- patches 5-8/8:	add device tree support and defconfig flag

Please provide your feedback.

Merge strategy, if any:
- patches 1-2,5-8/8 can go through the Renesas tree
- patches 3-4/8 can go through the PCI tree

Thank you,
Claudiu Beznea

Changes in v2:
- dropped "of/irq: Export of_irq_count()" as it is not needed anymore
  in this version
- added "arm64: dts: renesas: rzg3s-smarc-som: Update dma-ranges for PCIe"
  to reflect the board specific memory constraints
- addressed review comments
- updated patch "soc: renesas: rz-sysc: Add syscon/regmap support"
- per-patch changes are described in each individual patch

Claudiu Beznea (7):
  clk: renesas: r9a08g045: Add clocks, resets and power domain support
    for the PCIe
  dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add documentation for the
    PCIe IP on Renesas RZ/G3S
  PCI: rzg3s-host: Add Initial PCIe Host Driver for Renesas RZ/G3S SoC
  arm64: dts: renesas: r9a08g045s33: Add PCIe node
  arm64: dts: renesas: rzg3s-smarc-som: Update dma-ranges for PCIe
  arm64: dts: renesas: rzg3s-smarc: Enable PCIe
  arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC

John Madieu (1):
  soc: renesas: rz-sysc: Add syscon/regmap support

 .../pci/renesas,r9a08g045s33-pcie.yaml        |  202 ++
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi |   60 +
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |    5 +
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |   11 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/clk/renesas/r9a08g045-cpg.c           |   19 +
 drivers/pci/controller/Kconfig                |    7 +
 drivers/pci/controller/Makefile               |    1 +
 drivers/pci/controller/pcie-rzg3s-host.c      | 1686 +++++++++++++++++
 drivers/soc/renesas/Kconfig                   |    1 +
 drivers/soc/renesas/r9a08g045-sysc.c          |   10 +
 drivers/soc/renesas/r9a09g047-sys.c           |   10 +
 drivers/soc/renesas/r9a09g057-sys.c           |   10 +
 drivers/soc/renesas/rz-sysc.c                 |   17 +-
 drivers/soc/renesas/rz-sysc.h                 |    3 +
 16 files changed, 2050 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
 create mode 100644 drivers/pci/controller/pcie-rzg3s-host.c

-- 
2.43.0


