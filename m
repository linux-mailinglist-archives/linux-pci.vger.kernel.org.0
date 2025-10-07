Return-Path: <linux-pci+bounces-37666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DACBC183C
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 15:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5048F3AEE64
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 13:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2DC2E11D7;
	Tue,  7 Oct 2025 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IvZ4/5jh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F1C2E03EF
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844240; cv=none; b=LwwHWnuGggawTosrWx2MrCKUPkRPbWdP9GwvfLPXphSbElcTp9t60YCI8aT9TwcXrd7H5PgrrwQ3cm6y6aLI4qTZtFZ74UW9FtmRwLjM3Q2U5Hxq7Lx3n/SNwTy27REPcnTqkEMEclq80xNFzFee1y/QQYcrzB6eWSD3+ktl+pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844240; c=relaxed/simple;
	bh=7SALpk0Qg9EKYms34wSViHkTxM7EmL7IzVmGRLoW08A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gz0q67aPkQMQLmEbqF1y9AaSC/16TXHpJcOFNVycl/OG93apCrgpzY62sYvGUr3nvsdkL0wtYGTDlf484ZFxIc27IBpp+2KPUp+gmsnmMmznOBdywEz1EgD2PtWwyTidcFiDMxBJZCp1qwggU6KpF8/UDjxiwbMGNNVTb7obIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IvZ4/5jh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e61ebddd6so58729615e9.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 06:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759844235; x=1760449035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+oLo4NRxdhyJnVkge2ge/4TyfDf6EUTmkIrZI6xQJjE=;
        b=IvZ4/5jhf873lZ/Qz0KlX4g71At10N02/BH6vOK9I+gFpr4WXo1CvapSPTOhmJV7by
         RgiARMihQVjq34R33w2JxqQyTTjYjt2Ng0XbQeKmywlZcNjUb9WqAVZl84+ZSS62e8Mt
         XGfACnjcD4VnD59RVKSO7T3m5nbroFNbVi1Cr0x3t/YymGmEkDUJUDsXtScjF/gSQzkc
         gTB3WgnbRE4eG7HrZRoDE9qLlhAt7NNpIEyV837EZ86VQSI+FYH1BrYHZKvfskIVUvBc
         Emy3bHLVA09wowpC7cVj4z/3ZRq7YzePJsor+C/s1fParUU2tPXPb9cikUzAAXJ2V2ql
         SPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844235; x=1760449035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+oLo4NRxdhyJnVkge2ge/4TyfDf6EUTmkIrZI6xQJjE=;
        b=tDHlDTAsrGyxUfgOtA2nHU7a9e/n0YNNVGkExO1SIwaRNdDcaQ8rQnO4WTRne0pEtb
         DVblXvrxXQoorG3TlqeUFHXQtK84UMIbu3g5lIrQCt88jfSlXA0fxPCKTAZVeGgGlZi/
         qYhSy82i/ppZo4mBd0gDidXwlay2/yvwzF8OCJbJIX/Ca/5BAkEaqPNZAT+1QF7ItsUw
         njgzLCEUjH/WLmp+uk0WFG8e9WEDRt32oFUlmarlv93rhjrlaOhjiSzLxatzhgEfy40G
         x5IF2mxO2thUtLsx08PA+o2TgVFjTNhGRGVkMVVYCFGuB2kYLSa9LzrMqvU2neh8YAvO
         tdWw==
X-Forwarded-Encrypted: i=1; AJvYcCWX9NsJkqbNwBtsN4xdNfH7ADWTdJ96qypKPaJZ8b0NdDfUsb1xUtM5fOf3wDk5LwRUAyHTwRVZO+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXZpeaoOl5d2pD1IeG9MjtGoTQ7NC3tJET1E7aTw6cXbkEMKyt
	SaUhUgKF57OkOdoyvc5wxpMgeyzK2ge3+GfyBwxcRz2R6pXQ58QObwNU3Jxptd3/buA=
X-Gm-Gg: ASbGncuAydS3kAqTE9FUSf5trZBDD7lSTNMvsC4tdD9NTe+GEQIGpSxXRwtllXZFie/
	uzSPAUJqQ3tNbCdLXLmRhnUKfSzuopW+YKK2+dgPIF/NXOAPezIX2Z3LN4EMzhQwghPwoZy6Ckx
	51NbYkVQ+BZDVa9IaHX/ZVmualqOzYw9t7Kw1PJKNCOQRSBU7uepCgC3PBljmdCq1l+wp6LojNP
	LMCSksL8ayJD1WbLBGAC1MzScdv3XR3RiVOZvXxQqsCHU+tAoAeCazaZCtO4+SGfTkK7A54W4nh
	V3pzZr0uAdagnCgfTc6x87McFJFsKHDfAciRBNTHMTqfSmIfsGAQTXFEtvb/yXntQ+EA5EzzmUC
	cwtubX61FDQPHXRA7c9afkUeutmYsO9xs
X-Google-Smtp-Source: AGHT+IF6p2nCrjyvWnpj802nNvH0Zjgjiu1IWG2oPrRGEeNafpoQbYtAv+tL2yWvCYnX0Nj/3v/vCA==
X-Received: by 2002:a05:600c:c4aa:b0:46e:4cd3:7d6e with SMTP id 5b1f17b1804b1-46e7110498dmr124129495e9.9.1759844235126;
        Tue, 07 Oct 2025 06:37:15 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e674b6591sm272189625e9.4.2025.10.07.06.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:37:14 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
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
Subject: [PATCH v5 0/6] PCI: rzg3s-host: Add PCIe driver for Renesas RZ/G3S SoC
Date: Tue,  7 Oct 2025 16:36:51 +0300
Message-ID: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
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
  dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add documentation for the
    PCIe IP on Renesas RZ/G3S
  PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver
  arm64: dts: renesas: r9a08g045: Add PCIe node
  arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
  arm64: dts: renesas: rzg3s-smarc: Enable PCIe
  arm64: defconfig: Enable PCIe for the Renesas RZ/G3S SoC

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  |  239 +++
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |   66 +
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |    5 +
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |   11 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/pci/controller/Kconfig                |    8 +
 drivers/pci/controller/Makefile               |    1 +
 drivers/pci/controller/pcie-rzg3s-host.c      | 1776 +++++++++++++++++
 9 files changed, 2115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
 create mode 100644 drivers/pci/controller/pcie-rzg3s-host.c

-- 
2.43.0


