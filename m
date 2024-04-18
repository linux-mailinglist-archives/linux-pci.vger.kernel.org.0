Return-Path: <linux-pci+bounces-6447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E5E8A9F8B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 18:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E73D2B259F4
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 16:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D07173356;
	Thu, 18 Apr 2024 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q37Gd3IG"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2040.outbound.protection.outlook.com [40.107.7.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150416F8F7;
	Thu, 18 Apr 2024 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456309; cv=fail; b=JwRTcUDlWdTBHWtmm2L6C8smeEsKlkKvVEGPoAxzgxDAe6vU2YJhDK4Bukw3+lVq9evMdtw78a9bV/qDfg464xK7szs2eqyH9d4bS9964N+IyCss0RKLE/B8q5Chf8oQ95OKsMuC4yh0QvRHoPmI7mi6r4IhJVBcy2dlovl0BQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456309; c=relaxed/simple;
	bh=6FD223ZMRY+0Cx6+lSaWx7PQsIl626YS8mTGNFar8Do=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=t4XR5EkQXiXGFkB2nSu46ade+nLBEO/rufKZxVRzmddr3wiYSdso5a/hPZVbq+nni8okF/+vG6KJpzxpyF+iYMZyE0owc1pPmq3gEE7MkizRPhqL5Q72k0P3fSphPjEEgOQiRYLtRkgNHYYLKQ1Q8LC26XLcWoHs9pjmXxQJwZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=q37Gd3IG; arc=fail smtp.client-ip=40.107.7.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AB8j0M5t2dnDRliwYXqNjH98NUylf52Ptz0yF2tTP5TEWfqbqwIppIbjqlpHCpMYF8TZvcI7AJPPv7Gf56LhmSawIq5LnGuLx7lHGLCqPtR+BpYMbqgXJm80fjuM9YnJqioL7JtHQxzaz1+MAMZCsxfo9k4kH8KFmFqPmWyHygpEOFdWKR8oxtLlvgttR4mGmwAEVylqt1mn/C18+UPRibijI2fHl8NGEFE+OBlIgp8iDFWQU8K+nGZm2TJteReyr0/wfqcr+9zrFmsZ1O4Isz9qLYVGE9NGzhrtctVZyGAkrVM1LR6w7sXy+9JA+OBzXQmDrxBt0AH5shc1Xqq2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JenbLbO8Z3CNvFbIgUb41pv30awKa54nznASQIJLIM=;
 b=PnWoEbxwtBIw2uKaiYYy+lrXxhtDf3igjxg2HRk0oBnOPLvY3VTnJ0MiFN3mPkc1MRFuMIUUVJ5x0wIUquYmAyulNqrmX7NWz73MwJHUexJtJXh01h+rqdwgDS7Zmdm0O7mj/VOGx4NnnQ/yGOx4zxOI8aQuNRn8Dd/upOHNbc/LPUK2E3DGi9IPPYThjkJlaS3Q5XPgUUK9z5XiFxiw2k66RCt93+g9y/e0iGwFzdzL8LTeaMK5b7UC+8l3tY/iT8UcgDpq5ucxwwOX4NGWSgcPOXe3cta196YwpzljQtzUJdFegB4BlSjQL2+8SQ3249mknHef0uMsYJ05/D0cIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JenbLbO8Z3CNvFbIgUb41pv30awKa54nznASQIJLIM=;
 b=q37Gd3IGvGL/4h7yMAYHx+kbk5lOONpMjP1BOzZYDSojNETmW0QNUJvM+EKnXc3CIQqaM9xmoDg7at0xyCsca8licYwUAKFZEgR0XjyBnxBCTj+SyHeboJIqXGnHRRiomRF7vKODLuPOQDPMkLKI22Rdn46m5ZHrcVY2omyTEQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9405.eurprd04.prod.outlook.com (2603:10a6:20b:4db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 16:05:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:05:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 12:04:28 -0400
Subject: [PATCH v8 5/5] PCI: dwc: Add generic MSG TLP support for sending
 PME_Turn_Off when system suspend
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-pme_msg-v8-5-a54265c39742@nxp.com>
References: <20240418-pme_msg-v8-0-a54265c39742@nxp.com>
In-Reply-To: <20240418-pme_msg-v8-0-a54265c39742@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713456277; l=6078;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=6FD223ZMRY+0Cx6+lSaWx7PQsIl626YS8mTGNFar8Do=;
 b=j3+bUZPA4eMGV/tUYAE56PAG5MZxiY8Y7fuPfvTp5lP6CehHSdQd9rnzURYkOQsP/xQJFF8ER
 mRF8/KxoZABByOcZyJrXHZOLvW9e3GSk1EKye1MsG9Tqjj8oAyB70G8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0102.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d25f40-f337-4879-7457-08dc5fc14ce1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	siNABfYubPY47qXEN/HJc8lVBk9xB5lABKKRHxUg2QPO7MWygu6FK2xfXStlRUw0MAu4/QPLDNFUrEdmsTtDyp0LsEX/bZe1MUiPsi6NGCiKB0wiyo6tGxx5tUngVQOJ/t7oOZmtRTbsMAl2qC4QjcdU3t+vyApKe8g8XqSY4Zs5M1NF4a0Q5CL806I6zZ400waXYPwIiLCWjV1aMxTKJ1QD9kkDb9Qiu3WnBhzOELbXqotIoVEdkf0N/xP9hkVLPLZ7bLCXHi2wqvIl1hAiK9mcmZG/uRCI29mtERpeSJ9YoTOx1KZ41sUEi/KAEFi22MhnpLzBrtW3Bo8yXvPqFrGTy5ll8S6HopVl3d/dt1wsm7xhQCw6co8nJGQ0rfEBEUfat69bP8jKz5tOXZAz03+V4mHn3uTy8Rc1wY2CJX1f11JoDthefQ4ECfvL3td4QnWoeXD7lsS3NOFWTNlRVg5R/9gbMT4YXI+bj70GI62jJLZLs/rahF2HkkKkC+Qsvbzscxsg0QGZyzplooMWIxL25ctBsEs0wiqtSIJT/Hwn/JUeQWp1EVbuJrazMUxpAqPiV7Vc04ONtY4ywczEeXEyKOQu47EnKPIGkDpi3AyERPOAPY4RcHFL12YCi7yLUPBuOcBN1s/ib+SL1QBPC7f2dkEnxuM6QOTgI6W6DQvrBp/7n3L1kwmRHm5BIaCUf/MWHAV1YvtsXZL7GpK2cNzPG1RnWJNnEl/eC2zo4k8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(52116005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGV2NzhXVmNSMURxRXZ5ampzb0E3bE1TeTVNa2VYRFcyZ3pRbVNaVlRLTEUy?=
 =?utf-8?B?WSt6Wks4UTJ6VS9iTmhFVGtURzhHMHQ2MHB6enRmWDJZR1RJZzM5UXcwVUhq?=
 =?utf-8?B?Vm9jWWRuUVdDRUxtc0Z1RElLbnU1QlhnM21tcE1YN3o1NTYrQzB4YVlOZHNp?=
 =?utf-8?B?YWVTMjlZQzNCTHM1ZDU3bWFQUDc1VUNveVkzQTdHWWprZG1CdExRakNkVCtU?=
 =?utf-8?B?Um00VjBXZ0U5MEtoUW43WkUzKzl5bDd2b3RTSkVvdHBmQm8vazZmZ2czdUNG?=
 =?utf-8?B?ZVE0aUk5YVQrdDcyUWtkS3ZhS1prb3BYYzBXK0NJeVg3bExkK3ZYbTlWc0RI?=
 =?utf-8?B?K2N4bkQ1eFY3RWZ4OGpRWTVHSGFxTHo3ZllOamJaVzBhWHNGV2hwOG5PdlB4?=
 =?utf-8?B?dmRhOEJXUUNrb2I4czJ6UmYvYmxCVDI0V1NoV0F1anJSL3RJUmRNcjRJUCt3?=
 =?utf-8?B?M1l6RFFKZ1UwcmI4NEdTbTNpdEQ3a3hyNGlmVXlRY0lmNnExTzhmWjJNZDFQ?=
 =?utf-8?B?a1dQbDd2SUNMNkY3dDRnTUpQbnM4eTJnRDlpRXZrbGR0MEgvQXM0VTZscTZt?=
 =?utf-8?B?U2pwYnIzUXpXdmdmS25FVmE4a2o2ZU1QS0lVdHF3TEVFZjNVNlFUZ3FBUkU0?=
 =?utf-8?B?ck1LVTkxODlBaVFqZkRodzRUSjY1Tk1yU2xpeWhoeG1aQ3hGaEl2WW0vN0tZ?=
 =?utf-8?B?STg4bXJrWk5uT3BaMFJsQzRrRHNocG9TSXJQZlhzTXFlYWRCWHpFc3hWaXRv?=
 =?utf-8?B?Uzd3amZ1ZzZKNFNIanFhdmxDYk9ZSHRBV3JYMmxiY05rRU9iWEZNU3VTMnM3?=
 =?utf-8?B?TUFYM0ZIK2xuR3hjYmlhMHJzMlU4bjdheTlmQnBBb1pyTnArNWxHVnMyTEV6?=
 =?utf-8?B?Zk9yNXhNeWNwYzF2dHFCaGp1UkxyZ2VKYVNQOVZlS0dyRU0vTEFUTmRCZFp3?=
 =?utf-8?B?MGRTV1Q0MUdKRHhiUyt1N0Q2NHFleG9RSVdaWmM5b2ZETzc5bHk4V3poM2M2?=
 =?utf-8?B?cXJFYitIYzFDRi8xZkl2MSsvR00vRmxFTG1UMXhXaklVTHl1NGhtTE9qTVR2?=
 =?utf-8?B?OXFOQjMxZ1RvY3QwZUZGVGFBc0xDSEVUb01YeTdOZUdGZ1VNbHBEaTFpbXVY?=
 =?utf-8?B?blhmZlhPUkkwQkdkenRiL0hRWE9ZSThCV0JjdWNoSkdKcXZzVG0ydzNQOFpP?=
 =?utf-8?B?K3kyNUx1NmtHV1hZdCtxeVJQeGQzRWNRTlNJWFhrOWhnZUJESWJhT3daZzlY?=
 =?utf-8?B?a2pIQzJ1SEh6TkdoSytScTcwKzVBQXlya1lVL09paXZxOGZNc1VSdVMxTFpt?=
 =?utf-8?B?UUpKU2xGR3lwZ05XVU5SZU5YRm9Cbnh1RitKT3BYUlV3TndKTFRKZlFaRWZ1?=
 =?utf-8?B?STNEZzVKK1BXWmF6Mzl4OEVOaWMyRXEydmhYcDdFb0RIZDg2dzNoazFET2V4?=
 =?utf-8?B?aE5MclhsSS80Qnp2TXVUV1JRMWNPVkhia3NWckpVa1hBblFkNXduWTJVV3p1?=
 =?utf-8?B?VzRDSVVJWkxwcVgyWU5NR2dqZTlMaEZEQzF2Q3Y5Z0gvTVU5MElpNlV0QUdy?=
 =?utf-8?B?bUE0OUkyZENxYUFMckFwekFFY2pFWUx0NmVzOFA2YkJkQVBKNytqRXZYSU9X?=
 =?utf-8?B?cmZhV2pOVnJOcFppWFdmMnR1VFRoVFd2ZVJkZHFZazc5UkRhLzJRa2EzWFNk?=
 =?utf-8?B?dVVOMER1UHgrZXB1SHRkSFpZcFFlaFBsODRSYk5OZEpZU3hST1FOZ1NSOVQy?=
 =?utf-8?B?ekY1cFAwTDhsSmJkTWZ4K0IvKzlGK1dsQ2o1UEJDT2xiSVlvdStod0hNR1hR?=
 =?utf-8?B?U1lNdm1laXBXN3NRRFVhRm93akkySm1aNzZnK3Ntb3Q2cmZsd01ScFJOR0xh?=
 =?utf-8?B?Z29TTGt4NHArOEhESy9yZ2trUkx5QnNOYWpUNXZOVFBiQXFmcWQ2K28xd1pw?=
 =?utf-8?B?YUFqUVpqdmFBb2tEY0phZk1ndGVzMVYzeFQrVVRCWmxEOGVwTXMrbHhKT292?=
 =?utf-8?B?eEt6NkVMSjh1NHhKQVViZDRFdlRVdU9EOHp5Wm1KZWpyWndjOWFNRnVXVG1J?=
 =?utf-8?B?azMxSk5qRWt2aE1PSG5VekIzV3pjRTl3bzlPbFJycXB0Q2orRHliY212WHN1?=
 =?utf-8?Q?l/yddD8mGSHf+vtrfsPBFjaY0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d25f40-f337-4879-7457-08dc5fc14ce1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:05:00.3793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIHkddVhC6hCOT8PaeMZXzqeh2HBl1xrtcSj7N8DekNLHlToLeCoPL+9a3crqzzDm6E2S7/We3dEBe5JjQrZtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9405

Instead of relying on the vendor specific implementations to send the
PME_Turn_Off message, let's introduce a generic way of sending the message
using the MSG TLP.

This is achieved by reserving a region for MSG TLP of size
'pci->region_align', at the end of the first IORESOURCE_MEM window of the
host bridge. And then sending the PME_Turn_Off message during system
suspend with the help of iATU.

The reason for reserving the MSG TLP region at the end of the
IORESOURCE_MEM is to avoid generating holes in between. Because, when the
region is allocated using allocate_resource(), memory will be allocated
from the start of the window. Later, if memory gets allocated for an
endpoint of size bigger than 'region_align', there will be a hole between
MSG TLP region and endpoint memory.

It should be noted that this generic implementation is optional for the
glue drivers and can be overridden by a custom 'pme_turn_off' callback.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 95 +++++++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.h      |  3 +
 2 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3a9cb4be22ab2..a0822d5371bc5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -398,6 +398,32 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct resource_entry *win;
+	struct resource *res;
+
+	win = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
+	if (win) {
+		res = devm_kzalloc(pci->dev, sizeof(*res), GFP_KERNEL);
+		if (!res)
+			return;
+
+		/*
+		 * Allocate MSG TLP region of size 'region_align' at the end of
+		 * the host bridge window.
+		 */
+		res->start = win->res->end - pci->region_align + 1;
+		res->end = win->res->end;
+		res->name = "msg";
+		res->flags = win->res->flags | IORESOURCE_BUSY;
+
+		if (!devm_request_resource(pci->dev, win->res, res))
+			pp->msg_res = res;
+	}
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -484,6 +510,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	dw_pcie_iatu_detect(pci);
 
+	/*
+	 * Allocate the resource for MSG TLP before programming the iATU
+	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
+	 * on the value of 'region_align', this has to be done after
+	 * dw_pcie_iatu_detect().
+	 *
+	 * Glue drivers need to set 'use_atu_msg' before dw_pcie_host_init() to
+	 * make use of the generic MSG TLP implementation.
+	 */
+	if (pp->use_atu_msg)
+		dw_pcie_host_request_msg_tlp_res(pp);
+
 	ret = dw_pcie_edma_detect(pci);
 	if (ret)
 		goto err_free_msi;
@@ -700,7 +738,13 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		atu.type = PCIE_ATU_TYPE_MEM;
 		atu.cpu_addr = entry->res->start;
 		atu.pci_addr = entry->res->start - entry->offset;
-		atu.size = resource_size(entry->res);
+
+		/* Adjust iATU size if MSG TLP region was allocated before */
+		if (pp->msg_res && pp->msg_res->parent == entry->res)
+			atu.size = resource_size(entry->res) -
+					resource_size(pp->msg_res);
+		else
+			atu.size = resource_size(entry->res);
 
 		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret) {
@@ -733,6 +777,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
+	pp->msg_atu_index = i;
+
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
 		if (resource_type(entry->res) != IORESOURCE_MEM)
@@ -838,11 +884,47 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
 
+static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
+{
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
+	void __iomem *mem;
+	int ret;
+
+	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
+		return -ENOSPC;
+
+	if (!pci->pp.msg_res)
+		return -ENOSPC;
+
+	atu.code = PCIE_MSG_CODE_PME_TURN_OFF;
+	atu.routing = PCIE_MSG_TYPE_R_BC;
+	atu.type = PCIE_ATU_TYPE_MSG;
+	atu.size = resource_size(pci->pp.msg_res);
+	atu.index = pci->pp.msg_atu_index;
+
+	atu.cpu_addr = pci->pp.msg_res->start;
+
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
+	if (ret)
+		return ret;
+
+	mem = ioremap(atu.cpu_addr, pci->region_align);
+	if (!mem)
+		return -ENOMEM;
+
+	/* A dummy write is converted to a Msg TLP */
+	writel(0, mem);
+
+	iounmap(mem);
+
+	return 0;
+}
+
 int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
-	int ret;
+	int ret = 0;
 
 	/*
 	 * If L1SS is supported, then do not put the link into L2 as some
@@ -854,10 +936,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
 		return 0;
 
-	if (!pci->pp.ops->pme_turn_off)
-		return 0;
+	if (pci->pp.ops->pme_turn_off)
+		pci->pp.ops->pme_turn_off(&pci->pp);
+	else
+		ret = dw_pcie_pme_turn_off(pci);
 
-	pci->pp.ops->pme_turn_off(&pci->pp);
+	if (ret)
+		return ret;
 
 	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
 				PCIE_PME_TO_L2_TIMEOUT_US/10,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 703b50bc5e0f1..dca5de4c6e877 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -341,6 +341,9 @@ struct dw_pcie_rp {
 	struct pci_host_bridge  *bridge;
 	raw_spinlock_t		lock;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
+	bool			use_atu_msg;
+	int			msg_atu_index;
+	struct resource		*msg_res;
 };
 
 struct dw_pcie_ep_ops {

-- 
2.34.1


