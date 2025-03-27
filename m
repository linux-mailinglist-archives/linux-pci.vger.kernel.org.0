Return-Path: <linux-pci+bounces-24874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A024A73A47
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 18:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43303B38B2
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87E0187332;
	Thu, 27 Mar 2025 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="be4Yz97F"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EEF1ACEDE;
	Thu, 27 Mar 2025 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743095870; cv=fail; b=qUKYmWUxuyh7UF6Vk4WJLPCjbxjafOfSPEVOAHEfhknVErcO7giTCLFzrQSjvic1ABeKkAKnc3LbTFPXIuQy16s3WbDw6RMMXm8ZvY8jLAg3Q96UleLbz3K30V+ZIHliMAMeVj91l62Opc0z6+AgUBujSxer4yLMVFSQsy6Pb/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743095870; c=relaxed/simple;
	bh=8WqKJu8v/O822s2LVMJWWBII3ypikTQslz6lHzbsFUo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YLPfK2uydplvEHkNAxr0aM0I3yRD8KMMRWjR6xylxdDFFhsP8tBmZ8VVZpsJI2z9P16D1Pf4ITVYJTnPwUoAgbBB4o1XdnSGlFeuWZfmSzk06aPXyUSPJk1/e5FZvckCUNIGXPKdF9MpbeI8jx/mViIB8nEFm+2xenv7EYBFnAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=be4Yz97F; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfWxee8az6P1GSbMK5EJqc7ydCUo1wBtrVrdz4tJsDEWKVkekDRKd5LkNNWqwgInESfGOKvmXApY/vTTElAzUvuFMZ5yt/g+eQWk52MFYVV4n6LE80mQk7brn2l88IXEI7z+7zdA/wWxge8+6JsRiQ3j0bv5hAjexQADQ9xEKgoxnGHZ3rhUmlDNMGNgf+2BTbfLMKWFmCv2Tlqz3A0V810LrMSreZqI2TK4NujGyQn8abSwJQCA1Ch7KjKTCSdROBJ5DgS2a7ZQTBQZSX9iB1cZH/sywiJL8JXLXwmv2uv8RnwcvuNDqmsRiyydg50ZxdltV8L06dI+GmeyVG6IJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WqKJu8v/O822s2LVMJWWBII3ypikTQslz6lHzbsFUo=;
 b=TY6v+8V64khN+TekIFBjFCkm8tW8Mjgn44zK7id/o0VJ4bpZulGTkXZvrFxwssCxSKu4iyH6PTcAqVNWPAmsWSbfP1xWMMXtrU0ktA1tqIoO2DWkvWablJxY7jKP95u2MqfSYGyJXWjc4D7kK6JebS39H4v8y2+//d0swpgpvOpzii74VPA4rIkJVQn0xCgXugXpEo4HHWurusmQ1pTYuutqRiJsyljv0+akMpjEK8VygMJQK/29UcSeiCDEZYiewhhRSV659Gti3b0C9zXqVHFiDlCrMclgafnXdSy1BSOJ1TMPHFGdJTa24UYjhVeZ2Ms1jtmZZPD2Aes6lQaHhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WqKJu8v/O822s2LVMJWWBII3ypikTQslz6lHzbsFUo=;
 b=be4Yz97FtXXQiEp3l1pz0/EFALlv4ZiwaUzzGPzQXIowe1+/s8VSd78yIXL0a+nd7lCrwdbPuqY7Dd0/xkgkWnbb9kH5DOqAXY2ihkaax7kn+cjvtPWWpLNjBoENfi3gq8u9U117RVCAT2wo8u6trXcJLARontFFc/iTYkRJqwE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DS7PR12MB5911.namprd12.prod.outlook.com (2603:10b6:8:7c::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.44; Thu, 27 Mar 2025 17:17:46 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 17:17:46 +0000
Message-ID: <9479341b-8e72-471e-84e4-55b91c7184e5@amd.com>
Date: Thu, 27 Mar 2025 12:17:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/16] PCI/AER: Modify AER driver logging to report CXL
 or PCIe bus error type
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-3-terry.bowman@amd.com>
 <67e583a6af077_160b72948b@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <67e583a6af077_160b72948b@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:806:27::26) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DS7PR12MB5911:EE_
X-MS-Office365-Filtering-Correlation-Id: decc834f-a4c3-4a16-d63f-08dd6d534ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG00N3diRkZTTkdwRlFreVIxZWJkYzAxd3F6Ujlxc2FSUlJaTFI3U3h3Ynhs?=
 =?utf-8?B?K0tHNnprcHhHcGdocjkvVXI2M244OVU5SUlRTTJnREsvaTRzSVR1QUx0L3hu?=
 =?utf-8?B?SENWM0E2MldIYXoyZXkva1VVbUh5WURQR3NncTNOeGptVnRPQVlQZGxTRUVO?=
 =?utf-8?B?ZG0yTzBtbFhGMnozV01GU3FrUDFLUTE5cnVGcXRwaWNNd0J3YWVnblBQRmln?=
 =?utf-8?B?VUswbk4rTVJoL1NVL3RRaDgrY0dOdTF3TC9UeVRlM091c25nWUVnbklPSDE3?=
 =?utf-8?B?c3pObHBvVkN0SnY0Vk9JYjFDWHh0R2s4Nk9ON0VXOGh1aEhPZWNHVWxwWVdq?=
 =?utf-8?B?MFphMWc5S0RUdnVKam5yVGJia2ExNXplU280TjMrSjRNM2liZ21HeFpXQ2xx?=
 =?utf-8?B?T1dScjdsRkxSYmFrODRIVjBwN2RBc3RORlBJKzl6ZlVPQ2JJYU9xQUU5RGYw?=
 =?utf-8?B?U3FsSUp4cTVaZlcwVHk5ellrVGs2T2pjdXBZY2lkaU5pckRINFVzeUhOQU53?=
 =?utf-8?B?MUQxMDk2aTByaXlsdlFheENhczNEdFd3UmRGSFNKZzhuUFdqTlZvQmlHVTI2?=
 =?utf-8?B?UTVxK3B0SzVodWpTNjFWRXcwQWJSVXhTaFFiUjVzeUEzbVd3MjFKSHk3TzNh?=
 =?utf-8?B?b2cyekNNN2xQZWRDQWI4azVvQVJHSm1WRUtySlhCU2ZkL3FnZk5XYWMrTUp3?=
 =?utf-8?B?WkJFbGNKeEVlYlVJS21WVnJYUVZkOGZ6R3B3ZkZXZW15YmhrNmd3cEcxZVNl?=
 =?utf-8?B?K0E5OG9rK05JTVcwVmVKOTd4a2VPOHA1MURVUDJBT2FuWmw1cU9jQnpUK3dF?=
 =?utf-8?B?dENzZktIZnN0RUZ2dUFiKzNsZS9DWFhkaU5lWUw4RUlZS1FWWmxSTUl6SmMr?=
 =?utf-8?B?amFxbnl5cEZjUUhJWDhDZUE2dUtDaFZoR1hJZ1ZuS0phdzArTTdQRXNEb3F3?=
 =?utf-8?B?ZXNkVnZINnh5RU43akZMOEZlZ0src3B1NlhxNXIzM2tQc0hJT3ZCWExNb2hv?=
 =?utf-8?B?YjIzVk9NM1FmQmRtbVNYb3Y1SWw0Tjc3cTI4TGNoOEY0cWVVYkpBZDN3M29y?=
 =?utf-8?B?ZXBCbUFueU95NnpSbXNsMUJnMWpTd1RHeFEvRGlXMVNSUG04OVBhRjFEYVND?=
 =?utf-8?B?SWdKVHRlWW1kOFl1YlVRVjkwNHg1bHRGQXNvb3pqWmRwOVRMSHJMYnI0Q1hR?=
 =?utf-8?B?OHNkb0doRVZvemFlZkRHdkVnWDJDdFFmcy9SSWg4VEl6NFFWMjBxVTZCcWo4?=
 =?utf-8?B?KzZWSUZZUTVETGNnbUt0dnZ4N3Jvbm1EMW9NYm1HRnY0ZVdnVDF1VTM0ZURK?=
 =?utf-8?B?R2doNmJESEJRQ0U0enA4cnhqTDA1ZE82Ung2d2sxdkFVbUUyM0Q0eEFKcnlZ?=
 =?utf-8?B?MEhqeHBtT1lDbkd2TE5aZWlMVW5uNlBOVlpVc1VkYzk5T3Vqa3ZtL21xd0x4?=
 =?utf-8?B?U2J3YzNDdzBES0xVUGdET0pFakFSL205Ry9lN0toTER2aFEyaU8vTFFuZFNT?=
 =?utf-8?B?a1RUNnA2ZVJWTEs5d3FDMkRheUNES09GNnBLYk1FYmkrN213U2thQU02VjlG?=
 =?utf-8?B?d1lFWDk4S1BGSVpSRXdUajdyZDE1SHAwRUFKRCtTVVFrZC9MdVpwd1pWY0oy?=
 =?utf-8?B?YmpGR1c3VXcrck9BTkRkUU81N0YzNnR2Smw4YnpEOVBIbWw4WWllVkVFTHJm?=
 =?utf-8?B?L2VtQkdlUXFsQkNBeXNVK0dvUnVQZDFPRkZ1d0lmTldqd253OElFSndRazZQ?=
 =?utf-8?B?SG12N2ttRnpmRXg3Tmdpd1N0TGVnQmVDSmpVVk1oUU9URzZZaTlxb1ZoZE5F?=
 =?utf-8?B?bDk2aHU2c2dxWVF0RkNZK2FwM283cnlSa1dVeVRMRWEyTTZZdk9UOEF6NVpt?=
 =?utf-8?B?NE9jZ2NKMGEvYTBjV1pHUWRBN2JlTk9kWGVoQW43VEdaenJJRkh4Mkc1WXFp?=
 =?utf-8?Q?u+u4R18niZFlywbHtGpLPSk9Dj/7FQfw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzNDb0dHaEI3R2JsU0ZFMlFZYXZRYThrNC81TXlScTFxSVZsb0hXSU1zbHcw?=
 =?utf-8?B?NllMamRNVDBOSEtocjgxMkVnN3lnY3g5bTQ1TVdDejBoekFBVjlHVGNVSExv?=
 =?utf-8?B?SG1SeXVFcmhGUWtNc3AxMEI3RWdFdUFkWXVUejVCeXNZK09IL0dCUWtqTnZF?=
 =?utf-8?B?UDE2R3ZuakFGWlZrSjN0YVlCSis2a1paRWozME4vaTkyRGwwM2FwQ09COEpu?=
 =?utf-8?B?Y2h6NU5aWEJ4Z2pUbCtSMHVtc3BWNTgza3dOSmtoZG1kcnRINndvSXF4Q0Fi?=
 =?utf-8?B?TWpYSzlWV0pPMlFoNWVkZVMyTkF4L0hkYWhldndKRW5TbHhFKy9BaUc0MzdH?=
 =?utf-8?B?SC9qczJCTzRRT2d3VSs1cEpyOUtVRzB6ajFnRjA5OUVnTEdoMW5rWk9DQWdG?=
 =?utf-8?B?RkNnRWVSZTViNks4WnBVaXFzQ0lDcE1aUWhzcHZHdHYxMW1tK3JUYjJNTHNR?=
 =?utf-8?B?UElXZFJERkErWDBKTUZqUG8xZGRoQVhyRFBDbUxuYWtXTlNzZ1hQbjlFYmlw?=
 =?utf-8?B?VTBOT1JPMUJ6dExBKzhFcngySWhobUdDT3JmVU4vTTlJTlkrampteDNMYmtK?=
 =?utf-8?B?NklURGFEeFpqQ2pMblBEL29uR29VTWtLZnlLcVFSRTJTMjlvb050YzdrV0ov?=
 =?utf-8?B?R0tieU5FOTM3cFd0bWgxem11c3Fxa093M0JFU2FhdFZLZ0dkTjNQbUs2cVl0?=
 =?utf-8?B?eENvcG1IZU9mMlJMSUloWEJhWmIrSDB4RkJmSThOQVFaQTJJbzhacG1hMVpB?=
 =?utf-8?B?MmVzUGxWY1NjRTBKbFZhNEM1NUd6QW5NUlYrVFdyVW1Kci82NXY4ZnRURW5z?=
 =?utf-8?B?UzZNcDBmb0ZQNlJzNUdrOTd5MXdjc3ZGdlp0QkRPWkR4OG5DOVZzZUVPUXU2?=
 =?utf-8?B?Q2EwSzdlSDRGa1JLK1AvU3lFb1A2NURrQTd2aEo2V2xvdy9GTzFPMEErVDd6?=
 =?utf-8?B?MkJjMThHSlFLZnBWcXhaS1NscGNKM0ZNRjlaamgxVWZJQ1J4MGp2aTRaWTRh?=
 =?utf-8?B?YVdFYlp2ZnczMU84dFlOenQ4Q05mUHYyR0M3R0UvQkRWTEhweWFuSmdiSHNH?=
 =?utf-8?B?SFVEdzh0RDRzZ0ozRTg5NENUQnZQSzd2N3U1M1g4YXZXalpDVEJkTUYrTmNS?=
 =?utf-8?B?V1BkajkzY0xNSC92aTA4eWhGU1RndkcyakJlMGU2eHF1T3o0MXRtK1d4cHRu?=
 =?utf-8?B?eFFCcHUwcmdxRTVjdENIWlluZ29BdWZQYm1ieU80TzA3NWkwM2xVYUpTNU9E?=
 =?utf-8?B?REVJbVBTNnVuRWpPeFU0VG1Qbk8wUFR2R2g5M3dQVmlCRGQ4dTZiTnEyTVlB?=
 =?utf-8?B?MnJ3L3NGSzN4Wm44c0I3SFc3RzMzUUltQ05TSGJ2WUt4aVlaVlA0RzRsK01O?=
 =?utf-8?B?c1lsSGNWekFEV1pwRVpzenYxRWEwOUVUUy9pVWtPWEtMcnp3R1ByUk1ydktI?=
 =?utf-8?B?Ulo2WGIzRHFoRVVBWnY1cmFkblZNSkR6bTlyWml5R3J5WkZrNC9uM2h1K2hD?=
 =?utf-8?B?Si9oV3N3V2JJd2dGdENDV1lROFZMd3IyZ0dRQ25YUXQ4Vnh1dEg2RGl2UEdW?=
 =?utf-8?B?czVtOC9PTEFaSGR0U3V3aXdRRjlyNXBScmtTQzQ0amJOZ2FOZHpUb3Bkdlls?=
 =?utf-8?B?anQ0YUs1N0FEd2VXSlZKQ3hzblJxU04xMGdBRGlmaXpLbnplTHVGTFhBamlO?=
 =?utf-8?B?WGRoMkhSenk3R3BYd0dmUmVPbnQvTENPQWhyM0JqWXhHR2J0b09GTHNGc09h?=
 =?utf-8?B?aUZMV1NVaDVoMkRqYXhIU1pzenE4R2NDSmo0Wm51REczQ3EwQTMyaXdRVTlW?=
 =?utf-8?B?Qm5tMXU5NXhuSEpNM21KZnBuQ0lDUXlNd21lcFFWeXpaRXFjNmljQTZoMHdX?=
 =?utf-8?B?VVpBUHBET1M3SXJqQ3MrNmFMb2EyU3ZGRWhBQ3VaSk94RG02Vy9OMSszWXJC?=
 =?utf-8?B?TXBsb1p6RElraW1CWXlacjY4TDFKVlUxQ1BzM0xybUxrb3c4bDdqbWJHaEZi?=
 =?utf-8?B?dGppZ2lYTGpWS1ZLMlVQNHpldTRtdzRQUkFBYzVLYU1OaFFsOTVtTkhoQmpC?=
 =?utf-8?B?T2ZqRUJNZzUvRERhY3c0L2w5bmJwbWpEYjNRRzRxL044SmZBUDE1clZzck9M?=
 =?utf-8?Q?hxbgQY6kjlYtB7SkFYND47/hb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decc834f-a4c3-4a16-d63f-08dd6d534ae8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 17:17:46.4846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7MI7xAZM1bN754mdSHpFMeiwYPxnIhXmxcmsc0IiA+nTXUgdl1XsYPQ6DkNsUa+x/GYB8XmSZ0jQ9N1mGunwCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5911



On 3/27/2025 11:58 AM, Ira Weiny wrote:
> Terry Bowman wrote:
>> The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
>> for all errors. Update the driver and aer_event tracing to log 'CXL Bus
>> Type' for CXL device errors.
>>
>> This requires the AER can identify and distinguish between PCIe errors and
>> CXL errors.
>>
>> Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
>> aer_get_device_error_info() and pci_print_aer().
>>
>> Update the aer_event trace routine to accept a bus type string parameter.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> I'm unsure how Karolina's new populate_aer_err_info() will get the new
> is_cxl flag.[1]

It looks like the Karolina's patchset and this will likely fall into the
same merge window. I will need to take a closer look and possibly make changes
for a simpler merge.

> Generally though this looks ok.
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>
> [1] https://lore.kernel.org/all/81c040d54209627de2d8b150822636b415834c7f.1742900213.git.karolina.stolarek@oracle.com/
>
> [snip]
Thanks Ira.

