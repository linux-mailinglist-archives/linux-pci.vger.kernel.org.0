Return-Path: <linux-pci+bounces-6291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590608A5AAE
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 21:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4AEC1F23C45
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 19:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185C515748A;
	Mon, 15 Apr 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C2hUY+7O"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2077.outbound.protection.outlook.com [40.107.105.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C100157467;
	Mon, 15 Apr 2024 19:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209652; cv=fail; b=jmEr0+4erHzDA+y48eOUygtwAYfH38DZY/GHbIyJuh1JTrYtvIh1+uudHTs9LwJLtwEK1BFA99ZlFmEOzj5JcU3aV1W2R/e5UaX+mkKDZMtZ8wzFKz91/JEnPxuBhtRDVtPZf3pZ8QSehCdz2dszWjB9rD3FkNrpCDRbR6Oga3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209652; c=relaxed/simple;
	bh=IvTQligpMXKWtQKY3rue7KFieXPNIHaS5ARIXkddXi0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YyWWbOgy5DOPokpiMbxgx1TEouxRxaNTqV7r3fNx/yb+gA2ph2E/R69vZc501gTCsclR03Qb9Rv5Yk26wiRLW0IcV5XYiyezSXzbmF82rMVCZjJ05/Gg3Uk9E5REAr0M5jQBbTP/WMkOhD0AIRlZbMN99dVyceV0vqmstPhkkRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=C2hUY+7O; arc=fail smtp.client-ip=40.107.105.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JI5OjbEy2igHP/3t97CkkeKNxp3wnlaM/JXk0SYMUV5U0QKDG7AsJFtVo1VOUgcN415X/kVE4v5PeaNJw8+uQBffqq9frgoHKUHh05INgabR02F0Ybd8+O+umxMOI+02FHggEFCOnCO4NU1EWxcIBdlWaH0xWa9YteS/3+LfTI1WnZAxfrX4B3Hq1VLFhqSsAtv43SDXCfzJWLIKCyz84QgZUrct0vDKP4mnybJ9aBA5ySPx9si6V8aLDs//7jrK8GZeojsCkU9cM8rFf0y19G1V9iiTjo36Bmc7z0mlEE9svDFEuqBBG0bFnUJyZlb3h/gho0JjgOIGFYGImfAZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2pjL9n5tGmlUWggrS+YCiQGS6S2MWnHDrjBnZIQRoI=;
 b=Xc+FpeZv1akwy/MO7hlE244zZUwOaIi0Pahh4c3PAL1wdJvjFe6LyEFCz1ouPB9RZzSKUTsTtB0IhvxCDnSD28Qq+k9rdSdP1av+F4uEK2wWaaJyIylpuxSEurP9MHLv4bL2XgHiPwF49c2xc8yf9Sxegkb7VS75HZrnVBWxsKfbCXtqpNmEb8Su5M6OcwQl+04QadJV0MJUliINC+c3NhT1wJjcrKbsPKCIE6JuTmBBKqotR/1VZLhj/DSLFBZorjoMZydh99BfpSkSgG078OI7qPRZuaaCFWSiIzKWxA+ly3BTAV5dDizMeZlNtFKutalUwrwHp6v1NtFv1iOn/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2pjL9n5tGmlUWggrS+YCiQGS6S2MWnHDrjBnZIQRoI=;
 b=C2hUY+7Oaa22gvmzv2VW9IK91H5m9yJP9Xv/BaqGN78yaKDkUHdpnL/GoO5dW3oTNpowi/TA5bEstuhH5PyBav+SJRcjOSvOhOSpYDXaLllsQybe6l6LJ0z1o019jFoL+lo46BvquLd8S9ExiA2G1zUDfncHdvfai+LbxT+N4eA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10279.eurprd04.prod.outlook.com (2603:10a6:102:406::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 19:34:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:34:07 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Apr 2024 15:33:28 -0400
Subject: [PATCH v6 4/5] PCI: Add PCIE_MSG_CODE_PME_TURN_OFF message macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-pme_msg-v6-4-56dad968ad3a@nxp.com>
References: <20240415-pme_msg-v6-0-56dad968ad3a@nxp.com>
In-Reply-To: <20240415-pme_msg-v6-0-56dad968ad3a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713209628; l=652;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=IvTQligpMXKWtQKY3rue7KFieXPNIHaS5ARIXkddXi0=;
 b=/sJleCQxCQNzeMnByvWoiRGRTJTUBnnLxGkQB9oRBlGlKa4H0G2IgsW1UozWK/GT1RhdOsKXe
 fyHMJu90FHIDSSt5BgP9/4L/phlWoI2r721k9rVyWHsb1YCyjMyrPIq
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA2PR04MB10279:EE_
X-MS-Office365-Filtering-Correlation-Id: 61be0b71-5c18-4b12-1d3e-08dc5d83048b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BESTg7W/3bN/za8a6IAiyGIW7oE09qJzO0ULFKWWIt90m8iL7oJiLZWYyvtuVgk1r3J9HAj3nFSlLf/g98IEuJlrT8rvXCyPqqmk183y1m14Q1mOmw7Z6zQ0XC/ZjyJMq4l9XqcFCHCUYth8iJGv2YcPxY847W395a5brvCTuWFQrsC0q9DbTThtc+drMYwLjliCbhdhNyDMhYrTQoQTI2lrx4KlOXSqsQhuOm4eMrjyaGRy6AD2ZoGLfL8JSET99/Sr19L+YW4KnMfRaqTlauekCOn48OWcQ3N3TBG0V734WW9y2aWN/KcUoxz19ogs4o4C3Kbt33cHSW0dMVE3VrkLsPdWwsA7Mi6tjr8F77YY0O0w3Bddhp6ttdD1MhPEoQOisRlHbMCnT40jcPr+8L0Ei4nqC6YdbltQqisXcdJsoe2rhUf8W1Ryn9ZMupnBkdNx4b3KPbvF73BzvsJzeKYOtCzoya1h5yk4rB5cH3gS7FJmLoFMpVB43ghzCrxs2p0ABXEWCEYlKjPZDZ0o1cfK5PeTY/lyOKP1PlN1WLq2qX42D9vaLUBYZVle7YwYSxyh0VhPqCaeNNQZO3Q20zovo3IVhfexUH8oCJj830P51VqhG/ARlUSCmOPc3h3RbIWHuWOhHtAvHaXPTJXgajl+aDkHmCsgiTHXgT148dU2GAaeTB0bNVIqVT777cXEKfT54GPjM6WbXb4Ghfl/vgf+xT3KQid9Vn3vFv1o1xo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1Y2YUtNbDVjTFN3VnBlVkJkZldYZlhMalFUSXB0Q1FYcG54NXI0R3RMaE5B?=
 =?utf-8?B?YStKYU9DcXJiRHo3aGM1QlpMclZhT0JZWCsrL0x0VEFiUWtnYTZNeS92NGxs?=
 =?utf-8?B?aGZjbDFBRThMcmE0SXhQNzUrNXRSb1p3RW85amV4ZTVhTER0RFVBQ2ZOYlRx?=
 =?utf-8?B?V0t3aCt1L2xjRzl3VXg0Y00zN2R6ZDZHUGRkd0dsZ1IwbnhUczBYVnFLa2xJ?=
 =?utf-8?B?SlB0RGdwODNQV2lHSHV3cCtBQzNOWGVMMGZKMzlvUEphNDUzYWdkbEVhSjE5?=
 =?utf-8?B?TUFPbVZHSzlta25JaUxRSW8xUXRlbHdHU09yMGhnUjYvUEx5dGo1ZVJoWXpW?=
 =?utf-8?B?SGp6eW1FbVluVU5yWlZ2TFVTc2FvemZJOVhFK3FHdk5ySXJSUnJDOVNwVnpM?=
 =?utf-8?B?VDg1MENmQ01HeVR5UDA2RkxnelNSSDhsUi9KZGxaS3dxSVNEZ0ZVdkRaWnRF?=
 =?utf-8?B?NGVHZ3MrM3cza3lkNVVhMEJEbEpXYmlaSCs4NHE3REFadmE2Yk5wUDF6MG5F?=
 =?utf-8?B?ZjBlcGxZNVBSM3p6eGh1QUJ1M0hCZ0paVjV2cDJHUTR6dlhVNUFhMHZVZU9Y?=
 =?utf-8?B?Y1NTNzlKYkFYbE53R0xXaXM5ckVCRDc3RHN5V0x0TFhjeHlwQjRJR1ArZGpn?=
 =?utf-8?B?eVJ1ZU1Kc29qTWJEbjJRSDNMYXN1T0RKdkdDV0tINWZ1VS9EUGg1MDZESGlh?=
 =?utf-8?B?U2RMVUdRK3VqVmh1bnNOWGFiK3I2RllYbVV4NWQvaWdMd2N6cXVKdzZvTXJD?=
 =?utf-8?B?c2FEWWVVeVhRd2l1T3M5aGRVN0tvc0xDTTlCUUQwNTZRczk0Q2V3b09FL2lJ?=
 =?utf-8?B?NVVhWkhpTlBpVEFFait6V081YkhJK2t4MDR1ckxseDdHZHhsSjV2My94V1NX?=
 =?utf-8?B?VXF3ZnZ3MlVYaG5OWHE4L1lGNUpSS1cxa2lGdkRmOHR3UkFuQ0kyNDlQdi9l?=
 =?utf-8?B?SFUyVzlIc2NQZDE4RHA2SnhOS3lnSklYdlJpY2ZOaFh0VUhZVUdnUFBqcHlN?=
 =?utf-8?B?STY3UWVWTk5YbkFZbkxycVVGZGllMk50TS8zaU5Kd1ljUHFyOTQrSnVuTEJu?=
 =?utf-8?B?SG1xZW8wVzJsTXZMS0ZFMGY2UEtocFRva2xobmFMOSs0d05JMXMvemRNa0d2?=
 =?utf-8?B?VHJFc3ZBRnlQRE5VRUFwbXZCTjIvRzFORDY4c1Rwc3NkOFFzc2dIVWpvZ0p4?=
 =?utf-8?B?UHBheSswbXNxNGFtV1lNaVBJa0tUeG1IMDNrUk0xcnlNeVVsRGNuMWhZUGY0?=
 =?utf-8?B?Wno0dENxVUhkWUt4T3M0S2FET1RxdjZvUjcxTXNUYmlyeFY5VWNta0RVMzh4?=
 =?utf-8?B?VGU1WW1vRGk5OURkeFVQNmlVTG03ZmV6TjZ4KzZXcDZxYWJvK2t0TXpMaUtw?=
 =?utf-8?B?eXlCQmtTUkVjeWNiYVJQTC9wL09lekZZSWtiODJ4cjVRcGNxV2FUWThsUGZR?=
 =?utf-8?B?TzZBcDF5MjRCaFRnM09HTlZ5dkVJQU4xNlhWY2hlRWY3c0VNUks2OXQ1dFVP?=
 =?utf-8?B?RTFHa1IyODYxVjlMc3FmNGYwdTZlVElCdVlnNWExeUNmbmdVeTJCbWVIUjV2?=
 =?utf-8?B?dUhockI3U1RRTFhXRENCVmxnUndSMldDNVROdnN5MUwwWUMyb1NwcDBGMndp?=
 =?utf-8?B?Y1FETjBsb1MrbEpFRVJUeUJuRGdrb3N6ZWpUUERvUHNKK3E0RzJobHFMcThv?=
 =?utf-8?B?SjBGRXN2U1EyekUwVnRnSTlxZHdSVERKYm5nakxZY0xtWHhOZkQ5U2Q2cWpL?=
 =?utf-8?B?QWttVVFGUlA4UGtEWlZKKzlteEpla2xRVTdXMmxPazBUM3dySEVraTdhOWZK?=
 =?utf-8?B?djhoNlhVanlWLzZsYkV5bGxTaDI2VlB1RkNKRDc4a25wWnFvTDJmZnU3Nlla?=
 =?utf-8?B?amxRQW1Dd3EzYkNrRWpONXhvMTVJbVZrR2tzN200cXN2RkVqNnN3dXYwc09K?=
 =?utf-8?B?UDFqTzFmRTE4SDVPNGVUcTZzVExTN2UyVUJiWW12Ym0ydGQ5RVVIaGZqZmJP?=
 =?utf-8?B?ajVJRUhoWnFVd1htZVFHK1ZHb0pvTEtuVzc2TitPN1A0c3c5SUVvYzZNWFhV?=
 =?utf-8?B?T0NCd3Jpb05kU29QcGZ4QzZoNE94bis1M01iVS9RUmxsb1UyQWtzSTJzQjIv?=
 =?utf-8?Q?H6Rs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61be0b71-5c18-4b12-1d3e-08dc5d83048b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:34:07.9105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1NjJza77Xi35mJK5t8BTgqR7rZyAtXLyP4d1fOGR+3ejaCBNm3Bp1pzHduyZwOoOUeximxzUDRb+n0Yq1Jsug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10279

Add PCIE_MSG_CODE_PME_TURN_OFF macros to enable a PCIe host driver to send
PME_Turn_Off messages.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 19b4227a8a7e8..1f6d54a5a7cfc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -30,6 +30,8 @@
 #define PCIE_MSG_TYPE_R_LOCAL	4
 #define PCIE_MSG_TYPE_R_GATHER	5
 
+#define PCIE_MSG_CODE_PME_TURN_OFF	0x19
+
 /* INTx Mechanism Messages See: PCIe r6.0, sec 2.2.8.1 */
 #define PCIE_MSG_CODE_ASSERT_INTA	0x20
 #define PCIE_MSG_CODE_ASSERT_INTB	0x21

-- 
2.34.1


