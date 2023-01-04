Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0968165D2C5
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 13:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjADMen (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 07:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238969AbjADMem (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 07:34:42 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5711ADBE;
        Wed,  4 Jan 2023 04:34:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAASTfk0wwbed43sxdFIecIZX3dSv6pBgtZGKb7mKtr+kuWR5TvAyFJMYmdRr5QxaOptTQVYHrPXMcPVsdF0rKCLtAMafAA42NBUoZVG2/9JOgHeZJtTq5TdH9SYBD4V03DuJhIDlSGZjw6Yc3wtjnlUXj3254bNHV4z6yqEDx05u438/vKtvftBS//s1LTqDLcTXIC29B/2dNbNwODquBpwR+gTjG6oEjv9pl7HksX0AROkgUQfSFbUdY0ghqgHYpuixAHSJMT11pVKDwX61w+Wvo/lAXleYZWeXbIDe+l9V0KJR8Yk4E7AqA04D2YAU8FH6H0t+hPMMGazDE/7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNYUnApwgKwTBzjN51KTNiz+R37T4HXJviUDLIT1gOw=;
 b=kUB8V93fDPDnHaftAD0vsajajYhSVvI4MvaTtcU07A1xG53wPdAVoyPWg2R+9v+3GcyyNmL5kIjszUiFhbOO2Tf1iwOsi6Mkobjp7IQKVFtxgxZdOn8wZ2ZqcwvWW80PYF+uElVXdTlgBKrFUaojT941Oa7O92oyRWJiJVOa4OikPx51iIkzOztHPr6d9KWkNJh5MnydtlyvVWfGZXr+zWtu+XkGnSYMhOD6mTpCD96ijjHAcEim9WULl5agPlkzc0PaWdPa6AP0Ike39UsTxhn6uf4TTzzvQSTTfaKrkXA66nP5Cl3rXUQwod0NjImBkUgrc9LSy5TpzLkOQiHbQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNYUnApwgKwTBzjN51KTNiz+R37T4HXJviUDLIT1gOw=;
 b=GM38FAxgXax+7TSGtbTYZXQnvNRDUbnMgP4DZ47CjIjR0JigRk7usNtSrmgJL+LZSjzTslWTVpxyBJCLHQK3WgBoiaBWfQ0KqjWqpJXo+bvK2LyZecP8p+m3pBxiejwJCTupR935mVxn9txia5CopPZZPlIEvP3mPmDeVGaDGSHIAtV63z6w63VbRQsZ6iTsqpYCydyDGUgNamjBTMce+WkZD2m1ymsaOss10uHb4GpDtWD84RsRqRPfziye/Mga2yhflbTa6MAoweKNJqGRWHJO+p9/1XT1t7ly/R1CQlAGYOR44im8dwxZq/n5Wxb2NGMYs1n7orB1F9nBE8ARpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Wed, 4 Jan 2023 12:34:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 12:34:37 +0000
Date:   Wed, 4 Jan 2023 08:34:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Moshe Shemesh <moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>
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
        Allen Hubbe <allenbh@gmail.com>
Subject: Re: [patch V3 13/33] x86/apic/vector: Provide MSI parent domain
Message-ID: <Y7VyXNbWMdWWAC6d@nvidia.com>
References: <20221124230505.073418677@linutronix.de>
 <20221124232326.034672592@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124232326.034672592@linutronix.de>
X-ClientProxiedBy: BLAPR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:208:36e::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM8PR12MB5447:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd01129-6204-4283-b465-08daee500af0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jUkJ7mdmfsWlzJ3fmQbZXKsUCRCyBmf+GECIsK9VLbR2ygRuPUuXmNQCh9E2IC+y7OxgSz3XeGzjGmYqkPBgrjBDUy7zIX8FJkWiswt03Jg3H16NVSozLw/zeoOTGo4V/a7qzJVrWV9upDJrIoHNznhqfymp7arBviHjc507UA6O6VDGOUhBt5OWPVRNBNWm2E6aEMhqFkZndeZ/qyXFmqgwu0rRWTgnTtSntAjjyzrNYUWIYtXtXtyrl5WvkiqZcJf/6CM4fsrg+nbnVu8cupQhmmCY7kkhPQ6KbhhQkZEx/hwzoJc4mOoeka1q1QpF2VnT1hkGZXZzYhZ9yAmVopPj9vnCB5ryqS0+vEZMuqVy7BQTxn/K5NZCwYA1tSt7uJSAjnFjDnENfnavxTdpWfzvJkPIesABciSgUlLcdUsf66Sw4N1LX0oYP7yRuJRatX6lociaFPqVnEQj25H/0Ut/WdLhrgAjulO5In6I3D74V/H5NElrOR06MjVyghguKcVH27m2ZlxT8YfisTgiOKgrG8o4FQij/u9hXXEot3gM7bkpNMtTaR8XyQNyEr9hGKRxpAK0dSQC4C3bW0czhAd8KdFf7C7UyVcrRoLinGf/bnx4fHdVWCFs9KUVEgJYVVNLBDyHU6vaW2rIrRrug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(451199015)(8676002)(66556008)(66946007)(4326008)(36756003)(66476007)(2616005)(41300700001)(30864003)(6636002)(316002)(54906003)(38100700002)(110136005)(2906002)(86362001)(5660300002)(6486002)(8936002)(83380400001)(6506007)(478600001)(186003)(6512007)(26005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ADU10Kb+MbRmp4a6K+s49q11wP0iM88pJG1ggzM9nz0NZwc90VMP/RhSsqfm?=
 =?us-ascii?Q?TfsQRSMyr8cb6zacIjwi4s3lByU5EznRGQpNIlu5aV5dbZkp7Jo7Y164uLxB?=
 =?us-ascii?Q?BH2BGQJFA66BWdEWXqHIkLGNIl4y5RCFPd8ZSNS+4HXsIgc0sFDbxGVEsLfo?=
 =?us-ascii?Q?R0YJgGr3kMNmr/GpwC3BFbZGrPeDIjbH+RGOh0cpNSDdgiq5m0rbZIei2mZL?=
 =?us-ascii?Q?0kUPlpBWIdOiquCCs5wjYrjoLIix/fpnZoFfxSHhuOXN7EIT0pDlB+feYMdF?=
 =?us-ascii?Q?u9B6AJmgJizENEXu+eiZ3GohSPilcPesW+7gEJrayqT5G7zre3BprHQXnn47?=
 =?us-ascii?Q?qfWwA1alhXyrts0a1Df/e8qjTZzu0WJqIIBXgE93PLTplAaYOHowJEeozA69?=
 =?us-ascii?Q?1wZhcbqXoHiOQszy9lwnBL7iitEo/CNvxdtnga9ut7MrAFvfWYldu/WUW3bH?=
 =?us-ascii?Q?TdqokZ2t3MQ7OaIQr3GB4/AL+2RWMfGHPoOK1/yfqGpUY9/p+0E9hU4j3sMo?=
 =?us-ascii?Q?PySdI7RWym3L600DqBeyxguJxWnJtlpdMMff7TKNVBSZ6xeqBVF+5NGEgEk3?=
 =?us-ascii?Q?QIN64ie9a7dB3EXScqFFRNtm5BQ2ArNSZaHMI106yZssAiwjDYPOd/7M/Tbj?=
 =?us-ascii?Q?L6mENgP2LSQ9uZiy5qN6ZzgCL0IxqAB2jSlw/HkhIiLvw4yLTxl74IpEzIot?=
 =?us-ascii?Q?HH3LN1BWHjqJlhCVqOTfVkHxNrGkFEVaRncxlEffrru7GTlkPIvdJvDrSyOA?=
 =?us-ascii?Q?AHns26IOH+Ez+X1sLmgla6jmhixp75m1NiwSeVWXTc27V0H+f1JkId0JFASg?=
 =?us-ascii?Q?LBIifftC0XnTeKwQSfJum0VHheVxd7tGOX7g4lWTGTjnjEL+X5HHdzs95mtL?=
 =?us-ascii?Q?CrlWf7vqvJRQgzbs5hzKCRnQsT9g6pZSiw/QJaSOvmOAorzNgiqYn7P67Zf4?=
 =?us-ascii?Q?1Zc/xLyP5OdnYPS+kodGq+E9EKW+aC5tRftDw11k5sWUTjlKzehUmTSgRk4F?=
 =?us-ascii?Q?owJuEOKSQUmrqJA4/oZ5aZWhjBGsW2Qyx/ydqKT/uwBmvaAeIu5TWx2+vMlx?=
 =?us-ascii?Q?aAHJL9VtwiPUsRtHhj+DIuuvznyQnvseJai3SrvyOlOSTsbzEGArDALevOXE?=
 =?us-ascii?Q?rHgUquNiwRirqnhZ5xYbayODwQ2fOfzC0KAvgzVitPFOIoEhe/3tZ9mQhgoj?=
 =?us-ascii?Q?EJqce9FEZwN6/HJayrljvsl7tO5pmdWC+Mfz4yg+uIXu/dF4hJ0fWhXwIXOS?=
 =?us-ascii?Q?SE/mMQqvIPcNLbipAT2nmMsI6PQOCRluB55XgZl0JQNYpQshCryehcTUKDjy?=
 =?us-ascii?Q?RzFzhmjuz+TWWAOhTgmyNQcmKf4g8cT5/YAAGf3LS1rZYh7nV+kaBcQp+cGX?=
 =?us-ascii?Q?sSgxognSA5A9QmICfS/y9ppBOTTEQaJFmL3Q5hXkbhD124pxqECcDLBx+7bB?=
 =?us-ascii?Q?QjXize3k9EdYAAlb40gYWcOm9NNNF2NPXGw0YCpqLvN4P1fDKoS2ss1ESs84?=
 =?us-ascii?Q?n/50oI0tiiaHYXPUBlko3BdTpuXwR+eNFdkRyIs4Atizw0zKzOB8i2nz61yC?=
 =?us-ascii?Q?wRVTc3Oz+ivz3xgsaukcD0qVyucdIV4bfF9Gdj7h?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd01129-6204-4283-b465-08daee500af0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2023 12:34:37.6891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p82C6L+2SKmSdXpqb6jUgUH//opxbFXVoR9lpdgsKHWg9G9N9zaOrjdQewIlVJ1j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5447
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 25, 2022 at 12:26:05AM +0100, Thomas Gleixner wrote:
> Enable MSI parent domain support in the x86 vector domain and fixup the
> checks in the iommu implementations to check whether device::msi::domain is
> the default MSI parent domain. That keeps the existing logic to protect
> e.g. devices behind VMD working.
> 
> The interrupt remap PCI/MSI code still works because the underlying vector
> domain still provides the same functionality.
> 
> None of the other x86 PCI/MSI, e.g. XEN and HyperV, implementations are
> affected either. They still work the same way both at the low level and the
> PCI/MSI implementations they provide.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Fix kernel doc (robot)
> ---
>  arch/x86/include/asm/msi.h          |    6 +
>  arch/x86/include/asm/pci.h          |    1 
>  arch/x86/kernel/apic/msi.c          |  176 ++++++++++++++++++++++++++----------
>  drivers/iommu/amd/iommu.c           |    2 
>  drivers/iommu/intel/irq_remapping.c |    2
>  5 files changed, 138 insertions(+), 49 deletions(-)

Our test team has discovered some kmem leak complaints on rc1 and
bisected it to this patch.

I don't see an obvious way that fwnode gets destroyed here. So maybe
it should be like this?

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 955267bbc2be63..cbbcb7fd2bd00d 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1000,7 +1000,7 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 fail:
 	msi_unlock_descs(dev);
 free_fwnode:
-	kfree(fwnode);
+	irq_domain_free_fwnode(fwnode); // ???
 free_bundle:
 	kfree(bundle);
 	return false;
@@ -1013,6 +1013,7 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
  */
 void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
 {
+	struct fwnode_handle *fwnode = NULL;
 	struct msi_domain_info *info;
 	struct irq_domain *domain;
 
@@ -1025,7 +1026,10 @@ void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
 
 	dev->msi.data->__domains[domid].domain = NULL;
 	info = domain->host_data;
+	if (domain->flags & IRQ_DOMAIN_FLAG_MSI_DEVICE)
+		fwnode = domain->fwnode;
 	irq_domain_remove(domain);
+	irq_domain_free_fwnode(fwnode);
 	kfree(container_of(info, struct msi_domain_template, info));
 
 unlock:

Thanks,
Jason

kmemleak trace
unreferenced object 0xffff888120ba9a00 (size 96):
  comm "systemd-modules", pid 221, jiffies 4294893411 (age 635.732s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 e0 19 8b 83 ff ff ff ff  ................
    00 00 00 00 00 00 00 00 18 9a ba 20 81 88 ff ff  ........... ....
  backtrace:
    [<00000000bcb7f3b1>] kmalloc_trace+0x27/0x110
    [<000000008cdbc98d>] __irq_domain_alloc_fwnode+0x51/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000002aec9527>] driver_probe_device+0x49/0x120
    [<000000005f45a989>] __driver_attach+0x1ff/0x4a0
    [<0000000000dcaab2>] bus_for_each_dev+0x11e/0x1a0
unreferenced object 0xffff888120baa800 (size 32):
  comm "systemd-modules", pid 221, jiffies 4294893411 (age 635.732s)
  hex dump (first 32 bytes):
    50 43 49 2d 4d 53 49 58 2d 30 30 30 30 3a 30 38  PCI-MSIX-0000:08
    3a 30 30 2e 30 00 ff ff 00 00 00 00 00 00 00 00  :00.0...........
  backtrace:
    [<00000000bef783eb>] __kmalloc_node_track_caller+0x4c/0x1b0
    [<00000000f16b54a8>] kvasprintf+0xb0/0x130
    [<0000000078634624>] kasprintf+0xa6/0xd0
    [<00000000f17eea1c>] __irq_domain_alloc_fwnode+0x1ce/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000002aec9527>] driver_probe_device+0x49/0x120
unreferenced object 0xffff88812bc8ca80 (size 96):
  comm "systemd-modules", pid 221, jiffies 4294893596 (age 634.996s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 e0 19 8b 83 ff ff ff ff  ................
    00 00 00 00 00 00 00 00 98 ca c8 2b 81 88 ff ff  ...........+....
  backtrace:
    [<00000000bcb7f3b1>] kmalloc_trace+0x27/0x110
    [<000000008cdbc98d>] __irq_domain_alloc_fwnode+0x51/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000002aec9527>] driver_probe_device+0x49/0x120
    [<000000005f45a989>] __driver_attach+0x1ff/0x4a0
    [<0000000000dcaab2>] bus_for_each_dev+0x11e/0x1a0
unreferenced object 0xffff88812bc8dcc0 (size 32):
  comm "systemd-modules", pid 221, jiffies 4294893596 (age 635.000s)
  hex dump (first 32 bytes):
    50 43 49 2d 4d 53 49 58 2d 30 30 30 30 3a 30 38  PCI-MSIX-0000:08
    3a 30 30 2e 31 00 ff ff 82 97 0b 00 00 00 00 00  :00.1...........
  backtrace:
    [<00000000bef783eb>] __kmalloc_node_track_caller+0x4c/0x1b0
    [<00000000f16b54a8>] kvasprintf+0xb0/0x130
    [<0000000078634624>] kasprintf+0xa6/0xd0
    [<00000000f17eea1c>] __irq_domain_alloc_fwnode+0x1ce/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000002aec9527>] driver_probe_device+0x49/0x120
unreferenced object 0xffff888108177580 (size 96):
  comm "sh", pid 9721, jiffies 4294943281 (age 436.568s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 e0 19 8b 83 ff ff ff ff  ................
    00 00 00 00 00 00 00 00 98 75 17 08 81 88 ff ff  .........u......
  backtrace:
    [<00000000bcb7f3b1>] kmalloc_trace+0x27/0x110
    [<000000008cdbc98d>] __irq_domain_alloc_fwnode+0x51/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000002aec9527>] driver_probe_device+0x49/0x120
    [<000000004aebbb6e>] __device_attach_driver+0x157/0x280
    [<00000000c3894808>] bus_for_each_drv+0x123/0x1a0
unreferenced object 0xffff8881525f1680 (size 32):
  comm "sh", pid 9721, jiffies 4294943281 (age 436.568s)
  hex dump (first 32 bytes):
    50 43 49 2d 4d 53 49 58 2d 30 30 30 30 3a 30 38  PCI-MSIX-0000:08
    3a 30 30 2e 32 00 ff ff 00 00 00 00 00 00 00 00  :00.2...........
  backtrace:
    [<00000000bef783eb>] __kmalloc_node_track_caller+0x4c/0x1b0
    [<00000000f16b54a8>] kvasprintf+0xb0/0x130
    [<0000000078634624>] kasprintf+0xa6/0xd0
    [<00000000f17eea1c>] __irq_domain_alloc_fwnode+0x1ce/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000002aec9527>] driver_probe_device+0x49/0x120
unreferenced object 0xffff888155ac9f00 (size 96):
  comm "sh", pid 9721, jiffies 4294943493 (age 435.768s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 e0 19 8b 83 ff ff ff ff  ................
    00 00 00 00 00 00 00 00 18 9f ac 55 81 88 ff ff  ...........U....
  backtrace:
    [<00000000bcb7f3b1>] kmalloc_trace+0x27/0x110
    [<000000008cdbc98d>] __irq_domain_alloc_fwnode+0x51/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000002aec9527>] driver_probe_device+0x49/0x120
    [<000000004aebbb6e>] __device_attach_driver+0x157/0x280
    [<00000000c3894808>] bus_for_each_drv+0x123/0x1a0
unreferenced object 0xffff88816b4dfd40 (size 32):
  comm "sh", pid 9721, jiffies 4294943493 (age 435.808s)
  hex dump (first 32 bytes):
    50 43 49 2d 4d 53 49 58 2d 30 30 30 30 3a 30 38  PCI-MSIX-0000:08
    3a 30 30 2e 33 00 ff ff 00 00 00 00 00 00 00 00  :00.3...........
  backtrace:
    [<00000000bef783eb>] __kmalloc_node_track_caller+0x4c/0x1b0
    [<00000000f16b54a8>] kvasprintf+0xb0/0x130
    [<0000000078634624>] kasprintf+0xa6/0xd0
    [<00000000f17eea1c>] __irq_domain_alloc_fwnode+0x1ce/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000002aec9527>] driver_probe_device+0x49/0x120
unreferenced object 0xffff88812e17e380 (size 96):
  comm "sh", pid 9828, jiffies 4294944405 (age 432.160s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 e0 19 8b 83 ff ff ff ff  ................
    00 00 00 00 00 00 00 00 98 e3 17 2e 81 88 ff ff  ................
  backtrace:
    [<00000000bcb7f3b1>] kmalloc_trace+0x27/0x110
    [<000000008cdbc98d>] __irq_domain_alloc_fwnode+0x51/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000002aec9527>] driver_probe_device+0x49/0x120
    [<000000004aebbb6e>] __device_attach_driver+0x157/0x280
    [<00000000c3894808>] bus_for_each_drv+0x123/0x1a0
unreferenced object 0xffff8881557a9bc0 (size 32):
  comm "sh", pid 9828, jiffies 4294944405 (age 432.160s)
  hex dump (first 32 bytes):
    50 43 49 2d 4d 53 49 58 2d 30 30 30 30 3a 30 38  PCI-MSIX-0000:08
    3a 30 30 2e 36 00 ff ff 00 00 00 00 00 00 00 00  :00.6...........
  backtrace:
    [<00000000bef783eb>] __kmalloc_node_track_caller+0x4c/0x1b0
    [<00000000f16b54a8>] kvasprintf+0xb0/0x130
    [<0000000078634624>] kasprintf+0xa6/0xd0
    [<00000000f17eea1c>] __irq_domain_alloc_fwnode+0x1ce/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000002aec9527>] driver_probe_device+0x49/0x120
unreferenced object 0xffff88813f624380 (size 96):
  comm "sh", pid 9828, jiffies 4294944654 (age 431.208s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 e0 19 8b 83 ff ff ff ff  ................
    00 00 00 00 00 00 00 00 98 43 62 3f 81 88 ff ff  .........Cb?....
  backtrace:
    [<00000000bcb7f3b1>] kmalloc_trace+0x27/0x110
    [<000000008cdbc98d>] __irq_domain_alloc_fwnode+0x51/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000002aec9527>] driver_probe_device+0x49/0x120
    [<000000004aebbb6e>] __device_attach_driver+0x157/0x280
    [<00000000c3894808>] bus_for_each_drv+0x123/0x1a0
unreferenced object 0xffff88813a95c440 (size 32):
  comm "sh", pid 9828, jiffies 4294944654 (age 431.208s)
  hex dump (first 32 bytes):
    50 43 49 2d 4d 53 49 58 2d 30 30 30 30 3a 30 38  PCI-MSIX-0000:08
    3a 30 30 2e 37 00 ff ff 2f 5f 5f 70 79 63 61 63  :00.7.../__pycac
  backtrace:
    [<00000000bef783eb>] __kmalloc_node_track_caller+0x4c/0x1b0
    [<00000000f16b54a8>] kvasprintf+0xb0/0x130
    [<0000000078634624>] kasprintf+0xa6/0xd0
    [<00000000f17eea1c>] __irq_domain_alloc_fwnode+0x1ce/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000002aec9527>] driver_probe_device+0x49/0x120
unreferenced object 0xffff88813aa3b880 (size 96):
  comm "sh", pid 10020, jiffies 4294950696 (age 407.044s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 e0 19 8b 83 ff ff ff ff  ................
    00 00 00 00 00 00 00 00 98 b8 a3 3a 81 88 ff ff  ...........:....
  backtrace:
    [<00000000bcb7f3b1>] kmalloc_trace+0x27/0x110
    [<000000008cdbc98d>] __irq_domain_alloc_fwnode+0x51/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000000d688957>] device_driver_attach+0xae/0x1b0
    [<00000000003e203b>] bind_store+0x150/0x1f0
    [<000000003b2d7ae5>] kernfs_fop_write_iter+0x348/0x520
unreferenced object 0xffff888142df4b80 (size 32):
  comm "sh", pid 10020, jiffies 4294950696 (age 407.088s)
  hex dump (first 32 bytes):
    50 43 49 2d 4d 53 49 58 2d 30 30 30 30 3a 30 38  PCI-MSIX-0000:08
    3a 30 30 2e 32 00 ff ff 00 b0 f4 60 01 00 00 00  :00.2......`....
  backtrace:
    [<00000000bef783eb>] __kmalloc_node_track_caller+0x4c/0x1b0
    [<00000000f16b54a8>] kvasprintf+0xb0/0x130
    [<0000000078634624>] kasprintf+0xa6/0xd0
    [<00000000f17eea1c>] __irq_domain_alloc_fwnode+0x1ce/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000000d688957>] device_driver_attach+0xae/0x1b0
unreferenced object 0xffff88816cd32780 (size 96):
  comm "sh", pid 10050, jiffies 4294950903 (age 406.300s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 e0 19 8b 83 ff ff ff ff  ................
    00 00 00 00 00 00 00 00 98 27 d3 6c 81 88 ff ff  .........'.l....
  backtrace:
    [<00000000bcb7f3b1>] kmalloc_trace+0x27/0x110
    [<000000008cdbc98d>] __irq_domain_alloc_fwnode+0x51/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000000d688957>] device_driver_attach+0xae/0x1b0
    [<00000000003e203b>] bind_store+0x150/0x1f0
    [<000000003b2d7ae5>] kernfs_fop_write_iter+0x348/0x520
unreferenced object 0xffff88816b1df980 (size 32):
  comm "sh", pid 10050, jiffies 4294950903 (age 406.300s)
  hex dump (first 32 bytes):
    50 43 49 2d 4d 53 49 58 2d 30 30 30 30 3a 30 38  PCI-MSIX-0000:08
    3a 30 30 2e 33 00 ff ff 00 00 00 00 00 00 00 00  :00.3...........
  backtrace:
    [<00000000bef783eb>] __kmalloc_node_track_caller+0x4c/0x1b0
    [<00000000f16b54a8>] kvasprintf+0xb0/0x130
    [<0000000078634624>] kasprintf+0xa6/0xd0
    [<00000000f17eea1c>] __irq_domain_alloc_fwnode+0x1ce/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000000d688957>] device_driver_attach+0xae/0x1b0
unreferenced object 0xffff8881620cd580 (size 96):
  comm "test-ovn-2-swit", pid 10619, jiffies 4294958587 (age 375.592s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 e0 19 8b 83 ff ff ff ff  ................
    00 00 00 00 00 00 00 00 98 d5 0c 62 81 88 ff ff  ...........b....
  backtrace:
    [<00000000bcb7f3b1>] kmalloc_trace+0x27/0x110
    [<000000008cdbc98d>] __irq_domain_alloc_fwnode+0x51/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000000d688957>] device_driver_attach+0xae/0x1b0
    [<00000000003e203b>] bind_store+0x150/0x1f0
    [<000000003b2d7ae5>] kernfs_fop_write_iter+0x348/0x520
unreferenced object 0xffff88815cd13700 (size 32):
  comm "test-ovn-2-swit", pid 10619, jiffies 4294958587 (age 375.636s)
  hex dump (first 32 bytes):
    50 43 49 2d 4d 53 49 58 2d 30 30 30 30 3a 30 38  PCI-MSIX-0000:08
    3a 30 30 2e 32 00 ff ff 80 55 5a 07 00 ea ff ff  :00.2....UZ.....
  backtrace:
    [<00000000bef783eb>] __kmalloc_node_track_caller+0x4c/0x1b0
    [<00000000f16b54a8>] kvasprintf+0xb0/0x130
    [<0000000078634624>] kasprintf+0xa6/0xd0
    [<00000000f17eea1c>] __irq_domain_alloc_fwnode+0x1ce/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000000d688957>] device_driver_attach+0xae/0x1b0
unreferenced object 0xffff88816c302400 (size 96):
  comm "test-ovn-2-swit", pid 10619, jiffies 4294958796 (age 374.800s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 e0 19 8b 83 ff ff ff ff  ................
    00 00 00 00 00 00 00 00 18 24 30 6c 81 88 ff ff  .........$0l....
  backtrace:
    [<00000000bcb7f3b1>] kmalloc_trace+0x27/0x110
    [<000000008cdbc98d>] __irq_domain_alloc_fwnode+0x51/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000000d688957>] device_driver_attach+0xae/0x1b0
    [<00000000003e203b>] bind_store+0x150/0x1f0
    [<000000003b2d7ae5>] kernfs_fop_write_iter+0x348/0x520
unreferenced object 0xffff88812cfd9180 (size 32):
  comm "test-ovn-2-swit", pid 10619, jiffies 4294958796 (age 374.800s)
  hex dump (first 32 bytes):
    50 43 49 2d 4d 53 49 58 2d 30 30 30 30 3a 30 38  PCI-MSIX-0000:08
    3a 30 30 2e 33 00 ff ff 73 00 00 00 00 00 00 00  :00.3...s.......
  backtrace:
    [<00000000bef783eb>] __kmalloc_node_track_caller+0x4c/0x1b0
    [<00000000f16b54a8>] kvasprintf+0xb0/0x130
    [<0000000078634624>] kasprintf+0xa6/0xd0
    [<00000000f17eea1c>] __irq_domain_alloc_fwnode+0x1ce/0x2b0
    [<00000000c57acf9d>] msi_create_device_irq_domain+0x283/0x670
    [<000000009b567982>] __pci_enable_msix_range+0x49e/0xdb0
    [<0000000077cc1445>] pci_alloc_irq_vectors_affinity+0x11f/0x1c0
    [<00000000532e9ef5>] mlx5_irq_table_create+0x24c/0x940 [mlx5_core]
    [<00000000fabd2b80>] mlx5_load+0x1fa/0x680 [mlx5_core]
    [<000000006bb22ae4>] mlx5_init_one+0x485/0x670 [mlx5_core]
    [<00000000eaa5e1ad>] probe_one+0x4c2/0x720 [mlx5_core]
    [<00000000df8efb43>] local_pci_probe+0xd6/0x170
    [<0000000085cb9924>] pci_device_probe+0x231/0x6e0
    [<000000002671d86e>] really_probe+0x1cf/0xaa0
    [<000000002aeba218>] __driver_probe_device+0x18f/0x470
    [<000000000d688957>] device_driver_attach+0xae/0x1b0
