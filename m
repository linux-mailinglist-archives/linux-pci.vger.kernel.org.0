Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3E655E837
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344905AbiF1OYS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 10:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241831AbiF1OYQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 10:24:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34AD2CDC3;
        Tue, 28 Jun 2022 07:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656426255; x=1687962255;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iP6rFGN4MVizacFDXq6Afq+IzlEelUMyR7YWaozVSFk=;
  b=HPltUJ6ONfZ+KHDCrwWP2e7DxCrBm1Xd5WHuz6bk4McSZtaK2chJGzHh
   h1p/0TOiU8CXRDJ4gPyl51WBQeB8TysnKoBrmrjoWbGJgx3nR7+hxt4EX
   THDOeYPzQQMn5Jh6sZVWgI8uaf1n5VSc7bVNAxs5vQgC0dhiAZkVgKsTY
   H//8fT34dOvWTAh5nVD2kwG9KkjQ6+ILSecdm4wvPu4EW5dnQK1IVV1kf
   8SvbH/WQGsV8odF5U1+CAusK5KZS5p7udovrXAfL3fmB34AkfiKhXN1zO
   9uDLgWUBvl+Ohsik3oxFUCqO5lsxn4utgc9Bw76KmIGunVCLUlBBqyUvm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="262163869"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="262163869"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 07:24:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="836693138"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jun 2022 07:24:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 07:24:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 28 Jun 2022 07:24:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 28 Jun 2022 07:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVqSP7pQl8Bi2Q5ZTFaU7DsY56mYV7+eLVeGKMQMMNtawrXXzDwCDsPeTtC5L+Ka0Y2fMxj+mWLB88nLkWKJxpEOKDVHc9OuZJkIKuSuUzK3cotAI5wflosbtpvr5qqzcYdisg5cyxnHGhWvzlydWVHrjlabis9VVd3XDKzVwl1KotxxQdCuWV3an3DXgmeIuxKNK3UCwnwSwmRclb9exvXLdyYhr3zRBLJao/VQWtBb6r6K2T895AFc350NEZ/yNojffBe6obTvjV1TZJFCg3NI9vs4mC3AXZNM70Q2JxKkC48NYEb/sYPgjpgJpk2Y1XCJnnu2A5Z93IPMGxwNeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FWLgMHLgvmj+cL604b9YrwzXDji77zjZjd8AgExVYY=;
 b=Us+DGOja2/sw1Yh8Zi1277R/MqZRfOKViJK/6TUVLPl3FtwfxCRZpY5mD0bz/MfRuUudTt6QX/1DKV9lXR24pkt+uB56FkzbjsRwNzik72lMWL3VOS80rkkIMnMTaMzUOp00zEQ4IuF+nzLppgX+UHalu5/5kmLs1WETYQ+FdjBwozNUnZPI69Wf+xYHC7D6R1+O2LZaQXuQztzl5eC36oVuCu0PJHFhQhqKdd3OPlbXNS6SEgawwzB3i8qgrxaQFt8iNjHm/fMwAtgXFmEJSDNG07qFevknYyPg+Rs1rZHlDWpRbI6rDQkL2+xj1OWC64Mw1Qg+9efk/IUVvLNcAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BN8PR11MB3780.namprd11.prod.outlook.com
 (2603:10b6:408:90::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 14:24:12 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 14:24:12 +0000
Date:   Tue, 28 Jun 2022 07:24:08 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 35/46] cxl/region: Add a 'uuid' attribute
Message-ID: <62bb0f08eb1c1_169b9c29432@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624041950.559155-10-dan.j.williams@intel.com>
 <20220628112919.000067e6@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628112919.000067e6@Huawei.com>
X-ClientProxiedBy: CO1PR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:101:1f::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5a2d9df-eaea-4d99-faaf-08da5911df15
X-MS-TrafficTypeDiagnostic: BN8PR11MB3780:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GxS82hgzDNFVN1W98Lja/PBehKoXfld4fzQ3opzr2j040mJnIBv2ZrfDZle2QB1982+sHSf7PBnleG1kynk4EeMYv8KusKmFIuqaZJc/CjEcPFNGp7QloSsS2QZcAeIaspEyFuxpYLo8UD8qIJS+yqX+w4uVdiHE6nZKwDOxJZqG8MiRnRJPXQCrbfOkou2Y2S7mhiZxGFqTWtSVFS07acBEmw35xPOfOcTpCsgVXH5cwjaTIFgGyAdYiHJJKPEy/aYnF39L9tbah8UVc3+YZDQasT5o3oEJWHcAuej7uMIt1zpyos7kpNiE+BNconY6ZTQSLAMAD6RoVQ3TopblGdvqUDdFRmTmiB23MqsDYTjhnZd4EJJebbpXT/xpznAQl/iEGBgmcsoGnvSR+mqwIPUPNVvCa5JEr12M1dBCZK32KneKF34IW0IkBi7lQMiReIIhPQeGxjQHIpMPu8w7c438VIWN+r3PJPx2QR5yecOMJ8gHci8uSX7NdRXvaSi3qPc3d/4t2mUWt8rOYXwgVGiXpwBR+J0O6qHX9l7uDFXa+awOxqXRRdnviZoKgG5x8Ews+xMouU4oSLNX7nbBIxHiYnz1HJfbtjQ/VmBQoMia540EaLgY1n+xOPAgw0gLC7p8ELSkOZrTJqD9iigR33X3LttKvmYtzWDFQ+24WDPMrZGyDT4UeqYuFyoy8qrvzrfnM3ZBcOrbw2LyxSyNlSExzMXWyet7lSEmsStRxIgOB7pyxYwYiLsy83jmQRfK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(39860400002)(366004)(136003)(6506007)(6666004)(316002)(2906002)(66476007)(478600001)(83380400001)(6486002)(186003)(8676002)(4326008)(5660300002)(4744005)(66556008)(26005)(66946007)(41300700001)(6512007)(9686003)(110136005)(86362001)(82960400001)(38100700002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pawm7HoS24uJtuNqrAzStsTrQDaq9TdNrEVZcZwFk+JRlA5/sIX29TjCCkN5?=
 =?us-ascii?Q?xlaefvHlEjuotomZtz5zy3r6q54ndI7Cq5gvLV8/laA0x1cLo5bIugkUoIhW?=
 =?us-ascii?Q?SkPWb6q17Sl6KCpjWocF7hDA4gM44Sv2/a9TJz6Tq39An9JhNE8AgJuNqEwp?=
 =?us-ascii?Q?cU7BrPE/R+S2P6scDpAkt1FKefMX1WeOvY0NStS0o/SPtKuut3UAHPDliD91?=
 =?us-ascii?Q?8lQ/lmHakHMB1nMJ9RB2lxrklFoHAPtE5K/dAmApMVFcJ+Hs6jj0NyloWud2?=
 =?us-ascii?Q?KHObmcS6pAuoOcmG1AXzRG9ga4oqbxxUE5olkP8gP0GW+KakJluh/3F6vOuy?=
 =?us-ascii?Q?v5YHpS1gArkyQvkylQnIpjwHcQU3fx7GRzTyGEuwf/6ihnj21cVvFgBoHafg?=
 =?us-ascii?Q?gkU2KJ/ckiaOOHoLaASAsiWar2R4udMfyC9CDIy6hURKGYnWIaQi7hpJrbkP?=
 =?us-ascii?Q?fgy0hXbEQIMOApQAbKfmhMTtOvpTES7WsOVflK/54WkPpngplGq3G6d1vtUS?=
 =?us-ascii?Q?Z09GE4OmNUHdfoAnOr0T4jjaniByjcS286yaDgQwdjMoA9wBVOJThnt/610E?=
 =?us-ascii?Q?WeifDcd6D2yHMtuTGFk6UiOhkryXw4JFQmZmbmjuF+J7a+jtiJPXQEGWn06P?=
 =?us-ascii?Q?RWs0AnLl0mb+gM5+Lv2ZnjKv+dpoIQLUvyr++FficlgSwECdYxCJBRvTxC65?=
 =?us-ascii?Q?GzlBD9/ZtexuZId8eCrDNTbmjfMQn7gVK64+dzbhEASDH5McD7R9eBtT/67d?=
 =?us-ascii?Q?IpT0VcUtH6ntZTEukQgdkEcPqY2N2lS+uvXFODTOo1ZkmGC5JCcREggWaWG2?=
 =?us-ascii?Q?SJ/WOkQdiK+8wcMYm1RG79POiHNurb/lYuKLfel8j5IzCXxa2gV9C0RMkwGN?=
 =?us-ascii?Q?asyeCCLRqXV7zHWYayvY6GpzqXFTCQrc3iv5eJT8SWMen5JgECCHvjIFqob8?=
 =?us-ascii?Q?+mtRbARhXj7ROdK9kMtdHIYKVqh6nRQagNpn07GULzFNRmBLvST8u46ErYIv?=
 =?us-ascii?Q?nNhp+e8uIVbhP5+BLyO+esmo3R4YI2OTO3o3IVTYJJ6livlqGFxp2ATWeWbL?=
 =?us-ascii?Q?8LT2PzcSt+vthSd5Uve9jTEZS07bvAIdISdG2tTTrEg8SoDtlhQ8SOy+VXXY?=
 =?us-ascii?Q?fCrxDUeqkpjdgmWCTwJDAevCm3dyDIOOAEDnCOlCHCwgPi/zyXKzylxu4Jl7?=
 =?us-ascii?Q?f4FCKiXl5oJ4J3S6Hf+bS5dD3LzjRzeNIaOemZMvA0wrt4xCiVBQQwLU3zQF?=
 =?us-ascii?Q?87ptL5PIFyX8mfAx/zlXMeBYsmiCWDkQeFcIM5W4rnM8COiWY/IdrEkhM0y4?=
 =?us-ascii?Q?lBSwmVFyKGQwOAqPPmfFrEwaS+X5ZpU+BCzMrz4IkBqNN+kubAcfHWFFyJPt?=
 =?us-ascii?Q?Ee6MEwXI1ZjmNybHvePxX2qhMuH0WrXv7v8ghefA7gsln9GQmITlS2XA9T9H?=
 =?us-ascii?Q?oitGHKjivjt2xzL8vf2IoERsbzhrDwKLj5Cz56ewOrdKEpT+PgpCr1YVJQVe?=
 =?us-ascii?Q?NNMka4To3mSeZIzMTN3/gS/R1ytKvEiDtWKWce2vN/gmgomufYro/QmmkxhW?=
 =?us-ascii?Q?fX/xJfY2WHojdk70QJWglolbXhvvIbWs5qtGazNKpM5KruzImsXJS/OnI+CC?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a2d9df-eaea-4d99-faaf-08da5911df15
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 14:24:11.9828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6ogCXPoWlOIPGy/msaTycw7mtyHwFUovJbEbkT7f8InbmQeqTIFoWoM9cREfLHCNw4cCbE6UeXbcJp7f62BTjNRyrMpc6LR3yFw50l8jrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3780
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 23 Jun 2022 21:19:39 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > From: Ben Widawsky <bwidawsk@kernel.org>
> > 
> > The process of provisioning a region involves triggering the creation of
> > a new region object, pouring in the configuration, and then binding that
> > configured object to the region driver to start is operation. For
> > persistent memory regions the CXL specification mandates that it
> > identified by a uuid. Add an ABI for userspace to specify a region's
> > uuid.
> > 
> > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > [djbw: simplify locking]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> I think this needs to be a little less restrictive as it currently errors
> out on trying to write the same UUID to the same region twice.
> 
> Short cut that case and just return 0 if the UUID is same as already set.

Sure, fixed that up locally.
