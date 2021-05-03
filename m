Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9051371053
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 03:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhECBa0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 May 2021 21:30:26 -0400
Received: from mail-eopbgr770080.outbound.protection.outlook.com ([40.107.77.80]:29316
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232822AbhECBa0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 May 2021 21:30:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCL/lO0jUUHuol6goA0YgtXIvcFtDX7e5D00ofXEMwUROtHKhyG17bvegfUp72pQzfNV2zA973GQ7ky5Na2fHMC2VEbAMP4/rjYDnO/sok7SKTZa/qmF3jTB9928FxauvKBTrRTSE/ZrA963OJzR5MJMvpZ3WPb2hYhN+kSKrLtor+dd3Q0vZXB0U+C++F9KZXkCU83lVWGLR0q8NVgqGBi+dlwzU1kc8F86n4W88c9yEMj7WP68p0ZSz/JNEFK/4fiLtTzj14kMfhEvXvqglFjC2lLorWAXsz1qAFr77s30950JnNB+IctmccpcVhOlxndxnRzVdfdyGep/8bkzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyavnRE3Ox1ihMSwbw9mkeQeDET3W5clQ5FHuVhcTV8=;
 b=ilRiUR9lhADkC25aMVkI76koF7QZN8YQU5a4PbwsJ7b+i9Qbl6bkjTuQuU/ZKNobRA3veLLbSkywSVXBLZSoyOasRsvG4IKvwlnqWxaVTTlkNLXJd2dTtj8cmmAVAvHpAq35xf4kerybtz8jES8LA6wFIggVcDvPDvtaO2KA8RbfLYdX2n/N+gA7f31MBmC7SjdM9u7vReHM0Kw5FE9S1u3IGtmvBvWz2d0gk7zVZu+4YmGRYtxyGPNeiTGYgozXsUfJTuYX1ioMN8X3YviXFUxZLYlijOtNOGzPnf4km/8zozx2xneGo2MuO1rZpqWaXgi0Yh2LP4F8KgVGC9pUdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyavnRE3Ox1ihMSwbw9mkeQeDET3W5clQ5FHuVhcTV8=;
 b=OPEAjJnRM4x4FwIBocyNAcxTpUNMJmpwdjxKTangMauSn6yyl6eN4DPhU1uQCgi8olPpKYUJGROWgXQAVthWST+4li/4m/YSBN/Em+MbSYoM+Oi6BIINMuPLGUMNKJYZqUya5F9IYJT5O/+pABENj99XEn/8EWXOfm5W2cjIuop8WJ2GcXMtYXrYpzdFQKmsKO76OKarG2RQSjZ+NqjiR5W/gZrXhvEdzmCysS/SUr8CCXWy3WI6Xrw6E4mPmYw0gZhe7d9qLWOuyCdGdn3v6Rj0lR90ilCv9HuuTs8fDFhmLPAUzYQOLCCjRDrmwX+zFvrrExQpNQfUMnFvs/MdAA==
Received: from MW3PR05CA0010.namprd05.prod.outlook.com (2603:10b6:303:2b::15)
 by BL1PR12MB5205.namprd12.prod.outlook.com (2603:10b6:208:308::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.35; Mon, 3 May
 2021 01:29:31 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::47) by MW3PR05CA0010.outlook.office365.com
 (2603:10b6:303:2b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Mon, 3 May 2021 01:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 01:29:30 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 May
 2021 01:29:30 +0000
Subject: Re: [PATCH 12/16] nvme-pci: Check DMA ops when indicating support for
 PCI P2PDMA
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
 <20210408170123.8788-13-logang@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <f8bdf85c-2302-890e-7f77-e11fe6f29d6e@nvidia.com>
Date:   Sun, 2 May 2021 18:29:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-13-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a01d090d-0336-4080-9763-08d90dd2e647
X-MS-TrafficTypeDiagnostic: BL1PR12MB5205:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5205A85CBD986CF9F3BF562EA85B9@BL1PR12MB5205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2TnRenD0MBbZZTZHt/sDgGqDYrN69ewZbD3RlpBe5wmqMcA4vYkoigcHzR7xc77h9rXX17RHoASYYC3SMHLC8ULS8iZ+AUZhny7UQqSp8Bkptx0rU34/91aODlgf84LQFbAgsDN3powGzDht1hgOgTQqfBpqPal+WItxxmttNGMaNP6uFKGU3I0hvwtH4xUCBEEh7zXK18+LP9z0Gbi0PCysnPjBwl4I7OFr4craDXpQr7XbC57LGwRVWH7W7BLzG07bn8Vh5usMP2H+RalIWL/lVjd98JPjeQkQ7Ks40WrIVnrOqngGrh0P3cpbDXB2PHlRGBZdiokOyvZoUJxWuNV5xt8UYzihnbGiKb/pVQRshPxYxru3WTyO3jwGqOe6lBZONoua0GYvYkqTvx+ki0QidJ2nq13NyIdBNMbZ4tnsiHjiaPmyx7WBgp/i7lAn5oI1B7xIu/1B6jJzQkfn+Jf12Qxr+l/jJU1Zct7YP7HFRANXozrwW2kvuwqHLnmUKT/j4BmZIFE9GcKfgnaQX1tt9BXHzGSJUplxZ9/QyTAX7dIqMT9fokgN6g8RkoDCtzW0T+2NkznksFLgPO+/qeTF9zGAsH4gKC8WcXyyoDHPmrLdId2cTnYkduncoAuIsICOdEJGnRja7jGR91OBWc5zh7P8/bTNBa0pOWKQNmtV/14p/wxfLBq9iTx7g44VPDZJrfd/HEeBQWV8cpZnhg==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(36840700001)(46966006)(83380400001)(2906002)(36906005)(8936002)(316002)(82740400003)(4326008)(70206006)(70586007)(31696002)(8676002)(47076005)(7416002)(426003)(7636003)(16576012)(53546011)(36860700001)(5660300002)(16526019)(186003)(36756003)(82310400003)(110136005)(86362001)(54906003)(478600001)(336012)(26005)(2616005)(356005)(31686004)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 01:29:30.6331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a01d090d-0336-4080-9763-08d90dd2e647
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5205
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
> Introduce a supports_pci_p2pdma() operation in nvme_ctrl_ops to
> replace the fixed NVME_F_PCI_P2PDMA flag such that the dma_map_ops
> flags can be checked for PCI P2PDMA support.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/nvme/host/core.c |  3 ++-
>   drivers/nvme/host/nvme.h |  2 +-
>   drivers/nvme/host/pci.c  | 11 +++++++++--
>   3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 0896e21642be..223419454516 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3907,7 +3907,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>   		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
>   
>   	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
> -	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
> +	if (ctrl->ops->supports_pci_p2pdma &&
> +	    ctrl->ops->supports_pci_p2pdma(ctrl))

This is a little excessive, as I suspected. How about providing a
default .supports_pci_p2pdma routine that returns false, so that
the op is always available (non-null)? By "default", maybe that
means either requiring an init_the_ops_struct() routine to be
used, and/or checking all the users of struct nvme_ctrl_ops.

Another idea: maybe you don't really need a bool .supports_pci_p2pdma()
routine at all, because the existing .flags really is about right.
You just need the flags to be filled in dynamically. So, do that
during nvme_pci setup/init time: that's when this module would call
dma_pci_p2pdma_supported().

Actually, I think that second idea simplifies things quite a
bit, but only if it's possible. I haven't worked through the
startup order of calls in nvme_pci.

thanks,
-- 
John Hubbard
NVIDIA

>   		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
>   
>   	ns->queue->queuedata = ns;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 07b34175c6ce..9c04df982d2c 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -473,7 +473,6 @@ struct nvme_ctrl_ops {
>   	unsigned int flags;
>   #define NVME_F_FABRICS			(1 << 0)
>   #define NVME_F_METADATA_SUPPORTED	(1 << 1)
> -#define NVME_F_PCI_P2PDMA		(1 << 2)
>   	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
>   	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
>   	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
> @@ -481,6 +480,7 @@ struct nvme_ctrl_ops {
>   	void (*submit_async_event)(struct nvme_ctrl *ctrl);
>   	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
>   	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
> +	bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
>   };
>   
>   #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7249ae74f71f..14f092973792 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2759,17 +2759,24 @@ static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
>   	return snprintf(buf, size, "%s\n", dev_name(&pdev->dev));
>   }
>   
> +static bool nvme_pci_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_dev *dev = to_nvme_dev(ctrl);
> +
> +	return dma_pci_p2pdma_supported(dev->dev);
> +}
> +
>   static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
>   	.name			= "pcie",
>   	.module			= THIS_MODULE,
> -	.flags			= NVME_F_METADATA_SUPPORTED |
> -				  NVME_F_PCI_P2PDMA,
> +	.flags			= NVME_F_METADATA_SUPPORTED,
>   	.reg_read32		= nvme_pci_reg_read32,
>   	.reg_write32		= nvme_pci_reg_write32,
>   	.reg_read64		= nvme_pci_reg_read64,
>   	.free_ctrl		= nvme_pci_free_ctrl,
>   	.submit_async_event	= nvme_pci_submit_async_event,
>   	.get_address		= nvme_pci_get_address,
> +	.supports_pci_p2pdma	= nvme_pci_supports_pci_p2pdma,
>   };
>   
>   static int nvme_dev_map(struct nvme_dev *dev)
> 

