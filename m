Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88FF425E2D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 22:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhJGUxn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 16:53:43 -0400
Received: from mail-mw2nam10on2060.outbound.protection.outlook.com ([40.107.94.60]:57696
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231366AbhJGUxn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Oct 2021 16:53:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPsogznjrV0aLxFfIlXVP2CaxUzMRt0dfJP/ag/jiUoRJFJQy/xUNJb87KaPjltKWmrQho0nu2yHfGH6IsnsG/5PZR3F50PkP8gPoW9R4p2kPzSvZRpBlsxoJtR58UF1milyg3g2FloHu/oFCrJs45Lt8+CIapQ8BXfKEM9ygIQU7LfAK6yF2bUtRDHmMyLF+ppIs5RhHAdyaitgmgcQDQIeEmevsZhnAJPtYEuUn4cbYtIdpSx2ESpinollBCK3/mpAttYBFVRSH0vn6MQQsRvxtQIlhCdUnSdMihFKNMRZE+A8CwvcmkX4jRKcbroUzNQ7KXJefuIgfN86+oGxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YZCTkiWi6e5vQPZ6fDh95xvsJUXHqsajZ4ziULPkRiQ=;
 b=WVJu8JRd76uZ3oLgFkTtd7Xyj60W/Ls8zoLi1YgYyi36TCanDAFvPZNslSy+2un2dsJ4YOQ6SWYd4zs6jV+L3En/scBoRGhTEPj1Eu8H9jXEmzeGR0sjaRXS7kTVTkS7yRm08/O5io7w2qWERbHBTqQfIX/IMNGFbNF+Y3F3llW1J4AFICBFePIuQ5NRu8tVBTWvcSmZ39BRTbp9LeTsohoUobqV6xF/LzN0CMhHGoOwodrh9XngkfBb3PJqXUEhHtHwc1qvRDtiExz2bRcHqHvT3UTCfYCR93bQR+Qltm9IqIqlzr//SGJyHE99+K2IbTsVo/EH8bulAMr+Ej0HpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rjwysocki.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZCTkiWi6e5vQPZ6fDh95xvsJUXHqsajZ4ziULPkRiQ=;
 b=Jibr+DT03gAPQNQNyTfw96JqDFVpPuBj/LmaWXPdUSEz2wkHWe7tkQsZVpUxIBmjPZad+i6aPrEtPpKaCgFOkFahyWO6Upo2rZWtVal2TuMbZ0GmgXoXiqqeI57O01dO/be8I9dxmZ6qmWbET6CsUvbFaUHk/wzLL8jieLwyPXQ=
Received: from MWHPR13CA0025.namprd13.prod.outlook.com (2603:10b6:300:95::11)
 by BN6PR12MB1506.namprd12.prod.outlook.com (2603:10b6:405:10::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Thu, 7 Oct
 2021 20:51:43 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::3) by MWHPR13CA0025.outlook.office365.com
 (2603:10b6:300:95::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend
 Transport; Thu, 7 Oct 2021 20:51:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Thu, 7 Oct 2021 20:51:43 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 7 Oct 2021
 15:51:41 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: [PATCH] PCI: Put power resources not tied to a physical node in D3cold
Date:   Thu, 7 Oct 2021 15:51:26 -0500
Message-ID: <20211007205126.11769-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19d9b98a-d8f8-45a1-5928-08d989d444e8
X-MS-TrafficTypeDiagnostic: BN6PR12MB1506:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1506A2F0C6C6967B1018254AE2B19@BN6PR12MB1506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHNBzLqAEQLKNEwqq6kN9pCRh0omJjylJdFc2lmuJSaSdnOzlx7JxNSZxXt6a9E0/FzygzZIL34AajPqwWVEOGQZazsePKPZc/8J/85x1uKbe5bkFCZ08nLGT0c4/qALwshGK2VUChY3VyY1kcfSonGjOMA6D1YUcyoLbBtLYXGQzDmMHjKLPPqw4vmsk/TbWPUx1QyfY5ZPbRYoRfbmAOMVMfXlOI61vSgefZP23sioPHw0RyVlsMiJUW2GGkeNK9eHtamvwx5TLK9GLVtZUfM6xcltqyDVPyqLJM88bqmiasyumWHybjX2UZ0u3uQc0tSnV6+pr0/M+tQ/NXawH5Kzx3SnsOMMmIsska4bD0hz/1Uyw11nAhxn2k/HvZFQLNWzpQ9DDf6TxO9xXYnXZApiMYEY8kdF17+4GaQsfTcEIJH8wtblMzlquJWAZTe8EVusKEYpwc5jAKhORSbbcJQTNtT3NBAE3fsido9XVJ2eI3uqZuNUJu8hLdQu9v9E+48h8sMf9v9/rM9whJjd0GeMYGPl6cLxBWDsGAnW1JVbsV69P+MF8FzjSo4+vDWjpXua5jY+ggS2gcVTAoNkUYfsFxD6+yPwiQrRxtZ9Mxljx3izY8F7Bp+DfY6qQzDNWU3YRSe/haolSs6frZrRDQTU/tB20kT4xAt8vLNNkNd8YHnoYiLQCNfR7Dqv1AZdYrHC4KIXLJ4v2o3SqjHZ5Wci0hvSiSdBym953kdIMQp15XQYY1bGJmvUam+UPl9+MC/bZU7OeiFQPycp2SzYavKu9nlI6ZzdBRd7q0WktLQLksEz6L1iCKRt1ebFWHHidTMSj0O7AQoHNWKhogJQ4wjU7upYXCg+29lFmzNvhf5F+9/Kj+vAx5UR2cCrfGwZ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(47076005)(83380400001)(7049001)(82310400003)(2616005)(6200100001)(1076003)(36860700001)(81166007)(70206006)(966005)(86362001)(356005)(36756003)(508600001)(6666004)(16526019)(26005)(37006003)(186003)(54906003)(2906002)(6862004)(5660300002)(4326008)(336012)(426003)(70586007)(8936002)(7696005)(8676002)(44832011)(316002)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2021 20:51:43.0126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d9b98a-d8f8-45a1-5928-08d989d444e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1506
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I found a case that a system that two physical SATA controllers share
the same ACPI Power Resource.  When a drive is connected to one of
the controllers then it will bind with PCI devices with the ahci driver
and form a relationship with the firmware node and physical node.  During
s2idle I see that the constraints are met for this device as it is
transitioned into the appropriate state. However the second ACPI node
doesn't have any relationship with a physical node and stays in "D0":

```
ACPI: \_SB_.PCI0.GP18.SATA: ACPI: PM: Power state change: D0 -> D3cold
ACPI: PM: Power resource [P0SA] still in use
acpi device:2a: Power state changed to D3cold
```

Due to the refcounting used on the shared power resource putting the
device with a physical node into D3 doesn't result in the _OFF method
being called.

To help with this type of problem, make a new helper function that can
be used to check all the children of an ACPI device and put any firmware
nodes that don't have physical devices into D3cold to allow shared
resources to transition. Call this helper function after PCI devices have
been scanned and ACPI companions have had a chance to associate.

After making this change, here is what the flow looks like:
```
<snip:bootup>
ACPI: \_SB_.PCI0.GP18.SAT1: ACPI: PM: Power state change: D0 -> D3cold
ACPI: PM: Power resource [P0SA] still in use
acpi device:2c: Power state changed to D3cold
<snip:suspend>
ACPI: \_SB_.PCI0.GP18.SATA: ACPI: PM: Power state change: D0 -> D3cold
ACPI: PM: Power resource [P0SA] turned off
acpi device:2a: Power state changed to D3cold
```

Link: https://lore.kernel.org/linux-acpi/0571292a-286b-18f2-70ad-12b125a61469@amd.com/T/#m042055c5ca1e49c2829655511f04b0311c142559
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=214091
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/device_pm.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c      |  5 +++++
 include/acpi/acpi_bus.h  |  1 +
 3 files changed, 40 insertions(+)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 0028b6b51c87..0fb0bbeeae9e 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -149,6 +149,40 @@ static int acpi_dev_pm_explicit_set(struct acpi_device *adev, int state)
 	return 0;
 }
 
+/**
+ * acpi_device_turn_off_absent_children - Turn off power resources for
+ *					  children not physically present.
+ * @parent: ACPI bridge device
+ */
+int acpi_device_turn_off_absent_children(struct acpi_device *parent)
+{
+	struct acpi_device *adev;
+	int ret = 0;
+
+	if (!parent)
+		return -EINVAL;
+
+	list_for_each_entry(adev, &parent->children, node) {
+		int state;
+
+		if (!adev->flags.power_manageable ||
+		    !adev->power.flags.power_resources)
+			continue;
+		if (acpi_get_first_physical_node(adev))
+			continue;
+		ret = acpi_device_get_power(adev, &state);
+		if (ret)
+			return ret;
+		if (state == ACPI_STATE_D3_COLD)
+			continue;
+		ret = acpi_device_set_power(adev, ACPI_STATE_D3_COLD);
+		if (ret)
+			return ret;
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(acpi_device_turn_off_absent_children);
+
 /**
  * acpi_device_set_power - Set power state of an ACPI device.
  * @device: Device to set the power state of.
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 79177ac37880..1a45182394d1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2939,6 +2939,11 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 		}
 	}
 
+	/* check for and turn off dangling power resources */
+	for_each_pci_bridge(dev, bus) {
+		acpi_device_turn_off_absent_children(ACPI_COMPANION(&dev->dev));
+	}
+
 	/*
 	 * We've scanned the bus and so we know all about what's on
 	 * the other side of any bridges that may be on this bus plus
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 13d93371790e..0eba08b60e13 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -510,6 +510,7 @@ int acpi_bus_get_status(struct acpi_device *device);
 
 int acpi_bus_set_power(acpi_handle handle, int state);
 const char *acpi_power_state_string(int state);
+int acpi_device_turn_off_absent_children(struct acpi_device *parent);
 int acpi_device_set_power(struct acpi_device *device, int state);
 int acpi_bus_init_power(struct acpi_device *device);
 int acpi_device_fix_up_power(struct acpi_device *device);
-- 
2.25.1

