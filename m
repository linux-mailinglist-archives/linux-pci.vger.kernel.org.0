Return-Path: <linux-pci+bounces-19764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD626A11265
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 21:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243417A3137
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 20:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3B01FF60E;
	Tue, 14 Jan 2025 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sWl5JnWA"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99491FAC25;
	Tue, 14 Jan 2025 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736887489; cv=fail; b=CjL/NtGtvA7TyVvc4X72T8Wk43ItIDoobUxtmdjLBjuc3cbgtuWAs1cJ37sqkc7bhxta4KQoT71BK47QrN99q6ClEPmR6L93cOH++iMYoCTdfWHPF4DwhcczttdDLU4SuYiqKkU7Tqq6AwcBV803eHNrHqXFvqxEmVA9l1Ywkn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736887489; c=relaxed/simple;
	bh=SlkbZscy38pLLgm6gdWCEicMVPWJrdszU4orW0YLe68=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vo5rI22VFEiM5D18YFd954wqQ5enHGCjjxaxnJ0SPJSiLOa0efmHscvZo9JkOaXium3aNJVL98vEzZNJbL97nzULQuxBLifLD5gOw7kBG58obX1dv3I6TGwb21pLBdPZNgPfzsNesWyP361raCioJJY2jK7yE81EbuD99GvNj+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sWl5JnWA; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2Ho6BYU61uAackpjhxrbQjmpio3jyGABlfu6N1Sbg8lLtNodv7+stWNYQSivTVC+pkx+TiGW9k1Z9NpbdfxxUPKakHndppTXMftM3fXvqsEC63ehVt/8XRoOa8cz9u8fUCl0GKzMvAauGe12QMJVYNpXlPeDaV7JPjHIL7X41uBR/zbGtNGUQJeMBylrRq/Y9Kz0vGo1Vu/3iu5TEkQVez4qxbEubLG1Y5bOH/tRS6xmkEA4WmpzdXpiHKTH4fhb5wBS8U3+yIYffRuW4NzmPIon0h3oSkbsJn/acXh81neZsK/Px9PtGse4MF7Lzs0W5IF9taMcYaBbOaIisyYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voKYSNDcSIlDs7CG7DOJP3mw5Bgg+d6JPjHhCJpJPOU=;
 b=TZzKO9fbCDsTB5r27WXog2HcfLTsbvLEUw0B2wZnGlGpKyWjJikImqA8VyTVyQyE4aA4jCh1+NOaKGZTxjmBDGfy2ZBPzJmow7z7cAWKnKWX8Q/iQd5bZkjToHpj+faJQ7aa7wvjckPWTzurA13QgQdaj9k1rl8jm2gWK2PEvlRGlT8+LdWPWiL8RQNK6Ps1N4gL1p+6dLYM/uswnhdzhd0+58l3ApKuJwdExf/Yrgp+UqV1Zu1fJlaWa22ptI16oX1/XicwnMdQISdiXXYllHrf3UgeGS5SGK7NUBsPSDSzHNUv/QUAb3TknCgTVYRz+bXGoCAAgUmJLNdJdeSPMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voKYSNDcSIlDs7CG7DOJP3mw5Bgg+d6JPjHhCJpJPOU=;
 b=sWl5JnWAcg2bE1jz2AD+AqLsYyd482sEfY9dJ2vnQCTrcdTpVeztZ+xE1hr0xmrXDbT9S9dVecaL3KFyLsO4aAwaaCKWb/buQkcX9oxYlJxw9Qf5CozRHR/R0JXQg5/SOCuMzwwdc/HHvK7gH7nnhjSYC9nTtxe+KCpl5z+Ug0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 20:44:45 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%4]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 20:44:45 +0000
Message-ID: <e5c215b5-ab8b-4466-9e1c-c0881aa94a46@amd.com>
Date: Tue, 14 Jan 2025 14:44:41 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/16] PCI/AER: Change AER driver to read UCE fatal
 status for all CXL PCIe Port devices
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com, alucerop@amd.com,
 Shuai Xue <xueshuai@linux.alibaba.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-7-terry.bowman@amd.com>
 <20250114113208.00006d08@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250114113208.00006d08@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:806:28::27) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: aff0236e-6f1c-4686-b30e-08dd34dc476c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlJ2NnJ4YllndDJ0aFBkQTBHNFNQZ1NrWG5wTmJadVA1OEVDWG0rTHFLcGll?=
 =?utf-8?B?dGJnY3l1VjJKNEMrcGluWTB5cUZFSkJrOWI1SEN1NksyNzd5MkFlYkNvRko3?=
 =?utf-8?B?SHQxdGJHRGU4MHIyWEVzdTNjRGw3eWhSaXVPUk5CUE5MVHNNR0xYR3MybnBD?=
 =?utf-8?B?NktNSDNpUEJraTVRVFBrQzYvMENmM1EvZjRwaDRzY2w5M0puMlpaVXRRbk5z?=
 =?utf-8?B?UUhxUGQ1RDRXY3ErckMzcnlaUllLeERoVU1JaDhuSi8rYmxrV2k2cjVNU0Zu?=
 =?utf-8?B?N3pKaGY2TE1maWw5NjJZY25uREd3S1BTZ2RRbWxqRmNDRzg4WkE1MjJCNUpi?=
 =?utf-8?B?L3VKb21udHFEZCtBZzZOTkJHVEdmQmV4eXVWQzBXdnhzU21Vck5Rc3hLSUFs?=
 =?utf-8?B?WXdBK0dYMmErV0dBR3dOdURSNVJJbVJ5ZjZwT3RoM3F2UWw3WStyWGF3cmVQ?=
 =?utf-8?B?WDZMZUlTZGE5UXRDM3QxTFRFZTA4MVZFemtVZ1N5NmtHQkwrMjNsUUxHK0pH?=
 =?utf-8?B?QkI4VkdTTEpIb004ODduRzc5ZlZsc1d5MTV6SndSMlM2cUlrZHdTU3VSOXNl?=
 =?utf-8?B?enNCZ3VVK0daS3BrYVhZLytXQk5sUU9tL0JqT0I0SjhCS3RLLzZMTXdsOWFH?=
 =?utf-8?B?WnRvZEkyRitLblVyTFRNSGxjVzhCbXRlSjFodkw4U1lPUjF4Y3VIbzlCQ1JO?=
 =?utf-8?B?R0g3RWEwRU05NllPV09ZWFNYZmN3L1UvRys0azNJNnk1YlFWbm1xeEQwM0Q3?=
 =?utf-8?B?RnowakdDWmVPZFpWRDRLUHo0ZzYzenNQbThHZ2J2MG5vb2lNS0wzVGtkeFNq?=
 =?utf-8?B?dW9xbkhnTEZ5aEVpQUt3Wlo3ZjR1Y2hsUDdXMkxlU21BVEtPVmxhaTlFaEhL?=
 =?utf-8?B?bHlTcjJzeHl1VlVOREh6ZXJZODI3dS9CNzl0MXlyWjZrV3M0b0Q4cFVNNU9O?=
 =?utf-8?B?WUtYd1hpK2owZCtxbmltQzFzOUZOZU5DZGZwS2N2a2w2aE5WNVVFQmsyQ2l4?=
 =?utf-8?B?dkI3VXJWSUorN0RUQXpVZUpsck5xK3JZUU9qOGpZSWdvdUdJbDl2WXBHMXVi?=
 =?utf-8?B?cVI0NVpZRnpXNi9GU29FYk5YZDVMUnFoVndHaDkzVjhwZVVzY2U4NnhNS3d6?=
 =?utf-8?B?MXRGNjNjWStDNDVYeFR1ODlYYUx3MUMyYmdEaG9PT0RrQXlSRG1YaWR2dTN5?=
 =?utf-8?B?SFpFWW0xZlJ4Y2dSbEdTQmp6dHplWjBKTHVDVHNJMXZUS0pNbU8yWkphYWNC?=
 =?utf-8?B?ZEZZcEZVeDBpSjdmdnVTQWM3OGRTQlhRc21Fa3pQaGQ2cGhxYWl0TXYxS0Rl?=
 =?utf-8?B?SURwSmIvaVZhWm4rdWgvMW41RXVGdy96WHA0b3Z3cWpjUHJOeUdPQU5abDhD?=
 =?utf-8?B?WnhNN0NrVjdwUHNUVUtkdW9NUjBzaFFkVHN2ODNDTS82N21jNG5JV0RBZ1BU?=
 =?utf-8?B?TWNlVG52V3JDVjJFWUR3Vk5hMGs2TzdzSi9uUWxZWnFjNE1WNmRvaDhoYWdT?=
 =?utf-8?B?VHBRMWxBUDlwM21UQ083RXpHOHNORy9iSE5QdEJmOFU5OEQxVlI0bjlWZ3py?=
 =?utf-8?B?aGFXRzZCbmFOMmVKaTJBc1FCTTFlNGVINlhYeGZXOVB3aVFEYmYrMUdjQXlv?=
 =?utf-8?B?U1U3VUNWRERQMzhEdFJiTkFSQTlJcUZycFQ0dXp1QlhaSms2SWxIa1Rsa1ln?=
 =?utf-8?B?eUxvMFdxc0NMb0p6ZEZJVjl2MDRZNkpPL2VSRWpiN1k1MkZicVZ6SVlVTkM4?=
 =?utf-8?B?eitRVXQzd3k1c3l5QjdmQTJVK2h4UEFobFgxM29CR1Z3YndRYWN3Ungzb3pB?=
 =?utf-8?B?NnFDZTlGUnpiTnc3M2pwczE2OUV3Z1Z4bGRveTkwcEtodkJ5VENSL2sxSW4w?=
 =?utf-8?Q?TXBnhjXVZFeX0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0R4c2lsNHZydXROTDhxaVkwcnFQRmc4OGMrb1JYSzdCV0pXQlNRbjU2MmQr?=
 =?utf-8?B?SE1OTUxRUmZ1aXI0QWU4cEJCK0hsWjJXVHJPdVVZZDlzOTZMdS9OZ1ltRW02?=
 =?utf-8?B?RE51MlNBWGkxbG0wS2dPd1dOcFRQbjlCQ0dnQTdRWTF0c20vYVEwQlQ1NE02?=
 =?utf-8?B?RDJrSTFaQTlxcXVEd3JyZDJ6dUNwVGEzak12VVNIcng5MDRGb283OE41Z0Zk?=
 =?utf-8?B?SGYxa29SSWVBVHJzYlNkWExTU0g0eHoyK01LMWF5SUVQeURiYkw3OGU3NEU2?=
 =?utf-8?B?RkJnWlBxdE1DY1Z6Wlo5VmRQd0RVc0xiOElYS2dPL3VNc0RXbklkY1FweXZY?=
 =?utf-8?B?QVVnLzhxaEZMT3J2WjdaV3dmTXVESGVHcWdnakJPWnlxTEsrRy9ZeU0zTkZp?=
 =?utf-8?B?RnpYTXVVNmZINExwejR4WHNKdTMvQmxUNlNJUERJT2ZiMkVxTXdrT0RIYmtU?=
 =?utf-8?B?NkZ5Z0tUOEVKQ3VsNDZHL0xNemx4cU1SY3hPTXNodmtmOEpkVk5SRzdoU2lP?=
 =?utf-8?B?L21aemV4eEJqT2lFQ1RaZ3o1WEhrdEtxRUlYTnQ2ZG1Fa1JaR1RkUnZiZ2xk?=
 =?utf-8?B?aDZEeTVkWFVUOGw4RVNSdWhmd0ZLSTNEd3ZqWFRSSDRkb3VXczFMYjN1OHk0?=
 =?utf-8?B?dHVyWW9ZR0IvWEJzdVNLdjVFYmROQVpmdjdNVDJrK1B5VGVKeGFpMm1RK20w?=
 =?utf-8?B?NlpCQithNWJRRU80QzZvTkNBaGdTczBiQldHbTVrN05uTzVmb1FGSjFIOHZJ?=
 =?utf-8?B?dWlHdS9WcUJoa0ZLU2pNRmt5ZE5ORkg2U3pDdW5LN1V6Ny9PdVhiYkJUbjkr?=
 =?utf-8?B?eDQ4ZUJwRVZabGRFNXJ4WnhmU0c3akdhMVZ2L09TUXJhYVR1L0huZHRXa1ht?=
 =?utf-8?B?ZVA3WTduQVVDbTI4WUluamhCM3JYUmNjMTgya1ZjekZVRkNudEtqT2N2Ymx3?=
 =?utf-8?B?dG4rSnp1ZFcxWWdSZ05qd2ZvdThlMks1SWFMVEF0VHV6S3kzTHN2OXo0NlVj?=
 =?utf-8?B?a1k5VjNuRWQwem9MMTFvUE1ZU1ltbjJlZFZLbmFoVkdSc1A2MDNWQTkycEZO?=
 =?utf-8?B?eDNucU9yUFdPdEtUOVU1eGZFd3hRT0xpd0l4ak9iVEpzdURuYXFLTWxJdTBF?=
 =?utf-8?B?VlRjTjFaTjQyUGNKYnNhWDJCemhXL1oxcDQ0Y1dCZ05ENmJRc0h2SHJPVGFz?=
 =?utf-8?B?bTl3S05yV3pLbVRnQThnMm5lQmJmQnJzbFU5UW54ZWgwOS93L2EvKzlkeUdq?=
 =?utf-8?B?MWprV2dGdm1ITGFoNXZWeDV0NWZTYU9YbkkvcUwxeVRKWERwN3dab0crTVpY?=
 =?utf-8?B?YlYzZzBsSjZLWXBnNUhWYnVyU1ZUTVJmZXdGQ1ZNdmZwS1lUNTRtNjFHdUZV?=
 =?utf-8?B?Y1Aya0laMUpkYjFrajk0VWp6MGhEc0Z0VzBsbFJ1L0NMeE5uK0JxUkxvajZX?=
 =?utf-8?B?SFJ3RXltM0R5eTdWcldMcU5id2ZSNjZnaENiZFNnL2pXcGVHeTQ5QmhtSXdS?=
 =?utf-8?B?Y3FUbWI2VUhrYlhRSTdEcTNmamk4VGJkT2EyU1JoVTZlcEdCcHhxVlBOR1h1?=
 =?utf-8?B?R0JhL0pTV0ZOWTN3TUJOdEZ6bnJ2RDNTOG5GUmtWeC9mTm9XZzJwQWNKRkU5?=
 =?utf-8?B?TjB0dE1qVHhKZEVlNzU5cUVsendZY0dmNVZRTEppcEROZnZFSk1IbkZVSElY?=
 =?utf-8?B?QkRyU0hLZkdRc1lhY0U3ZUdiR1B3Mng0dWpMK2s4d0ZhZWsrRVVOTDYvaTJL?=
 =?utf-8?B?Sk5obWVQbEdMbmJKeFRtL0g0Z0EveUJBM2JESnQ0L25UMWNSTE16WWpQZUtL?=
 =?utf-8?B?RW9UaGRWeEkvcGhQa252cllIbW1sZlhFWXZkRFRvZFB6Q0JWbll1cWlxZ1Y4?=
 =?utf-8?B?bVVsRzR1Y3owSm1BSElsNkpCL3BZWmZEdW8zQ09BdU4vaUxRV2U1YnJEREVq?=
 =?utf-8?B?OWk0T2FlVkk3YXVWRUVOQ0JVcmc4ZHZJMzhUSUlTYndtNjIrbm9YVzFmalNu?=
 =?utf-8?B?Zmd0dis0b2c2VWVaNy92cFVOUFFRSVJtT0UvbmIvd1F1TkJFdW4rd2JpS09k?=
 =?utf-8?B?OWFsRnBEdWhObUJ6QWxna1FpWG1JQzMwK1ZjejFZTWY3bWZKWFNNUmVTbE9C?=
 =?utf-8?Q?/vw60Ik9wVnyBcjpDRcSnO37W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff0236e-6f1c-4686-b30e-08dd34dc476c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 20:44:45.3838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+3QJzKHLTL+hQJouWWDKNASKSvf7w3/rGEf65fS2SfNyCxIqWW0qRWvBwSMCNx1TvxVGD3tXweaALF4ch9w0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541




On 1/14/2025 5:32 AM, Jonathan Cameron wrote:
> On Tue, 7 Jan 2025 08:38:42 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
>
>> The AER service driver's aer_get_device_error_info() function doesn't read
>> uncorrectable (UCE) fatal error status from PCIe Upstream Port devices,
>> including CXL Upstream Switch Ports. As a result, fatal errors are not
>> logged or handled as needed for CXL PCIe Upstream Switch Port devices.
>>
>> Update the aer_get_device_error_info() function to read the UCE fatal
>> status for all CXL PCIe devices. Make the change such that non-CXL devices
>> are not affected.
>>
>> The fatal error status will be used in future patches implementing
>> CXL PCIe Port uncorrectable error handling and logging.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> This clashes with Shuai's series adding link healthy checks.
> Maybe we can reuse that logic to incorporate the condition we
> care about here?
>

I'll add changes to query Upstream Port link status. I'll borrow from Shuai's patch.

Regards,
Terry

>> ---
>>  drivers/pci/pcie/aer.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index 62be599e3bee..79c828bdcb6d 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -1253,7 +1253,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>>  	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
>>  		   type == PCI_EXP_TYPE_RC_EC ||
>>  		   type == PCI_EXP_TYPE_DOWNSTREAM ||
>> -		   info->severity == AER_NONFATAL) {
>> +		   info->severity == AER_NONFATAL ||
>> +		   (pcie_is_cxl(dev) && type == PCI_EXP_TYPE_UPSTREAM)) {
>>  
>>  		/* Link is still healthy for IO reads */
>>  		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,


