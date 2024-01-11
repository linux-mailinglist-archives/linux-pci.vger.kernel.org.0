Return-Path: <linux-pci+bounces-2018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403CF82A610
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 03:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EAC21C230E3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 02:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBCE19C;
	Thu, 11 Jan 2024 02:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xoMB0HBR"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC84C8D;
	Thu, 11 Jan 2024 02:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lG7h1uYYODkYvZE6G2zd22C8vsEbqRU87z5ftf5nDN6e1NYvHP7McjYbEDEU9s9orSEE/l1Si6ORdkxSpb1JZyhXzqhjcl6bK8WtD/S6eai+ITKGW3MrOe9HzLPSzLIjI5PXApCPykm7ApMkmCBF7MDg2aTSrNPla4VQ1zX8lFy+QAWyps+n6xuq9RkJKCuHLXfZaoco+x6uWXfzd/72vh3QqfLdtMH1BokjfsRWR4Kux6OC8rzrVpCORoxiTWHOM5WJw3zVlcJBrGqDSeLfXKAONt6s8JN+aRO+nl64Uj1vatoxS2btIqzgaEyoSKEjTleDqX+JvPyVuuo3mzyoCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYPUSwuSxTFxcRF7Zx1aU1KGn2LNvbhYYgD/cJ4QTDo=;
 b=dCHEK/Eza9qTe4U8+j6EUol7Ik1a95m+qwE2UTlDbBKze5oi7PejTpazBAzymH1pBETGfxV82MA0i6zRCOU1iipc5eBRHoPUKWPYVg9hpTJ00n+kTUcV0q0qj1sDmC1URlpSFI6LeuFb/Q//PBWXdG1pVZbO8i0NNcRHafLYY4GP4p3mbCuBkjqm0kSRm33To9UOxgwOr4pQATlPW/lQN1G8YOmZRfhQ04hCtIA5nNnaAWYEn56XbAZZcl1yrukUoD07YB8Iip6PHbCyxjNs1FQUP/swi541mnp389XJ9RU6S3bF3g7Iq7vA9d3oF+/5sderUtST3iVzAiJuGmKodg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYPUSwuSxTFxcRF7Zx1aU1KGn2LNvbhYYgD/cJ4QTDo=;
 b=xoMB0HBRkRJ92RaCwhHC4DoOblUCwOTwSQXUdKvbMSXN+YN+C9k8w2xUoFj6nSGQxHaKdqaYnpP7NRaK5hfGP8AN7Nhfo2BbICWOIAc3iHC0UozXJ0WYgyfdAYs3SSIGFtg9uNF79swRRYyzyt4z1Ym88lg8sV5tMRMmvdUc6T0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 02:33:09 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079%7]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 02:33:07 +0000
Message-ID: <08fea0a5-ddbd-ba7a-9e13-fc811b065b90@amd.com>
Date: Thu, 11 Jan 2024 08:02:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: =?UTF-8?Q?Re=3a_=5bbugzilla-daemon=40kernel=2eorg=3a_=5bBug_218360?=
 =?UTF-8?Q?=5d_New=3a_Disk_drive_of_TBT3/USB4_storage_device_can=e2=80=99t_s?=
 =?UTF-8?Q?how_up_if_connecting_behind_TBT3_dock_or_some_USB4_docks_DFP_TBT_?=
 =?UTF-8?Q?port=5d?=
To: Bjorn Helgaas <helgaas@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sanath S <Sanath.S@amd.com>, shyam-sundar.s-k@amd.com,
 Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240110190021.GA2113949@bhelgaas>
Content-Language: en-US
From: Sanath S <sanaths2@amd.com>
In-Reply-To: <20240110190021.GA2113949@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::13) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|MN2PR12MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: bad4fbf0-9341-43c3-dd6b-08dc124da557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gQ/b7DhxbPBfB3hQnojbm3LTdpu6ehJWpXD5wMjd9plr3SGrY7QrT4oBI6zlrkSUjXuebhz5XpZn/w10nvlKaWJKDnLGejRHs51irRpiBq+7zU38/c53Mwhhd+37/lU+E4KysdpNfbyUZvg+OX5golXqwXU/YveKe/M/tBpS1X4VUyjvNLwC4vRatLZLdoCTeYaNfsjvaD8ABZoJjQoUfvTb/JT9Q4GxFTzTTgHnTVp/HCdDI6Qsxr4+21HfIDoHvOzaChZcwAU25V3kLX5X5WruNeQ+cXb1F0nBiwcDdDCkLmMBarBMTJQPVF6HpO16UTDPjwtiv8ugbSq356+mrel8xoURTvbgro71yAPS8DQPlpT1FQ35GeBDG8kFF1PjydS4Gq3YtwGi3Ixu3eMwhDHFNFwX6SMNZvFytqRT8ppUvyVMff6Ax/d7iq4j2jmXR8NWAsqMXvYqOO8g4ka/vjdW4Lp1Z8IQQenX/gmwQSNITSdirkhbx5OfTU7WRwr7d3CvS+q/nCOkEVrm0mdi39SZj3DlsnAroJA2/ILrKz4ftprhtukL5FMgRzw+wAk+MZLRIRYg8SHsk4pTFMXMMd7gt17XS2WuJL47aChBuF+zp39Ne+UvrDpXKHl9qKXDUr8PVJWQmX/JrE5Eh1JW8s8lo4zoOcoAQX6Imx5UUO4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(376002)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(83380400001)(6512007)(6486002)(2616005)(26005)(38100700002)(6506007)(4326008)(53546011)(5660300002)(66946007)(966005)(54906003)(478600001)(6666004)(8936002)(316002)(110136005)(66476007)(66556008)(2906002)(41300700001)(36756003)(31696002)(31686004)(66899024)(45980500001)(220923002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjJlU212R05EYzFlbUxRRlM1VFFWSHd5WTZWQmNCSUo0RnlhL2V5azQrazZu?=
 =?utf-8?B?TVhFbGhUa1FOenZhY3BSL2JmTTNQRjlndm5KdkdnUUdhcUFjNHlzV0xSS0Fk?=
 =?utf-8?B?bkE4SHI0bXVMVVBZdFVrUkg0SFVUUElIcTYrZWtDaFNCNEdTNVB1aGJORkt4?=
 =?utf-8?B?Um9qZEQ0eGdLdDBxL3IwVTFVVFcwcFVaNk9mdCtnUWVyR29CT1dtQ3F3TkE0?=
 =?utf-8?B?TGkyMnNKOHF6VUQzNlg4ZlRGeDQrS1RwdjY3U1Q0R09zaFl1REpkemI0OHc0?=
 =?utf-8?B?WEo2KzRKNk1iNUlDVVRSMy91YTVTdk5DWFpLK2EwSHczNUlCREVZdG5OZnJi?=
 =?utf-8?B?TTlQZVgveXJSRXErOW5WUmhESjFKYnRwNER3cnRPMndYL0dSMStncHRnQ3N2?=
 =?utf-8?B?clpkSEZhS0hhWDYxOEpGTXZZYXdhL0doblBGUWtFSlNsMXZVUDY4TGNZN1U4?=
 =?utf-8?B?bmR5aTI5WTBEN3U2dnpxTnVCdzBWK0JsVVNtSm0wK0ZqRUVNWThUakxSYXp2?=
 =?utf-8?B?OFdhYzY3TnFMYno1anVjTHM1UkFORW9hZzlLYnFETThxRklPakM1T3RRRUt0?=
 =?utf-8?B?Y1hKNDhsakZybGdOMnFtQkVOVE5kWGZJN2o1RFJWZ0hIQzQvbnlUQ0gyREk1?=
 =?utf-8?B?YlZmY1VZRmdpdzZoaWwyZDNJYzA1RS96anIvbnVLbSt5dFlnTWFjRGxRVzF2?=
 =?utf-8?B?K1J4dEU2ajFOWnFxMDZ5RG1vdWYxdVhZMkI3elowU1ZQMGN1MWtabXJISFZT?=
 =?utf-8?B?eDhnOGtIZVI1R01sS0drbDZuOGdpY1hNbzhoTVFwVXU0M3NJelovSkVFbkJP?=
 =?utf-8?B?a1JkOGM4Um5LdXZkQmE3cEp6dWVQOUVsdk8xSDEydFRSTWFHNzcwUmNFN3BZ?=
 =?utf-8?B?K3BuNFNMbStlTStWcEZNazhPVXdGKzlReVE4VDBHbDlabmhzL0Q3RUgrNWtB?=
 =?utf-8?B?ZEw3K2FKQ1dZbStRc2V0V2UyNytmcVNDSHcrRCs1ZllSUU5vQXFPZ3dROGNJ?=
 =?utf-8?B?UHZCSGFoaXQvek45SjdoNEptT2kxMGcyWVN4K0tFVVh3cVZJZGhseXhpTFZC?=
 =?utf-8?B?cVQ4UE44V2ZqS0VhRThXNUMyTWFpY3gxVTB1YTBOYkVHVXdmV0d3cXg3bjBJ?=
 =?utf-8?B?T1orUndJL0JtdUZqMzVYR0cxYVR6T0k1WkVCcWRyc3pEcmZUVWxvTXgzRG5Q?=
 =?utf-8?B?VnBtVU8rMlJGRDhFbkNLQ2hpbTUrcEoyQ1ZIUjJyUWdVRzFUSUpRb09KUnpx?=
 =?utf-8?B?OXZvNmNoMzc1UXFMcnpzMkkwNGZ2U0h2ajIyTWMxSWxadmRBdUpFbXoyRTlQ?=
 =?utf-8?B?WjM4RUdNUyttOWl0ajhLUzZCVmlaaUlDemFPUGRNejBHQWZnMU1uTEw2bDZn?=
 =?utf-8?B?TFBBOXNETEZMNWZJdStNV3lqQUgxdzQrUm5TOHgxQ1kyS29vandiS1U0YWND?=
 =?utf-8?B?dElDcDFFby91SlVWMjFxV2J0WlpWMU9CM1RhaWZIM2JhMGFOU200elJTTzAx?=
 =?utf-8?B?MEg1MjQ3UWRoWVFEdlhsaDZSbHRyMkVVVG9KNXFwQTBIVDk3ZnZsZ1ZFMEZ2?=
 =?utf-8?B?UWhodVcrZnJoKzFyc3RnSk5vYkswVXVTZFZESGF5VU5XNlYrUVk0VXoxd0Zq?=
 =?utf-8?B?S1RGNGgvK2l5ZlNwRzUxaDNDcEFKMzZYWW43bkZUN3dBQmRXczhDUGNZYm5P?=
 =?utf-8?B?ZU4vZHAvWFRqUitxM0UyK2l0MzM4clluZzVkSUdQVkxaSzl4Z0xpYUcweUpM?=
 =?utf-8?B?ejNUYVh1OTdUa3dDOGZUK0l2eWp4aS9YZFBDdENtUVQwaTZpd3NjVlVTcFph?=
 =?utf-8?B?Q3FkSFRHRXpWWjVnU25pWWtpVldqNm56eTdJL3E1ZFJXcVBWWjJBbURNMHh2?=
 =?utf-8?B?eXkraGNwNWRvbXJRRjllR1NxQ1laWUd2S0VUT1o1WGowSjVGWUVhNTNHSVJL?=
 =?utf-8?B?Q0IwbktBT1RnWnRJQzIrYU5nVlFQODBWVmhxUEZtSHpGTGdIbDBOZGViamor?=
 =?utf-8?B?MHNPS0I3UW5aWGFBYWMvTFRPMldaNVpaWWtnQW9QS013VGRvNzcxWHArWTQw?=
 =?utf-8?B?WFF0VXF2VkJQK3krOU9DUDNaWm10OTd0c0o5b1lWUERjZmpiWWUxNXdNZ3lj?=
 =?utf-8?Q?i3cH85GGEiSnoJkClHgYFgcts?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad4fbf0-9341-43c3-dd6b-08dc124da557
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 02:33:07.8841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgVDu1xVmdJPc9wjE+io7pxSUaOclPxr3FXt1uJJhhxOwfPJgH5rRoXk1286YlcMvst8evbT1+wIB5lq/9Rk3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125


On 1/11/2024 12:30 AM, Bjorn Helgaas wrote:
> #regzbot introduced: d3fcd7360338 ("PCI: Fix runtime PM race with PME polling")
>
> Sanath, thank you very much for this report and the bisection!
>
> I assume this happens on hot-adds, i.e., you boot the kernel, then
> connect a USB4 dock, then connect the TBT3/USB4 storage device to the
> dock?
Yes, correct.
> Would you be able to attach the complete dmesgs log from working and
> failing kernels?  The ideal would be from d3fcd7360338 ("PCI: Fix
> runtime PM race with PME polling"), which fails, and 5cd903bce9dd
> ("PCI/VPD: Add runtime power management to sysfs interface"), which
> presumably works.  But v6.7 and v6.5 is OK too.
Sure. I'll get that.
Do you want any debug to be enabled ?
> Also the output of "sudo lspci -vv", which I assume doesn't depend on
> which kernel you're running.
>
> Bjorn
>
> ----- Forwarded message from bugzilla-daemon@kernel.org -----
>
> Date: Wed, 10 Jan 2024 10:52:40 +0000
> From: bugzilla-daemon@kernel.org
> To: bjorn@helgaas.com
> Subject: [Bug 218360] New: Disk drive of TBT3/USB4 storage device can’t show up if connecting behind TBT3 dock
> 	or some USB4 docks DFP TBT port
> Message-ID: <bug-218360-41252@https.bugzilla.kernel.org/>
>
> https://bugzilla.kernel.org/show_bug.cgi?id=218360
>
>              Bug ID: 218360
>             Summary: Disk drive of TBT3/USB4 storage device can’t show up
>                      if connecting behind TBT3 dock or some USB4 docks DFP
>                      TBT port
>            Reporter: Sanath.S@amd.com
>
> The disk drive of the TBT3/USB4 storage device can’t show up behind TBT3 dock
> and some USB4 docks have a DFP TBT port.
>
> TBT3/USB4 storage device can be authorized, the disk drive doesn’t show up.
>
> Issue reproduce sequence: Connect USB4 dock to host → Connect TBT3/USB4 storage
> device to dock DFP TBT3 port → TBT3/USB4 storage device disk driver can’t show
> up.
>
> The issue was observed in the latest mainline kernel 6.7.
>
>
> Failing on all the below combination
>
> HP Thunderbolt Dock 120W G2 HSN-IX01
> HP Hook 2.0 USB4/TBT4 Dock (PV Phase)
> CalDigit TS3Plus+ Thunderbolt Station 3 Plus
> Dell Thunderbolt Dock – WD19TB

