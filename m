Return-Path: <linux-pci+bounces-14680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4483D9A10A8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 19:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A93C283028
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 17:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B5618660A;
	Wed, 16 Oct 2024 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="O7E5Nlm6"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095CDD520;
	Wed, 16 Oct 2024 17:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099905; cv=fail; b=H39wz37JwUhvXMsh8YSLwGcxKX3Dxn+npaSjp6UsjS44HYIhgwvtyrhY96vrBeM8dm838aBVXRf/3AvcdUvwgq2TukROA/ojDNh/wDz8FLdzD5E++ZgWOo2lljlVwnSUw2jFBqudnxcWJOqoti6z4egBXhrPRoZMvLNGaUHyRpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099905; c=relaxed/simple;
	bh=fOY4HHZqK/NAIaHOy2qXTMHjV5mMsiVdn43b2Ml9RA0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gruT4sxn0Bb0xfjftXO7QC8KOdMihHlUfrZAj9gnzkuUv9tpB62+3RCzbXdbcaQzUJ/wTBGP1QGZKIZ+whf/tGWJuEkIUgAuxf3hL47/UXsmZa6ExyKNTV73TZMgJfub5KoheIhL545YBQwXljQi8adYGIea61WvH7lDgrJ+ikw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=O7E5Nlm6; arc=fail smtp.client-ip=40.107.243.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3KAgAxcrITZNrdJLhoJveIzVA0SdH7x2Kd+FsSjtf9wq1cLvNbkTng+7aUtU9CqtFJCgccNg6kj8jiNX5ijNRiMRQJmMeebzitW9vWRfXLEE+gTMkrr3csRhxZD3fsOO6aMbMQttMI3o8e2fsaOogaSaGL4kp3vliSA7BTp7uu2abmV1c7IaQ8iO7Cr91bZ4kr0tVeZROsi27YmBLvK1dUtEpRlkXWeNGD6ClfUj0Xlg+z38SsOOSa3Vol9/KILOK+KhQPxVUpUdBHB5owcNjlyfYkibq3pj7SCO75uI9GFYuvMPeivLmxYKobjKdHaXK9OcYiympc56Rv2zs+q2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+HTgjQRkfAXc9/pEARtXSZ3y3nKIInZXVvE4rxqNC0=;
 b=pfP1cIlO9TgWhIcmsxObc+a49+x3+t0O1ocDmMouslS20d2nRP41vjOXsiE5gz+LVglSgSSY8vTtawxvlDMXsE5L4rbecx3hX3Xn416xYo8c2HjhlIH2hsBYUAz6IWq8EQ2avN8tajmFJJEjAWcv/2ULfghxpZJabB00reKUcNauCfWbglb/8YtU9MTBKsft3eqsr8J8o0A2K7y9jU/UG6dvVU+Bvj7iXUIvPFfcd5EX0i4sG180muRh69l6dBe2PUFfEGHQZZaiaSCHwhKITxNChugQC2i9akZ98MGZfxTxK0B2FQ4GaFx9620PFckF8D9SvqVGh7utG1S1Pu4eFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+HTgjQRkfAXc9/pEARtXSZ3y3nKIInZXVvE4rxqNC0=;
 b=O7E5Nlm6/QHDXfK8SH0WaCEcAUt1kzT6G5zE4qfA0ouY/MAsnf3s3I4c9efBvldWl3MJQzO1P6Hbvo7CrKH94ClFlkzqmpWYo/IhgRH5jWwDKCDHPE6XUygNa51848KL42vwQPF8GJ/QK0dK4qLAraQYAOYGvwB7k6+J3jPUe/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Wed, 16 Oct
 2024 17:31:37 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%6]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 17:31:37 +0000
Message-ID: <6555a001-4f5e-40c0-bf27-38dd7a15c3d9@amd.com>
Date: Wed, 16 Oct 2024 12:31:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] cxl/aer/pci: Introduce PCI_ERS_RESULT_PANIC to
 pci_ers_result type
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: ming4.li@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, smita.koralahallichannabasappa@amd.com
References: <20241008221657.1130181-1-terry.bowman@amd.com>
 <20241008221657.1130181-7-terry.bowman@amd.com>
 <20241016173011.000021e4@Huawei.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20241016173011.000021e4@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0117.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::23) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ffdb53-1406-450e-085b-08dcee08633d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d29zU2FlK3hyYTlXODFxS3R6SENmaWdaS0d5ejlPbFZ5NjEwaE9zYjV0Sjds?=
 =?utf-8?B?NkU4U0Y1R2VYa2FNc0JJZldzK0wzcmU5WVNCTjFDaW85bTZLNXdneHhnY2N1?=
 =?utf-8?B?KzNadHdPdVhkLzJvWXNEWm5zMCtqVENEZEc4b2FhTTU3enZWMXdRZkhkUTlr?=
 =?utf-8?B?eTBWcTZEb09HVmYxaUJzMUpNc0RWZ3hNVCt6VUNCcHBnQml5VHZVQWN1dUg1?=
 =?utf-8?B?RHlsQjV5RE00OVliR3N3SThrQ1Y1ZVk5MXNBeS9qZVVqNitNSnJzYVRPVXVB?=
 =?utf-8?B?eEZab0RVVDJTYUM5SXhOanhZNlJEQzRYUUIzTFdXbHdDdkVZekRwQUcyM0lO?=
 =?utf-8?B?UFEvczlISm9uazRlRklKN3hlWTNuQ0Q5TEliZmlxbUEzZU8zQ3ZsMXRaTWN6?=
 =?utf-8?B?SjZBYzNheWxqRDZQdnVzVHBmUlRSNjU0YVFCckRIK2wwUjZwVTlubEM0amZ2?=
 =?utf-8?B?cHRXd3d5ZUJYMm5xWTJFUjdaUHArUUtvblJOYlp2ZVQ5S05XbDFodklmWmJl?=
 =?utf-8?B?aGY2OTI4aUF0aGtHbUtCMVd5VVUzMkVrUFJEcHB0ajVmV05nQURORVoxOXZL?=
 =?utf-8?B?WWM2NnF1NHZBYmgvT3U3TXhXNEN1RUdQYjltM1Fid3hWYzNzZ2JqYnpicUZu?=
 =?utf-8?B?VFRvTnk1TzFqN2w3RjQ2VWZtWUJVMlJtNG5memk2MTdQYWxWTFRueFg3dk5U?=
 =?utf-8?B?OFFNb0dZTU93ZGNueHhsdWxiS0dCMHFOR0dBcWgvNFMyaWpXaUJ0cWIwUkNy?=
 =?utf-8?B?YmY4cGwzSkMwaU0rZDZWem9YVXdPWFFKZ0RMZGZQS1E0Wk8yaktXRDlCa0or?=
 =?utf-8?B?b3U2RDFRMWlwMVVhV2VSN2xsV291R3NxOU9HWkZ2RkdyMmNnalNkdE1jVXhT?=
 =?utf-8?B?R3ZtMzZnNkl5ZHA2TXpHSmxtRWNqZko0VXlkcWxXVXFWT3QyTG12S09mTGRC?=
 =?utf-8?B?ZVFBRHdRUjRnQzE1TlZhOFF1ODFtbmNHbUFVTVBLMkwxSElGa0I4ODhUYmxR?=
 =?utf-8?B?cGtwdGVWS0dES1lLWnMrTGdQcGVuOStjTktOVEFXSG91Q2JCQ1dCMGhYeDE3?=
 =?utf-8?B?MnpSeXYwUnRocG9wdCtzY3RYSjQ0ZzYvY0V0RkxRWFlMTktCWnpoTmRsSkxz?=
 =?utf-8?B?c0labmcvVktkazlxYjQzYlArSWhuc3hvOS9hRVZSUTBRRDhHNjYrZElYYmFp?=
 =?utf-8?B?SVYraGRyMm5ZZ3R1S1kwS0dwNG5RaEdBMVplV0owbFM5YmJERld5OWx1YzZ2?=
 =?utf-8?B?aUxCM2pyS3dhUmcvc0Z6dWFtOXlKV1pFaXlYaUlNU3dtbHQ4NE11NnN3Vk9q?=
 =?utf-8?B?UEhETzhpbVEwWE9Xc3oxY1ErSmpncm1iZzc0NFAwbVYzeU5lcDVQOC9UTTl0?=
 =?utf-8?B?SXhTVlNyb1NaYkpDUkljSDFnQitTNHg2MW9OdlpZb2FJZFkyVjR1RUdvQnQ3?=
 =?utf-8?B?ekFwaEVtZFJUZjQ2dWEybmZSdDc3SVFGbU5uOFlVMWxHNk03RGUzV002MElD?=
 =?utf-8?B?NVVFZnBWVHlhczFPMEVlbXVVYklKaHh5TnBPd2R2MldRUldWRkRLRkxnQXdh?=
 =?utf-8?B?blVReVNwaGRvcng1S3NQeFoxdVY4RXRESjIyZGhQUkVPSXJnL3R3NTNybnRB?=
 =?utf-8?B?VDFBYjlCVC9zZjU0VCtydFZUSEs2N010TjZqR29MWWdvbjl4MnBlc21xWW5S?=
 =?utf-8?B?TXNlS1A5Nm95THc2YVV2V1ZEa0l5ZDU1OU1peXVPMThzMHNDTHdjck5RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEZ0WDBVTG1VdmhZcEtrbWVxMzZDZStwTW5rbUprd3A1ai8yM2p4N2xtaEhz?=
 =?utf-8?B?ZXZZSEhKUTdyVVNackFxUGUvZkVIUVppek8wdmFFZkJ1YWdqdG9KVUVlTGhu?=
 =?utf-8?B?TzhvdXpYSHg3Y2NpbzZVS2lZYzd4VEpzOTRBb2dZZGFTSjJXcklnSmxUY1lW?=
 =?utf-8?B?TTVZVkFFMHI2VDJsZ1ZNTzlQZ1FtcDJGdnpUKzRHaVlkbkc3cnlkZk9yekd2?=
 =?utf-8?B?alQ2R0ZKNnBmRmk4emJTMG1Wcm9kZ05HT2k4K1VDeGVqcTVaOHdpMW9iL1cx?=
 =?utf-8?B?OVRlanpDUGdYMEpkOWdLVWRCRFlPaDk4eGhPSkxZcnlESUkwYzRxWFpiQTc5?=
 =?utf-8?B?STF2WmZkaW91T0dDajRqSkJtREtFbUdLVk83R29hckVwcTFwMWF2NlBjUVRw?=
 =?utf-8?B?SVlIVktqM3BNY2p5dk9DS0xRT2tYeEs5K3JmelNrcXowUTlpR29vSGF1MDlB?=
 =?utf-8?B?MEdVdWdTS0VrUm0rYTVzeExybUI1aGNvcGFjUHFwc0pqb3IyR0FONVFpWVVT?=
 =?utf-8?B?dWFKbDFVaFBJTnNaUGVMTzArUldDMEZ4OWJZUTN5V0xaeXc0OUVVZ0hIRkky?=
 =?utf-8?B?RU12ajZGVGtVUUQxdGxDV1dmTldPaDA1UTM2MjlMMWcycC8wdDl1TkVmZFp5?=
 =?utf-8?B?MmRzdmU1MVppd29BTWRRUzVTZ1JVNExkWUt5Nm1pR2dNTURwTmlzandjYy9Q?=
 =?utf-8?B?c3dyY3ZoVnFFeVBOWTVsTWVTbnRUTXlEWW5QM3dRbzB0TDViTnV1a0RjdjBi?=
 =?utf-8?B?OG84MjhRTHBnT3ZmemlyZFl6aTc4ZElUN29jblBsek9wT00ra0J6b3ZUTVZk?=
 =?utf-8?B?aXBRY0RGZk5FUmU2WWFMY0FjSlUvSjd3RzlTNkZZVE9rNXArTE1YcDhiZytE?=
 =?utf-8?B?UmpDRTlYck1DVURuMXdzMG9odW1nbjI4VWFYY2x1SmpUMGFzYmNlVDJGTXNp?=
 =?utf-8?B?elNoZFZ4TkpxUGN5K1VVOWVBdzJSSXJCSnpqMHF5dkJ5WEc4cWtERzA3UHAz?=
 =?utf-8?B?a1RCTVU0STVSa290eE1YNE9SVWNsSmdTN0ZrODQraWFpbk1wM1dKVm1nVE9V?=
 =?utf-8?B?a1RTNEJYcmdqNXYrTU5qWk41Q0EwVXJiZ29mcmpXcnN4eDIyWi9Fa2FRT21Q?=
 =?utf-8?B?Wm43MDl4b09QOWdFVDhXbWNRNE9uOUh4MUNreFZWVGo0bmZaaDhsbUF4cHhK?=
 =?utf-8?B?WHhMVjVuVFVLeG1FMHRGZEFNZ29IL3ZNVlBuc0dmazYzSnFoTENXemVOSTB6?=
 =?utf-8?B?SWJSdm1zNmZHSTZBbkZvNlRxRmtGNFFxUTNzTUlSRnQ3U2NqL0R0d1oyRE9v?=
 =?utf-8?B?VFhzZmVBdC80SkJuNzRtdk1QVE84My94RVl0NDhFSkVaaHVzaFl3Q3NtTmlr?=
 =?utf-8?B?VjNNUXFRL2QrTzNXK2orNXRmQ3Nkc1RuQnJxV3JvTDhoQXZ3aEpFeXRCQThO?=
 =?utf-8?B?aGVNa0s1Ui9ydnd5dkNtSWd6cktCcFc5ZVhtcS8yYzJMSVJsQlBHVUJnQWtY?=
 =?utf-8?B?WEhSREkxT2N4TXY2Y3EwRmg3VGRrMTU1UFpBUzRNOVBVTW5rczVOT0ZISTJh?=
 =?utf-8?B?NVVZV1VEcG8zL3NOODZXRFNsako0ZUFtRDZvNVJpSU5FdC9hQkRLYXZ2NXA1?=
 =?utf-8?B?d0Z2NUtUMnV5bk1scEpLQnJ2Wjc3ZHlFaTFDcmdZc3l1OS9Bd09Ed0d3SUZh?=
 =?utf-8?B?dzgwU2tWNEhPOEFGTG1JSGZwSzlJQlN0YVYzY1ViaGM1eWE4c2RPU3VBQ2Fr?=
 =?utf-8?B?MUo5MTNkWUV2Y0pLUUtqUWhNSmtLYVhsdERUSFRNTWdid3dLQUZnK0sydHpF?=
 =?utf-8?B?U0VIa0Zydys1TmhVWHhVd21FeFpreHUzU1dDZTFrSTlLS24yYXJLeEt0QzJ6?=
 =?utf-8?B?djBzQk5pcUJ5SVdoMGxzVE9zbGw1OVZuOXhEZGE4SHg4elBaZ2EvZm1KMGwr?=
 =?utf-8?B?enJ4Q2djY1RKUG9lWmJ6M29meVhCWDdxVjJxcFhORVFORksvYnBqVWIrQk1O?=
 =?utf-8?B?VzJaS3d3Mm5FdW5IeWxwZmgrNlNEd1cvOGVHbGhEb3hUenVLRHlFaFppUTBz?=
 =?utf-8?B?ZmxtbXhUcXNlNTRrNnY0NlpFZG1vYTIyTWNhemFsUi9MN3hDbGNXQytOUWhO?=
 =?utf-8?Q?mZnJbX/yMQl8TUPQNO58zH5TG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ffdb53-1406-450e-085b-08dcee08633d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:31:37.3507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEAtaKuLkPiMrbiCqxqMVVoud+OYfQjdOPox3qNtTVgfwJ4ArxdX4pICUPW1wMOI7K7/9Mar1ZPKxjZlFI3J+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813



On 10/16/24 11:30, Jonathan Cameron wrote:
> On Tue, 8 Oct 2024 17:16:48 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> The CXL AER service will be updated to support CXL PCIe port error
>> handling in the future. These devices will use a system panic during
>> recovery handling.
> 
> Recovery handling by panic? :) That's an interesting form of recovery..
> 

Yes, Dan requested all UCE (fatal and non-fatal) are handled by panic in order 
to limit the  blast radius of corruption in the  case of UCE. 

The recovery logic in cxl_do_recovery() (not using the panic) is also tested as well.

Regards,
Terry

>>
>> Add PCI_ERS_RESULT_PANIC enumeration to pci_ers_result type.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  include/linux/pci.h | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 4cf89a4b4cbc..6f7e7371161d 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -857,6 +857,9 @@ enum pci_ers_result {
>>  
>>  	/* No AER capabilities registered for the driver */
>>  	PCI_ERS_RESULT_NO_AER_DRIVER = (__force pci_ers_result_t) 6,
>> +
>> +	/* Device state requires system panic */
>> +	PCI_ERS_RESULT_PANIC = (__force pci_ers_result_t) 7,
>>  };
>>  
>>  /* PCI bus error event callbacks */
> 

