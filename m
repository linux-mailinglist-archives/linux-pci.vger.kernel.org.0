Return-Path: <linux-pci+bounces-12708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6CA96AC5E
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2024 00:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E82285CAA
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 22:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3835F1D5887;
	Tue,  3 Sep 2024 22:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jYJDYtv5"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524341A4E82;
	Tue,  3 Sep 2024 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403342; cv=fail; b=GgseIjm7tutWjFWpedJ6wE7xnyV8FUVxIjiUlpUTAT8fGON/gwwjSJ+f82T3teZHnyaHdLcYGLtQcyDPGllhg75MZ6d0Yl4RWHqwdbWCw6oN8gU1WcScQVWxl5qzmEvg0zne++4NxJbD35tt1SuFUs1Jbv1Y5LuXLC1415GrZnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403342; c=relaxed/simple;
	bh=9PUd0juuIFQ87l4Yn9c6eqpdqYaIiy2id44KGaIMPO8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=umX76J5+/wvsS3J2V4zxdYkd4AhEzs7Hb6E95Ajm4ZNVl+r0E9Is9uhCo5c10nZVnwK9tr3/zB8ApIe6AxoCgXXDCcviIbC2DfFbI2L4WFXf/FJCUMcPMQozJWaAmRpCinNXE4TqC8pEMj1M8jAG52K0OUogPO69Y8CelljtTKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jYJDYtv5; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYj2Dhxq0PPBRJCo8ZTXZcVQswpMDbl/zbDVoThgVJc4DvSyCXp86V/Rl24weFQLuJSFoWqcgp4f4Djg0XTZeQ1vjhUe5LMglrPzzXkTuKmjQOzkmfhAXCsyaETnrGIyyTBGR507DhSlH6NW5OJZnOxdnu4lex7TDuqOeh/LYK/A6fX/8MrwPZB+t5mUnDMIJI1mjuzS6BQ954lfC9O7s4IVwwQeMw3EtN/djA/Tutzva6gWaWb687A6jh+lxWSE8Vvd27DGHLFVOaUueATxZbWqoVbxw5fsiaW/UO+lCiruXrxT6Ge9/u8L/xzc+GuERD9s5auwhec2FNYoFQrD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMMflL4Pr6rl5i4KWuCd0/+Sq274YO/HaV7YFg6e2yM=;
 b=o7wBvrfUbE1nnvrsg/Ys93rnc5Mt1kGjR+2EA83RYFA3RThFaGCV2UFj9+lzsIl5pR1YeSf0ZbSYPFtsmHVah2hcp5qLd0KIA3G3gWSGAKtmi7fmMqOmrqEikp2zW1S0f76tLPSOmPNMlPVPInT7aMI0AJc6wsAy9sX6Z22J51BEe+DKeCsh/gHqtxzFiNYm/kscUHivchXPD1XgdBlses14MJpm+0QoyrG9BgFZiH7zkk8x92J8igeDo+6glsRdsecNtrC5UjbHKpD2S8tcqr8pLipdqgBN5oiRE2ml7b/NYeRCaUOvGYIGBMVicvAKV3xyOcSyyCHWUD6SU43lgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMMflL4Pr6rl5i4KWuCd0/+Sq274YO/HaV7YFg6e2yM=;
 b=jYJDYtv5AE/DjQHVyBPd4nSVG8rsCgT3bn+my5sSSgbLzXgLLBEYNpOM6RECXnECKIXwmDjIW0MJeSBZ0Dxi0Z/lE+UyqqC+nbgSjlpFHkGUSQvquYHf9ivWJv7m/Y/YTnkH74v/gTlqtqpdRAcL8iuB+UR8TcbqnbT5wqDoVcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 22:42:16 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%5]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 22:42:14 +0000
Message-ID: <04354274-d198-4162-badc-1078d1293517@amd.com>
Date: Tue, 3 Sep 2024 17:42:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/12] PCIe TPH and cache direct injection support
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Jonathan.Cameron@Huawei.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alex.williamson@redhat.com, gospo@broadcom.com, michael.chan@broadcom.com,
 ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
 andrew.gospodarek@broadcom.com, manoj.panicker2@amd.com,
 Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev, horms@kernel.org,
 bagasdotme@gmail.com, bhelgaas@google.com, lukas@wunner.de,
 paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240822204120.3634-1-wei.huang2@amd.com>
From: Wei Huang <wei.huang2@amd.com>
Content-Language: en-US
In-Reply-To: <20240822204120.3634-1-wei.huang2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0113.namprd13.prod.outlook.com
 (2603:10b6:806:24::28) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: c7681c44-1daa-4c21-25a9-08dccc69a77d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmtxVXVhVTdpQytFSGpTVzdLMS8vM3FrYUNjNUl3eDJTdlVGQzI4WGFYdmNx?=
 =?utf-8?B?L3d3Qkl3YmdpNFFCZTRWYS9XVlUzMzJFbWgzR25TbEFSc054VjFKQml0WW5n?=
 =?utf-8?B?M1VnVW5CL3FJL2ZkWGRjWVRpYU1jaVFIOUZOcy8xMUNaRmtMVFVYR2xDMnpL?=
 =?utf-8?B?cEhPVWgxZmhxL2FhK084YjRWcUpkS2o5bS8xd25QYmJBcmszUERqQmVXSzFn?=
 =?utf-8?B?TXZ4WUFLRnN2azVHMzNUaDVLbHBvZ2pYS3ZUNENpc2FpN3FhWHV2L2EzaFRw?=
 =?utf-8?B?NGhTRVR1aVJDWG9Eb01SR1VZcE1tdjd4VWZ2UXhpeXUzOXVPQk1hdGFRcHdH?=
 =?utf-8?B?cmVQZ0hYaHJIVjNHK2NnQUUzM21kdGV0ZCtXMHFoUDg0NmlFcnk4dWhUWE9m?=
 =?utf-8?B?MkIvcFNtQlZHY0hwdURKWU90ei9ORUZEcjRkdlFBVU8raUl5cnF2UytrYUVV?=
 =?utf-8?B?bXZBMW9mRzBaaVZXVzdsTllTNHJQSU9zMExiZzNtN0JJY1cvUDl2S0lVR0V5?=
 =?utf-8?B?bHpGU1MvMW1YaENSYVhGdGFGR0VhZkQ2bzlXSS93dWxhdUVvdEQwcEw2dmRC?=
 =?utf-8?B?cjVtMHcxRElIWmkzWTZYMFYvS1lOOW1SUHNNSzFybGFYVTRhTDJaSmlnb0t6?=
 =?utf-8?B?R0F4aVlVSHQ3MithekhyWXUxWGVoNmpJYll6eGJUU2paZDczNUJzcklHYll3?=
 =?utf-8?B?UjdpYVdkWVZiWnpjMUxFdE1xcVJhZUZFaWpPbmk5ZUp5MXp3YmV6M0JKMVBs?=
 =?utf-8?B?dEdKVGVQWWNDWDdhT2JvUThYQi8yWEt3MTlHWitXUkpzRWlCMVhMM1pPVHBr?=
 =?utf-8?B?bnE2YjNFTlRiMGdPbStEbFQ1V1NoT25TQUNFR3JuUGppSzdQRnJSRzRzOUhZ?=
 =?utf-8?B?ak9DWUJZYlErb3JBL2gxMmlaOEtHT1o3dERrZ0ZVQUt5bzhleFZ4TmU4QWxx?=
 =?utf-8?B?WWlpdzNCVndqMWJGWHZ3WGJnRzl3a2pVWDlQQjdvczhRRTJ2M2JNeHJGSWcy?=
 =?utf-8?B?azR6UHJXaFRXQ2o0dzNBRzFUeUZLU1NtYjMxT2VxZ2dMSitjMHIzZitINUpV?=
 =?utf-8?B?MDUvVWVONzFHKzBHMnNMWnp5dzlSWlNDS0luSENHbTdiQWVMVkpBSHBXY28z?=
 =?utf-8?B?ZlNGVnA4cnpTYkhMU1QvVlVHS2FTSjZFRkttVXcrbmpITHU5Qm4zTzd0Y1Ja?=
 =?utf-8?B?UGNvOVhzb3RnN2dtZWczODNVU0Nzb1NRWGhnK29SeUhrVGRldHZKeXI3blcy?=
 =?utf-8?B?dXF0SlJHTCtscldYTTJYSUN4NTIrMHViU05LQ25MWnNWRXNoU1ZqcGZEeFlO?=
 =?utf-8?B?MklXUDN1YXE3S1hPSWlwYWx6aFZwMjNOV1VtczlDY0l3YXZhMlBLdU9hSnpr?=
 =?utf-8?B?Mm1CRFZ6R1lGREo4eE9rMDd0U1FPTFB4clJvMlJoMVF3bG92M1lSV3NhSllO?=
 =?utf-8?B?bTJVaXMzaDI1WjhLWlRnbEhzVEExck1qUmZDQzZBSHgzT3ZhNnZTNkxaaVJy?=
 =?utf-8?B?andCTDRuQ0FCbGpUNzBiWWtlVktiWEsvbjBrQzQ5SUY4RFZ1ekNVL05OYm5j?=
 =?utf-8?B?dTg2WGJmdGZzbU8rZkpJRHk4T0ZlZlpmaHB3S1FwclNYaEFNOFFxMFVBSUNB?=
 =?utf-8?B?VDc1a0EzeXNzRDR6NkNUaG5XczBHTGEyVUxZTndHWjl6SFFicjVqZXprOEpY?=
 =?utf-8?B?dEw1WmRqaG90N1p2QkkrN0pVeEUvSXpYT3VYalNnaFNzb0RHTkxZU1dMcjhB?=
 =?utf-8?Q?TnDwNCKY9EBKJe43jU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXRZK2RLYkJnREVkV09ERXIyZlNMejgwZjV0eVBGYk5MTmhFNHhQR01vYTly?=
 =?utf-8?B?RkMyODFUNDhSdGpQZVZFMENsRzBoYTd2bEVIOGMwS3NMbzZ0YmQ4ZFNqU28v?=
 =?utf-8?B?clREUld2WDNPWDIydFNOQjdZbnQ4MlFuVm80THNIT1htd1lyY1htWXo3cW41?=
 =?utf-8?B?OGJVVkRtNUY3QWR1TWttS3hGRXIrOU5pcnROZlhJSkQ0NWJnZStYWk1kbUlK?=
 =?utf-8?B?cS9OMVNaYm1NQXByYmNqN0tUUmFwUXpmUlVMV21saExMNERoQ2J4U1QrMXkw?=
 =?utf-8?B?RVFZMUJJK09KRFRuNy9OMS9SdmF2TzByWjJZTDViZ3Z0S0Z5elNCUzA5RGdF?=
 =?utf-8?B?MHVkbHl0WmtTUHJidTF2THgwckRCcDhtUVRaNVhPbFcza211c1ovN2V1b29F?=
 =?utf-8?B?S0JqcS9sT2JjTHVQc0ExTUozMVhoWGJ5OG80VVJ5UGFZSUtvVksvTUlTUElH?=
 =?utf-8?B?VTFSY2VxblM3MlN2WWo3SkV6M2p5Y1VDWWdSd2lIZVlGSlF1Rk5McDJsdm56?=
 =?utf-8?B?a1N0SUIvaEFZNDdMSUM1T1lhQXNVWkM1NCszLzZzOXJlNk9wMGdaUnRLWStE?=
 =?utf-8?B?QTIyRWFrQ2hBdVdsc3lZdnNSK25kK0lpM1BCMnJpM1BLdk14WkNIOGxUK2Iv?=
 =?utf-8?B?eXFGWDlnK3QwK2RSMFVLc2dTcXU1dFExazA1VThPczQ1c2VHb0UvVEhDOUFP?=
 =?utf-8?B?eGtySFhyUU1CYzNtOHVkNlZXaWs3V1I4TUk5Q21hRmluMStUVFdwUjlQZ1p5?=
 =?utf-8?B?V2YxT0taWGlrT2ZyQkNQQkY1SEFrcnRsQ0dOOFpOdEVqRFNpbUdRbXFERFFo?=
 =?utf-8?B?RHFLOFJWK2x1S2N2UE9BRXZvdm5HZ05BaEp2V05CYVd5a1lWU2JZekorUHcy?=
 =?utf-8?B?TitFaVdBRWxOUUQ1VzBhbVFFdE41YUQvOU1tSUxrV1g3U0RLSFBrR0VuaHFD?=
 =?utf-8?B?OGZNblN1WGJOUVdPci85WXZqd2M0Z1R2N2I3a0NSVURLb1hySmsyMmxIMitq?=
 =?utf-8?B?OFhQWHpqUk8zRi9GVkdpZkd4dzMwZkJUOFA0b1BUWURsRzZ2dVhEYkx1R0w0?=
 =?utf-8?B?VDNUZzM1RmpBWWlOaGFxTHNmNnB5RmEyWHZlTWk3SjdHNThNRFF3akxpRlBE?=
 =?utf-8?B?aTdQRmtycTVoU3VYYWl3bG5tRjdGMTRkMFRFVmhWY1d5aXhkMlVkV2ZRTVdQ?=
 =?utf-8?B?TitkRjMxTUtmYmNnWHViMzgyZ09nN1pGYVZYZ1Z4VlVYdlpHUkRLdzk5TUhi?=
 =?utf-8?B?Wi9pWUdaT1BLaHBtZXVYZVY3VGJrSFVkQ3prVURoMGFjdDc4ZUpnWmo5T2w5?=
 =?utf-8?B?NFRKdHdrNGZwZlc1azI1YVBmTHp5WGpUNG1XR0V3ZXdiVnVqMnYzbWFUQUF6?=
 =?utf-8?B?ak1WOEQ5MVZQY0tLTnpGM2R6OFhIZVcvRDQ1MXFvbHRCV1ZPT0FBVm1XcDlZ?=
 =?utf-8?B?UmRBcVhydW9WWnVDSWo3Kzd3bFdCMTl3WjIzaU1SMGYrTXlkcWFiRWZqNmZw?=
 =?utf-8?B?NkU2czYyemZDNjZVWmFXTm1sYlZaYXUyNHIwNmRFdkk5T2lHQXRsdS9GaVg5?=
 =?utf-8?B?bElZUGNWZ1RSRW1CcjVkRFM5THhiQS9reGFYZlpkckppQVlkSFBQYnd1YWdV?=
 =?utf-8?B?aVZIQ0tTNXBMZTU3RnZZSDhZSElxSVZibnlYRTZJYzQxMEpOUGRFdHZ6Q0FS?=
 =?utf-8?B?YXAxUmRhQWlZOGJndE93WTU5SGN6YktwZFpFYWNOSEZVcVE5Z0gvSmtRb21J?=
 =?utf-8?B?c1Z1UFNkYzZzT0pDN3ZNbm5LRHhSMkI2b1pkS0U3alkvYU5pZjI5WnVPcEF3?=
 =?utf-8?B?NUFWdmdpWDUvUk45Tlc1SzdzNVdrU2U4b1JiVFZ4VmlOWFZxeUpOZHlublAz?=
 =?utf-8?B?R1FWZkp5K3MyVTJkMXp3MWpxbTFWdGxKdGdlZDRieU8xZVRFeXpFV0dyQ3hz?=
 =?utf-8?B?cGIvOUIxUUQ5aVArZVQ3SVZzZSsxNEJIOVhOU25rY2JlV3lLYUtLVksyTGh6?=
 =?utf-8?B?MXVIU29ZL3YyWUxMVEhvWXdQRnV0WGRpUkF4K2ZaQWF6UlA3RFBaem1rSkZo?=
 =?utf-8?B?WlJraUwvTDZhRXFCVTFoOCtScnNJUVNXU1k5NWZtamZPUEJ1S3U0aHFXeGFT?=
 =?utf-8?Q?zb/nGtwP2Cy4NOiZqoZXZnQVw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7681c44-1daa-4c21-25a9-08dccc69a77d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 22:42:14.1913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bWe8reSf4vyNc7eMBdPHU9Fh/gloAIntXsYY9lg5fRn67+VY0t/Z1aOANDL5L3DU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325

Hi Bjorn,

I have incorporated Jakub's feedback on patch 11 (i.e. bnxt.c) in my new 
revision. Do you have additional comments or suggestions on V4 to 
include in the next spin?

Thanks,
-Wei

On 8/22/24 3:41 PM, Wei Huang wrote:
> Hi All,
> 
> TPH (TLP Processing Hints) is a PCIe feature that allows endpoint
> devices to provide optimization hints for requests that target memory
> space. These hints, in a format called steering tag (ST), are provided
> in the requester's TLP headers and allow the system hardware, including
> the Root Complex, to optimize the utilization of platform resources
> for the requests.
> 
> Upcoming AMD hardware implement a new Cache Injection feature that
> leverages TPH. Cache Injection allows PCIe endpoints to inject I/O
> Coherent DMA writes directly into an L2 within the CCX (core complex)
> closest to the CPU core that will consume it. This technology is aimed
> at applications requiring high performance and low latency, such as
> networking and storage applications.
> 
> This series introduces generic TPH support in Linux, allowing STs to be
> retrieved and used by PCIe endpoint drivers as needed. As a
> demonstration, it includes an example usage in the Broadcom BNXT driver.
> When running on Broadcom NICs with the appropriate firmware, it shows
> substantial memory bandwidth savings and better network bandwidth using
> real-world benchmarks. This solution is vendor-neutral and implemented
> based on industry standards (PCIe Spec and PCI FW Spec).
> 
> V3->V4:
>   * Rebase on top of the latest pci/next tree (tag: 6.11-rc1)
>   * Add new API functioins to query/enable/disable TPH support
>   * Make pcie_tph_set_st() completely independent from pcie_tph_get_cpu_st()
>   * Rewrite bnxt.c based on new APIs
>   * Remove documentation for now due to constantly changing API
>   * Remove pci=notph, but keep pci=nostmode with better flow (Bjorn)
>   * Lots of code rewrite in tph.c & pci-tph.h with cleaner interface (Bjorn)
>   * Add TPH save/restore support (Paul Luse and Lukas Wunner)
> 
> V2->V3:
>   * Rebase on top of pci/next tree (tag: pci-v6.11-changes)
>   * Redefine PCI TPH registers (pci_regs.h) without breaking uapi
>   * Fix commit subjects/messages for kernel options (Jonathan and Bjorn)
>   * Break API functions into three individual patches for easy review
>   * Rewrite lots of code in tph.c/tph.h based (Jonathan and Bjorn)
> 
> V1->V2:
>   * Rebase on top of pci.git/for-linus (6.10-rc1)
>   * Address mismatched data types reported by Sparse (Sparse check passed)
>   * Add pcie_tph_intr_vec_supported() for checking IRQ mode support
>   * Skip bnxt affinity notifier registration if
>     pcie_tph_intr_vec_supported()=false
>   * Minor fixes in bnxt driver (i.e. warning messages)
> 
> Manoj Panicker (1):
>    bnxt_en: Add TPH support in BNXT driver
> 
> Michael Chan (1):
>    bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings
> 
> Paul Luse (1):
>    PCI/TPH: Add save/restore support for TPH
> 
> Wei Huang (9):
>    PCI: Introduce PCIe TPH support framework
>    PCI: Add TPH related register definition
>    PCI/TPH: Add pcie_tph_modes() to query TPH modes
>    PCI/TPH: Add pcie_enable_tph() to enable TPH
>    PCI/TPH: Add pcie_disable_tph() to disable TPH
>    PCI/TPH: Add pcie_tph_enabled() to check TPH state
>    PCI/TPH: Add pcie_tph_set_st_entry() to set ST tag
>    PCI/TPH: Add pcie_tph_get_cpu_st() to get ST tag
>    PCI/TPH: Add pci=nostmode to force TPH No ST Mode
> 
>   .../admin-guide/kernel-parameters.txt         |   3 +
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  86 ++-
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   4 +
>   drivers/pci/pci.c                             |   4 +
>   drivers/pci/pci.h                             |  12 +
>   drivers/pci/pcie/Kconfig                      |  11 +
>   drivers/pci/pcie/Makefile                     |   1 +
>   drivers/pci/pcie/tph.c                        | 563 ++++++++++++++++++
>   drivers/pci/probe.c                           |   1 +
>   include/linux/pci-tph.h                       |  48 ++
>   include/linux/pci.h                           |   7 +
>   include/uapi/linux/pci_regs.h                 |  38 +-
>   12 files changed, 768 insertions(+), 10 deletions(-)
>   create mode 100644 drivers/pci/pcie/tph.c
>   create mode 100644 include/linux/pci-tph.h
> 

