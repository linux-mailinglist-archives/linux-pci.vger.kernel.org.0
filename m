Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED5636BD4E
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 04:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhD0C3G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Apr 2021 22:29:06 -0400
Received: from mail-dm6nam10on2077.outbound.protection.outlook.com ([40.107.93.77]:15905
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231666AbhD0C3G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Apr 2021 22:29:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljn5jMUH+PAk3o41p1Yh5k8Y5nQi4Ni9OLCc8bc4mr/Qy9addOaZtVuatiQHi9uh2TKM6QGXMOxppprPiGzl9u1weY6R1TDgLEno5OAcZGOKkQncHZ7oufZEN7vQD1Nklio9qm2uwYnROhzb2kSYpd/g8w4mdZCoVvRySmTziIpNpcM11B0cmVLtA81uldV1MAOHy7V0356kHsUGOAmQGvsFjoVdMrOBHdiFYtO9twSIyCaNs97KOFAP2jf9HEVk4QtSilnj6tbq77DcxW/cPy5KXz+TghT8eOGj10A+MdA8xDNmJt8InXtIMwSmyzXyBb+LWggSa5nktKWzHQP0LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWtx5I9BtdSvrsrQ143Q/vzbXPiMO9QvVFAHLSCP6h8=;
 b=nhACjaIRmwHFs3yag60V3DgAbPCij2a21MjxOokKQ3mPHtsZMILW7rmpXRXc1mJQHSslTT5PbPOaSsmyDGwrTzifis5Y3mjIsr9/FIpsJTkp3lSMDJDSsOOIwNiMtdBB4+xJ51iKI+UZapfUGWKiQNSDK+AvGOUiNNdPZKzJABT19lYCW85+9jadxL/OTshdOZSS0RXTNdqehGF/g9QnjoU875Jzd2pcofViUwUxGJeBxaL/7DpBz8I55SFptIp2r8Gj/RbUGaDEdu7A5D/zhpUrNWCkLWLDcvLbS32XfwNyywq/qfl/7MzAr4XKSUR5jN1hP1OIar5qQnXRfjoWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWtx5I9BtdSvrsrQ143Q/vzbXPiMO9QvVFAHLSCP6h8=;
 b=bZYce/bhf7IbU7ZCf/4Z45MdXtkYmzDNB30KDkbZ9LWvZBUFAqpV3gNfIK/LwphDUbdc4p8qNoMlxYYSzBAF29LwhpPZvqGOSGReJhlkUkuz/ORprL9DTq3LuliBXc3ex8fH8ns7AbQnstHMzFgBSvQx8TqNl2ALn5uvV0F8MTu6jMLdidAofC5fumcPOtPD7jJg8JYyQPOeEJX4RcXAZEUU4wRhcV6IGcaxwvrV6pcfjuvN1noXFVVNqwhdIc5pVmGPvXstIU6TSHGnMtFaMaRVHiMubj5gDzqy8bQOUtFkvzrhr4bOeiHEyeLLHZhZCZCSb5HBt8JuyJQ6czOnwA==
Received: from MWHPR19CA0068.namprd19.prod.outlook.com (2603:10b6:300:94::30)
 by BN8PR12MB3586.namprd12.prod.outlook.com (2603:10b6:408:47::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Tue, 27 Apr
 2021 02:28:22 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::8b) by MWHPR19CA0068.outlook.office365.com
 (2603:10b6:300:94::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Tue, 27 Apr 2021 02:28:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 02:28:21 +0000
Received: from SDONTHINENI-DESKTOP.nvidia.com (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 27 Apr 2021 02:28:20 +0000
From:   Shanker Donthineni <sdonthineni@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: [PATCH v2 1/2] PCI: Add support for a functional level reset based on _RST method
Date:   Mon, 26 Apr 2021 21:28:01 -0500
Message-ID: <20210427022802.21458-1-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3816ae2c-5411-425e-eccb-08d90924208d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3586:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3586FB28DF5DF8EF08E91532C7419@BN8PR12MB3586.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t297eBkn3MLb/9whYMG5pt20DzjrzzI3PlasfsDrMPpdH6zYGB1WJUU3lgC1BzffV26XA0eVmEhi1FO//HF7hR2tby+DqGs0j0mCCfVbm14KUEYiAgJ3ygJW3SSx3Fvam+l+6+gggbEI+fvTsovNDF2YKOwO5y98XetN/HCjew1xQCBbfwcbyShpzt8D54VvEEs7OjVMJHOA5iWKAoDS3eOQyyC2SmaddUjgr0N2sm4J+MP663+pISYWIsBdUyOayUCxS8GZwpEwnc6SMk/htO4iTN8PEhTbkwgviO4rUJJD8vcM1yYGJkpSoOQV+qC6A+3/sjPOykcI6r1N916aCzG406rMMCkSp0fIsn3EISaNgGhvYk3JhP/d/DhMbaiboGkOYvLBiWmFKNruaqa4W9lm3Af9oMoppFupgQnEATG9YBc5jTzZNDbZPxB1zOKD1xFs4I8iL/h6muObiMghvjg5Gm/lQVbMbIa3upr4bvvXdi43ZtL/b4NgrXuGhNaqKWtBQjg3EvfnlFsr4PAWKliawrtAwSAf+U1L5L2HYXNm3LhqkUy9jd/9IQjnsKWEYodG+EWvZaZSI7gcTLrRT+Kv5kpcZvRhdehJJpRKOWKkjs4vQJ1/ffwero60B2E+jePv+fINQv8td263RwsEHw60O8vHLufvRJzMpHtY64A=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(36840700001)(46966006)(36906005)(54906003)(316002)(356005)(4326008)(16526019)(478600001)(36756003)(8676002)(86362001)(8936002)(70206006)(70586007)(7696005)(47076005)(6916009)(336012)(426003)(5660300002)(82740400003)(2906002)(83380400001)(2616005)(82310400003)(107886003)(6666004)(36860700001)(1076003)(186003)(26005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 02:28:21.8191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3816ae2c-5411-425e-eccb-08d90924208d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3586
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The _RST is a standard method specified in the ACPI specification. It
provides a function level reset when it is described in the acpi_device
context associated with PCI-device.

Implement a new reset function pci_dev_acpi_reset() for probing RST
method and execute if it is defined in the firmware.

The ACPI based reset is called after the device-specific reset and
before standard PCI hardware resets.

Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 drivers/pci/pci.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 16a17215f633..6dadb19848c2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5054,6 +5054,35 @@ static void pci_dev_restore(struct pci_dev *dev)
 		err_handler->reset_done(dev);
 }
 
+/**
+ * pci_dev_acpi_reset - do a function level reset using _RST method
+ * @dev: device to reset
+ * @probe: check if _RST method is included in the acpi_device context.
+ */
+static int pci_dev_acpi_reset(struct pci_dev *dev, int probe)
+{
+#ifdef CONFIG_ACPI
+	acpi_handle handle = ACPI_HANDLE(&dev->dev);
+
+	/* Return -ENOTTY if _RST method is not included in the dev context */
+	if (!handle || !acpi_has_method(handle, "_RST"))
+		return -ENOTTY;
+
+	/* Return 0 for probe phase indicating that we can reset this device */
+	if (probe)
+		return 0;
+
+	/* Invoke _RST() method to perform a function level reset */
+	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_RST", NULL, NULL))) {
+		pci_warn(dev, "Failed to reset the device\n");
+		return -EINVAL;
+	}
+	return 0;
+#else
+	return -ENOTTY;
+#endif
+}
+
 /**
  * __pci_reset_function_locked - reset a PCI device function while holding
  * the @dev mutex lock.
@@ -5089,6 +5118,9 @@ int __pci_reset_function_locked(struct pci_dev *dev)
 	 * reset mechanisms might be broken on the device.
 	 */
 	rc = pci_dev_specific_reset(dev, 0);
+	if (rc != -ENOTTY)
+		return rc;
+	rc = pci_dev_acpi_reset(dev, 0);
 	if (rc != -ENOTTY)
 		return rc;
 	if (pcie_has_flr(dev)) {
@@ -5127,6 +5159,9 @@ int pci_probe_reset_function(struct pci_dev *dev)
 	might_sleep();
 
 	rc = pci_dev_specific_reset(dev, 1);
+	if (rc != -ENOTTY)
+		return rc;
+	rc = pci_dev_acpi_reset(dev, 1);
 	if (rc != -ENOTTY)
 		return rc;
 	if (pcie_has_flr(dev))
-- 
2.17.1

