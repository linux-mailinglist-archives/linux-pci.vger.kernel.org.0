Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882575BE836
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 16:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbiITOLz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 10:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiITOLa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 10:11:30 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79C45F7D9;
        Tue, 20 Sep 2022 07:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nP9hE9mI85Qy8fLkfwdj9HF904Wf12uBBbnU8TlP5SCF+nFBpdl7Bl8Thbfm79O/qLRFXM4AJqA0U34tHWGoe/k7WTrJzDq9/PxG8yTZm8cqgbSYCPVgU3i3SEZb6GaWDCwOV9/TNvqQKWyiyhdo8+vID9Ds4fxu47qPDaBwqyZZBJHYtDqqao1QwfIoC7PjVIAwMh6BzI5VvsVzRQXVCTltS+TuSZWJNxkEO6AVWitjccIpbOhukns71Sw4ecnhzEEZb18joc6RdV4FwqeW7wAI9PG3O+Z2oU2ydIsWDhcLoNBq+3QcZMpq+yRbByzaEJQ50iy0xltPn9YXaFkABw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xr0DaXmsSxqaTvPy/pKltDeoycmlK91zo6knguWQqCI=;
 b=Z2yFthyCTJkyBMQqCBYFfFM4a40mtni/FZRZXzZQaQ3nN402oq2R8VZw6DvU9qO+bDN2Sg15FPHC/P0eQ81h3pDKWl+FyutpF+NI0reiWszqG68dRUKOJBx7/3jWPFnKhMEoHapu694j/epc7XN4b3oLtqPJIkRGRaYJqJWaCK8mGwWO/MbwCJftve71I5XthTrL6AiQStpXjCs+M2dLs6WjuQdHu/tRgyXRNyv+H6twKNd3I4elGqaItEu4YHrL1JItPiCKfc0zrEHxBa2AU55XYh9t5IWprgGAJrlCFoU2i0lLkOXha1m+wWx7hwAVspOL2QAURw8mJoJ3/7iV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xr0DaXmsSxqaTvPy/pKltDeoycmlK91zo6knguWQqCI=;
 b=n/ZfB/KdDYMuJPjYWeEjFXXyVWCFDS6+GmDR1t7GTwIX60zOs0rkDiP/WIpY5zT2nLhJ0gq0FyoVfP1kYZpOWOi8JjTaCUnlM8JF5rO5wR899QpeoN2LuSXphspC4N168xfa4gjfhMxP6SAQr31DstZnIOSQnjH5O6hKDfvXCAPKBkuBEVU3zXDfL9uo6pewME8yNGbJATU6QXYNZ5t0b7Az3+aV+BrcExQnvXJxbeKRCUx5zSltwAcrqBlvdeq+E+4wr080PhpPzCdXC3UGyzSNgfkO7Q4+VTjerkI23JXVDrc6dLCmGOJ1PWX+Zb9s2HpkXzDdYe4S0wpOBzAJOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY5PR12MB6108.namprd12.prod.outlook.com (2603:10b6:930:27::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Tue, 20 Sep
 2022 14:09:46 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 14:09:46 +0000
Date:   Tue, 20 Sep 2022 11:09:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, "Rodel, Jorg" <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <YynJqID/E5dFCakg@nvidia.com>
References: <8735n1zaz3.ffs@tglx>
 <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com>
 <87fsr0xp31.ffs@tglx>
 <BN9PR11MB527625E8A9BB854F3C0D19AE8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
 <875yrvwavf.ffs@tglx>
 <BL1PR11MB5271326D39DAB692F07587768C739@BL1PR11MB5271.namprd11.prod.outlook.com>
 <87fsqxv8zf.ffs@tglx>
 <BN9PR11MB5276961D838169BF237928E18C499@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276961D838169BF237928E18C499@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0430.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::15) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|CY5PR12MB6108:EE_
X-MS-Office365-Filtering-Correlation-Id: 49608e05-b377-4f49-9358-08da9b11c57f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n9L5IGx5hLaK4+uR4oc1tdlN7gpnVXMUiUtBgCO4mLpCDWfvYrHuxbgkHHwZMF9TuhKZctfsh+Ec+Mh+d2gOuEF/osWTZ959e9I+MsiGNX+TIxnFD8ftu3o82j0/o5gqPNaRBSgEmEdq9oNeoaZiN9tVWxckue6/LDe8LifjYgkFG8BEYlJdbQgs42fEcPDCmo/CBiZuECoph9etMKDs3qn3HTqKu/5wwpTbRBvFAbVl3Vaz3eIzZGM1lv3KF/ki1uI1y6+DW49EuufqeYZkqFFZXwzX3iZf2Vkxm7sE5pNu5YS+7usiaLQn8d+7gl4huH6n8gukI47C8q7P0QdIGJTtIaRqTBsO56pxwt44LLTQXD/SoL8WX3i+8//cro/VFL0+PrF8DZhaqn/FeFSy0bBQqyWnEGfW7ShRW1eIC6qgfeKyc0x+zzzXjH1Q8iNj+tyiwjFPJaqJJtr6t0Mj4d9/CT40Tf+ZcQtXXgWMkppUHNL7GVYVPGtP3rfwAHVzxMDShhNSZG5tl6WD+OVFCtdgErtUvgCYI8FD+hTd0P0tcVKUagbWdTsh0EAPKyl2IyL9C2T/7+KRgVMdnCZeBoaaMJ5VaIsQI0m6ecixIfWdYq+kPDn0B5x4Lu3BnEkVp6sJ4coZOXdwYP3vl4IrwroDUCbv4UQrJzxicmmnWTAFDFOSgOuZhLxF5P+I8UZ0rBITctvMQS/7NUKXKSal2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199015)(6506007)(6512007)(478600001)(41300700001)(26005)(6486002)(4326008)(36756003)(316002)(6916009)(186003)(66946007)(7416002)(66476007)(66556008)(54906003)(5660300002)(86362001)(8676002)(8936002)(2616005)(558084003)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oRExy323pHmeV6Nhl0Ch6gi0iOxlUYZC56oRSY9XtQXi1wAkzwgrA1UY8Q6O?=
 =?us-ascii?Q?t8RoDr+Y1citYYXEVjHdzN8L4s4/VPcBlPLCfsB8sEAs7HL/CqCX0QGqkTru?=
 =?us-ascii?Q?ExA4g4Q9tDc3mAgosEIp1qdEiYkQp6Vf0BDUDb1Xnwne4hi86zGzuzDREQ1x?=
 =?us-ascii?Q?ynKL6bqiPvvevoIygHpPIL9YzHL3u2Yx4GKjPPI/SwhoVaeSFwxj3hFnrycn?=
 =?us-ascii?Q?n3NhOaiUB1tOwg+VydDeqVncQhKXinW0QH0kfYBEo8VqT33L8vC8DpCA0u/e?=
 =?us-ascii?Q?qm5yVJEak20yR1sKxm7y9pmHmn0OqECXky33usSoijubV91qGnRDYIJU+O3z?=
 =?us-ascii?Q?FZYs/G6Juw4yAYAkHwKXyIF1KvW1aCJlCKckwj8QCXgTZOtwMJ9n1lRKxc4l?=
 =?us-ascii?Q?/IbN3VQYNydb1ZLjlGm4pXTqGgWrYdjbR20Y50hsROZG+LbWBgJpxIlJEaWB?=
 =?us-ascii?Q?1SXef5PSn2n2uXnh/jcmgRa3Un9282DNVJLIHGI3a4p1x4PAsHb46cQJkhky?=
 =?us-ascii?Q?fDVr7FNoaGikWxljoZrXbghHgVfHczRB/Q+aChrwWllicVyzr4Z78Gbx988x?=
 =?us-ascii?Q?1VSb3eMObqUKKDwPrbQRH/BJXTsjeiEqfFnBtdsVVDWSS5Jndxv9eK16jJk3?=
 =?us-ascii?Q?7CX5Wsb6udck/A9EUC2wnuUpyKLy2mzOE+Lu4nncrMEDA8dNV+NXO7xNbAdF?=
 =?us-ascii?Q?SJv3fzl64k2qO/2OYh0+Pe7EmibCmt1gsnHhDYCBrgOPxlxbDmpUwuGOV3R/?=
 =?us-ascii?Q?hwJ4wKf66vjV8919qt1mLNDmskSTNx1DsIKMmRRdu8qadDcAazT97avb6uWb?=
 =?us-ascii?Q?gXNgi4mUec4hn2i5Y4m4XgUYTKQ8TSrDaMgrUaJNOYaViefs9XMjVRY8AOc2?=
 =?us-ascii?Q?sbZA5r1GpBdaNtil1lrP82kd4aPP6X2PGt7PB45+YuTEV0UE23/whPC7pvrU?=
 =?us-ascii?Q?9PU6MSdpcwdRI6SiVMhGDYiGO3AY06x7KOhFqkhTv6gGzJujtH2zxHt0EYBn?=
 =?us-ascii?Q?AYBTLZ16eDLDg7UXF1FDgrsgoWaLFntNsVnL+Y4MMnM5BbAGNXe1vmGmmn25?=
 =?us-ascii?Q?mODQKjf5SjGFaut9GyNKWZROkVAP8ac8I29DOor1PcHYLnkkqbLt+uMM046P?=
 =?us-ascii?Q?fWr+r8SPN51U/KAE8wuLqJFkj87w9SS7804Hzjy84Bb5SRvht5TaiMgej/mN?=
 =?us-ascii?Q?TGe9CoZ/u2WKlvbSbE45o89tBoEDdcXGXPHyrzkI9n1uSRKv4OLJu6WJs601?=
 =?us-ascii?Q?C6+vEu5uh7xgIHayoYGm4def3FGzdTdSlWfB6mK1pW2sARjuDwjULrPqMcUH?=
 =?us-ascii?Q?dqdjylr6H6eBqoH71q1DuEjP1VuaqPuz/pQl0AXcyftWQHC+JtGQdLI0zNh5?=
 =?us-ascii?Q?ulvqUJjH+T58R0IuyNZ867MO9kHCwOnt0pt98Sm2tGD2Iker3VQZjS0FvfiJ?=
 =?us-ascii?Q?YqMaS63Bf57m3TzutcLAfRkMdfH0qYjUqzck8qyX5/fHE6gPUf4DavsDQ0pR?=
 =?us-ascii?Q?kHQksjqJy3Qu5Ztb+d47B3HwO+diva+jcf3yc4syW+g7awkfEFwOrGlpSC5O?=
 =?us-ascii?Q?QjWpzZq7vB096/AfeCs8FnRdp5W7uzPuBfpALdWN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49608e05-b377-4f49-9358-08da9b11c57f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 14:09:45.9536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9NxtvBz6CEgTTXtd8LhXkF1+4doAQ/hZVi2+AAwrgXAgtTWC82VM0GXWRHthLkx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6108
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 15, 2022 at 09:24:07AM +0000, Tian, Kevin wrote:

> After migration the IRTE index could change hence the addr/data pair
> acquired before migration becomes stale and must be fixed.

The migration has to keep this stuff stable somehow, it seems
infeasible to fix it after the fact.

Jason
