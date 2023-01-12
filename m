Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84450667321
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 14:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjALN0X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 08:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbjALN0O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 08:26:14 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF41FBEB;
        Thu, 12 Jan 2023 05:26:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNfXdSu864YiyVGFXblrU1vv0F8MaE+uFyLMlPknZIWUErQ2zTFt1aek5gU9oE6IYzG+yPQJbPz/bEL/3OtP/dEbcvPdtzElgIWPy4v0MuKSeG8EYgOWA8mlSaGpIgvWkg4r2SL7960QpI0wxiD97gqVbgIjMSAPkr8xKMH9Qw+5FsSPM5VdOs0lxaP+JjBDT3oNsjXT37wYqcbfkPRpGcB9lmUZn3LS+0UUieALBWpDZTeoyr7SGXM56bJfpNQ51nm/ztvjQajhK6/hmwLxrBwMRBYkD4BwSap0GcPcPcQ6Q/mis4yVf4PmWNbZAgVUFe+BRT8T6VilGDxlwl664Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAkCFwR/IwO+CbPIJtmX45+edq5M95IyyVjGY36iOjk=;
 b=UyynzFo1h25qI/QtdTSw5ALUETBAV+wOlfcBSQ8e2kIvxpb/AzYX0UPWidXZjXm8wJycm7RlHCurOkhGh0q98t2FHZHiK4g/r9oSHY9fOzz5s7luwI/IoREbwFSlFwkA77Da4ajJScsc27503rZI4iEDHzpsAx1qD/TPqWnDjsEjETbBWAnQRJMxJ/6W6r6bib2+wILUbah6kobkdXPKQqthKZy1Uvwuer6Nd+1Pohw29ncLg++fzaAXdvQ/eGKi7B+9rwPl/j5AMsTl7Y3vBoFksAzegor2p0EyLlUnJkBT4KaszHpc1/R5QTGHySr98EBikNWube/WTWcJtIB2BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAkCFwR/IwO+CbPIJtmX45+edq5M95IyyVjGY36iOjk=;
 b=TpsiGb3Yt1cirpss+J3KCdjjuefH5pKARQ4nnKxl9cFxf8oyOryyPS7HLD9wpWA7Z0MTi6E97jfCT2QVscDGVFAcdR9TXdUlhQ5u73C1DdQPd3WXnGyr6GsPOFRQm301sr2LwYnzMurCw4Wt+oJeWI7VU2xW1vbjrOGX2G4LIxrc1d7CVoYvyflljQSE/ucLqiRcjivRiuJ1vMQ27PDhyt0X83frHppBsJYFhfVQx6bIa6P+f5hbI1jtsyaqRtWaMIdxvcs3rzJVSO6CrtgipzhkBQcjjJqlco3L2YAXMVwLJDWHyo87YqnvojT5FyRRmbhDlnc7DagyoR5YT8JIxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 13:26:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Thu, 12 Jan 2023
 13:26:11 +0000
Date:   Thu, 12 Jan 2023 09:26:10 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Vasant Hegde <vasant.hegde@amd.com>,
        Tony Zhu <tony.zhu@intel.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matt Fagnani <matt.fagnani@bell.net>
Subject: Re: [PATCH 1/1] PCI: Add translated request only opt-in for
 pci_enable_pasid()
Message-ID: <Y8AKcnFsdu3+8Cjt@nvidia.com>
References: <20230112084629.737653-1-baolu.lu@linux.intel.com>
 <Y7//SDtnfXGHfior@nvidia.com>
 <78a15f05-29d7-9dd3-175a-3915e7357c11@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78a15f05-29d7-9dd3-175a-3915e7357c11@linux.intel.com>
X-ClientProxiedBy: BLAPR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:36e::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 84a88ebb-fd21-46ef-7d46-08daf4a09234
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aWflXQWJ0FBqMpEBmUE1Gt+Jq/t6X1gzaKiGtceOTLGtZeHzJCR62kysYew5NcRcUV8zJeJuz2rGW6kkHJrpE16OfrQFyRyBCp5ltFiet5n6uhQNJ7ujIHt6MjO+u53LiAEpvuUTOJfBkVEl7MX4UOY8fOuvoRX1J+LdJhhllHxW7kPtoOMT9mjBmOlVy8k5jNMw2RJ3K8R/eQ5G1/p7MGB6C96paMQWClrVl40apbB7E4DFk9MLQJk4JTEfugm/kJlNQRUg7R5iSvhdd3zWGLqw9+7FOG5i8NcZaRz5DKmB8iyV1q/dTcwiAi2e8vz/CUNbL5tYuDrsJfU3lMORTYrqTvTEldPpsT7cUYgpGh14UVY14BOhUG+R6EGBOLlkMjRNrLvX2BPPc/vfkTfq5gVGGsoMV8764qAxI8Wf1V6gqThTd2wie7bMwI7+jGBO2wWtqU0LOYL1e1BtviqXY2qHQl1zaVjg3hY5lRwJAxDqwSYCIWBHBRwPJjqjZXPp3TQjfnb2aAKvl+RGIkDlxbcMH7YPZMGgJhKzsBpuYNRUJrJA8qdF/vR3pvX6vkX1AeAsg31KtdVNYG6Qtyk2Mt/Z19B1AugH1dZSgJ4R+8VT+sK/d08BAzvScZcVzpkquHrqnvixrJ9xvIjRtN34Q8ChDHx5ZMfZveWvpYA0EFRyKtBVNut943/0zhQPmgJC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199015)(7416002)(316002)(86362001)(6512007)(26005)(5660300002)(186003)(478600001)(6486002)(2616005)(41300700001)(66556008)(4326008)(66946007)(54906003)(66476007)(6916009)(36756003)(8936002)(83380400001)(8676002)(53546011)(6506007)(38100700002)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dP3zMX47blB5dLTCqbjNUwoH8tN8HOaAhyqCAczKhVumlmboXbgAE2YsFin+?=
 =?us-ascii?Q?PnC4x4fYLkiArIwYwQg5JbJ3NoyZ99npaL19YA7tWjrMe7XtLdqMcOTIhq/n?=
 =?us-ascii?Q?0bg0UoPC+vUEG2wBswms0l4wf2nBZtsyujiq+ekelO6dbgJ6iKNj7xFFR0US?=
 =?us-ascii?Q?c1j8mlzrG43CVaRl/wkZQiYrIxXPGj7cvDlVs16BDL0RKfPfdpQAoI0wHxjC?=
 =?us-ascii?Q?KWIiKM0apn2JKek2ytBxJ5aSSGqlsIJWuBguy+b24Aq3tcZEf1a+VX2lWrJm?=
 =?us-ascii?Q?/EYHXwCCDPA0MuuRHjdl8icQWypr1hi1/NsU0b1Q+ElbjwVc0T7a/Cf9Wd4y?=
 =?us-ascii?Q?ZBbTl12EUtEfdqP+Ye0L3Me9slE68Um88yok9dG5bfR/HqZyUdr0gbZ/XSV2?=
 =?us-ascii?Q?I/q6/a51wYvWvFH14vRYbxKvoIHOd324UATPbrX+SjXsEzTkgT8RDJZxUZOJ?=
 =?us-ascii?Q?/yYsly8k476toGidzaTv86HHDi8kF/oyefjTT9C6Izmn1N/7GZVbJdDLumr8?=
 =?us-ascii?Q?ESVTImLY+XiH5fNm5gtIHF8209ewLjB+nfMRCHHdXpjsBx5VeyAyS6uHek2A?=
 =?us-ascii?Q?atpGzBJGH82v/vVkoQZiC7OtU9qgiECNth7OCd/ume9qf31WmaeBAnVdXmC0?=
 =?us-ascii?Q?IdsKmzJFsmW/rZrsxa8w4pIXYXSWaxQxO6g4DpFSE41OoWZRyX3LVHUyLATv?=
 =?us-ascii?Q?EWFcTAZMwgNMhDu3HHQ/+bgWtM6FEWQgMCfBrV01XZSYLkT5PlIbbkAShGbp?=
 =?us-ascii?Q?69hexxvnmbf+TFpX+jaJQjx+6HHkt97o1Tq6RnyrAxzSMlu/Bvjw/SQiswfk?=
 =?us-ascii?Q?YBcMzSHcilS1HJpBTXTWb6kwtq0VJAlBGL9jHMGp1LXuncVpcygxRuGan+vH?=
 =?us-ascii?Q?vNw/uejUetmVe3QrdKo4Qn6hbaTN7rBJ1BGxg3ju1Xt6dVyhTQFR+cUQIBts?=
 =?us-ascii?Q?Mm3TexfpKjFPi5fzEEZpnqnAVYl5drpFoHdtrH5TVG+NNe+8r1bl1Qg5asDW?=
 =?us-ascii?Q?pz3M1fI9xfxEUcIYML9Fngkxq7r8vM8I0B7pQ2Sl5ozR8jEJrUnZEupMoqF0?=
 =?us-ascii?Q?rsADM5qFtcOLdP+gbNpmkRuxPSs8rTQ5geqKadSDcVeR8v/ZbLhLGZyb9F0w?=
 =?us-ascii?Q?hilfK5ArJNDuXO28jNNKBc7wcq5mHanBPzvwISb70R21QE2HVFltH91/1HD9?=
 =?us-ascii?Q?iJlPduoay8W9QvvQWp/8QgvGgOdeju2bRg8Ppn1MlcNlNU8FsybA6KAAX9UT?=
 =?us-ascii?Q?stkpu6vWtFTrs7ISmklin9WZJVhiR0tcpsum4yqa6mdwVIAQcNsK7c2nm26D?=
 =?us-ascii?Q?1+zhueBYfzV0UEnoL4kjYDYwMiE4z06vNynt2vPOQVunN2ldPsDQLZKxudi7?=
 =?us-ascii?Q?jPAnh9SCS5fkcoNcmjf/h3QxQkFsw4vrn084IItZuZMcC2O4y3hn0DM/5FrS?=
 =?us-ascii?Q?6xR5kClc4sRL8i5HZ9+5hjwjZ6KvdZAI15u3IEpQlr7wvDqgUQYFb8HNQlHX?=
 =?us-ascii?Q?P6B1oAX3qbC0BopX6BX4gc1rGpYdTuWzsAE8RSoVhqNH/uX9oY5eFA4h99ui?=
 =?us-ascii?Q?fOJ8aTLLSHRnBJl8iAMOvP1TGw5+k0QTo7NcsI6W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a88ebb-fd21-46ef-7d46-08daf4a09234
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 13:26:11.2141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NrYwLJaE2mfKBH3dOafNb04tnxeqz1+8ENnVjQTXdYSHllYpvb5T47fqG73GF4lr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 12, 2023 at 09:25:25PM +0800, Baolu Lu wrote:
> On 2023/1/12 20:38, Jason Gunthorpe wrote:
> > On Thu, Jan 12, 2023 at 04:46:29PM +0800, Lu Baolu wrote:
> > 
> > > -int pci_enable_pasid(struct pci_dev *pdev, int features);
> > > +int pci_enable_pasid(struct pci_dev *pdev, int features, bool
> > > transled_only);
> > 
> > Please use a named flag so we can grep for it..
> 
> Sure. What do you think of this naming?
> 
> + * @flags: device-specific flags
> + *   - PCI_PASID_TRANSLED_REQ_ONLY: The PCI device only issues PASID
> + *                                  memory requests of translated type.

Yes

> > Discuss in the commit message that this is a temporary step and that
> > pci_enable_pasid() needs to be moved to the drivers
> 
> I will add below in commit message:
> 
> At present, it is a common practice to enable/disable PCI PASID in the
> iommu drivers. Considering that the device driver knows more about the
> specific device, we will follow up by moving pci_enable_pasid() into
> the specific device drivers.

Yes

Jason 
