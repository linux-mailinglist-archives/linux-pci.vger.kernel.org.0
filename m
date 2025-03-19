Return-Path: <linux-pci+bounces-24171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5068EA69B43
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 22:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47BC87AD2D2
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 21:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C1821A92F;
	Wed, 19 Mar 2025 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q1wZ3J4T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F801DE2B8
	for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421089; cv=none; b=QhaiimZ+wZJZLxzppmQyjQzlaFDK0TKwEgL5PURvmfqaSspw+9KE7QUxNnbJoQMUowjOk1MXMG0bbz+T2xLHOwzzNVDa9kPnhXj8gA8Vq/mWYbCr4k9+MfrHQ00no9NtqIP9ipe+nUoJKeBdkNuMC7QvAbF7WDcXFUybTc6un4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421089; c=relaxed/simple;
	bh=yydZ/tpS7Qcb3qVPnLRmqCanuEwEDrJdaqOs1o5cZBU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VZioLs2GMPoGwZh3qhvz2lX0gZyx5aNsE15JuV0Rz7/9NglbiWzD5aIhAwVuZ1A22A02F+sirHhP88bH0Im43vv3U9bdmAe5/yJeyUEErHeQYj5tN79SLNnWZfhJ2C3QTzcB01fQNW5QX1KXRkbrZuSjk2JJof4BJyx81usVGT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q1wZ3J4T; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso241054a12.3
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2025 14:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742421084; x=1743025884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iMJ02+UsxLp070EimN7oIllTlV+i2h1UPF3pGfX/mQ0=;
        b=Q1wZ3J4Tw6LR+4Zle8UH7uYFU4rGqm/arDzy8GEoA2vgXCE08R728azjX9KwF30MWQ
         QCAkh16YzK/2Du19tHdMcAWC3okcKEXxmHC3qC3wxq2ovKWsX9Y3S9myT6R0JDU6dOpN
         s4BiQc7e88TvlW73gRR3eVHxAR9hhp7dpKHOnhgYfSsb/4jbb6rMaukov6gRMdtD/vkR
         758aM6u2/azP3qt3Iec8ZiGg7OvQyMIPwLv4nI4fiRhi1+WkSj88n1cwlO00Wirv8Ffi
         okm4FGynZ9WRSkMXA/fYPiBBsG/rnSd3cMqDLhBZJwo//adYPRLccff4LxjLyE5rSSEh
         Pd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421084; x=1743025884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMJ02+UsxLp070EimN7oIllTlV+i2h1UPF3pGfX/mQ0=;
        b=qXH4xvAkavBYfVoMm6G5VJ9ksogKTAh5T9wvoYiWGIYHo0s4b2VPjLrsrDqj/MhZgk
         xVvIsCqSp6xFuPjUNc/6TD4ZDdVwkf5hAITbrqlYoap3r+ZwQTObT46VdFdqJpnaamK0
         K1mna0CXNBscRbqdXUwmG1wV/6k2bEx4/yPO1zz0CfVXPrwHqXgpwIPTe53EXeXADH7J
         R4FZAIn+aPR5cQSNC/Pz40uaTuY+eouMK/NFOLgTJD1805yi8+G7zRU1g24CTg+GFcjd
         bRKCsms4RuYtfUlo4SvDe6tjWgGlW3+Slf11zQj/Anz1HiwRMELbDVVmrt2XdCxsX/t+
         OMRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5eGbDU2QqaTJXKzZLkDcKDalOoZkJqqnLp6ug54LCdrmV3cG7g/Ta3BMIPxgZu8jkyF4jOMKbr1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzDcY8m3pjuyibTT/Lhledbpw72f3TZUFOBHA+w889dXw6V+14
	5St2Zpzcs+wJqACzbnSFpiD1lzUR8RCVL1fpuKtfdTLXDe3eyEdlX4aXYWEqhtg=
X-Gm-Gg: ASbGnct7cMDYhUEjxWVZT4pgH9fdl3qkgrqoEnHMpwLFM36XHocmPys5Na6K1f58ytE
	DmsdbkE0f90zjJx5mng5onXDh83SgIF46SsNnp3rip632tlD+Q3USMsSMtMOjEfibvPzCVfCiCp
	op3suA7ZwOZ7OjcrUR9Dts6E0KPSZS9sTVrw97eKggcPQyCC5/BrQADkofK+xGiSB6jERvUIlr9
	PRFsXfqLagKY0SZMkv2GOWMBJ0hbKdw8EE32qs9MyC8vTG4p/2tN04httCRdvHkVBaCL+/JIM6g
	sir+lE9FCHjezmDmISlXnVQu5sfAHgK3A42EZBiUBV84uOgOpuLXzmFHuLYcf1yVZE3tH8Zw6l/
	nlMEqtR9vcw==
X-Google-Smtp-Source: AGHT+IELQwTG7pKyuHeRhxG7pGOXWY26uVy/osvBSjthNH9mar6V6kDx43rUj4jn8vxdiITXO1EMeg==
X-Received: by 2002:a05:6402:5114:b0:5e0:9390:f0d2 with SMTP id 4fb4d7f45d1cf-5eb80fa5e14mr3965022a12.20.1742421084089;
        Wed, 19 Mar 2025 14:51:24 -0700 (PDT)
Received: from localhost (host-87-4-238-14.retail.telecomitalia.it. [87.4.238.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e81692e670sm9498000a12.14.2025.03.19.14.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:51:23 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com
Subject: [PATCH v8 00/13] Add support for RaspberryPi RP1 PCI device using a DT overlay
Date: Wed, 19 Mar 2025 22:52:21 +0100
Message-ID: <cover.1742418429.git.andrea.porta@suse.com>
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
from a devictree overlay loaded during RP1 PCI endpoint enumeration. To
ensure compatibility with downstream, a devicetree already comprising the
RP1 node is also provided, so it's not strictly necessary to use the
dynamically loaded overlay if the devicetree is already fully defined at
the origin.
To achieve this modularity, the RP1 node DT definitions are arranged by
file inclusion as per following schema (the arrow points to the includer,
see also [9]):
 
 rp1-pci.dtso         rp1.dtso
     ^                    ^
     |                    |
rp1-common.dtsi ----> rp1-nexus.dtsi ----> bcm2712-rpi-5-b-monolithic.dts
                                               ^
                                               |
                                           bcm2712-rpi-5-b.dts

Followup patches should add support for the several peripherals contained
in RP1.

This work is based upon dowstream drivers code and the proposal from RH
et al. (see [1] and [2]). A similar approach is also pursued in [3].

The patches are ordered as follows:

-PATCHES 1 to 4: add binding schemas for clock, gpio and RP1 peripherals.
 They are needed to support the other peripherals, e.g. the ethernet mac
 depends on a clock generated by RP1 and the phy is reset through the
 on-board gpio controller.

-PATCH 5 and 6: add clock and gpio device drivers.

-PATCH 7: the devicetree node describing the RP1 chipset. Please
 note that this patch should be taken by the same maintainer that will
 also take patch 8, since the definition it contains is possibly used
 by the dtso compiled in as binary blob and is closely coupled to the
 driver.

-PATCH 8: this is the main patch to support RP1 chipset. It can work
 either with a fully defined devicetree (i.e. one that already included
 the rp1 node since boot time) or with a runtime loaded dtb overlay
 which is linked as binary blob in the driver obj. This duality is
 useful to comply with both downstream and upstream needs (see [9]).
 The real dtso is in devicetree folder while the dtso in driver folder is
 just a placeholder to include the real dtso.
 In this way it is possible to check the dtso against dt-bindings.
 The reason why drivers/misc has been selected as containing folder
 for this driver can be seen in [6], [7] and [8].

-PATCH 9: the fully fledged devictree containing also the rp1 node.
 This devicetree is similar to the one downstream is using.

-PATCH 10 (OPTIONAL): this patch introduces a new scenario about how
 the rp1 node is specified and loaded in DT. On top of the base DT
 (without rp1 node), the fw loads this overlay and the end result is
 the same devicetree as in patch 9, which is then passed to the next
 stage (either the kernel or u-boot/bootloader).
 While this patch is not strictly necessary and can therefore be dropped
 (see [10]), it's not introducing much extra work and maybe can come
 in handy while debugging.
 
-PATCH 11: add the external clock node (used by RP1) to the main dts.

-PATCH 12: add the relevant kernel CONFIG_ options to defconfig.

-PATCH 13: enable CONFIG_OF_OVERLAY in order for 'make defconfig'
 to produce a configuration valid for the RP1 driver. Without this
 patch, the user has to explicitly enable it since the misc driver
 depends on OF_OVERLAY.

This patchset is also a first attempt to be more agnostic wrt hardware
description standards such as OF devicetree and ACPI, where 'agnostic'
means "using DT in coexistence with ACPI", as been already promoted
by e.g. AL (see [4]). Although there's currently no evidence it will also
run out of the box on purely ACPI system, it is a first step towards
that direction.

Many thanks,
Andrea della Porta

Links:
- [1]: https://lpc.events/event/17/contributions/1421/attachments/1337/2680/LPC2023%20Non-discoverable%20devices%20in%20PCI.pdf
- [2]: https://lore.kernel.org/lkml/20230419231155.GA899497-robh@kernel.org/t/
- [3]: https://lore.kernel.org/all/20240808154658.247873-1-herve.codina@bootlin.com/#t
- [4]: https://lore.kernel.org/all/73e05c77-6d53-4aae-95ac-415456ff0ae4@lunn.ch/
- [5]: https://lore.kernel.org/all/20240626104544.14233-1-svarbanov@suse.de/
- [6]: https://lore.kernel.org/all/20240612140208.GC1504919@google.com/
- [7]: https://lore.kernel.org/all/83f7fa09-d0e6-4f36-a27d-cee08979be2a@app.fastmail.com/
- [8]: https://lore.kernel.org/all/2024081356-mutable-everyday-6f9d@gregkh/
- [9]: https://lore.kernel.org/all/Z87wTfChRC5Ruwc0@apocalypse/
- [10]: https://lore.kernel.org/all/CAMEGJJ0f4YUgdWBhxvQ_dquZHztve9KO7pvQjoDWJ3=zd3cgcg@mail.gmail.com/#t

CHANGES IN V8


PATCH RELATED -------------------------------------------------

- This cover letter and patch 8 commit messages now have
  more details explaining the new DT include files organization.

- Added two new patches numbered 9 and 10 respectively dealing
  with the new DT inclusion schema.


BINDINGS ------------------------------------------------------

- Modified maintainer first name for get_maintainer.pl to be able
  to retrieve the entire name correctly from the .yaml files. As
  a consequence, MAINTAINERS file does not need an entry for
  schemas anymore.

- pci1de4,1.yaml: Added a statement about the ints activation
  type for rp1 peripherals: only level high or rising edge
  are supported since they all are active high only.

RP1 PINCTRL DRIVER ---------------------------------

- Added GPIOCHIP_IRQ_RESOURCE_HELPERS.


RP1 CLOCK DRIVER ------------------------------------

- Added PLL_DIV_INVALID to denote invalid values in pll_sec_div_table[].

- Dropped some empty lines.

- Changed TODO comment to better reflect the intent

- Changed a WARN() into WARN_ONCE() to prevent flooding

- Fixed the hard limit condition "rate > 4000000000ll" in
  rp1_clock_set_rate_and_parent() to "rate > data->max_freq", in order
  to check against the limit specific for that clock.

- Style change: dropped an empty line


RP1 MISC DRIVER -----------------------------------

- rp1_pci.c: Added a suitable dev_err() warning in case
  of_platform_default_populate() fails.

- rp1_pci.c: Fixed the mismatching %d vs %u in dev_dbg().

- rp1_pci.c: Changed the error string printed on pci_alloc_irq_vectors()
  failure, plus minor cosmetic changes such as capitalization of error
  strings. 

- rp1_pci.c: Changed dev_err() to dev_err_probe() where appropriate.

- rp1_pci.c: Updated the year in the top header copyright notice,
  also added a newline between lines. Also, changed the error string
  'Not initialised' to 'Not initialized'.

- rp1_pci.c: Changed MODULE_DESCRIPTION() string to match the one
  in Kconfig.

- rp1-pci.dtso: Minor change to the top header comment to unify
  the multi-line comment style.

- Kconfig: Changed description in the header comment to match the
  description in the tristate option.


Andrea della Porta (13):
  dt-bindings: clock: Add RaspberryPi RP1 clock bindings
  dt-bindings: pinctrl: Add RaspberryPi RP1 gpio/pinctrl/pinmux bindings
  dt-bindings: pci: Add common schema for devices accessible through PCI
    BARs
  dt-bindings: misc: Add device specific bindings for RaspberryPi RP1
  clk: rp1: Add support for clocks provided by RP1
  pinctrl: rp1: Implement RaspberryPi RP1 gpio support
  arm64: dts: rp1: Add support for RaspberryPi's RP1 device
  misc: rp1: RaspberryPi RP1 misc driver
  arm64: dts: Add board DTS for Rpi5 which includes RP1 node
  arm64: dts: Add overlay for RP1 device
  arm64: dts: bcm2712: Add external clock for RP1 chipset on Rpi5
  arm64: defconfig: Enable RP1 misc/clock/gpio drivers
  arm64: defconfig: Enable OF_OVERLAY option

 .../clock/raspberrypi,rp1-clocks.yaml         |   58 +
 .../devicetree/bindings/misc/pci1de4,1.yaml   |  137 ++
 .../devicetree/bindings/pci/pci-ep-bus.yaml   |   58 +
 .../pinctrl/raspberrypi,rp1-gpio.yaml         |  198 +++
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/broadcom/Makefile         |    4 +-
 .../broadcom/bcm2712-rpi-5-b-monolithic.dts   |    8 +
 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts     |    7 +
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi  |   42 +
 arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi   |   14 +
 arch/arm64/boot/dts/broadcom/rp1.dtso         |   11 +
 arch/arm64/configs/defconfig                  |    4 +
 drivers/clk/Kconfig                           |    9 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-rp1.c                         | 1512 +++++++++++++++++
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/rp1/Kconfig                      |   20 +
 drivers/misc/rp1/Makefile                     |    3 +
 drivers/misc/rp1/rp1-pci.dtso                 |   25 +
 drivers/misc/rp1/rp1_pci.c                    |  333 ++++
 drivers/pci/quirks.c                          |    1 +
 drivers/pinctrl/Kconfig                       |   11 +
 drivers/pinctrl/Makefile                      |    1 +
 drivers/pinctrl/pinctrl-rp1.c                 |  790 +++++++++
 .../clock/raspberrypi,rp1-clocks.h            |   61 +
 include/linux/pci_ids.h                       |    3 +
 27 files changed, 3320 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/pci1de4,1.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b-monolithic.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1-common.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso
 create mode 100644 drivers/clk/clk-rp1.c
 create mode 100644 drivers/misc/rp1/Kconfig
 create mode 100644 drivers/misc/rp1/Makefile
 create mode 100644 drivers/misc/rp1/rp1-pci.dtso
 create mode 100644 drivers/misc/rp1/rp1_pci.c
 create mode 100644 drivers/pinctrl/pinctrl-rp1.c
 create mode 100644 include/dt-bindings/clock/raspberrypi,rp1-clocks.h

-- 
2.35.3


