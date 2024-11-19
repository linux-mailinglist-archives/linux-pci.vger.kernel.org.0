Return-Path: <linux-pci+bounces-17070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7083D9D25AD
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 13:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06ACE1F24B03
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2024 12:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22161CC885;
	Tue, 19 Nov 2024 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e9ZqbUg1"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCCF1CCEFA;
	Tue, 19 Nov 2024 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732018868; cv=fail; b=qE+BFNUI0nKSFuUAaAUox8+/uTZly7aa6Q1M6yqsrKRR0abNgZr/ZcM6hhM84Qu+6q06/CS40ZYh04n9RdtbGgEPEilTMGERFQxZqUx87bo58+Za+IFFJNVYs6mLj92vjt/mMUMyWfGSgiOpDdwsgt4FXEalbe9rrOEnorckyA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732018868; c=relaxed/simple;
	bh=+1ZaOR21bnYpnSXlV18MpPkqaSuVaxLT2BPvkud9dts=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e+kn4I+T59fEvSRm5bhOgnCKHPwNTf3qQoU8Vz/fl6AUry4EhYq2nfpU7JefyoX6YW9CMv4/kzDQ9esJMTsSf/Jk9xhYe3QFL1WIOEPdOpfR0W9c2f7chudmbAZi4NaWXRimec1aIh3NiqO8f0GOqTReLzVeRTluw8LxvUK0V+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e9ZqbUg1; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mALGRry3c3FHB8xTMEelTNEZDbPmID2dBMQGUrTwd0y2beU5jKXsYH7NFKcT2QCwhzN+qDrVuRrOsUCyxFik96grzYVEqHr+1pNrsSG4CVgVnrJ2dJ8jn0YAyEZr2hH/7q9XpEkTz5wZRiF1RO6WFmHHxgOt25dKh6XExgfaPE9UDy93RQqSsNQ9yt6tw/aJv+r0cKRvilecFzKqkb+edK2tfCI2ZAK50B5s2sUK8fzN65zQRcl63HYJWJ/b7rg3FcurV0blSSxAwnM9axJrsrbLaYwK10TjmUr1CL3ohmKV/dURZ1+Pkg9V+wp+gK7V6hXITLlnZUSxPZIqAl6ZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3I/hIKApCa8GET+bAC2T9/nP427QaFyKTYtWv6Nk6uM=;
 b=YmN9p4tvKlS88l2znDhUvKexIrYcEuBMnXNpymBImbTcOjP7awGwfunVMOYEmlOU84mX95JGKpANU8B9Ibq+ZA29MOMtxrv6V4Iklej625kk5HE2UrUpvMk/v7cuFy4TRsgDwiwwiASWKaGGxjaiugF6V95zw2EYY1BNstwhMqamE00uaUhNGo0LaRpfmMpf02AoUHOfIub0kV2Auv/iwRw/6x+AG4qIhLlyM+LbwLpEZHwhu+KoWt1IqPy4+u6HGhRsof+KON0pJqFuN4SLzW0pDzHoRO0bXsZghgJ4vtYSqrqF/HdLYW516kHa1v90gIwiWOx/fYHHXqul+WMYBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3I/hIKApCa8GET+bAC2T9/nP427QaFyKTYtWv6Nk6uM=;
 b=e9ZqbUg1OvGdmWA/PgcRZtEleRdAqDIk0kOMaWSy6i54Tk5oIgEEF0qxR16a1Ic73kz1JIV2X2ykydiEpy3aEl9DvSaUlZX/m3KBIB7wKmu1kxlH1d9PejUwpeueldcry2eNM7hzF3QXTv/v42hafKjBSleprG2xIVLDKa8CIBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.22; Tue, 19 Nov 2024 12:20:55 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 12:20:55 +0000
Message-ID: <081886d4-90a6-411d-a234-cba5d5e997ba@amd.com>
Date: Tue, 19 Nov 2024 06:20:12 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/15] cxl/pci: Introduce PCIe helper functions
 pcie_is_cxl() and pcie_is_cxl_port()
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-4-terry.bowman@amd.com> <ZzYbHZvU_RFXZuk0@wunner.de>
 <ffd740e5-235a-4b74-8bf9-91331b619a7f@amd.com> <ZzYq2GIUoD2kkUyK@wunner.de>
 <e686016d-2670-4431-ad9d-3c189a48b1e4@amd.com> <ZzcKoOXTVVj3bTnE@wunner.de>
 <f8fb0737-3450-4dcf-87a1-3b9f03ec94f2@amd.com> <Zzohn1nGk1-ZpMlc@wunner.de>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <Zzohn1nGk1-ZpMlc@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0174.namprd04.prod.outlook.com
 (2603:10b6:806:125::29) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aeffcf0-aa0e-4f59-cfe6-08dd08949dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXc3b0o2RXVEZnl3TlJjWUJNejRXRFhGeEJuSHBSV05xOFhBK0pobzdpa0Z4?=
 =?utf-8?B?Y3dpZzY4MHNWWUQ1RXUxOFlqTThhUC9zRGVmNnc5eWRzVWJYVHVGdkJ6cGo4?=
 =?utf-8?B?SklqK1NyTklTcmdsWUFZMEQ1VXV4MWlTRkc5SGdndzBIOGxKZlExMEl2cjFK?=
 =?utf-8?B?UVNVZTM4V3d6QTk2NkY2TTd4cko0U094WWYxSWxSU05yTHZNOVZzM0pldGM1?=
 =?utf-8?B?dlJOVXFNZEVTZGZ1Q2xsU1VXVWJFNnUwbmpyOE5DYTRCZ1lGMjJRb21HWGti?=
 =?utf-8?B?YVRPcXpESG9Ib0FCVmY4OGVlWkMrMVJFclNkYmVNU3FnQ21ZazZTeEwwWVRx?=
 =?utf-8?B?cDU1OFMzMHI2Uk5ZNVRmbDJrZUNEY1JlSzdsSEdTQWxiUmorTVdFRUtMeTZa?=
 =?utf-8?B?SUhKOFhnWmQ4QldRcE9uZHhObnpFOXdrT1daSkduV2J1dXRqbVQ0UzUzc042?=
 =?utf-8?B?cmJYMTk0QmdNVHU4TVZYZFZlLzQ4WHFjQVJBUThmY2JISnQzOHE5TkJHRTZK?=
 =?utf-8?B?ZkIrZDZsWWtWVTEvU21LQldneDgrKzVjVWJEM0dLRkV0SG1JSnp5SEYzU2lz?=
 =?utf-8?B?bGZ6ZVRydVUyZ0gvY2krWUFYN1o2VkEvTG1NTmZQSEQyVmtuUGVHaVFtL0dJ?=
 =?utf-8?B?a3J5OXFSLzk0NnZWZkp0SkRXQzA2Lzl4YUdpd3I3dGVBMFFlUGNQMGNML1Q4?=
 =?utf-8?B?QVkzT2pxdG5KM2draU1QTFBJQVZSalFOb2QySVlMd2l5MVB2UytXUXpDM0Y2?=
 =?utf-8?B?Y0NQb2Y3cDMyM2Eyc1I4QnRTTnhvNkJxcWxmNlkxR3FKSHBZdmVMaHhreWJo?=
 =?utf-8?B?KzdYSVFyNkFFdXFjUXBqZEhNeU11cWw1YWN1dUduMWtYU3h1dVc2cytwd0FW?=
 =?utf-8?B?MWE1bFJNNkNXT3RPVkVadWgxd3NqK1dkLytuVXQzTTFqeGJ6TDhSdCtlUXdj?=
 =?utf-8?B?bjVOMS9PZWZaWDFuODl2WXNhQkhKdWdVWmtKWXRTSGVkZFUrbm1ZeDhnV0lp?=
 =?utf-8?B?bExXRk9ib1pwMUVxY1l0STNhK2RpYXdEUGJ4V0k5WjVKcW5BcDNuNTFFdTU5?=
 =?utf-8?B?VVkxQS80R0xycVhERlpGeWUydW5wRkRwVlQ0N2FrTUpHK0ZaVnRRd2xqOWk5?=
 =?utf-8?B?d3NwSGJhcldZTENaQk01S0t1MmpveFVNUi9lVTVEY2tzRzBZZ3hCL1Q4UElt?=
 =?utf-8?B?TVgzb0QrNUR6N0h3bzEzNHpQb3IyZ292ZndIZDZuQkgzY2hqdnR4SVY1bEVi?=
 =?utf-8?B?RDRRQ2pPM1J0U0lRMFdUQkpLWWQ2UG16eFZsNTQ0b05ScGF2NXEyVFFqM2xk?=
 =?utf-8?B?NlJpZkVlNG53bE9kK3NSY3pIZXhYaXZVU1d6TE0vaDZyZnFNOFVXMUVzeWZD?=
 =?utf-8?B?Ym5Xa3Z5Z1B2UnZBZTczK0NzVjBWWFJEUjQyTEFMbXdVZTRnanlENm8zaHVp?=
 =?utf-8?B?TEpYN0NVR3A3QWdkSExMWXN3dEtuMUFDSEM5KzlmTWVxTi9hdThxbEFQVjlm?=
 =?utf-8?B?UllGcVJvOUxSQzJGOWtVYjBZNGhpeEhYMVFyZUJKTHZhQ2pZTXdHdlVLRThI?=
 =?utf-8?B?TUFZcU1TaHp6cDcyNFR1T1Yrc21NSUlGMDJQTm1ZV2hobnVTUXJldmxzS3RG?=
 =?utf-8?B?MFVTQ1VMTTh2aTFoNWx1U2Nrc3FJMW53ZWM5K0hveFppSFZEeHpmVEc5THBq?=
 =?utf-8?B?U1FreVJNWjVaZ2VnL0MydXhjY1ZzY3FDZnYyZjY1WGZyTVdwam9MbmtoS0FD?=
 =?utf-8?Q?tAdrFPbVqOP2r9mmas=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tzg1K2dPYitOOHVOZDhXYVBOUTA5MEgvbE8rQzVqNkhBR2k3Zk4vWkxQQnNE?=
 =?utf-8?B?a1dGOXBNK3lMb1UzQSs5bGlFMnl6WDMxaEtEdi8yREg1SUJSN2RFUTJXdERo?=
 =?utf-8?B?Y3BmeVppcU1FQmZoWU83TlJwZjRYcVRXSG9TNm5MbWx6ZVNwcEF4Y3pmb2lG?=
 =?utf-8?B?dE52RVFLUnlCdnRsMEgrUlJ5MVdoWjVUZ1hmdGFEWTdEdjVvUHA5cUFJZHVN?=
 =?utf-8?B?bmtqbkgzTHJobFFRdE4wV2t0c3U4a3grZWtERUlkTWJjbzdoYTRqcHNTWlRZ?=
 =?utf-8?B?RWRocHFNOXFRVlNYT3FSaE1kZ3JyengvYkZ4OWFyVmM5c0pGaVdla1JORENM?=
 =?utf-8?B?ZkNZaENIUEdSTjRiOXJ1MjBRN1Y3RVhYUi9yVlF0WnNvN090K0VGbk5mb3pu?=
 =?utf-8?B?UlNSeWRySVhjckxnSVhzeU9iMVpvd0lwZVMwMldKSzh4cDQ4K2xSRXdRekFF?=
 =?utf-8?B?ZnNwNENtRU9SUkZUSnJSZjlmM3RoeTdXMnEwMndpcDVabzFSeitiMk1DaVJ4?=
 =?utf-8?B?YkE3QWtxSnZSWm1XWXIwbzRSTGRqako3RllqaDM2Z3ZTTlpRZGFlSHcrQnVU?=
 =?utf-8?B?Z2E0TUZrTzFQYzZVL1EwVnhxbGY1MGJBS0RDaDBEYVBzcmQ3Q3BLV3lqQ043?=
 =?utf-8?B?MllWeUdUTXhEM2JyOG5kVlVCdjBjanZaUGE3OHpyNTJod2hFckFMT1FhUVBY?=
 =?utf-8?B?TlhOQWJDWWUzM2M2aHR0cExTaCtuUStTeHhBN1VURTgzRXUwdU1LMTRhV3dD?=
 =?utf-8?B?K2R3dEVqOHZkSEx3c3lBMjIzL2FzS0tlZ3h0UTYrSXpYUFlXK2VBLzJjQ3ZZ?=
 =?utf-8?B?ZnRkVDhIL3ZCTzhDM1ZkeVZCSmxEallQK1lxcDdHSXRrbkgralNETHhJQ3p4?=
 =?utf-8?B?ZTZJbU9qK2FDdVVURjRadjNJNWNJRGhEQTQxYUJlcm9qa1VyRWg4SVBBcHlS?=
 =?utf-8?B?T2RsNVcwV2oyQmduK21UQ1ErUWY1YmtZT09HOHJROCtVQTl2K1NJdno3WkdZ?=
 =?utf-8?B?K0VJcjBUMG1NV1RGWXVEK2xTcnJqYWV5elVqQXJacG02WFBvQk1tQWs2OUFU?=
 =?utf-8?B?Z3NYMThXc2dEN1NMSDFielo0U1cwVGhjbzhrc2MrazVmeHlFQnM0aC9pc3Ns?=
 =?utf-8?B?V0l4bnlpZkpia0RKTG5LSys5K0U1MXcrU0M5cWErSnJyd1JMakFpMzVjbWRR?=
 =?utf-8?B?UHYrd29zVWdhU1Z5bGJwMHRERDJIRmhrN2R0U0NwUlVpOERKSmFKZEh6K0Ju?=
 =?utf-8?B?RHFiRzBJb0tIV2k3TGFaMHhZVGl2WmlBT2Q1RTI0bjVqZVJwdmM0MHBJT052?=
 =?utf-8?B?R251ei9wcnBReTV5M0lnS0RoM0ZEYTI4S3JHNzVHbm9BRWFlVDQzbTRXWC9Z?=
 =?utf-8?B?RGlJR1pPRjNsbDNpTU5HemtMUWJXSGFMckkyYTgwZnFUL1psbnpLbElreldQ?=
 =?utf-8?B?WUNudXR2eVpRQldNSWkyblNzS1JjUXB4ZUZ6MCs1TU5vbjVmaEJoQnRFWkhq?=
 =?utf-8?B?a0hYZkpqWlg4VnpCUGhtQnp1R054KzdDMWwrYVBKaGVRTjdEZVc5WTZqWDEr?=
 =?utf-8?B?QVZlTVN1Y2RCOTN1VHpzb21uNVlkRDNtQm1RNm00VStFbVJ0WjllMHV1ODRR?=
 =?utf-8?B?NXhFZTE1c2FCR0RMSkFZSmo4bDJyaDRzaUVhaXNBN09aV2syT1drY0M3cXpD?=
 =?utf-8?B?VlFsNkptdnRuWWxWdStXSVE4M1Nsa1B6NnBicks3dFZuTzJaSEY2VEljaytj?=
 =?utf-8?B?ajg4bzUvdHBUVjdBM09ZWjBzandhQ0V6N25qTFdMRUZUNTRzWEtwalEyY0lw?=
 =?utf-8?B?NkE4bWszaXNLT24vN1luYmZqYUVzVGhlMXVnRWxlSXpXREtOTzdJTDNjbmpQ?=
 =?utf-8?B?cENwSGhsUFV4ZUl4RWl3ak1WcU1tOGc1R0RDYUlONkFHRnozZzN4K1dPSWtm?=
 =?utf-8?B?YjB1U0g0UHRhSmsweWNuYStCSWJMand5UXJveWhvbnNGV1lBQ3pWVUxmY2lK?=
 =?utf-8?B?Ykh1cG9IN3JINHQ5Z1JoRVZjUWdqK1RXc3VremVaRFU0N1crZmhGcWc0U0lX?=
 =?utf-8?B?eWs5ZEVuNG9DUHVJS1dlZktZY0ZXc3B5b1h3TUZ3ZzhpczMzUThzSFpYNzJB?=
 =?utf-8?Q?Zy1NN50q4ejxUY3ebWHwm5xb7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aeffcf0-aa0e-4f59-cfe6-08dd08949dc4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 12:20:55.2962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nMkvXz4Df8mj97Sg3z9m9NhxokNOrYQyVESXp19xP8halq88MGb45UDZFDzElPFp+Y+814Z46sSTEArxUossVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493



On 11/17/2024 11:02 AM, Lukas Wunner wrote:
> On Fri, Nov 15, 2024 at 07:54:37AM -0600, Bowman, Terry wrote:
>> On 11/15/2024 2:47 AM, Lukas Wunner wrote:
>>> On Thu, Nov 14, 2024 at 11:07:26AM -0600, Bowman, Terry wrote:
>>>> I will remove the "if (!pcie_is_cxl(dev))" block as you suggested.
>>> Ah, this is meant as a speed-up.  Actually that makes sense,
>>> so feel free to keep it.
>>>
>>> If you do remove it, I think you'll have to move the cxl_port_dvsec()
>>> invocation up in the function, in front of the pci_pcie_type() checks.
>>> The latter require that one first checks that the device is PCIe.
>>> That's done implicitly by cxl_port_dvsec() because it returns 0 in
>>> the non-PCIe case.  (Due to the "if (dev->cfg_size <= PCI_CFG_SPACE_SIZE)"
>>> check in pci_find_next_ext_capability().)
>>>
>>> Another idea would be to put a "if (!pcie_is_cxl(dev)) return 0;" speed-up
>>> in cxl_port_dvsec() so that the other caller benefits from it as well.
>> Ok, I'll look at adding the same pcie_is_cxl() call and check in
>> cxl_port_devsec().
> If you put "if (!pcie_is_cxl(dev)) return 0;" in cxl_port_devsec()
> and move the call to cxl_port_devsec() in pcie_is_cxl_port() up in front
> of the pci_pcie_type() checks, I think you won't need an additional
> "!pcie_is_cxl(dev)" check in pcie_is_cxl_port().
>
> Thanks,
>
> Lukas
Ok. I'll make that change.

Regards,
Terry

