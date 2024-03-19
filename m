Return-Path: <linux-pci+bounces-4906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37E1880179
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 17:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD45D2854E4
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 16:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F2C82D68;
	Tue, 19 Mar 2024 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SGEW6zyE"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2047.outbound.protection.outlook.com [40.107.15.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCD182C7E;
	Tue, 19 Mar 2024 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864461; cv=fail; b=ebdTrfHjSMONlaTB0Sgmgn65WP5vmumhAtkc8rFZRZ59x5YKGjfz5vsEyaZTk+1yfJCCf8vaZ4fGcLyy/d0Pguu0xr54MUevXJP+N/rGX9qfb2KWi0MIYQpLl7s48fu1gfK6q7xeMMK2tbRhhdaydq/XrOtkrivAncHKdgSPgKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864461; c=relaxed/simple;
	bh=ubK5KYt7VQOKIPtdMUTb6BLNf6RphFRaoUgDr6itmew=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CViyy3Q//CAWITmImj/aNDpY26Zz5J3R6MfZ+XrHW2IRMzTTIm0Zjfz+OayLMCQajV96kGX37wutRwN36zA1rMvH3o1TGipBHS6zk5OmG+GtcpzXwYGWWWdobl0hyvicxncAx8Gwy+X/IcMD50HRhtzI/NeC1HwAzDGNozMP544=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SGEW6zyE; arc=fail smtp.client-ip=40.107.15.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVClrZGvgGHlPex2ao5BI/4Lbvrhe0Aj/nmOMiShL7FQ0xl9nP0IRUs+H1i0tyOleW8hlMKkvP1I+3jH+rdimGDWl1Rk1Uk262BpSDYYCCr/ih2ipk5W58Z7kyk9+Mw5BFvE4sORDQ++GuPmcundMrphW2rYxk2+/p/S9zSs151Wx971K9Y6R37fM0W9Ew2sIKm+caWeX7gOBsd1K48Lryn7FTODjbAw+/mLaHGuxGYii2o2sygtGyEQ7gkEwd0zjtKm+CzpeWLbusJUJdkLD5+TydT+r1FKbG6m3JrHiWxINl5B4RpoBG3cOVi89ZPjfedDMpFbqKBPBCpwU4Zxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIrCamd/WiRIq3iCLG5qfP2Vfg5QxB36ARsrGQKXIu0=;
 b=M7OKPZMKrDLxUwZZV7M3rlazmL8WP6JlLAge/wobo0+7pWdjkEoyB10A92KasPUe48oN5UKUMo12jVTKyuLh6oOc+/Q3xRhtpFJ/er2/CJrdwquFgfWMLzuT+GVBpZvvrx4RtgCW4SFj5QYnO+Eq18+v7NfIUWvnFcJ0gYsYtJkzzeINAzdv/gbY5qFbX9cSazF3fqgZx679nKGJYsQ4LqEAZCNPJDDejvoZhpV0g5t+jDG5xDopEKrlAVsnL1Jo8MIAqMGGf7Lr/8ZWb8K4x1UT8tVtCiKej7WS/x3u0hSL/OudgtwYAf2jJvIRILcZO1SGpy85RU6BBlQG/oasBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIrCamd/WiRIq3iCLG5qfP2Vfg5QxB36ARsrGQKXIu0=;
 b=SGEW6zyEoi68V2gS9b47b2U/71euYvQOLxk+7yK2tHowWhsp/dxQ5jeXevsOVCkTPMo3SxkBltCu9nULJL786H/FbBkGUYvYNlHKkmNx5BveumwsTwApV24PCSRAiX4KlALNdmHFuErng/556Z8vfdP+F9s6TNyOyM78s/12M1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7772.eurprd04.prod.outlook.com (2603:10a6:10:1e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 16:07:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 16:07:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 19 Mar 2024 12:07:15 -0400
Subject: [PATCH v5 5/5] PCI: dwc: Add common send PME_Turn_Off message
 method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-pme_msg-v5-5-af9ffe57f432@nxp.com>
References: <20240319-pme_msg-v5-0-af9ffe57f432@nxp.com>
In-Reply-To: <20240319-pme_msg-v5-0-af9ffe57f432@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710864436; l=5639;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ubK5KYt7VQOKIPtdMUTb6BLNf6RphFRaoUgDr6itmew=;
 b=F0PLKbXsKLB4yZreCfTuhgLPr2jTxhiFQiNoH2xAS09OnMjAcxVQX4/Mct2VhCPQj9I/n66LS
 lomVUYRad/rCJ/eOTy9b/v2CJAdDxFWGoZyadLpEoWTKlBV4AgCdwtp
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0104.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::45) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a22b166-c021-440c-0476-08dc482eb230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZaFmkPXgiCnD7vfJNj4wcgQK3+hXdsu85G127l6xIE2cRYhLSfCRyb+t+dIg1UNRb4iTA7Qzkm84p4ZRI23b3kWv5z3Z04NTcYSqiwnqzvDtqO/n7gs8brHar9NABQo3p7tGZukxyV9mp6EoVeRsFJHE/myk7jnhxRp5UCNOLICC8F8I5w52uLGWkovDGp+99iueXGPcjtZZbVkd9qhDRD3FK77kNDXIldHWaYwa6iXhjKkYIui8oX/v0+fsEnHryMoXCD8Xu+oc7a7Yd2tcXjMoHjmdy6AytgajtjHWfnvpyfb7eSQo1xDRw8QcVg/eDA4KJNou4XVbnWGcA38U3VKqly6Ts8Jg4eeuB2xdBFdmMbXYkrlI6T4EEErZJD7Td9Q89aFgWfz2PjGEvamBSbHGmgz5js5LH7dKumo3omuiLH3DITtalxlR5rwiMk+2D4oaPZNm0a5BEZ0gaCpepRZrpyE4Qg2mNZlamu0zdTlu8sck0H8W78evqBlzXIfh2dhnllyEOSH1UUA322IL7fWDPLAC4JAstRx6WaFMLgpcjuNYfhYR4pW0RPVizxu0XI5xoG9rWGvPJyyNIEf1kTfzo0L+OVPzKMjvsCdFlJ+3Iv0yazZ64iwi6SMpHj3vTBfXM+Tcn1O6kIlpLP2wANg5/dYAbxvQKZkICjIk4ZcIpLux2hXp3HPA1WwSZGLX8TYSEW9uATdcFJGNl3pj7LnlQ0T4zjE0JVbjZzvHOWg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(366007)(1800799015)(7416005)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXNxUWkvS0xXbnNOei9aMUsrSFltTUxQcS9oZEdDNlZTNk16Uld6KzMrdlFL?=
 =?utf-8?B?MFBleVY4UUs3MmR0YTM2dlBYbVM1RzM4TjV4L3JLZ3R0RjdmQ3RGdGovL2p0?=
 =?utf-8?B?QmRVaHlPYmhYYnpBSExONnVTUUpUWkVzMlhSL0hzRHRiSW1CTXU1MERLYmlx?=
 =?utf-8?B?VERzYlhwZElmS0tCTkcrdDNMVldVZDhGemJVNmliMU9CdVIzMGNLcFU3NFpx?=
 =?utf-8?B?SWg0eGc4VjEzUWZmTEtVSkc5Q25kck1xUnRyMkFSN0laOERoODZMQ1pPSDlO?=
 =?utf-8?B?QlBNNytUTlNiTnZTc1h2eTU5emZQdERCKzJtTGxURHlEMWR1bGtvUHFNcURM?=
 =?utf-8?B?djNrMkZtUWlLYkNyNFArdHpmYy9aZ1U5cFZGOTNnQTlWUlNMdHpGWkxHZTFV?=
 =?utf-8?B?TnZjSEx2eXJzMjZCZmp0V0oxeUhlay8vdUxQZEYzbEcxVUI3OTQ4UXRHQVVw?=
 =?utf-8?B?VmlpS2g4NkpQdUQwZGV3ckRuWnA1UVdOa1FBSWNWdnJybFJWQm44RWVqcHpa?=
 =?utf-8?B?cEVuVHVpTGpvQ2tWYWM4bzlHa2JpSVk3OWdMdVI2ZzdzK085cVFnVTRrUWNL?=
 =?utf-8?B?UldlcGh5L0Z4b0xCMVhDZWRoYXRPVkd5VTh5ZGx3QzNYeHJmdERGS3hsSG4r?=
 =?utf-8?B?TzBuckhMdm5KUmEySGhTUkg2UFc4UTUxcW1JSWc1aFllMkVuS2lIbWk3ZWFJ?=
 =?utf-8?B?dnFVKzZGOVhkaUMvUDZXSndMZ3RRWGRPUzQzZDJIUUplS2JaQ0F5QzBCRHor?=
 =?utf-8?B?ZHZyMUh5ZzJQMFZqYVdrYVlmUTlRV3QrQjhKaXBQVmRSZFZ1c1NrNFZXU1pU?=
 =?utf-8?B?QU0xRWlIa0F3eWN4clhNakJMU3g3UHYxTjN4RGgwcnJvZGxUajI4elJmM3JG?=
 =?utf-8?B?a3UzL1RYZ0M5NUk0Q0ZPWWowUlgvSUR1aXd6QU1YVXMyR2N6SmRocmZ0anFX?=
 =?utf-8?B?SW5laXI1SysxeTdKSTV3NkJKcCtLbzVqM3cyTnozU3I4T2NZVWRjdlN6aDBw?=
 =?utf-8?B?a2psdEw2K1NNSVRjVjdJYm5XVzZCK0RHVEhadE1lSWhPNTJNOXhqSVpGeHNP?=
 =?utf-8?B?alozTWJjNVpzZlk2U2lqVVBoVFVIdU1LS0V2MlZKbWp4d1I1RCtPeTlXRVpj?=
 =?utf-8?B?T3B0SjNobmdCRkMwbGVVQjFnMVljcWFIZUxjcFR6dlBCSTNTSldoWXVvdEJh?=
 =?utf-8?B?dDRRWmRqZ0RDQzUzcm8vYWE0NXJqR2o0OXU5Y1d3TUZSVEhLYkhkdTNKZ0Nw?=
 =?utf-8?B?dHh6MEVpQllOSGJCekZLak4rWkFuaFZZeUJsZW9wQ1VmNENWNG1Lc3QraDVG?=
 =?utf-8?B?UEVvdzlDSVRvNW5sK21VVlk0WlJtSnlhTnVHK1p4WHlleFB2Sjk4QXZNVmZV?=
 =?utf-8?B?TnRjVzk0YkMzenZxWStBT1oyT1VTYm1SZVAyQ0lkLzRiQVl5cUxJWnZYendL?=
 =?utf-8?B?N0FUTlhESk9qK0d1b1VDNXRVUnlwSXdISllmdmFYWWErcEVLQWNxQXQxVW5t?=
 =?utf-8?B?UkZ4K3BhaktXVS9rNFpFMUxZcUZpclljWkdVUm5EMk9pV0NXV0JzUTVYNVZ5?=
 =?utf-8?B?Vm1pRDVvbWU3SGZmTHoyRW9xYXVHOU9CZ2Zhb2ZTTG5jT29JTStyYXRSaDgw?=
 =?utf-8?B?VkVmMjFzRFh2SGk4OGltbnJWcGl6NS9SeW91NVBGSXZDVDFxYTV2dHBJSitI?=
 =?utf-8?B?SXhzTTdPN0NQeU9xZXNjT1JXaWNhbi9vMkNOK0tkMm5vTGdmazV5N3M4clF1?=
 =?utf-8?B?a1p2L2N3TUhDS1czeXZFN3MwT1E3Ny92WHdRSG1Db0o0amQ0WWFBbGlLY2xJ?=
 =?utf-8?B?U3d3ZkNjYjJlTTBaODdzUUpVNEFCYXFaUU5Xcndvd1dONnk3cXZ2U2toZ1lo?=
 =?utf-8?B?OGJYZG1neXorU1NqMDR5d2lCcmxYNWNnMzA3QnJTYnlDdUl4ZFZoeE9RWElX?=
 =?utf-8?B?a1lmU1BrejJXK3ptTzFZNTJBdVcvalMvUm1hVmIyb0xMTkFoZ3Q3aEh1Sjl1?=
 =?utf-8?B?Zy93dEJNcHcrQTRNcFBveFV0Y090TFY5WXNzM1FKbUE5UTFwaHp6VjRWS29I?=
 =?utf-8?B?OU54K1poc3J1ekhlZTNnU2ZNSi85TFlTeExpMnZrbnZVcEJQSkh1S0duZ1h2?=
 =?utf-8?Q?DyNx4fUwHexBKhqDjSxbwzfqO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a22b166-c021-440c-0476-08dc482eb230
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 16:07:37.5746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R46hvF2TaVw+0IEzDGXeKahGUFt5AdE9nNbpC4sL4mUNGc8dhhJ7aDX+iqKmCQfvhaA8YUteO6HxGioOux9nww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7772

Reserve space at end of first IORESOURCE_MEM window as message TLP MMIO
window. This space's size is 'region_align'.

Set outbound ATU map memory write to send PCI message. So one MMIO write
can trigger a PCI message, such as PME_Turn_Off.

Add common dwc_pme_turn_off() function.

Call dwc_pme_turn_off() to send out PME_Turn_Off message in general
dw_pcie_suspend_noirq() if there are not platform callback pme_turn_off()
exist.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 94 ++++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h      |  3 +
 2 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 267687ab33cbc..d5723fce7a894 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -393,6 +393,31 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
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
+		/* Reserve last region_align block as message TLP space */
+		res->start = win->res->end - pci->region_align + 1;
+		res->end = win->res->end;
+		res->name = "msg";
+		res->flags = win->res->flags | IORESOURCE_BUSY;
+
+		if (!request_resource(win->res, res))
+			pp->msg_res = res;
+		else
+			devm_kfree(pci->dev, res);
+	}
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -479,6 +504,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	dw_pcie_iatu_detect(pci);
 
+	/* Need call after dw_pcie_iatu_detect() before dw_pcie_setup_rc() */
+	if (pp->use_atu_msg)
+		dw_pcie_host_request_msg_tlp_res(pp);
+
 	ret = dw_pcie_edma_detect(pci);
 	if (ret)
 		goto err_free_msi;
@@ -536,6 +565,11 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 	dw_pcie_edma_remove(pci);
 
+	if (pp->msg_res) {
+		release_resource(pp->msg_res);
+		devm_kfree(pci->dev, pp->msg_res);
+	}
+
 	if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
 
@@ -697,6 +731,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		atu.pci_addr = entry->res->start - entry->offset;
 		atu.size = resource_size(entry->res);
 
+		/* MSG TLB window resource reserve at one of end of IORESOURCE_MEM resource */
+		if (pp->msg_res && pp->msg_res->parent == entry->res)
+			atu.size -= resource_size(pp->msg_res);
+
 		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret) {
 			dev_err(pci->dev, "Failed to set MEM range %pr\n",
@@ -728,6 +766,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
+	pp->msg_atu_index = i;
+
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
 		if (resource_type(entry->res) != IORESOURCE_MEM)
@@ -833,11 +873,54 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
 
+/* Using message outbound ATU to send out PME_Turn_Off message for dwc PCIe controller */
+static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
+{
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
+	void __iomem *m;
+	int ret;
+
+	if (pci->num_ob_windows <= pci->pp.msg_atu_index)
+		return -EINVAL;
+
+	if (!pci->pp.msg_res)
+		return -EINVAL;
+
+	atu.code = PCIE_MSG_CODE_PME_TURN_OFF;
+	atu.routing = PCIE_MSG_TYPE_R_BC;
+	atu.type = PCIE_ATU_TYPE_MSG;
+	atu.size = resource_size(pci->pp.msg_res);
+	atu.index = pci->pp.msg_atu_index;
+
+	if (!atu.size) {
+		dev_dbg(pci->dev,
+			"atu memory map windows is zero, please check 'msg' reg in dts\n");
+		return -ENOMEM;
+	}
+
+	atu.cpu_addr = pci->pp.msg_res->start;
+
+	ret = dw_pcie_prog_outbound_atu(pci, &atu);
+	if (ret)
+		return ret;
+
+	m = ioremap(atu.cpu_addr, pci->region_align);
+	if (!m)
+		return -ENOMEM;
+
+	/* A dummy write is converted to a Msg TLP */
+	writel(0, m);
+
+	iounmap(m);
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
@@ -849,10 +932,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
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


