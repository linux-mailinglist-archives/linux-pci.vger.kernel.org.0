Return-Path: <linux-pci+bounces-19437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EEDA042E4
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B0F3A2285
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9DA1F3D5D;
	Tue,  7 Jan 2025 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3iLcs9yr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FA1F3D3B;
	Tue,  7 Jan 2025 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260890; cv=fail; b=WMT5BxBhpNtFbVGsPZFRQglhzcAaE8Q1TEJCXyHmT6vec42H82N3WkYLyMRE72h9HJOAz7Fb9Y2VTqevvtRYX4MGtQ14ONZGjX55W0x0dB9kr8tIFFF7V8mH67j0rn7Yk/vLMm7oljzicTfdBm5Hhgi6LdMInzbfGAmfehspL/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260890; c=relaxed/simple;
	bh=zt0fm0U/60V/RTTedfawLlcIctW1YfwlF7GWnc88HMs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzLiIeM+9WmK/BCWw0So5OdfeZd+6Ny0uDZA40UvGZfKl+ZOZ0ZAcQAn2Hsmt6bQDwUyYWxgrYqBfCqH56r8M1KxcA+060ufQgGwMYdDh93RkklN5JFk60zUI2P/eq60DWRf/QVYxQKEjpj9JrorltOHLiQjj9vJZeTUso2MiLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3iLcs9yr; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Th27gLUoMfxAJKZFcg45DKpjL6OMhnrJAEMpQUMWd/9R3AFe+6cyybiRlsfG0zn0Q25oZaiQd6Jp3zGBHNsnMzs0iFfpl72HA8EPZ6B0vctqdPo1VXyk8MxNhdxmxMfZyaKrHXBoZxY6Mr8R8sqfBgfO7jQLCO1ZxK8raihmHa6lzc18qlNU5tj29c6lZTrXvIuQ7yKdGiDG47DnQbREfTYppYere7pXNqV1BHJ7hIKT014OuheM434/yxnOsx0hbVg/hqTYnaqsXQ2nctrH3+EEmGbNd9pFDOtajd+x+SW32Gkav9AA7z93AgUAyFcVrijG/nO/4igLwgXTJFKiHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVoi9+/VdugxpUhGgdAaW6tCiE2N5BLnCKt+R9nUQGY=;
 b=FhRdDMpDEQ+S0VZ6whom0FX+QL6Y1fnIxGR9Nh7gWSseRyCktTtKASuEA/V+wNiBn/7LLkYcF407NXu1CD9Z79mzGVJfVs4SIgbGjAaW9lfPwCVGcTg/qd7t3zPHc2qyge2gbqTs3eqqwezeX3v2qtGxXo0Hw9HVT3t2TKEmsDZLqRvKl6/ZomYaO+jg3T9t+lDr6bUyEzhYZv9NNJ2X1RW4PbKjGo0DO6mORJVjV/zpW7AHdkKsVL31nB8MVbks8/Vqehw38kY+21R+pV7HBbh5cZ/iyKre7KTGoO4BrcfbsF1hg8Uw9+gZYDm28WXmPToEW7jbO8PTu4MXVUOSxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVoi9+/VdugxpUhGgdAaW6tCiE2N5BLnCKt+R9nUQGY=;
 b=3iLcs9yr40hmSIXQmvNRAAvevwz16V6Lays+/LVqUVVWqc5ESM5IgAXtOfQ+XptimPJXpx1aFQw59DShYz6mJeObcQ0aQOKTa4swuvDF4lHDbqatoRilfKGdZTByRVz0LPu/9wZPbxBEVohVRY3KXhrOVFBnxfj90ERwq8g6Wg4=
Received: from SA9PR13CA0082.namprd13.prod.outlook.com (2603:10b6:806:23::27)
 by DM4PR12MB7550.namprd12.prod.outlook.com (2603:10b6:8:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 14:41:19 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::d7) by SA9PR13CA0082.outlook.office365.com
 (2603:10b6:806:23::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:41:19 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:41:16 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <mahesh@linux.ibm.com>,
	<ira.weiny@intel.com>, <oohall@gmail.com>, <Benjamin.Cheatham@amd.com>,
	<rrichter@amd.com>, <nathan.fontenot@amd.com>, <terry.bowman@amd.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <lukas@wunner.de>,
	<ming.li@zohomail.com>, <PradeepVineshReddy.Kodamati@amd.com>,
	<alucerop@amd.com>
Subject: [PATCH v5 12/16] cxl/pci: Change find_cxl_port() to non-static
Date: Tue, 7 Jan 2025 08:38:48 -0600
Message-ID: <20250107143852.3692571-13-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250107143852.3692571-1-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|DM4PR12MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 6afff1f2-d06f-4270-7c0c-08dd2f29593e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K79rymDIBl4WVf5B7ELElivKpe1ToZDppGkZ31bjEmAvkSVvJWspPbDB77M1?=
 =?us-ascii?Q?kHaK+qGoEHTYWjt7pHDr7U+x7P5XSHcGDDvlOy5m3mEw5ftPOQe87ZmmdTLo?=
 =?us-ascii?Q?qt4pK9hsWOnWE3rw7Wjj9ctofwutLtcEcOMDXNiRy5JwRtPAvDZ0oqCPW6iM?=
 =?us-ascii?Q?xrV7TpmQCYZz0soo+H6lOax45TEPvRiaDulTK/2/Bh1KsRXlouweXEoHKVWB?=
 =?us-ascii?Q?uMZ4Qv24jBeEsv6UfkMso9GZpRbvkjx1PRCXbSAUGcBbss2rfCmRj84VlkR4?=
 =?us-ascii?Q?9EIBB7gNbL8CF6a3Uzci+oShu8/9wIN5JVQwVWg3d66QnpRWYi/peH3aFVf+?=
 =?us-ascii?Q?Yy3hkWh26OsoiOG2ZVXSQXLhZLTvrg8rUgURyAhIXvdESrb2G6KItF+Vftom?=
 =?us-ascii?Q?8UKk0fPtEJuFhBQedN42nhlEzh1UGK8ZdcZcyakt3geQMJlI5zctrSxVyrjM?=
 =?us-ascii?Q?vKvqYYjzjf3IZOAXZkrlykh7etzwd2zbx0l5tqWNcDp1mNBXZybXsL9xybWb?=
 =?us-ascii?Q?iSysGfbgktPNXgXiWWj9XXr5+sL60AmmIhhJw6z8840OaFtWJR1tcMb/iysq?=
 =?us-ascii?Q?/iMmh/rzAuHW/o1WO1YKN2nKaQAa2Ai8zOnoAnd7mT1bX06DvL7LjoHkc22h?=
 =?us-ascii?Q?r4quYztRNi+TzQDwJoCvLUuhCYUMEfUHiQouGL+FImj8tVsI7fTxPtmSCTV4?=
 =?us-ascii?Q?JphhZ5pREg5JkR9hELH3pL4KOiqAcmqhgznFQFKsuETqS+OcPuyZe4ZLqO+y?=
 =?us-ascii?Q?kehXtKS6XycbSbzTc06y/ez9TJdck74+/4hMhJ7owa1oNXpTxZZbgF0Yuq/Z?=
 =?us-ascii?Q?94pVDNLQxP/CbKNpQKCg5WoSXivDahtGU3ZQ4pE7Y6QCGzA94X22gu1ohfIe?=
 =?us-ascii?Q?Ap2+/KEsjcHb4RBMx6/rWJGgYXkNUy6UuHazizFrlpKiR8pMyxsXJgor5fOx?=
 =?us-ascii?Q?EaRJHUAbWbA7LsNmWswn6KtcLvE9MWq1IbvhB2H3VJ31xL8miAXXKfW53JrE?=
 =?us-ascii?Q?jFYM7Q5w28ZZo9DJbEXT1xtHS/R4Wem8ZPQGE37dhQNcgy+mrdIztgD81zBV?=
 =?us-ascii?Q?tyOxHETqU9LNEuleKroBTdnTOuIgfgJW1a53oeJT6rlkv28jqAdXgx+dtCOL?=
 =?us-ascii?Q?awslP5fd5m6Tkklg255IayJoqxumQyzbNWRqCDD6p/6HuWcQKCxPPGUxZJv4?=
 =?us-ascii?Q?WJq8rt1msfJllMl0sum7s96xjw/16l0Yluxz0/PmzQdxOMl8k4Jok/Ep0LYe?=
 =?us-ascii?Q?a3vGR4qv4s61tg9mybxME7wAypLt3cACxZUSUZ5NBw/o544lhAgClA6BUlm5?=
 =?us-ascii?Q?MesLFj9KlsQq2IPrQHy9hWMp7PRfrQLX4ZiWI1ivzDvryGw8nLLh9s9MQuzp?=
 =?us-ascii?Q?CJfvaBhGqLl8PHwITlP36X/nxt9jCPdxf/Rrs34V16YufG9JTI6jtTuNBnU1?=
 =?us-ascii?Q?RVPPVwxv/GUYL87dmFa8MCzhT+TCnDdJ845THdZlmWqFcclfqMfNxk7e9h/U?=
 =?us-ascii?Q?G43WzHzQFVdjH2s0REHUgQztXT3yYMLBvCbn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:41:19.3129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afff1f2-d06f-4270-7c0c-08dd2f29593e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7550

CXL PCIe Port Protocol Error support will be added in the future. This
requires searching for a CXL PCIe Port device in the CXL topology as
provided by find_cxl_port(). But, find_cxl_port() is defined static
and as a result is not callable outside of this source file.

Update the find_cxl_port() declaration to be non-static.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/core/core.h | 3 +++
 drivers/cxl/core/port.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 800466f96a68..eb42a2801f98 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -115,4 +115,7 @@ bool cxl_need_node_perf_attrs_update(int nid);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport);
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 78a5c2c25982..1ee408412782 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1342,8 +1342,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev,
-				      struct cxl_dport **dport)
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
-- 
2.34.1


