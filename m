Return-Path: <linux-pci+bounces-19794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682ACA11598
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 00:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B65B07A2322
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 23:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C7F1FC7EA;
	Tue, 14 Jan 2025 23:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MMrt5LxJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EC61FECCE;
	Tue, 14 Jan 2025 23:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736898184; cv=fail; b=h/KLwM/xgJR1tLsGdrmsyIRrxM3DWshkZT5JqESN8w75Y8cEYNITNmPgf/gmqRfYMB1gkHW64WnuobQQJgBv8R/YEJmUyG5Yl1Yu8drEjrMGiUQf4HH8+tP3K9RiDt8/E72rs9/NxBffVHlMclB/Mc1AOZ12hmYQpaLR8s798k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736898184; c=relaxed/simple;
	bh=ppfrX/6PhpW6Q4q69yDqdzfChZVtcSzXpWfWXm1rgjQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sLQ3HVbdA7lLJLQJ/M6lg51SjcGg3v7kh8TQMZOO0Ldh1rSfoPN/nhlPMp5djqfttkmaRXLC4q+fLK2+TLWzzqnjtDuTdJs4NIyqm5H3xmUmX+71bjzcQNbdM0kInM9oSAk1ixpGVsQAZdNDUMgBwnKRoKcFzK3kgLwCV870PGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MMrt5LxJ; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qI0q/LJ+I+N58KNV/l/mazwRaVJtcBpjBfgzIajKVTuK3xuf6SXqNFC5hrMqIyoZqAtd4F8RFZrX7Tv5OyrZM8/egjo38qVoRmMglXTiREpfZ1opwHfQDQPnAP5lRrcTe20SaK4ehVX2AgZrhfd96j8Jrma2UduInTwyuZ5BCO5w7DsNhf8836GdlFaxWZxEEkV7YB6m5Dw2r2AjwhsruZCI+W7vmHBCuP+q20+vU2vmZy1EcjWrY/M85LS/HDk6fycXdDNXuL5nkUxJPb/mpwPzCbOfV7dixZZ/wBoosY3tkhG9aFcnKG23W9ne9w3suzzoVnrt5MtTkTpysQ1igQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdsLSDkw6zIbLv05dOV28DlGH4BUBJGpnQgjx4JyCEs=;
 b=UL3ZYhKLtXrlllyeAfrpOUSvSgYAJJERbc5AqGZEsYvZgKMzP7DJZQ+x6p8k3OKavvmemhrwz2anfQxv9gVqQS/zVNKDt40mgvAV8Ds+ijOFILCKFvLkqSTCyrbHrH/2KX73G5lw0Q7zIgg31QcKs6rdl3ognJtgecMrwgUKMHqtYm8TyitHcSdFt9i5r8dVk2Ggr+ZHtAG+QgOiv6Rl4L53JL/LQFXTunFBFIq4X5T4OZmmz54LjOcU/9Ox6FRaGV7XR2rnwUOJEVe2m4NKqET5sGF/q0c20GH1Fx6BQhfybDEipv9DiWwzejNi7hevhrjdjNa7lF0JIgtHNeXgqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdsLSDkw6zIbLv05dOV28DlGH4BUBJGpnQgjx4JyCEs=;
 b=MMrt5LxJeB8PtHCWnNf7WMhCTGrpnHUnT6f6Q4UGLlprGy8I6eW4xdVOMYbFydH4OmbSQKlaDxoHrPnhqnkpM87SXJsZfdEcr+j8VtOcw2PG29aOd675SqGdDsZwuOK4aEvVXaEGBD3rTlDUyseyDBibQx3Xx52rqr6b9C8kvOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 23:42:59 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 23:42:59 +0000
Message-ID: <a59f6af2-425b-4e5d-865c-2c85ed298083@amd.com>
Date: Tue, 14 Jan 2025 17:42:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/16] cxl/pci: Add error handler for CXL PCIe Port RAS
 errors
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 oohall@gmail.com, Benjamin.Cheatham@amd.com, rrichter@amd.com,
 nathan.fontenot@amd.com, Smita.KoralahalliChannabasappa@amd.com,
 lukas@wunner.de, ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
 alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-14-terry.bowman@amd.com>
 <6786ea6964f3c_186d9b29424@iweiny-mobl.notmuch>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <6786ea6964f3c_186d9b29424@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0034.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::7) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BY5PR12MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: 48947a0b-7e52-4441-b38a-08dd34f52dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE90dXY4VEQ3UGZCQlJoWmlDRGh2TVJJZGRxbTA0c3A4bVdsa3dlWEQxTHh3?=
 =?utf-8?B?Zlh6M29kT2k5djFIZ291NmZQcmthNFAyVnF5eElZWExOaFRNc2ZTVTNOL0Uw?=
 =?utf-8?B?MHhidW1PTmNudzFtMDV4MmhwRTZ6R2dzTjAyODZ5bkM0K3lCWkdqMjBHdWJv?=
 =?utf-8?B?TWx6b3oza0RQMFhHdFg3MnYrWStKSll5TncyMFViSUorS2FwMmdBL0lSQWhW?=
 =?utf-8?B?bTJRYkZIeTVoMkdkekhMY253NGt0WU4reXNOT1VVTkNFZzNtajV2TWxzM2FH?=
 =?utf-8?B?eGdONlF6RGs0RnI2REVYaGlYVURrRWJWL0pUUVpxVVhLR1M3WVJ6ekVMMy82?=
 =?utf-8?B?U3BoYVIyWXlmemZJb2FlOEs5ZlhEOUJqbDFkZVZzamdQRi8rNTQ2Y2FsZHg2?=
 =?utf-8?B?OEFaQlhocUhBeHBUMHZtdzlwTDB0MG5EMmttcjlNVUo5SE9GUGgxVWRVRE5k?=
 =?utf-8?B?YmdtRnh2R3N6YTlQUWFpeFc4WUFCSC9XR3ZXaHNTUTR0RW5LazlLQjl2UkRL?=
 =?utf-8?B?QStDNlZ2dTI2RnFmNmdmNDVocWpib1p5ZHdMMjdSWTZtcElOY01sb3FhS0F0?=
 =?utf-8?B?V3g4bzk0S0dJQVVQREpabzFiNmRKSm9LQWlHL1JvMjlZRnU2ZC90Z2kwanlm?=
 =?utf-8?B?UHduL3BmVjgvSkZORjNtTEtlMDRMa3pJeEhOTjAzOEk5VVMyZUFydElSaU5K?=
 =?utf-8?B?LzlVMHQwbHZzb3YrcjJ5UGRoYXl0dHdHeHNlMjdZNFpGM1pMSUJyaE1XVWZw?=
 =?utf-8?B?UkQycUY5TVIxbVFqaFE3MFRyeXI5d0VlZ1UwWCtobHNBdHNxZWxPM3FSVWha?=
 =?utf-8?B?bWlrQy9QTlJEQjZTNFBLUHRIS0VPZXMyWlJJRTVuSmhiVnV6cGY3bTE4eU1x?=
 =?utf-8?B?ay81SjhrdmpqMGxZcEVlUWJPKzRZWVBnK25lSzQ4OHlRUi9ra3dyeG5mVzQ4?=
 =?utf-8?B?T3JBL2ttcXNVRmJIMDh5a21KQ0trTm95SEZzZXhMOGtNMkdYMW5POTRJR3la?=
 =?utf-8?B?ZjU4ZTlsT1l0UzJBTTU1SFdFYVRmQVZCWFFrWFJMVmVCRWVCS0ppOTk1bjFs?=
 =?utf-8?B?MU5YU2w0RmFkUURqN3ZWSkI1bUVFWTJiR1ZQajhqcGxyUXNKc3ZqQ0lDZjVM?=
 =?utf-8?B?TjlzemZXMXRtNmRQRll4ckdTNHBJbEc0MDRpM3hZQ1ROMzY0d05MeldvdVR5?=
 =?utf-8?B?ZFpqOGJodXFLTFA2anptaE1XUFp3TkcvaGs5WVB0c21KOGdyTFRQUE1VR3dr?=
 =?utf-8?B?dzRVdTZlTlg3MlgraFpoSUdUYStuN2NraDhpbHNISDZ2SC9YVDNSd216SXVx?=
 =?utf-8?B?eGZVeTNKU0JNQmZhZ3lpQ21Oc01XTE9BUzZsSjhUN3AvNkhleTdTVHRQdlBD?=
 =?utf-8?B?dWRHVXJtMGw2bDBEZkVBS09hRnNRNWpkZFRMdFB3ekgzZHlETDl1SVBkek14?=
 =?utf-8?B?amJ6bjVZaUhvZ1Q1Z1Q2eCtQNk1jeTZUU1NkaUcxMUh0MzIwc0VOM2pmSVln?=
 =?utf-8?B?WG9BK1ozQ0JKdTlPSUlORWdZZ1d4djBkcnJRVGl0blhSd3dHNzhscUpLbWtY?=
 =?utf-8?B?ekE4Qk5BQStXZXpReFRMWi9rU0JGbjFkWDRzQ0NSeUtuUUxGQlZUQS9GMWpu?=
 =?utf-8?B?Wm5ORkhoRU9vcm9wNWdSM3Jqck1XdmJkNVJ5N0ZOS3VCUUNlbVdHclBpbjVn?=
 =?utf-8?B?WmplbVM4MGNSOXZsdytuWHZYQ0xXOUdnaUlHdjBMM05BQzRaYit2U0JNK3FT?=
 =?utf-8?B?TUZ0aWdnMzErM0pRZDhxa1VjOUhtL0VCdnFKWHZWTm9iaDU3c1BGeW53dkEx?=
 =?utf-8?B?UW9BbUdaRE5ZNDQrTCtOY3hpN0Q2ODRDNTNDZjN6NUk4TzM4S1QxYUphRG44?=
 =?utf-8?B?ZkxqV0pMblRkR1ltWWRmSXRrMko5K3dacFpWYzkxSzJHcXFsKzREMCs4UDA2?=
 =?utf-8?Q?b7HxTtX3zvA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3dwT2RJTzBwcTU2SE0vSHRMdzdLV1JRUDlmQnBUbzRQK2QzUm5GMG5BZ2dP?=
 =?utf-8?B?UFRzTjY1dUt5N21UdG5VRWs2QzNJeDFDVlRuRHFsTkNQQ0l5R0tPdzZ2bUw1?=
 =?utf-8?B?YmptK3grOUVQUTVTM29jWjdSVnNGVk9VODdPbHFQQWxmeEhwNWpHcWEvb3Zy?=
 =?utf-8?B?NitaTVZjZEpnUVUwTzNBZkZQVWk0TmZNL1I5YTUzaHZHWTN2RFR3QmNmSENx?=
 =?utf-8?B?MWo4RDM1WHlMRWtrSll3NElUSUtsbVFSVjNDQTc0R0ZCUFRrNXNneDMvVWFR?=
 =?utf-8?B?YkNCcWlOYW1TSmRpaDhmYkd0blVuTGRIdSszc1R3bXR6ZWdSNUFrMGVnNHVq?=
 =?utf-8?B?OUtYOThlaW80emVZTlhOc3N3VTlBVEFKMEg0RWdRVktxMm8vakkrU0NuYUp2?=
 =?utf-8?B?bHdxUG96MTE1dDg1cWhXWklDc0hPZHBkNkx2akViT2lFQ2lHYTVmV20zcTdG?=
 =?utf-8?B?cmN1QXdOclh4eSs4anNOVnUxN3JYaGpCUzJmT0Z4cFlPc0h1TkdROVo4aXV3?=
 =?utf-8?B?VDFPOEtSTjR4L3NxMXU3NVRBL3YybzZnRWFjcDN2OXdFcngxOGlZTGFZc3Y2?=
 =?utf-8?B?Q0s5WUR2SVNVMEtrSDJIY1haOEx6Ti84Z2ZzNUVjUi9hNWdITEpWUGROcytl?=
 =?utf-8?B?eVd1Slk1T2RrNGhORlc2MDRSYS96ZzlmOHdhbVF4Sllsb3p1NjlyOW4yZW5O?=
 =?utf-8?B?dzlwQ2t4b2JVQ2svNk52VFpXWE9leHY0M1drZUNWUXdjMENYWnhjbHFuZnRw?=
 =?utf-8?B?cWZkc0dUTUJsSjk5UUdoaVJySWxIYU1lNHNyUlVROSt4LzV5cVQ1SjRaN1Jy?=
 =?utf-8?B?SWd4dmEySXcvWFVhM1VHWEE3UnY0czdLMDhkdXNUemRWRTFITVk3clZ4TUxz?=
 =?utf-8?B?M1dWa1RWckhmdVIybFBwZW8zaDdRWVJFZmc5RnVhREJHazl1V2lwQ1VQQXl6?=
 =?utf-8?B?Ykp0aXFiMEwyNWErZU0xeW5xNks1aEp1OStrblNEOS9nd0JZVlFRdmNpNmxC?=
 =?utf-8?B?NXd1WGM2T3o0ZzY2RkNEYkovaWs0WWN1Z1ZxcitVdlBMRVNyV3BPTUJMdTBx?=
 =?utf-8?B?bGx2SUFTMmpKT3hySlNLWUZpWEpQNzZnSyszRFBYSk1jdzZTZEpNc2ZDRnA3?=
 =?utf-8?B?em0zMGdRVFRSSmRERjdJY0FnNW4zdk1CeHBzY21MYnRhUHplQkN0SHp3Rmlw?=
 =?utf-8?B?OEpTdDVna25RNGYyRFJBMmRQeXk5YUFZMkRlaTVLSExCd0V0S0RGblAvRnJm?=
 =?utf-8?B?Qm42Mk5nYVp3MHNrRlZUSjA3MTU1bCsraWc1VGNBZ3JmMHV2T2lzMVpzZitL?=
 =?utf-8?B?V2JYdlBCOVduRG1OalpDZlZSYkZKSk8yblEvQlZ1Y01wUWhSWjdqMll6ZER1?=
 =?utf-8?B?NWNoaVBCQ0l6QUZWNVVSdkd1VlZwVytDMjBqVXhLaXl4Mzh2UUhib0NDVDRk?=
 =?utf-8?B?TE9JU0tEOG45SThnVEZjbTlqRWRKZjFkaEdFSkIxd1V2TUtMT20zL3J1WVBQ?=
 =?utf-8?B?cC8xUkxVVkNzK1NKVjl2WnlhTmN5K0VXUEF6TlR1cVZhd2dJQ1gvb1l1c0d4?=
 =?utf-8?B?dkFNcEVrY2luVlBtTUkwSWQzakhpTzA4WFdRSGhZNTd6d2U5amtKSjdXWXZa?=
 =?utf-8?B?eUk4Q1VyN1NwMDNxaENkYXhNcTB1M0YzcFBXUFRUczhyOWcycUptQU82bEZh?=
 =?utf-8?B?cFM5alJjcWZ5Y3g2cG1MLzJUcTByRU9yMHpmemVNN0l1TVRyYjdyejVlOW5V?=
 =?utf-8?B?TzBnVGlySlB4VW80LzRqOUpvWFVPUlBkOEZ6SnB3OHBXUWJhdm9qWUsxQUpP?=
 =?utf-8?B?M1hRQS93TFZCV2d6Q2tWSUNCM1EzTm9EdjIrR0JRVVY3UkNrVUU1NGRVcWFC?=
 =?utf-8?B?TzYxbFpiaFg4ckJWYzBoNW9xVWdYMTE4TDRXQmdQL255THNIVHRDWkdmZkQ1?=
 =?utf-8?B?NU9UWWdLYVpzbGIwTEN0Q053R1EvMXRsNUdFZEg2T0hqOG9mQ1pUTFBZK3BG?=
 =?utf-8?B?bGNaWmF3T041S2xxTlBrbWlMZW9yR1plY0lWQXZVQ2ZQUmFSVW9tQk1FMDBo?=
 =?utf-8?B?cXQ4dmpzOXJuWmxvU015SnJDL01mMWh4ektML2t2Y3FKTklHb1h4b3c3d2t5?=
 =?utf-8?Q?OFI1Q+cb+3Ip9yggc6FNe/tbL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48947a0b-7e52-4441-b38a-08dd34f52dc0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 23:42:59.7787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9bA39gTqAP4ofUCDyhOoHtPbp+SzHF0YxPb0BPwBYUB8Q/63MkH37gFxK85p0txbUtTviBV7dgBAan8kQCzdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084




On 1/14/2025 4:51 PM, Ira Weiny wrote:
> Terry Bowman wrote:
>> Introduce correctable and uncorrectable CXL PCIe Port Protocol Error
>> handlers.
>>
>> The handlers will be called with a 'struct pci_dev' parameter
>> indicating the CXL Port device requiring handling. The CXL PCIe Port
>> device's underlying 'struct device' will match the port device in the
>> CXL topology.
>>
>> Use the PCIe Port's device object to find the matching CXL Upstream Switch
>> Port, CXL Downstream Switch Port, or CXL Root Port in the CXL topology. The
>> matching CXL Port device should contain a cached reference to the RAS
>> register block. The cached RAS block will be used handling the error.
>>
>> Invoke the existing __cxl_handle_ras() or __cxl_handle_cor_ras() using
>> a reference to the RAS registers as a parameter. These functions will use
>> the RAS register reference to indicate an error and clear the device's RAS
>> status.
>>
>> Future patches will assign the error handlers and add trace logging.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> ---
>>  drivers/cxl/core/pci.c | 63 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 8275b3dc3589..411834f7efe0 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -776,6 +776,69 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
>>  	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
>>  }
>>  
>> +static int match_uport(struct device *dev, const void *data)
>> +{
>> +	struct device *uport_dev = (struct device *)data;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_cxl_port(dev))
>> +		return 0;
>> +
>> +	port = to_cxl_port(dev);
>> +
>> +	return port->uport_dev == uport_dev;
>> +}
>> +
>> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
>> +{
>> +	struct cxl_port *port;
>> +
>> +	if (!pdev)
>> +		return NULL;
>> +
>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
>> +		struct cxl_dport *dport;
>> +		void __iomem *ras_base;
>> +
>> +		port = find_cxl_port(&pdev->dev, &dport);
>> +		ras_base = dport ? dport->regs.ras : NULL;
>> +		if (port)
>> +			put_device(&port->dev);
>> +		return ras_base;
>> +	} else if (pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM) {
>> +		struct device *port_dev;
>> +
>> +		port_dev = bus_find_device(&cxl_bus_type, NULL, &pdev->dev,
>> +					   match_uport);
>> +		if (!port_dev)
>> +			return NULL;
>> +
>> +		port = to_cxl_port(port_dev);
>> +		if (!port)
>> +			return NULL;
>> +
>> +		put_device(port_dev);
> Is there any chance the cxl_port (and subsequently the mapping of the ras
> registers) could go away between here and their use in
> __cxl_handle_*_ras()?
>
> Ira
Yes, this could happen.

>> +		return port->uport_regs.ras;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static void cxl_port_cor_error_detected(struct pci_dev *pdev)
>> +{
>> +	void __iomem *ras_base = cxl_pci_port_ras(pdev);
>> +
>> +	__cxl_handle_cor_ras(&pdev->dev, ras_base);
>> +}
>> +
>> +static bool cxl_port_error_detected(struct pci_dev *pdev)
>> +{
>> +	void __iomem *ras_base = cxl_pci_port_ras(pdev);
>> +
>> +	return __cxl_handle_ras(&pdev->dev, ras_base);
>> +}
>> +
>>  void cxl_uport_init_ras_reporting(struct cxl_port *port)
>>  {
>>  	/* uport may have more than 1 downstream EP. Check if already mapped. */
>> -- 
>> 2.34.1
>>
>


