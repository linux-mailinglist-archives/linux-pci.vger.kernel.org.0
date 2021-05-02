Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D298370EEC
	for <lists+linux-pci@lfdr.de>; Sun,  2 May 2021 21:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhEBT7e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 May 2021 15:59:34 -0400
Received: from mail-eopbgr750042.outbound.protection.outlook.com ([40.107.75.42]:48377
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231909AbhEBT7e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 May 2021 15:59:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/cnupS7bk6IcjeR66fkwxA6gPy+fmjpnO8ureHYwn83Zo8PLaE7bNbV2MJB8bODKI/hbMBqptyDTacy1ZKDCL+SXs1ncE6TIKL30CUl2Ealkaj3mXjvsaHPWO2LoPjnVW8MH3LWnLIrMSBrJ/SxTWK17U1IMZvGfCOLPn+sm/Xkjbn72nObwOH+/7diiyTpp5QSTFXFM1QDb+D/5f6SLcFU8/P2x/3CmDRVpJHQSiaX0wIIdLUgD/XNJYF4Fy997eCS64EzvftDVs7bt68/9smQqGL78qRy5+jcFMT4eXTK7KDk7uVCYZreI0oGLKSvZTRJYqLvrGFd1TFHKPoqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nOyp69OoyQYNuJI/+RFuZqsBro/iudgEZwMU8Sb9n8=;
 b=XRTGJW5GDGehWa7l8RKWDOxbVBoVK8xScNSg/tyhFd5Bb0uPiLNGZaLT22qhyitTvhKDMuhqug01h2zaMP7snvQNol8ULY4CdJFbEo4ckQbbyf/yuI+KJqnVlPv2daWjaG6z7q3fwg5UYr889vKuIh2vxsxK8EsEWo9gcejXKEyATZeBt00MTYhXMr8uDgitiieiUp9nnCRKfki2gaF73JGN7DlRDNYpqQbfUv/FQwaeuBgO5RCsMSaAxTX+/XevW2MZA36XKY63av9QrKI/6PhTIkT09zh2I3ETiq2IsxBKPuKZxctwoBKhvmlxIXNw28CZNn1R6h2aWV+qCyaUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nOyp69OoyQYNuJI/+RFuZqsBro/iudgEZwMU8Sb9n8=;
 b=i27KtrfiNwNMgd4eGd2eq7hcxl69xb2OPU10VFeL2u41b9oFsXx7TWQvgwEZZbBOvl5x+Wxx+K48FTC0MmVNTj4l0dNylaqEj1cDQurEcTkpRZaJsQjs1Fa2xiBrlHrhr3z0X+GkjjbRYe/kun6qNjJ9DvpbElVAXf9CsXjogaAj/z79YEORR9Hn24AX755as69BtavD3mc4qxqFyX1qZ2KXxeq86a+f4tJ4+afySXdcvrdkGqJXP3ArK0SdVfPgWyIZDTA6KKmPusvry1YvL5GZ6KnFJEHxVBYs8c0lrOcHPdpppphvl/Aut85F51DKhGxC1DnAuvDpX4z9CfGDHQ==
Received: from MW4PR04CA0308.namprd04.prod.outlook.com (2603:10b6:303:82::13)
 by DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Sun, 2 May
 2021 19:58:40 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::e6) by MW4PR04CA0308.outlook.office365.com
 (2603:10b6:303:82::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Sun, 2 May 2021 19:58:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Sun, 2 May 2021 19:58:39 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 2 May
 2021 19:58:38 +0000
Subject: Re: [PATCH 03/16] PCI/P2PDMA: Attempt to set map_type if it has not
 been set
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
 <20210408170123.8788-4-logang@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <3834be62-3d1b-fc98-d793-e7dcb0a74624@nvidia.com>
Date:   Sun, 2 May 2021 12:58:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-4-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b43cf32-e796-4b45-ab8f-08d90da4ae2c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4563:
X-Microsoft-Antispam-PRVS: <DM6PR12MB456393713B57874630123A30A85C9@DM6PR12MB4563.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gmhhvMZrIigSoQ7s0nsloeIACaCa10DZZJydMGb+/QlJiqyvMPpF7l+4UFoUqzl6QN9k7beFq+fHAvGwv1vKpuSSCGYtgiCVsOd3NFdkerVaCyX82GlAZTkRSO0hI5b2V1v5wA/jE5d3EOoe42Sz2VayUrug0hhyphVcfQDTclEOffwjqzm8IAXLLo140YJGarBj+0WjNvN4xvUCM3AbxSs1mcQJM4AiJt5ElWiMOiHX09Wbma1mCbkMIdskDA/EVJ5RoVYUgm4F3RGq6pjveNS/CXCvoP1Dfg3cqMf2+i3431g6wR3lTGgAxZOTAzjSOvXUeeAA3YltL2/H5u8FLvbXZndgS6g9g2x43t0ImKbc4qFPKIvtssaCbWeAM1PriMRtKwv0fG9jzhzGVlpUhmeAzCEp7mglcu11jIa1L4zoV2UaqLv+kph+pigsETc0Kbwn/7lXiK4tCP9iQf5R/Wib+eIA4M/7wMkaSRVAkpMlfAKcsLRkM7I+8CuDFJqm0XP5EJoOgpJQVpDtBnkchnVEUDSPbU7k7pB92Mwt77NsJXBMqmq3ud+JReyouUcnOTfHE2xlDYoF+tNw4YkQw405KwnVuegGCZal/ILNQbt0HIiNRc0ciwtEWO5oFPXGRPjY5VzMMKJ5xUNOc2lqfyLXukZccKIMc+oNxa19ho9YIWgy2bOsYwLbe/0PjQb/0VkSY4YB26NWNT57fXu/4Q==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(36840700001)(46966006)(110136005)(86362001)(2616005)(356005)(7416002)(82740400003)(8676002)(26005)(31686004)(36860700001)(70206006)(5660300002)(7636003)(478600001)(53546011)(8936002)(316002)(82310400003)(186003)(83380400001)(54906003)(426003)(4326008)(70586007)(16526019)(2906002)(336012)(16576012)(36906005)(47076005)(31696002)(36756003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2021 19:58:39.6557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b43cf32-e796-4b45-ab8f-08d90da4ae2c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
> Attempt to find the mapping type for P2PDMA pages on the first
> DMA map attempt if it has not been done ahead of time.
> 
> Previously, the mapping type was expected to be calculated ahead of
> time, but if pages are to come from userspace then there's no
> way to ensure the path was checked ahead of time.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/pci/p2pdma.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 473a08940fbc..2574a062a255 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -825,11 +825,18 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
>   static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct pci_dev *provider,
>   						    struct pci_dev *client)
>   {
> +	enum pci_p2pdma_map_type ret;
> +
>   	if (!provider->p2pdma)
>   		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
>   
> -	return xa_to_value(xa_load(&provider->p2pdma->map_types,
> -				   map_types_idx(client)));
> +	ret = xa_to_value(xa_load(&provider->p2pdma->map_types,
> +				  map_types_idx(client)));
> +	if (ret != PCI_P2PDMA_MAP_UNKNOWN)
> +		return ret;
> +
> +	return upstream_bridge_distance_warn(provider, client, NULL,
> +					     GFP_ATOMIC);

Returning a "bridge distance" from a "get map type" routine is jarring,
and I think it is because of a pre-existing problem: the above function
is severely misnamed. Let's try renaming it (and the other one) to
approximately:

     upstream_bridge_map_type_warn()
     upstream_bridge_map_type()

...and that should fix that. Well, that, plus tweaking the kernel doc
comments, which are also confused. I think someone started off thinking
about distances through PCIe, but in the end, the routine boils down to
just a few situations that are not distances at all.

Also, the above will read a little better if it is written like this:

	ret = xa_to_value(xa_load(&provider->p2pdma->map_types,
				  map_types_idx(client)));

	if (ret == PCI_P2PDMA_MAP_UNKNOWN)
		ret = upstream_bridge_map_type_warn(provider, client, NULL,
						    GFP_ATOMIC);
	
	return ret;


>   }
>   
>   static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
> @@ -877,7 +884,6 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   	case PCI_P2PDMA_MAP_BUS_ADDR:
>   		return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
>   	default:
> -		WARN_ON_ONCE(1);

Why? Or at least, why, in this patch? It looks like an accidental
leftover from something, seeing as how it is not directly related to the
patch, and is not mentioned at all.


thanks,
-- 
John Hubbard
NVIDIA

>   		return 0;
>   	}
>   }
> 

