Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123E9598443
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 15:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244949AbiHRNgI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 09:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243887AbiHRNgH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 09:36:07 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409C8B5153;
        Thu, 18 Aug 2022 06:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AnFgfisthq2KHzOJPdK5/29jiZOZl8YTEXeTFtxzO1mXobCvryezgRrnBk/EOrHZbdYuwyzedmb0GmpoWrtu64knDlEegjNIK2OOwBnhZnf8ocWuZUPbwpNt+JsXfUdWbIuVVR6RQFQbthlPlGo6wS7jJuyfX1oGcI/1oW7CCfOccOTYiCOK8xUALJmK2tgJSF0r6J0B+wjZF9ba7dqMfSTpLevJcMlAOXVM8LDoTIbi5Mvr82cfKHa8r/fgfUlkKdxuiFDLoIUAFKZhvCSEa6r2umlDBmKCgCcEZz9WlpWC973BeOCQDoZtUx80nLBjFuMVTT3ngFZQVsrXVAS3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zg0xgggvVnnbWWiKmfoFGCWCThPkQjebibqlN4c4Nk0=;
 b=h/3VIu37RQrXjDEA/Kz/wOteo35NAJTu7tN7R1OvqHSvbDk5WmZ4DmT+Yv8fja99TG3+777kk7Th5ccNPAAOvjXzv9pTCpCUW3dv6xwLXolBQJGEeCXfC0111cPkeNpyGFF9che7sNmJpjeg0LBzOodJrfsZayk/5VvTV1sy55wkarolUzVymnlpsI7YsKJBUnfiV9Z4ouQiiii4Y3vY+isp7r7F1fBoiyBC0XrJ/+DorsPThjW4KvmH2CRdR5/PKrJ0yWzSz8JsBirOSkJcTQVNRw31o+Kh9UyMK5XiLkR1vhAnCJZdZ22MYcUzoMLd4i9jnef06+BH1gUYfqmMHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zg0xgggvVnnbWWiKmfoFGCWCThPkQjebibqlN4c4Nk0=;
 b=kJjbz+T2uDUrZ2mLlCfW4PwrP+m/Ac+WkeIOu7nacSHUX2nz3T0zbJ/iRU8VoR8O0j3nP0RdG8gJSk0kXRFWyFA80JZUatizbDj6t3NOlrrBdxlwjMrA9cCmXCLwxQudHPbNifNxEHPDKaOzdoplT/AjVJTazxmgnLlHtqdW9ney/bgE4qwdNtuwoojOtlxMJdaEXbzgM0P9CxRdC550nj3nm+zB9oceLalzzdnpQwopuj0fXBQ2yeeBslHVYR0eQ/AgG6V6V+C3C4hgC+ELtHXk/cjGeENFgd/EoRSr3LRZRm7ctMo3caLBL9EDomquJXB6oSoJ6UYUOjTvG/sG4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB3598.namprd12.prod.outlook.com (2603:10b6:208:d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 18 Aug
 2022 13:36:04 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 13:36:03 +0000
Date:   Thu, 18 Aug 2022 10:36:02 -0300
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
Subject: Re: [PATCH v11 07/13] iommu/vt-d: Add SVA domain support
Message-ID: <Yv5AQkcbhtaKFs1I@nvidia.com>
References: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
 <20220817012024.3251276-8-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817012024.3251276-8-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR19CA0012.namprd19.prod.outlook.com
 (2603:10b6:208:178::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68d1dcd3-96b3-452d-c8cc-08da811e98a9
X-MS-TrafficTypeDiagnostic: MN2PR12MB3598:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TV+XQt59VRkhAUBHMNVn8FkRxAkBZ0zuPVcE1M+DEfTIujNfl3uJ/uoP5mDHtxAVr0eegH6zpFhDHnhNBElh5m6JjEG9x0UdRUlofMqkm2CMN1RS/FlyRGz1EqDR+zyS8z8bsFAImyL/OTY2yMHRLK4TTN4oeYM2AfF+a98r8Xh6L3xOx94eCz6ZNjzCrypQ4RgKcpJloCpna0ERg6bVwTZk9TPy35wvcB2LVRyMptGH7bdgWXUE2C1qijQbPC+q3OM8udboMAevKneB0sAglqjAQY9E+nUuKhfQV/Cb+NRz1yoeCUxDxZu/Km7YG+VbPZG37ECxrsJQMySVe7NDCwoc77lSq7cHVke9kgHVlk8PwRiP7P/Wcaau/L4dDX2fpUMUAH4mD7yVL89QnwpwxRO6A67DFq3/CHhE1wPj+wtTeyaGp+084naA2yDJYaJE+BtP6q2Nk9+hl9QfF0qmDLDB28MwKdj624/tSjik/Si1E4J6hHoec1bfvDdotSc+PqCXG3UwlF/jR6/RWplxO8lB+eFurgEzLC4zA496TNVI1vXfZIN2G1R1jgLpcVKVXaHAHDUCg0miWQ2PI/S1Nb86y6Q337qj6KxeyzgDAialz73hDmbdcopSyUmohyi3cTluqjg6lmhXiitsMRNP4bPjk/IE9lbvqaCi6m3z1+avaCiwj4WQmgyuzGlPNItrALsNuV0kj790YDtW59fIkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(346002)(396003)(376002)(136003)(83380400001)(478600001)(41300700001)(2616005)(186003)(26005)(6512007)(6506007)(38100700002)(86362001)(7416002)(6916009)(6486002)(316002)(2906002)(54906003)(8936002)(36756003)(66556008)(66476007)(66946007)(5660300002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tXFCBbl7qkBiA8YKhoagsfKMokM+RlP3Pf+R9TnK3+llsWzX+2kjfajHt5A+?=
 =?us-ascii?Q?QPBnf/FrLNTwBSHParNqVW37qpnEk5DobcBGrCqGmoRR7m2DDmG+Hkv91A2c?=
 =?us-ascii?Q?ccbvzYbObFZ1xp5C54ncpzgaCGne1aPrHqRj4eYgXayki5q/7teqc/SlVzLx?=
 =?us-ascii?Q?nglfOdMEvoj+zmrW7AtazmDZsx1jNstxlllSzjun3kgvpELqzwxRbh9quZAk?=
 =?us-ascii?Q?dd7CY0/pbBTCerrYwJjVtidmMgcMRfwvaSQluVxcejOjWw4RJQnb7SxKnIVQ?=
 =?us-ascii?Q?1dY0S+BuUFG1uK5j676IvLtbIvC7loFzV1yLZAniXrJWbfsigmd65JJEFmGt?=
 =?us-ascii?Q?qYD//S7793Rn78XLFgeVHKKBllwDKXwrVeMdRPDXW5O6+ydBrLadkqQlxlC6?=
 =?us-ascii?Q?mhf1B+GIYwtsJDvLmpVlbUC13t9O0j+953VLmKG5MplYf8bOwOxNtCUDjn1b?=
 =?us-ascii?Q?xhOrVn3GU0sOAci40iDV4r7HfTMOSBTV5q3B30luhOBZ5ouOwcoXpIIax+rm?=
 =?us-ascii?Q?vqYOuX7WLGHQr8IGR2WikvJpHl9SfGcj5XDSg5pm2qpshrrGbNrKT99GygYI?=
 =?us-ascii?Q?M7hvnhKy+vsBrbXSniE0CSiaJEQsGE12ceAbJCsSfqiNMeUx6LFSpnBcv6XO?=
 =?us-ascii?Q?QmWbS+RbQycvOxsJlSmIg8FUsJSJIc96/iLbfs9G8s53tmCHzK7OCEKqsMgG?=
 =?us-ascii?Q?CRtEf2g9R4xqmt3psHa8KPxdWVNA2kNDn0UYzs0k6XbjWIL6mn4jAcQe8BeA?=
 =?us-ascii?Q?CS+9t2INTdAMt35EP5Usjjovz3NgCfxmVHWcB2uYAaKe7c3JoReViC/h6B/n?=
 =?us-ascii?Q?06pdCDtUVlY57hHhgW2LYwtbONeAClya2I0Dj4Y34ZNumbKqSlO9lQYsrm2J?=
 =?us-ascii?Q?WhSZCD9uoZCfzYuT2ClrrTMcIOeE4beF+by9ojjbboIF5bgHODGPslTZffVl?=
 =?us-ascii?Q?RKssHQh2omT1WR13jt0ZXtifeSdpzCVMG6JgbbySgUcu0PdcRr4+l9gRreUk?=
 =?us-ascii?Q?OnVyW4Zm92iukWCmtSik5LaOq0DKIL/+lODP3ddEWfcW/nZ/E4/d72byXYG0?=
 =?us-ascii?Q?BqpzM0UduEekDS10S7fk6hxBnGXeLPira9kMVkLQRa5e2di7/YKwyzs09qwk?=
 =?us-ascii?Q?L9ACOGZTYMganF26/a6Ql8N+WnjYiUFgRIqetvICIL2YtaopnsrlEmVzG1RJ?=
 =?us-ascii?Q?I+Q50yqHpHXsnt0Xt2jGs5nMBcIN1bMEDbUfvjvK9mNXVfYa7HyTeJrjQFr+?=
 =?us-ascii?Q?I2scOCoOyCVoKZAIa3BtmsSysq+kocMQxB108o7DQlG+MJGR2dC8ifQC1cY4?=
 =?us-ascii?Q?q9qYCL3nbY6Ar1VhaSX7yuk1U/C2rKuazy58tL/fw7ynpyRpQcrUDgX/kMUi?=
 =?us-ascii?Q?uKm8X6tRIqY+65VaGJAZv8C4UQbJ5uGKFyegJxD+AT+EKLMV47bKTFQfRx0G?=
 =?us-ascii?Q?ax5Q0ZEuuvnCUnlIUNDe8w7U4gVzo4AsfTLYYioqZ8x3/BQyIJlJZfaJP/K4?=
 =?us-ascii?Q?hoIfxw8epcCAaVlxKwXQ7SUp7ZHFY0DVvANg57J375JGEjMDtJMFkmwwixRq?=
 =?us-ascii?Q?KgYBa8+IhikYPXlJ227eR8CyDqmJGVSab8rIWVpQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d1dcd3-96b3-452d-c8cc-08da811e98a9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 13:36:03.8018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6oObocfvZ0cha5fjsVUIIFdHuU9JGPXLMQPL3UShGN6oGbh27YM2hCiYB+3KC9j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3598
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

On Wed, Aug 17, 2022 at 09:20:18AM +0800, Lu Baolu wrote:

> +static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
> +				   struct device *dev, ioasid_t pasid)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu = info->iommu;
> +	struct iommu_sva *sva;
> +	int ret = 0;
> +
> +	mutex_lock(&pasid_mutex);
> +	/*
> +	 * Detach the domain if a blocking domain is set. Check the
> +	 * right domain type once the IOMMU driver supports a real
> +	 * blocking domain.
> +	 */
> +	if (!domain || domain->type == IOMMU_DOMAIN_UNMANAGED) {
> +		intel_svm_unbind_mm(dev, pasid);

See, I think this is exactly the wrong way to use the ops

The blockin domain ops should have its own function that just
unconditionally calls intel_svm_unbind_mm()

> +	} else {
> +		struct mm_struct *mm = domain->mm;
> +
> +		sva = intel_svm_bind_mm(iommu, dev, mm);
> +		if (IS_ERR(sva))
> +			ret = PTR_ERR(sva);

And similarly the SVA domain should have its own op that does this SVM
call.

Muxing the ops with tests on the domain is an anti-pattern. In fact I
would say any time you see an op testing the domain->type it is very
suspicious.

Jason
