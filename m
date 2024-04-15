Return-Path: <linux-pci+bounces-6292-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 587AD8A5AB2
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 21:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1967B22E49
	for <lists+linux-pci@lfdr.de>; Mon, 15 Apr 2024 19:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300931581F0;
	Mon, 15 Apr 2024 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZjeyPuOM"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C27157E6F;
	Mon, 15 Apr 2024 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209656; cv=fail; b=nABBhD0su7cli39N9ilMOiKFjVxbwlzcwK5qmhr+eyE402tf5eKvEDf5t+qyUMbDNakWlkIwg5nBEGNLsG0CLDjhVeIcfEhPBzlFKl0JJq9MWH5oXvvfuqziXmLoWAtfbtxICKWpMhZUcaJU2cseWaNTyWhK64jB1kGcC2G8qiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209656; c=relaxed/simple;
	bh=T5eM7jGli++Q0uN2S+ZvsPFpy84pD1uEfNuEA+XWxBA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=o5rHAFAaQeMUmlbgp3l9n/WG2Pi/PImrHL9ahWkC0VePkDg9W3fFAHo/6XTZRiw4tOdNu6wGeLAvhZXwIybwyyoG4zu7hH3+zsbg0py15XCWWJZIFkrjQz/c7roiWKYP09A0tOar9V032punKwix72xdosDbw9Mo62uzgzzd+nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZjeyPuOM; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEt4sNSihD5ZDx1VnhXvNru6lXpHLF64bpRR17gsMJAZcmjlkD4NJNsGwXKqj6JJkQPztYoakj/vUyAMYIxfnNRBbVNOR1aexH8bjiGT5EL+sSK5UP4KZYo+LZvqwzcqhVkLuXb/fYfgVJmHVnoyBgs51u/yfMklSfEw9/6n8HuKXFfkYHTyOr0Z2AAo9fGmih8V+Y//ug4Uv12kleNfAK/r06tApKK/4+biaRihS0SQjaTNFyRg0sCFKfMbAZ6GW60Avxu++6D6prDSz+SzW1+Opq+84dH31+Cc4NDbEYkbNgDOTwHYFvuVP4soeZciMcLZFbUOhKvegxB5bF5+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szb01cgagiGs7LgbVEcXCjvASrOLIDPOofiqOm+8tQ4=;
 b=Bh2dfNR9Rvhi4FvZvMmvQmlecRI1phl/0LwgziO5UmSRx6zCMKksGJRiLobCCwp6ClbvPkoxsrgUqrzMI3+SKE3YJesgc8DsRa4ke0n6ji5s45thl8xoHIIc1N9f/j9CXst29agsOfcrlNKjjnE6w7ZzHf11+wwtE3B51lSS5sRsf/2tj+fhBSVLRlExYTFYptzawOyDiwACQsHaGkb69bb5nxdJ/T/9IAky+2DHFEdlkbr6H9UFTIxVHHcoYUMwQJ8ew3qM4oMiiYUnewwOQi4LJYGTjx0PKtmZ7oW+NvxjyzIOqzlDPxxLqoQM6SGD381LqTZZy5rVSMOrlOKeEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szb01cgagiGs7LgbVEcXCjvASrOLIDPOofiqOm+8tQ4=;
 b=ZjeyPuOMURJXfjNb1deisLOZT0Lpcp7uGjgdteCV5M0sYwuC0ICD2k6AtQrCc5yftRCOhNl9rs/XQhAboaQrg82HOzPm7vOPyCkYr2qbxl5vKsECAdZTN2592wGMrUr05ENnSpLdfOA9441eiAniBIXlGc8NRBcNM6t7IC5h1oI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA2PR04MB10279.eurprd04.prod.outlook.com (2603:10a6:102:406::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 19:34:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:34:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Apr 2024 15:33:29 -0400
Subject: [PATCH v6 5/5] PCI: dwc: Add generic MSG TLP support for sending
 PME_Turn_Off when system suspend
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-pme_msg-v6-5-56dad968ad3a@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713209628; l=6259;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=T5eM7jGli++Q0uN2S+ZvsPFpy84pD1uEfNuEA+XWxBA=;
 b=aRstxW3H3QIp5/DrFXUvQCYxpTwwTi3aPojUX/ZFd/ummGxc1M4egr/RNDp4llAAdarDjm0yw
 onZ7zl5aCWBAK/w2bnv62f1ZLEYNGv39X9aL8KP/5QrA88pSxrk/Lwa
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
X-MS-Office365-Filtering-Correlation-Id: a019d729-429f-4868-fd8c-08dc5d8306c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VnzkHrzpJNivn5AdsutqWLftdPAweTPqTzPuqVy5SPOCn81WW2t0XXjHFUbfF68/TQSlfXRLtdWcChasPC1PvrzBdFctIwJhRrW/+a/Wy7K46j3Q1qGrqGmnNIvH9npaHZ/N/R7bdNcfEvGuFg5XRq39odvuudfH/xU2bEMzBfE6fjhVIn7ySptYp/DyoXd9tmClRPjt0JFXySNgDFDDvjnGXwIl/YDlOvH0TsGeewF5u8zMGrUow1pcU6GF13x3C8aah5qGu5xUfvlvyhkYH1dRFF/eGKgKYGdMINHv1kviJQsihUB3JPzIb88Rz4688/c83Iu9Nux4YXgRp5yJh/b5eudT8JTLYY8QDt9ZRfYuzb7RWLW2TbOv53N7n4UYsGvP/Q+CClF58I+mdUgugQsWYhdBSKHXQDJ9llXnFEHmPb1+Vm2w5nJT+zUTQPWX/N8LjnIPwMi9WNFXQrlpHUjms8vf+gAKznJWfhT25t1CiJfT49MNCWVjOueLQhPGaogepL4lFyrGVZruCY0UNMdK8JUqWXnzWwEAwptJT4Iq8SM+nNGmfrzFGFRPL/HwPH5S+hft0CiZIQo/kpZYfJvV7VKRxk95YlYSC1/Ll6omRJOSyH0p+A33ei2Tlhpr0E9X+xz37mOsgQkQp8/8i/W2DH3GVQwpodCAzW0OskdF3u2Hzk42zzn+EKHlDMOVCyWJp6GfhZOJkU/+ab269plrniZU0NHbYDIEkhUG0I4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REF3ZW4zY0F2cnE4NEM0aC9PUmt5K2dLTjRaUGsvZStROHBKNEtyWWZyL3Nl?=
 =?utf-8?B?ZkM4VlErWlZDZ1lOc1EvUjFucDl2eGZGUENUbzVPbEJCVEpLdXMyUmpJbzhI?=
 =?utf-8?B?eVRnZXZhU3RlNHFTTHg5RmlXSWhuc3NnOXFuZnFMbDJmWm9oVU5vODQyd1lU?=
 =?utf-8?B?L0RCNFZiR2Z0SHVKZzN2RXFlUTJLUUNIdXRXbGI0UWdVMUJIYklaL3FwT2Jt?=
 =?utf-8?B?a2o1TGs0Q2N1KzROR1R5ZUVHV29FdkJFUlJaZjZjYmIyNmYycjQyKzNSOUtx?=
 =?utf-8?B?cWgrNXlLSUJiWTE2OEJydDZtSkpldnlyZWJINEpTN1NSWU90RGhYNUZHRlI1?=
 =?utf-8?B?d0IrWEc5cFQrc2ozTElrb2N4VkM3OHUrVmhjbmxBeDVSL3pRSXU1SVgyL2w0?=
 =?utf-8?B?UTAzU2txcWdMSTd1OHQ1TmNDLzBXNkNnNXY2NlQ1RVBYU2N3azJnZU1ZSUJt?=
 =?utf-8?B?MlYwaFdNME1ob3g1dkhkeSsyU0RqOVhBWkk1alZYVGxZM01UZlNJamcyNThX?=
 =?utf-8?B?Y1plRHVJSlV4cFBZbTJmK1dKZjlJV2NXKzl0L0RwVW5JY1ROM1phWU5EWFRo?=
 =?utf-8?B?cUxRa0FWQnc2NGgwOG0ydklIc1pPVkJSeG5RcVpvRjhvdXloclpJdUZpMmk5?=
 =?utf-8?B?eXNENWtCbDMrQ0tMUjJpSmxkSEMxWDJuQTBmN3FtdmV0ZFliN1pMRmJQVEpB?=
 =?utf-8?B?M0JOR1U5Qm91ZlJXQjdhTHRUSVVKKzlyRHVzUGtwQWRjZkFFekI2NUkzVHA1?=
 =?utf-8?B?TE5MVFFrYkJ0SEVncDZQcGlMelhmc09sNExMRGhGcGNzNG5PZnRIeVlvQlk1?=
 =?utf-8?B?dm1mZDlQMy91d1p4NnZUUWZEN3ZvV2pEbk1QOU9pRHlwN0pNcXRtdEhBR0g0?=
 =?utf-8?B?bys2c2k0eG5mUUlYTXYwYlVZRitrK3grNGJRbk1RQXpMcDVWaHFqYnJKOVRJ?=
 =?utf-8?B?NWJPbGowYUREWDVXQ0ptQkthTEp5MkI1aGx3dXdIVk1LbHEzMTF3T1R3TkN3?=
 =?utf-8?B?eUFCc1pTblpOSW9QSGwxdUlrVitDeHRqcmJVMHNCU044dE1XWFdIT3VlRytx?=
 =?utf-8?B?TEdLcnhURXc1U1BjMURRenBBR0FPMnFpQUR6ODczZEpaTTEvVk9FcVlUYWV6?=
 =?utf-8?B?TnV3OFUzYnQxWlIrUEFZREVoZHM2V3I5a2tFK2EzaEY3RWd1cEpVZkIyZHpn?=
 =?utf-8?B?ODdXRUpocXQ4VDU4Q1BWejk4SXBnVU8rSFpkYnFjSlg1NUVuczZGZXNKU25S?=
 =?utf-8?B?Y2VPZzdMd20zb21sY0VTWm5BQkZmS2grODlNM3JWNUl3RnppUFcrVlN0RFRN?=
 =?utf-8?B?VW5Kb1pLaTJyaENNVGVXNklGQjF5Vy9qYVdWZS9reDZCbUJhSXA3NjlwaS82?=
 =?utf-8?B?a0ZrYk9GcTRuTmtYczdUcTFWeFd6bVdsREZWMUJaSVJnWnc4MmQ5UHplTnRW?=
 =?utf-8?B?dHRtOTM5SHR1MkdkN1Y1ODBua2o4WG1QSTZ5TG1oeTR0NGt3bnFNejhnUW9F?=
 =?utf-8?B?Y1ZyeFJQYU4rS0hUV0phTTZpMCtFdUlIa2dBZUttZXJoUjBkNUVxeVdzd0JK?=
 =?utf-8?B?cTN1MGp2L0NRME1tbm56THlzaytmQTRrRExXS0Y1YTczb2kzeDlDREkzSDJQ?=
 =?utf-8?B?TXl0Q2NDZzFlcjdrYnZJZDR1dnZGOU5IZWVuS0IvcmpaQVZsOHdyaUhGNzZ4?=
 =?utf-8?B?c0JVN1d1b1d3VjBFcGE0ZjBGWFI1azUxZEdON1hjaEJYdWZoSmVUZ1ZhK0Ru?=
 =?utf-8?B?ck1iUUZjcGVUWkVPVVRNbGI0WU9lcEJGbjdWWkFKSEVZb0xvWThGKzdRT3NT?=
 =?utf-8?B?SUZpY0xOSEZMVlYrdUVaaW53cFdUd1hLdzUzYnNNNVFDWHlqRDFzcyt6OW5i?=
 =?utf-8?B?OWdVcjNyblZlcmt1R2l0dThNaXRRY2NjYUZweWJKZjBkamFjK0VheGxiSzUr?=
 =?utf-8?B?ZXRML3UzS2NURTd6Skg5U2NKUDl6b2MvbE1aYjcxWitDV3dneFJEUklHYUEv?=
 =?utf-8?B?aENzODAyTDduZ3B1TFFOblBxc2lwUWxocnpRbjBIM2l1ZVVIamJHajY5ZGpT?=
 =?utf-8?B?NDlqWFdKRkU5UFhObDdXRldEQ2FnK1dlSWNZNjQrZ3YxVjllTFJNZjhVdVZX?=
 =?utf-8?Q?Im9Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a019d729-429f-4868-fd8c-08dc5d8306c9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:34:11.7238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zgEOQmaRJINeTMfGUR/2iPj+zmuwPe5WSJzQFJxsFEFsdHjaE1WkdYS3whxIjqRaQCAmk/5kAenbEJruxtAOiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10279

Instead of relying on the vendor specific implementations to send the
PME_Turn_Off message, let's introduce a generic way of sending the message
using the MSG TLP.

This is achieved by reserving a region for MSG TLP of size
'pci->region_align', at the end of the first IORESOURCE_MEM window of the
host bridge. And then sending the PME_Turn_Off message during system
suspend with the help of iATU.

The reserve space at end is a little bit better than alloc_resource()
because the below reasons.
- alloc_resource() will allocate space at begin of IORESOURCE_MEM window.
There will be a hole when first Endpoint Device (EP) try to alloc a bigger
space then 'region_align' size.
- Keep EP device's IORESOURCE_MEM space unchange with/without this patch.

It should be noted that this generic implementation is optional for the
glue drivers and can be overridden by a custom 'pme_turn_off' callback.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 94 ++++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h      |  3 +
 2 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3a9cb4be22ab2..5001cdf220123 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -398,6 +398,31 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
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
+		if (!devm_request_resource(pci->dev, win->res, res))
+			pp->msg_res = res;
+		else
+			devm_kfree(pci->dev, res);
+	}
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -484,6 +509,16 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	dw_pcie_iatu_detect(pci);
 
+	/*
+	 * Allocate the resource for MSG TLP before programming the iATU outbound window in
+	 * dw_pcie_setup_rc(). Since the allocation depends on the value of 'region_align', this has
+	 * to be done after dw_pcie_iatu_detect().
+	 *
+	 * Glue driver need set use_atu_msg before dw_pcie_host_init() if want MSG TLP feature.
+	 */
+	if (pp->use_atu_msg)
+		dw_pcie_host_request_msg_tlp_res(pp);
+
 	ret = dw_pcie_edma_detect(pci);
 	if (ret)
 		goto err_free_msi;
@@ -541,6 +576,11 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 	dw_pcie_edma_remove(pci);
 
+	if (pp->msg_res) {
+		release_resource(pp->msg_res);
+		devm_kfree(pci->dev, pp->msg_res);
+	}
+
 	if (pp->has_msi_ctrl)
 		dw_pcie_free_msi(pp);
 
@@ -702,6 +742,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		atu.pci_addr = entry->res->start - entry->offset;
 		atu.size = resource_size(entry->res);
 
+		/* MSG TLB window resource reserve at one of end of IORESOURCE_MEM resource */
+		if (pp->msg_res && pp->msg_res->parent == entry->res)
+			atu.size -= resource_size(pp->msg_res);
+
 		ret = dw_pcie_prog_outbound_atu(pci, &atu);
 		if (ret) {
 			dev_err(pci->dev, "Failed to set MEM range %pr\n",
@@ -733,6 +777,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 		dev_warn(pci->dev, "Ranges exceed outbound iATU size (%d)\n",
 			 pci->num_ob_windows);
 
+	pp->msg_atu_index = i;
+
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->dma_ranges) {
 		if (resource_type(entry->res) != IORESOURCE_MEM)
@@ -838,11 +884,48 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_setup_rc);
 
+/* Using message outbound ATU to send out PME_Turn_Off message for dwc PCIe controller */
+static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
+{
+	struct dw_pcie_ob_atu_cfg atu = { 0 };
+	void __iomem *mem;
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
@@ -854,10 +937,13 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
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


