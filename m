Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8923A423399
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 00:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhJEWmZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 18:42:25 -0400
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:22497
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230113AbhJEWmY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 18:42:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWq93tHHJR1bgYKJl0vqF8qu+Mz2EHgt0+z9DlLm/UnX17SJTyo8vZkZ9OLvFx7FyjAtj4mehbX/LIVZp0V6/d8gCplH46/vgvcQ46hjwnl5Z4ZXXhJXYZvkpdzsNF1zPPTkAKb++KH5LNsD5I2RrkQJhsccjLDu5eDQXYzL3GtHw3khXL3hfJ57vJ5nqizig9jOtxyYOvnC1GMmGAg5J4lKL+4Li2GMRLN0CBbjP2BfhHSI7YBTcdog68N5GFWO358p/WwJLztn5dBlwy5gAWU4UHKaBDLHhruSSPYdZ3zmapJ8z226OpqzIorbJLQacAK98Ccveej/dmeQZoptSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0SPiDLSecRVxcmTOcuqGMRRWrr5KYXrmBi4icLXSvk=;
 b=i3PAWIcZ6Yqn43eZqo0cEP9vqZaumHPgYXQmJtbt0BhxvBtLzF5LWCM2CsAZlpX5/azOZYdWsbE3kiLtISPNmYLXiqLpkH0sWS3aVvE3OJeGMmwYu3DT+yWddQYAi7otc9XMrVuh/vplxs7t+0LITYRJ/PJaBli5wtEGOOHmYzWDYTije4iyC2C/STxyhtLkD6HHkjFVGfCcM+dohLZg21M68gBL02527pMs1LpPXMZ7suk2ws8jHlN5RtTuKUrEWAwYylEM139EVADdM/roe9MN4eBT1gRewlW2wkn/RavHB0kabV//0BMLVzGAjRkjDay6AgtmXWY4YOA+JBaUyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0SPiDLSecRVxcmTOcuqGMRRWrr5KYXrmBi4icLXSvk=;
 b=OkvFs6/QRAvytephvDf7pcPIT4MSUjodhly+8w3JfW5OOxQRtRohadOf7ir8zzMmKDrp99SNYiz7w+hD9QQGOHzMXVcy41+v6oHs72UTnRFPQFytE6XXSP0MKrFJcCQNZSiApmBOh9fjExXfeG6zJmTDOiHGwfHh0K/+GpU6ZxbMMRplViY7Zwtf6LPuTGn1y/nL4ESwBv7MWHPKtrE2IP1q8seZTBoWEhzybdRG0GQQJVBkqiD2qCxsGoMWghas4cBPzxCr5NzuyOwv1I48nBaiT5mvkCevNOH26qdWy0JmaOJ/nPhROw1RhzzkzUzEr1Y81GebjfFmk+CbOtv+Bg==
Received: from DM5PR19CA0072.namprd19.prod.outlook.com (2603:10b6:3:116::34)
 by BL0PR12MB4724.namprd12.prod.outlook.com (2603:10b6:208:87::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 22:40:29 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::5c) by DM5PR19CA0072.outlook.office365.com
 (2603:10b6:3:116::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend
 Transport; Tue, 5 Oct 2021 22:40:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 22:40:29 +0000
Received: from [172.27.1.153] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 5 Oct
 2021 22:40:22 +0000
Subject: Re: [PATCH v3 12/20] RDMA/rw: use dma_map_sgtable()
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mm@kvack.org>, <iommu@lists.linux-foundation.org>,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Xiong Jianxin" <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Martin Oliveira" <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-13-logang@deltatee.com>
 <20210928194325.GS3544071@ziepe.ca>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <ac05dec5-6b0c-6846-2f5b-a8930c718806@nvidia.com>
Date:   Wed, 6 Oct 2021 01:40:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928194325.GS3544071@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5080e68f-6992-4776-b1ae-08d9885121f9
X-MS-TrafficTypeDiagnostic: BL0PR12MB4724:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4724B1981A39F0928AD7ADF2DEAF9@BL0PR12MB4724.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NwotbeLPsRBLX9CmrwCLOm6Knk76ue7GIegYZDSe0jyh8JvA/2jcGYMOm49Jh4e6Bswef8t/Z/hzwmVBYs5ZkzRxSsd4/chNGAZnbjaJuzP7T6C5S2vjMuTgas2qTn5FrYSHOZi6bMejwk5C5uWWVUbfxU93o9ITSDT3XC1NfOKLtPWcJTj8VpZjRhGrhrT+JZYgDr9yvu31nVMPgqkt72HFV/bL2rAqACCwUwOb+N+NU7lePDOVfMd4d0BY/fhwy9vJtU4Yx+4tR/7QGRkEYpYxjCPdf9r4rEO+FJrwbzf9P/Fk9sKs1sit7/R+o+UIahn02E8d9685GUZJI3ToqwXdSY9xePuCVNQWv57pje4IkXFSzyWcggTTBvhKtAxzse+jEpoB5IPtlFo3um8COoxC3qYM0iBVJUpmZ+o9vphWeiOg7pTx6b0YV5xMCqedk2FY347Spi309b4RKZoTRMuER8zjvuokSYNiEooXNWp6mSBUDmAAWR3TzuJrxrVonVnIwSY5ub54a95/1xFPkSKa1ahVqthlgUVZavfZ/b1BOVxWnF+DFjbItlUFs/0+5MFTZ48N/lkKIqZAyjqszdnGMbOu1KR2fKjjq+MPJtZRCnMd9oXQ5A+q5MOz0KEGS7Yap0BTZQ6GoyoIacZYNS4twfxgyBD2DuuLBu52WeVvxzabknCdn7gt8rlexE275NfN53HolzUOYHgg84/YrVbJfWasqipgrZtqV924QaM=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(426003)(186003)(31696002)(26005)(53546011)(82310400003)(7416002)(36860700001)(16526019)(336012)(7636003)(86362001)(5660300002)(70206006)(70586007)(2906002)(4326008)(36756003)(54906003)(356005)(316002)(8936002)(47076005)(508600001)(31686004)(8676002)(16576012)(110136005)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 22:40:29.2247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5080e68f-6992-4776-b1ae-08d9885121f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4724
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 9/28/2021 10:43 PM, Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:52PM -0600, Logan Gunthorpe wrote:
>> dma_map_sg() now supports the use of P2PDMA pages so pci_p2pdma_map_sg()
>> is no longer necessary and may be dropped.
>>
>> Switch to the dma_map_sgtable() interface which will allow for better
>> error reporting if the P2PDMA pages are unsupported.
>>
>> The change to sgtable also appears to fix a couple subtle error path
>> bugs:
>>
>>    - In rdma_rw_ctx_init(), dma_unmap would be called with an sg
>>      that could have been incremented from the original call, as
>>      well as an nents that was not the original number of nents
>>      called when mapped.
>>    - Similarly in rdma_rw_ctx_signature_init, both sg and prot_sg
>>      were unmapped with the incorrect number of nents.
> Those bugs should definately get fixed.. I might extract the sgtable
> conversion into a stand alone patch to do it.

Yes, we need these fixes before this series will converge.

Looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

>
> But as it is, this looks fine
>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> Jason
