Return-Path: <linux-pci+bounces-2943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8A3845CD5
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 17:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115BB1F26784
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 16:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAE3163A9E;
	Thu,  1 Feb 2024 16:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ks2o1jbz"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA00A163A8D;
	Thu,  1 Feb 2024 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706804043; cv=fail; b=hgMwm2oj2lTtr0/K7+iGN687sqk4bKrdkJLqkcA9H8uD4TLHGj8ZWNmHY639LTCnRrczOQXWKreKj3N/bGTGD0lR5rjKqlrOBE0muDvpcRAxGo+kcM3LKv2vK+WuCslypwqqGT/lC4+Gb7upPY5Ep2fSPqMX2LiyE/xyF41JvfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706804043; c=relaxed/simple;
	bh=D3OVyPoQgbl9xXSYR/1BiTXAJm+k9I1uFEMvcHMr1z8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bEplMuvIuZZ1G8614BPCzS1sf7HFsPE2pIvgzMSkCEVTeTR5D0ZE4DXkYZ3Wsg/Zq4CJ4r69L3unjxSdQAO1D1s3pPGK2KBhvJKaw/G7gbxiRWyl8uFcNSnjytJIzHRiMwH2cdjj57nO6py08/dNtB2xYACx5s1Xf/7LUUQ+A6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ks2o1jbz; arc=fail smtp.client-ip=40.107.104.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+8HhHzFsMXwnNPcQLF94YRsh1ZhAHuYDU0/W8qmSruDzht1mASF5Oe4NfMIbvWMCU5dDUtWFy+hnHR7L7C30Q+9dhUDUwU3tfed4dAKPpA2F2wAEleKALiW3XoyIRfWn5JO+ClnPTPwlArQ7lI2Ljd1qO9j8FvCwPaqKqaUxWMSomJPoVmcB4cRLIitsCrNE52uMiYoDAudmkH0xE+EryxdnOT8zN+7rfo6PdRSUx1SvOA79Wm8u7U8VlmYVyl5u9ld2oNPYnbQECu7+AEAxddBerAfRxY+x3mmjVXxC46iyiOhZmV3grf2Df2yP7ul7O5JgiJOLVBE8ndWW0hcDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyF7iTLz64XOA4J2OBaNogx5ppHO6pakjQq/PoIvIyg=;
 b=drChc51E6aZfArqiPNhYE/igfmLZs0NHm3j2EFwlIMzGr3E9j6oPVR6K8/sOc0OY9uiAKYIzxPvAQ4ZwELRNYl9TNV/a6JqBl0TXNkiMQ/PNQJOK5J+t/QRquw1Hoi5eiKyp2kb1jLhJs5b2xjRtwOtgV3QAzOU29eG/IA+T3Ipcp5d2Zkb6uGkNvNas0eHjBMcDDQKmJNKlqzkJO1o9d7EbatHvVnlLFEft7+dtJeMjpy8jzaI+zuRBEXmZo6gRw5T54zPf0BNtHI2Z0YzH0/m2d+mS8pYYHjj7k0cmugZdrn9USUbD8YcrF2ImaB59QU8W6Eg0A7htMDmP8EL/UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyF7iTLz64XOA4J2OBaNogx5ppHO6pakjQq/PoIvIyg=;
 b=Ks2o1jbzJynA4dsfFZ0d/kvwLTbHNZMJS+4/8ZhcgkH0Iu1eP5ruDxjtwsGMJVzQhPsD1I1WhjEoCiiNvlKBuCYkxKYEqb266cijNGL9wtES0bcmmUs1jPUd60aoWniLiRRjGtBlr0WMAipz1is5Z0JN4tFFnHM4oWKEeXyznUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9110.eurprd04.prod.outlook.com (2603:10a6:20b:449::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 16:13:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 16:13:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 01 Feb 2024 11:13:28 -0500
Subject: [PATCH v2 4/6] PCI: Add PME_TURN_OFF message macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-pme_msg-v2-4-6767052fe6a4@nxp.com>
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
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706804020; l=581;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=D3OVyPoQgbl9xXSYR/1BiTXAJm+k9I1uFEMvcHMr1z8=;
 b=Z/MykaJG4lN7Eiy498ABqEaB5K84jhUBMRuzNHiZIQonpO8C+NfdT7mGWSyLdCdXZ/K0/12S8
 wHVy0K+btKfCFkUfiSO2NUHSAPSbJ0ZcfPhorZYcRN7PR6NVVJuUPNt
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
X-MS-Office365-Filtering-Correlation-Id: d1ef6813-9f81-4e3a-f93a-08dc2340cc47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fpBvu/vARqFGfFJgptP20iruQ3x9w4wvHVrMf5wD3YOnZBYquY4nR/pPvonM3WJBUX99B/8xcmcUDoEBjfECmduu70vDlSJsK0Yp8FxDj8JHnlhQS/KEQYMAI9rEQ6paUx2MSR7xisGcTl+fJyVMoz1ImkrdF4wg4nobaYm6fdHpwQiRsVCwKH1H42bpFBHvbibI2d0wusel4gyamNh4xRluX1SWWbmaswH1n0inGWP/gWvYtGcpiZCGkamK35P+ebgP5vJgKXjGIzImlQwAOihSCXcTCBwvtMvNc/7slxnQaD1WIc3A3rlgdUhTb4YxgRcFpqms/ssewbPgP8EB3aYMilEty788rQqR/xbzR1EmI4UlU548yviLOB/smiadunu8p+c7cPRmXF6GDeUN0+2WGwk+SMxrrKQ1/OwWI2QA04wyIDTN8G0tOTQ/1VvpamsbZxq4Nn+J0THKG2ivlI1x/OwpCbbFmUwf3CYtl/BNJItLCZgFXQ1TNRCvinHTQef7RObM44lR+ApfUbCTpEt0t5d3r8NJnenCcwslfQ/v9ZVvJQIOnaUGLRyOvRfEQIvT5DJaJrEqlH6QU4E09egZkQHlZ3Bg7ESauXtJ9H5LRtYM7ibte/+HKcuovEo2PbodMPj9Z33YY2Gfpw8wew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(15650500001)(2906002)(4744005)(7416002)(5660300002)(41300700001)(6486002)(36756003)(86362001)(38100700002)(478600001)(38350700005)(52116002)(83380400001)(6512007)(2616005)(6506007)(26005)(6666004)(8676002)(8936002)(4326008)(921011)(316002)(66556008)(66476007)(110136005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHVvNlpjaXZrVG1WL1BhN00xQzloYTZ0aGh6TkZWZHU2RzJQSUljalAxclBC?=
 =?utf-8?B?S1hjV3NIYW1TNHMrZ1lZZGcwcmR1SGx3RksvYUpVdDc4UEZPODIzSkJENnRp?=
 =?utf-8?B?MlFEdDZmYjZxdWgyY1UrSWhpU1EwTURESWNEOUNZeHhPMzFNVGI0aXpRTWRs?=
 =?utf-8?B?OVNyTDlkeFMxQ1pBOU8ycHNXT0FKdmwyZXdIVjVjRE9oNUFWNFQ2Y1VmbUxq?=
 =?utf-8?B?dlBiMlRPeHhSQlBnNTcwNHNFTHBoaHhEMUV3Qy9wajFSNUwrM2dxa0JjZlRF?=
 =?utf-8?B?OUoyQmRpcXJwaEtvRW1COWVhSWhtUzNoMEd3VnY3MVFJMlhpcFJOWTJIR2xL?=
 =?utf-8?B?OFBFYmRkcGNiQ2RMYXYyckJKQ2NnWTlpQ1NzWk5VM3hPNGtwUmErbXUxdlJD?=
 =?utf-8?B?OHpIeWplVGFwR1NvZnFxZDA2TUZ6RmF5cTJQWUR5REYxbnZZQ1gvdkZUK2Rh?=
 =?utf-8?B?Smcvam1oNGhNZGh0WGxKUURVM2dFZ1V0YmN1MlEwdU1FVzVhYWkzWmJOUFpT?=
 =?utf-8?B?N0lJMi9QUy9UWHNhWW81cE1BaUFadmF3M2cyZjNYaVM3b1psL2xxYTBkZmRG?=
 =?utf-8?B?NDQyaFBjVmJDUjlBV0hxMEV5ckxnMjYwSVZCSjNsZHh3WUtVOWVYVEQ2UmNS?=
 =?utf-8?B?eVI0RTJtTEtjazZueXlVOUhnL1A0VXJYVGQ4SUdrdCtaa3BaZ3lOSGU0TkMz?=
 =?utf-8?B?MlF3MXNjdUUxRFB3QWNBVytwTUdvTGhrNXFoL1B4amZ6OGY2UUJnWEdDem8z?=
 =?utf-8?B?dEE1VlFEYlVZSGpuYnQvaTN2WWFLWDg5MWVEN0UrVmU5M2l4ditONlFZemdv?=
 =?utf-8?B?WFlJZ0FMS2NEL2xscnN4dXhIamVzWWJONncxQXZma0hCRG43aHpKR3ZGWjd1?=
 =?utf-8?B?S0g1VXl0cG1hYmRRV3U1d2ZCMWpkUjdvMjlkek85NjJ4Z1p0N3ZENmJndHJC?=
 =?utf-8?B?OFQwRTA5MUg0SExwTHV5UFg1K3REZ2hKVHRXUEhGWHVmRFFySlN6d3hVT20r?=
 =?utf-8?B?MXR2dWVIKzRKNFhlR3JpclErY0hEN3RxeHhveHYwSk83b1hzcnFsUUtOUSta?=
 =?utf-8?B?SDBRdWt6eWFrdFJ1ZzdRT0VWaU12RkNGK3RKdFhWMmZ0dzVheTJaWUJzZHho?=
 =?utf-8?B?YUFUQWdFZnYwRWsxVjUvTWVjQTNCTTllRVdHWjVhY0FQR1ZqZXNEaGNrb3pn?=
 =?utf-8?B?VnRHMnlyUEsrL1JyYWFHS1RQVThPYUhhNENHN0FTbTg4TXBSajhycFlOck15?=
 =?utf-8?B?dlZZRUdhbm9NeXYxSzlaL3FlUGVqMGw0RTlIWEFvelpSSjdlYnR3cjlweWFp?=
 =?utf-8?B?TUp2bmpBZGpSZzRXMGs0bk1YQ1pTWk1JcWNlL3Jmb1Nlb1VVSGgzcTNIa3hw?=
 =?utf-8?B?a0gxRGhzejU5elVTaEY5VXNTM2tZbEFZK1hpTndMQmd3eDB4Wm9Fck94L09r?=
 =?utf-8?B?QTM0QnVySk9OcE5YeVpTZFFaamZyL1ZldWJzYkZ4YkphSldsTkFkSDVBTjlP?=
 =?utf-8?B?Um8xRUFuL29oblY1M2kzOVRHb3o5Y0JGaFNiNURCSjZvNXFpZS9BSzIvdlo0?=
 =?utf-8?B?ZWlzelZVWHgzNHVYWjRwNktqRjRqaXZ1YlpWU3drNVlMMzgzeTdwQ0dpeFpa?=
 =?utf-8?B?dGl4QlBUNW94K1JTTHg4Y0MrVmFTQUNiQ0V6eGErV3o5VWRVZU41TEFpZVVV?=
 =?utf-8?B?RHlTMTBuQnpSNW9GWDA2KzJrRGh6bi9kL0FoYzcveEFHbDEvTHg1UUlzZXZU?=
 =?utf-8?B?clRJQktWcFMxSkpIak9wSUwySFd3TW5mdWs2OFlXdno5cXl3djRqd2U0dU85?=
 =?utf-8?B?QnF2Z2tOdlczSlNmYkduOXFlN3BuQitKVGJoWVVIejM0azhBZ1RKa0hoSlhS?=
 =?utf-8?B?cDdFT2RQNmJKZEFMaFZ2dnBaTWZjYis3bEhuY3dWa0VCdGxnK1pJUXUxYllP?=
 =?utf-8?B?b216OEpTZEZON1JwRnd2bmlGTGpCQ3FBWmlKRkN2UWxEMy9EclZjWlVvSUp5?=
 =?utf-8?B?UkorL1VONHV4VTlaWjZIMDJ0V0QvN3RoUVdrZmNpTXNaYmpZUW1rekdsZkRw?=
 =?utf-8?B?YkRBSndEYkpnVVQ1OGdScUtNSGgrWnE1MjF0TlB4UkNGZkt3NEJYdkJPYjds?=
 =?utf-8?Q?8dOc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ef6813-9f81-4e3a-f93a-08dc2340cc47
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 16:13:59.3100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xPwITF6/7Y4hcOeYCspHaZ7VX+MsRfsHdDv/LrE8LNBe6Anc0yYTugFZDCn0taqpAsDoPuP5cseMu8PcBBgxfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9110

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


