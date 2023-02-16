Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1166997FB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Feb 2023 15:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjBPOzb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Feb 2023 09:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjBPOza (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Feb 2023 09:55:30 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB5F521F2;
        Thu, 16 Feb 2023 06:55:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CrxN6RWnTYryFudr2C8aZR9UGlesMmvBXQqBpDz29Artn5W1pu1ziWy5tZREaWs7XekKOo8wmmmu+iMWoCcXA+M6+q6uq5PgRmvk8iIi8AomKTP+LFmOYSJhD95BfZl3mW6PNU9B4IMzk19tXbcoRE8Xoz8s/u3Dc5HiC+fT5xr17xJF9qY5IoMejONvFW6DMR77h5VmJEaKFNEJaRrKyT/0+/hQuJAdhPZazn6sfrM+3gI6mhvLRtNy7Ygu1qPLOaPXirVKzGRT6x8UaqqibpVE/CcHskPy+sRRNj/ZyQddqV8j18TQP+YIleIKXWJT1VuLmzfXC7mXXNTfTsiinw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQMjLq39sta8mLJQxFW3EY7LTWkB5ZSX+RIKjslPiNA=;
 b=bmFlKsk/zvHKZGUt5U/qAKaTdEvGWox7GeIjLrNgqdoXCcKFGBqH6MG7lwp7yNeg2NIkaUNAsaMmkpNAXTaenEyiZFJV2Q7rSeZmJNmMcIvFsSfj71QNhhyXQ+JeQtkAD0espIQrE7fWEYvQnHcNvn+NcwkuG07JPtO79B9dYqaVQAr/VeFL7I5NpYqXMYUIgiyRV1mVhehzLYpXKYiiful7smDwNnokxWkxgXa1n2h0a3xQLBpG5TkZBGKcst78hHX4TBa5VyaSCjnrN37ScLILSHGWQXUWsGV/Yje7hPQRmyxWD0jWfJNBddpDziiWDUfCl0pK7T2TmFpvOxA8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQMjLq39sta8mLJQxFW3EY7LTWkB5ZSX+RIKjslPiNA=;
 b=g5+1XHbMeBvG1DfGnaW5K2dDtGT8XFshUsvCz3uUPrbxRLc9DgvI5eknayBMP5x8SukkzuwUnLpcvAGG4tSvyt39SnMjxdU3rR2pRRZA7QLaQBE/+PKvnYYs4K1hz/h2cZNgXSw4KnfEbGKyHEs4vOW8rPyF7jKWMeIWmVjqFfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ2PR12MB8717.namprd12.prod.outlook.com (2603:10b6:a03:53d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 14:55:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::e6ea:9231:6d39:93da%4]) with mapi id 15.20.6111.013; Thu, 16 Feb 2023
 14:55:22 +0000
Message-ID: <33d2ac92-3be0-f653-59ef-58a04c744ba9@amd.com>
Date:   Thu, 16 Feb 2023 09:55:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: =?UTF-8?Q?Re=3a_=5bregression=2c_bisected=2c_pci/iommu=5d_Bug=c2=a0?=
 =?UTF-8?Q?216865_-_Black_screen_when_amdgpu_started_during_6=2e2-rc1_boot_w?=
 =?UTF-8?Q?ith_AMD_IOMMU_enabled?=
Content-Language: en-US
To:     Vasant Hegde <vasant.hegde@amd.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "Huang, Shimmer" <Shimmer.Huang@amd.com>,
        "Liu, Aaron" <Aaron.Liu@amd.com>, Joerg Roedel <jroedel@suse.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Matt Fagnani <matt.fagnani@bell.net>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230215153913.GA3189407@bhelgaas>
 <e3b866eb-830c-9037-39c7-978714aaf4d2@amd.com> <Y+18UuVTKIshk8EF@nvidia.com>
 <9103b537-62c3-d6b2-b576-713406635455@amd.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <9103b537-62c3-d6b2-b576-713406635455@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0352.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ2PR12MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 84599b1e-9b4c-425f-8670-08db102dd402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6IisXCn8gd/STqf74iffZJFZ7k0jcA0cLsVI9mDsBTnYU5fg/dc6W3cTpNxZArypp2YIcibqkkJsZBbncBohkLSk+EW1iST8CMTNtuXeb9sojH7RE+0T+LVvX5xQOopSfjznXI9fiB6FW4MvEjeuqqPt2C5fHTIivjhVwcNlNDucwlI953OORAbqeqbc1Nm2633vDlpqJc7v8BGI3q0Dujjsq16xDdON8sJiIm1z5syJKqaJKdUH//DrIgeA5ZVBd7JQo3eZxU92oS1n3ZKSsWPUDa4EocB9R4k5j0/kiX/GPUZijSZ0mozIrFfPzWhLR5D520zdVahqfBnGy+E/oeXXn7d1sFkSDwl9Tr2jACULQrQXa2/NYQPfzoElEgpF4LjwOc4sHynK/IlQ2ST2WANnTAm/Nsf7OPB03Bpu+v+PfAi3VOOrnKMvH0w1hIpHyAUdEKf8UmiK3iyWttDXr0w1oEkCHDXidqYQO9odP7imoPnFbuDrRY5D4rqatrpJXakrkXC3BA6DdskKEBuhQJI//nhSYhvwjSrDqvBwI9ZKbzzGgKBsqLJhlvzNwtoh1GVk8VdDgRy++NpDzLRsHZDXqYQRCzFBXmniucCixkZCIPRa2SyfTJBCQH0rS1bpoHOK5xqqq4uG6MBavuPDmvmvN/WFJwaiF+hA8BjDAXFMOSUGxW5dWp1EqeeQMVORgnP32GKhIMssY/evH5fMg3/WouaqDYXj3jNtlq4Dzg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5115.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199018)(53546011)(6486002)(478600001)(6666004)(31686004)(6506007)(6512007)(186003)(26005)(2616005)(2906002)(966005)(110136005)(54906003)(316002)(6636002)(38100700002)(66556008)(66476007)(66946007)(36756003)(4326008)(31696002)(41300700001)(86362001)(44832011)(8936002)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWpXZnVsZi85cUttWE41aC93Mi9HU2F1ajloMko0ek1MLzVQdmZ2STFNYVdB?=
 =?utf-8?B?N2loT2hGaUMrUnVGTGRRN2c1NXo0Mi9KU2hhNmMvaGE0Q1prcTg3VUpqK0tv?=
 =?utf-8?B?cWtFMzZPamptcWtqWENpWE5CeGhZSUJTNTJPYURiSlNKcEJwYmdLNk9SZVVu?=
 =?utf-8?B?a3lFMmtXNmUzenFodVlvRzFJbUJXd0Q4NUUrNk1tbDFIbWlFaUh1MWZwTkFx?=
 =?utf-8?B?L3hCVE1ERm4rRlVEUWdqRkV6RTdLWlNVdEd4RUhvZFZEcjZVUVgzQ3M0OUVu?=
 =?utf-8?B?ZHVYQnFrYmx2Y3N2c0psOUxTUlB5V2xXTWFYVnkzVUZlY2F0NkxTMmFqOW90?=
 =?utf-8?B?TEN4emMxZ0V5UXFVU2NQU0kyRWtEMmVlOG04bmFLc0wvZUJobWlEMXFGU0lt?=
 =?utf-8?B?VUZ5OTlWYmZXZ2toYlNDN05lT0RNN2EwbEVhNzNSSVgxRDBSaDFNUXM5bW5B?=
 =?utf-8?B?Nmd2TlhKME9OM2UvbjVRcmdPZStnUDh0ODVZanFMVXRDeWxtUzNQMW5TRERu?=
 =?utf-8?B?a0VXZW9VR3dGOGJBZnVlekE0LzQrSzVrdHgyeDlmdm80Z1JvdXJKSEhoa0Nt?=
 =?utf-8?B?Mm5mN091ajNYZ1F2aXJlS3VTWjRFTWtkRVdHTEtDaXFBaXBUVlBHMG56Q3BL?=
 =?utf-8?B?L1FwVTlQSG1hUDhjSE5NWS9zK3Jwd2pwU3dYYy9GRHlTU0VMalR4aDRielBz?=
 =?utf-8?B?TFJ2a3psSmFBdkdESGEwMm1lNXlRM2JRUGwyR1dOMnpwNG53TU5FNEVzMmIw?=
 =?utf-8?B?aUx4R2JpTDZXN2RBNVN4NDl1Q1FPTkd5Z2RkVUw0WDhtekwyNmFwS010aEoy?=
 =?utf-8?B?L2kvazQwczFDOWh4REpLak5rRFNWRDJST1ozcG1HbkZ1Q0ZDZVpUbHZndWEr?=
 =?utf-8?B?d0V0UHhRNmJSUi9LSHZPSXpTaE5XMHBFOU5obSt6a3VFd1YxS2J6eHg5cWFI?=
 =?utf-8?B?NFlSUTY5Q1ZGT1djMllDTzkwNEZUcXZIcEhURkdST3hnYlNOZHpMWW55Ymcy?=
 =?utf-8?B?bHN5S2J5TWZOTHpHVjFocjZNbXVIR0FtOGFyckE4V0ZDdnRiTE5zZ1IzQ25o?=
 =?utf-8?B?a3RrbllsMUxlNkc4RGxBK0NyeXhvTE5wWk4vQnc5WUkwcE1DVC9CMTFUakg2?=
 =?utf-8?B?bFpUWXlxY2ZRK3piQ25iWkhvTXZKZy9haGFGTkozNW9QSXJObGp4YTZYbURs?=
 =?utf-8?B?Wjd2MDg0cEhVUjM4UHowQVR3b2tNZ2pRQlJqdVhFU0oxL2lxbnBHbS9EK2dk?=
 =?utf-8?B?ZXlLRHN5RHRpcEFNNDlPaGZtQU1ETTFIR2VidDN2U2VId3JVUEtRRHZwUlVt?=
 =?utf-8?B?WTg5OEgrRnBMUmZlUytsYnFyUi8wT1JrRTVTblh2VnhWSk5iR2UrTHZiN0Ex?=
 =?utf-8?B?b0gwRUl4RVlzMkxRSDdhQVVkYkFTMllBMmVNOWEzL0ozNzJxOFdJeWtad1By?=
 =?utf-8?B?eDh3TUpTQkJQMm56c3VmdHo5YlUvZU1RR1cvMjhqOEk4ZHVRUG1tZEU1VU9L?=
 =?utf-8?B?ZFFTUG41M2hKY1dvUG5PbXhOYXVNRVdvNUhkSmhKT0pYc29kUHZUNlQ1VEFo?=
 =?utf-8?B?TzNPaFlEK1FyNlNtc3dHZmNVWHZGK1RPdWQ3UUU2ZTF4Y2tHcnB5Q3IwRWdI?=
 =?utf-8?B?QWh6NEpTM2w4SVFWZm9Ec2JEeUhiZ01RbnhwY21yMjFPUG92SU56anpwRCty?=
 =?utf-8?B?d3RPNzF1WUYrQ1ZtTFdLV2FqWEJSN3NkMmV6NnZXNTh2NlQwQWxJQVVOdEtT?=
 =?utf-8?B?TlEyWnBMSGdnK1lTdDh1dHp5OE9xa0IyT2tpUGpZanQvWnFyZ2lLRmNQVmlZ?=
 =?utf-8?B?ZlFxbC9CL2VmbnlBNk1malExb0htSEVPK1FIVEY1TU1Sd1l2NEpEbW5oMG5Q?=
 =?utf-8?B?RlVjRmlQY3FWZ0xrQ2ljL1gzc2NwRTZGekxTc1lOSVlxaFdJQ3JyU2dSYTdk?=
 =?utf-8?B?bE1EU0piNDZoM0wxZlRCem9ubWxuSi9nZW5QcmIyZ3N6N3F4eWlHZzhqUlhW?=
 =?utf-8?B?ZFhSblZLbVF1Z3prbkZGbUUvOEFPQTlHS1pPbTIwcEh5eUl1SHBkUTBxVmNN?=
 =?utf-8?B?ckpkaGxCclN1eW9abkJiUnBDN1htc3JwNllWRkxNalBaVndDSm5BM205Z3VD?=
 =?utf-8?Q?OpUYsR5HRvItQyY8SEpPsNF2Y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84599b1e-9b4c-425f-8670-08db102dd402
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 14:55:22.1752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vosDTrqoFUKBQNngmVuL49QxGKXh8c3nrAX/ayXPgMqCWMGujlot868YjEebOzBMVo83nGYmkzPlR4P2W01ZXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8717
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

Am 2023-02-16 um 00:37 schrieb Vasant Hegde:
> Hi Jason,
>
>
> On 2/16/2023 6:14 AM, Jason Gunthorpe wrote:
>> On Wed, Feb 15, 2023 at 07:35:45PM -0500, Felix Kuehling wrote:
>>> If I understand this correctly, the HW or the BIOS is doing something wrong
>>> about reporting ACS. I don't know what the GPU driver can do other than add
>>> some quirk to stop using AMD IOMMUv2 on this HW/BIOS.
>> How about this:
>>
>> diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
>> index 864e4ffb6aa94e..cc027ce9a6e86f 100644
>> --- a/drivers/iommu/amd/iommu_v2.c
>> +++ b/drivers/iommu/amd/iommu_v2.c
>> @@ -732,6 +732,7 @@ EXPORT_SYMBOL(amd_iommu_unbind_pasid);
>>   
>>   int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
>>   {
>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
>>   	struct device_state *dev_state;
>>   	struct iommu_group *group;
>>   	unsigned long flags;
>> @@ -740,6 +741,9 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
>>   
>>   	might_sleep();
>>   
>> +	if (!dev_data->ats.enabled)
>> +		return -EINVAL;
>> +
> Thanks for the proposed fix. But aactually this will not solve the issue because
> current flow is :
>    - in this function it tries to allocate new domain
>    - Calls iommu_attach_group() which will call attach_device. In that path
>      it will try to enable ATS/PASID and hitting error.
>
> As I mentioned in other reply I think even current code returns error from
> amd_iommu_init_device() to GPU. But the issue is, in __iommu_attach_group() path
> it detached device from current domain, failed to attach to new domain and
> returned error. We didn't put the device back to old domain thats causing the
> issue. Below series should fix this issue.
>
> https://lore.kernel.org/linux-iommu/20230215052642.6016-1-vasant.hegde@amd.com/
>
> -Vasant
>
