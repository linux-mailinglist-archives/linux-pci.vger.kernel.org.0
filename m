Return-Path: <linux-pci+bounces-5255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A920988E35A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 14:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96747B27ADB
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 13:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C731802A1;
	Wed, 27 Mar 2024 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol+I2iv0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F417F399;
	Wed, 27 Mar 2024 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542302; cv=none; b=N7DCacQ9UYu0YqMVzor5EBrRyWMXP80GAVtguWRql+LJ49znSN3QujhHIsDnAcHlD2gKhmCZIkDHLkukB2ZfYayfmmd/gpyIrM1zcrSuQBupMj89/1/MfSilcyDwkfDZuYLacG89MPKuaTqbu21jvy528J+XmfaziI5bShwQ4O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542302; c=relaxed/simple;
	bh=nfNNpFSFPqJ1Ehbsb1fl0Q/VVJfGQElQungtP6fuOkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g0p4by77ForjJaydYi8ZmroQDd9jJq45zHWBGa4KNMFa84/k68bKPyiMs9K6ZYyjj2W/JGRKJQlZersWpyFyhpyq5CtB9hYFJ/X8FIAzZ3+uaG/PObKHObALtEM2xR7FlemzaS9LX9/X/UNuC1rl1KhGbjUdXeaoU+IhYP3Dvi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol+I2iv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D34C43394;
	Wed, 27 Mar 2024 12:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542302;
	bh=nfNNpFSFPqJ1Ehbsb1fl0Q/VVJfGQElQungtP6fuOkk=;
	h=From:To:Cc:Subject:Date:From;
	b=ol+I2iv0lr7+a9a1r1NdynkdAVbEbq7v2cv7OunAma3r2E1a8ptexTRNghr4VqKBW
	 6coUILJNG+8O+uHYWFEzPJFOqGEu3Gz87kBkoGmvXL1o1qd00atBohVXL0b+lQPd8w
	 uVn/sNtRQCbME8jFS4544mJ8YTDfupv/Thj3nJ78xowKH1LsRapilfzw3oz2ZiZ730
	 eyDiIaEqTzs8svfa0E3P2VTJDQscIbcYzCSLP+DRt2YSuM68R++AxnfFpynR9GnISa
	 spJ1laf9VkqX4pm5fFB3Uj9kGlpWi+1nLnSfq2MQyLiJ7FDCc2YSXilkYQvANcW7Z/
	 Odq8suEHEYayg==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Jamie Gibbons <jamie.gibbons@microchip.com>,
	Valentina Fernandez <valentina.fernandezalanis@microchip.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v1 0/5] BeagleV Fire support
Date: Wed, 27 Mar 2024 12:24:35 +0000
Message-ID: <20240327-parkway-dodgy-f0fe1fa20892@spud>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2296; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=RI2m5bHQsW0uJCHnU/tjkVOqc52vi6o5eCDYaLCFLpw=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGksAqydJlvmL/rdPvF5qY6d1bHNnT/6FuZX9rq6Zp5/P +1AQurHjlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExEUZbhn9rSW5dYTA+mmFx7 mSIiMum2am/pgt+e95okjE5ffn8tnY/hr1ACk/aj0pt7n37zyt0kenqbtXTPx0vbtmZP8c402LK 8jgEA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Yo,

Wee series adding support for the BeagleV Fire. I've had a dts sitting
locally for this for over a year for testing Auto Update and I meant to
submit something to mainline once the board got announced publicly, but
only got around to that now.

The PCI controller has to stay disabled for now, the driver (and
binding) made an assumption about which of the two root port "instances"
would be used by Linux and the BeagleV Fire uses the other one. I've got
a WIP patch for that in the works and a patchset for the GPIO controller
that I have been trying to find some time to clean up and submit.

Thanks,
Conor.

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Jamie Gibbons <jamie.gibbons@microchip.com>
CC: Valentina Fernandez <valentina.fernandezalanis@microchip.com>
CC: Linus Walleij <linus.walleij@linaro.org>
CC: Bartosz Golaszewski <brgl@bgdev.pl>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: "Krzysztof Wilczyński" <kw@linux.com>
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-riscv@lists.infradead.org
CC: linux-gpio@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-pci@vger.kernel.org

Conor Dooley (2):
  dt-bindings: riscv: microchip: document beaglev-fire
  riscv: dts: microchip: add an initial devicetree for the BeagleV Fire

Jamie Gibbons (2):
  dt-bindings: gpio: mpfs: add coreGPIO support
  dt-bindings: gpio: mpfs: allow gpio-line-names

Valentina Fernandez (1):
  dt-bindings: PCI: microchip: increase number of items in ranges
    property

 .../bindings/gpio/microchip,mpfs-gpio.yaml    |  17 +-
 .../bindings/pci/microchip,pcie-host.yaml     |   3 +-
 .../devicetree/bindings/riscv/microchip.yaml  |   1 +
 arch/riscv/boot/dts/microchip/Makefile        |   1 +
 .../microchip/mpfs-beaglev-fire-fabric.dtsi   | 124 ++++++++++
 .../boot/dts/microchip/mpfs-beaglev-fire.dts  | 223 ++++++++++++++++++
 6 files changed, 365 insertions(+), 4 deletions(-)
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-beaglev-fire-fabric.dtsi
 create mode 100644 arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts

-- 
2.43.0


