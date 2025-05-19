Return-Path: <linux-pci+bounces-27951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3713ABBAFA
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 12:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A60C3AC54B
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 10:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1382749FB;
	Mon, 19 May 2025 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A+BoEfZ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2056.outbound.protection.outlook.com [40.107.96.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A012749E8
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 10:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650022; cv=fail; b=pPDAlGiVbfJmOLa+Rz2U9KQKlcN5f5kWhspyUa3X3nR6A3QfeRNQAJmCSP2WOolcFo+oGbUR3tGqqmVy1Gmvi6gi04b47ZqQMz6oNM3XS2f23uIYFq7En7FHZpjgI2+fb3r0faB4FpOVxhYb0Nmg2+UkWKu0iETXVwTr9fXbBsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650022; c=relaxed/simple;
	bh=0JsM8ko2Nav3nnXgZPQs0yA+Axn+m07VXrdyxzTAxJs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QGn9stCfnvRI7qjT3NaH7esFrv+d2tAlGNkgv0cODw3IgONRmyNMMVGnePir0BSN5aAAU+szI7/vB7h15QUw126vAfDZvv8O+LNxzK5JYuEvfM6xtVSBBRCtPRt953z700dZbis4UD7w01E8tHGp/QnIMdhB8nt0rTeoueEX08I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A+BoEfZ3; arc=fail smtp.client-ip=40.107.96.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEIBnget67gmQCr6sG31HC+E3nK9RFyEpqm1Wqd6DXEUrYqaSegbYJLp163GyU8OkpXatol0Dv8poY8OPYinzZRwRX5hFVe80ODCghuCCBH9togHgG46phBFv7ZgG7G24rrT76dWQ1tVfQ7USjJUKK2b6iuhupfyCfJegbVKl1P+Cj9HboPVYFmr3eSiS5wUNxN67q66AdeovR+oKIgnC7GFEOhJcJ+LE2w7uEB/Nn6V9sRjPPvQtUe0PVRiXA5sWYPA/yHZp66VDxRIReBRxRkfV5qi63tKcmL7MRR3Sz0zV4/whZNOcmSwNVRwddtyHllcX8Tdz35WBWKE4dL55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFvj0mEBF85Lzl/jM21DGREpirFo+ajUCHcYd0Fdg2A=;
 b=TIt52tR6GHfCIm+MnDEOzTVgu8WXAEclckb6ZFvigFfxfr27O+0+mNIath/numeN5a+FrIO9z3ZiMekBrnOp5DVVAwSxZPGsgDuIt31kz/NsikkU3EKopgx5dD5GgDjDk6S+AF+utagSQZD89x4mc4X4TD5ssNBL0beNyd9BFeWhXJZX4LZJPsGFQp7AwobtXFeetc0AY/qTxET2AAymwwQ3wLDoSk+LCpXhyyYasJ4YcyOM17CGClSyJuXqB7zVUdHhetg4j6I1aSpsyR66rEUyBE3oRwdW/RHDkLJn6eygYesaEODbNzwXG2BNtmxlAGSMRkKf2yvWpY95V/Qvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFvj0mEBF85Lzl/jM21DGREpirFo+ajUCHcYd0Fdg2A=;
 b=A+BoEfZ3ogom2dCBJz/fbe9wR9azP069MKVzqLIq36xd8+bNA+Z65xQ5jUa1xQmVumTuiB/bMgae3qcAaEJotQWKb5C9IT9GOL4EhWA/hqitGXAW/ZFnuYnrqU9nCpB2aNPZJOD1Up0UycawUN6FIDTjAEUexQmn7CgOIsz4Cxs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Mon, 19 May
 2025 10:20:15 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 10:20:14 +0000
Message-ID: <153d5223-169d-4379-bc2c-6ad279489560@amd.com>
Date: Mon, 19 May 2025 20:20:08 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for host
 TSM driver
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, aneesh.kumar@kernel.org,
 suzuki.poulose@arm.com, sameo@rivosinc.com, jgg@nvidia.com, zhiw@nvidia.com,
 Xu Yilun <yilun.xu@linux.intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250516054732.2055093-13-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0099.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:204::8) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CY5PR12MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: e90cec86-493b-483e-5c0f-08dd96bebed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUdKdXpTSHdjekg0djVLYXczeUhXTkZ5OGJOMk81Z3NBVC9QWEhCR1F6TFgx?=
 =?utf-8?B?ZmRxRGlGWWtkSUdTNkFkbW5XRS9rTUxqWDF0ZzIwN0hFUkp1OHVDOTFlcmRP?=
 =?utf-8?B?a2NGNjVwcWhqM2NZTWREZzhub3VRWlBSci9uOHFuWVZ2bTlFdUM5azIrRGdU?=
 =?utf-8?B?M3BQU0tZNGErNEo3VmM2aGJCNU9qam5iL1FrS2U2TnZHSEZiVVd6bG1ySGJO?=
 =?utf-8?B?dEZpaFVwV0RHYk5iZWVsTTNNd3YwMGloVllBYjBEVDBCRXM1SHNtNW1xdEV2?=
 =?utf-8?B?ODhiN25ON25pUmdHeGRlRjhxU0JMMzlPRnh5M0RwakdVdkNzdmI0SDU1TERn?=
 =?utf-8?B?VGh2WkdaQmJXbmdSYzFSNnRCbVdnK2pNQ0t3MDZKdk1POTF6Y0o0Q1k2RnBi?=
 =?utf-8?B?WkZyaWtwelpBV3VWMVJMcUpRVC9KbUNmUThMSEhDZmNRYUx1MnlpYXNMLzNm?=
 =?utf-8?B?ekkyR1ZJQWE2QTRINkJWd3ZubEZXRjhDYWN6Vm5UcGxMV0w0WU9RbXpSeVZY?=
 =?utf-8?B?RWp2Y2RRSHZvR3FSa1FTVlVLQUZ3Lyt6K2FBNjg1WVpVQ1RsK0ZPQ2lVaUxx?=
 =?utf-8?B?b3VicVE3dnR1YUdhVlJtTk13YmZmbXJCOTI0SjBTaGVVNlArQ3Z0MXBXTXNl?=
 =?utf-8?B?ZzdrV1cwd09LMm5tcllWZzFWNHp4dlVhM0xDSGdhNHRhcW40NFUxbU5UZXVq?=
 =?utf-8?B?cGRpM3YvbXdCbzVWbUt6akpkT3pUQWRrNkk0ZFVtNFY5NmhxUDh4dmY2NVF3?=
 =?utf-8?B?UGNaeXRaVldVSG1ldzJVMzVVVithSU45QTNJYURhRVI0T2QwT1h3aGd3a0Ev?=
 =?utf-8?B?ZmEzcU96U2tlK0lXWVdxeWpKZnlVR2pOZTQ0b01USEtNOGtsS1VHdlFDREht?=
 =?utf-8?B?VFBoNHV3cDVBZEhteTFuZ2czK0hDbjFxMVZPUUwrc2h1RWdnckZXZkdScy9U?=
 =?utf-8?B?ajhGcVNpeWVYSW1LeFNqSUhtQUJyU2o2Y0FkUzBrTVk0Um1kUmx4NUxYUC9P?=
 =?utf-8?B?OHpidnRLbVkzWkltY3Z0Z3Racy83cWxzSXFOcEdXS05rZUErRnNpWCttMnZi?=
 =?utf-8?B?UlRtbWVUM1MxN1pwVTlJSk9penRTQXhSMTFsOS8xNTZMQ3Q1bTJOYUljQity?=
 =?utf-8?B?amgxVnV0dHFESy82YjJ5K3V2RnZ4c0s2T0VjamRuK2l4SlcrbC8xRkE0NUlR?=
 =?utf-8?B?Z21zNjNmM2RDQlgycVc2cWtyOEdCblo4K0toSDYrWEVnYnJNcktKM1ErS0J0?=
 =?utf-8?B?b0NPVzh1Rm9PNkpDYTJLMVNML0V3NmNpbDhVTzlIcXN3czhIN0ZCQlJ4Z0lK?=
 =?utf-8?B?bDhCVTJzUjFtTFVFbWtyM2ZUQVVXYldyM0o2OTl3dnUzaTZRWVpEWTMyMnFz?=
 =?utf-8?B?YXBrdERCdTlIRGFaZEJvdEVRakZmME5qVnZQRVMxUXZpUkpXUTV0cXUrVDFF?=
 =?utf-8?B?MWVETjNnNEltM0E1Y201M3lyQUdDNG5lSXpFVUpodDU3QVdNRENnVklyMmFo?=
 =?utf-8?B?dzQyYnNZd3JacityekdtVGQwNCtWT2c1L0M0MEJucnNMbnlrMTlnYWxFdzZY?=
 =?utf-8?B?eW9IczBFR3JpTE53VHB0aEphUVJ5Vk9ja2pCcytyVDNsdVo4a2tUbGJwWVNO?=
 =?utf-8?B?ZGJBc3R5eHV6eEpDQUR0SjlQMk85WkNBT0MxMnV1QVV1ZlFWTkgrUUJNZjQv?=
 =?utf-8?B?ZkJtQ05XbmQrRXZyakhMUktKdzRLUnJyR1JGeFNDblJCTmp2YTlMU0xLMTJZ?=
 =?utf-8?B?ZUt1WWVGSEtDOXFtcFM0a003ajV3c3RVVzNOM00zQXVldE5BZ1pMWGNpcHo4?=
 =?utf-8?B?VXM3TkFFK0ZDZkNQNnF4ZTRNVE9neUFyeEVCQytxL0k0TCtCdHRVNmlkR0sx?=
 =?utf-8?B?NkpiTXRvL2VXS0RaNVN6TWN5ME5tclF1WWljR3lvSVJsUzU5dWpUSERNcTYw?=
 =?utf-8?Q?9m7JBzxw50E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFZablIrM1NtTlRiUWpaWCtVNDN6ZVhJUTAycGtpb0N1MFlSSlFwQUtMeWNa?=
 =?utf-8?B?Z1dMVllzcXorNmUrb2lUVStkd0pqODM4T2ZMcjd2TzhkT1piOVBqMmdXdWFy?=
 =?utf-8?B?ZDg1UXVWOURTUkJVK3F0MDJHeTRjeGJVam52bjVaa0VPeVhkbHZCQ3FOYURV?=
 =?utf-8?B?RmFXRkZpdG5WT1FkUlFnVUNLTVFJanVmb0tiZVIwN1VzTXJkdDRDUjBaSUZl?=
 =?utf-8?B?S3RaYTU1UzVNQUdFd2JLUlBQd2lGb1JPb2Fpd1lXV2RwNGJ2eFdkWmQrOFJZ?=
 =?utf-8?B?aHRJMnZmVVhEeDlHUmNhVkN4ZmNGeDdCSC9BcnBxdXgvYS9vMTdsWUtFR2dQ?=
 =?utf-8?B?Ym5jNmpSZ1JnV0xWWFM3ZEYzZlozUlI5dkRJc3JpUFU5Z3dtSnEzNEhWZlBs?=
 =?utf-8?B?VHhGRlNUQWRaV0haaFJtMnR2TGVsQ3pvUnlabmpmdUlRT3EyWGhYMzEzVk9F?=
 =?utf-8?B?YVRyNTFXakx1MzIzcXg1bzdUb2NJeVNTVVlDSjR2Tk9uWWNJZ2JyTmllZytN?=
 =?utf-8?B?M0MzNzgwMUtFbUt6MFRGZW1UcVA3WnVsdFRGL3BQVVV2dHRZZXZxQjY3ZkRP?=
 =?utf-8?B?OVEzMGFzQWtET2grOW00NGdmVDJ0ejZDQ1BJbUpjUlJOZ3VTTjhKTFhFa1ZR?=
 =?utf-8?B?RTliRllkcjVINVJaMklsejgvNTFEdG1ya2d1YlM5N2tZTnJLSTRsK1dSajM5?=
 =?utf-8?B?bEJSUXQ2WmhONDV3R2k3d09VbUkxaWxBcUZrWllYNElKUFhCRWJxOWE4ZFV4?=
 =?utf-8?B?YzhFYksvZ0lPc1RTL1dMZkM5eEthanVKc3hWbk5MdzdJY09yWlBBNzd5bkRO?=
 =?utf-8?B?NXk2YUMvWHdZUFVlL05aT3VTMDZoVlg4OUhVemRlWi9uQTg2Y0VkUzhPNmJM?=
 =?utf-8?B?Vk84YzdFVjRwcDN4Wko4eWtVeGt1RjFQdU1aNmZERHpUdzZOWEUxbzNxQ29G?=
 =?utf-8?B?Ui81YUdGUUtSbGZobXhvamF1alYvSUxvZEV2dE8zSHVSSjdoaTVHeTY1VENv?=
 =?utf-8?B?SXdwQTBETkhrSDk0SXZGaC9XWS84UFZjbDRQbVNudWNPdEVSMkhWNnlEZzE3?=
 =?utf-8?B?NCs3RXlmRlNXVWVEOVk2VUFNTDQxZ3o3WTFsUnN6di9xWU4rbzdleEFDYStK?=
 =?utf-8?B?bEp6Mk5scFVnTCt1N043Ny8wd2w2cVhySkdZcWUycG5tMHo4M3ZnZWZjSnRp?=
 =?utf-8?B?WG16emM1WEMrV0ZlUFp0UlY3ejQ2K0xFRFBjUm1GUFQ0RUVVRTdZV0t0MXds?=
 =?utf-8?B?UGxyeUpNZUNkbjh1cldLUnhXV3d1VnRESVBpM1MxSWpLNXVzWVpGMlpTUVBt?=
 =?utf-8?B?TGUvSHc2NnFmbDVYZStRUithZFRnWnJHamNWVURML1diUE5iSlJyVXFIdEsy?=
 =?utf-8?B?czdQVDdDSFVqbkpvWitJZkNiZTFXbGN3VjlSU1I3RFJFa0FHUERBajEydER0?=
 =?utf-8?B?b21jQ2tCM0RpLzNHNFJFNmhCYldGT3BxWHVoa3NlV3ZxcnFtU0wxOUJhZ2hL?=
 =?utf-8?B?RTRhczV6OUZmNVArY3JEaE5CYy9uYWlDRXNkdFdxUkp6SnBoSHRqNVVBUEtK?=
 =?utf-8?B?TGtUYWEveklVOE0xdE9xK0ZOWlowMXhnU1NqeVFYSDhyNUluV3hNQlVDSmdn?=
 =?utf-8?B?bzlwMFBxbndSakxxTW84OGhuQkd5MUMvUTRWZXJON3VmYmZ5UitsL3ZlKzZ1?=
 =?utf-8?B?SWQ4empRVXU2OGk5QWkrV2xTZWZISTBqdXNpR0RGaWs4bDBOSjJPL3NiUHZV?=
 =?utf-8?B?N1d0NWVySmJROTJjZlNFUk1xN1ZuVVVueUlvQzAzRjQ5TU9NYjdrSzhSeVRn?=
 =?utf-8?B?TENRdUNBYmQzNGsvVEJIRXV4MWxVd1AyQy9sWkRGa3UrSjRLWUl6bXdmNEYw?=
 =?utf-8?B?VXRkWDd2ZnBXUG9BbWhZWC9OampjSmp0ZTJWaVhDaksxZy9vdWdja09kdGxH?=
 =?utf-8?B?eGhXV2dzSDB1UHdZeTJBd2tnTlAxN0EzeDZOR3VNYjZSMjJWKzVDdS9MVWNh?=
 =?utf-8?B?OTh3dDB5dU9WUEZnczBCb01lMWVWU1dCNUR3YTFJMHRmNFVEaHZIam5iYWxm?=
 =?utf-8?B?dnptS3k4Zy93MTBnZUN3d3FaZUVrZ3F2Q2pDT1FPckl1Q1A3bngyT2NYTzU1?=
 =?utf-8?Q?18S1EKx1tmEX6keQ34aUjnTPf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e90cec86-493b-483e-5c0f-08dd96bebed2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 10:20:14.7755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1ScZLJrbbGpGqb0QQh2kW6TCqa2Z0jGUNG9lrNxPcbF+Rv+vO8tg+iXVWm3fQ6FkM4d7QGXKJS2voLdapbVQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622



On 16/5/25 15:47, Dan Williams wrote:
> From: Xu Yilun <yilun.xu@linux.intel.com>
> 
> Add kAPIs pci_tsm_{bind,unbind,guest_req}() for PCI devices.
> 
> pci_tsm_bind/unbind() are supposed to be called by kernel components
> which manages the virtual device. The verb 'bind' means VMM does extra
> configurations to make the assigned device ready to be validated by
> CoCo VM as TDI (TEE Device Interface). Usually these configurations
> include assigning device ownership and MMIO ownership to CoCo VM, and
> move the TDI to CONFIG_LOCKED TDISP state by LOCK_INTERFACE_REQUEST
> TDISP message. The detailed operations are specific to platform TSM
> firmware so need to be supported by vendor TSM drivers.
> 
> pci_tsm_guest_req() supports a channel for CoCo VM to directly talk
> to TSM firmware about further TDI operations after TDI is bound, e.g.
> get device interface report, certifications & measurements. So this kAPI
> is supposed to be called from KVM vmexit handler.
> 
> A problem to solve here is the TDI operation lock. The TDI operations
> involve TDISP message communication with devices, which is transferred
> via PF0's DOE. When multiple VFs or MFDs are involved at the same time,
> these messages are not intended to interleave with each other. So
> serialize all TSM operations of one slot by holding the DSM device (PF0)
> pci_tsm.lock.
> 
> Add a struct pci_tdi to represent the TDI context, which is common to
> all PFs/VFs/MFDs so embedded it in struct pci_tsm. The appearing of the
> tsm::tdi means the device is in BOUND state and vice versa. So no extra
> enum pci_tsm_state value is added for bind. That also means the access
> to tsm::tdi must with the DEM device (PF0) TSM lock.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/pci/tsm.c       | 227 +++++++++++++++++++++++++++++++++++++++-
>   include/linux/pci-tsm.h |  64 +++++++++++
>   2 files changed, 290 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index d00a8e471340..219e40c5d4e7 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -50,10 +50,65 @@ static struct mutex *tsm_ops_lock(struct pci_tsm_pf0 *tsm)
>   }
>   DEFINE_FREE(tsm_ops_unlock, struct mutex *, if (_T) mutex_unlock(_T))
>   
> +static int __pci_tsm_unbind(struct pci_dev *pdev);
> +static void pci_tsm_unbind_all_vfs(struct pci_dev *pdev)
> +{
> +	struct pci_dev *virtfn;
> +
> +	for (int i = 0; i < pci_num_vf(pdev); i++) {
> +		virtfn = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
> +						     pci_iov_virtfn_bus(pdev, i),
> +						     pci_iov_virtfn_devfn(pdev, i));
> +		if (virtfn) {
> +			__pci_tsm_unbind(virtfn);
> +			pci_dev_put(virtfn);
> +		}
> +	}
> +}
> +
> +static void pci_tsm_unbind_all_mfds(struct pci_dev *pdev)
> +{
> +	struct pci_dev *phyfn;
> +
> +	for (int i = 0; i < 8; i++) {
> +		phyfn = pci_get_slot(pdev->bus, PCI_DEVFN(PCI_SLOT(pdev->devfn), i));
> +		if (phyfn) {
> +			__pci_tsm_unbind(phyfn);
> +			pci_dev_put(phyfn);
> +		}
> +	}
> +}
> +
> +static int unbind_downstream(struct pci_dev *pdev, void *uport_subordinate)
> +{
> +	if (pdev->bus->parent != uport_subordinate)
> +		return 0;
> +
> +	if (pdev->tsm && pdev->tsm->type == PCI_TSM_DOWNSTREAM)
> +		__pci_tsm_unbind(pdev);
> +
> +	return 0;
> +}
> +
> +static void pci_tsm_unbind_all_downstream(struct pci_dev *pdev)
> +{
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM)
> +		return;
> +
> +	if (!pdev->tsm)
> +		return;
> +
> +	pci_walk_bus(pdev->subordinate, unbind_downstream, pdev->subordinate);
> +}
> +
>   static int pci_tsm_disconnect(struct pci_dev *pdev)
>   {
>   	struct pci_tsm_pf0 *tsm = to_pci_tsm_pf0(pdev->tsm);
>   
> +	pci_tsm_unbind_all_downstream(pdev);
> +	pci_tsm_unbind_all_vfs(pdev);
> +	pci_tsm_unbind_all_mfds(pdev);
> +
>   	struct mutex *lock __free(tsm_ops_unlock) = tsm_ops_lock(tsm);
>   	if (!lock)
>   		return -EINTR;
> @@ -392,8 +447,12 @@ static void __pci_tsm_destroy(struct pci_dev *pdev)
>   
>   	lockdep_assert_held_write(&pci_tsm_rwsem);
>   
> -	if (is_pci_tsm_pf0(pdev))
> +	if (is_pci_tsm_pf0(pdev)) {
>   		pci_tsm_pf0_destroy(pdev);
> +	} else {
> +		__pci_tsm_unbind(pdev);
> +		pdev->tsm = NULL;
> +	}
>   	tsm_ops->remove(pci_tsm);
>   }
>   
> @@ -435,3 +494,169 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
>   		       resp, resp_sz);
>   }
>   EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
> +
> +/* lookup the 'DSM' pf0 for @pdev */
> +static struct pci_dev *tsm_pf0_get(struct pci_dev *pdev)
> +{
> +	struct pci_dev *uport_pf0;
> +
> +	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
> +	if (!pf0)
> +		return NULL;
> +
> +	/* Check that @pf0 was not initialized as PCI_TSM_DOWNSTREAM */
> +	if (pf0->tsm && pf0->tsm->type == PCI_TSM_PF0)
> +		return no_free_ptr(pf0);
> +
> +	/*
> +	 * For cases where a switch may be hosting TDISP services on
> +	 * behalf of downstream devices, check the first usptream port
> +	 * relative to this endpoint.
> +	 */
> +	if (!pdev->dev.parent || !pdev->dev.parent->parent)
> +		return NULL;
> +
> +	uport_pf0 = to_pci_dev(pdev->dev.parent->parent);
> +	if (!uport_pf0->tsm)
> +		return NULL;
> +	return pci_dev_get(uport_pf0);
> +}
> +
> +/* Only implement non-interruptible lock for now */
> +static struct mutex *tdi_ops_lock(struct pci_dev *pf0_dev)
> +{
> +	struct pci_tsm_pf0 *pf0_tsm;
> +
> +	lockdep_assert_held(&pci_tsm_rwsem);
> +
> +	if (!pf0_dev->tsm)
> +		return ERR_PTR(-EINVAL);
> +
> +	pf0_tsm = to_pci_tsm_pf0(pf0_dev->tsm);
> +	mutex_lock(&pf0_tsm->lock);
> +
> +	if (pf0_tsm->state < PCI_TSM_CONNECT) {
> +		mutex_unlock(&pf0_tsm->lock);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	return &pf0_tsm->lock;
> +}
> +DEFINE_FREE(tdi_ops_unlock, struct mutex *, if (!IS_ERR(_T)) mutex_unlock(_T))
> +
> +int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
> +{
> +	struct pci_tdi *tdi;
> +
> +	if (!kvm)
> +		return -EINVAL;

Does not belong here, if the caller failed to get the kvm pointer from an fd, then that caller should handle it.

> +
> +	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
> +	if (!lock)
> +		return -EINTR;
> +
> +	if (!pdev->tsm)
> +		return -EINVAL;
> +
> +	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
> +	if (!pf0_dev)
> +		return -EINVAL;
> +
> +	struct mutex *ops_lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
> +	if (IS_ERR(ops_lock))
> +		return PTR_ERR(ops_lock);
> +
> +	if (pdev->tsm->tdi) {
> +		if (pdev->tsm->tdi->kvm == kvm)
> +			return 0;
> +		else
> +			return -EBUSY;
> +	}
> +
> +	tdi = tsm_ops->bind(pdev, pf0_dev, kvm, tdi_id);
> +	if (!tdi)
> +		return -ENXIO;
> +
> +	pdev->tsm->tdi = tdi;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_bind);
> +
> +static int __pci_tsm_unbind(struct pci_dev *pdev)
> +{
> +	struct pci_tdi *tdi;
> +
> +	lockdep_assert_held(&pci_tsm_rwsem);
> +
> +	if (!pdev->tsm)
> +		return -EINVAL;

Nothing checks for these errors.

> +
> +	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
> +	if (!pf0_dev)
> +		return -EINVAL;
> +
> +	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
> +	if (IS_ERR(lock))
> +		return PTR_ERR(lock);
> +
> +	tdi = pdev->tsm->tdi;
> +	if (!tdi)
> +		return 0;
> +
> +	tsm_ops->unbind(tdi);
> +	pdev->tsm->tdi = NULL;
> +
> +	return 0;
> +}
> +
> +int pci_tsm_unbind(struct pci_dev *pdev)
> +{
> +	struct rw_semaphore *lock __free(tsm_read_unlock) = tsm_read_lock();
> +	if (!lock)
> +		return -EINTR;
> +
> +	return __pci_tsm_unbind(pdev);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_unbind);
> +
> +/**
> + * pci_tsm_guest_req - VFIO/IOMMUFD helper to handle guest requests
> + * @pdev: @pdev representing a bound tdi
> + * @info: envelope for the request
> + *
> + * Expected flow is guest low-level TSM driver initiates a guest request
> + * like "transition TDISP state to RUN", "fetch report" via a
> + * technology specific guest-host-interface and KVM exit reason. KVM
> + * posts to userspace (e.g. QEMU) that holds the host-to-guest RID
> + * mapping.
> + */
> +int pci_tsm_guest_req(struct pci_dev *pdev, struct pci_tsm_guest_req_info *info)
> +{
> +	struct pci_tdi *tdi;
> +	int rc;
> +
> +	lockdep_assert_held_read(&pci_tsm_rwsem);
> +
> +	if (!pdev->tsm)
> +		return -ENODEV;
> +
> +	struct pci_dev *pf0_dev __free(pci_dev_put) = tsm_pf0_get(pdev);
> +	if (!pf0_dev)
> +		return -EINVAL;
> +
> +	struct mutex *lock __free(tdi_ops_unlock) = tdi_ops_lock(pf0_dev);
> +	if (IS_ERR(lock))
> +		return -ENODEV;
> +
> +	tdi = pdev->tsm->tdi;
> +	if (!tdi)
> +		return -ENODEV;
> +
> +	rc = tsm_ops->guest_req(pdev, info);
> +	if (rc)
> +		return -EIO;

return rc.

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_guest_req);
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index 00fdae087069..2328037ae4d1 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -5,6 +5,7 @@
>   #include <linux/pci.h>
>   
>   struct pci_dev;
> +struct kvm;
>   
>   enum pci_tsm_state {
>   	PCI_TSM_ERR = -1,
> @@ -28,10 +29,23 @@ enum pci_tsm_type {
>   	PCI_TSM_DOWNSTREAM,
>   };
>   
> +/**
> + * struct pci_tdi - TDI context
> + * @pdev: host side representation of guest-side TDI
> + * @dsm: PF0 PCI device that can modify TDISP state for the TDI
> + * @kvm: TEE VM context of bound TDI
> + */
> +struct pci_tdi {
> +	struct pci_dev *pdev;
> +	struct pci_dev *dsm;
> +	struct kvm *kvm;
> +};
> +
>   /**
>    * struct pci_tsm - Core TSM context for a given PCIe endpoint
>    * @pdev: indicates the type of pci_tsm object
>    * @type: pci_tsm object type to disambiguate PCI_TSM_DOWNSTREAM and PCI_TSM_PF0
> + * @tdi: TDI context
>    *
>    * This structure is wrapped by a low level TSM driver and returned by
>    * tsm_ops.probe(), it is freed by tsm_ops.remove(). Depending on
> @@ -42,6 +56,7 @@ enum pci_tsm_type {
>   struct pci_tsm {
>   	struct pci_dev *pdev;
>   	enum pci_tsm_type type;
> +	struct pci_tdi *tdi;
>   };
>   
>   /**
> @@ -86,12 +101,40 @@ static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
>   	return PCI_FUNC(pdev->devfn) == 0;
>   }
>   
> +enum pci_tsm_guest_req_type {
> +	PCI_TSM_GUEST_REQ_TDXC,

Will Intel ever need more types here?

> +};
> +
> +/**
> + * struct pci_tsm_guest_req_info - parameter for pci_tsm_ops.guest_req()
> + * @type: identify the format of the following blobs
> + * @type_info: extra input/output info, e.g. firmware error code

Call it "fw_ret"?

> + * @type_info_len: the size of @type_info
> + * @req: request data buffer filled by guest
> + * @req_len: the size of @req filled by guest
> + * @resp: response data buffer filled by host
> + * @resp_len: for input, the size of @resp buffer filled by guest
> + *	      for output, the size of actual response data filled by host
> + */
> +struct pci_tsm_guest_req_info {
> +	enum pci_tsm_guest_req_type type;
> +	void *type_info;
> +	size_t type_info_len;
> +	void *req;
> +	size_t req_len;
> +	void *resp;
> +	size_t resp_len;
> +};
> +
>   /**
>    * struct pci_tsm_ops - Low-level TSM-exported interface to the PCI core
>    * @probe: probe/accept device for tsm operation, setup DSM context
>    * @remove: destroy DSM context
>    * @connect: establish / validate a secure connection (e.g. IDE) with the device
>    * @disconnect: teardown the secure connection
> + * @bind: establish a secure binding with the TVM
> + * @unbind: teardown the secure binding
> + * @guest_req: handle the vendor specific requests from TVM when bound
>    *
>    * @probe and @remove run in pci_tsm_rwsem held for write context. All
>    * other ops run under the @pdev->tsm->lock mutex and pci_tsm_rwsem held
> @@ -102,6 +145,11 @@ struct pci_tsm_ops {
>   	void (*remove)(struct pci_tsm *tsm);
>   	int (*connect)(struct pci_dev *pdev);
>   	void (*disconnect)(struct pci_dev *pdev);
> +	struct pci_tdi *(*bind)(struct pci_dev *pdev, struct pci_dev *pf0_dev,
> +				struct kvm *kvm, u64 tdi_id);

pf0_dev is not needed here, we should be able to calculate it from pdev.

tdi_id is 32bit.

Should return an error code. Thanks,

> +	void (*unbind)(struct pci_tdi *tdi);
> +	int (*guest_req)(struct pci_dev *pdev,
> +			 struct pci_tsm_guest_req_info *info);
>   };
>   
>   enum pci_doe_proto {
> @@ -118,6 +166,9 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
>   			 size_t resp_sz);
>   void pci_tsm_initialize(struct pci_dev *pdev, struct pci_tsm *tsm);
>   int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm);
> +int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id);
> +int pci_tsm_unbind(struct pci_dev *pdev);
> +int pci_tsm_guest_req(struct pci_dev *pdev, struct pci_tsm_guest_req_info *info);
>   #else
>   static inline int pci_tsm_core_register(const struct pci_tsm_ops *ops,
>   					const struct attribute_group *grp)
> @@ -134,5 +185,18 @@ static inline int pci_tsm_doe_transfer(struct pci_dev *pdev,
>   {
>   	return -ENOENT;
>   }
> +static inline int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm,
> +			       u64 tdi_id)
> +{
> +	return -ENOENT;
> +}
> +static inline int pci_tsm_unbind(struct pci_dev *pdev)
> +{
> +	return -ENOENT;
> +}
> +int pci_tsm_guest_req(struct pci_dev *pdev, struct pci_tsm_guest_req_info *info)
> +{
> +	return -ENOENT;
> +}
>   #endif
>   #endif /*__PCI_TSM_H */

-- 
Alexey


