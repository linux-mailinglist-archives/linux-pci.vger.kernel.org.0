Return-Path: <linux-pci+bounces-17955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240239E9D6F
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 18:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15612161E4A
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 17:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3A01BEF75;
	Mon,  9 Dec 2024 17:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JVFmfs07"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E4A1B042B;
	Mon,  9 Dec 2024 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766527; cv=fail; b=ORiSqyYTzNC0Ohqts3olrmjmRjMSTeY1t8yd3/+ElWhRT6uoX6DpRSA40DM8nLVaUP73pagkZsjVxDV13k/n/gj7IX01IuVdShzXLGRNrCpc+1Ri6CiI4r+Ny6D8rJ7Uz0UK6LlC4vWtkzPM5FrcFlJAezcqUeC+VNLjJ/jXc2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766527; c=relaxed/simple;
	bh=QttR5tH/yvKIxFiJ4f9buzL9F0LcYD3wXvxdYIIaHrM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eggu+jy8sCpsdkjjE1NPJgUx9BrMuvejhD/Eh6tZc7Ytr1ZdvX3IRhkz/O+AjOiYb0MTouIPWFF1LWt+7jGkmUYJ/YoBgggPOU+8vRNWUDgs6mHm2T9GNU0lv+NXfAMFOnqr1U8/JDtYjcpAvhmlOKqhmzHUeUdDiXuvTlTcmOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JVFmfs07; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ycpmUZwTqdBNHp5R3+KFzu6RBvip78v39sK3aTrGnsEQsJBqrBKh1hnMS1jR2xZLPjlB5KbRnMx3VSMnY7HfgnElLP22ZlGPMfF3TbfpfXdlvpju4HYR+IPiTYpqZdO/5ics4WE4goG1ECCyzQ2DrWsWl92GPBDRheYG5GDlRS//9Hrji4l/NAOzXvrlooRvegCYJBB5XHLI6LMBWkPzyfDFWPJXbmNExP0xbagxWu4HbI57jKnvj0u64p1rL34kdHBXGqTXWBRVbrO8iXHJ8dMMG6vq5wnO0N/YysEIq7BLRWRCKfBkTfBiinsxeRnn5upFpW5i3LVxt22HPzq5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwHmvm7ybUkTgCCj+32HWwVthgCGdLhI52uVsPchYtM=;
 b=TZ2vDupAjLXGgBhoHmhUzH/iid3ZMy7DPCQSQAGhCkebZHSO3wLJFr0BF4Uou1ee1A9aCdCtzo0aT+WF1fZDsKna+S+8OEwLgdfetpYiovnpBLNoS1F8nlXJNrMwkPUOUmmSegkCdtcuFwldXViKhAVPJHTLwVvxDiJ2st69zZAfLuwE1pSo0YRr+TdlWkeOyYuEfLnrH/dyJFuLH/VmJBTKhLwhRHjNGF2uoQgtfBSTIoF0xkWwtgevmh3eatgN4EZfgsGv+AIexH4YXP2/bqpfWfL8pbuOFGyZIUm3hz6DHaqFDtPMHBwrUODpVZvOp9B0Ciqppzt2TmjwLlXh7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwHmvm7ybUkTgCCj+32HWwVthgCGdLhI52uVsPchYtM=;
 b=JVFmfs07SKDNw9nqPc6s/1Ji+eKU5G7ZwsQ+dyFIBgtloqh9ejncCqw/V0trxL9zxygj0U6PCehl7O6YzZ71FbME849BFlFd88V8KVj8ah1xWt6EKNNtIXPKue2IvDWYnl/Gnwin6xkDssVR9+FEdc6OCE9MQf0CieXocCNLp+eZB7nH3mMs2Chc5KQGIVEQ82w9tDGQyZTE4vZlmjvMtcpYz4HTwbMohuwgflRF8HEbXTqCMc6OBLe48yHbKn39B6cGKgwYmLutF0C2cQg++X8PK6jGZo3+/RlhzKyr6cC0h/ZQzTKwMdYUtIENfXKYbbhhNxgmXCL1I6j4nNX06Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB11017.eurprd04.prod.outlook.com (2603:10a6:150:21c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 17:48:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 17:48:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Dec 2024 12:48:15 -0500
Subject: [PATCH v11 2/7] PCI: endpoint: Add RC-to-EP doorbell support using
 platform MSI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-ep-msi-v11-2-7434fa8397bd@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733766511; l=8536;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=QttR5tH/yvKIxFiJ4f9buzL9F0LcYD3wXvxdYIIaHrM=;
 b=7JKPSA1DEScfwnrV95WQ0KgzMFedzlQq2s54m24Nwy+x/CRqDwuydiwWUU9VdnffkeFr+42Gd
 ojL6PJKeXkWAZwwatU1PqgbcZACRdS2pDta/y7E3oFBDE450jmsaN5F
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB11017:EE_
X-MS-Office365-Filtering-Correlation-Id: c0dda56a-a96c-4e7e-abe0-08dd1879b957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDlrL2xsaCswVTdwSW53R2IrNW9WMkVEQjNzOStSMER1TStGcGR2enphVEVI?=
 =?utf-8?B?OTJxVmJLbS9WZ1lNVkhGL1EzMzArbkd2OFlxMURtWHd5Vko4cTVaVjRaTlh2?=
 =?utf-8?B?N3pHQlBNczBvbGVRbUltL05hdkNZYVZKb3BoRElkOWNMNTdoWWRlTlRGaXFF?=
 =?utf-8?B?amQ2VS9VOEkwN2JDTkx5dmNIbTRaQjZCR0JTOTRuc3ZGckxmWDZmYU1wWG9l?=
 =?utf-8?B?Z3lSaTJPVnhXdWFQNUd3ZHRTK2pHMHFMMDV5OHhXc1ZIbmlZRk1wRlh3Y2M0?=
 =?utf-8?B?NGFXb2tvTFRXRUJxc20rSVVvTzBhWVZoYUgwcEd4NXBGbzlkVExaVHVUVjdY?=
 =?utf-8?B?cndORUMrZmpBN25Ccm1MRGNRTUF4QmtpYmU0NmgySWZUcnZCNXhjMllHdEM0?=
 =?utf-8?B?VndoTE9LU2twRUp1UHdLZ3VMOXpleHBvU2x2R2xtV2VjK0tpQzFjd1hSSk8z?=
 =?utf-8?B?MExiTThFNlJBakpISDlWcWZwZlVRTnhHWjRGQ0J5VngyUkNvMlQyWWVwaW5z?=
 =?utf-8?B?SkM2dkZkYzBIay9CQWhXQTN2RHVFcFJvMmd4K3pySTFLSVMvMDNjTjNuemtJ?=
 =?utf-8?B?ZXE4VTdGOHozTHorUVBtbDd5d29YbUJrNk1EdEgxdGlFcjBRODdteEVDam9J?=
 =?utf-8?B?UHRmWVk4SlQydGRQUFl1S25aMU1qbU5QcDA2SXpxNHIzb0hYU2NNRktKZzJC?=
 =?utf-8?B?aUhLUGk1SjEwVTI4Q0loNVVEME1SYVVrMk5DZFJIZWUxQ2hwUzk4cjM3Qmh5?=
 =?utf-8?B?UVpNVmdZSy91WTdJV3hlVG1WK2JUaFp0cVNlRVVINnhlTGs3d2VIMGRmUVRn?=
 =?utf-8?B?c1lnN3pLcDR0WUVwYXVESXZZSzhvZ3lLQjhsWEsva2VZcG9GU3NVQ21yOHc1?=
 =?utf-8?B?aFVobzFkWTM0S1hGbFM1cWpsOUl2ZXBtWGE5SG4zMW1YZFhjK3pRSkRlSnRl?=
 =?utf-8?B?V0x2a0R6RW8xRXlsWEMxM3ZFQjRId2RIN2tzMDNoT1VRdGR1OE8rRTUwZ3FG?=
 =?utf-8?B?TGVIRjVFdXZsREo1K1JCaC9oSDkrRVZmN09KQmNHZWsrdzdjOXQyM01tWjMw?=
 =?utf-8?B?Y2pMblo4ZjRtbDlvQ2VkbmlodEdJcTVhaXdNWlBJaHNZdWYrVlFTdkQwSnJD?=
 =?utf-8?B?eUErNEpBZ2F1eWVjb2dFVStDcXN5NmdPVnpvUUtuUG93b2w0UTltd3h1Zmhr?=
 =?utf-8?B?QTYyL3dpaUY2cVFEUHg0WW5ZbU5QSEJZdTBQWU5JdnFldEhJT21kdFBZRFQy?=
 =?utf-8?B?UC9BZ3VUcnVscFFNUEEvSVlYc1hyM3YvemRUWG1VMWNweURoU3pIcmhkUGo0?=
 =?utf-8?B?aGdIbERYb3NTNFRyd0tqQVpEc0ZKSHpzSmx3UHlHUW9vUFVuSHdsaHY5MVdU?=
 =?utf-8?B?cFFFNVNFbnpGbU9hL2l3WmtNS2J5b0drcXFvZTlYWFNiZGk2Z1QwYW16SEhq?=
 =?utf-8?B?T3FYWDRiNzFhOG1qN25MdTFiL09KRTFrUWVPeGpObnZINDU4V0NyZVE0dk53?=
 =?utf-8?B?dlp4dSt0cS9oaUE2dWVvQ1dncDJvZ2liNkJ3UFArQkovWGc3d3BoTlB5WmJk?=
 =?utf-8?B?V0ppQmt1MDhFR2lDV0R5ZGp3Y0FEZDgzRHhwTFBuU1E0VkN4VEc5czlFc0Zm?=
 =?utf-8?B?VTlKOG9LTG15SDcxRVJ5ZXVkR3hYZ1JPZ0E4ZGdIU2htQVJCaEFPVHh2WklI?=
 =?utf-8?B?aDFQZndpMm9hcGlUL21vNy8wbnA1VDNZR2w3Y3pGT3BHYStwb21JYTZYQ3BX?=
 =?utf-8?B?NWJmQmZQOGQ2ZXh5NHZYZEFWWTdUYW9tTzhTT1E0WFFUb21MMis2d3J1L3RW?=
 =?utf-8?B?NEhXZUhXWDAwVzlqYXlCWHNZM3FzbmFzd0V0a0F2dGs3U3R1YVRzWmVETEJ5?=
 =?utf-8?B?MjcvNWE4M2xUYnFabVhrWU03WFpLdHQ4d3dzWmRqd2U3SDNkTXNKRTJmeW5R?=
 =?utf-8?Q?hUqZWuF/7rc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFVxWVU1T05KbW1mKy9EbTJoWXF4WlZoTmNEY1NjV2lpWFg5cXl3RVhYd3dq?=
 =?utf-8?B?bmlBQXVXNHhXbmVFdXAzOUVYZEpUY1IvSENYWVpJajNVTHlBYWwvbk5pYlZH?=
 =?utf-8?B?MWNHZ3FCS0pwQUxDNjdJaFlvWHAweVZGK0NKMnZuYWtLcG1zV1BuNzMrNjdZ?=
 =?utf-8?B?RTRpNk8xMGdVTFNWMTFiUVZTYnBvUDRSMlpCZzRzcUFobGtPZE9IKzRIc0FV?=
 =?utf-8?B?RUFNNTVKNWltUTVKU0lDQnNtY2Zzb2lIRVJ4a2JRUitDMEtaLy9RKzVLZS9O?=
 =?utf-8?B?SFZ1YmtLZS9BS2F0UGN5eUFlNDRCVURwSk1zTkc2T3BwVHBibGIvTGpvSm51?=
 =?utf-8?B?blVMblVISnpkVkZBNlRUWjZDWVo2V2dpLzBKMGRQeDJEaGlkaDd4OXR6WUZx?=
 =?utf-8?B?aXNYUVVHeFhPTWs5SUpXcnM1QzA1M05VR3UwUVFZaEhVRGNDbEtpN1E5dXlL?=
 =?utf-8?B?MytCd3g2YzUzOFFDdHBoMm5WZkQxTnRrYXdHdlppRW16U05iV2Z6aGRtUUZY?=
 =?utf-8?B?NWFtSkt6eDFBR1FRUlp2VW55ZlR6b0I4dzZHcW9Sc3M0RjNGeGNlSSthQmpi?=
 =?utf-8?B?MEVMeWdqZjlHd0xTRzVZRWx6OEFULzFyTEV3aUlXOVhXMjd0R1BPN3RXRzFB?=
 =?utf-8?B?Q0taSjduZDJWQzdtbCtHRThGUjFEZEpPL0UxN3ROYVFkaitNOEo1Z3I3RWpX?=
 =?utf-8?B?UGRvOGNtYmJMczNDYTUzZkxoTjUxVmU5YktvaG5OZFpEckduY0J0Z1JObTZW?=
 =?utf-8?B?ZDVsZWFZRVVMVW9Cd1YvbXp1cnNVTUtuSG5aQkYrLysrRHAyM1VlcndEKzhs?=
 =?utf-8?B?dkdMdk5tNUlKZ3M4VHc5QzZjVHovZ3hrM3Zqc0JUZTQyR29NaHhDc1d2cjRn?=
 =?utf-8?B?amVvckgvSkxFZXEvRXNKMTRLMkpoVHZsaTRQcXJURE5TU1Y1eE8xQmVuVEFx?=
 =?utf-8?B?djBYUHdoNXlwSVg4Q05QQjBKendIRFdaS3pMNWpEcTR1R2VPdkJyampGTW9a?=
 =?utf-8?B?dHBSMzExVjRacGRkUXRja1dmZWluR3dERDVEMnlybUc1MytvOSthSWZrY3k5?=
 =?utf-8?B?aWhDVzRNa1FqTnh4UlhZaVNVaitaQkdwaXVLS2hwVFFVRnJjTWM0OW9OekVH?=
 =?utf-8?B?Y0JlbTV6K28rY00rQWd1aEdSRm9KQ0kzR0ZmckJUMGVmS25Pd1prNVBNS2Fn?=
 =?utf-8?B?cHIrUDlMYXFQRFNMSzU4WDNKb1kybGZsdDBLMVBCS0w2K3gySFAyUTlTTkdk?=
 =?utf-8?B?RE5aWVJIS3gzeTNZQTZkM3RKWFpJdTB2a0c3c01Xc1g1a0J4YUxpMDJKMTJT?=
 =?utf-8?B?MzM2ZTZGQVhNalhMZStxR3cyR1pWRmdhL3M0M1JCVzdDbUI0eXFvc2dOZW5Q?=
 =?utf-8?B?OVozNlBaWFFndmdibFM0b3FDaHFBN1RDVjJNNjFTZmpNVHdGR2EzeGdqWTZJ?=
 =?utf-8?B?RjRkOFc5dkxISkZhMGpucVhLZVFzRnorV0pnYm9JcklxbWVIVzJOYVNNZnha?=
 =?utf-8?B?QkhLZTNMUWx0MW40TGQ2T1VXU0M2M0pwUFV6ZXlpZ0YrbytudE1GbzJXZ3Nk?=
 =?utf-8?B?cXRmbyttL3BSWE5PNVlyM1l1Zlc2QStkNGhHanBVT0FCOVNMekJtUGowM2RQ?=
 =?utf-8?B?UzB5ZXJGaVFsQ3ZCNE9Sc2FLZGdnOVZNUlAwL2RvZnZUdDBySUJ6R0VpMzB3?=
 =?utf-8?B?QzNIQkxSVWtqUGhvdERZUkxGMDJZcXRrYnF3RDRkV3RQTkVTLzN0ei96S1pK?=
 =?utf-8?B?ZkYxMExvWXR0ZFJWTGRENXJzQk85aHRxcEVaUVpQR2RjUlVJdG9IUGF3V0Nx?=
 =?utf-8?B?UnJueUY5QnFPZFBmYnp1T2h1Q2ExVjlQT29NeGlQcU1oVjEvSFNpS2dLeXN1?=
 =?utf-8?B?eE4vYnVvWll0VWsxSzhPS0c5Y3BXeFMyT1hZVjV1ZWZYUW9mSXE5TmJJMFEx?=
 =?utf-8?B?YWMvblV4M1JuTXhuZm5lT3VoK0UwZkUwVmh4SVpVZUhibnZMV3Ftd1dza3ZN?=
 =?utf-8?B?R2lJQjFvNUZtY2Z5SVBxN2xac0crS1hVM0ZHY1YrZTJPV3ptQmJEei9sMloz?=
 =?utf-8?B?dnl6Smx2RWxSZ0RvbHRTbE5JZDI5Y1d6allncVdOeHpMWXFJZEpEeDF6WEs2?=
 =?utf-8?Q?osyw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0dda56a-a96c-4e7e-abe0-08dd1879b957
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 17:48:43.7186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X93YkVX90uW1UmiIE+8+TnXlfZ83/Jw64wSoNmuYesAYlnrhM1iU+aylGU18zZY7geTk3BJrD6zt6fvAfLwE3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11017

Doorbell feature is implemented by mapping the EP's MSI interrupt
controller message address to a dedicated BAR in the EPC core. It is the
responsibility of the EPF driver to pass the actual message data to be
written by the host to the doorbell BAR region through its own logic.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v10 to v11
- none

Change from v9 to v10
- Create msi domain for each function device.
- Remove only function support limiation. My hardware only support one
function, so not test more than one case.
- use "msi-map" descript msi information

  msi-map = <func_no << 8  | vfunc_no, &its, start_stream_id,  size>;

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
 drivers/pci/endpoint/pci-ep-msi.c | 148 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ep-msi.h        |  15 ++++
 include/linux/pci-epf.h           |  16 +++++
 4 files changed, 180 insertions(+), 1 deletion(-)

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
index 0000000000000..b0a91fde202f3
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Endpoint *Controller* (EPC) MSI library
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci-ep-cfs.h>
+#include <linux/pci-ep-msi.h>
+#include <linux/slab.h>
+
+static void pci_epf_write_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct msi_desc *desc = irq_data_get_msi_desc(d);
+	struct pci_epf *epf = to_pci_epf(desc->dev);
+
+	if (epf && epf->db_msg && desc->msi_index < epf->num_db)
+		memcpy(&epf->db_msg[desc->msi_index].msg, msg, sizeof(*msg));
+}
+
+static void pci_epf_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = desc->msi_index;
+}
+
+static int pci_epf_msi_prepare(struct irq_domain *domain, struct device *dev,
+			       int nvec, msi_alloc_info_t *arg)
+{
+	struct pci_epf *epf = to_pci_epf(dev);
+	struct msi_domain_info *msi_info;
+	struct pci_epc *epc = epf->epc;
+
+	memset(arg, 0, sizeof(*arg));
+	arg->scratchpad[0].ul = of_msi_map_id(epc->dev.parent, NULL,
+					      (epf->func_no << 8) | epf->vfunc_no);
+
+	/*
+	 * @domain->msi_domain_info->hwsize contains the size of the device
+	 * domain, but vector allocation happens one by one.
+	 */
+	msi_info = msi_get_domain_info(domain);
+	if (msi_info->hwsize > nvec)
+		nvec = msi_info->hwsize;
+
+	/* Allocate at least 32 MSIs, and always as a power of 2 */
+	nvec = max_t(int, 32, roundup_pow_of_two(nvec));
+
+	msi_info = msi_get_domain_info(domain->parent);
+	return msi_info->ops->msi_prepare(domain->parent, dev, nvec, arg);
+}
+
+static const struct msi_domain_template pci_epf_msi_template = {
+	.chip = {
+		.name			= "EP-MSI",
+		.irq_mask		= irq_chip_mask_parent,
+		.irq_unmask		= irq_chip_unmask_parent,
+		.irq_write_msi_msg	= pci_epf_write_msi_msg,
+		/* The rest is filled in by the MSI parent */
+	},
+
+	.ops = {
+		.msi_prepare		= pci_epf_msi_prepare,
+		.set_desc		= pci_epf_msi_set_desc,
+	},
+
+	.info = {
+		.bus_token		= DOMAIN_BUS_DEVICE_MSI,
+	},
+};
+
+static int pci_epf_device_msi_init_and_alloc_irqs(struct device *dev, unsigned int nvec)
+{
+	struct irq_domain *domain = dev->msi.domain;
+
+	if (!domain)
+		return -EINVAL;
+
+	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
+					  &pci_epf_msi_template, nvec, NULL, NULL))
+		return -ENODEV;
+
+	return msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, nvec - 1);
+}
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	struct irq_domain *dom;
+	void *msg;
+	u32 rid;
+	int ret;
+	int i;
+
+	rid = (epf->func_no << 8) | epf->vfunc_no;
+	dom = of_msi_map_get_device_domain(epc->dev.parent, rid, DOMAIN_BUS_PLATFORM_MSI);
+	if (!dom) {
+		dev_err(dev, "Can't find msi domain\n");
+		return -EINVAL;
+	}
+
+	dev_set_msi_domain(dev, dom);
+
+	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+
+	ret = pci_epf_device_msi_init_and_alloc_irqs(dev, num_db);
+	if (ret) {
+		/*
+		 * The pcie_ep DT node has to specify 'msi-parent' for EP
+		 * doorbell support to work. Right now only GIC ITS is
+		 * supported. If you have GIC ITS and reached this print,
+		 * perhaps you are missing 'msi-map' in DT.
+		 */
+		dev_err(dev, "Failed to allocate MSI\n");
+		kfree(msg);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_db; i++)
+		epf->db_msg[i].virq = msi_get_virq(dev, i);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
+
+void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+	msi_domain_free_irqs_all(&epf->dev, MSI_DEFAULT_DOMAIN);
+	msi_remove_device_irq_domain(&epf->dev, MSI_DEFAULT_DOMAIN);
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


