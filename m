Return-Path: <linux-pci+bounces-16573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4019C5F67
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 18:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BFE7BA0EA2
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DFE20607F;
	Tue, 12 Nov 2024 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mj9lo3bW"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013001.outbound.protection.outlook.com [52.101.67.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96EC206067;
	Tue, 12 Nov 2024 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429017; cv=fail; b=mJSk23wq5RNWyiQhXBJEkoJHBv1S7oAdbxIX+cNZwgZYQdgwAEsHtGgXTklBXbNJRJePicWgWkTzMwNv67TV1fnaAx/zAKvmECf27Yvp9y+UPAKRGBzdPygS3b8tzjCJIyugGNJVVCWwNVzJc2qb5Dv7MDShybX+MB0kfgU0NfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429017; c=relaxed/simple;
	bh=z2gfUk6Iy0qpccEqgsQb1mQyi0vsw4beh4C3pSh0IPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bhG9N7ICsZv1t5OWEkdAfitohvkuOXKowUz+9Wy9hPXakwNyRw9MJnH6lJG9hzelAvZTXRdqGvWfm5wu6rjNrcJpB3MWWahBtQserKWnXzufLp3MvJonELZQFqR4aFNMtbrVpQMheMFLBdk4MU7re6JS6m+F+WNH43mwRlndeLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mj9lo3bW; arc=fail smtp.client-ip=52.101.67.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDJvBD0o0Yuda4WWA+BJHGP4r7z0UJkcP1uLUVmGWCXCCAXnCuAetj/1GFpEL2ovz543aHvaqpx1D2Te3NHz0VQiG7Qezp3NCROkk1O1EvcEWPGV//SSBzKZwc7LPKHEJVSI+MwPqgIOK+lG4tYldwyQ12rIAH8QCE/9H0eU+m20yquHjMjijAQ7PqhcbvF4cDlX6+Kf1k/C5OASK0r1+ycN9R5bFZ2Hky5lC6bnpUUoLzCJYCIY3fw9J4RXYtheApkGD4CjEn/I1O1VBBjrMsUFRtro5WFg2jwnMY9fZnbFMWEMSgEkvDXRaB6ZVqkaWuE73H2dKMti+ifg9eQZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1bmd2vD5VP609WR7RU3xYIiH+QgBRe8pFTZ5gObnKg=;
 b=G9507+rH1C/kgShe/b3hzPy2488wv0ujVbgDPibJOmncNuc53LTPboIUtP+f15LWAWZaHInSjCd3gCCOzLUfzQdWtImeqO2eaMQGGw4stprJgGS1rQXoEucEF4KT1IKDF7n8UT/I380sx4i0pYM1OzsrVx9pw7cnGLEoEyosKa95NVb6+2Sct3501lgNdg41Ct4gJLLihT++8MaqMGezoo6FJpYE93HG/QMnPPxm7cfVC4bZbf9pA/yyzO11hsIxZ17Aur9nO6XttjPLM3jGkiB/YAkO5pm+ZWocCfOjSdaxKbmmclnKvwjiqKF2rbhrBSRllTgZ3horged4v0oY3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1bmd2vD5VP609WR7RU3xYIiH+QgBRe8pFTZ5gObnKg=;
 b=Mj9lo3bWyYL5RbHn1LSksoXE5/sJsJ79VwdQcJSF7fQdUm0NLmb2TUJOpK7SyefNeBjZNX7/3+kwPmL9kBcn7BQstJyzzvSx3caW46Q2TdH4QyFuBgqBNeNEEV7CfeehWbVjBcI3XZGOwTuNtsCiCaH9OoNdtpgyI18Uy0+po/kGXkJ3n0/o7/eiTk+PMtvIBdO27Cx3o8BaHloQDAOjb2xiqGlzcc6Kp9+BjnGyIOROIvt0fnwfB1gfjSvsMRxTeOe+MAK1+uVNkQsS6JUWfuRB2PuoGBFdgtpGCzklzEjLiUZwN7PFkhivFiayAsOubxeapz2uECbLQfMoRtyeag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7953.eurprd04.prod.outlook.com (2603:10a6:20b:246::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 16:30:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 16:30:11 +0000
Date: Tue, 12 Nov 2024 11:30:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: Hongxing Zhu <hongxing.zhu@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Message-ID: <ZzOCi1RKvB9Siy1y@lizhi-Precision-Tower-5810>
References: <20241107111334.n23ebkbs3uhxivvm@thinkpad>
 <20241108002425.GA1631063@bhelgaas>
 <20241111060902.mdbksegqj5rblqsn@thinkpad>
 <ZzJCGkenhxgJxoC4@lizhi-Precision-Tower-5810>
 <20241112080216.6kzdybe2su5ozp44@thinkpad>
 <AS8PR04MB86769CB7A25283A4E252477D8C592@AS8PR04MB8676.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB86769CB7A25283A4E252477D8C592@AS8PR04MB8676.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: afff21be-8527-4add-5f21-08dd03374795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckVmUjBsSitYd1o4bGlhU1B0MStEQUtVQWxoRjJETE5zYnIxeXpiRTR2Zk82?=
 =?utf-8?B?UXFrRU5VakM1OWpDQnpqNEVpMWV5QStrMWRjWit0bGFJNWNXMzFRTDhTdHhq?=
 =?utf-8?B?VmVGS0VNb1pNelNMcjA1UjdrN2VubXVhNk8zaWM2VGpwZFIwVWpaMi9menN5?=
 =?utf-8?B?UVRBRm55cUtDNzNRWkxzdjd0TGQvQm5EVWtDZk9FWitOZmhWWmhiQ2tjNE9z?=
 =?utf-8?B?YnRrNmZ3TVFJVE9HOEdqcUIzQUUxbnZHSHNsVDUweStseVlWdXhHekdHSHAx?=
 =?utf-8?B?eGpzZFI3U3VrZ21mZVIrWkI2QVlpcFpVZzMreVhlU08va2xKMFpDcWpmSUZT?=
 =?utf-8?B?MzJicERid2QwRHY0c3ZNVlpUT3lmRDdZcEY2aVFDOTIxMmJma3M0dVlvM0hU?=
 =?utf-8?B?TnpNejNLNkQrd09aaFlnbk15clJvWmpjU2E3U0JINVFmaTNNRkI5bERnK2w3?=
 =?utf-8?B?Vm1PN3BXYkVGdTQwNnFSbnJaQi9SNUJZOU1RbXJvLzc5aEtUcGQ3MmpZUXRu?=
 =?utf-8?B?c055T2xzdmZ6eEttQWlaOXVlRzF0UFE4U3NDcnkzL2U4cmxhWFU0SFFjTVBV?=
 =?utf-8?B?VGk0b1JQcXdueUEzdm1COWszczg0amlIdFVRd29ISXk1S3hTRG1JWXdpdHN3?=
 =?utf-8?B?SXFyTklxUDVjQ3YzdTdIYnFNWEVOVWNoWlNnWXJFcjc3OGlWb01yNTU3Ynpn?=
 =?utf-8?B?d3lMNFpZUVlLK25zaUZCQ3A4U3RZSGlMNmZaSjkzalE3UWlWWitCcVY5N2Np?=
 =?utf-8?B?V1lzalRMRERmUUlTK3BJbHZWV2VjOUtoZHZSLytjbklyMkpIY242Z2JlL0ZP?=
 =?utf-8?B?TzUwRWdRNC9ieXFVYzEvdmVPUXAzNFVRTjJ4R1hkdDJUbS9IdHBHTUI0bzJy?=
 =?utf-8?B?ZER4bnRueUZ1OUdRb0cyRDc3L1E1RUFyL3VtazlweUtIRFNQNFhYbk03QUdG?=
 =?utf-8?B?YXRxNHpDM1p1RWt5MVA1b2VCMWdPZFhLaXl3TmdLZkFmSnBqYmRzVTZka3gr?=
 =?utf-8?B?WUlOSmgvQnhkZDZLRnpMYW0zQWFYaUFRVW5SYWlmMHJZeTgxeTNoQkc5WHkw?=
 =?utf-8?B?cXlvZGQ5d3FySDFGZm4wYVVKejJONXJFbUtEWGs2RjZiNDdodG84Njh4cGY4?=
 =?utf-8?B?V2dzeUlIbmcrRUNGTnBSZ3JjbVNqcCttVW1qSWRjdmUzaTdQWURuZVZ2UWF3?=
 =?utf-8?B?dkYySmdKRTJSdG9iVGdmcENIUEQ0MUVPRms4ZTdPRVdjZWcyYnJUSm14NG1Z?=
 =?utf-8?B?MThxaVg4ckY3SjFUek1xZEpwelJpYXVtQkxyazNTTEdCbkxHMVNMOCtZNDdM?=
 =?utf-8?B?N0ViaHlFNWhrZmE5bTVWWWZKaEE3QmpVaURuN3QrZEJNMGF5VTZEM2hHSTMy?=
 =?utf-8?B?dnArN3pMY0QrWVJPSTViS2hkeU1xK0pEUGkyekM4RDJnTjlHTnVtalRMZmtJ?=
 =?utf-8?B?QmZackdObFNESTNqTXBQMnFFdVhBK3h4YzhFRkZSd2l1NFM5NDNNZU5CbEx5?=
 =?utf-8?B?Ulk4Q0trQTkxQ3VlRE5HM1FZYklWSGhNZFhEK0JoR0xCOUxRUHdkUUtvTDRK?=
 =?utf-8?B?SFlnTlFCb1JpVUhaMzR1WnR0M2prTDBrVGJXWVZ6RVdHSG9zRSthdTQ0TU14?=
 =?utf-8?B?aUZxbjdBSW45U2FWSEcyeHFBcDExZlFVcGpDU3ZXbHFWZUxlWDNBeWo0STYy?=
 =?utf-8?B?SytPN0t5bDREOU9YZ2k5M0ZyeCtPRWVPaFhNd3E4Sy90cWlzamVVK1FqRndO?=
 =?utf-8?B?TXVlVXVJamZ2WVFMTlg2d2piMUdEWWpwNEh0TTJFcXRJUENRY0JXaDlPZENi?=
 =?utf-8?Q?wcUYjPjl8ua9m5z8QcKLwGJi0LeeYSafJbUtU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1FRSUhoZmdNdkpwRVV4dm1kcXdNQW1lYTljaThtZXJtczhHcVp0TVRVMlFl?=
 =?utf-8?B?ckl6RVNOZWVIa3VQbjVEaEc4bUdaMVVaWHFpamdHbHZTVkx6MlFhNmNvZHM4?=
 =?utf-8?B?bXdWMTdUSGkzSjZaQlJDdmFiakNxSlJ0NWhXU0Vhb2h1YnM5U3VySXY3aEFq?=
 =?utf-8?B?c210ZmJvZEpzOFJORzczYXkvWDZ5UE1xdWtJOFY1ZkN6cnpNcmFMK2F3V2NZ?=
 =?utf-8?B?cENXVi9IWWVPS1FncWIxV1dOUlBQYkszN0VveEFUbTZKVk52OGN3bmVDRzF1?=
 =?utf-8?B?aFlNZGxqbVNnaXhmamdIZmhGNTA0Q0NXQ2FpUEI4Q1F3RTZ4NEwzT2tyUDJM?=
 =?utf-8?B?bVRMcGM4anpWUDVjeUM1U0JRbVVpWkxGVHp5ODN6QkYzWmdIeVVhUi9iU1Fp?=
 =?utf-8?B?aWxuejNnYmRtanlWcEtwRGNtUHZmeGxIR204MGZNa2RsRnNncTRyajR4YWY0?=
 =?utf-8?B?c215cjJqdHFjeE55OE9CWE5TY0lvUjFtb1R0T016K01NMEgxckFnUC9sU3V4?=
 =?utf-8?B?aUxaS2twMXhNRW55eXdXYnNmdi9SaTM2K3NZeTA0Q2ZDVWVnMXM1V0hVVUVm?=
 =?utf-8?B?VXUrY0h2M290L0dzYUZiWWxmeDQzS2grcXFlT2txMWRxa1lDVWtzR1ZIWkJ0?=
 =?utf-8?B?QnNra0RDcmZ2RDRJSzgvRm1yK0VNbnM5ajVKQVNmMkNCSlNOUERXTGlLUDRV?=
 =?utf-8?B?cEp3em8ydG9Tb0xKV0l4Z2dEQnFhNzVrRXpNS3VtaWlYQVgwOEsrQ29UVzZH?=
 =?utf-8?B?YzZyUVkxY3JNcUQyT0tYYVNQdnZLK0ZOMlZHMFdTa0s4MGZiNDRYeHpYNkY2?=
 =?utf-8?B?cUNtSkt3SWRYcDhhL2JnQnFIYWNRbkk2UU5sVFB5NUVHNUdLVUtha2krbEZu?=
 =?utf-8?B?OStPcjJuaWhpOWM5RW1WWEgwUFhJa0xJbmRaVDBXbDdWRUwvVVR4bEVENEJi?=
 =?utf-8?B?aVovVTIwZnpWczc0WGg2K3JFVTF6K3R6T3BkMTRuTFlqRnJpK0crQnpsSHZo?=
 =?utf-8?B?dVdNdGtSOUVramlQMkJZNUg3OXhQSXZKTWF6c0tUUmEzTVM2MnN4VktYcjdQ?=
 =?utf-8?B?aitCbmlMTmVINU9qYzFGSkdqYVdQbFFtRHlyV0lza25sNmlVQm1FUDRFdkFM?=
 =?utf-8?B?eC9iM0p4UDNheDBieWVyYWxQNVYyMGlWdURGRTRvUVcxTWRVZmVPbFFTM2lM?=
 =?utf-8?B?VXRFYzFCQlUrNmp5RmZXYjFvTDd6djJnZ2ZFcFYrL0F4VEhlaXkwZklUdHhV?=
 =?utf-8?B?akx6WTE3emNtYThQMm9EKzRLZFVWMjRTTVN4RlZyUHArMWF6T0thQWk1Q0du?=
 =?utf-8?B?ZjYwRlZoc2FBRGwwSjFNZkE1ZnJWYkcrZ1BKNldKYi94c3lIWEJMOGViSHFq?=
 =?utf-8?B?VFl0QmtlNXJabUxOMHN6S1VXeDNKamdZSEZUalRuNDhPbHRneEZOL0hqYTRX?=
 =?utf-8?B?Tkt6YlZUVGhUZHVqU3R1RTlJUm40RDUxZmtOU3lMTC9xSUhIcWo0OE5BK3NV?=
 =?utf-8?B?elJ5MDhVYk04dXVSQjBUa0VEakNnWEx3YTlEYWRET2g3NDhkWTVyWUhiaHNV?=
 =?utf-8?B?NEJnbnBrKzA2R256U3JES29ETXZRNktNMUhnVnNBbFBYQlVVeWlKQ281Q0NT?=
 =?utf-8?B?R3kwcmZGZGJvSlcxRk9LMVZsdE81QWwzekFTT1RJcEU0UWVIUDkvWkhSdnBQ?=
 =?utf-8?B?eDgvY2k1bXFxMjV0QzFzNm51R1VZcExHZmljdEFqQTJULzNmNmdzODlyTHh2?=
 =?utf-8?B?RHBvbW5tenBKWlozRlpMT01aN0NET0lVL1VhMm52N2xzRENuSk9RZ0JVd3Na?=
 =?utf-8?B?aUsrK2o3QjhVR25mVkVnWEVCQk9SQ0RNZXJFOG5nVzJCbzl2NUFSOXBFbzdV?=
 =?utf-8?B?SGdmUUpBakFzSDVyQ2JsL2oySDIyMmN0Rk9GUFlqUkhSbjU4c01wT28wY0pX?=
 =?utf-8?B?YkEzYjlnQU9JalRxSmpCN0s2am1QTDhrL1N1UzFpdHlzYlFsbmJTelEzWmNr?=
 =?utf-8?B?RFVwaTBia0ZmZXYxZnF6akl0cUpXaHJaRExnTEdoTmwzTU9RQmpycHB1TUd1?=
 =?utf-8?B?MVVxNXlIUUNrMFpNQmRSdkZqM2ZWajkvRFdGM21mWWpoenRBdUw5eWhwMXBz?=
 =?utf-8?Q?HfLqZjnALGNzjkc30zHkZFvLw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afff21be-8527-4add-5f21-08dd03374795
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 16:30:11.6820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: en0yYgss90DPPaRBEyzd2wWDvJOc69aZvLg9UV9lQamKvvOLG7RjVqkr3+pnk4x02gIepNm6GmPlvBYWGbulrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7953

On Tue, Nov 12, 2024 at 09:15:25AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Sent: 2024年11月12日 16:02
> > To: Frank Li <frank.li@nxp.com>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>; Hongxing Zhu
> > <hongxing.zhu@nxp.com>; jingoohan1@gmail.com; bhelgaas@google.com;
> > lpieralisi@kernel.org; kw@linux.com; robh@kernel.org; imx@lists.linux.dev;
> > kernel@pengutronix.de; linux-pci@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v1] PCI: dwc: Clean up some unnecessary codes in
> > dw_pcie_suspend_noirq()
> >
> > On Mon, Nov 11, 2024 at 12:42:50PM -0500, Frank Li wrote:
> > > On Mon, Nov 11, 2024 at 11:39:02AM +0530, Manivannan Sadhasivam
> > wrote:
> > > > On Thu, Nov 07, 2024 at 06:24:25PM -0600, Bjorn Helgaas wrote:
> > > > > On Thu, Nov 07, 2024 at 11:13:34AM +0000, Manivannan Sadhasivam
> > wrote:
> > > > > > On Thu, Nov 07, 2024 at 04:44:55PM +0800, Richard Zhu wrote:
> > > > > > > Before sending PME_TURN_OFF, don't test the LTSSM stat. Since
> > > > > > > it's safe to send PME_TURN_OFF message regardless of whether
> > > > > > > the link is up or down. So, there would be no need to test the
> > > > > > > LTSSM stat before sending PME_TURN_OFF message.
> > > > > >
> > > > > > What is the incentive to send PME_Turn_Off when link is not up?
> > > > >
> > > > > There's no need to send PME_Turn_Off when link is not up.
> > > > >
> > > > > But a link-up check is inherently racy because the link may go
> > > > > down between the check and the PME_Turn_Off.  Since it's
> > > > > impossible for software to guarantee the link is up, the Root Port
> > > > > should be able to tolerate attempts to send PME_Turn_Off when the link
> > is down.
> > > > >
> > > > > So IMO there's no need to check whether the link is up, and
> > > > > checking gives the misleading impression that "we know the link is
> > > > > up and therefore sending PME_Turn_Off is safe."
> > > > >
> > > >
> > > > I agree that the check is racy (not sure if there is a better way to
> > > > avoid that), but if you send the PME_Turn_Off unconditionally, then
> > > > it will result in
> > > > L23 Ready timeout and users will see the error message.
> > > >
> > > > > > > Remove the L2 poll too, after the PME_TURN_OFF message is sent
> > > > > > > out.  Because the re-initialization would be done in
> > > > > > > dw_pcie_resume_noirq().
> > > > > >
> > > > > > As Krishna explained, host needs to wait until the endpoint acks
> > > > > > the message (just to give it some time to do cleanups). Then
> > > > > > only the host can initiate D3Cold. It matters when the device supports
> > L2.
> > > > >
> > > > > The important thing here is to be clear about the *reason* to poll
> > > > > for
> > > > > L2 and the *event* that must wait for L2.
> > > > >
> > > > > I don't have any DesignWare specs, but when
> > > > > dw_pcie_suspend_noirq() waits for DW_PCIE_LTSSM_L2_IDLE, I think
> > > > > what we're doing is waiting for the link to be in the L2/L3 Ready
> > > > > pseudo-state (PCIe r6.0, sec 5.2, fig 5-1).
> > > > >
> > > > > L2 and L3 are states where main power to the downstream component
> > > > > is off, i.e., the component is in D3cold (r6.0, sec 5.3.2), so
> > > > > there is no link in those states.
> > > > >
> > > > > The PME_Turn_Off handshake is part of the process to put the
> > > > > downstream component in D3cold.  I think the reason for this
> > > > > handshake is to allow an orderly shutdown of that component before
> > > > > main power is removed.
> > > > >
> > > > > When the downstream component receives PME_Turn_Off, it will stop
> > > > > scheduling new TLPs, but it may already have TLPs scheduled but
> > > > > not yet sent.  If power were removed immediately, they would be
> > > > > lost.  My understanding is that the link will not enter L2/L3
> > > > > Ready until the components on both ends have completed whatever
> > > > > needs to be done with those TLPs.  (This is based on the L2/L3
> > > > > discussion in the Mindshare PCIe book; I haven't found clear spec
> > > > > citations for all of it.)
> > > > >
> > > > > I think waiting for L2/L3 Ready is to keep us from turning off
> > > > > main power when the components are still trying to dispose of those
> > TLPs.
> > > > >
> > > >
> > > > Not just disposing TLPs as per the spec, most endpoints also need to
> > > > reset their state machine as well (if there is a way for the
> > > > endpoint sw to delay sending
> > > > L23 Ready).
> > > >
> > > > > So I think every controller that turns off main power needs to
> > > > > wait for L2/L3 Ready.
> > > > >
> > > > > There's also a requirement that software wait at least 100 ns
> > > > > after
> > > > > L2/L3 Ready before turning off refclock and main power (sec
> > > > > 5.3.3.2.1).
> > > > >
> > > >
> > > > Right. Usually, the delay after PERST# assert would make sure this,
> > > > but in layerscape driver (user of dw_pcie_suspend_noirq) I don't see
> > > > power/refclk removal.
> > > >
> > > > Richard Zhu/Frank, thoughts?
> > >
> > > Generally, power/refclk remove when system enter sleep state. There is
> > > signal "suspend_request_b", which connect to PMIC. After CPU trigger
> > > this signnal, PMIC will turn off (pre fused) some power rail.
> > >
> > > Refclk(come from SOC chip), OSC will be shutdown when send out
> > > "suspend_request_b".
> > >
> >
> > Thanks for clarifying! Then it would be better to add the 100ns delay after
> > receiving the L23 Ready message from endpoint.
> Okay.
> How about the following changes?
> - Before dump error message, make sure link is up.
> - Add 1us delay after L2/L3 Ready is received.
>
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -940,9 +940,16 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>                 ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
>                                         PCIE_PME_TO_L2_TIMEOUT_US/10,
>                                         PCIE_PME_TO_L2_TIMEOUT_US, false, pci);

My means change
val == DW_PCIE_LTSSM_L2_IDLE || val == XXX

XXX should be one of below value when linkdown, Maybe S_DISABLED or
S_DETECT_QUIET

00_0000b - S_DETECT_QUIET
00_0001b - S_DETECT_ACT
00_0010b - S_POLL_ACTIVE
00_0011b - S_POLL_COMPLIANCE
00_0100b - S_POLL_CONFIG
00_0101b - S_PRE_DETECT_QUIET
00_0110b - S_DETECT_WAIT
00_0111b - S_CFG_LINKWD_START
00_1000b - S_CFG_LINKWD_ACEPT
00_1001b - S_CFG_LANENUM_WAI
00_1010b - S_CFG_LANENUM_ACEPT
00_1011b - S_CFG_COMPLETE
00_1100b - S_CFG_IDLE
00_1101b - S_RCVRY_LOCK
00_1110b - S_RCVRY_SPEED
00_1111b - S_RCVRY_RCVRCFG
01_0000b - S_RCVRY_IDLE
01_0001b - S_L0
01_0010b - S_L0S
01_0011b - S_L123_SEND_EIDLE
01_0100b - S_L1_IDLE
01_0101b - S_L2_IDLE
01_0110b - S_L2_WAKE
01_0111b - S_DISABLED_ENTRY
01_1000b - S_DISABLED_IDLE
01_1001b - S_DISABLED
01_1010b - S_LPBK_ENTRY
01_1011b - S_LPBK_ACTIVE
01_1100b - S_LPBK_EXIT
01_1101b - S_LPBK_EXIT_TIMEOUT
01_1110b - S_HOT_RESET_ENTRY
01_1111b - S_HOT_RESET
10_0000b - S_RCVRY_EQ0
10_0001b - S_RCVRY_EQ1
10_0010b - S_RCVRY_EQ2
10_0011b - S_RCVRY_EQ3

> -               if (ret) {
> +               if (ret && dw_pcie_link_up(pci)) {
>                         dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
>                         return ret;
> +               } else {
> +                       /*
> +                        * Refer to r6.0, sec 5.3.3.2.1, software should wait at
> +                        * least 100ns after L2/L3 Ready before turning off
> +                        * refclock and main power.
> +                        */
> +                       udelay(1);
>
> Best Regards
> Richard Zhu
> >
> > - Mani
> >
> > --
> > மணிவண்ணன் சதாசிவம்

