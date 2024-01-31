Return-Path: <linux-pci+bounces-2849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48982843236
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 01:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C540B226D2
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 00:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A89C804;
	Wed, 31 Jan 2024 00:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W7OTadz/"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAB15681;
	Wed, 31 Jan 2024 00:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661973; cv=fail; b=WQuP9e0+5/6a8KFTF5gRnyuuwdtb/4KMBo3FX5tFomI7vEcDzH3QOYlBiohu80OLH+dMJUtp1KJL3rypcH3CSZjigyN+oXoZwPJsJ2u04ybM4w9P6hgyyM9K8rRXEzY6MkxgMKbH9l6/KbLAYVOJ2gTZx9ayhWuxypf+6xNaoHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661973; c=relaxed/simple;
	bh=D3OVyPoQgbl9xXSYR/1BiTXAJm+k9I1uFEMvcHMr1z8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kuuIJ6DAqTyhqhbsNpiKRbffvfsR3MLlgm22tv3q7V4Zp2UvIaNMmSKH82giRt2bvMmlTtd3vvTKT7FPoqgBv9fdIMu9hN4X7P+aAuW2/F6hJ0JVxufvsplF0ozsm45tEIALdKmF0Aaj9WoQCzTnFFrSxX9ZPGRyH5+Ym838aYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=W7OTadz/; arc=fail smtp.client-ip=40.107.20.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDL+N+7Q0WPCATaTHmYHQOIXedL4V5vlAjUgvZ4voxXUiPR8EwP9bhooIoFTLFxDURFkPhj+rpPDO+4zqtlsMmrIjLQQsImd3yuMf6xcVFUgKTTkVrPStjc7TLiykmGfVpQG/HVrm970bIGK1/SsmX0bMK8n+VAHsYl2im+nD487Qr5mE9m3js5oOZR7dcCvQWcqIm9JmQtoE6kobxzUu11y/XO6hYZk+l1JPR7NY32nm+t1PEKFm6phCeaNnFhiWfJvG5PtAGPkU83R+3ddRbEgUZUyaPFy13hDpm/kM6ZtrH7h4Udi/EwOUZze5g+mOqk5UanHuj4f3hi1Xi4pyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyF7iTLz64XOA4J2OBaNogx5ppHO6pakjQq/PoIvIyg=;
 b=eFztu43zfMPMRXeO8AW4VyAPnNdJJk7D31LCZAac+/EVp4ElzG4mNbfdIKVlRLfbEbkNP0yVp7VSpgA1dcV9OfIoFLnwsCbN6nZT07U6+DMwnRcrbIKpYE9qcAhsfCGlLjbkJrh2Qupjiw8l9/KT23uKU9ci+TH+t1cVyIu5V3tecvVIiGATSv56wWJwwlpKYKua1PegKMwPZPMIJy1mqVc72k9gHE35Gyq1+1I8HWTKdxro8oZ9UZG6a9KEx2v5SKtDwNYTNomupI4/CI4FB3YLlY4tO2+1nZofxTQ5qQofvdgkDCMaiv4K1XDhDLlbgj3OJsNsD51jm7yra+UiUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyF7iTLz64XOA4J2OBaNogx5ppHO6pakjQq/PoIvIyg=;
 b=W7OTadz/kXl1p6xDd/oN2VV0IfaFeug9iBw9d61tMSHnjOtfLpSUhrYIjXVENwFnk3kyDo4UOq+E55i3gxS4rdMCXTmqRVvUWToAsBvP4r13AO1xVkXds6ywRTU59et9lHnV+SVqWkNmKqnFrmDS9jYn3QTwJZ+2eCxyRryPVwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6877.eurprd04.prod.outlook.com (2603:10a6:803:131::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 00:46:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 00:46:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 30 Jan 2024 19:45:29 -0500
Subject: [PATCH 4/6] PCI: Add PME_TURN_OFF message macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-pme_msg-v1-4-d52b0add5c7c@nxp.com>
References: <20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com>
In-Reply-To: <20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com>
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
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706661950; l=581;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=D3OVyPoQgbl9xXSYR/1BiTXAJm+k9I1uFEMvcHMr1z8=;
 b=XsXEWdpcfnWza3UEvb1fkG/rDSmcctRltnVtUv3z6PVCeT2HxW2MXIcag6pe+EntwDp+AcySh
 B2dNTHOnL4jClEFUYY5KN6dhQ/sEMN1ks0en+DDPU/LajdW9UhqdWZG
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd87ac4-6eee-4351-3f6a-08dc21f603c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+wp5sDTPzJkk526FiddlXYFFizL/l057QhtFzkhwBZ3dAGxz6RkTQ2sYuLLdjTYkqbL6/oDnJ42fKVNVYuGhaEMYZmaaPf+tABEz4eny+/mW7UzWm1XhdTsk2KKSXcWBpX8l73MJK461lWmrolpYsdVO6UvOlkqV6DkBmxHzCG4TcLHCAnbYD/dV9cnCr4hvHIA1dr3ofYtpB83Ww6+kl/TuuTUC7SiOBwKK52thDLwzQuAsd04Jbx7z6lwABU9Y9TlPVsHbL0geQytgWbnKxYwozOsVE7mXg22BHPqX8nmKmwueSiqop+MhBPuOI1yM3rQteod2Sy/ITue8ERbFtAgN8IGCQnrON6bD+sbORfow4CWYADjj67T8iIFHnVUvuLt0SthFM31M3w1FGeDu5L9eSbYrkQ8fEGwiwLcpoR+pUqDbnXiBY3OGLULbi9PyrloT24331lKk7FSKLCebgUDgkDghOMLPlHWcaw+vj9P6MNiFGVNNlej2fYDLSFaVxammpedKmMxf0fKG6at/VLdAz9Asr7a33kCrpmx/DVZZ8f2jMPeGX6+WQ/QBYTNy3tf4bHnyf0zQfj8jjooVMRkNeMedfUpr3zKw5RJOQaGFuS4Wf89IwAaEDwXY8llXIRQAh7dwc6NC1sq4DQOaAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(921011)(26005)(36756003)(316002)(66476007)(38350700005)(6512007)(52116002)(478600001)(83380400001)(2616005)(6666004)(6486002)(6506007)(38100700002)(86362001)(5660300002)(7416002)(2906002)(66556008)(66946007)(4744005)(15650500001)(8676002)(8936002)(4326008)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1huNWhCc2xmaDI3QXVuNmFRbENGNFpKeit2UldGY0kxSC9lVEVVaVduRkZj?=
 =?utf-8?B?MjZmK21pUXF1TS9xdExzNi9lQjhwdGlzL295aklEdWl1blRrekR6dnFYVDV6?=
 =?utf-8?B?TXVCdVc4azNxR2pWKzRCdU1mN0pLQ3h2em9SVjVDaExqMkdYeGxhcmx4QkhF?=
 =?utf-8?B?bmpZZklZdWo2UkxwcGFKeDM2SEZ3amdvQU91cllpVDNraWtHbmU2bFVJSEhU?=
 =?utf-8?B?dUhkY280SzFBclkxYWU2UlNpQ1pBQjJrK0VXRkh2TVByQm9nYTJMQU8rTVBm?=
 =?utf-8?B?L0xoTFVKbzU2cmFDbWwySlM4WmRnVDZJUFdMUjd0RlIyaWMyOHFOV3Rsbit1?=
 =?utf-8?B?Tjd1NWNBd3dPVGxpVWtwUHdnby9teEt5U3FCOWVsdDd3VkhGdFQ0bjk5Mnpx?=
 =?utf-8?B?OU9jUDJnRGZKNWdMQ1RDcHMrMlh3TlRHT0lKOUR5MXZ3ZEJxcWh4UWMvN2l4?=
 =?utf-8?B?MERKNkQ0UGVlM0llTFFjRmk3Qk84ZitFcVZ0enZWZUNPZ05NRnVPZE14b3A3?=
 =?utf-8?B?OTM5UElKVldMOHduUnM3SGdNZEs4b0hrL0JqaFpMZnNNcU5Ec1lJbXF1Mmpq?=
 =?utf-8?B?dVN2aGxiMm5PRkdCVHp3NzRzNW1pVlB4MXI5NTN4UWt4eUw2MGhsbE9FaEk5?=
 =?utf-8?B?eU1QZ1A3aVFQU1poZkZUSnd4UG1SQ0ZEcEV1Q2RReVF6c0NWMmE4WDVrNlJE?=
 =?utf-8?B?WnZMb1Q2YnBtVVduT2ZYUlVXNGF1eFRqRGZ3TFlseHA2clc5YWVHWURMNVJo?=
 =?utf-8?B?Q2pEVnhYbHBjb1V3dng0R2Y0Yk01Z2psYTE3N3B3V3cyNlBDS0tqVXdERUIr?=
 =?utf-8?B?MmhZR3FSd1FQYlVvenNCc3UrUy81UEdHTzlFMUY3NE1yMEFoeUhtcitzTVNN?=
 =?utf-8?B?SE81dVBZVHRNMHBrNUhHUmRaSFBkeUlEa0YxQzVDVzdUQm5Id29INit6cG12?=
 =?utf-8?B?VUVENU9LeUUrcEpDN3RkOWU5OHhMb3VPNTVqS3htSlpCN1hCV0RCRDZWWDlj?=
 =?utf-8?B?UUI1WCtyNHhjeGZvNzh3cHFDbzRJUWUrT0tkZ0Y3T2s4OHZwL1NXMWVhdklt?=
 =?utf-8?B?YUp4SmZ6djBXR0tvdEhpdW5nZG9qRjlXcVdnUUZYbVFmVWZlUFIzRXpxNExq?=
 =?utf-8?B?Z1lFUUVNTTdGMjNBNUR2Wk4wbVRmZFRweW1uNEhZSVlKK1cva09yOWtYUHhD?=
 =?utf-8?B?K2JzcHcrRVpvN0RtUzFKTmp2WnphOUZpRWlDRVRNUUE5WDJYOXZWaDgyWHNn?=
 =?utf-8?B?VEIwbm1jWVY3OGp3RXNnWDlUU1k2V1l3UFpNNU9ac2hGaW8rVklrT0RBTjFU?=
 =?utf-8?B?K0JWb3JJUVlxZ09oMExWZDVGb2VYSW9EVzExVU1nRW5CRldUU2o0ckIrSVJN?=
 =?utf-8?B?SFNEaS9wdGhLMDFmamJzMFZ2amtRSWdkL0lsaUdQUUlBN0E3emVxUG5CaHZH?=
 =?utf-8?B?MWpQa082aUc5WklmR1pSYXpRS0FCSTJHbGNocU5JTkE3TlQ3R3RxVy9zcjZT?=
 =?utf-8?B?djduRTBZblNoTm5mM1RIWlZ6cDgxUVNhS0VxNlVoSW9XbVpDdjRZM1dQM0I4?=
 =?utf-8?B?aTQvTnlQeXBMMlRZK0FUN0ZRNmU5Q1pycGFTMXRwMmRmbnRGNmNZSjJEVXpO?=
 =?utf-8?B?eWZkcEkyRzdXNUl3cUdtWnZ4Wk1BODBuOFl4TDl1ZXcrd2VqSHRmbzVLY1hB?=
 =?utf-8?B?bnBBeUtsV1BVZHQ1aHppWnRCbnQrWTk0Y3pNN1ZORlRTRU04VDRKU1ZEdnVH?=
 =?utf-8?B?Q2QyeEhJakpiMTlWNFVGcVYrN1FBcktHcHJPbTBJbk1VeUc1bGc0NnVGa1U2?=
 =?utf-8?B?ODdjYWt2eDlGa29LUXYyWnFmbk93aTRqeDFGZTlYR0oyYTJNZmNQL21tcU1O?=
 =?utf-8?B?bE95WFUyR0l4SE05K2k2MHFWQnZSM2JIRmhDMlI4RjZVR1lVK2YxcW5DNGdH?=
 =?utf-8?B?WGFsbXNOTXZuWVNvdlNob2lISzM3czNYUnBDajQ0UDJ5TmxEZXQrUTJMdjVJ?=
 =?utf-8?B?bXRzOHNFM3AyNEk5WWpzMzhPd3lKblNpdUtyRUVia2FlOHZ6YnFPcngzTCs0?=
 =?utf-8?B?Q3Rsb2QrWThSTi95L0lKcXgxSWo1ak1wNFdQNlJyU2dyUWZMTGFHayt3c1hw?=
 =?utf-8?Q?lcb6GIZRT7nUntgaTjJYOhtFY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd87ac4-6eee-4351-3f6a-08dc21f603c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 00:46:08.9941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVTelFsuFgiqLplFcRYnyJ+h1EOcDdsHlF1Vn39CvygpuS6TxkTFT28qrbvbetfPMaSGcL3iHLavgcB2J40dyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6877

Add PME_TURN_OFF macros to enable a PCIe host driver to send PME messages.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fe42f5d10b010..46bbd815efccf 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -40,6 +40,8 @@
 #define PCI_MSG_CODE_DEASSERT_INTC	0x26
 #define PCI_MSG_CODE_DEASSERT_INTD	0x27
 
+#define PCI_MSG_CODE_PME_TURN_OFF	0x19
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 

-- 
2.34.1


