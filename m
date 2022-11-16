Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CAD62C6EE
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 18:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbiKPRzV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 12:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbiKPRzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 12:55:16 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C98761B85;
        Wed, 16 Nov 2022 09:55:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+u2IjXXBGA3BSb4z21GqqG94zKb91iC86ZCGrJUjTHXkGhYL0LPlINGy6NshCNRQZ5E8FNJ1IJFwZIwUIPglEGH1P3clBMAd2ZXmtQVgE4LMqedD5GgLZoi1b0Z09ZfEP84+oVdnvMAgHZerHzu1telLI+Xyi3zgIIbbKUbShp3vrktq57RpYOLK1jh5vpdxQaAqaZ7oNiDWje26fiDM5UvP+Uq8vFO8hRYnzVyvoerikahl9ajcvgGiMgpZ5W24QRZQ5FdR4CJWrWTdPoPKi9I9vR8pPJSYffNdFqca6BCKxGgN29vKF+paATNm+xztV2NRRQDDQb0zi7navXUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhatKLz74FrY9w7mpa42VUj1UORwop18O/usowy+doo=;
 b=CdyionKAjXxiFFX7VuHB+Iid/dL0li08UNFvLNvCTMakY7c/Op+PGY43kIClKzGIOE5ojgAl4+OvNEglR+wSkq0yqwJj1epU3DdCSirSzC1p9jOVPRvthuB/NMIj8TpXoyFAEaSGQ3JZbSmMqS3rVG4jrLcnxKmkH+TuepyttCiA8YEAPJD3k8BVhK0OJvdW8gClE6SffZYHaU3jKdD86m4mihODP5s8IakqF1MtfBG7c5Ixj36CzpBe2JLKLWVnjZ2YcRiVOnm1hv9wqMwliYMjAj7aZT0X9+aT1eEctK3RC52xzbe9DCA2ztl0SAsz8MmLBZoEtUsgIHypn//nRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhatKLz74FrY9w7mpa42VUj1UORwop18O/usowy+doo=;
 b=ShEPFWuRLFv/sVOs6HDj+hxCcQY1oV04LsUcLOe55IVkVTKrymTmJsl8fRtDGxtZ898fEikRMvD4v+oHJ9LN3lNmtZvLkmslASjclsfgX6XYwGXMyLdG1fxrh1p4SCGWWyuLmIq5SCO9dP2rfc7d3bOOmrn6EFp3/kWX0K8ShEW81sKa3cqQG/Fr9b8JzOCzqUbehm+D1ApTpsjLDhxk4ea6JG/iOl0weC07TQTwXwMOAWcaA2TBuQhFvouqCITd/UJTgwBadEsoGez4HayU/g4g7eQPHjstNQFBWvUwHats96xCjT4yVOt9Uu4E0af2NSQMw2RPjHoSdHzScsUNuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 17:55:09 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 17:55:09 +0000
Date:   Wed, 16 Nov 2022 13:55:08 -0400
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
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch 18/39] PCI/MSI: Move mask and unmask helpers to msi.h
Message-ID: <Y3Uj/L7fWkSvDi3f@nvidia.com>
References: <20221111120501.026511281@linutronix.de>
 <20221111122014.640052354@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111122014.640052354@linutronix.de>
X-ClientProxiedBy: YT4P288CA0014.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b3da43-a37e-4940-839c-08dac7fbb3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: niZ6RlljTPFi+CUtiFNpBBwZImbz+qJGRAAa8C0KuE0PQZyC8zP5uKs831COiB8aZtkk1MtaUmKUhGMwPWvYELA50/sijEXJtf0z7USFeQqCJckxyvHr9asW/p+NgM+hw8X/aiwJG1Fo979Y45On9jS13hCoKbp74UgNiHMR3pXyZzSKVywK7Li1N6CEf3m78zgoX7ooV/Jwb7BG1wZReZPynwt5t58UybYhXTHsm3rtRjBlew4h+iJI1qL+t4jl6BIWyPkU2V1OVagpz8nmb/ottzVkEhKdTi752Hz1A5RYsjSBitfowFW7o41uRZE0+ntJUfY5Mve/ATepMt9RkGH7MCdhvWli4H0jxjr720ccb2OilcHlVeo3uT6cEp8F7h5UsAIKcGgFylc2Fw3KOWVC5uxlue8wjD0f8I7F+S1ArN52GLTp47rZJBw+e3/Mn2VO46YReZZlpDvSW0kiceiFWQKTtJJipmiESFgzMlVBIgMfsVvUAisKkoU+M++Dq8EZ7m3liR0oEJaLPsFOX/hV+grQ6HQZSmrnoxSR1iPvktMaJ70cB1DXOb8xWKCXygSmf/Eza4QsN4LrLbQ9NQyDLuReMM6QFR6Tk9kKZDs6nTW2+sMUd3eEpgcg/3oNCYYZXxrAoNWT7ZDNJkQq1p7d1Y3uQLIMiZHY0P4/iB/1rPpR6f38ANmepj2CVJbZPmF3wDfB1GHkhXlLUwAhEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199015)(38100700002)(86362001)(6486002)(5660300002)(478600001)(41300700001)(6506007)(8936002)(7416002)(4326008)(66476007)(316002)(66556008)(8676002)(66946007)(4744005)(6916009)(54906003)(186003)(2616005)(83380400001)(2906002)(6512007)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Od8AltB29hGi3eHcgcbL/VpDco9K774hv6sHDUg1b2wXhVGpMp0uJ1haOu+a?=
 =?us-ascii?Q?bfgmH+x7ROaAEnAOr/4ORfMnRYReZH/67JU1MdA9lFfy8icimV71z9R/V6Bd?=
 =?us-ascii?Q?iW/Ldzm4EDnPH43VSpSrsRtNrrRSZu9FsYDtujqAq2uqKHBndGldfY6cdSCv?=
 =?us-ascii?Q?7dxyGoYgUYu0xXvJiw9xM5z3qdozBDq0FTR/ynxYtMprIUzWvnQRPeSvKPvE?=
 =?us-ascii?Q?JH2EkEy4AZc3GsrkmxgjvaTc3GppApDek1HaSycrEepeyCqBgXADf0ZYhBW6?=
 =?us-ascii?Q?8xKRT8E3IKVqVM1CpYuYFyoeij+vW57p45jDdJ1raEy9T+Edf29yO2bdPeeC?=
 =?us-ascii?Q?aFrOCeMsJZYM4Y6+DcT65DyQSrfY2VDJjfOfLZGjG7FTAMahOqYecVpMiUmT?=
 =?us-ascii?Q?VSp2bTwrUKg8Pfp630rdiLDPBNsY7ggWQSAs+xVJnERNduwP0EzMkR5YF7nT?=
 =?us-ascii?Q?nyWERsJBARh6ZC5Yh/7ub+7GNn7ptH0iZdT8uWYvV/PxnoSjXhhPdMksna69?=
 =?us-ascii?Q?10IfKCXrrRlLmBwfMJAKT69pJ8M1HbhYRUMrgvNBl1vAs/DXFexFH/WjsM3c?=
 =?us-ascii?Q?IGgmFj8ERl3SLqkhGiuVQLQHceudD8ws9+vscV/NYAwWMHL1+/39/xBEvFsf?=
 =?us-ascii?Q?ILt6UOc3SF/zZOuA5XOrcNCoVyxFl6fQT9fYNY+tJ3yhqn7dka0WIfBCVnpC?=
 =?us-ascii?Q?ofT9G7K9gM9gfXSvnL5WNZpfz12wKowDWouiXmr7Ld+UNUY3qNBIMjE6wcR2?=
 =?us-ascii?Q?xvLlhoreeyeN7vYkwYWYFE+hl3RgK8yV4nYUqBfHvXwau5Sqknd0vnQWLcMS?=
 =?us-ascii?Q?kVsm3oJ+Yo7CUyO2x+FzbBQJoMptEsksFxRJmIhHRL4ysORmYvKQQaUebK1F?=
 =?us-ascii?Q?arALLzOVTrWZE1YAKoLVCgzybrY0ID5gD/IP/EaTL+xartLcANYz1cwKoiK7?=
 =?us-ascii?Q?9N2PwDsmoaZoZfvs8kuYJUs2CGwcpkFGnCaSbnEhc5vuJraHRVfHu2QNvY0t?=
 =?us-ascii?Q?ehdEgi7uF73S2tNRzmMJMgUHBFZQ0I9At813Gc9ftb2WVUpBo99tK0+sZwWU?=
 =?us-ascii?Q?1PBRZ18hoBtMzMQ/Jo18mVXbEVkHZcANaNzyFUw4euxl4bQtXjzfUKw2BIai?=
 =?us-ascii?Q?WiRpUOMCKjYkmvhOmfp0GPswqgpGU0q3jYowVXDRdCzugkkwiK6HHMvRzA9z?=
 =?us-ascii?Q?EDbZFh+sXtlH0IWS22Os7snWh+7rh4y/kNmEONPr9YRKxWBd1NVHqn7478Vb?=
 =?us-ascii?Q?6TNoEQInVQTBJvamNb1Nf0vsVbqgXBtDLcjnpaJbrtp1pTHPbZEjdKxuAkr6?=
 =?us-ascii?Q?K/Qf04vTKFLPovoZH+lJrnFTHozJduu8kiIe/mdS2u07ltni6szvNoalFgJr?=
 =?us-ascii?Q?Xw6JeQd8Epi7C1490RnCj9AI5k4KcJUsPG9GwRCXW2sAK9jJUBsWsKuYcgGO?=
 =?us-ascii?Q?F0D9FbpthB18oCvjnHljYByNzCVzRdV805QZ7e6SktlxFro++iVWJT8nDhmf?=
 =?us-ascii?Q?RMT2zqKWnyKc1Js6NnZzgMLJUW48rs8SWpbUuT2N//eGrttL5ZA5flNQMqjH?=
 =?us-ascii?Q?DKbn03VfImaEsqhTL+ZXEKEfOZtOHNdGyP0r/peO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b3da43-a37e-4940-839c-08dac7fbb3ea
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 17:55:09.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M7n+5oFe9rLU3sdWTKmvhFjJIsCzTJr/6KX0lRi2ru0g5IoEJaxhhhvsUbrJ2SOB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:54:43PM +0100, Thomas Gleixner wrote:
> From: Ahmed S. Darwish <darwi@linutronix.de>
> 
> The upcoming support for per device MSI interrupt domains needs to share
> some of the inline helpers with the MSI implementation.
> 
> Move them to the header file.
> 
> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> ---
>  drivers/pci/msi/msi.c | 61 +--------------------------------------
>  drivers/pci/msi/msi.h | 83 +++++++++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 74 insertions(+), 70 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
