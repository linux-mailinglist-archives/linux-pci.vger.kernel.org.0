Return-Path: <linux-pci+bounces-18193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9F49EDBD2
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 00:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A990281157
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 23:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACBC17838C;
	Wed, 11 Dec 2024 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X7B/9B27"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B871F2C42;
	Wed, 11 Dec 2024 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733960425; cv=fail; b=K4i5X6xYTuJsgb4T/qKTarFYDYdxF+sXforB+ukaOC1W5vmx1HY8P0MB0HyC/vmknUD+OrY8JjpA0n0h/gO08Xbvm4xPCp1t7ujIyMdFRi6hIxqbKn/whKSOo+vw+FMxkk/wCrxLWF9OGLMnPZzZpENpw0U1HpFXuRrMbdyVDG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733960425; c=relaxed/simple;
	bh=+bJEK5eygtMiUs7y2/ViHSO5BB5lFwzx9FGP7CVNJrI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cn1fiOQ2hznuIyL76hOpBBSvjDFubdgVVizim6m3cUVZbKPaAEAPG4dLvVT46HeDrjidwTxvZ0lb0d7OulRYqYJ+ixbYBGXDxzvLoyuKtq7clw6RW1wl0hsmovan43DRrs6fymU5wcByodLYm4ri9LY/lXd2Z44cmUtknA0O/dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X7B/9B27; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHvCBwI3DHIkyz851qtRrxPi9oisX82qSwJ0F3Lf6gVTKz5cMFUnEoqyNure5MK+vH10KzmvA/klJxqMkFrP39/ZryN/f36+sVi2CfLXXQVDtXu5m38R/08ep71DZ0+ovqeQWfdaqhq8F6Kqzre5NdwvV/QMttutPEmRV5wo7qFNsVvOAqsVVU8E+Xo8IsvrkdW7jNew/9QWcO0mw+J+GoKXryG1uXOJ5i8tegUUzB8AieS/xfcEu3w/Wqtl8uvbO0tk1zgUzRCF8annF90+dSRj4ITAXHkZph3/W0tcy9bcJLhyBCivotlgBd2Z6AMAZSSD0InrwdpYsDGB9uVB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ETr2tXbf/OccNN5hwjorryDGEInd+RxiF+E9PdkWCY=;
 b=Vrqc6Er2Lrx78UR80AhEqxSvrYYp1C0jpelvl0l2uvckKKt0b1fPqsYHkFu+c68rR1nMe70W1XRi7/4NHJ9hWeWOSmGz97d7S7sNO/G8zluDUHt9Iq+PG9oPE9sf0SdLWAsQPQy+w5fzQDeS4AuRLbG5k/l9jXiQkuY1yGvfvZc+f3fKQMUj4pNBiYnydO8SMBDyc3sIRSzYsfaYpRoymdegKw/2qAo5gpcdLqGB6SajXsGHgBow28vxG3vnJBQICRic/YBP+oMBYKpuLByrYntzsSNathClUHRjoMm3bLJWarU6zFdFGHItf9S4IdEr4duqPlM+ZEVlq0RXpKRR7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ETr2tXbf/OccNN5hwjorryDGEInd+RxiF+E9PdkWCY=;
 b=X7B/9B27s0TBVynLcoZrQ5Zi4k6ja3sPX4pqI3JPU18LGa4rbyM1ZYlI8YUSY8eXTmkwhZRO3vauiCubnrTJO8g7V9peUoHuEsjt9jdEQ/5tmuFBUQuOLn6FQpBUaxyotfgSTZ3UewG27uJxczAnbz+xbZzsESx78TRXBJWJpqw=
Received: from BLAP220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::23)
 by CH3PR12MB8282.namprd12.prod.outlook.com (2603:10b6:610:124::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 23:40:20 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::83) by BLAP220CA0018.outlook.office365.com
 (2603:10b6:208:32c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.15 via Frontend Transport; Wed,
 11 Dec 2024 23:40:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 11 Dec 2024 23:40:19 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 17:40:18 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <ming4.li@intel.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: [PATCH v4 01/15] PCI/AER: Introduce 'struct cxl_err_handlers' and add to 'struct pci_driver'
Date: Wed, 11 Dec 2024 17:39:48 -0600
Message-ID: <20241211234002.3728674-2-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211234002.3728674-1-terry.bowman@amd.com>
References: <20241211234002.3728674-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|CH3PR12MB8282:EE_
X-MS-Office365-Filtering-Correlation-Id: 15918b21-5eed-4646-1d22-08dd1a3d2c70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SuNMyOnLMN7t7exF+0ISwWpaCqPu/M7Yf68f75BUXB4Z6hUsnaCuxB57mDKt?=
 =?us-ascii?Q?hE8WGQb9/JAN5o/+2CxoBXayJFx4fYPaJeCld9qxXcc72UOyZQC04Fncbd9R?=
 =?us-ascii?Q?PuGscK6FGW+VWsbPz/re+0w0RDh78TchxlSSOsJ2t2AEYoZQzy4lDkr/uAcr?=
 =?us-ascii?Q?vheOgffKysYjdXuII7edyh9Z43H3DAHqDPvZS8hXoMAScr7qqwH+PkDQbM5z?=
 =?us-ascii?Q?JTZK71B9qHuh/iX18HRr7oyc2zEJl5/zaWLkULJq9tX06b04sLe3Q/oJtZMd?=
 =?us-ascii?Q?3w9m8QTfbn/uu5zi2SWXhbvUaQJ/TX4tvNipxg6r7WppPfAqCOlef7CYNNjU?=
 =?us-ascii?Q?gHBc3T0B7PjHUM0ifItPkpzyXwXjpbKa6JgwL8O7acTRaVUYkZMUf1eP/V7j?=
 =?us-ascii?Q?ZhvQNqn0Xi4IKkxC7Vmq4I2JasB3lUcdjxFFXKOMwCxDb5JFVSuvOYP53uFt?=
 =?us-ascii?Q?x1U/bWxdvcAaTlPUM6KgrdkXLdwZktQb59pf3loiJ0yZe1z/lthJYgknolio?=
 =?us-ascii?Q?rOEldDyTwAeMFWmJUwg12oBZa/E9rkT/32lT4fPpC7juExnJ6vfVp77cENRu?=
 =?us-ascii?Q?RlgHf4vPTqA6JBZpbZ823SpBbA7Lix7bnB+JBGtxAcDbR8t5CM/63W7XzNoR?=
 =?us-ascii?Q?xFq4fQmkNBjH+gy+djRJ9emGpXcZoKiSjP0BR5Xd1unjOvtbOdXc2XA+xE5B?=
 =?us-ascii?Q?rKOwH34Ys6VaId/GXdXqYeklTP/p2AFpUMflrwxMQZZJA+IiDr5vNMc6ctUk?=
 =?us-ascii?Q?ZNmJ6RnYHv8cFWHY9RDia0Fn6sefnQ2Z5+JkaYgLpqxcDlGqKTPWDzCoL9O9?=
 =?us-ascii?Q?0tlUY1bpIEMD26L2grw+w90vWv6zYObZNikCrpd7vclYFEvs52iGEW4JKGYx?=
 =?us-ascii?Q?a02JwjWuyz4zDnOU0C9Q7HOtquEGcDed7XLF0t1QsoIyV8565FLInkpegEp1?=
 =?us-ascii?Q?89iqFhXNGviRQI9WsyiL/GncXGPsz1kPEM8T9KhuERlpvd7IiRtSxIycSH9J?=
 =?us-ascii?Q?whYGHtahax1c5+pIiEoq3SODfNduEZ21s7HW1370klgake1/2jmeO+a3M1yw?=
 =?us-ascii?Q?WyxX69L8+5BIzBDXS6y/f9TkjqbD4BQnfdrgLeAQFEVlgbDBpKIa+UDcBSpb?=
 =?us-ascii?Q?1ob0H2qm4QWfz39SAgTho2b29eEzJbc2n3L4sapY3G2aoD7mMZHhYauAbOvZ?=
 =?us-ascii?Q?gC59AHAYkvNG9ERTK4TBt7MabaC1bDPCOrgFio0c7Dkb6G2gsYZ8fK4Af4fu?=
 =?us-ascii?Q?Ij8p1/3SLCKVvwEISnaKMFFyILRTZGF2EOtB4N7QpbVYeYyDIYrvuXkTkzc5?=
 =?us-ascii?Q?t6aatdQGPzWl5+5679u1fnjcYsMPPX/oTU7d5ReuN3IOeXPwfACxqPGKOYbD?=
 =?us-ascii?Q?Ydqq5w24x+Dy62hVjMPIt+aJxVHbcuy7yMc3W0eHC1UpyCkd+Yy39e/ySRzN?=
 =?us-ascii?Q?L2JLFtL+Vs8ln9u3SHOInDF7EzHLQrFlz0JUPx2Mr1+zGSdsVDzBnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 23:40:19.6569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15918b21-5eed-4646-1d22-08dd1a3d2c70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8282

CXL.io provides PCIe like protocol error implementation, but CXL.io and
PCIe have different handling requirements.

The PCIe AER service driver may attempt recovering PCIe devices with
uncorrectable errors while recovery is not used for CXL.io. Recovery is not
used in the CXL.io case because of potential corruption on what can be
system memory.

Create pci_driver::cxl_err_handlers structure similar to
pci_driver::error_handler. Create handlers for correctable and
uncorrectable CXL.io error handling.

The CXL error handlers will be used in future patches adding CXL PCIe
port protocol error handling.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
---
 include/linux/pci.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 573b4c4c2be6..f6a9dddfc9e9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -886,6 +886,14 @@ struct pci_error_handlers {
 	void (*cor_error_detected)(struct pci_dev *dev);
 };
 
+/* Compute Express Link (CXL) bus error event callbacks */
+struct cxl_error_handlers {
+	/* CXL bus error detected on this device */
+	bool (*error_detected)(struct pci_dev *dev);
+
+	/* Allow device driver to record more details of a correctable error */
+	void (*cor_error_detected)(struct pci_dev *dev);
+};
 
 struct module;
 
@@ -931,6 +939,7 @@ struct module;
  * @sriov_get_vf_total_msix: PF driver callback to get the total number of
  *              MSI-X vectors available for distribution to the VFs.
  * @err_handler: See Documentation/PCI/pci-error-recovery.rst
+ * @cxl_err_handler: Compute Express Link specific error handlers.
  * @groups:	Sysfs attribute groups.
  * @dev_groups: Attributes attached to the device that will be
  *              created once it is bound to the driver.
@@ -956,6 +965,7 @@ struct pci_driver {
 	int  (*sriov_set_msix_vec_count)(struct pci_dev *vf, int msix_vec_count); /* On PF */
 	u32  (*sriov_get_vf_total_msix)(struct pci_dev *pf);
 	const struct pci_error_handlers *err_handler;
+	const struct cxl_error_handlers *cxl_err_handler;
 	const struct attribute_group **groups;
 	const struct attribute_group **dev_groups;
 	struct device_driver	driver;
-- 
2.34.1


