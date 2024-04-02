Return-Path: <linux-pci+bounces-5544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253448956DB
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 16:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00482B23174
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 14:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82DE12D1E0;
	Tue,  2 Apr 2024 14:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EmOZSVHR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2127.outbound.protection.outlook.com [40.107.7.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD0F12C813;
	Tue,  2 Apr 2024 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068452; cv=fail; b=VSGjQqvNwmrJb1wt6DNO0UI8YPHRe2WXRUOUdETqYaTG2YGDqA48IcFSwDwz21zWYqZ0tU2G5tk8NdL5ZKPSFSJxdZBLWMaXHhOpyhntANn4iuAZPhM2G8dH3PdADFOSHcwvm4fFOjkxnmCrhnl0c5qqEXssGrxC7hp65vkMLyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068452; c=relaxed/simple;
	bh=DVWGt16ZkDjrpGlf7ZmoFMuh0WPhyhcGXUgdS2u0B7Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=mjvWZIjf3YFYvuVWOioUKWSBTIeL1MiHuiCH8pmFGIsI2unSySz9tsJHt1dSy4jPft3tkW/yXdtI2EWijWyVW6bbsNqrd/vDT/6AdR6abctdrLd2xUXz22w+phF93gFR6qnnoGgazm+fyJ271VI90whZWozkQ9lt0PHEjqOlCOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EmOZSVHR; arc=fail smtp.client-ip=40.107.7.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URjfrZwQVheVP3napiZ/OeF8YE3vAAhMik3f7uha97hgXCcT7ExgM4yef1/aKAOEUWwfOBgmnyUsT9hXN2b9ztro/IbmwLFyNubj1ZEoLnjM9a7YXouxIbWWnyD8zMaj3f3IOpw4dk1uJZcDNzKNCzKASlLv5a4597ygS2gtRESzZzeu2AOQINMZ6riZ7MaNaLaG1TVe2BUgRLeUmPv7eTMQ4f0jQMq7sFZ/4XTJysCznNx8L/qwXipiOPjXTvEOPK0I4OfKajWdcRvWO0TFON/6MIT2fiCqvppzRWq2XcddbaTHIXE2tAsETbvG8ePcPvBXXuCIq90KbzlENJbpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvmYICRW60IA3i7sGyBZdqkWQTTksPH37Wf0u9XLh8U=;
 b=bSKMwsZKk/1P12mmrlOWe/1/veR/8wYz0gCy1X9kp1d+dlij+nBm8KCuPU8ZplXNKexFoS3hKycmz0n/L3eIBCaKtSO+2/znMzajoqVjxilBNCOmNAv3ckRwQGwD2gPVUJ3jDK9liwikOdprU6uABlDZ0WQRTqIsaZopuBV8Uw+sG6apXkE3+YhlDaLfc13TsP9nMdv8jJQgJlFA3ZM5n86wOCz5y0PFyYYf/NWj8UFx702rGJEZK5Idx0YdU5tBBADY0wCbUMqebDF82S+xj5BqyUKkIto0ZN6ZZRBwP9VtOINeG4p1rc796dDlWjV012+oFqRp0roQw9tvDADODQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvmYICRW60IA3i7sGyBZdqkWQTTksPH37Wf0u9XLh8U=;
 b=EmOZSVHRC/MoIDUguwZ54ixxikOuoId340ur0S3Z8KLnRHf6nLGHcgtVV17mkVEcFTFv0bOQJaDfOiluK5MVBoWbp/TFZF3XCFNyz9E7gmcdbv5j2oJSbmssUcvIFctfr+JWhk3+zj7hCXO00jFkkLf3SnP+30MdWxZACtPJEtM=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB10036.eurprd04.prod.outlook.com (2603:10a6:10:4c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:34:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:34:07 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 02 Apr 2024 10:33:38 -0400
Subject: [PATCH v3 02/11] PCI: imx6: Fix i.MX8MP PCIe EP can not trigger
 MSI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-pci2_upstream-v3-2-803414bdb430@nxp.com>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
In-Reply-To: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Jason Liu <jason.hui.liu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712068432; l=1224;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wkqaOQNbAPl8jcfm4U/1iKLk2FvgNgK2azcC4lLlLiU=;
 b=RnYRF2rkC2glE0yYsLaNUFVJ7jqpnzBN2j/X75UrRaWnYZJUXk4coQmSx5xkhbS7BFFwB9V7T
 dxkNZsUe3lxC22IRSG8z3Ri+Mmua9dKUSEvA5LqdFvg+HSqoXgwudlb
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:510:324::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB10036:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	un8Qd0pNSCCUu8qwK1sKXEI72oz8fmaWNqVoADBDXLKrxXsjX60yYJbULTBy/IEZkd00m21ASRZHC4bBDVOi6yoYkbtJNNsUJH9LF+vsV78rY7MEN6Tt1MUDRS/ZlsIyB6sgsAqEcEJ709hS35kC4brphPTZcdMo7a/p0YCLal8qbMkGx6osk3UMT/uPYpQjyjyA8bvFwQ5Lm4Wb3DsYObNOwlCMJVJFxD/FvVZORSuDz6oc++sfIqOcV82/VV76IXBTeSVHGDOLsM4sYqbt/2F3thD2+i4CiQkAuRApV7q8VF0MguUHlTUBDMyN3PI5Ew+2F10cHUbxeJ+jMhbSCMQ5irVJcmghg5PP92WX7zc0m+lzxizrA6+LMporkF3g3cFBU9S0UDUfHSypOs1AKL6FRIPcGaAWwyEnskKE7JaCf5/bySiGy1tQv3oq+C2kl0fDqXoytKWnykPbE4kSOFbquKhpEJ3rMsmS46n9R4KAojsR0hKFpBvaD8qQl5x1BAJ8GdH+IGGfXyxQvbQPIersRwF4qjG4YesIi9cayQQ2CeD//4isdgWKVdg+SHfiMF1wqSZLKDc+CClE6mClFp/7TPq01AlY5ufwYme/tKWQBhHgt+BLd/VsLEn4GE5JIaCQcoJcI0JoQtJToOM63N2FT27gRYH8nyJQ7rhZW+s7HtaBw2XdX/2j7pNC7O2j6wlj5kVAoYKPxzpl9GUD5hT1ThrfHnFfVShnOQsTIC4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(52116005)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFFmdWZMUmdzMnI4SU9xZUtCejQ2cVdUNTNCOFJTYzNyVXQ4c3hhdjVkZlQ5?=
 =?utf-8?B?YlpicHkvd24rWHZsMVdTVTJhM3Y5ckU5QUVNSEJDdXZQcFl0QjVLK29acnNS?=
 =?utf-8?B?SXJVVzQzelhmUDRBRDdrSUlud0JUVnQ5WHpaS04rbjMzNlM0OVFGZERyQWF2?=
 =?utf-8?B?WjR2c0lZT3VvYmMrVlc5elJCTDlMN2xHSTdPL1lXMGRCek1lVmdlMmcxb0p3?=
 =?utf-8?B?NFVhV203MmZxZ0c4ZkwzeEdqVWhDTXg4WlZMSTNQSk9RVnF0YnpOK0M4R1BP?=
 =?utf-8?B?U3M2THpUN0pUaUhuay9WSTRoeG0rYjNpNlR1aDBvdGlrV1NSbjZuZ1FlZStE?=
 =?utf-8?B?T3JhT01wUFZveGdHVEhmNEo1UVNzUTdnV0FPTkU3SldFMURoSFYxNFVaWGNy?=
 =?utf-8?B?Y2dhRTF5bytLR1I0V2ZXYzlRQ0o0UnViU1NQNGUxcDJIUzFYekgvbjcrZTBN?=
 =?utf-8?B?UEptaTVnVmZTazF4QkJNK1FjTEJmRk1zZWxpSzhBNlhleVpYUjBuSVIrbGhj?=
 =?utf-8?B?MlpzTlAxNXlOTzZYUDMwci85dFB6L1VYZmxoSTM4b3RPMFpXZTNZcFE4Q2V1?=
 =?utf-8?B?dlJxOHIxbnlLZ09EYS93N2xwczF1VEJCTGdYb1NFMDRvc21HaHB4K255QzZq?=
 =?utf-8?B?ZEg2VGUzRFhYRXdnWFJmRWZYWTBEVnZwbi85aXd5TlV5YmIyOUsrS2VSWjl1?=
 =?utf-8?B?STZDMUh2MWx5MHVLRWM3LzIrQWNOSGFhQmlqWHQ5Y0ttaTJWZFk5MVFMOVZm?=
 =?utf-8?B?dUwyQjFYNkdsYkM0bEFXN1luVy9Td201dm5vYm54d0I5bUtkMnJsbmpNNDhx?=
 =?utf-8?B?ZmxQZDk2Z2doQnJOOXo3Q1h0b3FQWS84RXp1QzdLR2RoM1B2RHZES0xLMGl6?=
 =?utf-8?B?M01lakV0VzdCSDJnZ1QwQ2pUTDBqWlBtdUNyaGVuSWp5dGhPRmpld1BHK3Q2?=
 =?utf-8?B?WnpJd28vWGhzb3dzaVdzcGhmTXdlYjExNkp6VnJIb3IxeFRIc1ZhYXdyY1ZP?=
 =?utf-8?B?T2t4Y3RsNmhRcW9YWitSZExiWHI3VFREakVxRERCUDZQK1NSOHNNTXpOUll0?=
 =?utf-8?B?b2x6Ri9wMHRUWGpFM0NBTTlNeE1XSHk4VGVvWnFUaUFrcW84bDRBbFpZNVNS?=
 =?utf-8?B?UXFwY1Y2Qk56b0c5V0g5SGhMT2dDbS9TNFFHdi8yNEliYW9pRUp2SzlzSTFY?=
 =?utf-8?B?Mzh0aHNpRlhrRlF1ekhoOHlXWlc5d3ZXTHE4SEpGRUczbTNIQlBKMG1Ib2V4?=
 =?utf-8?B?cWNwL3JsenRDajRORTlaZVlMQzVEbWJCNEZUQy9KYWY4c251TEhSMHRBUXlY?=
 =?utf-8?B?NE9QM0UydE9sNlFhcjA4dGJPTE8ySkhaYmJqYURCYmJWTWJWOENxZWpRaEhN?=
 =?utf-8?B?RjZJclM0d0ZFTjRLNXBIdmJvQVM4eHZSWU5vNnVkcU9EM1EvVUJEaXpVRjNC?=
 =?utf-8?B?LzB6UTNRR2xpSDlaY2MzVFlqUU1kV2QybmlWQ09ualMyVWx1ck44UnVQS1Q5?=
 =?utf-8?B?YWY0TUpPbzJKMjRuWW8zanhjWVNab2poWVZKaDdLekpYUzFzKzlLMFhhTWND?=
 =?utf-8?B?eFMvenAzQ3laVWJESy9uU3JOOFdaL1RIVHNobEtXcWFucTJaWm1nVVJ4U0Y2?=
 =?utf-8?B?QnNrbjR4NjZmZDRhU1ZDYXA1NHd2ZGN5OVFLWWdEOS9oNXdWcFNoTGFtdlFa?=
 =?utf-8?B?Szc0OFdEby8vUnRZT0FvY3JzdmdQMnhEQ1lFTzZZWXRyME1PY1VLbEdrMkJY?=
 =?utf-8?B?amJxd0VtY3Y0RTFuTnpaYS9hdmVZSkRZS3dSSnZvNlh2ZVNkaVY0bWtBdzNB?=
 =?utf-8?B?ajQ5VmltVHBoTUJoSWhjRUtkcS9TVkhDbzl2MVJCYXVjMVZqbSsvZmw0T3JD?=
 =?utf-8?B?NEJETTZoZ1RJSGN1VFAvQU1qeW4yM3Q0TDJFQTg0ZThBUWRvaytHWnlzaFds?=
 =?utf-8?B?dTdLaHJRSmp5Y0JtWnMrS3k3cWdoQ0JpdGZlL2tnRkl3aFMxb0JLQ0t2cmpJ?=
 =?utf-8?B?c1h4L2lrV3lzZ1RnMDZOV3JRUXNLUXRBZWsrc3I0VDN6bjF5bzB5eUd0U3RZ?=
 =?utf-8?B?bEFZbkZta1IvRkJLRVJTT1QwdytKbElzWEllZ2xkUVR3ako1UE9xMHViM01J?=
 =?utf-8?Q?lgCRW6N9POAQuo6FMUeroF5mc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e5d60f-08d6-4790-6341-08dc5321f3fc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:34:07.3435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGC2SLRAZ4fES+DOF6BtFygjzVBjlptlAs2HYNK8+TAzO6+qcNnWYQUt9PWWTmsmYRyxRSVKqQu0lInv77WwvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10036

From: Richard Zhu <hongxing.zhu@nxp.com>

Fix i.MX8MP PCIe EP can't trigger MSI issue.
There is one 64Kbytes minimal requirement on i.MX8M PCIe outbound
region configuration.

EP uses Bar0 to set the outboud region to configure the MSI setting.
Set the page_size to "epc_features->align" to meet the requirement,
let the MSI can be triggered successfully.

Fixes: 1bd0d43dcf3b ("PCI: imx6: Clean up addr_space retrieval code")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Acked-by: Jason Liu <jason.hui.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e43eda6b33ca7..6c4d25b92225e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1118,6 +1118,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
 		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 
+	ep->page_size = imx6_pcie->drvdata->epc_features->align;
+
 	ret = dw_pcie_ep_init(ep);
 	if (ret) {
 		dev_err(dev, "failed to initialize endpoint\n");

-- 
2.34.1


