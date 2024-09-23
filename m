Return-Path: <linux-pci+bounces-13385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0527997F0E7
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 21:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63514281980
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 19:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5951A0728;
	Mon, 23 Sep 2024 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YzaArdd/"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADC81A08CE;
	Mon, 23 Sep 2024 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118012; cv=fail; b=ASVPduBe3YwO7ehKqzK83qkdKV4h+ye8/R0Y3HWZl4M3k8XMqRjXC4TyBJePTyMYOfPU2x4PNHFP474z14abyKc+o6ytm9qZm1ZX/uMTHWYM1BdyM2+P5nB+IKfhvCs3XaFc4TxKX/vvgWHqR+V+j8ns0cFH6FSUNeWzLr6N8SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118012; c=relaxed/simple;
	bh=V15zXozfNWL6kp+8D/DbmD0EcKRgdTMQmrzAGNRr6iw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=KKNY61GCUJOyN440cT9K762h62CrGLzyP51eZrfY3z3Xqt8dERROrYx8qpiBO8/1Ryu3zYurq3pVLcP+DL2zAqjYfNiReINHJz03Y9Z1h7kzxOz1r4pYJ/GnHD+3JyFHADMt29znKY7hD4zNyCYlzVY69aHYzcBY+H9WgomG3HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YzaArdd/; arc=fail smtp.client-ip=52.101.70.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xuw6Vs1srrTs1tvmEa4N/Z9Hhm/lg2z93BrMlnB4/4p+X6s4iiYgYm/1TnAU6IuNFi/eYjzUj7Ntfthbwi3AfJKpv89p44ZINZkiu+ODFtEGOUCQHTIPBj9RNA2Xi/ESmlcmJaK/R89MbnwVfaskmfi56/1KvHwqfxxRGJd+5vg7RJIOAEfThDsT+KfF6UUI3/JIAScoaHiT0G5iwKpvD2x4MnONNfsjaX93xwdBB0sgeViekhOkpZHRfeG7v9RcvzJ2lIuhipHT/KocDS1lkDa5IXvBDaEBIKS62gh1LXyzEt3KA+OPGd3liba6N7+ArGfBW6yY0ozgJrncpzI4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSxCkGr2E+mSdyHcbfmNyRd4WlUmCAiViAAKc7v4Vyo=;
 b=H5DQ49arBD2yT8opxU+TmaMoaf6dgQNaXcL8ZLVI2qPB7tIdlRQzO6HLof2T0beHQOzk5HPNBDJYdEkyK874+fectTt3W3Kc0VZ7u3X4mzleRspOcJSddk06oz8sPJSqR8ZWgKpD7w5LcidapFw0O3t4jGg6yHyEbL+rmDlYpRyZsBr+VHK8xZ7GWNlvl69n3qY+kYQy1dwURwG9LlvfpXveVklv+SQIVmQKubWR07eIwhmyz+O2tD2ZlGJ1kWpYjkV6LdFG2d6F70ZVDgKYdbNIDDJlwxvAAv3+WFs2cjpWszWrRp9DDFySv7Qn/DksPNQ20SKUwoG2f+TNo5Veng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSxCkGr2E+mSdyHcbfmNyRd4WlUmCAiViAAKc7v4Vyo=;
 b=YzaArdd/RBkRuob2WSzBbrQoJUkfbXDgQbjIAFzr6v77JBxTwZM6zIyE3vq1ZCvM1SCEeuBC0DoqiLTXyyO4vGoC7LFmpzT22Nw7bWY8LklNv41vHmK9vf7FEYNaMALp53cganzoVuWaEthc7mPO4NTheWqJaCJzthS6KruZ+2BFvoq1WRCGAfkylBaQg+XH10YanKmNAEtBaFwC35Sok+z42q1sxW2jktIv5jryuorTegG7sw2svVEwATBms4tIyKmP58+322VzCPozn13EIaejYrmqFASXzVCvGK0GZ2O6sibY+QHimkI5bahwJPTDQNV4Z/guWajwOf0VMT3UwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9562.eurprd04.prod.outlook.com (2603:10a6:10:321::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Mon, 23 Sep
 2024 19:00:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 19:00:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/4] PCI: ep: dwc/imx6: Add bus address support for PCI
 endpoint devices
Date: Mon, 23 Sep 2024 14:59:18 -0400
Message-Id: <20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIa68WYC/13MQQ6CMBCF4auQWVszLSDUlfcwhEgZZRbSpjUNh
 vTu1iZuXP4zed8OgTxTgHO1g6fIge2aQx0qMMttfZDgOTcoVA1q2QtnmEZyoy/PxrSmpRqRpIa
 8cZ7uvBXvOuReOLysfxc+yu/1J+k/KUqBYqpJzyfV9Th1l3VzR2OfMKSUPi7AyZ+oAAAA
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727117997; l=5552;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=V15zXozfNWL6kp+8D/DbmD0EcKRgdTMQmrzAGNRr6iw=;
 b=zLj7AFge05IBbyBRDen5FYTZP3VjCHOVj0jGDmLAsimhBEqqJ5y5lceZMKBIw0vKcilsOXTZ3
 Rg9PNqLlPaiCPO49msN3rVVJpqzYWWqLJ68e6k/qV/wO1OUKaCCaF5H
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: bf24b445-ff66-4e09-7dde-08dcdc01ee27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1FpMS9lQW9nZWd0Smt1ZkdQOUMwNDRrRnovZ045cWJreVB6a0JlWU03VFpV?=
 =?utf-8?B?WjhqNXIzM3plRnk1cTNxNVg2WHRPOEhXY3dLRUdqVTBRNzRLbW41SHZacUVW?=
 =?utf-8?B?a0pNWC9xNVc0TVBmSlZSVklxOUpSNUhZV1dkTUNWQWZVMTA5b1NyNWxCWUhU?=
 =?utf-8?B?TCtEU0xjbFJ1dzU2UTFFMmxTWC9zR0kxRGE3SFpkWWRiUEJwelNiS3Q5TWdN?=
 =?utf-8?B?azV6YTFOZ2p5bG83UmZkVzJITXd3SXRGUkpFQ1BTYnk2cExkU3Y2WlhyR29o?=
 =?utf-8?B?NDc4TXBxb2hLcUtRTHhDUlhGeFlycnpZc25vTWhnM1BBZ29tdXNFV2Q0RWVi?=
 =?utf-8?B?OTI2aFBCMWkxN3VRTG96SGFTNSt4UllmR2t3R1V1NSthaEpUT0YvOVZYckQr?=
 =?utf-8?B?czVRbW1ETndCbVVXcFV4cEwwTVpmNjhBZVcrVDZVRXhCak9TU0g2M3Y2anJs?=
 =?utf-8?B?OGlQVWFiUWZ6dHBDSjFJU00xOW1CM3V4MXdUWUNuc3Z1VjExRnZ3cXdDYk1G?=
 =?utf-8?B?WEVxTEtNcTluOGFDTW1vZXlzRzR5Ni80QnRBTytDelg0Q1lDdkpGT3Q0R2dC?=
 =?utf-8?B?bC9UWHROWklGVUdNODUwblJGVEQ5ZXFNajRtZ1V3V01qSG44RTkzSGpBcXBZ?=
 =?utf-8?B?cmJQZHZNMjVyTkxTdWYzYUlZSXg0Ny9HcEljcVl3OXdvZWxpK1RoTWJZMmxr?=
 =?utf-8?B?dkk5a25hTzFwSnBlUjRaSTAxZlQxSTdldmhZUkNycklIQm1NYjkzUFQ4ZWdH?=
 =?utf-8?B?T0xrMWxjUDcxMjdEYXgzWFFORmROTGZNL1pGN0lZNkxkUGs1R0JTSGpaQ3pJ?=
 =?utf-8?B?aml1LzhuSncyL0V0Y2lGdXJVc3QvTzRSWVBSUjBxWXZNOEYvNVlSMjVlSVpU?=
 =?utf-8?B?VXdOVUh3dzF4UXI3d2pUclo1OHFWOUVqMEt0WElEbzh5Y3RwOTM3ek1RVGNU?=
 =?utf-8?B?K3JTTjhrVkY1cmZsUWtTM0NhN1U2ZXZHM3BUdEtDbmd4bmhCUWVxS3N1WVIx?=
 =?utf-8?B?Qjc5Nm16V0ViZ2ZtMTZIV3J5TFcrUDVhRXlINUJCY0ZTb29PV2hCcHBheSt2?=
 =?utf-8?B?QjRtV3NZa2FpV09RNmNGOGIrM0ZHeTBBMXkrMjBXK1FBTlZpcm16TE0zVE9N?=
 =?utf-8?B?bUVWR09uaUVjT0pzQi9BM0JSZjJURmh1Z28rOFBhSzd0Q2p2dGtha3ZJa0M0?=
 =?utf-8?B?c1ZzN2R4OWI4MkJoRFBoT1IreEZjNUliempyaVJnaEFNY2FJcVZobGFaNWtk?=
 =?utf-8?B?UXRIeGFENG83ZWk2QnBxUGVXNnNsOVM2ZWNhNkN1alZVQ2xMUmxNcGxjc2tL?=
 =?utf-8?B?cWhnN1RFZzVSU0Fta2NpMnpuNHFReS9oazNOa1dhUFovMUUvWEY2L0tGcTBF?=
 =?utf-8?B?MXJjMWErZmJiSEdLT2ZSWXhPZlpWNUY0aEc1MXd3YXQ2bjVyM1lCb0RrNGow?=
 =?utf-8?B?M2c0RHdyNmhsckpxRUc4Y3J0ZlF3eHV0T3pCUzhuTEJCMHZWaHdMMC9nQllI?=
 =?utf-8?B?eHdtTEg5VFZIVUtYOG45OFgxVURFbzlKNHkra29NanpRQ1RCOUsvcjB5d3dQ?=
 =?utf-8?B?eTBMVHIyaWVGcGJDK0RmT1RyZVdBS0ZSMWs3bk05b0ZoenNVL2lENXRscEds?=
 =?utf-8?B?Z0Y1ZTFXWFlSd29OS1FQME1WdTY1UlRrMnVRVlBJQjZSUVFoMnY3TW1WUjFY?=
 =?utf-8?B?dThEL20wWmtLWUxySHlVdndQZzhvV2NkcEN2MmdIVCtyemJhWGlMMFFuWG5j?=
 =?utf-8?B?V2NWMGdVS1NPeWRibTdqOWFJUnNHY1BKY3Q5RlUzVU90YW9BL0JTSWtuelBF?=
 =?utf-8?B?TXYxK1ZOcU8rRFNvRkdFL3V4SStVQzZMcXhRdVZKL1RzTTQ5clBaQ0VES0FL?=
 =?utf-8?B?eFVUb0NkaEg0aWl5MlpxbkhyUXU1MDZidzN3Q2JPUHp1a01IWXByc1ZrZk5D?=
 =?utf-8?Q?aWSYzwqXmy8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXUycjM2aXFoTndWUW5IZFVOVDhaWmpwRlZkMlU3NTZ0d0M1YkZ6d28vakxV?=
 =?utf-8?B?b1RSRmpqQ0xWY0hxSnVITWRqUUpQMlE5SXBtYWVTY0ZCOENZSjJ6Q1piWFlw?=
 =?utf-8?B?ajhWMXJ1dDNpSjlyWS9UUHVRcXZScE5jNlBxajZBbCs2dG0vKzk1WEs1OWIw?=
 =?utf-8?B?TXV6cnZndFZvVlExbXNSTDF4VmtsdjN6Nml5YkJXM0JicWkxMCtWdGlseThK?=
 =?utf-8?B?UmtVNU9qcUJDYjA1VXgrbWcrM0NtSXVVbWF4MVBGMGJoMlhJR1lhaTMwVGtB?=
 =?utf-8?B?dU1jTjc3eWp1dDRHeFRPbGpPYStndWV0YjROT2Y2eWxLdkdZTDRRemNvNmFN?=
 =?utf-8?B?RWJIem5zeUJqR2dxWFA1TDFXYkVaTnJIdmp4MWUzUzlEM3FvOEorVVNxdmdU?=
 =?utf-8?B?c2N5Z0JSRlIxZ1I5TUdmeXBrMUFBR3VNWURYUnlGSi9iNk5Qb2dMMUpvblpS?=
 =?utf-8?B?c2l4emFhK1lYS0JDRVlyOHByTnNXcUtZbDl1NWUyYnJEYUYxbTJ2dnpTVUda?=
 =?utf-8?B?TEhvaXZ3Rk1LMkRmZUxjYWZOeC82RGZUelgrRGE4SUw5S05adzUwTnpFUUIz?=
 =?utf-8?B?aC9tWHZ6UHJTRG9SMzNqdmZ5ZDZZNFdVRkFvaExRYXNXNitzUmZGOGd5VmVP?=
 =?utf-8?B?VW52c3RWR0JjRUYxUlJvV0ZpN3lsN0xmZHNCZFUrYlU5bjFXSnhCOUdzdFNp?=
 =?utf-8?B?eVplVXhKdXAxRHlwdW1FSm94WUlVMlJzSGFCSVMyK2lNVkFQK2gxN1FiMnJX?=
 =?utf-8?B?SElwT1dsTlNpZ1RzWlpMeUFyQktCMFB2eGVEQXVxaEdzWDZkLzNCZnlxR29t?=
 =?utf-8?B?WE1mSFRYV1JIM0RpWW1iRGIvSmp4QTFKUVBMcnV6WTNFV3YyNCtsVmNJUmgx?=
 =?utf-8?B?MWNreHk4d3VQdzl2UDNabFVwRVoxRGpybXFJaDhkajM4M0NzMWhNd3pJTDhX?=
 =?utf-8?B?b2NSelpGbWVhbU1xOERSR2NTRjFqazFTblVJSDNrWExGQkVyRlMyNTZOYmt5?=
 =?utf-8?B?QVVEbWlFQW82RVljQndJU0JqT0Flem5vYVIwRTY0QjM3U0RQQkhwREpjeE1m?=
 =?utf-8?B?aUdEcFAreFFYNktsLzNZMndYOGNqSUVQNFBJVDMzS2t6RUxzRzdzSVIrU0du?=
 =?utf-8?B?ZzE3Zk9lVE40My9laXJUTEdIa0FmbHQ3cjlUckk0Q2lnMEMzSCt1Q1Y5Qy85?=
 =?utf-8?B?Y2ttNTdaNUc5N0pQYnVhMkh6dlowbGN3bDc5NW9YNDR1OVp4TEtzMXBlV1ZQ?=
 =?utf-8?B?K0NCT3Jmc0dBdjRPVGxRNHpuTzY4SW55aWdzRkQrNmt5MUhVRTQrUnI4eU8x?=
 =?utf-8?B?ZjlhYjhURjVyYVdkVzBlRkwwOHMwbkFuZm5YOVFxcWNnOW9XWHRjYkNwaFFx?=
 =?utf-8?B?Nzg2YVlxamRLVzM4elNUM0F5V0NSSzB6clppNVNmeUhkY3JNMitYanlRZ2F4?=
 =?utf-8?B?Tm9qYlhSM2pLcVo3UnZXV09MNWNCL0p6c1ZiYzlPL3hxVS94TEZjcUR1c1ZB?=
 =?utf-8?B?S3NIUVBibVp0eHk0eEhjNkU3OUZ2bDB3WW5va2p2Q01IYnordkxOcHNFYlRR?=
 =?utf-8?B?UlhYcHc3THBHdzBOLzhZNlk4YmtRcDI4dDRGZUJTNzN3dnNDU25rL3VvR1B1?=
 =?utf-8?B?MklndGljTmltcGQ1R05sSFM2UzdISEZjUmhFbENYb0xCYVg3U1Y0TGMyTEMr?=
 =?utf-8?B?dkllR3k5STJ5RGhLY0VIUXhBZDdyMWtEODEwSS9xenJSTVFPVjY4YzVONjBL?=
 =?utf-8?B?bkdEQjBTcWZDYnlkeHNleDh2MFh1ZHZVY0h0a2diSzZOa1pmWGZhczM5VUFK?=
 =?utf-8?B?cmlrbmhlSVhUZ25BRWdGaTgvN1hiU3l2OXNiNmQvZ3JNWXIwdUZBTW9FQlpW?=
 =?utf-8?B?YlpIOW1EMEw1eXY3WXNRcUVHcWI3V2FmMkljWVByU2ZjTXE5YXFnbzI5VHRM?=
 =?utf-8?B?bnhOc0JYZkh0d0lEWkRLNjdtbi95NkNkckdwaHlrWnVyQ3J3Zk1EQXdZKzhB?=
 =?utf-8?B?Si9qUGlFQmlBZEZLUUFVZVRDY2hTVk1yUEtJM243SzVUUllPK0Yxbm9IVUwr?=
 =?utf-8?B?NUlaT0xLMVZtMWphMGxPUTZQanVwb1BYY25sUFVlUHlrcy9WT0tBM0x5WUZM?=
 =?utf-8?Q?uIS8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf24b445-ff66-4e09-7dde-08dcdc01ee27
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 19:00:02.9440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K3NW47eb770KnHLwTIuyilovlLUCrXy7Qj0EEukz0gPk/GIKDPDAJOCR3eBLAQBwc0OoF7QQ9kyGZ+o8iYqooA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9562

Endpoint          Root complex
                             ┌───────┐        ┌─────────┐
               ┌─────┐       │ EP    │        │         │      ┌─────┐
               │     │       │ Ctrl  │        │         │      │ CPU │
               │ DDR │       │       │        │ ┌────┐  │      └──┬──┘
               │     │◄──────┼─ATU ◄─┼────────┼─┤BarN│◄─┼─────────┘
               │     │       │       │        │ └────┘  │ Outbound Transfer
               └─────┘       │       │        │         │
                             │       │        │         │
                             │       │        │         │
                             │       │        │         │ Inbound Transfer
                             │       │        │         │      ┌──▼──┐
              ┌───────┐      │       │        │ ┌───────┼─────►│DDR  │
              │       │ outbound Transfer*    │ │       │      └─────┘
   ┌─────┐    │ Bus   ┼─────►│ ATU  ─┬────────┼─┘       │
   │     │    │ Fabric│Bus   │       │ PCI Addr         │
   │ CPU ├───►│       │Addr  │       │ 0xA000_0000      │
   │     │CPU │       │0x8000_0000   │        │         │
   └─────┘Addr└───────┘      │       │        │         │
          0x7000_0000        └───────┘        └─────────┘

Add `bus_addr_base` to configure the outbound window address for CPU write.
The BUS fabric generally passes the same address to the PCIe EP controller,
but some BUS fabrics convert the address before sending it to the PCIe EP
controller.

Above diagram, CPU write data to outbound windows address 0x7000_0000,
Bus fabric convert it to 0x8000_0000. ATU should use BUS address
0x8000_0000 as input address and convert to PCI address 0xA000_0000.

Previously, `cpu_addr_fixup()` was used to handle address conversion. Now,
the device tree provides this information, preferring a common method.

bus@5f000000 {
	compatible = "simple-bus";
	ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
		 <0x80000000 0x0 0x70000000 0x10000000>;

	pcie-ep@5f010000 {
		reg = <0x5f010000 0x00010000>,
		      <0x80000000 0x10000000>;
		reg-names = "dbi", "addr_space";
		...
	};
	...
};

'ranges' in bus@5f000000 descript how address convert from CPU address
to BUS address.

Use `of_property_read_reg()` to obtain the BUS address and set it to the
ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().

The 1st patch implement above method in dwc common driver.
The 2nd patch update imx6's binding doc to add fsl,imx8q-pcie-ep.
The 3rd patch fix a pci-mx6's a bug
The 4th patch enable pci ep function.

The imx8q's dts is usptreaming, the pcie-ep part is below.

hsio_subsys: bus@5f000000 {
        compatible = "simple-bus";
        #address-cells = <1>;
        #size-cells = <1>;
        /* Only supports up to 32bits DMA, map all possible DDR as inbound ranges */
        dma-ranges = <0x80000000 0 0x80000000 0x80000000>;
        ranges = <0x5f000000 0x0 0x5f000000 0x21000000>,
                 <0x80000000 0x0 0x70000000 0x10000000>;

	pcieb_ep: pcie-ep@5f010000 {
                compatible = "fsl,imx8q-pcie-ep";
                reg = <0x5f010000 0x00010000>,
                      <0x80000000 0x10000000>;
                reg-names = "dbi", "addr_space";
                num-lanes = <1>;
                interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
                interrupt-names = "dma";
                clocks = <&pcieb_lpcg IMX_LPCG_CLK_6>,
                         <&pcieb_lpcg IMX_LPCG_CLK_4>,
                         <&pcieb_lpcg IMX_LPCG_CLK_5>;
                clock-names = "dbi", "mstr", "slv";
                power-domains = <&pd IMX_SC_R_PCIE_B>;
                fsl,max-link-speed = <3>;
                num-ib-windows = <6>;
                num-ob-windows = <6>;
        };
};

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- Totally rewrite with difference method. 'range' should in bus node
instead pcie-ep node because address convert happen at bus fabric. Needn't
add 'range' property at pci-ep node.
- Link to v1: https://lore.kernel.org/r/20240919-pcie_ep_range-v1-0-b3e9d62780b7@nxp.com

---
Frank Li (4):
      PCI: dwc: ep: Add bus_addr_base for outbound window
      dt-bindings: PCI: fsl,imx6q-pcie-ep: Add compatible string fsl,imx8q-pcie-ep
      PCI: imx6: Pass correct sub mode when calling phy_set_mode_ext()
      PCI: imx6: Add i.MX8Q PCIe Endpoint (EP) support

 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 +++++++++++++++++++++-
 drivers/pci/controller/dwc/pci-imx6.c              | 24 +++++++++++++-
 drivers/pci/controller/dwc/pcie-designware-ep.c    | 12 ++++++-
 drivers/pci/controller/dwc/pcie-designware.h       |  1 +
 4 files changed, 72 insertions(+), 3 deletions(-)
---
base-commit: 4ed76e3b7438dd6e3d9b11d6a4cb853a350ec407
change-id: 20240918-pcie_ep_range-4c5c5e300e19

Best regards,
---
Frank Li <Frank.Li@nxp.com>


