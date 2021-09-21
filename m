Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AA8413A2A
	for <lists+linux-pci@lfdr.de>; Tue, 21 Sep 2021 20:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhIUSnR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 14:43:17 -0400
Received: from lb2-smtp-cloud7.xs4all.net ([194.109.24.28]:51397 "EHLO
        lb2-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233372AbhIUSnP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Sep 2021 14:43:15 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Sep 2021 14:43:14 EDT
Received: from cust-df1d398c ([IPv6:fc0c:c1f5:9ac0:c45f:1583:5c5b:91fa:2436])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Skb8mlMr9pQdWSkbAmYt2D; Tue, 21 Sep 2021 20:34:34 +0200
From:   Mark Kettenis <kettenis@openbsd.org>
To:     devicetree@vger.kernel.org
Cc:     maz@kernel.org, robin.murphy@arm.com, sven@svenpeter.dev,
        alyssa@rosenzweig.io, Mark Kettenis <kettenis@openbsd.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Jim Quinlan <jim2101024@gmail.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v5 0/4] Apple M1 PCIe DT bindings
Date:   Tue, 21 Sep 2021 20:34:11 +0200
Message-Id: <20210921183420.436-1-kettenis@openbsd.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJAwNRZfItx7Ca/LQZGO8Hp6gt9AXY4gOPt4meSRg+3UmnKdHuwFhbQCu6nsqyqxNvOyuzarFKw3/4fLWCJGzEc0GGLfq23sEKY4AVHHAM849h4iLU9n
 TiVAFPhOKXPC9KSXurCf+NcfTy1GGLtCxInTPgoT3yT2wSBTNB28NAQw3kBjC9HtXeDP3UHcPO1FFWvIBxr9XX181R1/Z7GwOafKlivDRIYsKToDk/K8dbn7
 un2ZVmgru+jaUtF8VDMF/8Wj9Rnq0y/sB2ETSaFGDXsOyQKIry5u43TU+05kMXQEOqDnx5C1iMJ5z49oCkW+UcIAYKDrfvqV44FqTwZFuqnUYcz3KhZ8uYZV
 RG0GN96IPTCAqaEwNczdMrZUyQV8Tk7eeiAdsBPf+sDGZpxU38SBrvdXHU9idppHkKX9xkvT8/e765fm+NeVJZyWjZBBWLtlVVO9XreHWaIJ+Nejubotf1M/
 JhjoCxNbTShh7xgeYZrUPHYIi2MsuDOXcOQRmUWpOE0UMGqCmHd4il7XDjq0Uzr6iyjFwNLH3ujE9i6UqffgQZsSqD/Pd+a9hJkByvIebNM8EdmDvRnHhuda
 +HxcVUB+xpwkb+0T+EAqZW7aeZsE0fHCMp/amZYUMYgzhX91ZEkh8nAi5E82m38+TfDn5nQECIPOcYAOAB3RtjzTBHu2iriKCygnVtpbVQF5uFxVBjxZQIYu
 nVj0/HLh63zm3hVuYLjfD9gcYBEixTqOAo+4lt8Btkmhn5+/QIGu+2qhpZJIcd4UzuUsKkABJqo/qf+mI64j7rl/w3htHDgtT+ISVH7v50O9WJ4MlxJw9MW4
 10DQy0yp0W9JEEp4XvfNuwzwx2bft4rpCaSmij18BvCmuxDVhYacg7N5CWEIzQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

Patch 4/4 of this series depends on the pinctrl series I sent earlier
and will probably go through Hector Martin's Apple M1 SoC tree.


Changelog:

v5: - Use correct license for MSI controller binding schema
    - Use power-domains instead of clocks as we figured out
      that the hardware actually does power gating.
    - Fix sizes of the "reg" property.
    - Improve constraints.
    - Improve descriptions.

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

 .../interrupt-controller/msi-controller.yaml  |  46 +++++
 .../devicetree/bindings/pci/apple,pcie.yaml   | 161 ++++++++++++++++++
 .../bindings/pci/brcm,stb-pcie.yaml           |   1 +
 .../bindings/pci/microchip,pcie-host.yaml     |   1 +
 MAINTAINERS                                   |   1 +
 arch/arm64/boot/dts/apple/t8103.dtsi          |  63 +++++++
 6 files changed, 273 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml

-- 
2.33.0

