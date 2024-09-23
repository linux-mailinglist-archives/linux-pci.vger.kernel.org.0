Return-Path: <linux-pci+bounces-13386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAE597F0EA
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 21:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E781F22317
	for <lists+linux-pci@lfdr.de>; Mon, 23 Sep 2024 19:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCA71A0B12;
	Mon, 23 Sep 2024 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PlAIqhYi"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA731A01BD;
	Mon, 23 Sep 2024 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727118018; cv=fail; b=L95nZ/hnjqFF+L4jo8Nt4hwXIRcSCAPkVnsn4ySmQF3kiz4ZLvQmPq9SfzdsqHExRa7G54YKi7JttBvw6Nk6kAqxNANMFN4+zGzXQ8oPUp8fMpztwCUVGsLDIPIsHphQPrLeywCgcF/wtAqhejy4+wkB6n3XlCftUGj7/bM1VgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727118018; c=relaxed/simple;
	bh=UA8d+sBLH56yo6wbs19BhoTsblTm17oh+2btuJvmpbk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DVRfvLXHZXKcYbx4vwHPa065C+Ye6ZP0Dk3gSy2ILMYdHBu6r42mxYRJqSN2UwVCRLdlf8WlnlM+KfH+xVE4MAfLhH174DpIHK3kRjuCOo8DyAwtErOl4HS0EOTwGEBQsYBkPo08yZ+b98UjIhJXi1l0VN+N5noycZ+I35ZLr/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PlAIqhYi; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGcWf3gVh/Wp19NEGOYxatlsQwD6oTeuJGTzP7qNRsqkn+aNaoUIBsVZb+jZoeXlv3nBzldUy+S0fQwcdg2xNxHSimuOTIY7dTYf5mv3PoYup/1oceutROh3OZvtl9IRSEbxW7/p1tA7RZPoNGOZP8T0H64vaI3zzdMJccdprcmygUtwuRdkDanOu4pgo6feNjP3MOd3iNbn+JgdlSKBZ/sQnY+6CQNYVIQI0lOw7oJuUpSvDN2nmq1gSXSSgmsYkOqcCGTgdOWczHUwUvIEyf64zpvYTHaycSMecz+TR5zWvvrJwCGZqBmvv7a8VsS3MQ9Klzvc71BXdv6ECkbprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrUk9YwMPnne01ifz2s05Q5PhJgj0l8sUAQNIs7aG8g=;
 b=jB3mYGIc4Ue7mjcvlCOUQdxoZYspNmWqzrTv2oufa2QZskQVwf0TL7Z2clBwpw/UqvnYbt7+eq5wDRlrHJVjwM0km5j9uqj9+/E4uVOATkVuSdBULZkvnXh8Tox5ZOXgR77bOX1XEL8UP7U2Oki/WoVP+Zpzh8CM2kWcfGdGzMWyx27bt0T68oiH0p2d0q63u/BxLH8oM3PC2V/dzMRP7azVRRCtrQj0kOc0ui6RMLXJSCLGxjtW0A5U+Vmnw6e0+p1w8Yw6KtdXeqhgSnM00A4SQzXIpHsyc7N38I1GDLl7ZcxADdtPDaXTxPYgnmYHrDSxs+h38i05NyB3yByIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrUk9YwMPnne01ifz2s05Q5PhJgj0l8sUAQNIs7aG8g=;
 b=PlAIqhYizFjiB+nMpgYChosSqMRQaRFHQkpDTyg1Lyrp1y5NtfcmjqpEPQWL9LvLpyFP6sI+IgnvWvh8eelyvtkQvMn/MqsLbeOJ8m8mOWYnjtKf4Ej3FJZ8jFx8+2gNMLQrSvZ9GV+VACH2TtTHwSiGc3aPo6qWBifRXz2Eh51ceqV82By8qvW3O+Dy/w7aBwc09CPr/urN3T57YBk7++txnBflSCrhxhEG4E+Oh0Bze4NjU5L4TSQwRqt2oRMBhTk677aXq9j5q4/dB0EOAkLJIhTDhFYoBDNlODFwga94qtc+Qe3BaBabDdFBdq6XAd4MWkgir9NDDZKWzKYodQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9562.eurprd04.prod.outlook.com (2603:10a6:10:321::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.24; Mon, 23 Sep
 2024 19:00:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 19:00:08 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 23 Sep 2024 14:59:19 -0400
Subject: [PATCH v2 1/4] PCI: dwc: ep: Add bus_addr_base for outbound window
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240923-pcie_ep_range-v2-1-78d2ea434d9f@nxp.com>
References: <20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com>
In-Reply-To: <20240923-pcie_ep_range-v2-0-78d2ea434d9f@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727117997; l=5222;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UA8d+sBLH56yo6wbs19BhoTsblTm17oh+2btuJvmpbk=;
 b=AbThf7zokd+Nv7jvltfFUDJ986D5PciTOKU6Rru46M6BXfAO9/TFa5BhSXmyWj6AkTYAat3sx
 kpbS9UXXIybAAVH0+5QuOnwyc6VwfvPW2alKUtk39Ua+RunUs0qU5/z
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
X-MS-Office365-Filtering-Correlation-Id: 0b9668bc-bd6e-4f4f-6159-08dcdc01f1a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OG5zTjJsOGJDbldJZWJTTGtLSUc1a3hIYWNHWHVLQUZHaU8vbEl0QkZvWWoy?=
 =?utf-8?B?emQ3ZFh0aEpvQTlmanpLWGhpSW5lUnU1TlZKTVJpTFpVajQzdVFQL1pMOEdn?=
 =?utf-8?B?WFRWejlaNzUzRS9ERUJRdWc2cDRHcWZEbFlUeGg5NklKMk1NNklTUXRRbGx0?=
 =?utf-8?B?ZHRYVVZ0eGR0OVdacVU3UzUvUnV4Ymdrd1U4ZGxWTFhiVVhvVHdubHF4TXFp?=
 =?utf-8?B?UHZXeWZGd2dTS1ZVaTg4ai9nTTNraHYxcWlWZitEUWJFQ3plUzcvMmNJS2pW?=
 =?utf-8?B?UHUzeVljS2ptVVZyWFJyZ1F2MWxBN29FREpmQ25XMjgwZnQwU04vS3dQSThL?=
 =?utf-8?B?WlQxS3dicEo1aEtsd3pDQmtsV0tVTjhmWG56bjU3WGl6RWozd25RMjZ3VVIr?=
 =?utf-8?B?WHlNRTJxUFdkZ29Iems4STN2R1MrQkYzazgzZFR5dXl2S0tQRmhpT25UNWlr?=
 =?utf-8?B?b0xQVUllUnpFOG1vcTBiV2JDUGloQldlUU11ZkF6RVhmbTdPaU5TV0FXYUM3?=
 =?utf-8?B?dEsyRmlsTUp3ZmVQbU0vTCtpN3dZeExrdVpvQUhoODlWQ2NRcktMZHRXL25y?=
 =?utf-8?B?aUtsWGsrejVIRFJMSjkxcW51U2RWREpuSlE2YTVmUURoSHl3WElWMXA2UXRo?=
 =?utf-8?B?NitCOTM1d2tCSmg4QmVSeFdUTHA5TnhZSEprQ0pINEpTU1gvdDdFNXBNbFJl?=
 =?utf-8?B?Wk16d2k5T0lLQ0htY0JwY3Z4dEdNYUxZdGFxUWZlZE1XZEttL2NmY1JYYzcv?=
 =?utf-8?B?VXByYnYvWDU5eEcrKzREVEVZK3lBZ0V0Rm1lVUdQS0QxRGRKNkFIdGFJSEpz?=
 =?utf-8?B?dkdFQmpzNlQ5VFl3YkJpWHkvVnhjRi9oejJsQXZqdExEbnlpUncvMnNiMlk4?=
 =?utf-8?B?VklTQVUwdkhrY21PZkVoanJKOWVWeXpNazBYNG04L0xwLzdzaE9oVVhMY3lS?=
 =?utf-8?B?NTlNQTR6WWE1bEIrKzZkb3pQSFdpN29odHJRQTY4MlZFYXJTdEVOWjVRS3Vp?=
 =?utf-8?B?NlBoa3NtY2RqeVhOUGRURHBZL3c4WnFibkxUUjJHbWF6MGoxcjNqVlk0Z3Z0?=
 =?utf-8?B?L2Z5RGJiOEE2VmdTY1RxZVR5TzQ0Q2JSL1ZXN092YWRidnY4VzNSNDVPYXdM?=
 =?utf-8?B?dFFnU2dOQ1BXV0pFQmZGR3NIaHAzNS91Vy9XeURWeUs1WUxMTHY5MVB1ZXZ0?=
 =?utf-8?B?eWxKbk1MTkdTS3ZVcDlXWTY3QXV6RVJlbHQyMDhpV01vTzRIUzVVYmg3QS9S?=
 =?utf-8?B?YUpBc3lwVEk4THNJVWd3VEdYek9FK01odTFCZGNCR2VPV0FCcUE5LytWc0ox?=
 =?utf-8?B?ZWp3aFBBeXpVTCszakNLaW1qNFgxZS80M0xEdUhWZGtVWVZHVkdoMC9wbWxw?=
 =?utf-8?B?b3lZYngyMVhEaUNWenk3QmVBSE8xbmxHa091Q3Rac0x5Wi9RZ3hNWkIraHM2?=
 =?utf-8?B?REpTS04zMGdVdlBrV3RaN2pSWG4yOWdSV3gxZlBNTE8rRTRlRWcrRUw0eDhm?=
 =?utf-8?B?ekhaM1RoUmhvaHRIaVJjUWpRVGp2eWkxSXF4SGRkUGQ0bmtCU212R2x3SVdp?=
 =?utf-8?B?andFclJ2bWlOK0dRRXh0N3ZMU3hiNFhOQkIvZHA0a0FlRHM1ZHpUNDhVbFoz?=
 =?utf-8?B?L3VjT1JxR1ZKZkNtY0krVFNtbjdpREtVRlFuYStSbkdObmx3T1dqSDY1dGpO?=
 =?utf-8?B?YXZGWExBZnY4ekJDek5UMnA2OGd5ZHB3blFEMjBZZHF1WGVTSzNITEVMTTRV?=
 =?utf-8?B?MkpHZEJSQVc2MTZWenptMjdteXZWYnN6SzBoQ0hML2Uyd2VSTDBXaWU4OSsr?=
 =?utf-8?B?dUJ2TTR2QUlEa0tGUDgxSFlHTXFFL3VjeEpQcnpOZC8rc3JJTkp1cUNiREhL?=
 =?utf-8?B?MVpLcXpIMHR2d3BqMDBMcE1PVWlYOThOYVRWaUxUOGVqUWRaRWxpUHFsdkhX?=
 =?utf-8?Q?u9KO+EUyxuQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFFFeGNkNzB5WVBRMWhVREJ0ZnpacTJaRDlZUjFtdG9sb1VJRjk4VSt5b0Zk?=
 =?utf-8?B?dXorOWROTDRBL20ySG1SKzIveDg5dnliL1hZWTVhUXBxUU1EQWNlT01tV05p?=
 =?utf-8?B?S3V1d3FLNWFTOU1XbkN4aXl1ODVpdXZ1THFXa1lhSHdReEpNSnNXVzFoMXJ4?=
 =?utf-8?B?VFZPd3M2cS9lR09sdENWa0tQZFE1YXExNitvbU0xdTlGT21wUjdVTDZRc3A3?=
 =?utf-8?B?VmxRamlISjVYK0xvcXJLRFNKWEk3M2pmK2dDR21vSVhYRWxzeUJKTUQ5bUFR?=
 =?utf-8?B?N25QdW00YlN6bmRQUkQzV05Qc3JkaURXU01SVnN5VnIwSW1sVU9LeG5aMDdl?=
 =?utf-8?B?Q3NRVXJ2OEhkcGZLdEFqazJWMXNta0RZSjhKMjZ0cFdjNis3TFo4RzZsQzhG?=
 =?utf-8?B?cWFReDh3Ry9MSmVOSjdvYUFFRFlOcXQ0amRYMmthMVUrUys1WUhBZktQaFJr?=
 =?utf-8?B?SExMLzIzenV3WVhpeTBQNzBoUTFkajZvNWs4Sm1YQzBSeHA4Qm5ZWWorbjM3?=
 =?utf-8?B?MlU0dmIvZHpwNkJFZWJsR1JpQVBCbUwwVWNsUVZCRzd0bGl0alFKNjlLQ1J1?=
 =?utf-8?B?bVBwbHZBeUVUaGpWUmFTRkphWWdRbDVsdnNScis0Y01ySG9WcFZ6UmR1eFB0?=
 =?utf-8?B?Y0R3VmplVmxFYnB0dnJaejQ4YkoyVXpRODBWbmtudmFQUWpXN1VNZDhRc3lv?=
 =?utf-8?B?d0VkNzVwZ1pJTktmSjY2WjM1aVFUZ2tYU1ltbUxwT2hGOGlXZW1BYTZFLzRZ?=
 =?utf-8?B?dHJjMk0rc2pZdW9wOVpKTHRHczdJa1IybUluaGxYRXJtMkJlVE5aVkNUb1Rs?=
 =?utf-8?B?WkZSZzEwcDcwQ1pjZnZHRGRVdDY1NW5QWk5Kc3EyZUFXT1RGT2V6UDRldHBI?=
 =?utf-8?B?dGhhb1hzaG56OEpSSm1ISVJmQ2VGSkFMNkJLTjJYcnRFT3JDanQvazBIUVJT?=
 =?utf-8?B?Qmhyd3NqWHM3eFl2akVib2dWcWd2MEMxRnNXLzJxZ0JydTY5emNvRS9ETytO?=
 =?utf-8?B?cHdjclZnb0dSaUc5bDVWQ1V6ME5OVkJ0M1hoNmludXd5ZGhnR1BNUWNBbHBu?=
 =?utf-8?B?UkhWZ1B5d0pvZWkwb2RUN3lJWUg4S2dqMUJjVGJWb0FaRG5UNWNVSENKN2hm?=
 =?utf-8?B?dEFPWnFLbVFPbFB3bll1ZmNHSXB0Z09xT2xrclREVzFFRlJTSytKTmNnSjIr?=
 =?utf-8?B?NFp4dURGeWxHY2xWcnNRcXJaV01TY0Rvaitmb2VCVEtxOFpyeHAxcm5KVHBD?=
 =?utf-8?B?RXU2bmxKaDhZTVZoQWZHbmZaSTVvbVVyaW5tNEFZditjaW9qbjhoS2tTQTF0?=
 =?utf-8?B?VmorY01PY0tNWVdGOHlaa0c0UFBCSDdacTFoOE9JMVphZFl6VElHaFBicC82?=
 =?utf-8?B?OWFlb3d1UEdIL2RPbUg3RjVsaTQ0Z085Q3l6OFhYLzBkWG1TS1Y2eWQvN09k?=
 =?utf-8?B?S3dUTlNiMEtBNkRRQXJldjFCa1lBQjlmaUkrRWhHeEcyWktWTEg4WmdyZE9S?=
 =?utf-8?B?Ui80d3NaYWxRQzRwZjg4Mk5zc3R2dmRXVGdiRE11SXN6RDc4a0NRY2R5am1m?=
 =?utf-8?B?WndZUi91M2tTeGJjc3M1dForMkNzdE5IWC9EMTgzcnZmUGtuQ25QNzBsRVBr?=
 =?utf-8?B?cmpGalZ6azZQR2NJamVUNFZCSzNyM0swanJERmt5Ny9SWDg1bDZnUWNtNGV4?=
 =?utf-8?B?SnI3aE1uRjhKNWErbTVVTlJxeDNPWVgwZmpPUm12K3M1bGdJbjV5ekVERXY4?=
 =?utf-8?B?WWdQTmptajR5UStyVG9qTjE5M3dUTUVBUFJqcHAzTDMwRmI2N3pvMHpmeWtD?=
 =?utf-8?B?QnhaUUdDQVpwRkR2a0ZrNWJyeTY5K0tGNWpLZ0ROcEdvTGZvc0thTy9jbGFt?=
 =?utf-8?B?RkxlZS9WckNlN2JBY054SFJxdjMyME5IZGNZekJKM0E5em51aktmTXd4L0wr?=
 =?utf-8?B?WnRYZ1lpK204YWtXdUdtemg5Y1F0OThHa2tYQlBNbnk0eEw5MUw3MGhVZE5T?=
 =?utf-8?B?K2pDY09uSlNFV3RBMVZndWVRMXFxdWJkTENIeWRhaXJNLzdOZWY2YmRHYnBH?=
 =?utf-8?B?YTZtUXRZSEtLVlBCMVVSVDZRV2Zqc0dXY2gzQXRjTU84cWN1ZFlqRjFaN2V3?=
 =?utf-8?Q?GSoQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9668bc-bd6e-4f4f-6159-08dcdc01f1a8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 19:00:08.8174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c23GZINQrMYjkDJ2D5qEi2AU2FlJMAcnjjXeKVR4AMmh2CKa4gFhTQDD0bR+YmnDTM1Uw6BmVkNBNw68+ThBwA==
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
The bus fabric generally passes the same address to the PCIe EP controller,
but some bus fabrics convert the address before sending it to the PCIe EP
controller.

Above diagram, CPU write data to outbound windows address 0x7000_0000,
Bus fabric convert it to 0x8000_0000. ATU should use bus address
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
to bus address.

Use `of_property_read_reg()` to obtain the bus address and set it to the
ATU correctly, eliminating the need for vendor-specific cpu_addr_fixup().

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 12 +++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h    |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 43ba5c6738df1..51eefdcb1b293 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -9,6 +9,7 @@
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 #include "pcie-designware.h"
@@ -294,7 +295,7 @@ static int dw_pcie_ep_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 
 	atu.func_no = func_no;
 	atu.type = PCIE_ATU_TYPE_MEM;
-	atu.cpu_addr = addr;
+	atu.cpu_addr = addr - ep->phys_base + ep->bus_addr_base;
 	atu.pci_addr = pci_addr;
 	atu.size = size;
 	ret = dw_pcie_ep_outbound_atu(ep, &atu);
@@ -861,6 +862,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
+	int index;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -873,6 +875,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		return -EINVAL;
 
 	ep->phys_base = res->start;
+	ep->bus_addr_base = ep->phys_base;
+
+	index = of_property_match_string(np, "reg-names", "addr_space");
+	if (index < 0)
+		return -EINVAL;
+
+	of_property_read_reg(np, index, &ep->bus_addr_base, NULL);
+
 	ep->addr_size = resource_size(res);
 
 	if (ep->ops->pre_init)
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35aa..c189781524fb8 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -410,6 +410,7 @@ struct dw_pcie_ep {
 	struct list_head	func_list;
 	const struct dw_pcie_ep_ops *ops;
 	phys_addr_t		phys_base;
+	phys_addr_t		bus_addr_base;
 	size_t			addr_size;
 	size_t			page_size;
 	u8			bar_to_atu[PCI_STD_NUM_BARS];

-- 
2.34.1


