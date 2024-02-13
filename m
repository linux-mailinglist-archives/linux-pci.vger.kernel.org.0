Return-Path: <linux-pci+bounces-3418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F570853DA5
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 22:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55321C27ECD
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 21:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2F4629E1;
	Tue, 13 Feb 2024 21:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VfFPxsBs"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2070.outbound.protection.outlook.com [40.107.8.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FE161695;
	Tue, 13 Feb 2024 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861092; cv=fail; b=TIWQy1wNGEY11pEFL1oyWJSPiQKaSGO+qxVnfrrIjheFe5FSxcM1UeUdqv7O2DaLhkFVGr6J7bMMGe0bZeM8DRCe1FSWaI/a8XwGtSw1gNV+CoqbEC0wjnYOWoBFKkIWVZFTSCnof0zX8JWgSVjnVUU0vk0STF2voEKLfIu1SbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861092; c=relaxed/simple;
	bh=0n9yn+SK8WKzfk7Sg4Bnnj9kG1xw5fJUkKrHFv0hMh4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ggYuhgqJvzcdhIjTCFHkKUDveA74/C+Jk0u6KwG5FKowbGnvqu1XpNGwiUF8RvPrjrySw7fU3xLmntRggQroW0cfsqhkWJwbDyUtDWHpD9+26I48vpuI3vebje8rhsaz/mFeSgSeEBo/nf0eaWVYpVXSWN09foIf5F0pxjXAxDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VfFPxsBs; arc=fail smtp.client-ip=40.107.8.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJuI5MnhSW/QUDlopQo5StN43Y3MWatKorb9YyIJYin4T6L+lCdSVhvu+NLURraGHWqlNj82lHMGhYjaFDmqdteaJgleY5cn6ZAPVxfVC4PjFl0xR+WElgrkSuNThL/3n6ul/ABAWlp2044hnW3fxAaEmbm+3KJvSvkfUVS9Niv09F9IJeSE6Yywp1c4iMBcy5nkdJK6l7rzDqrKp/raSLkW5vz0ovpN0XNLz90umasoq2b4vQMZm6tA+KlRoJrZopc8C3JyD8eYgM5I+Qz6EcGE9H/H04BnUMJvfSvxHpuedmun/emxIs6pyBykloq/DQVJpa99ftiJVoBmTWcu9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSeFRmxl5iipnf4di/o6bXNzcEBqSB+o/oDR76bd9ls=;
 b=mFC/8AIQVfO9y+Dmk13Jkgw2Euh/aa60of4bOZh2Emr8KRAroMVBjXyhPYmagaB27xK+mTMHtju7UBaIdGaNoU0IQ7tIx+WAVeHCmr8Y0imoeGsHaGsMa8apfCQfcKdl8jkxi9UiaDQdJv2yQrm2EHx/dyXhvLo141SApynwFeeyxsbgQzQanNCsT70ZS6wbEesaljlgAbOaaW4iOepPcDHwNd+VXtRjySQCelk0DhPzQ1FV9En6oRdqwKOTBsK4pR/c6ZBu+mJnaqDjlVDZHC4YTZnVVNpgPOdQR47bDbADeCklQLovwco5mnI+WwGr6OQx739x/G85Erc0TUBnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSeFRmxl5iipnf4di/o6bXNzcEBqSB+o/oDR76bd9ls=;
 b=VfFPxsBsvYsj5QSmVghcDqKSauvMy+1ASmRgguhcW1u6tFiwLHD0d32j4Lrk2/K1eXIYyc28QMykbNael51uXB1l5SwpQnQxmEOEA7LXGTAN3xfAe73gmmOS5PPZpohViGoXwTxayGsMS3N0Ie68jiRytaJleAWyk5aH+rHQ6tQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8837.eurprd04.prod.outlook.com (2603:10a6:10:2e0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.44; Tue, 13 Feb
 2024 21:51:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7270.025; Tue, 13 Feb 2024
 21:51:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Feb 2024 16:50:26 -0500
Subject: [PATCH v4 5/5] PCI: dwc: Add common send PME_Turn_Off message
 method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-pme_msg-v4-5-e2acd4d7a292@nxp.com>
References: <20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com>
In-Reply-To: <20240213-pme_msg-v4-0-e2acd4d7a292@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707861067; l=5590;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0n9yn+SK8WKzfk7Sg4Bnnj9kG1xw5fJUkKrHFv0hMh4=;
 b=jbAMBNdLFhsC4g0YQslKnAqS8HdI/vd3GKRKlFkjksfGmE02bEafj9GQFmJjNH++Rf+8Z4F3f
 6p20aIdDGfCDjMhnBXgA7amLu/Hc4zYHZyfh33LM4/b4+9EBSnEP/kr
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0211.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8837:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f326471-07af-498c-920d-08dc2cddef24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JyaSsDtp7J95LzAspbESMUULJAe+cnaaA5otkmeywD5ErJ5CGT9+RBERymZ92vJ2GNagWGIPHBXMc8sFdivFjCn2/rFuWtBo8tMNvFMm2jX5ngGZnO6mk+WNFPT/JXz8Vvl0QvoHZDUZry6SpAWwI+RURmTW0wE+FN+79bPEpRCtqvW/8TGO3l427o0EE+KxeKilT/9G9veFsLaxwQ3ZWceJQCS9vEhzVYjKPq8k63XQqfmjoX7RmCU2VUhF5zfMtuyc2m13miw8j+MLGTnf9twxBV2tH1OTWKlniu272SyrcG6vVAbGVgA0y/P/30GwPOblgD7k4bMpZ2ZpT9eFbv0O1XelcWJTfWZhFDUGzifolxbVm1fM1qSHwbEriuQrjY/DFPzLURCBrW/v9+tGmR3r/OtCAdkx6ckSWw3HOGV6dhePLiFsvQnSFDmEQbc5+8PcLgnOYaqNiIZh8xsfPsEXb3CTSBuehmIbnUTGzjVfzhnjvTEcqkFohkrc0TlnHYV9aS2zYWgItAYKarmqsJ33jpGq90XnxUxgZQQ7FcZNk9svVc528QkqljTM/jq5NErBbN+JVFdLUJH2l1zgwCm4d5BaHc4VyAAr6rBnmEenYhwRM8RRObGWzS9RxWSzYq+fm6AvLgS2re6is8v9Vw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(2616005)(6486002)(478600001)(6512007)(6506007)(52116002)(7416002)(26005)(316002)(110136005)(66946007)(6666004)(66556008)(66476007)(8676002)(4326008)(38350700005)(8936002)(5660300002)(15650500001)(2906002)(36756003)(921011)(86362001)(38100700002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlRnQmNSUGRnOWc3STdMY3lpNXoxY204Z3BORFM4ZStURDlQZEd1YUZ3WGt0?=
 =?utf-8?B?cTFLWnYzTDFLaTJuVFIvK2dNdGNqWnRQbk5vcGcwVTR3bnlFeWhKd1JaSkZS?=
 =?utf-8?B?R0dNKzVYMnVIMUwzSzNiTzdLZWNyUXQxbXJtckpGL1dubDkxWTlFM3J5Uzhr?=
 =?utf-8?B?b3NGSWY0RDlNT0p1ZElBaGdZTXB6eUZSaTFSbzFvaHdhaFN4Ymh5eDNVR3Y2?=
 =?utf-8?B?MWV6a1JWOE11ZXZrMGRqaEU1bWF3L0dzNTNHN2xnZW0vV0VWZmFpQ0tVckRt?=
 =?utf-8?B?V2VIN0Z1ZjVxcjNNcnlGNHphUHJlSjZ4V1kwc3V1RTFPenN2VGpaTTc0ZTVT?=
 =?utf-8?B?M3NqT05XaTMwb3l6TFhlTTVrU3l2REE1aTluYTBzUXdzbVIwR1BJSWxOVTlE?=
 =?utf-8?B?RlJCLzI2TjJURUlLMERzY0czZ2ZVeWJEajhyQ3puUldmTGhHNkNRakZNSXV1?=
 =?utf-8?B?RVp4UnNVQUh1TU0wRXdmTWlDQVhNTmFJdFRWcHhOaHh2SVU3SXl0TEFWSHhu?=
 =?utf-8?B?VllPdFZ5QitaQnhqelJqbGIvTUplR3JTYUg3d3I4OXFZaFhocjZ0Mld6a0Z0?=
 =?utf-8?B?T3orRy90VXUveHJab09wMDNuNFlsR3d5N1dCY0FCRjJWOUd6VDhDOGp1Z3Qx?=
 =?utf-8?B?L3l3K0hzODJOSXp1M0RIaDNTT0o4Vk85b0VmVXh1TE1QU2JzUzRoczFIbnE1?=
 =?utf-8?B?YXdQOXJpN1hyK2d1ZFhUdjZHSTNNUTdCTE0wSVdFZUlOandaNW91ZGFVUzJH?=
 =?utf-8?B?RkJ0Ti8zN2JiMnpvd2JUVjJtN0tDUVFxcWs5UzA1QlZMUUJQZGpJYnc4aTYx?=
 =?utf-8?B?eHdrVlNrMHlDOTZNWWUzY2l6QytzSlVBbDNOQjBNd3RTaTFTNGVmWXVJNm8v?=
 =?utf-8?B?MzJJbHBENXBPMTJjOHpPeXhvRDQzZU1yMUF4bElINXlNZ21EbFVVUC9aT2hP?=
 =?utf-8?B?U1IxQWpETng4bi9LN2U2WENReVE1ekRmbEo3RWVTK2ZkVUkzWEZjRmNYbXpU?=
 =?utf-8?B?eWxmem16enlWeFZMQVNoK29oelZPSWoyNXp6eTJmQ0llc1VqU0dHTDFUbzho?=
 =?utf-8?B?TFVweHJRNFlVclZ2dFNmQVh4QUhsS0NXN3VEN2dhcUJQUXFhZ0VMbzZCMFZr?=
 =?utf-8?B?OG9SOERSaFBObUxEc0pHcFN1azJFWHdDUTRXR1M2WUdoeVpQSldxejFHcmdr?=
 =?utf-8?B?RFNCS05OdlduTVExUHVLaXRtNnlZeGFFeHM3U2FrQUY0N1pGRGtGTWRmMGVP?=
 =?utf-8?B?SjJ5VGFPR24xbWVtNzhXak5TSjFUb2VNSk1sYXVaVzJPemJMSE4zRjZyS1dw?=
 =?utf-8?B?dzZTdDNpWnZKOVU0U2svS3d3Ym9xWkxON3BHaHpNMXJIeXN5Z1ZqMnpTYlBj?=
 =?utf-8?B?SkJQNUJmWFlNY3ZnL3V5OGRkR2RuQXBIM1VtZ0wwcndPcDlTSGpMSlYvS3hz?=
 =?utf-8?B?c2JoVG5OcTJKOG8yUGEwZklGVzhVc2c1L1NMRFBub0Q1LzdHT20zNldZWHNV?=
 =?utf-8?B?WTJ3S3VIVktoakdDTzBQVDVmMEhvZlYvQm9DZmt1YVgyTGVwL0Mxd3QwekRF?=
 =?utf-8?B?V25uWE5PdHRIQjlMVUZjUXZkdzFLLytwRytzUWpxdkd5azZGbWdvVzNWZmx3?=
 =?utf-8?B?Zkh2ZWljVGxUb2I0TkpHQWNWZ3EwdDRkSVlxT2FRM3VpWWlFZU94ZUpJVmx3?=
 =?utf-8?B?dVB4MXJOc3ErOGxFaUlvKyt4Y3hac2NESXJUdldkSVEydlUyWmJsajYxWllZ?=
 =?utf-8?B?NnM0bnFPb3FmT1Zqd2JsWkNqSW1ETnFTanhWV0l5OG5GN0pwUS85L3dPUE9p?=
 =?utf-8?B?U3lkTlBVZVp2NVYwV3pHVVVuOTIyQXo2OWI1Rm8waHlKU0J6NW5ma3RZK3A3?=
 =?utf-8?B?MFU2UElvbURZdFZ0OEQvZFY2NXlNMHZ0b3FMUkQrREh3Q214WG9TRnp6Nnho?=
 =?utf-8?B?Z3czRFdvZkpJY20xSXRTejU2MlVsNWVWV2FsZ0NpY1NmNmdEckZrYzNBL1dv?=
 =?utf-8?B?WUdJMklMUE5xMVZTNXpSZVBmTXNzTytCZUw1c1RCYytPK2VUb09yRm5mRE1I?=
 =?utf-8?B?bkt0TzFTOC9yVXN5VndoME5CTE5BbGl1K0hxT2xtKzFyd2RmS3U5UDdzSXZG?=
 =?utf-8?Q?6oZN8VPQTDAXZSWS30g/svXX1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f326471-07af-498c-920d-08dc2cddef24
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:51:29.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JE7xF6XM3252KF+jAZ6/cMGivW5g3CWheg6mrp+yWSFI3MaqiasINvtMWyPnJFTPxu9RHXHMDx18aoUd2diDlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8837

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
 drivers/pci/controller/dwc/pcie-designware-host.c | 93 ++++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h      |  2 +
 2 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 267687ab33cbc..5e83756492462 100644
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
@@ -479,6 +504,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	dw_pcie_iatu_detect(pci);
 
+	/* Need call after dw_pcie_iatu_detect() before dw_pcie_setup_rc() */
+	dw_pcie_host_request_msg_tlp_res(pp);
+
 	ret = dw_pcie_edma_detect(pci);
 	if (ret)
 		goto err_free_msi;
@@ -536,6 +564,11 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 	dw_pcie_edma_remove(pci);
 
+	if (pp->msg_res) {
+		release_resource(pp->msg_res);
+		devm_kfree(pci->dev, pp->msg_res);
+	}
+
 	if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
 
@@ -697,6 +730,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		atu.pci_addr = entry->res->start - entry->offset;
 		atu.size = resource_size(entry->res);
 
+		/* MSG TLB window resource reserve at one of end of IORESOURCE_MEM resource */
+		if (pp->msg_res && pp->msg_res->parent == entry->res)
+			atu.size -= resource_size(pp->msg_res);
+
 		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret) {
 			dev_err(pci->dev, "Failed to set MEM range %pr\n",
@@ -728,6 +765,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
+	pp->msg_atu_index = i;
+
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
 		if (resource_type(entry->res) != IORESOURCE_MEM)
@@ -833,11 +872,54 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
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
@@ -849,10 +931,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
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
index 703b50bc5e0f1..9e6076aa4c850 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -341,6 +341,8 @@ struct dw_pcie_rp {
 	struct pci_host_bridge  *bridge;
 	raw_spinlock_t		lock;
 	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
+	int			msg_atu_index;
+	struct resource		*msg_res;
 };
 
 struct dw_pcie_ep_ops {

-- 
2.34.1


