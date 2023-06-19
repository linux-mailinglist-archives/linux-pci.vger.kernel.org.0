Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749C673590F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 16:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjFSOCT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 10:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjFSOCS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 10:02:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDECFB;
        Mon, 19 Jun 2023 07:02:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZX5hD7U6PN6xTf+Y4wKJDCETOIGNtW58PJ4O7ztLXqbu3K7BZ9lHQOX36feeN3E/If2pFxq5AaqIRjfD6Jkd4KmEaWHK/jnkx590oZApaDfpY5ywkHjGvQYoHdwkQH5RDTC9OFknCfEWi6Er2djWzfMssGxUVuVy+W9hKlIGydyfK3U3dZYIsD2Ep3CGC9TitcK7zswV/LVC7ucKVjbzt4HWxoy4ki/f6vLz0oYTN0o42k6Ty0QyvWmqfj0zwgHHYE19uxaTB4b/hb6vrx/HDNiJeqkkL4pRZjFG79Npi7pxTiPAfJ29mrnjEbkLl6rNohiVgakiz+ArkTiPMV02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+z06EoG1WohvWlEFicO9MzMmPS4KqP4nZWtWywfO+8=;
 b=bth+PVBaFSy7gzJ54tCmHV5FyNofE1mWlEw42T8sdpkwm5yzwwvChKyHiWNMGiZI2XOeH497dHpmvxwE8Xhya+tqjvJBTTxY4MRPw8Jq8wsF+7VS7UqooX2cci+BXYE9DqsrNtzmr5IPXbJnPXu/pwB6sUa8qB3pZcB5nUPyX/V62cOuLE7HVoIL+jh9nsMlFB0eq4dnm03D7RBU9PIPMdk97TC0YWabqDNjHHh7aXcuzjFZJW16EHnsC/CtDjcW/QtRHBKdX6fLlrvd5oEtsY2xBBHV0qgFZvoG4Dkp1HvVDBD5TKm7taaoyUnWHhaEDmz1iPNp8w+A2dbteA6jxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+z06EoG1WohvWlEFicO9MzMmPS4KqP4nZWtWywfO+8=;
 b=EjKPljpWJSkCGzGTtsJm/IxbAlhozmPjw1vC+HVrhPAoRECS3OnewUizNdXbBp0cI6hmPsuc0W+2SEGDGfc61/BTEgwcxk4muQBI10rGnVTTFdHRyjdzpsyrFXI0EC7P38O6VJOXajt0mvzdm4GTrvt3B28iwPH4It7+grLOnjVURpsdjY4IM8EmoFTMhCEO9ZhDvaBPNRk5IxtMro8Amt2jmxIuorSOQeq2PN3WS9e6kzbLWMnI3FzGru3V0c5sYCAHpkG7GSF/Ds9gcJxpxE5jMHXRcwuGE6Jxq+x1Jj83oshzVtX5EX21ZkGvci6E5pkVg8H+VGBf2GQAk9hZ1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 14:02:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6500.031; Mon, 19 Jun 2023
 14:02:14 +0000
Date:   Mon, 19 Jun 2023 11:02:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: Question about reserved_regions w/ Intel IOMMU
Message-ID: <ZJBf5DP60prFH5R2@nvidia.com>
References: <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com>
 <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com>
 <ZIiRK2Dzl2/9Jqle@ziepe.ca>
 <BN9PR11MB52765C24405D2475CF3CBEBE8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZIxTmGU4a5dniEY3@nvidia.com>
 <CAKgT0UfmdOOPSD5YvpHnh1A02URn9zxVLbyXJM_67On7xojLcA@mail.gmail.com>
 <520e2be4-726f-c680-c010-a308cdddbae0@arm.com>
 <ZIyxFpzh3WG+ifws@nvidia.com>
 <90823b33-1f44-8789-9a38-282407fd9f15@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90823b33-1f44-8789-9a38-282407fd9f15@arm.com>
X-ClientProxiedBy: CH2PR16CA0020.namprd16.prod.outlook.com
 (2603:10b6:610:50::30) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a322e2-655c-4ce1-c702-08db70cdc89e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qlCKTvtRWE9Btf80aZlCClW3rG3HFlqT4HU8IF2ZtMPN8JQ36DTIOMHJXc3V/9M2vrVSpBIv/3vQaYkE40gwONqcDNXB0jJEW3qy81vIZHjgdeJSXAG+kod3cqOAoOg0D+pYzQaFv/Qvh8Q23RBR74p7ZmOWsDSNpTYZ6wvVAs5eaWgZ3y1lOIuC/WaWMnGGXeP1jyliL5CJVO6DSZZyB7cY6yVe9ObQGxwrMCQzVNoNYB/IFSDKTVJx6XUTKJ0+UFaX61Yp4MiJ+B7yE24vKmqiNNz1Ba3xXCmHwAKIzjUHsAEXhWaM6Sq6VEQ07fDm2pylkdsVIIJ8WFvQDfPdxx0YRild11yhhkl36tzQ/tUr2I6Z0t9Olxw2Y1P/CpEYzrR0x+kRvfK9qS4PpdGFBD11LIskoCeuZS4BKmJbR28cdgu2RBzIEzY8NQVdKLMe/4jURcy5AQzBi9//8TBfSWWrQXNybvWsy6m1B33zHu8b5iB+Is+gYn9Gkc9UhR8V0Rsx+ZSechweZQnfzagsy9YUzDp3JsZ/0VUurDkVq6g72+fz3d3O6xtOGEDdEH3MhvZKTIhsZ46xUSpvk1evhvFjWU5+1FBo/Sv9NC6yqlw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(451199021)(4326008)(54906003)(478600001)(6506007)(53546011)(6512007)(26005)(6486002)(186003)(966005)(36756003)(2906002)(8676002)(41300700001)(8936002)(66946007)(6916009)(66556008)(66476007)(316002)(5660300002)(83380400001)(38100700002)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fnU59xuE9DDGa/mW6pr3NJq9Dk++I2xXCUoN+TcoXIeShRDtt1uqgmSQPSVj?=
 =?us-ascii?Q?MfemvOlIhr0Q6g+5GAKCxia0Y+xsniC8h1HpbukXjvZecDspMSBHJmis9VRF?=
 =?us-ascii?Q?gctDWURWnQNvceJYXUOJO2vPvEFnPIn4TIBQK5uWz+IEeoVZzhwBuDXoAdsW?=
 =?us-ascii?Q?gd1S0xP+9WqX8tyFL746x9Ab4sHx52ahraoBbbG/00LXjEhF79EKdNYeGnCW?=
 =?us-ascii?Q?YQcvuP+ctkSENetsGBmyTcxdzycYQRaU1PD/0of6BHlZPvfPaw4VcU7veTBU?=
 =?us-ascii?Q?a3+29fQZSE5IM27Wuy+CiePfTc1mnPo5LLUyCfqxax5P59tvOFQ/O5P/pREl?=
 =?us-ascii?Q?paNowCpq5IbGCB29mYEt5Ri4boaX/prS7X3fWxJi9qHnWuiGYN2OnJRw3ITs?=
 =?us-ascii?Q?7PKMFW56/mMvGBYEDfXr7JiCC950/U08VSRzwf9tadQqKRyQieqCXWZC9ZRj?=
 =?us-ascii?Q?TlZSCwARqgz3fyUurtdn+G38AFucg5EEHqhxAsXxL5ahaQODanbMr7YEE7Zr?=
 =?us-ascii?Q?7asTm7D1XuOLPrphlYMwcNt3DMgji2e43FkuoAE5E2A+2zKZNWNdV9syf02J?=
 =?us-ascii?Q?pOAgZ1Pe1vREDv8TinfkHjpYhGc0IgNYwce3xiaBYXr0PgW+/0xEi35fxKPH?=
 =?us-ascii?Q?c3KEUqs9PxnphdcLUoUakr6dGK/jfczHFwvKYSInfa/OmjgSasGTK7XJ9F2I?=
 =?us-ascii?Q?V31RdNrKTNvT9IaMtyD7w7xUhUX/jR4duSogj708rS4zCqdb0OE+sROg9Pte?=
 =?us-ascii?Q?dj+VjBQL16TXrF+zlm7BNVYthBieFaItt8C7l9tDPNKvoOw5WSk6kK6t/iW4?=
 =?us-ascii?Q?0xxUOlj+tWuDEo0fD/Xkntm97VnaYnocZdaT/RSdCgEnKLjqxrBf1zZiq/wK?=
 =?us-ascii?Q?CZrWVwE/slXS59cun31TOBX9ZcfEvgE39IIOU29mbJ29wOdA5kOXAXcSwZma?=
 =?us-ascii?Q?RZcbTahX2yICTUhtBNomDmMVir22ul5ViaW+IZrL6jufH7pfS1jOKf6cZSWA?=
 =?us-ascii?Q?L4+/DIHO6ep2HQ4x/uTCmAWwKDnfd8sH9F46ruhVOs74+A4kijArUjk2vBsD?=
 =?us-ascii?Q?GPnElJLxWNmi07Dm739B0cc+bk87Bv6+MA2/2EweITXhmH2bjJfP6Q9UO/ch?=
 =?us-ascii?Q?HS6uIdcBpLRZIMGgQ/W5Jm9ohvJE+xB5nlMXE+YLduAp667U/9B148dU+n+p?=
 =?us-ascii?Q?wfiEmYyZvAmTty1kg34hbS0BIScaXaBEj4rgkpnRy/L/n9h5a/OiHzQXkYaG?=
 =?us-ascii?Q?zY06xu4ReqoEF1Zzq7JrzB49PhmuJcDOe8/Eq9+7qw+aC/loUZStvBQ0n3wl?=
 =?us-ascii?Q?bggqEESEp8ZKzIQGcEV1fwsWbT+NkRERzvnwm3v7hHy4N92KnQ6nPC2jrOcu?=
 =?us-ascii?Q?NbMzNlcKwGZK35crYRhNWmaK+WBbpFeTvTbkCsyc0a1WuKMN3JrilhANtSZh?=
 =?us-ascii?Q?vbOIG+jNpRv0rNTYUFdB5pBFymy1aQ+25FhQ4Sf/AUMSVmD+vT1i1n2y9Qrw?=
 =?us-ascii?Q?gWt/Ov4pfl5ZqiqkmQHfTW9vWk4BYKW44x70Adt1DZySMooKuf5jFnv+xi/C?=
 =?us-ascii?Q?bEQKG8635jGsriGu2Zo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a322e2-655c-4ce1-c702-08db70cdc89e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 14:02:14.0524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWRXjOVKbRQ4ZssnjeaO+YYLrWzCRmL8eCddTZrpgyoqh7zN7MXyS0D6d525rusr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 19, 2023 at 11:20:58AM +0100, Robin Murphy wrote:
> On 2023-06-16 19:59, Jason Gunthorpe wrote:
> > On Fri, Jun 16, 2023 at 05:34:53PM +0100, Robin Murphy wrote:
> > > 
> > > If the system has working ACS configured correctly, then this issue should
> > > be moot;
> > 
> > Yes
> > 
> > > if it doesn't, then a VFIO user is going to get a whole group of
> > > peer devices if they're getting anything at all, so it doesn't seem entirely
> > > unreasonable to leave it up to them to check that all those devices'
> > > resources play well with their expected memory map.
> > 
> > I think the kernel should be helping here.. 'go figure it out from
> > lspci' is a very convoluted and obscure uAPI, and I don't see things
> > like DPDK actually doing that.
> > 
> > IMHO the uAPI expectation is that the kernel informs userspace what
> > the usable IOVA is, if bridge windows and lack of ACS are rendering
> > address space unusable then VFIO/iommufd should return it as excluded
> > as well.
> > 
> > If we are going to do that then all UNAMANGED domain users should
> > follow the same logic.
> > 
> > We probably have avoided bug reports because of how rare it would be
> > to see a switch and an UNMANAGED domain using scenario together -
> > especially with ACS turned off.
> > 
> > So it is really narrow niche.. Obscure enough I'm not going to make
> > patches :)
> 
> The main thing is that we've already been round this once before; we tried
> it 6 years ago and then reverted it a year later for causing more problems
> than it solved:

As I said earlier in this thread if we do it for VFIO then the
calculation must be precise and consider bus details like
ACS/etc. eg VFIO on an ACS system should not report any new regions.

It looks like that thread confirms we can't create reserved regions
which are wrong :)

I think Alex is saying the same things I'm saying in that thread too:

https://lore.kernel.org/all/20180226161310.061ce3a8@w520.home/

(b) is what the kernel should help prevent.

And it is clear there are today scenarios where a VFIO user will get
data loss because the reported valid IOVA from the kernel is
incorrect. Fixing this is hard, much harder than what commit
273df9635385 ("iommu/dma: Make PCI window reservation generic") has.

Thanks,
Jason
