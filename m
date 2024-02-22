Return-Path: <linux-pci+bounces-3890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5638886043D
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 21:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A52C8B232FD
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 20:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2590B12D211;
	Thu, 22 Feb 2024 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VcY/+tyr"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B2573F28;
	Thu, 22 Feb 2024 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635576; cv=fail; b=gu5ioPIs6FpZB0yu9LooiZumRlPVp/eRD6wqKtA3X0Qo3cO+2ahNGvyFlZj1NT5ddUOtrbaQel+yt/nCs+uWHYTlo6HR+v++/5e7jSE2rBvFrwKMqSwJ/ree0bRitq47G/WiWlyL5wbm/UcEFaZOUf8r5oEaPF1sASG6IC98pgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635576; c=relaxed/simple;
	bh=nud9x9d0kLyTvW1caamEpwQ54gTWzZ1XfdWJO7i0hLA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cp8Auk0ZM34bGKKHshUtT9JTXyCnBortjGS9QSWlGpocY0dh7lvnJE4euBMfK6L2W+0RvuVpPIwT3qST8lo9Y7F/CXLI9+zE+IcJRyrA/a5k2hCSQzmx0h96DoiXfeJBO4E+ej0JOvNruDxpdm3CW0ZnR6uvxPrgjha48OJJZV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VcY/+tyr; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+VhFhmCf9p8EkmXbov89EX7H4ZUmC8zvSPprF8UmaKmJ7biAWDO5I1t7xzD7SeRH3FN4S45vstAf2mX/mzkVCBQ0yW9a2v7figoXhyNNGgFvt4VElZPiJS69dLKTwiPI7FIhTubKGvPErhu76arnkK5cYtPf9t52GmgFD6rbaLYMQhmFKEZfetlewwc9ieU7x6sEEAb1YrMnwE66/R54HCdlza9nDQnvNqpEwJXNFtsShTFnnFM042ND6QN2d2f1XZdF0w1DXQcOlwLK6yf1u9WJZBYGZLFQDkUmG/oC1v9JV1T3Pf5qQiLAsy3qK6K7X89bulGy/XUm5R+96IObw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1BGlooNL7ZA/QDJX6ts4D7FR66/ke3g+Wh8na1JEl8=;
 b=SW8uBx0jvQEkhya5n2QhoIZy4ZY2Ho2xC4MXl+2tx9ClK/nO/8p8Sw2BYiXG0uQpdeYxUcZpGNiLlM6HEvjjUaihBxKzU2gfJO3j9w349lMw8e4soIUplTl7zXFOhVsDphlIdsm1Ueotey12zeApbFtk1LPVBox42T9bX6P46G2Z6qqr/Xw+GW4zB9Td4lBd7/5jKez3cMw+jv3Nu85BfXc67a12uyhsHSZwjo1np4k9Z+x3cnVCPa6P40em3TLBVHoAumjEO10UDPECw9iATpufmwomQPUMfQ0s9ibSvH0bJwU5ZKC/ZuXJAunImMldqRTyD8eVx8ow9Rk9jecLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1BGlooNL7ZA/QDJX6ts4D7FR66/ke3g+Wh8na1JEl8=;
 b=VcY/+tyrYf8ekptybxkV5LCsLF5L+T0ELAWavOEg72jZdD9j1IGKqglAW28ws/oX2ZDTnkHqDZnQahD1ZldXAXpSZyvUX/YptYSv5ES+POlLHm2kzka0rr5vwsImnxEJuVsJcWB+dbnlPt9EVHvu7dZ6D9WzV1s6ZFKuf/1yhpjIQpAYats+bhZxNTsm/9hjFc7VMmvoJcwMHqSxNlEP/mVUmHtLHI8PXKaVKn5FOl/ylQsPof+bqqI/vHmVs46vvDNrxrgaFSaxUx9J+UhXyq8OAEWrQqQArb0E/lEtxW64534otzvG2L6FDqxE/c6U8ZALBOkFB+QUGMCRw520cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by SJ2PR12MB9237.namprd12.prod.outlook.com (2603:10b6:a03:554::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 20:59:22 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::ad63:96df:9a9a:83e4]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::ad63:96df:9a9a:83e4%5]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 20:59:22 +0000
Message-ID: <f2cf0041-8da3-4fa6-8fc4-7fbb7706514c@nvidia.com>
Date: Fri, 23 Feb 2024 02:29:13 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] PCI/ASPM: Update saved buffers with latest ASPM
Content-Language: en-US
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 bhelgaas@google.com, macro@orcam.me.uk, ajayagarwal@google.com,
 ilpo.jarvinen@linux.intel.com, david.e.box@linux.intel.com,
 hkallweit1@gmail.com, johan+linaro@kernel.org, xueshuai@linux.alibaba.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, kthota@nvidia.com,
 mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240108124248.1552420-1-vidyas@nvidia.com>
 <20240222174436.3565146-1-vidyas@nvidia.com>
 <83f0d77b-8ea4-4443-8077-6139bc905952@linux.intel.com>
From: Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <83f0d77b-8ea4-4443-8077-6139bc905952@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::9) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|SJ2PR12MB9237:EE_
X-MS-Office365-Filtering-Correlation-Id: c054ce60-9a15-4b69-8321-08dc33e92521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1k3ch/kwWwY9zJ1eG9qs05udkyt5x4YvE5DB0sc5WrdPCbY80i4xfw9USA4s18sAS2fMJffYcRnHoUECCmfFqzM1sTPZv7E3sheaD927uWOqcJfoY8CxW0kpCoe3MPrfdLT5JcwCkiYtrL6rfkiTIL02v/+JtV3VZzi6NPr1rqjeFzbQPbKN50/oqFtmbU94KdXfLTt/8fi2lWA7qi632k/1uFT6G58FzQr9aa9dNy+6piOUkBXaLmMdtlXgKmnm0lQ7LFIzKk4LJ98tLsmI5NYsXtr0Pgt2ibwFAS1KJnyVMBJiNvw8RvT4H+ypInwP6FcSJsGJzPFAhqUcDAd0RqxKb4+hUgLPRy6n2HnDMaE3sn7xpbfLPvlCey+RzUrOojUK85v1yZCi4oFJB3asHaCG0zbBZ/AbhYQz4KsRp60nS+ypt5nz2NztCnXGAjGn8SHtXzGVAF1hrRaDF14Pvsj1Q0UpjYl0vytZR6iDzVfUIc/9tfa4dAkJHhfqxPe9COMT7m0XPu5wXuZVEY8mQHr9X7jWYZYMv5ggOtt5vVlyKHgnjfsgbWYZ8SsdQbJQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVBZMmIyaXIwRlUxdnYzTkR0ZFhoNmEzcXoybzZ0UWoxeVM4blF4Tmp6Skhz?=
 =?utf-8?B?aE9Wc2pGWUxOUkZTTGtudkE1elRKQUZOM1ZtUjNYbHh6S0ZaRXdWR0NUeFBu?=
 =?utf-8?B?OFordHMzR1VNS3JhaXZNMFg3NWRlZFRNeUUzTU9yN0xKSVI5REhXR3UzQjF2?=
 =?utf-8?B?Zy92NzdzQXBxU3M3MklrQ3psM0NGanJweUlKYUNRQlNObGtKQ3pOTm9HWm1L?=
 =?utf-8?B?ajVzemJFWUFNeThPNWxGdDBhZXFYUlJmZUVCenc4UFJRTDZlb2xnbVRzMFdj?=
 =?utf-8?B?UitwbnNuUTFVbmtLSEhmdk1ibHJmL1VtOFZTNnU4Q3lwTVVlb0Q1K0FQVGxN?=
 =?utf-8?B?SzFnVDZpMjgrMmNDQ3VIbDl5a1JzMXc0eW43SHpKOFdsbzE0VEJKMUxUTGlL?=
 =?utf-8?B?aldiRFV6Tm54a25uRFFWQ2dQbUxzb0tpemk3alV5Q1FoY1F1ZG1tY0RuUVhU?=
 =?utf-8?B?a0ptcmYvZ1BDeStVR3VhY0Z6ZkRCbkRnNWszVVVaUGsyQjVWbG1nblJyN0JG?=
 =?utf-8?B?V1R2RkR0UHYzN08rcEJTQ092NDhzb2ZIV2tPV1JBKzVhSTlsOWxUb3J4empV?=
 =?utf-8?B?aE9KOG80Z2FpTVRwNkZJSzlPK2JqWjFaNDdyY2s5UWpvL3FkRlBoZW9ZUCsv?=
 =?utf-8?B?SGVmNEIrakZva1dscGJxYkFrNnQwSnZkNUZvQ0Z5VUw0VUNIejlQNXhMRmlz?=
 =?utf-8?B?TS9KQ0pGYXFkRFM1SEZzRHM2SDhHMHpvUy9VWlZRZ045ZTc1WFRKU21mVFFF?=
 =?utf-8?B?dTQ1dnpCc0h5eEhMYTF1RGUwOEIrdGE1MlZZTzVIZS85bFBQdFVnZ3JEQjgr?=
 =?utf-8?B?UnF6ZmxoczRZb3VKenBTbHR1a3IvWW1JOWE0STI5cnE3R2l0MUJ1R0srRnd2?=
 =?utf-8?B?VStLNVpIVEh1SHNQUlZlai9VbEh4aVJwRXpTMjZ4TTJ5ZUlDMmlPNGRRc2p1?=
 =?utf-8?B?MWR2OW1HcW8yMGtBV3BZdkZTTGtybUExOXgyblFmeENPbzRIdXRVQWpQalZP?=
 =?utf-8?B?dW8xWkhJSlM0NkNLVUNVaEpQVHJHWEZ0dDhUc1ZYQU1OL3hjM3VWYUhCT2VT?=
 =?utf-8?B?L1U0QTNoYVRCZFQ2aXl2SHpzMGFNZkVpS2xnbmxBR1prYUhiaFlVc0JZNHZz?=
 =?utf-8?B?bGtKVzlod2phZ3FlVW9JZ1dMYTJkVHJOZXdRTTcxaWFYRmw3RU14dmVLdUVN?=
 =?utf-8?B?RUVxNWxoNFhSWkJTVjRsbmVpaWJoWlVSMXhXaFZ2WDdBTFJmWXJwWVd3MjBC?=
 =?utf-8?B?QVpwa1RrZDQrL3dZS0dGdjNtcVNLMUJ5SnpmNjhxOFR2SU5pTGhITGZzN2Jz?=
 =?utf-8?B?MFRiS3VhdW5VVWlzV2VyckpqV3h5eHZtNDZ4WTdYN1pFWDVvTjBteEFIV1BD?=
 =?utf-8?B?S1dnOWxGZm9IeDd2TE5wQytpbXphd3c2eGVtVytFM1RJS2NxOVIwSU5qM3RP?=
 =?utf-8?B?WVROZ21GYjB4ZTluRGVPTDMvcGJmb0d3S2RZSGs0WXI2SUc0dU9tb0x2UURm?=
 =?utf-8?B?a3ZFQnlDMlVHRzRZK3NZdGJFcjUvR3dzdldwRmpiSnJuTXdNbUowQXcxUisw?=
 =?utf-8?B?aDcwVGFEYXB0aGVqcEpuTUQxZ0dYOFozdnRlRnIyTHBRZ25Gdy9vSXlMOG9k?=
 =?utf-8?B?ZmR2U2U4Q21sYnpaaGxyRTlRK0x6blYyeksrdE9vRWk5RkxyOS9KMnAzVktL?=
 =?utf-8?B?Y2MwcEhOVjVQbUwwZnh0Z25WQUFtOXNya0hhTlVQNzJyd0RBZklzUjJ4aDhq?=
 =?utf-8?B?MU1zNkpBREdJRVdTMEJDanoxVk43UnlmaFNtaHdnRFkxL1R0U3dRZlpYQndM?=
 =?utf-8?B?M3pXM21vR1hhUXhubU8raFRkZk9PRlN3L1VFc25MTE9hNDdLbFVGZHJ3a2xj?=
 =?utf-8?B?SzdxRHpkaTZUOGRTRHZabFg0QTZIV0hCdU9yUEVsTWR2c1ducUZubVNMRzBN?=
 =?utf-8?B?Z3BGaGEzdjhLRU80TVRyeDQwejZYMmJTeC9ON1REcWJYVHBmT3M1ZlpNSC8r?=
 =?utf-8?B?dXZDVVIrUUJPR0d3WVlnRWc3Qkk0L0lSMS9HUkE1eEpkVTZlamZhVVJNMFd4?=
 =?utf-8?B?dkJWNjM4alZ5ZVNoMHZkRXBmOVZ6RXlXZmZHZ0VTS1VXQnB4VHpzYkRjR1o1?=
 =?utf-8?Q?FcLub5z0noSgA9j0Zbkc3Lh17?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c054ce60-9a15-4b69-8321-08dc33e92521
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 20:59:22.6721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIXgfjmHnrHhdl9qnfuJbxZ1g5Rhq5HGALc6rIzmlVIbHdk42V7g59VKblqshLEx/zsrzZUrfPbhNT2mpHI9RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9237



On 22-02-2024 23:50, Kuppuswamy Sathyanarayanan wrote:
> External email: Use caution opening links or attachments
>
>
> On 2/22/24 9:44 AM, Vidya Sagar wrote:
>> Many PCIe device drivers save the configuration state of their respective
>> devices during probe and restore the same when their 'slot_reset' hook
>> is called through PCIe Error Recovery Handler.
>>
>> If the system has a change in ASPM policy after the driver's probe is
>> called and before error event occurred, 'slot_reset' hook restores the
>> PCIe configuration state to what it was at the time of probe but not to
>> what it was just before the occurrence of the error event.
>> This effectively leads to a mismatch in the ASPM configuration between
>> the device and its upstream parent device.
>>
>> Update the saved configuration state of the device with the latest info
>> whenever there is a change w.r.t ASPM policy.
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V4:
>> * Rebased on top of pci/aspm branch
>>
>> V3:
>> * Addressed sathyanarayanan.kuppuswamy's review comments
>>
>> V2:
>> * Rebased on top of the tree code
>> * Addressed Bjorn's review comments
>>
>>   drivers/pci/pcie/aspm.c | 28 ++++++++++++++++++++++++++--
>>   3 files changed, 28 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index cfc5b84dc9c9..3db606ba9344 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1648,7 +1648,7 @@ static int pci_save_pcie_state(struct pci_dev *dev)
>>        pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &cap[i++]);
>>        pcie_capability_read_word(dev, PCI_EXP_SLTCTL2, &cap[i++]);
>>
>> -     pci_save_aspm_state(dev);
>> +     pci_save_aspm_l1ss_state(dev);
>>        pci_save_ltr_state(dev);
>>
>>        return 0;
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index b217e74966eb..9fe78eb8b07d 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -95,7 +95,7 @@ void pci_msix_init(struct pci_dev *dev);
>>   bool pci_bridge_d3_possible(struct pci_dev *dev);
>>   void pci_bridge_d3_update(struct pci_dev *dev);
>>   void pci_aspm_get_l1ss(struct pci_dev *pdev);
>> -void pci_save_aspm_state(struct pci_dev *pdev);
>> +void pci_save_aspm_l1ss_state(struct pci_dev *pdev);
> is this rename a review request? It is not clear from the commit log
> why you are doing it?
I rebased my changes on top of pci/aspm branch which got the support for
save/restore of ASPM L1-SubStates registers merged recently. As I see,
the name of the function that saves the L1SS registers is given as
pci_save_aspm_state() instead of pci_save_aspm_l1ss_state(). My original
change already adds a function to save the ASPM state (only L0s and L1)
info from the link control register and I called it pci_save_aspm_state().
I thought it makes sense to use pci_save_aspm_state() for saving the info
of ASPM-L0s/L1 related registers whereas use pci_save_aspm_l1ss_state() to
save the info of ASPM-L1SS.

Thanks,
Vidya Sagar
>
>>   void pci_restore_aspm_state(struct pci_dev *pdev);
>>   void pci_save_ltr_state(struct pci_dev *dev);
>>   void pci_restore_ltr_state(struct pci_dev *dev);
>> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
>> index 7f1d674ff171..a62648dd52bc 100644
>> --- a/drivers/pci/pcie/aspm.c
>> +++ b/drivers/pci/pcie/aspm.c
>> @@ -24,13 +24,29 @@
>>
>>   #include "../pci.h"
>>
>> +static void pci_save_aspm_state(struct pci_dev *dev)
>> +{
>> +     struct pci_cap_saved_state *save_state;
>> +     u16 *cap;
>> +
>> +     if (!pci_is_pcie(dev))
>> +             return;
>> +
>> +     save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
>> +     if (!save_state)
>> +             return;
>> +
>> +     cap = (u16 *)&save_state->cap.data[0];
>> +     pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &cap[1]);
>> +}
>> +
>>   void pci_aspm_get_l1ss(struct pci_dev *pdev)
>>   {
>>        /* Read L1 PM substate capabilities */
>>        pdev->l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
>>   }
>>
>> -void pci_save_aspm_state(struct pci_dev *pdev)
>> +void pci_save_aspm_l1ss_state(struct pci_dev *pdev)
>>   {
>>        struct pci_cap_saved_state *save_state;
>>        u16 l1ss = pdev->l1ss;
>> @@ -309,10 +325,12 @@ static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
>>        struct pci_bus *linkbus = link->pdev->subordinate;
>>        u32 val = enable ? PCI_EXP_LNKCTL_CLKREQ_EN : 0;
>>
>> -     list_for_each_entry(child, &linkbus->devices, bus_list)
>> +     list_for_each_entry(child, &linkbus->devices, bus_list) {
>>                pcie_capability_clear_and_set_word(child, PCI_EXP_LNKCTL,
>>                                                   PCI_EXP_LNKCTL_CLKREQ_EN,
>>                                                   val);
>> +             pci_save_aspm_state(child);
>> +     }
>>        link->clkpm_enabled = !!enable;
>>   }
>>
>> @@ -931,6 +949,12 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>>                pcie_config_aspm_dev(parent, upstream);
>>
>>        link->aspm_enabled = state;
>> +
>> +     /* Update latest ASPM configuration in saved context */
>> +     pci_save_aspm_state(link->downstream);
>> +     pci_save_aspm_l1ss_state(link->downstream);
>> +     pci_save_aspm_state(parent);
>> +     pci_save_aspm_l1ss_state(parent);
>>   }
>>
>>   static void pcie_config_aspm_path(struct pcie_link_state *link)
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
>


