Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A089D41B9D7
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 00:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbhI1WGq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 18:06:46 -0400
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41]:63904
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242929AbhI1WGp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 18:06:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WRUzzhdefmJ6h3g6TIr7vSBu3tgHVLduDzIpiSGOzHan9q6/GBGZ+RKLVLLkp+qhj6D8E5h0dIBNFdpf3Jm0EqwWPCAmfyO4Et/Zi2cYefkReCQLIqfMS1fCZXgNQpWVRdIj3Rbw4p+6wG7wR8OYsq822G9xIb6oYsB/y66201hU3c7vCg87sZ65b2BecbRP9dxWU/4LTpD0fl9vDQyHdWCsLaJxqg2+PIM8QTugN8wt5CvV7joH7xuGv1vGTkcswnf2Mfw42httFtwgcP69Q5aj+l77TT06ofJGWAzbmThzhwpKw5XuWKnN2WHYTW+hkrjUz+Myb5Ii0II1NRBiaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Qe5kxN0ddAG7mPItxuJHjsxxxyi+e/yvMrh0jCYFVH0=;
 b=mq8SV5SwxizebaiuKKDLEeP8XekjDCKr5/VbnQcTyQZoSV+rSL+KJGE/Uj/SBZntl9aI84z936/XL1IX0ucXY4aAaQFoocvmI58Ewp4zkAvYZboj3pI9vkMMo3l2mt4xwK3VDQNL8a9Aah8A8DPKFXPQhjLZg5hBh706IzvXkk3vpyYbvuDnxrFckGuquwOK6QQYZV5IeOmZZ/Rb9zSBG5d5ABBBKUtNeyZaymnEfxMzSL06U/le4cUdD9qbvOrUr7sRiGvhmCv19wX9B+NMuX7ZAgq78BcREFTbOEYp8rr9HkTZtT8WTKuVfqF27kTZN9PqzEedKcIsBgC868p9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qe5kxN0ddAG7mPItxuJHjsxxxyi+e/yvMrh0jCYFVH0=;
 b=Pxlsptf+DlMyCcU6pvK6KDdace9IB2bgH53hk5FHMLMQxFKfyglGMjqlkZOLQ4mSNtKNDjpYCId45G3Dbq89iPIxKGzr4ARhTcqIJYhGLwuzg/eiFK7f2dewZAS/07Moa2g9MXaHKkW0z0rDNRW7IPLGLT+QAuJeP0h8C7olmnrjF92S2XcNes5FMjMfm8ORP97OCmWs1Q+s1dk6UrT8iKy7OScqWg5bhCsTykKhrpLHMmQ6K2n26xnsp2/Lg6PTPwZw2kQ7xgd/D2kMcofxgTeA+NGXd1N1ppcYjsQSrdyhPT/Na0Jr0UhdWmFVs58I5pLb2n2NL0D6n+grt+JOWA==
Authentication-Results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM6PR12MB5550.namprd12.prod.outlook.com (2603:10b6:5:1b6::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Tue, 28 Sep 2021 22:05:03 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::3817:44ce:52ad:3c0b]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::3817:44ce:52ad:3c0b%5]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 22:05:03 +0000
Date:   Tue, 28 Sep 2021 19:05:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
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
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 4/20] PCI/P2PDMA: introduce helpers for dma_map_sg
 implementations
Message-ID: <20210928220502.GA1738588@nvidia.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-5-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-5-logang@deltatee.com>
X-ClientProxiedBy: CH2PR12CA0007.namprd12.prod.outlook.com
 (2603:10b6:610:57::17) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR12CA0007.namprd12.prod.outlook.com (2603:10b6:610:57::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Tue, 28 Sep 2021 22:05:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mVLDi-007Ice-4B; Tue, 28 Sep 2021 19:05:02 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1431c98-a1fb-40f7-c25b-08d982cc05ba
X-MS-TrafficTypeDiagnostic: DM6PR12MB5550:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB555067D3D9625CE21F528D0DC2A89@DM6PR12MB5550.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/+59L6XbL1hKX79x54TMl+VW5TtLSP0rhJlfYGz9uibMTqstalowo3f7tJL7X7cHzTY9GsTKbOiQWdF8HvueBRAULoBkww4NNuwxogzgSBQwl22aCqKdgL5YXeQnu5dh0pdtpcpA3F68EqDtlKVHNb/Haz+nUwvGXeMEme+AEFBwnfrsHpKs91R8a2/zduf8Vgq4YxCjhhQTO548VEUGf08XfgrK0KpV3pt53kdr04SHhvxI7kANemBsLY4+p9yimGD7DUfzOPD6CBkO2YWi/6bD1qtxAtTKML6062AdENpGMiRPwCE33LN//UAjHDTu0I8W3DFozFQ+qVv0xU+Tg9Jve8mjET3x8w6U5sHV+Tkf0pw6IakhbY2mGQKIu2zmkwEglxYPR+9CytQ3/ArdwSQ8/3RLs07A4noOxk2PJ29YYS7WtTrXcG7epfGHVhGtoGxDhTDYTsJlxMqEzuhyDojP+rDrxcD73WPDZMdqaZKhpgjYwTJoGDdz7EGDBL2cWOXtftLV4NJE1szabmxbt9z6c7zfy/dYuxWvl8IhBuSch0OvOaoNIb90SfiVb2sHefdZHUjbP+AUW4TmAlw71tfVnqTsB/WP2/C/secvr5hBeKs/LQbfIlgmAFxVR9YhfKChu2lboDrgommteqY9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(316002)(2906002)(7416002)(1076003)(83380400001)(9786002)(26005)(66556008)(66476007)(54906003)(36756003)(6916009)(186003)(33656002)(8936002)(9746002)(66946007)(426003)(508600001)(38100700002)(4326008)(2616005)(8676002)(86362001)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MbeOzvmyZtyGuYqIg8gFYQZVCLgxMhHjTbX6Cnf1P9tfwz7Suor1pImP8JPj?=
 =?us-ascii?Q?caO8q1PgVCOahQCCszk+zupX80XmzidTgq5okzLL73ltgtcSFMy5vAa4CEVn?=
 =?us-ascii?Q?TOQ4M5oEnT4EYh+gy5MQriwS/vct5rvCGogsj4kWW8zIh5puafcFPu+6pAB9?=
 =?us-ascii?Q?V7OllzpJtrWh8hp2HgHpNVhci6xk0OiPGuPtA0oNGgr0++xtZtBtrmNunmLO?=
 =?us-ascii?Q?MucA9WuPEaFD/hw7cpAfzMbkpw7eYQE97keo9C5hiewxKvPwkUtW0DIg3c68?=
 =?us-ascii?Q?iOzevMIgS2nCLU6KDhvgZ55iR09fqDN3kwYevBqbsPS2h2VD3aKA1i0SaagF?=
 =?us-ascii?Q?SrIwjD7XKqdtiiLN4B/9msRh/JYdOTTFVoft0g+D2ufyo+Gg7EWShXnJlQB0?=
 =?us-ascii?Q?3sJb1n/DBr3th7oz2cKMW85m6j2mDCWGPptgzmltkW02madh4fmGoJm9DBiA?=
 =?us-ascii?Q?sWAQrv942SbRP3h6RdameJXH6vUaHg48/S1twHJzMpuhD2z6gl/unIVx9yXu?=
 =?us-ascii?Q?sBVVSkjcD2NkVmzwBRgXkk+GV2OnenDZgwOv/JFLhioHDbrXxzOjcsM0wmgz?=
 =?us-ascii?Q?NEmRcIqZ2P0Ng/Ryp2MBUVbmj40rJC1SQbTPyDLjqO2GHTgeqk926by5iLdT?=
 =?us-ascii?Q?slZdR+entC+eQs/umXo3i/pFV9n0zgr6syMQ0M8s0f0jhympu3tZNU+F3YJ7?=
 =?us-ascii?Q?Zu1S7YDpNMVmUbPj4clJcnnPL733cw0OG+ptUj88XFX/fHY3Q15O7HNh4mG5?=
 =?us-ascii?Q?2wSTo+5XqDG9QRxxlGE/ypIcw1Kk4D1komdsBV4DMtFMxMl706iHRd/UAPKS?=
 =?us-ascii?Q?/TH0F2SbPzNo+6sVYd2NXBZ8XafDICmctv9X1gfHLpcFOkNVh+CROMVREZEx?=
 =?us-ascii?Q?mgRij3Tf9d4wuU11eV3jPowrANntpnds0fj4WCe0Bf6Y+rMADOngMmBLZwkZ?=
 =?us-ascii?Q?43hjPmt8O3zVgKw/hGidiRfpjqKAfHsaKB77sksgx6WTzI7fHRpYd04j0nmp?=
 =?us-ascii?Q?KucamxJj8AEGbCuVwOou9r/zEwMhZS1rb9GDOYlVjZY9eCFvZHF9Llx4YRTP?=
 =?us-ascii?Q?sCTnAgrS8OUlTT0uTHZ/Ek/mM6r/XBnrBAusOskl0wjtoR6WpLOxt6CcaZTV?=
 =?us-ascii?Q?IsHvuMXf2vt3vy6RUO9pqhcnvZzw0qKwK35sUyXFdjzruV3E+cEG2Jcph/I5?=
 =?us-ascii?Q?UoZElAKOQacaP7S27rdxv0zkVOUKY4d08rJN8Y5V7LCJhRyTVEAvNtg1EFzO?=
 =?us-ascii?Q?YUi4BnlgpAxnLnWHRPWXag72kSxRKl1A+EVY+WVvZu86jG2MRTepe+gD9Cto?=
 =?us-ascii?Q?PfCZfhJoc6EB1bM8xJaBiMbP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1431c98-a1fb-40f7-c25b-08d982cc05ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 22:05:03.4026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzyvAr62RCkiS3PB4f9w7ovyyuBGQUV5TbN1p4rjkcrxQooUFwxjGG3tU9k4b3o9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5550
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:44PM -0600, Logan Gunthorpe wrote:

> +enum pci_p2pdma_map_type
> +pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
> +		       struct scatterlist *sg)
> +{
> +	if (state->pgmap != sg_page(sg)->pgmap) {
> +		state->pgmap = sg_page(sg)->pgmap;

This has built into it an assumption that every page in the sg element
has the same pgmap, but AFAIK nothing enforces this rule? There is no
requirement that the HW has pfn gaps between the pgmaps linux decides
to create over it.

At least sg_alloc_append_table_from_pages() and probably something in
the block world should be updated to not combine struct pages with
different pgmaps, and this should be documented in scatterlist.*
someplace.

Jason
