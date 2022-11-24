Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA05E6379B4
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 14:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiKXNJe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 08:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKXNJd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 08:09:33 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E5CC8CB9;
        Thu, 24 Nov 2022 05:09:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLZMyfjeTIBKemPzvyLxc3R2micxHzqOVA8WkhX2BQ1Tevy392n9RTjS/HCvTdv97wQ/1l2L3cCjPGcogin0aN1Q5VOBVV6/5tKQNblBbaM07PBIw2pYoBaipxeyQhZjOzEXRlNimJtsnpyoyh+3cJY2fRBe1/4YmhdepF8zZIul66I/aJx5fNkvc3Qi8stHpSYzAeiqSt7k7wLpgCXEXjXJ+JwmTSubFb93hT8sdXHFHKTXTCNdwgjF4YIH4LQdt9buVGqMiXewk9CA2JPzuG7467QYffhzobhLUBXIv2yng7peLgfdYBQFtowp+ueiGQDmlLq+s3UQ5YInMS2gzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qjDcBSOLHCD4wuUt8NNubavWOcreA0GRvUYdY0V8sZY=;
 b=CgY++px9P5OYH9xO7JZmSSGAzZLfzLZ5BdfQFbn8P2PDoEN0uqVkmznYMKSj1AfXajApzxKh4uTLp/m6ror6LYHVsXzt7f6M2eudUXrIBXdTBFKMU83tnsGIo3i7WxKXN6l7XJYzuNSBfNrIkeIzxVoyW8bSgn6NYaPcdvQYv/jIFZF+S0v32Lsk8ZRQ/7M/BGu53Hs/hkpKf6fCnKNfQ3AbrFMyKdtXN37mL4L9JtOxZOrbWlU6QMAI19oWx70dhPe1wlptOz8f7MCtuqE0/d16Xk1zYQBVwwfFV+xrf8Bom+HCaorMUZ2aDN+10e8CYc7RMsEpLiVDNR2gKdw1Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjDcBSOLHCD4wuUt8NNubavWOcreA0GRvUYdY0V8sZY=;
 b=A+2+cQSzgnc+JRcJCN893cl1sgQLa6ltFoPOysQlX4xnsKAffI7feujnjO7OBjKIkuGy9FnlN/FkauuL8QlYLUuaskj/eE1HJNG+UcCij9rATD5QFKK/ThvHE8s8tUdC6QVFL6LlMKYuZ8aqTsejONLROZjNmKZyg/8mEhJ9pYc+Bka1o93d1GvOQPqPs7NdHA+75I7oyxvxr7R5SXsOdC9lr8rBAEhp4lXuIBAyaGZWbstnHevTcYO4auk0JtJvTA/vv0wy1WPvrLKOw3pAgq8kB0PJe5icCaq2ggRYx5mvsAYSUu5uyJuyKipuRvnWsUTuSQ5E8Te0r6Zxz5gFhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 13:09:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Thu, 24 Nov 2022
 13:09:28 +0000
Date:   Thu, 24 Nov 2022 09:09:28 -0400
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
Subject: Re: [patch V2 27/33] genirq/msi: Provide constants for PCI/IMS
 support
Message-ID: <Y39tCFWB7I/fFEAa@nvidia.com>
References: <20221121083657.157152924@linutronix.de>
 <20221121091327.974140298@linutronix.de>
 <BN9PR11MB5276C9AE570B4CF854F6F5E48C0F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87o7swd8gi.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7swd8gi.ffs@tglx>
X-ClientProxiedBy: BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be4b1f6-e736-473d-d612-08dace1d1e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GaCp+BV6F+ToL28ropaqiHMBGhH6xZ7veXQOhgjQmS/oXpzXYDhCvhNJvfRmz1oP3J4nnVxc2P7EfcPRUk9YA0C82ur7QLNSGQmhQYuRyDV54x7KJn5+z6C0KtERKiLgYkWY53XwpJuW43u5T2R+z+rJjym4BUpJpG3H6DqJ3caKES2T9Tb62lW6k3e0E26cIKaGLPvN2+Pb1mOpzROjWyWnJvmvhLQGJ4x+jTgEbPLp+kngm/7iTnaJwJAv2G1SaXIarE7SK+0hnzGWKHsVPv7BAtzZfiI0hw2X8mFpQudlxPF2epfuXiupt0FHGPO5lY8O4TFRwxtX3JqzbCUtDMoOmIPhsYKs+2Ou1HoiuPLHaU8bNmjzQP/9EFuFTvTbbtbYBmzs7ws3BqqCDCmaN9aOFtrnYJdlQ4VcD9u25dvGEQKTmbJC2jH5bT0AWpE81m52tSpDClYoeWy1wNBReSe0sNuA6oRaHppaEjAqmJ63Th6xWjANVsmMrk5ArYxxvCN71kSCizMgj53JwfMGYW8TcAalnWwcr0qsW60gwxILJjfSwCOyzJr2sIJGGL/9ORgJBuIUZhGf3+hqKPahOpbkuWg3JHIlm6RTnb23m/GIxM1K4Nd43YngOLogvq6CHMkV7LKKREvwohVlEXXrjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(451199015)(36756003)(86362001)(8936002)(5660300002)(4744005)(7416002)(2906002)(26005)(6512007)(186003)(2616005)(38100700002)(478600001)(6486002)(6916009)(41300700001)(316002)(66946007)(54906003)(4326008)(6506007)(66476007)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sPdMgIqWBTw7VB8BzZAxCjMkhIH/B9BKUjoZ24bHrpUJzcMZemcVlyLOkWwB?=
 =?us-ascii?Q?iecO7kqxR5Vd2XTAxaFv7z7Wg810eCRCLn/QtL32fLDP8LeRIqI0e+4Invbr?=
 =?us-ascii?Q?ft0f4tyxYNHlSSQ2QhwLqq6XkTdQPol7d5cjb/0Rn2Yol7ZWogVjfNsmDXRP?=
 =?us-ascii?Q?lgEaWq4SMyzWQcIdaDJe7DLYJThsELKpcSLdzevxLhpx92NA1rDeMMBDWDRe?=
 =?us-ascii?Q?TXPwDw1BLNd6EbG49Z71o0xRgXzx/GLIZdDHGuuv46pUXp/Ilolw/EeLcyQH?=
 =?us-ascii?Q?KZSRTRBu+i+DERBGcat4KeRILD/fbd+842Uve9CN+D79dhvGY2WyvVKh6N8/?=
 =?us-ascii?Q?6l3OgzlEliuI/8EFemod0EGfezlFOW2LI/RBemDBJa86KEWSIahwxc7uJ33+?=
 =?us-ascii?Q?mZ82+c7PVfSZCKomzoBrw/hSC0x4QQY3kr2+0mFS/p0bR1S5rixyhrhvD+gd?=
 =?us-ascii?Q?8jyoLw/wxJYRvqcnPkSVUtQdeltf+SnCwTlebD7/O7s2vLuo/Pimm9l68Xup?=
 =?us-ascii?Q?Y6IM3x3LsxWMFB7uKodC9pR0/L1gRQOWWApQJ2vlaseE0BDZfO1xaYyE/oFM?=
 =?us-ascii?Q?KSc/v4kNdB8mT9PsT9GylTbH8x7u1dco8eWq20QDOk6xunV80cwcOPkhUr72?=
 =?us-ascii?Q?9IuUE1X00h4CtWRWe+nhK2+7sS4Ng2J+gROAYaVIZaZ/gqzvBiU5kzyCWPrZ?=
 =?us-ascii?Q?j+E5qs/C8/j/ql+KpkJfabzop4MNm19VV9mYkKfka65/GNGH0c0N2pkExX6o?=
 =?us-ascii?Q?aL8LhsQYVJGyJRQIu86IViYzPUa23pkQx0zRYtEJJ2L2sLNmZduxtaxkL+/R?=
 =?us-ascii?Q?3+skf9ZPUorvqHbjscB4HsggmJt+ZD8oEtfbbUS6AWBmpVHIBPCXPZExLhza?=
 =?us-ascii?Q?bENiyhM/LhCyrhp4TStevuAHbGjsvzDB9Y0UYku8eVP/WaDRUInVPVSgYYte?=
 =?us-ascii?Q?4sjIEwen8dgIzYgV4i+iLMPV65OscC3qpSH/9t3/Aes26oAAFs/FONFdlr3S?=
 =?us-ascii?Q?6TecPq1+swbOBihzg9o/XrZtTnyfIHlqco6b7+7BDb0ZgE+OvkZtQE5zODOw?=
 =?us-ascii?Q?f585jVzVKB6NOK5IizHx9JJyn74dwqvxRbMDz6XeGEU51m8aNpelBtWifYFQ?=
 =?us-ascii?Q?LTFypd3z2ErNO3BRxA9a2cGecGvB4/4K6/OTHLzleuYoI+/PUiSApEGb0CHb?=
 =?us-ascii?Q?Wz+90ec0VfpHtkSNGZnoPMPOCdxLjXERsCpuzL24C8biEEzeAIV2DXo7IyDd?=
 =?us-ascii?Q?bTIR3ibtGINM3zl0LOCiKsCxYlRQDUZF6f0pEM8X40fnBeAedcQKeFmVI8FU?=
 =?us-ascii?Q?64M5hNTDrbrQBGxWt/qVe60tjF9mlGhNIWqsHE4e2ZC5DWr0hvIEx7APPRiW?=
 =?us-ascii?Q?rywCj1askRY63BTTyS0MrB/IdMOmfNFhdtjSQPKHGugaro8tTFe3mLCH8vQr?=
 =?us-ascii?Q?BvdlntoSziPl3GL6sxTgSjAMRMJ72v6/XKxt87JyiOySUOP+7/U+Ypr2cFJP?=
 =?us-ascii?Q?QkdK97wpyDANpMjo6rgLzPzTIyG+90B2WXfNoQh/FrQIorQfzExdP1fiEAhv?=
 =?us-ascii?Q?8yvFT8wJ3yVRtto1Ge8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be4b1f6-e736-473d-d612-08dace1d1e7b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 13:09:28.8245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0WdkfgJ3bAo366uWUz44dJlvhB3gFuBaLHuiEWhT0CcEcBcFjSRFd4XO9M+g24s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 24, 2022 at 10:10:05AM +0100, Thomas Gleixner wrote:
> On Thu, Nov 24 2022 at 03:01, Kevin Tian wrote:
> >> From: Thomas Gleixner <tglx@linutronix.de>
> >> @@ -15,6 +15,7 @@ struct device;
> >>   */
> >>  enum msi_domain_ids {
> >>  	MSI_DEFAULT_DOMAIN,
> >> +	MSI_SECONDARY_DOMAIN,
> >>  	MSI_MAX_DEVICE_IRQDOMAINS,
> >
> > SECONDARY or be explicit IMS? Are we envisioning non-IMS usages to
> > occupy this slot in the future?
> 
> I'm not really decided on that. Whatever the name or use-case for a
> secondary domain is. Not, that this is not restricted to PCI.

This is hierarchical right? So if a pci_device spawns an
auxiliary_device, its driver could stick a msi domain on the
MSI_DEFAULT_DOMAIN of the aux device as a child of the PCI device's
domain?

I don't know if we need per "ADI" msi domains, but it seems OK to me
to hav have two slots for now and be general about what can go in
those slots

Jason
