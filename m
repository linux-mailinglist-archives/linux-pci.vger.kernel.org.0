Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594FF5E7B6E
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 15:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiIWNHr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 09:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiIWNH0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 09:07:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A6513AF38;
        Fri, 23 Sep 2022 06:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2eGGsu+I0KstWP8Dpfoooe3GkI0OqWO4zymeR8Nka7+NfQSHRt8AaWHCIrBZf+7G8+HqJ4cz6v5myfRtHanGvR6gTJLq6nU+FMPBgy/M3kAhU9ptoTTUUznrpnPEyZavaqYeZksFuhnG8DzCPUR1PE7KJRptjVtqXhK7P5RwVNcvYyAqxQuwkNdKDMhdNS+dHy5pocK7Y6e1Ed9RYSsfsWz0YsTu/PY6KAU9mdgHxwKUSiCgJUN/x8qZhTRfVRk19EgezTXCO8KeZngPhfoMEfc5czuF0dyYF72MBeikBBjg4OPrUZozSaWQvM7brDUHP6xang3vG7WQgVouhdaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaRz4SYLupJPrRskOvLpbXV2tVRAhgYqLiSkphmqa+w=;
 b=BmlCJhV5dID1OGxOqoyTb9FeqrGCrkuBINU+UQQD0WIR5UpgFzX/vYNKgsVbyD3dnJhl2T77gjruS5hI9VZ66nUnsASs6BfV61HaTo+ksi7h5Jjc2324gar8lVGmdMglct0bCy1OtoKikOxdGQ2fBaH7ulVWetb09yiAXCAHXtUS2DpoW14GAE9Y/tsmWkdtx/rMI0sxTySnDrucPMYFi3cmETUk5C9XlwCLIsiTWHRNRQzZ9v4ha1pV9K/O1nhztF8dCB2t9GOJQorytZ1YsDXXMxZkWFRl8T50O0CFr22iJJoru4xHi4RzfIVnyHU7ml2GWyj5xUyaQqCza7T8Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaRz4SYLupJPrRskOvLpbXV2tVRAhgYqLiSkphmqa+w=;
 b=iQwZbDc8DBOscCg7cv3ag4XHQwwqzhf9ZigufLQWCnNyNg9UIdKLXUljdOE8H05vJDhA1e0IlTguJQBVPlYNfrlWmwwRFwnBK4YM8FSAGj6E8Gx9zrqUaf+a6OB0G/Do8uIbAFQYfC7XhWVJTG6EVLDIBk6EsQL7Ib0bnwldsBxSo8rVbC5WH9fQLtl/Kb2gTGfX/XF0efcQgt++ENfm0cupOvAqURiJKmgHLuDi43/OmX/K8XVl96boT96ZYLhRGNy/SzogGAp4gTpnmxn4v6oOj0ujHyVzsfylcEoLTpiE6nXB/ta97RYbr0OSvisrFphUOJdfHf6wGHnzoT/6jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BL1PR12MB5175.namprd12.prod.outlook.com (2603:10b6:208:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.22; Fri, 23 Sep
 2022 13:07:23 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 13:07:23 +0000
Date:   Fri, 23 Sep 2022 10:07:21 -0300
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
Subject: Re: [PATCH v13 07/13] iommu/vt-d: Add SVA domain support
Message-ID: <Yy2viUjvZsW6gx9/@nvidia.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-8-baolu.lu@linux.intel.com>
 <YyyECCbmfsaDpDgJ@nvidia.com>
 <075278e0-77ce-2361-8ded-6cd6bb20216f@linux.intel.com>
 <Yy2jbsaXuoxgR+fj@nvidia.com>
 <a0b43338-183b-3ece-c85a-e904bee27eef@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0b43338-183b-3ece-c85a-e904bee27eef@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0161.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::16) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|BL1PR12MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: a04cf4b3-b2ca-41ab-d436-08da9d648de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uEwj9xulSgOk7A/TUcuD20rZDvnQ0JL685b5wnqLHxvyWYf56mhhaTq2wKOadAUWQxhM3rQDmyBg4GHXnkiOpHZE6+P4TbN4uyUlM/RFteTlbQj6WDKzmMS277IvtHv9HIsH/7P00AWVkzMRJMhWwnmb609S8PSLQ5s0KkdEF21WPDBEFxOqzsjlI5g41q9/S9D3BNkG9G+NtebFlXodARoABsCHqh5FI4Nyo5fZ4XZtDD4W/wlKyxz/CnBz+KR9kbKiBILD/U1QoDbNFmlXDZecwzf9JbLthB2FrZYZN6cRAimdVXAlJLjZy0Fq0144qfg1eL+l2WxWjF0Oq+DHeckIo18jn+FR3OWA+EyIF9oKZBgyKWa/jSV12oPyWUTCm0kdG8XCqWmkmHEWIH/NWFhIOQOHlOn4DG5/ivyW/Cn3Jv5RPj8ghZNoEqSVxDOSEFKS6J0786mzRFKeaRxhOA+suL7oRCMo6if6lt6MgSvN81+HILvziQxp5fIkPSBQMovkyUkEQMRjG1ivpBdLLuNGACS7ynRhmNzRBD8Sd5vzYqya+mXd3oBf97R+hX2d0jerwLs/ocqZKlQfK6Pb1ndNw6rdFHcQiccmvvBDSdbcZ7BIzgN03TuRm7jf+a3KKufOF+moYqu7iZjoUWDcGEynmMo1QUF3kJKCKg2VR/7BgzyiJ9dmKlRzwhN2NxDDFqFI2MK0oZyYUxRlRqn8jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199015)(38100700002)(478600001)(41300700001)(6486002)(6916009)(54906003)(66556008)(2906002)(53546011)(66476007)(6512007)(26005)(36756003)(8676002)(4326008)(4744005)(316002)(66946007)(8936002)(2616005)(5660300002)(6506007)(83380400001)(186003)(7416002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d0HVc+/mbK4WVvzKTekqhY2bHtZpgd2Iroa8MB5lXOlHvqGBEQaRcAeIwTvf?=
 =?us-ascii?Q?+WUlUrnPxI6bTO7v1VcaIk+QQ/z8RhyQLyxVg5kbpnhcZ5gXT5aTO3es4hWn?=
 =?us-ascii?Q?GqjjSfDV3ISdArffK58jUTkE8HIb5K3C7ECucYPdFxnaqaNx0CmnyP9/Nd70?=
 =?us-ascii?Q?zeVgSg3b9B+ZlpR/taSrStRcRpJuillfQcQAAl75P99SAAWCCA+vSrwChTdD?=
 =?us-ascii?Q?L4ipSqROletNO8O/X7cNR5+YVYmPoiiwTtTGk5F/zanoofG7XPv1huBYD8Mu?=
 =?us-ascii?Q?2/g9rlZA59JdlAhccsZv5+qqPg9MukQsAQ7evbkhI6BKiIDrt2e4WaHwSQ0g?=
 =?us-ascii?Q?ELmTfv01E7sEhsyJ6OX8iShlCl8ZSracGkBMnQcZ+jd1Uy2oDBndKpIdSiym?=
 =?us-ascii?Q?m7ukaFyA7+6s+aQt4sMANNstD5AhcIE6CxCW4OToD5UokeNyfNMGFEli6j6M?=
 =?us-ascii?Q?SIoynQMhfdwU9wNAj4Rzl4xGWakhLRwKWSabYe2j9AbAM0r570WOjKuc3Wg8?=
 =?us-ascii?Q?+nq9ShpQHXH2/uUdj33Wy3zsZDc3R05Gj7av2H3PlIAJrZUDdQK55Lxihzh0?=
 =?us-ascii?Q?Mo7PeW1EbUiKW4lMRE7Nk2yN/qpIxIXhm56SW3n3Xei+HFDw+UJ6PUa6jq7V?=
 =?us-ascii?Q?MD+Jp6cmvVlYWpb44w3oBUjme89dcX5ZDS6oiG8dcQndQvJYL0ioKxWj5qGb?=
 =?us-ascii?Q?VVB5WDq2blsojti/t3ybpVE0FbAZIq8M92uEXAzMfdE8uqRrm/o0CD6KhKmU?=
 =?us-ascii?Q?A0O+UB5ZsDJhly0zs1ykuQM/dN0NoDlOw8oQpfTwDLssc41WJOkpyoAc4Fx1?=
 =?us-ascii?Q?gfSuUUEHeoJN1lxzjRWn8rh8o8zvqMwAE6DtJDImNsGPrmrOoYIQTQO6KieV?=
 =?us-ascii?Q?PEJNWXGSOyO/MTAwo8p+oSs02j6KbDu0KLdbqf/zMV55upKMiNnwaxkPmf7C?=
 =?us-ascii?Q?CW8sDs+uGGLNh+StIM+Hsqe+iwuTiI94oKf0GBLN1FAhKbsRFN8oMMPy6IFi?=
 =?us-ascii?Q?Wj8mKbjuK7Xgy+eQi9R4IQMzwVVLB3ZChw1OFys6EhtiJzOesbNjSGJb52xd?=
 =?us-ascii?Q?uCmrytxoD7YZafi2mhFUESQ0AMzGH0QR9KspKI/enUhwtE3M5qS8Mvd8rJIX?=
 =?us-ascii?Q?6ModLqP7X3SYzrY8Hu3NS+RotoyIXF+Sqwd+ZYBj4KseRdxOkFd0SabpDj0h?=
 =?us-ascii?Q?VxUVc5CaR0swVPl7q/BwEHn52hwG4pjmKUxOPG2XAuQTdGgZyLqufiUGzAqY?=
 =?us-ascii?Q?N0PcdEzBQnTDtV5qs/tw1j8vogzPcm4ArbSvutBhG8LNiZwGSbphlE/kTaCE?=
 =?us-ascii?Q?YQHp214EN6W/cSgDfROGu982gWbXEvgQ8AM+1soejj82lOecAasWsZLm5pqP?=
 =?us-ascii?Q?ZIBceDC4tGRnbRGdkwp/RePvsNQMIM11fSvD/tWKw3HnC7unvL6rswLIBSB5?=
 =?us-ascii?Q?5w/j9+jlvol/y1mLStpEnB9hXYtZ8q2q+4OjQ7gppJw+e/ikrS95kNYCV9Zk?=
 =?us-ascii?Q?N16UnJC1f19dhWo2RtNHYj5hAqtP4/fU9HCAcNHAPMwRjhNnhZw33lliC9fG?=
 =?us-ascii?Q?mLXg3m+5rk8d4DBl0Z9SUKERhfaLhdV1z7j+JZqL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a04cf4b3-b2ca-41ab-d436-08da9d648de9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 13:07:23.1110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91CmBzeYufA7aqpDeT3lRbHlJGzddz/B5cahT5qEeKCUkNENvBdveoBKEJKBJR4T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5175
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 23, 2022 at 08:41:56PM +0800, Baolu Lu wrote:
> On 2022/9/23 20:15, Jason Gunthorpe wrote:
> > On Fri, Sep 23, 2022 at 10:21:51AM +0800, Baolu Lu wrote:
> > 
> > > At the beginning of this project, I wanted to consolidate the mm
> > > notifications into the core. However, ARM SMMUv3 and Intel handle the mm
> > > notifications a little differently. Then I decided to do this work
> > > separately from the current series.
> > 
> > It doesn't look really different..
> 
> They are essentially the same, but slightly different. For example, arm
> smmuv3 provides .free_notifier, and I don't think it could be merged to
> the release callback.

free_notifier allows to use mmu_notifier_put() instead of
mmu_notifier_unregister() which avoids a synchronize_rcu() penalty on
teardown. Intel should copy the same design.

Jason
