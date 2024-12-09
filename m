Return-Path: <linux-pci+bounces-17960-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D06E49E9D79
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 18:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C537E161DDB
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 17:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47C21C5CA1;
	Mon,  9 Dec 2024 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l9Yio8FF"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2046.outbound.protection.outlook.com [40.107.247.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B111BEF73;
	Mon,  9 Dec 2024 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766550; cv=fail; b=nIIC5H8TvEUqu8MAWgLddq1K5N7zjmHi4x89vGYDPGHedLzm/bLjmZug7RO1yrpKTwZNr/+MAIy9C/TGNWWHMPyF7DJyCR/dtMXN6O0XvUED+Q8XKeg2tCoXOUdMdHsFfFMdOXKNzj/m8xP2ls4VUBv5i5kSLIPJw85owhfDYSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766550; c=relaxed/simple;
	bh=nOdTcGsplP67pe89t/lWexxXwRfnbNq0CbahLICCrsE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=l/vOkECBCyWqZSC6HbuL6Bfrxjo1fEx4lwNL9wWCBLSQJKkUafxpoDG6A21k0mDj/5gHSC+mL7Klo2ComN25mFL2YCGZwURQ8an1D+NKwGqMACa0c4GHy61fGBqrZc/I47ALAKLCFyq5GK0D2IzTzsoqvN0PY4La/eQY11Gmgio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l9Yio8FF; arc=fail smtp.client-ip=40.107.247.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFpd5+NAQMmFCP+pzEOSu7DJZ7aqa75pKDJGJlfqgmhMgtGTPUWppC0JcD57S03q8miulXn1O0DYNGawiqMbRGIJs1FwhAGnMz509EXD+lwu2DfrKaENqX48tJWTgIoPeoofka7YUeh2vdjZ+EYz/ZbqwX+pP2oa13Vnl0W0ydBruEFaW5j0Z1wJ3QzPT/tctY8C+W68mLPePKjiE0DJo03L/8pNiqj16VIvmmz9EWfK+j3oP1ULTUVIR88HU3jAAfFwD7L4nwVXq8rzeSGyeMXEYtidGBnGTORMis8KZcqrF7MkwXTjY5hZG7g+Ia7gEoo9A+M/9gycWpiwrKmMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrbcNtRasZ3J5xRN5xIPVWVszaYiQrxyw0UpP2GGNOs=;
 b=RrxOOgzFCReW5qbvZ0J2sD7OPZcH+sRP3L6hfV2Juj7HFQi9D726kgR0Ka0mZ6ur/TEOW1BUO5vyE777HybBhX146wy5WdERHJ4C0Opt7bYne3sBRnDBSzY2JMq6C+s0PSqI0Bck+mVuXZFPRWXb7rDhhscZvY/JklLm9oKv1CfxkgGL9zsxncKPNGYP6BvpC8GT0fH9AdU/+j2P4mNN0CHzA5s3rSl5BuBF2ePUi6E48ACKVyz1wvG8QDgm1n+ozcFIjUbcNf8lralprr9ZJBwcJXe3JzAGCVclXdNraU8enw3IS9W+2U/VctDoyTgPUAuu91mprNHg4wNw2XyCLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrbcNtRasZ3J5xRN5xIPVWVszaYiQrxyw0UpP2GGNOs=;
 b=l9Yio8FFW3tv6e049eSbpVxfwMtVgPtDu44nLaMDX8evtAlewSr5aJdejPUe/oL7EC+Lx9z/L6QaIouZCZQC2Yi8HSnB71HBA45B/zDnPt4n0ITlHjTZ4SAg6ausjcXh0/ujsq/PfQUPHa6PVDn6liJajBQ9sEI/OvE6lOmzuUdEfkQ+Qhri4VQeOxoleiuxUcENUgJlxiOJNymrBChScpIpyrDqlA2uF3UZbi0pOWYcz92MPVokh1RlsADKKS+sqTvxMD8l3EbZl5ZEWC04Z7lziMheGNy+Qi+wW8dQczX87KnJPuHUSL2T4q54baod+9JinT3D8RCOLJXb+DfgrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9485.eurprd04.prod.outlook.com (2603:10a6:102:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 17:49:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 17:49:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Dec 2024 12:48:20 -0500
Subject: [PATCH v11 7/7] tools: PCI: Add 'B' option for test doorbell
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-ep-msi-v11-7-7434fa8397bd@nxp.com>
References: <20241209-ep-msi-v11-0-7434fa8397bd@nxp.com>
In-Reply-To: <20241209-ep-msi-v11-0-7434fa8397bd@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 jdmason@kudzu.us, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733766511; l=1851;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nOdTcGsplP67pe89t/lWexxXwRfnbNq0CbahLICCrsE=;
 b=ZEtULO/MfiNHjiByrLc2lg/EpZTMdmcewapzhTVji0QmZrEurBIs+ciwtyS7UwcMz5AYau0yy
 kQ2vCkYBLeSAJ//UecOCZEPhcZ4pg8bBJJnNHqtfs6u9rjwGJIVJ2GU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0070.namprd17.prod.outlook.com
 (2603:10b6:a03:167::47) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: 1493b9dd-235d-4bcc-df46-08dd1879c5fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1RRN0NXMjgrZ0pUcGRqTVpSejhHK1pCK1QycWZleW5BeExoTEFIdE5Ceitw?=
 =?utf-8?B?WDhTRnJPdjFDQUx4TWVQWldYa1B1ekg2WjBHR0ZJb0l2a1JJVXFDdE85bXNo?=
 =?utf-8?B?cEhqMEZNSW1DVzFSNUtVaGtnZ3FBQStWT0t0Zzc5SVNHRWw0MmQxSEZKVjNO?=
 =?utf-8?B?TDR1K3lHZDNmSGR2YjFYVFFVNXZsemRQUEtnSGx6M2E2THlBd3VJMUQ4TDEy?=
 =?utf-8?B?VC96SHVtSGN1NzdEckh4KzJYR1dNZmhrWGV0alFsQkY1N01xN2R1MHBjd0Zn?=
 =?utf-8?B?Z1RLaUpML1hBcGh3YUwyV1dOemlGMHJEYXc2WTRnejlUek5INEQ4SXRpVmgy?=
 =?utf-8?B?ZVFOYXBZemJDR3p5S3ZVWmJTaDRjb0xLTm1NcnphZytaa2RkUDF6WGNhcXpO?=
 =?utf-8?B?ZGFQMEwvSEZmek5YOHJqZ1F5cFVsajlGWGl6c0hreVU2Y3lnTGdEcjl1b3Bx?=
 =?utf-8?B?VU5aZG5TZkpLM1N1MFMzUTZzSzVUSiswb1RRVEEzMVAvdUdsSDNXeWpjL0Uy?=
 =?utf-8?B?SGs4WGVjbnZVbExpT0ZVRmpLbC9QbjF2dFNlQWk0NlBuMVRLdzJndzBoMlQz?=
 =?utf-8?B?bDdId1Mzd043d3hybkpxYmFWdUNtSE9uNkxQNkJWeSsvL3dtUUlxa1Riald5?=
 =?utf-8?B?MHJjZmg2b2hMQXF6NjhJRWhaWEdnV3orWHJsSWUwaXJRRXNHZGRKUVAwOFVP?=
 =?utf-8?B?UDQ0K0hVSXFlN1owd256WVpuaXRVb2dKeXp2djNMWHRnRDdFb1pzU1B5VFo4?=
 =?utf-8?B?amVHN0EwUzFsYUpvSk9GbG85S0hkZ0pEL2I1N3FqSTF3aEhmekRkSEd3RDBC?=
 =?utf-8?B?VkR4dHRFRVduZC9aWmdyV3V5Y0JwYUNBZ3R0VWRqUjFxU1dUUUxkeFRNNTlj?=
 =?utf-8?B?VUlkQVNkUWZFMzYyeUFCc1FncFhsUkdGelhIcEFQeSs0cjhxM0FSdWtDRllK?=
 =?utf-8?B?eEI5YlU1ZFF0UGZPSDVuZHB4ZnhJZDd1RWlmUWNsYWRaQ0pWOG9yNkh5c05G?=
 =?utf-8?B?aEZreDQvVStDelNKNklUR1BpekxDRTU1VkdrQXNpZks4cWJUZGxlaWdEM09X?=
 =?utf-8?B?TzRWVVF2K1oxVkIxbms3M0FldVJiK0g0S1ArQXNxaXo2R2dXRTlvd0p5Ynk3?=
 =?utf-8?B?MWhRZi9wVzJsVGxJcXlnQ0lOaUo5djQ0ODM1dEgxVDlVUFptUTJpTWRoRm9v?=
 =?utf-8?B?aktvZjZ2Y1ZDbXdTOU03cVZxY0QzTDVUeXZRVVUzZkx1UTNDNjJKL2IxNmRC?=
 =?utf-8?B?RFQwaUNmUU1zLzNpTDJqeXVuSGhaOFpTQkRNVGFLN3UzM2h3ZmlhWUI3STA4?=
 =?utf-8?B?WmlzRDE1QjM0RHlsRCtNZXV3YVVYeFNHaDg5c2lBYXlKckZkd2pjTTBUWDdL?=
 =?utf-8?B?ZG9wSGZiN0VMRzN4eGwxRm90akRoYStsdkxWRCtPVW9Cbnd1MElLVE5yYUc2?=
 =?utf-8?B?Yk1CdHFZa3VwNzNDeWFuQkdPUXFtL29Za285eTF4ZnBYc0FmN0pXaGhHNUM3?=
 =?utf-8?B?UVAxS3VTVkpyOXlYZXpFSUc4SlB0RkM2WTJqY0IzbndmNi9QSE5sUURMTW9B?=
 =?utf-8?B?dkhNV1JJVTRIa2wxSzZ4c21BaDMvdlpWa1NtVHlla250T1laMGdqNFBCU1FZ?=
 =?utf-8?B?RVFEUldWQWZBTDVIZkFFLzlQL3VJdDlzWmpLMHNIcVJNTWt3dktaVnR5aURI?=
 =?utf-8?B?ODdHUndwSWJ3MURTM0FpUmQ1N3E3SG9RbjkwZlY4TnViY3EzK3Znb2xFM25w?=
 =?utf-8?B?cm1GZnZaU3llNjl3WlM3WnZxMndRelp1RVdNOFdxVDJxcTMwcXRodHhnSXd1?=
 =?utf-8?B?b29CMDhWOGtESzRzdURVdWM4ZzdCNGNwaVVabUo1K1VKenlhSTVSMm9Fb09n?=
 =?utf-8?B?N1R1eGorRXBIQnI3dmtNbHpLalE5ZE9kM1NVWHJIZ09Pc25VMjU3L2RMMjFR?=
 =?utf-8?Q?2LTfTTK4QQA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1VieXgveDNvcXJtdDcrNUZ6RmlHTVprN0Y5cFAyM01VSVZZUXd3d0JHL3A4?=
 =?utf-8?B?UmZBTC80UW9LNm82Ky9OUTNnZjBrME9vRTBjYTVIZEdRbEhCVmZsdUFoSWRR?=
 =?utf-8?B?U0wyZ0QyWlc2cVVSWk5kUTVOSkdvVml4a1Q5dmxpRU9Hd25iSWdyNkhxY2pH?=
 =?utf-8?B?ZWx1enNMU0pRZnh1NGxjWUE1VmE1d2lqNUhQWVJ4V1ViRW03dGdBRzU0UVdX?=
 =?utf-8?B?eHlXWUtkbmlRU00rTldUN2RZWkg1aUJaWnRONXpoUDJkaGdWZjVGNXhBcWpx?=
 =?utf-8?B?Q3hRakxpMklUaEVOd3NVOWN2K1laUnBjVHRMajBxWThBTHhXczF2dFpna3pS?=
 =?utf-8?B?YURKR1pvZnVWZ3FCTjd0SzNsZGE2d3pRU0ZHVDZrWStaY0JvTkFWQWZ1Sm5r?=
 =?utf-8?B?Y2NvK0dGWWJtVkxka1UvL3NlYi9HZEZIbDl5dU9rMVprL0hQVzZIRkhrN0VN?=
 =?utf-8?B?TmlWRU04dmlacWs1ODhXNUMweEtHT0JmNGlEd1FUejI3YUJoNnpucE82OUhQ?=
 =?utf-8?B?emZpbkszcWpsY0tkY282Zk1LU3JjQ1JpaWc2YXNPalNEOXc1eUdKY0xGRm1D?=
 =?utf-8?B?Z0lZWjVraVBkUTBuOGxUdmJKUmxzUGRHUThhRnpUWnhLcTBkbjFlTXlQaVAw?=
 =?utf-8?B?eDBlQ3Y1YnZYOUgrL1ljMlFVWksrNEltMGRhRlN5aHZ4dkgyRi9SOXozWjZm?=
 =?utf-8?B?YVFVR1p3eTZSbE9LKzQxZ3FBc3M0UjFmcC94R1B5N3Z1WVZwTzRBOGczdHBv?=
 =?utf-8?B?SHl6MXZ2OExOMmI1Rk9WbDF5WUN2T3JuOVRiZ1ZFeDAzOEV3SjM5N1JTT0FV?=
 =?utf-8?B?Y0FRcHFrK3VDV3lYV2tvL2cwb2M3ZnV4NHc0TWRHK0lxc3R1VGZnbXdiamRw?=
 =?utf-8?B?MXd2WEtJVnczemYzNzZhM1hhUGdhc2xvMVFBVzBCYXJnME5EN0pyUFFMa3Yr?=
 =?utf-8?B?bGljUXRXSW9qMW1rSHdMRDYyRUt2VnE4ay80WVkyTEdIcklETnp3aVpocGtz?=
 =?utf-8?B?bmZZMGE3L3E0blVOOUtWNUowUXhKQmdVL0p3aDZ4TkRlMkFrRjRxR3cvdG5H?=
 =?utf-8?B?bTI3MDNjaTQ5dVNueExpRHV5MGE4bEFuYTdhaWZrLzRIV3NEMTdScDFMTkdY?=
 =?utf-8?B?YmJXM2UzY2N0SXRsa2hNemlMYWIzN001dGZkNG9Mc1BNOTN3c24vQ0I4R3R2?=
 =?utf-8?B?Nys5dndVS093NkdWdWc3TVhxelV4SFhlVEgxTlpBUXlocURyUHpnOU9ZUkxa?=
 =?utf-8?B?ay92STlMU0F5U256QTZrZjNDZlNFbXA0MG53bWM5T25mR2dNNGd6QmxMMi9D?=
 =?utf-8?B?TUlXeUs4SXVjaTdSbk80Tk1tTVZWUDRHZFpUUmJRdDlQVEVMR0d2RkJQdmJ6?=
 =?utf-8?B?R1paeDh0aHVSeDJqSThrTGp0RW9ISDU3R1Jvbk1pMk9aM0FXdEJaZkMvKzkv?=
 =?utf-8?B?dEVWNjg3RjRmOUR6ZFpPZjdHalZ5bmJTeHJVWW91NVhSR2NvSXY2a2V5NWpi?=
 =?utf-8?B?WmJxR3AvUm5vQ1hXc2praGNWZjNmY1dIMFU5bkJUSytYK0tQSTY5NXM0a1JH?=
 =?utf-8?B?Z3kzYnE1Q1JxZ3ErT2Z6a2w1SEJPWTRFRkFza0dUQ0s0ZllZaEdQV052TktM?=
 =?utf-8?B?djJxa1RUYlJhOFBEZ0Mrd1RmVFFnaysyREV3SlpnbjNYejkyZGdnTEhzOElU?=
 =?utf-8?B?d2RkRzM5ZWh0eU8zeS9LWW9adFRzUTFxQ1dBU3Fqb1hFWXVVUFgrbTc4bHJh?=
 =?utf-8?B?UXZ3LzJ3SzM3Nks2K1dSbnpuYi9qVnlTTkhhMnkvbUZEK3AzUEh2cmo2N2Yy?=
 =?utf-8?B?UVhhcHlDQWdLYUw3OVo2SW85WmZFOVVTR3p1TFFaN0lHd3pJWU9iVTJEN1Zu?=
 =?utf-8?B?b2pRa205aW5LaFNFbklEcHloLzVKTzFkR1RoVFIvaGdxME96azFsVHc5a3Y5?=
 =?utf-8?B?ZTRsTE5VWjAyU2tZa1Qvd1J5eWtZZ3FJNXplSm8xMzhPRmtpT1Mzd0pOMkY3?=
 =?utf-8?B?NkRDNmhDaUJSQnc1Z0lrbmhLV21xNGZlYnJFWUZXc1pFbXZPSG9ySEhoNE9h?=
 =?utf-8?B?aWpVNEVYc3lwZjdkdjA0Y3k5N1I5MkVZZ2FONXRWcGp1WWQ0VE9kRllQTDg3?=
 =?utf-8?Q?Au5kPHxrzxBcFeVXnne5z1/eZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1493b9dd-235d-4bcc-df46-08dd1879c5fd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 17:49:04.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5P8YhVr0KwH2q1mONUdgTvElUDke2V6Pg3ZFIh+oQAhiJdAGoZp95baBHQB5+z+gZwxeeDKQYElXA8ntI+Isw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9485

Add doorbell test support.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v11
- none
---
 tools/pci/pcitest.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 7b530d838d408..fcff0224a3381 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -34,6 +34,7 @@ struct pci_test {
 	bool		copy;
 	unsigned long	size;
 	bool		use_dma;
+	bool		doorbell;
 };
 
 static int run_test(struct pci_test *test)
@@ -147,6 +148,15 @@ static int run_test(struct pci_test *test)
 			fprintf(stdout, "%s\n", result[ret]);
 	}
 
+	if (test->doorbell) {
+		ret = ioctl(fd, PCITEST_DOORBELL, 0);
+		fprintf(stdout, "Ringing doorbell on the EP\t\t");
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
 	fflush(stdout);
 	close(fd);
 	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
@@ -172,7 +182,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:x:i:deIlhrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:BdeIlhrwcs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -222,6 +232,9 @@ int main(int argc, char **argv)
 	case 'd':
 		test->use_dma = true;
 		continue;
+	case 'B':
+		test->doorbell = true;
+		continue;
 	case 'h':
 	default:
 usage:
@@ -241,6 +254,7 @@ int main(int argc, char **argv)
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
 			"\t-s <size>		Size of buffer {default: 100KB}\n"
+			"\t-B			Doorbell test\n"
 			"\t-h			Print this help message\n",
 			argv[0]);
 		return -EINVAL;

-- 
2.34.1


