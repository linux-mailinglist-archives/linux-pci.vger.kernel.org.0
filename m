Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B110C38212E
	for <lists+linux-pci@lfdr.de>; Sun, 16 May 2021 23:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhEPV1a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 May 2021 17:27:30 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:40455 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229600AbhEPV1a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 May 2021 17:27:30 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 May 2021 17:27:29 EDT
Received: from copland.sibelius.xs4all.nl ([83.163.83.176])
        by smtp-cloud8.xs4all.net with ESMTP
        id iOA9lJWwKWkKbiOAAlkPqJ; Sun, 16 May 2021 23:19:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1621199946; bh=1+zNzYaekEI6LowqbJIIfmttJzkR4J3dpjnqx+BQ46Q=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:From:Subject;
        b=JyGl58Bya86gQ8HQUMWIuf0DLYyMpPZ1D/Afd/i1j3lUDYUGqhj0lPLBBzv31V38a
         kx+M7tWg/igm2RqJV7lRpLEIC5YT4Yi14UQZMlXiCaF0v8MOKcNQJw9j0ZfGAb+o6m
         qMofk2wcpwrxSrRlcIrEoWr2UleS4sFo38VUKeEavRlUj6lbDLoVKHGoai6vZX1fvC
         iNqf8sicsPSRWZosRjioqs3AcJoLooNYUudAYRcV3aV55yXiCj7SqFto/hU7GiDn98
         3kavto4ZAZA0lQra5rCSMRga8KFqGe5OmaX+4j6Jlfo6x9ZmxnMPz5SV0AvLzr1uHF
         qztadK2ysqEiQ==
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     devicetree@vger.kernel.org
Cc:     maz@kernel.org, arnd@arndb.de,
        Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Apple M1 PCIe DT bindings
Date:   Sun, 16 May 2021 23:18:45 +0200
Message-Id: <20210516211851.74921-1-mark.kettenis@xs4all.nl>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJiHI2l9RTHm3qxrVyeOIGcmaqvKJeZGxTWKXxrtrQLTfs7o5p5UhmxDyW66fWImczopUkFQV4yzFaPibreJfR2PJ1G/aoDoL6xm9AqmRgTnW2LshxE5
 GEmigu7bvzEuecyGcq+QjNHCONjtEg0sw3mkRsb6Z2Hn0KonnlAM98EasnBSBNnUmaFJFD0FFYp8bkSBComXhD0k+aS4fFHtVsJfs5ngHPJEawjTBYjZvryS
 8EFQcU5IGD5OCidvywtMrRrlGAkYBUJYSZbXgQ9JsmeOdsg+uOuPjeV2ziGbw12haOis/ZJPg0pHEph9DXOKxZwY2TFberLRgss5OahgadkVXhs/cNKQ6AWd
 iNUeCwrHwPyPyIWmqNDGbymFmyvDH+8ThFVwqwWKwVYQjIrEsErchyAHcDwrIsMzZ2VuZI6fupI/aHW0AlPni2y6tRz63OQN4eUC3APZhWSq37t/bEMKd9Vf
 w//BXkLHvqXAN4brbRS9ZUBscElABHHME+qBqA9471leJDlfndGlDRdXb0g=
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

These series depends on the pinctrl series I sent earlier (with a v2
respin today).


Mark Kettenis (2):
  dt-bindings: pci: Add DT bindings for apple,pcie
  arm64: apple: Add PCIe node

 .../devicetree/bindings/pci/apple,pcie.yaml   | 150 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 arch/arm64/boot/dts/apple/t8103.dtsi          |  64 ++++++++
 3 files changed, 215 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml

-- 
2.31.1

