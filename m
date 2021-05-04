Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710A33723BF
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 02:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhEDACa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 20:02:30 -0400
Received: from mail-bn1nam07on2065.outbound.protection.outlook.com ([40.107.212.65]:33860
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229499AbhEDACa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 May 2021 20:02:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQ349dalfFZlLLUKAv+RmQPoKi+23fNIQgQS2ofOamHpPKizm7dnKrisFHG1LB3ubk9IdMId+FwsComDQbU79wlfh4/Zpp+6rwTae3MdFSa7f/KlDCZ1s8A40nVKjPW9ZoUlkpifT2VcZQxj03nYz/ZHv38u/hrci0yHy2Rr2WywuquGiwqx4YRVMr/mRdKkxsAAECgirXqJ3AFLG//yGBFQzoY7Z/6Iz+/LFBEbCLM2iKAqVLBNcV9k/xJNoEFkXsVTDmaiim0s7TLAvPIAaTvYSYOSRvXv33K8bhSaFEC2RoNV06hWLZfTakDWNrjbFgE36JdWWGYdUXPBDixpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/cKLKtzFGu2aBmD9V1JWghE6lhzzVpZbjGGqXGgfDE=;
 b=k5dcz9/T4tpG5GqOJOtrV1I8j77yaPzkGmCEwGKAwoaZFTvETmDvNdy8RdHn3IYz/tfvjI4AwRi5YwiPjmvxFK6j4iN6imKr+6gpq7vV2cP16SaQKheVDftNsyCCbfIbKlSO8e2DdR1R/IoSS5OqvAsbu/yJRfAmkV5GOClL6sEeRtNeOCxS9qVF4kUFmxbAK7C0HXx6+e+iRzEsOYDSb+MyUyNY/RDz5dDfg6vPtnAoxotoVkUmUdF4K0Y6WWtK6IFLHnmoAskwvQ9d+tPZkJMx644fK/6dFHXI772ndGZWrrQUkbq+KF68E99UT3jbUS82xK7EmRhNkKIKfsYXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/cKLKtzFGu2aBmD9V1JWghE6lhzzVpZbjGGqXGgfDE=;
 b=jJ3JtgOsZ8NdK38ie1C/LhBT5lRufdPnz5NSvkEbrYT4JI3vO9GIgBeR3JRhNZhzJeatAhI9ayAIZ6iuAiINzGzyUP+v3NO5+DNdpECxNi7fG5sR3OfynMROkukDho+yd3EdflRpyrywD38cYSQpZXb3W7+p9jG2vSurHcVlFUAE5ZdKmEqKSAu0Kn+1IF9ULvgdbbIU6P5x+57G6QEqh+eau6iZ+4mPLs5ESA7iyeJDCNFH6S+hTaA341K1q7eSCYAlhB3roWrr9niNae6sZL2FTJVHxjDt2ZH3nZSGZCjbs8Dz3icvxNitctTzEVZ/Mqh1lEYPovTbufFhDVYM3w==
Received: from BN6PR18CA0011.namprd18.prod.outlook.com (2603:10b6:404:121::21)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Tue, 4 May
 2021 00:01:32 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::50) by BN6PR18CA0011.outlook.office365.com
 (2603:10b6:404:121::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Tue, 4 May 2021 00:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Tue, 4 May 2021 00:01:32 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 4 May
 2021 00:01:30 +0000
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mm@kvack.org>, <iommu@lists.linux-foundation.org>
CC:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-10-logang@deltatee.com>
 <37fa46c7-2c24-1808-16e9-e543f4601279@nvidia.com>
 <8de928ab-2842-dac9-07ad-a098124f791f@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2a08b685-53c1-3ee4-0ce1-315554d63685@nvidia.com>
Date:   Mon, 3 May 2021 17:01:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <8de928ab-2842-dac9-07ad-a098124f791f@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0813dd7d-b8d3-4a4a-ab1e-08d90e8fc688
X-MS-TrafficTypeDiagnostic: DM6PR12MB4419:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4419EA1EF793681904259354A85A9@DM6PR12MB4419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g25pE3vm47iOOf3nrkoBw1Avm6lF0MjJlFEB7U2Yew/Zyk7wqbrBCatnGMxxEQGK1DuKwK2om1mRsSuX381Gq647R9kcThPTGXC9Eb473Y1SDtTHjjWQ9ZjWu3NGWifydb/zEnPmY45pZGuqfAQI3iuHV0+rbYKgtfRd62jdfLGf/wzqu34Wdr1v7gwKPZkbTEdTglHIZSwJRcWzh9PiTImue55182LoRc3RNolAUxSERvTc7VVTMQJocrNm7iTH+XdpTDIQNItwZUtNjUeFd1TRLbwtgADjfUNhvEtgscaLV3i6i66VKg1o+bWQlw8S/iPxhS0/LrFRaQ4ywxwgC2jZtqmB4AxClxDTQRdHYuKfnLQ2z1EBi2gB0ToZr9zq0Fsj89sk63tUBSRjCR/ukWwQmeH1hScFOEXxNhC0Fe6LBMfas8VgzcC8HjujsyZsYMvtWwmAr/DYIwWjbCGMFUa/0Q+T94rs1hMgwufvv20vVZ279CqFeYdd13X0Fu+H+OMhdTbywmbh0n9fd2xml0BgFnywafIM0wLvfzcBJmIOcr3/JZo5mc+/BcVVHNq8Wfdr6gbPjHZgrkvJPmcLxYtPcp0F47mo8iR0uliYkKKR5nZ5OuGHpSHNg33a/Q7h+6GkP0rzklkRCQ4APUNhMnAJ+thEVMTWRj3813r+vPlX4fX2VMcgQK/hFIJXVctYVGe3Z0A/xFQuPkS6vjrtdA==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(46966006)(36840700001)(110136005)(316002)(2906002)(336012)(36860700001)(426003)(7416002)(8676002)(83380400001)(47076005)(31696002)(86362001)(4326008)(26005)(7636003)(82310400003)(5660300002)(8936002)(478600001)(31686004)(16576012)(70586007)(36756003)(70206006)(186003)(16526019)(356005)(36906005)(2616005)(82740400003)(54906003)(53546011)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 00:01:32.1844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0813dd7d-b8d3-4a4a-ab1e-08d90e8fc688
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/3/21 10:04 AM, Logan Gunthorpe wrote:
> Oops missed a comment:
> 
> On 2021-05-02 5:28 p.m., John Hubbard wrote:
>>>    int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>>>    		enum dma_data_direction dir, unsigned long attrs)
>>>    {
>>> -	int i;
>>> +	struct pci_p2pdma_map_state p2pdma_state = {};
>>
>> Is it worth putting this stuff on the stack--is there a noticeable
>> performance improvement from caching the state? Because if it's
>> invisible, then simplicity is better. I suspect you're right, and that
>> it *is* worth it, but it's good to know for real.
> 
> I haven't measured it (it would be hard to measure), but I think it's
> fairly clear here. Without the state, xa_load() would need to be called
> on *every* page in an SGL that maps only P2PDMA memory from one device.
> With the state, it only needs to be called once. xa_load() is cheap, but
> it is not that cheap.

OK, thanks for spelling it out for me. :)

> 
> There's essentially the same optimization in get_user_pages for
> ZONE_DEVICE pages. So, if it is necessary there, it should be necessary
> here.
> 

Right, that's a pretty solid example.

thanks,
-- 
John Hubbard
NVIDIA
