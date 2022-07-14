Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D57575642
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 22:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbiGNUTQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 16:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbiGNUTN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 16:19:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D7F65D68;
        Thu, 14 Jul 2022 13:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657829951; x=1689365951;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5+G5XYYhHjriDY3qm5yLqHrxSmfsJXdxNINpghUKXv4=;
  b=e7Mwl9A280gQg36AxgZWMD+kuDGzt5BkU4hHR8K8qAWMlUMfM0zWW2vC
   wSQ1uOqv1tEIlxpQYjvTx9u/Mg7JlkoLTMZdV3nUEMstLZpfpQPzEFkb5
   jhWbc6Te5UUWU7dGZQTCq422BAnaLDdTKH/Q5mcKAiqXV//1q+6cEF5pg
   LBtU16RlETT+cIWnrSK+zavnNmxoc5HqloYtXbINGmDsXZ7qaaZCBQGSV
   XXrOHvdfge4GPHaleOIE7aABfMe5b3JIjE/JwWMZCm8lo3B9Eqve0FAY0
   gRaA5EzaEHIeIELfq0SevCSfYzCF2qAzxDDZnTk/m/m8nHPcmJ4PEZqIU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286362222"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="286362222"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 13:19:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="546403423"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 14 Jul 2022 13:19:09 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 13:19:09 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 13:19:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 13:19:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 13:19:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC2u9Ebw+7sbeLGMfMrasqdmJBnuo91bp+bnBiLqUSiKA2BDioBk43YRviZDzgP6+lLzGok7qAwiJ2EMtm5VMzVrk2Ao2FnOYZFiXpE4AABBEmzokOIY6zmq7XYTC1trNxmb9p0TnQhHqr4m0QSJi5elJSP8P5O5fD9B1s0vnXbELzMt9ZNNZ0PJQFSWfV2f8sNmeFtqH5rrgeyVExVm5YTXDZEN7v3LAUBfv57siPxkkDlvXHNjkfpV1zqMIefbUl6MUZvqiCfhZZYLin03BReaDZCT7McRxuNnsx7DIs2HWEcUe32HVUFu3LM/4i37rCMo8n2XbFQh05bFZQRf4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Okf0kIqrqU2isKkTp9KZWROiHhbd2gpqaLCjJQGAXxw=;
 b=L2iXinTv6JJvs+oB6DuR9riuJEhG9jzfr3BYZ+p7KsJPx8bUDTeiWpPyFcWTY/1GNqseRaxkwnJkwuYp/vpLv7ESkXNqhNdDfIPJS08V77fO5Y89MWMqSdBJRuFA0MZd8u/V4geidcmxwozp1jFfOIXM7bAj07n9PlJRltPjf0Qq0s53yNqS54oPMdWrQc+vkcbA9dG41bgFjNYJv04w3csu3NlmuFZKw8Q3fQjhHj39w9K0TcxuO9M9fecvShUMdMUurC8FOM0/nkG6Hdo1KKvurwo8s1DUR5q+U7bcLbgYysnH5TPNDJLxKiD1hjV6diZ8hFFuUrPTur0mhnTbEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DS7PR11MB6245.namprd11.prod.outlook.com
 (2603:10b6:8:9a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Thu, 14 Jul
 2022 20:19:06 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.014; Thu, 14 Jul
 2022 20:19:06 +0000
Date:   Thu, 14 Jul 2022 13:19:03 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V13 6/9] cxl/port: Read CDAT table
Message-ID: <62d07a37d25ed_16fb9729491@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
 <20220705154932.2141021-7-ira.weiny@intel.com>
 <62d0387522e5b_16fb9729432@dwillia2-xfh.jf.intel.com.notmuch>
 <YtB0loLvlKbgcA43@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YtB0loLvlKbgcA43@iweiny-desk3>
X-ClientProxiedBy: BY5PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4e38483-7dde-41d6-8e50-08da65d61a1a
X-MS-TrafficTypeDiagnostic: DS7PR11MB6245:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ivdUzkZ8IxyTDdv52vQlfq4KTsArdwHITRV5HSX1PVHnFRRnwCiRAf8LfT5kXmSh+C9iGnOBD8IU4Uur0PrAGO2cR08Ypd2GQTd9eGaxScMaQQp37yE7FnHzjat7Q0vfzDhZ4nlCNs3C2p2Z8jAe4JDKUygl6f1KqeFY4wUSMAGSG5Lw0k7DOIgVnYfg7Y4FBJJVgQqQhCM9zDVZnqCYt0SKQD7gKra6JoDYvXpDpliAhcq/m+aWu2aZIvx1i2Fb+NpWJqAQwFBGuz8n4inDKjbCLVcflB6nBRwidltVBqfXZ0alfbgLfIu490/Yb1jSFIMVZ25b3tHkWK8d56e2vbdoNCQxY6/jUmKibubeqw5xnymEtyv4KjtWlTJ1aFi3ylgJUQOTLPlH4Vie9c/Ja+vvAPrrolNSuX1q+yUY1sYhKbD7c5qLZZueO8O3LWZ+mxne3OhXe4jegrluk7vs1e5z6qdOmI8AwOwBvDO8xjbOkBki3x5/blyoI6rPiVUBpk2eW1MkjxqRcwvTHdL0kmBDwo+k6j9GNiP400nWM3DRLXGBtPeMNKTiFVwL+mJ/U4rRKaFxJyek8laktClUEIDqtmG71L8EikhPoXXUdWa6NMHyXA3o1zEpOOY1MmWrQjuBSeXDwG0weoCec+pHqb/4cn5GLlVFS6PYU4Lv2RtvQjRtpO9nk1XGIGhzlmI40TgxCS0BzJqP3VQ/lvTTIko2COrI8uGjC46C+ONeHolHWXPEWU+5HeAUSFSTrqt7/qa1tXa06du50yK/QZRv0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(39860400002)(376002)(346002)(396003)(38100700002)(478600001)(6666004)(6486002)(6506007)(6512007)(186003)(9686003)(41300700001)(26005)(82960400001)(83380400001)(86362001)(30864003)(2906002)(8936002)(5660300002)(54906003)(110136005)(316002)(66946007)(4326008)(8676002)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?reaAifJR9dbpgYuAeel8UONinj/bh/fyS/azKiFmBBJls57pdhN4LaIlsXSK?=
 =?us-ascii?Q?UrjVDdzRH19dSkRCg3uEJAJrTbKoQ32e/rLqJpm5uiw2+eoCHgORLsU7yu1Q?=
 =?us-ascii?Q?kqxVq8NNacg7aC7flQAF+YjxVDIV9IAxQoD37cCJzstSm18Bvii/W5XJL4gC?=
 =?us-ascii?Q?Dmrazxd9KvevLEJH55QlMuDB1F+HfBDyqKscwnUlJB4WujJm8nqe6Iq8ff8w?=
 =?us-ascii?Q?iAj7oxa2ODMpU83JSoGjTvmy8r3YR+ZNxhcmcXasieRYI+Q/HA+DGMjL97Xx?=
 =?us-ascii?Q?e5A1Yml+CO54ldZ43LljGXdYkb/5XjgPeSm5eE/VIQ7H8vvJ2YcEXMibZxKu?=
 =?us-ascii?Q?GURtuvhOaHOWi2AVQwKCLM9690mfY+dGjKkX0BNp43WYPn9yqZ3I2dyp1OA+?=
 =?us-ascii?Q?7+AE4eg8IGR2ORDex1hRv6THOsTSghjVE599kPi1fr5lDhZ4vIBO8p5vhlmX?=
 =?us-ascii?Q?aXr2EnYpm+yKixFI4B36Y6heR7l3f3UWLxnm/331iWTHgwt1wRWSk05iHzwI?=
 =?us-ascii?Q?GSrYs1c7lYiQjuz4xMbRXfa9i7z5ZtT/9tSzN3GdrXsu/cJRhn/vnj1fX7Y3?=
 =?us-ascii?Q?6SGlct/rB1kyTDH0J+z+JW838FPXdK363HYOWCZDsAFLvt11Odf/TpkTSq0P?=
 =?us-ascii?Q?uMb3nPPdNt504mnzgApshhxpwqXJONJWLQKL7oRHM86Ex5G4oFcOaSmeU8lo?=
 =?us-ascii?Q?xm+ADNFYWUhPg83c0f48MiiTuuf1zef3iPTlYLXHINsQWfhAtjxPcxvgAYxS?=
 =?us-ascii?Q?FJWn4atbBekW/Ee4z0RVM6H70D2l4PXv0guPoDMGhRKkrD9rsCICJIxoR0UT?=
 =?us-ascii?Q?fE+M79xRg5SidcLY1g8fAZ11C9+y4das4IuwCbYrU6cm8HRboFJu7lBOcyZz?=
 =?us-ascii?Q?JNyCN15/aEDnVPZeU8zMsTypkkM2MLxyh7WhDh7opE+KroQ5dA74GoWi32S4?=
 =?us-ascii?Q?OYBKMo21DN8yHx+SuU2ViH75kfKAJvsBo732lAMX+BgFWzuFmyzf3uXJCtCI?=
 =?us-ascii?Q?K+jaEg7EulUwHmXmS7jJHjOt43UdJkIRU9preS+hV93VpUCJlHZeIG6QTERl?=
 =?us-ascii?Q?Tp+LsgL+QstOc+CTLoaZOPq/SL2Tw2seCgdyMTw+nZZIwWCCGOvlMWAgvoGH?=
 =?us-ascii?Q?TmUtDMM+0HxOsCByHPYvjms+V4BBfLc8Qlz66wp08jCUgZ8kne0m45F9tDW6?=
 =?us-ascii?Q?UXr5yMmAHg/P+o0QMtnjU6pS5IS7bCIoaDZAI+DOi7kKIr7aIVfQZSLKIYyz?=
 =?us-ascii?Q?h5xCC9UQPbGq/24n5L2uB+XAcmGmb2vg77qigXzPRy+sF3SZVtrYotRIOr4u?=
 =?us-ascii?Q?2KRWBFn3kEFgY0dK14QMdUOXIwInpY+RQ8iT90FAZ0EKukuOsgoMoQ5CF9S8?=
 =?us-ascii?Q?vzZOaF5dkKHUEOCu5324GgJ8JM1W2qN1LXiDNmLOklo33BN1VxDpQOz417ah?=
 =?us-ascii?Q?ZfLAxt4HM0VgxPYHVvNgr6ijHXkNli3IktCuXE46DJpMmHYz6H5/ZorfUZ15?=
 =?us-ascii?Q?2IE8baK+qJHRuwtIMuV8najjra8aUP5ObViIazG0hJWHAA7tbwLbH4dWtdVt?=
 =?us-ascii?Q?s1Fz4z+2+S1+wvsNmqGAxmMcZ1ZqN3HpgWkBlPZ9X7hibZsIPbPoGhLjIx9Y?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e38483-7dde-41d6-8e50-08da65d61a1a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 20:19:06.3107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /imSfvjGVG3dukAZsxzngAjAF5vwTvnrerv+6oj+Rar5dEXJ7N6AukHlwObPcs70NQvbEzZyg88vs76fd/TJu20qCkaew1XYDJX3lqjOtvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6245
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ira Weiny wrote:
> On Thu, Jul 14, 2022 at 08:38:29AM -0700, Dan Williams wrote:
> > ira.weiny@ wrote:
> > > From: Ira Weiny <ira.weiny@intel.com>
> 
> [snip]
> 
> > > ---
> > >  drivers/cxl/cdat.h     | 100 ++++++++++++++++++++++++
> > >  drivers/cxl/core/pci.c | 170 +++++++++++++++++++++++++++++++++++++++++
> > >  drivers/cxl/cxl.h      |   5 ++
> > >  drivers/cxl/cxlpci.h   |   1 +
> > >  drivers/cxl/port.c     |  51 +++++++++++++
> > >  5 files changed, 327 insertions(+)
> > >  create mode 100644 drivers/cxl/cdat.h
> > 
> > The bin_attr additions to CXL sysfs need to be added to
> > Documentation/ABI/testing/sysfs-bus-cxl.
> 
> Done.  But with a very simple text:
> 
> What:           /sys/bus/cxl/devices/endpointX/CDAT/cdat
> Date:           July, 2022
> KernelVersion:  v5.19
> Contact:        linux-cxl@vger.kernel.org
> Description:
>                 (RO) Raw binary CDAT data.
> 
> Is this enough?

It should talk about what it means when this is absent, present and
0-sized, present and non-zero sized.

> 
> [snip]
> 
> > > +
> > > +/* Device Scoped Memory Side Cache Information Structure */
> > > +#define CDAT_DSMSCIS_DW1_HANDLE		0x000000ff
> > > +#define CDAT_DSMSCIS_MEMORY_SIDE_CACHE_SIZE(entry) \
> > > +	((u64)((entry)[3]) << 32 | (entry)[2])
> > 
> > This looks sketchy for 2 reasons, there is no type safety on @entry, so
> > it could be anything, and it is referenced twice which is a bug waiting
> > to happen if this or any of the other macros that copy this pattern pass
> > a statement argument with side-effects like:
> > CDAT_DSMSCIS_MEMORY_SIDE_CACHE_SIZE(entry++).
> > 
> > > +#define CDAT_DSMSCIS_DW4_MEMORY_SIDE_CACHE_ATTRS 0xffffffff
> > > +
> > > +/* Device Scoped Initiator Structure */
> > > +#define CDAT_DSIS_DW1_FLAGS		0x000000ff
> > > +#define CDAT_DSIS_DW1_HANDLE		0x0000ff00
> > > +
> > > +/* Device Scoped EFI Memory Type Structure */
> > > +#define CDAT_DSEMTS_DW1_HANDLE		0x000000ff
> > > +#define CDAT_DSEMTS_DW1_EFI_MEMORY_TYPE_ATTR	0x0000ff00
> > > +#define CDAT_DSEMTS_DPA_OFFSET(entry)	((u64)((entry)[3]) << 32 | (entry)[2])
> > > +#define CDAT_DSEMTS_DPA_LENGTH(entry)	((u64)((entry)[5]) << 32 | (entry)[4])
> > 
> > More sketchy double array derefernces against an unspecified type. No
> > need to invent a new way to parse ACPI-like table data. CDAT parsing
> > should end up looking a lot like: drivers/acpi/numa/hmat.c. I.e. I would
> > expect the helpers in drivers/acpi/tables.c are repurposed to parse a
> > passed in CDAT data buffer rather than using acpi_get_table()
> > internally.
> > 
> > Lets drop patch 9 for now and all of these definitions. Leave all the
> > parsing to userspace via the bin_attr. Then we can circle back and build
> > up the CDAT parsing code when its ready to consume the data for QTG
> > assignment, and reuse the ACPI parsing code.
> > 
> > > +
> > > +/* Switch Scoped Latency and Bandwidth Information Structure */
> > > +#define CDAT_SSLBIS_DW1_DATA_TYPE	0x000000ff
> > > +#define CDAT_SSLBIS_BASE_UNIT(entry)	((u64)((entry)[3]) << 32 | (entry)[2])
> > > +#define CDAT_SSLBIS_ENTRY_PORT_X(entry, i) ((entry)[4 + (i) * 2] & 0x0000ffff)
> > > +#define CDAT_SSLBIS_ENTRY_PORT_Y(entry, i) (((entry)[4 + (i) * 2] & 0xffff0000) >> 16)
> > > +#define CDAT_SSLBIS_ENTRY_LAT_OR_BW(entry, i) ((entry)[4 + (i) * 2 + 1] & 0x0000ffff)
> > 
> > Yeah, all of these unused CDAT defintions can be deleted from this
> > patch.
> > 
> 
> Done and patch 9 dropped.
> 
> > > +
> > > +#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
> > > +
> > > +/**
> > > + * struct cxl_cdat - CXL CDAT data
> > > + *
> > > + * @table: cache of CDAT table
> > > + * @length: length of cached CDAT table
> > > + */
> > > +struct cxl_cdat {
> > > +	void *table;
> > > +	size_t length;
> > > +};
> > > +
> > > +#endif /* !__CXL_CDAT_H__ */
> > > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > > index c4c99ff7b55e..9232b806d051 100644
> > > --- a/drivers/cxl/core/pci.c
> > > +++ b/drivers/cxl/core/pci.c
> > > @@ -4,10 +4,12 @@
> > >  #include <linux/device.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/pci.h>
> > > +#include <linux/pci-doe.h>
> > >  #include <cxlpci.h>
> > >  #include <cxlmem.h>
> > >  #include <cxl.h>
> > >  #include "core.h"
> > > +#include "cdat.h"
> > >  
> > >  /**
> > >   * DOC: cxl core pci
> > > @@ -458,3 +460,171 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
> > >  	return 0;
> > >  }
> > >  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
> > > +
> > > +static struct pci_doe_mb *find_cdat_mb(struct device *uport)
> > 
> > small naming nit, probably more places than this, but
> > s/find_cdat_mb/find_cdat_doe/ to make it clearly distinct from the
> > drivers/cxl/core/mbox.c infrastructure. I.e. I think "mailbox" is
> > implied by "doe".
> 
> Good idea, mailbox (and mb) is overloaded.
> 
> > 
> > > +{
> > > +	struct cxl_memdev *cxlmd;
> > > +	struct cxl_dev_state *cxlds;
> > > +	unsigned long index;
> > > +	void *entry;
> > > +
> > > +	if (!is_cxl_memdev(uport))
> > > +		return NULL;
> > 
> > If this only supports endpoints just call this from the part of
> > cxl_port_probe() that does:
> > 
> >   	if (is_cxl_endpoint(port)) {
> >   		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
> > 		...
> > 
> > ...and let the person who adds CDAT support for switches refactor it
> > later. I.e. find_cdat_doe() can just take a @cxlmd arg directly.
> >
> 
> I was trying to make this generic for all ports originally.  But in the end we
> punted and said end points only since we don't have the plumbing for PCI port
> driver yet.  Won't I have to move this back when that comes online?

Yes, but:

    if (!is_cxl_memdev(uport))
            return NULL;

...in this path has no reason to exist in v5.19. The need to consider
switch-port-CDAT is at least a full kernel dev-cycle away.

> > It's
> > enough that this patch located the cdat cached buffer on 'struct
> > cxl_port' and the 'CDAT' sysfs attribute under
> > /sys/bus/cxl/device/cxl_portX.
> 
> I'm not parsing this sentence?
> 
> .../cxl_portX/...
> 
> does not exist?

No, I'm saying that the sysfs location is fine, and find_cdat_doe() need
not consider switch-port-CDAT yet.

> 
> root fedora /sys/bus/cxl/drivers
> 12:46:39 > ll
> total 0
> drwxr-xr-x 2 root root 0 Jul 14 12:44 cxl_mem
> drwxr-xr-x 2 root root 0 Jul 14 12:44 cxl_nvdimm
> drwxr-xr-x 2 root root 0 Jul 14 12:44 cxl_nvdimm_bridge
> drwxr-xr-x 2 root root 0 Jul 14 12:44 cxl_port
> 
> endpointX points back to the same place as /sys/bus/cxl/devices/endpointX
> 
> root fedora /sys/bus/cxl/drivers/cxl_port
> 12:47:03 > ll
> total 0
> ...
> lrwxrwxrwx 1 root root    0 Jul 14 12:44 endpoint3 -> ../../../../devices/platform/ACPI0017:00/root0/port1/endpoint3
> ...
> 
> root fedora /sys/bus/cxl/devices
> 12:47:59 > ll
> total 0
> ...
> lrwxrwxrwx 1 root root 0 Jul 14 12:44 endpoint3 -> ../../../devices/platform/ACPI0017:00/root0/port1/endpoint3
> 
> So what is different from what I'm doing?

Nothing wrong here, sysfs CDAT location is fine.

> 
> > 
> > > +
> > > +	cxlmd = to_cxl_memdev(uport);
> > > +	cxlds = cxlmd->cxlds;
> > > +
> > > +	xa_for_each(&cxlds->doe_mbs, index, entry) {
> > > +		struct pci_doe_mb *cur = entry;
> > > +
> > > +		if (pci_doe_supports_prot(cur, PCI_DVSEC_VENDOR_ID_CXL,
> > > +					  CXL_DOE_PROTOCOL_TABLE_ACCESS))
> > > +			return cur;
> > 
> > This has me thinking the doe_mbs xarray is overkill if all the other
> > DOEs are just enumerated and then ignored. When / if more DOEs need to
> > be handled then we can think about instantiating all of them and keeping
> > them aruond.  Otherwise, just do this pci_doe_supports_prot() check in
> > cxl_pci and throw away the rest. Then cxlds would just carry a single
> > @cdat_doe attribute for this first use of DOE capabilities in the
> > kernel.
> 
> I was hoping that code could be lifted to the PCI side later.  For now CXL
> could handle all DOE's.

It's only a couple of code to fetch the CDAT DOE out of all the DOEs.

> At this point CXL devices are the only one using DOE in the kernel.  I know
> there are other PCI uses coming but for any 1 device only one mailbox object
> should be created or we are going to have the kernel drivers conflicting with
> each other.

In what scenario would a PCI driver conflict with another PCI driver for
the same device?

In the CXL case cxl_pci finds the one DOE it cares about and throws away
the rest and nothing else in the kernel will ever conflict with that.

Don't try to solve future problems until they become present problems.

> So I'd rather leave this series with CXL controlling the DOE mailboxes.

Sounds good, I'm not asking you to change that, just asking for this few
lines of filtering to move to cxl_pci.

> I think later we will need to lift the mailbox objects to PCI and CXL
> drivers will need to query into that side as needed.  There was a
> version like this before (Probably Jonathan's) and I think the aux bus
> moved it all over here.  <sigh>  Sorry getting pretty confused myself
> at this point.

Sure cross that bridge when we get to it.

> The code change you suggest is easy to do but I think it would be better to
> land this and then lift all of the mailboxes to PCI in a follow on series.

That follow on move is not prevented by just the small move of this
filter to cxl_pci, right?

> > > +#define CDAT_DOE_REQ(entry_handle)					\
> > > +	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
> > > +		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
> > > +	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,			\
> > > +		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
> > > +	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
> > > +
> > > +static void cxl_doe_task_complete(struct pci_doe_task *task)
> > > +{
> > > +	complete(task->private);
> > > +}
> > > +
> > > +static int cxl_cdat_get_length(struct device *dev,
> > > +			       struct pci_doe_mb *cdat_mb,
> > > +			       size_t *length)
> > > +{
> > > +	u32 cdat_request_pl = CDAT_DOE_REQ(0);
> > > +	u32 cdat_response_pl[32];
> > > +	DECLARE_COMPLETION_ONSTACK(c);
> > > +	struct pci_doe_task task = {
> > > +		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
> > > +		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> > > +		.request_pl = &cdat_request_pl,
> > > +		.request_pl_sz = sizeof(cdat_request_pl),
> > > +		.response_pl = cdat_response_pl,
> > > +		.response_pl_sz = sizeof(cdat_response_pl),
> > > +		.complete = cxl_doe_task_complete,
> > > +		.private = &c,
> > > +	};
> > 
> > I think this wants to be macro'ized to something like:
> > 
> > #define DECLARE_PCI_DOE_TASK(vid, type, req, rsp, priv)
> 
> I was thinking the same thing after you wanted the task init here too.
> 
> Can I follow on with that work?  I think the following members need to be
> wrapped and hidden from the caller API.

Since this patch already needs a respin you could just do the simple
DECLARE_PCI_DOE_TASK() now and figure out the hiding of @work later.
I.e. keep the INIT_WORK() in submit for now.

> 
> struct pci_doe_task {
> ...
>         /* No need for the user to initialize these fields */
>         struct work_struct work;
> 	struct pci_doe_mb *doe_mb;
> };
> 
> Reworking that structure goes hand in hand with said macro.
> 
> [snip]
> 
> > >  
> > >  /**
> > >   * DOC: cxl objects
> > > @@ -267,6 +268,8 @@ struct cxl_nvdimm {
> > >   * @component_reg_phys: component register capability base address (optional)
> > >   * @dead: last ep has been removed, force port re-creation
> > >   * @depth: How deep this port is relative to the root. depth 0 is the root.
> > > + * @cdat: Cached CDAT data
> > > + * @cdat_sup: Is CDAT supported
> > 
> > That does not provide more information than the member name, how about?
> > 
> > "should a CDAT attribute be published in sysfs"
> 
> Sounds good.
> 
> But re-reading this 'cdat_available' seems like a better name all around.

Ok.

> 
> > 
> > >   */
> > >  struct cxl_port {
> > >  	struct device dev;
> > > @@ -278,6 +281,8 @@ struct cxl_port {
> > >  	resource_size_t component_reg_phys;
> > >  	bool dead;
> > >  	unsigned int depth;
> > > +	struct cxl_cdat cdat;
> > > +	bool cdat_sup;
> > 
> > Just spell out "supported", no need to save characters on this used once
> > attribute.
> 
> ok.
> 
> cdat_available?

Sure.
