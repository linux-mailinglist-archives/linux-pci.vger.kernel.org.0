Return-Path: <linux-pci+bounces-5116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D2C88AA43
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 17:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88F62E2173
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 16:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4952D28F5;
	Mon, 25 Mar 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TW9Wu0eL"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBEA86629;
	Mon, 25 Mar 2024 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379749; cv=fail; b=DHBlOA/X+YTajNnTJoGEiyORgXAHXqO7a2IsKcyX1JkTwErSd97J9mHPJl31j0DZ+6vGVvI3gzTH8V9C+0Ew6TLTmCqPZ+l6EHvsZvgwVxbzsGG0HmdhmqOnbFNRs8rZmqvFUU68yjyeUcmOCeHDzkd4EWXyej+upV7stldBwVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379749; c=relaxed/simple;
	bh=yE0H3bDVnXXcQsnJ1gBAiEbw3+ENly868S+xuk9j/cU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NkEuR/S1Bre45MO8gu3pqetq6uGAOMgKCnOHpBoPD/62M/jxkBldRBlGfirk3rCfTuZL5FfNOuIt3zInqraAGOHVp0HLBwmNi9r7tBurR9mgybmCF7rk5hPkjzrziJeWMPXl28sb9rgfxVP/4HO7nmIEHYa8myZHCN7ZVydApcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TW9Wu0eL; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/FnbdDth9l4BlwCLejVy5lLJIAE9CywBap9JV7y5HmWXlbNITVWt8cJHkVlus6T2fd4wEP7gPygv6xeDZLqqFlZ3QL5iwBkPhTG2HMu/ln0pcZi7acxw40yPhQ1/qt7jIcWdfmDSyGwpqzb0k9HxKOq19BOYuMFLD1wqHcroFtQ0YC7qPA08DLBvgOYj70bPJrPk4SoUxrsFUcUGaht8Fo+MK//N/OjVzrK7shuJ7sctZ8+E4DL4UmiroC+/hEcFZEeWMHZo8aYrNdSq0YtdcAtcfiVR40OP/95MRT50cbCQUgsAfx3E4tPCEAdf3kfdtCsKA/jAhNg8iU6CPvWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqtOCstPD/B6dLWFEbRbY2ey+Tto0A2Vqe7BNNGmni4=;
 b=MDcAHnTVamiKxzClrWSmeAO8v1DyywKbFrAWq5f2guHKSSaSy134IpnO/ogrxzsVKoTvDftSHkUzMglM7sdVVeWKjXTIDWiOMW1cllcRCLoaXhBWbVcTJhyQHtOBSgXZjLBHkzWsIZF7z01POMY3JEzvRgMOJf06Eq7r/dPXCZRCupXkOKg4mp7BwoLJ+j1QSoAO2BeER9CFkc8nPRDCPlxdmGeChxUsaOcl9tx4vykLzWNNVESXO2e2ttoTVgdul4v5dTAP4LCt4HnkY6Obh82SYnq/bnvN95L148ua1FRQma8jEH9R7Ur1mGZnjdfIvdV66s8Ac76rTzPmPqp3ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqtOCstPD/B6dLWFEbRbY2ey+Tto0A2Vqe7BNNGmni4=;
 b=TW9Wu0eLO7v10P93ZQyIpbyPsw+PrE+a66kJTqFv10t5AXQyyGlwKLusihncw+36NGHw98UjWJF/b3Mtu+ltoRCtr334nMmPBRzL2SW89VCTwtXdlQPplvqjlgCBdumvpawa/8W7RmZrpaloA8qmzfynf+PQrSWtytvF9X9xjpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 15:15:44 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06%5]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 15:15:37 +0000
Message-ID: <1287adbe-364f-431c-b33f-9d73e7829b6c@amd.com>
Date: Mon, 25 Mar 2024 10:15:30 -0500
User-Agent: Mozilla Thunderbird
From: Ben Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [RFC PATCH 0/6] Implement initial CXL Timeout & Isolation support
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 bhelgaas@google.com, linux-mm@kvack.org
References: <20240215194048.141411-1-Benjamin.Cheatham@amd.com>
 <65cea1bc6ac0c_5e9bf294ed@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
In-Reply-To: <65cea1bc6ac0c_5e9bf294ed@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:805:f2::41) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 711288e4-b53c-4e58-933f-08dc4cde6d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZSoGESBbFQrrgtR/SE1bpePy87RrHJ/LfJ2RHZklTrpFCKLG9zRK1Ilih7Zrz8x71bgHTuJDpP8GUEN4yxKoOXWscC4d4cyNMq7ioKXjAz4hn8QWLG/p6v4f8rsxt2CQY6SbXGqZ1CHOVpY1fRzm9QC2E4QrSNigFxdnUhmCTyeApX0oVqIg0xi7msVE3K2HZ10B8k8Ya9c1mt860I+beUVKZlnx0Oob2TclGuRkz/RmextdPNZjarUrpGkvaMdL63TE+NvUar/oAGVU800uCloOGrBN6SUaq6QJc0s6RJHklqxaSp/HSm8RbXdoguMG3vLtNWlv7HFWA6zd62xxWWykOMkiogL5q/q7lfsF/rKK63IV9nMpf7KBYnvQj8mpDdBAWsfSjlfZET40qnstqMrhtelzq6MxIiJ4bH59XMPN6eiNqBdzl5QsQXXtDDCVNNDU+gLVelk+psUxgFa1WKuEaLEajAPseFbhYrAncOS6X9DCStKSIynqxqZOrrHbbh8UsxjiWaDMOId0WYKQNvXqBaAw4QviWuviqTSiVPwYiKEgJoSmjVaMqcyfaLC0BP35heupRynZaUbdFT1RrcOYhGc/cHsoNOyuvZutqjPQErB56ndbuiB/8foPe5/dZCmTuyf8OY/2ACGkDuWbtbOj+r9L5cq2AVcZxv9coeg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bS9SNEs1TjJjVHdJOWhLUlA0UWt2TmFQWkpWRjRVaExpT016cG1GQXI4cmFR?=
 =?utf-8?B?Zmc2K0pFcTVBZGNvY1lMZVREYmVNOU5wTUVKTDVXVHNQRDZCdWxMWUt1eThm?=
 =?utf-8?B?MEprNXJTQW90WjBTdDZWWi9WQ0ZONlZNNjBqZVY3Nk9wVWtibTNHRmx5R3dx?=
 =?utf-8?B?SGpEOFZnOEgzTDFyb0Foczg0M1RCanZ6UlNXUHpTcytQOFdyckxLb2E1NVM2?=
 =?utf-8?B?VndXeW1qYyt2aE5CbTRjWlFudXl5bm5oaDR1N3ROMGRIbVpsVE4wYTZjV2hK?=
 =?utf-8?B?dFkrOUtlTExqSHV3SUszV2Q2aGU0TW1lK01KTXZXN3RGaFU4eGFBUjdEZkVO?=
 =?utf-8?B?QUh6blIwTUtJT0hHMEkvamVjbGFsUlR0MDdsOFZPQnc2UlJ6KzRORjJPV0FQ?=
 =?utf-8?B?bHpRMHZmbkVXUXpKMzg4Z2M3OGxNMFVJSUFXanVGYlRHTldVczFpL3pXWDZi?=
 =?utf-8?B?cTRpU1pEb0sxUlRoSmF0WDZIMG5kUHVBb2s3eGdRNVh0TzRoaEszRk8rVy96?=
 =?utf-8?B?My9STE03NFV1S2dVQnJISDFscEpiZVBVdFMyRUdJRmZZNThIbEhua3ZLT3ds?=
 =?utf-8?B?RWV0bnhVRTN3V2NtTUNRaGJ1MWJDcitmeFVmNlBwcS8zKzZzSURBbkNpaUV2?=
 =?utf-8?B?Qloza3dvVDhnMjR1NXdRNTNqUUthNCtWbS9aMVNlTmNtOWN0MllqWU1ISnJC?=
 =?utf-8?B?c2dWVHBiU0VNcVY5L2toT09iSzlsa0VvNU56d0EwbzBxKzNaaWVTaDRFeHlS?=
 =?utf-8?B?TGpJVzV6d2RvM1dYVmw4SGNzY0FSV0cxMFNkV0hVMUJNazJwTEVrNU9MWTRn?=
 =?utf-8?B?UGZvc0pVU29IeTl3eWVvWU9NS2RIbUdySTd4cjByd0hBdXpXVWpMNFJGcEJz?=
 =?utf-8?B?eGhvOCtQSTdqenpRWXI2UVUycXA2eFBkaDF3UTZJa0dqZWtKVlRDODVOcEVY?=
 =?utf-8?B?a2c5YlFoMUZXREJ1by8vdzc0eFRRajBWTmJIMFplMjdraWNFcDlqMm5GTExu?=
 =?utf-8?B?TS9jYkpRK2ttZ0hlODMzb01BRW5yaTFxWjViR1JZdEtnQjJIL1FLT2dHQWJt?=
 =?utf-8?B?bk4rZm01K1FYNE9uakxMNmVld3dXckJhcmZVQTlBYjFoWGJxdmJWV2tYMEJH?=
 =?utf-8?B?ZHNMWGo4b0dtZUE1ZWk1c0FIbFZuL1pRZHp0b3gxY0VVcTdPNUgwQXlsWmkr?=
 =?utf-8?B?dzB5aThneGlKRzc3UjRKb0Y5ZExWbDBYbVk4ZVNDZnZBOEwyTkJ2L0FtamtF?=
 =?utf-8?B?dTBQZ21XYmczRVFpSGoralA2VGhpR0ZSMmp4a21nRmFvZVVCd3NsV29xZW5M?=
 =?utf-8?B?bE5EcklCdUl3akxob3BhOXE2OTM3ajVhSVQxRXUxYXdac29nNzl5OWJqZE5D?=
 =?utf-8?B?cVZDZlpxNGw5RU9YUGEzM0RhcVpEYTFTZ3pheW9Ra0F0cmZER2tIZTdzak1Y?=
 =?utf-8?B?QWgybVI5TXlTd3hEMkVJVlVXSGtLTGdJQUVVUjV5M0Jha0twbUllcUI2Yk80?=
 =?utf-8?B?a0h1VmJzZ21Ka0s5UVZ2YWZiaUdQdjdyOXRpQXhsMncyVGdZd0Z0OFY1dFV1?=
 =?utf-8?B?b29BYlRpUGp1NmNkUERzdlYyMnVPM0VybWp6OXAwY2dZZnh0amNHYzZvdUE3?=
 =?utf-8?B?WS95b01XS09zZ2IzeXdERm52bndWeWhnSWI1K29IcWRXdVpvb00zZG1RS2Zl?=
 =?utf-8?B?QkMwRnpHSW1MYkh4RzlrRkdsem1vcjFaM1JVeE9CcFY3NExwckRsbzg0dElu?=
 =?utf-8?B?dGJ6d2RDQXByUjF2Mm5TZEc5alpFL1NjbmNSTDdQSHBrdDJuOGdIUkRSNnRS?=
 =?utf-8?B?ZkY2Z0dUQkRSc2ZvNm9zK2xHb28yU2t4Sy8wRDZ3VXQ5VmRlWDRLTlUwd1lo?=
 =?utf-8?B?cER4R1o3bThWZUNnWXBlWWJha3pSRWZsak45ZmxqWjh5a3REbkpPNVdMQ05q?=
 =?utf-8?B?NjhUTWVPN1Jqb1VzOGpKUVQvUTdFT3VwNzZwbjdSWkdDNWF4K0w5V0xuVHd2?=
 =?utf-8?B?VUFLNXEzNWI0R05yclJkbVpxTzViMzZoY1JKaG1ZczYzZzNqYkRIL2VLZ3pR?=
 =?utf-8?B?RGNzZ0tFQXIyZWJuVHVmWHVTZjNGZTdDTVN2YzhXWklSZFpobTRheDdEYTQr?=
 =?utf-8?Q?OucX3pr2vB38g0cX4lJ1CUM4v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711288e4-b53c-4e58-933f-08dc4cde6d17
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 15:15:37.8218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dua3mS6GHlQ8OjOi5lflf1sEHOfErxv7ztFFehskr8SnOhzscIaL7ARZQTke2i+9tPkoeCUHvZZsDJ4nbVYNSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867

Hey Dan,

Sorry that I went radio silent on this, I've been thinking about the approach to take
from here on out. More below!

On 2/15/24 5:43 PM, Dan Williams wrote:

[snip]

>> The series also introduces a PCIe port bus driver dependency on the CXL
>> core. I expect to be able to remove that when when my team submits
>> patches for a future rework of the PCIe port bus driver.
> 
> We have time to wait for that work to settle. Do not make the job harder
> in the near term by adding one more dependency to unwind.
> 

For sure, I'll withhold any work I do that touches the port bus driver
until that's sent upstream. I'll send anything that doesn't touch
the port driver, i.e. CXL region changes, as RFC as well.

[snip]

> So if someone says, "yes I can tolerate losing a root port at a time and
> I can tolerate deploying my workloads with userspace memory management,
> and this is preferable to a reboot", then maybe Linux should entertain
> CXL Error Isolation. Until such an end use case gains clear uptake it
> seems too early to worry about plumbing the notification mechanism.

So in my mind the primary use case for this feature is in a server/data center environment.
Losing a root port and the attached memory is definitely preferable to a reboot in this environment,
so I think that isolation would still be useful even if it isn't plug-and-play.

I agree with your assessment of what has to happen before we can make this feature work. From what I understand
these are the main requirements for making isolation work:
	1. The memory region can't be onlined as System RAM
	2. The region needs to be mapped as device-dax
	3. There need to be safeguards such that someone can't remap the region to System RAM with
	error isolation enabled (added by me)

Considering these all have to do with mm, I think that's a good place to start. What I'm thinking of starting with
is adding a module parameter (or config option) to enable isolation for CXL dax regions by default, as well as
a sysfs option for toggling error isolation for the CXL region. When the module parameter is specified, the CXL
region driver would create the region as a device-dax region by default instead of onlining the region as system RAM.
The sysfs would allow toggling error isolation for CXL regions that are already device-dax.

That would cover requirements 1 & 2, but would still allow someone to reconfigure the region as a system RAM region
with error isolation still enabled using sysfs/daxctl. To make sure the this doesn't happen, my plan is to have the
CXL region driver automatically disable error isolation when the underlying memory region is going offline, then
check to make sure the memory isn't onlined as System RAM before re-enabling isolation.

So, with that in mind, isolation would most likely go from something that is enabled by default when compiled in to a
feature for correctly-configured CXL regions that has to be enabled by the end user. If that is sounds good, here's
what my roadmap would be going forward:

	1. Enable creating device-dax mapped CXL regions by default
	2. Add support for checking a CXL region meets the requirements for enabling isolation (i.e. all devices in
	dax region(s) are device-dax)
	3. Add back in the error isolation enablement and notification mechanisms in this patch series

And then after those are in place:
	4. Add back in timeout mechanisms
	5. Recovery flows/support

I'll also be dropping CXL.cache support until there is more support. I'd like to hear your (or anyone else's) thoughts
on this!

Thanks,
Ben

