Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919D242337E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 00:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbhJEWbV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 18:31:21 -0400
Received: from mail-mw2nam10on2086.outbound.protection.outlook.com ([40.107.94.86]:3498
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230477AbhJEWbV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Oct 2021 18:31:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqyIiesZEPzkdI+sMx5BhjF/sj5IGgxWX8uvTM1x+9n1lnc/Ne+hgXfjic4a0dYTrbPrACc5fczjLuJFqdom4kPkzC0r3VSGGrRa+4Aa6KWJ/gRO0uwgVzkx67iO4OlJQ/ZHmk4nthw3hce04uLtCnKxhNf2LYztZHEgAmv/cPEQOGpC1txk6tjCckOtsII3UM1q6k/q7MVmAplMpIOKpg3TFGFDkEcixDtRf72odNo0K1EE+sEaRyXLCnhL3JSJgSqZQxH4DsY6sDm60AWQH3o+upwvnOzWAu5aIPH7JYf19mHESlUZtWf6nhzRWg7dSHJMW7H9A+nY6iEZkBVmsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chkYqoM6E93PKji183hSuWb9LTQEjHrIwMqf1+qRNwI=;
 b=Rlfn6HGQA8fxmtnl3Q5LVIJVODw+Nd/GiID1DqHhYBcIpUw+RcKV0p5qC0uCxBhvx2ONTJX3Z+mBYVvn+JkAqW9xAJJAN9DU7nhXDSD7/L+cq9MF7RBL3ZANJ0vM7UauOwoBJzXRt9tVXfPKDHiAz6Yvp55TgNUN5tJJpU2QyOrCG8iywPPlvzFp34CqRFqhcj5XsFCk46vf0XCniEUqHOEke9uAVYqEv2M67wfovNAUpDcpUyTD7hH88m9QtYOSnIVN9HcNauD9XWNZhr8iXpTR9+LA0zTDHllg2hyMFY8aOskOhI2aKCe6da4gYrC8q0BqMwzdUPOeu7P7lSqbpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chkYqoM6E93PKji183hSuWb9LTQEjHrIwMqf1+qRNwI=;
 b=XdTk9XOGaZG307QTshC3i8J6U3bdiKPGvIOF9n+5QijIv4IVwmkNX81Y7KGnEbOLLPJACxkiX+M7t9uHgq3e9arVpG5sld4XOO17icWVSfcsLS+LvhH4il/s3tI3DzNTSv+5KI9/zwd2Gzo/vH+C1Mwfo1gX873nkwdujXda/EDDKkR5mZ3rEq9Zu27xyhx8BCfvL2qwx66pmjrcAXYQXTWZjmqDMvqpdncaIW88X++DmZ7DJiEtmnz6a+1KjyuikCnL7BU7uOCGGU98UQkWju24aEJj23vMzdPtASWf8yH1p4vQzcyaniqeHIOqXr4FTHe8qh25ORJ6VcFtoqvAZA==
Received: from DM5PR05CA0015.namprd05.prod.outlook.com (2603:10b6:3:d4::25) by
 CY4PR12MB1399.namprd12.prod.outlook.com (2603:10b6:903:38::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.19; Tue, 5 Oct 2021 22:29:28 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::de) by DM5PR05CA0015.outlook.office365.com
 (2603:10b6:3:d4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.7 via Frontend
 Transport; Tue, 5 Oct 2021 22:29:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 22:29:27 +0000
Received: from [172.27.1.153] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 5 Oct
 2021 22:29:20 +0000
Subject: Re: [PATCH v3 10/20] nvme-pci: convert to using dma_map_sgtable()
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mm@kvack.org>, <iommu@lists.linux-foundation.org>
CC:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Jakowski Andrzej" <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-11-logang@deltatee.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <f38472e5-1273-140c-9177-299f09330c2a@nvidia.com>
Date:   Wed, 6 Oct 2021 01:29:17 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916234100.122368-11-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13cff12d-bd1c-4670-891c-08d9884f975b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1399:
X-Microsoft-Antispam-PRVS: <CY4PR12MB139955E979C71D9B148E83B9DEAF9@CY4PR12MB1399.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jVsOBNqCNnGnzpCBvnGnNKbiTobINaogTE7wjsFEUjyDWxaa0WagZox3rZfeBcdKYcLwlydFY+vxPQfV7WaXPPZn41RnmFyzY87DvpIT6l+PBuMzUShjv+VcV3Ajp7pVr2hPMQlHw6UmcCOxtg1urhpzdMr01Z97hkCmq8Es7HsjZOuRy4dlM7dTIEqC3Zw0ksg3ASJgs4mkgr8m5g4A7ice8sIlTqKnj6xRM4viaSyAsVKZzf5RSM1kwp529ioXp3J6wK7fdsP1MFpR1PvV/nkyD8HZO2EkDbSJhuh/O2EsexZpDARRvGr/XAkZNBIT6w2ZnN4/2HnaxczyQ6oDUKKgDs/XS7yhq6yj09zujxCvMVnQXkxtT/JCt38OomhniiqFy/9BXoh14PBadwEy1gL9gZAIN5j4FioLL+4vBOUUJqNwZ8ShHsh4vS5MJGPGbwIqCAIrCC7PfDQ4N/sA1I3bpINLZqWxiHOadqskiI6+MYgJMl0ktnh0T3Kb18ClES2qYsmTlgtGe7AFw2/odDh2eHgRIyWYklEdkaMY1u0iIfWVUvqtFVsM/26mg5gOlj8+/pciCPRNkE95WEbOkHwKYAnf8Zw8WPv5pq6KkYBfUbXdi3T1UUfIF07LU/73R31whuR4uvF3SwDUSW/1eSkI74vQwunolcraa8SxTVoAFdJ0zGPADnjqlA0IfB7MqgYxecTIJMVLL+HP5oPFRus0v0SnjjSmmFFpdvK8wQ6WFENnnpJOy2+q8MfzYpT
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(82310400003)(2906002)(47076005)(110136005)(186003)(16526019)(70586007)(26005)(54906003)(4326008)(7416002)(16576012)(8676002)(8936002)(316002)(31686004)(70206006)(53546011)(2616005)(83380400001)(356005)(6666004)(5660300002)(426003)(7636003)(508600001)(36756003)(4744005)(86362001)(31696002)(336012)(36860700001)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 22:29:27.1291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13cff12d-bd1c-4670-891c-08d9884f975b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1399
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Logan,

On 9/17/2021 2:40 AM, Logan Gunthorpe wrote:
> The dma_map operations now support P2PDMA pages directly. So remove
> the calls to pci_p2pdma_[un]map_sg_attrs() and replace them with calls
> to dma_map_sgtable().
>
> dma_map_sgtable() returns more complete error codes than dma_map_sg()
> and allows differentiating EREMOTEIO errors in case an unsupported
> P2PDMA transfer is requested. When this happens, return BLK_STS_TARGET
> so the request isn't retried.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/nvme/host/pci.c | 69 +++++++++++++++++------------------------
>   1 file changed, 29 insertions(+), 40 deletions(-)

Looks good,

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>


