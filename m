Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1673D5983B8
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 15:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244591AbiHRNEc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 09:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244533AbiHRNE3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 09:04:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486C474B9C;
        Thu, 18 Aug 2022 06:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvovvBPpiis7HhuLp7sBfxTWSROTXetvjZTlR3raNpdswKMG7cwfpbWcIlv76oIC2CHhvXjEKuJRYYYZ1ZU/2AGvMyNM6PJjnFnxzFGWf3868E56jdZnYK/mcXk30FhAlviVptClHRyVX5KfER8Y+88Bt1IPXP4a00X981scTcH2vfQ8O8FMPPbvwscu69m/Nan/zo0fZBMhIR4yYpIc6E1Co0V6oDiLvvbCZDlLav8K+whAbE0iqgQQKvTwJFk7s5XNnZ4wfI0tbOkYI0VfKgwlrzA/PJ5xq7TBnhIfbjAXlKl0f5VFA4uqpHH2ejelh2ODfqFR9z5Zd18gn0emDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sN1uExqmXcdeEFNHj10h+hMQeheiam8GXqv/uPBBfh0=;
 b=TFWZt46SoYuMZjHgxX2iCr3P9Q/vb39t2Fj3wU4T1sJ58lbSdZqII0PbpUG3E/+6DaSXnl45X72ltfCfxDn7TPxTGyitoa1pfp0ap5yg1tfzda4lyLCXXr/Pn7x9ugrrWOsYG293nsgZ0d5Yloc8RrDT0Tj7jT7CeabbTxqu/6hGg4w+u5DqYE20kRPYo0a65gUONH5nvtdTKrOzVO/K38nL87ydYvZTPOmYLhSp+sbhjAnbLSLj0LnGYtxVe5AiU24C+W36qf8+sRCa52EKRozvPqa92a75TsCUivrEnby7iA8eDp/Rrc0tUKGtzNOjs9PQfEe+xRiIJUOXjlDYbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sN1uExqmXcdeEFNHj10h+hMQeheiam8GXqv/uPBBfh0=;
 b=B5Bb53v/cZT4KPKLIFQbqouevGN9XZAN1M7DyUPK3Fbhn6IiBypso5DD5TnCfwEdQrCNKVsgKi66EOxvAKXpUUU14OPMKYVpFNv2RfnyWnxDq9LSSoxIicuyAvdXKSiBzSC41/RQT5GJRvWBmQLJNzP9lJ9I1Mpekrln/TMd1QI18l8l5Z/QbzqWpqJan54O3MsZLWh2jTh1iZJqqUj5XDbWP9lZ//lJ+2KgRDpMI8TF1eR/SUhGaMQsslln1ADF1oaorTZsN8u3Yr656jyiNJHhWEwlSopN9r+inNm9rdS64GE/xvtg5wZuAUGuhF/Co0eEVWVmcUXya5DgAoYMAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN8PR12MB3172.namprd12.prod.outlook.com (2603:10b6:408:68::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Thu, 18 Aug
 2022 13:04:17 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 13:04:17 +0000
Date:   Thu, 18 Aug 2022 10:04:16 -0300
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
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 04/13] PCI: Allow PASID only when ACS enforced on
 upstreaming path
Message-ID: <Yv440MU1UeD9u67g@nvidia.com>
References: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
 <20220817012024.3251276-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817012024.3251276-5-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR22CA0016.namprd22.prod.outlook.com
 (2603:10b6:208:238::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfbc4279-2f3b-4336-2408-08da811a2856
X-MS-TrafficTypeDiagnostic: BN8PR12MB3172:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 63l+IhTTm8bH14XUlwkQr3am1Ds9SunaU/TPzO0pZPvj4Ka1BjB9kNG5OYnOuQU5xp2jGsQ3vf9RcakKlxHCzTgPfzC+pjyBsNFq8mXe1gBCsYewkZ6cgZTmqH1EuboC+0ZftqQBdy8qwTvVJKNEklZQfFEoeUmqsx/NQq/+JekZOQ0iK6wcIZtQTPRvpH9FK98w3bYpSzfXVcnUHnl4cP6YU7GEkbVSYHvkN650m9L2nHvBCXrKJMjmRUZ4hFhDG//zevP8fMVDgPihRMSn7b5VFwgTMp5/D1cBQIrT7+rZJrlHRWlI3yp/byyrOIy6K9t+obRzYwjG27OxRirSCdgC4eUOQiTPM7zU/4oasB0y7R6icJnwQ2+1kWZLjICSDOnhEXCLVc6MbrUc6o7yIf10dMhiSx2qulvC588DsjZwJ2S7zLbgTZtDgscNpJJM1ZFembrKD7y4xfcvigT70rU5oTFGNECbY5SruQlq8TekOlwV7OTUMnjlkfw1c7gGt8YSwoZrfYf+XoVG5dJqFbUSxaC/55elk9QU7PzNCl92EDjNYphzhiG8qSE+bJVl8JeZrZWxWlz5K8uvRLjRaqh4zzVecW/joZ/Aj9RdW3+CtN3fhHrlOaxSaLfDCeXRZT3ELBgYYlqcclGWQd84vG4ZtUmRsJ9h7oLyXcVqesa6apdppqYbaZgUHa5vnWRHz65chtcLxLWCTX9/JNiDOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(36756003)(5660300002)(478600001)(7416002)(316002)(6916009)(41300700001)(54906003)(6486002)(66946007)(2906002)(66556008)(66476007)(8676002)(4326008)(8936002)(38100700002)(186003)(6512007)(2616005)(86362001)(6506007)(26005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VMqb7lKQ7AnhzcpMrxG4uy69h4utDzFE4AODr6KyF4OlExrps4drVRcL9ir+?=
 =?us-ascii?Q?Va/KSEVRBXHk59/SjqAojh+DDetR09MnFtpGmgD2wQs4hXE1h/My+xHalfk6?=
 =?us-ascii?Q?N9Ut7h2o3cNL6JAUS/cNxtJOF64Jmah/6erwUAcgrULOSGI3wbeZ7aoR2vcv?=
 =?us-ascii?Q?EcG+YrgOTjdm41R2mwICq4ZkEZmxbnvu4o9BY2Z2qLxEO9PWCVkGpFk7gabX?=
 =?us-ascii?Q?kRRGa0rxIE3j9D4xkm4Hy4sUStYiFi0dDRFlo33dQZf3Rdr/Iz6iOX2cCmsn?=
 =?us-ascii?Q?3aQFwQgc0NSHg4W5M+0Tw8G9+jUq7gT+jkWf03GR6tssuVQ3mwpk2XUj3SAK?=
 =?us-ascii?Q?eY/4CbiacFmiLEsA2nrhCR5vZ1oEC33KJgnsPLi8d7v6T5YDVmiWgy+GcqI+?=
 =?us-ascii?Q?eOEllGntbJoftVXm6fJnv8Dy31guPR/eIo31YXjBUDbMpvTz/s26R1sRxmln?=
 =?us-ascii?Q?oFQQS1638GUbQtc86Xulk1ooGtbWh2wpmCMmzekh1rMjmcX4AGX8eKjtg4GC?=
 =?us-ascii?Q?TtrupfEIdXziuAdawaZWvY258JBihhExJ94aq9YZ10qWY3UobeUrro8xATBJ?=
 =?us-ascii?Q?hytDFlfc98jFHkx6fr4YSDrTQi8LLvRfJxk6a8AeFxPIxFF8f5ZaRBWQfHyH?=
 =?us-ascii?Q?CyDT43GYQ8pPEqiu1xdhIjRZ3rSaPn0RvHgr7JzEsypej5WybhEPrgK9AXem?=
 =?us-ascii?Q?pgyNww2WkeBrQfuGEzvue0oI4vzwgz32ZDuqz00VgnDDXuW6LPdx4G4LJ9sL?=
 =?us-ascii?Q?4ar2gR51dOsYQpXCywymZY3dVwdQNsxfsoPDZUdCWeH455rQKkOVZWkNtyJL?=
 =?us-ascii?Q?kimFBG4Q7caeOuBgNcHaDh3xVYG8Df9KDQHGWuEeYEIH+aJbxcecTFDTwOa4?=
 =?us-ascii?Q?thq7U+LrlU3k/YHGCtuC+zydUdFA/fQ6X/cKNvlYWxDSAYt1kOpJJxpCtYN0?=
 =?us-ascii?Q?EbG6P942IuS4DgoIhJNyAuou0aODmKTL+tk4zJjFFbBk5mwzoyqijh6vC57S?=
 =?us-ascii?Q?X52O/m3yu1Z9SijaYbLazLTX3nSdV0BkK/E66xj3y0ZseP4R3/EVmFZVUbnd?=
 =?us-ascii?Q?7rYt4Or5lmGOL0ny1oLyFKuVvlFW8JYy3dI7ERmhppm3MzzDbNeagQrFYCrK?=
 =?us-ascii?Q?vg3DKVEj4DiBV8VGmETG0Qrcysty0fSkJCV4lQBa3NM5pS6noTc1q7WPuYOD?=
 =?us-ascii?Q?r33BtQX5dzM6mry4faDRDprSc9XTMorD+DDc9mQAp8R0dYwwmoGUxclrMLHa?=
 =?us-ascii?Q?+8JvUz1VVeOKlFB7Jw6wiWpEgXwPOskEfUdf3RtQpmZ/N8EY2qVFyjJObtFm?=
 =?us-ascii?Q?W+leT1bDSrSmSvaV3Mq08C5udtcvG0+UxhYt9+WrCapu26tiKBrADQQbDQsc?=
 =?us-ascii?Q?AQaHEJoTq+PPpoR2m+5IaEsSLQMEmvfmDhjmsvXQKq3DR7CsAoAMmXK4oUUR?=
 =?us-ascii?Q?hQAn2wZoXFhPac3BDK8s3hLJeVNdNk3TLZoX5RX7ENyuovRBlCkqewTIukgD?=
 =?us-ascii?Q?M4msXeHDX6g4R4Ve1oNKoQJ/ntkNirCXS94omXthBOAerKpj8Yzi89S7qUD2?=
 =?us-ascii?Q?InU/6Fle7f2loCeuu0MV7IX9eIJWtgSUMQy+0HdN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbc4279-2f3b-4336-2408-08da811a2856
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 13:04:17.3543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ER/k2LrFuSte8TzmPMAuUAP4FF8HiYQwn3FDT8MXnTRCXrKFIdTLgI8pOOlcVxNI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3172
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 17, 2022 at 09:20:15AM +0800, Lu Baolu wrote:
> Some configurations of the PCI fabric will route device originated TLP
> packets based on the memory addresses. These configurations are
> incompatible with PASID as the PASID packets form a distinct address
> space. For instance, any configuration where switches are present
> without ACS enabled is incompatible.
> 
> This enhances the pci_enable_pasid() interface by requiring the ACS to
> support Source Validation, Request Redirection, Completer Redirection,
> and Upstream Forwarding. This effectively means that devices cannot
> spoof their requester ID, requests and completions cannot be redirected,
> and all transactions are forwarded upstream, even as it passes through a
> bridge where the target device is downstream.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/pci/ats.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index c967ad6e2626..0715e48e7973 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -382,6 +382,11 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
>  	if (!pasid)
>  		return -EINVAL;
>  
> +	if (!pci_acs_path_enabled(pdev, NULL,
> +				  PCI_ACS_SV | PCI_ACS_RR |
> +				  PCI_ACS_CR | PCI_ACS_UF))

I think we only need RR and UF here?

Source Validation causes the switch to validate the requestor RID in
each TLP which has nothing to do with address based routing

Completion Redirect changes how RID routing works, and has nothing to
do with address based routing.

Yes, both of those are usually set for virtualization scenarios but we
shouldn't check it here as a basic requirement to enable PASID.

Jason
