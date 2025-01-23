Return-Path: <linux-pci+bounces-20287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D93CA1A6DE
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 16:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F043AAD0B
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 15:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8082520F09D;
	Thu, 23 Jan 2025 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YYtwjo2O"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07A20B22
	for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2025 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737645496; cv=fail; b=HyxMCMo1EPnJ6cUWK6RRU6BMBNy/UMHarYBCyVZy1zjR8RNF2yqpwwBBEBMODU5BOqpWZ7YO3J8+xUd9SlHTVcVHDlr19HnbBDXBcgl/pK23pwn409ZpxdK+dEBVVAVh95iaqslTh+9bGhhhRtChF90CnZBEqWSY+JI9xvOsesw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737645496; c=relaxed/simple;
	bh=YCIl6dxFq8lTdogIKI8jYDGEq8djqiZKWYO32GR6Alo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nSfA22O1JkOXCN78dN2+gBpBrNt6gkI4JeyMOQA8E4kNd8QKKiL6n7JhF+gSWGIVqsN4i9pJA45oV+QDaqmOEonOLXe94ml8MsIhAQ71hxdC+wA997r/dMLQ4Ow9s1zdZ/MMrccSaQuoLa77SH5ENMuQNiDHifv/oHfo808D7N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YYtwjo2O; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMvCsg5cDGX4Z43xazxS4iO432nYof91zpwmwwhM+z3QSw4c0ahXjfcT0DFyyYNTw9sOb/KtpUrJckh+kP8OyYFNFRYojVXhHgbX2wo7hhbseFf3FVaoRdouu0PR6u0MUPF/tDk19cS4tUM39iHTkDCHo5RorglGwtVA1NN9pKuJs4xc6yLVUVsugqhkcUOum/KwUxfDsCs8jqaSzWHfBviD4kBSs5ThupTbr40ucbORYlGIMzUOVg+1oD0D8LTIlO/D7IusuSa/d0psk337NJEZ9xDnpu+94a2UXRx11GyT0uRfdBFs5a8zt57k5XzVbi1hWPp7E+Q90EiiMARXyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2q9QA5ALa9CrsrHO7Wj2tzU0GC/NRU8Zhc2E70O75vI=;
 b=SPPmCOjQzj9dgpqdmpVOJ0oslI/9yAw/m5SUprvzMHidWzUhl1B/Wx77wi8ikJFIMgivv4YGc0p72Xe90DujuDmV1Qt520DB2ZTuRjzCLgYfBEcyCF6Eli0vhQ6cno83/I44T8xHbdApMQfhwGir+lWZwNR5KvOKHzB+S70fV5YfZkwr+sbKmCgvGt2B80nIdCIj6PyTQi0uHScFlQXWdH2+XDKgWCKZ/wqAg7Jijh2Ka0a9z2xfn7PRKCsNRXeTcKjXn+oLQjp/Wwk4ZUI16BJEWQI5uDhoiVwHWz6pjQqFTt3cir3n0U8jxqUhTRRioC8DLtTTSvofuzevfzuE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2q9QA5ALa9CrsrHO7Wj2tzU0GC/NRU8Zhc2E70O75vI=;
 b=YYtwjo2OUdtf2UzT6latO1IWlBDK7yxwp+Uua4uR5k+bZw9Ki0i8H/LsWXSj1UHMtTaB9zQ9bVNP0XoQ7MiEdtcXlmymh2pvaa+OzG4r969m6h9+PwpFd2fVQST1sPn13rE+3m5zSkmTYCGOMonfsK9UPLwL/ayW0BRzxYs3ltw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ2PR12MB8875.namprd12.prod.outlook.com (2603:10b6:a03:543::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Thu, 23 Jan
 2025 15:18:11 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 15:18:11 +0000
Message-ID: <0817690d-900d-4f42-9d93-97da9018f517@amd.com>
Date: Thu, 23 Jan 2025 09:18:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] Rate limit AER logs/IRQs
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 PradeepVineshReddy.Kodamati@amd.com, Lukas Wunner <lukas@wunner.de>
References: <20250115074301.3514927-1-pandoh@google.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250115074301.3514927-1-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0096.namprd04.prod.outlook.com
 (2603:10b6:806:122::11) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ2PR12MB8875:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b42c80-c598-43f7-96b1-08dd3bc125fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXNPQlhQTlhHNGl2aUdhbm5FN1M5bE8wTmFUS0Q3dUl2aXkxWEJ4b2gxS1Rk?=
 =?utf-8?B?SWQ4V08yM2NFeERUeEtFa3hBS1c1b25mN2tEVVBGTC9HMWJNbk5nVCt5NUZB?=
 =?utf-8?B?NEdyekRlS1gvZGR0c1J6RmRyL2h4QWxrWG1Qa25vVXZUdVVLK081akFyR21k?=
 =?utf-8?B?azFmZW8xb3p5ZU5nOExNc0UrckhkdEJ3ZTIzMVVsVEFGY2pYckkwQWNqTmJs?=
 =?utf-8?B?SXZWdHhrUnBZUThiRmhJbkduTTh5blcyOTFSTUJ2MnF1WlRtMHJ0c3VMMmFJ?=
 =?utf-8?B?N0VWdmtJTE16ZWFwelVZQ0pnS25Xd0FDTzE5czB6MlFRa210Y21BZEgvbVl5?=
 =?utf-8?B?M0xMZTRtVDVlVXNHNWc1cCt6eWo2WHVLbkJMUWMwSkc1UnVXQVlpYjJVZGg2?=
 =?utf-8?B?WHJ2NUZNR05FbFU4ZCsrbVJ1RXFGR01XNmV6WkZ4WVdnRzRrSlNsQVJuK1M5?=
 =?utf-8?B?clpwV3V0QkdMditnYjAzTEszWjJCQzhBWktmTFh0cFAwV21zelN5RXpOeVRF?=
 =?utf-8?B?RVJHdE5CVWxjSHBteFBzNW1HdXZNWWxoRi9uUEViNnRueWxiY3FLRW5Pams5?=
 =?utf-8?B?NVJHZ094T0lscjJ0bmZPVWx6aWlRMWNyaldPNVVKcmcvN3M4a1dkRDVkNUww?=
 =?utf-8?B?cSt4R3p1QmNuMFZTNDlsd0swbG5JOUE2aHZuei9LZ2duQ2JoRisxSHRSWUxO?=
 =?utf-8?B?WTVFajQ5enJpOW5nT2pFNU1LT2pxRGJ6Uk9oay9pU3hGZlJnRDlHVzFpMHVY?=
 =?utf-8?B?SEQ4b3hIcllhWXZZVnRHTEdnSDVyM2ExWXNLT1RWZmhQbTdYMExIYUZ5TmZJ?=
 =?utf-8?B?ZDdrMERXUXpBVkZGK1dDOWM0MVlaV1U4RE5rNGtYMjFmK0RDK2k4ZXkzMHls?=
 =?utf-8?B?Qnk3d2Y2UE11ZUF2eHBKZElYMUk2czEzVVpIQ3MyaCtReVRyc05XU0IzQ09x?=
 =?utf-8?B?ZWQ2eE42WUVpZk9EN21XQ1hGSlhiY1drbGNxcTNSRm1Id0I1V0c4Ym41ZE9I?=
 =?utf-8?B?dVczODNaTFNvQXRvNEpINFdrWlZLc1NrVm52T2x5djJyMG11eWRrS3p4ODNR?=
 =?utf-8?B?ay80eXdRVWpLM2pQdWNkcjBGSTFzRE92Z1FEUksxU2JjbHpxOXcwa0xuZksv?=
 =?utf-8?B?OGpsTUhpcXhpM1oxN0VBeUZPR3VWcEczdk85OWJtaWVrdVI5U1pSeTU2Q3Nw?=
 =?utf-8?B?VVFDR2FDcW1ISTIrUHQ1WnMwVXlWTG9lWDJGMzQrK0NVUFQxMHZXdzRTNE04?=
 =?utf-8?B?VUcxV2pMbWN1U1ZYU0lQbXZIRjVlQXV3ZWJhSWE3d3NRYVNqMVlSeFlHeFMz?=
 =?utf-8?B?dittRnNFNDJuUElvalprYXdKQzZlMDJhQUxrM2dtQis5WjRzdkVXOU9HNXI4?=
 =?utf-8?B?Zlg4eUdrSTY3Y3p1ODY4ZmRsT3FDczlpekk4YkhLczJVWFhqR1FnZStuSWVH?=
 =?utf-8?B?RjFaQWJjeGorZnNSdStjeTNndUZFYklEWkJwWlAyOUo4YUFVcUVrcEFLNmpT?=
 =?utf-8?B?Z2wveGNISE92RWJOamVERjFuKzRsQUdpMHNrTjRyVndmZmt1dE5jcGhJeTNQ?=
 =?utf-8?B?Z1JCYWN3dFZ3T3RQRnljcEduazF4ZUx1cE5qOGh5NTM3N0Z4anBhUVFmbmNx?=
 =?utf-8?B?aTZZTGVjS2NqaXFqYWhYNWduY2lXdTVMWWxaREpTbm1XMUIrOXNnZGZxdUov?=
 =?utf-8?B?dXI3RWtuYjlMNUJuVFFXNGwzWUdRZEJub1NPVzRKbmdhYnluRklKOVBNUDBy?=
 =?utf-8?B?WDlBVEx1VjVna3hnOXc2T1ZiYVpBb1JHMVpNenA1YUQyb0dFRFp5dGlSb29U?=
 =?utf-8?B?aHBQNkQ1dW8xV09iMnE3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTFycVNPeWprSzJnNHQza1czdk54TTdvRHdxM1FudmVscHdWR1M2V1Q2RFRI?=
 =?utf-8?B?RW02bzMzVTJpTS9pWUc5bDNoclZSSU04d2hCaTgzM2N5OFEvWTdXWERGMyt5?=
 =?utf-8?B?Nzh2WmI4blhuMUpYTFVZS1ZPTzg3UGxsWkJ4M21VVXloSlVJaEhkQjJZNEZi?=
 =?utf-8?B?OEVSUkprejkzL0RqSE9COWlnUkdwbVpOUTIvSnhBK0lYYnVhN2MxMytOR00z?=
 =?utf-8?B?eWt3OXVoaGlKNzNKVFBrVFJUemZDeFBaclpnajVac25XWFJ0dTlRL1NDd3Nk?=
 =?utf-8?B?Z3ZJeFMyWENIYlBpam1qVVFpYzBoU0ppV0I4WXlndXQrQjdQSitqcVRDdGxJ?=
 =?utf-8?B?bHpxRnl5bHF6blVQeUhyemk4anloR0NjNndYbkJ1amI0ZDlmaXBhTkgrYzBs?=
 =?utf-8?B?VFlINXgvcFdpMFYxREdhejJKUjNwdlV0aFZmUkZtcG5xK3lwQnU2UmpyWEE0?=
 =?utf-8?B?WVhGaC9SODhpRVNyYWZsRVZBVFBhWUV3YmNKUytNZThyeFZ0emVZZHhpMzhE?=
 =?utf-8?B?b0lpQmNNT01IVFpVR2lBTWc4L3FjVFlZRTdJaWE2YitMSThNNjdyVVhTeTdP?=
 =?utf-8?B?emZzWTl3MnhEanNQSnNieEE4azhYT2IrTUFxTFU2ejBpNFNtclhYMXdyUnpl?=
 =?utf-8?B?TGVrNjdtL2xDL0JZL0UvSVl1MTlQdmE1Ti80N0ZUTS9JRUZtQUtCNHZFVU5u?=
 =?utf-8?B?MkRoRml0Z0huSGZWc2xnRlBITllseXFVSFNKQ2E4UjVGREZ5em1mdFlvdVFC?=
 =?utf-8?B?UEpYTER4bGpvRHZzK1YvM2M5TUZhUHpWNWRwUHhJMEV1VW9NT1RyY3JDbGJt?=
 =?utf-8?B?MmpZempoYTBLdDhrVlcwVHJKTW5vUEI2cWIyKytWdU9LUFBEOEliOFZBSXhF?=
 =?utf-8?B?YUUxRFNRTndBSFg4akZ3TC9POThtdmJHVkt2K1A0cm8xa0U1aXd0S0Z3RFl6?=
 =?utf-8?B?L3NTVVdic3NXeUFMdENibHp4WSt5T21mQmtKbXM3VWZINUw2aXcwRjl4NWs0?=
 =?utf-8?B?bHRVZG5aZzZtdm5lTi9nQkR2TTE3eHM0SU5LZ3ZtTC81SVl2KzRlYm4zK1dq?=
 =?utf-8?B?SG9qbEJLcGhJMnViMzV3RWFOejhib3FhZHk4NjBEdi9BdGlra0sralQvKzU4?=
 =?utf-8?B?WU94NEFqQ0xqNXFYSEdxb3g0eVI4RC9zb3J0dWFtdERtSFJtb0hHZ3Zla2dK?=
 =?utf-8?B?QzFFL3l2Ykw5ODRBaUh2T1VjaDR0S0JSYWZVY2FtamIwSE96TG5KS1VtMFg4?=
 =?utf-8?B?K3FOZGk5TmM2bFUxY0Rlb2QvVFUyQ3ZKZXc4VkJOclliKzVDS0VHTjhjWkF0?=
 =?utf-8?B?Z3E2eVE0OUxZVVhrYnYwUncvWVRlSk05d1JXUVNOVDBrcjQ5TmtaVlFiTWVW?=
 =?utf-8?B?Y3BTQ0xnODdrYWdtN2pLblRsTWxZVG5GVHhRblliWXpVdFoyZllrayt6d2N4?=
 =?utf-8?B?VUZFK1dvUU9RRFZDY3h4ZWlQY0h3QWx0S3FHTmJOaFltTExSNVpsQ0daRG1M?=
 =?utf-8?B?SENITDdEV3JaTEUwTVgxL3FkTnFTcm9yOExaSGF4WE9TVjArWC80ZnR2c0R3?=
 =?utf-8?B?QmtrdnBZN3ZwSEM4SVpWcWJSTnRSUWlGNEFGQTVZYU1sR1d5eHpyRGV0WXEr?=
 =?utf-8?B?ZCsxRklvdUxJdm5uOFU1V2pFZXdnMUpsVVBISWJmWDVXUFpCR3ZWZW44TVdX?=
 =?utf-8?B?bVJOSXkrZnB3WHJ6dDNhMTQ5eXlSNHJudlNwVGJrS0hCQmlwdE4vd1hOSVhG?=
 =?utf-8?B?UkNxRFBPNU9aLzEwTDdmUHpSaDh5azlSQndUOTBHMFo3dkFLdmRGRkhMZFph?=
 =?utf-8?B?RDMwTmZVUnhuaG96Qm9acDdWRG9FUHpZbm9FN2VzdG5VL05nSitwWXNFR3BI?=
 =?utf-8?B?TUc3UXUrV1ZSbVBOaVQ2U2x4TjFNQ0piaVVTZitsNjI2VzN3aHAzeU5hQUJU?=
 =?utf-8?B?K3JvMVc0U2pic21CQ3NWS2d5UkpVOXRZMEU2V3NkTk1hV0VRQWlBZ09sZE5H?=
 =?utf-8?B?M1J5MThkVGRTVnlJU2o4VDlyZUd2UU04b0VLODVXMTFoWFBnampvd3BSZWVx?=
 =?utf-8?B?OCtaTDBkTGc4a3ZXcy9IK1BWR3o4bmI4WTlkYkwwemF4WWtxVEpCcVZ5ZTNZ?=
 =?utf-8?Q?47rFfc/ZEkr+gUGS/GKxaeY7O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b42c80-c598-43f7-96b1-08dd3bc125fe
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 15:18:11.1391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BOHY2jt0cONE7s/2j5acbphJ+fE31/YviFoH2UCV7cIswvj11SY3Hyfa3H8by5bEbcuyFKHI+QSNdV2PO3RiTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8875

Hi Jon,

Can you share the base commit used here? I would like to try the patchset. 

Regards,
Terry

On 1/15/2025 1:42 AM, Jon Pan-Doh wrote:
> Proposal
> ========
> 
> When using native AER, spammy devices can flood kernel logs with AER errors
> and slow/stall execution. Add per-device per-error-severity ratelimits
> for more robust error logging. Allow userspace to configure ratelimits
> via sysfs knobs.
> 
> Motivation
> ==========
> 
> Several OCP members have issues with inconsistent PCIe error handling,
> exacerbated at datacenter scale (myriad of devices).
> OCP HW/Fault Management subproject set out to solve this by
> standardizing industry:
> 
> - PCIe error handling best practices
> - Fault Management/RAS (incl. PCIe errors)
> 
> Exposing PCIe errors/debug info in-band for a userspace daemon (e.g.
> rasdaemon) to collect/pass on to repairability services is part of the
> roadmap.
> 
> Background
> ==========
> 
> AER error spam has been observed many times, both publicly (e.g. [1], [2],
> [3]) and privately. While it usually occurs with correctable errors, it can
> happen with uncorrectable errors (e.g. during new HW bringup). 
> 
> There have been previous attempts to add ratelimits to AER logs ([4],
> [5]). The most recent attempt[5] has many similarities with the proposed
> approach.
> 
> Patch organization
> ==================
> 1-3 AER logging cleanup
> 4-7 Ratelimits and sysfs knobs
> 8   Sysfs cleanup (RFC that breaks existing ABI/can be dropped)
> 
> Outstanding work
> ================
> Cleanup:
> - Consolidate aer_print_error() and pci_print_error() path
> - Elevate log level logic out of print functions[6]
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=215027
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=201517
> [3] https://bugzilla.kernel.org/show_bug.cgi?id=196183
> [4] https://lore.kernel.org/linux-pci/20230606035442.2886343-2-grundler@chromium.org/
> [5] https://lore.kernel.org/linux-pci/cover.1736341506.git.karolina.stolarek@oracle.com/
> [6] https://lore.kernel.org/linux-pci/edd77011aafad4c0654358a26b4e538d0c5a321d.1736341506.git.karolina.stolarek@oracle.com/
> 
> Jon Pan-Doh (8):
>   PCI/AER: Remove aer_print_port_info
>   PCI/AER: Move AER stat collection out of __aer_print_error
>   PCI/AER: Rename struct aer_stats to aer_info
>   PCI/AER: Introduce ratelimit for error logs
>   PCI/AER: Introduce ratelimit for AER IRQs
>   PCI/AER: Add AER sysfs attributes for ratelimits
>   PCI/AER: Update AER sysfs ABI filename
>   PCI/AER: Move AER sysfs attributes into separate directory
> 
>  ...es-aer_stats => sysfs-bus-pci-devices-aer} |  50 +++-
>  Documentation/PCI/pcieaer-howto.rst           |  10 +-
>  drivers/pci/pci-sysfs.c                       |   2 +-
>  drivers/pci/pci.h                             |   2 +-
>  drivers/pci/pcie/aer.c                        | 227 +++++++++++++-----
>  include/linux/pci.h                           |   2 +-
>  6 files changed, 216 insertions(+), 77 deletions(-)
>  rename Documentation/ABI/testing/{sysfs-bus-pci-devices-aer_stats => sysfs-bus-pci-devices-aer} (69%)
> 


