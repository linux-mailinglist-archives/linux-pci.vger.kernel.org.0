Return-Path: <linux-pci+bounces-44979-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50675D26809
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 18:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B8463086D44
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 17:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293A93D3314;
	Thu, 15 Jan 2026 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DTzlEe29"
X-Original-To: linux-pci@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010069.outbound.protection.outlook.com [52.101.46.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1691D8E01;
	Thu, 15 Jan 2026 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498199; cv=fail; b=MGyaDIKSYr4YeO9EfJKyYwoFwvGd7HHoKYLX4sGNrcJnSWh0ZWxGF96k7ezoah3HgsmvpgQ9hciiJYZvXLRsjlOk8UrK3r1AvQIfq7WqGQDDbvtj0tMcU/CmLSXIs4qqgSlDQ+e7byLjrwWKJN2z2AhSuD7GXU3AV0EkQcEeFsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498199; c=relaxed/simple;
	bh=q+A8ZFQ+OFRlLfAJEegHx+g3Ouw7pYOceMsQG/5WPbs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t1y0M3Eb9HDb6OAGWZzZicC/qWyvC7bt+JfGnbr69GmOo4ivsOZec0rxeEVRe/vHI+df+dvmkttSc0Ulxeo/NXL+o67hOPTGFh7384DKdjeQKMacC1eqjdJiGBCpELoN5zfOcv7dDIPOJ952p0DLSbP/LgfVu0ZrZpAxpGwMWWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DTzlEe29; arc=fail smtp.client-ip=52.101.46.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mDdzjzfMopk/Y4smzvmgPxid6ijJACUEg8u8PuyVCLxdn6TCbrmyRs0jWxiSUyimDgPLQ4MuSEPa3zFt0eZmQNAzoa5cKvU5Fe+zpAI2oCQwIpFBekaM6yf+3nfy6lKeiWPwMTu0UULOZVrjU/SYbG3e/0hppMl/cy//R04bUfehBgCoH8vLH1EoAn9gXvsBn5gVrU9zP7Wbz+pbodAo2+JjDTJ+ZZZICZ2ItVFreDL2YEJwpQABD60yMrnJ86UT1etZwq5VvHcL4FltwtQn7wyAgGa73rCDBR4oZzCBxgXRfzUqppQC98cqlVFJofwveIaSRvMrEj1nGKaK5fbNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZKY9KfwOaLwQTGP/V1HubYYa5j29xwGxdk92MtClow=;
 b=ZCQf45tVIIwi4vi7hK49StZZRtOu9jVxBnVNF0+ccxFRFGRGgqzHXjOv3N/8KeucHjUq/Ukrv6KhjRdYM16cd1x8Al1k3/2FpIpHLpVVjfzob2G7LtdxQr3GbCMVvEvC+Q3NWkDiGdBYa21IluXsVnST8Z9CXWcqcjv/zFd0V0XBw8XQjvbiPKKAVFV8YnL9fV8adNndQZFeeH5wNafWcfe+eJL1OwiQqZSlHJ0n86SiamhfMARNOP7hYjc9WX4xVdCQTOYLhiHPfKpTc3av4cbsZSfjxenQhY+kfCLlAVj77y2TSWp2ZKw+LQpvh4Szn+AT7Z5K1NzUayn7EQQHKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZKY9KfwOaLwQTGP/V1HubYYa5j29xwGxdk92MtClow=;
 b=DTzlEe29IAiMrMCNMwJPFjlem3R2goyaqhf1KCpTQj+VnR1+KcPPRhyjyiU9gU4RMnW6GkZUX7lH7FRm9pOrEh3EeRBAPbL3sxnCkH1yWpSwNRljRLhct9s8ukYVmG1NVtHHKujEZVHyu2sAT3fjfb5CIcSN9bnHc+ydWsM9uUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 17:29:54 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9520.003; Thu, 15 Jan 2026
 17:29:54 +0000
Message-ID: <fd1b14d6-8c0e-4e55-942c-3efb3982c010@amd.com>
Date: Thu, 15 Jan 2026 11:29:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 30/34] PCI/AER: Dequeue forwarded CXL error
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: dave@stgolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-31-terry.bowman@amd.com>
 <20260115160107.000019d3@huawei.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20260115160107.000019d3@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0112.namprd07.prod.outlook.com
 (2603:10b6:4:ae::41) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|DS0PR12MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8619d6-9b9f-455a-5f83-08de545bb203
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czErRWQ5Q0lhZTlyWGRTN0dVUHA5WG1DZ1BFSkhpVXdEWjgvVDdXekQ0VU12?=
 =?utf-8?B?THFNN0w0N3R0MFZocURHakJYZ3RFclJ6cFBtYnhZS1c1MHJCTVhFMW5rT2di?=
 =?utf-8?B?QnpydS92ZS90U1l5RDhJM21pU0RVZWpVaThsckFPSlprejBoakxxVVZTU3B0?=
 =?utf-8?B?a2NSVThZVHpUaGNBVE02TWt2TXJxeTJOTGw0bjlpRjZCUU1NdGV3c1dob3lC?=
 =?utf-8?B?VUt6U3JGZUl2UGZLNUNwWExORDM0ajNKWnh6aDl6RnYyTytFNC9ROGY1eFJ6?=
 =?utf-8?B?V3BGY3RoSGFna00zNkx0VGlvZUw1V1FBc0VpNmkyd0tzTXA5bC9FY1VHdmRl?=
 =?utf-8?B?aXBheVlKdEJsd1E2L1h6QXFFa3RFSlp6TjNlRFF0TmNSUUdXZlZleVgxWFdo?=
 =?utf-8?B?Wi8vdXhSQ0d3azdsU3NQWHJweStVcDY4Wk9FQVdLekQ2NDZBbEl1aEc4ajFW?=
 =?utf-8?B?MjdQbElDVm15NmcrcjFWSENYK2ZsWXNhRk5wUll5aWQxQ0RPZEFUU0JJNy9n?=
 =?utf-8?B?SHZLQmx0Sit2cCtZZ2IyLzBFN29nOWxJU3owQUtaMGtEa1hjUUFVYmRzbGZR?=
 =?utf-8?B?OFRCVE5yMWsrUVNDUmVEd1BVS1UyQVBWbjd3Vm1GaGNnVXRyYjRwVjVFdTFR?=
 =?utf-8?B?cENGMzJnSmUwYjcybk1LdngvWitmV1dVc3d4aFZOYTZkZHNBdHlSZ0FPOVZo?=
 =?utf-8?B?VGptWUNJK0RobnkwSXdwa1RmSFR6Qm1wdTRIL3gyY1NOQmI4SjBWUGdnN3J0?=
 =?utf-8?B?aCtGVlVrOXZTcGtwcUlyejR3cEJpZmxwV2NhdnBnWE9HbTR4VEFDbzdteHVn?=
 =?utf-8?B?TmhTV0VuUEJUTnNZcXp5TFlkR1JFdnNmRUFyckhpaWkvc3lmbnBWeEdZWTRu?=
 =?utf-8?B?dC9QSGg4MTU1Q1d3bUtpYVhNOUgrV2laQmtOaXg4VEdZT054ejNuZzh5UWdq?=
 =?utf-8?B?QWpCY3IzcG8rbjYrMG44ZFpZN1BOUUpyZ3hrSmZaN2kyQ0RlUVA5T3VIMTJk?=
 =?utf-8?B?K3lpVWNDL1lZQUxKenhqR2NkeWlhR0lna2dhU1VIR3JzNVd1VFYxMEdrclNT?=
 =?utf-8?B?ckhQdFRmQ0RiajhaQTZ2TnczNG1vQ2F5NGtLTlJRLzlNRTYyczkxTnFTTFFJ?=
 =?utf-8?B?RWE2RFJabGUxRjV5RS90dXp6UjYrWDZkSEx6cm5uSzdrdkROeW93VENUL05Q?=
 =?utf-8?B?QndQMUtUUHR5WkllSXpBa2lNZ1BBZTdscnlCcDR1YUNHRlZiSG9EM0swTGx4?=
 =?utf-8?B?dXRRMDd6K2k4Yll3TE9BVlhTNVhZVWVJZkw1QUJxaG4zTmZ0TTBBT3lydjR6?=
 =?utf-8?B?MExsQm55ekZFNk1Vc1BrTk1zRWVOelZJN2ttQXFuTXpWbTV1bDFzSkV4UVVF?=
 =?utf-8?B?eitqQ21Ha0s5c3ErdG1MOEMvQ3dCUkZqa3NLcVhyKzJLUGZBRXVpT05PQkNO?=
 =?utf-8?B?K0MyVDJuTjhsb255WGJ5N1ZlbFJzTW1MV1NhSFZPYWg2aG1qd3o3MDJleDRv?=
 =?utf-8?B?bERRaGVNRGdKaWs0U1ZYYkdHNjJhbHFBRCtHQWRpc01RbHk5NlZoS01lQUFJ?=
 =?utf-8?B?RzU5dHp6L2JGd0RnaW1FYWthTGRNSWt2RlRXaHlrc1hHRzZTdm5hOFBWUU1R?=
 =?utf-8?B?NUE1MCtSSWlEeW8vbnBmUksrQStGbGZHQi9SYjJuUGx1ZHh4NDN3VVJjQ2JL?=
 =?utf-8?B?NitoZ1VMQnh2aWdHd0VpVzk3WXRRdTJIdnl2ZTFmYXhsbWg4bTJWZnB6Qklv?=
 =?utf-8?B?TFRtcW5rOHlFTUFSaWJSci9DS0o1S0tOSjhvN1JBN04rekFldkJ6MGpHSW5j?=
 =?utf-8?B?RlRWVHVYMit5c0p2dGFiVVVzZmptL2pYajFFanBodFRxNzR1YVRUUmxUSmty?=
 =?utf-8?B?MVFwbUhoQkFyeENkd3V5TE4zSkF2amtxWmNWNmE0VjQ2c1lwUnZNQVpnVGV3?=
 =?utf-8?B?WUZ5Qm4rcnhYdk04ZTNmZStMY2xGdHdSSHh0T1QxQjFtaTVrRXZUSjFza3Z0?=
 =?utf-8?B?Y1JSSjlhNlpURTExOFQzOVREcVdsSHJxR3NJalZzZ0ZXdVlYWExMZzcrdlQ3?=
 =?utf-8?B?dGFIKzN5YVNsK1hpYkk1bnpBMFY2dVE1MjZGKzBKSHhOQzk1VExCMGdhYnZi?=
 =?utf-8?Q?4ogk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TG50UzVVZ1NrZ09hdjl2Ym8vVktoZitsY01ZS0xtTG4zaDFHRDVVOXZMRnE3?=
 =?utf-8?B?UXpPRmNoWHI4UTIzUk9XVTdQSGJUQmllRjFCbmVaYXhtc05CT01LK0c5KzlB?=
 =?utf-8?B?Tk1QQ1ZvenN3Q1EvOG1aT0Q1SnYvbUhTT2V3SVBXaHcwSGN1UElYQ2ZxNmt5?=
 =?utf-8?B?Tm9vYVVoSzZTaUlxUjI4bEJudVhzeEM2dFlta0tDY2ZJVy9XQ2RBaXIzWlFW?=
 =?utf-8?B?VzhTVmcyRmkzTE5SQUh1ZGV2ZnZZUDhIeTVsUmh6TVV6TFZWTG53UHRkYWVt?=
 =?utf-8?B?VmtndmlDOEVsZ1VXdExvcFlEOTh4enJzK2h6UXc3SXdPNU1IQWFuS2duVzBs?=
 =?utf-8?B?ckt1STEzSWhUZ2ZiMVZlMVlyU3hONVhWSmhGNlVkVWFTdGlKazZ1Yk4ybytO?=
 =?utf-8?B?N0J3T2hmM0dDWGx5akJTc0QzWkdSOWxLMHdIYVVhT1JvU0hYQkxpbVpCa3dk?=
 =?utf-8?B?L3JwcXJqd2JtcHZyNUpndHo5TmoxMmpPTld0eEErUEt6N0VQa3dUWkNDZ3JY?=
 =?utf-8?B?WDFySWFHTHNVMXdkOUJuYm9uRnFyYXY5WVY1RmJFMGNLR1NIeXpITmVJL2pG?=
 =?utf-8?B?ZnNBSjVoem91anhvS01IdnNLazBlZWZXZWZuNTk0RThkQURCRmhBTUpaRWdQ?=
 =?utf-8?B?ZEZGcDNYNmFiK2pTZE0yajR6TTZJYWhFUi9iejk2Z1ByR0UweEJudmR4YUZ6?=
 =?utf-8?B?UndkNHNRcXBPVXdIUEpXSU5kQ0RtdHFuVXVIK0NIRUZrVWdnU0dXYjFRNkgv?=
 =?utf-8?B?RWU4UElqdk90SFNyNy9sMlZFZk5HVk9oOTBsamcwLzQvNlZFVW5JZnI5VkE1?=
 =?utf-8?B?aU5WMXJibUtoeEdNRDNSYndyMFRCWVZhTk1pamxMM0pkM2svbStIYlhEdnMr?=
 =?utf-8?B?b1JpUFlPa0Ivd21XODhMdklaRTA0OGdwMEVuek1TdXRZTUprbTdOS3lKT3dN?=
 =?utf-8?B?cnZSb3NNdmdrUWpuUWFid0NkWUpDTkh0WWQrUklCMmhwQ0lWSkFFNm9LdU5m?=
 =?utf-8?B?WmNxdVkvUGtDaWpmMG81S1p4a082THVkNzFEVE55b3hlV1VNZGJWTjRjMHlt?=
 =?utf-8?B?WlR0cDNURmFGVmZSdEgzNFpwY2ZUOTFtYWM5ODVLMzJFRmRuR3FkaFdIVHdR?=
 =?utf-8?B?Ykt6L3VCaVc4RGxvS2RDaFk4NFB3NTA2US9nR1k4Z1hIYVl1VVVRRVpZNFNN?=
 =?utf-8?B?cUM5bWhUT3k3Q0NlWlhmTE9vbU1zK1hnUXhMMkxiTW1yMmk1cjZlWW01b0JC?=
 =?utf-8?B?Tmw2cUR5U1JmOG5HVzJTLzg0TTBGbnJIRDV3VDdTRDBkdFFhb29GRFoyQjh0?=
 =?utf-8?B?aU5KczNDSkNPTlJSQXNadFVFSVhIU1hFUjZZbGZWT2p2Tjl3Z083QnpSNlJT?=
 =?utf-8?B?YzFTejN3eXFpZzRrL1ZoeDI2bWxWWGhuUURKaW1SdTd4Q1ZwKzJmNnhBdWRm?=
 =?utf-8?B?TUU2OUF3SHM4MFhYS1dFS1plUTRmcXY4UlBoUHUwb0Ywam1CTWNyNlJoWW5y?=
 =?utf-8?B?SVFvMXJFdXFRcEZhSmRQbGt1a3dXN0ZJTVo4VEN4WnppYjEvRmJObmNFZHJz?=
 =?utf-8?B?bExVUFpydlU3SGwyN1BsRjIzd3QxdlYyaDR2eHoxRnNDclVna0JyOEZHVnhO?=
 =?utf-8?B?VCt1NkU2Nytra082ZFp6Z2drT0tzVHhRQkdOVVZHK3V0SUNKWU56OERWY2lL?=
 =?utf-8?B?cDlSdmp3TFJrcGI0cVRmTUFkZUVBTE04eXRxa0UvRk01M2FIcUdlaW13a3FW?=
 =?utf-8?B?RHgyVDlKOHBnQy9OYm9JY0NOeDk3VXYzOGRnOG1MS1cwWkFwTmVlaGVsK2Fn?=
 =?utf-8?B?Y1VlQTF3ZjgrMWdKOFVtMFpyWlBod0pMelN1a1BpdWVUdm1HS2szR1hacWFa?=
 =?utf-8?B?VVJ5enFDVW40RFhNVGJ3a1A4aXRrN2FNSGgyQ2pqWHJMcDFuR1hCR0hRdWR0?=
 =?utf-8?B?NDdvU1hGVVBGTCt2cFVvaVBYRzdHbEttZ3J4MXlIOUhrY2dXMkd6VUhKRXdR?=
 =?utf-8?B?NW1RbGl3K1ZtcE5ZdUVQRjZSZGc3S1NWb2dvek1kdm1nRXhpQk1OMFo2Wjl6?=
 =?utf-8?B?S0FaWXJUWWI5MEZzVk41cTVTMndhSjlzRnFoeGVRNk91Ui9BR3ZSaGYvdmpI?=
 =?utf-8?B?bmJvSkVBOWEvV1VhYkFaQnhsaW9aVmNtVTh2ZGh3L1FCK1htRmJwK2pJZklj?=
 =?utf-8?B?U2JGQ1RzcG0wdXhRV21Id1oxeGswV3JhOCtpYStjT2JNRDMyRnNkQ2cwRnE3?=
 =?utf-8?B?TzNWNStsM2F3ZkNUOHROckswZ2dwU1ViNmVzdnRzVVJUbUQ2WHhMTmNPS21i?=
 =?utf-8?B?YzNvYW15NVVrZk9aS1NubTVPd01QSGw1MHF0OHExSmhRSW5yMVFqdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8619d6-9b9f-455a-5f83-08de545bb203
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 17:29:53.9654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rD9fkzvSs5I/bDZNmL9wwUeDJByMFDHrZLwvW3zU06gHcGGDwE2ILM4X6/E4fpsgPsvlqzBbDxvZUwbY+7h6IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6391

On 1/15/2026 10:01 AM, Jonathan Cameron wrote:
> On Wed, 14 Jan 2026 12:20:51 -0600
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> The AER driver now forwards CXL protocol errors to the CXL driver via a
>> kfifo. The CXL driver must consume these work items and initiate protocol
>> error handling while ensuring the device's RAS mappings remain valid
>> throughout processing.
>>
>> Implement cxl_proto_err_work_fn() to dequeue work items forwarded by the
>> AER service driver. Lock the parent CXL Port device to ensure the CXL
>> device's RAS registers are accessible during handling. Add pdev reference-put
>> to match reference-get in AER driver. This will ensure pdev access after
>> kfifo dequeue. These changes apply to CXL Ports and CXL Endpoints.
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> Few things inline.
> Thanks,
> 
> Jonathan
> 
>> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
>> index bf82880e19b4..0c640b84ad70 100644
>> --- a/drivers/cxl/core/ras.c
>> +++ b/drivers/cxl/core/ras.c
>> @@ -117,17 +117,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
> 
>> +/*
>> + * Return 'struct cxl_port *' parent CXL Port of dev
>> + *
>> + * Reference count increments returned port on success
>> + *
>> + * @pdev: Find the parent CXL Port of this device
> 
> This is a non standard type of a comment. I'd make it formal
> kernel-doc.
> 
> 
Ok, I'll update it.

> 
>> +
>> +static void cxl_proto_err_work_fn(struct work_struct *work)
>> +{
>> +	struct cxl_proto_err_work_data wd;
>> +
>> +	while (cxl_proto_err_kfifo_get(&wd)) {
> 
> I'm probably being slow today but where does that helper come from?
> 

drivers/pci/pcie/aer_cxl_vh.c

Thanks for reviewing.

-Terry


>> +		struct pci_dev *pdev __free(pci_dev_put) = wd.pdev;
>> +
>> +		if (!pdev) {
>> +			pr_err_ratelimited("NULL PCI device passed in AER-CXL KFIFO\n");
>> +			continue;
>> +		}
>> +
>> +		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
>> +		if (!port) {
>> +			pr_err_ratelimited("Failed to find parent Port device in CXL topology.\n");
>> +			continue;
>> +		}
>> +		guard(device)(&port->dev);
>> +
>> +		cxl_handle_proto_error(&wd);
>> +	}
>> +}
> 


