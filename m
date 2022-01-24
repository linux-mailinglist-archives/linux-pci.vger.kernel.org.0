Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62ED0497F30
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 13:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238240AbiAXMVW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jan 2022 07:21:22 -0500
Received: from mail-dm6nam12on2079.outbound.protection.outlook.com ([40.107.243.79]:2401
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231180AbiAXMVV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Jan 2022 07:21:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJGLKdViOec0G6bLV6bFet7CKP5NILl1sdj3wOdjHVDy+B88ZvSEoMYTPUn4z3xlPHmPVwvPlHNpsWOZkw72kWz/0HJNd5hy2R4UQDILjbSg0zb2/p2M2f0OkyWNdy0ubQSVszMXohW+MhkIzwPl7U2BohAduZMf1F62qqhoJDJsjGHUYWi19gNW7Q5tIudWIzUy5qogkMHO8VxgTn3qvxgljnLdcdfn0wGQz5HDxub/RSq3Hyewn+UQY6KoW8yNq1kHQw+mnZNUSX5UNbbF2sML3asreS/GQQMQtfJfDdgyFn6pGUFUlyOJlnW9UcJzxTBYIS0/7+pt6tHgS3EBsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeXOPqj7ZkbddF/deGJ0C/kG3ctWNz+320Z7MSvWFok=;
 b=DRM4v4sw4YunJttJgBN892XtRgt8C0YueKJVHjlAQp2O+Lqz5vxRJKHsk0clvYg8KiwJMuGXF4fBMs24hHuE6ONfDG35Zc3vWHS9zAcYwlpkX+YlKgvn7WpZzmddOrU09vdA7Gmj+oZQFspkALW4VE9sZVXQVUpFt/hLtN4kDCH5+mxFMW7ehSAmSdswhKY5HMz5dBsZ3tQ/bjJlgVW7jkGwbodghJlsr2eerWtdWNV0n2VUIMeix5gu8DlcrK2EjN13AvdngDqTI6YzATh9M53yh9mGraBibZEHbiv521NS/bZk5q+RE+xntZg5vL8llZVb6Qp3GS8hhbS09VO3Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeXOPqj7ZkbddF/deGJ0C/kG3ctWNz+320Z7MSvWFok=;
 b=qdJ+goK2AHeCtLzceiu+dJnqLSM2HPhsBJZENW8RzLyHJ9D1Uybv+H8TZLKFA3WVDrDUHYhNe5a6hqDA14L7nEfc3t6Le+IG/0IQk0konh5SsayqZMeYRprdR3qfDsRhjrqP8dBYyvqQVH99X63/HJmUoQgN2K1ps0B6zHIcPkRU6po4JaJrQgpE1otsQeIjcCakGL1GDLJvhaXW5VcgqvqWy5QxdiIg6ymcgCuFwm9BxFXONloOZGWgucJlRsNdIZMyncoQcvzaSVder4pqqGkO4rRjHFFrupq9vOE47uU4Bhx7IBS6uZv3RuwoT/8ytKkC7n6boyoviW9ehLleCA==
Received: from MW4PR04CA0142.namprd04.prod.outlook.com (2603:10b6:303:84::27)
 by BN8PR12MB3300.namprd12.prod.outlook.com (2603:10b6:408:6a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 12:21:19 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::ea) by MW4PR04CA0142.outlook.office365.com
 (2603:10b6:303:84::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Mon, 24 Jan 2022 12:21:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Mon, 24 Jan 2022 12:21:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Mon, 24 Jan 2022 12:21:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9;
 Mon, 24 Jan 2022 04:21:18 -0800
Received: from nvidia-Inspiron-15-7510.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.986.9 via
 Frontend Transport; Mon, 24 Jan 2022 04:21:16 -0800
From:   Abhishek Sahu <abhsahu@nvidia.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Abhishek Sahu <abhsahu@nvidia.com>
Subject: [PATCH] PCI: Fix the ACPI power state during runtime resume
Date:   Mon, 24 Jan 2022 17:51:07 +0530
Message-ID: <20220124122107.12148-1-abhsahu@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c62bdb8e-a2d6-479e-f628-08d9df3406e7
X-MS-TrafficTypeDiagnostic: BN8PR12MB3300:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3300EF7B8E3B30415AF7CA5DCC5E9@BN8PR12MB3300.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oTFrS66Rqlcp+lRcFld+r8W4C9wAdCW6q54wb62NJtNwYHuZinbKVZGeCs+RzUhyNxbDLiv0Rz2KO5Ock1HCi00rRE94pcWNN6Usb7f4dVuQYnJJNVD96FK09Go4wq/VLCheqhg+szojcjIgho3g139KODlkTRnq2VmxZl8UNr1c3Hzq9ONLm2PlVwn6YWi9Ey/h7v7ez8fOXEjYeEyjpwIb9de11vGPdjKHnn+zdr9Wxig+EZXICFhjlV33Ck5XpV5Ki7ET+4V4MHlNEs3gW4bUa7hmED+0IwtW7WdN6QFhXR32l3dj8UOylrMdJE6NTh7i4Ys0JnndhuqgM9OdghDRuqeulkk9a/1KNlcSwLp+uxbb0GOaKfkynoQjHSZZLkJdApqjDGLRNjlxuEBj6HszOqTPGdCW7t7MoTLEuJrwdughdGQhl8glGUWGReDyvDtmvj1oxJlTUMU/EqDpmZN1jSKGk2DLM4yUHJ3x+DWfafdOZIyv0DP9CytMIoMPYkbZuSVo0kH+jMH3djKNZdqKLTstCk0oMPNtS8+apzekDkG/JB6yjt9BaOyk0n2N7I5knKf4C3KrxEOzaIqTmHq9bBS1rnxTvgTIf2eds8vCTqCpYyyudv2F4647BJ9jQPbA4ikLYCu1xNPj4RQaaeA125iuYtZ4mKOjPMxw2/h32kFihr+bX0w+W8g8aQa9F73eGQA6Il/NDI3YTVf44GtM5n5D8mKyQ4/BXZEYSps9+GVobDuUC/KcaJFPKLJRsZlRDXVZ2dKIwHaHOcq89pwd1Pe53gMXXt/zybykQzM=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(36840700001)(40470700004)(46966006)(7696005)(426003)(26005)(4326008)(70206006)(86362001)(1076003)(107886003)(82310400004)(6666004)(8936002)(54906003)(70586007)(508600001)(336012)(47076005)(40460700003)(186003)(356005)(8676002)(2616005)(36860700001)(83380400001)(5660300002)(36756003)(81166007)(2906002)(316002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 12:21:19.5700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c62bdb8e-a2d6-479e-f628-08d9df3406e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3300
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Consider the following sequence during PCI device runtime
suspend/resume:

1. PCI device goes into runtime suspended state. The PCI state
   will be changed to PCI_D0 and then pci_platform_power_transition()
   will be called which changes the ACPI state to ACPI_STATE_D3_HOT.

2. Parent bridge goes into runtime suspended state. If parent
   bridge supports D3cold, then it will change the power state of all its
   children to D3cold state and the power will be removed.

3. During wake-up time, the bridge will be runtime resumed first
   and pci_power_up() will be called for the bridge. Now, the power
   supply will be resumed.

4. pci_resume_bus() will be called which will internally invoke
   pci_restore_standard_config(). pci_update_current_state()
   will read PCI_PM_CTRL register and the current_state will be
   updated to D0.

In the above process, at step 4, the ACPI device state will still be
ACPI_STATE_D3_HOT since pci_platform_power_transition() is not being
invoked. We need call the pci_platform_power_transition() with state
D0 to change the ACPI state to ACPI_STATE_D0.

This patch calls pci_power_up() if current power state is D0 inside
pci_restore_standard_config(). This pci_power_up() will change the
ACPI state to ACPI_STATE_D0.

Following are the steps to confirm:

Enable the debug prints in acpi_pci_set_power_state()

0000:01:00.0 is PCI device and 0000:00:01.0 is parent bridge device

Before:

0000:01:00.0: power state changed by ACPI to D3hot
0000:00:01.0: power state changed by ACPI to D3cold
0000:00:01.0: power state changed by ACPI to D0

After:

0000:01:00.0: power state changed by ACPI to D3hot
0000:00:01.0: power state changed by ACPI to D3cold
0000:00:01.0: power state changed by ACPI to D0
0000:01:00.0: power state changed by ACPI to D0

So with this patch, the PCI device ACPI state is also being
changed to D0.

Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
---
 drivers/pci/pci-driver.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 588588cfda48..64e0cca12f16 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -521,14 +521,22 @@ static void pci_device_shutdown(struct device *dev)
  */
 static int pci_restore_standard_config(struct pci_dev *pci_dev)
 {
+	int error = 0;
 	pci_update_current_state(pci_dev, PCI_UNKNOWN);
 
 	if (pci_dev->current_state != PCI_D0) {
-		int error = pci_set_power_state(pci_dev, PCI_D0);
-		if (error)
-			return error;
+		error = pci_set_power_state(pci_dev, PCI_D0);
+	} else {
+		/*
+		 * The platform power state can still be non-D0, so this is
+		 * required to change the platform power state to D0.
+		 */
+		error = pci_power_up(pci_dev);
 	}
 
+	if (error)
+		return error;
+
 	pci_restore_state(pci_dev);
 	pci_pme_restore(pci_dev);
 	return 0;
-- 
2.17.1

