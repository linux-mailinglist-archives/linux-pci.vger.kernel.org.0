Return-Path: <linux-pci+bounces-16969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B129CFF49
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 15:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072672820BF
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 14:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3E017543;
	Sat, 16 Nov 2024 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SaVTuKzk"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013052.outbound.protection.outlook.com [52.101.67.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EA115E88;
	Sat, 16 Nov 2024 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731768068; cv=fail; b=dTQOHT91vsxEMRHsdA9Fh9gxJZ5yiyKfbIsdloEAuQDeqXboov5wRJYRpql0pogbnG68WuGU4xuujSL3rDI3Af4V+npHLfFp9fjCEO9LJyefSM2SEvfJlxtrw+h57XikRI73FPpB9/ZugXqOKDpYsjUsJcjD3IawTTcFaxKQ0JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731768068; c=relaxed/simple;
	bh=yquequOPIQiT6wZB6qhSoTflK/T87agYnvYLNWlTFQM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=hUn3aPPuU2bCncIKyj0/o6ScJ2tiZAdvZexdT7L3PuZTaNcwTKA09EF//4VM2aevLGoeGr0Kh49BLdikYf4SdVmWh0q2rJfe2MahvrrNOY6MR0cWS1qrHFbrkeADFLdfUsdP5PxV8wwjXigbCem902zO/QAjBYv9hPJvRCTDxoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SaVTuKzk; arc=fail smtp.client-ip=52.101.67.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=No3X6IsVduHkt32Xqe+DXlCFtHvWBlfOBR8AzNxdNhXgaTVV2GXJOyEVxa/fRccseS2e0f3vZ68XH7o3sYsLmZQsAipE8YmFcDq2pGroOU0ke/GElxmOG4Yq0soCJXfGwAYHrRQ5IioZkGAe/SQA3jZSs4m5B9gN+hjrNUk9PPvI3NYLa7BE0IxkvefgNAmqXI5FPCOBq70FoB/zFm8mWLxYD6OYlUZtuuLP1PXe7F7MgmFBH8fyEXZ9mj6vIHdD6E9aqnnwsoqn42X5NraZEQzTLmmJyWtaPMQJ80xLXHbcCad6GGOfMAMejbyKzngQ3pcPJmsu9Obx3TEY7rg34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWKDVRAZ+KU4/SVDF3SlXfqMf4fm1awq9iKWr/YrbrU=;
 b=a8kw+F+1ZrhoAiftz/Hw0OPl0rsTDS/Jc5+8CY0b6lQcwzArvuXKUqZYDaiwcliHCZKqBHMEkww7A7GdyOweeMhNm72Cf5r2/tQGkEJa1iY6OAScrLavWDREWfP19rd+HLgdQXfTyE0X0pQ8fJ/dB1X6xms9YHvivIAauemjYUuBWRWpFjyBPqulpUEfnajWw2kg71A9STRjK207cQdpmlVGIp5ZE1eTrSAmIfaJOcEAJDG/4f5PUMxlKKxmViMoVFF940koUvFE8edfPGyVg4I14gdOnmHBzWo7e0Gt4KsN56N7P78HpAM1G/KYvyt5fv1JIMwBtYuvKbkb94HZ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWKDVRAZ+KU4/SVDF3SlXfqMf4fm1awq9iKWr/YrbrU=;
 b=SaVTuKzk7289dNmowJ3aaN+rGgnwHOw35Vnu3E1UnAc8St4xpZcw4MqUQR6Z4Gyp+mflrLG06JGcwOxDRLirrlLkxmeDdzClWvl6UQdSxVUv5diBptRVgGM2oDzob/9aTDj8xXg5awxMWcb0WVHYKYbi6Yt8uF/0OnPZtZFOWlixy/RrpoHjdvKFh56hSo+o8mxuyi4ba+41Hq8mLBAUsUChUCdyHxOmYU7SNJLFNO6MIdKk7+ssgN+baEk6rLvuuW8KjQXLJBbFLWMk3hjz8zAUXZW10ocx/d0J/32bx+y7NuAWfjoCu1FhpjU1Nu2cen1/rTkou9fKDKKRnrmmSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7265.eurprd04.prod.outlook.com (2603:10a6:20b:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.21; Sat, 16 Nov
 2024 14:41:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8158.017; Sat, 16 Nov 2024
 14:41:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v8 0/6] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Date: Sat, 16 Nov 2024 09:40:40 -0500
Message-Id: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOiuOGcC/13OQW7DIBCF4atErEvFDGAgq96j6gKGccMitmUqK
 1Xku5dEiuN0+UZ8v7iKynPhKo6Hq5h5KbWMQxv+7SDoFIdvliW3LVChAQVK8iTPtUifDMWkdYL
 Eoj2eZu7L5R76/Gr7VOrPOP/eu4u+XR8J+0gsWipJnMmHCB1B/Bgu0zuNZ3ELLGaHNGzINOTA5
 Yg5hIT+FdknAuU3ZBuKYIIFUlkp94q6HQLcUNeQsX1wiKwJ/33P7ZHZkGsom0guxj5lpCda1/U
 PktqD4W4BAAA=
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, tglx@linutronix.de, jdmason@kudzu.us, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731768057; l=6926;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=yquequOPIQiT6wZB6qhSoTflK/T87agYnvYLNWlTFQM=;
 b=QtDknoF/JUY7Wd4engzEBugHvy1P7YBFbWgNouZL+wFL2NuRC1wG/mXtoYTyXr4oswoWfCcok
 UOfm5+NvxDoAgO6+xFeEx9NfOepIOgJdHcCkqrkauL7Yp9PaKcTLaju
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0210.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7265:EE_
X-MS-Office365-Filtering-Correlation-Id: 48cb12e5-8b80-4cda-fbc3-08dd064cb0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFM0MnpER0dqMDZaSmtaMWFyQm00RzU3bHJDKzh3UUJ4VDUwZHNtVzY5Y1Uz?=
 =?utf-8?B?K2VBZDJYbTdKV2pKS00yNzYyS3hLMUsxWEorR3k5dkxBWEFLVXJPWjd0dzRB?=
 =?utf-8?B?c0I0R1hsa1dRUmJSV3dueFNCL3Z4ZEVFektvZXVGWk5JdmVEZVF2ZjdOa0p0?=
 =?utf-8?B?bjF5WmRPekhIcnpPVnZVSDlxSTU1WXFjcVoxdWNQR3padXlHTXB5aXpNcFlI?=
 =?utf-8?B?WHNQNXhrYjdnZldhYlZVUEE5VnVRTkRjSHZpRG5lQUg0QlBYdmJvMDh1ZmZ4?=
 =?utf-8?B?SDd1Vyt4N043U2VmbzNLcEdtcnNUUDRCZURkR3VyM3NUMjN0UkVLcnpkNmJW?=
 =?utf-8?B?bXJWYmo1amwwaE83VTBBaTByQ090VVJGMExRTlYwOHdBZjNObEZGQlhBUU40?=
 =?utf-8?B?UzlPaENOa1pmTXhSeEdLbUZRZExDNUxyczk4VHF1d3B2Qm9meCtVakZqYzRW?=
 =?utf-8?B?YnhBM1QwNnVlWGFFOGwxNGd4S0ZNaE1WTCtBbWtNQnNHTUNBNzh2Y2tvaktx?=
 =?utf-8?B?Y2E1U0pEL2N2VTJhdUgzclRoRHFKeThPUVZZeXdNWFR6MnhCMTZCUXNtTWJx?=
 =?utf-8?B?eXJ2T0Q5elE2eTdkSUFTUG81MXVOakZGT2RwM1NrOGVzV3JVL0w5VU1BclNZ?=
 =?utf-8?B?eldBY0I2TnljVlM3NXJKQkJRMkZMbzFZcTRGazRncEZKdjV6V3h2d3hWUDBo?=
 =?utf-8?B?VDFabFZTM2ZSd2RTTHU2V3loMk91VUNzY0xJUjVRYWRIaWQvelhEYXU5Yzh2?=
 =?utf-8?B?SXNzNzRzdlIxWU1zakVRV09QOXE0R2dkV3NVM0JHUHNzditWR1dndXRqOEw0?=
 =?utf-8?B?dHgxTnVublpXWVFNM0Y0TktkZmpJeFNsVmZDRTVid2d2MGRIR1ZsUnRSVGRY?=
 =?utf-8?B?NHFKa21WR0c4RlVmSmNXK2dWTzFtK0tiRk9wVW9pL1ZkVTVsaVZZMmFTQk80?=
 =?utf-8?B?R1I2UkpkQ3F1dXczcDBQOW93ZHlpRE9VVWVjNVJ6cEZnaUV1VGhWZHY0c3Vw?=
 =?utf-8?B?Umdza2lVZmprd1ZvYVdiQlQ3MGh4OWFMVVk4TnRnS0NOckVZQ01oZEVlV1N2?=
 =?utf-8?B?MUZpeUV1MTByc2ZmZUl1TnNVbis4YUwyNlFLS0IvWC9GUHZGVVpIam1iTHov?=
 =?utf-8?B?V0UxbGwycENNZUV4cWZTcDVkdHNadk5aOWpOUDdLOWtmTGJWZ05YaTNBdkEy?=
 =?utf-8?B?b00xdS9pQVdBNi9Ebk1ENlRVZWtQMTl0SFVnOHhISEM4cjNXTlA1aUZyU0pH?=
 =?utf-8?B?MENaNG1yZHBJU0RBeitCRlNnTFJmYWNGeUdyRGovUUFDcWd5NitNeUlRTTVk?=
 =?utf-8?B?M3Jid2puSUM0MlBZRmh4cEZiZTRhZFlRbENSZGlkNC9iVE9yVU16eUZtckVs?=
 =?utf-8?B?blBhQTl5djNrWDFHV0lwVlFlbHpxMHV3dEI5L3VpdUtQei9MdW4yTmJWQlhP?=
 =?utf-8?B?LzdhczFRaUc0VnZIOUJuMy9MM1kzRU1jdDloQjNTbXZURWV2T0hmZHFsellY?=
 =?utf-8?B?MWpVZWduMFZwWDRHWVdXUUpBaGh1eUZzc205cFZqUGZRei9PR2Z1OHdWOUox?=
 =?utf-8?B?VXlHTFQ3SnZpRzZwRi9RUEpINjZwUW5EMUhQMmFxM0tTYkpGZWxVc1drL3M0?=
 =?utf-8?B?aE9ReE11ZnNNS0NuTlNlMkI3ZFdUSElESVIyQklSb0FYcitVRXN2VCtFV2l5?=
 =?utf-8?B?cVhEbGVkTXh0MzVSRURDdEdyZnJTOWZBUDdBbTFKT29VeTVrcG0xNlVOZUI1?=
 =?utf-8?B?NWtsRDRkdDkxMStXUTJIYzVkZ3VSeXNmT2xKT0VzaHZINE9sdkVoSnpYb1VJ?=
 =?utf-8?B?YWw1UzRXTWd6TTE0VnFWT0dQdVo5U2MwK1hZelpmaTN5UTZWMGpLRkhBUXZG?=
 =?utf-8?Q?EwwFj8Rdrji9U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUxkamQ4TEtUelc3QWdiN01BaVVKaU8yL3c4SlIxOEEwZzAwRjhyUHdHemht?=
 =?utf-8?B?UndzaUxjTHNLV3FodDM3OXU5eHhJemRSWlpNalFiRFNJZ3pyQjRPQlA0bUkx?=
 =?utf-8?B?eXh5WS9GbkpIUXBUSGFYUDdEdGE5VXpsVzBCMTU1RTRveUNtZEhoS3BYeXNQ?=
 =?utf-8?B?d1FWdEd6RnJaRTdsWTl2N0JiZjVHUWVTTEdoMjdJMExuMVloNk1YVTFPY08x?=
 =?utf-8?B?a2E5eXVkdmU4MEIyWHdYY3M3dXcvSlFLMEhMbGdDQTk5bklqaXdPM0FZZkFk?=
 =?utf-8?B?YTl4QkFiUlRjSnFOdTg1OHcyczZJK0FMSksyYkxQRUZFd3ovZzhyUjN2TXk2?=
 =?utf-8?B?VFlKZ1dhaEE5aXRsRjg0VDM4ZUZzOGl3OGxRNnNRaE5pVEdvMFI0RytxTXIx?=
 =?utf-8?B?NXdhOXo4S2JvZWJQRUJjWk1zWTEvbVRrYTVMcmxSWGQ2eUhoWVdFSm5VZHRj?=
 =?utf-8?B?VVp3V3g5UEZzd3BkMHRYSVRQcnRQNHdwYUZRQXd0T0U5Y3ZqVm5zVDcrR1U1?=
 =?utf-8?B?QUZCd0R3WlhkUWJzb2E2T2k3cjU3Wm9CdFBYTEtLODRDV3NYKzg0OVlvTVhy?=
 =?utf-8?B?a2dPcVVlUkpCTTdoMGRidmVEMS9GNk91QWhMWWZDQm9BMXloRTY4cEQweXgz?=
 =?utf-8?B?S3FaWkVTVjAvZ0Npa2x4N2Z6QWxWWHBMSTdMOEo2MHoyYW5pWTl0QjNwZENo?=
 =?utf-8?B?enVnVmQybFlpUkRDUitHL20xNEo4ZVlXZjc5ays4cXkvcERjQkZBOVN3Ymph?=
 =?utf-8?B?SWZGN2J3ekZDczRvWXhaMjFXUFhNVFR5Z1JSbnFpSGdCQmZhMnhxT2Qxd1RF?=
 =?utf-8?B?QTNjczVOTXhESFF0Q25JbjVuWFRna1J3YzhKeEZjMVlhMzc2c21KMWFZa2wv?=
 =?utf-8?B?S3A2bFA0RWRFSGpSR0JlYmFpNzljd2hFeGN4U0NCcGRzdmZ6aXp4R0dyVjhz?=
 =?utf-8?B?cW94NnF6Z09YUzB6YUk1UmRkTld2WjJEVzJRYklDSnl4RC9tc2JvVnpSNzZ3?=
 =?utf-8?B?Y3hoMmd3L3ZLZVBBMDNaa3JRL3ZFNVNHVitCUU11Vyt1U2x5R1FrT2R6UVA5?=
 =?utf-8?B?TlAzWWU5YW1XMENYVWlnR0cvRWVXWm1hK0NoQzNZMXdPcmRTVU1LNDlQYitW?=
 =?utf-8?B?dXNCVjFuY09GN0tGM2w3UUpoYXpTOVJLaUsrcmpudjBaMEEvUW9CS1dZa1h3?=
 =?utf-8?B?YUtYeVEveitrcm42RkVlNUhXb25FT0JaT0NpNkNrOElmQ2xrV1NiR2t6Rjdz?=
 =?utf-8?B?OXhQN3ZwUktpWVppZDI5ZmNwUFRVOURla1cwTER2bnZwMEFaY0pNZWFLeEZn?=
 =?utf-8?B?ZFdnc2hoNm5WczFYUnFJZFNIejJ1VGhWVEJIMHRjYzVPVzZYRXpqQ3J1TVkw?=
 =?utf-8?B?blJ3QkFkdFViSDlONExieVZTS1JEdFc2Sm9hQTkydjNsV21pMzdMK1BHZ094?=
 =?utf-8?B?NHA0THl2M1p6NEdpYVNPcENoWHBhOXh4aEVVZmJac0YzbEVQRkZHemtzYnFv?=
 =?utf-8?B?OGthRDhzallaZnNUVFZSaGRDR1JOMmZaN2FzV01ucDMxT3cyeFpFTmZsVkxK?=
 =?utf-8?B?QURkelFJRk9ndzJ0S0RRamxOOHNvWkEvQkdmZnFQeS9VYlVrVnhGeUluVTZZ?=
 =?utf-8?B?cjhoUklIdDVoZ29xQnQyQ21aZlY4T0s0ZTlGeDdnRk54b1psME5Vck9pVjk0?=
 =?utf-8?B?UEkvVnJZZFNXbnpmOVZoL0VXRlZKQWtZK29nUWpWY3RJV2JjNzQvZE12Z2ZC?=
 =?utf-8?B?YnlOLzBLVkQ0TWsvRnp6WHNIcVhEVThaZXRzVFVabHR3WG9qTjN0SCtjcUJT?=
 =?utf-8?B?ZGs5WVlqUWEzSW90czArbFBDVFVFK2dXY08rQzRxMEQzQlNzY2Q4MVBlNnpj?=
 =?utf-8?B?a1VlSG9wbXlnK2FlZGQwS3pTVFcyNTkwZmQzM3JCTDJHeW0zMFdRMkpmQlFq?=
 =?utf-8?B?WWlxOFVsS3p2cldLTXljYVFNZjIvNWRiaU9wMVNkdmRabjVuNTcvcm5LZzNR?=
 =?utf-8?B?WG9iYWJ0UGV4MFNWUkR0U3BrZUhhY0xyV0lwa3RrRXRiQVQxaGI0cFFWM0xR?=
 =?utf-8?B?MjVJNlhwVkRLZ3NFcEU2NEhVY2E4NUNxeDBnSS9zbGN1Q2hvMmNSVXZMbnJN?=
 =?utf-8?Q?0Cg8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48cb12e5-8b80-4cda-fbc3-08dd064cb0cf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2024 14:41:01.1389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvPaTgzc6q+fw3pPC6WU645QqcAvmiUYZevroVcMQLYmQsn+gvQw74dFh1uitKUpZLnQXI1Ws0CC0wqatpQy4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7265

┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
│            │   │                                   │   │                │
│            │   │ PCI Endpoint                      │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
│ Controller │   │   update doorbell register address│   │                │
│            │   │   for BAR                         │   │                │
│            │   │                                   │   │ 3. Write BAR<n>│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘

This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/

Original patch only target to vntb driver. But actually it is common
method.

This patches add new API to pci-epf-core, so any EP driver can use it.

Previous v2 discussion here.
https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/

Changes in v8:
- update helper function name to pci_epf_align_inbound_addr()
- Link to v7: https://lore.kernel.org/r/20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com

Changes in v7:
- Add helper function pci_epf_align_addr();
- Link to v6: https://lore.kernel.org/r/20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com

Changes in v6:
- change doorbell_addr to doorbell_offset
- use round_down()
- add Niklas's test by tag
- rebase to pci/endpoint
- Link to v5: https://lore.kernel.org/r/20241108-ep-msi-v5-0-a14951c0d007@nxp.com

Changes in v5:
- Move request_irq to epf test function driver for more flexiable user case
- Add fixed size bar handler
- Some minor improvememtn to see each patches's changelog.
- Link to v4: https://lore.kernel.org/r/20241031-ep-msi-v4-0-717da2d99b28@nxp.com

Changes in v4:
- Remove patch genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
- Use new method to avoid compatible problem.
  Add new command DOORBELL_ENABLE and DOORBELL_DISABLE.
  pcitest -B send DOORBELL_ENABLE first, EP test function driver try to
remap one of BAR_N (except test register bar) to ITS MSI MMIO space. Old
driver don't support new command, so failure return, not side effect.
  After test, DOORBELL_DISABLE command send out to recover original map, so
pcitest bar test can pass as normal.
- Other detail change see each patches's change log
- Link to v3: https://lore.kernel.org/r/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com

Change from v2 to v3
- Fixed manivannan's comments
- Move common part to pci-ep-msi.c and pci-ep-msi.h
- rebase to 6.12-rc1
- use RevID to distingiush old version

mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
^^^^^^ to enable platform msi support.
ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep

- use new device ID, which identify support doorbell to avoid broken
compatility.

    Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
    keep the same behavior as before.

           EP side             RC with old driver      RC with new driver
    PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
    Other device ID             doorbell disabled*       doorbell disabled*

    * Behavior remains unchanged.

Change from v1 to v2
- Add missed patch for endpont/pci-epf-test.c
- Move alloc and free to epc driver from epf.
- Provide general help function for EPC driver to alloc platform msi irq.
- Fixed manivannan's comments.

To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof Wilczyński <kw@linux.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: Niklas Cassel <cassel@kernel.org>
Cc: cassel@kernel.org
Cc: dlemoal@kernel.org
Cc: maz@kernel.org
Cc: tglx@linutronix.de
Cc: jdmason@kudzu.us

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (6):
      PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
      PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
      PCI: endpoint: Add pci_epf_align_addr() helper for address alignment
      PCI: endpoint: pci-epf-test: Add doorbell test support
      misc: pci_endpoint_test: Add doorbell test case
      tools: PCI: Add 'B' option for test doorbell

 drivers/misc/pci_endpoint_test.c              |  71 ++++++++++++++++
 drivers/pci/endpoint/Makefile                 |   2 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 117 ++++++++++++++++++++++++++
 drivers/pci/endpoint/pci-ep-msi.c             |  99 ++++++++++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c           |  23 ++++-
 drivers/pci/endpoint/pci-epf-core.c           |  45 ++++++++++
 include/linux/pci-ep-msi.h                    |  15 ++++
 include/linux/pci-epc.h                       |   2 +
 include/linux/pci-epf.h                       |  30 +++++++
 include/uapi/linux/pcitest.h                  |   1 +
 tools/pci/pcitest.c                           |  16 +++-
 11 files changed, 417 insertions(+), 4 deletions(-)
---
base-commit: f5373677e13177cfc7875f44a864f9a1db751df9
change-id: 20241010-ep-msi-8b4cab33b1be

Best regards,
---
Frank Li <Frank.Li@nxp.com>


