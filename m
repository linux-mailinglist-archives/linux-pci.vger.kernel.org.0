Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7345B270E
	for <lists+linux-pci@lfdr.de>; Thu,  8 Sep 2022 21:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiIHTp0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Sep 2022 15:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIHTpZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Sep 2022 15:45:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2349BB47;
        Thu,  8 Sep 2022 12:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662666321; x=1694202321;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/KkN3F7pMQj1/S6yDmXntgukaFPEEc9bGeCDjH3pQ4k=;
  b=ceVc+MxAKnxzjWPd83/IHN6gRF60DZl+jAUTPnEUf2ofrUqUUD3GcmzI
   xG6CYnBkiOAVLs0iCLT21ekBkeYVvtAHcGJUlwrw8ZFeTyTh8weSLdPw0
   9pELvNb1F2qec1H9XbRW0bZrguZy47v56IdsQI5aFmjIR1yH/8iC6Y2hV
   D3CAFWlB2XeO1TPyksRofjz9yw8xXqJCi6mKByaVNz3q5dPC4moNLAuXN
   lEjq2LhiCXbCNG/O/ZDvYPXR6QfzetOGEg8rBZzGRR1zH/7hKEfaP0Qrc
   MaVqy880jNpaHxwHyCgtpIqJRNW0Lk3gLcWNahb5fg4PgUMapfEDElgsw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="277694288"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="277694288"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 12:45:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="943492042"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 08 Sep 2022 12:45:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 12:45:20 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 12:45:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 12:45:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 12:45:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghBkPYnf1D7GXGb4FbS/X01pRYou7sR7yYkOoU7w2n+5VqGonOU0f4ADQ/KgMYVpko70b6N8nOdoOQhcXawm8wgVz7sx5fQkPSm0+vwpqe7Vmx9GizSFI4YVqStzi4QyNCN41GZF7MyGa38/PIbAh3MFaAgkLSRiPcxIAhIKSfW42uTdm8dEAJtXhOc4ZASPUzCz0OJI8TWzqlQpnHpunxwdTj408AUE8U3qLCoFDNcj4PD7zXxZ1/jyrtGUIglugZosHbGR5jvODgRsply/Us+jwhPnIBqwvPKtZQXziO5jUEj6NLy8/CLpWUX+rzQ6iS2KZ4GogOsjBuO0PN2AMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdJ/lRPRGKXiQESuwQ09D9OxNnIxnadGD+rhDw2G13M=;
 b=QebU1DZk9h+t87DPFfxyop1tvCu1XfFwUfnsP7j6Qm538eflPMZXYeX2z3JysHE3/xoNv+rDB+juPtn1HENUCdP1n6EHd07afGDCZCA7YPhBNAKzATZL1QpcWdAXZydMBqI6P/4zH2yQBtjil6CgPP/R/viSUgb62Gn9xFYf2iPa8XE7dhtL+Qs9jHeis9mzYjovaw/Tu7MZxw7fE1YVWfaES2POajMzEWsC3x3clWkkP650LJhF1q/BvHRjTkthYdrfuBOf8MSZ06qW26PPW3XwU3jo4xt0SUbA4XMbsOvj0e4/C7X0B6NJs4bPSLcyn1g2XLSq5AZ/vSCT6mW3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW5PR11MB5858.namprd11.prod.outlook.com
 (2603:10b6:303:193::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Thu, 8 Sep
 2022 19:45:19 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 19:45:19 +0000
Date:   Thu, 8 Sep 2022 12:45:16 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Robert Richter <rrichter@amd.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        <linux-cxl@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 06/15] PCI/ACPI: Link host bridge to its ACPI fw node
Message-ID: <631a464c166cc_166f294d5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220831081603.3415-1-rrichter@amd.com>
 <20220831081603.3415-7-rrichter@amd.com>
 <63198617c7854_5801629450@dwillia2-xfh.jf.intel.com.notmuch>
 <CAJZ5v0iQNSNzO+mw7zqkvpniiYdipprTYnkzx-M7Jxq4_Cs8VQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iQNSNzO+mw7zqkvpniiYdipprTYnkzx-M7Jxq4_Cs8VQ@mail.gmail.com>
X-ClientProxiedBy: BYAPR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e34aa395-589d-4e79-afb6-08da91d2a8e9
X-MS-TrafficTypeDiagnostic: MW5PR11MB5858:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XjmJ8H+vmzZmELOdp3NDBsOJ/A7nOmyF9Tt1NGrwd9cai5RqzMHLs2zLeLOoqJa+x7/ev3sJS9EpCbghERgxpXvaZK+TpQjI9UAPCYidTloykmzQOSkNn9q0GKZmoRzp2aqJtBWiAikDGCC2Hz9aH1kRKz/5puUo/efOTuEIBsRpfyCeh60gcCCL3rROWiWItyPC/y2IzOs1WSPCE0LrmwktbWKGWyCvysNuzeutpRujIDlKPevhS7HLMhUMYrw58r5pY0U5ucY7vMsR+uMGhouAFdj9imwd4dUt7v6MCzzntG/FBroY2gTKlYVyH/k02Kfqt0w0vJ0w7mJIWfZmUURFDK4wotLgVluLgxJ73pOBg5DySoKRyLuGJiLzQqiqkpKb0IemFgrsvilS97FKx39h2GZaxXC6/6zmPoBos3mH4GtZ33Kzahrpz7njbKI4f5uayL5lzMuxHMMfCjM30zApuugcZOTd/ACOuUwQ93+OaTms8XT8wkS02/jKM3l2n4P8Zup9Vzlh/yl/h3G+Dbepd3Mqi6iMann6EUViiO7w31mIUMeitNviC24dPSxOAmK/CG/LSd8j/LXsAN7g31wtASuhmbHWq+VAAEokutCFIp2n0qVifMkPh/sc342el9vnZP98aqLD+EOc9ADrrgxyF3Zz3EedIy5IvRJX9NXwt2XbwzAnNVZ2pVILPU1kQ0Hps+obMrxziTHMue/I/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(86362001)(6666004)(53546011)(8676002)(9686003)(2906002)(6506007)(4326008)(6512007)(26005)(4744005)(38100700002)(41300700001)(66556008)(8936002)(186003)(478600001)(5660300002)(110136005)(54906003)(66946007)(6486002)(82960400001)(316002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K1jDy/djnWeFB2aKST37OjkX274PLszEVmFiVjhgf9LdIXetTOTIgL2RxTED?=
 =?us-ascii?Q?pUc81U43bPgaFlXywtGGO7FubFiwVtv1henXhc7DSB1o67b2MynIFD7KF6Jt?=
 =?us-ascii?Q?Cr8anwLqdHLrOMzuAOIxUn4thbvpAJhRNRKL6HJ++5dcG80sWq/PuJdnXquS?=
 =?us-ascii?Q?5xPufynq4Sic176LXdjF1M69ptPHcmtrWN/dujwYj8LNZDSxIgSizgwj/AAT?=
 =?us-ascii?Q?Lqi+Z7gtkYBjQxGobwRLRoDNuu1xrQQWMI8mWH4ci6nWyOhI2R9zx5KBoXtM?=
 =?us-ascii?Q?WMrFIVgQ/0RM+PQcQa708nuPkWDYozEroosszTwnMedmZ3nESQF6mCq50AUm?=
 =?us-ascii?Q?RYYA+wh/XDvQ/h2/ctUK7ngMb8EVELUDtLBUVIXXCwjjAuP7BluJLGALIIEZ?=
 =?us-ascii?Q?fRUqXkXFCV2b7cIFMb+4OoEGZfKjy2sSWdEaej7TCYggxK0G3l7s2uIA+Uk1?=
 =?us-ascii?Q?mqAXvwmKXk0A7w7hDGxMqiB+ZvVZ8bxCFyJwAIJZ5QpFhEBBdTYAOOvHvOTT?=
 =?us-ascii?Q?+4v53copVJ3/vrV1Pfu0IV6SkyewzDjPvUDz0sY8Ui3Q5EMzS7m0p8v7Edee?=
 =?us-ascii?Q?Ewxr+mOfM5NjFnajjzp8RhsI79k2A704B2ynL4RlZOYvYKfeZK6lLnn3YvMc?=
 =?us-ascii?Q?QMHRrl3F944J9id4hQ7lrl3RwnzzK8cptG8y44zCOJfjbFbkVJ3UydZKd3SR?=
 =?us-ascii?Q?K7Zp7ftQRWv7fcmvK6Wdat9ZKj7LH5PKsj8yTSJ4R83K3dsiU0nZZ5mtFdj+?=
 =?us-ascii?Q?HLT5qbx+q1rvz4i82iHKkvEG5DyMsPnaMfeiPAsYPZFxe5kue3cVZHy7YnRl?=
 =?us-ascii?Q?ovJsKHj3PnC/LF4tYi2Lc+WYIEcouuXxs/V5lSNhcxMVuXDPwox98e97mlqK?=
 =?us-ascii?Q?7/KXolstORqsvPi5ofqiaGl6Rb7WznX4GM6n2UF80KcnCJA1Zmzf8SPaSo9P?=
 =?us-ascii?Q?uEseLbrle3aUcxRnEBuklBdQXb9kKfZ0BXUVgQS+BzfDTSifUrhTE/2ceZ0G?=
 =?us-ascii?Q?5IMeyjaemuZAARZX8yEfRfkFc5Dxk7Q5Dmyejn5spqDF9TPGETtE7OhmVNOd?=
 =?us-ascii?Q?SOnlu56ny1qlSs4rII9SGyvvnOSmKfH05T+4i5jxXANantxH3NIyLmMVwjEx?=
 =?us-ascii?Q?ufLLOOAjzrGa7/sr35GrREuZqsGaEFpUrYpee6mC+yw2BYr8mIpvlplag7xu?=
 =?us-ascii?Q?sqlpIs+0TiRK4jYCk8Ef924kWoAgWA2UmXwZHs9QH8u5oOQCgOAePA2d0tL9?=
 =?us-ascii?Q?jVUZAHMxv/Fe+owCCcI4x0LJIJ5pNNRUXplgARoViQXP7lIx5kw+QzwmR7Pj?=
 =?us-ascii?Q?uGlZhctqLRY0qZnLI7/6DAf1HZz4rtxPuFiWqPtuYpgw8qBD6Qu0ESsVqyf6?=
 =?us-ascii?Q?iQsIwBL1XbLYoPnLNy7hqWgLpRwErOBJvw5ihc30MBG9uDuFjQ6hRKuDn6G/?=
 =?us-ascii?Q?RATjCAaCUbZfHhzjfwuy1zmUUfnag2b1UA2USClW9iaZty8lnUc/jRAKMlon?=
 =?us-ascii?Q?TSxyR5yuRbvRXxly0nl9Y5arVXUI2F7x2u5BEjrpWGksvg8YbNbFkVmhPkiv?=
 =?us-ascii?Q?0RktlR/qTqWvjuZsdYeZaHmZ2+VGdr9JL/B34QXXF9FCXTiZw6VvYCXdyBF3?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e34aa395-589d-4e79-afb6-08da91d2a8e9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 19:45:19.1268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GLXJaev7Y7jcjP2k1S93RiouyaipcuVhP0rpaDnGPvHfqt8DaSqlArXY8964xDRvY+5ugFHju34EHkVK1qFI8Eea3/Ec25ORPCMCaj4ls3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5858
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rafael J. Wysocki wrote:
> On Thu, Sep 8, 2022 at 8:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Robert Richter wrote:
> > > A lookup of a host bridge's corresponding acpi device (struct
> > > acpi_device) is not possible, for example:
> > >
> > >       adev = ACPI_COMPANION(&host_bridge->dev);
> > >
> > > This could be useful to find a host bridge's fwnode handle and to
> > > determine and call additional host bridge ACPI parameters and methods
> > > such as HID/CID or _UID.
> >
> > When is this explicitly needed. "Could be useful" is interesting, but it
> > needs to have a practical need.
> 
> It is needed and it is present on x86 AFAICS (see my last reply in this thread).
> 
> This seems to be addressing an ARM64-specific issue.
> 

Ah, ok, thanks for pointing that out.
