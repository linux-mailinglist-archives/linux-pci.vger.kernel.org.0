Return-Path: <linux-pci+bounces-13139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A23179777B7
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 06:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07AE5B244C6
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 04:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C4E1459F7;
	Fri, 13 Sep 2024 04:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fF5tsow+"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034BF2F34;
	Fri, 13 Sep 2024 04:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726200742; cv=fail; b=uSpBtfWb67MPUfZOJkwTHJiTMx7jyxH+7NMbKlAAFEj7ggmbYQK276xvB7wucGOpE5K2zTFHdk66Zb2VVaEQTKa/5gT/7n0G+NmpDvS7mnFrCB+oFehpwlYvHjCVdTrkm6uIY/Lcet+zP4Ul5QtFndjzJ2OtUG3e+59NiTUdMMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726200742; c=relaxed/simple;
	bh=k3kq+w0a3D1pC0i9q/ObaQ9yaECOK7P/vxewtYyTsRc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t+8b/JKo/tE7rQtRAs37cbua2ZqVGELMURVHX2Ene1khVHRm0bIe25stWZOGVc+4wjvB4Ev3xrgToefLlnNufe709lJRodbXMJyvCFHHMC93K+dVTIGGjObv60K0yBxFbACxxIomQkmDVDSWRxflMvTDMqabJ2HV1Mu0Er/9sBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fF5tsow+; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9CTpWjqkLs2UiXVZlDpE25H6x8FuyPU7nT/QklkSKjPxoFOIQ5j5HhGNXcCamo1n1qgf8PTb5Yv4aSJolzOToE15VmET0sWIphWPeAGPHDBlaoMP+CdOcS8mk9ASAG5IaXDgYc5GxTAmv6oiir0wOje+BrpvQbCFmN7rTu2FMhH0r6OOG5y7Rq6AnF9xsS/5B19MgFjEmat6EYA509YnPzWRy241r9kPtWlQiA9eLGQQZk12wrBRWko3avkxLYCJrm6bFsW9eESikrvgnD91XDZ207jfF86cXx/fGT8WS1jIrvsL0awmkQB4otqgtYvUlJboHEPiKVN+vMboQKDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AcvuwUci+P6XXxHqOMXY70xh89b1aF+tCx7NdJfAFY=;
 b=SnUeaZe+53ttKhJ8bHPu4R1zun4rlD3qzShva5uNeGVDX6EdAlTEqlvNotisIUsxpcrrPkEP1WnLwU5BBuMzpWFtwdQAWJRBO//b0BFEoT+0girXNLdPxOGRuATrDaUOjJ7e7KAcLFc2qE4GqyfEOBd9tQl0kUMsFb63vhPifW+ztKGwV4Vq/mhktv+amnfJG8YFaWEEdIuTIBG1SkHTo84OxcH4y3TnxQQi62HIXurWpldeSVI1rbC/SGH364tC2+Ed0T7GicEG3yS5gIzfnqLRWlV0JcyWsKcI8lUGHrpYxpDHOCSAm1PuFwgRSCatd/NEhpoBG1OGqEG/jaSIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AcvuwUci+P6XXxHqOMXY70xh89b1aF+tCx7NdJfAFY=;
 b=fF5tsow+up1UuUDQ8luLctIg7X6au9n2cMI49F+v8apkSH+oANxU5740NvcvulorLvU/vbxx3MDScXqlrxVPvGAIkWdQu8/n4iLxXEdLg1Sr7QFbeOwin5hfJJe7hW+r/n+u62Q5XW0a5UIZmWU6myFLX/mEV7w/S447Y8TreSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 13 Sep
 2024 04:12:15 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%5]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 04:12:14 +0000
Message-ID: <66019fa3-2f02-4b03-9eb7-7b0bed0fd044@amd.com>
Date: Thu, 12 Sep 2024 23:12:11 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/5] PCI: Check PCI_PM_CTRL instead of PCI_COMMAND in
 pci_dev_wait()
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Gary Li <Gary.Li@amd.com>,
 Mario Limonciello <superm1@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20240903182509.GA260253@bhelgaas>
 <525214d1-793e-412c-b3b2-b7e20645b9cf@amd.com>
 <20240904120545.GF1532424@black.fi.intel.com>
 <2bf715fb-509b-4b00-a28d-1cc83c0bb588@amd.com>
 <20240905093325.GJ1532424@black.fi.intel.com>
 <b4237bef-809f-4d78-8a70-d962e7eb467b@amd.com>
 <20240910091329.GI275077@black.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240910091329.GI275077@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0007.prod.exchangelabs.com (2603:10b6:805:b6::20)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: a6d5a7ca-c462-46e9-a866-08dcd3aa3f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXZ5OE9xUmJVenFYaHpoTE1ySmJ1R21zTDZkUkdMZHR1MGd2eWcyOTBMRDZ6?=
 =?utf-8?B?QjVyem5QM0JGSTlRSDdQQ0VZUmtpaGNVUzlQZ3htNXYybm00VzdXTzdBdFB4?=
 =?utf-8?B?MzI2RW03ekdzd0lLYXZNckQyUkMrVDlDdzVWYUVDdTN0YnFsd3kvTE90Q1lD?=
 =?utf-8?B?eE1MQjJhVklBNU0xdWRsNjNWU3crdnpZMFBXVngwcEdaVmZSUHpSUXZGMWV6?=
 =?utf-8?B?QTBQNUVrTTlkU3BjemN0Z2lyYTZmL21Odnh1eDhJOGRwUlUwRU5mbllDSnFQ?=
 =?utf-8?B?eTNZc2NTK2FxS0xaZlVMRGVQMUNIZHkzRUNMSUUwQkxKSlkydEh5c0dQUjRx?=
 =?utf-8?B?akNHTEptQmlGVjAvUXVsMzNSUFI5K3RXUkhxM2Z1SHdrSXA1amtCR29ScFUx?=
 =?utf-8?B?VVk5Tm14MU91TEJIRWNuMkFCR1g0Zm40N3lmdmVUNVROYXc4RzZGV1lvZ29F?=
 =?utf-8?B?SHBSTW9oa3FhV0hjQUx6K2lmcFVzLzFWclVaeUxscE9mS2hhQ1ZKZ0F0QkNr?=
 =?utf-8?B?N3JpMmE4SWlTTXNELzlmcVFqL21kc0RvWmNMd3A5NVhqdTJiSWxwRW94R2Iz?=
 =?utf-8?B?bUJHM2pMeTBWZ2NyK1dqYlZ4Q2ZTVWVDTEVpQ213ZVpNVTR1Q3JyLzMweWkw?=
 =?utf-8?B?M3RGb0xDM01zaDQ0VnkxQU83WGdvRHRDQUJnUy9uaVhHcjUzeVFrM2xCTTYx?=
 =?utf-8?B?YStxdi9YM1lYVSsySXh2ZGJzbnBTaXhqQXBiejdXUXRvNVZSMkdPdlhmUi96?=
 =?utf-8?B?RnlES2I2WmRPRTdaSWIwangwVEVrMkxtVDAzSmRyWXBsaFRrRFR4QU02b2ky?=
 =?utf-8?B?K3gzVHR0Uk1TTUtiNHgydW9oSm1BRGJ1ZG1WbGNkaUFlL1lpelo3WU5WSDBM?=
 =?utf-8?B?M0xrY20ydGVLYzU1YUEvQ1lkMGRJdWRWVlN6NFRyMXY1aXVITFk3b0hXWDhG?=
 =?utf-8?B?K0dkUWd2aVUrMmNQZUh4K2lJdElqd3R2V2pmWUEyT1Y1UGh2MExKS215bGVQ?=
 =?utf-8?B?REJBeXFqLzJ1WWo1eU5BSld6Vm9FZk9DTmJKS2htSjNVUS9tR0hGdnpweDRO?=
 =?utf-8?B?Wk1CVkh1cnN3QzZqVUtLK0RGclJRZXRMREpqOWJIbFFxOGJNWWVBdHh2SkFk?=
 =?utf-8?B?UndoQngweko0YnoxYW94YUs4RG1KQ0V5Wjd6c0RVSDhHNHBEdklVazg3VkdC?=
 =?utf-8?B?NFRwN2greVNKUUppNUIwSklqdU9CdkJ4ZzV4OTRhM2FEd2d2R1F4anBZaktx?=
 =?utf-8?B?dlRnNmtGUXQvbTczdk81Q2RMTFZYZjdXUUNMclQzRURjMHVOcW54MjJjQW5M?=
 =?utf-8?B?SlM2RURjT3dGcUY3dk1XakVTUEpCT00rZXljTmZyQ3FWR2oxUjZIY29Cd1dO?=
 =?utf-8?B?NVh6Z0JZd29waEZrNC9CcytjQVYwK1lmYkhGbUpzb3E0WjlnTklRcVFpZmlV?=
 =?utf-8?B?TXBXZERRa2o4U2F3Ung0Z244Tm9DYkZXMFFyaVJDcGNJeDlwaG1vZ0hFdGpZ?=
 =?utf-8?B?V0dqaEt5YWFqQkhzK3BhRzN1K0dvU2lvTG01cXdVOEY1ZnVJcnBqd0RvQ0hl?=
 =?utf-8?B?enNBZ29PVzYxeFZHcjI1UnpCVWNubVBleHVsNlBiZnRoRUNhSGNORCtIQkdB?=
 =?utf-8?B?dFplTkZCd1ErcEFyaVZmTlM4SlJ3ZzBQTGdxNVhyd3l0NmlaVFhHSTBubCt3?=
 =?utf-8?B?TVgyVXV3WldObWx0WDlTUnhENE1hS3ZONEhXS1NwbEQ0d1JFUzYvWVB5Nkov?=
 =?utf-8?Q?ugmXv74VuzLzuWMHKdDpRPWOwrZ7WlfBwxnS1Ci?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blk5R0w4dlhQa3VUSkRnSDJxc3JhU1ZmaFN4bFpJSG8xeDRpd3hiVG9UdXUv?=
 =?utf-8?B?Wmpkd0VTNWZyT09EV3h4OWZIb21oUmx4bUh0M0srNHdRS3puc1B0ejByV3hn?=
 =?utf-8?B?TjRUcks1bXJISG9HT3VhY0JZV2tIUXlCU2dFeVc1clJyYXVFeG02d3hmVlo4?=
 =?utf-8?B?NnFTc3U4UWVZbEIrT2hja2xNQmpiekluN1pBbldwTW50UTlSUXh0MVhsK1J6?=
 =?utf-8?B?TjFPaU5UajB5MFZFVTVwSFJLM1YxcjVudmZ1Q0ZSOU5EL0JuNDZzREJHYjhh?=
 =?utf-8?B?VmIwcG1idGYwRENlNEtwZnhwbDBIUmJ4SFBpZlR4Zm1LdnI1aTN1b0RJYW4r?=
 =?utf-8?B?dTd2TldReTA2SlZaRFI4RnBydUJ6TnZyZ1lOd0wzUzlldndJcTl1NlpUalFy?=
 =?utf-8?B?dGJNSzZRWTVpaTRRTUtwbEczVUFURWlkeWZjc2hKTXdlVU5NSUJYV2lwOTZX?=
 =?utf-8?B?UGlrZit4eGsydmNyWGNKd2Y5SGR2OHE5a3NvWloraUNCMnZSVlF0NFlJci9T?=
 =?utf-8?B?QVF3MkZGblVSbU05TXJEbE5mc2NSZ2ltWE5zTkdtckNxNk5WNGRIMzlhSTlk?=
 =?utf-8?B?c21sMXU3ejYybnkzUnY2NWFKeldlNzk2eGRpK3BaeXJBSDlGemFRNGlIY0Vw?=
 =?utf-8?B?clFwK0dCOURiKzNVYVJnZC80RG8yR3lGTXVjZ3BqUFg5YUxxREF3YmNRUENO?=
 =?utf-8?B?QXRmbHpqWkJBM1FTQkZ4Q2lXbFU4V3ZqYitNQy9Eckhqam01UkZEMzlZQ1M1?=
 =?utf-8?B?ZFJvdGwyRmc2VHpFT0tlVzRxWDliNjZLc2dINHVTc0VqKy84MUpWVGRSdXJK?=
 =?utf-8?B?U1MzWSsvV0EwOC9uaWlEZjNWdEFhQmw3ZlJTbFdldEFwTDZCWDE2UWhjMWRr?=
 =?utf-8?B?RjNHbzlScENTVW8xZ0dGdUpuOW4xU3c5YlpldWZ0eU1HVjF5YnNiYzhaVVJ5?=
 =?utf-8?B?Qk5kdlBmRXM4SkcvYmhCN1h3MEFFVW5QTzAwdnZmTlhlNkVOS2pkaWZZVW1D?=
 =?utf-8?B?dFo0MVA5Tm9CQU5WS2hUY3g2eSt2VEhWdVpRMDlOSjdoYXl2ZVlQQmYzQkVW?=
 =?utf-8?B?bWgvVWFuTmN6US9zS2VHTXpiZlM1V0tYcEtDdUZ6QUIxcUQ3aFBJKzhpL0tp?=
 =?utf-8?B?dEhBMzMvNytNSnlzbEV4ZUpDV3hPMFU4UzRrWlFEck9rV29PNW1LcHhPam1t?=
 =?utf-8?B?U2phT1FxTThZNjc2dS8vcStQRVdNMjZ5enFQN2NkWGVEam5adTVGdmxXZUdm?=
 =?utf-8?B?dSt4V2d6dFFrRE92dGUraElQOTVsMkdhUUZLMVllSm9qSmhSVGNOTndpSWV1?=
 =?utf-8?B?Y0I0UDZSZjI5cVVnUTk0SmdZd3NQaEE1aDZOUDVZb3JQNmEyeTM3blpIRkk5?=
 =?utf-8?B?QVVFdzBGOFdjYmluRUNGN2Y4ck5waE9wRTk1QTE5R0FKcm9iTm9KVVdPZURO?=
 =?utf-8?B?c0MyU1VnN3piNlZMT2x1eHNuMHdxNUp2elN5eTEvcW9OTmU4YXZaa0Z3bDYv?=
 =?utf-8?B?SHZ0ZWowOHYzVzl5S1Y0TDZ4SW55amxXT0E0YVdlQjBiMWlXY2d1YWNjVmpt?=
 =?utf-8?B?bmFiUU1QdTJ3bHFUaDNFVkZ4YjhiVG1HM3JVUlkzdGZVYTU2L2t2Vmp2dERk?=
 =?utf-8?B?aGZKT0JXaSs2ZXg5MXdJMVVnQnhQLzV0ZS8vdG9jQ0Z2ZENsRkdnV0RxNjBC?=
 =?utf-8?B?ZXpFUkJOampPckpCRk90NUorK2phR2FkUHA5bm10YkpZZEZYNmlUS3NPalBn?=
 =?utf-8?B?dmgxWWRTTFA4eUI2YUxzQUFDcTQxWjkwUW96K2RuQVcxbDd2M2FRWVk1T01T?=
 =?utf-8?B?RHpQYk1IQmdhbktDZjVFVk5SWW02KzBJZytiQmlkNDc0MnVPZ0kxZFNhd0RZ?=
 =?utf-8?B?SW1LVkdwdU5BRTFWTmNNd0VWN0V0V2YvdzY0OEFZWTlubGJ1MzFETGw4eGR6?=
 =?utf-8?B?a2NlTlRCMWhWZVJPOUdWc1oxVnA4SW1ob3RZeEVhTmlUcW9mRlFOK1FiK2wv?=
 =?utf-8?B?U3U2YUF2bWdmc09Kb3FvWExjaEFKeWpHcGUwMXRRd1p5TVZ2TTdpQzRtSTM1?=
 =?utf-8?B?RUV3R0prczJWTlNOSlZIVTY1YkNwRTZXM05JM2J1azgyaHZnWGJNY3VrcXJZ?=
 =?utf-8?Q?rza5FcIbVu2fRS4g7ScXW0H3X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d5a7ca-c462-46e9-a866-08dcd3aa3f9d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 04:12:14.6659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aDVLIkQczdvqLbrdZh5htMLdeukmaZg12liqBinjAzUQo80VVposdCUKq6y/E0c9bsuEHTlmBzzbRIoTF1FSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354

On 9/10/2024 04:13, Mika Westerberg wrote:
> Hi,
> 
> On Mon, Sep 09, 2024 at 03:40:54PM -0500, Mario Limonciello wrote:
>>> Few additional side paths here, though. This is supposed to work so that
>>> once the host router sleep bit is set the driver is supposed to allow
>>> the domain to enter sleep (e.g it should not be waken up before it is
>>> fully transitioned). That's what we do:
>>>
>>> 1. All tunneled PCIe Root/Downstream ports are in D3.
>>> 2. All tunneled USB 3.x ports are in U3.
>>> 3. No DisplayPort is tunneled.
>>> 4. Thunderbolt driver enables wakes.
>>> 5. Thunderbolt driver writes sleep ready bit of the host router.
>>> 6. Thunderbolt driver runtime suspend is complete.
>>> 7. ACPI method is called (_PS3 or _PR3.OFF) that will trigger the "Sleep
>>> Event".
>>>
>>> If between 5 and 7 there is device connected, it should not "abort" the
>>> sequence. Unfortunately this is not explict in the USB4 spec but the
>>> connection manager guide has similar note. Even if the connect happens
>>> there the "Sleep Event" should happen but after that it can trigger
>>> normal wakeup which will then bring everything back.
>>>
>>> Would it be possible to enable tracing around these steps so that we
>>> could see if there is hotplug notification somewhere there that is not
>>> expected? Here are instructions how to get pretty accurate trace:
>>>
>>> https://github.com/intel/tbtools?tab=readme-ov-file#tracing
>>>
>>> Please also take full dmesg.
>>
>> Sure, here is the dmesg with tracing enabled:
>>
>> https://gist.github.com/superm1/5186e0023c8a5d2ecd75c50fd2168308
> 
> Thanks! I meant also enable control channel tracing as explained in the
> above linked page so we could maybe see the hotplug packet coming from
> the lane adapter too. Anyhow,
> 
> [  560.789681] thunderbolt 0-2: device disconnected
> [  560.789771] thunderbolt 0000:e5:00.5: bandwidth consumption changed, re-calculating estimated bandwidth
> [  560.789775] thunderbolt 0000:e5:00.5: bandwidth re-calculation done
> [  560.789778] thunderbolt 0000:e5:00.5: looking for DP IN <-> DP OUT pairs:
> [  560.789800] thunderbolt 0000:e5:00.5: 0:6: DP IN available
> [  560.789803] thunderbolt 0000:e5:00.5: 0:6: no suitable DP OUT adapter available, not tunneling
> [  560.790484] thunderbolt 0000:e5:00.5: 0:7: DP IN available
> [  560.790487] thunderbolt 0000:e5:00.5: 0:7: no suitable DP OUT adapter available, not tunneling
> ...
> [  578.677640] thunderbolt 0000:e5:00.5: nhi_runtime_suspend() - enter, pdev->current_state = 0
> [  578.677648] thunderbolt 0000:e5:00.5: 0: suspending switch
> [  578.677653] thunderbolt 0000:e5:00.5: 0: enabling wakeup: 0x3f
> [  578.678248] thunderbolt 0000:e5:00.5: stopping RX ring 0
> [  578.678256] thunderbolt 0000:e5:00.5: disabling interrupt at register 0x38200 bit 3 (0x9 -> 0x1)
> [  578.678272] thunderbolt 0000:e5:00.5: stopping TX ring 0
> [  578.678277] thunderbolt 0000:e5:00.5: disabling interrupt at register 0x38200 bit 0 (0x1 -> 0x0)
> [  578.678287] thunderbolt 0000:e5:00.5: control channel stopped
> ...
> pci_pm_runtime_resume()
>    pci_pm_default_resume_early(pci_dev);
>      pci_pm_power_up_and_verify_state(pci_dev);
>        pci_power_up(pci_dev);
>          platform_pci_set_power_state(dev, PCI_D0);
> 	// here we should see acpi_pci_set_power_state() printing "xxx: power
> 	// state changed by ACPI to D0" but we don't.
> 	//
> 	// also pdev->current_state is set to PCI_D0
>        pci_update_current_state(pci_dev, PCI_D0);
>          // this one reads it back, it should be 0..
>    pm->runtime_resume(dev);
>      nhi_runtime_resume(dev)
> [  578.773503] thunderbolt 0000:e5:00.5: nhi_runtime_resume() - enter, pdev->current_state = 3
> 
> // .. but it is not. It seems to be powered off, D3cold.
> 
> [  578.773516] thunderbolt 0000:e5:00.5: control channel starting...
> [  578.773518] thunderbolt 0000:e5:00.5: starting TX ring 0
> [  578.773524] thunderbolt 0000:e5:00.5: enabling interrupt at register 0x38200 bit 0 (0xffffffff -> 0xffffffff)
> 
> // As here too.
> 
> It would be interesting to see what ACPI does here, I mean enabling
> dynamic debugging of acpi_device_set_power() and friends. 

Here is a log with dyndbg turned up.
https://gist.github.com/superm1/2f7ca6123431365d11e9bc3cc9329c14

You can see firmware node \_SB_.PCI0.BUSC.NHI0 is physical device 
0000:e5:00.5.

> One suspect is
> that when the runtime suspends happens, the power resource or _PS3()
> gets called to put the device into D3cold and it has some sort of
> Sleep() inside. This allows the OS to relese the CPU to do other things
> too according to ACPI spec (and Linux does this) so now when you plug in
> the device the GPE triggers wake and Linux starts processing that one.
> We see the above runtime resume but then the Sleep() in the _PS3()
> completes and cuts the power from the NHI while we are in the middle of
> resuming it already (or something along those lines).
> 
> We saw similar "context switch" happening when PCIe L2 failed, BIOS
> implemented the timeout using Sleep() that allowed Linux to process
> other things which resulted unexpected wake (not the same as here
> though).
> 
> So one thing to check too is how the ACPI methods get called and
> especially if they somehow end up messing with each other.

At least to me it looks pretty straightforward that each D0 sequence is 
going through and nothing looked out of order:

acpi_pci_set_power_state()
->acpi_device_set_power()
->->acpi_dev_pm_explicit_set()


There is a Sleep() call in M232() which is a SMI used in both _PS0 and 
_PS3, but as far as I can tell it's not actually called as the case 
always has zero as an argument.

Here's some snippets of ASL from the NHI0 device to see.
https://gist.github.com/superm1/32ef1f822a6220a41b19574024717f79

I feel your theory is right about it being an aborted D3cold request, 
but I don't believe it's from concurrency issue of _PS3.  I feel there 
isn't any guard rails either in Linux or the AML for ensuring that
the transition actually finished.


