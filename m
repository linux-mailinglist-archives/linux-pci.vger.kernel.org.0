Return-Path: <linux-pci+bounces-42760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AA0CAD5D1
	for <lists+linux-pci@lfdr.de>; Mon, 08 Dec 2025 15:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFDC23020CD1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Dec 2025 14:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5431F31283D;
	Mon,  8 Dec 2025 14:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FOrvqosZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBA22C08D4;
	Mon,  8 Dec 2025 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765202770; cv=fail; b=Mg+hlr7tCDGfxTIK2sJc0m55z+YbVyRiwR205+JD/+BuWstDJRNyr9n593WtpMJ4533FgXH1sG+FjKQjhDIA9FIWRlsTG1s8Sz1r8woImDI4YZqHoZPuJmNDK/oFXZmNwIjVnVGA78fCIMdwrhTnJoXdIzky3Yf83chBYF/61aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765202770; c=relaxed/simple;
	bh=5wIujHsfVtUbEkv3fHQXvXhA9Nv3HPqPKmTKZxyDvOE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=poQ5T3gTANEcfT0IQy/13diY8TwiGDDbmsUU4YCwcBx2S/VYUak+qPE7/0RPtJaLyVwPMjgx+/SBzgN+/RQNsV19vi4H7M1y3Z1edZ8aJ1wN6gKjjNfyRlT+UYG9hbN19jHKLpDw1b61Fb32QV9xpeWM+8Kp7wUjhxg6jLiXmAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FOrvqosZ; arc=fail smtp.client-ip=40.93.196.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cy4QWKIXp83OnLpI5k7aiE6fsOMLg9KAqCWAL3zBlI7u0FyaqgYczlMb6qumTfdCHbOphZZasWqss/JPYPHf2I2q0S9EchNM5v5BT7TuOodTGQGooxywAe7mbQbolJ+Cz/wRNKjdzY1+MCvA9GayBnSY08b5Wo6eCCpWeCjlIrXyLEU+ZClTJd4As8bEtY1nZ1i9r536nraThXKaJWBBfHot6GThufJGf7hWFK+yIN/pL68ZDvQkb02ZIQSlwda7ZnXp5DTKOWn1Lr0nX+YuxQJwUGV+w0iuMZvRyVAAnXGQgwezg8KBSE9z1uv1I2hQANH+DoEJ6B/V7uEL/AmDHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTQZ2xRSpBcuuVZApaEdkbm27CmJGDO007AndhgVigc=;
 b=N5kDFdnOmX9WD8AjE4fhueClL1+UzYyKPQE09cDek7Y3POBMDeH+2CWQB5hFS9ekXbpPJQBDC3PVrUe7lg861iQd8U9aYVZx1r5qKxhYyqYkrEH7sm0XvmbQmO8rS2nEcS1S8/3q+HRgt512krW+vZQ1OxxjX8kO2oVLYjtzImvmU3nG6IdYPnbIOv8+vjyWSfivY1oe+K8cZGPaTWuwHs8gqKfepuLOh0+gRaSS8YYTYmePkPTYZgGyTc15FTmQEbPymYL7sHn7jyhrV6w3Gi8JrKaj/iV+w5qg5KGWbk5QcM3s5tS++9ZYtQOJm6oqZab43bgoHSvT9u9g3LwzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTQZ2xRSpBcuuVZApaEdkbm27CmJGDO007AndhgVigc=;
 b=FOrvqosZ+wLje/7I5A2UP++grBkPGqeHDoupB6m4p09S/C2LDR3nidpepmrMrHeHBTbz+j/jQn3FdmspZwsG0+WufY68SaOmDVyXNXFX1C7EhsewDU+OwGRbZNEh45B9NyrfxiumR798rQxojy+OC4TgNX1CDh+nL+59Ntqw49o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS7PR12MB6334.namprd12.prod.outlook.com (2603:10b6:8:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 14:04:52 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 14:04:51 +0000
Message-ID: <f45b11fc-270d-4047-8149-75081399b2ed@amd.com>
Date: Mon, 8 Dec 2025 14:04:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] cxl: Initialization reworks in support Soft Reserve
 Recovery and Accelerator Memory
Content-Language: en-US
To: dan.j.williams@intel.com, dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, alison.schofield@intel.com,
 terry.bowman@amd.com, alejandro.lucero-palau@amd.com,
 linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com,
 Shiju Jose <shiju.jose@huawei.com>
References: <20251204022136.2573521-1-dan.j.williams@intel.com>
 <143deecb-aa53-42e6-b7eb-91fb392e7502@amd.com>
 <69334c038705b_1b2e100b5@dwillia2-mobl4.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <69334c038705b_1b2e100b5@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS7PR12MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: 1327b76c-107f-4da3-00fe-08de3662c13f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzFiZ2RwSVl0a1YvQzlCNlloVUpJSFhBU3RDdlQ2L1VhZDFtL3k5K2VpRkJY?=
 =?utf-8?B?VVlROHpmR2wxQ3Y3U0ZTbDN3azR1WVFBL3lkWnhwRGM1ZCt6K09JYzl1N2Nu?=
 =?utf-8?B?MFYraWFHS2RwZDlxNWltT29teVBSVEMrTEI0cDR4b3cxNU9MSVdpSFNmaHRG?=
 =?utf-8?B?dXNqbVYzZHRTaXFkMnRLRStGUEJDclF1NzIva1E1cVJXNVpqamhBQnQ5aUpj?=
 =?utf-8?B?amhIZ0RmTDI3UytvZ3hBY0NjWkdqd0FJdVFGcFd3T2xlRG1kSmJQejlWQTg1?=
 =?utf-8?B?MmRPeVpGUSttdWlDQTRnYlh3WlJjNVRKR0xVNU43ZmJ4NmN6RTdEb20rbFRU?=
 =?utf-8?B?dkcyT0t4MGcwTzllRXJxbUVTUUNvdngxNHJ2MW51NkgvRmU1L0NHS2JHM0ZM?=
 =?utf-8?B?QVFub25KM1FvVkN5WVFXQWo4U08wTU5JVmJqakdjZEJQcHdLdUl4TGMwbEoz?=
 =?utf-8?B?ZGVwdjVhTXhQSlNPV09OVlFjUmxrbDQ1QTFXM3JwNHp4NUFCblE5WE54Y0Ry?=
 =?utf-8?B?WmpYRTJ1clNidEsvby9vZXFBdjFxREhOYkpFWWFHN3l1K0tNNW5EbHU3dnBa?=
 =?utf-8?B?dkxRY29FRUtvNi9CbHlVTUZsM0haWXJKT21sQWd6aXVFOUZHMkJTRHd1ZXRV?=
 =?utf-8?B?blNDNjlVeWc3YlQ4dDM5TFFCTkFKRnRtUk5ENS9GN09VSEVtZ2FvR3pOem1z?=
 =?utf-8?B?dXV1ZUZLV3hzQjB2cTVZTVRDUmZ4Y29YZUEwaGhSSm1Yc1dBaHJ4UGtFRXNM?=
 =?utf-8?B?NUlsZVNRTDZQUzkxbnhCUzFhTENaZi8ydDdtSGdkL2d0VkVYR1VUUlcwMFZW?=
 =?utf-8?B?bTZhblJjMm5mV2t1SEhiS1JqazdoaHhFdTZoNXZjWEIvWU1KV0VSZE9ILzFE?=
 =?utf-8?B?dUd3RlRwR2g4NXZxam80TFZMWVRacFpsTjRLelN3M3E4VmFLYjZzSXFEdGRC?=
 =?utf-8?B?eDkvaHdtNTRYMDdKbEZEb1Evc1l0SmRSVDNTUyt0c3VRZXBUNDlPY09UeWJY?=
 =?utf-8?B?QTRqaGFYU2xsckRwZmtOUFoxU3psaU41UDlTcHBvU3VXWWVvMWZaSGpCVDFP?=
 =?utf-8?B?bGswYWFOVTltZ0pMMm4waXVrYlYzbE9hbHlYQk5qZGNGbUpZYmhSS3JkVU01?=
 =?utf-8?B?Qm01ZThFbzJZMDY1SlA0N2dxQ2tuVjZFNUo2TXVWS2xnOFlSTHhnY2dYNDFH?=
 =?utf-8?B?QmZHSHNaWWdFaCs4Qll5NGVZTERCOE1ObjZhNk9QbCtlWUo3TVFqa2ZCTWFk?=
 =?utf-8?B?QlBTVW9WWU9QK1l0TERBeXlzVmNyL0QxcWlWdkJZaE9DL21JeXh6WnY3SWVZ?=
 =?utf-8?B?SXd3UW1NNWJROFpMenBqekRLVjEyZks0dnAyL21NYTJld0pUam5ic0ZyVHdD?=
 =?utf-8?B?a25TMkFKL1NFWkxzV21KNi82Tlh6Uit2WWVQL1JjckIrdldMSGdXeG9ZTXk4?=
 =?utf-8?B?ZitRM3FBY3BHUzlCNjhpOWcwWEF2amtWQnVaOVJ1cTlTaTkwL0paL2tndXhB?=
 =?utf-8?B?SDBSeDYwUVdnRGZDUjRNQjRFZHBQSG1JUGlYVkVmV2VMV25hZDBUbDJKQm1S?=
 =?utf-8?B?dnBGalZaNFF5TXdITSttRTJqNnp3TFc4R2F4R3FzSThyNkpHTU8zRXpta0pz?=
 =?utf-8?B?MW1zTmdRZmRQQU1iU0RBNjlUWHN3ekM3V2hiZkxPTHVqUUUrY0NUL2I2eEsz?=
 =?utf-8?B?aStXUUxwNG85RDhJNnFqTTBybFBEU3FseUs5Z2JNZHBaRkR6R1BjeStwMGtM?=
 =?utf-8?B?ZmRTR2lqUkMxZFBuYkkrTGtqK3lFTUk3aUd6RDBHdjhUVlBMM0ZpN2xsOGRz?=
 =?utf-8?B?TysvbUFjNm4xV0JUZFN3aDJtcjlISGxDc2NuQ3gwQ3JDRkNOZ2t1WGxJRXhp?=
 =?utf-8?B?c3Z1bEt3Q2Q0SGRpcXg0a1lDeEhyZmZpelc0SmQvMytrQ0FRcjFCZG1hbmZh?=
 =?utf-8?B?ZFkzbGozQnVpbGNtWGJDSlNkQTZsZ3BMaDdIV1EzcEs1WUhqcUlxTCtvMWNI?=
 =?utf-8?B?QzJERzlQejJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWJsWWF0WW9rRlpBbGxGbytuS0JFbEo0RUk0VWZOWHozTE9BOHlQSXJ4WGFY?=
 =?utf-8?B?YXRNalZVc2ZqQlZhelZJVjkyQU1ZSUlJWXlaRndVbjcwTmhxUFN6OUhhbnlr?=
 =?utf-8?B?MUljWXdGUFFSTUtadUJ3ZExOLzFhQUk4bjdBcFNlWldNQ0RReVFmQUVBS0F4?=
 =?utf-8?B?Q1dFV1F5bUpzSjdqT25BaEdjcDg0bDVmbTNWWnllOGxtZ094eXc4U1BMYVdB?=
 =?utf-8?B?c0RBL1NXeFlNM05TM25xVG5TeTBkclV0OVc0Mmk0MHFUbFlWQXlNT1VqZStC?=
 =?utf-8?B?V3o5ejRIbGkybkwzcGFuSXQrdkVmWnZ4eXRsaERxYm1FVStja3JVQllkVVpD?=
 =?utf-8?B?dm5UMFVpTytGbmVlY1JPUVprUmxSRFBSSDVjWkRGcVdpdExBUUJKSjZuT0Jv?=
 =?utf-8?B?Z0xiYkhpYU1ENmxPZDdiNUpvVkc0VTFWVmVhbEowRzBWRG5ucUVNVERmUDVD?=
 =?utf-8?B?K1pRaTBvRVJqSHFhbWRKNG5CcXJva3JkaVBUdVhHMzRja2kzQmNQREpoYWww?=
 =?utf-8?B?aUNYaVY0NWJhd1o0aFAzLzdOVitzWFRaZi8wVEdnYnEzZU5xZmlrVVdhMkE2?=
 =?utf-8?B?V0FXNkZtbUNZdjVqcFN0ODJySGRxSE1Ca2RPWlZkMUF0RGxKTXhmYmhqekd1?=
 =?utf-8?B?alAvSzhtenNONlR4WExab0ZtMGNOZ3pRQkZONkpwZ2NqbDd6UEtWdmtsbnBF?=
 =?utf-8?B?ZGlUcGpSaFQ2MXhvcExGVVpsbXBzU1FLektRZ0lkVndJQXdtbVovQnVPemhL?=
 =?utf-8?B?OGtqSldpMjFmUUVyaWlpV1gzZVY2UU5mSHBPZk5KaE1OalhsSjFtcllmYUJs?=
 =?utf-8?B?cGpSRjAzUkxkM0NGZkNyTk5QVHdVOGczSTgxeHZTdWFmci9KeGxxSTduYU9s?=
 =?utf-8?B?NWhzb1lmdXhHeWxRMnEwLzhiOExKdjlWQklOVUdvcUUyQllZQW5EK1g3V2Mv?=
 =?utf-8?B?b2plWXpXQ2Z3NWFNRXRzdThqaldFTTN6d2oyN0g5NFlKK3V3cy82UDBlVUZU?=
 =?utf-8?B?VzRJVi91OFo0WERTNTdDdW02cUdreGg3NDVhRG84Qmt6ZEo1cGsvdDkwQ1h6?=
 =?utf-8?B?MEVHNURINW8wQmg4aHJ2QU9VdEVWMXFaNm9HWnYyVUFiQyttUGxyWEVkNzNG?=
 =?utf-8?B?blM1MVlUOS9pV2Z2QysvUmxUdzFzYitQc2hTOG5PeldVZGdOVXhTL0RjR3Mx?=
 =?utf-8?B?QmxkdTFmbW9rdzFNSzR1R1duMEhIekliMjIra3YrZEtWMFVxd1RVVERsRGFt?=
 =?utf-8?B?Zy9XNW9zUndVcDg4cVR5RHl4bXk1TDRpTHYycnYvVlhSNWFObEwzeGg2UjV0?=
 =?utf-8?B?ZWo4eENDSld6NndjRHd6QUdqV3p5bVcwZmU2THd4aTlhbE43WjNMdDJLZ2Ex?=
 =?utf-8?B?VWdkdlovc1NTMks1ZGdmWk95MzJnVHMyajhOOFp6ZDBaUkx0cTM1ekJaQkt1?=
 =?utf-8?B?RUZmV2YrejFKT3NJd1d4Rk9aU0xQK2pxb0FROW5ZWlMzY3RBeHlrNG9zemFk?=
 =?utf-8?B?QU5vM1YzdDkwMEhlWER5ZnlIbjFtMVlwa2tkS1k5TDhXYlZKc1Bud3dBck80?=
 =?utf-8?B?UDNHMmFYVWN0cUZ0bnAzcVpTWDRZbjdNdUQvcUtraHQwNUZubHZZYVlnKzRR?=
 =?utf-8?B?SVJ0YzNuYVpxTjl5L0RscWt0ZkltbHRuemVkcEE2WXJlR0x5dTBMb3hVOVYw?=
 =?utf-8?B?a3FvZWVOUUxYTnVuaTlvYmltTmRtOW5WRjBFR016a3RJbXR2TGxoUEkzNXd4?=
 =?utf-8?B?a0Z4N3EvTWtuVTQ1Y3hXRmtXdWxYdFhKVUF0dnVEWWh4RHgyMkVsck85OE1P?=
 =?utf-8?B?bkFxWWtLTUVNeFhUTkV4UGxCS2E5bDdZczhGdVI4MUZSWEErWVl6YmVIb1Bn?=
 =?utf-8?B?UnlPRFFpUDVVWHZkRFVlQWFOU1dYVDRBc0RFK0kvVWw0TnF3bFY3WS9rWVNx?=
 =?utf-8?B?MkdZcFFEamlOcEFOeDRIbUFuMmxuV1VXVVFpQjhzN09ha2t5b2hvekpVMTc1?=
 =?utf-8?B?aWtveXV5QTlsMS9JMkkwbmpWVDc5ZUpsYlZVQnVveDVscUZDZFpWK3VSYTRS?=
 =?utf-8?B?UzhiYVlMeXRyekoxa2pEaVNyVnA3L29QZFlDL2NRSDVxa3l6Skx5dVY0c3BM?=
 =?utf-8?Q?PsHyOhWn/ceXoPKyLNmzEKlWu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1327b76c-107f-4da3-00fe-08de3662c13f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 14:04:51.1830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxeZcw3yolGQpCH2UOWsLvIfVLXBGzMvDmnBXJtj65fVc+jX8cdQXSeplDI7JxGAspXrvUVv9rn/fUxNp1pZCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6334


On 12/5/25 21:17, dan.j.williams@intel.com wrote:
> Alejandro Lucero Palau wrote:
> [..]
>>> For "Accelerator Memory", the driver is not cxl_pci, but any potential
>>> PCI driver that wants to use the devm_cxl_add_memdev() ABI to attach to
>>> the CXL memory domain. Those drivers want to know if the CXL link is
>>> live end-to-end (from endpoint, through switches, to the host bridge)
>>> and CXL memory operations are enabled. If not, a CXL accelerator may be
>>> able to fall back to PCI-only operation. Similar to the "Soft Reserve
>>> Memory" it needs to know that the CXL subsystem had a chance to probe
>>> the ancestor topology of the device and let that driver make a
>>> synchronous decision about CXL operation.
>>
>> IMO, this is not the problem with accelerators, because this can not be
>> dynamically done, or not easily.
> Hmm, what do you mean can not be dynamically done? The observation is
> that a CXL card and its driver have no idea if the card is going to be
> plugged into a PCIe only slot.


Right.


>
> At runtime the driver only finds out the CXL is not there from the
> result of devm_cxl_add_memdev().


If there is no CXL properly initialized, what also implies a PCI-only 
slot, the driver can know looking at the CXL.mem and CXL.cache status in 
the CXL control register. That is what sfc driver does now using Terry's 
patchset instead of only checking CXL DVSEC and trying further CXL 
initialization using the CXL core API for Type2. Neither call to create 
cxl dev state nor memdev is needed to figure out. Of course, those calls 
can point to another kind of problem, but the driver can find out 
without using them.


>> The HW will support CXL or PCI, and if
>> CXL mem is not enabled by the firmware, likely due to a
>> negotiation/linking problem, the driver can keep going with CXL.io.
> Right, I think we are in violent agreement.
>
>> Of course, this is from my experience with sfc driver/hardware. Note
>> sfc driver added the check for CXL availability based on Terry's v13.
> Note that Terry's check for CXL availabilty is purely a hardware
> detection, there are still software reasons why cxl_acpi and cxl_mem
> can prevent devm_cxl_add_memdev() success.
>
>> But this is useful for solving the problem of module removal which can
>> leave the type2 driver without the base for doing any unwinding. Once a
>> type2 uses code from those other cxl modules explicitly, the problem is
>> avoided. You seem to have forgotten about this problem, what I think it
>> is worth to describe.
> What problem exactly? If it needs to be captured in these changelogs or
> code comments, let me know.


It is a surprise you not remembering this ...


v17 tried to fix this problem which was pointed out in v16 by you in 
several patches.


v17:

https://lore.kernel.org/linux-cxl/6887b72724173_11968100cb@dwillia2-mobl4.notmuch/


Next my reply to another comment from you trying to clarify/enumerate 
different problems which were getting intertwined creating confusion (at 
least to me). Sadly none did comment further, likely none read my 
explanation ... even if I asked for it with another email and 
specifically in one community meeting:

https://lore.kernel.org/linux-cxl/836d06d6-a36f-4ba3-b7c9-ba8687ba2190@amd.com/


Next discussion about trying to solve the modules removal adding a 
callback by the driver which you did not like:

https://lore.kernel.org/linux-cxl/6892325deccdb_55f09100fb@dwillia2-xfh.jf.intel.com.notmuch/


Here, v16, you stated specifically about cxl kernel modules removed 
while a Type2 driver is using cxl:

https://lore.kernel.org/linux-cxl/682e2a0b9b15b_1626e10088@dwillia2-xfh.jf.intel.com.notmuch/

https://lore.kernel.org/linux-cxl/682e300371a0_1626e1003@dwillia2-xfh.jf.intel.com.notmuch/

https://lore.kernel.org/linux-cxl/682e3f3343977_1626e100b0@dwillia2-xfh.jf.intel.com.notmuch/



