Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5232633269
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 02:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiKVBxC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 20:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiKVBxB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 20:53:01 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A720030F;
        Mon, 21 Nov 2022 17:52:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVETvHFQaTg6/NNj6kAOJBhGG8KDpGarpmKeHHdftQDIeESwmfUTRAlc9FN7AC/9P2BHqQzY7mekWT/rz7mqNdpWVor86hGsq/6XxiCb8G0iPacPHgpJq24sAd2mrlofHvE9ziDF6z9wAeU9UdWZ8wJiEg2S+ZPz01SvEdvJZvKiZWvSloI5F2w+I02rQHViOeL7oAZgO9A3n9MOSIKB0vBMoQY9bTOaWt/VTzzcJXMTzoO3/2A6RJMx8Vgp652yB29lNU1gd3FYRcf8ogw0K2JGJ5rh6SDcQv7qt+1WotcEB9fplY0v+LCyav/oCW5iBiGXnCwXZ2k6qI8tqxV3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47ue/zq0tjj+wvXZhL7HJxvKlSfveyE0EYlOnTllB2w=;
 b=TLaw9aNQAMGfg/edV7bk2+gWgBVT0dlY/Ps8vuCN9CXVINkPPu4nnURbQo8X5E1GlgQYHhGN/mrEej5w1+uGJ6Jlysk0bTpqvnEKzSMfTkSu7XTvOrWZ4pMqQvE5aWDd61cVr0vdjWCJc+0GDVzfAOlEv2dpoLrOTHerfXZXZPS9zMlUsHuKj716enf+yL6uCyLyxfC0qNCzeRp37ri4SzZMsYxL8rSp0+8P5RZsTMe1/Tfhhtt/cVQlahyQf6sPzlEdyt7x6rLUi5IV4v1y6D0zfIVP0nF6UbO+jW+56x1yVWaEpA7G/EHxDg8Eufb2E12xa3fBAuIaw+5XGzi1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47ue/zq0tjj+wvXZhL7HJxvKlSfveyE0EYlOnTllB2w=;
 b=ibtsM6oNDN7OBQ4noJYWQzLAkyKjiM48mNcCg/TqCbi6MJFYQGRS7aT4bojRelYDDKrI0hU+ln/H2evVRhTx5hYSk0QoZ0hnMOpl0s3KuV8vdKJbZo3s+84b2R4ppqL3AVt37chKF4Pc7wX+didusNIMZf7grkMJBHwo6Y3ThfD5NviKiRKgGyiE48gcs4Qya7s94uPsmvn1hXZ8OYCywEjvFsur9bAmpzMjSILhD279laBuFOm3ZY8gexG/dciekt7mNfnmLBr7bMSw1UyvuP6JA46ABkODXEzyAFp8hC0oaOY40w7HM6f2mewrinA+vJSrx2r5UsBvXkKPyu9yKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 01:52:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 01:52:57 +0000
Date:   Mon, 21 Nov 2022 21:52:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
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
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 19/33] genirq/msi: Provide msi_desc::msi_data
Message-ID: <Y3wreJlD/7TsMCme@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.346985384@linutronix.de>
 <Y3U5xwujkZvI0TEN@nvidia.com>
 <871qpzkj9k.ffs@tglx>
 <Y3uzVJ/7ecL8DBK7@nvidia.com>
 <87bkp0hzai.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkp0hzai.ffs@tglx>
X-ClientProxiedBy: BL0PR0102CA0051.prod.exchangelabs.com
 (2603:10b6:208:25::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: b36757fe-f4b1-43b9-d62f-08dacc2c4746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cgrbG5M4eaQWgmlGOlANY+H2zQ3s230PU7pDuIN70Yc6iYY1J9TJ8A3vS5Txw6RBxURRuHSQOcqqY6R6vt4oa4fTCZb3gwaExSHtOZtOUQJ3VKmEU7ecYLczkBQEmnCfs4yYdiLgP5MB3scsWlaC0TP7hVuthVGcmM0XKSLUNRNr6uI8JjvktYpWkCCc8KZZAEYNGNoXOJouGVfyTgOCrRz3EvKJXq4nFDBYj0mfjIHB+ESlXB58J7qqcyPzdTjtrIn3ngAQMO4WgWyBMHrumUbo3MTm2jNLqxiNQFjMiyXkW3jfBI12bH4QkRF9sSaRqoTZ4gH/UN5vlqZQrkz7AG0nX+0EZLnq7iLHORDBogr4qPkgo0+jh8lRoxwXYiT3fm+1hiP9WyyvsqS6zUFNmwar99TbfaI3TlRqj0fALWle+Eo6vN71uv8q2zV66yuJ4w0sT101OEnsoNTrsbpOEIvxibFQ0Roz4jT1yDqMGewrIz02Kvq7zy2asRB337YVjeRm2j+6PS4GL5ttpg/qfixCBqpH1jdP3nPF7KF72efhAVIT4yQDIA+BtPOLLEES15aN5DTfcrZBLy9nLHG+u3XqoST9h0eAlXKlr9L9YCfO38Tj7x1qKEmaFUmpdpXQwSJ2IFdQQGP7EM1j6nxH9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(451199015)(38100700002)(6486002)(41300700001)(86362001)(478600001)(7416002)(4326008)(8676002)(5660300002)(66556008)(66476007)(316002)(8936002)(6916009)(54906003)(36756003)(66899015)(186003)(2616005)(66946007)(6512007)(26005)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lLwl39K7yTJwh5MByuyJoZRmknherbmAKqKaglkN2T6pMeSDd/nSK0JWpW/J?=
 =?us-ascii?Q?MLFgeWn0rkRg2HGKq8G48NQK+clBGaE5AsucpKVxRJpcMOK7pCOOaoTl75dx?=
 =?us-ascii?Q?8c69TstD1IPQolhGf6Vpmhr/Q9KLqUtiokkniKevr8oK+UlN9ywRC+thVtYX?=
 =?us-ascii?Q?wIZQQNfpLOyRYWQLEv8mNHI/6quxY50UqUK0PD4DIV1uCrKXIAx1Lg1qDb5P?=
 =?us-ascii?Q?WSztBeYTNATy7tYSZw2S6kIOsp+lKefrVjiXK9E7FRtArgC6WQOSlMQCtswS?=
 =?us-ascii?Q?xj2AFasfrcYS1ZMpIXE8hCO6MMTfk9LwQW7Pp6GxZ/TMv9LIbXJklJDmso+D?=
 =?us-ascii?Q?9MuaHaKhLx6q3ivSwM8oax0EcPts7a4B2ir4wb5zD1Uj8I3+0Up6VaCe4n7C?=
 =?us-ascii?Q?zBFduQoIbOteLUygiNi+ozbRrHgzfZUu1BU3iRade7zFfDfVGO/zSHnX/RjE?=
 =?us-ascii?Q?nWkk8KY8Euw1wVD6fOEfoucrJYORIlMghNpp2Uq1Xk/0IembqHkW48cwOsGI?=
 =?us-ascii?Q?GRJhkwJyaRMWKZiNW1fveMnR3WJ9oEGGxZY1nHXyrTaGa3TQyyqY2GT4Zu3L?=
 =?us-ascii?Q?cOLASKUCcD+4wiDHAuIFnaCPduinAj6lTBbt9SVDtexhgUTIbHIcbljTtGCQ?=
 =?us-ascii?Q?KUJbAcn+WzJifCHU+nBNvACtuxMfOQoQggPf4+nUpva6Ibzt6oduLjEPVkLR?=
 =?us-ascii?Q?PGtQOIMjvOtnmyGBi++RdTYi8oyJ2InirgN+Uq9LwrCH9zPb4bxltptRMq4b?=
 =?us-ascii?Q?oevhxqLLEXJcQhOxrNAhQVSvqKHRs0WVxfqMKRpwfawn12KBgOwmAfW3kVqx?=
 =?us-ascii?Q?m32JPzqWCkppXyWWXa9bAfU8Zuvp5TJsm/4eq20zvSroEBEjOxuG+oswYpcM?=
 =?us-ascii?Q?n69YMLpoUXwx2d1I+MCimilaklXDcByphwvX6SpZZ3tYjw2xqD/28fySwnNv?=
 =?us-ascii?Q?p7qK8G6Ba3K++7qhV4ZIieBPx8MsZJIpB45D57YI11OnURd5RTkAZK5NHQ7X?=
 =?us-ascii?Q?grmnfXD4pKuEvGRY4/Gat3ddrFi0z85zlkRms3fyf3EJqxy9L++XhqCzhJhO?=
 =?us-ascii?Q?jK1rdFnYWVYrsHS5+gZvzYPTPopJNkAO5FDdWB65CRVVuEML5poPwlzEg7J+?=
 =?us-ascii?Q?MOzp3+q+hJf8F81djVv8TQcOpuEcOlXy1zrecyHWvJw1gPCIT01VVlMnldqL?=
 =?us-ascii?Q?RZx8wgtBr/RY1cH8wnCPvikhgB6/y0JUgA0hKLjJjatLNq0g0l+av0y/f42n?=
 =?us-ascii?Q?yUVVnW1vfQondWSbhJynroDo3KpwcrtlhBYuEFxC8TClHwo0tv3CtWlPjPL3?=
 =?us-ascii?Q?vgRjpAKFzCYlCg7WGQ3ChY+JUvDwfjEgdas+W2Oa1V3fjh1h8KXctdqU5DeH?=
 =?us-ascii?Q?98SrJTVpioN1/WDuZfOPElKzCnJxZ9MrIPVIcqWrf2BH2pI7Z0vB1X39WBXs?=
 =?us-ascii?Q?okh7Wc4zn7WNEMEDLctJhgxDunwErgCjfPXKQ4B3UoNXwyWyjNG4YsuB8Dl3?=
 =?us-ascii?Q?mhSyJ6AoQqRLHV6OIodJr4KYGFvGAwgK9G/E514PEM9WDQqM8HkO3nNB4c6y?=
 =?us-ascii?Q?homWqBoIu1khIYLarZE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b36757fe-f4b1-43b9-d62f-08dacc2c4746
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 01:52:57.4516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UP2UvDOqmZ71BwKwfG5zR3agemml/gnBDG6lAhOgH5hqjts2ekoZ0e4H2k2Qqx9J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 21, 2022 at 08:40:05PM +0100, Thomas Gleixner wrote:
> On Mon, Nov 21 2022 at 13:20, Jason Gunthorpe wrote:
> > On Fri, Nov 18, 2022 at 11:08:55PM +0100, Thomas Gleixner wrote:
> >> Sure I could make both cookies plain u64, but I hate these forced type
> >> casts and the above is simple to handle and understand.
> >
> > I guess, they aren't what I think of as cookies, so I wouldn't make
> > them u64 in the first place.
> >
> > The argument to msi_domain_alloc_irq_at() ideally wants to be a
> > per-domain-type struct so we can folow it around more cleanly. This is
> > C so we have to type erase it as a void * through the core code, but
> > OK.
> 
> When looking at the wire to MSI abomination and also PASID there is no
> real per domain struct. It's plain integer information and I hate to
> store it in a pointer. Especially as the pointer width on 32bit is not
> necessarily sufficient.
> 
> Allocating 8 bytes and tracking them to be freed would be an horrible
> idea.

No, not allocation, just wrap in a stack variable:

  struct foo_bar_domain_data arg = {.pasid = XX};

  msi_domain_alloc_irq_at(..., &arg);

Then there is a great big clue right in the code who is supposed to be
consuming that opaque argument. grep the code for foo_bar_domain_data
and you can find the receiving side

> At least from the two examples I have (IDXD and wire2MSI) the per
> instance union works perfectly fine and I can't see a reason why
> e.g. for your usecase
> 
>      cookie = { .ptr = myqueue };
> 
> would not work. 

I'm not saying not work, I'm asking about the style choice

Regards,
Jason
