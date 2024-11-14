Return-Path: <linux-pci+bounces-16802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015729C956B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 23:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59152830E8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 22:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDE21B3938;
	Thu, 14 Nov 2024 22:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S4Lql5T2"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013034.outbound.protection.outlook.com [52.101.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9551B393F;
	Thu, 14 Nov 2024 22:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731624792; cv=fail; b=pb4pwUn8L4D7UPfdkBCmTpMcW06WxW1+Af3S94TnnCaJJWbgADkfCEqhrR9fmuqouaH8Jb8sO+BGxPK1Vd5KS3yeCC90bDCjc/tsRgkYiitikeTlSZvNSVV4QXMTPnphEH9SEdeudepDS37Nk8Khe1OVZDoHmyftI5mhtaWToFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731624792; c=relaxed/simple;
	bh=0yAMagX3u9+aZDCSSioQiAmKlqCp0jSmM1pLy+8moi0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=V8ENH0Nucmw80LuDyusZ4Y3i6/C9P436769+UpK+c0uCflRM/Oc7ICVThx40R7WcrRgQiYBtymYZRfDajpczSn/F/0XMbjlNu60GmvyEDpogzToF6xqa81ofRJstq6ffNkQB3OB1hmL33ASr1XMzkc6kL5xN+sd2qafVPDJhlJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S4Lql5T2; arc=fail smtp.client-ip=52.101.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjCvIIpSp69BKK0TMNpp/TEsfMteG+XE4TSr9zCZSuI34oT6HtsE9pKcwor3QVtJeCWFOf/EIZXaTI7xftuYRuHJgf3PwUUYqD9lVk0ZwlJ1TkjMApFNl5MZ2T/hwqaqt5XISAzuT8K1enopNz2ZrHhyWHKgSnDNvLSAIGeZPp1OmH6QM/CWJ22vV+MYjXo0d0KDKnqNPKsKQCsCLcL0L6pdhizTOXKEosFLoFwdez2kczAs8dhEGwXehk23Ye2ej9MYtJvWJzGyJw8iUp9B0KgN19myk32nacCtr9BhYfqFBZsDof3mIGW6tUV1OLJHbSLPmUGtya7cA/JPeQO4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0KC6fMx3yDLGEroWZHuxH6YFJ99NVir6SglA7R8IoU=;
 b=pniwC+AAvj2EFKtoEHlStDoKk4N0BdzY/51KwROynhNl0JorIghpgUbYfMOh4iSvcbtRDPh+HMQ3mc5viQ3XiwuBw9Vh+pVlVtFkynMPdPrP2XfWBTX6dafaeqXt8LqU3tH5FUzxG2wUDCQd62VhAB1ng2UnGV29CB4jTMxFTuxZrShiTdQKVKUNFhEz/AluWZLurbZEpi17C4F3Ockp4GgdynEwB+bVfffCBgch5iuFQWCTXTw8ZO5ZtHEt2F+UgruVVSaW/ny0+ZCkxey9eXnyTjtoVimk3GeO8zTm+EyEKz6lMC/SnC36uQndeeoaBQhTG9La0tQvjd08FuJS/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0KC6fMx3yDLGEroWZHuxH6YFJ99NVir6SglA7R8IoU=;
 b=S4Lql5T2KaTLOBOuZKrppzQPJnNPqGDLi0c/fUti/oSxh+1yXTZXHwQlwNanUko9Uj2cnG40hALipH82vUSBCS2Ty5tKQqWVOjpc+S2DQM5W/aP+9T9P6VKBzd26vC6xaNSyCeWw8CxFo4Iy6UL4guuF47vd0lmZvM73Hu5qkHhiX8O6gLBN1FRZba/FKw1dSMzpT4eEIp2yPfIK+c0G2CiHzOnTscOWO5m42kW88QXRLWyfzmmEYRaN03+8RIBED7+fmYXKk9h91841b7Ve/TjUQDpmPjpgLsWtehLI/mHx/jNng5xukzZEM6SaYMI/ADwVMBQEib189X1SgqtosQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9967.eurprd04.prod.outlook.com (2603:10a6:10:4dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 22:53:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 22:53:07 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 14 Nov 2024 17:52:40 -0500
Subject: [PATCH v7 4/6] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-ep-msi-v7-4-d4ac7aafbd2c@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731624768; l=7661;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=0yAMagX3u9+aZDCSSioQiAmKlqCp0jSmM1pLy+8moi0=;
 b=9fgUJt1DvuUMv+mualC4PrkA/qGPlkwbMMF6lQzDwfwBiDhnpYfaQGOTdKPycxxlit8ArsMx9
 bDQ+Bcr6jjyCP0lRg/fm5OD4mrSuKQE8yOlYzDPs2S4XVNgFoRKGIj5
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
X-MS-Office365-Filtering-Correlation-Id: c25f5d4d-47b6-48b6-72cb-08dd04ff1adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFNFc1pHK21RanpuYjhRWlNHTk14WXJ5blNlNnFmMHZiNFFsaVNJemtZazVw?=
 =?utf-8?B?T0d5M2YxZnR2ckYwUVdDY3YxalFvZzE4L0tOTjJXQkFVSDJiVCt6QmV5bjlz?=
 =?utf-8?B?RmpKdVpodDhtaHNncjhKWjMxdHlLT0pseXpIVGU5Z1ZlOVdVSXlJb0NTTWxr?=
 =?utf-8?B?MEJTMTJvYy9xSGtKcTFadzViU0RmRitwc21OV0pyV052Wk5ZY0UvUXpCWVBp?=
 =?utf-8?B?Zi8yTDZWVEd4bHl2NmJpcis3bDg2cG5aTGpZU1ZOTnhrRVR0UndiN0twVHVQ?=
 =?utf-8?B?bHFNUzhxZ1doKzZybFpuOUQ1Skc5ckdvRENNazNpR0JCNlNkRmc0VEk0N2F0?=
 =?utf-8?B?T0xxYmZnQ0ljcFNjZGpsUEdsQlBJcGt6ZGlSVWZ2ZWZXL0tnRHpmYkRTSS9v?=
 =?utf-8?B?S2UwL1VPTVQ0MGFxNEM0dWRRbjF0alFKS3MzaVQ2T3lha2U2RG5VOVZzZnFK?=
 =?utf-8?B?aWl4WXJZc1dtNmtHNkNDYlJvUm1rOXdPNmIxUjIrSWV3elJjT3Y0YXBiQ0V5?=
 =?utf-8?B?Tk1ocDhtUHF4clRqOTVvaXkrdjFxNDJENXFlQWFodjFkb3poWmtnT25mNE5T?=
 =?utf-8?B?bmdyTmp1eTg2bENnS2FTS2pMQjViUnpPemExcW56L2p0QkZSQ0FoeTBocGtZ?=
 =?utf-8?B?QWJ3NWlUMWVkMGNJbGhqancrdFN3RGJIaHFjOFk0RTVJQ25KQi8xQWI5TlRa?=
 =?utf-8?B?QjM0a3hhN3pLUGRlQVR1bHg1N2VpekVRZndEdmMvU2JFNmVlT2JVOXhQNmY2?=
 =?utf-8?B?aFVWK21vcXdLcWV3Zy8vQUNaT3R5ZWJjeGY4U3pqdW93VFlBSE4zdjJ4TjhP?=
 =?utf-8?B?Mm5OR2xKSUVoa0VjMmczNW0xTkhZZXRzUU03ZEg2Sm1vSHovMjVJekZyLzNZ?=
 =?utf-8?B?RUhEbmtYN3FueWd5SjhNQTRMYWZ1dFd5MGdMTkIyMkdZdlFGM08rVWNHaG53?=
 =?utf-8?B?S3VFTThOenF0R1ZkdEpqT2oxZmY1S1lRRTNSbEVCT1VGZEZVNlp3RGZWSmx5?=
 =?utf-8?B?eUJ6eGZ3MWVrYmpsdDNnd2dkRzlhSFY3cFhCRlRxbmFYbmhld2x5MEo0V0kz?=
 =?utf-8?B?czVISVFyN0xJOGhlditNMERpdnhtekI0UVFMY1ZpbUxuTjNPVDJXNjAycEg3?=
 =?utf-8?B?cGpOWHVGZkl1QWlVdllmWmd5ODhKVTNHcHZROE1WMmg4RGZoZ3l3aU1LaTc5?=
 =?utf-8?B?Y1cvcy93TEtTd2IvUTlGNGF0WStWTlhsUk02Tlg3NDV3a3R3b3RCMHBRZUln?=
 =?utf-8?B?ci94REpuS3E2QnFWNE0vNlk3aCt2RW5Sd2dMS2JkYU4zSHB1OHlRc2N2V0lX?=
 =?utf-8?B?V1FsVTlnbXdCOUNRRUVEWkluSXlBUEtHUE9adk4xWlVMVTBteS9YU0hyMW9J?=
 =?utf-8?B?dlE1RElyT3ZiKzdmei9LditobDVkSzVvb2RzRGl1N2x1TnBUeE9LK2pCWnli?=
 =?utf-8?B?NTgzV1paSkxuM1BCRVJDcjJuNjRqelZmN09zeDJxNVArbjgxWjZxdGdGdjBR?=
 =?utf-8?B?NmFBTXZUWUlQdXR6WmNNRXpBYUFTSFlJZ3ZDaW0rcEx6Z0hqWVVYZzhFWkZa?=
 =?utf-8?B?K0FxM0NGcXVKUXNqRE9YMm8rbmdQdkMzU1VoeFVRdG12ZEx2NWk1cEVpTEVW?=
 =?utf-8?B?SndTUjJ4QUNhaXBBRXBFRkduK0V2QXlKcnJkSDFBaFlXZjlMeXlKMHdiLzM2?=
 =?utf-8?B?TURidGk5THVOQmFnR05yNENpaVl3WW93UW5ydzRoQ0thYmVTUjBiSktZYnVZ?=
 =?utf-8?B?dW1VSWZkcnY0NDY4d0s0T2c1QzM4VkUzMVdCNmlFdVp6UVJWSjJQU2RVTGEx?=
 =?utf-8?Q?vZtFMiGTFwkOYjjYokdyiKpSMghnCc2gMLCAg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEFrNHp1VzNTdGVRV2tCRmY1YldlNlQzZGFTUnpZRXZZRFo1RTNYYzQ5VkZI?=
 =?utf-8?B?aUo4MVBNODZVb1FhamNxYWNJemVudDBDVUhzSmhSa2ZaY3pxWUxQbWttVGxr?=
 =?utf-8?B?WE00eitKM2tYWEQ0dk01Nkl2QUhNSzJZMFFLa1ZDL2gwenJIbHZocWVNR2ZG?=
 =?utf-8?B?SFpUcWN5OWdocWRUV1NwUUxCUnhOb2VmZFoySUNxckZscXVMdFA5NXVOMjdj?=
 =?utf-8?B?ZGpQSVRwSUQ3bkRZNHk4NVpDT2lWb3JEYjhONGxDNklCNWRqbWo2c1hlQTdD?=
 =?utf-8?B?d1RvWnpHMEJTLzN1UjBNZGFuUFhjRllYdHFnb3p5N2dBcy9vakNxVStBeFk5?=
 =?utf-8?B?NWxOL04zZWgrZVVGdFZVM1JEdTZJdWtoVWROaFIwZ25NMjk5VHFENVpmWSs0?=
 =?utf-8?B?MVdsYktEZjJXa3RnWTViT00wSnVYdm42TkhQeEozQTJna2FTWTZWdzRDUWxX?=
 =?utf-8?B?NmxKc3FtWHBWSThUU3EyZC9qV0hjR1pGZFlSNGI2bHRkRHh1WjhXaUM0V3dW?=
 =?utf-8?B?TmZ0RUpCSFpDYmxuWGx6LzlKZXZvVDErOTJFSW03TXhBN0FPdU1IK0lMSGg2?=
 =?utf-8?B?SGVnWWpOcHl5QTBTUXo2NlordkV3SGZCTHpKOTBMTjhHajZCaEJ1VFJiVlAv?=
 =?utf-8?B?RE1OZE9uVitmTWlFQjdQY09JS1dzVCt5eW5aRkFWL1dod1c0bHBzUS9aSk93?=
 =?utf-8?B?RzNFdXhWa2xrT1M2WjdlSVBpT0tQS2lUWTVoR0ZHZzRWNVhBYTlaNkhXN3Av?=
 =?utf-8?B?MFhLRXhYelM2ekJsekJnK2NqU2lnSGRVcjJXMUt6NWZub0N2RlAxVWxrZm1j?=
 =?utf-8?B?YjJqNGhmcUVkOGxISmRHL0d6QkxybzNvQWpXZ1lXVTJzTjl1NGVtb0lxaC80?=
 =?utf-8?B?bFJzSkp4d0g2RGRMRFcrcVBVeENoZE9NWVI3aHVLZk1VZk9VdFFoaDhOMTJm?=
 =?utf-8?B?Yk1XbDNMMHVuQTUwNnFtcS9LN1ZvMWdSaVJmeTlsZ2xHK2JyQUlBVjhIRlV1?=
 =?utf-8?B?cVFuMk5tSlJCVzRjWXdhL3AwTm5lZ2pxNnZpRmJTbW85UW5OZUhlNWdQa3RX?=
 =?utf-8?B?YlhYdUg4RjFWa3RicmdRb0hCYk12RXMvZ0ducE9jQmtYVmVBbnRSVWF2TXVB?=
 =?utf-8?B?dVJPZldJQmM4Q3FRbjE1WXM5eGtKWE12clllbFZOVWlhWUpxb0QzejR5V2My?=
 =?utf-8?B?b2lEV0FEWGhOQkRZdVR5NWlZYWlidy9aU25lM3FCQjY3Z1J0ckJGMWV3dlNL?=
 =?utf-8?B?VkRaZHpERWE1bHVLd3V4WnBiMjFTLzZNTzlKNjNaYUdQMVp5UTZTdjlMTS9S?=
 =?utf-8?B?UlV3TUc4djRKMzhDSnRSZ0hnRk5lMElLREFHUER2VGZ4N3h4c2lzTkJOaHZI?=
 =?utf-8?B?aGVRWWxkbXdmYUFjbTRnaVlPUFJwWklzN1ljM09mY3FQNUpHU1VzRDUvdU02?=
 =?utf-8?B?dWZhMnZ6MnFOdER2TGtPYW1yZ21hajRaUVJWSExqWGY4U2tmV3p0MUtnVG5D?=
 =?utf-8?B?N0hqRmNtR1FKODBHSkZORWNpdXNGWkNla0J1YkNnMDRNTVRDNzd4MnN4SE9r?=
 =?utf-8?B?SDFYc25VbkttOFhqNHZkS0ZoTVkyNEh4dlI0c1ptZTJMNWpRV012VnptdFdI?=
 =?utf-8?B?N1BKbkcvMG9qb0xMUDljb1E4RUhheE03aVhWbWNMRnY5TnZialIwdVN2akJ6?=
 =?utf-8?B?bHBWZEpMcmNVb29GS0x1NUhLTGIxZDFqSERyUW9jT3JtTmFwSjF6eHdxTFB1?=
 =?utf-8?B?enJuYkk1dDRmRlJFTDRPUUdKUmluSm11a2R4MjYzKzkxKzVndzV0TjZaOHll?=
 =?utf-8?B?ditWQWNEOVptdlhESm44YlhudVhmM0N1OWRISmpVOXFuanBCODZ6T291MUNR?=
 =?utf-8?B?Y2dEcXR6d09DSy9yYjNOODk3bTNqTm4yamFkQXc4TktYa2N2R1pjbHJsQTds?=
 =?utf-8?B?akVxYlZpczRkZXhxcFRoQ3dIUGdqd2FibnJUWmQvbW9jdnVjM2M4cHBBdWR2?=
 =?utf-8?B?S0IwQ0l1bVNzbkgvVUsrNFhkNk9GYUlPY0dSZ05WRmdTaDNwNmY2b1BjaHFK?=
 =?utf-8?B?a3llR04zcG1uT1JoWHVOWXNick0yNXlxVU1nWEZqQ1NJU1J0ZHR2eFFodlpx?=
 =?utf-8?Q?sRXM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c25f5d4d-47b6-48b6-72cb-08dd04ff1adc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 22:53:07.1727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yba3KdaYOb4T7Ri4RSsXR76RcaRKIjGGKOUJRb6jX2Zgtb5iinmcm76soTv9c+1ovN5cHt3zLdvkGelWn9vS3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9967

Add three registers: doorbell_bar, doorbell_addr, and doorbell_data,
along with doorbell_done. Use pci_epf_alloc_doorbell() to allocate a
doorbell address space.

Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
callback handler by writing doorbell_data to the mapped doorbell_bar's
address space.

Set doorbell_done in the doorbell callback to indicate completion.

To avoid broken compatibility, add new command COMMAND_ENABLE_DOORBELL
and COMMAND_DISABLE_DOORBELL. Host side need send COMMAND_ENABLE_DOORBELL
to map one bar's inbound address to MSI space. the command
COMMAND_DISABLE_DOORBELL to recovery original inbound address mapping.

	 	Host side new driver	Host side old driver

EP: new driver      S				F
EP: old driver      F				F

S: If EP side support MSI, 'pcitest -B' return success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pcitest -B' return failure, other case as usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v6 to v7
- use help function pci_epf_align_addr_lo_hi()

Change from v5 to v6
- rename doorbell_addr to doorbell_offset

Chagne from v4 to v5
- Add doorbell free at unbind function.
- Move msi irq handler to here to more complex user case, such as differece
doorbell can use difference handler function.
- Add Niklas's code to handle fixed bar's case. If need add your signed-off
tag or co-developer tag, please let me know.

change from v3 to v4
- remove revid requirement
- Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- call pci_epc_set_bar() to map inbound address to MSI space only at
COMMAND_ENABLE_DOORBELL.
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 117 ++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ef6677f34116e..6077a51bbd7c4 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -11,12 +11,14 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/random.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-ep-msi.h>
 #include <linux/pci_regs.h>
 
 #define IRQ_TYPE_INTX			0
@@ -29,6 +31,8 @@
 #define COMMAND_READ			BIT(3)
 #define COMMAND_WRITE			BIT(4)
 #define COMMAND_COPY			BIT(5)
+#define COMMAND_ENABLE_DOORBELL		BIT(6)
+#define COMMAND_DISABLE_DOORBELL	BIT(7)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -39,6 +43,11 @@
 #define STATUS_IRQ_RAISED		BIT(6)
 #define STATUS_SRC_ADDR_INVALID		BIT(7)
 #define STATUS_DST_ADDR_INVALID		BIT(8)
+#define STATUS_DOORBELL_SUCCESS		BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -74,6 +83,9 @@ struct pci_epf_test_reg {
 	u32	irq_type;
 	u32	irq_number;
 	u32	flags;
+	u32	doorbell_bar;
+	u32	doorbell_offset;
+	u32	doorbell_data;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -642,6 +654,63 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
+static void pci_epf_enable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = reg->doorbell_bar;
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct pci_epf_bar db_bar;
+	struct msi_msg *msg;
+	size_t offset;
+	int ret;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	msg = &epf->db_msg[0].msg;
+	ret = pci_epf_align_addr_lo_hi(epf, bar, msg->address_lo, msg->address_hi,
+				       &db_bar.phys_addr, &offset);
+
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	reg->doorbell_offset = offset;
+
+	db_bar.barno = bar;
+	db_bar.size = epf->bar[bar].size;
+	db_bar.flags = epf->bar[bar].flags;
+	db_bar.addr = NULL;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &db_bar);
+	if (!ret)
+		reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
+	else
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+}
+
+static void pci_epf_disable_doorbell(struct pci_epf_test *epf_test, struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = reg->doorbell_bar;
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+		return;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+	if (ret)
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+	else
+		reg->status |= STATUS_DOORBELL_DISABLE_SUCCESS;
+}
+
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	u32 command;
@@ -688,6 +757,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_copy(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
+	case COMMAND_ENABLE_DOORBELL:
+		pci_epf_enable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
+	case COMMAND_DISABLE_DOORBELL:
+		pci_epf_disable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
 	default:
 		dev_err(dev, "Invalid command 0x%x\n", command);
 		break;
@@ -822,6 +899,18 @@ static int pci_epf_test_link_down(struct pci_epf *epf)
 	return 0;
 }
 
+static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
+{
+	struct pci_epf_test *epf_test = data;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+
+	reg->status |= STATUS_DOORBELL_SUCCESS;
+	pci_epf_test_raise_irq(epf_test, reg);
+
+	return IRQ_HANDLED;
+}
+
 static const struct pci_epc_event_ops pci_epf_test_event_ops = {
 	.epc_init = pci_epf_test_epc_init,
 	.epc_deinit = pci_epf_test_epc_deinit,
@@ -921,12 +1010,34 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (ret)
 		return ret;
 
+	ret = pci_epf_alloc_doorbell(epf, 1);
+	if (!ret) {
+		struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+		struct msi_msg *msg = &epf->db_msg[0].msg;
+		enum pci_barno bar;
+
+		bar = pci_epc_get_next_free_bar(epc_features, test_reg_bar + 1);
+
+		ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
+				  "pci-test-doorbell", epf_test);
+		if (ret) {
+			dev_err(&epf->dev,
+				"Failed to request irq %d, doorbell feature is not supported\n",
+				epf->db_msg[0].virq);
+			return 0;
+		}
+
+		reg->doorbell_data = msg->data;
+		reg->doorbell_bar = bar;
+	}
+
 	return 0;
 }
 
 static void pci_epf_test_unbind(struct pci_epf *epf)
 {
 	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
+	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
 	struct pci_epc *epc = epf->epc;
 
 	cancel_delayed_work_sync(&epf_test->cmd_handler);
@@ -934,6 +1045,12 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);
 	}
+
+	if (reg->doorbell_bar > 0) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		pci_epf_free_doorbell(epf);
+	}
+
 	pci_epf_test_free_space(epf);
 }
 

-- 
2.34.1


