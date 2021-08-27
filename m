Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A22C3F9D6E
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 19:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238504AbhH0RQf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 13:16:35 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:55917 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238071AbhH0RQf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Aug 2021 13:16:35 -0400
Received: from cust-df1d398c ([IPv6:fc0c:c1f5:9ac0:c45f:1583:5c5b:91fa:2436])
        by smtp-cloud8.xs4all.net with ESMTPA
        id JfS3mDfw9JWNeJfS5m6c2g; Fri, 27 Aug 2021 19:15:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1630084540; bh=nXlaS3prSiZVMJryT3t3etHYnAzjqVUbsiRTUUbYIeI=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=O5mvUkZqEL/Ad+wlV/1oQLIZve/W6esfQZnoDY1y8Bc5jdtEqj5ZDHG4JnqmakBek
         LKm7xGDfBYtHJGS4VgNXlawwuL/oj+5kGREWjNOzkQNej/SZSD0f0OORkVxe/L0A6F
         W2cnzPP0nWQIh0DmRQ6h1DpXeIzqgw3ZB1G5k4msnDzpJqFvrq2JMoXddGngzkwmHb
         jBcoAhC9Ie7OJ5lyWHRwQkTHrt906AorhfSjeMPz80FiD0IgxT6uPeq65ji9nNiump
         ACRZ4nZaCUMzmgjpF9KkjXk0DESAvClRiXs+08roByBw1u3yzU1B4+0KzYVyX57rUq
         U1u9Wl+PhQ6yg==
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     devicetree@vger.kernel.org
Cc:     alyssa@rosenzweig.io, Mark Kettenis <kettenis@openbsd.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v4 0/4] Apple M1 PCIe DT bindings
Date:   Fri, 27 Aug 2021 19:15:25 +0200
Message-Id: <20210827171534.62380-1-mark.kettenis@xs4all.nl>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfF4P4Lg/TKSMGvTdS4QEd3FclE9oV5E+06cdwacwqiwVewVsnRfmDHmsDipn9GOTFOJXXXyD2knsMLStF3P6V8Ul/a21HndwGlfyD7KdAEUp9Wpr4J71
 iocDEPasSk9Pi1ggyGTSsmNmCygt3cPp5sBhgekIvTrWRgH5AQUz1/GYLz1GtfkS85DywbBoU/hD1sQwf3cV4g0fKFfVjetMsJeH8EebN5nbaAc8D842iO4p
 XL6Mgorwis/xz1jXNcpdmfQ3eP5y0MzDakhoUY6FG/zy9ECXqJZRmCenH4VFxVo09sEGDwxhR5j3zq0DA0iVBOxqolG8nYyg1yDI2H34B93dhUcYQ/TNtH73
 z46PG/hfiiIdNNXd/THBPscyjeT/KA+jKg8SYzPxsgzO6qBIjy33tafGfYq/6bDDU4MYaAXs2tawq47h8M8QoBtkV0L4bVhRQK+PAweEXdEb5Mttn5gLYuMW
 fHUA4ea9OeDZo1RRJ+vobULpm/eQnUOGomfik8n0YJFCF6oW9HdxXo4oGyogm54K8H8ojH88FgVQyTQYL7St1uwo32mE9zzPK1uFBKoSAyodVdbPbcKcbOzB
 Ynh2Su6qtcaDBjsSBe0V8KWPNkWm9em9UpPGwoT4dSctdCL0deWuKGGjmV8AEhTosHHbjmCExPtaa6on5kTyS+hiCEw05kgfL7GHX0iXqL/oAryh1/pZ62zo
 tX9C3AtV+e5N+XNEU0aLV/i3J3gQdL67C6/GGe6/EYm7JkZ3zJZgfRMSW4o844A21qA4h6we4rRmiIuTyyX2hvU8NxSowbRe2C3KhNlxli5/J68A103Rt2m0
 t8mQ0aVfZZ28vAbJF1Y=
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Mark Kettenis <kettenis@openbsd.org>

This small series adds bindings for the PCIe controller found on the
Apple M1 SoC.

At this point, the primary consumer for these bindings is U-Boot.
With these bindings U-Boot can bring up the links for the root ports
of the PCIe root complex.  A simple OS driver can then provide
standard ECAM access and manage MSI interrupts to provide access
to the built-in Ethernet and XHCI controllers of the Mac mini.

The Apple controller incorporates Synopsys Designware PCIe logic
to implement its root port.  But unlike other hardware currently
supported by U-Boot and the Linux kernel the Apple hardware
integrates multiple root ports.  As such the existing bindings
for the DWC PCIe interface can't be used.  There is a single ECAM
space for all root space, but separate GPIOs to take the PCI devices
on those ports out of reset.  Therefore the standard "reset-gpio" and
"max-link-speed" properties appear on the child nodes representing
the PCI devices that correspond to the individual root ports.

MSIs are handled by the PCIe controller and translated into "regular
interrupts".  A range of 32 MSIs is provided.  These 32 MSIs can be
distributed over the root ports as the OS sees fit by programming the
PCIe controller port registers.

This now adds an MSI controller binding schema and uses the generic
msi-ranges property to specify how the MSIs are mapped to interrupts
on the AIC.  I copied some of the description text in the MSI
controller binding schema from msi.txt but it may need some further
tweaks to make sense.

Patch 2/2 of this series depends on the pinctrl series I sent earlier
and will probably go through Hector Martin's Apple M1 SoC tree.


Changelog:

v4: - Convert MSI controller binding to YAML
    - Add generic msi-ranges property to MSI controller binding
    - Fix typos/formatting in apple,pcie binding
    - Use generic MSI controller binding in apple,pcie

v3: - Remove unneeded include in example

v2: - Adjust name for ECAM in "reg-names"
    - Drop "phy" registers
    - Expand description
    - Add description for "interrupts"
    - Fix incorrect minItems for "interrupts"
    - Fix incorrect MaxItems for "reg-names"
    - Document the use of "msi-controller", "msi-parent", "iommu-map" and
      "iommu-map-mask"
    - Fix "bus-range" and "iommu-map" properties in the example

Mark Kettenis (4):
  dt-bindings: interrupt-controller: Convert MSI controller to
    json-schema
  dt-bindings: interrupt-controller: msi: Add msi-ranges property
  dt-bindings: pci: Add DT bindings for apple,pcie
  arm64: apple: Add PCIe node

 .../interrupt-controller/msi-controller.yaml  |  42 +++++
 .../devicetree/bindings/pci/apple,pcie.yaml   | 165 ++++++++++++++++++
 .../bindings/pci/brcm,stb-pcie.yaml           |   1 +
 .../bindings/pci/microchip,pcie-host.yaml     |   1 +
 MAINTAINERS                                   |   1 +
 arch/arm64/boot/dts/apple/t8103.dtsi          |  63 +++++++
 6 files changed, 273 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml

-- 
2.32.0

