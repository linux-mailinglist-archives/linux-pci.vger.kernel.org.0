Return-Path: <linux-pci+bounces-13949-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C48D4992BE9
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 14:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D27EB22908
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 12:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4811D1E65;
	Mon,  7 Oct 2024 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BuePtxqu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EAF1D1F5B
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304790; cv=none; b=Xv+DBAPMz6cWbCizaoS/Oeb+L4T1yLReGadA4pAjcgzvGpLJGdwrJ1nRuquY1o5JUAp065YWfhPp70JGKjlS+qwuw7lQ9HssMWAB0gGK2sgmBdDxnnbmu4ARoNangzrfl2Jqb5m0Jg4X4rnMVv3HpoPhQTS+3H8DyN4DaRNgkjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304790; c=relaxed/simple;
	bh=y7Bb0wWrjHCxSTFw/kUaPQGsiGsC/4MSWE57/p0qYns=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=NRSh4WEwkqGZTEcZX/BitAWtW2jq6LRCdEf5tcmfAlA9dlllxGHAZL/4U60vSDP2A0fZcq6Ho9RngTN+xwuQDtGy1myPrxq4th5SsTZr0r4V8/q45cOnRoUbNaI0qA4za7GDj9bjRSifrWq9oyaVhEz4E6Rt9Et40XnsZHua1gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BuePtxqu; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-539885dd4bcso5306195e87.0
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2024 05:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728304786; x=1728909586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=klOzmE0LBk0ONLxfUggcJ+UZZugeY7pk5FGjqWj2uqU=;
        b=BuePtxqupgbGy7IX+xAdES8687LfMGM4CA0Wo7ec4lacOFtPOq0aeUVDjtRUR2lXI7
         v/UNbGRpURFx6FPYkqMUZy08rTt6Ol3vik+15n0rwbTMYJvI6RLIHxE3BCiZxoWS+3/W
         HP0fROw5CGu5bPACZbv819pSoELWEPL7uarKxlVsFPHiq3K2qUCT9hEd6vWvrSF42Y1P
         iaXIedFhs9KXjTsBQgn8WYvsZEarRoPHzSp0e1dJQBnKThLSH+0e9/UbNp4eX1cwgyTc
         9/lsvSNbrLXel2VyNdGbyhpJ7NS08IyhoZdZwc3UOB0sJlpQVSPdE241DLANwUsVUDKA
         AUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728304786; x=1728909586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=klOzmE0LBk0ONLxfUggcJ+UZZugeY7pk5FGjqWj2uqU=;
        b=AzapbxfGbufU+M2etu8k65qXM4vMq/cRAjIIJQj0U/4epfP7/dMvjxTuwBQWdXG71g
         2rIdfd0EwHU6f48AUQpAKgr9aJo0sRWUsFEYDV24nnj1hzsllcq+2QpC7MVUrtGFiPms
         T673LHTXkMhnx8RqwsckQdc09JzYGJpjaVSw/MgCQilYpoRxy8DyTFP/Vc0v6v7rwJ9r
         kmkX/bCPQd6atvqfgCIM2N+GNcRC0g2zP8Bf5/o4fCNwtaBcbq4m6OafFYzr13csVkyK
         PkAdZh5OISz6G8eLm1Niggi2B7qjmo1Ez1gvP5JUBQ0tL2C6dZos+BVlPziD1QsxjqsB
         Jg7g==
X-Forwarded-Encrypted: i=1; AJvYcCVmQqcNj4fTE1aSu464g9lMj+413L7JGQaMFeIVXMwSX6HQireYlep6tM2lVvnFDRmQIwnh104bxJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0w3vQ5F06KzJeCf1Oh2GVBJRRlB9qxLnEtPVtfhI7jfiVAtH3
	Gtl4kgbuJil2seyuz3Vu8Nkljvl4/GbJZuN/2wrk8hLTvxUyGqzkfwYIlOF/cis=
X-Google-Smtp-Source: AGHT+IGGfBGBDFkxOzpiPI73XR7SuQgT8GTl6+c3ivCl//N6I1dEBrL/lmLeTmv3yTyVKYqeggooeA==
X-Received: by 2002:a05:6512:33d0:b0:539:a3eb:d000 with SMTP id 2adb3069b0e04-539ab9e16b8mr5477968e87.42.1728304785491;
        Mon, 07 Oct 2024 05:39:45 -0700 (PDT)
Received: from localhost (host-87-21-212-62.retail.telecomitalia.it. [87.21.212.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e806adcsm375324066b.221.2024.10.07.05.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:39:45 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 00/14] Add support for RaspberryPi RP1 PCI device using a DT overlay
Date: Mon,  7 Oct 2024 14:39:43 +0200
Message-ID: <cover.1728300189.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RP1 is an MFD chipset that acts as a south-bridge PCIe endpoint sporting
a pletora of subdevices (i.e.  Ethernet, USB host controller, I2C, PWM,
etc.) whose registers are all reachable starting from an offset from the
BAR address.  The main point here is that while the RP1 as an endpoint
itself is discoverable via usual PCI enumeraiton, the devices it contains
are not discoverable and must be declared e.g. via the devicetree.

This patchset is an attempt to provide a minimum infrastructure to allow
the RP1 chipset to be discovered and perpherals it contains to be added
from a devictree overlay loaded during RP1 PCI endpoint enumeration.
Followup patches should add support for the several peripherals contained
in RP1.

This work is based upon dowstream drivers code and the proposal from RH
et al. (see [1] and [2]). A similar approach is also pursued in [3].

The patches are ordered as follows:

-PATCHES 1 to 4: add binding schemas for clock, gpio and RP1 peripherals.
 They are needed to support the other peripherals, e.g. the ethernet mac
 depends on a clock generated by RP1 and the phy is reset though the
 on-board gpio controller.

-PATCHES 5, 6 and 7: preparatory patches that fix the address mapping
 translation (especially wrt dma-ranges) and export gpio line naming
 function.

-PATCH 8 and 9: add clock and gpio device drivers.

-PATCH 10: the devicetree overlay describing the RP1 chipset. Please
 note that this patch should be taken by the same maintainer that will
 also take patch 11, since txeieh dtso is compiled in as binary blob and is
 closely coupled to the driver.

-PATCH 11: this is the main patch to support RP1 chipset and peripherals
 enabling through dtb overlay. The dtso since is intimately coupled with
 the driver and will be linked in as binary blob in the driver obj.
 The real dtso is in devicetree folder while the dtso in driver folder is
 just a placeholder to include the real dtso.
 In this way it is possible to check the dtso against dt-bindings.
 The reason why drivers/misc has been selected as containing folder
 for this driver can be seen in [6], [7] and [8].

-PATCH 12: add the external clock node (used by RP1) to the main dts.

-PATCH 13: the dtso that can be loaded from userspace to change the gpio
 line names.

-PATCH 14: add the relevant kernel CONFIG_ options to defconfig.

This patchset is also a first attempt to be more agnostic wrt hardware
description standards such as OF devicetree and ACPI, where 'agnostic'
means "using DT in coexistence with ACPI", as been already promoted
by e.g. AL (see [4]). Although there's currently no evidence it will also
run out of the box on purely ACPI system, it is a first step towards
that direction.

Please note that albeit this patchset has no prerequisites in order to
be applied cleanly, it still depends on Stanimir's WIP patchset for BCM2712
PCIe controller (see [5]) in order to work at runtime.

Many thanks,
Andrea della Porta

Link:
- [1]: https://lpc.events/event/17/contributions/1421/attachments/1337/2680/LPC2023%20Non-discoverable%20devices%20in%20PCI.pdf
- [2]: https://lore.kernel.org/lkml/20230419231155.GA899497-robh@kernel.org/t/
- [3]: https://lore.kernel.org/all/20240808154658.247873-1-herve.codina@bootlin.com/#t
- [4]: https://lore.kernel.org/all/73e05c77-6d53-4aae-95ac-415456ff0ae4@lunn.ch/
- [5]: https://lore.kernel.org/all/20240626104544.14233-1-svarbanov@suse.de/
- [6]: https://lore.kernel.org/all/20240612140208.GC1504919@google.com/
- [7]: https://lore.kernel.org/all/83f7fa09-d0e6-4f36-a27d-cee08979be2a@app.fastmail.com/
- [8]: https://lore.kernel.org/all/2024081356-mutable-everyday-6f9d@gregkh/

CHANGES IN V2:

NEW ADDITIONS ------------------------------------------------
- Two new yaml schemas, a common one to be included by device bindings
  representing MFD devices exposed through PCI BARs and a device
  specific one customized for RP1 chipset.

- Added dtso file containing the gpio-line-names for RP1 gpio controller.
  The resulting dtbo can be loaded from userspace through configfs.

- Added preparatory patch that exports gpiochip_set_names() symbol, this
  is required to rename the gpio line from the driver.


MISCELLANEA ---------------------------------------
- Added newly created files to MAINTAINERS.

- Dropped the patch dealing with DTBO section placement, since now we have:
  https://lore.kernel.org/all/20240923075704.3567313-1-masahiroy@kernel.org/
  which should now be a prerequisite.

- Renamed "bar-bus" to "pci-ep-bus" wherever applicable, for consistency with
  Bootlin's Microchip patchset.

- Dropped testing patches for macb ethernet.

- Added "-@" option to dtc compiler for rp1.dtso. Symbols exported are
  needed for loading gpio-line-names dtbo from userspace.

- arm64 defconfig now have both CONFIG_MISC_RP1 and CONFIG_COMMON_CLK_RP1
  set to module.

- PCI_DEVICE_ID_RP1_C0 renamed to PCI_DEVICE_ID_RPI_RP1_C0


RP1 misc driver -----------------------------------
- RP1 driver moved to drivers/misc/.

- Cleanups on unused variables and definitions.

- Moved __dtbo_rp1_pci_[begin,end] to an appropriate header file.

- Interrupt number definitions are now local to the driver source code.

- Removed the calls to irq_domain_[activate/decativate]_irq since they
  are already called by core functions.

- Added myself as module co-author.

- Using pci_resource_n() to dump the BAR aperture.

- Adopted pcim_iomap() managed variant to map the BAR.

- Several cleanups in various error return path.

- CONFIG_OF_IRQ automatically selected when MISC_RP1 is enabled.


GPIO/PINCTRL --------------------------------------
- Removed several macros and definitions as they are now unused.

- Reworked RP1 pinctrl driver  to leverage regmap-mmio to access the
  setup and status registers.

- It's now possible to load a dtb overlay dynamically through configfs
  in order to set the gpio-line names for RP1 gpio controller.

- Removed unused includes.

- CONFIG_GPIOLIB automatically selected when PINCTRL_RP1 is enabled.

- rp1_iobanks structure declared static.


CLOCKS --------------------------------------
- Renamed "xosc" to "rp1-xosc"

- Registered RP1_CLK_SYS (needed by macb ethernet)

- Dropped unused ref_clock variable.

- Added myself as module co-author.

- Release the spinlock in rp1_clock_set_parent() return path.


DTS -----------------------------------------
- rp1.dtso is now in a patch of its own.

- Reworked the list of self configured clocks, now restricted to PLL_SYS_CORE,
  PLL_SYS and CLK_SYS.

- Moved clock-rp1-xosc to main DTB for RaspberryPi 5. Removed macb_pclk and
  macb_hclk, now provided internally by clock controller inside RP1.

- Removed property gpio-line-names, now managed by dtbo loaded from userspace.

- Dropped interrupt and address definitions. Interrupts are replaced by
  hard-coding the appropriate int number. This impact also the relative yaml
  schema. As a result, include/dt-bindings/misc/rp1.h is also dropped since
  it's now empty.

- Minor order fix-up and name changes to adhere more closely to DT coding style.
  Some cleanups in comment.


BINDINGS
- Dropped assigned-clocks and assigned-clock-rates from RP1 clock binding.

- dt-bindings header files are now named after the binding filename they
  refer to.

- Represent drive strength as its mA value instead of a positional id, as
  stated by the common bindings.

Andrea della Porta (14):
  dt-bindings: clock: Add RaspberryPi RP1 clock bindings
  dt-bindings: pinctrl: Add RaspberryPi RP1 gpio/pinctrl/pinmux bindings
  dt-bindings: pci: Add common schema for devices accessible through PCI
    BARs
  dt-bindings: misc: Add device specific bindings for RaspberryPi RP1
  PCI: of_property: Sanitize 32 bit PCI address parsed from DT
  of: address: Preserve the flags portion on 1:1 dma-ranges mapping
  gpiolib: Export symbol gpiochip_set_names()
  clk: rp1: Add support for clocks provided by RP1
  pinctrl: rp1: Implement RaspberryPi RP1 gpio support
  arm64: dts: rp1: Add support for RaspberryPi's RP1 device
  misc: rp1: RaspberryPi RP1 misc driver
  arm64: dts: bcm2712: Add external clock for RP1 chipset on Rpi5
  arm64: dts: Add DTS overlay for RP1 gpio line names
  arm64: defconfig: Enable RP1 misc/clock/gpio drivers

 .../clock/raspberrypi,rp1-clocks.yaml         |   62 +
 .../devicetree/bindings/misc/pci1de4,1.yaml   |  110 ++
 .../devicetree/bindings/pci/pci-ep-bus.yaml   |   69 +
 .../pinctrl/raspberrypi,rp1-gpio.yaml         |  169 ++
 MAINTAINERS                                   |   15 +
 arch/arm64/boot/dts/broadcom/Makefile         |    3 +-
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |    7 +
 arch/arm64/boot/dts/broadcom/rp1.dtso         |   62 +
 .../boot/dts/broadcom/rpi-rp1-gpios-5-b.dtso  |   62 +
 arch/arm64/configs/defconfig                  |    3 +
 drivers/clk/Kconfig                           |    9 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-rp1.c                         | 1658 +++++++++++++++++
 drivers/gpio/gpiolib.c                        |    3 +-
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/rp1/Kconfig                      |   24 +
 drivers/misc/rp1/Makefile                     |    5 +
 drivers/misc/rp1/rp1-pci.dtso                 |    8 +
 drivers/misc/rp1/rp1_pci.c                    |  365 ++++
 drivers/misc/rp1/rp1_pci.h                    |   14 +
 drivers/of/address.c                          |    3 +-
 drivers/pci/of_property.c                     |    5 +-
 drivers/pci/quirks.c                          |    1 +
 drivers/pinctrl/Kconfig                       |   11 +
 drivers/pinctrl/Makefile                      |    1 +
 drivers/pinctrl/pinctrl-rp1.c                 |  860 +++++++++
 .../clock/raspberrypi,rp1-clocks.h            |   61 +
 include/linux/gpio/driver.h                   |    3 +
 include/linux/pci_ids.h                       |    3 +
 30 files changed, 3595 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/pci1de4,1.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso
 create mode 100644 arch/arm64/boot/dts/broadcom/rpi-rp1-gpios-5-b.dtso
 create mode 100644 drivers/clk/clk-rp1.c
 create mode 100644 drivers/misc/rp1/Kconfig
 create mode 100644 drivers/misc/rp1/Makefile
 create mode 100644 drivers/misc/rp1/rp1-pci.dtso
 create mode 100644 drivers/misc/rp1/rp1_pci.c
 create mode 100644 drivers/misc/rp1/rp1_pci.h
 create mode 100644 drivers/pinctrl/pinctrl-rp1.c
 create mode 100644 include/dt-bindings/clock/raspberrypi,rp1-clocks.h

-- 
2.35.3


