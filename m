Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192C0733108
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 14:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbjFPMUq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 08:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241493AbjFPMUp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 08:20:45 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B722D7F;
        Fri, 16 Jun 2023 05:20:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTmdETKkI4Qus7n0IAvAYFHaSJ00YJl2mCsGpesABAJs9N838D4keMNc7zwlysZ+ggmRSVydxYIeaRNoQwn+qJGq5rAaqrAESfsOEe56aXpRDPgicoE1v4ZrYOChCYRBpdDErCgXgDpmS3VAwzbobLsrAJg320kZQl6DHUMNQjMHiKC9EwIS9P6KeZT938WnS8Qu1H0RYdfGnDSmQ4vbej0p+Kp1yM9hx4w+qAyuMRoWa7aMDbixwgu5gF/5SkPQGhCuLBnPdC7wxuZxBHJZ5dcqVOUYUq4BEPQYjNC7CnZgwVWmQqRP1Mg11A2ItAaXbOlORcGbyLsra8Rpm+gjfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLC6qM/b0govMJqHe+EdbWXwRwTAiqjJKy00sP5djxU=;
 b=VdVPpHcdooHeinWkX7boeDC07quNUTqcmx2l0yAlyBYTaARcKdLGGq/KelKOr3gMk5E82BOJtdK+CgvcId/WlwLgISOqv3Ymdx7C3mkvFr4clGpJFbFoeyLggk6LTXLHjUFDvbC22pWBkaww7e0vGST/EPFpC7ljgAa+nLS/7AxASzkguNy5yoa6619t1kvnuzjssIlEt8mTmWjmpeXVt8ZQiAgdcZucUCBx2z7667NCLj7KZGdiTKOzKLkZ7+OVxYD+9xI3KCZPSDbclxM9aWhrP/PjPFBzjeh5lrfnthbseBRhN5wKLTOFymc4pDDPe9jkTNyYh8lgXSmq7bW7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLC6qM/b0govMJqHe+EdbWXwRwTAiqjJKy00sP5djxU=;
 b=QoK6+fR93rGEtdr4nC/qaU35iqa/VSvOasXTdq4gQYcYyBMSrlHmvVtUdkdsyAkcHL9wvYLhafoZQzJJ9EYVoKGy0P5w2biLHd2gPjg9/4HWmbSY7zFL/GAO4pG+iiHwlzDG4AGGWWbPyvHs6Xfws3KMGR4cIR/cOYJA3phBA/EkQzxqWhoa+fMc5QFguc2rhTtHjqHFAJMZxjc3rTvPhOeXaw41Sx6AIx0cNexVJhMHqr0X1TOmsstR+MwviSJLGRHIf2nYjoDgm7MEWq8nnA4iwv/d4IJC/hYt2k+IoWpoPdYKa66enFQBat0sSJh/NqFbN069iQBdKyUWRL/nzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 12:20:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 12:20:42 +0000
Date:   Fri, 16 Jun 2023 09:20:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: Question about reserved_regions w/ Intel IOMMU
Message-ID: <ZIxTmGU4a5dniEY3@nvidia.com>
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com>
 <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com>
 <ZIiRK2Dzl2/9Jqle@ziepe.ca>
 <BN9PR11MB52765C24405D2475CF3CBEBE8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765C24405D2475CF3CBEBE8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR01CA0001.prod.exchangelabs.com (2603:10b6:208:71::14)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 636436de-9b1a-478e-255b-08db6e641a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dZF8Au+PkGv7rL6TE7ktRBFpD9EIxL25NGffHnLHRsHR0J0wBRcKKi/6hNaoA5EqlNN4QLxNLFPiT+0LZEaggqmu6j92sYuz6hbtMPNvR8kat8fjEDVZwYU4FW2/q9306nzwUHinWm+VllBU/uFUvK7pln1i4jTz7vuovyNw2wUpgPS0oUbEtnVf+z0Rb/Kwhtm//yN4zEgqRgOnh3ft51bTDlpZIuf58bwXgV/4GymmxVJlB0ToWrehDoEizkSBVR/Y+Ord8ytvK/NfH2oIrxt+ymbzkBBENVhRXAJFhLqw60L5h+9PTQMQpYgn4Y2CiGWNthXXdkq/u/TE6fEMeRnXf+5bb3uIoS9je9NqH2ZHpVzY6O5zln6mjS/TLxa5MsYAOcV1VK5OIyYO0i2lbddQYkgpJZ4v+oeYaF32MCdGYo9tmBp/F+AmB0izif9Rdnu5Pb7vv5g3moYK5GaJH9C/H0EAoObjAvJxYtOXWRoIz7cg05nlZH1k75y2WTqyg4ImMsJFxZV6tDV5V6AoWPU0MluDT303hS3KqIxRQ1r/7+SMRNLFYJmboxsJXIDm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(54906003)(41300700001)(8676002)(86362001)(66946007)(66476007)(66556008)(6486002)(6916009)(8936002)(316002)(4326008)(36756003)(66899021)(478600001)(6512007)(26005)(5660300002)(83380400001)(6506007)(2906002)(186003)(38100700002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o6lz8TBOctyI0HzKhcRLFBcnGwDkAeNCrpsjwPswBsFDwsvJljk/jSL8tUOK?=
 =?us-ascii?Q?fI73m3c2b8qS13VTGAOI4iY+cnncOQpPe2m1IYb0Wi9YIn9cfUpmBDVIvcau?=
 =?us-ascii?Q?5qtGliBgiZKBX5HNwaJRuVFfx2/2V5vFjq820JKdcL/L7hJGgVvBhkwRQYf6?=
 =?us-ascii?Q?Rfju9iXNVIw3ERAQ1zNfuWHzPE0R3EMeNyTnPf1Puf1qK46P4x2Ab8UPWROv?=
 =?us-ascii?Q?WIcMtApE5H+hVxGZoq3F5xBMG2WTNv8Q8pkYCMZ+g8rdDiXYD5AMCBFmwOEp?=
 =?us-ascii?Q?wZIzSFhNOjQPnT8fHt8IP2qACRUOozYXtjLo/Fdl+s4cpc2iHc9f09tWwBh6?=
 =?us-ascii?Q?o5XJFrLtYLxvNWdA7ZtrITsydc+P+Bf7ZEqjxnWYqa8vOpN4pKwfHiVoybIV?=
 =?us-ascii?Q?4XRPj6Pj5HQgVqntEfXyeuuEGMyWjnwg2fGw4poUtk5CIQqqo/4a/sB7CVFG?=
 =?us-ascii?Q?WXO9OV7wMCIqvT4oYMOBULF8UQvZbtghoK1sa/cBDl3OB2F02D0GYQjzU/BF?=
 =?us-ascii?Q?YVPGgRmeiQJ03FbwpVtGGxnR+Yq7+Nx9rH0yhevXsWOJ4vcIqrJVABwMfu2M?=
 =?us-ascii?Q?NHdQpXuJDlSXg38H+mRgiOxipTBGCvQ+AWCPzichTmmccydTkvJgt0ErzWIU?=
 =?us-ascii?Q?UdNSXSJqqGHSU2JJbnwUQw8lv1k/WbulNv8MH1XUPGPPn1nOX1IfQfBkRcDB?=
 =?us-ascii?Q?7JfXMLAB4Sqmls0eR5NTRkqjcnrZUawhwCprKbvyUyZXernCRdWsomZh2gNI?=
 =?us-ascii?Q?y7YvTtpY7iCxyo2XyEY0kOUBa4MjMah0HcVhnsReJ/tSlBphick5SaNWj6SA?=
 =?us-ascii?Q?iza2xowoaA8G03FIzOH7dyimxUo3PTFSRwgNQOTlUGooiilaeA2aBAXj3l9x?=
 =?us-ascii?Q?pE0MF1JAMfHEPZSveccHzw/snwm9e4RTpAcuUrZyV6cICjgQqy1i2oH7esRu?=
 =?us-ascii?Q?7XS03u2nFOwadPHGs2RKtwp3azrik2cmarsw6xqfpUrtfzLMu12HU+D18u+6?=
 =?us-ascii?Q?8x00euNmzrX7iG4OXD1CtGrXJcT2aU2tw6i8NG0CH1yoHnmVzPp3RdZBSZNo?=
 =?us-ascii?Q?qoIOeizzpt0oUdkY9YbSg/scO87S1XZ7PGcLGEmko5mNdKkC7sOn/Gue88C4?=
 =?us-ascii?Q?+wW0lUkHTrM3u0VtuvYRYAcJsK97rT01S9+uatuooEtTyoNwY1zxEJf2XHBy?=
 =?us-ascii?Q?TPo0hOvB2xVH0mtzPYvcIEBYeIcNEDYgYA2KkcMsiCuc1KgcCGUc5vSpnS5n?=
 =?us-ascii?Q?pDk7vlz7CWxXQiaeuN+M6DeF0GfkbqlK1x5SX1aKXGtV0Cv9Bs+oMnjg/3lu?=
 =?us-ascii?Q?eVifAE4zXMZuhzrPXzl1zh3zE8z8TO37kCLi0GWV384BK13yHipqvgwJuyST?=
 =?us-ascii?Q?Xlr+Gibp3xON/hLpo4jFYNEKvNBmafb39d30R6TO0U/8yLbY04Js6SIz+9eB?=
 =?us-ascii?Q?YqQSgMqY7UGTbfNWWNfjBY88sicOzyOMwdxLscQUZuzvoyxfQSMDnSPVyLfq?=
 =?us-ascii?Q?7UMZbTMUFM3TOgwSSGFRLDdu32XU142X5Jm50BYCEdD1Yq15I94pfP2lS0oo?=
 =?us-ascii?Q?e/jqOLsMHbaJdDfkZyM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636436de-9b1a-478e-255b-08db6e641a22
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 12:20:41.9008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DRp69ELyMAsXwmNbZv0ntcMIS4fVdv4FEmNNwNaMW+0Kz0b9LDKhNfc0ErUyvVWn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576
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

On Fri, Jun 16, 2023 at 08:39:46AM +0000, Tian, Kevin wrote:
> +Alex
> 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, June 13, 2023 11:54 PM
> > 
> > On Thu, Jun 08, 2023 at 04:28:24PM +0100, Robin Murphy wrote:
> > 
> > > > The iova_reserve_pci_windows() you've seen is for kernel DMA interfaces
> > > > which is not related to peer-to-peer accesses.
> > >
> > > Right, in general the IOMMU driver cannot be held responsible for
> > whatever
> > > might happen upstream of the IOMMU input.
> > 
> > The driver yes, but..
> > 
> > > The DMA layer carves PCI windows out of its IOVA space
> > > unconditionally because we know that they *might* be problematic,
> > > and we don't have any specific constraints on our IOVA layout so
> > > it's no big deal to just sacrifice some space for simplicity.
> > 
> > This is a problem for everything using UNMANAGED domains. If the iommu
> > API user picks an IOVA it should be able to expect it to work. If the
> > intereconnect fails to allow it to work then this has to be discovered
> > otherwise UNAMANGED domains are not usable at all.
> > 
> > Eg vfio and iommufd are also in trouble on these configurations.
> > 
> 
> If those PCI windows are problematic e.g. due to ACS they belong to
> a single iommu group. If a vfio user opens all the devices in that group
> then it can discover and reserve those windows in its IOVA space. 

How? We don't even exclude the single device's BAR if there is no ACS?

> The problem is that the user may not open all the devices then
> currently there is no way for it to know the windows on those
> unopened devices.
> 
> Curious why nobody complains about this gap before this thread...

Probably because it only matters if you have a real PCIe switch in the
system, which is pretty rare.

Jason
