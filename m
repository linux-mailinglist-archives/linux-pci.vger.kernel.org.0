Return-Path: <linux-pci+bounces-3745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0A085B1D2
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 05:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C66B2246B
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 04:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907C0535D0;
	Tue, 20 Feb 2024 04:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UM0jxF0n"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADBC535C4;
	Tue, 20 Feb 2024 04:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708402052; cv=fail; b=ku5bGoYC1AGUaWnqtO6Oti9uLuWbBhw/Apy57ECBcsKVFcOWBYL/dLeWK2HAqQiSNidAEEs+VB+ge9jblfOnjAhZRBrLVMemskUfgg4hbHji1FL2mz5MXygCBXnKO1cts0guXLbWd7p0zRpyhlUFQ+Hl2jgde+MlfmQI1QpBIoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708402052; c=relaxed/simple;
	bh=GQzuek9q1/h2hdJW/b7nWyiqo9JKllbQOJkd2dlI1Ns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WzheX856j5TGJw8U4wlgEPUeEgdlUktHxAXwed3OOpjKQ5w+M8d82LHvA3/01qTmTrMGU8lFIJdarJoTkwglxAShjbIqt1Sh0Al7sKiW4xUlotqn2Lp+sIo/5qOJZK6+SOUKhzyxV5vyGxFxvbPLGWMfv7q8PyaajjImoAzbdKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UM0jxF0n; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/eIYaNMblZgUcs7sS4QwF2W4y22JRTtwgO0oij1TCSbbD34JH+MMG+iCTAXLuE8x9Jz/Ma3bbifwocVm6y5Fn5GIuCxZ0TOKTu3nATzJU1tLZ3vXN/4651+q9e9vmV0NfZMTdDohDCOQj2M+pOYwhx6deerrHyBhA/b1pzYgk82YTooN8fi3PGjP5wOkzU2iney4ZBVlfTmxKx4/UjcWWECmTsjCcpJyL781UB7A9tfN+i+Laqa9TFK3IRiIdieA/7Hf7UQhKTWC3DgDOovUqr9coTpq+LHO0vAIqPnh8Fm5kedDiXAGrZwjYoiyM2/BEjosiOgw7aBMuop+EfFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QplnY3qTBe4NUyNZF+I678/uzZeX+MV6cP4vhMXjI4=;
 b=Wh05baWv63DwN/WBk2CCms8mU2PJLgolldVSSKe9rCiej7M9JDsJIqt5y9kE89I+1JhktG4nuZuKqBXDY7SRXfPXfXtlAwMA0ePHB61eLc8RUPuY4HRPSYRqQU6taQ9ptLU+2MHYhf0LUo/B1zDCjSXkQElRZy21bsWyNI0MhwhjFAxJo1ZzjxeaIJdDRMUnRD/Y5ma2tGtIfGigxeGl/w23aLXh5/izJHddWr1J2NdM3ZnGqPEKmkAqm0la5c/ioak0RjB4DjvcPxj7z2KSo0HxxRlWydbd2nAlYU9Ai0+MxKKq3guP5J4Q2DX0sSuZkKuXyY9fUADsFM8FMk1y9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QplnY3qTBe4NUyNZF+I678/uzZeX+MV6cP4vhMXjI4=;
 b=UM0jxF0neoDNu8l16bzKZSPfTDjEi5ybZTWfpPx3Vr35E7weBGDXAeUKIz8aGS46VapDfVZ0Ptc2RlJKmv/0+s9fnfy+AFH6Xejzu+k59ZZvV6jK9VjciA/6FetCJjEOK1pxci3uYraRUAPCs3wz9TgCgvFzVQHVqAU1Qciheb1U5F8kV2gLREagjrQ21KpzBN/e1U/mQpNn+21ns1vgB2xo2qeSpPhDonVRQQVnVHp2BE42c9cziRlQoYI9/yVrhTZx1oEN69xpkAZM8yefJ6gKPlDTWiCHEu1LlLJ07YLeiAEjTw9rZq+oOUHMgJIPHm7qLx/ORgVQwr1LpezpWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Tue, 20 Feb
 2024 04:07:25 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::ad63:96df:9a9a:83e4]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::ad63:96df:9a9a:83e4%5]) with mapi id 15.20.7316.018; Tue, 20 Feb 2024
 04:07:25 +0000
Message-ID: <c09ae4cf-8004-4c64-80f8-47dd1c014158@nvidia.com>
Date: Tue, 20 Feb 2024 09:37:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] PCI/ASPM: Update saved buffers with latest ASPM
Content-Language: en-US
To: bhelgaas@google.com, macro@orcam.me.uk, ajayagarwal@google.com,
 ilpo.jarvinen@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 hkallweit1@gmail.com, michael.a.bottini@linux.intel.com,
 johan+linaro@kernel.org
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
 mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240103103501.2428197-1-vidyas@nvidia.com>
 <20240108124248.1552420-1-vidyas@nvidia.com>
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20240108124248.1552420-1-vidyas@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0P287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::12) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: c117b76e-65ab-4dc0-9e33-08dc31c9719e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r20id8p45OSXqyWQuTEh1+CsLHTxKINpRYKTYAe5ZPyiMXQgdxZ6mFB8nVSpRA7tf2abE6xDoerz909lT+F/5lqIujlYuhMSRpu7OysEtF5LkmTtIJnE8R/cmuE3SfclMGluLRDq9UmQ9dhSwwszXRgx32VJMZ4V6hDpdz+CjhAVndVm00cipKUwWy7W+mxJiGbXmVeqVK8L6wwZNyWdDMe+X3zRoSqh0TTe9yTBriL/PfWP8KupfRFLmReiUv2PsnkMiQ4oaTmiQ2Wbj3ZmMsY+qRvnuR/MxrdVQyi4ZzE0FF2Hy12UegcpHEc2Ns4UJfB+WJ9vMekU9hSHSUcBbHVT2DaZckclAVrswIvMH0uoZxK0ntHF7s4NGAqoVTOD8Lhnef2lGPiov5SZMyJmNTTAERDa6OZ3pvMjvm17kieEwduvHAz97ZkCD3dDp6/nD/+jTUR/RwHVaaAPg+tbdVxfPQq1+w9Tc+oLDRvBs+jZFzj13qhqOhpWDSxuFl+BGhsJ13xNBttbSPfK55owMMw9Ap4LFFQM0jNRZrBGD2g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alhBTFIzaXlkVEdWK3RMckJsLzh6bDU5eUM4S3R3c3pkYndNYWxUTi9vZ29o?=
 =?utf-8?B?TnhmT0pUNkdiYy9FYldIcDRXRlJHbXhyS0IyMThJL3YzUmtmb2pvRFMwVDg1?=
 =?utf-8?B?WTlud3NIYVZicVhSRDQvNmdoUmh1VUY1amtxejkxbWxKNXhtYm5pYWZ1S0Vt?=
 =?utf-8?B?RHpVQ3hGcFpDdHltVGxZL0ZRT0hsZnJITmZWTmtRQnJuNzFqQ095aURocUZD?=
 =?utf-8?B?WmY4VnZXOUlzdTR1WWtRUXp4WVN1cGptRWZzWmp5OTYyMHdpcUZSS2FCY2xQ?=
 =?utf-8?B?OFVrOTlSMXNJbldwTXNuVmVxaFlOMGYwbVdhSTVoSHVqT2tmbFdCcHF6WEVt?=
 =?utf-8?B?ekFFcWdTcWFLT1hSZ0xidGRkdUg5Q2M2UUxZazU1SytKRGxPRlBQUkVYdkto?=
 =?utf-8?B?eUFaUVJrQ05yemNXUGlmbjV4aHYwRG1nQmJVMjVqdGNmVmg0L3B4bGJWcDY0?=
 =?utf-8?B?UDhEeXhJV2dXMEJDK3lFZU1CTzVVUEtlcTE1UDJ5UnVPdXE4QlpDS251WUlh?=
 =?utf-8?B?Mm5iNS9saURERUlPQU9yWE1hdUZPOEdvcVdnc0xPVmFrS2JtdVRaSElvRFVy?=
 =?utf-8?B?aHU0cC9pM01JWjRKVWs1aXQ4ZlFRcTVHSFdGR2pkUjFZZlAxdG4rbGNNVXpZ?=
 =?utf-8?B?R2hSa1d5YmhCWHc2UmpkSDVQZFZhaDZqcGV1dG4yMFR5TWY3YXA4T24xN2ZI?=
 =?utf-8?B?QTczcEVlbWNCSUV0d0FNQVVKR0s5N1VMM2RoOEFNekNDU1BiM0hwWFlQcWYy?=
 =?utf-8?B?c2pPRkV2bkRjbENDSktkSlp4ZGcvQ2d6Q0l3V2FXZm1uQUVsNzdiOFo1OVpO?=
 =?utf-8?B?aHFJb1QybjUrQ1lER1NobUkyaGVaMzRYeFAvMnRJL2t0QmpXVkl4RlppQStv?=
 =?utf-8?B?RjFtRm45VEg3N3drVUZIWWZpdzR0NHdkamQxNkZuaEpPeThGd1VUR3AzOHAr?=
 =?utf-8?B?UG1KUXVOY1BVbHY2K2dJcHZaeXB4ZC9KZkJZZzBJV3ROSW5RRWpBbjFlUkln?=
 =?utf-8?B?UGNsTE5aWjEzcUV0WFlQQjNVd3dEaGdBZ3hNNXRPa0tlM1FGRElEMWEwTFZ5?=
 =?utf-8?B?Y1BMSHJjNHkva3RTMDdMYStqVTJPOHc5MTdCVjBocGhOcy9rVTNsUzJyR3Bk?=
 =?utf-8?B?Sk5oTFFqcEhNZXZGSFhUNUdnQ3ladmpwZWMvZUVtajZIenUyWHA5OEsrMXB3?=
 =?utf-8?B?ZUpHTDlkcno5Ync1ekVKUnJwa3FxWHpvbEhRclVkSmJDancwZEE1d08vRm5s?=
 =?utf-8?B?MjkxNFJqbllxRUtOUEtVZEh6cm9aT1o5RzFkL3B6OEtpQzk4b0NCbkx2cXpm?=
 =?utf-8?B?UjY3MFZHeWkwanhpUXZFS0p5STR2ZnJ3bXkxcDAwRHlUWDFLM2czRzFXVGZa?=
 =?utf-8?B?RzdSRERnaG9jY1JYa21LL2dUM2xRL0dxTDgrUFNweGtjTDY3SkNYWFJsUXV4?=
 =?utf-8?B?c1JwY29WSEQrcFQrWVFpR1d3ZUQ2Mk5WRzh3a2xkOXJvSVpmZGFuVkFsNDdK?=
 =?utf-8?B?YVFBU3JYNEd1bVV1Zk1BaGluY000SXpzUzJwNFRjcVk0aWx3TndJV2hNblRl?=
 =?utf-8?B?SDFqNGY0UG0xeGdybFFIWjZJbFM4RVc3QkRMeGdkakUrNlBYZW5UeE94UUp5?=
 =?utf-8?B?RXk4VTNzN09zdWFHR2xpcXhUVk14OTFZRng3NGJWUkxIYWVwYU1WSWVqTmZ0?=
 =?utf-8?B?Q2ZNWG9McFRVM1ZuRUpkS0M3VFNwRHRGd1RmSVkrK3BBTGVXcHdMc3krUEk4?=
 =?utf-8?B?dStjWXhPb2NyOG5SR1RsVjNFbWNLb2JDcFpqem83RVhxcW9pZytlOHByTDl5?=
 =?utf-8?B?dXM1d2Iyc1V3OWdlTXQvWmR1bmhnM0s3UkVqZDYrZVBqbm5Hanl1c0YwN2Ri?=
 =?utf-8?B?TFN1eWVCZDdla3d1OFpOR01FMXQ5M3lWY0t2QW93SlJMOXdSazVyZFBNRVVv?=
 =?utf-8?B?VG5tZ0plaXZkZiszRlNLRk9VSEo0b1RjVW1tRDY3dDdyZ0RiTW0vK0M5ZUdh?=
 =?utf-8?B?T1VZNXhFcWNjUWJTYndqYk0xUno5WVRsUEZpdUVKcUdkWWc0UlhGRkUrQzRh?=
 =?utf-8?B?MlE5YnZES1dCRytYVUpBZUJTRUVhazNBRjdmeTkxcDBCRlcwV2dPT0EzWkRB?=
 =?utf-8?Q?cWccb1WF+vcTMFXa27Y/y9Y3G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c117b76e-65ab-4dc0-9e33-08dc31c9719e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 04:07:24.8132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAVVjC96epVt7HmcO+aB/TI8SVWhWu/Ecdwt+O1oZapi4C1V2P0DUxFUXaawoBwFvnZwvBFr7cdn2gZGPsJC7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258

Hi Bjorn,

Any comments for this patch?


Thanks,

Vidya Sagar


On 08-01-2024 18:12, Vidya Sagar wrote:
> Many PCIe device drivers save the configuration state of their respective
> devices during probe and restore the same when their 'slot_reset' hook
> is called through PCIe Error Recovery Handler.
>
> If the system has a change in ASPM policy after the driver's probe is
> called and before error event occurred, 'slot_reset' hook restores the
> PCIe configuration state to what it was at the time of probe but not with
> what it was just before the occurrence of the error event.
> This effectively leads to a mismatch in the ASPM configuration between
> the device and its upstream parent device.
>
> Update the saved configuration state of the device with the latest info
> whenever there is a change w.r.t ASPM policy.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V3:
> * Addressed sathyanarayanan.kuppuswamy's review comments
>
> V2:
> * Rebased on top of the tree code
> * Addressed Bjorn's review comments
>
>   drivers/pci/pcie/aspm.c | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 67b13f26ba7c..1b4f03044ce2 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -138,16 +138,34 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
>   	return 0;
>   }
>   
> +static void pci_save_aspm_state(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	u16 *cap;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
> +	if (!save_state)
> +		return;
> +
> +	cap = (u16 *)&save_state->cap.data[0];
> +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[1]);
> +}
> +
>   static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
>   {
>   	struct pci_dev *child;
>   	struct pci_bus *linkbus = link->pdev->subordinate;
>   	u32 val = enable ? PCI_EXP_LNKCTL_CLKREQ_EN : 0;
>   
> -	list_for_each_entry(child, &linkbus->devices, bus_list)
> +	list_for_each_entry(child, &linkbus->devices, bus_list) {
>   		pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
>   						   PCI_EXP_LNKCTL_CLKREQ_EN,
>   						   val);
> +		pci_save_aspm_state(child);
> +	}
>   	link->clkpm_enabled = !!enable;
>   }
>   
> @@ -767,6 +785,10 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>   		pcie_config_aspm_dev(parent, upstream);
>   
>   	link->aspm_enabled = state;
> +
> +	/* Update latest ASPM configuration in saved context */
> +	pci_save_aspm_state(link->downstream);
> +	pci_save_aspm_state(parent);
>   }
>   
>   static void pcie_config_aspm_path(struct pcie_link_state *link)

