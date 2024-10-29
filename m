Return-Path: <linux-pci+bounces-15545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227FD9B4F7A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 17:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EAE1F21DC8
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4051CC17A;
	Tue, 29 Oct 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Nd2zkdWd"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2078.outbound.protection.outlook.com [40.107.22.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25C1D86E8;
	Tue, 29 Oct 2024 16:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219822; cv=fail; b=mnjWjHdxsE4kxgapevqwMFEcq8xtaEtGwhq0Y79Q0mogTqgH49jT6PKW+xOZiGwF3qc++3y093PDlOkiZ9AUs0dXs8rJ6l9GMDfPzZvKdiPFnKum4NPxz6PnzA+LkEq3mAqvScORetwd5LrwR1+Rg51xpqXsCtSYGr6l7R5h5kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219822; c=relaxed/simple;
	bh=iJ6/KG8KKdayrGbVtcslMDA3WnqF1vdb/oRmxj7ytWo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OiT/VMdVnOkM3lv25eiwDUOOc+wVD4AZpSVIB0viIEqLYWj/k8sBY+lKFnQFktFvuy5HuA1x/0QbYIRG56AfjSeKSA7jxYCJ2NkzAGL8dN0/hUYBCwwc8YExWPqgP2fGE0r186svflmiMUBov67lzrV8wUlwFowVKfImksWOnCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Nd2zkdWd; arc=fail smtp.client-ip=40.107.22.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=no2EibCM2q/PwFQZnjfCZ3uyDf6xmybAfevqnKeTxodDeUtfrffCAs3wZvCz2K/HH16tb7Un+Co8awAt/8R22JHQTh6FDKUrCTpbEA9dC/jym4Pgt21cxu2DEYun/pbidRYWuv3JoP4kGMnRN2BwN+mxEcutMRiJtrbJUHTGfHVuquC6//63KQ7I1zZ4L4M5NWy7v1OUuMbE1DOgdMzS7fj/AhWcBtIqIKI+XgtfBuW8SZlunv1VqsD7CKsZICI35hMP4Ix3Hwfxm6mhqH37ytACzMsQabtFu1BoRkXJFyRFMwkr2WY4AAxd+4J66hVXxFsWQtYLbsLoltyhm8ry6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/VhIsVSTv0d5u3ZhfKuu8Af1yUZKW5mR3qA1hzH6eg=;
 b=WPRJyaZUmUorQXf2OnX1OyD6XK6Mvne36sZzhlij18w16epGGn+NHfA+BKVeIJzN5sD6hjnhJGe+d6TglFWI1UlRGOzp6+LOtDUbhWpoGVpvt0d57AzFF0m55iG4RkbNGLTOSvHWbE90iFkg2KKa2j+ZIEE4JMtiT/F/s+p7Gxz6WIXa2CyQPMMCvv9/Z/8CKGZkdgEEowjX4VlHV5sSCuU5fnBo/x+LmwowE/VATj1XBX0pcZLLLFkErhwPpE94793kbn1UYghn4BkqV39D8byOHR4b8u+UDJxCK2eGRcAznlq3q4UI9Ja0R1aqpTbRb3Mdv4RoUl2Wwb+iIOqlQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/VhIsVSTv0d5u3ZhfKuu8Af1yUZKW5mR3qA1hzH6eg=;
 b=Nd2zkdWdRTuQGfjT+aW3/ESI+sIPPEkLzBwsYc1BL/aNkozNm6FocIHJj4rz7EkAo9MiW6ejMMwjp+PICGnMqYpyFBXluZmzAQeoUZCzPa3Klm0ylvFhZg/gevB0M+B9VS8PyKJJBQ34h419XitOndcNgpKq+ZOtR0a7NCRz9AQz+V2lXOF7JifB4oQmwOLVJM5LKXJ9/CDj/+KC2hz0eSoL0SGBC8u+WZMYdvRpUefIgp4cxJSmeJoXj60u841/8StdfOXnN47GhS327Y4poLNTHMe7/IM+udHco8Z4CBsfFD2zAVc6lr/LblYx3zMTAy13B3tgtD9K+UT2XwmZuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7577.eurprd04.prod.outlook.com (2603:10a6:10:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:36:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 16:36:58 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 29 Oct 2024 12:36:35 -0400
Subject: [PATCH v7 2/7] PCI: dwc: Using parent_bus_addr in of_range to
 eliminate cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241029-pci_fixup_addr-v7-2-8310dc24fb7c@nxp.com>
References: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
In-Reply-To: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730219803; l=7546;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=iJ6/KG8KKdayrGbVtcslMDA3WnqF1vdb/oRmxj7ytWo=;
 b=/jyC1OwyX6tQ2kmRI4ZCCYPxvzLkz0MGYm4a0Brx5F1Kkn8GhdcAtbdlD06qrkdD0LTIsD2uo
 OBcTNM26FD1BCYGNjWDZyfWNRxIg2plSPnneyymPTKZvICtRsXJwVDO
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:180::48) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 85cc176b-3eb8-4586-3f14-08dcf837e7bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXgwbzI4WXdxS2FDNFhTc2pDbUY2ZkJmQkJxeHk2ZWxKZ2tIYnlUNlFuUXZs?=
 =?utf-8?B?dE9hLzRscU9yWWdmbHVVdmpoWkJZb3lvQ0hDRWRpZFF6cDA5dU1rVTcrdnZN?=
 =?utf-8?B?YWFWZGNKRU5MUHZBRXJIdk5hRFhjYTAxWFpjUzk3elJRL3lKN2IyQWFTSE9E?=
 =?utf-8?B?amp6M1pJV0hGVStRWWd0L1d2anhpVlFFMkhsbExqZ25TRVN3RnZmeUxBM0ZK?=
 =?utf-8?B?ajNEVjVZNmw2ZloxeGFSZGV6NFBpMzVDNDBqaUtFSHdzVE1JSHJwSGJKNFJV?=
 =?utf-8?B?eWs4b3dYU2tPK1dOQkg4V3lJVmNZQ0pNNkc0eVJHM0xtVmJ4SUdqaVplN2h2?=
 =?utf-8?B?YnpVVmJuS0ZXcVBoS3Y2Y3BXWjFpS01rbFdsRHpqNGh3V3gyYUZFTHBiRGY0?=
 =?utf-8?B?WE9UZHowaXBYa0YxRHorNUdIY0cwRWRPMm9yT0JxaGZlekpPSEtOMUZjTGtU?=
 =?utf-8?B?V2RSTGZwS0lGazdaMnlhQVlIUE5GTFN2eHNBQnFsczJ2eEpkYThML2d1M1lV?=
 =?utf-8?B?UGNPN1NZd2dqUkFhanZjL3JCN1JUZW13aHc5cHVZT2d1V0RDTk8rREdDU2dx?=
 =?utf-8?B?aE9zUGxOSEt5N2tyQ2ZxTFJFek1LWVFDNy9oWkVrVHAybW1kNjBybTBDMUQ0?=
 =?utf-8?B?L3JjTkFaQTVZU0p2d1dpaEZMWWF3cUViTEVYYTA2bGhtZnUzVGhaakViR2cr?=
 =?utf-8?B?a29VMGtkdHduaTZoNTFTaWp6Wm5LNE5NMExyTENPY2lRZXppR255TUZRdEg2?=
 =?utf-8?B?cTJYbnZwUGw5T1Q2cnpGQlRIWmNQOCtaMWxhaWpMWmN2OUJ5U3JVNTZnSzlz?=
 =?utf-8?B?bjJDUjhwcFNJazB5UkVYeldES1RWaUpEU00xb1B5NWxSeVU4QW1OZlB5bXlX?=
 =?utf-8?B?UmpWTE4yd0FCbmJBVU9MVkpQY1FFbnk5aEZSdnFmcjNmdC95VkIxa3ZZY2J4?=
 =?utf-8?B?SnNmSm5yYU01NnZSQ1MvaWlvcEhXTkpFaXAzS3czOC83VUhDZlRzUkNwRWt1?=
 =?utf-8?B?L3pJSU84bFNtaXVSK1Y4N1M5VFFzWHJpb3gzRmRHWXk1Qk5SbEVzY3NBNEVR?=
 =?utf-8?B?SFlUVXRNU2N0c2tVSk9tTFlJT3JhZGlaazFIRFRnM1djaUlnaXYzd0tNRHZm?=
 =?utf-8?B?V1dTaEIwb2xmY2ttTlRvdHhVbWFrdGZEUkZFRVVrVFVHYXVQbUFIbVdZaGlN?=
 =?utf-8?B?ditVdDg0TUdsS1lhanhIckd5Ly9iTG96L3ZNcm1CNDl1MTl1cnU0U2VINkJx?=
 =?utf-8?B?bGV2bzJDYWZndjhTRHk3UmV3SWRZemtSRnMwUTlZNkxHMnBtdWNSS3ZDTDI3?=
 =?utf-8?B?c2RJV3ZEbklMeDNHLytlV1A5N2tqN1FGNzluZUxNaE9wV3dHS3VlVnE5WUtE?=
 =?utf-8?B?a29OM1ZWRG95YjVlbTZIUGgwR0RJUzg1WnVObURhOC9BRk9QVDNBd3pLNzJH?=
 =?utf-8?B?VjQ1WnVocWFxbnh3Sm93b3lpR2M2ekFmVEF5VUJUK1duRDFPVmFnaWVUNVJZ?=
 =?utf-8?B?aFVOQnFaZkVmc3plZmdtS211emROTVdFL2FoTjJYZXVGcXBPeFZiQ0hoWmRM?=
 =?utf-8?B?ODhmRGIyblRaMDFWM1RUbkVTYzJySTVrSzlicXZ3YU9MdFhnMkpEby9GQmo4?=
 =?utf-8?B?OFByQlZuSkhRbEpBWWNnY2hMaldJTEtUbzJHaGFHbTdqeFZla1RjMm9XU1Zr?=
 =?utf-8?B?SnN5Qk1NVjF2aTN0bEo1VlByTVhVVUJPS1I2NERoRnM3ZXVMZnlwTGJTYmJM?=
 =?utf-8?B?aEIyMVFqeFFicEJnMTdjU0FFRGpaaHJ0WEpjRElLRWlMcHlpSm9panlONU9T?=
 =?utf-8?B?WnNNcmFjbEJqd3I0RlRNKzBiZW8vK1FUNHVMeURmc1NMRTNtTmhkcXBybEty?=
 =?utf-8?Q?ZV2RmrKP2RFn9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDlLSmdSUXJxL2xGRDlnY3dSc3pWejFieE5tS01TZzVOL0JFbW9lMHQza1RS?=
 =?utf-8?B?QWtSODdhV1VvQTk3VTRjQmV1ZE1Yck1EYnhCVWRFVTdUOC9VVDRBbnpaeXRz?=
 =?utf-8?B?SDVtQVJDMGZHVnZRL0Z6MUZ6YzRYU0Nxam9Uc3NScDh0MEZzRTNZajByVFAx?=
 =?utf-8?B?ajJGUkZTV0ZjR0dZTXFtVkxHY0R1MlVoNjZTSHlYK09BY1JHOFBqMDVJWUVJ?=
 =?utf-8?B?aG1wYVl5WjNQSzcyNkxvOXhCbUc3NkUzRHNNQndPS0JKYy9BTENEeVNGTnFG?=
 =?utf-8?B?WEdJRDBjNS9SQ252NGgvTitYbWhjRmFsUlVBVjNYek9lcUNEaEQzN3NmNlI2?=
 =?utf-8?B?cU1nb0hXQ01MNnd5eXU2NktBc0hxUTJxb0tXQ1hSMHZGUU92UlE0UHVEVExk?=
 =?utf-8?B?Qmg1NzFXdmJaV3pQL3A5K2dVdnF1am43bEZGNzZ2WXZtZUh0VWI3MDlKVHVV?=
 =?utf-8?B?MkNKc2tnd0dXNGl0QzNoRmpwODJoK2ljdW91YS9sQ1NVOS94K2creGFuWklR?=
 =?utf-8?B?WVlySVhGU3E1YlVvMm9QTyt6T3B6NFdyeDFiWW83VVFrRXk1d21WblRXOXlz?=
 =?utf-8?B?S1l1bDZ5TmxmSkNDbUY1MmRIclVHQTlYVUkrN1h4cEgrcFFkenZFSzdOWTYw?=
 =?utf-8?B?bHpORUwzc3A1MzN4Q2VoS3g3S0lRYU5lZnFaVDRzRGd0em82WEZrdHZtdTFP?=
 =?utf-8?B?RVhLdGhEQmpLa1Bpc3g1eEtoRDF1V2FKOUFxb202RjdUdkpTY0ptbnQ0dUVu?=
 =?utf-8?B?azR6aVZKZW50VGQvenRtbDJWT3l4UHYrMjJkNWN3cENFSFJrRkZ4TVRmamVP?=
 =?utf-8?B?KzRlOExabmFtVGhFQWF5UWlMdXQxVmk0ZkFrdkpLdW9zNW8ycVBWcDZmY1Mv?=
 =?utf-8?B?eFp6d3cyaFkvK1BmQ09CR0NWNUtIN3ZKMk5LcVhqUDExOG5JMVBNeDdhb3pQ?=
 =?utf-8?B?Y01rMXlMUTJKMERqbFE2cGZCdUhFSGRqK2xIbkNNYVVlMUs2ZkxJMi9oMVdY?=
 =?utf-8?B?SjRWZWZjUHJTeHozVkVwdDgvY3h0VTc0eUh2L0IvaEVseVNCN3NhM1A2Rmpr?=
 =?utf-8?B?Zm1aM3g0clduRkRQWWFzZ1A2Z1JKdlZLaU85cG4vQ2tLcTJlTW9aUVhNTUk1?=
 =?utf-8?B?bURLR0F0VjJoZWY4WVhGdC9NeDVmak1FSUVBM2doSlpmblM2b3d5d29Wek54?=
 =?utf-8?B?S3VoTE1CMVYzYzZ0ZmF2bnZIbm9Vc1BIT29GTGdvcWF5NUk1Rk1hK0I3U3pp?=
 =?utf-8?B?aTZZdm5OSFlBMUZwWGxSc0ZDYVphb09GNHJ3OW83K3RKMmQvdWkxRmNPbXEy?=
 =?utf-8?B?d1hSRStmaC91dUlvMXMxZXZvMmZGeWsxY2UwWWtzMk5UTWp3eTZwSDJQOEN2?=
 =?utf-8?B?L0JwL2lqbTBucitDbHpOcVgxaXVWWmRFUlJYMjV1RUkwR3diYVljak8xTnB6?=
 =?utf-8?B?Qm9oM1M5YTE0SVhDSUtHcnM5MzFIUEllYVFSeVgwZHRKcHIwUEhwNUgxeUNn?=
 =?utf-8?B?NnZmNjVlOVRnT1NUb1pQb2VlZ3BkSmUrUUNUOVZwWXZ6SXZRbExBcG8relVY?=
 =?utf-8?B?TXZCay9zeXI3RnNxTzFaOVdCbkVOQTlvTFJ4c0RNclBMQWdpVENGemM4VGZV?=
 =?utf-8?B?dzM3VENHZStZekNiNHpFcCtCdnc3QzVRMWtMdWVaQmFXSTM5cnlmb3hjRHNR?=
 =?utf-8?B?WU5RSmVBVE51UWphOTRMdGVjRFpYLzlRNEJTWEFMZW90Mm9PM3BtOFlESEFU?=
 =?utf-8?B?U2E1azJQWjhZOTBLcDZheG1VZ1ZRTk9EMGpVdmZEdk9GMDAybXdCa3Q0YVk4?=
 =?utf-8?B?YXpQT2hQQ2RlN2NyYWl0cmRpZ1g0WDVzdnN2ZHRGb1hGRFhJcTV3aG90dnVP?=
 =?utf-8?B?NW9rTzVvbldXR0VWREhCMWZKYk9MRldXVkJSNGd3Wk9TcjZ4d0Rvb1RYeDVs?=
 =?utf-8?B?ZExYY2JPcDFzc3E2OEhySk5hQW1meUJpbVdvVit2V3d0cEs4Qk9GdWJld2pj?=
 =?utf-8?B?SGZLU1Q1RENkdW44UUFsaXhDOUY0elQ5aUVKL1JnVjl0RXlSaDA5VW5oSys2?=
 =?utf-8?B?dmRicElqeXMxa0tpV2w5QU5WYklNSHV4VzhxMGpMbzNvL0o0KzFEQmxtSTJ2?=
 =?utf-8?Q?5eOREN5n+x4/IRWIVMhanDGA8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cc176b-3eb8-4586-3f14-08dcf837e7bd
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:36:57.8597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6DYc4LQEd0Bs4wItpa5YksZoJgZ/d708Zgq7udOL247gdwDdiWb9sBuKa4q5o/94gdmnH8sMMCVBXohcgUkG/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7577

parent_bus_addr in struct of_range can indicate address information just
ahead of PCIe controller. Most system's bus fabric use 1:1 map between
input and output address. but some hardware like i.MX8QXP doesn't use 1:1
map. See below diagram:

            ┌─────────┐                    ┌────────────┐
 ┌─────┐    │         │ IA: 0x8ff8_0000    │            │
 │ CPU ├───►│   ┌────►├─────────────────┐  │ PCI        │
 └─────┘    │   │     │ IA: 0x8ff0_0000 │  │            │
  CPU Addr  │   │  ┌─►├─────────────┐   │  │ Controller │
0x7ff8_0000─┼───┘  │  │             │   │  │            │
            │      │  │             │   │  │            │   PCI Addr
0x7ff0_0000─┼──────┘  │             │   └──► IOSpace   ─┼────────────►
            │         │             │      │            │    0
0x7000_0000─┼────────►├─────────┐   │      │            │
            └─────────┘         │   └──────► CfgSpace  ─┼────────────►
             BUS Fabric         │          │            │    0
                                │          │            │
                                └──────────► MemSpace  ─┼────────────►
                        IA: 0x8000_0000    │            │  0x8000_0000
                                           └────────────┘

bus@5f000000 {
	compatible = "simple-bus";
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0x80000000 0x0 0x70000000 0x10000000>;

	pcie@5f010000 {
		compatible = "fsl,imx8q-pcie";
		reg = <0x5f010000 0x10000>, <0x8ff00000 0x80000>;
		reg-names = "dbi", "config";
		#address-cells = <3>;
		#size-cells = <2>;
		device_type = "pci";
		bus-range = <0x00 0xff>;
		ranges = <0x81000000 0 0x00000000 0x8ff80000 0 0x00010000>,
			 <0x82000000 0 0x80000000 0x80000000 0 0x0ff00000>;
	...
	};
};

Term internal address (IA) here means the address just before PCIe
controller. After ATU use this IA instead CPU address, cpu_addr_fixup() can
be removed.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Add a resource_size_t parent_bus_addr local varible to fix 32bit build
error.
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410291546.kvgEWJv7-lkp@intel.com/

Chagne from v5 to v6
-add comments for of_property_read_reg().

Change from v4 to v5
- remove confused 0x5f00_0000 range in sample dts.
- reorder address at above diagram.

Change from v3 to v4
- none

Change from v2 to v3
- %s/cpu_untranslate_addr/parent_bus_addr/g
- update diagram.
- improve commit message.

Change from v1 to v2
- update because patch1 change get untranslate address method.
- add using_dtbus_info in case break back compatibility for exited platform.
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 55 ++++++++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h      |  8 ++++
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e41865c72904..ea01b7bda0a76 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -418,6 +418,34 @@ static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 	}
 }
 
+static int dw_pcie_get_untranslate_addr(struct dw_pcie *pci, resource_size_t pci_addr,
+					resource_size_t *i_addr)
+{
+	struct device *dev = pci->dev;
+	struct device_node *np = dev->of_node;
+	struct of_range_parser parser;
+	struct of_range range;
+	int ret;
+
+	if (!pci->using_dtbus_info) {
+		*i_addr = pci_addr;
+		return 0;
+	}
+
+	ret = of_range_parser_init(&parser, np);
+	if (ret)
+		return ret;
+
+	for_each_of_pci_range(&parser, &range) {
+		if (pci_addr == range.bus_addr) {
+			*i_addr = range.parent_bus_addr;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 int dw_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -427,6 +455,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	struct resource_entry *win;
 	struct pci_host_bridge *bridge;
 	struct resource *res;
+	int index;
 	int ret;
 
 	raw_spin_lock_init(&pp->lock);
@@ -440,6 +469,20 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->cfg0_size = resource_size(res);
 		pp->cfg0_base = res->start;
 
+		if (pci->using_dtbus_info) {
+			index = of_property_match_string(np, "reg-names", "config");
+			if (index < 0)
+				return -EINVAL;
+			/*
+			 * Retrieve the parent bus address of PCI config space.
+			 * If the parent bus ranges in the device tree provide
+			 * the correct address conversion information, set
+			 * 'using_dtbus_info' to true, The 'cpu_addr_fixup()'
+			 * can be eliminated.
+			 */
+			of_property_read_reg(np, index, &pp->cfg0_base, NULL);
+		}
+
 		pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
 		if (IS_ERR(pp->va_cfg0_base))
 			return PTR_ERR(pp->va_cfg0_base);
@@ -462,6 +505,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 		pp->io_base = pci_pio_to_address(win->res->start);
 	}
 
+	if (dw_pcie_get_untranslate_addr(pci, pp->io_bus_addr, &pp->io_base))
+		return -ENODEV;
+
 	/* Set default bus ops */
 	bridge->ops = &dw_pcie_ops;
 	bridge->child_ops = &dw_child_pcie_ops;
@@ -722,6 +768,8 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 	i = 0;
 	resource_list_for_each_entry(entry, &pp->bridge->windows) {
+		resource_size_t parent_bus_addr;
+
 		if (resource_type(entry->res) != IORESOURCE_MEM)
 			continue;
 
@@ -730,9 +778,14 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 
 		atu.index = i;
 		atu.type = PCIE_ATU_TYPE_MEM;
-		atu.cpu_addr = entry->res->start;
+		parent_bus_addr = entry->res->start;
 		atu.pci_addr = entry->res->start - entry->offset;
 
+		if (dw_pcie_get_untranslate_addr(pci, entry->res->start, &parent_bus_addr))
+			return -EINVAL;
+
+		atu.cpu_addr = parent_bus_addr;
+
 		/* Adjust iATU size if MSG TLP region was allocated before */
 		if (pp->msg_res && pp->msg_res->parent == entry->res)
 			atu.size = resource_size(entry->res) -
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35aa..f8067393ad35a 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -463,6 +463,14 @@ struct dw_pcie {
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
 	bool			suspended;
+	/*
+	 * Use device tree 'ranges' property of bus node instead using
+	 * cpu_addr_fixup(). Some old platform dts 'ranges' in bus node may not
+	 * reflect real hardware's behavior. In case break these platform back
+	 * compatibility, add below flags. Set it true if dts already correct
+	 * indicate bus fabric address convert.
+	 */
+	bool			using_dtbus_info;
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)

-- 
2.34.1


