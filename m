Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A25764A782
	for <lists+linux-pci@lfdr.de>; Mon, 12 Dec 2022 19:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiLLSsK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Dec 2022 13:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbiLLSqw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Dec 2022 13:46:52 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071D91F5;
        Mon, 12 Dec 2022 10:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670870811; x=1702406811;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=185g2PoLEPIqUOlMVtYX0TBfidNy/tOGzsQ7/jr0s/Y=;
  b=cMhrQ5CsBBf6xBXNLIP0JDN/Kxr8nCw+3Ha5Xt4qG9wrFGKlJvEzPhcJ
   cRl+oM+ZlvUQwvsibkchM/A8I34Zs9ui80LLxcTf4sCk8uMhpFqNMqfWn
   HZlXGqYtp9YCYXjOicoXE9t0evxSItn+SrhEXRTuZPHwcJI36S4gxdhYc
   8xvoZ3alS+zBwyDya3YAGNWC7nHrhNWHOF2kh5aN8pibtSxpJUDkxXW+S
   8yS0NWMh0CDqHdZaOXlCuLKVWkB4/lDs7lXL+4xBWAfsgLbqmU2GA21hB
   7FKgi1a9W/UNqJZCwSWf3Y+WNlFwKuzWOhRUIiFzoKupXZtqdvKZByir2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="316632445"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="316632445"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2022 10:46:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="790601636"
X-IronPort-AV: E=Sophos;i="5.96,239,1665471600"; 
   d="scan'208";a="790601636"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 12 Dec 2022 10:46:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 10:46:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 10:46:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 12 Dec 2022 10:46:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pe8VMIQS1Q07zE2wTbUn0Xvk6zHGynwRNRYCq6LbFOIQSDYS1YvBTv9zl+HprjL9SogVWXpo8uqLBBhQBhTCXLWIlRpvycO1Q6tK7Nkyb8Hdc2OGfjwsq6UfdRsCawONhVfie1mlFvrKHz7eDJr7AgvE7Z67V7r1RgjSW5Es3M2E33EIgf/A4fZMGsvDQfXMDkDsYkdWfZq4l/P2BROzXpwM2g48LCR4tnn3cVX0b42uZbzlwTXCCHyCPDKzo2XRc16AdMDRAyPdjRa/QBDp9D9gN3WoSNxRUNU6vo6ho05ND5utrilc6W1y6iAWSueYSBi4p/hFuEev+5hZQZ3fNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ze0GdhoYjSrtboZbN15XeqbPCkT2sf/x9PQwinU/to=;
 b=EXShqfkGYDFI0D21+ZDPs6hz7y1VZiKJy8i1srnBwBwGIKpfh8rbjoanhetxZTCLugwBI1liMUWI+RrCc/InqOe+iOAjUe2v2ZjFmELXX0tG5hLEh343C59xuQbLinZujsr4nPmuVFon9+1ZhdS9TLsXhhO3BZbjfYH2/CNRKxGqyn3455PiCLUgVh3VM7uEJxk0b14NCKjmN83gtiZCfGBmPvYh422JqPdeR1C6c5WXJ/NF3tVWcTcTvvIpvMCQ5gQiZvw9Aiu6ROZ6gC1Kcp8nm55wFwwFrIHEUEb6+dNwu+bmv4KopO4+mucChlwcd1/opIjpueYpuQduNBjVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 18:46:31 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 18:46:31 +0000
Date:   Mon, 12 Dec 2022 10:46:26 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v4 0/9] CXL: Process event logs
Message-ID: <Y5d3ArpuLYl4g4Mc@iweiny-desk3>
References: <20221211-test-b4-v4-0-9f45dfeec102@intel.com>
 <Y5a88UgaE3EzJFQh@iweiny-mobl>
 <20221212161613.mz42m7n6eswjwdjv@meerkat.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221212161613.mz42m7n6eswjwdjv@meerkat.local>
X-ClientProxiedBy: SJ0PR05CA0111.namprd05.prod.outlook.com
 (2603:10b6:a03:334::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5816:EE_
X-MS-Office365-Filtering-Correlation-Id: 894c304f-f621-4104-09c2-08dadc712f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iGuaSmrm2l8cjAib7JtSH7cOrY0xNmJ8JVBSqLtQdgkVP/cY4LXP+a9CREG1/i7zEbsftuQxxy+lTMLSSy/azFDjN9bwuLeq+nrw/LhfL1kPsxPTUkGAUK0P+OJqfSzfMcxfmyfPmOV0iygyF1BTzfelmRBKzxTgQI3jVHb/HxCJ5OZkNtR9yJN+7Jd1A4V9cSDUWDvMf9rnFmTtf281J/HalKdiE3A/ItYc4c/ALcLmmXZSoraqv1qAuez387EHfUU5M5/Ypsq1wsYh/dndmDaPSgA9Rwa3sUa6PpDma+c9d5QQP6dRVkrinOINvzcXvZr4Emaa2x2gBrmnwPqnqbdWAfpPLl2rY4b5Ml+S7zFOTMPcax6K2F6d21xO9bfOuDngu+vaUmh2Y62cDx+sz42xBQLvLPadL0VAMQbeyG9MS5tU7Qt57li4rbw3OAfeDq4HoFaEcoN23plgJdb3k7YJ+4AmnHdJw5UjNkUcyoK2S9JXwRGsxLFEWvqJG7F5cTTn4j96D1p/c7cI3Zf6J7mh5JYX6nxyAoPTayK6zgfLjak3X+n0rVMyiK77o7vy8t3OQdB06OSgpJKyjjoAiY/Sv9ruPYwaiDdCsphQU+V7WSJGJDD+qYghGjTbKwf3S1HqbWDLf/j28SZWxhcGvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199015)(86362001)(33716001)(316002)(8676002)(4326008)(9686003)(82960400001)(38100700002)(186003)(6512007)(26005)(54906003)(83380400001)(6666004)(6506007)(6486002)(66556008)(44832011)(5660300002)(478600001)(6916009)(2906002)(66946007)(66476007)(8936002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AcWlWR7hsJCm5uxeGEWMxyiHPIgi4OynUCbAUJadpwZ1jXP6cKR+JqR83G9n?=
 =?us-ascii?Q?pbSfn9q3cqCWCTbufK4pW+AbCsG4fBGarAxynhn/hp8jxQ0GTSTYQelSjMkT?=
 =?us-ascii?Q?eHIacNgUS8Zs/uGnu8/Ah9aGjwS1Oj9NlH2GdDT4vrpIcAOCbU9oVLbpAmmZ?=
 =?us-ascii?Q?ZEBTSAVPNC/NNBXNFGjCmnB/h5qHaDlx+bD4570AMy2pT0uh9bwn80Rj9j7M?=
 =?us-ascii?Q?akX6+i9pxR66ztUzzwFBWIvJmujK5Pifr1c7lLlV3m0SV1/0yX+I6NPBiAlv?=
 =?us-ascii?Q?25J5NMvPzU97MJTd0acuP3DQ7VqHNYAAnVYpImBi6RGwP5L/WE2/D1IKTZll?=
 =?us-ascii?Q?5C1AHzQI0oDYQHzfCh/mOOr2eyaIvFiykcNlASkuceOc7rp2d3+SCITLgaMm?=
 =?us-ascii?Q?+yoxvAFmfbBx7/5GeZDRaPnGbD0LszNJCPaetqgcP5YHkuqRvndxR3ASX4VJ?=
 =?us-ascii?Q?fPx7vKJrGotKO92Y1jv3fQ7DI6qnnbu3/9dsVlB5A8fb6o03FiPdLHhAExvs?=
 =?us-ascii?Q?m9SnUIbI63lQeB5mYW3TdzRedwe/0JCgj+4BCA7bNzOgIBIecjV00mExax1U?=
 =?us-ascii?Q?iyHuqqj8y53cjugClCma8jhiUhu8zhFxZ+WxI6nHScMPdhCIK3pRmbMwbjd7?=
 =?us-ascii?Q?d+MhErmdzb3WIK/rKzw9AOStzDHFO68gxWKMfxN/2ghsdml6Vp+QJJOFusxG?=
 =?us-ascii?Q?faJvQKepFIJr6ad0nsjVZ7Ek4sSNIpHQnxzv812CspH0muqsbzu1xTHVogMw?=
 =?us-ascii?Q?mRnP1AusISLKf0y0ytPxDpp+eXQOwaDj1PjPbG0Lhxf7TWmGI9U+d/R7O+eH?=
 =?us-ascii?Q?yLvVobY6AcGHJY+JauIf2W6dSWnQod9W/NI4scdy/lusc/dIoKYMPHuIsF/a?=
 =?us-ascii?Q?qq5ZDzeOrbBw2p/4n9UbOiYLhobIKhUYSWpsg+vO0KaxVRZg9hErzNRWgF+W?=
 =?us-ascii?Q?UaFbp7NfFxdu63IcRZR1pXcftb5xzY22FTa+eXZjDDS1ohBqciIBJYG4JmXo?=
 =?us-ascii?Q?tJKzYP7qgqMRXSLlKjjKJjFsG5+19DrSeY7J3XoZ4w37VbHoTO6aSN1Oczqj?=
 =?us-ascii?Q?f1O3hEU0yaNWGBlV24WP+flgNfWrLJnN0Pte4h6O9jwxP+qwAlxY005pnhEq?=
 =?us-ascii?Q?102+OeGkKtlGIstZ9R2VMxKYl+l6hTayy3WF/x+OY29pLDOLIgt71LwhXHh5?=
 =?us-ascii?Q?mHByHJdMUgfa3Bc2OTCAnWC4vormSD43SK9xLjvtjE7fgLLoz/KmWl4asijM?=
 =?us-ascii?Q?d650UVvZxYvXGUdU00aKU9Oh5zgNdWUAFapXjEGm5iyNuv6yuNSLiauMFcIa?=
 =?us-ascii?Q?iHFJ1vcRonjNtTxzxQ03+fRW3WDsd3qlwOKf/trL8cngFBI6A+ouBMuHhO57?=
 =?us-ascii?Q?VVc1P0EGF1keCUbUgeozJLrAymeJQK1T3z5LWT+93G2hTwqv2kSQZvX5Qf+j?=
 =?us-ascii?Q?qt3VYh2tdEUbE0U8IbnSS57tyqBzudqI6Sf4+ntWWV+Nlk7ShdrdacHz6QYj?=
 =?us-ascii?Q?ynOVyngJmg4NJstjEmj9RMX0A0A3qYv1HkOyswkMDVs4lMNN/QhiY4drkLcr?=
 =?us-ascii?Q?rx0wuS008cDonFAngMPiT1cWloMa/kexXYXasC9f?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 894c304f-f621-4104-09c2-08dadc712f32
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 18:46:30.9535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uoGYp3C6sDVfcLxOWQWIQOeSln7Ke3ho45KwzH/ALH9kxacrVaQvHnd1je6DZFKRrmgtN3X4zm5GkFkLnWLxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5816
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 12, 2022 at 11:16:13AM -0500, Konstantin Ryabitsev wrote:
> On Sun, Dec 11, 2022 at 09:32:33PM -0800, Ira Weiny wrote:
> > My apologies.  Please ignore this series.
> > 
> > I'm trying to use the new b4 send functionality and was trying to send this
> > only to myself.  I'm not sure what went wrong.  The patches should be ok but
> > this did not get sent to all the intended lists and people.
> > 
> > I'm going to resend this hopefully to all the right addresses this time.
> 
> Ira:

First off thanks for the quick response and I have to say b4 send looks like an
awesome tool.  So I hope the above was not taken the wrong way.

> 
> I don't think anything went wrong -- you probably used the new "reflect"
> feature, right?

I did!  :-D

> It fills out the To: and Cc: headers but doesn't actually send
> actual mail to those accounts. Mail servers don't actually pay any attention
> to those headers -- all that matters is what destinations are given to the
> server during the envelope negotiation.

I did not know that.  But I was kind of coming to that conclusion based on
what I saw happen.

> 
> I do realize that this is confusing. :/

Only to those mere mortals such as myself who don't know squat about mail
protocols!  :-D

> 
> Should I include anything in the output about this?

Maybe.  I'm not trying to put more burden on you.  But for the ignorant maybe
it is a good idea.  I did panic when I saw all the to/cc addresses filled in.

FWIW I do like the idea of seeing the headers as they appear.  My personal
scripts have features to dump emails before trying to send.  So now that I know
what happened I kind of like it.

Thanks,
Ira
