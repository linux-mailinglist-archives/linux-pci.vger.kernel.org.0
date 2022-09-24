Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8881C5E9069
	for <lists+linux-pci@lfdr.de>; Sun, 25 Sep 2022 01:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiIXXTY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 19:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIXXTX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 19:19:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D241E3D5A6;
        Sat, 24 Sep 2022 16:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664061561; x=1695597561;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EzSc0xFAlREPY54Yg+aE4Rr7P4+FoNAq3uii+Y8uRqM=;
  b=PBVlWxwi/T7oANzcg6fNWKPX6jKXtClOWJ2qAPI4gSwB7+qK1m0CZZHs
   NHr9DV5yGm1l6Sf139bdECec7WZpryYvOfgocAKnI3Q1VnZPe2DN3jR9K
   2wWUmFRqeqRdJ0ND9U1jE/72IV+iFUGIMkWtzOHbcu8uVJXYSIm6r6kwm
   UnAorrKneDdgNZ9w8oZ2V00mnb8ziKn+m2BuTaVSkkps12qDGEQSRFW/C
   fxvw9HAxnaWViSWoJfu+fbQBu0G6Rzezs+8gi3AISC0CMpg3laAoRkwCP
   NJxdfe/n8pAkSgVeKGPzDJ06iEoXLSbDYzyCghGlM6DBuDfEx5qpjxfcD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10480"; a="298414395"
X-IronPort-AV: E=Sophos;i="5.93,343,1654585200"; 
   d="scan'208";a="298414395"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2022 16:19:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,343,1654585200"; 
   d="scan'208";a="651374418"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 24 Sep 2022 16:19:21 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 16:19:20 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 16:19:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 24 Sep 2022 16:19:20 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 24 Sep 2022 16:19:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwbL9brg3Bfu0onHU/3vnd2IrlEzUWECvVpV+9FtZd+36pEbWKxUYHt6iCGXWQsoPVMvp7G4LTzoif2rsFDXxg0qvN5z6R3uX6fINdFv18v9eD+jY6ncj5VTQu16SEZkVME98H5r7gKOwTGTHsZOnBQWFrckk5hBM+jKQGCPSL/mZIeMSByYt/wpVlAtc07SmUizrEf2fJROs/A9gpBOF95InoILizj8BwGxyZh+UpTRvnAHGBwwwDm47pBbmD+Bgfu+B+iMYQob6p3ql1KI7l8Jyl+Bhkgb9n5hp8ptpOgudv756ACc0FRwpL2QvdrkBspaSrzY1OK47gurHP8VHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8CMoqVKkQi9MQTLAQQ/5/CO2Rk0tTNfz6iZGeTERgc=;
 b=OntajH1FYUH6TsW584MDutzQXCEBLRi/w7BuK30agVrSjIFcvomfz8H4957GlyhkX7nmUI3kEjADkk1TpExzzQFMCK3c6pplN123fePv5cMCBWA3zCt08OFd8Om1uj26dHTqNz2PY3b2RAWggVU0ZMejbAiRrJGTldKCHz0jqN77T9ektle9Ix01uYkUX8E2jfLcGImGm9cAdyAp+uaLWGrVAfbAghqoOavrPk16D/kDBXgMwdnV4SInlUlN4KJktmr3b6z75NBq7wGkYAMPIU2hNd+GkdBe48ZemlbvDM/aeEDnj4bx6tjv/7gobGcEusOJI2aovCB6QFpb/N3ohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by BL3PR11MB6363.namprd11.prod.outlook.com
 (2603:10b6:208:3b6::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.20; Sat, 24 Sep
 2022 23:19:13 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%11]) with mapi id 15.20.5654.024; Sat, 24 Sep
 2022 23:19:13 +0000
Date:   Sat, 24 Sep 2022 16:19:09 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        "Adam Manzanares" <a.manzanares@samsung.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben W <ben@bwidawsk.net>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        David E Box <david.e.box@intel.com>,
        Chuck Lever <chuck.lever@oracle.com>, <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [RFC PATCH v3 3/4] PCI/CMA: Initial support for Component
 Measurement and Authentication ECN
Message-ID: <632f906d99804_795a62949@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220906111556.1544-4-Jonathan.Cameron@huawei.com>
 <20220923213634.GA1420285@bhelgaas>
 <20220924053953.GA13820@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220924053953.GA13820@wunner.de>
X-ClientProxiedBy: BYAPR07CA0027.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::40) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|BL3PR11MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ae8fc2-61c1-4136-9270-08da9e833116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JW6k3yq8yb5Msa2HWMpjXi6J+67ugLKNMU5NACAr6VrlfBgJ8Y5gkl2L22EMl9ion7ivjewAHjqSObZkBtoV8T4Bjf4dODgTBTGQd5ARqI8a9Gz19w6Bka26zoM8JtiDkzeyst9cRq9t1pIQDeO9L0dNLMBdEOgobbBX3AflJrx8lGcdMaib8ubZYSXbjkL84DM9xtp6nODKUi2xsNFxaEunp5vhfR0BFS+PMeyofQgvUohH3fNoEo/clWW0doZ34gvxqLHV1x08SMUTjMbyJnOJYqhgSD2zpOQwc3Ce7QIO3cLvTtEwsTGLfs4s1qlZGYY4qGPLEJPHEfYYu3yE17aWBCqEUVtXH35DIL8HRPZ7vf39McCT1CI6rVPsaz8/QZYptyePjv1jh7+0qKrxoBPuBbXUwoxCsn8E03zvwQyVWuWGJlVb20jaXrmc4hwP81huQYaYGDfuqJib/foIJ1mBZTkcdz+G+//qPrPhPLpiQ7P6gHsRgBzrWx38ZXzwMGZTRJnOB29+eDSytq2mdvpoNLXhufdkawQcEWOL+ZxJgCxI8NyDm+r6sIzyhOmQqV+GRyERy3dY06wdrGzwDLDfP/yaVoIFNm81w+siAgHv8Rz4MpYopYLEIFjQrd5rqNHb5/KntNLSk0gYB1Xc1ht9M2z81jQkYmzOQ0j2U8naLMf6MSIRA8AFlHE8EOI6GhUUSlQKyEREAjdYjtk1fPoFulQ9nnyA9Vj4StWpOgI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199015)(26005)(66946007)(4326008)(41300700001)(82960400001)(66556008)(9686003)(6512007)(8676002)(6666004)(66476007)(8936002)(54906003)(38100700002)(5660300002)(6506007)(966005)(186003)(478600001)(2906002)(7416002)(83380400001)(316002)(86362001)(6486002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?43CwUK35gArh5rOrgtAD/T86HFWbHq67BYjPUrb6JSsaLfV+s6gcr/m1zFZA?=
 =?us-ascii?Q?Bzz2mBxBAy8es/916bYzfIzGCOVRwKIhkXwbvbocekxF8cQoUTjpAX8kVS62?=
 =?us-ascii?Q?jWquV/bSq7K8DUzCx/RYkI3XwKZmKeQ2hxqTyiFwrJ18y6CIKcXUEkHR0oPO?=
 =?us-ascii?Q?zvFiFU0KP7NWJpfqa+i+/W1IMQ0jGUBITVYTF5LZn/oFs25P6h/rM7ZSlOiI?=
 =?us-ascii?Q?Vw2OGAbJQgech46yeQyOSc7wnkcL1zPF4uPAiAQ23UqyfCV+++21VtMhnulq?=
 =?us-ascii?Q?FB6EDYx66MWvIkbJNpzacO2Zb6FYw4mbOKFk0tgQ6wn7W+MzqqTHIgjCvqVK?=
 =?us-ascii?Q?mdwNXBpTM0OjfoBfp/HMxm8pXnmB/ZLS6i4bjTUrojp+/DrZwKOhCWkZTJxB?=
 =?us-ascii?Q?4XIfE7kCzoII0hgEjwUePIwf7Jy3GBdFFlTz008rF0pka3vIdT9/HDQOjLZD?=
 =?us-ascii?Q?+D5zb4fOZdiFL8IQPIORe5uRl/FEGP56+PPo97IvU/RJ/vQmqr5EXY7SNhVE?=
 =?us-ascii?Q?c8X5/I6ZOVfG5O0knG1bve8ZWGbrickSBjNwSHZ+640Eut9rDx6K5XyzPZzT?=
 =?us-ascii?Q?Ru60Yxbue4hUeqOHruaa+oOpQIARMCqpJe6DITT9Zbj3TkIOsuu4qgvlHXu4?=
 =?us-ascii?Q?LeXHKHAnQZM97Fy/qT/Yma3zz8MpTPxmHQA+NZfLvDkgz3/86GDpqXGei4bk?=
 =?us-ascii?Q?4mzhuRQq1+bn/ONL9pl3xc7cCQbgb5I5e5vH2mhRtla5F4RWirm23HqAinjf?=
 =?us-ascii?Q?ANAIGZwXoNKeShVBp3Tcycw4ikvrAvg/33A1nquLcHJ0RKXzHAh5rfx2rFE/?=
 =?us-ascii?Q?yyNWEpiDqcO8ZYMnh1edqhX7J3wqwsJ0TW0SNGtt0IeEPbfuUci1rCPVmv+v?=
 =?us-ascii?Q?BdbeqFuIgafmVCOd2Vu0Q/tF9Vg1kohzIl7cBag7wfDFPWxdSp55+Fk5dN0a?=
 =?us-ascii?Q?Smod2RE8LD4y7BVmXpIccA4pA4uAA/QGa/shxigVKaMGgyyX8nQGD0INbLEb?=
 =?us-ascii?Q?9Y4LF47dZQ+tAeqedNmDjRkef0SLu33KkuHoX8CILUNaposimHAjUXkfyzg2?=
 =?us-ascii?Q?QK5h8aoIDSnYxogeRc5IZ6y26Iyf3oZ/ghOAoKxKQLvW3DRoOp/1f0t5Hz1G?=
 =?us-ascii?Q?+d5KPv87Z9ktulskaGgiZXz8xZv4LAAjuRTBh3mxc66D6dIATAjf704AxzgF?=
 =?us-ascii?Q?YfYRne+zeKNny9TwMhBpaN3u9tn3D4k5KjRT5FTMGWvmgRVSVpNR5CUtzo9c?=
 =?us-ascii?Q?+pWUu+oSNSeiTuNMupWq4g7u00KRsHDkVFzvhDp5658xf60hXHBBe0GBCbOP?=
 =?us-ascii?Q?7nLbf1pckXo5m3mMPg3MBySqNO7R6fgJVof7jUQJYZGJVYrB2icF4OmLhT9K?=
 =?us-ascii?Q?i2KOpsHUzawfh6UPzn9qsrLZFhoufvyG+QUhJzP7fh1tckrxZDOWcAt/I/pw?=
 =?us-ascii?Q?043eNt2Tm3X7684CxAv+Z+hYusPjrYVihSgRsAOC1ao1qXZtPxzk29HcxbUi?=
 =?us-ascii?Q?lBLJr7PvSzHptE+vbA3/ukeo1h6ASCfheguDbYbI3xo7tGZIuTlU/T523/D0?=
 =?us-ascii?Q?VxlGZ1z5fb+H2JmnJPdFaV4WoziyNmH1L5SE8TEt9n7aU5i3n+e80AIhQEbA?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ae8fc2-61c1-4136-9270-08da9e833116
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2022 23:19:13.0157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iD4hE2WME4di8/+M6VpYVti531rGvtgFo4NfJUuGKbWEqVgNk0bbBjRAT9PicCU5WqPyr1yB9Fm0k2Nli8kSgOpP711/sBsA/KIwQCKYuIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6363
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lukas Wunner wrote:
> On Fri, Sep 23, 2022 at 04:36:34PM -0500, Bjorn Helgaas wrote:
> > On Tue, Sep 06, 2022 at 12:15:55PM +0100, Jonathan Cameron wrote:
> > > --- /dev/null
> > > +++ b/drivers/pci/cma.c
> > > @@ -0,0 +1,117 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Component Measurement and Authentication was added as an ECN to the
> > > + * PCIe r5.0 spec.
> > 
> > It looks like PCIe r6.0, sec 6.31?  (Oh, I see that's what you mention
> > above in the Kconfig text :))  I have absolutely no idea what CMA is
> > about or how it works.  Other than pci_doe_submit_task(), nothing here
> > is recognizable to me as PCI-related and I can't tell what else, if
> > anything, is connected to something in the PCIe spec.
> 
> CMA is an adaption of the SPDM spec to PCIe.
> 
> Basically this is about authenticating PCI devices:
> The device presents a certificate chain to the host;
> The host needs to trust the root of that certificate chain;
> The host sends a nonce to the device;
> The device signs the nonce with its private key, sends it back;
> The host verifies the signature matches the certificate (= public key).
> 
> The protocol to perform this authentication is called SPDM:
> https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.2.1.pdf
> 
> Various other specs besides PCIe have adopted SPDM (e.g. CXL).
> 
> One transport over which the SPDM message exchanges are sent is PCI DOE,
> which appears in v6.0.
> 
> So-called measurements can be retrieved after authentication was
> completed successfully:  E.g. a signed hash of the firmware.
> Thereby, the host can verify the device is in a trusted state.
> 
> "Attestation" appears to be a fancy terminus technicus which encompasses
> authentication and validation of measurements.
> 
> Authentication forms the basis for IDE (PCI TLP encryption,
> PCIe r6.0 sec 6.33).  Encryption is useless without authentication
> because it's otherwise susceptible to man-in-the-middle attacks.

I would also add that attestation is useful without encryption. The
Thunderclap [1] class of vulnerabilities is concerned with malicious
devices impersonating legitimate ones. Where validating that the device
you think you are talking to also passes a challenge response with a
certificate chain you trust helps to mitigate that attack vector. IDE is
interesting because it is "persistent attestation". Whereas SPDM is a
point in time validation, IDE helps protect against swapping out the
device after the initial SPDM attestation. That event would be signaled
by error handling, making device swap out and interposer attacks more
difficult. I.e. you would need to silence the device swap out and any
upstream device that flags the error.

If Linux adds SPDM support for the value of attestation then I submit
IDE should be considered next.

[1]: https://thunderclap.io/
