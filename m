Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB2A5EB30B
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 23:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiIZVVl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 17:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiIZVVj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 17:21:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC307C32A
        for <linux-pci@vger.kernel.org>; Mon, 26 Sep 2022 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664227298; x=1695763298;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=28jr5jLSny/Rzq6M1S10ikJwgvMfwWtUv5+p6+C2Q2w=;
  b=msl+8XIr3Pgm0dyfjf9hyIwohKRgG1vYqx7PQPvkf4tnsbUdigXIIxtz
   jzZKrVtJ/lJ0yBwCjYeGpgne1zGIzdmoKIguiaGHJ++4K2tuKn3cw4pDg
   kXa7zNkelZqdKBHoD84zmF6NCTdox8wKkUjRgkA1s3oTe+2CzrUyb7PO7
   eo1d9YhNI8Qp31FcdpyuWY8dqmMdgPUt/GB488wXDTiWZey64+s67Gc4A
   3h13JRuyYkY8IBO4aWP+zhf0smG0SI9TpM1gCwguyBJHL9/I+USegEKo0
   Odey3ABHK/fgiPfnO7r5vxtLWnB2Z0yNYzWheT+ZE9Mvko9zLgAlE9ZBM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="284265721"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="284265721"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 14:21:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="598902135"
X-IronPort-AV: E=Sophos;i="5.93,347,1654585200"; 
   d="scan'208";a="598902135"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 26 Sep 2022 14:21:38 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 14:21:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 26 Sep 2022 14:21:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 26 Sep 2022 14:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LM2CorUMOnQOH31FhOahBVGR/AhaErBicxwZCT+84QI0edyXYf80tkfYK18v7b2PNQ+Hv1z5GSWFaAQ42EBQi+kc3l1nV0lcTM3RuigRyx19GOLKCUiyKwLlod3eGnX1G7fdhBKNnPJncLQaWWwqYZmz3LZNri1JpPaxP9GE9BNlrgxYJU+ptu9jbS028q3oPtj/eE6WS1QAhd65HXf/VAgy0XAAB4VLYhLHihpGqaQzx04eoiTi89AhIC+DXr3+A6zVc6EIWWM4rwnqOUEYPIEux4YDQblqy9ankaAvGDkFMNnCRYVowxn8CA1WXp2SDcAXBJIVVhy/DieRuMa2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmkYNoqsLj23lOxpY+7YEvoB/IGyoR+RsnYoAddmG2M=;
 b=OuK4Gwj7hnS4zkPHkurN9vCgvesO2BKLDGtT+CKuXqU2ywECAGsiBFNk6otmRkH3BLBLCMS7xxreawyr5Cdk06ao5Ax/wiY2SBxAB4o4Zh/vDFPk3PSPqTzM38lNhTSY9tZ2PtOMdT9wzMJnfIqkFWg7obgngC6lHG20H9Q0pRlRMIiBPKeiSDtK54T0gS8AltB2CyHnOx/MCHYcCPTIlMXaXmrP5iOOV348sRBB/NHlJlWlJ/bTDEi7IYwta4Q/yfaicQoKsN952wtcZSDR0tHuKccn+EGejk8c9JcldPObiUJ4ZLo1MHsFlG0S1+BElqCLrdLcDL4SungqG0Ffvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 21:21:29 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::476d:8fe1:1952:1e25]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::476d:8fe1:1952:1e25%5]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 21:21:29 +0000
Date:   Mon, 26 Sep 2022 14:21:26 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Lukas Wunner <lukas@wunner.de>
CC:     Jonathan Derrick <jonathan.derrick@linux.dev>,
        Jon Derrick <jonathan.derrick@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "James Puthukattukaran" <james.puthukattukaran@oracle.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3] PCI: pciehp: Add quirk to handle spurious DLLSC on a
 x4x4 SSD
Message-ID: <YzIX1vjt+eoTWHDU@a4bf019067fa.jf.intel.com>
References: <20210830155628.130054-1-jonathan.derrick@linux.dev>
 <20210912084547.GA26678@wunner.de>
 <91950e7a-68e9-9d35-ff0b-a2109de7a853@intel.com>
 <20210914144621.GA30031@wunner.de>
 <3f7773e0-1c20-f96f-097f-f545a905151d@intel.com>
 <446a21e2-aea2-773f-ca88-b6676b54b292@linux.dev>
 <20220924073208.GA26243@wunner.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220924073208.GA26243@wunner.de>
X-ClientProxiedBy: BYAPR11CA0079.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::20) To SJ1PR11MB6201.namprd11.prod.outlook.com
 (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|IA1PR11MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c39fc6-d0e2-47e9-19c8-08daa00513cd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+PZyr/9/kcJNxbHNBAwJZFyA1AT0ZDSvHHgAQ1eMmD8JE88KXM7YHUR43kG5ioE8N/J7OsjIdgqMbcKnM0EJ+M3yC0QT63bSHCRjm0p6fp63HabPyHv5JDxZvU42XuWo9hQ0k0AYA4b9Zi2n7TWvQOM9w0OomHVdkyXbiyGU09b2qjIS1MoXpkhrWV4EHfmsFMh4Kd7S77uq1anTp//7EY+RCpmAodGgxIwmx+MQ//OSVhYFq1IfkrtKiIC2DTcOA1sgmHK5voyxzVfXn9Bu5+Q1aeMKX/kyG1/MtVCWw5IHrBBp0nJGiUIxg4WMlVy2kw1BGiS0hPki3yFAxqHk7BWqCjum5FBXd70CFkGRSHY6F+zmrJq8veL5xu2qQk03SbS4APhSTjFYS9mIi33CW5NcUWupcX+ChCxNAAa+P7NYBxqNX9FB7jINIBN9W58+5D5SN86MXM8/JnHVfX5nhL098sU46pIftkbyJDjL6k4m3/p/MWJtie9LjfbP0DXgLzXErJd2a0b4lA+KbJWOMHx81g6itpuR6+pSoz4n9+t9oI7rn/xn5HycLARJPgOHqjBj7dMyq5DrRWN0o+Gf5NZ++VlsjZZ9qqM5WV2yhQM32cJcS9xyUQ2ALUJ+ZntFTFjjzcLUk8KNxY5m0Wh8M9+//TLGvLOXuE0BiPyDCOXFbTKakOz1CMRBEnOEiBK2v8cl0Ehyuyo7SU2U3d0O9NssdMuyHPdGRNokvud6MkXnFwFRUs+lNSQgWdzjiaRN1nqhnuroYKOx91C5nxmffnZSJao8SoAhporJHVxGFQhTuJT7EnX9qCd0F0KHge15BdUrW/X/ipysxWW0r4PtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199015)(186003)(82960400001)(83380400001)(2906002)(38100700002)(86362001)(54906003)(966005)(4326008)(478600001)(66476007)(66556008)(66946007)(6916009)(8676002)(316002)(5660300002)(6512007)(26005)(44832011)(6486002)(41300700001)(6666004)(107886003)(6506007)(53546011)(8936002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AGRE5zqkD3sPdFTAz2adIkAupYvkOvAi40kE53YfoJvzpENao647RXy3vGKK?=
 =?us-ascii?Q?haIGn4W8T/V0hGKbj2hs+7uGGWq508oJmhfY4uVMG9BDUdGp3qpq3c9b+vli?=
 =?us-ascii?Q?ZrcxCNZkApkwrOZGAG2oc1C5JvxZAqobWBe3xCTpcHiGoVeTiBkUBTR/sVqK?=
 =?us-ascii?Q?v3+zNzG6SKK6ANvOVBGruoKMIYYZLURWRYgaXxQCfQs4vK6+KF5zCW5H4wYn?=
 =?us-ascii?Q?sLCUHGclqOI7P88NK+LQjVAmM25zDPuxlQAlpnTNmFyDqI5bybmR7V/KYOwV?=
 =?us-ascii?Q?Eg+L82TyzTVF85T/gdcE0wLD6oJ53N4RhAqwZH1DEDhwfasznS34Qsq988Jc?=
 =?us-ascii?Q?iPisibs32Bg9hEX8ehT94th8UN7tqL1GOQDdKNTTwQ0CSs/ERZPaFXd1JvjM?=
 =?us-ascii?Q?ZEcn8Ofs3L78H8271qL6dbIDKysHE4u7gaXqjY3fNBQMOJ9u8BqNJOcqMwVF?=
 =?us-ascii?Q?4egggL2BHAUFpMGbq6uQgApKlkTBhJv81wRtfN8RQYEx5DQLsEmGpp1LP6t2?=
 =?us-ascii?Q?9e+nQizWQS010IBJ39Wx/Z5ghH8J4fXjHKaJkrbh4nNTp11cbWL1Q8xpO7OS?=
 =?us-ascii?Q?VVV/0Q7FgKNbh80EZEJyd/tw4Rj73vfagmLNOEv0azyrKU+WYZRib9mS9lPz?=
 =?us-ascii?Q?EyF75R7Zyd2Zg2lxUFvqD8WjyP78qZ8ZwJUERNeSxWsN6+eYWK8/vqMzXVBQ?=
 =?us-ascii?Q?PJySyt6QmEaEBYGFCrDKk/XDMs+Te9rCayliaGRKF3Jmys3ZQpzt67WsIi7Y?=
 =?us-ascii?Q?ePdWfQ0IeBvTd4pk6F2e1JgRGSjNecdPCPzsypNqyc4ovO0dnNNHO1tHwUGc?=
 =?us-ascii?Q?s1XdnpQikDlZumjg2N4DABWoagTQTsmHZliUA4SYzVYZW26LoRlUnxgFWH3J?=
 =?us-ascii?Q?4rGzBBDKvXwZg23ubtsO7sZwTapcH/S8RKlUuFvkxMjeSGhB1bnL5+e2PWW5?=
 =?us-ascii?Q?KwLMR1HHQfd1PIr/iKAkRBmZMA1o6tinPj52MX16D7xrmXyqv/57QEvtnkN5?=
 =?us-ascii?Q?q2MNH9G/r7eC6yKW+ka+jPFEbFoCOpB1PkSR5qeRULXQz1tuuRtpqGzxDbrH?=
 =?us-ascii?Q?Lc6V6jh5iIFPaJZ/WaakFiwvdtrNn65ldQoPYQuoOEyRpYe/S29aQ9wN229j?=
 =?us-ascii?Q?WcbscKtzlvo7LS9s8MFJ5qZGD5lkE6chG3A77YS1L4VXAsGR0XQgNb+5ujDM?=
 =?us-ascii?Q?04OljSfhv6Si6QP0H8VyD2dHUtSircwLqpc/LxkFrNwf/vf7bpyHbU/dDfq/?=
 =?us-ascii?Q?yhwYHy6azZWv14OIteu2H4Ccd/kZIu+Pvoz644/vDnTg4j0PiErCB2LKhuzu?=
 =?us-ascii?Q?s7kQm65qn8v3OMUMhDmwHA4hK046SW/eNgpbvaW3SW6t/7c6yJNRWgkZVXXp?=
 =?us-ascii?Q?htJ82HXWxZ7rqsR5sxUKwK0VUDPdrhWfk1fgUfIwi3WOtFUJtKQeoN9wsg9F?=
 =?us-ascii?Q?2l0q7H0S/Mz6ljYy4NzZ/NKHz9tasOmSiwVbj7sV7wuJNwuS9yDMasyZVV50?=
 =?us-ascii?Q?lmYwXGUNR+TjFAS0U6jY+Ydy59aWwoiJQlyTIIncB7HG73o9GL7AxdTn983V?=
 =?us-ascii?Q?EJnUr+CNmsMnCz02lTgYY2LgtoeDUMC+hBJzwF6WpxVCynZqvDzUN7TNFJIH?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c39fc6-d0e2-47e9-19c8-08daa00513cd
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 21:21:29.4929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFXO/Z2h/Xiq9dmrvbmnGj3ahwfkbVHiDAfdsEt3tUZywIsukjgVpTo1WJp/DebDMfA6lG71Gmni2ZM84HaqVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Sep 24, 2022 at 09:32:08AM +0200, Lukas Wunner wrote:
> On Fri, Jul 08, 2022 at 10:35:15AM -0600, Jonathan Derrick wrote:
> > On 9/20/2021 11:18 AM, Jon Derrick wrote:
> > > On 9/14/21 9:46 AM, Lukas Wunner wrote:
> > >> On Mon, Sep 13, 2021 at 04:07:22PM -0500, Jon Derrick wrote:
> > >>> On 9/12/21 3:45 AM, Lukas Wunner wrote:
> > >>>> On Mon, Aug 30, 2021 at 09:56:28AM -0600, Jon Derrick wrote:
> > >>>>> When an Intel P5608 SSD is bifurcated into x4x4 mode, and the upstream
> > >>>>> ports both support hotplugging on each respective x4 device, a slot
> > >>>>> management system for the SSD requires both x4 slots to have power
> > >>>>> removed via sysfs (echo 0 > slot/N/power), from the OS before it can
> > >>>>> safely turn-off physical power for the whole x8 device. The implications
> > >>>>> are that slot status will display powered off and link inactive statuses
> > >>>>> for the x4 devices where the devices are actually powered until both
> > >>>>> ports have powered off.
> > >>>>
> > >>>> Just to get a better understanding, does the P5608 have an internal
> > >>>> PCIe switch with hotplug capability on the Downstream Ports or
> > >>>> does it plug into two separate PCIe slots?  I recall previous patches
> > >>>> mentioned a CEM interposer?  (An lspci listing might be helpful.)
> > >>>
> > >>> It looks like 2 NVMe endpoints plugged into two different root ports, ex,
> > >>> 80:00.0 Root port to [81-86]
> > >>> 80:01.0 Root port to [87-8b]
> > >>> 81:00.0 NVMe
> > >>> 87:00.0 NVMe
> > >>>
> > >>> The x8 is bifurcated to x4x4. Physically they share the same slot
> > >>> power/clock/reset but are logically separate per root port.
> > >>
> > >> So are these two P5608 drives attached to a single Root Port with an
> > >> interposer in-between?
> > >>
> > >> I assume the Root Port needs to know that it's bifurcated and has to
> > >> appear as two slots on the bus.  Is this configured with a BIOS setting?
> > >>
> > >> If these assumptions are true, the quirk isn't really specific to
> > >> the P5608 but should rather apply to the bifurcation-capable Root Port
> > >> and the quirk should set the flag if the Root Port is indeed configured
> > >> for bifurcation.
> > > It's a function of the slot + card combination, but we can't distinguish this
> > > slot's special power handling behavior from the vanilla behavior. It's modified
> > > to handle power on the logically bifurcated, singular physical device.
> > 
> > Hi Bjorn, Lukas,
> > 
> > I need to resubmit this.
> > 
> > Besides the 'pdev->shared_pcc_and_link_slot = false', addition mentioned
> > above, is there anything else that should be changed or any reason this
> > wouldn't be accepted?
> 
> Another report has cropped up of spurious DLLSC events:
> https://bugzilla.kernel.org/show_bug.cgi?id=216511
> 
> That other case differs from yours in that a spurious DLLSC event
> is seen on plugging *in* a card, whereas in your case the event
> seems to occur on *removing* a card.  In both cases, the spurious
> event is seen on the hotplug port's sibling.
> 
> I'm starting to think that we should probably disable DLLSC events
> entirely if they're known to be unreliable.  The hotplug port
> solely relies on PDC events then.  Otherwise we'd have to clutter

But when we have ATTN, we don't subscribe to PDC events correct?
Can we always rely on PDC changes?

Unless you have a PowerControl, PDC can also be spurious correct? and so
will be DLLSC.. But I agreem, the hotplug code is getting hairy complex
and can help some simplification. A long time ago I remember I worked
out a state diagram in google draw for how these states transition to
guide the code, but I don't remember where they went.

> the event handling with all sorts of special cases.  The code would
> become fairly difficult to follow.
> 
> I've attached an experimental patch to the bug report which disables
> DLLSC events on a hotplug port if a P5608 SSD is plugged into it:
> https://bugzilla.kernel.org/attachment.cgi?id=301845
> 
> Would this approach work for you?
> 
> One other question:  What if the SSD is not bifurcated (i.e. x8
> instead of x4x4), don't we need avoid applying the quirk in that case?
> Your patch doesn't seem to do that.  Can we recognize somehow whether
> the card is bifurcated or not?  Is it sufficient to just look at the
> Maximum Link Width in the Link Capabilities Register?  Does the SSD
> report x4 there if it's bifurcated?
> 
> Thanks,
> 
> Lukas
