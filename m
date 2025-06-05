Return-Path: <linux-pci+bounces-29034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9577ACF182
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 16:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D9137A7526
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 14:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D13272E41;
	Thu,  5 Jun 2025 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D+ARWFGQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4244B1E500C;
	Thu,  5 Jun 2025 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749132290; cv=fail; b=CFsemW9lPznCBX7JspZvsM3omQLsYIbT1H9Jo2BBkrT3V5F9oMI7CEeDQDg8jiOUy7TsnNr+RhSoCrEPh/7ssMctwaGs5wuIWeEm5k3A6arDJpjfKYJe9jJrIn/NgZtmVyUspUYdEM7m6MptdvHve09AXaQkLA8/Gsf7jl8mmlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749132290; c=relaxed/simple;
	bh=XIppgE+Gv4uBaEWn+ZfGRBB8ziFHcFBMd86V/BeQi6E=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FDAtwds4mVmn56EVKgHq2oiC+ScmRyToKlBRfL8m19NkkSgueE4JRo0gC0jw+R4TO4U0fRWNnKyaEEjZzitFddo869nbjsISjLm7Opk5lbqhwWiDOPuAil5suKY4dPLwO6j/GztPr4Z4Gtqf51l0Vtd2G6FMCOL59arazN35BDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D+ARWFGQ; arc=fail smtp.client-ip=40.107.101.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wL0fVBeyJrkJfY371U+1/mEJM4OE51BTIix+YYlOS5Gqlm2Pq4ZscCn4UwoUwMMeE6ZqaNDDfSDUx223FfnoEMf50AsA4qra//t+lmembdkgAJTzM2R5WUCmkhAGu4cFC0E5RPNrdPqJJcuWx4leoCKejsEc+zLgYQLcHs0WAhT3vXfqVzoBzBWGsRh9aJ/SI34s5dYOz10LAGM029fmahwZRxM5shgq1/XbHCcNQpvyX4rD5FNEUtqc0SNLQKWC//5Q94NdE03ryTjj53AIdd28kmrvlNkeCEBtty+zrnm05sxvt5jmTt0qmEMF6P8lOB8huUvc+a/g2H7pWqHRhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4Fkq5LfLf8KR4bXwI0h9wQv17tywHiXLR2owiAWaxE=;
 b=Bypsxz5Si0JZObcyYL5Dw4Cwt8leZpcrDuEFCj1ABJqZCjoBQ2h1hyRuFxZUFtQ6TCr4IRFVuKcYL5Jo1zgcHLe5lICMa2UJdiA3RkU8gKpxZK20La5DkldfELeN0Jd3LL1jtCIxnTMuEKjTS14TuObzyuilMikgNrdpU6FnXG1RoFFOedTPi+CzLYibYoKZMP7JdRk8V6BmXahVLVni6JdokqOcY7WobaMJ8KLz6bsIlBWaAMs5YegPlEFqfm6ya4g/Ov2pcHCMseCqR4gbaByVmxu8ZdbSuQDWkxhirbkfMHIit4WDJ9Cjgex94lSEabFeuWqeaUBuFdw6Ja/hYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4Fkq5LfLf8KR4bXwI0h9wQv17tywHiXLR2owiAWaxE=;
 b=D+ARWFGQvKcZV3lnNu7yeaRf3VYtG3wk/ebOuj45QuhDC+MMRi/nwxarTImsP6tSSTLKlpkx+7q9vnpNtf/30p2GPWUnGQSMkJ1+ij/a4tMazBS4TplZaap2VzIQZyKUyK/jNobC07uKIpBQw47WGVvrDy6b0FZw5eJ8RieAzuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.32; Thu, 5 Jun 2025 14:04:45 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%5]) with mapi id 15.20.8792.034; Thu, 5 Jun 2025
 14:04:45 +0000
Message-ID: <4a7dfa9a-965d-403e-9356-2013c30569d6@amd.com>
Date: Thu, 5 Jun 2025 09:04:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/16] CXL/AER: Introduce kfifo for forwarding CXL
 errors
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-4-terry.bowman@amd.com>
 <52dfc3f1-b7e1-44f2-8f99-f3f37f44f00d@linux.intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <52dfc3f1-b7e1-44f2-8f99-f3f37f44f00d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:5:3b9::34) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SA1PR12MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: c53165c3-911f-427e-c0dc-08dda439ecce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDlpbEd5dTRXMDBaK1hyR3lWaklmVGFWTkcvR0I4djNadEF5WEJ4aUxFNzAr?=
 =?utf-8?B?bWVvWGdMMVdrSFlqdnJheEJDTE9xeUZ3eW5TYlJMOTZYRTFRcVBHTS9NRzhX?=
 =?utf-8?B?QWtFdDE4blIvNC9GS25oeHhnd3g0a2thbDl1ZzlSK2dCSEJ3NXIxSzlDWkJR?=
 =?utf-8?B?UUEzalNjYWR3dUE5UWRUa25hb2QySEUrNUhpelA3eHhabDdwQVlPRkVkQ1VR?=
 =?utf-8?B?WExWcFV3d2lTb2tYZDJ4dTJPdU1HK3RpaW9SVFd0WFZoYjUwdHUxUXdzVzhW?=
 =?utf-8?B?c3U5cWc5ZG5nOUhHanVCL0xXT2J2L2M4bUVYa1V2bDgwK2JLSjdqYkFKRTBa?=
 =?utf-8?B?UEQyTkozY2JRTUI5dnZCeC9uWXRMU3BYbSsyRVhBOUo0bU0yc1dmZFdkMTBF?=
 =?utf-8?B?UWtsY3I3SGlnVSthVnl4VXlUZGM1ODQ0MnU3cS9JZmRDUU1CSHB4a3p2N3NF?=
 =?utf-8?B?MW93aW13QmtrVDI4Q2taNm1aOTdqc2YvbzJkRGJIVzBVb2J1dTQ5ZnZvM240?=
 =?utf-8?B?RmxzaUR1UzJmOHhXVUdrS2pZL2MxRlpNY3hFS3Rrelphbm1SeWVOb2VVTjdP?=
 =?utf-8?B?UWNiL2JNb3dVbzBXOEljLzNMQW9yOEhxS0RUQ01RemtwVHZrZWFORnZveVBT?=
 =?utf-8?B?YjZ0enk0UFcvM0ZxTWtraTJ2aWFJVjcrV3NObG00d2hiNTVORzAyZmwrT1ZN?=
 =?utf-8?B?OXNJd29BU1grUFhLZy9WYXlxL21YZ0tRR0xyNWlqUDhUdHFKTVMrSmlWSDNE?=
 =?utf-8?B?TDZvS2dXcEVTYW1lOGxPamR2VTNYWGl4anVKN2R2cHpGNW9BekkrS2Y1Nkt1?=
 =?utf-8?B?NHk4MkRTNjVKN0xzT2F2eUZscExoeVk1a1FaN1dTLzB1UHpqeE0vdTZuZG0z?=
 =?utf-8?B?eFNLb25NVzdnS0p4ZGptTjRYY1RSeGorOXJSWkhCcnZMRXIwQWNpZmJKcm52?=
 =?utf-8?B?bGJ4NWc5YmJ3N2tvZzkvS0JvRU5ORVBQa1JqRlJGYzIwbnJrN1hkSzA5K0du?=
 =?utf-8?B?bnlRYTBzdXB0ZitvWVBaQjVGN25SekdmVzh4UTVJWjViZlYwd2tkNE9ydFZu?=
 =?utf-8?B?Z3Z3WFdPZmdEYXV5ckF1UG5oYkdRNEhic3FDK1BiM1lwR1c4U1RIQjRMVXFw?=
 =?utf-8?B?bHZiUWhSYkN5VW9OK0tiREdlLzZWMTlEbGM2Y05TZHQzak5FOTg2SEx1WDZq?=
 =?utf-8?B?VXlaQ3c0dlh3NEttNElKNXJXSjlKQzQrTVdnOXEvTVdvOFZ1enE3V0dlSEx2?=
 =?utf-8?B?c3RybW4xcmlzSGZJOURnM0x4aVBiczlBMVlIRkFBVG5oTm1UcU5ZbWVDdEJ1?=
 =?utf-8?B?UE9jNWFyUFlGU0puK0tkNTIxWTczOWhrTU1ZNG54N3ZTQWhRNHp2N3c4Q05v?=
 =?utf-8?B?ZHhVWWZIcFJ2S2dKRnFXMUVyaThPZjJLbmRCWE9lOGdXNXNNMUcyVzNUanVZ?=
 =?utf-8?B?QTNmZURjbmhqeU95N2FBY1BQN29PbFdmeXlQblZKZUVQQXJJWE5tY1BMK2NH?=
 =?utf-8?B?cUtmSWtoK3FWZjhtdmRzWkV1R0JITXk3SVY1L2d4VWpqV2lGbHZ5ajlBbHNT?=
 =?utf-8?B?NS8wcS9iWWJGZWU4NTdOS09POVJlV0x4bi9jZUZxWVh6dlJrbURSZ2VEdVMy?=
 =?utf-8?B?blVNam5tc1Bqb1RUczJXZGl2Y3RqQVcwUFFOa0JxNnBwcUkwM2dWZGlTWjFw?=
 =?utf-8?B?VHpmNzZySThtMDZCNXZ1eVc4UllkZG9mcUZMVUdZMVZKSEU1dkxzQ2FnZGdI?=
 =?utf-8?B?N3k0SzVFY2Y5L1poTkZqYlMvaFhQNm00YmxUU1JoU0d1TW8zcFlxWCtDcitl?=
 =?utf-8?B?enBaV1dJK24xWnVPWGdlN2hiclRUN1ZPM1V5Vm5aQWNEbnhJa2RtNm02SHBI?=
 =?utf-8?B?eXJHekxTTXNaZjZoNFF2eHZUajR3eTQ2RHFhODE2R1V5SVhzcVlvWVFQa0tM?=
 =?utf-8?B?M1MzRGVuekZHdUQyUUFXaEUwVkxwNjVyRHY0eVBDN1FTQ3NXaU1ZTmFjaHVT?=
 =?utf-8?B?c091dG9WUUZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1p0a1BFWDFLNHkyOWJ3ZHpMSW1LUUc1bFNkZFNrQUpVUjJOdnZTNUVIMUZB?=
 =?utf-8?B?SlpBRHU0L1hsSjgrdzNBQWNtZ2hSM3BBSUJjUXpCSGgxa1NwbGwxYXg1amRu?=
 =?utf-8?B?cnpBY0xNRFJMY2dQdUtLb1JTdXNRMGIvY1k5WDBCMlF6WVM3a3hKSk5mcHNY?=
 =?utf-8?B?NGZRUGk1c09oSXFiOWNNU1RaMjExTjdYYnpYVEtNelFRZER3VDNEVG1sdnNh?=
 =?utf-8?B?ZWk1cDN4cXFBVXVDY3pockF5LzM1T2hVQ28wVHV5c2NjSW9mV2w2VzhIRGY2?=
 =?utf-8?B?SXMwdEt0aXhQT0diMDRvaXZnZjRDZWFERkwyeGtyQmxoWHBJTVZwb1BOMlBM?=
 =?utf-8?B?UWpiaHpuRW4vT1FEVktYS3pKbXdqakltY2ZCeEI4MG9ZSUVVK2c5amxpdG83?=
 =?utf-8?B?Z0lMczZsbFNXd3VjaDQ1ZjBhV3RFYXhtUnJTd0lIT0hGWC92UFI2eVIyTlp3?=
 =?utf-8?B?SDEzaElmZmVRRHU2VmMvMWdNTFNnSU03bDFWTFFHenQxajYwUW5NVXZnRm5F?=
 =?utf-8?B?S1pWcnR3TFNtR1B3aDN1TWlBVWVIak4xSFVyK2hiU0l4WHB0OVJsemkyMUFj?=
 =?utf-8?B?cjJFaWlTRHFOS1dMSkdQb0JTOUFVQndWWEx2QjVKKzBqNExJTUI0NDlaMU93?=
 =?utf-8?B?bFVqcFBFcWJlM2MyWURZak1OcURvME1IRnVhVDVHdmY2U09sMXE3M2VsNDBm?=
 =?utf-8?B?L0l3TDFFbE45YjkxT3J4dUNwV2JaeE1iY1R5VkMxaHN5eXNaU0M5WW44TEFK?=
 =?utf-8?B?WFJGaTRpUmc5SmR6VUdyNkFmTi95allCR0JHNlR1UkhiQUJscTlyQUtBTnR0?=
 =?utf-8?B?OVNaWUdaZUJoK3JNdGhrSi9qdlVBTEo3NWpLajhtTC9zOXNrcU5nTDdkUWdQ?=
 =?utf-8?B?ZDBMa21JdVlqTnducW1FYkVVU3hTNXFlb0hZVGVwOFcrTjN0ODB5dzNMaXdq?=
 =?utf-8?B?TSt6RzhBZkZ6RXZVSHFFTTBIdFM0bnh5OXNUNGZxaG1xSnNKcGpJcUk5eU5G?=
 =?utf-8?B?eUlPWklXVUUxWGh3WExKc05Hajg5aDVYRTIraWNyeG5aRytXeDE2b25IUHhD?=
 =?utf-8?B?ZktJNnhnOXhmeHhjWmUxamFBQktuYVgzRGZGRkMyWE5UZ1RVRUJLSjhoVTZ4?=
 =?utf-8?B?WlZBQkZSTWNMQ0lyM2hFZmN6TC8wbTY0OWp4Z1Z2WFBQamFELzZudWVGU0p6?=
 =?utf-8?B?akRiQmxaZkNac2ptOUhUQU10VmNrS0ZCdkJGTS9qbnVnMCsvY1NieFZocG9z?=
 =?utf-8?B?TWJFWlMyYXhXa0Vha202WUJKeGdBeTZoQ2R5eE14NkVxZ1JTYkRGditHK3hK?=
 =?utf-8?B?SW1ZZ3VENVBSVlNsQzJvTTVYNlA5UVRqS3BVYi9lU1ZmMlkyRkkrNkdEQVVu?=
 =?utf-8?B?SnZ3aDNTL0xjYkdDa3kxR3pEQWlJV1FycjJRT1JtOWxlVDhOcnR6R0RhS1NK?=
 =?utf-8?B?b2o4VFBsNU1ZMUdSdjkxQVZVU0lTc2xYRVNXSHZVaWY5REcxdHpsZ2tIV010?=
 =?utf-8?B?Mk1mYVZRQyt5Q0dLVElEOG9GOTNHNE1UMjZiU1JzVlVHbEQ3ZUxJRlJEVUJu?=
 =?utf-8?B?T1IzajhtbUFEMitDcVdCSGNPN083MCtlMlNLNE5lamg1ellSUFNNV3NkUzhz?=
 =?utf-8?B?cFdNTDE1akd2L2h4KzIraUlkUU5Tc1AwdUxOVWdRVkhBbW9kUWJROEM3UitV?=
 =?utf-8?B?UG0zeTN1NFJGdCttS3U2YkVWeHZ4WVhPNE9GWWxmMFlydjVKbS9lVElrVk14?=
 =?utf-8?B?b1RiOUR5ekVDTlZabDljdlhHelBVbXh3QkkvcFZiSS92OTROWTlkNm8xM01J?=
 =?utf-8?B?YjFmeU12ZjdJMlgwZ1VJcEZqczFNT0REbXdxNStpQXNCTDAwYTNhVkpCYVRk?=
 =?utf-8?B?MUdVM3dVWUhQUFBtUnI2S3lnMXlYQk9VemtETDFIbklJMTJwWVplY21Kb3M5?=
 =?utf-8?B?K2FtNHRTNE4zbnhXUE9Qbk5vWHN3MWhYU3hWY0dkWXF0ZTZVcXdjeHVGWHJP?=
 =?utf-8?B?cC9DNzVMMExwZUttTVE1N1gyR09nTHEzVDNrWldrb3BlU1g0cGNCbVZzNUhY?=
 =?utf-8?B?QkhXRWM4TnFpcFdBLzlpWW1yRzVOdm1JVHpEUllQS1ZzNGIxQTNRcjhuN09h?=
 =?utf-8?Q?5FIXIOq/7Hk3GRrsPDVYRfZJB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53165c3-911f-427e-c0dc-08dda439ecce
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 14:04:45.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcOqMqI7a1byyVfeXLRz04NGAbV/t2/vrvsRqfAG6M7y3+esVDASEUF4A8PRE8XT3SGqs8tG8FzqQPoF/Ls72Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669



On 6/4/2025 5:50 PM, Sathyanarayanan Kuppuswamy wrote:
> On 6/3/25 10:22 AM, Terry Bowman wrote:
>> CXL error handling will soon be moved from the AER driver into the CXL
>> driver. This requires a notification mechanism for the AER driver to share
>> the AER interrupt with the CXL driver. The notification will be used
>> as an indication for the CXL drivers to handle and log the CXL RAS errors.
>>
>> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
>> driver will be the sole kfifo producer adding work and the cxl_core will be
>> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
>>
>> Add CXL work queue handler registration functions in the AER driver. Export
>> the functions allowing CXL driver to access. Implement registration
>> functions for the CXL driver to assign or clear the work handler function.
>>
>> Introduce function cxl_create_prot_err_info() and 'struct cxl_prot_err_info'.
>> Implement cxl_create_prot_err_info() to populate a 'struct cxl_prot_err_info'
>> instance with the AER severity and the erring device's PCI SBDF. The SBDF
>> details will be used to rediscover the erring device after the CXL driver
>> dequeues the kfifo work. The device rediscovery will be introduced along
>> with the CXL handling in future patches.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>   drivers/cxl/core/ras.c |  31 +++++++++-
>>   drivers/cxl/cxlpci.h   |   1 +
>>   drivers/pci/pcie/aer.c | 132 ++++++++++++++++++++++++++++-------------
>>   include/linux/aer.h    |  36 +++++++++++
>>   4 files changed, 157 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index 485a831695c7..d35525e79e04 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -5,6 +5,7 @@
>>   #include <linux/aer.h>
>>   #include <cxl/event.h>
>>   #include <cxlmem.h>
>> +#include <cxlpci.h>
>>   #include "trace.h"
>>   
>>   static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
>> @@ -107,13 +108,41 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>>   }
>>   static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>>   
>> +#ifdef CONFIG_PCIEAER_CXL
>> +
>> +static void cxl_prot_err_work_fn(struct work_struct *work)
>> +{
>> +}
>> +
>> +#else
>> +static void cxl_prot_err_work_fn(struct work_struct *work) { }
>> +#endif /* CONFIG_PCIEAER_CXL */
>> +
>> +static struct work_struct cxl_prot_err_work;
>> +static DECLARE_WORK(cxl_prot_err_work, cxl_prot_err_work_fn);
>> +
>>   int cxl_ras_init(void)
>>   {
>> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>> +	int rc;
>> +
>> +	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>> +	if (rc)
>> +		pr_err("Failed to register CPER AER kfifo (%x)", rc);
>> +
>> +	rc = cxl_register_prot_err_work(&cxl_prot_err_work);
>> +	if (rc) {
>> +		pr_err("Failed to register native AER kfifo (%x)", rc);
>> +		return rc;
>> +	}
>> +
>> +	return 0;
>>   }
>>   
>>   void cxl_ras_exit(void)
>>   {
>>   	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>>   	cancel_work_sync(&cxl_cper_prot_err_work);
>> +
>> +	cxl_unregister_prot_err_work();
>> +	cancel_work_sync(&cxl_prot_err_work);
>>   }
>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>> index 54e219b0049e..6f1396ef7b77 100644
>> --- a/drivers/cxl/cxlpci.h
>> +++ b/drivers/cxl/cxlpci.h
>> @@ -4,6 +4,7 @@
>>   #define __CXL_PCI_H__
>>   #include <linux/pci.h>
>>   #include "cxl.h"
>> +#include "linux/aer.h"
>>   
>>   #define CXL_MEMORY_PROGIF	0x10
>>   
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index adb4b1123b9b..5350fa5be784 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -114,6 +114,14 @@ struct aer_stats {
>>   static int pcie_aer_disable;
>>   static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
>>   
>> +#if defined(CONFIG_PCIEAER_CXL)
>> +#define CXL_ERROR_SOURCES_MAX          128
>> +static DEFINE_KFIFO(cxl_prot_err_fifo, struct cxl_prot_err_work_data,
>> +		    CXL_ERROR_SOURCES_MAX);
>> +static DEFINE_SPINLOCK(cxl_prot_err_fifo_lock);
>> +struct work_struct *cxl_prot_err_work;
>> +#endif
>> +
>>   void pci_no_aer(void)
>>   {
>>   	pcie_aer_disable = 1;
>> @@ -1004,45 +1012,17 @@ static bool is_internal_error(struct aer_err_info *info)
>>   	return info->status & PCI_ERR_UNC_INTN;
>>   }
>>   
>> -static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
>> +static bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
>>   {
>> -	struct aer_err_info *info = (struct aer_err_info *)data;
>> -	const struct pci_error_handlers *err_handler;
>> +	if (!info || !info->is_cxl)
>> +		return false;
>>   
>> -	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
>> -		return 0;
>> +	/* Only CXL Endpoints are currently supported */
>> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
>> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC))
>> +		return false;
>>   
>> -	/* Protect dev->driver */
>> -	device_lock(&dev->dev);
>> -
>> -	err_handler = dev->driver ? dev->driver->err_handler : NULL;
>> -	if (!err_handler)
>> -		goto out;
>> -
>> -	if (info->severity == AER_CORRECTABLE) {
>> -		if (err_handler->cor_error_detected)
>> -			err_handler->cor_error_detected(dev);
>> -	} else if (err_handler->error_detected) {
>> -		if (info->severity == AER_NONFATAL)
>> -			err_handler->error_detected(dev, pci_channel_io_normal);
>> -		else if (info->severity == AER_FATAL)
>> -			err_handler->error_detected(dev, pci_channel_io_frozen);
>> -	}
>> -out:
>> -	device_unlock(&dev->dev);
>> -	return 0;
>> -}
>> -
>> -static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>> -{
>> -	/*
>> -	 * Internal errors of an RCEC indicate an AER error in an
>> -	 * RCH's downstream port. Check and handle them in the CXL.mem
>> -	 * device driver.
>> -	 */
>> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
>> -	    is_internal_error(info))
>> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
>> +	return is_internal_error(info);
>>   }
>>   
>>   static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>> @@ -1056,13 +1036,17 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>>   	return *handles_cxl;
>>   }
>>   
>> -static bool handles_cxl_errors(struct pci_dev *rcec)
>> +static bool handles_cxl_errors(struct pci_dev *dev)
>>   {
>>   	bool handles_cxl = false;
>>   
>> -	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
>> -	    pcie_aer_is_native(rcec))
>> -		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
>> +	if (!pcie_aer_is_native(dev))
>> +		return false;
>> +
>> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
>> +		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
>> +	else
>> +		handles_cxl = pcie_is_cxl(dev);
>>   
>>   	return handles_cxl;
>>   }
>> @@ -1076,10 +1060,46 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>>   	pci_info(rcec, "CXL: Internal errors unmasked");
>>   }
>>   
>> +static int cxl_create_prot_error_info(struct pci_dev *pdev,
>> +				      struct aer_err_info *aer_err_info,
>> +				      struct cxl_prot_error_info *cxl_err_info)
>> +{
>> +	cxl_err_info->severity = aer_err_info->severity;
>> +
>> +	cxl_err_info->function = PCI_FUNC(pdev->devfn);
>> +	cxl_err_info->device = PCI_SLOT(pdev->devfn);
>> +	cxl_err_info->bus = pdev->bus->number;
>> +	cxl_err_info->segment = pci_domain_nr(pdev->bus);
>> +
>> +	return 0;
>> +}
>> +
>> +static void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info)
>> +{
>> +	struct cxl_prot_err_work_data wd;
>> +	struct cxl_prot_error_info *cxl_err_info = &wd.err_info;
>> +
>> +	cxl_create_prot_error_info(pdev, aer_err_info, cxl_err_info);
>> +
>> +	if (!kfifo_put(&cxl_prot_err_fifo, wd)) {
>> +		dev_err_ratelimited(&pdev->dev, "CXL kfifo overflow\n");
>> +		return;
>> +	}
>> +
>> +	schedule_work(cxl_prot_err_work);
>> +}
>> +
>>   #else
>>   static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
>>   static inline void cxl_rch_handle_error(struct pci_dev *dev,
>>   					struct aer_err_info *info) { }
>> +static inline void forward_cxl_error(struct pci_dev *dev,
>> +				    struct aer_err_info *info) { }
>> +static inline bool handles_cxl_errors(struct pci_dev *dev)
>> +{
>> +	return false;
>> +}
>> +static bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return 0; };
>>   #endif
>>   
>>   /**
>> @@ -1117,8 +1137,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>   
>>   static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>   {
>> -	cxl_rch_handle_error(dev, info);
>> -	pci_aer_handle_error(dev, info);
>> +	if (is_cxl_error(dev, info))
>> +		forward_cxl_error(dev, info);
>> +	else
>> +		pci_aer_handle_error(dev, info);
>> +
>>   	pci_dev_put(dev);
>>   }
>>   
>> @@ -1582,6 +1605,31 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>>   	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>>   }
>>   
>> +#if defined(CONFIG_PCIEAER_CXL)
>> +
>> +int cxl_register_prot_err_work(struct work_struct *work)
>> +{
>> +	guard(spinlock)(&cxl_prot_err_fifo_lock);
>> +	cxl_prot_err_work = work;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_register_prot_err_work, "CXL");
>> +
>> +int cxl_unregister_prot_err_work(void)
>> +{
>> +	guard(spinlock)(&cxl_prot_err_fifo_lock);
>> +	cxl_prot_err_work = NULL;
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_prot_err_work, "CXL");
>> +
> Above two functions can never fail, right? What not make them return void?

You are correct. Good point. Thanks, I'll make the change.

Terry
>> +int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd)
>> +{
>> +	return kfifo_get(&cxl_prot_err_fifo, wd);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_prot_err_kfifo_get, "CXL");
>> +#endif
>> +
>>   static struct pcie_port_service_driver aerdriver = {
>>   	.name		= "aer",
>>   	.port_type	= PCIE_ANY_PORT,
>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>> index 02940be66324..550407240ab5 100644
>> --- a/include/linux/aer.h
>> +++ b/include/linux/aer.h
>> @@ -10,6 +10,7 @@
>>   
>>   #include <linux/errno.h>
>>   #include <linux/types.h>
>> +#include <linux/workqueue_types.h>
>>   
>>   #define AER_NONFATAL			0
>>   #define AER_FATAL			1
>> @@ -53,6 +54,27 @@ struct aer_capability_regs {
>>   	u16 uncor_err_source;
>>   };
>>   
>> +/**
>> + * struct cxl_prot_err_info - Error information used in CXL error handling
>> + * @severity: AER severity
>> + * @function: Device's PCI function
>> + * @device: Device's PCI device
>> + * @bus: Device's PCI bus
>> + * @segment: Device's PCI segment
>> + */
>> +struct cxl_prot_error_info {
>> +	int severity;
>> +
>> +	u8 function;
>> +	u8 device;
>> +	u8 bus;
>> +	u16 segment;
>> +};
>> +
>> +struct cxl_prot_err_work_data {
>> +	struct cxl_prot_error_info err_info;
>> +};
>> +
>>   #if defined(CONFIG_PCIEAER)
>>   int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>   int pcie_aer_is_native(struct pci_dev *dev);
>> @@ -64,6 +86,20 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>   static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>   #endif
>>   
>> +#if defined(CONFIG_PCIEAER_CXL)
>> +int cxl_register_prot_err_work(struct work_struct *work);
>> +int cxl_unregister_prot_err_work(void);
>> +int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd);
>> +#else
>> +static inline int
>> +cxl_register_prot_err_work(struct work_struct *work)
>> +{
>> +	return 0;
>> +}
>> +static inline int cxl_unregister_prot_err_work(void) { return 0; }
>> +static inline int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd) { return 0; }
>> +#endif
>> +
>>   void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>   		    struct aer_capability_regs *aer);
>>   int cper_severity_to_aer(int cper_severity);


