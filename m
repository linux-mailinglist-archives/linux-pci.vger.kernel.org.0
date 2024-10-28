Return-Path: <linux-pci+bounces-15447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B43DC9B3294
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 15:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F34A282F35
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 14:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130F61DDA31;
	Mon, 28 Oct 2024 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cRRCKCKa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF60E1DD0EA
	for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124438; cv=none; b=cfOW0ohNFaGyVmp6yWaEqVWZK9PLubzi50EM2wW3vO20zYRud8QMD2PV9SojF7Vi76QTOT/vi3SMN5DpSPlqDs0UtP46R7G0dppwrlRzE47geEJmnEIxoXih228P2ElOlCEvirQvzMbrsRrcKM5tzzjMBySmV6KXZaPOv5IefTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124438; c=relaxed/simple;
	bh=OkQm541mL+CQThMaqvJlJK8G6Hq8gMZwEjrzY1OYG50=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EY9ScpYlMK73Ll+SNTDjSl3VmXs5HgrLmPZtgqAsYMb3k7DjHzYGRXYlNf0jqTRAKV/dJTkuU3BlzplRpPWz9hhlDNUTULIhG5fjhHM3XglHaSzITZBR3qgeGdDk50ydXoumURIg8B8bC4RxFhoNvcdxBnuho2GjlRipDw1c4js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cRRCKCKa; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso3756271e87.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730124434; x=1730729234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fmWQwY0LyW7DZAdLbPONRZPTG7Y9Z40HVMwsEI41r2Q=;
        b=cRRCKCKanDeOu5hJbb3zDOQ5s3DmmP8wQqMr/lNDfrzTxgoyyKDk6HMbYe1gxSQYVl
         +s0M8TupCTtg8GZGdAMImN2k1hwpPs/8m7s9RYRfAIOxcQo05yz9gNbnZXYbxTMaR8Ko
         dcbbkf+3h0ihJgBgKnq7zdRhWavU0SN5qomXU+5ZrT5+0mRQavbHdI9CTfbWg9Gpk2dL
         JTARB7GQDZ4M8VvwtCK9mhF6cAAg/VK0z+YFc3WoNXewqiFxdA0Qh0YiXY+PGKhIVdyl
         Rp/Lc1M47VeDwTxR6KiFehhe2S2awqU4OQ2WBnFfxwJhqSM7s9TwZFOwDgDGtCBZ9n0s
         fGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730124434; x=1730729234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmWQwY0LyW7DZAdLbPONRZPTG7Y9Z40HVMwsEI41r2Q=;
        b=h8L5ogF6OySnuXFc5Vx2NhcmYMwEwRoKazhT6s5BSrlMQ1rXXNnNHsr3dtCK65LEBS
         n8IFBTGD81NPgBBdjZmjG0qKU+1q2Eqpmd7uFT1SsNKX4dF7aKLJSL91pTIJgETGQB8X
         FZPq7Tzk7haD4argJzsTzcTUxb8BStGbgfSvL1RrlSa7qkht/i1BiIpmGKc3dgUwYjsa
         Rxcm9dzxZ/qwB2EHlquhF65X+caE5VdIzegpXRzRoTxiPBVR/nnzGxhS40E/gWm3FaqB
         kxyC0EozJgiL+UsH9215M+L+BnASAIXTBFq3mnXAyZEcQ5kVge0EqmN8sbtfiCQ2OQ1T
         Rm3w==
X-Forwarded-Encrypted: i=1; AJvYcCUfndYydDKOfW+lqvYT/UdX7mM4dEq1peePlrALEDP+XVvfuZ3YDeLvMtT93dOTwRxpIBPlnDo98dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMP8rx0ydRFm9hLhl3NtRa4DRbyhsY+p4bXPaqlC+va3VFOUd6
	544mM5iMImgdukhvluojZuD87yHch50sfsVZ14pFNS8VId1rUtRRyvlGhJBbeQo=
X-Google-Smtp-Source: AGHT+IHUuPqkKP8P1megHNLn/ao7CtOz4cPFTAgpqvApPN3/0axwoAMsnKF52yOT43fKrZomUCJmpA==
X-Received: by 2002:a05:6512:2399:b0:539:e9f8:d45d with SMTP id 2adb3069b0e04-53b34a1b10fmr4101627e87.52.1730124433790;
        Mon, 28 Oct 2024 07:07:13 -0700 (PDT)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b271f56d9sm388920166b.144.2024.10.28.07.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:07:13 -0700 (PDT)
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
	Krzysztof Wilczynski <kw@linux.com>,
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
Subject: [PATCH v3 00/12] Add support for RaspberryPi RP1 PCI device using a DT overlay
Date: Mon, 28 Oct 2024 15:07:17 +0100
Message-ID: <cover.1730123575.git.andrea.porta@suse.com>
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

-PATCHES 5 and 6: preparatory patches that fix the address mapping
 translation (especially wrt dma-ranges).

-PATCH 7 and 8: add clock and gpio device drivers.

-PATCH 9: the devicetree overlay describing the RP1 chipset. Please
 note that this patch should be taken by the same maintainer that will
 also take patch 11, since txeieh dtso is compiled in as binary blob and is
 closely coupled to the driver.

-PATCH 10: this is the main patch to support RP1 chipset and peripherals
 enabling through dtb overlay. The dtso since is intimately coupled with
 the driver and will be linked in as binary blob in the driver obj.
 The real dtso is in devicetree folder while the dtso in driver folder is
 just a placeholder to include the real dtso.
 In this way it is possible to check the dtso against dt-bindings.
 The reason why drivers/misc has been selected as containing folder
 for this driver can be seen in [6], [7] and [8].

-PATCH 11: add the external clock node (used by RP1) to the main dts.

-PATCH 12: add the relevant kernel CONFIG_ options to defconfig.

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


CHANGES IN V3:

NEW ADDITIONS ------------------------------------------------

- Fixed a bug in of_pci_prop_ranges() that was incorrectly using
  a CPU address instead of PCI bus address while assigning "ranges"
  properties to PCI-PCI bridge nodes.
  As a side effect, the patch "PCI: of_property: Sanitize 32 bit PCI
  address parsed from DT" has been dropped since it's no longer
  necessary.

RP1 misc driver -----------------------------------

- Dropped -@ option while compiling the dtso.

- Removed unused includes.

- Dropped unused sys_clk references.

- Got rid of dump_bar().

- Added the relevant unregister function on exit paths for mapped
  interrupts and domain.

- Added missing MODULE_DEVICE_TABLE().

- reset_control no longer claimed in probe().

- dtbo_size and dtbo_start local vars definition moved at the
  beginnning of the probe() function.

- the DTB overlay is now applied after the interrupt controller
  has been setup.

- Reworked the Kconfig dependency list for CONFIG_MISC_RP1 to avoid
  a recursion.


GPIO/PINCTRL --------------------------------------

- Gpio line names changes (and relative dtbo and preparatory patches)
  have been dropped.


CLOCKS --------------------------------------

- raspberrypi,rp1-clocks.h: license adjusted.

- Removed unused headers.

- Replaced locally defined KHZ and MHZ with defines from linux/units.h

- Added regmap support for registers which also has builtin support
  for showing regs via debugfs. Dropped the previous implementation
  of debugfs attributes.

- Reworked the clock tree using clk_parent_data instead of strings. This
  also allowed to get rid of __clk_get_hw() and friends.

- Split a couple of lines assigning to calc_rate into multi-lines for
  ease of understanding.

- Dropped .set_rate function from rp1_pll_ph_ops since it does nothing.

- Initialize struct clk_init_data init via = {} instead of memset.

- Used dev_err_probe() instead of dev_err().

- Module init/exit declaration replaced by module_platform_driver().

- Kconfig: CONFIG_COMMON_CLOCK_RP1 now depends on CONFIG_MISC_RP1 instead
  of CONFIG_PCI.


DTS -----------------------------------------

- "rp1-xosc" renamed to "xosc"


BINDINGS ------------------------------------

- raspberrypi,rp1-gpio.yaml: removed a paragraph in the description of
  pinctrl node since it's already covered by pinctrl-bindings.

- All paths to referenced bindings are now full-paths.

- Uniformly using single quotes over double quotes on patterns and strings.

- Amended some node names to adhere to DTS coding style.

- Dropped unused labels in examples.

- pci-ep-bus.yaml: simplified the definition of pci-ep-bus node.

- pci-ep-bus.yaml: added additionalProperties: true.

- pci1de4,1.yaml: interrupt-controller and #interrupt-cells moved from
  pci-ep-bus node to the main device.

- pci1de4,1.yaml: @unit-number not optional anymore.

- pci1de4,1.yaml: droppped pci-ep-bus redefinition (already inherited by
  pci-ep-bus.yaml). Also removed the internal SoC nodes.



Andrea della Porta (12):
  dt-bindings: clock: Add RaspberryPi RP1 clock bindings
  dt-bindings: pinctrl: Add RaspberryPi RP1 gpio/pinctrl/pinmux bindings
  dt-bindings: pci: Add common schema for devices accessible through PCI
    BARs
  dt-bindings: misc: Add device specific bindings for RaspberryPi RP1
  PCI: of_property: Assign PCI instead of CPU bus address to dynamic
    bridge nodes
  of: address: Preserve the flags portion on 1:1 dma-ranges mapping
  clk: rp1: Add support for clocks provided by RP1
  pinctrl: rp1: Implement RaspberryPi RP1 gpio support
  arm64: dts: rp1: Add support for RaspberryPi's RP1 device
  misc: rp1: RaspberryPi RP1 misc driver
  arm64: dts: bcm2712: Add external clock for RP1 chipset on Rpi5
  arm64: defconfig: Enable RP1 misc/clock/gpio drivers

 .../clock/raspberrypi,rp1-clocks.yaml         |   62 +
 .../devicetree/bindings/misc/pci1de4,1.yaml   |   80 +
 .../devicetree/bindings/pci/pci-ep-bus.yaml   |   58 +
 .../pinctrl/raspberrypi,rp1-gpio.yaml         |  163 ++
 MAINTAINERS                                   |   14 +
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |    7 +
 arch/arm64/boot/dts/broadcom/rp1.dtso         |   61 +
 arch/arm64/configs/defconfig                  |    3 +
 drivers/clk/Kconfig                           |    8 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-rp1.c                         | 1540 +++++++++++++++++
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/rp1/Kconfig                      |   21 +
 drivers/misc/rp1/Makefile                     |    3 +
 drivers/misc/rp1/rp1-pci.dtso                 |    8 +
 drivers/misc/rp1/rp1_pci.c                    |  357 ++++
 drivers/misc/rp1/rp1_pci.h                    |   14 +
 drivers/of/address.c                          |    3 +-
 drivers/pci/of_property.c                     |    2 +-
 drivers/pci/quirks.c                          |    1 +
 drivers/pinctrl/Kconfig                       |   11 +
 drivers/pinctrl/Makefile                      |    1 +
 drivers/pinctrl/pinctrl-rp1.c                 |  801 +++++++++
 .../clock/raspberrypi,rp1-clocks.h            |   61 +
 include/linux/pci_ids.h                       |    3 +
 26 files changed, 3283 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/pci1de4,1.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso
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


