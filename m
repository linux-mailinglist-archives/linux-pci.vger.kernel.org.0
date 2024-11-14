Return-Path: <linux-pci+bounces-16800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA48F9C9567
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 23:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AEC7283278
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 22:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1ED1B21BC;
	Thu, 14 Nov 2024 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V35hZwqm"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013009.outbound.protection.outlook.com [52.101.67.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4101B219A;
	Thu, 14 Nov 2024 22:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731624784; cv=fail; b=GyfE6KIA5EhOpSFwBy6+Uiho50U/IhHiJFTN3pMyma8idWg3WFjHZFnY0Dg6zUTU0tUgE0abV7c8erscQzDMqM4spSl79KdSTrGj9uyKJLDvR+dhMJ+X6Jt4hQXwTH0Cv7uyY7qkRX4uPkPtOhPjm+CKVMaEolmaXrP38DNsQEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731624784; c=relaxed/simple;
	bh=NrKifoN1fmq3Tc8fKoWlpGpdQXpHuqlY0N137rNr0VI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HwuklcsRZzr+WttofqXc1C2bOx3x2m19HOs4QJsLnB0CfkNgejqbs0NdAlBktHCeCfeuBN9XRPTuMRr6kKLmf3xyhKqbaCYz49FhoWH0TCuU2/s3kfwz6BUDw8//OtqIx1IlWng6016upclaAFp/A6x3vHGPRhge4zt0+4fDS/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V35hZwqm; arc=fail smtp.client-ip=52.101.67.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/8+ow8iBEjbj41VXvfMfk/OB7s7Tr34iT0Q5Stc35BGBpPkGIxpv3sHN0GJBeifFKQvRMa2fUNofx2Jc4nPnib5SCneZS2uuPoc+GEupn12X44Dnz2GTfM0SD4pqDntzqcYR6wIg/2cenlbhE7m0P6AeQLjPYrnpeyvZIE1+5P0owx2ZWEhUaJKT9bMaoK8Gd1MAq1WwpCAXh2Mr7SrqkWbwnxB++aZPaH53HnazUnISwrNiSQZonwUF2NHcQdZAQnjDtttR/qLPLzm3v7bc2WQgqA0EqISHpvbP/7Vo8xLUWO4Kjl8Dib2raUSTQzBE20OK4XnXETxkuwRh33eXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97UWWYJzp/qrNarYH1kVajK0y5wQMq7H3SLhCi+mabM=;
 b=IC/52BPpisd3yxHRs4XSAMZLWYhkEouwdCrykH+O7AMp+2s8J2pW8Qg0JJwXTkkCa9G/sjIkY2a+EV37NZTJYysxKvBmj+lGjqUP8yoBzyjJxF9s8GYsE46gywM3EG351hRG4elS3GmjQIieUdY20QW28VpEyb6IkIy+2ZgkyPccxqFZrdcqhQfxrEzZxIJZYTFcH+ecAaW22+NVEnSAAuYn8EcNj/5uOdD9gFQb1HqLeS2myVDu1rvK2llVasWoSzv0uyDxhqG6dy/2g05t7UJntLqkQznE/5dsane8rZvzvYraVQ1c2roKYRSeVcMPhCwNqK5Km1ZTxHaeklkyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97UWWYJzp/qrNarYH1kVajK0y5wQMq7H3SLhCi+mabM=;
 b=V35hZwqmyM/cGct4CzQ/p0SBXwgZplqu707YnGpBR3ekh13d4v+6YG1oK0q9llkOSKsYxgkcaFYC0ZMo8yDByp7pWPRvzZWcRn25YlJpTs4Vhk0PQ6po31O1XxaPA0Vur5E7M6KrBqcWSwVp2tub5x1aHQlDfDkhxfEvldgaD8GtB1BfA3gWFEuwVlvTY8sgUjzT5yE01LqM1VLCvtVCbmERNSpX3J2KPeYX2OsNPuhZrUIrBu5pMedlOkQEPs6v0VUBh87u4LwgC6TkQ59vHr9LYEbS5jIaoYrHjI6GAIHsA1yd1mQl9NZLD+gYmicfeR9vP5DAuPROhVxloEelfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9967.eurprd04.prod.outlook.com (2603:10a6:10:4dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 22:52:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 22:52:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 14 Nov 2024 17:52:38 -0500
Subject: [PATCH v7 2/6] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-ep-msi-v7-2-d4ac7aafbd2c@nxp.com>
References: <20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com>
In-Reply-To: <20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731624768; l=6297;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NrKifoN1fmq3Tc8fKoWlpGpdQXpHuqlY0N137rNr0VI=;
 b=+dhFZexOlmiNWGCmaGYzMnUICE36RgzqikUVOQnHKaHm47Tm2h9Jm/2NGci9z6i9OG2MzMOmh
 xmHaZTkOifVBRLzTvkNasACSNNZ1TS2fP/h7KBEf1rKFI6zQYL4/JSz
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9967:EE_
X-MS-Office365-Filtering-Correlation-Id: d1460550-54d1-424f-e012-08dd04ff166f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFZ2RFM2TWN0ZisvVlh1WEV6aHVJWFB2TjF5M3NWQ0tjamJOSEIrMEpjbGhz?=
 =?utf-8?B?ck1WQW5yU3Zyam5iUDB6VXJneURQZHlTTzhiaVUwemRIYVRQVTYvQ214QzNa?=
 =?utf-8?B?cFNpQkh2Lzk3dXVweDlCdDRuczV1OE8rR1pEcEl6bVF4WlgzNXZ4cmIzTStw?=
 =?utf-8?B?ZjlzUnZRNUNJYkFURk1NQnQraExCd0FvUGhJMHBtTnZCSWN5V0g2SVA1VmQ3?=
 =?utf-8?B?T1l1MDlVTVJJc24wbzAzZWthYTNmVFVJbmdUc2xEYitROXIvL2ErODVHcDNY?=
 =?utf-8?B?NXVQNHdMMVZNWjBhajRYdStJTGF1VEhXL0JJa0V5eDBYVm14MmszbDRlWllk?=
 =?utf-8?B?OEF0R2d4anRDaVJPdVVHcGJmK0pRMVBFMVhSYWF3eWJ4dE1BNHo3R0xua1Vm?=
 =?utf-8?B?Rlk3aUNxbFBjVTZtVFZsc0E5R2VRNENuRHJQSXFKUzFoMmhGQXJZMWNqbUwr?=
 =?utf-8?B?QjMyeG1DSzBSeXArZktqNkdZVG52RW5HbG5YZjJEbktCdlpUQWd0MXRRNDVt?=
 =?utf-8?B?WUpwejh6blV1aGtxYjhNMmNpWFdRa0pLSm9tTko0MzdnZWpYZ1lsVW1uMk5O?=
 =?utf-8?B?VE1mYjNpTmpIU1VPL1lUS1F3WUlsVFFDK1JOVk0rMlNCTGtEVTBsZ2NyaGND?=
 =?utf-8?B?dDdWUURWWFdFZUErUjdyM2JVZ1ZXeW5URUw3NUpFNlBOTGREZmtMaFUwc0tV?=
 =?utf-8?B?QW13WWpXRm5aamtTelFLeUZSbnhjcWoyQng3SGEvVFZyaFljc3NFVGtydk51?=
 =?utf-8?B?YmNNOGVFTTkzU3gyUlhSeDJna09vd0h1eVlVcHNmT21lbnZqMmt2UDFtYU9p?=
 =?utf-8?B?QWpmWWZqZWYzSmRUSGhHaDJFcGdnU3Y0eDhNZTdoL05lZmJvNDdyQktTSVJV?=
 =?utf-8?B?Q0xnZmJQVGZZUzN0OVBoTmFQWFM5VWRMb2JmWVpoQ1UzQ0RZclVFZzh5Uzhp?=
 =?utf-8?B?SlBLaUJuODJ0T082Rk40Q0JsVnlOUFhVR0RxYzBmZUpyd3crVDJTaTFGbU5X?=
 =?utf-8?B?NSs3TlQ3Sjk3WmdBZVF1akNvZ0xSbDRBY1AvUTUzUXgvaEhIR1d3bUgzK0t3?=
 =?utf-8?B?eldTVVRIMXNDVnBSQjFpelM3Q1NxWW9sdGU4cytlRVh2YnR2TlI0blFQY0FV?=
 =?utf-8?B?Qzh0VXpzNjZ1Z3dDREEzeDE3a05KTXpIbHRrVk5sZkxUN2NxdjdGMjl2ZFFJ?=
 =?utf-8?B?dW14MFBLd1hKSVhsMDR4TDBWZjVJNWNNQ0RPOCsrcDhIS0IvL0RMMkFJbnJX?=
 =?utf-8?B?ODRNc09iQVlWQ3FiVXFUSUprOE9lWDNLdkY2dzNYNFoycVJHS1U0SzZGZXl4?=
 =?utf-8?B?YUZSdTRacHFId2N3dk1OOEhSK3FGKzNNWlM0U0Z5R3dOZzZYWnRPYjhhZk0r?=
 =?utf-8?B?Q3NyR0R6NE95ZHM5N2ZwN1VwWVc1NTBFL1B3OTdGUzNQaDZQcVprUm9ZR2pL?=
 =?utf-8?B?UnQwNUY4RU1JN3lGWGsyMm5BTnlhcDlHVjNWOWdoQ2pmbDY0cGg2aWh6RElZ?=
 =?utf-8?B?NWMyMi9SSzhVSEhRV21EeS9YMzJUeG1yQjkreTZnZ3F5V3hUMDk5ZTl0Q0hl?=
 =?utf-8?B?UmROdzJ1a3FNbU9ucHkwTHZJVDdGMU0vUzRQSTcxWU9MSGk0S2dDbWpCKzN3?=
 =?utf-8?B?YnpxeFdVajU1OWlHc2haaGRjUmtYVFBENEpQZksrWGZPNTd5SXIwSW5rSytL?=
 =?utf-8?B?OUhBQWY3ZWhqV3h5YnhvMzZsZEtVZUF3T3lTc0lJWWt6Q01rQkpsdlVCcGJw?=
 =?utf-8?B?MlZSbEc0N3FhQlV4QmtCNVQ3ODRkNWRlM0hUTXU3cng5V0RiVzNYV1pCRTFq?=
 =?utf-8?Q?UdEb7NPzSMyJnFzDbGA5IqSitB7l2iHA90IhY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3RFaTI2MVY1ZmVvWXl2OWtkL2p2S3pjRUZFSUszTTdRbnhIQWs4Nkh1RU04?=
 =?utf-8?B?dGpMMWliNHJ0NCt1NkFURHl2OUd4bVBXaDNIWno3bHRud0tMa2VZdWdIcFl0?=
 =?utf-8?B?cE9pRXRHVDJkUGp3WE54bTFUUVcrekJ3YkttVnlNeGpzUmpVMmtzV3dScmNH?=
 =?utf-8?B?VFkvT0phdGpUQlJ2dG5PaFY2VjBJQ215UGdqaGVNY0N1MzNjaXJOSG42ZnZY?=
 =?utf-8?B?eHVQNWZBMFFVYTVzendOUGZaU3MxNDUwY0Ftb1JuUTNhQUpXOHI4UGlBalFJ?=
 =?utf-8?B?Z010ZXhMaFBBNVhJSFlTVzU4QzViNmkzTzRocm9WWFFva3N5elBYZkJQR2gv?=
 =?utf-8?B?RG5oZTF4TXdGREhnNWU4OXhobzRNSllMak50NS80aG1JRkRBWHFMRGJNZUxR?=
 =?utf-8?B?MUs3Z2JrV2x3bzB0VXJ1RzdkbHRkME8zWEFpODhHeHVxRFVnSEd2cks4dCtP?=
 =?utf-8?B?VDkxTzVoY2RmRGxaeVRuNzNCMlhNcEk1Y2xMWGFkYzcwQ0dBWE12LzFTVkRz?=
 =?utf-8?B?d0pqUmdHK0Qwa2R1alRxNUE2TThGNEptbnlMRkdTUXZkakp2MGJGaWg5NkZu?=
 =?utf-8?B?cmV4bElMNDVTZ0dLN0VvenRSM3ZtakFMRFhYNkVFaDl1R3BwdS9HMFFjSmJx?=
 =?utf-8?B?TU4rT3pEYm5RUFF5QU5DTHBqaEpRUTU3b0xVak0rRG9KZlkwNEZkTmluUmFh?=
 =?utf-8?B?ay9GSllQb1VJVHVlV3NmblgxbzVHd1VNY2dKWXI5bGhXS21tT2ErZGtQRUJT?=
 =?utf-8?B?NTJhOU1YMHJENFB4cHdlSVBGWFczdmJ5Ym55WWVFL21FMWk4MzhGd3RibmVk?=
 =?utf-8?B?RlQxYnllNEN1bWJSQ3FMallDbnc1SE1mM3BGQzgxTFpTM2tuc0YwblZTRi9v?=
 =?utf-8?B?NXNVeExSZGl2NnVJY2hiNFJOZW1lNWFZSHZSN0NXT1JqKzl2eWhBU010ZXFl?=
 =?utf-8?B?SlpwazY0L3V2MHhLTzg4YURDVForcjdlZDk4VkhsaytSZXRVY01qbGEyTnhz?=
 =?utf-8?B?Zy9iRmR6T0dMWHdhQmhOR1VyQUQvRmt5aVJRRmtuS3l0ZXZtVnlzREJPNFZY?=
 =?utf-8?B?YUI2OFZ4dGFEcUNmNlhVaVU4aCtrbkI0azI4eHNTelBSWUc5T2I2TnJzVVNS?=
 =?utf-8?B?YWM3YWJTMTNFVWJQc1JvQlZxRWE5TXNRV2NQa1gyeHJPdVhCaERaL0p0Vm9D?=
 =?utf-8?B?NWVoYkpwalV4QWEwaXFoQmhaMWNHcXgvZTl4eXhDYzdReGdRSXZtMVFDMHdu?=
 =?utf-8?B?NUlGNkhqNjJHL01Iekp1bVBjc2J1aVNHN1NjNGxHMnlmREl2bEVveTZ2S1Ja?=
 =?utf-8?B?TnByTTcvNGZGQUpIQ1NTd1lVRDZDYTcxeXN3VWdxWnc0K1k4SG0xcUNIL0Z2?=
 =?utf-8?B?L0x0K3liUE1VTmlWYnRKY0toMEFJMTZ6RnpqNWNsR2ZrdkJRaEhwd1l5d29n?=
 =?utf-8?B?MkI1WGNwWW5uSXBhSXFUZ2JsSW5BaFJLWjdVOHV4aXkyTXN3dkN3ZzRhMDVy?=
 =?utf-8?B?QWVEVzlGOXc5c3MxSlBrM2JadU9YMld6NUlEMHhOc3Ewd294UGxiTFZkMndm?=
 =?utf-8?B?UFlvdVAyYXZvRFd3L0tpeGFHdUFRd0czRU5iY1I2V1EwK3RSRy9VS3Z5U2dL?=
 =?utf-8?B?ZUdaM3ZZbmQzRFFaOGNJdFl4T05OK3dkbjdDdEcxNU1xdFFZOTNxMUNhQ3pm?=
 =?utf-8?B?K2RkYUx1M2pzVUVBWXd2MEc2MENsclBxMGVJUGZycXBScUMzS3h5V1RPdXU3?=
 =?utf-8?B?VDlzQUFFN2RhQ3FuYW5XdlYvcmw4YVQyV1p6NzdmOW9rWFFwZU1FQVk0YWl5?=
 =?utf-8?B?cDJock5iRGZGcHZ0RE5jdFVlOXNlc2lWS0JFU0ZuMmFGU3VVSzVNSXZrc1FP?=
 =?utf-8?B?VmhoMGNHQkt5TCtaY0xMWVhtMmVOMXVZTDhUYTdudVY2M3V3NExKSm82bjBm?=
 =?utf-8?B?b0tqVmlDa3gyTFU3b21na1kwaXpvY1cyZ2s1clR2YlIzVCtUa3AwMkxTUkdv?=
 =?utf-8?B?VFlJcWdkTnd0UzhkcmpGYWJVT0ZmbzNtdllDVFdnWTJ3VElGYWhpRW9XOGlI?=
 =?utf-8?B?Um1RRlAxUWZnTGsxelVEZEYvNEhPOGxLRklpa2FZMzNEbVdvYzVIZ2xJWnNJ?=
 =?utf-8?Q?dKV4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1460550-54d1-424f-e012-08dd04ff166f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 22:52:59.7063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCQYSSamR2PcjhAWw//mfeziiKhfB5uH9RojzzOpuFx23lFXGcVHTzhGZN6ONh9Y31Vd0lTAnWDcOYYQxbNgdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9967

Doorbell feature is implemented by mapping the EP's MSI interrupt
controller message address to a dedicated BAR in the EPC core. It is the
responsibility of the EPF driver to pass the actual message data to be
written by the host to the doorbell BAR region through its own logic.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v5 to v7
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
 drivers/pci/endpoint/Makefile     |  2 +-
 drivers/pci/endpoint/pci-ep-msi.c | 99 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ep-msi.h        | 15 ++++++
 include/linux/pci-epf.h           | 16 +++++++
 4 files changed, 131 insertions(+), 1 deletion(-)

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
index 0000000000000..7868a529dce37
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -0,0 +1,99 @@
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
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci-ep-cfs.h>
+#include <linux/pci-ep-msi.h>
+
+static bool pci_epc_match_parent(struct device *dev, void *param)
+{
+	return dev->parent == param;
+}
+
+static void pci_epc_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct pci_epc *epc __free(pci_epc_put) = NULL;
+	struct pci_epf *epf;
+
+	epc = pci_epc_get_fn(pci_epc_match_parent, desc->dev);
+	if (!epc)
+		return;
+
+	/* Only support one EPF for doorbell */
+	epf = list_first_entry_or_null(&epc->pci_epf, struct pci_epf, list);
+
+	if (epf && epf->db_msg && desc->msi_index < epf->num_db)
+		memcpy(&epf->db_msg[desc->msi_index].msg, msg, sizeof(*msg));
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
+	ret = platform_device_msi_init_and_alloc_irqs(dev, num_db, pci_epc_write_msi_msg);
+	if (ret) {
+		dev_err(dev, "Failed to allocate MSI, may miss 'msi-parent' at your DTS\n");
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


