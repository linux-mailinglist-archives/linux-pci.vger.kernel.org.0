Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A8D3D55BD
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jul 2021 10:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbhGZH7O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jul 2021 03:59:14 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:50795 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231728AbhGZH7O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jul 2021 03:59:14 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2021 03:59:13 EDT
Received: from copland.sibelius.xs4all.nl ([83.163.83.176])
        by smtp-cloud9.xs4all.net with ESMTP
        id 7w2DmOzH54Jsb7w2EmW9Mp; Mon, 26 Jul 2021 10:32:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1627288350; bh=aj0DzTZBIxsexmhMpHw/owBjAQ/ySL4SOuHiY/ftDuQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=nLK+JyAPuW8TLciSMMU18MR4Dviz2di0rbveBUZTOX56W6zCXdjLBtrVDlGxtlyBL
         CH6MWD/KWITle4r2lS8oQ2dsKE/JnvpkkkmVznwD2BFYstl+3V0pmVBZkx2W2ElJIN
         7QgQsLxZvsZm7U8o+tMSOFH0KsjO+q6yJ41DfvFqQRB2yUr85Qv0aZ6pf5Nw+J4OpM
         LcqR6LZ3r25AtyFEXyju4Ll8Uzh9R9UiO6k8kf3A4Magsx0BU6w0/Nx93SU8lLoE7T
         xXmbJB6wHOl7mnrVQ8iWfkr1wzNwM3WATYYwhhUPawgb/GZuPsub4VkSTL7M8NkIlH
         4zcvTqcrYl4vw==
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     devicetree@vger.kernel.org
Cc:     maz@kernel.org, robin.murphy@arm.com, sven@svenpeter.dev,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Apple M1 PCIe DT bindings
Date:   Mon, 26 Jul 2021 10:31:59 +0200
Message-Id: <20210726083204.93196-1-mark.kettenis@xs4all.nl>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfC5rqQSex9y1nQvPdjLYz3X7h5Q4DGif9oeHclh8nCZpGIdTg9koclwDAVwJ6j3uJUo13ZHnXuCUisnTHy7XVsOoBHL39lwjg4fh33ZdBx7WgcnguKyS
 fyMdN7n7uLsOMB7Do5VLRkEJujzA7SyCC9msk7K4DcTTgARf0DSiTekPkjehPe2rZm66+rcKB9csifgZu/ExdWXeLNNxUnkDGmIlcM+3H8nnkXUslvdj26i6
 EshCJF+ZBEXyCvHz5Rco4raq8PE5+mpkiYkCwzq8ystAbzjQeIPHNL5nshgQoFQKQqKdxYEmU36A2bQ6i/B1d3xjirq+wiGOPU7gazf7YLhwKoNO49APTm29
 ph19JG43no1SEv2IstkRGgs4YW+t22CUKTcn7+ml/SsX1WB63Q8MOlKwlBoV6fAhkEdnBgcnKROljEx9GDoGZAcex1Rtl4DKoEJoOLsMmei+hl9WXwBdSQdm
 ce95TfdKDgF8P6pnfdEBQKXsvC6UBhYqmQ+MRWd1mGfzjL2oAXGNe8OBq4SfcSDtQtahdn9iKJObo4SRg3T2UnM0PyTDbIHodmxLRQ==
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

Patch 2/2 of this series depends on the pinctrl series I sent earlier
and will probably go through Hector Martin's Apple M1 SoC tree.


Changelog:

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

Mark Kettenis (2):
  dt-bindings: pci: Add DT bindings for apple,pcie
  arm64: apple: Add PCIe node

 .../devicetree/bindings/pci/apple,pcie.yaml   | 166 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 arch/arm64/boot/dts/apple/t8103.dtsi          |  63 +++++++
 3 files changed, 230 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml

-- 
2.32.0

