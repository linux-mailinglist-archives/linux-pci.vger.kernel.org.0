Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D479A62C917
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 20:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiKPTk6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 14:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiKPTk5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 14:40:57 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F401183B8;
        Wed, 16 Nov 2022 11:40:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTz/3KlQTlfRJ0CPsvRegnhJxL71fWPpABonA6d645i4ZILyia4BL0ixp16Ug5WpDRktiVek2BMf8bd31E8mHFDdUTvJukeMghhpJvZTCwuMHhdb+HxZ+DynmM6mhr66ZcaFW3Rw6LnONHrYzRcsbJe6d8AVlQVvmU7cbE2e9RsX4S1n+mJm11ztFL8UpNJLyUnhUFEdNUi8CWmS8FHG2B6+Q6Rn0reHVAv9fzTpJPtsgevLGHLlyOARGVZY88vJ7rgqIK9dktfgGeM6sFEngh0IpUER9Yda2k6+otSwun4cA2yPILNaOI+31CGaZp7lm9ftUyu+J3oEjUQd/aBHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/pX60NupHqrYTvL5qQ7mGBXmjNFEEH3xaQEGirgFzE=;
 b=SO0L0w3GTx2ruRCgI3LYfWl3gyECG05E5atKuBtNG16Daca2okj/e6Ld2oJcF15FpZiNlu/N46W523JP/irxg0WFqx0PwWfylPrthds1Ojg1rNpviKepUXqjRUc68WFWeoB+SbU7xRuHDA6hnpv5oOh+ut1rL0kXXq7Q01xvFcFFbykPj+9n+dXFo/sgBibvXS88kztbRjgRsVhobFs4WN2mMM5Aysx2+snO3iAEQmLeUlEYRhz9JxbvS/n9PQRrMvi9mQn7wznHI12J80Hgr7DcmEQUng5uqQrqh5Jxx2OAA1Bo3/Iw2cqxQezNLzbGvhgnwlQvFR+pclPQx1Z1Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/pX60NupHqrYTvL5qQ7mGBXmjNFEEH3xaQEGirgFzE=;
 b=ljt3JRcNqycdz2ADuvEMEkRYWCNm3wEY0T8uPmYIWkuCSkoQLMH/fJw+i9xJ6Ap5v/mweRMACSnuZvfDdRtSBd59uk5DGeCLNB/FVt4GSMDK0QKuVoOyzj9924FqpWZKYZBI1mdalXq6YVKtdqHPw34olmlNkonG6Xsd8OIZ04/lY2NDWmvGAiYMSVcdC2/2JgcJfV5ONxRLaQwJ39EP94TJvJHrRYILynTDaOEOegoZa+xy0vd2oGtfR4LzQA05urt4K9wEeLxGnI9yvUsx7VUGtP3/YT9LbnlZIn9j4HE27xtNjep+ZGX4umwEScB15eRx2GsWE7uyvMPOWVNnWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 19:40:54 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 19:40:54 +0000
Date:   Wed, 16 Nov 2022 15:40:53 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 24/33] PCI/MSI: Provide prepare_desc() MSI domain op
Message-ID: <Y3U8xT+tF1IR7OF8@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.632756918@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111135206.632756918@linutronix.de>
X-ClientProxiedBy: YT3PR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea7a309-9ddc-4419-e663-08dac80a799b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQY42IpupYEozmLxTf582xUMQSMv5J3U2B7aLZp2/IvwnaKq7wmuQl7H6f1ozZsZbVysAoB6vtRG9UfLMP83lum1iaUElMcNsmpyBwwCetJzD1IIN7In8PfBAykE8xbj/C362GaQpQfKgmFIOWIGvGqgEx42+WVIHZ/AmTTBRuKjQWQdzroMHql5LN2sAPdKwUtyi8K3PpQbwqdWhMOo46c5hv/kiNkfel20KoNqPXRb2U5pbIOmaoQhjyL0d+Exrmjjn7HUMwpd8+2SElIbLna0do6dlJxzYE+WYrDe84oyVqhR3v2jVADmBKxleyNHEctu3c7ozqe+nJXQPoM4gxFhyWvC/WKh3JOIAx/osUSCQyOGwq2Y5jfB1BRnP/7nzel6C24/WekrhyPayO+JtScvFVeVvZRDNadQQX8aotUB3tEBIZ9yfXe/f71HVZaEb4WH4mgfQ6UZ1VRd4LKXzMQgdYrhnsa55NhWPirdQr7zUl7XkF02bJG0LwPQFJFGZHuwJkR/VfKV8lxDl4xwkbmTPvmejMvlAbAIQ1G1p5cyot/T/etS00ybdyeR1mSaHagnsFubEaXxiXEguJygKWFU/U50P6jiYlPQ1D/dMNgNI13vglkkfgwVZXQiVwKfkWjH0J/Y7G1yREUoMT+ae6PrMh5sHW/l+Sc4BW/n+6fqGAW/oyUc9qUpmzv/srl466IoixVHCe87OblCgSNgRf7GBOVR4teycoxx8vd0/FDxY8HlVPl1gwDR2dPlqtBK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199015)(86362001)(66476007)(38100700002)(478600001)(6486002)(66946007)(8676002)(6506007)(41300700001)(4326008)(66556008)(54906003)(2616005)(316002)(6916009)(186003)(6512007)(26005)(7416002)(8936002)(5660300002)(2906002)(36756003)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UQ8YRYGJAGiEEnETUC3QXSR1XGrugGRK9BSor9qbooFhDYz3C6F/xoAUTlYZ?=
 =?us-ascii?Q?l5WJk/R8DIVMcahMd+hvkTC7c21EHkdG6gAFpEMYMWygJg/NOx4+7S+10WhV?=
 =?us-ascii?Q?EzHj2FLdP2rCFTwhVt9UyZXyTfqUDvkK/K3AmllJ6XLXf7IlG1Mx6/BfwlTf?=
 =?us-ascii?Q?F7a0laYgUJ0X5xWkdw6YVCav2afuWsKvWeJGp0MBrpheo9ZxXp/6pXsXiKvF?=
 =?us-ascii?Q?q92JQojOoESthSh7xpdJzDCXQPEC6y7i1yVV2zbZN1MqtYEOO3cgwUku23qk?=
 =?us-ascii?Q?/F+076xxILwcXnz+0srDyDKpF+xLBNTIO8qTQqaORnM2r1vcrZGPBYDQs7mF?=
 =?us-ascii?Q?RTPTvx7fWVxQ1oaFeQuWtWiFH90RdV7fkKjLeL6ha009uxNX+voM0KI08AvW?=
 =?us-ascii?Q?kbAxED9XyQnUJ02h8rLAWI5pwjeX2DdVVUQtznYlx3njxaG8N4dpYtnB+ZVa?=
 =?us-ascii?Q?/eLQZ3eWf8EFc0gVxT7slmlrG29r//2rHit9y7NLcJ4CdCbeO43FJcT/Mq4R?=
 =?us-ascii?Q?6GF3nKCKpf6vorX+oR0GVU3a0Xs1G2sbnLMu1f0Pdh4l/H+iwV39QuG/KP3w?=
 =?us-ascii?Q?/8WVdit2hqN1i7erfa8AKjQNpF4KWdO27loh3dWCllikNWwI+zEGAB9eQOLC?=
 =?us-ascii?Q?QBAgRMBkQEPefuR4H/j74kxLZjHvFroXnlqESgvOSNCPUTUzPKkhrLE9BL3F?=
 =?us-ascii?Q?3hepZcwuHGyeQFQHbxWDEsNzf4wZwMc/LPUNTbIPYk8WL/1QWI6A0boQ8UvX?=
 =?us-ascii?Q?sbRuMcCicNZ0E7UIGOd2frMMW38wy0gfp5YtlKgl5rtdlu4LJ/ZVL+aKXNpI?=
 =?us-ascii?Q?fPPY5iF2J6UJnlbhRkTpvhsRN+pQhbt3sdUD6ZMiUteYybda3vjA0CC+KYZj?=
 =?us-ascii?Q?RPh9okxnl9/2rZgwugqRzcZupZxoifehcv66QcUFHRJmd5dlNWM1qhV+bZ16?=
 =?us-ascii?Q?gtFL/spBqEDZrQjuuP0BSRTKP8DyxI1sOhkoux10yJUos8lvNZMlgAjccFzF?=
 =?us-ascii?Q?Zo1TEuOO9hmpCIWwM7KS3Y7eoCbhzHe3qyRxahDFlGy5jEEnw8B9JpCoTAsn?=
 =?us-ascii?Q?YpvYWgBsCxkzj5axIgAj88/bOa3hhAV/dP+fDPGLuhJHWGL+5KHYHZHG+7af?=
 =?us-ascii?Q?IX+XxNbmSjUs1+eiGBXcgoPY+fVsnWEWugMYN9OYJ9EmDkYhOL9e9Im46QjM?=
 =?us-ascii?Q?rwoIszo4U/4Nw/TTiiaTXdfAGPzk4+djGlAgFgiJ0vGvUaq1gnVnbFoyQWny?=
 =?us-ascii?Q?ODC8RMrUYypq5mIdRJAHNe28zaQTawX9trMsWDg6DetjUVU3iJmulC06D73z?=
 =?us-ascii?Q?e9fZGeqY+D72oCCQTI7grRvIdFbnNNyJorkYECnm+rufN8booa/+4x8fx3GB?=
 =?us-ascii?Q?Dj4BGhyiAVaUooNjABwVj9vawokddaqK+whujJVhmnCeFpTcfpCMvw0EVm1I?=
 =?us-ascii?Q?HRyjK462sJRKVO4C0kGN1hYvKIiLRCpdQk5AZPhTAk3k+OGF+fCm8Hop301w?=
 =?us-ascii?Q?tE1qtcS8SZAGMOu76C/bo1qhnNdtJnvTWd8wbDhTj6vc8dYEPoEZOG/G94Z8?=
 =?us-ascii?Q?SCZhGcpYnkcIovY1bQpHsedfqKEZd0KwMrH5OiiP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea7a309-9ddc-4419-e663-08dac80a799b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 19:40:54.3397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82H2wGUMfvT6Uocr1DcStbFVyclCOK2s64+qij8T2jFS95cMj6aqKK9iVfzyVG2I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:58:49PM +0100, Thomas Gleixner wrote:
> Dynamic MSI-X vector allocation post MSI-X allows to allocate vectors at a
> given index or at any free index in the available table range. The latter
> requires that the core code selects the index at descriptor allocation time.
> 
> This requires that the PCI/MSI-X specific setup of the MSI-X descriptor,
> which is partially depending on the chosen index happens after allocation.
> 
> Implement the prepare_desc() op in the PCI/MSI-X specific msi_domain_ops
> which is invoked before the core interrupt descriptor and the associated
> Linux interrupt number is allocated. That callback is also provided for the
> upcoming PCI/IMS implementations so the implementation specific interrupt
> domain can do their domain specific initialization of the MSI descriptors.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/pci/msi/irqdomain.c |    9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
