Return-Path: <linux-pci+bounces-2026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AED882A701
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 05:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB3D1C23192
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 04:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC3417D4;
	Thu, 11 Jan 2024 04:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="avMxhOqA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2501FB0;
	Thu, 11 Jan 2024 04:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9NC9TrKd3Ag3Bq8OOs1fpfT6lu5md4arkHu3jnOuRmM0utp4BR5YQ4nZcquxi9h8awBRt/SiuoZpNGulEdB7Rtwhe3wyNb7YY1NWlIt98qj0ecpIgT3kZzvU/c1SjWx6WJ57in8VtZog5Ihu9GgWd3MGIkwlVuVFyJUrlfZFMIkZ8iQUhbz9gPcBe8A9JWgwfWlcBJ5LNxe248cMKsL6igBZIRM5Ye3TaaQPL9Rt7Ma7LAPlibYguDQkr7Yy8MiW7XSTJI0gz5S9n3YmCk6pObQQnSQeWnEgHfhueGOzXXjDU4v4hWkrduS9Cj2iuQi7Ojcr+VAY9XeGU28iDzjog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9FvC78Ie0mATK+Eb4NvBqQj8g3A8FsT8Pr8aaHE+m8=;
 b=NRiGZTT3sH1i3Ulk67ijEDSAnVkdoR+AlrsvVrkV8IharJGuODFHU2pON3/4zK90J6iApOXH/Ctm99u0aJdYlDOFotOAqT2Cdh53aeMHnXEmYGH7Mj1nGijnqI0liIAbwVo5W3+VAdhWYc0XgYZR9OtvZSpwuMu68DX8AW0FnktwLrasDN0Z6qcFeuLZTmcVzxwyAxfrIaySgxPf20N4ly3muk+q8y7l4qvjdjaFePsjQHOz4rbooFcGsZwhaHcInggcrlrKtYKRjveQNVKzbDqeHjwv3miDP6HDYbVfexMr9849UYWNA9WI5qm/RNW/fegHtn5D/ZqfS40hMrlkdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9FvC78Ie0mATK+Eb4NvBqQj8g3A8FsT8Pr8aaHE+m8=;
 b=avMxhOqAMxkVUtXEeJxpddQJYH7pNwhi28J/+AUywwkN/In21FEV+yK0DFk0Vm8GYItiP9i8eF/WNRPXmgIo+7GQow8m8J8cPpJrcE0hMYfhEWA83LhIl1c/+dSfqNTPGVxU8WPp/S2O7K+Q0CjM227QWtacClfzAasukHrvOac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Thu, 11 Jan
 2024 04:50:52 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::9906:988a:788:1079%7]) with mapi id 15.20.7181.018; Thu, 11 Jan 2024
 04:50:52 +0000
Message-ID: <8483b8ed-e0c8-e690-12b8-7e517989c3fc@amd.com>
Date: Thu, 11 Jan 2024 10:20:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: =?UTF-8?Q?Re=3a_=5bbugzilla-daemon=40kernel=2eorg=3a_=5bBug_218360?=
 =?UTF-8?Q?=5d_New=3a_Disk_drive_of_TBT3/USB4_storage_device_can=e2=80=99t_s?=
 =?UTF-8?Q?how_up_if_connecting_behind_TBT3_dock_or_some_USB4_docks_DFP_TBT_?=
 =?UTF-8?Q?port=5d?=
Content-Language: en-US
From: Sanath S <sanaths2@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sanath S <Sanath.S@amd.com>, shyam-sundar.s-k@amd.com,
 Andreas Noever <andreas.noever@gmail.com>,
 Michael Jamet <michael.jamet@intel.com>,
 Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240110190021.GA2113949@bhelgaas>
 <08fea0a5-ddbd-ba7a-9e13-fc811b065b90@amd.com>
In-Reply-To: <08fea0a5-ddbd-ba7a-9e13-fc811b065b90@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::31) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 71664b24-b492-4deb-5fd9-08dc1260e341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3B+vJ+bvYBMzMaIfxI3I2JFYxAbOUd3n5dafOptrAWTc0ayypBxaz5ur6Zr49AOHvShibyXxcIpPudknymBxW+ImOnHbjrSG073Qg+Erk2EIqbTPD4hks2I2I5fc2tKrWDHPZyL6ZlJyIB0UqBjKApm58g5mdn8TkSBIMYaZ/dXF9BOJ30ezb8QpfRoInxFmlSy17T3fgIpCvdpUpiRcP/IoFOuLR8D/QWsvrnFTcSrZ3ArLtIXsaCzONefLGTwTFsNWxgvJjUfsjZdsPWEADby/6q8cLMMC8D3RAC5CoaK5VBqSByWyIQkX+vBKgQybiOQz9AG3UFiHP5hwFKZ1PxngOQ0zVdWcj9ZLLv0nyh3bs0fFEvoUVJVY5wKAerE0q9S03KpJUkubfGRr88cnk/tyWVz/L63T3CX+2CrcGQ70N3hBmKkQBgxG+iI6X5nThsRxnvDLb+3xSdfWjRuLZAIcX7sJeY+I9910RvAZjK8a30F1CnD2rrGqJenZUp/5rXRiZ10CauFSM4kozhzzimkJ5xG7tclzxRWugSnstN6O08QcX/4fJfpxwec70ZB0JHFni8o7YcdleWWZ2HPVWWSArKxEgd8awaSh4HylTlS30umfAFdH060ehHhcmJXtHSMUjPacMhbAbLaWxflyxP1xX1fcylagBfsQnzCdHxc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(366004)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(66556008)(2616005)(26005)(110136005)(316002)(66476007)(54906003)(66946007)(8936002)(4326008)(966005)(83380400001)(6486002)(6512007)(6506007)(6666004)(53546011)(2906002)(5660300002)(478600001)(31686004)(66899024)(38100700002)(41300700001)(31696002)(36756003)(220923002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFNkYk45RDlmeGpEKy9XbWFtZlk3RlJiR3VzSmNETmR4S2w3amJsQUtrdEtP?=
 =?utf-8?B?WENNMHhPSlRRMzJPT2FyeCsycEIxTVhpZE5hKzNrNnZjWk5OR0NXdXBFeGJY?=
 =?utf-8?B?b1Z6TEZaQXpHbDdiVjllaTZxdUl4NHJlSjNvSDkwYjFoaTRFUWhIbHkwckhI?=
 =?utf-8?B?SnR5U1NRYXUrN29jRjF3WHlzcHZPb2RaODExeEVIay9kT0hBUXRKTWJ3cEM2?=
 =?utf-8?B?ekFFcFZXRW5JRm1aa2RpQXJmQkJLM05JMjRrZUFxRWtIN25iR0MweTZrbWVy?=
 =?utf-8?B?MjZsbmZOWjBUMi9TVW1JSjZCVkVvdUFMdVlSVmlKdktJZUhmdmJDbTI1K0gv?=
 =?utf-8?B?N29ZWW9acFdES2RWT0hQVloyVDVsUjJJV1ZzU24wUjRwb0g5NnVDMk1JMkNH?=
 =?utf-8?B?RlJHc1BVdUVzOVJHQkMyTGxiRlVFd0tndVRtWkwvMndCc2ZYaHN1aHJDekM4?=
 =?utf-8?B?S0NieXFVRkF6cUFiWW9DYzVacS8yTG9mbnZvWnBXQ3czemhZOUs0Y0oxUHE0?=
 =?utf-8?B?S05wZGYrQmVjSldYOWdZNmdDY3lCb1BtQUlTSDBlZVE2SUlCNzN0cjJyTGlF?=
 =?utf-8?B?dWNuS08xSkh5VzFMelFKWUh1LzdDWkVISVNRaW9RT2wwYWxHcTF2Q1gxelpC?=
 =?utf-8?B?eEtvcFpnQVVieVZrMjRDdHd3RjVUOG0ySFBwYjRMVjI1Rkx1WDJJdHdicWg4?=
 =?utf-8?B?QTR1VFJmK0tMSjE3NFh3RGhrMUwySzZIbVoxczFydjhNSDRFUDlXVWtvNmZD?=
 =?utf-8?B?bEhYMU9IOWJLWUFkYWNNUWpkay9mOExDanhFaWoyM3ZkQjZWajVuMHFvVmhO?=
 =?utf-8?B?TXZ3OGtLYVNZbVZNcmVPbHhXeGhxbW9lTjVZb2N3NFE5RUlhTVA1VFdwdEY5?=
 =?utf-8?B?TVVnbitNM1M5NWVEeVZWejdQdGw3UlFGTnAwU3RNMnNRU0puankySG9rRDJt?=
 =?utf-8?B?Y2FPdC9IdW9JMmNWVXFPVUs3cER4eThwdGYvK043UEZPeWk3dGdqd1pWajRQ?=
 =?utf-8?B?MzczZXFLc1B4NWtvby9xSCs1MDhRaGxDcE1BWXFMR05nUmduOWg4SGJ0K1h6?=
 =?utf-8?B?ckRINW0zWXEzbFNpY2pxVEhEbEpBU09FcWFMUktuY00rQzRXQXhqejEwUG91?=
 =?utf-8?B?Um03R3lrdHdvMlVBUmxBcVQydXNoRlZRV0R5WmhrTm5WdmlwZVVIOVhXeStC?=
 =?utf-8?B?R2pEVTNZbmx3M0dqRDJWQzhra1FYZWRJd2dWRCs3SUJDenZjZXZncUxLWFBi?=
 =?utf-8?B?d093N2dwREl3MlRGM2FMWTJqbkFhQ3JwSXg3dUJQbFRhekI3K0VWU3BWdDQr?=
 =?utf-8?B?SjJGWi9RU2lsOThLcGZJNzk2YS94Mnc5YjNyQU0yOEdzcHNVUjk2L3VURjR4?=
 =?utf-8?B?VXFETVFEMjIxdG95NTBzRzhlYW5uRHNVSGIxYU8vOS9DV0YzSXA4RVVFOHRm?=
 =?utf-8?B?TTVqL0JDY1BPN0tyQkM1WDR1eGNSUUJRSmVkTEswRURKZmxZdEU1MEE0WVh3?=
 =?utf-8?B?RVhJZHpkWmZFUWRFb3JOSEZDb1ArdGdXdzM3ZUVRYnplT1VBQW1lbkRPTnJK?=
 =?utf-8?B?dnVmVkloeFdXcDhONjliSUk0dGw2UjNqOEJYY1QvS0p0WTBZVzV2bmZqb1E3?=
 =?utf-8?B?NjB3dmRQYUxncDViZkcvek5od1NBcHhRYThyTUMrZG5GbWt1Wkw5d1l6VVI4?=
 =?utf-8?B?dFUzajRyWkRqa2FLUlZzalQ3OVlabGxEK3VxU0VFWWRPN0N3UEk1TEFXQkt5?=
 =?utf-8?B?WVpEZUg2aUx0dW1EdldTdTRhM1g2dGdla3ZKOXBodEc1M2NYLytERU5DSlBv?=
 =?utf-8?B?VndtcEVhT1pmRkhENTBkY0lEbDhyenR6WnRVODR2S3N1MWkzZmFLVVlYb01X?=
 =?utf-8?B?SXkveHlhYlRHUXpNbkhtTkpRUGtScitzSXFrMm9mMklkU0xnNURFWXpOODVG?=
 =?utf-8?B?M1V4MU5BaHFDcUVHY0JKanJPTlhzOFAydHFhdjBQZkNoWFdFRWdvcUxWRzhP?=
 =?utf-8?B?OGJBVmhXeFM0MnpmR3d2bktiWWIyQXhmVEdwQXVnL1lGeUdYY0tBYlgwelNO?=
 =?utf-8?B?ckhSL2xWTkxHNUdLZkFCQ2ovV0hYZFFNd1kvL09GS3hkem5ETUdIWExMWTlC?=
 =?utf-8?Q?QeDuzoqSOSaPo/pxHyr1Qo6VE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71664b24-b492-4deb-5fd9-08dc1260e341
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 04:50:52.1961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zzcc46mIKi+wCa4a7/egnHCf1uFF1MzdIr3UTfT46UX1VpgbP4HVo7N85k5RBeNxWForfRoyeKCafDWEvm8iFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821


On 1/11/2024 8:02 AM, Sanath S wrote:
>
> On 1/11/2024 12:30 AM, Bjorn Helgaas wrote:
>> #regzbot introduced: d3fcd7360338 ("PCI: Fix runtime PM race with PME 
>> polling")
>>
>> Sanath, thank you very much for this report and the bisection!
>>
>> I assume this happens on hot-adds, i.e., you boot the kernel, then
>> connect a USB4 dock, then connect the TBT3/USB4 storage device to the
>> dock?
> Yes, correct.
>> Would you be able to attach the complete dmesgs log from working and
>> failing kernels?  The ideal would be from d3fcd7360338 ("PCI: Fix
>> runtime PM race with PME polling"), which fails, and 5cd903bce9dd
>> ("PCI/VPD: Add runtime power management to sysfs interface"), which
>> presumably works.  But v6.7 and v6.5 is OK too.
> Sure. I'll get that.
> Do you want any debug to be enabled ?
Attached required logs and outputs on bugzilla
https://bugzilla.kernel.org/show_bug.cgi?id=218360
>> Also the output of "sudo lspci -vv", which I assume doesn't depend on
>> which kernel you're running.
>>
>> Bjorn
>>
>> ----- Forwarded message from bugzilla-daemon@kernel.org -----
>>
>> Date: Wed, 10 Jan 2024 10:52:40 +0000
>> From: bugzilla-daemon@kernel.org
>> To: bjorn@helgaas.com
>> Subject: [Bug 218360] New: Disk drive of TBT3/USB4 storage device 
>> can’t show up if connecting behind TBT3 dock
>>     or some USB4 docks DFP TBT port
>> Message-ID: <bug-218360-41252@https.bugzilla.kernel.org/>
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=218360
>>
>>              Bug ID: 218360
>>             Summary: Disk drive of TBT3/USB4 storage device can’t 
>> show up
>>                      if connecting behind TBT3 dock or some USB4 
>> docks DFP
>>                      TBT port
>>            Reporter: Sanath.S@amd.com
>>
>> The disk drive of the TBT3/USB4 storage device can’t show up behind 
>> TBT3 dock
>> and some USB4 docks have a DFP TBT port.
>>
>> TBT3/USB4 storage device can be authorized, the disk drive doesn’t 
>> show up.
>>
>> Issue reproduce sequence: Connect USB4 dock to host → Connect 
>> TBT3/USB4 storage
>> device to dock DFP TBT3 port → TBT3/USB4 storage device disk driver 
>> can’t show
>> up.
>>
>> The issue was observed in the latest mainline kernel 6.7.
>>
>>
>> Failing on all the below combination
>>
>> HP Thunderbolt Dock 120W G2 HSN-IX01
>> HP Hook 2.0 USB4/TBT4 Dock (PV Phase)
>> CalDigit TS3Plus+ Thunderbolt Station 3 Plus
>> Dell Thunderbolt Dock – WD19TB

