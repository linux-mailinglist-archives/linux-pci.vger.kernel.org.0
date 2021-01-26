Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E6D3054E0
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 08:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S317222AbhAZXip (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 18:38:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:50318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbhAZWEF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Jan 2021 17:04:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2DDA2065E;
        Tue, 26 Jan 2021 22:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611698605;
        bh=UkV1SPQrNIZuXnp8OvX6KFw+Sn4o0k96KuF4kwb4yrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ae6T1QlI77cXfhemfTp5BOwOIwubfsJI7wsL3V8MPJV9jMN3iOXgyVDC9iuQaqTIY
         KodjHSrP9F6AeE5Q981XYdLC/Lowd/uA6qGvxHEb7J900UZ6PWz3zVQxn0qeoCcIZB
         t46ENDuw/TqxwYatROw+mT+KW7P/K9siVIOWZr9FajKFGcXqBorczE9+rabfFcNIb1
         bjWkAjW5xck/UIsycK9i0b1eht53SK7Z2JvHYsJGiqkLmYTslOoYiTRqeof++fLbHH
         d8sm612NtkqfYK5b8MoMz1FRyr4NMg7Q+NoEBu3JsdT0LZxkSNx3Ca3YHtrHUucD4H
         84RlXbKjKmIow==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Sinan Kaya <okaya@kernel.org>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/3] PCI/ACPI: Clarify message about _OSC failure
Date:   Tue, 26 Jan 2021 16:03:11 -0600
Message-Id: <20210126220311.2925565-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126220311.2925565-1-helgaas@kernel.org>
References: <20210126220311.2925565-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

This message:

  acpi PNP0A08:02: _OSC failed (AE_NOT_FOUND); disabling ASPM

is alarming and slightly misleading.  Per the PCI Firmware Spec, r3.2, sec
4.5.1, _OSC is required for PCIe hierarchies.  If _OSC is absent or fails,
the OS must not attempt to use any of the features defined for _OSC.  That
includes native hotplug, native PME, AER, and other things as well as ASPM.

Rephrase the message to:

  acpi PNP0A08:02: _OSC: platform retains control of PCIe features (AE_NOT_FOUND)

Previous discussion at https://lore.kernel.org/r/20200602223618.GA845676@bjorn-Precision-5520/

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Sinan Kaya <okaya@kernel.org>
Cc: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/acpi/pci_root.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index a001f8f56b4b..6950a35a5ac7 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -441,9 +441,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		if ((status == AE_NOT_FOUND) && !is_pcie)
 			return;
 
-		dev_info(&device->dev, "_OSC failed (%s)%s\n",
-			 acpi_format_exception(status),
-			 pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
+		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
+			 acpi_format_exception(status));
 		return;
 	}
 
@@ -499,7 +498,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	} else {
 		decode_osc_control(root, "OS requested", requested);
 		decode_osc_control(root, "platform willing to grant", control);
-		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
+		dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
 			acpi_format_exception(status));
 
 		/*
-- 
2.25.1

