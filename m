Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7878F5C467
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 22:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfGAUpR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 16:45:17 -0400
Received: from xes-mad.com ([162.248.234.2]:29045 "EHLO mail.xes-mad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfGAUpR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 16:45:17 -0400
Received: from asierra1.xes-mad.com (asierra1.xes-mad.com [10.52.16.65])
        by mail.xes-mad.com (Postfix) with ESMTP id EEDCD202F2;
        Mon,  1 Jul 2019 15:45:15 -0500 (CDT)
From:   Aaron Sierra <asierra@xes-inc.com>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v4 0/3] Improve _OSC control request granularity
Date:   Mon,  1 Jul 2019 15:45:12 -0500
Message-Id: <20190701204515.23374-1-asierra@xes-inc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213213242.21920-1-git-send-email-asierra@xes-inc.com>
References: <20190213213242.21920-1-git-send-email-asierra@xes-inc.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

These patches allow PCIe AER to function in a kernel without
CONFIG_PCIEASPM enabled or with ASPM disabled at run time via
pcie_aspm=off. There is no explicit Kbuild dependency between the two
and there are, in my opinion, legitimate reasons for no implicit
dependency to exist either.

Previously with ASPM:

acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
acpi PNP0A03:00: _OSC: OS now controls [PME AER PCIeCapability LTR]

Previously without ASPM:

acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig Segments MSI]
acpi PNP0A03:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]

Now with ASPM:

acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
acpi PNP0A03:00: _OSC: OS requested [PME AER PCIeCapability LTR]
acpi PNP0A03:00: _OSC: platform granted [PME AER PCIeCapability LTR]

Now without ASPM:

acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig Segments MSI]
acpi PNP0A03:00: _OSC: OS requested [AER PCIeCapability]
acpi PNP0A03:00: _OSC: platform granted [AER PCIeCapability]

This is v4 of the patchset, which includes these changes from v3:
  * Factored non-functional output change into own patch (0001)
  * Factored non-functional introduction of inline functions into
    own patch (0003)

Aaron Sierra (3):
  PCI/ACPI: Homogenize _OSC negotiation output
  PCI/ACPI: Allow _OSC request without ASPM support
  PCI/ACPI: Refactor _OSC request bit setting

 drivers/acpi/pci_root.c | 109 +++++++++++++++++++++++++++++-----------
 1 file changed, 80 insertions(+), 29 deletions(-)

-- 
2.17.1

