Return-Path: <linux-pci+bounces-6367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9618A8988
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 19:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15EFC1C237DB
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 17:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A71517109A;
	Wed, 17 Apr 2024 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="loQp+CCv"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2068.outbound.protection.outlook.com [40.107.241.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540717107E;
	Wed, 17 Apr 2024 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373211; cv=fail; b=YtboqV/my7dmFr8RkCyl0hTSCiL3c7nAiFckNccIr8EIkeM7OnSV7nvi0Jmz1Sc6+nZOzrkM3mk1iPWzfpUjxuYdVVTlromXNZME3njrRkhSnw0koMyep73c1v/lq4r9EZhYKYUW14b9ESzJacDyb8dpTd8XXRK9TfltBcFNw0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373211; c=relaxed/simple;
	bh=RGiIXYVRmfGJBV1HNXeAiH/lKJo/HvVSSGdFR93iLDE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=J7REGQuQi6VP3dEQtnh+3ZtmSfTrNIh6ag0mNxMa8UrUCQag5PT6YjLKRdYrgEicLEHTjTuL6O4nTnotbD16OoKTqPtLjnPqPlDvxAUB6qY9hET2+sYRqwJDCw9QkqnzaIpsLvV8pNeE9sgcW//LRnUXcVAk+dXDuEWWMTmYOMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=loQp+CCv; arc=fail smtp.client-ip=40.107.241.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjZ0sZ9FwD9R8C1XVgp4iYkdYejlcY464MTz24XLFqjcMCepvkLKSlQIY9XWXSS5R8kL1xZizgIxTva+jvNkWv/Suc+IG0pSMKF/bQH3Em2sEJnQ+vziurfk03xmkGFW75UPMdTuUf6kjf3nSza3CNMD8Eel5XWAClxA8XQRn3VWf4LNKHSLYMML9MvsWMoferopH1+Q9xOXHbkNIYCgI3oenWi8CSlg9SKl1oLVSgVxK/s2hehmCJAjr4vlwR2GZm/epV/013Rq7BmQuWKnUBn3k1BaVDzyiMUCzryl0gmdriOc8gU84I/0q+m+7/WGrbbwQblrwxoPCOz/Y8xD5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7XJormfUbxmrv0piWzu3dWXoF2ecnIxqtssuoVKEuJU=;
 b=oCt/apZU3OiHuvKJ3frKjzkbo5hcEPnzLfGImWVGtFdHoKTKbjsxWVeyEuV+zGJHafWDIsgA1P8pJ/eKYo4/d9Vs9p1oRj8/P4OIyWeEKjgQb0KyW/otudjlbFXj7ocwmgKL5cY6tU7DtgI1LYE8t7ch9nFAu0I4ipbY1E3wlp4O8GNZCwWtQlMbEs8ZDB1c6U1LCXIik1oUi9YUJfTTn70WCX1+ul51jCYTEeqeZN3/4KOCUftYMIxpVSkitAeA2sxDTwL1St6fonvqIRhdbDys/6mtr3u6o3k25W7jcz3Avq5pz0IhTOB5eR+eINrtE7QeZZpeU/k/YPZkPfB61g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7XJormfUbxmrv0piWzu3dWXoF2ecnIxqtssuoVKEuJU=;
 b=loQp+CCvA7SdleZkSz7wmSn1H7aeifIqB5noDu32oVsic+/LlL24+YwOydT68kpCYcfcaOzE7uuUUmRQDfnd9H5le8R37V/XVsXN7obESZL1sYm2jfPgK4fGzNd5H3Fa3UUv1A6OTrvAfaukEVqDznMymt4ApbJQAlhtjSpGrM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8080.eurprd04.prod.outlook.com (2603:10a6:102:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.51; Wed, 17 Apr
 2024 17:00:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 17:00:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 17 Apr 2024 12:59:39 -0400
Subject: [PATCH v7 1/5] PCI: Add INTx Mechanism Messages macros
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-pme_msg-v7-1-9c6208cda90f@nxp.com>
References: <20240417-pme_msg-v7-0-9c6208cda90f@nxp.com>
In-Reply-To: <20240417-pme_msg-v7-0-9c6208cda90f@nxp.com>
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
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713373200; l=1623;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=T7axIIwEU0hBwz5dW25mb2R9FYDj6emglE2AhxS6gq8=;
 b=QsAkgdc0M94P4kLwp1lMZ5Dj/5NWRiCC9kKaGAafSTD/ZJDnn3GxySi9x2PDlhfrodraChulz
 NHakwLBTjO2Aghxvjv9fn9zl/9UEC3OpadvC1dherDF5smYhyJDZiG7
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: fde0befc-5c02-4aee-fe14-08dc5effd5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bXWShc65dqa9BJ31BfhPcDTyFSCGTJkqZh8YKWgX1C4fyLwGhrpdaAd7BcMvd2o3sDJH03n++TbNkdRAfdNvC2XL1LPS082zr+IVFMDWAgTDBrgva2ALPrhSZjlj+2MKO3UJCceyLp9040dfx3JKZ7oNslajSpovQIq2kxlawRRfSGozNC9t1lzrw7VESmWvEetyfSB8DruyAB99oUpW1VcltstU3S3VP/MiUNI3eh4OcYZ8OADKps87BNx1jn5SrNeqKKGANuGkM0oQhvvVFBXZbRIDbAbLTITgYIsZSPORL99opAjtWNE4ZvfLZDGqhXVp99e2A2bO8QUOzREZKT9ncD8N5+h4pXVArfNkPGJlKBpATo5l6V0xuqfw590ssb1FbPsF4GeV0Axp87UdICLK2KeReDXy5NfIrM3yoMoTBZ19KX3P8l+MI8zKxc34R816HJzD0XbNi3O1HeyxLFiGZgHCb0QUuB4hPEN6Wo0s5pxeujownXw3Wn0qF9JduQ1CI17f8c4VTmcxDijW/57efkYXFDCtHZb86MMug1oQ2Ba+bEAvxAGwJqv3YJjESgsVA+/Th/tQ7uYG4WNv364uZtd/X74Z7jBuMpi/NDbiNCU0Pf5O5bWg8QL8zfeBIYfFHP8bQea9B6Ng8WPI1niDg4HYoGPXpiQUyX7DR1k9SIR09fTfOjQj4UhQ8nyHmLYr+i5TfZcrp73BwYW0y/6fVGWN3JDD7UoVYxzlNe4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTVMd0o1cjdBVHgxTHlXdHVXVWdBNGJHalRIM2xtUjJnanZoWUNZTkVwL1pR?=
 =?utf-8?B?QS9adWwvZXJldmRVSTI5cUJHRWtldFA1dDgzQVpOYkIyRXNGdkwzaFdFK3l3?=
 =?utf-8?B?ZmZPNUhwenl1ajVscStXNnBENVBJVHZ4bHB6MmhOMkdkNnp3YVRPOEtzV3Nq?=
 =?utf-8?B?T3hLVnN3aVlCSVhNWW9UMDgxYytsRmNseDdmSjNOQmI0OTE2L2hBT1Z5M0lV?=
 =?utf-8?B?VVREaWc4c1QvMGVVZVFqclBsVFBCL3V1bGdQTFN0b3hpS0JDVGxPSzNxWDJQ?=
 =?utf-8?B?TlArSllFbWZUN04rSVpxVGJPQjZaMmVmM2tGbUFacjUxMWc4dVJVeTZ4WCtO?=
 =?utf-8?B?OCtSYnpKeWFubXl4Qk91NjNRWDJRWWpDWm43UUlQZlNFS3grRnRkYUM1Qmp0?=
 =?utf-8?B?SHY5ZWlKMyt0NTFQb01OazNvVzRheTA0Y0s1SWZxVytYaGZaWTJ6dUFXUE16?=
 =?utf-8?B?OUhlK2RHcnczSGxTdkpiVzJ4ZFgwS0x2eVBOS3dxSkpmRU96U1RtVFFGcW1m?=
 =?utf-8?B?YkxSRHU0OU83NDhsY1dXdjAwUDBOcXlKUkZjb00xN0RuaFRXWXg2aDBkMU83?=
 =?utf-8?B?MU0vNE04YzRRTmFweU5ESjdwQ25GOFpCR2d1OUR0UktncTlJNytNNVd6NmRH?=
 =?utf-8?B?N0t3Z21KWGRXV214TjBKdnJPVFYwRnBmR01sY2s4ajlqWHRKakFKbDRHM0ll?=
 =?utf-8?B?Y3hWSzJ5WTBLODdLZ1V4dUdMZDhPUWs1anRQME02KzF0Q1MxLzlUVkdVV1lS?=
 =?utf-8?B?eVphR3Y2NzlwQ3hlTjJ1UkpuL00vQ1Q0cHl0ZW13dWVQb2JSSkJNS2ZQeWlp?=
 =?utf-8?B?M1hTTW0zcTBJZ3hPVWZCdDk2ZGMxaDhZRUkrMUJ4OFA2ZGlUaFlEdEhiSE9I?=
 =?utf-8?B?UmRZd3RERDZaUnY4b0dyVndGZGh4ekUvdWJWTDVkRm1Qb2JKQU0wdWRMWDFQ?=
 =?utf-8?B?NTdiKy9QTWY1Z1VDcllUMUVkbUI5MXFjc1o2c1plVnpyY2lmQ3QvU2NPTURj?=
 =?utf-8?B?YXZsZXVBWGJnUUZzOVFzRlNaekp0Wjh2YmIzQkh4NyttWG5QRE5MTjJUYjRL?=
 =?utf-8?B?ejhnaHRTdFRDaTM3STBNNXFnVlFiRlZRM25JY003QWJRVkF6YU5HdG51MlNZ?=
 =?utf-8?B?TDFmc0dnbjBrYWYrSXZOblVMeVgrTmFQcHlvZzloWE5lM1hCVWdwdm84dTdU?=
 =?utf-8?B?aStpYzNTQWcrNHZqTDFzQW5lL0xoVVhmMlpVdlYyU05sZ1dTQW5LL2R3bEdx?=
 =?utf-8?B?TFNyeUVzZG1ybzVHb0I3WUFYeUZpcDJvaEUrL0tkQ24zdHNEOWswdVZLZXlU?=
 =?utf-8?B?ME0yNktXUWptNkZuSUNRWkVZcHp5MkM2TW9SNk9JR1E0TE50NmY5d2VPY1Q4?=
 =?utf-8?B?bU5EbmJxemJ1YVJmUzFGeXRlRnpRdmdQcStZZWhOYzBSNU1jbWJFcGovNHZr?=
 =?utf-8?B?U1J5UmljelhUWExpaW42aTlXakVtYzB3WkExdW50K1JMYTNVY3RKSC84UDlr?=
 =?utf-8?B?WkhSekxVOFJrTnZZRHdPUFlUNUEvaDhla0tJWldjYzIzVGpkYmpGcEYzM0JM?=
 =?utf-8?B?dUlHUm1uclk4dGZDY1lkU2dPMmhpdG1mZnBxcjU1MjdDVWhWU1ZKbnVQTlRj?=
 =?utf-8?B?ZC9pRWxYOWNadUVlaHFIdUowMS9ZL285ditReThSbEFQZ2J1VmJVdUd0bW5n?=
 =?utf-8?B?K3c4bkRKZGlCYkVqdDBuRGRBdUVvKzdjQnVHak5xRnVHU2dOUVhacEY3WWdj?=
 =?utf-8?B?TGtqVlJreTZzdlg1YkkwUHI3eG5HRnpUaklVcWZyd1JHYXo1ZWhmZnlLOUYr?=
 =?utf-8?B?WmVCTHpzRkZ1RjRWa3dCc3RwL1phUk5FN284TWZtYXJxMVVXU0pra0JFaU4v?=
 =?utf-8?B?RnpTS0M3dnQxcE1xWlZST3ZtRFkxWC9XeUhCQSt0WUFjL0JuT0RWeE5IWTFS?=
 =?utf-8?B?L3JoeFJ6L1dqVWJFUDY0RVloTDN6RDJFOGZwQnMzdE5UT2tGbXljR2ZDRnNM?=
 =?utf-8?B?RW9Pc3BEQ25SdmFzdm1GcEJpK05haDd4T1hjcU51WlJmWnpZemJpN3EyWFFR?=
 =?utf-8?B?QkRZZWJaU1JueG82dERDMDVONzIvQW82dFRrcEdVMnZPcFNCeENsMlNodTNC?=
 =?utf-8?Q?mWw3nTMrDVlXgvFj4AdmqjJS7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde0befc-5c02-4aee-fe14-08dc5effd5f8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 17:00:08.0033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rNJbzGNIlRDWecGH1vNipDhfG8DPt1SD2mZjnAivHJkK10g1F6ERGVduKkhwD2qsBwL1bU8Yxr5G0zvlWZL1kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8080

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
index 17fed18468474..02f46875fe2d9 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -22,6 +22,24 @@
  */
 #define PCIE_PME_TO_L2_TIMEOUT_US	10000
 
+/* Message Routing (r[2:0]); PCIe r6.0, sec 2.2.8 */
+#define PCIE_MSG_TYPE_R_RC	0
+#define PCIE_MSG_TYPE_R_ADDR	1
+#define PCIE_MSG_TYPE_R_ID	2
+#define PCIE_MSG_TYPE_R_BC	3
+#define PCIE_MSG_TYPE_R_LOCAL	4
+#define PCIE_MSG_TYPE_R_GATHER	5
+
+/* INTx Mechanism Messages; PCIe r6.0, sec 2.2.8.1 */
+#define PCIE_MSG_CODE_ASSERT_INTA	0x20
+#define PCIE_MSG_CODE_ASSERT_INTB	0x21
+#define PCIE_MSG_CODE_ASSERT_INTC	0x22
+#define PCIE_MSG_CODE_ASSERT_INTD	0x23
+#define PCIE_MSG_CODE_DEASSERT_INTA	0x24
+#define PCIE_MSG_CODE_DEASSERT_INTB	0x25
+#define PCIE_MSG_CODE_DEASSERT_INTC	0x26
+#define PCIE_MSG_CODE_DEASSERT_INTD	0x27
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 

-- 
2.34.1


