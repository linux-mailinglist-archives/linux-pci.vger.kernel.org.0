Return-Path: <linux-pci+bounces-11443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C773494ACA0
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 17:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462521F225EF
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 15:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242118172A;
	Wed,  7 Aug 2024 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d7RpIq9J"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6830179949;
	Wed,  7 Aug 2024 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043880; cv=fail; b=mlOezDD797LeNrzexHIjFoml+Tktw82V1F1Q9MN/DdRDFqVsf/BKOhHlgJqzqUMtFSgHKrdiw/KisNSKJx1F0h1gnno3jOSnn563hA3ZemwMlBBSbakzY3lOLb4SGnirlJpUOP6+pH8ZMuDfFUHiO7FtBUY5C5AvOhtio8yB5TA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043880; c=relaxed/simple;
	bh=WTGaoKLGmKcpdor9RtT2osJ8c+CnhFELP9JCBrzCLc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qw9ACNVPEp04x2LGGZssOrfyOKFXoq7Pq8Ju99MBsbHTn0xOucf7Ki/y05CahrdIwSeqxLTXGcfYo5T++53mNWTAcjyaYWF8B4fni+CwKJLqigCyx05lpCy9w5cwmhullfP4kRs5q6DQTCd831yyilowUqeEpICaNE7OaCCd6Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d7RpIq9J; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kSm33aT1FZG2qX3OjEfbYlAcW84t5UEVva1cf04VIXLSK8lgafOH9BJkueC+/A0oaFcC2Q64e5JHeSXw+ZxL8MgGUH4a2+XAJNEu3xRI56r/UquHqaKFDPddtLqce5J5+3JQ3dplr0UzCx6Nwac7tCBUnLZd2hzIOC4QoOnLOyqFS+NsMildC7wyoWJ/aF+uMLO79LpvboX8z1pmo1rq2d1sQZSjsG/7ILxSkjHlOk42sy8rEuFjdQisAtjuvRCYrOa/1VP7fr6ktZfLP9y0O/XgpdhuCJLUWVhfxerHJJK12ko172RQ3jyaZPAhoD3pFRXxwyLm7OUAbj1f/V1zTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoRPZSlQUrXffMRiUvvcx0DN3xHbVWz/kyrltfBIZ4M=;
 b=Wzqa4vA6fbkCkV0iuh26F5B9T8g9idXCuHMJNGzzkDBhFYB4th5KPkX3zQbcTusVAE4tKa006Ytp698u74IbwerG4+NAZD3Ma4oQ4ULbyT/4CwQUB315m6lATNtgT2H5Lsw2VZuMjpt8LLLEKO1LjC4GRjhJDtOdmS0ldtXEWvFEt+7JuvPBO0STpr8VkQRpz2ciXWZbFO+IosfCWxFKX1Izhk/SCPX/cq5FvfK+KalzWg6hTbEz2vcWfUJcVg6Izl3TkbZF+7un6Odf0u0AZ/myYp0CrZkWcLrwBsNjRpgpSTEOc+KkvH/i+Iba4lb/Alk3HpVjvs0UKCgm1NFu9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoRPZSlQUrXffMRiUvvcx0DN3xHbVWz/kyrltfBIZ4M=;
 b=d7RpIq9J4Nwei9LOevUyftOgEY5NZSt4h8rso9SC0TIr5VkY02Zg+KcWeqBqq6K7TRjVwfuPpDsKP1Kvh1AoJKpzYFq8mCRe2B7lSH+nsaWM2d89Ixw8p6+msZR7EOldI6kS+TyTPzErY2ZDIJQEA7hpfsG5rGjeYCebM7F/ry4=
Received: from DM6PR07CA0105.namprd07.prod.outlook.com (2603:10b6:5:330::8) by
 PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 15:17:55 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:330:cafe::b) by DM6PR07CA0105.outlook.office365.com
 (2603:10b6:5:330::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Wed, 7 Aug 2024 15:17:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 15:17:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 10:17:54 -0500
Received: from ubuntu.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 10:17:53 -0500
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Stewart Hildebrand <stewart.hildebrand@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/8] PCI: Restore memory decoding after reallocation
Date: Wed, 7 Aug 2024 11:17:13 -0400
Message-ID: <20240807151723.613742-5-stewart.hildebrand@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807151723.613742-1-stewart.hildebrand@amd.com>
References: <20240807151723.613742-1-stewart.hildebrand@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH0PR12MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce2b8c4-72b3-43e6-c032-08dcb6f41c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K0ZkAQ6XYhJhkIP+wTzbuCMpQred85Xfj8kSQrOUU1f5yMVcPiCxcnnkkfbm?=
 =?us-ascii?Q?J9LuZr19Xq3TdvchlR1t29GkNNp8W1O9YKv0sP5SU2zI1gp3Smf1U8HGeoZM?=
 =?us-ascii?Q?qqTg0giayi68gUGb+XJ3gIqDhW1/sAwn21jqZpPiwVBHSKOXLs+fmiczUGMk?=
 =?us-ascii?Q?fp9rORAdgNw5FC8xM0XQV7s6wO2PeRhlTTNIXgi4Ku7l4QEK9Q8l2GnN2bgN?=
 =?us-ascii?Q?tKkvqDEB2skCqwRBwarRPDseiKwRaYQg6H3Rdi8Kzxs0T/TzxckyWdDkX7nC?=
 =?us-ascii?Q?hMSaZujCg6BPm4S/NIct+3PXh3aGEXvirnySjKWSYcM/QG5tuRwmtXjYero0?=
 =?us-ascii?Q?PHslU5RMzBx7Ky/ClYFVsDY3MBidfFI/F7WVsrhCoKLYs1cepPJxvrTHfl2V?=
 =?us-ascii?Q?DJWSQsDqIUwJqKuyjwW+9KAR95tLk+283NIJzM2erWL55HCJWm1/xRVaYRSR?=
 =?us-ascii?Q?+LazLp53sIqKmFp78twL+RiiIkEQInsiW/ml7rjikF/pRWYA0rr2bO49dW4B?=
 =?us-ascii?Q?Jg5phG9vYtc+O3dEzIRBXnjzkm2hAIEhjgiSDkeEQeY+s0Y7ihhBwtCW7zk0?=
 =?us-ascii?Q?VPkmVF14JyfKlWLmVA8zGsQJoa48kKHQQKxCVav4qvVm+Uzx76dWiyghjtsW?=
 =?us-ascii?Q?205kYyt/caEPQrKBE4qU0U5rJvYbd9SvYbBNc22pT9XPbOpmzjzyH8l0wkqa?=
 =?us-ascii?Q?FctZgg3AeVYU9MXICLLL52Km3wfR9RNM/m9oRrb9bMoSP/uuymnyzpyQpXrm?=
 =?us-ascii?Q?W7SX4r7AKUCvAKezygXVHG2C4/3cuSnNoySDjZcIw5vtt7nJF0voAkyvZlNa?=
 =?us-ascii?Q?JLdtR10i6vl0BWgiMEaFPnsDIQsaFk9baR1xM9dEpyt0ucFzidzb6nQqOcHV?=
 =?us-ascii?Q?oXRaqS/aUgPXGqcX6tosINSiqgomx3wi55cHGZwfxIRtu+vxPyfHH1bzXDzb?=
 =?us-ascii?Q?wTFo5SRMiDIOefIsNYRW4j+PLvU+6D651tZS1cDr9dYUwB/POeI9aLDq1JfA?=
 =?us-ascii?Q?vZpB7Nf/+/hUFPJulqpEzievR7kn/08eivc6cYboVNEdbgAyIxez+smQb+rB?=
 =?us-ascii?Q?f8wSirKiurggPIBqx5I0LDWSbOd9YgjV1uELoCtM39ss2N6BY7qXyPzbsg9H?=
 =?us-ascii?Q?isTP4duiywXInB5p91/vEwVdY/rOtJ5qfVPT79MduWoUauHumKEPneInuqdM?=
 =?us-ascii?Q?8BAlLkdO09RttMs2KW3ktqpIvsQMYEIOa034PWWYeHNNwe4H/Ovfu39dpzJ0?=
 =?us-ascii?Q?rpf9Zac5Y75mR2mDk4u0LbOB5OdJY+pG6q9/JEhSKWWMN6kWS+cN93wK0CFg?=
 =?us-ascii?Q?LAgBBoR0NstfC9jo63nMlCX+z3S+MwDd34s3vq199Rs0xWD4T1+z8IjuMSwZ?=
 =?us-ascii?Q?Wn8TJuStDECa2DMMn5K+/n2uNdku9N/gIIHhzBQvVGXNgnaySQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 15:17:54.7049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce2b8c4-72b3-43e6-c032-08dcb6f41c9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798

Currently, the PCI subsystem unconditionally clears the memory decoding
bit of devices with resource alignment specified. While drivers should
call pci_enable_device() to enable memory decoding, some platforms have
devices that expect memory decoding to be enabled even when no driver is
bound to the device. It is assumed firmware enables memory decoding in
these cases. For example, the vgacon driver uses the 0xb8000 buffer to
display a console without any PCI involvement, yet, on some platforms,
memory decoding must be enabled on the PCI VGA device in order for the
console to be displayed properly.

Restore the memory decoding bit after the resource has been reallocated.

Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
---
v2->v3:
* no change

v1->v2:
* capitalize subject text
* reword commit message

Testing notes / how to check if your platform needs memory decoding
enabled in order to use vgacon:
1. Boot your system with a monitor attached, without any driver bound to
   your PCI VGA device. You should see a console on your display.
2. Find the SBDF of your VGA device with lspci -v (00:01.0 in this
   example).
3. Disable memory decoding (replace 00:01.0 with your SBDF):
  $ sudo setpci -v -s 00:01.0 0x04.W=0x05
4. Type something to see if it appears on the console display
5. Re-enable memory decoding:
  $ sudo setpci -v -s 00:01.0 0x04.W=0x07

Relevant prior discussion at [1]

[1] https://lore.kernel.org/linux-pci/20160906165652.GE1214@localhost/
---
 drivers/pci/pci.c       |  1 +
 drivers/pci/setup-bus.c | 25 +++++++++++++++++++++++++
 include/linux/pci.h     |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index acecdd6edd5a..4b97d8d5c2d8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6676,6 +6676,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 
 	pci_read_config_word(dev, PCI_COMMAND, &command);
 	if (command & PCI_COMMAND_MEMORY) {
+		dev->dev_flags |= PCI_DEV_FLAGS_MEMORY_ENABLE;
 		command &= ~PCI_COMMAND_MEMORY;
 		pci_write_config_word(dev, PCI_COMMAND, command);
 	}
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index ab7510ce6917..6847b251e19a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2131,6 +2131,29 @@ pci_root_bus_distribute_available_resources(struct pci_bus *bus,
 	}
 }
 
+static void restore_memory_decoding(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *b;
+
+		if (dev->dev_flags & PCI_DEV_FLAGS_MEMORY_ENABLE) {
+			u16 command;
+
+			pci_read_config_word(dev, PCI_COMMAND, &command);
+			command |= PCI_COMMAND_MEMORY;
+			pci_write_config_word(dev, PCI_COMMAND, command);
+		}
+
+		b = dev->subordinate;
+		if (!b)
+			continue;
+
+		restore_memory_decoding(b);
+	}
+}
+
 /*
  * First try will not touch PCI bridge res.
  * Second and later try will clear small leaf bridge res.
@@ -2229,6 +2252,8 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 	goto again;
 
 dump:
+	restore_memory_decoding(bus);
+
 	/* Dump the resource on buses */
 	pci_bus_dump_resources(bus);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4246cb790c7b..74636acf152f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -245,6 +245,8 @@ enum pci_dev_flags {
 	PCI_DEV_FLAGS_NO_RELAXED_ORDERING = (__force pci_dev_flags_t) (1 << 11),
 	/* Device does honor MSI masking despite saying otherwise */
 	PCI_DEV_FLAGS_HAS_MSI_MASKING = (__force pci_dev_flags_t) (1 << 12),
+	/* Firmware enabled memory decoding, to be restored if BAR is updated */
+	PCI_DEV_FLAGS_MEMORY_ENABLE = (__force pci_dev_flags_t) (1 << 13),
 };
 
 enum pci_irq_reroute_variant {
-- 
2.46.0


