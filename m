Return-Path: <linux-pci+bounces-11161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FC59457BB
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 07:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C896DB2156B
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 05:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0219B446DB;
	Fri,  2 Aug 2024 05:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0krUp6Rt"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3580D3B796;
	Fri,  2 Aug 2024 05:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722577459; cv=fail; b=VDubCxrgEdZ1h1+yIo2Vako1qhXiuXm6qgyrP3W5vWjJwXRfgFtVm09AzEOq0xFoWY/hUWNBQw5fsAVPD4Rt71IWprIkRnx+XrGcyZqxatwMkoG9bBy86uFeqXofyE6FtKtkBgUo9RUupBVOaNn/1i9cfXpAl7Y+VFryvm9FPYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722577459; c=relaxed/simple;
	bh=bWk9XRd6W3mvDb587E0fQ6HGzac5+cA67V0C9t2WC2M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YP8SQI7+ZE3aaDPwP+qJ1JWzb5nHuqzIU1M8XnVvoUp7gcoQ5ZWYE9vN+NMCH443W5hMAXo3RDY2dZdVa2o09TI3LUSFBjONICOZFOwBMN771C7Ji0Rj8AbNzzQ/n/J9NTXg/POMKFQ1rXYxEKdTgUXoiS9C9AsVXR3JUfG+zUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0krUp6Rt; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfoANRho22+7fSUKIUxso4wY0RBIwYT/YxFnPKkZTEptP8lLXxHCkSgtnpfy2Ak084xlUGPJVL1k5p9uIk9Hyo1ZakgcdrIVZJora66wb37ThO5Kg4eEORYO6EpJIdU/HjdbD8stMHRTWRTkMxAg7yg2Sy2gzCNIp5ogwz4Mwmv4M8cH9XCikguWR1hu0n7fW+WnTlnDoqTPW7WV77jfqEczyTeAOSk1o2aMuFRMjsOHoZTuz4rgrxSbrmtXQKMenkpUQ0TEepejrwSK9DpiOsH6kce2XHSRo6FJfOgJn3ivBWWdTEaILzB58vmx9G6C9kRT08mgkW+bGYX5iBVM9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qMJvgRKUV5oaakhokoCJfJ/rNbYA0igUbhHaHnBHVk=;
 b=wF8yJFc0jlnUZjEuyWYYfMBMrwcBPVKKdKuNeROsG1KS7G3ZyaVFZXRxl5qgT/AdYrJ2snNwwHGjMjhxbg8OBjh4xTEpkWCdxi9TadSGLIwNGZJseBJyLMnkJFqcXlxFHjHR4aQsDLV6V8tfxY9TRVhFJZplgjmDtqeIZq0hQEZxhHmYHRIHzlecsIcGbZRgV4ny6BpRq7y7316SJnFizLhYKJZ0BUP4mfyC3X1e2OcdfGhv0FDuamzpAXsLsftr2PmD1vVATPw+CuVnZqIf+P62TAvjQBASz0v2WZxQvjLmuHC10ngHogc/sHWuX1KoGEhQec9mSJuOWRyZSySO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qMJvgRKUV5oaakhokoCJfJ/rNbYA0igUbhHaHnBHVk=;
 b=0krUp6RtEnBOIwASd9nJNa+LeSTpE4T8zgmLoO/1Ys3kyrKuX2iNuRPMWIgf+QtU5Zdsj+FBlpAWLKox/oKrpPAZZ5ovZQx+ni2oIDDIvVvcLjqbzmxnDcwV9LqZJHaHLHTTG3Yu5mVC/lHWZlTr1WbEv3u9WkVip7pDc+ipxRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by SN7PR12MB6814.namprd12.prod.outlook.com (2603:10b6:806:266::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Fri, 2 Aug
 2024 05:44:14 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%4]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 05:44:13 +0000
Message-ID: <91a50d58-f9b3-4003-b694-6829c9bcb0a2@amd.com>
Date: Fri, 2 Aug 2024 00:44:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 09/10] bnxt_en: Add TPH support in BNXT driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 Jonathan.Cameron@huawei.com, corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alex.williamson@redhat.com, gospo@broadcom.com, michael.chan@broadcom.com,
 ajit.khaparde@broadcom.com, somnath.kotur@broadcom.com,
 andrew.gospodarek@broadcom.com, manoj.panicker2@amd.com,
 Eric.VanTassell@amd.com, vadim.fedorenko@linux.dev, horms@kernel.org,
 bagasdotme@gmail.com, bhelgaas@google.com
References: <20240723164818.GA760263@bhelgaas>
From: Wei Huang <wei.huang2@amd.com>
Content-Language: en-US
In-Reply-To: <20240723164818.GA760263@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:a03:100::38) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|SN7PR12MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 1471e865-25a6-4469-b510-08dcb2b623cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUp2eVpVK1BqdVV5NEhMU1dsUVVuOUxhNmFmWWxYSWE0T3B2WnZOUjlvUmVu?=
 =?utf-8?B?QnpSNy9hK25EbmtHM2REUWhKanViZmtQenJ3bUhpbDJ1ZGc5ME1IcEdvWHhB?=
 =?utf-8?B?S3dhLzZZWEN4THRwQklRUURDV0U1cVdiTXljWFZoWnlDdVdBcEhPR1NwN21z?=
 =?utf-8?B?TC9TUEY2QTN5OTdaa2M4NUdzeHRBbHhZc0FnL1kxeUpvN2NKeE03Q28rbUxG?=
 =?utf-8?B?VzRSeHpqOVhRcFZBTnhVa0RqRk5Nb0VLa29XVWdjMEFjSXZETVhpZWRIVFJH?=
 =?utf-8?B?SzNJWGdjb2xTTXEyNG42TDUxQVhOM29CbXVqY3ZUZVd5QkFKZmxqeHp2cGVh?=
 =?utf-8?B?c3FLNmgreDF0SkZ2VDRIQTE0R0UwYi9HKy8vTXNXUENpQ3dHenFUeE1SWW1F?=
 =?utf-8?B?RWdKUHhQUmlFYkpqRzFvM3NkVjd6R3hMKzNVbkJZMzRIVkxEYnMzdWp6bW9s?=
 =?utf-8?B?V3dHZTZKeGhOOWZ6a01SUi9IZFRIT2VhZzhFNDNJTi9LZUJNeng3blF1UW9z?=
 =?utf-8?B?R1BSbnBsaHpJWG5iMlI5OFZ2eC9kdmx4UlVjeUdVbCtwOVJsRVQ4clp1U3Vu?=
 =?utf-8?B?emRtZW5CRjRobmRlV1BjMVpMR0l0UGgvQ2p6UzVwL1FNeTdxUnBwQVVuN2g5?=
 =?utf-8?B?YnJXaHNudFFYKzB6czZCMEJybG9FS3dnVVlYM0NiQW5xNy9JaWVkbzE1dkNH?=
 =?utf-8?B?cmNFbGlDaDd0WnpJa1NkNk83OTZEL0JsYkVURjU2SFNrRC9QZVRQbVhBT2lt?=
 =?utf-8?B?blBNcXVYNCtWNUFXRWpwdHZEaXpab3k1WkJPbkpNSUsyeHc0dVd2eVpmRkpU?=
 =?utf-8?B?NEZYQXptL3l5eWUzYkpCaGdPNnBoY3hsdmk2Q2FSbGs3aVdyMXZpVFNJcU0y?=
 =?utf-8?B?WU5DZFRmUUViWVFqVHRuWTh1TnRaWnpnOWdQS1dHWUZXNUs5enFEWVpkQitV?=
 =?utf-8?B?TTFEd0FmSU5lVUprNDA4elZENC9OR2RwNzBSUFVyZzF1ZWh1c0RCdG90Y1pj?=
 =?utf-8?B?djZJdllnVUpNUjArMkpUYmZSS2RiTEI5OUVvbW9jTjRjWXNKcFJFbVJZYkNw?=
 =?utf-8?B?d0czOUpXMjVnb21ySUdiUTQ4ZjhCbDFQUndJRzFVMGUrKzIrbDhVazBxRlZG?=
 =?utf-8?B?b0J1ZEZ3L2J0bVVhREpJSlhQUVlzVVF3ZFNIOHNyb0o3amJYeXlRNldUanJa?=
 =?utf-8?B?QzRpUFBCcVBOMW1nTVdhMTRpUHE3L0haSXFHYmdQWmxyNnl2WWcvMmM4TnJT?=
 =?utf-8?B?WHgybzdiL3hIdVc3b01VSTdKaTM1VEI5NU5ZNC81TjVrWlR3blB4eDIreWRQ?=
 =?utf-8?B?TjhPUk1WVDNxQk5CaEFHWTdENmw5Sjk1RWszYkpIRTZkUGgyVXczNG43VG1P?=
 =?utf-8?B?aGJZeGhycnp4eGRla3NiR29lbG1LYXdGc0puckduU09rWXhub2ZGNUhEd2RF?=
 =?utf-8?B?UUFGZE52Zjd6eXlQRk84SkkyS21OeEZMcG1QN2NoM21ja3hZTWRJc3FnaGxD?=
 =?utf-8?B?dllmd2E4elk5T2w0Sm1LQ2IwMEpzK2J0Ri9KQngrSFYxTU5pa05DNmsxcGI5?=
 =?utf-8?B?a3ZITW1TOEZScjdoL2NXY1VpTGJyU2cyb0g1eXdDdjJyV3hJSGYvWWhrM1Bv?=
 =?utf-8?B?T0lMUmFqUi9BZnluRXFZU1luV1JPbmJyZmNzTzk2eitmR29TRTU2WVdwMEtr?=
 =?utf-8?B?R0Jyc21zSVMrcUJmblpKL2xOOGlHUWd4bW80UUh3eWJmZ2UxVjZmQnRHUXhI?=
 =?utf-8?B?dlJCSytFbVJrb1VOZWw4ZDVhSFRFMlA3L0QzakFhc2tlUGMwbWswUVF6a0RI?=
 =?utf-8?B?TmJhT2tQWTBvcjQrdllYdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDFEYjAzdHBLV2wyQks5UjdzYUFhNlVLbTYzTVlIbEZrUERTcVNmbjZncVda?=
 =?utf-8?B?SHRVa2xGc0prNzF3RWZoWU0zSjh4K0R1R1dRRDJnd1hIaEVsV09nYzlWS0Yy?=
 =?utf-8?B?QVUzZjgyUG1CWUsremFuYkRuUnJySTdoVHFPNEIzZW9qcVlHN05FZ1B6a2Ev?=
 =?utf-8?B?NnlGOWJXbDJ6c0NPcHExdm5OcEdPYk5oVmtwZXgwREN3OEZtOGdpWXF0SmRv?=
 =?utf-8?B?QmNrcnJWOXNiTzl0S1R4cnV2S3hPUkVUSXhTNHhZY2pteXdXWDMzWVJScVpm?=
 =?utf-8?B?amV3UGNMc2NLeGFHR0ZURTd3Y1AySFF6S2FQSlp3RlQrSkV5SUloNTduWFh1?=
 =?utf-8?B?VDd4dFJYVHk4dHdZN1k1NVczU2gyUERsdFFxOWxscmRObnpsdGFodE93amZm?=
 =?utf-8?B?cjI2MHE2V2xFanZWNmhFRHFONW91Q3VmUU00OVI5NVRmMithVFNFYk4wVEtv?=
 =?utf-8?B?YWovZVFMWUFsa2JJTUcrVGhudnI1blY4L3BDU3ArdExJSjdka1orYlZjekx0?=
 =?utf-8?B?TWJQUTJZT0VzZStpMldSc0tBeFJaaG9qVVNaaCtSS2NGbmtwUmxCeTlJdU92?=
 =?utf-8?B?eXpJdHhkR3pqZDNBWUxqbmsxcVlxdk9TOW9jKzdDOFo4bWdNTitlVHNvQUhD?=
 =?utf-8?B?ZlFwa2REVGhlOHZ5eHlXNDM3eTUwbUdQaUVOdkRXZDRGYzZubFkzdHd5cFFx?=
 =?utf-8?B?cU1oUVBkTGMyY1drR3kyM1V5VS8rWEpYQXlOL1RNOW5xUnpqYUZsZ0VJZ1kw?=
 =?utf-8?B?OVpkM1RnQzV3SFEwNldTWXNzZXdEbFZUUHVwWkdCdXl5WXpaY2hpTnJPTmFx?=
 =?utf-8?B?Tk15WGUrTUtVc0lvaU10anRNSVhmaklVZXpFRG1ISmpTWXJLM0hxeFM1d3lE?=
 =?utf-8?B?TE0weGc0SzVINkJoRFhhYmVrVVdnR2dLODRQNTFHYUVRejhPeXQ4R1lQaHRC?=
 =?utf-8?B?LzhybmV5UzdGMzZXTEhSZDhYTGlzZysvazV0WkdINHl3Y09qZ1BWV0tHc1Q4?=
 =?utf-8?B?YkxGODY4WVk2MHZQTEl6RUw5cE9sV0g1LzVES0liWjhub0RsMjlPRnN3dFVU?=
 =?utf-8?B?UDZZQVc4bVVJaXU4NlBpSDZrUUlLZWJ3Y1JBekNaZUc1anllSWJzYlc0VlR3?=
 =?utf-8?B?THpQRkpxQi9TUFArNHZLeERYSis2T1JFb24wWXBzWFdaN3VSMUdGU2p2K2Nm?=
 =?utf-8?B?UkZ2WXBBbWllZ2tMTHpUUHU3MGVzZ3BjVjhTVHoxTzBzdEVLNG1Za2F6Q0ZU?=
 =?utf-8?B?SllEV3dqelRvMHIvQWdBVnJObVRmcDJmb0lMdXMvVTVobG0yWkJnMTVrWmVk?=
 =?utf-8?B?SXF0REJGS2V4R2FGQmVVN2QwRjdoRWhuUDN0WGZTendkYytvM0NyOEJqWDRW?=
 =?utf-8?B?R29MM1lVSGVxZ3IzYVR2ZkZSNG5mUDRqZm5DNDNJNkZyd3RuV0NSQ1NFbVZz?=
 =?utf-8?B?dFdlMWdod0g3SlcvYkl4dGpSSStlbjFnS08rMVkrQ1J3U2c2d3Y0RmFISUVB?=
 =?utf-8?B?NWNMcVpuc2tHam9aVGhQQWdVMmtKbGlVM01yeXMyY1hwMStrb0pVUkZJaFM3?=
 =?utf-8?B?WUx1Vmd4YVlLL244VnZoZlFScCtFN3BlOWFjd3YzNWw1b2o5S0FBSVB2Mlln?=
 =?utf-8?B?UHhWOHF1WDNyL1JSaXNSQXJJcVpLQ0RNMHFoQ0xHeUM4RXVBVEUvNzQwL0VN?=
 =?utf-8?B?dWQ4emNxaGV4T0JLT28zVytVN0UrLzlFTWtSUFZOQy9Wa2FMMTB6QjV1aGJT?=
 =?utf-8?B?ODNJNTA0R3ZxVFNDcUtybW1BNHF4OWNoQlhXbXBtVlN4dEY1cDN0bFNYMGp0?=
 =?utf-8?B?UkwzUWZ1cXExUVMwTUJWWSthbzl5dUtwVDJVeGtVbWdhdEZmMFFKZVI2OE03?=
 =?utf-8?B?RFYzMVcwd3hXY2l2c3FUTWtMZW5BVHFDUVVqZ0NPc3NsNEtiLzJjYWh2d1Bj?=
 =?utf-8?B?TFFPN1pTUXV6Wm5ZZHF5MHhEVVN2UHdpU0x5dWJUSjMyc2MydGtLVUpZK0ph?=
 =?utf-8?B?OVBWT2RVVUlrZmJ0Q1RENXFvM1NwOXpOTUdOc3Rzb3hjSktORFZPd0JRVTJ2?=
 =?utf-8?B?Sng4eXZZaTJVR240Vm9wVFRsNmpCeXZGeUdBTXc1VFdwdVNiNUtRTnV3K1hQ?=
 =?utf-8?Q?Ppn4HxIERuFfHyoB2Nc13jME4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1471e865-25a6-4469-b510-08dcb2b623cb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 05:44:13.5660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7z0ncudOfMxl62n8dDPNlBXTVM+hJpwZnd6UrZU/ZLmOHE+h9LQoAHPXAn+iabyE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6814



On 7/23/24 11:48, Bjorn Helgaas wrote:
> On Wed, Jul 17, 2024 at 03:55:10PM -0500, Wei Huang wrote:
>> From: Manoj Panicker <manoj.panicker2@amd.com>
>>
>> Implement TPH support in Broadcom BNXT device driver by invoking
>> pcie_tph_set_st() function when interrupt affinity is changed.
> 
> *and* invoking pcie_tph_set_st() when setting up the IRQ in the first
> place, I guess?
> 
> I guess this gives a significant performance benefit?  The series
> includes "pci=nostmode" so the benefit can be quantified, so now I'm
> curious about what you measured :)

Using network benchmarks, three main metrics were measured: network 
latency, network bandwidth, and memory bandwidth saving.

> 
>> +static void bnxt_rtnl_lock_sp(struct bnxt *bp);
>> +static void bnxt_rtnl_unlock_sp(struct bnxt *bp);
> 
> These duplicate declarations can't be right, can they?  OK for
> work-in-progress, but it doesn't look like the final solution.

Will fix.


