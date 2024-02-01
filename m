Return-Path: <linux-pci+bounces-2940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D39845CC9
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 17:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E231C2A379
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952AE81ACF;
	Thu,  1 Feb 2024 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fe2nBStb"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2088.outbound.protection.outlook.com [40.107.104.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72013779F7;
	Thu,  1 Feb 2024 16:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804031; cv=fail; b=PSTPbhewB+tVLc8wCLavzA/h4oqkYikT4+sNP4egrujgZW2bsOvzpMri4aF8oOV+SxGIyqnu4zDI6Upzy9fXCg7N1XdjWqHRlBHOUbFlpdJ12oCZSc/Nv/zrbYrKm3RlUnE3WHik1YQUhEAqkdnC6M+8z7fb6fUYF1YxNbzhebM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804031; c=relaxed/simple;
	bh=fr5F/NMvcIdoIVIUI5D13pnNFmYbF3Hf6pub7RqtnLs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OErdMjyV6t6CUS5Ob7TJSqNwae0tgF7wBCCRsalVLKRCQa1EL0UR1n7upmmXhrX7ilsEqKvysU4phQ62qpYi5Xo1btCUP91X3NuLqIApLpd1aHbWihWU4UVlEKugPzbySNWIMBRvkQR+jpPHjtXUBCaMrILf/4QGhTIWZotD/04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fe2nBStb; arc=fail smtp.client-ip=40.107.104.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtZLPWaHHZGD4bBinpaaS2uhXAvcxtT4ohkxUTFckNrd9DroZR8ShHxv3MIgKU+J8dPKaIrZGEjKWQKo+ovITSmpI7nUg8cLUMqEiP4Elcv8ROkRUEzQV3RtXFWDxWn6MJU7atj6gP0JFcgKSrK/wGgFwktFW92v0YmwoWWUN3vh/Rg9XWCJyFTlLlctrdZAUcaCKAgjmu7PWZPgDxP2oApKpXKOTxzo5SzXeez/yd0f/4weE2BXYmQHnKZtnzLRhOLYtI/c4NFTGsT5PKbB9rA+q/Yo3K1+c9cyYp3ih548l515TpR+NIzQ351P15abg4duLygciS3pRDe8Z2E82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saEmtOwB4Gc3XJl4hmoCStakXVvmGfCb6yNjLIDKTV0=;
 b=aJ+3QT3h8kD5ywGGtx1YIGFnblIMwTJ/fZrUxwMMmHKeC2p52/rXZsA2iLu180c/BVSVcxJlYG4ZDh8JSNuqYF8AzXRA0nZNQ8e4pJfAeJpKK1hs3oNNCh3uwru4iEyiER6Q4gxUElXbMFywrGe2/r/zo/Q/x0x/FdJUQY5N2r+4KhN7x46PpFY6ZPAfU5nflEWDnM4yfBVExSVKccAdz8Ix6UPoB69ojskmaQ+V2a2jUqxoUPgv/NPCA2KuZ70PDoC4UEmnEWDmgv4vAr8JaTwANYNohszVQYddxHv3J8q1OEgrcSc9D4MW52wO86yQjS229s903rvUUlUj9qVXeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saEmtOwB4Gc3XJl4hmoCStakXVvmGfCb6yNjLIDKTV0=;
 b=Fe2nBStbsfi1decn8ZpuQaHEkfZuWLp3HaI+rySYvnoOXkWF9S4vIUBlPB5pIWeH8oHVjSITFBvUN/dsWs9bKZKQCvsQNBMsHKFfI3JfMUU75eQh/yWr6KJnIqKQBINsXidLbWcbiGdNN6fnH4iFAUyTddmlIQmrzi2CASPdp2c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 16:13:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 16:13:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 01 Feb 2024 11:13:25 -0500
Subject: [PATCH v2 1/6] PCI: Add INTx Mechanism Messages macros
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-pme_msg-v2-1-6767052fe6a4@nxp.com>
References: <20240201-pme_msg-v2-0-6767052fe6a4@nxp.com>
In-Reply-To: <20240201-pme_msg-v2-0-6767052fe6a4@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Serge Semin <fancer.lancer@gmail.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706804020; l=1563;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=V63Eq8UBEqU9bY2RF68hjfzqp6UKmY7eoXAuoGScqbw=;
 b=4wFs5KVa6oOPfJwwRVUlj91CsvWkZFa8SQunJ4/fnoSgZ8jHWvLIWhlzbBsXHizxhAVYn/uIN
 L3OxHqa9Fe2AHvE6V3o4JyEhQBjsYWIVh7Do+X3Rf8VQTkCgys2YlqF
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:74::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca3e157-e0c1-4073-850c-08dc2340c597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2MJraVC8RC6XcC5wQ5HFLR3BQNDhvFsex2FPByIA4HIc3DvLujtz4A7vgqWdW+8y0zBI9Vwe8nzpfb0F6nHE+ZX7/op/feSSeViIZwi6fBrlxoAYGirFRKEd5Ie5IdEOHpz+wd3GlHTglS68iEHKlsZR+AiAypSgcnEcAtLfIdwrMquuTM3BCwBrWwgb4TFqVjqdhqd9mUf52VDfYNkyK0ONPeOJ0lsd9ipmx2CSjJGXA/WdG2EPvUvYd8pfYilI0FJi5N47Q5snI5YmgG2Uur+pO53xIyj2d87ujUlbmMINNCiZyn+kptJkNBPtYOqf5n32eVohcPKjB2wMfabjM2/48sg9xF6WFNfLJXVc5ZCuhy59fvxm2rzowMs/G48GUJLRevM5mmTmgarF/A2lYN6//hkFzpA7aw5RS8cgzKwJgN/wfPs+B8xOQxKypaMQbrLwxYei4DDRSpVcQDTTrnI89e06aHjffgd7YvO7IykJJsR6kAW924tG21yNJo9E3sYTbH1vVcvqlzcZH5NNr3PYIexgCEk8oCC5vwcjiP3Q1HfBJNZ0HGUHaNsUrpJhVhEtNBocC/OJchp16w2p6mbmmm1f0NzDpQJgnLjjULOobsXAT6yKU8GT+H2exI655HFUoT003hH0on9DADKwgA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(15650500001)(2906002)(7416002)(5660300002)(41300700001)(6486002)(36756003)(86362001)(38100700002)(478600001)(38350700005)(52116002)(83380400001)(6512007)(2616005)(6506007)(26005)(6666004)(8676002)(8936002)(4326008)(921011)(316002)(66556008)(66476007)(110136005)(66946007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXFLV01HOWMyUCt5dGJvTVNLbnZ2NnhUU3hqUWJBTnlxWlN6TEFWYm1KVERx?=
 =?utf-8?B?R3pVVzJJRDI3N2phcUVTWDZNNzFDUXVyRThvUEMyck0ycXE2RDZkaHIxVndZ?=
 =?utf-8?B?VHRtOXBPR2JzTkZWS2l2ZHNIUkJaVVEvT1lGRkJCL1hlTjMxYjVDcjRHbU10?=
 =?utf-8?B?bys3Z0pUZ2Y5MGtkcHVVRWJ5dXl4OHJYZS9IU2FLSHhueW5iQlJrd0NjOTR0?=
 =?utf-8?B?eEpFMkhQcXQrSk9zZW1ySWRMTWRwT2xWRmM4T3B1KzZzS1MxUjJIV3RPWGwz?=
 =?utf-8?B?UVZnbEtEZHF5L2Vrak1QeTl5U3pZR2RXNlFreEJTSUpmcGc4TzllbUV0c2N4?=
 =?utf-8?B?cFVWU1YxY3ViYjhlNlAyZ1BTU2FoQ3dsSGNVSWtCamRSYUFyL2xxQmhCaSsy?=
 =?utf-8?B?ZDlrS3F3eGc0WmsvSmpVQWhNTXhFcUxzcDJTbVR0bDNXdEswaUUyamh3MU4r?=
 =?utf-8?B?WkNhT3UvYzRtTzA1eGhRenEvWllLREhYT1FnVjFsWnBhMXdIZzM0aTBOWG1C?=
 =?utf-8?B?NU5WbmxUNjR1TXkrOFVjci9yK1FFOTBzUHQ1U28ybW11dTNtSDVGbUxLV0Rl?=
 =?utf-8?B?d2huQklUSkYzRDFHK0JyTkFqWllWWmJqSkg4UUFOdnRhN0YzWk55VEVoQnFi?=
 =?utf-8?B?dUtFcFRxWGp5UDlGV2txSXRDVDEzV25maWEvbWoxVFNscmZ5UkVqMUQrSkgv?=
 =?utf-8?B?ZjJPcEwwS0FiMlZnOVVZckUrcjZjemxnS2YwZFoyNUJlTElqTm9McjdmYWV6?=
 =?utf-8?B?YytYTzR4NWZ3OUt1M3hJMWE0eGVsTWM0Tlh1bzV5NnRpTURyZ3FvT3VsZjBM?=
 =?utf-8?B?eTRaVitlYzBLekZ2c01mWU94eEkxK1ZlNU5nQTVKWXptMnMxVVdSZnRLcDRY?=
 =?utf-8?B?QlZ2YzRTaENUM3FGMEF2QmpyVDc2azAyV0hOcU96MUJralJpa2lvaXNLSURK?=
 =?utf-8?B?MEo0cXcrQUxTbFZlMFhrc2htdDdYY0ZiamFVUmFWYk9OZXZPaDBSYS9SUUVa?=
 =?utf-8?B?by9NRGRNc2ErQU9kYUNqQUxTWmhJYUNFSHI0NXQ4T1BmUTQwSWN1VWtyUk5F?=
 =?utf-8?B?VGszM1BxNFR6TWVqS3JPUmdjRDJlUmVMZ3N6bUF4MUh3SHVldk4wVjJydkF1?=
 =?utf-8?B?NDBCOWhkbklFckJ6QVZGQ1VDWTNhR1BxbGdGTFNUV21TOVRqUEtGNlRLZFVW?=
 =?utf-8?B?Ujk4T1dPYjFGSDlnR3owS09ienlxeWVNaGUyT09ZVXcyczRFVDlRYUdROVp2?=
 =?utf-8?B?MTZhOHVDUmR0MXhSWWw5ekNkUEx4cDdCOVovQjJkZXNvUU82OEF2U0xuUldq?=
 =?utf-8?B?Rkc3cjUvKy9xUkZCN202dlVYbUV6d0hxZitNWHpYRGZqWTdoeTVCK3V4cHRZ?=
 =?utf-8?B?b1BGVk5XMDF6MzhCc0xVb2NvZWR2dE9TYlJKTDBMZTVZd1V4Z2xIcTNrVklJ?=
 =?utf-8?B?TTdVcmpSSzY4ckxHYnZzNkwzTjVxUXVndkFvRDlvUGJpeEwya1VBc2piMGJz?=
 =?utf-8?B?VXVnQi90QXdkR3NWTExiYTFTcmhncHlGdTczVFkxaXdxQWRGcVg3czJRK2h4?=
 =?utf-8?B?ZytVaUMzRmdaVjN6cWRvclVhMzJlUFRJZCtZS1NyeWxvcmh2bE80ZlRFTFlP?=
 =?utf-8?B?VFIxbVZYVWtHcEhRMGxqaVpyZ0tndHhzZ0dTV2FBSEZvVDRsWFZ0ZnA1N2NB?=
 =?utf-8?B?eEJKWlJiOVUxNVZCSWh0YnJjS045M282S0toem5aZm55dHJvbm5iTHFERWoy?=
 =?utf-8?B?QTFIZzVmVFM4aHB4dEg3dGt0QWhibFk0dWR1akdWOFJEVkluZlUwY1M0NWs3?=
 =?utf-8?B?YUYra2tISjJPVzdzaG43c081c1N4eGhsNk5GaFJ5YUsybzE4M1dHQms1YVUv?=
 =?utf-8?B?c2lpNjNZTVpXYmlOMzMvT05XNFkxZytoRjdWWldJYUdEQ1c2ZnMwYS94VzIz?=
 =?utf-8?B?NEc4dzFUR044KzlNVG1RMmFUMXFaVXQvTEQ0NzNsYmJhVmhrbVUxQWE1MjFO?=
 =?utf-8?B?R3V5bGVzVk9pODRsdElMRWJSNTRmZ3RKSkorSW5wU3BqcFJDYkNkcEl5ZjI2?=
 =?utf-8?B?WnlCUXp2REJPSnRIVkNLYWNGZno2UE9VSGs1WmlWOVd5c2ZyTHZuT3I1Nmxr?=
 =?utf-8?Q?7P5A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca3e157-e0c1-4073-850c-08dc2340c597
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 16:13:48.0596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zV0WYE+Sc53pn7jRvwAvZn1orkqi0Clm2CxnNyoVXJTpoUC5Ka5EyQXAvmiT49rQdxMdxUqmSnj4wvThBAUxeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add "Message Routing" and "INTx Mechanism Messages" macros to enable
a PCIe driver to send messages for INTx Interrupt Signaling.

The "Message Routing" is in the section 2.2.8, and the "INTx Mechanism
Messages" is in the section 2.2.8.1 on the PCI Express Base Specification,
Rev 6.1.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2336a8d1edab2..fe42f5d10b010 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -22,6 +22,24 @@
  */
 #define PCIE_PME_TO_L2_TIMEOUT_US	10000
 
+/* Message Routing (r[2:0]) */
+#define PCI_MSG_TYPE_R_RC	0
+#define PCI_MSG_TYPE_R_ADDR	1
+#define PCI_MSG_TYPE_R_ID	2
+#define PCI_MSG_TYPE_R_BC	3
+#define PCI_MSG_TYPE_R_LOCAL	4
+#define PCI_MSG_TYPE_R_GATHER	5
+
+/* INTx Mechanism Messages */
+#define PCI_MSG_CODE_ASSERT_INTA	0x20
+#define PCI_MSG_CODE_ASSERT_INTB	0x21
+#define PCI_MSG_CODE_ASSERT_INTC	0x22
+#define PCI_MSG_CODE_ASSERT_INTD	0x23
+#define PCI_MSG_CODE_DEASSERT_INTA	0x24
+#define PCI_MSG_CODE_DEASSERT_INTB	0x25
+#define PCI_MSG_CODE_DEASSERT_INTC	0x26
+#define PCI_MSG_CODE_DEASSERT_INTD	0x27
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 

-- 
2.34.1


