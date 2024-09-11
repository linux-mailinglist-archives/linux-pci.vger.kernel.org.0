Return-Path: <linux-pci+bounces-13051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215B397574E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 17:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A3F1C22F1E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519951ABED6;
	Wed, 11 Sep 2024 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3jD/8apA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB0C1A3AB8;
	Wed, 11 Sep 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069100; cv=fail; b=tjI9emQuheMesgMmUTV/51jG/E7vJHA5VYYT/sF88ifPfCPlp37tUhz5oB3ENaM63+Z8ZNVxXeG8A85SlXBWJD0wHfstmC0arg8D+oT8DJDIW+Y0q2Te+Yq8WAlK3jpbTpdr1tFfu9RmSB6YJZ5+u77oBsKPNC3+eG4g4SiZf2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069100; c=relaxed/simple;
	bh=PRVuPVlKcr9LPF96iIIFB5KJAp4hrhbWx2PSBRim4Fk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IMI9dsxBmwamECSglPAhgG+U46bqU5UeknQN/TYpJQVLxee1XKLQ4nwWG7cR3wVSke6FapEdPoNzYORY3quTdZZySPeHc3LirTLUhElNPS6/n4l997Et8TE3EeK5j5DQ4rTYYfBMWEZlbT0gz+EE3D09EsMY2dkaZtE2uyzuK30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3jD/8apA; arc=fail smtp.client-ip=40.107.212.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZDu9JSyy3iaAhY7tVZj/Ym26LE//p5u9NZOUYS2W/s+F+UVDPNrkCNPIzjrMDrb1pZtOHLXg1qnhAWdftgBLkiyp3tQ1kPS2x1KrkEGK1nHKrkRoPM1RO+qQbYE3s04ih92QPcAdTOb8VmTZmveTItadHpPOmxGZjRv6nWkSJ8lUbCas72UXh9fOO7RTfZi7LKBqJ3ShZGGzH9PGtcGXovpfZBA41kvtpLAHaWgXALdmYD5H8zdmd31NkwvufkUCWI4AUp4uUG8SbR0MVvTnG97JvYrtfZPsd0fv0aPOixzM3r0VcJPJtLwQlpWS3sO7hxXstQcsXF5NNA0SbUStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90woEczDQLv6hWzWwgVoFwelawKJCvQGaz9+4SEjB14=;
 b=U4uJArBhIwv57uaQRLLQTzOkpCtf/SSo1w9tRBIYAkys6Jqup2NNAbOc3zRIE7ffz1jFDIsRWFSuNfE2J8Sxbk+KfzvWzrES3tr37I/6pL6XpfNTYlanmNpehUOjejQgA8RlCKaUnbJ9cbkF4ZOFXssdgolzI+NSF3omUuh3qCooafiWqguvk7/PNEs6F+46Bov9xYengFD7XSfmfh89xJl7SJ7LE5pXucFVbDDaJiVPXZ1njwlL7Uv7R262xorSMOUA6ngGg/h+W3Ek0nqcpUxgo/tA7rOwreSP6xu1bn8XPaV0I/drz+k857Z07wo/K4T7OURulsKq33sHAHiUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90woEczDQLv6hWzWwgVoFwelawKJCvQGaz9+4SEjB14=;
 b=3jD/8apAyqNaoAQcBVWjxT1N9l7Sadnthl1smu2rwOPZzVIzwfvoIV0MFD77RXyG06g0iJ92mExCsCAZZFMEdXq796pyRJ3yL72JbOibm3YywBbdgbMU/PpJaIkJRzfOKFk1Nk2bv3MFmeHWx7qoO1jtoCExwwrmQr5ZzVDC58M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 15:38:13 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 15:38:13 +0000
Message-ID: <c7b9cafc-4d9d-f443-12b5-bf3d7b178d2c@amd.com>
Date: Wed, 11 Sep 2024 16:37:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V4 11/12] bnxt_en: Add TPH support in BNXT driver
Content-Language: en-US
To: Wei Huang <wei.huang2@amd.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jonathan.Cameron@Huawei.com, helgaas@kernel.org, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, alex.williamson@redhat.com, gospo@broadcom.com,
 michael.chan@broadcom.com, ajit.khaparde@broadcom.com,
 somnath.kotur@broadcom.com, andrew.gospodarek@broadcom.com,
 manoj.panicker2@amd.com, Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, bagasdotme@gmail.com, bhelgaas@google.com,
 lukas@wunner.de, paul.e.luse@intel.com, jing2.liu@intel.com
References: <20240822204120.3634-1-wei.huang2@amd.com>
 <20240822204120.3634-12-wei.huang2@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240822204120.3634-12-wei.huang2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0670.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed6c432-2acd-4534-f467-08dcd277bf06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTdUTCsxY3JwRWpRTE54Y25Kdjg1UWNRbVdCR2Fia2F2Wm00S1k2K2JsQTFS?=
 =?utf-8?B?NVQzNjMvc3BnSHhZUEVQMHZjVWpPOU9wbDdNRkpBSmlNSTJxTWJoY0RMRlor?=
 =?utf-8?B?aldrRVVHZHBaUGFVc0dXUzJkK0VQSWovSFIwKy95Sk5LbU9MOEhzN0Z2WGpu?=
 =?utf-8?B?OFdua3ZrQ3RIMlVYZndKcWR3bHIzNjVuZFgrclRobkIvSHQ2NkxDKy9Qbitn?=
 =?utf-8?B?aU04b014VVNCUHZ6TktsaXVTTlg3QlhjYVR4NXdjUm5nc1ltRWlxVytkdUxF?=
 =?utf-8?B?MjVydnd6elpUVDhCSE81M29YazdLSUNxaHVXNVExeXB0Y0VVb3c2anNuL1pR?=
 =?utf-8?B?RGxUL3NYYzlOc0tuaHlTVDFIVXllN3Foek1pUFFpUVlHRGlpcGYvZEpDRkc1?=
 =?utf-8?B?Mks5OGJJV0FpSlcwSHRFaVd4bnNzeThJTjBLNVQ2L2ZoZExrRi8rd04wbXA3?=
 =?utf-8?B?UWcxa2FSYXpBVHZ5Y1M1Nk53OVFBYTZqQUFFcFhlaWdmMFBublB4RDBaRndO?=
 =?utf-8?B?bEp4NTMwNEZWZUhTblFabEhNRXJCbFVjYkpER1VqNUpQVUJBM2hacmxBK1V2?=
 =?utf-8?B?cVJTNktYRzFwMWFyTzh4Q1MwNVNmZlRvbTRpdTBJWDJ4RW5iL0VWUTlUcjVI?=
 =?utf-8?B?dUNvN2M1SWMybmUySjJFWURwNDdib1htZS9CR3M0aDIyZW5LNTE4L2FIdUI1?=
 =?utf-8?B?Tk45elNpVU1JNGNZcDE3TmZDbEx3WmhJSGphTUxyckVLZDNVdEhGdXc2VTBk?=
 =?utf-8?B?Q001WU92TFArRk1zL05KU0tGbnVQTmhSR0JNem9uWEwvaFZtaFlmSno5ejBo?=
 =?utf-8?B?eUU4YnJsL1RvSmlxOWNnRnRQSEhsQ2JlNWp2RUZqeWpJcWFIaEh2dkdGbHRN?=
 =?utf-8?B?c0VJZzlTd0E4RnJlZzFxUHVpYjd2OXpSQ0htUlB4cW94V0JEaXZjWkNpNmVl?=
 =?utf-8?B?N09qeVAzTHVRRjZSeExlVVIrN3RDR2ZrZTNtTWlFRCtmVWg4bmdPWElBQUQ5?=
 =?utf-8?B?Q28zVGhIbUNabVJmRFBjdVQ0cGlTdVZIMHQzVTBsYThRZWd3cHk2Q0ZUK0ln?=
 =?utf-8?B?bEVQaGRWSGlBd2hMRzhuSlVMNDRjZy9rWjErQVVkWUtSNFZ5eWM3c3g5YlJn?=
 =?utf-8?B?N0MvdWw3OVRpWUkwMDV3ZUV4aWc1SmJPdmRKYUs2cHU3Z2FRamFYR1QwcnlD?=
 =?utf-8?B?eHYzUEtWdDY0MHA3Wmw2d2lCVjU1bTkxdWFPMlEvSnFaWDJCTllobjVzMWY2?=
 =?utf-8?B?bk8yWEE2dlFIeXl3ZWIvWEwxSzFIOFR1TEs1SmpwMS9CL1NGM2hOakN4WDRi?=
 =?utf-8?B?ZlFiSTQ5TFFsMnhvTGJkK0xrbEs1cFM2bjZqZng2YWNNVWpVUGVvdW04eDRT?=
 =?utf-8?B?UlFUNWJ0OWd5YnZOWW9NTytrZnAwMDJwTU1ic3lPdUFHTXZWQ1pXUThLMXBO?=
 =?utf-8?B?aEFidjFSK0dFY2RiQUJzazBHcmMwK1dWRUpaYi9kZVBzN1loTVc3Y0VlZ21E?=
 =?utf-8?B?VlBEVGh0bEpPYURVbFZhbXhKZ3g0czU0UWVBOStlWDRxYnlyODJYaTNCZndJ?=
 =?utf-8?B?eEZReUtCTGpqWmIvSUU0NFhnc3NCUUd4eW1hM1duM09KNHR5L2hvZXE2UENH?=
 =?utf-8?B?NXdscnNJK3pnOTlvbkMzY2YwUmt5TktIVWVndVM5VGJ0cDdTRU5FQlNITXFJ?=
 =?utf-8?B?eVBFaEt0bE5IZXJucklQZzZ6QTQ4MkpmN3RqN2pKQVRJSGxib05xSjRzbjlo?=
 =?utf-8?B?QXo3N1dMbEFHdWNreDVjS05KaGhRSnUwOGNIY0M3SzFKckUwVmdnU1l4ZzY0?=
 =?utf-8?B?M0FJS3oyNzNnQmJPTjZGUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek9ZZDF1d05PMDcvQ3lzRFZpNDNpc2pJWU5uNEpwOFdsZmZSZE5RU1Y5Z002?=
 =?utf-8?B?V01takR2ZnRMdUpVOXlOYmoyK3RWNUlnanc0TGFGWU0yaFRuOUJWOXppZGRV?=
 =?utf-8?B?bnZzTk92eXZLYVQxWlBJc3c3ckhyeVo3ZHdWRktCNmNWQWJzekpmNHUwZ3Y3?=
 =?utf-8?B?RUwra3doYWxlRG1ZUlRrWWtvM3BPNDVlblUvWU1ENnpYWUU2ZmZzdG5ROUtK?=
 =?utf-8?B?ZkNsYjR2azZqR0pjQlpIUGROVldZRGdjdWR6Y21DeXdsY1lOWE1MRThRcWsv?=
 =?utf-8?B?RWJDc0N6cGtBTHhDOHMybExQS3RPOExwamlHZTlLMk5ENEQ0MmIwTEg1andW?=
 =?utf-8?B?VW5sSlVDbEpDSjdhRytWUk9aTThwYXliZkI5dlk4a2JrcldSWDc4WTNlWVoy?=
 =?utf-8?B?UWJxNkh5MkVPeWZxK3lrcVVYQld6TjVMQndXRDNTem80dTV5MktZcUdTU3ZY?=
 =?utf-8?B?aXhROUNOVmo3Uy8yWHptbUFheGRsVzJxQ3J3aGJhK3kwQ1htZzZKS3pFb0gr?=
 =?utf-8?B?anV5U0VBdlZaNTNiakp2YzBRdmNNbTVaRXlNT05OVGljZWpYQVBFMnJ5WjNa?=
 =?utf-8?B?NnF0SUxQTDUxdkxyM3U4NENMMG5hM3BzSC81ZlVxNC9WamUxdm9wODZKUzJm?=
 =?utf-8?B?dVVRS29OVmJQWW8zSDhpNzZ2Snh1bVUrUEwwV1RRWGhWRlhkT1ZEMXdqdVpq?=
 =?utf-8?B?cFQ2dm51aEtIVnJzUTJZUGJ4RE5RYmxBVWIwbCs0ZmF5ekxRaWtQRlpxbDlV?=
 =?utf-8?B?WG5JUm0vVGJzdmVqaUdFUU1iTnZueE9FWlYwQW1QRTk2YXE1OVBsa0hwRDlW?=
 =?utf-8?B?WXBxNnNpL3pnbFRNcXpEZDcwN29pRWdTNGJzM0tpVTFBMUdoNDhCT2NUT2wx?=
 =?utf-8?B?ODRMT2s0OU5kOHZ0SHErdnFFVWxEMEVDWC96Ri9tZlVMbERjMkt2TzN6aTJY?=
 =?utf-8?B?TWVVUERrTytCbUJaa3B4TlRoZGo0ZkZHQy8vZkg5a01PVDRWVHBmOS9XdEd4?=
 =?utf-8?B?c3RDYk5kM3UrdHBhR1VicEp2dCtUc0x0VTNEb2RhZTNKNW1OT015TEpHL3U5?=
 =?utf-8?B?MkFWczFidHQ1U1dqbnowcWdJVEtTcmNVd1ZQZUlRM0VRVlhKQUZqaFlRTG1I?=
 =?utf-8?B?RWkxRk1zRGV4V3kwcnNDT3VzSVo2VUpPbS9uUkpmakdodHlTRVRMNUdtWlZH?=
 =?utf-8?B?UUt2dFRYZGcvRmUvTVZTV0JBODlQNzZ5YkVPYitVR2lDdzBPTjdxbnRuaHhV?=
 =?utf-8?B?R0lsbnJJZGo5bXZKL3VWMWtIZUVtQXVQUmhiM1lUUUIvejZ3QjJGaUgzdHpX?=
 =?utf-8?B?WmlEYmxITUxhakpJYmJPOGhZZlNSSTRUT2pMRlJJblFRMi9XeU5PTjc0akRI?=
 =?utf-8?B?bVhuRnVrNFRSTEMwK2lleEJtQmRPbTgvNXhFMHB3WTFBcElBd3BXV3hOaHlQ?=
 =?utf-8?B?bENFMk9sdWdERldjamFoWWp4RVFQZENTOWxhOStGNWJmRHRFRzNkdXRnVG9P?=
 =?utf-8?B?MVdLVXFjbFZtUk9HUy85M2VBSE5Ba3ZvNHlHTVZvcGlEUG8ySXFZeTRGVDEw?=
 =?utf-8?B?RThROVpSS0szUWJkRDE1dXArUlZCd0pObHVZenFtZ3ZwVUM3N2dnVlBFb0NU?=
 =?utf-8?B?Q2hvRVNFamFhSU1IZzRoc2I5NEZnbVNoUk85OGdtTFA1ZlNudk8rai9wdzRL?=
 =?utf-8?B?eGFOQlRQR2I5bUtxYTRUNlVPQ2JzVW5oTUdOek90N0RsMlJSUmwxcjI4UUV4?=
 =?utf-8?B?OHZROERsaHI0eVVaYm9HemsxYnhMRDJZYXJBSXgwa0lUK0NNcXRnWGVpQ041?=
 =?utf-8?B?QmUxQWUvem1GdFlNSGhwNXQzMDV6aVYwWHEwYTd2b29XVUpjYmgyb0VSNTZ1?=
 =?utf-8?B?NmJYSTVVWnhEcUp6MG1HZ3NQc2NaRkw2WnBLUHg4czZuN2h3YjVPODVUQ3ZC?=
 =?utf-8?B?TEozZFNjYzV6VmF0dm9mUGRGVnRxeWdyRng0UTZFNnQrM090OEJSV0Y3Zkpm?=
 =?utf-8?B?ZUs2ZXhJcVBqUDJmb1IwajBOK2UrSmY0MG14RDEyTHVpNU5CN3RDcnA1YUtt?=
 =?utf-8?B?Z2xuNUZDRndvaW5obmlxaytuYllORDl4Ukp1TUs2WlI4YmovTGRJZjh5Uzdt?=
 =?utf-8?Q?xmucxTaZmBqpHLm9r9y0VKGPm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed6c432-2acd-4534-f467-08dcd277bf06
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 15:38:13.1075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s35Z9xRmaRgovHKtv0OlnAkD+GRYXdpxNDxKbGX8hf6e2UFxEgs3Wi6bvjDCNdtpTUApj21X5lMGxZEG4d9g+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307


On 8/22/24 21:41, Wei Huang wrote:
> From: Manoj Panicker <manoj.panicker2@amd.com>
>
> Implement TPH support in Broadcom BNXT device driver. The driver uses
> TPH functions to retrieve and configure the device's Steering Tags when
> its interrupt affinity is being changed.
>
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Manoj Panicker <manoj.panicker2@amd.com>
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> ---
>   drivers/net/ethernet/broadcom/bnxt/bnxt.c | 78 +++++++++++++++++++++++
>   drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 ++
>   2 files changed, 82 insertions(+)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index ffa74c26ee53..5903cd36b54d 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -55,6 +55,7 @@
>   #include <net/page_pool/helpers.h>
>   #include <linux/align.h>
>   #include <net/netdev_queues.h>
> +#include <linux/pci-tph.h>
>   
>   #include "bnxt_hsi.h"
>   #include "bnxt.h"
> @@ -10821,6 +10822,58 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>   	return 0;
>   }
>   
> +static void __bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
> +				       const cpumask_t *mask)
> +{
> +	struct bnxt_irq *irq;
> +	u16 tag;
> +
> +	irq = container_of(notify, struct bnxt_irq, affinity_notify);
> +	cpumask_copy(irq->cpu_mask, mask);
> +
> +	if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
> +				cpumask_first(irq->cpu_mask), &tag))


I understand just one cpu from the mask has to be used, but I wonder if 
some check should be done for ensuring the mask is not mad.

This is control path and the related queue is going to be restarted, so 
maybe a sanity check for ensuring all the cpus in the mask are from the 
same CCX complex?

That would be an iteration checking the tag is the same one for all of 
them. If not, at least a warning stating the tag/CCX/cpu used.


> +		return;
> +
> +	if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag))
> +		return;
> +
> +	if (netif_running(irq->bp->dev)) {
> +		rtnl_lock();
> +		bnxt_close_nic(irq->bp, false, false);
> +		bnxt_open_nic(irq->bp, false, false);
> +		rtnl_unlock();
> +	}
> +}
> +
> +static void __bnxt_irq_affinity_release(struct kref __always_unused *ref)
> +{
> +}
> +
> +static void bnxt_release_irq_notifier(struct bnxt_irq *irq)
> +{
> +	irq_set_affinity_notifier(irq->vector, NULL);
> +}
> +
> +static void bnxt_register_irq_notifier(struct bnxt *bp, struct bnxt_irq *irq)
> +{
> +	struct irq_affinity_notify *notify;
> +
> +	/* Nothing to do if TPH is not enabled */
> +	if (!pcie_tph_enabled(bp->pdev))
> +		return;
> +
> +	irq->bp = bp;
> +
> +	/* Register IRQ affinility notifier */
> +	notify = &irq->affinity_notify;
> +	notify->irq = irq->vector;
> +	notify->notify = __bnxt_irq_affinity_notify;
> +	notify->release = __bnxt_irq_affinity_release;
> +
> +	irq_set_affinity_notifier(irq->vector, notify);
> +}
> +
>   static void bnxt_free_irq(struct bnxt *bp)
>   {
>   	struct bnxt_irq *irq;
> @@ -10843,11 +10896,17 @@ static void bnxt_free_irq(struct bnxt *bp)
>   				free_cpumask_var(irq->cpu_mask);
>   				irq->have_cpumask = 0;
>   			}
> +
> +			bnxt_release_irq_notifier(irq);
> +
>   			free_irq(irq->vector, bp->bnapi[i]);
>   		}
>   
>   		irq->requested = 0;
>   	}
> +
> +	/* Disable TPH support */
> +	pcie_disable_tph(bp->pdev);
>   }
>   
>   static int bnxt_request_irq(struct bnxt *bp)
> @@ -10870,6 +10929,13 @@ static int bnxt_request_irq(struct bnxt *bp)
>   	if (!(bp->flags & BNXT_FLAG_USING_MSIX))
>   		flags = IRQF_SHARED;
>   
> +	/* Enable TPH support as part of IRQ request */
> +	if (pcie_tph_modes(bp->pdev) & PCI_TPH_CAP_INT_VEC) {
> +		rc = pcie_enable_tph(bp->pdev, PCI_TPH_CAP_INT_VEC);
> +		if (rc)
> +			netdev_warn(bp->dev, "failed enabling TPH support\n");
> +	}
> +
>   	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
>   		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
>   		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
> @@ -10893,8 +10959,10 @@ static int bnxt_request_irq(struct bnxt *bp)
>   
>   		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
>   			int numa_node = dev_to_node(&bp->pdev->dev);
> +			u16 tag;
>   
>   			irq->have_cpumask = 1;
> +			irq->msix_nr = map_idx;
>   			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
>   					irq->cpu_mask);
>   			rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
> @@ -10904,6 +10972,16 @@ static int bnxt_request_irq(struct bnxt *bp)
>   					    irq->vector);
>   				break;
>   			}
> +
> +			bnxt_register_irq_notifier(bp, irq);
> +
> +			/* Init ST table entry */
> +			if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
> +						cpumask_first(irq->cpu_mask),
> +						&tag))
> +				break;
> +
> +			pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag);
>   		}
>   	}
>   	return rc;
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> index 6bbdc718c3a7..ae1abcc1bddf 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -1224,6 +1224,10 @@ struct bnxt_irq {
>   	u8		have_cpumask:1;
>   	char		name[IFNAMSIZ + 2];
>   	cpumask_var_t	cpu_mask;
> +
> +	struct bnxt	*bp;
> +	int		msix_nr;
> +	struct irq_affinity_notify affinity_notify;
>   };
>   
>   #define HWRM_RING_ALLOC_TX	0x1

