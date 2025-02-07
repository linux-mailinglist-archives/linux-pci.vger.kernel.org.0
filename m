Return-Path: <linux-pci+bounces-20931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD11A2CB84
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 19:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83BFF7A56FB
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C0B1D0F5A;
	Fri,  7 Feb 2025 18:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B3p5pd32"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFC41A0714;
	Fri,  7 Feb 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953333; cv=fail; b=PKgAqShiCqfU5mfc9iGWhd8R4sEwlwGj2Z9rLQ64xBJlu8XG2LGy1RTP4dqUtqCWoAVi5A9xGJOr47H29TlFb8xanwAvP/b27nPMxEgSoMsqRNDoweMAZwEHbtcKi7bOryQufdo+gR/QdTBBmC49c/fqxEid9qQpv0z9Ch5+1So=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953333; c=relaxed/simple;
	bh=YfCfkucDwFyktonJCTzCofFlqWZNbz8aZDT56GuM4+Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tXyIhVzny+qXVlvwVVq4PpeMEFy2z6trCIP0LjUpAFeU3GxXIKbUitHbQ+bE13bSH1G2Nmc7FBu28MKYx7acSEcZVg2fqe3zKbCToya1iCSRn+YW91jhb4Tew+K/+M+FhwVtjuCj38ri372vH1OuexJUBwBicFo25PUeeByoA2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B3p5pd32; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQGKanuHoOTATye9JOMLmI5J4RU2mby2rleaMIn5v083hg66uxRcwzJHiDMNEtoS6JrZ29UqWc1mB6qOVL/UICNaYBlwnQgNmcSYEkQYWFJooPe8WlhazzfrYV4VzLPh2mQBioV9NUwCyguX+sCr+eLi8pyt+Q/4Ybe8wscrIfnoM9dxxdPSwMGrmzFRhVn0FOOb3gnfc3gsw2leasjA1pQIu3NuWwkduNKnyqu1igk+op8gDv+nzUv+2YQ7wBvIlHPhhEQN5iHxuTSZWrsM8kcLCPaBkUVyrD3WTpKoDfr742CD+6QhFzUz2O0XxjXzeIi3VO088VyChaO8ToGTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfCfkucDwFyktonJCTzCofFlqWZNbz8aZDT56GuM4+Y=;
 b=rSZqNK3LzdYd6iGwy8po/gffrFdRYgujYc9VGq2nLpLk9BUBoWl1yMs4ASXmao+Ol8Uugl3Ecv0E3NEgLN/m7xh6rVT4/D9/P9MsMQ6PPLmULd0siNDBNVN9E4niA6yWvdULD1M6inSU/qTNBvTaxICyvl2klo+mXLCtKHRDtEfbOr9g0laKprSY06BCzaiF8lD/diGoF8F9tQycW3M/OpQZUeGe+6+haE7CxhTWBJHiYrmGDJFaokK+pnhgd0jYyflh6oX4N3dgPmJIz9rb/pAibawYrYMGqFyB28C6s/+Ql/aFbLyQwmErR51W8vIjX10X9v0C7RHGjIoe0WV3RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfCfkucDwFyktonJCTzCofFlqWZNbz8aZDT56GuM4+Y=;
 b=B3p5pd321OmX5NrXEhqbeEvWHRYVlFtVWE0NUuXI899oHzwRE4wudwsr9n0rh44DOk0BZIAUhokwxmXfxm4reNko2Qdf5xkT/vcXn+ji2Y6oGQIY/q31Os82WEtiuJv6CW8TNjBpUn5PHUYRSmtyy2GydI0oKONeRL0khvkZfeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.14; Fri, 7 Feb 2025 18:35:29 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 18:35:29 +0000
Message-ID: <bacd6448-e327-41f9-aa5e-ef8a7522fd43@amd.com>
Date: Fri, 7 Feb 2025 12:35:25 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/16] PCI/AER: Introduce 'struct cxl_err_handlers' and
 add to 'struct pci_driver'
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com, alucerop@amd.com
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-2-terry.bowman@amd.com>
 <Z6Tq5mWoxiD3LyQ3@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <Z6Tq5mWoxiD3LyQ3@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0008.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::12) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: e07b0b76-cc6f-477d-8c55-08dd47a63248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHdiZDM5cUplZnROQW5XdEtIZDM4WHdtald0K3FDaGJVcnNWdE8yV3o0UmEx?=
 =?utf-8?B?TEtnMkpobUwxcG5xb1B2bW1ibEs2eWRFZTdGMFBqa3c1YnZtaWVFVEd3N0lI?=
 =?utf-8?B?eW1qeWgxWkVja3AwSC9CVVp0eWRsNkVEd2drbUZEbHFzNzRqVmwwTE9YQWlY?=
 =?utf-8?B?blVUTHk2RHBhNTZ6TWlxa3YvUmRxZTdVUElaVVZTNXhTajZXRnlmVGJ1Mm9t?=
 =?utf-8?B?M1ZqMUdFQ2dQa2dyd0c5eW91VnF2SWwwaVExM3B6RFJOM1U5b3lZampOM1hy?=
 =?utf-8?B?NWVKbDRrL0Z0S2E2bnlzOGdMNlBYQkttMVY5WWI4VllRK0o4NEpoME1iL0ZE?=
 =?utf-8?B?eXB4QW9SakZHUWt5QWdtN1JUdmtuNnRlN1BPY1Z2OUExT0U4cDFDb0xGYTUx?=
 =?utf-8?B?bHRNRzc2Y01kRW9TMjZ0OS9JS3JOZkdMTGdPU0xjV0RRWTV5N0V6RjkvcUEw?=
 =?utf-8?B?RHBmU2NpVmNPNVl4VDZGWHpMeUl2L0VHd01WUlFEeEp2NVlBbURHQmxFOVM4?=
 =?utf-8?B?cWF0dExXWjhJZSt1MmFZcFA1aGY2dDA1Yk9yMExtNGszaTl6cVRXeXp3SStV?=
 =?utf-8?B?ZEMwbkk2UE5heUF4SWlFRWNCek1wZ1BNblJiRkIvTXFFaVg4OWZSMGZZWTBT?=
 =?utf-8?B?cWprTnA2dkJxdXNTVzZWRGZhNlJTbTAza24razRMUlNnTFM5b3ppQkFZZmtF?=
 =?utf-8?B?WjV4VXNESWdKaDcxdXB3NmlRdzR0SHFYbndmaDVVdlNpYXU2ZGVPWVU5VFRO?=
 =?utf-8?B?NnRONGZMUGxVQ1I3V0JSc0NFSnZ2WkswK2JzbU0xc2x5VWxBZ2FGb0RibjRP?=
 =?utf-8?B?bnQvS0NRMHVObFVjZ044ckRUR0drdE84MStQbU81Z0p2ZGlWQ2pNUFpQN0Q5?=
 =?utf-8?B?MWVrVm9LaXJQZkl2RjUwanlLa01xMGhpY3VKN2ZidHRubDVBanJhbVNkTFJl?=
 =?utf-8?B?MW5xdmh0K2tkSVJOWXpKSmdxeWk4aFBiMmR4bFhaUGxBSnZubU9aODJRNkFN?=
 =?utf-8?B?QThHdmkxbUJIZEV5OSt4ZGNIVjZtQmVVdmNtQTV3WlRralM2dDJvV3NmWloz?=
 =?utf-8?B?dDVzUHVtcWxYQ3BES0xlcHZqb3F4dTd4UlJGWGg0UTM0YWJTQTBzMHN0a3Vt?=
 =?utf-8?B?aXBFRENlQ1Vrc0pwckxTWjRVTUFiNy9DY2greWtIMDZDQzAzTXlyeTRpQVpN?=
 =?utf-8?B?VndEbW9RcTJ0VjhuVVhpSllyMVBLdkRhOTVnbTRXQytZM2hZVDJkWXRhb0Vp?=
 =?utf-8?B?dmJMZCt1N3N3bGJJOVozSUwvZVNza2tqb3FyWFJ5RHBDOWRyRFMyV01FeFFJ?=
 =?utf-8?B?YmFKRCtMOTRmMXZ3OUNYRjM4ZW84YnVHNEluRUtzaFhOT3JVenpmVVMyUmls?=
 =?utf-8?B?dmtUNHBoNTM4WmtlaXJMejBxNXV6QXhZdTVOeVZBeS9BUWRucG1FMG1HcUtR?=
 =?utf-8?B?dFdhYmJ4YTRvVXRJdHRrMUFTekJwbGI0WmN3anA2UWFsSG51NmZuakJSMkZh?=
 =?utf-8?B?c0EwWGtObTBHYktRMXgwelJoNkJsbU1FTHpsRENxQnFIb1c1NlR6dFd4YXRG?=
 =?utf-8?B?czJhRCtXeVFlRnU2dXp6TUxnM1BFenVLMGR0Nm9KTStFU2h0bHNUUTU1V3E2?=
 =?utf-8?B?cktWcXcyZW1LVm1NR3pJamdNb3FNamtOVG0vQ2ppbEhZWHYrNU5yV21RS3hy?=
 =?utf-8?B?eFZoY3A2RDZkMjB6Z1FnWGVyYStpRmMwK2VKZXBOZVlxd2NjeStBQVB0NVZS?=
 =?utf-8?B?MjAzdjhLemo3Ri9aTC8yQnRub0l4bFdwNFVMNThzMUNPYTd3cHBOVUYvdFV2?=
 =?utf-8?B?dXE5V29PSWtmRkkxNk5LWjdvbGdOc2t0ak9RaHRtZFhIZTFPMHR2amUycWl5?=
 =?utf-8?Q?0NXh/YVJ7iFb5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rll5MVpTLzNtajd1b0YyN2R1Und0T043MFAyTzdjeDdvZm1RWjIxTWppd1RD?=
 =?utf-8?B?RW1rZk03VG91Y3k4eVVJKytCU0hoTHlmYUZqMXFDdzZsTkd5dHBDaCtGQ3BL?=
 =?utf-8?B?VGFIL3dGdzZCTitNdEZ5VDBHWnU5cGpZY255MkYyVmVnQ3RVaUtsNXp6bExo?=
 =?utf-8?B?ZXBBNEg2aUY0RHdjV3VrUmFSUEVDRk0zMVFrY3I4RDVHdmVUNWduWjFtRGww?=
 =?utf-8?B?bGtUTXlKb2g2aVp0azJ5Z29Lemp6V294QUovR0FKamFpaTA1QkFtZGZZeXNl?=
 =?utf-8?B?Nkl2YWN5dUNaYkdqdmViUlBzeWx0WVFhYW50WHRvQTh5M2dLVDZBbWdZVkIy?=
 =?utf-8?B?SnJwZUFIanB3SzZZWmNPZk85RzFzVERkaERvYTloSE5JVDRGT2lwRXM1OWZ2?=
 =?utf-8?B?VmlRQVhHeUR4YmVJMTNHZEdrK1ZtTEFpZ3o4M3JqSHgrTHQycjdJR3Q5cXdr?=
 =?utf-8?B?U0FzTUNQb2tCWUFOR25YRGFvM2p0b1FoRE1DY3pDVXpwVk9GaHQzN3NYWDdu?=
 =?utf-8?B?ZEQzRHBZWDJuVUJKOVgzVXBaTDQ2ZUxuLzhHMnFYUXBpVEQ0ZUc5eGNFak5L?=
 =?utf-8?B?UjRjMmdmTlFFQ1BVRXYyeitoZFZLT0llcUQ2a3dJQjE2MlFFREJoMWxzdXhw?=
 =?utf-8?B?b1I0OENpcWYwQ0RwUUl1QWh5YTlISjNRU09wTVFlVWlwNnV1UFBUZGVCRzBh?=
 =?utf-8?B?S0hPYjFicjNDNkFRWmpkQUkrdzRDaGZQaWNGV043SnR1SWZYTTljeG40MXdD?=
 =?utf-8?B?S1Y0QXhLQXFGZXRVNTdMNktCcWhNb0RkU3VnZVJCV1FwT0NITjluUFQ3Rzkw?=
 =?utf-8?B?VE8xTjZPUmxHbktiKzREVUpqYmt6a29nTjF4TGo5NFNqTG1aU283cEh0cnRW?=
 =?utf-8?B?WkpBU1djMWxxMHZndGFyWFJXcnR6bTdoUWhYOExWbktqWmpRN1N2YW1VVVU1?=
 =?utf-8?B?VnFIcFAveDNpMU5PNjR1QUVTWHkxMUFPbjl2WnhrUER6Qkg3OEI3YmliUHZ6?=
 =?utf-8?B?ZUVnQzZQYjM2VktaZUd1RjRtcFdKU0d5K2pGWUZ1dFFOVERYYmdhclN2aTlW?=
 =?utf-8?B?RitnTGx2VytUNVU1a092YkFETkdvS0hETVVkL2ZVK1JCSzhPMUxBcEkyV2g0?=
 =?utf-8?B?ZTJ4MlFyKzZxY3NnN1h4dVZwSGlaa2dpWm5SdDBDaE9EazY1b3FoTVAyRTVR?=
 =?utf-8?B?OUtHcm1NUDF1MktyeTZFZFV3d25VeW5BVkdQZVdqd3lCU0lBMWZZWkk1SXMw?=
 =?utf-8?B?NFQ4cE5xRzRpMkpTS3hmM25udDB5aXVoNUEzM0liVldpNGRKaWNhREVKRGw3?=
 =?utf-8?B?Mi80T0lDZFNMN3hKczdSeDBITFZkZU5NNVIxS0hIeXFHaHZmNHg0RFRwSUJ0?=
 =?utf-8?B?N284MUIzTy9NZTNidkdjUXZmZ3hEOVFwV3pQOEZWRUxkYkFyMWFxZU9UVklX?=
 =?utf-8?B?cm15ZGVSTEU0QmE4RW8vUHhyYnBIT1NjdVVJMmZSR0ZxVm83aFdtdk5jSFEv?=
 =?utf-8?B?WEJMS2pDeTQzaHI5MGpPeWJzcmd4ZWNiVFlJcTZqdE1BRjJCeTRJMzdqU0pN?=
 =?utf-8?B?RW1jMjAzcXBDcnQrUVJNSjc4bmsyeGdrNVdnV1ZJSDB0SXJRdFJKRW40Q2Z5?=
 =?utf-8?B?bVFUMnIrSkFIKzVPY0I0TUpCalAxUUZXalZWemdLZVRQTGxkNVhIUkN3MXFR?=
 =?utf-8?B?VGRxYVB5NEYrbXYzWnpPQURuR0JSK1hWQjRoa2FjdnM2c3o1aGlSODhzL0FJ?=
 =?utf-8?B?U3A3REN5YXozakRTUFVCT0ZVNzU1SFEzYURFM25kdWdXRmpRM2ZmWU1tcDM3?=
 =?utf-8?B?QXV5b1czdlRYaEh3VjIvUnYyS2pMOHdEd2E3bzhOcE8zbHFRbE9QQ0pKUFJM?=
 =?utf-8?B?WDVHVEd1MktWNWFndnJTWWxoUkVvUy9Pdmp1QVJLYzJRa3hzbDFQSGVqK0hv?=
 =?utf-8?B?cm84Sit3OWVHTk9WTFRVM1ZxSHdJSHdsU0M4ZVMwRUVHUjlkR3pURDBrZ0Rj?=
 =?utf-8?B?V0o0Q3VDYWVXbWdrVHFhMlY4Q3hUL3NnTHZMRkc0Z3doT1pxdmNyaElTekRC?=
 =?utf-8?B?dGJuUCtvMGlsZVo4SmRsNjNMY0RUTEF4T0FPK1Z3RzdOUHRJbmR1aFpsa0hR?=
 =?utf-8?Q?Y5qUenfGCRekJKOpGje2xVxa4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e07b0b76-cc6f-477d-8c55-08dd47a63248
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 18:35:29.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+3Gn/7f/RLs6dDHMe1YlKkSemaxoUIB/GOmhuBMYQelt1fuMQFG/nW3eMbyPT1tz5gkb2ypfAxvG2SvKqQ+jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212



On 2/6/2025 11:01 AM, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 08:38:37AM -0600, Terry Bowman wrote:
>> CXL.io provides protocol error handling on top of PCIe Protocol Error
>> handling. But, CXL.io and PCIe have different handling requirements
>> for uncorrectable errors (UCE).
>>
>> The PCIe AER service driver may attempt recovering PCIe devices with
>> UCE while recovery is not used for CXL.io. Recovery is not used in the
>> CXL.io case because of potential corruption on what can be system memory.
>>
>> Create pci_driver::cxl_err_handlers structure similar to
>> pci_driver::error_handler. Create handlers for correctable and
>> uncorrectable CXL.io error handling.
>>
>> The CXL error handlers will be used in future patches adding CXL PCIe
>> Port Protocol Error handling.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
Thanks for reviewing and adding the "Reviewed-by".

Terry

