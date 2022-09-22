Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709995E67FC
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 18:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiIVQAv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 12:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiIVQAs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 12:00:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03B7AD9A4;
        Thu, 22 Sep 2022 09:00:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtJG2n4C3j4/rd2uiGqWnELL+g+3aO+F+d+NUcUeyTP7MVC7WYigzcjziFKePKuidBoqyD2RFB+PHX7w4yxB1datGNyZ8jVJ0Q7cgszyb/4j6915V0TdwW5mezmRPVI986rkMaWjKKkvhYA7dkH20rUI6RXr5oEYWCXTmz3utTVq2qV4uW2BOAoWhTsT/e4iLVYoz+aWn26DyDQUQfzqY6ngNgwixLFdcRfLjeaXMjWG7LzAyMFc+a/v9QGVogjUTIoiwSWqkOUmmpf3a+Z2+z89oeuE7Y8Li1MdtrjVIX0pRYz5AzOIVq2j/A+nACBezxHdsH/L0KpX69/K3N2M0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wbhck2v3y7MLB7AOs5ZkKc6I9c9XqhK/rch18xgONRs=;
 b=C8fa2no0I5dZ7HQzE3Ko3ernRRDmDTvMuXzrp4YqbxqjK9XccopdInJ13tzfaD4nq9G2AA8iojNfzQuu/2mgIE5qKqIOmOVMZD4sJ0BTM9bJpqZTdqSyxGBDcsgfeWFqn9MAgzI/7/qJULtMnfPIFT2t5Yw0JnzdSZnjj5EDaj64R038OkLhyW5u2BzTzCAFJ2hedbnwDyHtLJNm4KcGTLZ43l0a2HkPRjueNv5aWk/RWPMhXGjK/1kiw+O8gN2e8jNAXqBFd9NMq4+KiFtj9nIWnD3ShMa8HUA1HPP+CcPwIRdiSaiAANK+6XP+ujGiOtcQ/3Eoxa1hjvk+kZ+zaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wbhck2v3y7MLB7AOs5ZkKc6I9c9XqhK/rch18xgONRs=;
 b=pYE+i+iI5wQbuUHiW1xgwAfXQ86v8Y+yJDLuMBRLOlijY97EDMjzq8dylaP+MIpbXleybIpc5INLsJUIwu35OTvYxpWHNb/1dF7uizF4KZrVJKXWbin3hosR1zO74vt092sfIrvmNQm60tB8HvHON4oClj2ZscBkuo31X6DTK6jU6qvFiYE3Aknty8xtp9Z5MsQ5Ky7IQKUtwDNe89I5QGB/Whrtuv72y4NvfpNzarW5WEPCaMHEPuqfKtsMP5ACOMXTWqjUAL6KXkxSoqWB7ayJ0WhwzCMPEMg85cNf1dwJevUgnDgVhfGzTP1dv0ilUfJbgCGI+MtDDEs2ScdUag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 16:00:42 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 16:00:42 +0000
Date:   Thu, 22 Sep 2022 13:00:40 -0300
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
Subject: Re: [PATCH v13 09/13] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <YyyGqDP8AgjsFAkM@nvidia.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-10-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906124458.46461-10-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR15CA0055.namprd15.prod.outlook.com
 (2603:10b6:208:237::24) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|BN9PR12MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b9d92c0-571b-4ee3-77bc-08da9cb399b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dw/lPjVvlESDka65mR9+holL2QANTArRPJOh7LYNn9QFyjSr1dIytac8wl5dzlfx4598GvEf3u55frXVSLW4NozXhtYUwADlQO0jyWeZtHFNEggRfKy44KmR/f3yQ9m7HlWtvA38m0pERCxmnm0rYhDzVb+Sm/RXupJgkqjzkCOseuhWB+f/MCNq5uTw10xcvoM3YegfgCMDAkTm1QqY58TxZ+RhIfKagMwq/Re/pCNjGHOnP7bM3uB0q4+byi5Pc+PzRhdTpeRi+eLdGrLbmLBo2zBYUs0WxDmMFcdJXkKN9IkmsEDjKWwq9Mw6pXGNkoyrmYPsDI8dlLkZ1rAPv0jTCfbWgn4dLvfm3imrtM6EmIbGDk6N7HRnhKCoCryRfm8elacL5xYI5cgjBnU/RN331ZQ+dEcVs7gJk2xM8CSzQVGRllViLp5qCHm/SlDCb/xajkBMv+508aUXl1k9TKz4+9TtuApjZp9hubpoiR4VmlYWx6ZXuE/EwpK9lfOoZPClyLkVzezdsz9AppKIUtVupL/mirgG8WFhCfgfOksahhzSNeTIlmbHzhJ5QQb4cO4Imn7nLMWxUpjEjUNvb8z9Cy66gjK9lcDi/nl9A6Xq2zgAMB+DujyfIPdEXwBaG1AJFSU0gw5bdvNiwj5KVGvyKpELrmRDeJ+ocSAw1ReyvnbGnykf3N45r85MWESdjUzbtVBwMiw1Q9YnrNxXgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199015)(38100700002)(66946007)(2906002)(66556008)(6486002)(6506007)(54906003)(66476007)(5660300002)(26005)(6916009)(36756003)(316002)(86362001)(41300700001)(6512007)(8936002)(4326008)(478600001)(7416002)(2616005)(83380400001)(8676002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VbghKZfE8qR4iIB5u9FUCtWq1bs4MUrD3N0JC/QdNprnr5k0WHNRAMjY5yY4?=
 =?us-ascii?Q?xkwx1i0BLaRdrXtArMAbGwMR3herYj36HgEQxjNnxszQVPGplys0a2iEnZE+?=
 =?us-ascii?Q?p+AOjGB7Ge/H8lselR6qC7nfwV7yyvY7I9B/lbww0/wdVbuiZfodwoZhP6kO?=
 =?us-ascii?Q?9rO+oOk/k5WmpRQDFKY1QGXwCmvXI8BVsr08tFegG3wXjj7O82LgZIUF8wit?=
 =?us-ascii?Q?sr3cBgp5JzELcKG8hesPKnUW1FAQ2Bj7YwaYIZ+KPLYXrXPFvXtHHkigneWH?=
 =?us-ascii?Q?IkgzmGQ629+5r+10j9KB+hxJ1NCjZDITzk09olbNdxvDEA1g94GXDt8svfvP?=
 =?us-ascii?Q?zi004jW7LB8lLnNVdaqKL5zFQ4dSjwVzfJ0XcWjjx/ysQ/SjzK0GH4Pqkq+8?=
 =?us-ascii?Q?UrKqMMk3apcF439KWg+Ivufa+AzcOH7Io/xpBEflCLec2iFoxEg2wWuuHo8z?=
 =?us-ascii?Q?PmVKNATHUPOomcDEsjZnDBHo/x225AxK1okrOFYgeO39mOjwwV39xn3OcaoS?=
 =?us-ascii?Q?oX7tWrNIMSjyRVlCxXrop7Li/2JxwFE02z7uVfLRRH/7pOBmptThsfJN/Sy9?=
 =?us-ascii?Q?d/XS7rah+CMvpcu8ykACzWgDMt4ITqnNAbRG9fXX8fh3ud/EuvpRYWTcBQsQ?=
 =?us-ascii?Q?skDqZjeUkEG+sJsgxA+XkfU/VdKU6Z5eVvSEbd9NZWPxCBdOxarewuCGisAi?=
 =?us-ascii?Q?5gGuuhAtIwVo9HErYRuhXJCPOd5oVu1QM8lVPTNC5zL3NAUVJv/YBAV7S/C9?=
 =?us-ascii?Q?R7/Wng0IyzjfbwWuvgg6tCe0Yal/WqyFyyHQRowbagiX9b6HAHEqaGq88Nxh?=
 =?us-ascii?Q?d3YWZweMIPcXjT9dsGT2f3LBtSKCeEXq2RXxK2h6WUl03HHjcA+2eh7akS+t?=
 =?us-ascii?Q?wQ2YXWawACUf/qv24C3J3kX04CYY3hxNxvbeJYd4kx0bWOh1G/MJbzRKRqpP?=
 =?us-ascii?Q?0uHwzEuT3NQqwMVdOSnlQPP335+j5152AXvFsmuNAHa8w0jq1znA/m4jQr62?=
 =?us-ascii?Q?rN0zpXP6wbb9t8iJQzuC/IZkp33Wd8cjd6Kn8ck5YV6YqcTKKsDHUyKQbzhw?=
 =?us-ascii?Q?yGnrLD/fN6YNYUgmtLaoH/pQ90q/Hv85xXbnjbpXhVfa8DZNIOXLC8CFSGaX?=
 =?us-ascii?Q?dXkDqToI4t2mhZ+WhvcH/WjY2GOVp/N1PjdHe2U26sspFawx2lo82zuAFNa0?=
 =?us-ascii?Q?MHyhcwjMhPXzQIyUoybPnMl6xB4SGBO2kKXP48C7/M5Vi+zhMus1oWbCdZGn?=
 =?us-ascii?Q?rZamZ4FokpreGE8ESVDIQ6gQkOSJ/1SHZG0cA3x6QR3EHOX0CUr/JFxNqxUK?=
 =?us-ascii?Q?xJYwEXIDyhyQ5rRN3cZGQ2/P+gSe07fxAcZdVqoaKSH9GH9c44jxCfPd/A3U?=
 =?us-ascii?Q?9Ft3BDojeG9BWzNmM6Djizuiz2/Px3yFunQhsO76pdGJPE7pdoCJC6C7jwox?=
 =?us-ascii?Q?uWWSnNAkx8301zX8+7UQeVQPph+Ot6CDe1D8EPYGCg5nT6EjMm1hBZD8bx5K?=
 =?us-ascii?Q?LMnnDdAGB22PowmJTwdUI0aVczJrF7JHl6dCaRFHXsuu4kAVRAOJaWz2jOOJ?=
 =?us-ascii?Q?IrzD0VZDfbVeLoIZa5Am3hP1wL07wz6c+3OGxeew?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9d92c0-571b-4ee3-77bc-08da9cb399b9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 16:00:42.3818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lodVCDrtTsCuPQ76Ud95cYLfDgKFX8A2e+1ObpO8kUE8fvdSngL/ODxUe2JkVfX3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 08:44:54PM +0800, Lu Baolu wrote:

> +/**
> + * iommu_sva_bind_device() - Bind a process address space to a device
> + * @dev: the device
> + * @mm: the mm to bind, caller must hold a reference to mm_users
> + *
> + * Create a bond between device and address space, allowing the device to access
> + * the mm using the returned PASID. If a bond already exists between @device and
> + * @mm, it is returned and an additional reference is taken. Caller must call
> + * iommu_sva_unbind_device() to release each reference.
> + *
> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
> + * initialize the required SVA features.

Thsi is something else that needs cleaning up. IOMMU_DEV_FEAT_SVA
shouldn't exist.

We need to figure out an appropriate way to allow PRI. IMHO the domain
attach should do this, domains that require PRI should be distinct
from domains that don't. When a PRI domain is attached the HW should
be enabled to do PRI. The domain itself should carry the fault ops/etc
that the caller supplies to respond to the PRI.

That is something to address in the PRI series though..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
