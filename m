Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327CA1B0F1C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 17:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgDTPAm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 11:00:42 -0400
Received: from mail-dm6nam11on2049.outbound.protection.outlook.com ([40.107.223.49]:10176
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726615AbgDTPAl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 20 Apr 2020 11:00:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHIMhyzm56zW1LYVVi6argaKxI1Xn6ZvR+PwXPaY7y3TFxUrDdzxjC8fS1MfjqXm4N53RxL1JaQTznOW+QtJDCCqzCZRwlsjhqY+NcFgZ9bT0VNvN6oiHxu9Go0Qkx9xYdbL1BmOYBewDfMKCVR4nr+rIfdrXy9oP10b3CKrWQCrxVbDh65cXyHfh5JD1Ykmhn9JkdvrT/XO/UBSq/KsnXh6reyMP6kNkPm+nzMe6m0HJhNI9rlX8bKtbj+28xpVMhZaKyNmuKxzn+opTavswIGPsW7jmD2RUcqnuPNjvT7LZnQsIq+h184+xb/FVM9+Pdt6sQz+US9GMGto+BHZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlB20+Rmyl7OHe/6tsHMMwNKNZcnARrih+6tZhS8YOs=;
 b=JpdVihNktXyb+Mwpk9XCUxlxd1K5oIiRS6Es1L5L4Cg8znAsE6P0LPjK/6pUacLWz8YTUfYqiYfU3QXkFZhEsoe11NtVcG0ve7Iyr/XzM1IAe+OcirL6RDLuHzD6IhMIuueU7y4PGQuYMAgWmOd7MYoGYlKfuA0fsocSg0k57Me8O2cE1M94jwBe6VWPFLp3P3Olm2EJ84Mg2U5VzdGMzE0P4lD7HNzg6bNy79wi61XWVRl0Kt8Q7WRuNld+MjjBo09x+jzV/PHbBOcoTpZ/vac14f5tu5E7FHHSDQQZZa8thgHd0OyBW/IahwnHbACcLPAFgwRK9iyoxW8YsY1hSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SlB20+Rmyl7OHe/6tsHMMwNKNZcnARrih+6tZhS8YOs=;
 b=tFvejdDoDzp/1HhexSfRt0UoHTVbYtPQ/V1TAGWhW9n9RyyM9I0atV511ZETTmuIU5VYxaGmiXoVlfu0SJ4r/0X3K7ixVu+UZ1Wbw7zpcCgxVofnUw70tn+X124ut2oDhINxNqKw+Nz46Hy17pR+DkVNy+LEYnC5JYi/nak1ec4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2512.namprd12.prod.outlook.com (2603:10b6:802:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 15:00:35 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 15:00:34 +0000
Subject: Re: [PATCH v5 02/25] iommu/sva: Manage process address spaces
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, zhangfei.gao@linaro.org,
        jgg@ziepe.ca, xuzaibo@huawei.com
References: <20200414170252.714402-1-jean-philippe@linaro.org>
 <20200414170252.714402-3-jean-philippe@linaro.org>
 <20200416072852.GA32000@infradead.org> <20200416085402.GB1286150@myrica>
 <20200416121331.GA18661@infradead.org> <20200420074213.GA3180232@myrica>
 <20200420081034.GA17305@infradead.org>
 <6b195512-fa73-9a49-03d8-1ed92e86f607@amd.com>
 <20200420115504.GA20664@infradead.org>
 <966e190e-ca9f-4c64-af05-43b0f0d8d012@amd.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <65709b48-526b-ff43-760c-0fe0317d5e9c@amd.com>
Date:   Mon, 20 Apr 2020 11:00:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <966e190e-ca9f-4c64-af05-43b0f0d8d012@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::14) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by YTXPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Mon, 20 Apr 2020 15:00:29 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e3e7dc6-48d1-4fca-58e2-08d7e53b91d8
X-MS-TrafficTypeDiagnostic: SN1PR12MB2512:|SN1PR12MB2512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2512BFA656FA189B33FD864592D40@SN1PR12MB2512.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(26005)(81156014)(8936002)(8676002)(86362001)(316002)(2616005)(956004)(478600001)(66574012)(186003)(16526019)(16576012)(66476007)(66556008)(36756003)(31696002)(5660300002)(52116002)(4326008)(7416002)(110136005)(6486002)(44832011)(2906002)(31686004)(66946007);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRX8BVLLPrwFYYO28ur8xUzGd2KsrDdoQp3RWn85YlROeI0HViSEZtjDZ4JaHmL+bmvJnehRjn+BAEwuw8SypVVc+vQnNnYo7qX7HL+3BdfJr1sP1YbwFGqMZEgN5mXILFxiIinq+kZBIno82wiOJC152uhGYhkJUh9X88jeJWhA9TDj2i6d/Iy0QqpbPfLCNTdZ5E3OVmu457D/ARK68mZ7s3WXqBt7mIlnaUmAtVSpsZdJeOhqZ7WPyzixwoRJC8QOmlrHa1Qo6ZOoMoyNzuq6YNUIQy8lycg478VwXz9XzDNZbSfw4SkDItF0sXgMptXeRGhgWcFs1v4oJ9TW2aneYUKnKWHM24K7oR0breCLlfYb5YKCuJUJjp6nrQgvk2Hoq8l4eG5zzrRSeoENTe/g9QkROg1DhVe79UGph6NcnPD412kONpLK2I4Tw3zc
X-MS-Exchange-AntiSpam-MessageData: APW4AuyB41nOOrK+bR6qIzEwB3b/5fh6NoLcQXetg1QZgKqALWMTu1aI764U6MR22praENZ5ljx2zKa8YUAHXyxMQkuw+Mbqkwv8knQ+E6HEyTCA1HdKH0BE/TOPJgepePG/qSAlFS+1rf2gKPW/NQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3e7dc6-48d1-4fca-58e2-08d7e53b91d8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 15:00:31.1099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P+vtAbEtK09GfV5bFRarwkLDRgLklppa60qOdk2GuarJ/bDrDIcqDqwJOJgoAkfj1ZqCwTb3CUpeN6olbSoCaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2512
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 2020-04-20 um 8:40 a.m. schrieb Christian König:
> Am 20.04.20 um 13:55 schrieb Christoph Hellwig:
>> On Mon, Apr 20, 2020 at 01:44:56PM +0200, Christian König wrote:
>>> Am 20.04.20 um 10:10 schrieb Christoph Hellwig:
>>>> On Mon, Apr 20, 2020 at 09:42:13AM +0200, Jean-Philippe Brucker wrote:
>>>>> Right, I can see the appeal. I still like having a single mmu
>>>>> notifier per
>>>>> mm because it ensures we allocate a single PASID per mm (as
>>>>> required by
>>>>> x86). I suppose one alternative is to maintain a hashtable of
>>>>> mm->pasid,
>>>>> to avoid iterating over all bonds during allocation.
>>>> Given that the PASID is a pretty generic and important concept can
>>>> we just add it directly to the mm_struct and allocate it lazily once
>>>> we first need it?
>>> Well the problem is that the PASID might as well be device specific.
>>> E.g.
>>> some devices use 16bit PASIDs, some 15bit, some other only 12bit.
>>>
>>> So what could (at least in theory) happen is that you need to allocate
>>> different PASIDs for the same process because different devices need
>>> one.
>> This directly contradicts the statement from Jean-Philippe above that
>> x86 requires a single PASID per mm_struct.  If we may need different
>> PASIDs for different devices and can actually support this just
>> allocating one per [device, mm_struct] would make most sense of me, as
>> it doesn't couple otherwise disjoint state.
>
> Well I'm not an expert on this topic. Felix can probably tell you a
> bit more about that.
>
> Maybe it is sufficient to keep the allocated PASIDs as small as
> possible and return an appropriate error if a device can't deal with
> the allocated number.
>
> If a device can only deal with 12bit PASIDs and more than 2^12 try to
> use it there isn't much else we can do than returning an error anyway.

I'm probably missing some context. But let me try giving a useful reply.

The hardware allows you to have different PASIDs for each device
referring to the same address space. But I think it's OK for software to
choose not to do that. If Linux wants to manage one PASID namespace for
all devices, that's a reasonable choice IMO.

Different devices have different limits for the size of PASID they can
support. For example AMD GPUs support 16-bits but the IOMMU supports
less. So on APUs we use small PASIDs for contexts that want to use
IOMMUv2 to access memory, but bigger PASIDs for contexts that do not.

I choose the word "context" deliberately, because the amdgpu driver uses
PASIDs even when we're not using IOMMUv2, and we're using them to
identify GPU virtual address spaces. There can be more than one per
process. In practice you can have two, one for graphics (not SVM,
doesn't use IOMMUv2) and one for KFD compute (SVM, can use IOMMUv2 on APUs).

Because the IOMMUv2 supports only smaller PASIDs, we want to avoid
exhausting that space with PASID allocations that don't use the IOMMUv2.
So our PASID allocation function has a "size" parameter, and we try to
allocated a PASID as big as possible in order to leave more precious
smaller PASIDs for contexts that need them.

The bottom line is, when you allocate a PASID for a context, you want to
know how small it needs to be for all the devices that want to use it.
If you make it too big, some device will not be able to use it. If you
make it too small, you waste precious PASIDs that could be used for
other contexts that need them.

Regards,
  Felix

