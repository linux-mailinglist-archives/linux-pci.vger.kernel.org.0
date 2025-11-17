Return-Path: <linux-pci+bounces-41366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C25BC63138
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 10:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 833A94F0B1B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 09:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6529F325705;
	Mon, 17 Nov 2025 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="SLGtMSjM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC573246F4
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370567; cv=none; b=FTJ23h6p76rUHZFdt5Wadar/M+PMhxm7dbuu4Mcp76dL0FkGWu1e8jURbelRFk7OiJ0kIvzxyAo6h4fT8D+jcobdPCS2eBt2iaKoEtSWyViaczjrwtJrJl4DRVfXMpEKItNvIt257OCRKk7Fyt0qB8gjAx/A7Qv4NWOUQEWPhv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370567; c=relaxed/simple;
	bh=BWhHBdSxNz6oDAcjcPmXRnYsv7TcjfVh5EqxArjkTbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=niUB4/5YTkvjd6Py+orZFkk0dROwTH3zybjDii9gpHrn76zoBU9B509/uNvTw7IyfOhrhZWingundXE6HQSWKxav8a2lmYu1INZQevb7o6G0I8fzGtA8isfYAY5EK+lNKWlH+fweKAcYluZ7/mxvt6BzTD7gb4SrT4qx5jOMXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=SLGtMSjM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429c48e05aeso2384411f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 01:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763370563; x=1763975363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WZZz0I/gR7q+VNKt5uK6BwuR0bSvglAaLrUPN3x53lk=;
        b=SLGtMSjMTD/CPyo4j4L6GNFs9o6IgfQsvTJvtRgsY8pLJmzTHbf8S4dYVvCLmTU2oe
         kHYW/FuN9neXqZ86LTn73kcA1RrTy+Tzhz3RPWnsgq4xkqhTQb0gNd3VXyT7TlQsL7MQ
         PappdWY0w+ZThjg+6eBAyGACfRlOhYgelfOJj2Lieet5BOO75WHK52hVJlv0f06MXA3p
         MvRTm+uWI2YiVSad7dFQ0Q9G3EtFGrORtMTQPdkddib+9Qac8xaMG3Vvs1nibDxhVPqO
         +5yTQ3HiKsq4y85ISTfJFjCDAVAThiH+ouxK3g+HsRJZr4zrSeSzpGpR0SQtFjKgajfa
         H10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763370563; x=1763975363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZZz0I/gR7q+VNKt5uK6BwuR0bSvglAaLrUPN3x53lk=;
        b=rVOt09ym/DsV65mVs0oiZMMvpJWy9NQwTcGlBW9VtAg8YS8rye5uTxVEHt8bPVIVIl
         3wzN7Tg+SVt/sJFj6kcy0k/h/VdO6NqA7OwtD4cbvYZJS07+OkehAIt7trBln/6aEgpw
         pwK/Ia5YhNKUkFVVoo8d2Wuih0pI7o8+YUwrQoAMYMLNvCmQlAIft0zjDwbyXdBUUoQS
         VS4U6d9ojR52Qd+Gj+vFyfqvNJEw/T/0WBqh1D9vIVmwfirO2KJAbjTpYcCKKgGuTian
         +mEdA8IOhS0IoUoHjEsBBAdYRutN/jIm7Ig387BXD5wnOC2nc315GhdFJzehDd8/bhqM
         i63g==
X-Forwarded-Encrypted: i=1; AJvYcCUlZHqw666VCGhA6A9wnvQPLO++bZNGIFOIEcd4baQyb7a4nYi057tBximdfZ1QId9gzLsZPj/PqXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5DU+U972eftmH674Q0upGspApReG3C2xV7CJObJ6GA3piRdQp
	VTLeLqZWisApyZ0kF+xePMmWwMX5IAjmvjSLsyEsZ5VlFmLdVhIm2WXrLLr0BQlZYyE=
X-Gm-Gg: ASbGncteZp53bdG/CE1U5I9SSMtM1Dq0OmnS+sgegktGCh/QkcUbYcaAEDG8TFDGYjX
	AwV/c7LDnu2IMH3fAH2gWXCXgqLU+0cy0NwZT7bH9PKFC7jZzLEgbo8AF56Dwy5fi+TzSjGbFxm
	+sfXpBLM+wlvCJYhV5xMT0B7XpVMxcAoC6oz+/I+I3heXRPxPiuWTe9sEu+gAMGtLuAYP2KGtWU
	Iq9Jfn+kHuM2EXQOgGnlxJltKGNtkTEBgAsimljrrjSwjhkdQz+KJfa9em34O79QnjLHLcnr+2k
	k5T83SNUYUFmeYxNZh4ghtvFIFqj43nCPPXmTE5qAFRLvBDC0YGsfxWDbdRQvt35j8J4owFajtO
	z0erh3oLuY7wucJrYac9vhSDSOPPtPdMmujszzp/He5KbRdT2w5zoqYAlEYls9pOAKXQsNRTnur
	KwmgYDf0G34vSgYnyRE6snYhVissSp26kkmw3r5/mk
X-Google-Smtp-Source: AGHT+IEIBx/MJXLPmtiUtaCQqQNNcaMsC6k5IcBO/zokIfM+93/0OcmXFRypivkMANfjtqihN5iboA==
X-Received: by 2002:a05:6000:2911:b0:429:cc35:7032 with SMTP id ffacd0b85a97d-42b52821778mr15878783f8f.23.1763370562981;
        Mon, 17 Nov 2025 01:09:22 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b894sm25703786f8f.26.2025.11.17.01.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 01:09:22 -0800 (PST)
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
Subject: [PATCH v7 0/6] PCI: rzg3s-host: Add PCIe driver for Renesas RZ/G3S SoC
Date: Mon, 17 Nov 2025 11:08:52 +0200
Message-ID: <20251117090859.3840888-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v7:
- rebased on top of v6.18-rc1

Changes in v6:
- addressed review comments on DT bindings and driver code
- per-patch changes are described in each individual patch

Changes in v5:
- dropped patch
  "arm64: dts: renesas: rzg3s-smarc-som: Update dma-ranges for PCIe"
  and introduced patch
  "arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock"
- addressed review comments
- per-patch changes are described in each individual patch

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
  dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add Renesas RZ/G3S
  PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver
  arm64: dts: renesas: r9a08g045: Add PCIe node
  arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
  arm64: dts: renesas: rzg3s-smarc: Enable PCIe
  arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  |  249 +++
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |   65 +
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |    5 +
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |   11 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/pci/controller/Kconfig                |    9 +
 drivers/pci/controller/Makefile               |    1 +
 drivers/pci/controller/pcie-rzg3s-host.c      | 1759 +++++++++++++++++
 9 files changed, 2108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
 create mode 100644 drivers/pci/controller/pcie-rzg3s-host.c

-- 
2.43.0


