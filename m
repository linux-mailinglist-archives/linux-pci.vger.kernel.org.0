Return-Path: <linux-pci+bounces-33456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A63B1C05F
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 08:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248493A525E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 06:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD92190498;
	Wed,  6 Aug 2025 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4s17WqwL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DFB1FB3;
	Wed,  6 Aug 2025 06:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460992; cv=fail; b=bF/AiGwRWpZMjxKFEGnPRGTwz26BdvltU975sGyIaaQw5kJTFjQ0+7QHPPVs/dPCoX9dEde96mS8FRzo4leueDXE04K5YAKDbx1wgCiVyWrllLprn6z2erja+/z9bh8pQkLkp9KeAmW48AsCW2bfqs5jRepX9MzR8VMQ1A+7wlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460992; c=relaxed/simple;
	bh=4X+Kyu5viwX6lrYMbuO4g7biv2L9Ag5hOR8mQTf4abE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jcf8eoLvIw/5G7kPmyP0okKYe/ajkrFs2wvVOrT+g1PkkbBrKXXtkzO02ZVxdbYiZh0BYpeIUPj4xX0w+lbUx5fOAh7Nelb5LP7of/tlnFns7HlDwFxRg/9WhMYyYjJCm9Wa9J0HF9Vd1jpVyJcRdSti/YpgQi5ekw6aBm7nmjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4s17WqwL; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U03dRzvzsKTlf375qYVC/NsUSeqVZcaf1Jg7NHbp2nUqY+U9Achkkodh8Z3NNGVKioULbPVnRaUyzj9SWzUKPw8F8YR/ot6nTkqUU4YgZ9vfXlE5uesCDJC5BJiJK/vvbpxwQP7Dbl5FdpVPmSXWQangzkabZVn6R7s10E0uBUJdIQnx0iN07irik1gaFk2EATD0+SGe6aJu7MS0lyealw55VAWVHM19ppmhzAMz+GAfZ+G/qQx1WA+mFNvgifC/9GiOiDJr5g0Qvkj+mFpkmVtBtip0GbPEjxI1M2XCMYsXbbytKML5Z+LJHG6colWoczu7DAG4/34x30U5ijf+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4Iud10/LdYdaOqbEXdAzdFy4vsQT7OWVrw8367UUKY=;
 b=rQwBHExQ8yjAtq8mSqcLkIdU6BxGFgr6PQE6jojuobI2nADTHW6jtJemAMXv4pRDyGyiuvXaA7guIg6MHjRr2mnLhhvrzTzAytx7Cli8xvw2hg2b1jBDqynAzmxnK2/LmT20UE1mNKqgmMm5vnBjOIb6HED14SXp/0dW5efuuj0z/+GPMcSkmSar5r2Jzk6HUTtceJUIoauL5QcxhTQY/XRlREid83uSNBa5dVk1j88vS2xsZXOfquiU5rUyPhdzdGZ14+BZL7x9Bm+XLgup8dSMmkPocVxxTJGR3Qvll61sIw2n8fOza29Gc/7oz7NSpXhxyuy8BQBmK2INk/NYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4Iud10/LdYdaOqbEXdAzdFy4vsQT7OWVrw8367UUKY=;
 b=4s17WqwL+puJzAB3JYOib4RZ9V/oDARLGaVI/MSA5Y9q0QiXEepNjJByf09/f+RbhYvPhVv4mu/eV0+TisPFsU+ZFR7hkCmRqs8nPlY3RqAZIBO5X6GtBu51+7rtxA/4VsyHx+/S+CN3154Nop4jEy3iOm0w4lAfWe26WcBnSMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by DS0PR12MB7727.namprd12.prod.outlook.com (2603:10b6:8:135::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 06:16:28 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%4]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 06:16:27 +0000
Message-ID: <59cd3694-c6e5-42c4-a757-594b11b69525@amd.com>
Date: Wed, 6 Aug 2025 11:46:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] thunderbolt: Update XDomain vendor properties
 dynamically
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, andreas.noever@gmail.com,
 michael.jamet@intel.com, westeri@kernel.org, YehezkelShB@gmail.com,
 bhelgaas@google.com, Sanath.S@amd.com
References: <20250722175026.1994846-1-Raju.Rangoju@amd.com>
 <20250728064743.GS2824380@black.fi.intel.com>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <20250728064743.GS2824380@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::49) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|DS0PR12MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: ef30628d-5ee1-454e-4906-08ddd4b0c67d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tkg0b2R6bDhTLzR0c3BaOFFDV3NibjBUWVp5TW1ISzZ6QWMvbUNDUVJYYkhI?=
 =?utf-8?B?NTZyTHZHbXFyOVNIVElIQkpsWHAxMTYzcmliNklPbGp2eWVTUE1yUGpkV0h2?=
 =?utf-8?B?QVZpUURhWDFGZmloOEFJUXIwSzIybHppbjAyWTdqaUl6WXZraUNFSVQ3L2Ir?=
 =?utf-8?B?RDVHcURKdENtU2JuNVZPN0J5Qmg1Q2E2WlJQTWdNWW5adi9hcTRybTJacEV1?=
 =?utf-8?B?bmtJM044UXR4UDUvbVhGMVlqNjg0MWcxQWY1b0x0YUZRRzhpWFlPenJRMytm?=
 =?utf-8?B?ZE5URmZ2ZHJVc2xWMk5jSWVBVEY4RXl4RWIyaElOdUZDU053ZkVVVmhuQnEr?=
 =?utf-8?B?ZmRwZ3Y2M0pvU3hmZlM3Q0RBcFo4L3Y5T2o3c3JlckFiaGM0d08zcVpJTk9y?=
 =?utf-8?B?aW5ldGI0bFBSZFlCQkNlSTNQazhjUkxkVVg3UFlvVDcxSU11KzNnUUJmZzRv?=
 =?utf-8?B?ejYwVnFwNms1QVYrVkprWnpuZ3kzbHM2K2NDWnNJc3dKR3hITDdDNVM4aTlH?=
 =?utf-8?B?N3Q5U05FMXJtLzRTZDk1ZFdqOXduemNIZDVvbHQyYk8xWlFCM0VIeXZRRDA2?=
 =?utf-8?B?eEhkOXp0aXh4bVNTWkdXemlaUEMydnpza1VDU2R3VElKNEQvN3FPYncyaXdw?=
 =?utf-8?B?MXZGdWt4dGhyYlNaZDZNa2tSTVM1azFuakZRRWliMnF1QkdkV1RpNW5uWHNa?=
 =?utf-8?B?SkhJK09xK2dyWkFSSHE0SXBwT0pneVhRQi9PbVhXU1AxKzQ1Unl3N0FQRUZt?=
 =?utf-8?B?dUhETlVsdjR6SHNucFMvMk1Ed0I1SWRwZG51Zkxmb0ErQzQ5dzlMTC9MTmNU?=
 =?utf-8?B?N2VXYS9aaWVtb3l6SVFWdGZCd29uU1RCRnBuc1hvcnZOTkFpTHZSR2lad0ty?=
 =?utf-8?B?Y2VxYVZCYXhydjk4WXdpU2c0bCtIR0xubGl6Q1RUMnpyUTR4Y1dKZ3ArZ0Q4?=
 =?utf-8?B?bWRRMEwwTjRBTTg1SDNEUlNIQkYxS1JQMEtNbGs5Znk1K21mbStRbzlhUk1r?=
 =?utf-8?B?RzRzdUs5bk9XZGFNV3FRNmZUVWI4eE1EOERhK1ROdTJJK2FkWHVGcEFlK09O?=
 =?utf-8?B?dGpXNGdxL1NLaVNoV0pGS1Z2SUwyYXRTZWkwTldzZlNQTlZlWWI2Z0N0SjBS?=
 =?utf-8?B?MVg0Zk9ySWJjbnRNdTMrRW1ZaXhFdWg1eldkOGZQcVBNSVlheERQVFMxdEFS?=
 =?utf-8?B?bzRPV0ZOYTFnbDE2VmVmNTRzd2M1aWQyV3Q3MmhTN09DY1g4SnI5V3pGMVRI?=
 =?utf-8?B?cGxleUZ6NDJCdU1sUW1lak5tLzhQNkY0cDE1MitkbWc2UE9pWWNwUHp3SGxZ?=
 =?utf-8?B?Z3RKcEpVeVNyTm1zU1dpNTFYT3FwS0hFMCt2MVlsRjN0bmFrM1NjS3hENngv?=
 =?utf-8?B?UUsvZTVCN0xrckJBZW9HdEZvMXVYUlhkQk5OMUpVNjl3MmhXZ2FqdU5lUk1U?=
 =?utf-8?B?dUtYTHNqK1lVOXlYZThvQ2FwNzdVbE03dXJIZWpvdjh1S0dsVU5KNGV5NkJ0?=
 =?utf-8?B?K29qTjdqb0hxRUN0NDNvMC9XN1BHcXU4emduQTdOeENVeURPRllxWHZMSG8w?=
 =?utf-8?B?OUZ6am1BTE5DUXRaT295cXhyb0paTXJwbzh6VlhFSVc1Vmh6Rm4veVlWalln?=
 =?utf-8?B?aUNsVkdaWlFGamZYYXFDTmVoeUxlL3BtYXFGcjFDeUYzbGVDZ3JhS2l6UTRi?=
 =?utf-8?B?YnZOWkVuTVhmZEdqT1B5VW9lWGxBU1huczh3NUt0RjNTQURaMWJOcmJOSFBh?=
 =?utf-8?B?emdLVHR3WDAwUXlKS2VxMUdPZzh2MWxiVDd4Ym5xRlA4SWx0bThER0dMNWRK?=
 =?utf-8?B?ZkkvMTdvSjZlNHdoVjRWcXhoR1c0Sno0UzcwU2NlcFJSTk5YbTY1QTJmWSth?=
 =?utf-8?B?M1N4Rk5xOVFNRVE5SXFLQm5hRXhvU2JVY3R3R0R0OW9BcytjKzM5aGgwaWJ4?=
 =?utf-8?Q?H57NK+L/BcE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anNmaEZsN2hldG5tN2ZrUy9DU29wVXgwQnlvSEtSd1ZydE52WTVyZUJPVjZp?=
 =?utf-8?B?ZHNpTUpuOHhNWmNCdmw1Szh1cVl5QlBPSnlWUVdneEF4UmhFMlkwOURKYzBT?=
 =?utf-8?B?amVITnFyaWFqWHBQV0N2TXNtWDJobnp6R3ozUjlKU3FTd1czSUE4YlRSblI3?=
 =?utf-8?B?Z0VneEhaY0hyalZ4dVNEcSs1aUttenpBbzJvR0xRdmtpVFBvVWdCOWtHNzVS?=
 =?utf-8?B?OC9GSWV1MUFsSk1BVGtjVWRiRmJyNkhoYmhqRUxKRVJOVWNrM3JtK1dsYUd4?=
 =?utf-8?B?b2dlZndNRVpPVENsRUFva3I5VjlTQUZlUSs2WWVvalZBWkdqRmQvSzI0UUFj?=
 =?utf-8?B?dGMxbVFhdDc1dWZINzJtV01uL2pncGIzazI5MWN0Q0U5YlNIUENpZGl1SjFS?=
 =?utf-8?B?QUhJVU9JMXJZQ0p2NWdmUHZNa2JJdXdCVGZkM0RHeWZQMzhvZDA1SUp6VG5E?=
 =?utf-8?B?KzRtLytZNTM3TjJaSHFuSTZNNE43MENBZlI3UWRhdkhHYk1WQjk4eGV0YzVP?=
 =?utf-8?B?TTlQeTI2QkluOGpEc0oybHpYYkJReVNMNEtPNTJSclF1UWdIc0xmUmhERTlC?=
 =?utf-8?B?UEdOZ0hyWFJtdmJVVjBQUzB6UFF0SnJFWXI2WlBtMGl1TTIwYm5jbDgyS3Vx?=
 =?utf-8?B?alFPcE9tQ2p6UWxYditUMkhGYVI2QzhXa0hNRDJub3hNd3gxdEJLcXZmSUpH?=
 =?utf-8?B?Mk9RVjVOZUFrUUt5STZSVWkwbm82VkxuZ1F1c2VoTmwybXhvWUQ2dE53SUIr?=
 =?utf-8?B?VHV3djZacXVaWTdsdUZtUSsrUU0xbVhSUzVaVUJEVkdjYXRabG1FdTg5YjBy?=
 =?utf-8?B?dXlDL1Q0bnVwUzlCRHZpZ2V6Vm44d2l6SHAvaThWb29oa295WVdjZ0U3WVNp?=
 =?utf-8?B?OHlYV3pTbW1naDF3amdwNU0wSDFLR1ZFRGVRZzVwajFWQjFUVExVVEhtbnZ1?=
 =?utf-8?B?SWtQK1BqN21CdUFBbTR1cDdpTmJOc3JVQ2c4bUFDQlVRMWdXMUZOMWdhSFhp?=
 =?utf-8?B?Mm90cTY1eEVZTkwyZSs3WDNEZDFXbk9WeDlXaXVDemtHUGZVdzBuV1N1N0gr?=
 =?utf-8?B?bWVoQ0dOdzVrbUsraHZKM3dSaXhiYWRseDRydW13eTAzT3UrRXdVK05VYTlL?=
 =?utf-8?B?NWp0bldTVUVTcE92eDBxTjVsSkJuMmlXWThIWFBmU3VaaUhZcFFyU3A4NzlI?=
 =?utf-8?B?NlcvOElodmljWVBWUzkreDU2Rmwza1J5MVF6emUzbDNSYit1NU5XQzlGNEtv?=
 =?utf-8?B?ZXJQeXp3eHdXcVNOM0prMjdXUU5TRnNCOXZqT0tSdWpzT3JoaFBiSlh6NGhF?=
 =?utf-8?B?OHh3bnRaRENBVmIxVHNSNXdDUHRRQktuUUNuV3Q2TVZlSjdZTVZ4RTNmbU1z?=
 =?utf-8?B?bzF5ajVNNlZ2eWRVbkJZNURCRjVsQUFTU25WMU9qcE1MdnBKZHVtK1JaZkZo?=
 =?utf-8?B?azlGZXRmakJkVmFQd2t3OVlZMGZxUytUTU1tczl0b0hYZlVjcFdaY3FPeExj?=
 =?utf-8?B?MURaYmFhSHVGMnpkT2YxeDM5ZDN2TU93MGhDRk9zb25URzRzOUJRaVNSdnNC?=
 =?utf-8?B?bjVPd3RqdjdrajZVbVdGNkU1ZDdxNm9URDhReDdKdVpXR0t2R1ZKKzkxV1N2?=
 =?utf-8?B?cGpOM05oYkRwTVhoNmVzTGoyWGQyVHJTRUdZRWp5OFMvalEyNkhORnNmQTFL?=
 =?utf-8?B?dW1ZOXNCOG5lVmw1a01uTG5VbFlaby9ZeHhWZ2Z4RnFsOHk1eENIWUtsTWQ4?=
 =?utf-8?B?dzBhTGxKV1A1cFh2emFIVDBVZEVyZEFubHcvamRZb1VrZ2ZyNVluV01Od0la?=
 =?utf-8?B?dytudDFHaGc5QWZBWTAyS2s5QkZXdnlsWGM2SG1CbGo5SjZqUVN6b1B5eCtp?=
 =?utf-8?B?aFRZSGtpeEhHbmVEYzI1citkeXZhZTRnOFhKUFJDMHhiZVVOam11TkxaMUhG?=
 =?utf-8?B?NXhoS1JKbGxrbDFFQVdCNHB0YnozblFlYmVqbXd6MWYrQ0NuWXo3VXFSSi9F?=
 =?utf-8?B?NUdQZW44N3hxTk1kSmVoN2ZROEhIOFNKdmp5UzUxRmJQQVVTN2RxUVhOaE5N?=
 =?utf-8?B?andOeHpOdlR4WFkrVER6eDN2RmhYV1FvaXZMeWtmY2JJeGJnYmpRcVZoR2tH?=
 =?utf-8?Q?wU/vwcve6L+jwZ2g9FQ8UCxi8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef30628d-5ee1-454e-4906-08ddd4b0c67d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 06:16:27.0578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhIfRCImweyVB4hBuHjOurbSIDXht8SF7wik6qu2pEo+VyJVyPTVc2WTQxi59ab83EMOke4Zxn/NiCdpK0zszw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7727



On 7/28/2025 12:17 PM, Mika Westerberg wrote:
> Hi,
> 
> On Tue, Jul 22, 2025 at 11:20:23PM +0530, Raju Rangoju wrote:
>> This patch series aims to update vendor properties for XDomain
>> dynamically for vendors like AMD, Intel and ASMedia.
> 
> The XDomain properties pretty much describe "software" not the underlying
> hardware so I don't understand why this is needed? We could have some USB
> IF registered Linux specific ID there but I don't see why this matters at
> all.

Currently, it is showing up as "Intel" on AMD host controllers during 
inter-domain connection. I suppose an alternative is to just call it 
"Linux" or "Linux Connection Manager" to ensure we accurately represent 
the connections across different systems.

I appreciate your guidance on this and suggestions you might have.

> 
>> Raju Rangoju (3):
>>    thunderbolt: Dynamically populate vendor properties for XDomain
>>    PCI: Add PCI vendor ID for ASMedia USB4 devices
>>    thunderbolt: Add vendor ASMedia in update_property_block for XDomain
>>
>>   drivers/thunderbolt/nvm.c     |  2 +-
>>   drivers/thunderbolt/xdomain.c | 32 +++++++++++++++++++++-----------
>>   include/linux/pci_ids.h       |  1 +
>>   3 files changed, 23 insertions(+), 12 deletions(-)
>>
>> -- 
>> 2.34.1


