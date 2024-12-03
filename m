Return-Path: <linux-pci+bounces-17594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3839E2DD7
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 22:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D754B63934
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 20:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07313208992;
	Tue,  3 Dec 2024 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eO5yCdF+"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2079.outbound.protection.outlook.com [40.107.247.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF458207A20;
	Tue,  3 Dec 2024 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258241; cv=fail; b=jT5cepVyX9Q003HPxmOPDItYKjv97o+dl9cAvQ2sYi2Ht9fYYfWqGjZ0czG665SwudgtkxjPJY+HeG0klyg+JYTbj7HwtrVM/arH1zsjlhjaOT/VH3DQfgef4iMY2/I4k/VTlucEoYvyyx06Hmz2+4/0S3xIRWOc3CRozqtCa2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258241; c=relaxed/simple;
	bh=CYzhaaTxCf0bfjgS3xeE4SAfmPxICO3mdD1dysE5nTU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LyvlHfJSS+DKRLG2GtfrOfJhxakMMNL46RHkZRXcg7tuH2PFICk/vUe44SMmn8+EtR+ON4hnOCEawwGN7p7Dt5LgZAynQ4xbpZOoMXiW1gT2XZma7He7FJGGD7ywE1LMmJIOTiLT5p00GiFkp/9w9TZKfcV6/9fgaPeWVxcBcow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eO5yCdF+; arc=fail smtp.client-ip=40.107.247.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tx1GMIzWCp9YOhKrYJG+n/8vta/3cwPZTcM3KdA4QkPes+2+qbDMEc/I/U2Poga3QQUv0EswXijWCdJ5Ga15zVvGII65nbu+9z0ZATnMA2kEglU40rQYQ99vBX93Fa53s5s6VO+8GJ4p6TEenCf4FwEL/5ZLIpVrRQB43gAt33Nd4dzPSzN3ZYipRTk+vwHxdyhyOhKfriRYU1PLvnmPFmOxSOvRJ2BwKprLHaZoVuDCD+kIjjvmDzDCqb5UDowTyfiClx+TbtS2uA7LwnveCQExREPlLm/aSrDHJoZuMF1pIda7XYteVDguFnhtYObdUwNWSHuzYXKVlGVJaCgFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qc6rNEIOQHfLuONmH/Q5URdGsc82rTkhcNlw3A3hyEU=;
 b=wRvJizvCbepdDup21Bn9VpF1RL+2fM43OHsG9jxDXPnniKejuSBlK64GM6A9YheeLTrq1rtqoQ7O4gDpZ9soblzGwGB8YJW4dWb/m8GPns0jfveeaBxJymL8b0GW84rA9ICS1+/xQpCv6h4U5+FiNWbmGBJgnvhezO+lpJMKRRVifvMEY3ppIw1m+aci9eHnNKcPloJ3QEn/esRwak1X6K2LAlaD4dweJy6rA1nH5U0Spytfqs46H2qRRYczn5kpO7O5DCtxvdxwAvBDKlmXx4PCfz5Mr2BrCcGSP5Mjx9FgxSYEPl/j74SUb1ViuhnY9PWw0qhYo+7hAkhpCFmohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qc6rNEIOQHfLuONmH/Q5URdGsc82rTkhcNlw3A3hyEU=;
 b=eO5yCdF+QdSToFJ03imfzf099S+YF8g+gzl5yAAiAyzbXxh0CNuo7puQFQ8XLBFoqZeb7khAvhZhwaWuAOiOpYRFRgy5vWFSMRHM02Bxold6Kz6V6csIcZkzly8dkpM6u3xCfNcXyNnz4ndX0EEIthcaLqUP498XtJ149WgGq/uxG6nQ/Pt1xmkHU5S+2fJVCwAxin1lq+7V0DlebpiYly33CYKvF2Wrb5K6tQN5DwvMHl5wtegGeP8t6lf/lRNg6K8Rhq63d6Y3fx0w0BKH4VNc+o3Vpxnpn7u/PQU8bA/XlS9uB1dtGxv8Jw54fwRgoc5hthdL63kQlPoTgK6nFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7108.eurprd04.prod.outlook.com (2603:10a6:208:19e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 20:37:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 20:37:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 03 Dec 2024 15:36:51 -0500
Subject: [PATCH v9 2/6] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-ep-msi-v9-2-a60dbc3f15dd@nxp.com>
References: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
In-Reply-To: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, jdmason@kudzu.us, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733258225; l=6716;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=CYzhaaTxCf0bfjgS3xeE4SAfmPxICO3mdD1dysE5nTU=;
 b=7Na5mclwPapwPDJLqjKuUX45flvuWvukbKCw2Y7BGCgWFsNBh/D0BIF4MVP3TSPe/RJRSwTCd
 IJdXngvQQ3IDGpRs9Gs20sSi4oVsrARSRkzzsUOQHRQEhX7G8tOgAaL
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 51b6b03d-6a20-4aa3-5ee6-08dd13da4767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0RSYzhVYXBDS21CdVFBN1pUR3BDb0UwTUFsanZOcEs2Mnl4QkQ2dnJ1dUdh?=
 =?utf-8?B?VUtUOUZ2RGRVdWg5THdQVTBWTHJrS1NyNzVhVTh1cnpqZHZNU29CcWFHc0xp?=
 =?utf-8?B?NUZOODY1ZEJOTVNtVWdEbVhLcnhLeEV6eTBEME40bm0zODRVNkt5UTVLN2NM?=
 =?utf-8?B?TzNoR1R4STQ4aEhIYXltQnpZRFVTTjRpRHprY2N5UGVXN016VVdlRWltSE1n?=
 =?utf-8?B?bysyUFlPVWcvdkRzeSs5RXBQS1hBOXprcHhNMFBDZk5DdDV4WTlkUWJoSzVI?=
 =?utf-8?B?NkNVd3FxaC95WWc5ei9rcHZKYzU2QlFDVUJDdnlLbXVuV0tYemRtamZOSXdk?=
 =?utf-8?B?dUUyQkJUT2tRb0c1L0Jtb0plTUl4U0R6N0UwcjBZeUcxUTFza3lPay9aYUlp?=
 =?utf-8?B?a2d3VmljNmUzbTJrcU5rU1hMbWtTaTJuSGY4RzhrUTBIaG44YVBKNEpJbmVY?=
 =?utf-8?B?OXBLYk9rS09VY014VGV3T0x0eUZOQlNyYVpONnNtZ1k2T1NpNk9sNGZkNitK?=
 =?utf-8?B?NUdpbEM2NjRWTnpycmxhSCtGQ3d4eW54TWJFblE5RXBsU2lNS1BmcXlybHc1?=
 =?utf-8?B?bnNqNy9kdEtaN3YrcVcrOWR2Q2VzM1BhblpWbTVhNDNTOHdsdWRlZmNVWm53?=
 =?utf-8?B?Y2VpMGlONVpkVzNCa0M0bExoRUNJYjRUcmphOTZQYW5NMlZKc24zUHMrQUFw?=
 =?utf-8?B?THRnRDZpdzMwZkdEN0ZSL01sRUZEMTY2aWpVclBDbDEzbkpOc0hGRW9KR1JK?=
 =?utf-8?B?ZVE0MG5oWEpFYlhWT2ZkMlkxdjBDcE5TRFhnRTc5Y3phOEtsMjZWV1RoMVI3?=
 =?utf-8?B?OXRoclRldGl1L3JueTV1cmFnVEthbStNRlNOUHdtUFIrOTV4QVp0Sml3UGh4?=
 =?utf-8?B?UzZpMDRWTGFFdmp5MjR0WlFFYmZ1eFBMV2Jod1lGaDRzYURPTVlnUEJrSnpH?=
 =?utf-8?B?UTJqaUxPODVCUGlKRlVGOFJZNXNTWnNraS9oSmovWEkvTDJBL3JGVmJyMzZ1?=
 =?utf-8?B?QldWUlRyWDNkeXBtSWwxREdCZGlsTmYxQk92czhmR1BwaVhES0ZURXRMZGR5?=
 =?utf-8?B?RERndGNlYllleEc1ZzVqVk5aZi9rVUY3THhtNE9LWE5OMWh6R0VvQXhXM250?=
 =?utf-8?B?T3ZhM25qZnJoY3E1Zk42TGdSS0pZOTJtQXJXSWlIejhZS1BSSFJhK0psZVRU?=
 =?utf-8?B?NnRhNTE2YitxcnlmdDRsNXhGdHZBeGs5bGcvODdvelM3M2c4QVRlV1RqbmFJ?=
 =?utf-8?B?OTYySnJFSzZiUWhxbzBVaThJYkRVN3NhL1JJanJUWG8vZlhOSVhEWlV0QWFu?=
 =?utf-8?B?UHBBcXRQNnFCTW8xSWpTVVBlc1pUZW04SWNNQktFcXd5dWZiUDBseEp2MkI1?=
 =?utf-8?B?WjdBYkg0NlZuT0JHSFFxUXRkS1RzOFlDcnoycjB5MzhGdWJ4YnFBZEJqMXNu?=
 =?utf-8?B?VEE0VDBnT3RGanNrUmF3UnlpMzFOcjRzVGErTm9JWmV6ZkxTZ2hFNHBUNERu?=
 =?utf-8?B?T05UV2ZTazlBOFFGY05DVk5FMnhhdjNrRjhxMDRnTEJxMWI5SHhnakprZmRI?=
 =?utf-8?B?cXdXQ0dmdUl2UG1qeDlEREYzckRjTHlhZmlNQnpLZTM3OE1DMmpVYi9XR09Y?=
 =?utf-8?B?Tkh3ZTF5c0ZoL0x0R1dLUUdadVFIQjUxZE94OW8zcUhMck1VekYwZk0rWDBW?=
 =?utf-8?B?Yk5GbXJMOVJjSUsrN01ndDNnNDJmMUtjKzVvVHFpODFXNVpWN0JQYVhnQ0E0?=
 =?utf-8?B?THBkZmdvNEFHRzZEOGhCQW96dmVtZE1oTmRZTzdwbDFmYmNvRDVGNWx2eVZF?=
 =?utf-8?B?cGR6UkJSRFJrbmloTklBNzNtZTV6STNKb0gwNkdxMVdWR1MzNWZjM2MzU1ds?=
 =?utf-8?B?Nm5TVWVuaFBqNEd0Y3Q1YXpUMDQwMkVPVTVvVHRRVkFtRkE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEhINnZKSDZ4WkMvdjNoeHdENU1rU2xXTjZ6Qk5PdUpKT0FYcllGQUxjWWlx?=
 =?utf-8?B?Ny9NUlQwTGVHQmoxUGoycVIreEpZbjQ3K1h4bkZaSnc4WUFmY1NpNWZCV0Y1?=
 =?utf-8?B?Q09VSk1PYkMyNHMrb2lVay9OREhWVjhhOVY3U2ZXUkNiK2NWMForTjQ1RDE1?=
 =?utf-8?B?TjlZbit0QXdFNjBZZkFwK3FqMTBCdGVaQWNZWWJqeFNoSzJjWUJ1VHZ0cVBN?=
 =?utf-8?B?S3NmeDZxekpWbFkxZUkyd1QrTEhMVTBHcVJ6djZ1QS9pY2h6Wk9TUU9MZVcz?=
 =?utf-8?B?MlFheHRCTXMxNU9OdzhENm93MFRxK2o3Z1lNNmZ2SytKRUtrYUM4a1pvd20v?=
 =?utf-8?B?YUV2ek1adDZRM091aVlJcnBLejJPWGQwdzhYcm1UeEdKMURBdWlORlg0VW56?=
 =?utf-8?B?aldJVjQyeEhzK2dXalUrdjBnTzdPTEdPR1YzcEVpRmpSLzhCS2I5TzFUZWEy?=
 =?utf-8?B?dThlRXR6YmE4TlFaWG9JMFJSNHFuZlBRYXMwVmg2OVZzekE3d2I3eCttT1Zz?=
 =?utf-8?B?N2p1RkwycWR4V2hJN1JHMXRFVWpLOStCUmJaeVMzYTNPNGJOdHh3TmlQQ09K?=
 =?utf-8?B?VWV4NC9hWUdOK2t6SkM2VERTMmxKZ2hlV2QvdEo0SjZ6VENrQTdmcDlvbTdm?=
 =?utf-8?B?WTUwMmZTeFl3WTFQQTJBSnN0OC94QXhVTWVGUjFQa0VKeWlKNUdXb2RGUHZ6?=
 =?utf-8?B?dTgzaFQyWTRiUWwvcTVHVktJdFpGbnMxbXdVK3lLWkl3Y3pNRExNcVFSb1g5?=
 =?utf-8?B?aDVCdWpyTHNhYnFsNGJmWWlGanZ5QzQ2STBWMk9xN1lWdk4zNUpYTUZWZDNj?=
 =?utf-8?B?eGtKL1VuOVRBM0J3aVFGdCtqYVVIQURlM1lkL3JsNDNPMHdSa0F1VXFtaTVF?=
 =?utf-8?B?ZDY0eENSbjZ3TEF5amxKN05LVTZjaURXN3JIQVBvUU1PRmF2dmQ1ZFdibC95?=
 =?utf-8?B?RnR1akJuNmpwZ1ZESUM1R1hIU21Xa216OHZhWXY2dVBHZGlRdzFtYm1CWHJu?=
 =?utf-8?B?SEk1allWdGloWXlZMHhUOWZiQXZlK1lpaG5sWTh4U2FXTk8xaGRnNlVzNW0r?=
 =?utf-8?B?U3lPQzZia2FIRThDdWRRbUpTempxK2VDZ1VWTm1mRU1EZUFhbWNkVzlVZHU3?=
 =?utf-8?B?Rnd6cEJoZmo5RE4zcUVWK0g4aXJNejAyaGJSclRvV1lud0tzWUg5Mk4xazBr?=
 =?utf-8?B?aTgxVjVFaU9JU05xTWJUT3p5UFIxQ2tKN2MrNmtBTVhkaVhwenY3cHpkM0xj?=
 =?utf-8?B?Qk5OSk13ZjZzK0ZLODljdWhQRUtsZnFTTXJ0WVUzMERFMHhqUkV0NTBUcUxE?=
 =?utf-8?B?WjF1OThROE13RXp3aFIwSnJrVHVZNWFlZERHSWZTTXVWb3d5RnhaVGhGVUNV?=
 =?utf-8?B?UnFFelZHOThyZDA3cWpVQ1ZoZ0NaWkNmRVhXNlJWcFBzOHp4eXQrOG5NbGtB?=
 =?utf-8?B?ZVhqQWdnZGRvQ1RwcVZWbS9PTTkzdWFxR0xoVDUvMjdJam8xWWFuN0crZ3Ry?=
 =?utf-8?B?cmphQk5URmhxazhoYWRNNXpkTHBVb1Z6RzFnRDRCajBTemlQbzlnZ3ZtaGZr?=
 =?utf-8?B?aS8veEJ1SEJhaFk3VmlJaEJaTTNheXRzZHpmdk53UnF2WFFlNHNSRDlOSjJn?=
 =?utf-8?B?dHdpWGhyYjhyMjhSbEZUb2J6elR6M0U1N2NZMVNiNllMZ2haUTh5anNrNlpB?=
 =?utf-8?B?RUVseS9zejEydTFnYnMvWGhIM2E5VjhmU3V4RGszSGFzWmtBdHpuRGdtMkYv?=
 =?utf-8?B?WEdDRXZBR1B2TEZZc3JmL0ZQNlRINysyNkVZellsb0pRTmJmWlBmVlVoVHhK?=
 =?utf-8?B?aWcvOGh1VEZrck5IdXBkQTBzdWJmTnlaOGl0MzNsbzRiUTRqZDdtNDlQdGFq?=
 =?utf-8?B?eTIwaUVnMVlITVB6eStxMzI1eURybzkwQ2ZVZ3BoNFNlMkRmdTY4SWQ2WEJF?=
 =?utf-8?B?NXFRbkQxbUhta2Z5Y3B4V1lMVFZ1a1VUam9VSmRmWE42NjhBYUFqNU5wL1hn?=
 =?utf-8?B?WVdHMUUzZHlWOW5CVmx2OWVQY0oxc2MzTU9qd2F6ZUx0Nk9wcVdFOXY4RjVV?=
 =?utf-8?B?Z2VQQlc1allWMjhNMlVBRVZGRXZBVGE3NDVqOHhmSkZuYkhPbGI1Wjg3ZENx?=
 =?utf-8?Q?tvSw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b6b03d-6a20-4aa3-5ee6-08dd13da4767
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:37:17.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3smYZyPOqBZVc+eaTcNBEWOFg+xrUjCg4jwNep+YIBNHaodUWo407/meWnBnQjQV/JVVH0ucnqOlYC5mBw6qJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7108

Doorbell feature is implemented by mapping the EP's MSI interrupt
controller message address to a dedicated BAR in the EPC core. It is the
responsibility of the EPF driver to pass the actual message data to be
written by the host to the doorbell BAR region through its own logic.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Chagne from v8 to v9
- sort header file
- use pci_epc_get(dev_name(msi_desc_to_dev(desc)));
- check epf number at pci_epf_alloc_doorbell
- Add comments for miss msi-parent case

change from v5 to v8
-none

Change from v4 to v5
- Remove request_irq() in pci_epc_alloc_doorbell() and leave to EP function
driver, so ep function driver can register differece call back function for
difference doorbell events and set irq affinity to differece CPU core.
- Improve error message when MSI allocate failure.

Change from v3 to v4
- msi change to use msi_get_virq() avoid use msi_for_each_desc().
- add new struct for pci_epf_doorbell_msg to msi msg,virq and irq name.
- move mutex lock to epc function
- initialize variable at declear place.
- passdown epf to epc*() function to simplify code.
---
 drivers/pci/endpoint/Makefile     |   2 +-
 drivers/pci/endpoint/pci-ep-msi.c | 106 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ep-msi.h        |  15 ++++++
 include/linux/pci-epf.h           |  16 ++++++
 4 files changed, 138 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 95b2fe47e3b06..a1ccce440c2c5 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
-					   pci-epc-mem.o functions/
+					   pci-epc-mem.o pci-ep-msi.o functions/
diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
new file mode 100644
index 0000000000000..8f92f447712d8
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Endpoint *Controller* (EPC) MSI library
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci-ep-cfs.h>
+#include <linux/pci-ep-msi.h>
+#include <linux/slab.h>
+
+static void pci_epc_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct pci_epc *epc;
+	struct pci_epf *epf;
+
+	epc = pci_epc_get(dev_name(msi_desc_to_dev(desc)));
+	if (!epc)
+		return;
+
+	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
+
+	if (epf && epf->db_msg && desc->msi_index < epf->num_db)
+		memcpy(&epf->db_msg[desc->msi_index].msg, msg, sizeof(*msg));
+
+	pci_epc_put(epc);
+}
+
+static void pci_epc_free_doorbell(struct pci_epc *epc, struct pci_epf *epf)
+{
+	guard(mutex)(&epc->lock);
+
+	platform_device_msi_free_irqs_all(epc->dev.parent);
+}
+
+static int pci_epc_alloc_doorbell(struct pci_epc *epc, struct pci_epf *epf)
+{
+	struct device *dev = epc->dev.parent;
+	u16 num_db = epf->num_db;
+	int i = 0;
+	int ret;
+
+	guard(mutex)(&epc->lock);
+
+	if (list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list) != epf) {
+		dev_err(dev, "MSI doorbell only support one endpoint function\n");
+		return -EINVAL;
+	}
+
+	ret = platform_device_msi_init_and_alloc_irqs(dev, num_db, pci_epc_write_msi_msg);
+	if (ret) {
+		/*
+		 * The pcie_ep DT node has to specify 'msi-parent' for EP
+		 * doorbell support to work. Right now only GIC ITS is
+		 * supported. If you have GIC ITS and reached this print,
+		 * perhaps you are missing 'msi-parent' in DT.
+		 */
+		dev_err(dev, "Failed to allocate MSI\n");
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_db; i++)
+		epf->db_msg[i].virq = msi_get_virq(dev, i);
+
+	return 0;
+};
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc = epf->epc;
+	void *msg;
+	int ret;
+
+	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+
+	ret = pci_epc_alloc_doorbell(epc, epf);
+	if (ret)
+		kfree(msg);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
+
+void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+	struct pci_epc *epc = epf->epc;
+
+	pci_epc_free_doorbell(epc, epf);
+
+	kfree(epf->db_msg);
+	epf->db_msg = NULL;
+	epf->num_db = 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
diff --git a/include/linux/pci-ep-msi.h b/include/linux/pci-ep-msi.h
new file mode 100644
index 0000000000000..f0cfecf491199
--- /dev/null
+++ b/include/linux/pci-ep-msi.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Endpoint *Function* side MSI header file
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#ifndef __PCI_EP_MSI__
+#define __PCI_EP_MSI__
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
+void pci_epf_free_doorbell(struct pci_epf *epf);
+
+#endif /* __PCI_EP_MSI__ */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 18a3aeb62ae4e..5374e6515ffa0 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -12,6 +12,7 @@
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/msi.h>
 #include <linux/pci.h>
 
 struct pci_epf;
@@ -125,6 +126,17 @@ struct pci_epf_bar {
 	int		flags;
 };
 
+/**
+ * struct pci_epf_doorbell_msg - represents doorbell message
+ * @msi_msg: MSI message
+ * @virq: irq number of this doorbell MSI message
+ * @name: irq name for doorbell interrupt
+ */
+struct pci_epf_doorbell_msg {
+	struct msi_msg msg;
+	int virq;
+};
+
 /**
  * struct pci_epf - represents the PCI EPF device
  * @dev: the PCI EPF device
@@ -152,6 +164,8 @@ struct pci_epf_bar {
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
  * @event_ops: Callbacks for capturing the EPC events
+ * @db_msg: data for MSI from RC side
+ * @num_db: number of doorbells
  */
 struct pci_epf {
 	struct device		dev;
@@ -182,6 +196,8 @@ struct pci_epf {
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
 	const struct pci_epc_event_ops *event_ops;
+	struct pci_epf_doorbell_msg *db_msg;
+	u16 num_db;
 };
 
 /**

-- 
2.34.1


