Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248665A7F92
	for <lists+linux-pci@lfdr.de>; Wed, 31 Aug 2022 16:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiHaOKQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Aug 2022 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHaOKO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2022 10:10:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201566C130;
        Wed, 31 Aug 2022 07:10:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eU0CgVQDLbHxS+vfMfdqJ8pN2jBLha6rWS06PfT1A0qVXO+tvDMhLZy5i9yzAUBm36kkqDsDVEK8Y2/883/yCAARPs6bDaXdLR67BKOEXcZHhg3PepKscddrRIRt73SPM5n9Cv9L7D3fs22lEiRenqCEqXjNtvSGUcU2EQNXPoDdIH3HWABIzpUGMfzvKAkzIYB0iIOdhPm18Y5JE+sjXa3JSGc7ztbUxmIyJViN+MBITzLd68D+VI3o8ct7YIqPyKfkrr4t/Xlu3XWekjYb5BU8WXVdbJK2pFRfKYCth6Iu7BtNUD1W8Q6Dyuxf8Z8nJt0qiao70gk2dQaA6R88Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74YNoZOCisO0cqQllsWusU4d2yCYWrgWe5FPNqRmIbY=;
 b=bmWA0Bw5xWQvZ4XPOrjpo+ZNWd5ZmniK/2XF/nSvGNerJ8kzP6xmxGGkjvBrg6Iq6JANahVX/v2O3egH6HurjPZ5Lht5Z4pnGVYqTz7GiNWR46nZJhwH5Sx8fcBYjmRWSBEDfW4JAy08kGv/p+UGxnarQivUqH/bYngZtZ/dayDtEtmvgmixVE0/gZwsXstXplrzw3j/PNrzM+dhT8VTTJie2Gpjvgn09WYa/ML1xQcgetIf2rSj+9H34RdwdXcaC+WRdrrOWWMQhjdLIr3/c5Ae1VmD49cgap9vUaiQ38swi5gy37cTZmtsa5a8R5lCg2EpKRME90ilhNNzYmJ0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74YNoZOCisO0cqQllsWusU4d2yCYWrgWe5FPNqRmIbY=;
 b=YEXlHjdwr1nJcZYj5z8C1IrBxMNFHesQzpAO2PjXKKs8utpngItTH92Zk+hrYyeWUiQlvyGVucLmQ9OWyakN2KMR36qBOXl7DQJI/gxMxMItv70AdSrMUuRQDpMgSywIb7ugAPuw5sp2t+CcwFq3Jy9ZKuggeWweStgQ1jJLHNngsnm5mhm4dl7Py9vTBnbwEUCcLVuVAmrlNPvEgmGsrM0RJaS8T1xrTsP96oYC6ueBJCIu7c4AGNLZIKMfRJ0UFoehxWFxlMpadGcCHqse1iP1c1WZSGCtSOL7ZU+OYMzZl79hzceGS4rLJ9O8oM9gMqvjxFg7XAzYet7ma80Wdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (2603:10b6:610:a8::16)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 14:10:11 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::3d9f:c18a:7310:ae46]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::3d9f:c18a:7310:ae46%8]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:10:11 +0000
Date:   Wed, 31 Aug 2022 11:10:10 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
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
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 07/17] iommu: Try to allocate blocking domain when
 probing device
Message-ID: <Yw9rwktDY9Uca/cv@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-8-baolu.lu@linux.intel.com>
 <YwjeL2SVmdRpoWb6@nvidia.com>
 <316f6575-59ea-08e3-aaaf-bc1e4f42a574@linux.intel.com>
 <Ywz3A3tHEzY+Sf7b@nvidia.com>
 <c7d71936-ea06-3a71-d13a-cedd108413b5@linux.intel.com>
 <Yw4Qzif8W53ykR6K@nvidia.com>
 <c46ec383-bd51-1d78-ff81-0bee064ce1cb@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c46ec383-bd51-1d78-ff81-0bee064ce1cb@linux.intel.com>
X-ClientProxiedBy: BL1P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::10) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 928fd401-4bab-4b21-be83-08da8b5a8473
X-MS-TrafficTypeDiagnostic: MN0PR12MB5956:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: djBilCimONxby/8FshW3ocGhvYlOJs08nAaICWeMaRJLFsaYa6tUwEGbOmW/dQCwhQNTC42YmN4bp0nJnnIsILscip2hXjrQP3z2Qpb7Zoeph1nRtY+/dy+UMfcIa9WeDE88b5gNAY3QkqBPI1mUTbIr3C0TZDj69iWv3cKHZ26wFnP1XnUGQf7kIE4JqWkRGJX3fuqBfqrN9OpeGqC1eBvf+Wnov3GYHTw6GnNWY+gKhzWvSxhmLw3Lk9IZiF4Q4yXWVVk0RSInGpfPvQ9JhUoukogGIc8dp6ZModHanDsvxovA1ukd6zlGlF2322Zt7n6UHE3vF9GdmSaoUhC31orWpEgz5fSNeL98oVAijCnyH9HzOhkEefFaiSUpZKBNFb7A2w0xRKIOi3r73xHYBA4cTw88B8j7lLuIP0X3dHTDd2ms6xb31z0D/jAkNp4Jt/anrWfLa8K6oaYM/p9fAaEbEn9nKAwJ3XlwPis9ziAswA3HuqD6+VBaq9R02ZHrNIC+y3Wm8B5MTZLQzsgwlf5A7XevxTd2FHwRbxGrV1OYA/6Nk3MNqdim1cSTERFZ8+nDEV5IwU9AjfLPNBuSy0I8+LphKFS1KqXXYDAtTgAVMFPIPuT6KBztwGkRSbqtIT8O1SbbHfjDjIONevtoKcyIS53z83uFG/dXz81Y76NAl4NjRQi5BGS5AJDh+jOpLcV/SLWbULgLiOL9q0JbeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4181.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(4744005)(2616005)(83380400001)(36756003)(2906002)(186003)(7416002)(66946007)(5660300002)(26005)(6512007)(8936002)(316002)(6506007)(66556008)(4326008)(8676002)(66476007)(38100700002)(6916009)(41300700001)(54906003)(86362001)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EmAxjWegNWsZ+LR6yNfs74sNkVLrKo4XLK8+le154RPcI+uNOMqqAkQ75Ekv?=
 =?us-ascii?Q?CRDN2ih+ef5bRYQWb+3VobW9guBJYU8peYXp7/cYhI0qtm+yQTAmYnGH+eSf?=
 =?us-ascii?Q?UGy3gAi07f2Zfh89Iqif58K07Zkx0xKlKns+oFexUeQbFRahbMfi1Xed0ICJ?=
 =?us-ascii?Q?AzIBZKbd+OENSnXAfzZuqjQZHXDaHCJ1pLrVc7rS1dZfpMP73RWEJ1qCLEnl?=
 =?us-ascii?Q?RIJn4tynyBQ2hBmCjtiIs6DohHbE4C+62a5L0Zw2/IT0Wbc2EbgujyCZKCpm?=
 =?us-ascii?Q?/RVKTUOp7GOj0JMZ+/7Yc1Q+fVO8AUJzPviwULccoobkXEHFz6ItBm8SD2Xi?=
 =?us-ascii?Q?6b+AfQEckGuG7HjkJiE1VF9Y1vkbgpMWgGaDrco+agJ29cp4FO6X6NGA3/Qx?=
 =?us-ascii?Q?ZDf6E5079iKixskF4pyn5b5M+1xpFRrWIwU08t9t+pYBm7FJ0l6EvtPqFyAw?=
 =?us-ascii?Q?oeEcTS8qK9K10PGs/OUYVKIDJrTh0M4UKiE2oUEcsr9tifOaBsNKlgaT6mx8?=
 =?us-ascii?Q?udmZLfwLqMlTayEu/i/VLKrAIhea4TIN+V9mQdw/QZxMm/+rOI6ZltA7o5F3?=
 =?us-ascii?Q?NqIcEoD0bu5qalVrcRobWzIUjetqQMR6yIK8BWTMjpe/dKg0F2jnFspFRr1w?=
 =?us-ascii?Q?p4jOwtzxactVTXyYyPR/k46Krgbm/DSqZIA4tLrNjJfdcfsy90KKYb69Os0f?=
 =?us-ascii?Q?n/3uLa8gKUSeROyiY4NA5XDGhIZ2EX86b9+MEjNzr26Ag/dSc+GiOIc0wyvB?=
 =?us-ascii?Q?nYDfUaJPFpF8FXmcP9LH7ZloP+EOxwVIndtSTHxHRHIbT9Cy28W4bIAnYNSj?=
 =?us-ascii?Q?tXYWalAaU1pyV/0Ipi6nMlW7oXvY8OWrr/j8Ezp63wyVA/yHXMtbpoROEzH7?=
 =?us-ascii?Q?o7G0WkRno2pTZoEJlsf4wyVsV4RdqVuREQKV6iKEdpo3zXg/Mj3kd5GzpYlz?=
 =?us-ascii?Q?jYIRx6Y8AgX5mqgzM7hL2hp27gJvnxg2BPSHO5uNgBQUQIMqabgUZYkORyZb?=
 =?us-ascii?Q?dZSkYzZDaQkgwqo/fRfpP0Wf2G7lgq8haCQOz6lKpUPgFw75i3PnUOlSUDNe?=
 =?us-ascii?Q?Z0DuSLmbTc43SKBiJ3Z66mURtRvGBeScQTrGZQbfgxTrsYL/7IdNhD2Je9bQ?=
 =?us-ascii?Q?MWXPlDgcmWBphsMN1OSRz9/XVrqfRDiM+z/SJTKMPF7zx8zsXPn6ySE6IIBd?=
 =?us-ascii?Q?fkX4OGv6QfpNuaBa6wyTZHwrn0DPWqD9I0YgT0QWJZgdsIAwP7zlVEee7uuH?=
 =?us-ascii?Q?jm940ycEjYtnZMynzlktQkPtsanbWncZBt3oyHDpLctU+RnBv+EbmGj/pH/9?=
 =?us-ascii?Q?m01NNa1Lu30tfRcBehJBudfQW4LZBDlOHtv/mVJWHADTs7st3Ob1ID1rQ37H?=
 =?us-ascii?Q?4vz3NuZpJcpuziA8qeLeWDXKmMGirvYvSZ45m4Z1u+gvo7xLHn3o8ezR+lQD?=
 =?us-ascii?Q?wG4GdmP9u4R6JNpasWsBXjrMvtJ2zAlUBRJwCoQ+1g3xL9wOe/5uj2dlIKi/?=
 =?us-ascii?Q?nIQPCwUm/mnxbyGv1lRtuUt//0bOrT8N75frx17Jn9LVPIGKcBYlHUaqbwmN?=
 =?us-ascii?Q?rIWpQCm81YKFtozYaP2JfqlpddUUUa6tlsHWXTEy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 928fd401-4bab-4b21-be83-08da8b5a8473
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:10:11.3247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCaXlfeQkgZNlA7F1WCSCeEkfWaI2UHpwMCVQUHIIbjCkNjQ9kd556N6Qj2guqLg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 31, 2022 at 09:49:44AM +0800, Baolu Lu wrote:
> > Maybe all of this is just the good reason to go to a simple
> > device->ops->remove_dev_pasid() callback and forget about blocking
> > domain here.
> 
> Do you mean rolling back to what we did in v10?

Yeah, but it shouldn't be a domain_op, removing a pasid is a device op

Just 

remove_dev_pasid(struct device *dev, ioasid_t pasid)

Jason
