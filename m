Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C666379BD
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 14:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiKXNOG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 08:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKXNOF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 08:14:05 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE49ED5E6;
        Thu, 24 Nov 2022 05:14:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAoPMqu5QhARnQhx5fhUNy0qmWwFXExVAfzEsyTSmEynRkk4SbFBMKoo30vAJNnx9LW+r/ciT3aq6HfzMzNvrHmsMm5vw8+GTP20Vl1AfUQNxFeHiEPQbylpIwNcY8Gw7nEBuUt/SyUlhC1i14GirWI8eASde89QY866UkvJuSvlJk8gayfegLCYxii4R77KTnz6XwVFH3nBupdPru9RZT6zy8OeUNmlt9rpKd2LwZgLMDo1GiW5xMPYhooj8cY6JDlj+4LvfZ03y4mGOk4WdtAJXunsFUFvSFyAfa5tItWQ1zNKSoL82WHQH2Mouovz3QXCK5Hx1mMycj7KwqHtPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWbeVANu+D+RkEeZQ9hVif9DvrLqmpj6J9qPL3nzdLE=;
 b=YfGJ5nExinZ6Y9PmIpfGE6my6/4/ci+mmTQy5kqFuM88GlYMsAn2G2F8z4FkP7YUqxWTYGDXEVbbntkkplC+Fsnx9HvtkhG96+rTrTLWvKYAOT90XC1/srSkKGAJ+2VPdkMH3GgE0mUgxElXN+q2O9ltSFndCcMz1Pa26xJWN9dVJqTtTIL6W/oIQSCk3f+ZYTQoKRktbvC9g2p5Wb7uyh4ao8QZ73nuoPO8yb0/mM/ss7vf7ViBdQJESjlAbUI+c3KC9Hx4X6ZZgNLENWwRKt1iDqLZvas+2G8rOZHGv4vY3LcKjJ5YIYIte/kFi0sC6tKFg/kQJkrFUPPbGq9Gzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWbeVANu+D+RkEeZQ9hVif9DvrLqmpj6J9qPL3nzdLE=;
 b=hlBgShvFAyuG1YZb9uYz77DgfbT3F2V5YwNb7n813TVpK/KKSSPNG+1hh8o9Jv1k40NXUge1goM2p7P0Eq6Gyqwq60KjWScdvPPwfXHdoUy4ZUsgVmscXs9L3WmfYpFFuuitm/UCMCdHUgRRfi3XTQlsfnHT7jP2+OuIoPHwLP1Ig1Jm95w91Y8Jywsg3gVcUduMFSsfEKNg+/mA97WXdfhqNE46nKLWFkp23RLS0G2htpnZmWSlzFYWdDThhjGPEFLc/SahQhZHjmYsqEIlVbSQMBp9GjAXylVwbHIBvpVQPl9K/TWYEEoGpINCm8h8LSEXwN9JeHIL/DtsQxhOKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 13:14:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 13:14:02 +0000
Date:   Thu, 24 Nov 2022 09:14:01 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [patch V2 31/33] iommu/vt-d: Enable PCI/IMS
Message-ID: <Y39uGVLrH3MvOoZ4@nvidia.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091328.184455059@linutronix.de>
 <BN9PR11MB527650A018BE7BF422BDA2F58C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87ilj4d766.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ilj4d766.ffs@tglx>
X-ClientProxiedBy: BL1PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5142:EE_
X-MS-Office365-Filtering-Correlation-Id: 2712f89b-63b2-428f-6f2c-08dace1dc149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9J5W/VmHlnTT6TxV7/rvIaP8wdcyjDRyPXrnrU6sgzWjR8eF0vtTSvtMKN60ttWVQGXsw6m3P553vLQVKigx+hSgJSZdij6a2QW1JKHRBC2vQEKXt4nzFsx6hqk+fK3PCYh+umnlBzt5eF2X+NgbyTBYvT/kGLdr/QRYSelFonflCRQMRynmp0LEitkKMWN5ljAo4GNAHz2UP2VJGteEGabDZrAz3Ke38sR301L4eEiB/RoLCKRLeAMQD/jZcUnh7ovLs51qI2r6VlcgERd01lTZo32Uv3tMozROylspLG4X/W6zk8rQw+QWvAYcwWUQQR+TMBcvM1Sm3jdN8yd7EbVMeBIaf0Hz/q9CjGfdI9bJJIys/GUbV/MMmzisCtMmciEB/fYY4j938iYajrnlo24gBDk+Ck9eorqgtynviDv8UEpOHqAtHYOL+FUA4krdL2KyGXfohL0fq+2F4k+S+N5BLBjj8AupI63scp0ykyDOdTfXX8Gk8vozB8KFCIVq1NwxVL5bfjG1C1khqzquRD9n5t9az0MZTiatTf+3FhVRz334rRNY5emGChUgc3MuTXW2h3aXEOq5qNJBxrPP39SXo5GJz0glupLedMt233tz69qIudWKKPJPBuFmLeH3PxcwNHoenDo77ZUe0BUTRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199015)(38100700002)(8676002)(66556008)(66476007)(4326008)(6916009)(66946007)(316002)(7416002)(54906003)(5660300002)(2906002)(186003)(41300700001)(8936002)(6486002)(83380400001)(6506007)(478600001)(86362001)(2616005)(26005)(6512007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s067qMdLivrf4a8BQ6WrF8pzGZtFOCGvAKrkRIyNctvGBOwAA30LqdKfWwNj?=
 =?us-ascii?Q?/PmO24ABJEZCPvedF6loXf6RthDAuT6WELM0pU+IGIuvZBHj1CoogvRRehFv?=
 =?us-ascii?Q?FaZ9mclw1G6/TRo77uvCwlOj+elDQIk5/GW4L1NnhNoTnZnGDWgBLL00jm/1?=
 =?us-ascii?Q?Puw1sckXgV1EBp2rIBZY/XP6cFQTE2bnfq3hDYGa44//fMas67QkzKH04ayM?=
 =?us-ascii?Q?SUqG3CdCWQWdU9ztmgSamcE48li37jBMW/RxaI6OOUticuNiivEcK1/zFvKH?=
 =?us-ascii?Q?JRh+vbXTEKsZw3RGiCkC6Oew/TwLNgkGK7Kp3MZCwR6q7iahlwt3HzZ3XBue?=
 =?us-ascii?Q?qOPX/RDRtBPdWfjZT+bTErSO8h2muPtO23l4TZTbNr4sxwIGlD415O+Oggas?=
 =?us-ascii?Q?NSdlN9py/jDzibPZJvg7hqiCDtvC9/MUtqIsvPZi3/TV+71bkg9sDYegBT3Z?=
 =?us-ascii?Q?hkE2HAgVSa8fvGUqYO5R11I/7W815TzJuYWMlfLNrsXZQ+9VddS75reIKuvH?=
 =?us-ascii?Q?Bq7kkfjb31bUdOS8kXGNHwwdtlmwLD98/VfAz+IIqqoNv1ANAKE74qYz53St?=
 =?us-ascii?Q?IYjzxHuizhoXRWmQbhlnFPGysnftYMmxyfFiuogKdmX9die3wxVIJzYWHjD3?=
 =?us-ascii?Q?1/ZQOW7TY1CCzkg2VhF2qBpEEDS8xbiS6OZnytA4JftXEvqqzYRkyDGHGwCr?=
 =?us-ascii?Q?L+83SB4kX1RaOzIvGwV/ZEUeIdhfIqLII9FxX2/ny/T5rSDJ19+xc8EH4JeZ?=
 =?us-ascii?Q?Zt5Dv1BGRdPy2e/DoVpDL35oZmnt3fFQGSYcCDW7FkDKEZyxVsSGBlL8K+xv?=
 =?us-ascii?Q?BJl9FZ8YP6eBUCvlGRaJr9XKAVTFkD3k+xDXfBFKVOQ8BSqjbnJQFhXsJphT?=
 =?us-ascii?Q?r7Updcn59Hn9RUyE9tq3F58v0EE65tZNt89R4gFstmYNAb7dSaXwdeUiDQeD?=
 =?us-ascii?Q?EW3drFN+9JnmElmk2BFxDobfglmsIj5DjASVzHnGNiMed8QN0HvPLEGsUnIt?=
 =?us-ascii?Q?1dUbcz6F43RW3VD4GdYNdCjTl3HVwanQv44O5InjqtRkBWq1o2bRz4TGBV+l?=
 =?us-ascii?Q?Mgl2porAC6+juCnQHNiSmPIJf2Rt5tZxq2yg98qp8dCkiPHiInWto9/oZVQf?=
 =?us-ascii?Q?I/CKeCUI4Iqnthpf11Dm2UgTZzcJdM7Hx5A1d/RDDQH9cmqEZlSZZF7anF0Z?=
 =?us-ascii?Q?gVQTyNHN32W7msoQ3eiMCmjA/Zcx/pQY7qk81E2kZoo4ZVNH/fz6/QTzKrR2?=
 =?us-ascii?Q?Q90QEJwYah7NlCJ3RY/bfsLTSBeWXCDt9k6y1HmVyUmY9dFC2MdHzSEw+lVe?=
 =?us-ascii?Q?MsVwp4nV+HnfGweZzP8HqPbXt5MJPnoOo6s1RMyTdBMYToyBIyWwq5nG4Ho/?=
 =?us-ascii?Q?IUCn475tVqxcwGWFjH8BSi/OGK09kFEE7wOvfQdZ1MDc7um/ElhYLSVMXWhH?=
 =?us-ascii?Q?hSk7A7mAdvM4vVDVU3ZNNGpODTc/EYDWysso8yvMxSrlTRst6qroA5/QPaot?=
 =?us-ascii?Q?+oTD+wB+yJtoIYbmGygSO2QaJUXcuX5lIRfsXZcO9z5p46VOFo0TFeSa5LGv?=
 =?us-ascii?Q?qHeKIb9rQMH7sY4nKPg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2712f89b-63b2-428f-6f2c-08dace1dc149
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 13:14:01.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zn5OORegGdyXPT5kTUygI25PQOzOeDYHyPmYAFLcVLa2A5TJE8lLCHoTesvq6uAI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 24, 2022 at 10:37:53AM +0100, Thomas Gleixner wrote:
> On Thu, Nov 24 2022 at 03:17, Kevin Tian wrote:
> >>  static const struct msi_parent_ops dmar_msi_parent_ops = {
> >> -	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
> >> MSI_FLAG_MULTI_PCI_MSI,
> >> +	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED |
> >> +				  MSI_FLAG_MULTI_PCI_MSI |
> >> +				  MSI_FLAG_PCI_IMS,
> >>  	.prefix			= "IR-",
> >>  	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
> >>  };
> >
> > vIR is already available on vIOMMU today [1].
> >
> > Fortunately both intel/amd IOMMU has a way to detect whether it's a vIOMMU.
> >
> > For intel it's cap_caching_mode().
> >
> > For AMD it's amd_iommu_np_cache.
> >
> > Then MSI_FLAG_PCI_IMS should be set only on physical IOMMU.
> 
> Ok. Let me fix that then.
> 
> But that made me read back some more.
> 
> Jason said, that the envisioned Mellanox use case does not depend on the
> IOMMU because the card itself has one which takes care of the
> protections.

Right, but that doesn't mean we need the physical iommu turned
off. Setting the mlx pci device to identity mode is usually enough to
get back to full performance.

> How are we going to resolve that dilemma?

The outcome is we don't have a strategy right now to make IMS work in
VMs. This series is all about making it work on physical machines,
that has to be a good first step.

I'm hoping the OCP work stream on SIOV will tackle how to fix the
interrupt problems. Some of the ideas I've seen could be formed into
something that would work in a VM.

Jason
