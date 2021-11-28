Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1834602B2
	for <lists+linux-pci@lfdr.de>; Sun, 28 Nov 2021 02:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356763AbhK1BF5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 20:05:57 -0500
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:63553
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231160AbhK1BD4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 27 Nov 2021 20:03:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmLAEb264UyG/Rn/FQpifpXCLGRavFjVl3psdqQF9B0egPP7WP+5260eMgWKR3E7USn7+tGzmh7rMytt8nWqZ/UFtKiKIvSCuRBG2Lw0jf+EUIOvaatnxO1Tzr0gyxF5HA069FAawsG2QR7u9N6XVVsBpkbZwgy8ixWUTTm/kRKxWCt2eDQuyJNiUQkMRWcqcGArUI8udjGuxi1nizGJ0P8uwTE6Wu9NBwDFgNU1tKFi3mP7G6nlIc5ZTaXO7wpYAS7t2chXhGzWRmN6SCjMOA7+3ksbgQtK/CTRdc14Pmqq7yk1qufwgigBHqwYDJgIDNx/8HXlTo7E/P09RFrBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSuFiADXHEbRNF87F77c8iR5JVN750YAAsdtJGLNHkQ=;
 b=LC+vITO2Pknu3BtKn2IAkpc9iK8b+JMZ0X6A3lG8+TgS8JUkhRBC4Tb295c+1D4ePdqJ/e6aTsu/FQ7HbU7b3QHfuRkiL1ETqLs4nu25XjXUaXHHyef7Ug+oxAmt2Szu95hGLBCncdAfw9dNDXUC0nT6WPrQTM7BQBVVEws49V0GkaXfjYoAlcdwhBREZmASh2KDkGxYYdPtjSz4dxTL4UN5/PwE5DnV2ja5Itrfh8/XRg6s3HmsmZ5IkmGzbKRKVkiMFDPiZEEnsLbsYIwp50nUV9rDld//B6F9+gK7GhYAO1iG/7sfqqhsDDOJNDc8doL744Mf/EtbxpJAsvnOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSuFiADXHEbRNF87F77c8iR5JVN750YAAsdtJGLNHkQ=;
 b=ccvevOaSqVMxW7u5i4siD0URuTx1eU547U7hlW6n68q0z3FtoqHc3r6JOaF48U5BVtRDJi7B5xF38JSFkGXWP8uoRh9sMpJD4YGdJzj/iDfSTOjweHRnawXG78/GVfpuqH353trfhKs2u3/OwhPOawTbiIubR8dDIqAG5HLrNAvmBsqwAWlGuLHwIZy7bch1A8yOGV7tIue7GyNcBF/CkF9PgKVTxMxqpIxwBXwO1Opdiwk0Ak1BLaw8xQU+pCxMgvnQSlMif5QoWgvLuUnsc8un5wDV65TgqA5UJBKCxtFFFPMyeo146dBeTOQDkzPychl1BeIEqpRtePKEZYB5Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Sun, 28 Nov
 2021 01:00:38 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.023; Sun, 28 Nov 2021
 01:00:38 +0000
Date:   Sat, 27 Nov 2021 21:00:37 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [patch 04/32] genirq/msi: Provide a set of advanced MSI
 accessors and iterators
Message-ID: <20211128010037.GV4670@nvidia.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232734.531194050@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126232734.531194050@linutronix.de>
X-ClientProxiedBy: BLAPR03CA0075.namprd03.prod.outlook.com
 (2603:10b6:208:329::20) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0075.namprd03.prod.outlook.com (2603:10b6:208:329::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Sun, 28 Nov 2021 01:00:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mr8YX-003nwf-Bm; Sat, 27 Nov 2021 21:00:37 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8752eb34-cae0-4763-7454-08d9b20a7de8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5208:
X-Microsoft-Antispam-PRVS: <BL1PR12MB52083FF4CCDE1E0B8307FCE9C2659@BL1PR12MB5208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUxCNuIZ25saZFExii+ANE36ff9Gyi4cDtsxZKnZpabPJ2MbRaNpRzBL4p9fKuITkTXg5ZPP55sardmOZlV7juWZvB3BY1hn40kjN1l4npVeKXgf8wSLUbT8O30nbP6JPlUBKa8N61asiafaFgBblAubrhHCOjYlTdFkPUXRYW+GRKGeghzSBBBdpygrf0PPdOEbyDUNwsKDebcpVpxq2zNCA9DqOY178PBYDKGQDP0/AFtj9qmsBA2sgubljwWyaTWadDsSu01UJIbkB0wpY6kt9dVVF08MeMYC4VpqqTmix5FM+LZuKrq+i61Wy9ETK3eNkb8psrQ2PnmFaw18ZpzCqoPoB+JOyHYkkFe4E35e+L3wX6hiIDuciiWHU3NfFpjKZJzzh+02CG6CvkuZEFakcEi60ra5DkjTC6iu56W4/AmyRID2nrccPEFKC6blaqbRIffn9iL4TWzQf9CFR9bsZgalDviflcvAVBDK7ceArGmMo0j/R1S6vuNeDu3l23XqWO5PNbVpBsgOqLh7+pxWA+QdkqHj+cMHrBLh5gBD1YzfwJE3SP+3cgbPiAK3AYWDKFbtY/kzjiSOnolbLUZnDIBVd9JG1mHBWwPInin/KFCEU4XI7uHQGUBYY1+0/oTbAUNVEFMRhXvQwE4//w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(66946007)(26005)(508600001)(426003)(66476007)(2616005)(36756003)(8676002)(66556008)(38100700002)(9746002)(6916009)(83380400001)(8936002)(5660300002)(54906003)(2906002)(7416002)(9786002)(316002)(33656002)(1076003)(186003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O1/xMy3YlSOccFzKS8MT6xkwzfF//odEuhpUs4hbvakw0tS5HCmvMlz41z6N?=
 =?us-ascii?Q?k1LBoj2Vu9fS0BK1O9ZA2J9o8lAjuHYVIVqo2HZkryxAv60pFjkpThgmvVG1?=
 =?us-ascii?Q?U7RRFXJblbefuJVp2YTv2UgXleYKM9ieaDJQlbJericd2Oexatvjra7wZtM1?=
 =?us-ascii?Q?Es59C6Had/X6eY2bHQ5pStI96DAecsvKkU09EYJy4LcVhWhLao05ls3x7r1I?=
 =?us-ascii?Q?dwKRziCsOwU+pV6xYNc04BSl73Lu3GtDwW/G+YV4qBe8Y/r+Ja93obvJBCmp?=
 =?us-ascii?Q?kkGfyjzCyUWjKQ3muLhxglS35E3NjIoHcKjTZX+9Ts/A2wN7oNEKTJyAejgu?=
 =?us-ascii?Q?ZaDnxYGB2hpni5ZMaH5EZA+G5Df9VGEDLXERztgipCNXUxUpWhrSfUJOgDll?=
 =?us-ascii?Q?t0JF4O/5g4MfoXs5oGjttxlQ5WDd+L/WAWOBLwwVGZiUhLPby0swWo3/KeuT?=
 =?us-ascii?Q?aQfLRnvxOxh0nTjUTO5Hfk2TSrVJ8LWjnrODuJ/E7MJkFWEPzDI8+QghHwPW?=
 =?us-ascii?Q?0axAdhHOM8Yy4p9pOW83Q+K+ToJFhmCjhhLP8I5ocYlUI6V2IfI3G/UHkbjA?=
 =?us-ascii?Q?bgrfRfxokPqJBDqLwRdDsiiAqPkuclA0GB7KjKphfAw1F6IsS91WXjAxlDRV?=
 =?us-ascii?Q?Sc8BFvUFMPVTO9evTriRXXeDbMmV3ybiDqoJcN70rkYKq/SXbo/7lhfoe4S2?=
 =?us-ascii?Q?c2ls1qnwh9A9sxzkdxubpEkr1gnT/l2YgwyuYP/61shhrfyd39/PidjsyhcB?=
 =?us-ascii?Q?AOxNQTuJOi+ncxI679cH5FU5ua+HLFhsAGoAOka/dGTGmnz5BrD84yzZJeLi?=
 =?us-ascii?Q?2egosyWl0MeFekCh6WmHc6Fgk7+lmwNbxhoBTcDYhL6tn+BVcREMeMChLOd+?=
 =?us-ascii?Q?7duWxb93ttTdXOTK5E+G7Tv2dET/7LLXsIb57feg7jEiphBh9OmQ7xppIXo/?=
 =?us-ascii?Q?Z2xPC1ZpTGT0dJzesLUPCIXLp33KBbUyPNYZaMgX2M0a/LfSuN6VWjsqeyiy?=
 =?us-ascii?Q?zzsAAPVJepLHr/PIwP36EDLqVgGuEAroTaMg/Nmq2g1h8uMXyCVek+6DjaYM?=
 =?us-ascii?Q?VJxqdtwk7GK+MD9MmoQTp4Jl/xngIbHXPYYllvnXPp+08H3neHhY7SKXRQvM?=
 =?us-ascii?Q?HUK1dd/6YteiHH2JND6Y9rHIyeneTeyUBiA2dnp7K48AqLqUACq3LOEuJVa1?=
 =?us-ascii?Q?usVOLQ4z5zEdU2Wgz0kP2usDPbHTqUB2pOsxEZ8Ti7WjFgZF6Urtucn70te3?=
 =?us-ascii?Q?72uxQft0UKCx5SOVVThIfi1Gd2MOl9MaAcwwatPUXkWDbztvEeZq+aYkAv/A?=
 =?us-ascii?Q?5VHi4Ws6ZrjHS+YroIvFqBRNUMwYmax4B8CpGIn/cOcFCPZKgpbtw0wznhAF?=
 =?us-ascii?Q?9ZCF02bHEaF2ofVKYMWaIzchBi+pXaeys/hwaYeCv+QhiSeDilVTdNiBCnko?=
 =?us-ascii?Q?WjVLDbGBDQNqCPl3czRr37O/cS/csWxmQQ/mgQ72r1J7nPLCsuBFGQQT1PBy?=
 =?us-ascii?Q?Ef4/3YwU5WukD6NvOjyeDtq0wE/FshE7Al8tpjKpbPch7W1NZ7kPa+hwmZ51?=
 =?us-ascii?Q?YFqZ6EalFje4lYaw/8U=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8752eb34-cae0-4763-7454-08d9b20a7de8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2021 01:00:38.3400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQRpN3xw4r09o19QPl+gR9ZtN6+qbn5jb3axmfZ6Rsb6SoobPNU4gAKWGmCbDdYl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 27, 2021 at 02:22:33AM +0100, Thomas Gleixner wrote:
> In preparation for dynamic handling of MSI-X interrupts provide a new set
> of MSI descriptor accessor functions and iterators. They are benefitial per
> se as they allow to cleanup quite some code in various MSI domain
> implementations.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>  include/linux/msi.h |   58 ++++++++++++++++++++++++++++
>  kernel/irq/msi.c    |  107 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 165 insertions(+)
> 
> +++ b/include/linux/msi.h
> @@ -140,6 +140,18 @@ struct msi_desc {
>  	struct pci_msi_desc		pci;
>  };
>  
> +/*
> + * Filter values for the MSI descriptor iterators and accessor functions.
> + */
> +enum msi_desc_filter {
> +	/* All descriptors */
> +	MSI_DESC_ALL,
> +	/* Descriptors which have no interrupt associated */
> +	MSI_DESC_NOTASSOCIATED,
> +	/* Descriptors which have an interrupt associated */
> +	MSI_DESC_ASSOCIATED,
> +};
> +
>  /**
>   * msi_device_data - MSI per device data
>   * @lock:		Spinlock to protect register access
> @@ -148,6 +160,8 @@ struct msi_desc {
>   * @platform_data:	Platform-MSI specific data
>   * @list:		List of MSI descriptors associated to the device
>   * @mutex:		Mutex protecting the MSI list
> + * @__next:		Cached pointer to the next entry for iterators
> + * @__filter:		Cached descriptor filter
>   */
>  struct msi_device_data {
>  	raw_spinlock_t			lock;
> @@ -156,6 +170,8 @@ struct msi_device_data {
>  	struct platform_msi_priv_data	*platform_data;
>  	struct list_head		list;
>  	struct mutex			mutex;
> +	struct msi_desc			*__next;
> +	enum msi_desc_filter		__filter;
>  };
>  
>  int msi_setup_device_data(struct device *dev);
> @@ -193,6 +209,48 @@ static inline unsigned int msi_get_virq(
>  void msi_lock_descs(struct device *dev);
>  void msi_unlock_descs(struct device *dev);
>  
> +struct msi_desc *__msi_first_desc(struct device *dev, enum msi_desc_filter filter, unsigned int base_index);
> +struct msi_desc *msi_next_desc(struct device *dev);
> +
> +/**
> + * msi_first_desc - Get the first MSI descriptor associated to the device
> + * @dev:	Device to search
> + */
> +static inline struct msi_desc *msi_first_desc(struct device *dev)
> +{
> +	return __msi_first_desc(dev, MSI_DESC_ALL, 0);
> +}
> +
> +
> +/**
> + * msi_for_each_desc_from - Iterate the MSI descriptors from a given index
> + *
> + * @desc:	struct msi_desc pointer used as iterator
> + * @dev:	struct device pointer - device to iterate
> + * @filter:	Filter for descriptor selection
> + * @base_index:	MSI index to iterate from
> + *
> + * Notes:
> + *  - The loop must be protected with a msi_lock_descs()/msi_unlock_descs()
> + *    pair.
> + *  - It is safe to remove a retrieved MSI descriptor in the loop.
> + */
> +#define msi_for_each_desc_from(desc, dev, filter, base_index)			\
> +	for ((desc) = __msi_first_desc((dev), (filter), (base_index)); (desc);	\
> +	     (desc) = msi_next_desc((dev)))

Given this ends up as an xarray it feels really weird that there is a
hidden shared __next/__iter_idx instead of having the caller provide
the index storage as is normal for xa operations.

I understand why that isn't desirable at this patch where the storage
would have to be a list_head pointer, but still, seems like an odd
place to end up at the end of the series.

eg add index here unused and then the last patch uses it instead of
__iter_idx.

Also, I don't understand why filter was stored in the dev and not
passed into msi_next_desc() in the macro here?

Jason
