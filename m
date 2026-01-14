Return-Path: <linux-pci+bounces-44822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB613D20D6A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3FB1307A6A5
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CF133508B;
	Wed, 14 Jan 2026 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ttYbx/rR"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013044.outbound.protection.outlook.com [40.93.196.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD42336EDD;
	Wed, 14 Jan 2026 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768415245; cv=fail; b=snwm6BAUgYKTF7rjy+FiGQJxDNLmnM0GyIsIuk2N2u41P03RpHCaL3xGroqhNAO8roV9ejrVl1LsfRdIcIxz1o6M5zspxU2cgnAQncM8yEgiWFL7EBh56G8Ym5IvchcuYWW9uu+BUm0o2DZ7mj+vHk2Jxk6LDFa81dxYZnMJm1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768415245; c=relaxed/simple;
	bh=HAcIXi8eSwYgzCjC2DMI6iBTT5FPQjXxsEB2iF9uhIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bB8AvbYQ1mQItVBlG1DuZahzDceonFxHJNaJcDIFbH+X9KuQ/piXAeGJjQbn7bVbPsGRQBH3GGbCs8ZR5UO0gPuC1YtCTmmJOZRjgGVrsb3j/3zvdm7VBHa78gska5ebW6ON9qjLfTR9mvG4v2i5ZZkCWQNP0AvOqOZ6iZNRjN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ttYbx/rR; arc=fail smtp.client-ip=40.93.196.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScloqtSeqG2iKoCPFOxUcfkEhgciEShSOcn4Kk7F10o04TvN9GAo2WcDejol0FqNX2kJkNgvRjqrpsjBn0j3zfxnX7N1yioCXe9fnJvZxhjTJjxZxZsBn+Vcg7sVkvcl13EtxqLEdQ8Dv2z+BpwiGfB+WJyPzuSmAgj4QAeVoqVbvJsbG+c7PAhu9Hgb/rQ30Z4JN9CYX2cgKt6wWdbK6OMqSqmghnUI8DNCbC0YK2PDkpk6bSrD9gT7hhlDJg+OKNZTfGXCzH6dGlp5Q7r8Jhw4zzj05Acikgs2PRMUj3hrp0qSE0AE41anZJ3D/tsejO5LJ5fhi+KDZm+WsHzB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFUpy46HIBa7TCBFLtxpQsgAi7tZpNnMMcBbnKkp7Uo=;
 b=hgNt14nlXlu8crSMh+URIbSy5hNKdrils8iha0Kvb5sev6PxQpvHVAkVeSPNp+70VUp5kXbL3RoWJV1L9LRN+NVQEBmKtp/O4BeJl4A38+e1pKhCarPHFBS3wT9v+M8GnRcbrzMQmSFPZ261xLn0g9QDqCKAyNkcWbK8ciTK5TTNZau9BnhAk7Z5j2fFhn4yhvZ1scMTBPuWelew37WiCa3UdhhTPTbJkyPgEHgfqM9tiIHxrXmu90blifJP8D1sNcwkblp4XPb7SYeMGASXP3IjAgBBjaQbsHm42xoMzMPWTlV1vWRgQteZcgtN3F72NyhGgXpkx6z2mkh23hm/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFUpy46HIBa7TCBFLtxpQsgAi7tZpNnMMcBbnKkp7Uo=;
 b=ttYbx/rRrYoj9P2KqTiYIN4C5Bp7QI4PPnMfsh/2rtsOwxbmSyjyLObX0pI18w2gxB3o2hDnSWs2nmWH6k9a5CYkRK19Vps5ts727GTkwyCwUYTyODAZp9AESzbcVblWa59BS2WqMuOgL9VAaVQSyo6DH19CTzbA5V1K2zL5b6A=
Received: from SJ0PR03CA0338.namprd03.prod.outlook.com (2603:10b6:a03:39c::13)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 18:27:19 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::1d) by SJ0PR03CA0338.outlook.office365.com
 (2603:10b6:a03:39c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Wed,
 14 Jan 2026 18:27:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 18:27:19 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 12:27:18 -0600
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
Subject: [PATCH v14 29/34] cxl/port: Unify endpoint and switch port lookup
Date: Wed, 14 Jan 2026 12:20:50 -0600
Message-ID: <20260114182055.46029-30-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: a31a7950-73ed-444d-bd59-08de539a8d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g6V/xASivu3K3QtcTWbkBEzw2LL0/YEZhQZYSxQyHW3ZduD5hAVeBkBDIWEc?=
 =?us-ascii?Q?Nn8TKZ8dqUh5YaUcdglT3ERYULlp01rqR9g4MZ0MqJLeeMt9qy+tBJa7j8hA?=
 =?us-ascii?Q?CETb+gy4RG8dzSYkMokBfk4gxGqCzFJ/DXczgYMjdzT2UNLtK9otbw6RQ+c5?=
 =?us-ascii?Q?krBNgGhX0hBGxeazlSQxopizoyVt4i2PwjPtwnlBwSzLuZ/OmvVwUwaVYkct?=
 =?us-ascii?Q?pOLO7Y+QZW0O7ZmKnKdoSQm11+S0RVhbkD+Nk2r4FAlU5/8/KoH0+AhJQMOO?=
 =?us-ascii?Q?gZWJhzAobacMbs6nh7Sk1EoaLsn6Y9y+RKaITpUX68xavBHgx1QySxlS9qQb?=
 =?us-ascii?Q?YbeXKvpTaYxnwpVMoYkqOabx6b+PTPKrIwl2gTfGsvHyX7WB0/9p4gco3vL7?=
 =?us-ascii?Q?XSgsqU5zmy4fAe8msHsFPROmaA2G/vYJcxC61Bczz8FDuIqRYgPZ8HjXAEzu?=
 =?us-ascii?Q?6cyRxqW3XDUAWxGNvqvQAJk8F09cc8/pPZTs3nKlxMexyI7EiO0W2AlOqbUo?=
 =?us-ascii?Q?D1E3aqQAIMlY/L7kTw2LmSSh//E8UkefCr/M2QxQDIhWWGLOxuNOj6kigryI?=
 =?us-ascii?Q?D9Tw5m8q/Fju7VyIRvY6tAzwi/VYrksw2gnNJe91GzAciRFKb5oT/yDq9VZQ?=
 =?us-ascii?Q?Y5LGxyPKxARxhDAHu47k95gbSxRz1RuizfA6ap7vKewFZ06kUMCNup9Ylpl6?=
 =?us-ascii?Q?ySF6Wxbi+BhqkfdUl7yOuToUVLT/zuj1DvkgYGCDY36EhLkJi/Bg+oaM5UlT?=
 =?us-ascii?Q?Ra3BirrhqB+mg8QxJwS9VZlr8EJZWbrlQ4fa+R0WAQQWCS8nxLQziW+A/qHb?=
 =?us-ascii?Q?8y8UgSI+AV710hxe+hTZyAR1XF8NH52WsHHQknsdd9dEpxIkDWoTV/RGxRr5?=
 =?us-ascii?Q?PH3l/Q8kMi1XfwdgJEe2ZK5ZCqsJwx7PVXwKriLA6S859cOuDGjnpq2G00sO?=
 =?us-ascii?Q?u8ADn9Gd2Otn/s907oVAoZcdthcoBI4mxwYb1C5NN/p9Abh2bffsNeLEjAFO?=
 =?us-ascii?Q?hdBX/OItKG20rXARRYbWhiGWiKmw9K4tdX/JzwE0TDRozwxMWw/gMZUoZBbE?=
 =?us-ascii?Q?eh+nWoLE9LvsBWzyqnQI3QaxrTHhAjsKBxakdeXl1C7R2HJp1lqPansMY7Af?=
 =?us-ascii?Q?K7MKzx5Pou0HwiGSrdvt0jBXzQGm/yxWUykeNNW0ewVHVJF4AyJwzegjgWPE?=
 =?us-ascii?Q?SPpwh4uTOYpcqNvM8OPvQhqwxnFwrubegXvHEseCXrUQiTqjrWU0FafGnytf?=
 =?us-ascii?Q?PCWbg6An6/XFsXPMyw166bd98Fd5Dn4k2aT+ClcPrihAUqq4Sllt0o4WsFxN?=
 =?us-ascii?Q?romkwmqJeCn3rVaLZw1kCB8wrDDcBAju6kR4K3Jtg2vvpNVdmz5+lMbliUXO?=
 =?us-ascii?Q?n9p8WIkFi1eHxTamftauIykcsEXmSNUwYeIBCOZF8L6uHcNMtkiXbRbeeawK?=
 =?us-ascii?Q?JfXEQDBe7Lwo40cqjjKQvWj1TOl4/MCdNE2PxC9Pbr8OaegGgDGCEV8dl9Uu?=
 =?us-ascii?Q?Gu5OaGz21dkCsHdrwS1gTVZst4wVn5mFPtbyqzkWgRCm1HGcECQ9X2WHbkQf?=
 =?us-ascii?Q?EtkZPrIJMDxRhqGl0/UYlpYSjQHd38Y6t6AO/PKr0i66Gqanoqp/V3/Cmwrq?=
 =?us-ascii?Q?1hL9aa9zN0lOV/FSikLAWOar/vI1IjL9lGfLVZzl4Wvy3N+yE2S1GFgy9C6L?=
 =?us-ascii?Q?GuopEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:27:19.1823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a31a7950-73ed-444d-bd59-08de539a8d41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732

From: Dan Williams <dan.j.williams@intel.com>

In support of generic CXL protocol error handling across various 'struct
cxl_port' types, update find_cxl_port_by_uport() to retrieve endpoint CXL
port companions from endpoint PCIe device instances.

The end result is that upstream switch ports and endpoint ports can share
error handling and eventually delete the misplaced cxl_error_handlers from
the cxl_pci class driver.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v13->v14:
- New patch
---
 drivers/cxl/core/port.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 3f730511f11d..a535e57360e0 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1561,10 +1561,20 @@ static int match_port_by_uport(struct device *dev, const void *data)
 		return 0;
 
 	port = to_cxl_port(dev);
+	/* Endpoint ports are hosted by memdevs */
+	if (is_cxl_memdev(port->uport_dev))
+		return uport_dev == port->uport_dev->parent;
 	return uport_dev == port->uport_dev;
 }
 
-/*
+/**
+ * find_cxl_port_by_uport - Find a CXL port device companion
+ * @uport_dev: Device that acts as a switch or endpoint in the CXL hierarchy
+ *
+ * In the case of endpoint ports recall that port->uport_dev points to a 'struct
+ * cxl_memdev' device. So, the @uport_dev argument is the parent device of the
+ * 'struct cxl_memdev' in that case.
+ *
  * Function takes a device reference on the port device. Caller should do a
  * put_device() when done.
  */
-- 
2.34.1


