Return-Path: <linux-pci+bounces-40541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E381C3DDB5
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 00:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1330188613E
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 23:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA04305043;
	Thu,  6 Nov 2025 23:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jQ6U9GSO"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD8D23B605;
	Thu,  6 Nov 2025 23:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471979; cv=fail; b=fJmBksDbDwoWHmhskaNNqdU77LyOaKkVpuxgDG6F/gORwr7Necg+oJCJXFMCj7OqPItnjVtZd5pUg0BQSsWaWREsHYD4s2wrwKLc7HD4+tPYeMGhZj/fQl04S5oJge9lrgM+uVPLQNsbxcyqL23tRl1npHsPwFY49GcGAF5TkGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471979; c=relaxed/simple;
	bh=CJyQLXGsrEy36biEr3BF6yQ1x/ttE+dm0xxAOLWL/O0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NP0RISoPkT7XP79mbMqzpaEuaDiOwUSz4blR8HfY5wiUwQVs8QAFRPihHg0barqY8YmUB5ipJ06hggfEIxIOUFaq54KdVBH5Vltnd1ZWDBE+EYBCq4YXOVWEDjU8iFVCG1ZgFR7xvuEd/DYZcDBGqGgHjMxpaieeDAMzKyqurXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jQ6U9GSO; arc=fail smtp.client-ip=40.107.209.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FP5Gayqzz3h1keK8Pb4Zd/u6ZDdZf/TXs2zWTXoeXRJukbaPTZdofVB9E5ZgfGTGeGHhv8jaJ5o1ykNIoZwYbAoiDeXVQYTHvsC/foZdoVjpALY5dXrfvP0KqxsSQh2nmzluBqpoZTxbd6mCp781gtgvE13UzZ6CA+kJzUe82DMzk6F8OLkQxiYijvT7DZXCXbNrneReIUlp3OoZGr98jpMtVqFJvJ7WJ2hHRlIH8lwfH/Wnc6cyhGC8xdr13YXplZaPaXSk275PP2cLZ7dTkCJljA7SWaNq1RCSSDVNHY8AVYZbZsmAp5J8aRo1H/DajraVzcmMCVhxWzpucAekyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzPm8XNqhNmxwMGQfrF6Ne+5QFWPIBn8pNBMseYtR6o=;
 b=WJByFy4PcT79kMx2hVbkV7S60AWeWAvTS+Ne75esRL7Esu9/d1uvu3rw/ybN7vIR6hNUv39BkJnKuHh3kuoeAuzTQJnUBMCztOTEFRvl9JriMtvDL7MWkmztUVp/aaGbKBCvUL3hIiz0q8v5D6tRmmUOP518FZfmlHwRF2HlHllRAIOXiXkFPwci29EDWaovomM4nG+w2BB0/sYUKtnWK7p4V98Bf+1m32PM2kNcnYzZ8jX0UwYfEyCE1xRHHR3SuckMs+zTzjVydmdqL/jAwQWBvYyQKc80k6YpmMhrPg9zFWWatUwuKEIecVjXQdVMkBUZN6EMiLZXVO5WwJaZ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzPm8XNqhNmxwMGQfrF6Ne+5QFWPIBn8pNBMseYtR6o=;
 b=jQ6U9GSOY7Bp0wIoqyNQw3qgiaczq98N3TcW7/7hLLAkRUfaN2BozpSG3P2c33ws2na+uM6xvwBeEmVZPVTBeJYoWwbBx7VNEGIgPQBYXWRFdVdDAJLpZGSXVwoGmNOA3rS8kkEvAW7UjT/k8z03EtWaU0ucY/+ysMVNs5YrOk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by SA0PR12MB4413.namprd12.prod.outlook.com (2603:10b6:806:9e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 23:32:55 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 23:32:55 +0000
Message-ID: <c55f05cb-3c56-4326-b68c-84ac27c28427@amd.com>
Date: Thu, 6 Nov 2025 17:32:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 17/25] cxl: Introduce cxl_pci_drv_bound() to check
 for bound driver
To: Gregory Price <gourry@gourry.net>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-18-terry.bowman@amd.com>
 <aQuOiK8S31w44pYR@gourry-fedora-PF4VCD3F>
 <aQufg2Nfq8YqkwHl@gourry-fedora-PF4VCD3F>
 <aQvO-eBboCOhRDOO@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aQvO-eBboCOhRDOO@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0010.namprd08.prod.outlook.com
 (2603:10b6:805:66::23) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|SA0PR12MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ad9e22-eb3c-46c4-71e9-08de1d8ccf91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGsvcUh5cFJoSUhDSHhkcHJvOU1oNGMvbUNGWnV3anpocDMxL2F2Um93YXpT?=
 =?utf-8?B?eDl2bXhhb21ZNGZETHpHOFoweHVBbjJyTzZYUFpjZlFSUHhHRG81RkVmaHd2?=
 =?utf-8?B?azRKTVA5WnFPQTltdS8rZSswNXdPbFBJTHRlZjdpVnFuYWp6WTFWOGNVcWlV?=
 =?utf-8?B?Z0d6aXN2KzUvUk9QOFZrMzVCa3kwMnc3djNPRElmeVEvSmRXNE1FVStTZjFn?=
 =?utf-8?B?NnJldXJZaXdHNFp5ZFRGeGthbWVuUkJRblJ1bEhUQXY3VjR2ZmhYSlJsYVZh?=
 =?utf-8?B?T2dKTWYvMkQ0MG02UXJHM2YzM3psWWdmZkZsckN6QmJoUkFxUmJ4a1NtTWZr?=
 =?utf-8?B?NmNWdmF3YUoxdlV0QncyV0RRa2Z5dk55bmpMVHk4eEZGZlBFMU1iay81emFN?=
 =?utf-8?B?RlFNQzBsSWU4NDlkNEF1MG42L0UzNWlzOStCdXdiTGdtZFB5VEZzTVg4ekd2?=
 =?utf-8?B?QjY0N1pIWUtnWXhHLzVqZzlqUUVGVVlCSlgvaElRd3FrRTYrVDBmR3MreWt3?=
 =?utf-8?B?TlpkSWdPMGlOY0Uva1BVNWV1S09qT2wreFNwWDZQTnhWM3JvMlE2S01OM2lQ?=
 =?utf-8?B?UUhQZXIvdVFXVmNPTFVkSllPQjIxSkhWMlRYaUgvNi9PN0hqOW5zUVN0Ritv?=
 =?utf-8?B?N2duSTFBYzBGZzR1RHltRzVoaHduSHNVNDh6ZmdvSnl4MzFrQ1FLY3pyM0Iy?=
 =?utf-8?B?Uk5zRFNaYTM3N3NPb2hZTGlWcjZRR1dYYkptMEtPazBrdEtoZUp6RkRuOXpa?=
 =?utf-8?B?eVdMOGR2NzduU2VBbGdiV2xiS0ZpckxQWkNjcjhoZ3UyS3pmb1d1SHBvWjVz?=
 =?utf-8?B?bFQxRUVzejliRGxISXR4V0VwUmt1MWR1RzBTYUo3K1BGRkg0ZUV2RnhqUkdm?=
 =?utf-8?B?ei9DQjl0WCtmOSs4ZUhCMWdOeGZjYW5TN0orSzJWVHpkWnd4TnVyek51YjJZ?=
 =?utf-8?B?K2pGdmNWS1czQlpjLzVkRkl6d08wa0UvSDN4bC9Ia2ZxL1BwajhZdEM0cHJW?=
 =?utf-8?B?WlNKTEJBYSt1bzRBQkI5d3AvTzVqazJQY1hYZ2s2YkdnZHdhUUgwV0NmalpI?=
 =?utf-8?B?eEZRc3RvS3F3WllQdGFDQUtLRTEvcFNyVHowbEFjaVdoZUNBdERlR2huZnFF?=
 =?utf-8?B?L25mRWcvR1pUak8vQjFzTmdjZnRUOUcxZHFlWm01SzNXZ3RBY041dnNIeHhN?=
 =?utf-8?B?OVhLTk45SzJLWmZYTVROR3R4MGVqL2pIQk15NWUvcVNmSDJMSVpYNG1sRHJi?=
 =?utf-8?B?UXIvN2lRdHkxNFdsN2ZQVVp0QTNSMDVsQTR0R1N2ak1OTk52dkxuOXB5TG5t?=
 =?utf-8?B?cm12Q05mOXBzUGdTQmp1UUNOYm95dHE1WFpwZEpQeHh2dXlrdGZTNkMra3lP?=
 =?utf-8?B?aDNSMHlGYTEzT0NGVGpSRzhxM1Vpb0tvRUVLZFBYNDY3blBkbGFJRnpobXZ2?=
 =?utf-8?B?U3UrNExXMmZCMUNPTENST3pkOEJ2TEZVT3grdCtJanpwUUprMWR2d3B4NUVU?=
 =?utf-8?B?ZGM1TjZGa0tyaU5VMnE2Yll3ZTFSN0x3bklySlhlanF6a2dWTGdPNUl5YTQx?=
 =?utf-8?B?TVRuTkJhV21IK29WSzkxZUJMTDJWMEtCRTltbERrS21lbFFlVmRweUNQMTYw?=
 =?utf-8?B?ZlNFMmVPaTBjbG1ZSVVJVzdTcW15M1JnYmdpN21MelIwUHdpYTdrUXd4VlBm?=
 =?utf-8?B?MGFoNm5mTW5NZTVCNGR5QzYyeWxsdnNpcWM1YUl2cW5yQ3o4OE5TT081NXc4?=
 =?utf-8?B?VlF5bXpsOENuMndnNHZaVkZ3VEh5MDl0WG54MjBWWUFSejBEOGRsLzVPUXRN?=
 =?utf-8?B?S0xJRVB3bkx1NXN5eGl3a0JsMVFRaWpvc2UrdWVobVd4cmlFQ1l4WmV5SFVj?=
 =?utf-8?B?cmxCcnRKQXFIYmt5UFlkRUhyMndyTlZyelNCaTRVQjU0ZEthTVNZYW92QnRS?=
 =?utf-8?Q?NMusoZuMFH5p23gQ33UHNc+sM559BIqM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bndSTjhBYUJQQzgyM2RMQ1ZjRGJPeDhDQ3JGU3JZNGZHeUFJTHJ4ODBrOGFC?=
 =?utf-8?B?R3V3cGpmUWZySTEvazRQK2ZqTloxaktpL2FvanlPbXNaMWtpYzFCUEJpSWU5?=
 =?utf-8?B?b3pBZEFxa3IvZVZzd0tnMEdRVWFqK210S0hJblF0YmFGSkhjREYrY0djbm11?=
 =?utf-8?B?dWZvNUdyNUsxVHVGOC8zV1Zxb1IxVmYwWWxPSm0vY012eTNrRDQvVTYzQm1y?=
 =?utf-8?B?QldlU1pndVZLVE1QT2xZWVV0b1ArUm9XVzRML05yT3JMM3JpL2R0R0g5cDdH?=
 =?utf-8?B?elF1VHhWTW56VWdBeTNiWjRxR2R2NExIN2luMldPYTR1bll6dEw5cXhNMzN5?=
 =?utf-8?B?OXBzc2pyNFB3TnRDTUROTnFTSEs4WTQ5WmNUZ2grZU51a3V1NDBLa0xwc3hP?=
 =?utf-8?B?QXF1ZUhRalZNSS9vdzN6QklBTHdpbTY3SzZHRWZrbXM1bHUyTUxPSFhkbG55?=
 =?utf-8?B?QzRraTkxSTVlb0tiUU1Ia0pML0d5aEg0Y0lrd3VtNVdGOU9DWDRqcGdXbFJI?=
 =?utf-8?B?alFnbzA1cXdiSEowQldtSWFvYkw1NlJISE04WUN4eHQyNnN6NmE0RHRHOWoz?=
 =?utf-8?B?ZzF2d1NtaS9wdERGQmdnaHYvaWkyeFZLOG5OSHAxMlEveSs3Mml6YzdpbjZt?=
 =?utf-8?B?WEszZng2Mm15R0prL3pDUE8wOUR4TWhJTlJNOWZZUmpKWE9kMFpVWUNZeVZI?=
 =?utf-8?B?MUMwODdrenE3MndzVnNWTlZPeHdTZ284cWI0Y000MXRvQmh3QkN5amZXTDdO?=
 =?utf-8?B?ZUJtZDFuQjVTQTM2Z01VcldvejdEL2J1NE5xNk1RWjlNemxtV3JCQ2g3Zno5?=
 =?utf-8?B?UC9ZSWVqVFFlQllKQXN5NnFNSUJaUWNTcHNnU0JJWENzbi9BNURkM21FKzEw?=
 =?utf-8?B?Tm9KT1pzb0Vob2VadXZiVmVrV3RHRTZxS0NnSEFJdzAxSGxvOElKOVZYS0Fl?=
 =?utf-8?B?OWV2Mlg4TExHVC94TTgwOWVjN0x3aG0wL1FtY0xBZ0NhM2FGcW5Ja3ZQQUxK?=
 =?utf-8?B?TTRkWFFXbitMQUd2Y2Y4eExkZFNndTllTWNORFV0ZDM3cG83bkJXWDBBSmN1?=
 =?utf-8?B?T2JrZjRCRUFZZUhJTGFWeFNFakZ6YWs3NTFjOGExV0djaVh1RVhKRndVaXRn?=
 =?utf-8?B?dXcrcTJ1RlVTc0wxR0tlTEx2R05CMFdqUlNJSTN5UGljTFo3Y1lDYkhUUDNQ?=
 =?utf-8?B?bVZ4bHRTby9FaHNDRlNVWWcwL0VEYktVOG5ZdUl0aFBHK2hvQnFmcWFIR2tr?=
 =?utf-8?B?ZkJ6bnRCYVVjbk4yMVlNdzdENkVHU0JSMEtyMjNRQTc5ZmlUS25HWCtMN1ZN?=
 =?utf-8?B?UDFDYUVmQmdKM2NhU1VsbW41ZzdEYnpmeDMzNm5WdVY1ckpndEN0a29ITEdD?=
 =?utf-8?B?OHg3YjZnMkZLRDVhUERVM0dvZ3UzeElYdE53clF6Sy9xQ1h2RnZsN2tJanF2?=
 =?utf-8?B?Mml4YU05NytCemFUWk94UWtERWJsdHg1RkoxbFJQLzlCWEw1ZzczUU5JdWVq?=
 =?utf-8?B?aFl1bWsveEduSkFrbnpmaDZCTmxpaVoyeDdmck5FQk5VdTlvYjBYTjNVQVV0?=
 =?utf-8?B?MjV5dU5KZFhvQ01UTlNJV2pZZnYwTjQzclg4K0syRjIzc24zU3FhV0t3d3ZG?=
 =?utf-8?B?dTFsMTB1QjNoeGNld3FwUG1sVTBWZmU0MjVCWjdaQ2oyd1J3NzJqaUpMa0Qw?=
 =?utf-8?B?MEJsK2hpU2JtZTV6WU1pcU8zcGlOWUd4UWVyZ1IrNFo4d3h5eS92bktMQ1Vw?=
 =?utf-8?B?TkhEVmhYVW9aOVZQOUVNZk5TSFNZSkRwM0ZtbHFqL08vTnFhanNhNWYvUWI5?=
 =?utf-8?B?ZHdIcUhtSEs5T0JNTmg1Zk44MUgzKytuSXlsNTNpSU1rRC9QS25aWEc4Rllm?=
 =?utf-8?B?cTFvTmRiNjd2YWs4WEVSVis2bWJVRlZpbzlWbDNtTjBPWDA0ci8rdXNNVnZT?=
 =?utf-8?B?Y2VmU0lYUlk3bXBTYlEzbG15c2l6RlJDRDlGaEpPUjNTWWFERkhLVUdidnJG?=
 =?utf-8?B?bDVXa0FzUHdMSUMzeU1wNHpwbmZqSkk5bklJT0ZXa3FVQ1Q3R3dudUNhUHlx?=
 =?utf-8?B?VTF4blJZMVFtcWxtMGZ3RDdkcTltOG5TNkhKMG5rS0JoekZYSFp3OFBJV2Vi?=
 =?utf-8?Q?N7jacg1i1yBk61fawlucFOJRP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ad9e22-eb3c-46c4-71e9-08de1d8ccf91
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 23:32:54.9867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBUl613yv/BrsAk++iGwSMd03/OscfN6nLhh2vSodd5IXgRCgaemmrFalbv8ffbEWaEfOqwo05wBuez+LIzc0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4413



On 11/5/2025 4:26 PM, Gregory Price wrote:
> On Wed, Nov 05, 2025 at 02:03:31PM -0500, Gregory Price wrote:
>> On Wed, Nov 05, 2025 at 12:51:04PM -0500, Gregory Price wrote:
>>> [    2.697094] cxl_core 0000:0d:00.0: BAR 0 [mem 0xfe800000-0xfe80ffff 64bit]: not claimed; can't enable device
>>> [    2.697098] cxl_core 0000:0d:00.0: probe with driver cxl_core failed with error -22
>>>
>>> Probe order issue when CXL drivers are built-in maybe?
>>>
> moving it back but leaving the function seemed to work for me, i don't
> know what the implication of this is though (i.e. it's unclear to me
> why you moved it from point a to point b in the first place).
>
> (only tested this on QEMU)
Thanks for pointing this out.

I expect your changes will not work when using loadable modules (m instead of y). 

It appears cxl_pci_probe() is being called earlier due to the changes. The call stack is:
cxl_pci_probe()     
  pcim_enable_device(pdev);     <---- Silent exit here because cxl_pci_probe() fails below 
    pci_enable_device(struct pci_dev *dev)
      pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
        cxl_pci_probe()         <---- Returns failure due to resource reservation failure

Brief testing is showing the following works:
@@ -922,7 +924,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
        rc = pcim_enable_device(pdev);
        if (rc)
-               return rc;
+               return -EPROBE_DEFER;
+


Terry

> ---
>
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index ff6add88b6ae..2caa90fa4bf2 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -12,8 +12,10 @@ obj-$(CONFIG_CXL_PORT) += cxl_port.o
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>  obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> +obj-$(CONFIG_CXL_PCI) += cxl_pci.o
>
>  cxl_port-y := port.o
>  cxl_acpi-y := acpi.o
>  cxl_pmem-y := pmem.o security.o
>  cxl_mem-y := mem.o
> +cxl_pci-y := pci.o
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 2937d0ddcce2..fa1d4aed28b9 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -21,4 +21,3 @@ cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
>  cxl_core-$(CONFIG_CXL_RAS) += ras.o
>  cxl_core-$(CONFIG_CXL_RCH_RAS) += ras_rch.o
> -cxl_core-$(CONFIG_CXL_PCI) += pci_drv.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index a7a0838c8f23..7c287b4fa699 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -223,13 +223,4 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		    u16 *return_code);
>  #endif
>
> -#ifdef CONFIG_CXL_PCI
> -bool cxl_pci_drv_bound(struct pci_dev *pdev);
> -int cxl_pci_driver_init(void);
> -void cxl_pci_driver_exit(void);
> -#else
> -static inline bool cxl_pci_drv_bound(struct pci_dev *pdev) { return false; };
> -static inline int cxl_pci_driver_init(void) { return 0; }
> -static inline void cxl_pci_driver_exit(void) { }
> -#endif
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index d19ebf052d76..ca02ad58fc57 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2520,8 +2520,6 @@ static __init int cxl_core_init(void)
>  	if (rc)
>  		goto err_ras;
>
> -	cxl_pci_driver_init();
> -
>  	return 0;
>
>  err_ras:
> @@ -2537,7 +2535,6 @@ static __init int cxl_core_init(void)
>
>  static void cxl_core_exit(void)
>  {
> -	cxl_pci_driver_exit();
>  	cxl_ras_exit();
>  	cxl_region_exit();
>  	bus_unregister(&cxl_bus_type);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 97e6c187e048..a2660d64c6eb 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -941,4 +941,10 @@ u16 cxl_gpf_get_dvsec(struct device *dev);
>  #define devm_cxl_switch_port_decoders_setup DECLARE_TESTABLE(devm_cxl_switch_port_decoders_setup)
>  #endif
>
> +#ifdef CONFIG_CXL_PCI
> +bool cxl_pci_drv_bound(struct pci_dev *pdev);
> +#else
> +static inline bool cxl_pci_drv_bound(struct pci_dev *pdev) { return false; };
> +#endif
> +
>  #endif /* __CXL_H__ */
> diff --git a/drivers/cxl/core/pci_drv.c b/drivers/cxl/pci.c
> similarity index 99%
> rename from drivers/cxl/core/pci_drv.c
> rename to drivers/cxl/pci.c
> index bc3c959f7eb6..e6d741e15ac2 100644
> --- a/drivers/cxl/core/pci_drv.c
> +++ b/drivers/cxl/pci.c
> @@ -1189,7 +1189,7 @@ static void cxl_cper_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
>
> -int __init cxl_pci_driver_init(void)
> +static int __init cxl_pci_driver_init(void)
>  {
>  	int rc;
>
> @@ -1204,9 +1204,15 @@ int __init cxl_pci_driver_init(void)
>  	return rc;
>  }
>
> -void cxl_pci_driver_exit(void)
> +static void cxl_pci_driver_exit(void)
>  {
>  	cxl_cper_unregister_work(&cxl_cper_work);
>  	cancel_work_sync(&cxl_cper_work);
>  	pci_unregister_driver(&cxl_pci_driver);
>  }
> +
> +module_init(cxl_pci_driver_init);
> +module_exit(cxl_pci_driver_exit);
> +MODULE_DESCRIPTION("CXL: PCI manageability");
> +MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS("CXL");


