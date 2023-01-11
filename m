Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB66660A1
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 17:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjAKQfl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 11:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239358AbjAKQfF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 11:35:05 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48897C46;
        Wed, 11 Jan 2023 08:35:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RX3fzNS0QfQDtbB/IiB6yp/5sochMNUf+3EC3FFhvXA/ov91/8GGfDcAelmV4fGHl2H5uKEHp/doOfUn604hIJUe2hSVIDxTTJULWw4APGWUj5uPJHzjmxfscxOUZmNm34Gqx8hqYdt+hI7rTzN+wtR1m1RT/IiZQShVRQDqAeAX/7KFs6nfuO7C++a5VesmeuojjFBSB6Nj0sE1XLb9wHDW9Rol6Azjoi9c3tztHaOaUEuTTHuw9WH4zES8SEe7du4HOBdKhZk7cv3Hq0aOVzRlpQpmHnLt4ACMR9EcDeBAQCFI9P59kBnaQYvthbSnkkInz1WMhRdNttviHL5rEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j86Pf+xUAujHw0w/U6/XpBCHwgWZEb+yf0qTbAUez4U=;
 b=gvJoqzISaOViHqbqfa3Lyi1c41LCpCf8bBB7yeyskFqi/Qye21lWGlXsBR1Y+iAlBWvbikpEhi5S9Upkd7ZLurZr5SaHZCVaaj1YqoOWwCIe0JY0l9J7TdzvjPvOLe9MvoN5r7JPJo975WL9GN5HPv8fuKtfjpPIWHufpZa+eY5JCYHhbOaXT7jYh8guiNNUhr9QG13umCsASAjAUXDZYw0vXWd4qYtY9YpI9gia8946xZjHd9b2DxxEs5pYdG9oualWFWiNfKTKN7yySJqtHBLYyF/efLPsLX66znW2A7FVDCOrp4Hr+nJY76OiYdoTSVn8Lw+S9nyrhk2AJNFaWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j86Pf+xUAujHw0w/U6/XpBCHwgWZEb+yf0qTbAUez4U=;
 b=TnwDwWe2LVfzpj9dj653PGARAkyd4LrFzv8unQDysWwMFUfBfwAeHqoLwRUH5pCE36Ohne5HmM9TJ9+jahOC2eI2fTE3UoNRUzRIxJ1lU4cLezSnyEOe1Kf8/QZtwE+nbUmlJJ8VEiLZf46juVMHI1JKH81HfgCxOVrx62y1lKitwj5B4JLzC9UC1BcHuJYacWM9ERZK+0eHDiyaXKD6lsEiSCMPeoOviGeW1j+ZIoX1kLtgrz1fvuNfh/bJwHxRM/ISDqNPSxktci1UtK6VFhGIvS17VHRXOMYGgY91Q6dMal/aLF8U1OJxcfUlOD1AehZFTDNd7NDeJiw25p2ZNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 11 Jan
 2023 16:35:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 16:35:02 +0000
Date:   Wed, 11 Jan 2023 12:35:01 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Moshe Shemesh <moshe@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
Message-ID: <Y77lNZzsUVUKPaON@nvidia.com>
References: <20221124230505.073418677@linutronix.de>
 <20221124232326.034672592@linutronix.de>
 <Y7VyXNbWMdWWAC6d@nvidia.com>
 <87eds2k2nr.ffs@tglx>
 <Y719OcFueTg09OUV@nvidia.com>
 <87o7r5dpq2.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7r5dpq2.fsf@kernel.org>
X-ClientProxiedBy: BL1P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA0PR12MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: cf389412-dc2f-45a9-7500-08daf3f1c9a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jeFyxm02aKQ/q8SJachCoAvxUF7C5m3suJd5MZBDXzAVjDRfAf4McIqw+UwRY6FFaHIQH9wTRidTIfxTW5mzTS+3rFXx1aeRoTvIf1Zlr/itVe0ao92GAO1Cv398jo5oe0nMBLqLAbitdLRUzhzg+NFo042+lqTBFhzK6jaLNl/03YvD6S+CUydRhfyZfX3j0GTyAiYo3+dum3Zw47E1OVNJg/uA+UdTK33sF5lPpfFrS+9NlnuX4bOs+A5b5WCcaFPCazKwdjtX/X0aYnkK2jlpu3MAAUxeshWRXSpRsOJQCyOvW1L7RIpDfCBPt0DAwDUGMn9C919GRQpZubRsr+DD03Fz0SIQOmPvSlLiPAhtCri9fhy7uLRIhhi/znnScvc+weA7lN5FhnWxVkgYTa3OvUpvS8Q45TvstYJQMXIh49nw4Z/8pkrQ0xxDTgLJ3bBMR8dJ1wJngY9aPjZPadOK+n5k710/HgIPqOJyrvHKOR2mT9y+at664XhwjXvPNGpBK72rjLgiPt5q2hvuRYEaLWCvs0T6WRfhgt0rO8pVXfPvJJRlZ+e8eweg4Il56pdQAVHX+eHo0f2a5DRvCVYWeqPPVeKWPCJ8VLkT7RX3PMcPXrc4VqSohhcBzwt30+tUi83LO6Jk1YpoEa4aW4lm1/wfIpIDtLPT7ChNxhqnVVNxj6+t1b3F9GPd2Ve2E3Vh5dYJA/I5l1P0Rd1oO503UaBFzumOFm124Cs7bsY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199015)(478600001)(966005)(6486002)(41300700001)(38100700002)(6512007)(86362001)(54906003)(316002)(2616005)(26005)(66556008)(66476007)(66946007)(186003)(4326008)(8676002)(6916009)(36756003)(5660300002)(6506007)(7416002)(2906002)(4744005)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zfk9C+gH0W4XbvIJhlUwS7wu3HO/OpkGMZl9g7nU03lYS6fa9fu3hSrowZ7Z?=
 =?us-ascii?Q?WlldU0wPffDg8RdOeeSYMbmt6MV5850cgqRf2YpcsAQ3coIEJQe9dMi9O5mc?=
 =?us-ascii?Q?R/yrgR+xl9TTVNJOvkAUGZ2xxJvyhce10KC6S1OjYM4isRzTkE9naJM9srly?=
 =?us-ascii?Q?xijiaCG3Hsz/EB2uIzAEuzuw3rqZ+SC4NWgP1TwFDBsbCFIlOAPeGMUUgPZC?=
 =?us-ascii?Q?H0pE8nGhk/6yMyBIj7Z/qGki7iM9BoqCJp0OaL5PNMOUblprYEAAY4Nkqnkd?=
 =?us-ascii?Q?4PFq6mBj+KrMwQoCmQYHBVtvxFLaTHcU1prX4+Tx9gXuyuOIPI3USID/1uJN?=
 =?us-ascii?Q?yvFD72mLH9351m+UFVrR5LI5LDyKgXduse+4nfREWFTNmgK9ujWiY2bASDwH?=
 =?us-ascii?Q?OJpka/3oOf8185szDnjCekFGaBwB9qBt1Ovwcxw4wsonQP2tdQgm1LBB38Ok?=
 =?us-ascii?Q?cuSJU88KECWmcC/MjDPJpt62vVzpY25qfbQ2m4k2wo6AKueQY4soLcjinnUY?=
 =?us-ascii?Q?ZHBgfidvYYs79bpa5XFBTCM1UtWihuszdWrRsqPOzPoe/qiORpXhZvmpbHVo?=
 =?us-ascii?Q?5MKXscZqpqaHmEXctjCEXpZ3DesRElfl/873tUUl9XgZA+AY1mArmOxpzegL?=
 =?us-ascii?Q?87xwhTRXHIBv/Mvgqx9XFD/bBHiMw8lsUIPzS8BG4qnJOY920osZbSRWLMMK?=
 =?us-ascii?Q?GOpCAMCLno1hIvcbgpO3hvUYVO56ip3+Y+wE4ZUNlMxsxT4tR9ju9xxk3jb5?=
 =?us-ascii?Q?lbnHIub6+/q4WOwp4i7LzK/jQuGj8AgedvhsdoqdMKPab1LfsAk0UzYfPxtr?=
 =?us-ascii?Q?Hkf9vrC7/xjb+rw+IP3+GG7qnMnH1qMaiAh/GdXdQ5KpaiQaUr6Yk7VDhktE?=
 =?us-ascii?Q?R+3o2DsyxFo+mjc6FyfK9PSLSFCGc/IDjq7c9xV0S4CjVtPaOxzTIZNL2j1q?=
 =?us-ascii?Q?lN+Xb0DmRuq40Wb4P46UXrkqHG7nW+mk8v++ef9f0bmIOuN6tgkQOmCj2OMG?=
 =?us-ascii?Q?meC0Weo5wjCpOvLlMpuvjNOOpGIAhwYmydExrpOsUeoIXck11yvnzWCipLUj?=
 =?us-ascii?Q?RMJ8xIkhaLecqdAk3GDY7h+Vi95Rc+sFFhLycZvSOdXmw+LDD4IsbunUBdQm?=
 =?us-ascii?Q?sFWjEwKM1aamtOXVqm/Pi9fn+Iyzp7gDsGrYLxmGW+jvs5axnOl8KimsVkMV?=
 =?us-ascii?Q?56L1Z3C11WyMtKg6omCC2ygsilv815SMJPJRPRcMefnh4wmKP/SHUMOO3gqL?=
 =?us-ascii?Q?PJM585QV/camhmWfzm5+cHQ9DqsjzB3/M6dMMxaWl8jVthoLko8A7JJRRtLF?=
 =?us-ascii?Q?BgoAKhOBzEG8hh5mPqXpyG6U0DDzCP4ZIa0ccEkr4Lhg8ag/XM/MgzWZvpd+?=
 =?us-ascii?Q?ijTl4kQLJX1BbPhgmSiyLT+di+ZJylK9Twb9taPbFE/+u4HRrw9nuktIr4Dd?=
 =?us-ascii?Q?vVh5Xhd52jviaGdPBhJB1OOemYWA9X7K2eCV2mGxncmk2LRAFfNyhwULFDF6?=
 =?us-ascii?Q?EQBuEQlGLxlvqWXpJPqiVqYIfUESC5UfdaMumvgzb0cRxgCSGN8CiJ3ST4FB?=
 =?us-ascii?Q?6Pl1RUbrABrtFprEl5BQFGQx4qWAfSnC3KplpAFE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf389412-dc2f-45a9-7500-08daf3f1c9a0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 16:35:02.3468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWQFPxH/Af3oPzf0L+ebRhNklEg9UiQJxFcYF8TYBopXeDmsvEMqroHAKH846l7p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 11, 2023 at 06:02:13PM +0200, Kalle Valo wrote:
> Jason Gunthorpe <jgg@nvidia.com> writes:
> 
> > On Tue, Jan 10, 2023 at 01:14:00PM +0100, Thomas Gleixner wrote:
> >
> >> Care to send a proper patch with changelog?
> >
> > Yes, I'll post it in a few days once the test team confirms it
> 
> I think I'm seeing the same leak and it's spamming logs on my test box a
> lot. Let me know if you need any help with testing, I can do that pretty
> quickly.

https://github.com/jgunthorpe/linux/commits/msi_fwnode_leak

Jason
