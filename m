Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6990D395340
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 00:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhE3WqE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 May 2021 18:46:04 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:43667 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229887AbhE3WqE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 May 2021 18:46:04 -0400
Received: from copland.sibelius.xs4all.nl ([83.163.83.176])
        by smtp-cloud8.xs4all.net with ESMTP
        id nUANlDkLZIpGynUAOlJsHU; Mon, 31 May 2021 00:44:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1622414664; bh=i+lntvHcQFtA4WzpzAK2fZ1XNv59rf7ksgwKKNSp1Hc=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=APMaVmSJ8y6a/CeC81LeSYkAbZOI9OhertHrGIi9OR5/orThysYGjt8K47yMNYYtZ
         e72b0FGi1B4uUZoOzlDaaKTmR7YOOBnW3penTZ+LZ20j29yesP9LHJKl5pLQE9jtGu
         QAx8jbOZyloYkq+77EvpQ8LHlSUOHexUbPz7McFw3v1SuEc56EzAuSuwAxePHrq/Y+
         mnXXNromzM0JphmfRs9cRbpnLpNXJIaa6kg8ZBSDIW5yXgHw8trFYqHIB5besj3M2M
         2CjBHoHZgB13W9rbTgWDH6abrWjweRyC++ciLdGkEdSdcbQk7sRFOdtGthsvyDj6Pu
         qQW8iA3K2/oWg==
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     devicetree@vger.kernel.org
Cc:     maz@kernel.org, robin.murphy@arm.com,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Apple M1 PCIe DT bindings
Date:   Mon, 31 May 2021 00:43:59 +0200
Message-Id: <20210530224404.95917-1-mark.kettenis@xs4all.nl>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCPLUSCSRp08vyYWAg9IyKw+2xNqsbnVOvxxAlmtWSR61EW2uQ+IosWVXLd+JVC4/nWNrGMT8TcZSM7C7uoDIvdwedp3P1Vop6WlTwt4V5CFzyCqN88D
 thKteuSQIRAAgvx6rTCQKb8IUzvfG+uOSIaZydB/e41JB+QNK5nk8QCluMH+W03fvYqyZaaDYd5vexS2yeFA0JEZcUZmoEnsK6rYEoBkxOWEH+SbDW5tq1x4
 Jn4M1gIaaWDClQO2bQKVp+9RJLw1eDAQ+YS/313KRi0MSXaEa/r5/SFrhIV1lPkAVfqgjPZW+y/tn9C7hdVnv8DNHvfhdNBCqjIs2zt3UZV8EyVVS8NS/1JO
 2ElaMTAKCYmWeMc0qTd/KryzZK+jna2NzOwNCXKB5wBRnz2N8uXV95hoftlIQ4hQjJtaUOd80uG58yvAQNGgZZ0MTZjxrYPBXdp1+csummTz7ADzlfNxPxk9
 o4HY0s0dxwSC5aNyTpFp3l+vq7gJ+R2pQpEjPNeVC7z1Z9dA40VofCIPi5k=
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

I still hope to hear from Marc Zyngier on the way MSIs are represented
in this binding.

Patch 2/2 of this series depends on the pinctrl series I sent earlier.


Changelog:

v2: - Adjust name for ECAM in "reg-names"
    - Drop "phy" registers
    - Expand description
    - Add description for "interrupts"
    - Fix incorrect minItems for "interrupts"
    - Fix incorrect MaxItems for "reg-names"
    - Document the use of "msi-controller", "msi-parent", "iommu-map" and
      "iommu-map-mask"
    - Fix "bus-range" and "iommu-map" properties in the example

Mark Kettenis (2):
  dt-bindings: pci: Add DT bindings for apple,pcie
  arm64: apple: Add PCIe node

 .../devicetree/bindings/pci/apple,pcie.yaml   | 167 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 arch/arm64/boot/dts/apple/t8103.dtsi          |  63 +++++++
 3 files changed, 231 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml

-- 
2.31.1

