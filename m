Return-Path: <linux-pci+bounces-7240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72768BFE51
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 15:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646CC1F23B7E
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 13:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E4A84DFC;
	Wed,  8 May 2024 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZIRB4M0I"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E2584E07;
	Wed,  8 May 2024 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174081; cv=fail; b=rM7NcPIjPheLA3Y47CyI9VJXj6rudA4KHdPRf4AUqAyEFmvjA+HlYMCSaESHxub2WTWIpkOPjjKiMaZ3gb8zIjs0fjTIca0KmF6u+ujieVpD94HopNGN4rb089T58mOdglAJMGrbnYto7IaVp0vo5GpyD6lqArBe6+QCMi3n+os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174081; c=relaxed/simple;
	bh=XS/qXPKa9ui9bBcyN3eFvBqit9O381Hwry11LhrjbRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TyVLPkghZQvZWXQYpRDj/ESB54pC/YtC7K+EOraYyCmpQtciwLUCz5H4DePZSybKbemmgjyHX0zIksVryMt/kUpASmlRRXEiR52V38X9R9TIjl60hZ6IsxmMeHR7Sau4t3gb2PXXHYNg6eMsk9yNVlzG1YZCH5TSTNSaQ02fxZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZIRB4M0I; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKMgPY4GSjdepcWS8A9VOGk+aHArN2EFXr4us/MlpMJjN1da2vTyfDMyRTWC72kqj7/xdJgLU+TG0W37ubp2htNQXqKmaXc58NHfc0P2mJXlOHKJ2nKMbFwFcrF9GZZ+SB8x+Vx8sz5Wia09vc/xx7+nSBgHi5EJP1qpdDPUqicUc4+Wfspw/1XKa+7qJC0a6/vMACSrxBeYVVhiv9OgLH2xTohp5K16SYfeRLhNT1yw6ObDi8eMH+auhMKSJ8/ZwZqn9zYf2fDr1VmvGAFXgpnZOlERmcUucUgTJCSppTrEXWr4FQGH3RKsEN8aukOmxkAK3RoKRjZPllwjbkR4/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAtfdDStPSAJJG82xFLLThdPCJYNMMoGue8WoGW75Tk=;
 b=GX1Qq2GpkzfDitsiiRDsl/kZ+ikdIj7Spk7zy/GK9lm+RU9jTwFSMBp1Efomg9ivmrhUj5UY1MQ4RsTLNc3BNmnT2ukgZVC5Wt83MV2PKOgNoMPZGBfKDQ4fCilufexfFAw+xf0Hb5zgWUT/wYPzseETFDiFEvmRIqE0QWgd6Cyf1hfe23rRc1w6V0sgZn/sXCCpnJddniOL5whum29S9DEdGF2KNgEvBnDNpHxKQmwyX6Ei76wpM4l1XEmyoyBhBPTiEfarV0D+FMx2pA0E65E2h3RwWaWifns7shxEcVVbc0PbqjUYvNnACZK0MyswhbLUPdFZ/RYb+UtfQPpXlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAtfdDStPSAJJG82xFLLThdPCJYNMMoGue8WoGW75Tk=;
 b=ZIRB4M0IGfp9UesDNivqB7rccGckgs7Id/6Nh0OWjIUggWTAhGNuTaZOr3ZIGoQadvbUkGac/HPHN7niaBKn6skYQCTNFKH7Ewm7vhdHUVdqzLRlX2Qq52iqXjNUlcR1OnO06ACRY3TurclvYsV+Qn3qspG8eN7UkTPK34T7VihOKaD52dpqf+2hYbmnjtnsC753Y90tNugqeRiXtOplASPEx7W48yXwHc4fhSBZaY2obMT+MBFyItyyeiYAOgyvLU/T7oReF7yrmKGSw8HyDAZvyZcQn5EByZS9MRd0TYig2dj61mNCRsdGxLTSv/N4rOwzb3XkwtUg8VF3YImxRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 13:14:29 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%3]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 13:14:28 +0000
Date: Wed, 8 May 2024 10:14:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, galshalom@nvidia.com,
	leonro@nvidia.com, treding@nvidia.com, jonathanh@nvidia.com,
	mmoshrefjava@nvidia.com, shahafs@nvidia.com, vsethi@nvidia.com,
	sdonthineni@nvidia.com, jan@nvidia.com, tdave@nvidia.com,
	linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kthota@nvidia.com,
	mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: Extend ACS configurability
Message-ID: <20240508131427.GH4650@nvidia.com>
References: <20240508112658.3555882-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508112658.3555882-1-vidyas@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::22) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS0PR12MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: 45d034c0-3e19-4e4f-3de6-08dc6f60ca84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkU1VFhvdm9PSGFRb3g3dXNZYkx2TkdZUWtJKzJPVTNFeGlqTHJ4MS9HL0RD?=
 =?utf-8?B?N3M4NlZPcHI2bDRmcHZsc0FzeGowbGdjeTNsNUZWK1VGYUZEeC81Nnp3eStz?=
 =?utf-8?B?cHBqQTVLbXRTZ2VoQWJialVZanYrVU95ZlFrRCtwR2VrMkhvakpVU0tYb0t5?=
 =?utf-8?B?d2tIY2g5Vkl1Yy9JUlIrMzhzaFJCcEltU2hXM1U3clF1L1E0bkRCNCt3NGtW?=
 =?utf-8?B?Y05xeGlUTjNrT3hxU1VNU0ZyYkFRbHYzK0JCNkFIR1k1R21qajhDQWNIOFc3?=
 =?utf-8?B?NmNIQlJFamZEbzY1ZHpKSkw2NGZvQUpWb2F0c21YdnBJT1htZWJ1eGdqUXp6?=
 =?utf-8?B?ZTAvU1dmM2dISlpPOG5VRDluRkc3OE5JcXN6cGw3UFpvZ2pKRmVTMEVzWEpq?=
 =?utf-8?B?TGh3YktodlV5MkJ5bGJxYy8xR3BCNE9hT2czUVRYYzREcVBhM2gvUjM5MEVl?=
 =?utf-8?B?NEdwK0Rqdjg2d1hWbG1xVXNnU2x3djROTW10UFZQbVFhU09td0d6NTBYQkN3?=
 =?utf-8?B?RDV3b2hYV2Ywd29PL2ZhSGpDc1pPUmtrUi80TjVSVUk1TE9OUGRoTHFtbFRu?=
 =?utf-8?B?a3dseUZyWUIrbC9tNUZ1UkFpcnFmTWhBc2lYMVJWSklWTTlMb2NteklMdExC?=
 =?utf-8?B?V1ZsSE5iVnd2Y3M5Yzd5RnBuQ1ZnVStFSG9VR0E0QkJWRzUzVjExU1hqaFFU?=
 =?utf-8?B?WVpRYkRBT1c5cU41UHZxcFRTWDhQYkd6NTcyUCs1Y1gzUnFOaDUxaWJ1YThG?=
 =?utf-8?B?aUdtVFB0SHNuZzFuU3prYUhkOHhjK3ZYNEdsK2s4cTNDMmRqQzd2OXFPWXFX?=
 =?utf-8?B?OHZKMm95MWVpejQxa3lxWktNSnFBbDN4eElYWFdnQkVyRmNtelVFbGtUYjRC?=
 =?utf-8?B?SERmQSs2c28rc3hERFk2OUVCSnRwVlVlOWZ1bmRYaTExV2xRQUZxZEZyVjZx?=
 =?utf-8?B?QWNzQWhvWDRNWlNiSzZnaFY3SXNmODh5cFNpdDVXOVRwcWRPYksyWnN3MHVO?=
 =?utf-8?B?cm40Yis5eno3NDBxNGpza0pwRVhHNHNxdk5SNGQ0OFJPUlNOdjdvZW9MVWNn?=
 =?utf-8?B?ZmM3VDh4WWRGZEp4R2lnRXU4bW4va0t3Rkk5S0Q3Rk1hdE1xUE9MUS9TY3Vu?=
 =?utf-8?B?T0FadExmUlNqVGJyakkwSUN6dTB4RTIzTWxtVTBWdjFrMVprazNYdFNiaUpt?=
 =?utf-8?B?NytkbEpnVjFLQzNPT1hZQkpYSnhjZlQ3ZGNteUpZMlkrYUdsd051VnJZNzVF?=
 =?utf-8?B?ZU9vVHV4U3c5RnZtYWF6TWlTZ0dCVUFwSlIvc2xLRGVPSkNVd1JyK2s0eVc0?=
 =?utf-8?B?azYrNGdiVkprUDE2bmJPQXZ1VHNLMUIwVEhOK1FneGwvQThKMlRXOUtlYVpM?=
 =?utf-8?B?cjMxLzZDZXpnSGc3MVQ1NmtRWEhmOWhYR09mTCsrOE5aQ3VmTW5XZXBKVzdw?=
 =?utf-8?B?U0xSZFh1NVBhZHNnSDIxNUwzZ0l0VTVmUG5FYlZTTjcva29MNHdpKzd6c0Fw?=
 =?utf-8?B?U3BKM1hYQ1diRldWUnZpc0dSZ082QzNEVWpMalQ0WGpSaFVxT1JjQTlTMnVK?=
 =?utf-8?B?U1JQSS8vSGZhU011WmdTcStQTDFhTndPYTRzem0rcDJvQ05xRk5kNjJXaEwy?=
 =?utf-8?B?VUVVYXZqTGIydmFzRnp2Rml1YVVaWlJDQ3g3cXhLZWdacmJueFBETmNOditX?=
 =?utf-8?B?aFIrVFNjOVI3eW5TZ25JTzZVZmdPM0R6RmtQNzlQelU5K0Z1ZXQrOHJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bm1tT3AxMVcyWlJUTUhXbG5ZWWVGSHhhZXA4K2NaT3dTeXdMM3VxVitSTlNx?=
 =?utf-8?B?M0pscTg1clY2R1JUL1RFazVCYXZtRHhkYktlTWp0R0pCc2J4NDlYNEVFM2lP?=
 =?utf-8?B?WXlOVzFCYmVtWWY2RUNvWmFFaEtGZ21WY1Vab3ppeG9HSkdDVm8yMFU4RlJW?=
 =?utf-8?B?dVMvS2MxVkFSOXYyZFRSMTMwSG0rTmJWT1A4QkxTcitYbE1ibjlOdklqb1Zi?=
 =?utf-8?B?eTQ5cUFzeVhCWXk3bzVRVjBsQmg2WWxWR2h2cStGRUJBTG9vczhXYThud3V3?=
 =?utf-8?B?eGhicVJXVkhZbmNkZkxBYmZOeU4rWmlJSTU3cWFTZ2ViQlpSMUZYVEd4cjRO?=
 =?utf-8?B?Q3lURThWTVgwcFhRdE1kalp1bUZrZi9FTFY0bjI3bXo4S3FrSi9KU0tIa2xj?=
 =?utf-8?B?NG1VSnRCVyt2Y2JoUFJFQWFRKzQzWDdaNVp5QnkvRU1vbld6dlo1UEdQT0Ni?=
 =?utf-8?B?TVBJOHRNYVJ4NEQ2VnBaUWhqcG5nSFIxTUZKb1FBUzRpRGJuVHNSb09yK3RQ?=
 =?utf-8?B?NEwvQVlYSmNxYkkvcnhGUDZHY1pEN3pkTUZuWm1VUGk1SmdMOG0zN0VWNnBK?=
 =?utf-8?B?cHRUUXRpcldHL1J5ZHdQWWRhN1BGbndBblcwZGpQRXFZNERubVpseXRVVUN4?=
 =?utf-8?B?NUtNUUVMU1Y4RElaVHl3RjRIaTh1a21sMkxsS3Q5UXRZclU3Mnl2L1RWRUVw?=
 =?utf-8?B?TTU0YTRSSUdTRE4zQjBKN1p6dFJIRGY0WS9JU3d3NzBWUkpEUkRhdVdSQW9D?=
 =?utf-8?B?TExoMGk2TDR1RFdBOTQvbEE1ZUdFSER0OXVacWVQZnRZODFSdWNxdGQ1WUxN?=
 =?utf-8?B?QXcwQ2NjZUJIbW1hVDExQ0N1cjdLTkdkZE1jY3ZlRXM4TlVzMUhDOGxvYmo3?=
 =?utf-8?B?YXEyK1lodnAwVHpmNjhnMWljdlN6elY1UUV4NDA1V01TZ1FNbmxQeTVNbU9F?=
 =?utf-8?B?VkFvdzZNVFRGblB2NEdQOU91VmNYeUNzcjFMbHFIRU1yS0xTL2RBRHU4a2dX?=
 =?utf-8?B?WWYrTEhIVE1IcGNCeGUvdWtKY2RYaWJIY1laRVMwYTU0KzEyMWR5VFAvdXJr?=
 =?utf-8?B?OEJueDhYa3ZUeHI3TXVYcms2SVBiZktneVRMR1NYRlJpM3V5YVZCZmRqZUtG?=
 =?utf-8?B?cHM0b2V1STRmK2xFNm9VZFFaNkN2RmVQeWxRV21pdFBQYkZ0WkJ4MFVIMVVk?=
 =?utf-8?B?RFpiNEdPSlNWOE1Lckx5VmxwTWdOeSsvUk9RM211am9IZ0IxNHN5eGtxTVFT?=
 =?utf-8?B?YmZLbzBHM3V3b1VkczFuUGo5SVdrcXkzQXJDd3pRZWh2YjVzWFFZaDN0dy9Y?=
 =?utf-8?B?VUZib1J6THFFZkpUcWhVZnZHa1FMbGFITEpBYlZaUHlCVGwvdkxrcUtqRHR1?=
 =?utf-8?B?UDN6WFNVNTEwMGVoY2FlZkhpdTZCbnNiYkx0NHpkNitNS2tzbVI5c2JEeFJO?=
 =?utf-8?B?RVorQWNRL2FqNTJWWWlCZ0loZTZSMitMd2hhZ2RzVncydUt5WXlEQ2lhcmJk?=
 =?utf-8?B?T3FQZlFMSy9HTkdSeUpQRXMyeGhYUlBpVERMa05nRTZsdHJEMzNNWGF1b3Ry?=
 =?utf-8?B?UnY2TWhSZWdXclU4YjA1dG9FZmRHamlVSUZacHJxVzhDSmYvc1FUeG1vR3p3?=
 =?utf-8?B?dWdvRXpYVzRIMXdOeTYzekRRSHdmblJpRkE2NTE2NjRLSXV0SEVZclpaMW1z?=
 =?utf-8?B?blBpRGJTSmlPUERRUUJMZUpxdHp6VlVuT3YwaE5hNTNXTW1lZXFxUFFybFlY?=
 =?utf-8?B?dzZuemtHa1JKQlpmUElDS0E3VGFkMFg3dWNSYko4a0dWL01kbkRESUJBVWJz?=
 =?utf-8?B?NFg3di81VEJmZm96bUw5empVaTRKY3BlZG92aWpEdHNkUlcxRllRV1NxVVd5?=
 =?utf-8?B?UGZIb1hrYTMzeVk0QjVJMWROSTdoWHM2S2UxRU9OZHBHUlFoT21URVFIcVBS?=
 =?utf-8?B?cXpjamdvaitlSTZNaERITys5S0JNU3FnSnlmSUZFYitOTXVuMXg1Nm91Qnda?=
 =?utf-8?B?YWlIWngzbnpMOXAwNElmdDJpZVYxUU83RVRVdnlpY05FVkNxVGlrRFBJdzI5?=
 =?utf-8?B?L2dVMzlySFNrWnBoYXUzSlNBeitEZ0NuSXBMNEtWOG45Y3NlRzUraUFzR3Za?=
 =?utf-8?Q?6vbhxkOSVWk+J6yUEEYJ1U9gc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d034c0-3e19-4e4f-3de6-08dc6f60ca84
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 13:14:28.7324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5kpMdWgWHx2Courky8IHottzx/yiczNZjuI1G4BIRBRt1PY+Mw4xVV55tUHJkt0v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8787

On Wed, May 08, 2024 at 04:56:58PM +0530, Vidya Sagar wrote:

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 41644336e..b4a8207eb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4456,6 +4456,28 @@
>  				bridges without forcing it upstream. Note:
>  				this removes isolation between devices and
>  				may put more devices in an IOMMU group.
> +		config_acs=
> +				Format:
> +				=<ACS flags>@<pci_dev>[; ...]
> +				Specify one or more PCI devices (in the format
> +				specified above) optionally prepended with flags
> +				and separated by semicolons. The respective
> +				capabilities will be enabled, disabled or unchanged
> +				based on what is specified in flags.
> +				ACS Flags is defined as follows
> +				bit-0 : ACS Source Validation
> +				bit-1 : ACS Translation Blocking
> +				bit-2 : ACS P2P Request Redirect
> +				bit-3 : ACS P2P Completion Redirect
> +				bit-4 : ACS Upstream Forwarding
> +				bit-5 : ACS P2P Egress Control
> +				bit-6 : ACS Direct Translated P2P
> +				Each bit can be marked as
> +				‘0‘ – force disabled
> +				‘1’ – force enabled
> +				‘x’ – unchanged.

It looks like 'x' doesn't fully work? Or at least it doesn't do what
I'd expect - preserve the FW setting of the bit.

> @@ -1005,6 +1076,7 @@ static void pci_enable_acs(struct pci_dev *dev)
>  	 * preferences.
>  	 */
>  	pci_disable_acs_redir(dev);
> +	pci_config_acs(dev);

Because this sequence starts with:

	pci_std_enable_acs(dev);

disable_acs_redir:
	pci_disable_acs_redir(dev);
	pci_config_acs(dev);

And pci_std_enable_acs() has already mangled the ACS flags:

	ctrl |= (cap & PCI_ACS_SV);
	ctrl |= (cap & PCI_ACS_RR);
	ctrl |= (cap & PCI_ACS_CR);
	ctrl |= (cap & PCI_ACS_UF);
	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
		ctrl |= (cap & PCI_ACS_TB);
	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);

So any FW setting on those bits is toast at this point.

It would be nicer if this code was structured a bit more robustly so
that it only wrote the ACS bits once after evaluating all the three
sources of configuration.

But I like the idea, I think this is a nice improvement.

Something sort of like this perhaps:

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 94313641bc63fa..64b852ec3d613c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -948,12 +948,20 @@ void pci_request_acs(void)
 static const char *disable_acs_redir_param;
 static const char *config_acs_param;
 
-static void __pci_config_acs(struct pci_dev *dev, const char *p,
-			     u16 mask, u16 flags)
+struct pci_acs {
+	u16 cap;
+	u16 ctrl;
+	u16 fw_ctrl;
+};
+
+static void __pci_config_acs(struct pci_dev *dev, struct pci_acs *caps,
+			     const char *p, u16 mask, u16 flags)
 {
 	char *delimit;
 	int ret = 0;
-	u16 ctrl, pos;
+
+	if (!p)
+		return;
 
 	while (*p) {
 		if (!mask) {
@@ -1018,98 +1026,37 @@ static void __pci_config_acs(struct pci_dev *dev, const char *p,
 	if (!pci_dev_specific_disable_acs_redir(dev))
 		return;
 
-	pos = dev->acs_cap;
-	if (!pos) {
-		pci_warn(dev, "cannot configure ACS for this hardware as it does not have ACS capabilities\n");
-		return;
-	}
-
 	pci_dbg(dev, "ACS mask  = 0x%X\n", mask);
 	pci_dbg(dev, "ACS flags = 0x%X\n", flags);
 
-	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
-	ctrl &= ~mask;
-	ctrl |= flags;
-	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
+	/* If mask is 0 then we copy the bit from the firmware setting. */
+	caps->ctrl = (caps->ctrl & ~mask) | (caps->fw_ctrl & mask);
+	/* FIXME: flags doesn't check for supported? */
+	caps->ctrl |= flags;
 
-	pci_info(dev, "Configured ACS\n");
+	pci_info(dev, "Configured ACS to 0x%x\n", caps->ctrl);
 }
-
-/**
- * pci_disable_acs_redir - disable ACS redirect capabilities
- * @dev: the PCI device
- *
- * For only devices specified in the disable_acs_redir parameter.
- */
-static void pci_disable_acs_redir(struct pci_dev *dev)
-{
-	const char *p;
-	u16 mask = 0, flags = 0;
-
-	if (!disable_acs_redir_param)
-		return;
-
-	p = disable_acs_redir_param;
-
-	mask = PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC;
-	flags = ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC);
-
-	__pci_config_acs(dev, p, mask, flags);
-}
-
-/**
- * pci_config_acs - configure ACS capabilities
- * @dev: the PCI device
- *
- * For only devices specified in the config_acs parameter.
- */
-static void pci_config_acs(struct pci_dev *dev)
-{
-	const char *p;
-	u16 mask = 0, flags = 0;
-
-	if (!config_acs_param)
-		return;
-
-	p = config_acs_param;
-
-	__pci_config_acs(dev, p, mask, flags);
-}
-
 /**
  * pci_std_enable_acs - enable ACS on devices using standard ACS capabilities
  * @dev: the PCI device
  */
-static void pci_std_enable_acs(struct pci_dev *dev)
+static void pci_std_enable_acs(struct pci_dev *dev, struct pci_acs *caps)
 {
-	int pos;
-	u16 cap;
-	u16 ctrl;
-
-	pos = dev->acs_cap;
-	if (!pos)
-		return;
-
-	pci_read_config_word(dev, pos + PCI_ACS_CAP, &cap);
-	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &ctrl);
-
 	/* Source Validation */
-	ctrl |= (cap & PCI_ACS_SV);
+	caps->ctrl |= (caps->cap & PCI_ACS_SV);
 
 	/* P2P Request Redirect */
-	ctrl |= (cap & PCI_ACS_RR);
+	caps->ctrl |= (caps->cap & PCI_ACS_RR);
 
 	/* P2P Completion Redirect */
-	ctrl |= (cap & PCI_ACS_CR);
+	caps->ctrl |= (caps->cap & PCI_ACS_CR);
 
 	/* Upstream Forwarding */
-	ctrl |= (cap & PCI_ACS_UF);
+	caps->ctrl |= (caps->cap & PCI_ACS_UF);
 
 	/* Enable Translation Blocking for external devices and noats */
 	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
-		ctrl |= (cap & PCI_ACS_TB);
-
-	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
+		caps->ctrl |= (caps->cap & PCI_ACS_TB);
 }
 
 /**
@@ -1118,24 +1065,33 @@ static void pci_std_enable_acs(struct pci_dev *dev)
  */
 static void pci_enable_acs(struct pci_dev *dev)
 {
-	if (!pci_acs_enable)
-		goto disable_acs_redir;
+	struct pci_acs caps;
+	int pos;
 
-	if (!pci_dev_specific_enable_acs(dev))
-		goto disable_acs_redir;
+	pos = dev->acs_cap;
+	if (!pos)
+		return;
 
-	pci_std_enable_acs(dev);
+	pci_read_config_word(dev, pos + PCI_ACS_CAP, &caps.cap);
+	pci_read_config_word(dev, pos + PCI_ACS_CTRL, &caps.ctrl);
+	caps.fw_ctrl = caps.ctrl;
+
+	/* If an iommu is present we start with kernel default caps */
+	if (pci_acs_enable) {
+		if (pci_dev_specific_enable_acs(dev))
+			pci_std_enable_acs(dev, &caps);
+	}
 
-disable_acs_redir:
 	/*
-	 * Note: pci_disable_acs_redir() must be called even if ACS was not
-	 * enabled by the kernel because it may have been enabled by
-	 * platform firmware.  So if we are told to disable it, we should
-	 * always disable it after setting the kernel's default
-	 * preferences.
+	 * Always apply caps from the command line, even if there is no iommu.
+	 * Trust that the admin has a reason to change the ACS settings.
 	 */
-	pci_disable_acs_redir(dev);
-	pci_config_acs(dev);
+	__pci_config_acs(dev, &caps, disable_acs_redir_param,
+			 PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC,
+			 ~(PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC));
+	__pci_config_acs(dev, &caps, config_acs_param, 0, 0);
+
+	pci_write_config_word(dev, pos + PCI_ACS_CTRL, caps.ctrl);
 }
 
 /**

