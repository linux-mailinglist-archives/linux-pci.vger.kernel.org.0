Return-Path: <linux-pci+bounces-15489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8EC9B3A0A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 20:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 002C11F2254E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 19:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F0B1E1C2E;
	Mon, 28 Oct 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kwSBa+XW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635BB1DFE12;
	Mon, 28 Oct 2024 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730142400; cv=fail; b=cOB55Aq1SqyS0LX4Fudh95Ig/dwb+7HV7+PevEXGjGqYnTMDRRatAn3SjkgRIXTWzMtl9P3vWhfOHumnJYw9bRH2RMO3ocodKlyodb2IF0OZ9qjRvfR1kaB0fZ59d501jsIPc0cWFduDfPaJS0cqjA7r6Ef9tP2NR8HWNBtg/9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730142400; c=relaxed/simple;
	bh=MHdl1pBB8ltbGON7gH0Psda0JXVx4MU6Xi578sObIvc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MWZEjDY0iwsucjueILUQkeGumSRUKUtaheGfToRJOgZ+G21eYGVdeydE4TwnZcAe8gmhqgrRZnSaxutQXBDHukwbpX5nacVe/4LaInS8I8Ace9typHDztheh1waxHbdZexJin8ZR4iJhE1P4KTy8gvhfpW94VdFIY2uZYpTK2BE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kwSBa+XW; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rl8rssUPgB7EqAco+rWgN4AONyKlI2GMKHiLYpZ90bOPM5DX+oYY4jgl7tJvUYFHes/JwUJjwymV0Qqm+jxmSJd5BpirOtOYJjMXMSjbdEGOByFpUkX0JzqfQqU3zWLQ2mO44rn3mlV4tAZuKSd/7TL1nZtv1pt5dEVPN430gekYJM/pA92gyvh5kYUsOzYiBza0FeZ+gVbkW/xKg3Y2Dkze5LWz7TOiGUBDC18uUmtYOEoC31LE2pbrjI0jzEqWSH+I/JUrCPiBvuSOS9FI3ORAVljOLLU8MzFn491GFg19yAjuetmL++3ajntIFrG9XaGZp1MK2MMkUzzBsmRl9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMSng6Hkq1ZytcY3Ph/5wRTVWQF53XvR2y3i6XkNIAU=;
 b=hKFWGXSLsciIIHk9poOQIr90ZoUGJvTnc2LobhrrvIStDgvRmXYNspPkGhFtZjYblTYXSM2B5Pk2Cl231cu7Z1LJkgmna6glmFS0tu5BTgf9wGqEhjDQCSfseTS55F9eKxnMtexiL46kNcvnjrZyc36yPQ4YbZJxhcKhYBMA2XQV8US2x6fTZnZK6gEn90svbW5x5txUrn5TlzfcALo5DRzWAWVn6Kmj9BVrKDBuhC7JJAFVT4GIjUr5c2XawR1HzO/HX2ypuvwuJKQDOVxqETInVBoDr0jrIo4pdFVZ9QMFDVLXM59TlLaK/XBADmUp9lxIqxO2NH6sJWXMFJTvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VMSng6Hkq1ZytcY3Ph/5wRTVWQF53XvR2y3i6XkNIAU=;
 b=kwSBa+XWWEKfv8Ow/I8Pq/QWeUkEWZuB5giKah165ILfxBvigkIIGdJQVbBj3/iQrHi02kcYjDz8t7ITK0pHWzoM/iN3ki10/xu8KgWhpQ4WRj0i4H5VraUAyOH/jjiDFrgHOLxRi9vIYvw4U4R8YYWutOzYB5TL82QP+ZMOejaklVhSGum5BBb7smLRQ5+ONfkvTSPXE3gLU1K1WHAHEPJi5NT4V6S8r7yEdIxO41M5ofm5YfLeHrMkxJHLrVn70qKrFJ5PeU8f06wwGd2wI3whICrVPTNbCh2KHZLC8ODKS6LeqwNtWc53cTTlwI/8tQaTP+QFD5AtBnPRQ5QBoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7946.eurprd04.prod.outlook.com (2603:10a6:10:1ec::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 19:06:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 19:06:35 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 28 Oct 2024 15:06:00 -0400
Subject: [PATCH v6 6/7] PCI: imx6: Pass correct sub mode when calling
 phy_set_mode_ext()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-pci_fixup_addr-v6-6-ebebcd8fd4ff@nxp.com>
References: <20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com>
In-Reply-To: <20241028-pci_fixup_addr-v6-0-ebebcd8fd4ff@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730142363; l=1266;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=MHdl1pBB8ltbGON7gH0Psda0JXVx4MU6Xi578sObIvc=;
 b=7wUDVK/qc/0ISWrgJoCoXb3D5iiXVsBocxv53p37ZhxLt0LjJqo1X/hN5j1q0wzpE6MNwd8La
 s2ecKtb1BEPDqaXSP6/atN5z+Rz0exk3hLtpdmJKiRY6peboJCyfSQi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 678cf69b-be54-4e49-c5ab-08dcf783a492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXE0MUNaQ1BzSkloN0J4S3VlQnNKUGdYU0ZEWFM5SVJ1YU1HelU3UkprdFlt?=
 =?utf-8?B?akxGUlVUdUw1cXI4SEdFMzJkRnVRbGZSVmpxR2w4amVCbUEzVFZvZ1BteDdF?=
 =?utf-8?B?YTZoeXBWOVN5YXFLMDJpaHpETUZ6VXVtSE9GdzN4U3RCVXdnTVpTSndkTEZ0?=
 =?utf-8?B?SmhKOEoyWHZRQm1wSXVrUFVpMzBTUEl5anpPY2M5aFhSRzFydERkU1JtMDRH?=
 =?utf-8?B?SEV3Sks3dGtUM2xGUWMvWGNDbmdkcFpXYi9Rdjlpd1Mvc2RmZ09oMlFTLzEx?=
 =?utf-8?B?dnl1T01tK3U3YjBtZDhqbjF4WDlRQUZOK0dQQmZ4dEVuOHNNaWxxdTZic1Rn?=
 =?utf-8?B?QUt3c0ExUXpOK0VNOWtlSkZ2YngwblN1YlE0TmV0ZFBHeHZ6eTVSSDR5a3Ft?=
 =?utf-8?B?blE0a0pJUWRzTXI1WUJlZ2FRaThmVklUaEsrNXBZYURHcmREM3pPNStBS0ht?=
 =?utf-8?B?bjZ6QXpZQzMydXRGdzlQNW10NmhZWnFxOU9HWS9maGpTZ2NkclZrZTg3M0ZO?=
 =?utf-8?B?bGlyMnR6aFJPK1lyVS90UUVZL1BuT2VkbU1UVWROZFhnRXEyL0hIb1VWNzQv?=
 =?utf-8?B?RCtNRlRvbk40K3EwbHFHeWhMZXlURFdFc3lHV3JqZjJRQXpxRmNDcXZSS00v?=
 =?utf-8?B?a29acC92L1ByakJsL2l2aGNiUjhFSmgrRXVaQVdHckN0WStDOGVaOS9hUDRh?=
 =?utf-8?B?SDZMQVNLY0JLakY2dEFZWXhMSjRWMER3QnZQeTVyN0lzWmJ1SUU4ZjFzM1lW?=
 =?utf-8?B?Y0Y4d3d2MDVxbUh1SU9CZFlBWG12aEJNQ0NpVHlGOW1JSi92Z1pSdGpKaHl6?=
 =?utf-8?B?UGxUaXdRaFJINlJUN21HNlUwQnYzYUhaOEJRZW5mdzM1a0kxS1RmM2pWQzhC?=
 =?utf-8?B?ZmxDN1c5NUNnV2RLa1JOdVNIRGYwSUYxMytpdkx2Z2Z6eU51d293bkFGOGVp?=
 =?utf-8?B?MnVnS05LcE1xNEFhM0k3dTA2WVFvdFc0ZmdhMjRxbVBLNWtLcTd0V21kNjBT?=
 =?utf-8?B?UnlwV3oyc0xnazR2Ky9pemd5VjhPK0FNY09STVNCOWxHYmVTcGdhcUxaVlBS?=
 =?utf-8?B?S2sxejY2QzVSRkRrRWhFR0hOeCtYK2dPUmtWRVExdzNycU9SMU5WWFhFQi9J?=
 =?utf-8?B?aGFzODhZbW1PYXhISGNxbDlDeG9RS2ZROG5Xa2NRaXJWYmtJNGJtdUh3bFNm?=
 =?utf-8?B?L1J2NTJBZHd3K1ZOYWNlVXM3TGl3bndveTJXVlBNNkxkNWpCRXBxOUcvdHJ3?=
 =?utf-8?B?emlzY2JhMlFlY2xwR3dYMzZkOGRnUFp2dWd1V1hSeURLTWVGNkJOMHhhaE5a?=
 =?utf-8?B?aVlZNXZJM1lVNVdXRUJob2VRRWJNY1NNc2o1M0VDRDBmQ0FNV0dNN1FzOVJt?=
 =?utf-8?B?dTljTjY4RlEwQ2RlRndlQzRLMG1BN0ovTWtjU1htV3cxVkJBWnFUVFBxazdv?=
 =?utf-8?B?QjhvSllxajhQREZkdzhHUGRZdlpVOTM0YlVaQ2NsenRjbnBlaEhPWUQ0YU9k?=
 =?utf-8?B?S2FPc3Z1Rm9hYmw4b2FZSmREd01Db3hJem1uQUR1TmpPMUx3Y1lkK2h4Uy83?=
 =?utf-8?B?UkZSUUpmOTNqeEc5NUxFT2crVVB0VG1jcU1mNzlzK1V0NUt3Nk1nYXZBRUcv?=
 =?utf-8?B?U2owaktWbElzNXlvdVNDYWZKWmdGSDVCSkFhQ1ZmSDRKekkzOUhDOEo3SWVD?=
 =?utf-8?B?Ykp5MlNPajdGM1RldHVlaE1SdkR3UGk4dmNta21QWis4OXhmYVZscXk1eldB?=
 =?utf-8?B?OXUzazYwOGlUZ2NyejM3Z2dGY091b0lRY0NWU0pxMUJQQVhUR092bng4emRG?=
 =?utf-8?B?Q2NaOTdtVXkzQUFrbFJLSmJNMy9leE9CL2VqQ3dQaEFDVjVCb3p0YlYxV0FQ?=
 =?utf-8?Q?uICSiRfuaDJ8G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFZIekJlZytYalhybDdkZ1Iva3krUEJSQ2pLK3ZBTzdsMEh6Znl1RkQzS3NJ?=
 =?utf-8?B?VkhtaFZIdEp0VVJqSll0TnArQkNLZDFDYjZndE85U0FsTitubW52RVU3SzZS?=
 =?utf-8?B?NXJ0VnQwWGQxTDY3SW5UMG0ydUhhWGxyZHAvZXk3TWJBYXRwQTdRMU1GbENn?=
 =?utf-8?B?dzBudDRza1hMNTJrdkZNUGNQbjJWNW5wWWJjT2JFYnkzek82ZGUxeFZiSW5U?=
 =?utf-8?B?Y1FzRWhvR2VmTXZvQVZaSWJLc21ENG55U3BPOTA2QnB4K2VrVjdOYTVzRWxu?=
 =?utf-8?B?T1FPSGpMQ3liOUgvVGFXaEdxeXFwbnBINXpLMlQ3Z1JVTVMrTGxtaGNGTWt5?=
 =?utf-8?B?KzVBMC9NV3BEeUxoTXBSUWZYd0hXZ1JsSFNKL0tKcEoxSVBtR2Y4S1dkb1BF?=
 =?utf-8?B?V3I1Z2RiOTIycmhJUGM3K1cza0V3Y1IzMEd4K1o3azFuVzNpNnBXcE5XTVFF?=
 =?utf-8?B?ZUxZQ3d1MC9IemN0RmlKeGxDTktpQ1NpemwzTlNtZ1hJRXhTQnZuK252VUtU?=
 =?utf-8?B?Tlo2cnR1QTNRSDZSWXQzWGt3cERtQW0ranhlalFObGZja2o3MjhSM1F6MEZo?=
 =?utf-8?B?ZHV1b3h5MTA2bWpMc0N4eVZ0Q0FEUHBiVzh5SGhCQitqbTNSaDVBZmNNWWJQ?=
 =?utf-8?B?VlFPazV6S0J6bHRtdE1XckE3QjNIaWlHMFFaZFYyN3ZZSmRQTE51Y1FtYVRw?=
 =?utf-8?B?dU5aNlBhYVdWb1VvMWZBc0ZVQ2V4dXVDcHlqdG1zNHFDVHRkL295Y01Fd0lJ?=
 =?utf-8?B?SjdITEwvMjJrQzU1dWVBbmpjWUNFMC8xbHhoa0dwQ21lL0pRY0FvUm1DRFRv?=
 =?utf-8?B?WldrNW1QcDYwTzlHbjlUdzFxOGp4YytVS0d1TG83QmZBenFKTkpkZ1paRlVs?=
 =?utf-8?B?c211azNNU0J3UzdWMSs4N2dPTVRyMzlDYkVrRlIyeVpWbXdlVzdHRmxJZVJ2?=
 =?utf-8?B?Vnk5cWMzcmlpMlFKd1J0cGJxbml4ZGRjSllJeFROZGxCdFQwMTF1MWNMd0JL?=
 =?utf-8?B?RExEQXFIZWtEWUR4cHF0NnVEM05PSzhSTDJuLzd5VzNyZ1RpSTR1S21MZTl4?=
 =?utf-8?B?SXJjWnpnQkR5TFNFRU5yQ1E3OFJLUTBONlhLOFZzenJ3cDV5eW1BdXZjNWRT?=
 =?utf-8?B?TVoxVmh6MVdCVnJjRFh6US9PQWhOQzU1SGRGc2U5L2c1QWkwdFBJOFM3L0Zn?=
 =?utf-8?B?cDNKOXE1dGpVNmZNaDd1cU1NbVBFTEtnd2s3dHc5bnlZd2NsTTFrUU5vSU1s?=
 =?utf-8?B?VDRRR3lnaTZQN1pvOWdadTJIRVlxRG55d1N0TVpVT2xyWldPZmRMZUpsT3lQ?=
 =?utf-8?B?MVlySm5UeXdZNGx0MmJ3NXRGZThaY1l2ZHJpUjRTYnQweXRrbm5EZGtjcTYw?=
 =?utf-8?B?b3dyUnpoQ2ZlNjhSODZ3TUY2ZTYwMmdwVkUwY04yc1lqUmpLVEZvL2ZSN1M3?=
 =?utf-8?B?bWVPcFhPYitHUU1vRmVNZmRCejVBRVFaREpSRDRSZDVLNFBCRXlheS9KVE8v?=
 =?utf-8?B?UHpIS0grT3d1NnR3ME1CQnJvckhoRXJZWTc4bXkzMkR3VjNwNStoUDdBdERP?=
 =?utf-8?B?K1JPemxhRlFuOUw0OGhmNSsvTm81OE9FakdnY0FhSWIxU2ZFRDRRR05JOURl?=
 =?utf-8?B?NGxYM0Yya1NBU3NadUJ6NzluM3JwdXhTc1kzUmlGeFBEMnczWmpSRk5GcElu?=
 =?utf-8?B?NExEQ3FBcEJiWWp4NU8zbTZ6RWFLemZ2dGJQcEhzN3dlRCtmQ2Y2MnVZb2RI?=
 =?utf-8?B?bUE1VitQajhmUUE5ODR0V1labXpCK2QxbE9PYXd2UHh0MVlSc2xkQ2xwR3J3?=
 =?utf-8?B?TkJRZGN4aG9IaVhPNlNDZ1JKWCt1THpGdlhmZzdxWFlyM1J2YWhZRzJxYVhZ?=
 =?utf-8?B?NmdhOGo5emNQczJmaWt3UnZFQVh2TlMyV1FheHdNN0dCZWdPdUI4NzA3aXcx?=
 =?utf-8?B?UVI0SjJZeXVQeDUrYjBhbVVKdkVmTXh3azB1RmpGN1ZicWlINi9teFV4a283?=
 =?utf-8?B?Q3RiRnRPUGVjeUhLWENLL3B4RlVzZ1loTG90Uzk3MTArRE0ySjFGbWJjWWtx?=
 =?utf-8?B?bkNOYzRBZWJ5Q0VIN3pCejJZbzJDNmRlMkNzZEJyUHhMcHhxMko3cUE4dWNO?=
 =?utf-8?Q?3ldZHoPczDFpXkujVBO+C0BJB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678cf69b-be54-4e49-c5ab-08dcf783a492
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 19:06:35.4833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApzZgWhIA5RqpgnstKTIqxBvurNVXszvXzdVw0om4KFMvkA+UApK3RvOGZSjwfT/JZrCFKjwsnWjY/UmBTyKQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7946

Fix hardcoding to Root Complex (RC) mode by adding a drvdata mode check.
Pass PHY_MODE_PCIE_EP if the PCI controller operates in Endpoint (EP) mode.

Fixes: 8026f2d8e8a9 ("PCI: imx6: Call common PHY API to set mode, speed, and submode")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3->v6
- none
Change from v2->v3
- Add mani's review tag
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 533905b3942a1..8102a02a00b38 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -960,7 +960,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_clk_disable;
 		}
 
-		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE,
+				       imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE ?
+						PHY_MODE_PCIE_EP : PHY_MODE_PCIE_RC);
 		if (ret) {
 			dev_err(dev, "unable to set PCIe PHY mode\n");
 			goto err_phy_exit;

-- 
2.34.1


