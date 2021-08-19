Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511083F228D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 23:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbhHSV5x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 17:57:53 -0400
Received: from foss.arm.com ([217.140.110.172]:47484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhHSV5x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Aug 2021 17:57:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EC751042;
        Thu, 19 Aug 2021 14:57:16 -0700 (PDT)
Received: from u200856.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74E593F40C;
        Thu, 19 Aug 2021 14:57:15 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, sdonthineni@nvidia.com,
        stefan.wahren@i2se.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 0/4] CM4 ACPI PCIe quirk
Date:   Thu, 19 Aug 2021 16:56:51 -0500
Message-Id: <20210819215655.84866-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PFTF CM4 is an ACPI platform that is following the Arm PCIe SMC
(DEN0115) standard because its PCIe config space isn't ECAM compliant
since it is split into two parts. One part describes the root port
registers, and another contains a moveable window pointing at a given
device's 4K config space. Thus it doesn't have an MCFG table. As
Linux doesn't support the PCI/SMC, a host bridge specific _DSD is
added and associated with custom ECAM ops and cfgres.  The custom cfg
op selects between those two regions, as well as disallowing
problematic accesses.

V1->V2:
	Only move register definitions to new .h file, add
	     include guards.
	Change quirk namespace identifier.
	Update Maintainers file.
	A number of whitespace, grammar, etc fixes.


Jeremy Linton (4):
  PCI: brcmstb: Break register definitions into separate header
  PCI: brcmstb: Add ACPI config space quirk
  PCI/ACPI: Add Broadcom bcm2711 MCFG quirk
  MAINTAINERS: Widen brcmstb PCIe file scope

 MAINTAINERS                                |   2 +-
 drivers/acpi/pci_mcfg.c                    |  13 ++
 drivers/pci/controller/Makefile            |   1 +
 drivers/pci/controller/pcie-brcmstb-acpi.c |  74 ++++++++++
 drivers/pci/controller/pcie-brcmstb.c      | 150 +-------------------
 drivers/pci/controller/pcie-brcmstb.h      | 155 +++++++++++++++++++++
 include/linux/pci-ecam.h                   |   1 +
 7 files changed, 247 insertions(+), 149 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-brcmstb-acpi.c
 create mode 100644 drivers/pci/controller/pcie-brcmstb.h

-- 
2.31.1

