Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BFB5A2993
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 16:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbiHZObr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 10:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344429AbiHZObc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 10:31:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C021766C;
        Fri, 26 Aug 2022 07:31:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6xmrY/0EgbxviYqOCNC1LO+yPamYpENpNpuEPUFfPElbYeFkuY/3BCPNasO1of5PD3kpcS2IGgn0XWuRP+bp0XxorlS/gVp6469GZMqeH18NSxmTU53GciFQYciP3arDzon7yAeYpN0T6EQBiLzHvHn2a8LTHnzm+y1q7zV2ChOoQL4jpilNYrFvfj8ff5bWXNrn7P/TU3sTE2VafoEAb2+rS4ppbwT1hvFipmXQGSA5/ijsJW3aCH/4Cq95VfN354sJuTupQBGYcT1ElK2N1covRRGFYlL3/bZMiF4F8kZBusazr8Lzjk9nOyKGNLsSi0p3nt/NOW/J9LSWBUi0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/O9wWph1qvpDBqW42Eaban7snWqjRa+X5rcBZYSu1s=;
 b=RksFo0lNkE95HI2EBJvSuLopjkWh/rLa8+s4pYON+G6xKKtB2uDySepji8a9jkgEaFbmSt/d2xmp7N3L9n6XfsHaF0XPH5prwRHZCrVSggfc2TtzbQmVjcPS7r4k/Drbvd0LKDyVdxwLLS2NvyYJ2Wk78uISyTj/vj4T+/SwNxk73wMlIxBjF1WGqqCUSYADPJbyjL0O7Uho9m8BEOS2/KeV5hvA3L4ZHYAt9YkF6if/JZKGGDVr8Q3BlmSpWoWGKlf4Ta43l9ZJiOIxe7487KgnLk0UmhSPZc+JpmqqfiWOTpL1nv+ib8SZFBZzIms+tjueZf/RsOT+G8dnWPRpnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/O9wWph1qvpDBqW42Eaban7snWqjRa+X5rcBZYSu1s=;
 b=I45HebUT3LOPfgjkNYiLcvP4p7bbAohLPN5xn+IlQiQoqtV5FOuYu2LAlOvPMUNVq96S9eooAfo0VxNHb0bCmqxVmBUvH1IgbBBEJVqryTX62k703AQmznnuW3j1xK8pp6/8UhaTjlZytjEaq553xlODLdmuntbuZGeSAVtlZu5x0Ts+8l9VS8pO/kWWaBSFjmy3yeu4hWENEttHc/uenfAXbWygAIpkmcSOIflI0XAIjL04Jhr3seNvs3pPYvX7f1LmByHX2m+LZ6bg19Du6E6jdEvczZoGNWoL0aHAdtUOvCBPLmkXMg8Grbb0bLYnWQGyzOohKDBTXmEkrJRMiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by IA1PR12MB6044.namprd12.prod.outlook.com (2603:10b6:208:3d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 14:31:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 14:31:29 +0000
Date:   Fri, 26 Aug 2022 11:31:28 -0300
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
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 11/17] arm-smmu-v3: Add blocking domain support
Message-ID: <YwjZQFOe+l7Z9jpd@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-12-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826121141.50743-12-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:208:23a::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad1f4462-c4a5-4d0c-1fa2-08da876fa9f9
X-MS-TrafficTypeDiagnostic: IA1PR12MB6044:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KfDlZZv3jVNhn5Ff2F1yqlmM6TNulSAR3vq1tQCmm3PfnxxwA2JQa5reMMsvN1YLGZDd8887tj1xTpysRH2geuP9cZxKhAZOUeEnmQECdon6Cl/xoC9WpSINMX7hgxZHwWG10vSYXMjI7Jjz5StIKwQ21rQRlD160mZ6v15bfJ7gZHZf1SLeD5ly1jkXwWDSzY7oINP0amh/XZfBn4KPGgWThVGxfudKoaY/+eGwBAB4ML8JzA8GWF7D+eZ2HANLtWi5V2XJLiIjUPlyeMUtmi94PMSmu4wyCZRNhW9ciHIHAj1M28NL5KSGJzHlKW5daxKauSBx0zA9n0/Vccb3jRRHhCI2RCmGr94lM1Vi7h+roxGgkjWytSXjcu/gRDC+aKex24V3N0VopFIWzOFK5tD76w4vyzDohqC/UjomGcL0uBkhzHI3Fvv5VJcYIoM78Dd0XLAIIUqwcs8ueAWouFJjF5GIZnvcJ/xnDiOb7DEPu1f7Q7axmqE9icuzU3AmMWkDNWeSis6tOnPrxnBmZ8kuqrMvUzSUEwvuFNIm6f2hJ636BKwMVljTtEkq5hBy2lpWCA9j7Ir2h/0BEXXgppil3FPkFUcmje5C9lwOIW1W60cWvnFFAPezhziRBrCkape+VZebUIEmHPflg/PQ1tBFXx30xy2+T+BfBqDD7Zzx7zDgOknwJwaVPoGTtQH+lInhp9CDSRAAsjn7xRfO6TO3mgh3qlmLkQ01/ZEZFNGrmNIF9hjPe1XpQ4A3rMhR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(39860400002)(136003)(396003)(6512007)(26005)(2906002)(36756003)(54906003)(6486002)(6916009)(316002)(41300700001)(6506007)(478600001)(86362001)(2616005)(8676002)(83380400001)(4326008)(66556008)(66946007)(66476007)(7416002)(8936002)(4744005)(5660300002)(186003)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MQu3Hy2MEzxwfjVPEqyNRjlPe31qx/cd7XldQE6Kt0xM+gawVFE+SvrMck8P?=
 =?us-ascii?Q?xlHdbDQ0sCnuIUXzEJoxCHOdMy2gLA+2Bvmd8xrstBGGTKeF2wAPpiHc9f1e?=
 =?us-ascii?Q?iKkLhv3EhCDWvBTsuMRryJG2lrLCg5jC0Rc0CnsEGYEClABBEeuUg+/o8gLl?=
 =?us-ascii?Q?lWJbsGHoIO13nZxKGRdE3mN7uBzdr6NBqFe/iRBdQyCbksCZmWrv9kFTkn1w?=
 =?us-ascii?Q?qao/9PLwO2wLxjhT3nEAUF7GWSye+U2xQkEcfkWtkm8DH2iYAKZxHckvMTL+?=
 =?us-ascii?Q?NxhaQfTUq/qASXJA7kl+9N9JBR1qXeEm0+7UUorEv7PqG+7ehM7guD/x6L7C?=
 =?us-ascii?Q?PPLdITLnKyhI5IpV+MMlZXaguHDO2cKJR/6Jt5nF0rQOBxsUPDGua28VJTT3?=
 =?us-ascii?Q?GK81mbNc0y0H4W0mR4Dfh7zJfVJygM8PPrWWmTnjvsSy6N6IN6HvepVcuzb9?=
 =?us-ascii?Q?WO9QpkXHzb9xFNytmg2VOv2atYYBvvhPPeJK5Obbl7xMw01VxFF36WjTyhWX?=
 =?us-ascii?Q?jNDy9ZGgGO4trPjAa+SYijZa/hJyHXelVTCtRYhHp4Yh+E54G3ZRmTMQTv4l?=
 =?us-ascii?Q?c4/QiVftLC2m76gr41XsfAFcjFbCxIiWmwYwwYv1nMsHlCUGjbyXV9vQQS9z?=
 =?us-ascii?Q?jcz8TeRCKYHOXSXlr9a/ltlAH9GTSh9HZ3f2jrzoeoY+gvFRJkIEsZ7KA3PW?=
 =?us-ascii?Q?dVKvb40c2mpxQW24blJiz+FXY8h49ZCbyKJtLSYlcgOU7c3ammVkP8HTOFf9?=
 =?us-ascii?Q?zSOkDbhV1lQEIdm96Dm1er9pMIWPEe2P5CQYOTt5PkHP6+kng955QOWV24bp?=
 =?us-ascii?Q?6loHZQhQD/hvHDDXgm6Bv2kYtULVJt/Iif9RNtyKM943zjLMjLUPwOz+cH7F?=
 =?us-ascii?Q?anPirU5od1qE212tMS7S7WlB52kkBpiv0YQ01dDB5mh5I8bLYLIozXX03PWQ?=
 =?us-ascii?Q?UR9K0a1aBLWtqQwS4U+VUnP264Y6/d+IzS6fsg3FdjKMbqaRbpg1k0AFAEXZ?=
 =?us-ascii?Q?6r7J9oN53dXuoyx2jUyhDmRzSXP9+FgTcdMDQpEj6HnJssy62wrMouO/eS5v?=
 =?us-ascii?Q?Y9jz5Fy42S9Crq3NOcPz4kCWkXRoWEV4HMlqQC2xjMmA2vL9phUr/SfhzOS+?=
 =?us-ascii?Q?hfF0ImkMchF3jY2E1fDge3FHkUfqQmBe6v4hxjiNTflH25QdI/7ykVMMJAOy?=
 =?us-ascii?Q?IJvmnQkRyr9MTWNfsyh44siuU1115fu3i3GTKVzw/GduvbOEL3SqJfT7KzW+?=
 =?us-ascii?Q?k1Bk4l07s73I6urg8SaiKXOfT5vlxg5aQQ82uw9q7EXLbHGVS91ffKGQF538?=
 =?us-ascii?Q?mXKQ337h7WOuWSK2l9qV8Z3goP3MoQh97pAqamZI+cpVWL56MERAUzi+iJGI?=
 =?us-ascii?Q?I9uirB2ZPJ3pENz3v5rLjfCHdAp4q1SpzJiSjUeYXkCLjH/9ZK8GhcLnwPYa?=
 =?us-ascii?Q?I6fyQlOY75Fb89HKNxYydfqwiZV0keFBraPcC3qZK1ed8LXGGrvCzUJymEcZ?=
 =?us-ascii?Q?YTEZhVvYcGGsczgP8uN5GJqvLccB+n2AIZVTSSs+gMUjaKNpLukp2F27+AEW?=
 =?us-ascii?Q?KjVgBXanurR7G+s3iyxMWoelvhVJ0d2SrMnmc7uf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1f4462-c4a5-4d0c-1fa2-08da876fa9f9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 14:31:29.0860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJztvkHtEbg7GukA42ZVtMoL3wrVdKGHXNLqUm7XIKfd9TscJPTQU6AO+kJY/LwK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6044
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 26, 2022 at 08:11:35PM +0800, Lu Baolu wrote:
> The ARM SMMUv3 hardwares support blocking DMA transactions by clearing
> the translation table entries. This implements a real blocking domain
> to avoid using an empty UNMANAGED domain.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

IMHO I'd send this separately since it optimizes VFIO today

Looks OK though

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
