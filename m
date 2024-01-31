Return-Path: <linux-pci+bounces-2850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748CC843238
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 01:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC3901F213D4
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 00:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90873746B;
	Wed, 31 Jan 2024 00:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TGW79rl7"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959584C8B;
	Wed, 31 Jan 2024 00:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661975; cv=fail; b=IUC1tnJXpjTO3WTSSsd2Ux6x4B8k+gKGS/OWL49LLQQPBHFQ8Qh4+6/jhozmxbXRsC1r0OS2x66gSs451mWYM+ccqHYsrvcDxxDFJhB1eG3cmKuVm8mNAXvotOLA9O+8m5riGv5hgPsSAYJ41aCu7LB2nVYhfP008qnSuy6ly3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661975; c=relaxed/simple;
	bh=cfu6DwDb0l7oT09xNpxjpxzHoXAlkfWEhm2pP3eS+Z0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pkBh7QqI2Pq2hVYpYp0+E9pcV2adZx3wWQdwAZJdXEiAY+5ha9h2AorwUXPnoIcF8uSmI58y3scuiuDTyZ1Dr+SkgWwPOjlviM5ayAhQGPJAA5Whc3UNU4xKdoNQcVwFePv+KxgVL0zWESeTDrpNu0GZjUHcmhS33QGBXPxgx0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TGW79rl7; arc=fail smtp.client-ip=40.107.20.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lfmq5ct05OgIBVlsXUJpPtptPTq78Nvf8UpDv9rsX3IjxybPp/pJjBdWAvB0/yYZ3sUFnoYHCNtMIjCgJXjcWFX1tHreyDNQ6wXplT7Uu+FpIarrVVDUEDjmxk/BGXvcHcZ+O6VCXvovEweOilOo+tpd4g+P+2zgz2gm55gODdG2v3PgSPrSINw1WS1iio1q7jZUdGkn2H3mCie8cj35facrwqZ0OfXhuMzxrrgcV09Zo9uh45sqs+XsiiSA5AOz9yE5eTeX6Oqb69hFggYsrCFYSNmu89DyySCeajZ/QiTd+U1+wlfWy7ISHHkIE+ILosXGFuWXwksK7UZjOV3+2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKNQWNbqoT8m5ZP1u/XMj+BzC8WwW+892iG/+v4LN6c=;
 b=YefxaRL9aFWCbO8zlb2KrgiTfxu6kb65tdIK1KBeEVuS3QGMi5kJX2q0t6GkW8MQaGTJe2GWeS+kBQtsml4dnl1KEedG8/pJdOXhaDLFC0w5HhYJau86NDkhmo1/rtM8duZpKGAa6CN8ak4la31wJaf4HOiq4jOa8h0VurhSHkkf2TVB4AI4GsVesx3M7vZdGTf+gAKClrtcTz6vU21QoF++WOvL9026xBAWg7RGocDwuBNAasq5LV6LR7askJ3dV7p7yjnCfXI06NAoJWu0pINcSbUHNjFWADWpSKY3Q+XH+8wedzKrM/QC7jhpjnIGDVGVRGI9+8POXa95OPm4eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RKNQWNbqoT8m5ZP1u/XMj+BzC8WwW+892iG/+v4LN6c=;
 b=TGW79rl7xIUW7G4pxk8lBN8f/0Xxr3caZwNBPlptEzWDJI0055+XXzl3CgN04kevPLgQjYPi/5spy7Jm7N2Iry05UirdrQOFrILd1FgDdenKQ+3/KYOn2H2itEyC+mupF15aTlb3rxLapNpBeoPPR6+D5EeZG26DJ53qnaqm5y8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6877.eurprd04.prod.outlook.com (2603:10a6:803:131::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 00:46:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 00:46:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 30 Jan 2024 19:45:30 -0500
Subject: [PATCH 5/6] dt-bindings: PCI: dwc: Add 'msg" register region
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-pme_msg-v1-5-d52b0add5c7c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706661950; l=1214;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=cfu6DwDb0l7oT09xNpxjpxzHoXAlkfWEhm2pP3eS+Z0=;
 b=eSiFbo1e8v1w0/khlc/jIGteYlx1FXSj+QNnu5Dg6nmkEz8JBuXjM6Q1MfwqsGJOuVE+2BjeS
 7J03CQ/nRwsCsrg92n14XENpAoKNuTg/P0u+wzCzWckX2pGv3Qq/Vdd
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
X-MS-Office365-Filtering-Correlation-Id: 1f9a4b83-914d-40cd-852c-08dc21f605d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zz0Wk0GLFJ+JFP+bAVAxz8oB4OUMGQGNXymInE+Lq7oCiSl9Tm9Ms9Uo9C+fi1ENE4wshnZa0YXrlmqwZGR798buNpwd+m/EJFhz9a3pXWp+YYu2ZqMQ9A5AIlGbln479fQZxuI6VxtaENR79pemC0rDRv7QcEyY9AzxNf1RXy0fjW9P84wRSmRsbzFclysA6SjCzk0wESTD8P74zLdZiSuM1y+yBiljpWPFqRD+v9PBYajuuHN55DHp0fVxJTex4vzmtK4iZOYR8sf3g85SBKvP7VL+WXn7v+zWbDMFT5PEubJh02y0K1N26IDl3LGP+BmOvd1oC6BYqXjWe3t51nl7D2NNWpwTASRR9C1Pf6JIIb96e0WH/OW9e7VsPvcvCjrQchxPyE2LlmqvgljP/xZxovyhgbnun7VLQ3RYunZ9Rs5yRJocOwKd27JzCmO7Cg0gxHvG2uUCHcDksXx65SJUxBCiuFnsqKoskzIG5uVs6pPi1jndukOBBlH0HyKUlxyeZ6gdnz4VWUrPLHXlfdwXHJfOZfT9MrU1X4SIUKvRBcozNpvKVr0E3RMyNJ3ZVGMUR5c+mkthbNSn+/Y+8rYKyGCX7xsyoN201rGAD0m3TF4hZj9vJSstoO8PGOz/tanMaJg1cPwhV+k3sPUY6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(921011)(26005)(36756003)(316002)(66476007)(38350700005)(6512007)(52116002)(478600001)(83380400001)(2616005)(6666004)(6486002)(6506007)(38100700002)(86362001)(5660300002)(7416002)(2906002)(66556008)(66946007)(8676002)(8936002)(4326008)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0dmcC95dzY5NUsvKzFXSnBrRVFoVnlhazJTL2k4amdlK29nMVFFb2JQam53?=
 =?utf-8?B?SktQa094TW85V1I2VTNUdWNRYlF4VUYwYUxwVUloeFl1Y2FSNExRQmd5eCtz?=
 =?utf-8?B?cXdvdWlBYzlMbVNnWXp5MFNZOEt2OGYzNi9kZEo1SUpiS1p2R1Bmb0VPdU80?=
 =?utf-8?B?ZDNvM0QxNkZlM2haY0FONTdYcmNiQkxvTCtia3UwTWhMWnZUVjh3WlVvRFM2?=
 =?utf-8?B?YXNsOXBKaDYxenFoYXNqMlUzMjBVTG05V0l6QzNoYTZDcUJwNDYyTmlxNThi?=
 =?utf-8?B?UWZldjdwNTJFdmlFSUxKTm44aUJPWndDWEZyY1ZlTDQ5RkhWdld5eCtoQzZE?=
 =?utf-8?B?cDZCaW8wb2NjT0dMYzNmb2w0UmEwRGFDWjZXYnRPRnFJL3lhZTlGWjJBbzNG?=
 =?utf-8?B?SHJTeWpueWd0UDZlaXhGRmkzNXRDOGozRE5sS3VFQnZlZnRoYjVaY3FhQ2dp?=
 =?utf-8?B?S3F6Ti8vblp5bVZvMU42aE9lZkNrN1grU0Q0Z2JrTTBJSEFFV1FCK3h0bHZp?=
 =?utf-8?B?OFA5WEZGR09xUFIzTEV4d1d3S3lPVE1XVU5yY1l0TjJYdk1jTnFHNXBPakFF?=
 =?utf-8?B?RFlYMUFSTUlMb1lMcjE3dWZXZXpiaDJTR0JGOCtJUFlKVElQTDlKMmFPcjZo?=
 =?utf-8?B?YVhMdXhFbkNFV2VnNDJzajdVS29YWnF6WHpLSHA2K3dqSWsvdlRwZ3V4aHIw?=
 =?utf-8?B?b1l6TXdwMFdqNGFFbVdsZmJ2VVpHQ2lZQnRyWGM1YU1wY0FPZldDQzNxZ1NX?=
 =?utf-8?B?S01lTzRReXlmNGN6akFEcXFNSjJIWGFCYVF6OGlpZ0hMeGsva0E2dDhkV2lr?=
 =?utf-8?B?UzQ0ejAvdzJzK0hyRGgzU3lxZnFNT0I4N3A0WHIyZG14Z2JaL2FSWldvQS9Z?=
 =?utf-8?B?Y3l1TWgyYUZ6cUxCMlM1RkZNTUtXSFNjQnZVR0wvU3pWRVN6YjdwdUtjMy9F?=
 =?utf-8?B?ZlRPTmxZa3Ntc2lYN0xJWXcrQ1JFRkUwd2J2YWxrZkQxWTRmcENldHlkeXF0?=
 =?utf-8?B?V1A4TUg1UVlGek13QXIvMUZSNmE4QThnZTA4S1FyOGEvY3lHY2ovaS81S0dC?=
 =?utf-8?B?b2J3V3hvZVZyQ1lqTVF3TWQ3YTAzcmdWWkI1OWJVVEd2YnJWOFk1MkJ1enM3?=
 =?utf-8?B?c0VUNFNoOG5nVzNnWTNUOXVPYUxDRzN1aW1GTGs1YzdXSkVjRDZLemtTMmxD?=
 =?utf-8?B?OHZzam9rK3JIa1JiVE4yWnFkTDVNNmtDS25YcUZRUGFMTGQ3NFRBNWtDSzho?=
 =?utf-8?B?YnVYbmJTZmtQZWJGUVFBVklxTEwzaHVMYm01RHFWaldrWW4rSDlWV3hoRVNa?=
 =?utf-8?B?ejZyTk5VRDJiS1JET0h2K1dhbm4xUk1tQVFPN1k3OCtTT2F6bWxzNk9ta1JF?=
 =?utf-8?B?UktNSjlrdWR2MTdycHlua1d5cDV2ZndtK3JQenFTdzFJNG1kR0lNUUZzQzlQ?=
 =?utf-8?B?ZzcvOElUbEJYSXBoQ3JYNmlMYXdrZXVCdHpLdFJHajM2N2dkaXA3MjlCTHpZ?=
 =?utf-8?B?TEhHMVBBRHNyT3pQK1NDT3MrYjk3QTVTSkZQTlBMTnR3NkxKc3ZxMG9kdGFi?=
 =?utf-8?B?NEhOV21pWENaOVNpTFJiMHRYRTZvcFlGcnk5Z3ZEN3J5eXJudHljRkZLbmVE?=
 =?utf-8?B?eEpSZlIwN09JWDdUdlowNlRzeUNaSFJLUWVrekVBd3pLWTdBM3FwblRxN1pv?=
 =?utf-8?B?NGF2RUNHdGVMS25oRGFjSnUwYlU0ZS9DMmltWWpHTDlLT2MvVGhHWDNnMmI3?=
 =?utf-8?B?VFpqTHBYdExUcFRZZkZSTGxGUE1QdW5reTUyaUp4S3lYWkVsTnJqOE9HUnZt?=
 =?utf-8?B?VTBWTEtlOTFHbFZaMzB1UHFjOE13QlZmZXBacU4rTCtJcXluZGtTTlZIUERE?=
 =?utf-8?B?VXFUSFRxVFkwdUNxSWs5cTZUNUo4WWRHZGlTZjU2VFZPeEdLTjRqNTYrN0w5?=
 =?utf-8?B?bjU3WlVOK1JxSmR1MkNyb3dzUWNZYmJkaStlamdoYnFpQ0lTRjVQTlEwbG10?=
 =?utf-8?B?TUpzUHNYc0ZHbmFRYWZWdDB4VDMrL0xpaitVYzIxN05Sdm5qVkFydG00OVh1?=
 =?utf-8?B?UkQ2dW45MDJheU9hYWp2Q254WkFMVS9VVE1VZS9YZ1JEeEJ5TW1GVkMwaWpn?=
 =?utf-8?Q?V8iyC7MRTGvpbNYYgsPCsmc0O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9a4b83-914d-40cd-852c-08dc21f605d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 00:46:12.5033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEfnUyMOCUKn1XWdgsLRM4m2DF3tQtFoeQClWF6787w6Ez/uArHcM69/11nl58G6smbVvDxM5uvlWSf64Ohhzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6877

Add a outbound iATU-capable memory-region which will be use to send PCI
message (such as pme-turn-off) to peripheral. So all platforms can use
common method to send out pme-turn-off message by using one outbound iATU.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index 022055edbf9e6..e27d81b6a131c 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -101,6 +101,10 @@ properties:
             Outbound iATU-capable memory-region which will be used to access
             the peripheral PCIe devices configuration space.
           const: config
+        - description:
+            Outbound iATU-capable memory-region which will be use to send
+            PCI message (such as pme-turn-off) to peripheral.
+          const: msg
         - description:
             Vendor-specific CSR names. Consider using the generic names above
             for new bindings.

-- 
2.34.1


