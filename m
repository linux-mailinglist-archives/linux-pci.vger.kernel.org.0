Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F99280D09
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 07:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgJBFRT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 01:17:19 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:34237 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgJBFRT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 01:17:19 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2020 01:17:18 EDT
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id B35CA30000CCE;
        Fri,  2 Oct 2020 07:10:12 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 7CB8449136; Fri,  2 Oct 2020 07:10:12 +0200 (CEST)
Message-Id: <cea9071dc46025f0d89cdfcec0642b7bfa45968a.1601614985.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 2 Oct 2020 07:10:12 +0200
Subject: [PATCH] PCI/ACPI: Whitelist hotplug ports for D3 if power managed by
 ACPI
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Arthur Borsboom <arthurborsboom@gmail.com>,
        matoro <matoro@airmail.cc>,
        Aaron Zakhrov <aaron.zakhrov@gmail.com>,
        Michal Rostecki <mrostecki@suse.com>,
        Shai Coleman <git@shaicoleman.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recent laptops with dual AMD GPUs fail to suspend the discrete GPU, thus
causing lockups on system sleep and high power consumption at runtime.
The discrete GPU would normally be suspended to D3cold by turning off
ACPI _PR3 Power Resources of the Root Port above the GPU.

However on affected systems, the Root Port is hotplug-capable and
pci_bridge_d3_possible() only allows hotplug ports to go to D3 if they
belong to a Thunderbolt device or if the Root Port possesses a
"HotPlugSupportInD3" ACPI property.  Neither is the case on affected
laptops.  The reason for whitelisting only specific, known to work
hotplug ports for D3 is that there have been reports of SkyLake Xeon-SP
systems raising Hardware Error NMIs upon suspending their hotplug ports:
https://lore.kernel.org/linux-pci/20170503180426.GA4058@otc-nc-03/

But if a hotplug port is power manageable by ACPI (as can be detected
through presence of Power Resources and corresponding _PS0 and _PS3
methods) then it ought to be safe to suspend it to D3.  To this end,
amend acpi_pci_bridge_d3() to whitelist such ports for D3.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1222
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1252
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1304
Reported-and-tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
Reported-and-tested-by: matoro <matoro@airmail.cc>
Reported-by: Aaron Zakhrov <aaron.zakhrov@gmail.com>
Reported-by: Michal Rostecki <mrostecki@suse.com>
Reported-by: Shai Coleman <git@shaicoleman.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci-acpi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index d5869a0..d9aa551 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -944,6 +944,16 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	if (!dev->is_hotplug_bridge)
 		return false;
 
+	/* Assume D3 support if the bridge is power-manageable by ACPI. */
+	adev = ACPI_COMPANION(&dev->dev);
+	if (!adev && !pci_dev_is_added(dev)) {
+		adev = acpi_pci_find_companion(&dev->dev);
+		ACPI_COMPANION_SET(&dev->dev, adev);
+	}
+
+	if (adev && acpi_device_power_manageable(adev))
+		return true;
+
 	/*
 	 * Look for a special _DSD property for the root port and if it
 	 * is set we know the hierarchy behind it supports D3 just fine.
-- 
2.27.0

