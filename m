Return-Path: <linux-pci+bounces-20959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CB6A2CEB0
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 22:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC69A1663B3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 21:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735301A3177;
	Fri,  7 Feb 2025 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mtX9LPGw"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2075.outbound.protection.outlook.com [40.107.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD7D195FE5;
	Fri,  7 Feb 2025 21:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962270; cv=fail; b=pnMYpWMfTO95ejOqGZtdrHDF2nfowjlXVsaxvLTo7vtYDXQ1UXTQOik03LhFdu7N51sezWQIA9meq8hKWDOy0G1Pf1bKXn0elCcBD9MoEwFPI2EWf8tpk1xasglCjEDBgl5oy6EbApKz5AhBjkUjORv99J9V9Rc8yIrinzYC8U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962270; c=relaxed/simple;
	bh=lDVIdvXI+B9MJasjbYMk1Sncdu+9x2OpwUPyurxXzfY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gINTCi2lZwVVqXVBxaGgpu+8CjqUwXjdEaaQRTgcD/nzlJmwEZqo1N6VD6MZ0eCozdjP7R7Ro29dPTIBBsvcvFQGlsTTo5nwujRggSfP00TlDyUpOPoUD9s2rwN61s+aHajtzLLUd7El1DTgKHQa5flABfANSQHke0pS2UDLi/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mtX9LPGw; arc=fail smtp.client-ip=40.107.100.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UySH8ZukdvETNmbNGTeCKFQhJSMCMYYWWi6r8Q7vuNKP3Z/NHFT5qzczMlBt6xhEOSyfMT7E+02ovjbf8GX2g8XK4S9VZhGop48QcYkbX9x7vxsOOI3EbPyXAtRoOqRR2CSQhUSiSXfuFIpcYbDAAtiLosKIExT2lpK1GJUkzWNjC/JzMVnR25z+VjtgKiHF5EFLM8rBWJQ222v7ReU4qUS6zmCOCIWC4Mb06rtDPjYUCR1v1B9wiHM3OHWjHvNULCIHoiNQH6ABwvD1Nrr6s757UEQu9I78j177kdueBPq467Rwd2ZQ37wpTmXQkmuVRLVInKdPixxAqDgxo/mS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCufUTFTLGT56dPsg5AyWQUaKWXvNrToCVufuiACCEs=;
 b=BkKey9GTdCiEJohzpiUsnEpRclnPD65B7OWfuSOOtwquITrSzQIul+BACBic90WCfDRIHN5SB1HS1ou2AUNIbQvW5A7BvyZnpsycrTXtzBs/R0G5vcsQdzgOvgrBjAbd/W2LtRrVExcP0SG0XV45HjVOLPqWFCqGeOlG469bvPxr4Mfbsk11fM6gLUVwgGAI0icBssvpyOH2BIjGESNxBfv9z3n2H2gHQWQUQyo51RJpJhTD2nU3lD9BjPzY/LuagaakP0WCTW/4agqzEkHjWlPokj/6aEpaBLziNtxhjNUS4hwfPPZxL/lAMgYYw64iTQRHm6b26AL5xB112/hOng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCufUTFTLGT56dPsg5AyWQUaKWXvNrToCVufuiACCEs=;
 b=mtX9LPGwHznX1oewLqZnogjA5W40SJugG2r1y2DkoqjQLC4NzlTmyoMXLnR/H97jxjV6Gbss+Vqb8Ee9nMoplOwFR7pZuMmsLijkJybZfSLUe3gHZorwH09KFAzKCieepzaVBPud48GTCAxDEfi/tu2JJiRwSZ1Jon+zuju6Z/A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) by
 SJ0PR12MB5636.namprd12.prod.outlook.com (2603:10b6:a03:42b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 21:04:24 +0000
Received: from DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f]) by DS0PR12MB6390.namprd12.prod.outlook.com
 ([fe80::38ec:7496:1a35:599f%3]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 21:04:24 +0000
Message-ID: <dca3416c-4827-4dd5-93f2-023a05037e5f@amd.com>
Date: Fri, 7 Feb 2025 15:04:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/16] cxl/pci: Add error handler for CXL PCIe Port RAS
 errors
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
 <20250107143852.3692571-14-terry.bowman@amd.com>
 <Z6W92JUQQt4Lf6Ip@gourry-fedora-PF4VCD3F>
 <5df5c06a-b1fe-4b79-a313-2b4c5b088f83@amd.com>
 <Z6Zh0faJrwxsVBLD@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <Z6Zh0faJrwxsVBLD@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0065.namprd12.prod.outlook.com
 (2603:10b6:802:20::36) To DS0PR12MB6390.namprd12.prod.outlook.com
 (2603:10b6:8:ce::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6390:EE_|SJ0PR12MB5636:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca70139-2c50-4d43-74e9-08dd47bafff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGhnUmhCcGIxYnBBejY4bzJxL2xwcFBhVkRXSlFDS0cyYWFRaEtLMmxXOFhT?=
 =?utf-8?B?R0J5UzlPbmJyVE80WVlmVmM0TU1pVTlwdGNuYklLME0yVHJLQjEyVXJPTlNX?=
 =?utf-8?B?cW5FMUJxY0N4a3VLanFuTFZqYTdubWlNSTkrdWRPODBTTzZjV2s4ajl5ZTg0?=
 =?utf-8?B?eUZHem1xaWc4UWNreitueWtwM1VVNDhoQUx6UFIvalo2NmFzN0hkQUllK3dL?=
 =?utf-8?B?NEc0dHpMeDEvdjhVSzAxK3hHWFcvVHY0citHVWtaajluajl4S1phaHVjTHBI?=
 =?utf-8?B?emxUMHN6MVNjM1ZXeXJJL0JCdXdUcmVDZlI5NU5ZYllKSysyOWV5MEZkTllV?=
 =?utf-8?B?N3BCNDJlYUtjTEUvWkhCUWlpbnNEdWRScTRreWhtb25QVkRSQXJieXc0dEE1?=
 =?utf-8?B?TFM3WGFDSGZweXBvTGNpb01UbkRaZFdhTWY0bjQ0Q3I2cUd4L3d0TEJZeUlD?=
 =?utf-8?B?a25BQW1PV1pHakJuMDBHckNrK29SaWo0eUVGWldIWXcvOStGME9yMHBoR0VC?=
 =?utf-8?B?Q0VvSUV5VE90c1ROWGlzZXVFZmdONzM0bUVhYmdqN0VUTXpWK1krb2ZycERo?=
 =?utf-8?B?Y0JKdEI5MUhDdHRrd1Zic0ZvSkV0MnBoNjRUZS85SDVSMnAzSC9FaWduOHov?=
 =?utf-8?B?TG8yQVdOOURCenJwSXNXQlJOT01NVnJZa0hVdHRPYTlUeW5OUUhPYkdESE1Y?=
 =?utf-8?B?c2M0OFRJNisrejlMOVQ4ZXY1SzMrRHZCcnFRN0hsMklOWm9KQzlvNEtzVmZO?=
 =?utf-8?B?eDd1VklsNlZDN2ZacVV6aU9FMjd5K2VxV0g4bVVKWkJHTm9zQUtIekp1QUln?=
 =?utf-8?B?TTdMa1F0d05aU2U0T3RXRGMxVFFZS3ZKUWVqS3RtdVd2eTNOSEJwbVhRbHh1?=
 =?utf-8?B?RGZZOVFBUmFSOTEwcmE5OXpvQkhodnRpYzd0K0ZIRytvMmtnWU5yNDVqSDRY?=
 =?utf-8?B?VTFrTjEwOGIxa2pEUHlTL2pNMnhCN2tsaCs4cXEyNU1vN1lPd3VMb2E3ZnJY?=
 =?utf-8?B?ZzAwZGhhTytkWVkzOG1xM3J4OTAxdlBtTklkTnhEZzJmUjVJcDFLYmcyZjY3?=
 =?utf-8?B?T2sxczR6SC9uVERtNEFMUE5ITk41SWcwYXovOG5FMDZGc3pMWjB5aFU0emtt?=
 =?utf-8?B?SFJvN05aZ1M3dlVENXI3bFV5V0JXM3NNSWNkNU5aMlhjSHRqNFpYWE9ZdnlT?=
 =?utf-8?B?OWZHVHM4ait2VEY3bTYzak5PemgzcDZMcGdSbWoxQTYzQk1lb2t3ekdVMVY3?=
 =?utf-8?B?dkhxWUc4ZlEwMnBUd1M1akxHbVp3T21FdFRXYmQ1cHZtNU1RYzNERlNkcEVD?=
 =?utf-8?B?Z1d1ekk2U0RUQVViYzhPVVVnZDhuZktOUi93cHNFVVE4U0ZGMG9ISzR1NHl0?=
 =?utf-8?B?czRuOFpGcVd3WVRzRmxlT2xBb25uWlVGWFA2bDhEWXR4Um5LaTdwK1ViR245?=
 =?utf-8?B?RGJLQnpSVEswMUdkVWE3Y255UHNaYXlQUEJ2M0NsOVRCYmJFTGN1Ym9JM0xV?=
 =?utf-8?B?aVZUNGtUa0dnby9jM1p3OWk2eDYvUnhpcWNkbjYvUjl1Z1pyK2RYelJLa3Nt?=
 =?utf-8?B?WnB3ZU16STlpL0dHOTZmZm1jcE1RM240Y09UQ0lFbFFTaVdVTC81RWozVkcx?=
 =?utf-8?B?L2dUaUk3MU01czVQRlM0eUE4UTNiMFlDeGRmYmU3M0hMSWpRdXFlMDArK1M2?=
 =?utf-8?B?SDdZeHpTa0FMSFNHcEVHUkd5RVV6R3RXSi95NDRxSm9QSU1PdEp0MmcxQmsx?=
 =?utf-8?B?VWZWaEVTOXRSeUhsRm9WZmo3N0VFa3c4K25RSGhWNEJ5NjRSb3RoT2Via0FV?=
 =?utf-8?B?bjJrWnpWSGRZcU9pSDNlWldCcW93ajBUaG8wUWRRbjZHOUtCRXZodG13R1ZD?=
 =?utf-8?Q?ZRCvl2rvTOyL1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGJCRCtYUkludnJKbmQybGIrcUFXWmNWcVR5MnV5bDVCM21sRTBRNFRhMm5s?=
 =?utf-8?B?YXd4Wlh4UCtmYjVqcHF2ZGZ3OEp0RVJhT3ZFWExtUHZLdE8rbk5mL3RNaHJF?=
 =?utf-8?B?SlRPeGRZN1k2N1Z3b2VIRWVwN2NRMUdsekthbEFRMkJSNnlaUi9MaEE0eDl0?=
 =?utf-8?B?K2RJSjhNK2xQMVZVcXdvN1R2OWNoOVlkdHhvamszeXlXS2JXei8xWlFFSTNE?=
 =?utf-8?B?WmdmQ0VsM3BOK1BOTDVZMWxIUWpaMm9OUVJKalZvaWdaSFM3NlI2SERKakY0?=
 =?utf-8?B?RTFQVzBDa3hwRUVnU0lIVzZ4WXVTdTFoQk9pUjdTTUp6OU9lNWJPaDNPUlJU?=
 =?utf-8?B?Zkp3VDg5NkhnNDc3Q2tEcUpuTTZ1WGtUNHhhSW5Ea2tQcERCZjE1R01oTTFl?=
 =?utf-8?B?b2REUkttMUZ5QmxjOUsxZ3UxVVprKy9rVTVweGpCSGpqZjArVjVoSkgwc3Vy?=
 =?utf-8?B?TTd5WmFCOE95cE5qTXh2U0lTU1RHN2hiVmFUeSttNG5lM2pzSDZQWGZQNmhQ?=
 =?utf-8?B?RTBVbGN5eHdwb2QwSkRHOFVqYy9XQXlmWXA0UUtRYlJYckpNRnY5dUx0aDMx?=
 =?utf-8?B?YlU2cm9LTGRQQ2xHMlpMUm0zZUdlWnJmU1BjNE1USnBDZFpmU0NjZUUraEk5?=
 =?utf-8?B?Qm1VeCtVc21yUjkwWkdreGdaZUc3d29wWmxrV3BIdnZWYisxaHNZVFo2RExU?=
 =?utf-8?B?ZEhRdTZBb3B0c2g4dWpERXpTK3BWQWpSL2VBaDBLNXUrdmhMdWhKY2F2TU1V?=
 =?utf-8?B?ZGNaOUdLMmdVWFpKUUJSUExJR0ozSXZpUUNWa2lxZ0hkSzZRZWp6aExoOGJq?=
 =?utf-8?B?QjRUK0RqeWY3bGNjOEdyN2FkRjR0anhhMDlnNlNEQUh5dGhoNzVGdlU0RzMw?=
 =?utf-8?B?Wi9GL24xSWlvRHovelY4OVZRZnNiOW5wbnlWUXQ3RU90RTFFcGtXKzVUK1pS?=
 =?utf-8?B?SUthUVY0YXplV2dldTNmSHQ4cmR0Z01ua1YwT2Q2K3dxa2VCSGxiM0s0RVYz?=
 =?utf-8?B?Qmx2M1VmdW56d0owUHhxdHFpMzRibkJpdGNlMVJWZ0VQdWowM1ZWaDlmaU9t?=
 =?utf-8?B?TG9aTTdyNE9RN1V1UDYrTFl1NkkvVnAzcEFTaXB6N1NWdHF2ODRFQXFXQ2ZX?=
 =?utf-8?B?RnNuaWtLVDY4SjNpMTlDY0R5dkdhNEFVS1BMV3lpa20zYlloeEtzdkt2Mldw?=
 =?utf-8?B?dlYxMDBaTUVIODdhRzB2RWpVMmxNNGF6eElSV0JnQzVTS2llZm5PbFlYdzc2?=
 =?utf-8?B?eDRKaG1kVFdtdkhyMUs3OXRrVUY2U1o2ZEFDMlhRckFOQkNKM1BhZE55bStX?=
 =?utf-8?B?dS9CYjBVMmtvaEhxSDVKdEpBZjl5UTlSSDdnR1NLUVg5NmZMSmVwcGU4ZEE0?=
 =?utf-8?B?Y1NSRC93YytPdjYxUGRkVTBqK01ibXFUSDRUcjJ5MlIydUxXK0dUb1lOdjFh?=
 =?utf-8?B?QncwWmtaRnhQNHZJYndvUlBnV2pnQ3ZFdWVua2dRTmdKc2MrNGI0dUcvaFUx?=
 =?utf-8?B?SEtNMW9GNEpRZDRHUjhNQlg2RG1RRFhYci9BZG4xeE5kRUxEL3Vac0JnSzFV?=
 =?utf-8?B?V1FkVDdUZVZFZUN4dUpGNC9FWGs0ZFc0cnpQMXhvTU8reERUYmY3V1pGRmky?=
 =?utf-8?B?a21iLzcyOGpYSk9NR0UzTEhLMFNYbERBOE5hcFR3ekN0UjdDZ1ltV1VGMG9T?=
 =?utf-8?B?QVpNQklrTlYrVlU3b09QemxPVkMrc1FQQnE3RWZ4WkZIREM4cS9MR2xQV2Ix?=
 =?utf-8?B?anRRTDNrWWlXdGFSNjQwMWJBbTF5TEVIQ1VXWituUVh4bGR4MUJnNEJyMi9B?=
 =?utf-8?B?VDhoOGU2bDRqQWE1SGRTNzRCUGZHU1BSUy80Q2RzbS9EQmpRbUxPMnhaNEpE?=
 =?utf-8?B?YzhjbVQ2Uk9XM1liMzZwWldaNU5DUTNZZGtUWFdjMzd5bmo4Vk1aZzNHWExm?=
 =?utf-8?B?eXBnMGdpU0kyd0dDbE41eW1jbUg1K01LRXV6REt5RWx2UmZrZnlQNVpoR1hD?=
 =?utf-8?B?MktBcURIUElJZmptTFFxbFRiQ1RlMEx6Z0s0cmlxWEtxai9jMDU0aWJLaldl?=
 =?utf-8?B?ZVFwTjhUemJnWXJYazFFdEkrbldjYTJGTnFqcEZ0QU5IWXIrQ25sMno2aGFq?=
 =?utf-8?Q?VXg9rOKXMbB98D3Ze89ZIK9Xt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca70139-2c50-4d43-74e9-08dd47bafff6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 21:04:24.2249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D2dw1xV4SZv3wbpRu/DM2VEawz9RBRS6SoZxFPim5f0DTBOMhDgnThXSF83WA7DmpNn6hIHkJCDecLk8M8d+cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5636



On 2/7/2025 1:41 PM, Gregory Price wrote:
> On Fri, Feb 07, 2025 at 01:23:06PM -0600, Bowman, Terry wrote:
>>
>> On 2/7/2025 2:01 AM, Gregory Price wrote:
>>> On Tue, Jan 07, 2025 at 08:38:49AM -0600, Terry Bowman wrote:
>>>> +static void __iomem *cxl_pci_port_ras(struct pci_dev *pdev)
>>>> +{
>>>> +	struct cxl_port *port;
>>>> +
>>>> +	if (!pdev)
>>>> +		return NULL;
>>>> +
>>>> +	if ((pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT) ||
>>>> +	    (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
>>>> +		struct cxl_dport *dport;
>>>> +		void __iomem *ras_base;
>>>> +
>>>> +		port = find_cxl_port(&pdev->dev, &dport);
>>>> +		ras_base = dport ? dport->regs.ras : NULL;
>>> I'm fairly certain dport can come back here uninitialized, you
>>> probably want to put this inside the `if (port)` block and 
>>> pre-initialize dport to NULL.
>> Right, it can. NULL dport check here covers this, no?:
>>
>> 		ras_base = dport ? dport->regs.ras : NULL;
> dport can be garbage (whatever is on the stack) at this check because
> nothing ever intializes it to NULL.

Got it. Thanks.
>> Terry
>>
>>>> +		if (port)
>>>> +			put_device(&port->dev);
>>>> +		return ras_base;
>>> You can probably even simplify this down to something like
>>>
>>> 		struct_cxl_dport *dport = NULL;
>>>
>>> 		port = find_cxl_port(&pdev->dev, &dport);
>>> 		if (port)
>>> 			put_device(&port->dev);
>>>
>>> 		return dport ? dport->regs.ras : NULL;
>>>
>>>
>>> ~Gregory


