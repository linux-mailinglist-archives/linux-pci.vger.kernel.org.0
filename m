Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5226F70C2
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 19:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjEDRUc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 13:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEDRU2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 13:20:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DA946B6
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 10:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683220819; x=1714756819;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=G5Qm2Zzo2V887v4b/Ij3XHqdlZYbj8bVqTSsVMTPFHA=;
  b=KFNmUnoa8Qx3Loi41Y4Uf3XuBfsPBf6lQnm0EYeEa8ZJS66G3u2M+Zf5
   kB6WKeEuw0EJRXPNRCEcZWNzEGG9GaXtjRh0MvhFSCzR5XCnCHEO0HPCu
   iD0HF5cXKWs03AfgFYBXi1Q/gRhnS1HWVlRfSwHOXztcsb5lk5VkfnRGf
   7Ug4HYr2QhJvA5g0rp+SzfUmhLTi8t1VBut1kfpxmKVkSuVn05N2kci36
   1V/Xe50/0NQpinjgkWXKhZ5Q2qpcsZaWVgMMblvZIJIov87d+klmfDt9d
   NeGok2ICo3Sr2viUhh95PNRdzPsk0OcDMneTNHNobT3jsFReRNj/rm/W1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="346474673"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="346474673"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 10:16:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="786635426"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="786635426"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 04 May 2023 10:16:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 4 May 2023 10:16:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 4 May 2023 10:16:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 4 May 2023 10:16:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIalmvLjSPKMdT7XMOFwbr2VHkzCF+TSGxRREOhHd3+4agt3Zk5oBHGsP1GyVCPHvrPejkxLje+BrKQ6A6ZrwkFPF5l99SFl5scuGzDj8GGOChfBBmYYOTcKLSM0gqhg2Oq56JBNamtg1iYur3SCKSXPIf87FoXrq1DsZqugf1eRQoMsxzpefjnl9KzP3hyN5mKSD9Nq/KV+ICPNmuYPkYlsl1lJ7gu3gPdi6inTGuTzejyM1tH+uHUjN+FePrtqWyjIg5Wna2IIq3edU03Z8PgvvhzgMXj8TLnB+q7pj/ixV2oYBFTH5QNCs4l9gVAi1PgaoFIpOOCOBSV0ktvugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRaCqQK+2IEAAwLurYfqwcS4BUXYQl9F7HJYWrglWeQ=;
 b=FOEvtTNdojHzv/nmBKCKxSWH3wLwq/PKjauYkJvcn7oETAez6zifUJxaiARPIVcUpDfpVP+Z2c1ClH9StKh607LrWlqxsFw4YwCMqqXGhqyqZ8Fbn2fhFXK2z/n6OH3oju8qDBvIK9NJdUjjqsPfpzUdNg3EpW3hSyhAh10TPoIUtEhgCHXGBam+nqX8Pn6oYO3l7k88Sz/iCRb3Glu4T5rLBFgtX73t75ZcvwvPUdU9xBAU8wRibXm7Q7GlGHaihS9SYSoaR6Oszv32HV8VXm95ZgPbbDxsqBVnoaFQBtYDs+8jGbe3emt5lAO65xgWVf3LmKriIWW9gAvWKqwhGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB8118.namprd11.prod.outlook.com (2603:10b6:806:2f1::13)
 by PH8PR11MB7989.namprd11.prod.outlook.com (2603:10b6:510:258::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Thu, 4 May
 2023 17:16:39 +0000
Received: from SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b3a5:53f9:3055:e9ff]) by SA3PR11MB8118.namprd11.prod.outlook.com
 ([fe80::b3a5:53f9:3055:e9ff%4]) with mapi id 15.20.6363.026; Thu, 4 May 2023
 17:16:39 +0000
Date:   Thu, 4 May 2023 10:16:36 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <stuart.w.hayes@gmail.com>,
        <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/3] Enclosure sysfs refactor
Message-ID: <6453e874d1c0e_2ec5d2945f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221117163407.28472-1-mariusz.tkaczyk@linux.intel.com>
 <20230504141048.00001ba6@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230504141048.00001ba6@linux.intel.com>
X-ClientProxiedBy: SJ0P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::33) To SA3PR11MB8118.namprd11.prod.outlook.com
 (2603:10b6:806:2f1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB8118:EE_|PH8PR11MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: 82a56c4f-ecc5-4f51-2675-08db4cc35260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Y8zCmKShHM9s8kGdpDkKpmZJ0sis8ILhfJ5vpnAfkhTtlq2kfArhk2hivHR2r7IjNOxkoYz7bLozHcH1eZ7wvgQKQaVsHiouTfr+Ng44DbcPNgU9upEM4t58zmjLqJJgBjUnTfrDWL05mz9+jh/sNLRbOxW+r1RbB/WTA2Knf6gUstkM2VEQwY7+OnEx5MIoR6NyvZGomOOk2Wfl7LpjvDIdzuatZR7a79z61N3N9diPvU62Ws1vxvG65VHrmMvdVLXgBVlcGldN6iBWsRRmmTX7IrS7biZvQtH0kGfFPgXKONFxmJRyEGdQDFZryW+QF4lNRVgLP/Tsygs4VDVyeKvC9IcwVxki/+fLZPTuu3dAlooaHMPec0+thZrK6eCfLehCtRY3Y8C9sCdD//P39wN+cSosjOuzPHeBpwaDp9ti3fQ9v3jgEakuQ+8tGBEXP5lo9TefEwXLIj5uyD952b+BH2ne8ObpjIfzOmxhBiMI5oWP+IJCXj6V5a2DNyFXaU3b3v3OP9ui7WrTPWuZb86W0BPyGwdjqrnBB6EV7w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8118.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(41300700001)(83380400001)(316002)(8936002)(8676002)(5660300002)(4326008)(66946007)(66556008)(66476007)(38100700002)(2906002)(186003)(9686003)(82960400001)(26005)(6512007)(6506007)(6486002)(6666004)(966005)(86362001)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZEn1Xx3f2iOS5/tKc9ckGszMviqvZRij/11znWPxgO6pwkvzmFqUhe6Ur6l7?=
 =?us-ascii?Q?spO5SeiaQ/LUOw67Jx99wKO99derq2733agLR0S+zA6m1Wuag4Hn8xFvjKD2?=
 =?us-ascii?Q?HsSa1XpmBL+dG/qYEb0jRp+uKkjZ19rlhjoPqAWgeIJa9CS9057lK/E3hdlO?=
 =?us-ascii?Q?vbLT11AHy1orHPXA7P5C145wOAJstOgWzBWMJg/B48LyHOxveIfyw/zcZpRV?=
 =?us-ascii?Q?pEOAqurxFzZnrqwI30uQqrU4vZy+irbYA0BMii3+oeasOiLny8a83K4VrlrW?=
 =?us-ascii?Q?PoFCNfzGkNw+LUCJWVfzQ0b4NXue+g/HWIBUBDdkqdQNgCdIjOwPsb4f2Ikk?=
 =?us-ascii?Q?gnqhxb1nk8E5PCelC9xJPb4Ornv4POLOMqpV1gGd29iCvf9VcHDUWMC5bpMj?=
 =?us-ascii?Q?4QgoEHix/f0tyc7Mk0i2E6kaTeg7QBEq/m4CcyA/mTIiu14fDCOg9GGxi4hS?=
 =?us-ascii?Q?j2bqdkCo0Jn5p9QsU6gTfYZ6xNyVTKjSI2RjzUuEinmOTgEJGUkM89rdsijw?=
 =?us-ascii?Q?I8xMMYxLJuKWKiM2oIkJku+q4nB7qtJqUOl31Yg5EzqhJU5x5IvbidrPl7uG?=
 =?us-ascii?Q?Wdyi4H82UtZEIla6Hf3qAcwi7QaM/uWRDSOjChqrKcCJPBeaFb0/j9haO8Db?=
 =?us-ascii?Q?IUDBuuB7c52J1iGV4prqRmrTnio2E7vtRpErhdj8OB00x6j/orAE1sQBt3Ks?=
 =?us-ascii?Q?PsrOc/tuz94zjkGMMyecxLgQpPkDXrkIFmVKEhOC/dcHvCSavK26Krg7UShX?=
 =?us-ascii?Q?ePdLgNkxY8zOg3MEkLrIXK1i4n9yExS779+a2RBPHzd6XrNMvB6csjBv1hWU?=
 =?us-ascii?Q?H3MOqYByE//4pW14mf9om3GhSi+jRGzmmP0lh94cRJx8Vpt5WBjnrl/TlymJ?=
 =?us-ascii?Q?/WQnSeSRLaXUXWd76hoNL7PXsD1iT/eOpRtjCgeYMwPwPcRDf2NSVrwC+0Cn?=
 =?us-ascii?Q?JxYlQBxmIadNQv8UCj3AA2G9d86KOLulkqDjjUe0XqfmRcYBRPMI7PiWx8Sv?=
 =?us-ascii?Q?jZEF55eHGaJxW+uhrNLSRvRm4wPhcYddUWADkFElRT9CSEnDO0oVGAKUD9+k?=
 =?us-ascii?Q?EijLIgkYVN1bL3x4XusiyK51XEEcw//zEnVbzst8+Cy7KOlpq1FpFC30rv4a?=
 =?us-ascii?Q?8/NjG/pVxWE/nAU+ApOpCO1kFcQVDHo72yfw1Lw8SMd/kL5SPBTNnXfAZToy?=
 =?us-ascii?Q?YiUd5bWl/jcGNN0tLrogNnN702VuYfzf7z4zDzNDd6fR8G6G21S/chGfznBn?=
 =?us-ascii?Q?sKlYMCe2/LYmXpKSw7xNwimi5dHPaVPxknFKXsV1efiTe32XGxOg3pGZoNG1?=
 =?us-ascii?Q?Ncy7G+6AgV/MYPStL2n3gqKZwM7EUMf11nZJD4PWTIQ3eiSZyPzUQhoiUpzs?=
 =?us-ascii?Q?Z8d2JOvwdOh00OMMGDlrbSbwZhGmwoWosjkUev2kVrGmZzfC13uCuHUiGBKM?=
 =?us-ascii?Q?ccUS6Vko5R7neNEXgatf0Dps7VUTU/14qtx6XPSzxrMNU1Go1axIubby2/xU?=
 =?us-ascii?Q?rx5E/MXH/PnQ+OAuo1vIN8tDlQIdcTP7E1yRz2Cd6Em4S9843mOFYpEeFVtU?=
 =?us-ascii?Q?Q4IIvWjjSsUDfbLeUZ8JZVyx78gBLOywIEBjzQXLWK+CEIMj8Lt9ny02bOZp?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a56c4f-ecc5-4f51-2675-08db4cc35260
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8118.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 17:16:38.9734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m7o0BtWfYRkFK8zvlYqjdGHUNCBPEnNQnw9VqZOwZUBbSa/Wzb2h3+KjvdTT1zwkH73RnMG8gJcF8QS+xvB35f5/CVZF9VunIeFa2WJG1i0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7989
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Mariusz Tkaczyk wrote:
> On Thu, 17 Nov 2022 17:34:04 +0100
> Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com> wrote:
> 
> > Hi Bjorn,
> > I agreed with Stuart to take over the NPEM implementation[1].
> > First part I want to share is a small refactor around enclosure interface.
> > 
> > The one sysfs change introduced is changing active LED to write-only.
> > get_active() callback is not implemented for SES which is the
> > only one enclosure API consumer now.
> > 
> > [1]
> > https://lore.kernel.org/linux-pci/cover.1643822289.git.stuart.w.hayes@gmail.com/
> > 
> > Mariusz Tkaczyk (3):
> >   misc: enclosure: remove get_active() callback
> >   misc: enclosure, ses: simplify some get callbacks
> >   misc: enclosure: update sysfs api
> > 
> >  drivers/misc/enclosure.c  | 96 ++++++++++++++++-----------------------
> >  drivers/scsi/ses.c        | 33 ++++++++------
> >  include/linux/enclosure.h | 14 ++----
> >  3 files changed, 61 insertions(+), 82 deletions(-)
> > 
> 
> Hi Bjorn,
> Could you please take a look? Let me know if you against this cleanup.
> I would like to get back to NPEM, I based my patches on top of it.

Hi Mariusz,

I don't expect Bjorn to handle enclosure updates. I expect the upstream
path for these patches is through the SCSI tree. Going forward you can
use get_maintainer.pl for this routing information.

$ ./scripts/get_maintainer.pl drivers/scsi/ses.c 
"James E.J. Bottomley" <jejb@linux.ibm.com> (maintainer:SCSI SUBSYSTEM)
"Martin K. Petersen" <martin.petersen@oracle.com> (maintainer:SCSI SUBSYSTEM)
linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

I'll take a look and then you can resend to linux-scsi. I do like this
stat line:

3 files changed, 61 insertions(+), 82 deletions(-)

...makes it compelling to take a look.
