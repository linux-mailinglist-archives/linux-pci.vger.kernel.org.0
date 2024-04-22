Return-Path: <linux-pci+bounces-6543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE50C8AD6B4
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 23:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20381C21462
	for <lists+linux-pci@lfdr.de>; Mon, 22 Apr 2024 21:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032101C6B7;
	Mon, 22 Apr 2024 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIl8xQoD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0981B1BC44
	for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2024 21:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821964; cv=fail; b=nMX2RUFchw5wHxTBFw1Tyjcrt83+1FUUT0P5QL4ktKv1dPMC22g0sYCwg5wgWUX96PW6hcIVSm8G8kfCTxwXxEC5nF+cNdqdUtcQiDKcncM0r2U+QftD5PJXCVSWi+4HFH+pJwWASn3WV4r6At287Of6E4Mhj1uPgkfk4k24gDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821964; c=relaxed/simple;
	bh=DlWzC8gv7pEy4eGms/LHd0BcCOEWHZVN+y7kQotPn0I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XDdaiZoSPgZCrS7V8d/RIsBKxNq77BuAmozy8ssqanaDSjD6ituV8SK7t2nv2mwdjszr4z607uNuHcQOC1TjngvGqF7RIXjhdy6jx9KcqvUcaO/nJo3NZMBf0D/IIhFFktS42M8Lup/pvy8HMIkShGIsk6YKMFou9IWXkBtaJJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIl8xQoD; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713821963; x=1745357963;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DlWzC8gv7pEy4eGms/LHd0BcCOEWHZVN+y7kQotPn0I=;
  b=YIl8xQoDMNIMYxPLHCY3RmsSFAFa3j1n5Z3GMRqS6SFqsW6Ri/d4GnEk
   mnKFjOWMZXo/QsEsvsM/6Am7o+iHK2oh6hDR3Nn14lcy8GGTjJ/0TBO5e
   SQv+zF0iIExvMQT2toe071lw6GGTGGs2sglsstGfGWMyvWxsaUYgK3Vry
   dtV8zTXJ+E/xjEDUOH4F5BpwfdlmM83PxUKJyqM269uDboLs/FeRD1aoK
   da7db3f+IPwfW0ZGj4e6EOhw7SEwGONAIOHrnBKRaYwJv22KhNrBmxrzn
   JAD6S2zWcUiNQ0n+2sa9p/ADfxGwopPXyVPFVRTUXrq4U15BIIOuvFGo4
   w==;
X-CSE-ConnectionGUID: UVQfw1n2S2CVzxo42LADuw==
X-CSE-MsgGUID: 4e301/72TcCOrP1U9nw1xg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="26898874"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="26898874"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 14:39:22 -0700
X-CSE-ConnectionGUID: E2esiPM2SNemjDeN8nS17g==
X-CSE-MsgGUID: 47FCcuHDSHKNKwmu17fAyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="24653605"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 14:39:22 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 14:39:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 14:39:21 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 14:39:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UH3BM+CPBbctosw8FRw7uJJ8QPBE4m5qENKe2+l1tS+9HmrVOB0VqH5RiWqQXRREw2knDZeoig/gEz+/mP17PInAi5GqlTlQeGghK1SjFvgUSfH/YE5prtZKJogF4bB8wCdJCemmgP2gNAqM1bdMdXCfCcp9Qq41TKBWycN0Sif1N8XSfbr0i+dRqZXVakGji3uU1HkCGPJ6yEbAkpZql2RBDB3Z/6Et5KDglIFjJpU+noNI6zwTdgqxaxsRkROGbHpjBkMgGuiCgFVSH8KVRoC1SpbpoyrJAvJnI/iB8nNJQWdfe/RweiLjIiZwbh3BTIdq7QZ/8UrAQ22j1c+bCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQhwfLy2ovNJDkLtHJgZA7uRulHoOAG2yjnuLn561sg=;
 b=oO+o5fz2ojrNi0t4+665HbbhxFMBEKG9Vo3N9CTS6QRKY67eGc5wlb4S2ZR23tPhOLXxgaHHFxNoxciXgLDVZc8J+XE9+Z9PFS66eJm49dwQxl9o7EPKNI+uoy3BDEye++jvULpjZYPKfQqdvyJFJqS7FWnieRiFFfaxTBX7NzgMkfVl9xKfurxeH78rNW6xBN3WX2lVcAwmaoTWABDQdocG0hPpWrThbSneNDopGD4AE/LJkkngdqQGWxJ3R3qwrVgsF3J93MneppnZ1FxPiTR8jtgngyTxu6U7AEtU+W9PujTBFAmR9cPXN7nAPDpw3zv3myWs2qAAvVqW1vV+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by SJ1PR11MB6156.namprd11.prod.outlook.com (2603:10b6:a03:45d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Mon, 22 Apr
 2024 21:39:18 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::7c48:3345:4ed4:85e2%6]) with mapi id 15.20.7519.018; Mon, 22 Apr 2024
 21:39:18 +0000
Message-ID: <5ba96aab-10ee-41b4-988b-2609b4d39f33@intel.com>
Date: Mon, 22 Apr 2024 14:39:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: PCI: add vmd documentation
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Keith Busch <kbusch@kernel.org>, "Kai-Heng
 Feng" <kai.heng.feng@canonical.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20240422202740.GA415030@bhelgaas>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20240422202740.GA415030@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0068.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::45) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|SJ1PR11MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e905477-b666-49ee-1774-08dc6314a9fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUkxT3MvUFduYkdzQllRZklVZWc0bHJ3YkFTczNhamlFYk1WdHVlR3crcDN1?=
 =?utf-8?B?QXkyeXJoOUpHaWh1aFBCQ3hnMDVmc0kxK2V5RkhaeEl0S1RNeFJJcmRETzRX?=
 =?utf-8?B?M3pIa0x6YS9Za2RxeEhkNmptZy8xVldIcFl4STNDdUNpb0s3NEp1VEV2OEFO?=
 =?utf-8?B?SEN3RWl2Q0JqdjhLRFg4TFpYekNrODVPNmFtK2FzVnIyZDM3OUFYY29yQkd0?=
 =?utf-8?B?OU05Rk5VcHduSDR2NUtUMzh3b1o3UEd2c0tiY2cvWEVkR0hYOUYwdlRWT1dl?=
 =?utf-8?B?VlZNZk04RmlzcG1pT0R3WUsvQmFmWlZKOGJpV0Q1V3c4RDlVWnRuN3VNeHVl?=
 =?utf-8?B?UHkrbmFsa09tQi9yTExmNWdwTUZpQUczS3J4QUcvRTR5TjNKeWNGV2c2djJX?=
 =?utf-8?B?bDNnbzNhVU1nbUZwb0dBSlNsNTRmZlpsWCswN3FrWiszS3lqaWQ5U0tEbnM3?=
 =?utf-8?B?MXJvK1VYeFJRSUxQcENPaFFoZGxXVkRXc3JLTHozZEpLTHZCaDhQZVgyeTlx?=
 =?utf-8?B?RzgvVFh5eGVna1BYSzdZZldzbzk4ZFdvWlZHMHBibDdSM2tGUHdWK2VlcUFa?=
 =?utf-8?B?YVFZNk9pUDB1UnRFaFRkaVZoaWY4anliaDM0MWtNaVMvKys4cnp5SFdzWGNm?=
 =?utf-8?B?cElmVWZFWTlEQzgvcWdYcjRDckEyQ3BHOHNSWGt0TStlaUNIaG9NaFV4L09l?=
 =?utf-8?B?WTBGMUgzOGE0UXpiN1A5cU1aVTZiTTZwd0Z5eFp4ckxzam1SeUtzeE4rYmFJ?=
 =?utf-8?B?bDM5RXd1R2RWa3lrOVFyM0l6VEZWaGZrZ3RZbEk0TVk5NXlLUTJtTGlMbkwr?=
 =?utf-8?B?c0JEdWVPbEJtMHdCTklyLzgzeEwyR2VTcnZ1ZUhJanBjcjVZa3Rlemo0a3Ux?=
 =?utf-8?B?V0N4bTVGcTgzMkhGTk9tajY4NnZVbEVMU09GampLb2VhSEp6cnpML0ZnSnJF?=
 =?utf-8?B?VVRNenVEeVZvN2NwMFk1dHFrS1F0WFhhSFJoQzF1SHQ2bXBWWGdkSjQ1WmRs?=
 =?utf-8?B?cHp5Yk5UMUdzeWZwWVMvZGcySW1RRzgvU2ovL25Xd2FoRFlmdFpoMFV4L2FR?=
 =?utf-8?B?RG4rSkIvM3lQaHRwbU9abVhzbUprdEEwdUZXeG5wNytUblVPV25NcUJMaXdH?=
 =?utf-8?B?ZnVjazl3SkR4OHBkS3FOY0taREhnVWpLWXNlZmxFU0NSazBtamx4YXhBRlor?=
 =?utf-8?B?YUQzUHFyeDJMM3NRZ1NpalFOaERHREJzVmlaZWFWZ1lVWC9QQlRsZHd1djVi?=
 =?utf-8?B?QW9heWN0MVFTUDIvZ2ttZVBvLzNIUFZYK2c5RlhpTWtpU3J2c0R4V2pSY2Fk?=
 =?utf-8?B?cmhMQnBwYkRqYWU1ZU43a1YyekprREFWL3FvYnBiQWN6eVlxcVFKbk84M0hu?=
 =?utf-8?B?RVYxMEIwVGVGTDdjaHZRekY4VUg4NmlucXJxSTNQenRiSWludnNjOXZwRWZ6?=
 =?utf-8?B?M05SZmZZWXVPdjB3U1IzQjVZRWljemlKMnJ1cTJWalF4dFF5aE5EYXJwWkxX?=
 =?utf-8?B?ZWgxRmgrSm55V0IzNnJCOVNDdUFoWFFmS1EzMjdwRmVkdHh6UkcxSi9VdEM4?=
 =?utf-8?B?Y3crNHppNjA0MTRRRUg2OUJRNjlYVDlZamNMalJoMnI5OGY0UFgrVDI4SmtD?=
 =?utf-8?B?QVRsQWRNa2NpbHI2RmI0QzF2bTB1TW1XY1JCTlZhYkkyRkR4MHVJWE1ocVB1?=
 =?utf-8?B?dE5uYWYwMzJzZU0rRTkvb2dzdmxuMUQ2cURoaHQwc1hoRnhjNXhVL2VBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2s5T1h4ZjIzTGVidEpibWo0UVkxcmpUdG1XdjFhQldzWFE3THRIMUNaU2FY?=
 =?utf-8?B?UEl6ZERYaXFyQzljVHBvSGNScUtvcDAyaWU3Q0Q5SG11aXJaK1cwT2xRL2dC?=
 =?utf-8?B?TW8xWSs0Qzlaak1jaG5Vc0owcUE3cDFkYzd6aWpsQ1dRTm01cU9KZy9URk9p?=
 =?utf-8?B?Q3M3VS8vdExPbnRmV0dBUDN3S09VR1dBUTNYLzlnNFZnN0RJYXkzUUc1S25R?=
 =?utf-8?B?NXRURHZZMnNGQVdQc2dMMmJPZGxJWVkwWmlqTGFBWmdiYjU3YjBhak5GRzRH?=
 =?utf-8?B?Y0FtL0MrNDQyZ1orTk96aU9kYVRTSk12UUkzU01HVlh0NHFpbjkyVytHL3M4?=
 =?utf-8?B?ZEczLzdZN3RsTUxjNDkvay83eWt6SEhzS2lVTlh5MzQ1TnFYYmRtRm5CMENN?=
 =?utf-8?B?SlVQL3B6TTZIcUJkYXdzNEE1Uy9CRHFIUVRrcEJpMkdQVStXUEwzT0pBRFN1?=
 =?utf-8?B?QVpRc1lQbFhwUE5uWWtrMXRuYjVtbVh4WDhFQXl5NEtLbzlaalNOUDd4R2l2?=
 =?utf-8?B?ek1GanFrZ2k4cUR0MjNkN1luUm5mdnZ5aHJyYVZ1VTd6TzJ2WWFTeUlXY2Vk?=
 =?utf-8?B?Wi9zRlliVGMxN2QvWUhBQ0ZpL0xNUndHQUt2VU4vMlpDdnVXdjlCM1hiSkV2?=
 =?utf-8?B?YmFVeEZ1TFdJeWJPeVFqY1B5UEVIZVhna2R0NkdpenFNdmE4b0x5a3BLUWhu?=
 =?utf-8?B?QXZPMUpiVjdoZXVGdnNHRzRTMjZJeVg3Rm9aOUFCZmVORjVzYThnOXpqZnBG?=
 =?utf-8?B?ZVpRdlhsSEROL0VnUE0xcUNzdEs4QlJLSjUzaE1JV0MvZVdMZmZHUGx2TGxX?=
 =?utf-8?B?QW0xRUhSaVBtdDVTNTNuS2ZsMkhnRVJVRStiOGVORzgxaEphalBVdGMwYTRU?=
 =?utf-8?B?S3VPU09yZGZlTk9xQXRpM3ExbHJoMVZzSkdEUWpCZDJYT0kxbXRIdS81bEth?=
 =?utf-8?B?S1E2NWc0NUR3WFV3RUg4SzB6VW9pdG9jc0dTTXBRSzB6T0VxeEtpOEJKbXdV?=
 =?utf-8?B?TGZYeVdVTEhZNjVScTNRcXRhRnE4WHA0WHNyWk00SnpKNGZHSjhiWlIyd1Nj?=
 =?utf-8?B?U2RrRmc3MnpyWDJEVm1WTGxxcVdNZjcwY3MrdUFJTzFHNTk4eC90SEN2NkdV?=
 =?utf-8?B?Q1k0MHl3OU56RkJjNGVLdUNndGhGY2lMZTdkb29BZmhJVUZGamNsMFFuM09M?=
 =?utf-8?B?T0pLek5GUE9LSnRSLzRlbzZScUpIWVoyUFJSY0gzYjZCcTBSdHR1MWRLQ3lQ?=
 =?utf-8?B?NEdrTzBMM0JUU2o4SkszQWt0UmhoMzVJSy9SaTg1U3VKMjVNT295ZG8vMitW?=
 =?utf-8?B?QU9weTlVMURUUTNjQklWYnMrUThMa1JDRXMxYkJzdXQ3Zm5nNzh5MGgwVE9W?=
 =?utf-8?B?RzRKb1J6Qk10ZUdGQnJPNkRLQ09oTklUM1NYRVJnZ3BuTkhBYS9LOXoweWhw?=
 =?utf-8?B?M0VmVVdyNGxvWkNnQWptaTdGeTlTdnZwQ2ZYeXFQejBFMTBpSENPYVlORVpR?=
 =?utf-8?B?aXJZcGkzZ3I3ZjM5Unp1eENSY2Y1MWJ2WG8yU0lPOE5wbENFR3lycFFJREJp?=
 =?utf-8?B?aTJzSFdCT0syYnFIUU5NdVJrZzUrV1A4SEgwMUhRaGpQVTZuTlZ2QVBoRjRv?=
 =?utf-8?B?WVBXaXBINDhjZ1JOQ3p1YTljVWpUQmJlNm1Va3psanFRb1g1U1lzbDRnRkhS?=
 =?utf-8?B?VEZUN1d0Rmd5QnJMZ21HRTlyNTVSNWpuU3Noek5ETnc5S3dEVUNZb1dycVhJ?=
 =?utf-8?B?bHVOY3hoMjhiZHNvQ0wxc3JjbzFVRTFrek9GRDlQM2xobGM2cUM2dU5yN0Fo?=
 =?utf-8?B?aG1WTHh6eFFCc3JHUGVESm1VZ0RCU2RnWGVUK0dITUhJNUloQjZUbnhZY0Nk?=
 =?utf-8?B?cHNsTHM5R2Y3bnROMWwxc2pMYmNkMzBPaXRFTFhWRWh3Mndpa3d5eXFJWU0y?=
 =?utf-8?B?L2tXeFJYOFhUdXpmS1JIOWZwYUJaZE45WXg0andVOHE4Y1BLd0hGUCtuM2h2?=
 =?utf-8?B?WVF2UWF6U0ljVFJxZFlZSjQ1VjhFeTdLYjRHOE52cDI3MWFIWmdxWm9Obitt?=
 =?utf-8?B?cDBqM29WdWpWZU9wRkJwSzRGSUJucHZ2d1BEeWo0ejJWQk9xUmFxL2ZjVEQ4?=
 =?utf-8?B?OWYvc1RJTWRoRTdRSzRkMVUxcDA5VnBKdFkwQ0w1ZW5CZGM0WHhHZEhncEZ1?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e905477-b666-49ee-1774-08dc6314a9fe
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 21:39:18.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAWFvfCR9BiZDlDfQu8+NQcSCoPHAk7HOO43Xg9aUixFClHMVdF6FjBreFpQT6CUK5pYdxUBq4qo/TkYiKe8f8ENITMqPxTvj5DIo3+dZzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6156
X-OriginatorOrg: intel.com

On 4/22/2024 1:27 PM, Bjorn Helgaas wrote:
> On Fri, Apr 19, 2024 at 03:18:19PM -0700, Paul M Stillwell Jr wrote:
>> On 4/19/2024 2:14 PM, Bjorn Helgaas wrote:
>>> On Thu, Apr 18, 2024 at 02:51:19PM -0700, Paul M Stillwell Jr wrote:
>>>> On 4/18/2024 11:26 AM, Bjorn Helgaas wrote:
>>>>> On Wed, Apr 17, 2024 at 01:15:42PM -0700, Paul M Stillwell Jr wrote:
>>>>>> Adding documentation for the Intel VMD driver and updating the index
>>>>>> file to include it.
> 
>>>>>      - Which devices are passed through to a virtual guest and enumerated
>>>>>        there?
>>>>
>>>> All devices under VMD are passed to a virtual guest
>>>
>>> So the guest will see the VMD Root Ports, but not the VMD RCiEP
>>> itself?
>>
>> The guest will see the VMD device and then the vmd driver in the guest will
>> enumerate the devices behind it is my understanding
>>
>>>>>      - Where does the vmd driver run (host or guest or both)?
>>>>
>>>> I believe the answer is both.
>>>
>>> If the VMD RCiEP isn't passed through to the guest, how can the vmd
>>> driver do anything in the guest?
>>
>> The VMD device is passed through to the guest. It works just like bare metal
>> in that the guest OS detects the VMD device and loads the vmd driver which
>> then enumerates the devices into the guest
> 
> I guess it's obvious that the VMD RCiEP must be passed through to the
> guest because the whole point of
> https://lore.kernel.org/linux-pci/20240408183927.135-1-paul.m.stillwell.jr@intel.com/
> is to do something in the guest.
> 
> It does puzzle me that we have two copies of the vmd driver (one in
> the host OS and another in the guest OS) that think they own the same
> physical device.  I'm not a virtualization guru but that sounds
> potentially problematic.
> 
>>> IIUC, the current situation is "regardless of what firmware said, in
>>> the VMD domain we want AER disabled and hotplug enabled."
>>
>> We aren't saying we want AER disabled, we are just saying we want hotplug
>> enabled. The observation is that in a hypervisor scenario AER is going to be
>> disabled because the _OSC bits are all 0.
> 
> 04b12ef163d1 ("PCI: vmd: Honor ACPI _OSC on PCIe features") is saying
> we want AER disabled for the VMD domain, isn't it?
> 

I don't see it that way, but maybe I'm misunderstanding something. Here 
is the code from that commit (only the portion of interest):

+/*
+ * Since VMD is an aperture to regular PCIe root ports, only allow it to
+ * control features that the OS is allowed to control on the physical 
PCI bus.
+ */
+static void vmd_copy_host_bridge_flags(struct pci_host_bridge *root_bridge,
+                                      struct pci_host_bridge *vmd_bridge)
+{
+       vmd_bridge->native_pcie_hotplug = root_bridge->native_pcie_hotplug;
+       vmd_bridge->native_shpc_hotplug = root_bridge->native_shpc_hotplug;
+       vmd_bridge->native_aer = root_bridge->native_aer;
+       vmd_bridge->native_pme = root_bridge->native_pme;
+       vmd_bridge->native_ltr = root_bridge->native_ltr;
+       vmd_bridge->native_dpc = root_bridge->native_dpc;
+}
+

When I look at this, we are copying whatever is in the root_bridge to 
the vmd_bridge. In a bare metal scenario, this is correct and AER will 
be whatever the BIOS set up (IIRC on my bare metal system AER is 
enabled). In a hypervisor scenario the root_bridge bits will all be 0 
which effectively disables AER and all the similar bits.

Prior to this commit all the native_* bits were set to 1 because 
pci_init_host_bridge() sets them all to 1 so we were enabling AER et all 
despite what the OS may have wanted. With the commit we are setting the 
bits to whatever the BIOS has set them to.


>>> It seems like the only clear option is to say "the vmd driver owns all
>>> PCIe services in the VMD domain, the platform does not supply _OSC for
>>> the VMD domain, the platform can't do anything with PCIe services in
>>> the VMD domain, and the vmd driver needs to explicitly enable/disable
>>> services as it needs."
>>
>> I actually looked at this as well :) I had an idea to set the _OSC bits to 0
>> when the vmd driver created the domain. The look at all the root ports
>> underneath it and see if AER and PM were set. If any root port underneath
>> VMD set AER or PM then I would set the _OSC bit for the bridge to 1. That
>> way if any root port underneath VMD had enabled AER (as an example) then
>> that feature would still work. I didn't test this in a hypervisor scenario
>> though so not sure what I would see.
> 
> _OSC negotiates ownership of features between platform firmware and
> OSPM.  The "native_pcie_hotplug" and similar bits mean that "IF a
> device advertises the feature, the OS can use it."  We clear those
> native_* bits if the platform retains ownership via _OSC.
> 
> If BIOS doesn't enable the VMD host bridge and doesn't supply _OSC for
> the domain below it, why would we assume that BIOS retains ownership
> of the features negotiated by _OSC?  I think we have to assume the OS
> owns them, which is what happened before 04b12ef163d1.
> 

Sorry, this confuses me :) If BIOS doesn't enable VMD (i.e. VMD is 
disabled) then all the root ports and devices underneath VMD are visible 
to the BIOS and OS so ACPI would run on all of them and the _OSC bits 
should be set correctly.

There was a previous suggestion to print what VMD is owning. I think 
that is a good idea and I can add that to my patch. It would look like 
this (following the way OS support gets printed):

VMD supports PCIeHotplug
VMD supports SHPCHotplug
VMD now owns PCIeHotplug
VMD now owns SHPCHotplug

We could probably do the same thing for the other bits (based on the 
native_* bits). That might make it clearer...

Paul
> Bjorn
> 


