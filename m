Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC30D57A9AB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 00:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiGSWPX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 18:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGSWPW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 18:15:22 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E244A829;
        Tue, 19 Jul 2022 15:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658268921; x=1689804921;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oB+Qhoil1PUMtPV0N8Fy5lOrc9hThwYriw+/Lhiji88=;
  b=ddSo6od3QzoPcdNZSatOe09ThJQbS+JXC2x5Uawqr5ggB2mB8jgB3IP1
   0EV5awJVp+eTbXv5c9JXah1AkACEROWIHv+Lam2+x4owZQvdtdHl9/o+b
   lIImqoCDzhd9ttvJ5ZbiHwmyrWEQH4L6S5s5VJQUaFPQ7V/Em3AeMLOQ5
   9vf+0AQMPjOkzxxLVtfKKRIewFvgPucE1HW5yh3pa7oLoQg4OiQVjiIEI
   LosmJgWayR3THJM4NU2IyRl5tX77cnVucRShdtrjmj72EhEpGVPg4vqQO
   mgiOm+Sc2ROYhe4fQFNANYabJpLQdpUD6xfAFr+v9Z7mB5mDQ+oOfjDiU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="372922360"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="372922360"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 15:15:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="625382109"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 19 Jul 2022 15:15:20 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 19 Jul 2022 15:15:20 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Jul 2022 15:15:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 19 Jul 2022 15:15:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Jul 2022 15:15:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lH1z44kb8dmVaNaFHsE+nMly7xvzs5iHx4pWPyITFmXTMDLV4Dp3myc3YXdPUUKmRyZUXtuvYwjA80fkzbmG0Acf8+PtGECSjMJoOMB5KDjIVeQjmi7mwpZbOkPmv2mdESgkUnt/f+ekGngN0fsIAQpaNAIoa64qdd5LpzbIn+U0AxsvC0GNNyUqDfc+XLDcV4S44SIfveFX7MnG/qU2m4OushqMOqpIBLL2MRKtUrlN57ujGEPH1RXZxyP+LPdcPSqEUiGY5yshN13HDZMlJbjS85AtLFc0Gu3CbkQJrWPCMrnINi8AL28PLXY4Uez7/s6i2Upt/NneXZvgDHlfAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xfDJxEOODeR7on39keOG4SUO5aokPOqLVqpJ+Tft24=;
 b=Nu7RYCtgdEsd72zZ7rHGIICK3oKVHY009BeId0paeIKd8OQUBFHl6MXeM0C79UJSehs80gv2g/H5dxjUSy4EzRcwSnBax6AeM6SII4RUpVNXrTYmJGpLZGT3QOho4TKZT/xFlSoQxWeHOEoFwVXE52L5nAtHrCfwoI9g7wLgwsGxKzLbFdTvf2fvIrEnNztb1j+YGg3++8VRKTFWezjQmHQchKliV6auRzbueOenz3ZhhMXoaHSzoiY/kT0fz31tuqXimNzR/1JI+PUVs3fDOD7b/kRAPHL4tamXiYRNsHM68j7kORPUaURtoKwWRirpe9zeLtUU57/e0lNe5SR+8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH0PR11MB5174.namprd11.prod.outlook.com
 (2603:10b6:510:3b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Tue, 19 Jul
 2022 22:15:18 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.024; Tue, 19 Jul
 2022 22:15:18 +0000
Date:   Tue, 19 Jul 2022 15:15:16 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 36/46] cxl/region: Add interleave ways attribute
Message-ID: <62d72cf43c74_11a1662945b@dwillia2-xfh.jf.intel.com.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
 <20220624041950.559155-11-dan.j.williams@intel.com>
 <20220630144420.000005b5@Huawei.com>
 <62cb6f9a74b33_3535162944e@dwillia2-xfh.notmuch>
 <20220719154718.000077ec@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220719154718.000077ec@Huawei.com>
X-ClientProxiedBy: BYAPR02CA0034.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::47) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17cd3992-4d0f-4f48-96cf-08da69d429c8
X-MS-TrafficTypeDiagnostic: PH0PR11MB5174:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GtL7zBVWHLhZ//dlekUva04XwQSb58KeFPZFlOGWXeYnF4Nm7S/0yWQh2gpsK7JXCcilHrSWyvzPzBJjD2ewLmBsLNquvsX0No4uQu9RcqvWJgV41n8uZGYDw95DwVeWAb9jHclUu4jGGioyv68bByXpC/OvEJ9o0hqAiwZU3Yx/z+p1WhF5qiJZTKl1t0S5nXt8N23p6bbxeTlq7Ao0iYwKeMk32E7DweyGUGcLpUSFshj6T4oKxMKqmjFdoVdHnDSme3bgFLpNighsfkpH0vJ2iHsdT9t9mLNjJ6nonQ9FP+qV4HyeC0st5CchLUO86a0RNZy4soFlVvAeFj6BYSklF/DFcfi5q6ZBFMmulfREtlRQDHfphZj5X51GayZydDrpa5lmI8YfJ9xqakpZB5SQbodFDWQJG1yNi0KD3F85afkATewBtqNpWyBXGmmgUsL9d9aCUPdGi4Jn7ihDQAncAMZWHvAsrrZtuiyKgXcfQbzaDQVJTZYrb97kkmrcp4FcO/p///mSjORGXxmPe7CQjWx6NPZ63U6xWaSA9oAQTuZhJMkHnNxCWDVvtOakda8tHxR+D+vnXD8uuKkRhdhWu97iTcyB7cpW6yNQGHOt/7OQGOD4GmsaAvDASnHWkUE92BseIuF9AQ92Q14XMPhgQ2oz6DTIQswUQEOj6Srx3zgRVGv873JPA+8yUDBhAs5efZSk/0ZjBaEKnCjVDjW7o6q081Cm1DiXorBNuLcmcRDuP+64Aqi3qsK6joEo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(136003)(366004)(396003)(5660300002)(8936002)(8676002)(4744005)(2906002)(66946007)(110136005)(86362001)(316002)(4326008)(66556008)(66476007)(82960400001)(6486002)(478600001)(41300700001)(26005)(9686003)(38100700002)(186003)(6506007)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OLvMkiVeiPvAwZC1rDFwdMptWBEtP4QJITD0cKjE1YtsGyzUF3eDjM3JaYmn?=
 =?us-ascii?Q?9ruWZwIyOg28gEovt1yyyN0mTNSabpmmQ6PK+5cxWNNEHftXjWmy4Uts12zE?=
 =?us-ascii?Q?SUFlNL/KTnDogVDjn0BKoIJTmOdY9J81WTBeNdc44tRoYCAdDvXdcKwZxodP?=
 =?us-ascii?Q?d8S9xgkyG42WCgY80qAclqZmP/uzrU9ghuP06/Dd3Uv6r31/lhdl/sPZwxB5?=
 =?us-ascii?Q?fLb1hEJziEYZZ5+AVthda5N15FK5ChxqmbWeCCiEAtku2wK8+XU1BQk7xG2T?=
 =?us-ascii?Q?3Dndf49m5ABb57KHWlBMizmBrIQTCsk689xT2iv0nt1fO7dACfy2zgruVmvc?=
 =?us-ascii?Q?UD8cn0dwiHiAFgsahII6kunGo3I7YT5zR/Lcb5x0urFuVTSDwo7Nhd8jDG7Q?=
 =?us-ascii?Q?QbmQc8NzbPVvL6+FDoIp6V03E5x6mZO/E4HuKQODMN4i4g+mGwkU85uF5rlO?=
 =?us-ascii?Q?eZ3thZU2eaWSB5qOgUUem4xtgPL14eoTpXNV5If7uLAc+pwII1Gj5g4fMOgC?=
 =?us-ascii?Q?IhgUAcyfMKxOIF60IeM1ug97s3qoj7OxX0TVBS0KyQI5gnDKV6nX5mZBrXWA?=
 =?us-ascii?Q?+ruQCGQCQ/e01oscJvnn/zi8o4kBPybG/mR+w0xeDwciT7Ddn9X7hot9T6I9?=
 =?us-ascii?Q?6ZWS0rLxl+XuGGGr8xVpIBghH0hiFWDGvQniuaKuXBBH0/XRYM42MRca6z4e?=
 =?us-ascii?Q?GDeiH16oIbYeGxh+HeIcP+hiK7PDcZDuQXFfBKylxDbwb64gPo19Wye3Ckcm?=
 =?us-ascii?Q?Dr7GiUvTFU1cT0vI/tJ0kHxas3rsvR52eBXPuKoYuCkd0Eg8nBPuiQpM8yCK?=
 =?us-ascii?Q?838wi/9ZlxRJjPLETWVKQsJbtWmxkmqErAM+6tmRAbdFILI0NAK9yNxaEdaB?=
 =?us-ascii?Q?tXUy6QabTkqNUwhS8Rpj4dyO7hB/Xq6DS70tfaBCaKtQAMZFmWTgdwsP9KTj?=
 =?us-ascii?Q?Cdjq+BZQRWaRMFCG2/EogGBq838zumNAUk5DG2R6f/tsrw4AyrlT9UjAyf9v?=
 =?us-ascii?Q?BkyC4iqob+OnBUppgPYjyNWh/zwCfenztd38IowJBm0XGxKMDzSCLQBhkLTm?=
 =?us-ascii?Q?9JfQhr7m5p/ifQ7JPPhXoOrXLp1DvC1jz/c4B7uEKj5BXboaWQdQHSmR0Gp7?=
 =?us-ascii?Q?6aHkLE7+ckTptH4nAV8pJvpOoILhRGnLzxXePm7IdAFlmwLcQy+g/bfIqgOl?=
 =?us-ascii?Q?uACATfEyf4HyqK0mhVcFukNiE7oXguNNAvTzOfLY+Nt8enxuB77ZWohPcxg4?=
 =?us-ascii?Q?aNof/zwo01tS9ezNf9bezxU3MhA/+N1zphUvf2cyObKF5bBCIGw82BTCa3Qz?=
 =?us-ascii?Q?vQxDB9kivTpxQCv1D7kdNZD03Tj6XucUGAMnNEhrlw7W3wpXWJrRvKvrUp84?=
 =?us-ascii?Q?l+Wybn9jSKdM5R9q5tAnf0NKjIiVfK9BwaYOpKoBRCvcz8x34etOylA1ltZi?=
 =?us-ascii?Q?jGHO+XcYpvuzVm90KDnijiGMLwLHZGG2qImZ5BYdMjgpOo6Sf1QEZEydK6Il?=
 =?us-ascii?Q?NuLtNpdraZ86sTGJQOmvfM0ex6k+CmNComhio4c/dxo89lKxGIJ2hktU5pRQ?=
 =?us-ascii?Q?GoL4O5O6xxY8T4E4VCHw3NMAE/XVvuvfk2A5y9Xoi7XdLI577IYXvoi374Ck?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cd3992-4d0f-4f48-96cf-08da69d429c8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 22:15:18.2903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXbxab+pdnKsz8Q/jjyD2ATbveLl4DZKbxt/HksPWw39olVNoGjnUDiE3BTeZArqKpz7kBw54uQINMfwRr/tvD8pLlsUAPqXXasF6J/3gLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5174
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> > No, I would prefer that as far as the Linux implementation is concerned
> > the software-guide does not exist. In the sense that the Linux
> > implementation choices supersede and are otherwise a superset of what
> > the guide recommends.
> 
> ah. I phrased that badly. I just meant lift the argument as a comment rather
> than a cross reference.

Oh, you mean promote it to an actual rationale comment rather than just
parrot what the code is doing? Yeah, that's a good idea.
