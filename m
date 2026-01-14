Return-Path: <linux-pci+bounces-44826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A57CD20D8E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACD1C3020247
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631F2335554;
	Wed, 14 Jan 2026 18:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WrvGSlsa"
X-Original-To: linux-pci@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012019.outbound.protection.outlook.com [52.101.48.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E13358BB;
	Wed, 14 Jan 2026 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415301; cv=fail; b=uHIEZe5iOWXgoK4+fa5Vp5NnBxCkxqtpXBAmtKqznojlq0o/RC4xu8NQ+XBoWdIx3ghU6oxptf3blbkNp5fEgckyfRMtr6F4Ykmlagi8ABf7Cn6fC1H5tuhQZNbwq/a8S6NwZf//7ji+b0Otsoua5P7IOgrhgcFIb0ZzlnCYjZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415301; c=relaxed/simple;
	bh=pYUYEho6WNQWaSKPyv1JnG8rGy+IqCBhZySxZnFLCzU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tG3Wko7xbV7ro8YAzOg+DZLdtLfMwJ+20xBdIc0shqFaVd4t16xDdc33NiXjj49qeC6fptwUVCpgx92DoJ39Zu6Un7GKGbsMMP6PxIOeHBqgZq+69n34zg+zbFV0EMOiLFkH/VjTujFEipQgAEcItnES9QNb08v6Nu7koRLyj9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WrvGSlsa; arc=fail smtp.client-ip=52.101.48.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9SZEy0rSLjlE5Ag1tFf5ev4zjy6GGTR3M7dElF1elh4j8i67OGb+onNMZyydbTRnY9x1Tn0v+P/n9B3kmiftL+LrflkShjfW2vtntEZoVfl4ckxG2wp792BoC3KRju6TBA1yWt6CIIZT1AHO2mRZc/2ECXWTfi5jJURVep6LTXqU7vYLv+0CDIJzHTsi635MacHa+OO6xPeQSs/Q5IQZvL6rB4r+OilsfCWPa0YSYvhswROmRALHXggO3uTX+O92+Afl2f1TPlTXL2dT93y0RZgiBYTIwveCfSjIa2fO9MzIm4uR161spqEVh/2riOGpPRFdqqjC/7aXkag5AcYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtie9cGljjtWccWQJ+bcWGJDmVFsOmjbZ2GDh3MYFos=;
 b=Du6WTPMuwXUI9lcxHuK4Mct3FYtmeudvXnrpEnlAlqCtahzydrmK5wUQvsQIlG2wUJWS8FIeqywgicSMscdT3Rl4U1UyOZXmTZSkSFfoOCwISb+9OSDrMnUJBcJsWNN3L1oB2BMl7YcIkG4wmdK44yqr3uE46vUX5S+gUIHlmxhMdDHQSYJlSUdMRCpZRlS9syUUveza1J94GkBBgkb5NX5U3tFFpcl9h5i1rDDnWE34D5hZMUo70XfcDya+1WwObRVBkk2wm7OW4EPZjSsZutUhCyHzgFlAGUhewPECF38ArAUKRmGfIbWsnvvi7hpFqn6bNzmhQH4bSV7To2Dn9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtie9cGljjtWccWQJ+bcWGJDmVFsOmjbZ2GDh3MYFos=;
 b=WrvGSlsaOa5W+UnT+u9dXLgi3C2V0P+xAyM7b9JqXF6I4Fo52gO8+ART7TjdssHm5KwEMl6kq13jC0WyY0enqDmstlss0IH1gttZd5GkKqBXMaLBpkFfHhDuj33RvzHFVTgZgzU5TxDc3jI7GarX/iPEAevGr8DOcDzqyfatIPg=
Received: from BY1P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::10)
 by PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 18:28:14 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::9f) by BY1P220CA0003.outlook.office365.com
 (2603:10b6:a03:59d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 18:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:28:13 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:28:12 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v14 33/34] cxl: Update Endpoint correctable protocol error handling
Date: Wed, 14 Jan 2026 12:20:54 -0600
Message-ID: <20260114182055.46029-34-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114182055.46029-1-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|PH7PR12MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef17c50-4e6c-4773-f7d7-08de539aadb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aY/UFErWL0UJw2iZLXotHVTk14KSHBLIQaO6talF+fXlsEALiZp59gFrdBzb?=
 =?us-ascii?Q?d39+0DqxwYoFg9JrPUVh9Onx4dYtqGmiZVQxZVmC7+3DpbzOUYCLSRugJ4Qb?=
 =?us-ascii?Q?sI3zaFO6dNagZ26Krcev0Sy3rJmvLKuXKRfp6YitLp8tzk/CAz3VOGQ5s56G?=
 =?us-ascii?Q?c6v6iE0PZvgUFV6s/mKLvKWnWzTjm2Eh9telzjm2SMWULg3LCxCXQToXfbjO?=
 =?us-ascii?Q?1gjMXvkGOv+gxmw8n+YOTwnSJw6gNIXh8JyMTtzvy4swHquAS9LGa4QOA7Uj?=
 =?us-ascii?Q?QybbnUjzv6XHandvtUxuJeGb2yjDd9e3SidlmcNJq9H4XsFCUpgTIet1cJU/?=
 =?us-ascii?Q?7BZbYhGKw9QFENSFQVU7hwSuWseieNb96mo14pwCflh4dpyFQKoT5BNG8k0N?=
 =?us-ascii?Q?61rfoUJeikxjFVMp0UJcPM7WyxYyYD6RXgIgix1UT1CItgxubJ+VbclPNowP?=
 =?us-ascii?Q?priaNKidg2zrM6+1pmKhY1hn+rah3NSPAP5E9GnnmTU/CBCKO9SfapVJ8XBZ?=
 =?us-ascii?Q?pOqIb7CkqJtM4ItSHUfISE3h274k8z6mTlLuA090FDPNZNEnqKoytsrUf4/A?=
 =?us-ascii?Q?qBgka0BnqeSPf2cX+kaoSp9GfYxuq0zYHqHhaapzDqGzi3O5F6AH6yVgafqO?=
 =?us-ascii?Q?a+PvKmu7z7Y66m8B5/ZsDzW1BRQJUOcfOvH2uOR8YaPj6W592pVkvypXHksx?=
 =?us-ascii?Q?+3ejR7Y6TCsZvkASfLY2HSEsVl1dSLZIHxFazYdzwleBxzTqM8j8LeslA3ES?=
 =?us-ascii?Q?SDpH4PbiK6W07pDdmraMUAqgZ7cayVtxx6tM8M1kxOgsLehkVwUxWtUbxkHX?=
 =?us-ascii?Q?c+F2CXh5wh1Ejtk0LD0MjwWAOjXMPv0zvWMjKNwQ/SBt9ylJsB5Eo8oasxEJ?=
 =?us-ascii?Q?BrJkpqsV3wCjauZAY6d/oN+KcV+4MQRU7XLhbH8XA8RJCVvi/VtKDOBU8KLX?=
 =?us-ascii?Q?5OQFVMsMnnn+K3/XsHfI82PN+OThfOQgormYCm5xyHtK1bpgjrtie7d/pzvt?=
 =?us-ascii?Q?uRgctDNTj3Ep/1Ya9RE2jW0Anw247iGEtgEFr/wHQnOAts/LZ5SnHMN+Tf+P?=
 =?us-ascii?Q?CM+B5jCEGFIaVMGqWUY+VEbfIqjnvk6hX2wvtYIgz20GiMJIRXPRaDWSyMqZ?=
 =?us-ascii?Q?TM8jwQeuYyXhOll+9DrRdumo5NZw3eEkxf12VpI3Yjr2yaI7XhqNbXwoDpFF?=
 =?us-ascii?Q?UnaWtxG2baQqz4AEZUTx3q5eENL/mZ72vvaUoCZP8IJZ/aHTtJn1Ll6c/7AE?=
 =?us-ascii?Q?iuBOt19fwQSptbFsNtrH/o2xAQOv6I0Zv3El4kWIdp0I9rLhrDo6Jj/IUkVB?=
 =?us-ascii?Q?BZPomLdS7tVZVoNvzxVeIxA7UWnt2seKTJg24i4DNNKOPCoSQNIiJQRE/g+H?=
 =?us-ascii?Q?HU0QO2SxDIK6akL6+kUPmJMjOFri/W18b3Wl8zNprzjdpZwuSszMxeSP3/xJ?=
 =?us-ascii?Q?oqoYa2NStXUJJOV0yJJuR9Fl0tdgxxCqQcSFJK2qLytCMFvHE6XY61w8c5hA?=
 =?us-ascii?Q?VPaEqraQo80QRtOUkINMVWxMezuiyRI7YkygEUc+/+JLQICo5svwEBXuAaS8?=
 =?us-ascii?Q?m+cuUgPC8ukzimUpvP/oMvwqPPwSHynNla6NCVPD51G+D010N5oXV8JOVuIy?=
 =?us-ascii?Q?2NbWg7IVCbdbXtXxXko3uyNvnMuxcezqtDP8NegAwl7wgn39uLNWlNj3c1Sb?=
 =?us-ascii?Q?+v62p57rkdmkSS1wQmEWJxGPqk4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:28:13.6105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef17c50-4e6c-4773-f7d7-08de539aadb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233

The CXL drivers must support handling Endpoint CXL and PCI correctable
(CE) protocol errors. Update the driver to support both.

Introduce cxl_pci_cor_error_detected() to handle PCI correctable errors,
replacing cxl_cor_error_detected(). Implement this new function to call
the existing CXL correctable handler, cxl_port_cor_error_detected().

Update cxl_port_cor_error_detected() for correct Endpoint handling.
Take the CXL memory device lock, check for a valid driver, and handle
Restricted CXL Device (RCD) if needed.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v13->v14:
- New commit
- Change cxl_cor_error_detected() parameter to &pdev->dev device from
  memdev device. (Terry)
- Updated commit message (Terry)
---
 drivers/cxl/core/ras.c | 52 ++++++++++++++++++++++++++----------------
 drivers/cxl/cxlpci.h   |  6 +++--
 drivers/cxl/pci.c      |  2 +-
 3 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index dc6e02d64821..427009a8a78a 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -267,8 +267,10 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 	void __iomem *addr;
 	u32 status;
 
-	if (!ras_base)
+	if (!ras_base) {
+		dev_warn_once(dev, "CXL RAS register block is not mapped");
 		return;
+	}
 
 	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
 	status = readl(addr);
@@ -345,7 +347,30 @@ pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ra
 
 static void cxl_port_cor_error_detected(struct device *dev)
 {
-	cxl_handle_cor_ras(dev, 0, cxl_get_ras_base(dev));
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
+	u64 serial = 0;
+
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
+		struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+		guard(device)(&cxlmd->dev);
+
+		if (!dev->driver) {
+			dev_warn(&pdev->dev,
+				 "%s: memdev disabled, abort error handling\n",
+				 dev_name(dev));
+			return;
+		}
+
+		if (cxlds->rcd)
+			cxl_handle_rdport_errors(cxlds);
+
+		serial = cxlds->serial;
+	}
+
+	cxl_handle_cor_ras(dev, serial, cxl_get_ras_base(dev));
 }
 
 static pci_ers_result_t cxl_port_error_detected(struct device *dev)
@@ -376,28 +401,15 @@ static pci_ers_result_t cxl_port_error_detected(struct device *dev)
 	return cxl_handle_ras(dev, serial, cxl_get_ras_base(dev));
 }
 
-void cxl_cor_error_detected(struct pci_dev *pdev)
+void cxl_pci_cor_error_detected(struct pci_dev *pdev)
 {
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlds->cxlmd->dev;
-
-	guard(device)(dev);
-
-	if (!dev->driver) {
-		dev_warn(&pdev->dev,
-			 "%s: memdev disabled, abort error handling\n",
-			 dev_name(dev));
-		return;
-	}
+	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
 
-	if (cxlds->rcd)
-		cxl_handle_rdport_errors(cxlds);
+	guard(device)(&port->dev);
 
-	cxl_handle_cor_ras(&cxlmd->dev, cxlds->serial,
-			   cxlmd->endpoint->regs.ras);
+	cxl_port_cor_error_detected(&pdev->dev);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_pci_cor_error_detected, "CXL");
 
 pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 					pci_channel_state_t error)
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index f218b343e179..3d70f9b4a193 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -78,7 +78,7 @@ struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_RAS
-void cxl_cor_error_detected(struct pci_dev *pdev);
+void cxl_pci_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 					pci_channel_state_t error);
 void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
@@ -90,7 +90,9 @@ int __cxl_await_media_ready(struct cxl_dev_state *cxlds);
 resource_size_t __cxl_rcd_component_reg_phys(struct device *dev,
 					     struct cxl_dport *dport);
 #else
-static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
+static inline void cxl_pci_cor_error_detected(struct pci_dev *pdev)
+{
+}
 static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
 						      pci_channel_state_t state)
 {
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ff741adc7c7f..328b4ea8dbc5 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1055,7 +1055,7 @@ static const struct pci_error_handlers pci_error_handlers = {
 	.error_detected	= cxl_pci_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
-	.cor_error_detected	= cxl_cor_error_detected,
+	.cor_error_detected	= cxl_pci_cor_error_detected,
 	.reset_done	= cxl_reset_done,
 };
 
-- 
2.34.1


