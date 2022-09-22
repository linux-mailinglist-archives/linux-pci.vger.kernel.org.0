Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2539A5E6806
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 18:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiIVQFN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 12:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiIVQFM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 12:05:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4AE28285C;
        Thu, 22 Sep 2022 09:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOvGsXi3CnAiEVsmyt8ia+4VC4dPAeHRPGcjX3QSZshWGzVijJGVl2rUz3l8M89m+nS4aMbZ0gOrlpfh5BwClovN8tt5nM/YSapFB40tpPcQgrpw6pSdVundZ0RXRVs/o7yigxjGFOohODQooNStSeyS2l+k1zxiIRusxOFP+APwLyCXYmGZEbobN1U/S0BPwqmROIjAH9FOhcVsqfi+y3FxJslMT8DR/V3bSYBUbZ/Ib5X0pe9PIYyOyRsCwnOBF7f7TbPgFzpY9nCm8OWhZMDccsWeaVzuSoiDovwrV7EwF7tApycTbtNdzINLX0CFDHuL/TOZbuBBeh3OXYTd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEzxiagqtH79v9BkfV4YJW0fHZFD4PFBgAxKN1kdr3o=;
 b=hodv5E110sCo1OHCauF12nJPOkioJd38dcfsWpaHUz1m0GXqL+JzbW4DL/QAkCdpQ/K82Aofqot8TflOQlzPVhhFisWqonk4gjJazUVUxNkBJjUNsboaxqr1URiQ6mgMNOt6mvxpLe7VHwY29hWYlECqpbxjrhg7TEp0tSsspOXhrJihSWuobdt/Yy+1PNjO1Jv141chxSx8wdc43Fz2XL6SU6UDrmacMCuTfGMuSsAuL15j2vYV9RpXOETgibuDBE8Of1sOdsDBO6bzN6tuaNyTbEffSitFWzZAK8bQ/fLeQZuRDAjZm9qCbUy/Z4YyzxrBdukTXf+G+mqvT7fOsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEzxiagqtH79v9BkfV4YJW0fHZFD4PFBgAxKN1kdr3o=;
 b=CsGyn8FsVSAvY35beoUAVYRszT97N47ZvcQ94+oefuBpVo7nTyVR9AMyYuipGmdzjxhnXKkq83fRorSc4Gc6FerLvn0MhyY7O5TfvirFus9p7EXwNZ44PaTlLGnpjcGa4RPSRlz5fFkI8zuC6GTMiKr0wRWJNLZpcn5gYziPbtYZHOF4v6eyA1yUH2CLOa8gUBhkOPT67+5UOhvwIs3739vEsgXyHtDz+GqNZ7Rdz4Efldo5P8+V9BgVzXGbw/ihkmnZYRlzAbdecHQ1SWyhuzIm8PpP9r7DSAHoZENQsBJOZSwduqBFFU4k6cgScSw7Adl/t0jJfhuZNRWgklLZZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Thu, 22 Sep
 2022 16:05:08 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 16:05:08 +0000
Date:   Thu, 22 Sep 2022 13:05:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v13 11/13] iommu: Prepare IOMMU domain for IOPF
Message-ID: <YyyHs78eszxj7q+V@nvidia.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-12-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906124458.46461-12-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR19CA0040.namprd19.prod.outlook.com
 (2603:10b6:208:19b::17) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 0064f085-da16-4b31-8bbc-08da9cb43888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2DeeCvZs9zrSi9biYE25wpeKYM/N+Z8ceziy9MyyUUeVvnIJqWA68iM4XS9LdJo4F4BcDtGquIzPc+zjCSnPRrIb4xIYIEjKQ7JBz5wKEuedeGXzxqwrgnf+DiQOJPee2CbtzBT775/pC2ku3+lurHG1wF2qvK/ikQ756eHvLzSKijsQWu0YuH3DBoHKDh6dS5NZJlTXq94P+fsLxiOpUy2f8ofgNahOyPxfCkSoKD/F1hBvwLZAee0LNVTxht/NrdHAmfK2dlAJev/ID8PtxxkhB491k5j/GNeQr6CeDR4Gy607K1Z5+HNlhLnqL8uv0fwG1bVNBGuNLc0bmoatNcSVRwKZKrmW7EB5y10cKD7glM1GrRrC1QH8swEh8/WnvijGKkcmiSLDhC+0BX/gdCmHxoZAyoVjK6s4W8NNa2jDkD2r1rXWb7zL9rQluOSv3eq29Cva0/nlOwr0XvBsOWPWY+nOxpwOiA1i81qooPvmpKEhDXXxuB7AOW0DHZV6YlFJjnS6GgpJoAGX5VEMCwhLgbGtKfOZ/kVj5BNczgZYkLYAaZhjK+sjDC7os2eVA6Ozndy/ZDwzjnkrrsiD/hT93IWD11oD/s4Z9bgvOq0wgaN1mni3Xsr4ATj/dwRtMf7yNOwiPozd28tRgI3VETkOXt2pUYUna+l5cBTalJMrM1QyTgCfT88z0VzeBwOZbB2ouy8wBGv8Y5FJqYZO1uvTmzzMmMW8u6hjgmUZH2uAMvyJoP1P2GiGJ9mDsXA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199015)(478600001)(186003)(83380400001)(26005)(7416002)(6512007)(86362001)(54906003)(6916009)(6506007)(316002)(66556008)(66476007)(4326008)(66946007)(5660300002)(38100700002)(8676002)(36756003)(41300700001)(8936002)(2616005)(6486002)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t1OwR/kdaRnWptSCurVEVlTIwpwYJ6nHsQiuIyYRjBalDPSj17O6ilvpnw2W?=
 =?us-ascii?Q?cqVyMuJMJJbDCaO0Hn6fN38rrCh9VNmL5f0OyNvBGbApmIQGzzSDJ6OE7JGv?=
 =?us-ascii?Q?dsykUEGgmrvk/ogwEYz97X7tgIwUx0QJ/RoQp4nHlFfpIv3xnNFuMq88H3Lo?=
 =?us-ascii?Q?H/Me1BJPzSMLZ7BBiw3yTskPB+xOQ5XJSc6n8RlyuqV0guuRN4a5E1krivqT?=
 =?us-ascii?Q?zdZPXFYqiOZOizZlhX/mGBhvpynOaUgHubtQef+je1Pb2lN8UG7szbm6kA5c?=
 =?us-ascii?Q?pXguQY7J2kGlNse6dB/94jd8FrOi2P7SjIFQUPZkW1XyCpjDNPVxqdB7yV1t?=
 =?us-ascii?Q?vVabn/CvUBO8k9TwahaoPlnmb3Z+RvdECc+Cmw4dVmaJ3l8DK5sk2UytTSuL?=
 =?us-ascii?Q?4STGVT3/XsG0Cl5bQJxGO2rf4MLsCIAnFF9fuYP35x62ne0I5pVy2h9tV7pi?=
 =?us-ascii?Q?JgGUU2lw9BLF50k9Q3aZO3nPrxYTGNjArP/i3+iFDA2gZXrG7bDvmgTJXKBT?=
 =?us-ascii?Q?k/csIsbAZjy4EvxKCrxVKvJGwXjNw481jM6lIb81BE8Fk7wVpLreCvMYvT5F?=
 =?us-ascii?Q?S29H0CvDM6+C2UO2LwPgIlAaIKnhW0dalt2j+FlIeYjgb413Pkgiqpcqnx+r?=
 =?us-ascii?Q?L+/1c7euIsiQE1er1xtcC6HWVHJVDLMXaMEbIVzv6Ds4k1QvTcBJ0oWaeIaU?=
 =?us-ascii?Q?DvVwft1vkKfsGjNtoshgUsOKa2j+9XCWP1Kos867UNEQ7lsjXxDxNIiXtS8P?=
 =?us-ascii?Q?BYUSayZet/FKcFFay2NslaMlnE6PkcVyo2UeGx+91q7XfYBPNlo8d4BmLIw3?=
 =?us-ascii?Q?J9Vqz/JVy4pnrhLu37BWNxcBo6u9meOfSlA1fLu3Z0VcTkOCxsGW9ox+Diy2?=
 =?us-ascii?Q?zpWNyrvuEYBLmuS6ZV1sze8IwIHs7XMkfmEWlS+F7cW8SNEO6u3kx6IVdAr+?=
 =?us-ascii?Q?HibJi/j1mg7o86lN3HJ0KUSbpeycyoeLV9GZeIwFeN+BUJdAvet9W8XmSuHy?=
 =?us-ascii?Q?ccLdCq0sfzlxCVSXdhdlHT0uupEx8SayfzGlqFyMg6VLC0KFS92KPb+Wq4O/?=
 =?us-ascii?Q?Nt26RP22ciMUM525yEM4sZ/ygg2KB9LDwg8dAuYwIbGTgZsX8YiOn+wXF67U?=
 =?us-ascii?Q?0zSzopX/RSQJzNBCLIJ5XtEuVqHCOP4iDIkJS5Bf/bKCT5rVs6QCuCxIdsKc?=
 =?us-ascii?Q?GlRs92OR7MqyySaXEV+7Tvxy0oxtmBl3uYmgW3/r0vneWdJz/2nfLHY9SZ4S?=
 =?us-ascii?Q?b+ct9fRgHqRsMKqaAfiac/PHehKs910/qwtsgnP5wMER7k6f6b76dyZe6VcX?=
 =?us-ascii?Q?OGd0LBKUpj6WPh3VQDWxRygh7waTTrtlSzrEmJa6C8MhvQlIFeIVOT16ojQs?=
 =?us-ascii?Q?z5JTGGl9LtHa5jPISh8Czj1uur/mPrnwGqHQb5+WvuICeeLbzAOeCsz4bmsR?=
 =?us-ascii?Q?HufdHE1beXfRHoQ7URsm03pWJg1Duhj/AkeJsUcEboZ+fHnTIVb4sc3DWjMv?=
 =?us-ascii?Q?kFWWsYnNlHOcBttIswlDYkFPmuW+LZp5GI2WPnvTU+1NaYOvRCh6KFTNn7op?=
 =?us-ascii?Q?6Cvm5oQY99JcHGD4HcC9oDRD6+YbMuLTiCW6pBUt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0064f085-da16-4b31-8bbc-08da9cb43888
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 16:05:08.6146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6aB/33GGnSEKO+TeSf23s7tYRsq5k5vq/CTLqAMvCcw9dkujCg6gP1mg694qcEGm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 08:44:56PM +0800, Lu Baolu wrote:
> This adds some mechanisms around the iommu_domain so that the I/O page
> fault handling framework could route a page fault to the domain and
> call the fault handler from it.
> 
> Add pointers to the page fault handler and its private data in struct
> iommu_domain. The fault handler will be called with the private data
> as a parameter once a page fault is routed to the domain. Any kernel
> component which owns an iommu domain could install handler and its
> private parameter so that the page fault could be further routed and
> handled.
> 
> This also prepares the SVA implementation to be the first consumer of
> the per-domain page fault handling model. The I/O page fault handler
> for SVA is copied to the SVA file with mmget_not_zero() added before
> mmap_read_lock().
> 
> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>  include/linux/iommu.h         |  3 ++
>  drivers/iommu/iommu-sva-lib.h |  8 +++++
>  drivers/iommu/io-pgfault.c    |  7 +++++
>  drivers/iommu/iommu-sva-lib.c | 58 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/iommu.c         |  4 +++
>  5 files changed, 80 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
