Return-Path: <linux-pci+bounces-2126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F35D882C4CB
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 18:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68F421F24C37
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 17:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B352262F;
	Fri, 12 Jan 2024 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KTHu+24N"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C52617540;
	Fri, 12 Jan 2024 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTy5b7d9qMgAkDNKR6iaGGVnYWjx5hV24xdoPqzEKTAZpFJWrE53VDWpWoTN8lwyVUOiwtEt9yLb92N6rWJPBgpv3ccTpJ2LXfNcH0gnaE8b7cF5OXq6IYqRWmpCLCntuJHxjdvt/SIS1kRliQv2vZJm6GxDzAzpeT294YQ2fuHvBjK+2NAoy0I9YLUf0nk5YHcwPZl+x7LFjF9fj4runTLrntK7VafircoJ++fmXkV0aIKMEZKSbsPKqB7135gdderh1qSjh51elPGHMRlQyRtpLqIvyWoHDZzxH3oiac+TcgFF+INQYotgfUiaRp/uyU+8iJRrt1b/oZNGTjxorg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3AI4s/lg2eeJn6SHXOUzU/1eog8PZHzKJ0L+erGjp40=;
 b=VJDDBFkGzcu0SZZc8yH48zhLwIrjG68uaa6aUZGeDShkXidk0BQ56/dNd3exLEK/B7mPJfqNymx619dmmTYgDidUv8/mCmb1rVSzwqPr5T5NmHJkUOjhhgoqlUa1cb6SiI2uqyNumYyIPlm2QOMqnTc/dank6qektgOkfVm4H8M+JKOZ6sbgdYlvrufLAJC3zaGxzaseq9/ySAb+wkre3myOChG2MzeTA5/pYgT2+Yh7PZkKIGGkI6qsd5iumH5lewZvHzkAKM8xOEPRZcUxfbP7MJ4w71hg2NmFLBUITZMnRLPkrIFx6SjmtRPPcj2DwitKZD40T12jowWHeeSy/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3AI4s/lg2eeJn6SHXOUzU/1eog8PZHzKJ0L+erGjp40=;
 b=KTHu+24NTmhZAr/sQx2DcpDWSX9NlT8UxAv69q4yLIOtcBVYn6jvGiw/43y84mlaZ8py2wRi2iDzIJVoymv40XKrMjeIVPa3ao0K49gMlFovbql2reONZYw+U9LPcmVlwYTATeiX40IjzDq1N9rDi48CE5Q5gjh98cdqyBPyVkpgOMV7iNQyxJ7iYZH2tVjZlXqrjacdPISGecqV32i/tMQTgiPaWPofyHeN02yyEpYGZhyzWF0AxnudRJQl0o4HuS2As5JAulXu5r4Aji2p2dKPu6GsU3BRloA0KoYpVBoElP2EBWv4oO3vBTeLLu4DmHbtZfTGQcWKBH5NNw4KeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.25; Fri, 12 Jan
 2024 17:33:41 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c%4]) with mapi id 15.20.7159.020; Fri, 12 Jan 2024
 17:33:41 +0000
Message-ID: <b9a7b855-af2b-4858-b9d8-3340a0421cfe@nvidia.com>
Date: Fri, 12 Jan 2024 23:03:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] PCI/MSI: Fix MSI hwirq truncation
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, bhelgaas@google.com,
 rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com,
 jiang.liu@linux.intel.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, sdonthineni@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240108120522.1368240-1-vidyas@nvidia.com>
 <20240111052814.713016-1-vidyas@nvidia.com> <87bk9qim4p.ffs@tglx>
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <87bk9qim4p.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::16) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: dcbf2744-a2a9-40b7-ca72-08dc13949e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ppjN6uzdqI8Tz7t0uSIS+iKFaWjeIv3PF9IMJolh4JoHkCaVxY7Q69vvDjNGZxkJUtQrX8nZ1pSqZ9+7myDKWo6BwnDYgy4lXRbz+g4FwfwwAqssP7Mdw55HPZsXQfFQimRKkpKEyUrrw4YoFC8GQ11XtHDybZG8ZaydPmYvpANEEJC30JTkBDG9/d59Icp6KgBNwTsf1GOmm8YeBcllR+4zGKLJOgVE7OBTaxkhxBzMnpzI0vBExjmpi9lpHeWJCpoZRmKlRd2BFzmEpgizmkrPO+TFXN4imJ/p4wVZVoivQm0qp33SRuf1WzdthqPSv5LXk/8WjmXzVUxYgrlC5S8CMlf5sORaBz3JRlZUSFE94p7unI4l+6pRX4Hvet3vlukkeVfn3I4g44ROadgD9L41zXWMfdv8wHHmJxLeE61i0uhGk1bqAuF7qx4qEgY4GsI1zFVgCAy4lKcRyu47MFg75MBiFTKedcPnqczxtyZTCMMcmlqShQCOdPY1MeyZTIGOBU3vOWltZNYxtx4AmAq7Ur07Xil+Swdg5QQ5qQw9kk+3/7bFAL6lLNf7h/csPpbc7GUzgzhFVMeghkdUhnj0T4A0fU8mStl0aLAvqnepwAE3XfZucnyWOzCDlO/VWNdo4vO4giZjK1xQHCvbKeVzcQ7nu+FKEFGAYU/DoJ3u+6+s2dt0pobzBj8erOfv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(41300700001)(86362001)(36756003)(31696002)(38100700002)(2906002)(83380400001)(4326008)(26005)(478600001)(2616005)(66476007)(6506007)(316002)(6486002)(66556008)(6666004)(66946007)(8936002)(53546011)(5660300002)(6512007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STMydkNaSjFMTW9sL0NBbDI4ZGE0ZnBjWnBwenFYQmlLZDBhQnp6Wkl3dXdh?=
 =?utf-8?B?aHl2MFBTRE50U0d2S0FiVEREMkdxMm00dWNYb3lUam5uUVNKanpWMWRxZG03?=
 =?utf-8?B?TXBvWGQ1ZWxJZy9jRnhOaWZFQVIxV1YydW9hUE1yZVFjRytWWGJwbklNdVZN?=
 =?utf-8?B?S1FUS3NxeFRGSDV3c2wycnE3UmpRTDZhOEU4aS9PNjBKRTFGT1g2YTVFT2ZV?=
 =?utf-8?B?WFBpZHZjQXBPS0dMU1NNUTNGUlRGVnp1SGVkamx2OHU2U2Y0UjdaTnRxZGZp?=
 =?utf-8?B?anc0eGZiZWx1c3dxNnl1d3JwVlhjUXI4TVEydUhVVTg1aVlVSVpoUUV6dDR1?=
 =?utf-8?B?SG1sVUJEWTBHbHJmZytHSWpOcDQwTFZ3K2xXK2hRaGFBbFFIbVFKbzhoWDZM?=
 =?utf-8?B?RTg5cDhEbDg2b1hxTFJIcEsxa0NDbjNJOEJEVHBYb1JLWktPRXlzTHZVajEv?=
 =?utf-8?B?RXd0a0NFaldLK1Y5UEk0SldHVnpMaWNGR1JST3Y5REF2bVB0K0JOK01LaWZ2?=
 =?utf-8?B?bXk3dEdmejlHKzgwcURnemwydEdyY2lmaHBGaUhOQnQ3YTc3SWkwbCtEczc2?=
 =?utf-8?B?LzEzZ1ZRSmdoVUdyUEpnU3VCT3RNME1BNjZ4L0FRSTEvazgvY3RjRk9WZEV1?=
 =?utf-8?B?WXdTKzhISk40dmQ0NTRid2xBRG9reFhRQ25BU05ibVZuR0N0dzZZQ3FoQ1U0?=
 =?utf-8?B?QVZZdXQvb1dmTEVRbXo3TUF5OHhtVUpzSG9tcjNYYWlKZlNkMlRSL1dZLytp?=
 =?utf-8?B?cWZ4a084a3NqV0ltS1ZKTFA4eVV4WVNrRFVoclBzNHkwN1JDYWlSVzNDZTA4?=
 =?utf-8?B?NFV4dDN1M25wOUUweXRDSjVNMi9vYTdBUWlnNkhRNldzcU9hbWtPMTlzYzdY?=
 =?utf-8?B?Njk3bWJQUFJmRDdCWlROTERSOHRWS2hMbkdMMkxaK3dwUDlBZXZmSGtGMXRH?=
 =?utf-8?B?V3E1TDVYK3ltOUtNZFJDc2pFNzVGNVo2aHJyRGFFR1oxQnRTdWRWRDlxenpB?=
 =?utf-8?B?NjM1SUlqaTE0TWgrUWkxKzVOWXFxdGJGOEN3eDRsWGVGa05iOGh5MEJjbjlH?=
 =?utf-8?B?ODhRNVpheFY1N0pJLzBKbWtLRlJTcmNtb1MydlJ1R3doMXpRYk52TGNxRXJy?=
 =?utf-8?B?Rjh3aVYvZHFvaWgxcXd0cTAxYWlFMUJMT2orWHZrdkpQSGtEYUR0c3BLaEJN?=
 =?utf-8?B?bkV4ZStwYSsvckh4Q3pXZlNzY0ZVWFdQOUcrVkR4c3lXZ0tXQnJiaHpNTlVx?=
 =?utf-8?B?djJ4dEZqbXgxemo5aWFsdDVkOGZweFpqaDJaSWhSTC9MT2JoWW1TdUxycEgz?=
 =?utf-8?B?dGpVSWFVWDVGaUpNRlEzZytvUWpVM1JWWHNEQUdHenFxRWJ5WHRESFhkSWF3?=
 =?utf-8?B?Uyt4dEc1MEg5enM4NVNIcWFYYjNPT2RNSVBLU0VKME5WQ0ZHWmszcDl2VHZC?=
 =?utf-8?B?aUtjUEUxK0NMOFMxcVZmTWdybXVvVjRUcnBCWVVCUnhKYUd6ZXc1TFRwOENJ?=
 =?utf-8?B?Z0J1NklEdlh5cVMzL2JsMnVQRW9rU2hJTDFBUDBRdThpUzhzUXVUdVQzZ00r?=
 =?utf-8?B?aTRqUEovbll0WmdNZU5FSGhvbmVYWVJMNmR3WFFFVDFRai90Sm9JYjRNQm9Z?=
 =?utf-8?B?a3V0QkJrTDlpQnR6bEpiSTF3RWN3S1loR0xqNkJaNzVJMjY0LzJzeDdRRTNE?=
 =?utf-8?B?cGdmTU9DSFJTQzNMQ2xLL0FIbFdHWHRHQjk2YjZZRi8wWS9CN1BRNjJITHNQ?=
 =?utf-8?B?SUpPQzRnSDE5S3JQSW9ZUksxWVRmWXFuNVBtRjlkMTg4Q29iWmMxYnRJTnRW?=
 =?utf-8?B?Q2RnR2l1dkdpU1FrZDdLdjhKMDVJVlA3K2NycjNuMGh3aGk0ckxCUTk3cVc5?=
 =?utf-8?B?SnZ2QkxBSTVPcVdxOXZIOTQrMmJCaGlycHRXZVMycExSMkJJeXIxcmRzTWEx?=
 =?utf-8?B?cHgxY2xPRVJXeUlYWHBhZk5GSTl2Q0I0UzZ6UFJTNkorVEJwT21ZRXZVRzJZ?=
 =?utf-8?B?ajF2ZVNIYVJjdjR5TDk1eVdrNUZsc3VYR3J2cjBDNnBFR1VWNm5wM1dmaDBG?=
 =?utf-8?B?MHZXVnFzdDZVYkVtbXBQczV4V3hWOUtyZUtlTVRwbVRyS2VmN0hWRjNQSVlB?=
 =?utf-8?Q?wIkIJAadxI1R9gl5am57/PzqI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbf2744-a2a9-40b7-ca72-08dc13949e05
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 17:33:41.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GsqnFe0bqUrHY5aDuQVwWiDncV+IalpIA5nBWXtlJRXSfal66ypurbxklMY8gERDoHApe7SdUPTcvd8BFlsIlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078



On 1/12/2024 9:23 PM, Thomas Gleixner wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, Jan 11 2024 at 10:58, Vidya Sagar wrote:
>> While calculating the hwirq number for an MSI interrupt, the higher
>> bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI domain
>> number gets truncated because of the shifted value casting to return
>> type of pci_domain_nr() which is 'int'. This for example is resulting
>> in same hwirq number for devices 0019:00:00.0 and 0039:00:00.0.
>>
>> So, cast the PCI domain number to 'irq_hw_number_t' before left shifting
>> it to calculate hwirq number.
> 
> This still does not explain that this fixes it only on 64-bit platforms
> and why we don't care for 32-bit systems.
Agree that this fixes the issue only on 64-bit platforms. It doesn't
change the behavior on 32-bit platforms. My understanding is that the
issue surfaces only if there are too many PCIe controllers in the system
which usually is the case in modern server systems and it is arguable if
the server systems really run 32-bit kernels.

One way to fix it for both 32-bit and 64-bit systems is by changing the
type of 'hwirq' to u64. This may cause two memory reads in 32-bit
systems whenever 'hwirq' is accessed and that may intern cause some perf
impact?? Is this the way you think I should be handling it?
> 

