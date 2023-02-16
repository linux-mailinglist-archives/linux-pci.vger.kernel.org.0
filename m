Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FE26997EB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 15:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjBPOx1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 09:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjBPOxZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 09:53:25 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E4E4D61D;
        Thu, 16 Feb 2023 06:53:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYCKc1F76u5dX6X9wFtkE01Rymn/FAPrFBWLNEZDeSzu/Q/WEeCFEohqBEZvaSekcMcVXBXhSIalIc1sbSy/ctp7bG0panUNcI5HNtz4LtjfAPqFVo0SQhktGKuQs4hSUwsOfaTP8hfwjGt2aUPxuhBX/je16bPkAQkQHPBR5lVUOAIssnYAcq3jSKCDuYhIk7qDWoa7tCwIisn2HDEfxV/kyV2afxBltClUFP7EcmpRooxisu4S8L1csyHvCd2dVOpZEcCt7vMhSvgBKpiZFgnnaKNit6tF1blXhPANE1gSP0fIjVIJN7edsU4iEscxfWN3qs+dlU+coBp+n2TU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rh7K+VNW5Wg+PsO6pS775WKQ/wiQNmO69p3WKdmESH0=;
 b=SifaAPpGTThEKdtbvOw85ZzaFeWB/qqRKbLO3UK6NTqa2sGgKes4guhzRya6eMPx4REl7adytE1uxmnb8teBdZ3UHTYLdJKMoC8C9ei2CuoN4kSNh7F7WM/K9CkXXWsU2X6Qd+v+5B0JLDlO6j4yXZl9Sz4qdtdm0SxGBITjiRPV47QvZCw4VdGvUPP1/PwMWjn3RQxDgm51XODChOBZJonTj5kKMA3gmxvRNXHneQ3l2J9JTM8AvTqGjrUOBzXXBql+1DQMqN+zZrn+jzTL/hQkvBvhSlMAoVUq7MFWJ0ANvWBCD9WljF15+evPyhxJWxPZ+UYsipbKulPf4tgwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rh7K+VNW5Wg+PsO6pS775WKQ/wiQNmO69p3WKdmESH0=;
 b=yuBAHivgVOwSPwQpxQnizr+ZdqjZV4KOMPUDh/Ok+muU06ukdBDjjgrELiiiqDMHsoMQEfixTGUe7nScxyc7K5LH9REVA9cUb6PTEoTSlpDjDpI2mEOxH/y/2T7Y5+BIxlYMLvxviGENeBVcIH3d7CSQ7UQCUgEd2WVsLR1LF3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Thu, 16 Feb
 2023 14:53:19 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da%4]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 14:53:19 +0000
Message-ID: <bbb6bd0f-b508-f8b6-1342-c394c18995ac@amd.com>
Date:   Thu, 16 Feb 2023 09:53:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Liu, Aaron" <Aaron.Liu@amd.com>, Joerg Roedel <jroedel@suse.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Hegde, Vasant" <Vasant.Hegde@amd.com>,
        amd-gfx@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Matt Fagnani <matt.fagnani@bell.net>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230215153913.GA3189407@bhelgaas>
 <e3b866eb-830c-9037-39c7-978714aaf4d2@amd.com> <Y+18UuVTKIshk8EF@nvidia.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <Y+18UuVTKIshk8EF@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0211.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 0439d102-35c8-4e34-31bb-08db102d8aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vagm968RlaaSIa1fx9UMmsrc0YNbTwejJpDEA5cOIywZtwlPUjXaPoQ9N8iPh1Ow3Pr9PicH9grjMltFjTGrbLcUtchixDRDlCJV1Fmp7KyM99Zm1tJNQN5BPB3D5Me2KzJnDEX3HpGXf+NPAi9kKDMFL2aZkvSRkVlzP8pSKd7gTZLXD9WiiaLobWvnUtgOdy9k7dniIjpKr1r86t2k0j2J9dvLUF93GajzPrgQ10fWtsF41vz+rpJ8eR7+OpsZWzGf1z849ZbGHgKADAwRoW13ioRCFKx1b4pyAKJdetXSUhVeyR1fU7nLNbdJk7IoEqBVBr6QTbxPZYV/XnmTghhjwLO2jZjYAF5F2CJ/v644p/FGWz5gIWsmbSFk8utRE2oWOUV1d0BwWT+OXhkcxDM3ytn31LVrRVXQLEYe+UwyBmeODk3wfqxJ+wOzXVUfrAbe6syKTzlbivLs0LwVdUBnvJEOx7KhW1SsniPJPyKx+9i6Dv6FVOtB1qmlcCgS8gPkvCAJUpXsefmW5HwsR8p0yryJJtPwkRNlZHqhsRgEhMwoWXzoHWAZagQgAqzu/bx5Yr+EOa+ye9DhBa9hd7Qlj6+a+sOEi6vk6JRcv4Ec/4gVtGqgKoyX+yi5hKHZt2T3LMQiQZ1WsNhjKeiwIN7yRUP/T0a1+vCkPPfzm+ILRMqcDdGh7gkBwz3Oxv32v0pMf4KjEN75a8UE8wV23UHDpK8dAHdG0hbXybK3dcI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(451199018)(186003)(4326008)(6512007)(26005)(36756003)(5660300002)(478600001)(7416002)(38100700002)(8936002)(6486002)(6666004)(54906003)(110136005)(6506007)(31696002)(86362001)(2616005)(31686004)(2906002)(6636002)(41300700001)(66476007)(316002)(66556008)(44832011)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUU2N2pMd0dMOUlFc204M055ZlpOdXlUamxMS1B5V21kL0p1djhvdUZTVHFt?=
 =?utf-8?B?U2pZa2o3NmxEK2p5ZEh2RVFtYzFyZE9OcWhqbzRpMVBkdHRrZE82UzFpcnRG?=
 =?utf-8?B?UGZWQmpxeXJSRG9TVzhxc0x4S0RhUVNsSmVvTkhFekt3RVpRK0U0N3hQNmpm?=
 =?utf-8?B?U2lzdnpzNDM2N0ZUZkpEUnE0V2Vpd05jZnF1QjJkMDVvM2xFUmU0eFptRDQ3?=
 =?utf-8?B?U2FxNVJ5Rllia1dZMFhhSXZueDNwNldnNzkvcEMyYmxrNTdMM0prSXVTSU9s?=
 =?utf-8?B?cXdoekdUYmU1QldzOHNZOUU1OTNScEU4WFFReGlMSkdBMVc0ZE1nTis1Um9Q?=
 =?utf-8?B?cmdsK3l0NDd3ZEJFaFMybDBESFAzbm9Xb3pIbWxVRWZicXlybGVPRW5tQk1I?=
 =?utf-8?B?cFUzZFRtVEVpRTROZ2loeDlEdUlIVjk3UUc1cTkyL1BKMkhVUHZOWkZEWkxU?=
 =?utf-8?B?ekZ0SHkrY1lKbnNXcGpNVHlsN25tY1NnUDY4Um80L3FDMTBxbGlrVzFoYStB?=
 =?utf-8?B?bFZ3dzg1UG0xNFlMdzdJRW92R0ZDdUZ6RjdPZktWbG5FeGVpVDRESEY3dXh3?=
 =?utf-8?B?YW9rZTQ5Z1dXWlFiU2NiYkQrMVNBWHRIMHFNK296Y0FQcnZQMHFjQXFMOEdK?=
 =?utf-8?B?dEhjTDdPK1dteGVUcFpTSlM2alhxcW1HTG4vODhqWE5MSUEycUNMUlkrYkpH?=
 =?utf-8?B?eVkwUFFQWmppd0F3SUNWcXU5a3RhOEY4OVpMcXhLNklQbVlWS0FuV2kxZE5G?=
 =?utf-8?B?T05Wb2RTbElBSGhCaVIxc0dHY3h6aUZGaGh0bWRaWEdVbXVteEh5ajQ0TXBi?=
 =?utf-8?B?cEpxOGcyRWc0ekY4Tkh5cVJTbE5IRWFkclhWT1VLaDlFbXJ0L2FUT0NqZm1T?=
 =?utf-8?B?MVRab0lCT2h0ckpSd20yRXhYWEVmQ1hJY0ZKcm5RNVVrMkNnQ3JNNExNRlRD?=
 =?utf-8?B?OTFHSGxyTzA0NTBuT3A0ZmVJa2R1YVVmQ2VqdzR0TkdWeFIrMUpQVTBjdWpE?=
 =?utf-8?B?blBMYzZMNnd5SUJlYzQ4d0U5UnIrdXlmTDNYUGZOZnJRVDkyM0t2dFV6cU9B?=
 =?utf-8?B?T3JwQldtdG9GQWIycWo1ZkcvUmVhRWdkaTM1M2p5NlhvNkdkbUVhNHVncWVY?=
 =?utf-8?B?RDdxaTYxQnl4NGMvZjZPM1Z0OG1uN2NlYnp0enh2N01yblJ2d1R6TlVhUGs4?=
 =?utf-8?B?eXlzVkk5djlNczN5RG9qMEFHa1lnRWh3UHQ2S1VrNkx2NG8wYWg1czNNWVVX?=
 =?utf-8?B?RFRkSVE4NkhicWJSaEVrb01QK3BTRU1DSWdTOU16ak9TcHdveUUrek9Sc3ZF?=
 =?utf-8?B?bzU3S1ZIb0ZKN0hRVisyZkd0cnhQUmZ5MzNVS3pNUTg0dFY2VytMTEV4aHhq?=
 =?utf-8?B?VC93QXhMMm5BdDhEWCthWVY2Snc3eE90Wk5QUXRqTjduOS9IelYvRTZQZVlz?=
 =?utf-8?B?eFcxZjZuOC81NUlGZno1Q2h2K2ZvQzNNZXlPOEhIWFVPR3hSSUNGOGRKckN5?=
 =?utf-8?B?Q0F4bmt5dlJiZkZWYzkweGsvdHpQL0ZHY3JDNE1qVkhtK245UStiSE5mL0k1?=
 =?utf-8?B?QkN6M2NXanA1Qk1UM1cyNi9BWUQ4OXhnWk80c1FDc3JpZnhZUEQ3cUROVUl5?=
 =?utf-8?B?bC8wYldHdy8vc1lQc21YMlJDbnVlOGcrOFc4ejJLNFRYRDRkZ3JGMW9vR3pJ?=
 =?utf-8?B?T2JsN0xGNzlWTTVPQ2xKYWRnVnhkUHk2UGNqT2lsZVloZEQ5T1hwMURFVzRT?=
 =?utf-8?B?VWtpQTdPMDUxcFVNTnRsSFRnVDdEZ2MzaFRRYWJydms5V1hRTk9XQmszRXVQ?=
 =?utf-8?B?eFpMeHVUSXg2bm0yV3BDRVZ4L0UvRGhGclNPVDhWNG5PaituclFhdUpLVUpM?=
 =?utf-8?B?bXhXZDloMHQrVDBQZExnWkZZTmtIUDlteTRybi9uWXo5UWZCNkg3TVNoQXQz?=
 =?utf-8?B?Qy83WnZ0amo5RUJ6cmh4NWtrTW9hdXdQd2d2M2JNczA1VXRwUkRQZEdoK3A0?=
 =?utf-8?B?cEF3MDRLQ3puWjQvazdPdHdTaTRZTUEydlhEZ1haY1NvSFozUVl5WVY4N1I1?=
 =?utf-8?B?MG0xOWZQMmtQeGNFVXd3NHFwVG1sNnpKY056eFliNlVTazFPZlJwT2lvby9E?=
 =?utf-8?Q?0HWagvxn5wr2z8Mo4rpIhWgkD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0439d102-35c8-4e34-31bb-08db102d8aa7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 14:53:19.1030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3phsGvha+fhxF/p7LIY0vRJq7yCJ9eoUAbYwEtaS432pmee5mBDMhXi7VDNPvIZ21sHNFQTJKwTu1vWtu+inQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Suravee]

Am 2023-02-15 um 19:44 schrieb Jason Gunthorpe:
> On Wed, Feb 15, 2023 at 07:35:45PM -0500, Felix Kuehling wrote:
>> If I understand this correctly, the HW or the BIOS is doing something wrong
>> about reporting ACS. I don't know what the GPU driver can do other than add
>> some quirk to stop using AMD IOMMUv2 on this HW/BIOS.
> How about this:
>
> diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
> index 864e4ffb6aa94e..cc027ce9a6e86f 100644
> --- a/drivers/iommu/amd/iommu_v2.c
> +++ b/drivers/iommu/amd/iommu_v2.c
> @@ -732,6 +732,7 @@ EXPORT_SYMBOL(amd_iommu_unbind_pasid);
>   
>   int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
>   {
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
>   	struct device_state *dev_state;
>   	struct iommu_group *group;
>   	unsigned long flags;
> @@ -740,6 +741,9 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
>   
>   	might_sleep();
>   
> +	if (!dev_data->ats.enabled)
> +		return -EINVAL;
> +
>   	/*
>   	 * When memory encryption is active the device is likely not in a
>   	 * direct-mapped domain. Forbid using IOMMUv2 functionality for now.

Hi Suravee,

What to you think about this proposed change?

Regards,
   Felix

