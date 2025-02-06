Return-Path: <linux-pci+bounces-20806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AD9A2AD3E
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 17:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70DE161E57
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 16:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C8A1624CF;
	Thu,  6 Feb 2025 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HstNZD/7"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C7152E12;
	Thu,  6 Feb 2025 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857911; cv=fail; b=Ei7V4Be2soN138yFFtm7h1n7C2whgEz/B9nMgXPu0IzTuM9u4tToe4vwzmStg5sUTvShiq003rL2st2wEb+Qrjx36nJKDfo0jNqKJ8QfOQEj5XZ38vovlM5N4F1kHdayH3ER65RYH8+TZPX3YHD7EpsyXLLs00cNMDvgqByakYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857911; c=relaxed/simple;
	bh=9dySdpBKZhkH7AgnWGwpIiO3mLVPGtprU9u2j8FV5QU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fF5oNValKghrbtJT2aqTNgjVZWqfAr04zifY906alWXw1/6C+TudB79/Y9WeKtaHJJ0xapOPtLjnlcJboi+pUhJO65kFJudkXZhlp9CUG6H5PpzNvXJJRwW8icpamOcPzFZiLDLHoYfS9/ZWAVL5aDqpdXFB03aEFznfyp3ffzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HstNZD/7; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jhq3jKkPk4b1aWD2dG60NqYQ+rpXwNfSaNdDzGmg7ycoL+1CQfvlIWYFWogmqySr/ogaJDrdH+JUd4UOqcNC4wlCWHbmkAKWioAaCooreS0qZkuZMRcZobRj2RKZoY1641CaJwo7leX7k3cKpl8l2jhnmMyHLdNxnNQR3ak5uPix4wSVCbarH5nq8JqVPg8rqZ3VgDXSsYIhV4WO6IoxC2NdRGgPV/wc6wVDqQf2UAIEQ2h4f5Ptc3Ij8WAmFgD+FvoysjRAVLb8KcAL7CLVvDtHF3UtCrm0cxie7EIwjbsUCzUn/0/V/cD7peOZBbMEvm90IPgG+CfsiXDJwuLAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ib/Z+Q8yfcfkrqtkF78cgYjvKKNtHjDgxVQrysgmgbQ=;
 b=LNo01lSsgk+l6ilwE1PcZrBxkg3Y51MYkdbecT1n8q8tr+04zyw921uSzhmcParCL710xDVeXvRM6oAu2cgKXXxjIn3EFxLaBsb4DOeBoC8sUJIN4GsYVogQCgRDJvDSfi0Qmo5hnh10G9BhfSo7Q0OkqWpH59b0DVH/G8qcMKKRYbpZ5VfaKw5HiMPl6w0/U39KJzjgFJif9l1kKUkFOJP/7idU0b5ICH4+3JpGQQtVCRCIGGZvxVJYiOP+dMO/47ucoWslSy6eEyWYN4Zo1fMkp33TSrzLjKAkrHVW+tDheSSrnezHLrcHdIDyAbP9SEqJd7vq+s+jKjlmoO257w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ib/Z+Q8yfcfkrqtkF78cgYjvKKNtHjDgxVQrysgmgbQ=;
 b=HstNZD/7XankNYF08qfhTEVAEFrm1K30B2eWn3DO+g8H+ambYRa1CzRYN5t1ajKa0B4gZ6qbWrBWpjLbNW9v1mvL0zYtkGmxbp3GpbntF1um/mPJVwqjzvtQwwQ3ASCJaLkuJrRE61oXGvpbcbzqXkVQZ6PebT476w5Yu6SgsiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 16:05:06 +0000
Received: from DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475]) by DM6PR12MB4877.namprd12.prod.outlook.com
 ([fe80::92ad:22ff:bff2:d475%3]) with mapi id 15.20.8422.010; Thu, 6 Feb 2025
 16:05:05 +0000
Message-ID: <e8c7f91f-8dc5-47f6-be8d-f68ad9258911@amd.com>
Date: Thu, 6 Feb 2025 10:05:04 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/TPH: Restore TPH Requester Enable correctly
To: Robin Murphy <robin.murphy@arm.com>, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <13118098116d7bce07aa20b8c52e28c7d1847246.1738759933.git.robin.murphy@arm.com>
From: Wei Huang <wei.huang2@amd.com>
Content-Language: en-US
In-Reply-To: <13118098116d7bce07aa20b8c52e28c7d1847246.1738759933.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:805:f2::24) To DM6PR12MB4877.namprd12.prod.outlook.com
 (2603:10b6:5:1bb::24)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4877:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fabeded-e1f1-4d7a-9186-08dd46c80596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnZZMG5LMVZPRTRXdkdvakd0SDNtVXVrbE1XRERUdWl3em9zQnlwejZaTmNJ?=
 =?utf-8?B?UGkyQ3NxbGxHcEM5VTVuTUwwbkdNa0QvZkRFRWt6S003a3MyZmxOdHNITlFH?=
 =?utf-8?B?ZWtYb1orbGJ4cUkweDRtbmYwbTRTTjNjOXdud25Bb2pyZ3lZQXBlVlJPQTNL?=
 =?utf-8?B?ckZQQVZLdHFJT29wcDl4M244aXk0cGwxdmgwZ2p4clJzVnBzK1c3Zkp3enVG?=
 =?utf-8?B?YVRGMjJmVDlubXNZWmxoZ1Yyd1hYU2o0cmxOaXJxcjZyRjRBTEorZUxLdmR3?=
 =?utf-8?B?NWVRVWVmTTJCNXhDNXJkRWJnektxYlpZT2U5MllCQ3FtNXRGYkNVdThONlVn?=
 =?utf-8?B?YVNmRkt1ZmdNRjJUUEoyeVhxUGtyUDdySm16b2dFaW80OWsrZDNvWENHWFpk?=
 =?utf-8?B?OERwNDVFUW5yQytGL2dUd2xCa3RWOFZDT3dHaUI3ZFlGOTBYdlltTkoycm1u?=
 =?utf-8?B?U1BHbWlIU3h0WUlLYWxOTzVUdXNydGVFejlZVTFZYzBUTDZkc2Q2dDBSZjJx?=
 =?utf-8?B?L0xELzFCVG52Vk5hY3IwMFZpZUVGUWcydU9nM292a290NVNqWU1XWGZma1dK?=
 =?utf-8?B?Tkp6bk5NVW9uOUFubDNUWDZqOFphMm9BL0FlaDNhalRvZm1GSnJnWTdVRUhC?=
 =?utf-8?B?dkplVk1OQUc4amsxYWQrWlJqb3RBb0NsaHI0SjYwemhlVUZvcGRGK01kNDVB?=
 =?utf-8?B?MEFrQVVXc0tBam8vdjloNnYyTENYTks2eWtKNzJpSHVuY3ZBV3FYTll4K3JS?=
 =?utf-8?B?NERhV3N4VzdvVlRXL3ZwaDh4SXB4TzBvWW5TNHEwdkJMTURNb2NOM3piaDhy?=
 =?utf-8?B?RGdmZTZMSkN3L21ldFFNK2xId2xmY2d4c0w5VUk2MHRJb0ZBaEJrcG5YM21i?=
 =?utf-8?B?blZxdElwOG9EeXFsNWZzNm80UGlqcXpzNkNTWU1CZG5CcVlldVdtZGpGaWda?=
 =?utf-8?B?UWswRDZxZzg5Z2tpaFNOczRVNERHWDg1WjdHRWFOYTZRdHRqZDlEZE9BckE0?=
 =?utf-8?B?ZGJhVnV6d05UdWV2K2dOT1FnSEJjUmJRejVxdWh6d0tqTzBBaGQrQmY2SVVo?=
 =?utf-8?B?MzVMRDhUbSs4VnBtVGd2alIyU1l6dU9FN3l3MEFjVTViN0JCYW5hTDhFOFox?=
 =?utf-8?B?aFlrMzE4QXRFWG9HNmZWYnRac0RIbUdtbmpuUnpqcnZJT3lLaHB6ZnVkNjFH?=
 =?utf-8?B?bUVMUFVvejZxZUIwSmJmdkN3eHVmejFwZzI5WkZOWGdMZ3dhSTFRWjBNc0pT?=
 =?utf-8?B?VUtibmNwc0JobFJ0TGx5Z1FITmVWckEyeXEzMmRjVlhONUZCbDR6MlZmNFNQ?=
 =?utf-8?B?UW1wd1hiS0U5U3UvSVhhWjBlaUlUUXYrQ2tQQll2bVIvazhEZktqMnBqdlNS?=
 =?utf-8?B?ODdINCtxWmtrbW9SYy94UHgxUnBTZk52OGdiaVpmdi9DZ3NLM3VFMGdudVlD?=
 =?utf-8?B?ZEJmZFh4NnB5aVZNRGR2ZTNwUzYrODBIcmFxcXQ3WFEyUUVxdENMZmtZMWl5?=
 =?utf-8?B?Y2lTOS91YXNFdGZZVEg1RU9BVVF4c2dKa3Y2VkpEcVJDTXg4Qy9PVGExTHZs?=
 =?utf-8?B?YjY4VitERzFrcU5LZnBZQjB5c3prMkdzT3hrRmdwV2UzUEU3LzNML3duY0dT?=
 =?utf-8?B?ZmdIT2lwN21ycTRNUEx2dDYwSGxoZmVCdGdObEJNRmh4aWk3VTFrM0g3NHNh?=
 =?utf-8?B?TGpqWEdTUmgzWXNIOFhRbGZ2cFNPeEtoMTBobzQveE83Y09MU296OVQyMk40?=
 =?utf-8?B?bU92Vys5SW1tRTJES3RJdmhlSGJGREVsUjE3c2V5UDB5NmFRL0VDT1o1QXFx?=
 =?utf-8?B?YkJWand0dW9pNGhMSmo0WU1OOVJ0bFcxNUQvQVllSTdvVXVzQVdzcVVMTlNE?=
 =?utf-8?Q?G1U9AkG4bfQ0/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4877.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXpkbWE4WlIxTUJLS242TXJKMWVpSjVnZVFVdGNQd0JUYTk4SmpPYlY5c3do?=
 =?utf-8?B?eG1STUZGWnQvaGNyK1B5VEdZMjNEU1FqUmlQMDVRNVFVc3FvcVBaKy9pRWVZ?=
 =?utf-8?B?RVUzeHFLRFdrWHA2TXF4S1EzYU1BWkZaYW5vSEttME5mVDUrK0t3TWRxaGZo?=
 =?utf-8?B?ODc0Q1BUS010RThsTnFqT0RnQk40WXVnRlBkaDE3R1BHWWd0ektMZ0FVN2hD?=
 =?utf-8?B?RG4yWlpCNFJjb2hxVnJaUG90cnRkeEZ5N09nOGF2eS9SNm5VWWs3MFlaU2Fh?=
 =?utf-8?B?b2g4eno1WEt0L2ZZRFI5ZHhrQm4zeUdIbzh1RmRnd3k4cDc5bEp3WkxQWWRG?=
 =?utf-8?B?OGIwMjBMeEMvQ1Q1VEowTEdneFJveU96VFViZDFyUWZtVmYrK094TjI0Zmdh?=
 =?utf-8?B?NGJibkRPTkxsb3hac0pZdWpRd3oyVE44YlpzZWt1QkVUS0FrN2JENG1iaTRz?=
 =?utf-8?B?Mk1aSHlneXB6ekRCWjBhWlJ3bUNBc3gzVUF5SUMzaGVGTFIyU3ZoRlFtdmc5?=
 =?utf-8?B?cS9HaGFkckd0ZHJabktVbTRuMU9CRC9Ob25uOUpicnVVVndzY1d2T0J5T2dK?=
 =?utf-8?B?Q2pvUWRGbnVRRW1LdUIwcElFbmVueGtVckNjMnMrcExpeVpMVVhVbTVkejNB?=
 =?utf-8?B?UmpKM1ZhdEFhRm9SelJ0UGR3enNVZkFVQWMvamxJa2QwSnAxeWNQQzB1ditQ?=
 =?utf-8?B?QXhPRU56MG1qaTFxdUVQcGJVWjlBZGE4aVVrU254V05OTTRqaWxPMlNoV2d1?=
 =?utf-8?B?UnhzOFk4YUR5ZW5IbzZqRndRdmZXOHMveWpINk5PZnRIMWtpdU85ZVRYK3Ur?=
 =?utf-8?B?T1RTakNvcjkxQThRclRlSGNmWDRIdm1GVkU2RE5sREZEWWRWZW52RHZkMVda?=
 =?utf-8?B?RkFXazlTam81K252WWc4SlIxaTV5TDhpMXJLck9KZlFxMUJzcWtNaEhrekM5?=
 =?utf-8?B?M0RENWhURkp5bGpGU1lSN1JWeVppTWEvNldWYVR4ZXdURE5WS3o2SU95VEVr?=
 =?utf-8?B?UlBJNW0yd0ZCU1RTSkVZcHI1SWJtYkRhMnZ6NXVKdlduUmVaalpsY1d1RUdh?=
 =?utf-8?B?eW91ZDltOFZLWFJpTjM5NGNteXRrdUJoZHJGMEJsMnNZcmMxMkpSRmxzWW0v?=
 =?utf-8?B?RVVHM2xkMGxCQ0dybjN0a2dkTjNZKzVFdTQ4bmlsREc2Z3dCQnk4SER1cUhk?=
 =?utf-8?B?b1NMc0t1L29uWFZvM0dyZ1hyMk45bk1mUVIvdEFPQ3FYWG15Uys3WXJkeCs0?=
 =?utf-8?B?aCtLVVVJNnREVkNaR005V1Y3TVZaaS9JcFRPUGZoQzVBWG1SNVFqZlRFWG9Q?=
 =?utf-8?B?Sk9pQlBZOUpJdHdnUFZrc1FKZXlpUGRDOGw0bHlzUnM5dFhhaUtrOGQ1S1FY?=
 =?utf-8?B?czlQNmpvbC9IRmlFaVRndUsxVzJMRkVsZDFCREF5cGdZQ2dLa1d5N2F2SDUz?=
 =?utf-8?B?MUNNRy9hYVIralVZN2NnK3JXQlRVM0toSGlQWjR6MFFUMzdHb2ZQNVhPWFl2?=
 =?utf-8?B?RXhzTXk0YnVIWHVPZHNOYm5ySUE3dW9helk4eEM5cXlHZ2pDR3pqcER4M3FK?=
 =?utf-8?B?ZkVzT3g4M1ZjWDcwWUx6dGxJRm5ZMEdDRlRPVWc1eDhwWjhaaHc4NkQ1bmUw?=
 =?utf-8?B?RVhsWHFLZVNFR3ZtWk41OXVzcUtxK2tyeG91c1lBMWpyakl1TnB6MmsxSjVt?=
 =?utf-8?B?cFYwWTNUdWR1UkpFTU1XTkhKcEZVcW9BWCtUQkF0Q09zOUZZMjFjK2JDcE5l?=
 =?utf-8?B?YTBYc3VNN0dkVStCcGRJeTBNRWRBaWpqa01aTGwxelBOSjczSWwrNXVKZlc4?=
 =?utf-8?B?aDBRWEVoQm9UZS8vVjg0UFVMZ2xXSDR1T3FaZ3VPbmZHY0trTC9EYUhRNDB1?=
 =?utf-8?B?WHRnL2tHZDdYTVk2U3hhenFyZnpERTFXYXlOMXZCZEhDTGNXKzc0d0QvOEZv?=
 =?utf-8?B?VE9YUy9VUTVRYitFem5ZRVU1T3QveTk4ZlpLL05uRlFoWFhPRzUxN0pJT0Vh?=
 =?utf-8?B?TnpoUlgrNnFSMXZLMVBCTUUyY3o4QWNkUFVvb01DalRYYlFaTnRxaTgyV09h?=
 =?utf-8?B?Zmp4N1M5Y3FhbzNXalpDSkZ3K3ltOWU3enFiT2JKK0xpYk1kaTRIQURlQlZ5?=
 =?utf-8?Q?1M04ybzolkAIQ5brJMPZrqc5x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fabeded-e1f1-4d7a-9186-08dd46c80596
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4877.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 16:05:05.9352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NSiyhY70GjKXIMRfDWFWv8s+r8IJmvmutoURHmwGP3EeaJWibahhnf1cOXorQN5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771



On 2/5/25 6:52 AM, Robin Murphy wrote:
> When we reenable TPH after changing a Steering Tag value, we need the
> actual TPH Requester Enable value, not the ST Mode (which only happens
> to work out by chance for non-extended TPH in interrupt vector mode).
> 
> Fixes: d2e8a34876ce ("PCI/TPH: Add Steering Tag support")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Wei Huang <wei.huang2@amd.com>

> ---
> Spotted by inspection.
> ---
>   drivers/pci/tph.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index 1e604fbbda65..07de59ca2ebf 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -360,7 +360,7 @@ int pcie_tph_set_st_entry(struct pci_dev *pdev, unsigned int index, u16 tag)
>   		return err;
>   	}
>   
> -	set_ctrl_reg_req_en(pdev, pdev->tph_mode);
> +	set_ctrl_reg_req_en(pdev, pdev->tph_req_type);

Per prior discussion, this register needs to be set with tph_req_type.

>   
>   	pci_dbg(pdev, "set steering tag: %s table, index=%d, tag=%#04x\n",
>   		(loc == PCI_TPH_LOC_MSIX) ? "MSI-X" : "ST", index, tag);



