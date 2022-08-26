Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BD85A2A25
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 16:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiHZO4s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 10:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237173AbiHZO4q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 10:56:46 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE024D8B3F;
        Fri, 26 Aug 2022 07:56:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWaTLazr9aZafhrarLQIktASzP/5Dln/x7bZnguJe9NQS5IjM2v2XrlyEEr/De+RmFTdpAalBd9f//E4aSYpd9fyM8bMrNRcUDHyMxEODStRzXRpOC1cEEQKM76gW3mNoQrwu9JNag3SYH6xn5P5d9eQq4+aVWpWeAQfkwtX0D37ydMOSYYIk/ALIETwhf0QSR2Mn3Q2GDlGmnF1BsrKlphoCtqYCY1bffCdO3rO1ngo8eoli2mtf+YmvHAdTkzASl7xqbVaQ1s79bDeh37tDaqIX2swejVkrdpthjeTWDo66LiRMThZ//KEDqMQ1lKqyRYyg3fQ8Nw+vvhj6QEMHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BOMPgAD5EWh57y/LPbyjTP4xVJ0pzda2lhjutvFuDRU=;
 b=cJcNjR3Cc7dUeIVhBX0iQFugskeRfJ8d8nePZNWi2RNcWZVBLUfVnbKRezgRGGcvJqdQ1H+hYCnuCpMITo3eF0rogHVLxXxdA8BB0ilMJieadjr4o6RPYb5iH2VdqX1UWiKNgtshNZfLOhCjB+WXrCHA8xAZiTns2CihmILA6HSQ9IaZjGo3g0lgRXJcYNkNnY0Q3ZabbPwVxeSCVpaA+rB3MI7PSUsI+H9C57LhfINClEYVk5pEjdq02WQrUBNSWgxV31G7OFkA7HOJYUovPPhnJexn0xzuGl6EjK4KHm3kndgoELC/87vGl+NaRFv8Ja/BCoxyIzZIeCv7HDfDPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BOMPgAD5EWh57y/LPbyjTP4xVJ0pzda2lhjutvFuDRU=;
 b=Vjz21/oRVT2ZsCQ7OQxMAAmvfShnFJQGoMAaVmVShRDBddUayTR90jFFS0WSTcZHizzU/T6Aw5lf7Yr9porYZqdNDrFrnbt87gh6+lI2WEpgi/A07lzLtM9Q2Hh9qcHPX9E9HJPTeLLl1d0m847VtoMs9wnkWL24dFxzHJJIzDInQBhTXFvWEGo9uqsiFm7WydVGLI8wLzrpJD/qKPeNY68Pu69n2OkpaTSxxbCrkZVCbb+GTK1pwEaiEdKt7/1vJ4QXCFFoKTGrSHC/ZzSwU1uXWKjGTONu4oQdFhMWf2GzMu/htTGi6kvRJc3bIqUM1KIdVy6zeV8eyapYhboE2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB4138.namprd12.prod.outlook.com (2603:10b6:5:220::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 14:56:43 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 14:56:43 +0000
Date:   Fri, 26 Aug 2022 11:56:42 -0300
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
Subject: Re: [PATCH v12 12/17] arm-smmu-v3/sva: Add SVA domain support
Message-ID: <YwjfKsvKyXLdCJ/Z@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-13-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826121141.50743-13-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:207:17::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a153b5e1-1f7b-4acf-c2c5-08da87733087
X-MS-TrafficTypeDiagnostic: DM6PR12MB4138:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+ZJDENMG8WoVwc5iJdMi8brqDgBVqll7Hdujnm+Gb5sslLrLh2UEgGLCfUVrl0y6mhMkZqdXjtojLsX7ITHincYY3793f/0z0xvhAPdZivz0/tviFFAO3jyt7he4Sap3ujPUXZ54lnqeof+y79/zKQrPRWwYQBsZym36NnJrrEbkHFowC8p6TzHZFL0JutX3B67urpkYCqnMWN9CwWGTwZx3rbC9hZMMDbyvWfR1IJbIJeuTgYyBdj3jd3tSP6kfvSvfLPG9mCBbzoMfL3jNaM4fGMWs69pjoNxpKrgbjjt66JumJ88SGyrWImgWs7xW1PT2bNVzNBVS6c73wRrWTdpwOK1spRDXTPWr12yQr3Hk9LEb/1knnzFJnjv2sTznSVlCwKHJaWbxk5YaeDad1j9xlQ2GpLJRga7BGwo/UkBeBcyciu1KvR2SofhzQdFveViNSKv8LaI4l+Uj9ajUb91xG4UBfb9E8W/n7x7gtQyXDJFS0dBKSmJwcn/4VeXnozq+REo2BxsfAMNxlQUEgdoya799vlA+wjU/GNgoxuIKiHXS5zWv1aoloFkOpB2bY1XA3d1vnQMYxQvuEpvOdJRoIBJVWwFLlIh4xTlRLojKT3Lwzi2fAPUJN5voEIblQfivjKhBvfqg2PNwuEvhO/36mRwRVm87H0HTrvMf3n0ej/8fSF9YzHeGRT6E/R3R/1tZ9iX85tHaY5gKBUzYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(86362001)(38100700002)(316002)(54906003)(6916009)(2906002)(8936002)(5660300002)(7416002)(66946007)(66556008)(66476007)(4326008)(8676002)(2616005)(478600001)(186003)(6486002)(41300700001)(26005)(6512007)(36756003)(6506007)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RCu1vzO6I/1tA25bSqSAU3oElN65Y6iYD+bZYeI7/Y9JlzCst56fTq9KR9wI?=
 =?us-ascii?Q?N6xixsAKt3CaUYIq3MuMT5rEDLlo896FUiZxnwmh+2hA7f08goh++gkCC7//?=
 =?us-ascii?Q?hvdW32t8Q3CZpp2WuT3ITgYfAG6xiTruXPseGApf4rqZB4ScDjL7n9P2aGeX?=
 =?us-ascii?Q?deDcL1hCiyUkUi4rH2+BIfvVT96njYx7H/W/TV4iKp1SeJtbEOgfPEY71zK9?=
 =?us-ascii?Q?Teh1y6Xa+qBvaQE5sdYSllBJsoPTUQkDS0ZWV2nAt7aBFr/yAXawhDyFc8EV?=
 =?us-ascii?Q?SvF6a06466GT+0BS0YQF3fdEUyP5qc3MFguF+Z/mUCySx1/MjhIGiQqAme9J?=
 =?us-ascii?Q?vbzyoleaTavXTTZWdRudJEWB3qh2uHnPYxIrB7N6R7I3xCJff9P0pIxDlyAG?=
 =?us-ascii?Q?TSOy0FGP6YadsXwIRHwOkMnstQNoJarjRGbJgwGyCV7A/HybQfhr4GT/msjT?=
 =?us-ascii?Q?u47r5nUx99Z012lqMXam4zQyqTjzoqSK9yPktER/ofr6ghnjlPX6sMeuxWyf?=
 =?us-ascii?Q?He/TytkOuyJ34K8VKGnYmmRnH+oy6LyEJogIcbXuIfKk8pt2NnO6cq3ki/0L?=
 =?us-ascii?Q?OaOb86f+XMMwetLsNn7M0Ee0Rb7SkTzFs0HPrsYO7H+iuusgiI2ymtnHSwaD?=
 =?us-ascii?Q?btZIbH+XaInDCGdnfQn5CAV0VmwlgKG7tUpZAIvV40XpVT1J69EHxVLqCfuq?=
 =?us-ascii?Q?EakYprFQYs2TXoQzzLriXD8KbT03DU8HQ+H9No/Lya0cTx1Mp1nNgyLoJCps?=
 =?us-ascii?Q?cCfFU66uj+wcWd11ZzOD0RI7gIY+Ar5+qBguq2qBdjN13Tr4hyfZ/w/YuNmn?=
 =?us-ascii?Q?AnT1XVWMDJCSr5O5o/xm6HZwxeW3E/QCDWgbFf0dVDCHEszWZ6yvStciKTaD?=
 =?us-ascii?Q?zK9HC0/ssw4wkbAJcJqM39rnD+3VC4UviZmumMl8TXG9Mn+dp0V/9kxmArwg?=
 =?us-ascii?Q?pGY9Ga3n+xb+UeWNCKP3eR2jevxfJ/gPik3an40jX2ipii48Ws78vxHnDyQP?=
 =?us-ascii?Q?dKP0yfattjEOiCYQvw2g+k4TurAOKzqT60pdiMqsZBzZ8XkHHIWrBLQZQ0gb?=
 =?us-ascii?Q?KIw1gBdejuLpr0EdgJ2dglg9udkmWEyJMqqHyAZTyexMw8DIxHvHPtdPWjml?=
 =?us-ascii?Q?+f9zkYvzsKE+7FrlUYelL2bqNOHX6YVKWxamDEmeaIc9M4ItuJilBRmP7lS8?=
 =?us-ascii?Q?eWN0uFlQB4HEcw6pnPd3O6xslEhUTzeK07ES2w0EK7ncoy0IHzAXah4LXpbg?=
 =?us-ascii?Q?qWU9iGRYoS3HSYV2He3ia07ykOlxfVCS2Qsa6nRIHzNX4AYxI5ma+B9yANVX?=
 =?us-ascii?Q?BQugMFEn+FOnC3LaeDm3YU3tQJGxQE+aPwCFt1AhJqjNHLxobjPCAT3mVeiT?=
 =?us-ascii?Q?zr78IFhzsLrTmSlTJVaP5vtFLSdzqucBUzLNa8vSuJjjrrh9jc4ezu3GX/oV?=
 =?us-ascii?Q?JUoFVva90TwTtbVVmdHZ7915Dd8b9C+xUwE7muz3ZEaazu7b9ez7c58ENXR0?=
 =?us-ascii?Q?f217m8Z20EUjlTF5p8rJngsrAW6j6MxYGQQ+0cs/DNCdMTEMC8lGW5U8e2qV?=
 =?us-ascii?Q?WO79obEvvaTK2G117q+RZP8JEXCRmO1CK83P8q9x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a153b5e1-1f7b-4acf-c2c5-08da87733087
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 14:56:43.3725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ECE7U0Ktcll9mpjCpZzbEIt8gi8La9co9dc0OQlvezCav2pFegBXs+J3M3Xg5He
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4138
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 26, 2022 at 08:11:36PM +0800, Lu Baolu wrote:

> +static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
> +	.set_dev_pasid		= arm_smmu_sva_set_dev_pasid,

Do we want to permit drivers to not allow a SVA domain to be set on a
RID?

It seems like a weird restriction to me

Jason
