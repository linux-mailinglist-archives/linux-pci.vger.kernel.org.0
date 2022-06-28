Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD8455EC6B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 20:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbiF1SUu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 14:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiF1SUt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 14:20:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED6C205D9;
        Tue, 28 Jun 2022 11:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656440447; x=1687976447;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LGZveCXnnI8IZtPB+qA09S5mwcjtDxCn8OJL+/y4JME=;
  b=AvaGwWhworjXXDz2zOs++5m/OvGzxh85CS2jCdOnOb+UzjiVXoqsUDLY
   Nz8RjZkCNuPd2lk4BQEjb/wwG3OkUO6tIDeexumSThjOaadviitguIMeN
   PPyuCvyVk0Q1ynzNyTmuCruqQKsAE15TQ67PZNlZ+6DLp96n8bFvO7om4
   Dqcw3O1KQ7DOHnrWTlbXBrZ7lIQz+t1QsQ0N5PAgJTf+oMLVCsCHwWZTh
   +NxpUIqu43G92KX6OAF/DYUwjgxhwSQb/3aIXzir1xliMSfE9QNxX78Zf
   qA55GYbLRXv6bkaSW0tRUULtOze+9o6o5IJRl/8HbrZfmRxhB7GrlewPz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="270576305"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="270576305"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 11:20:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="767264871"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 28 Jun 2022 11:20:46 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 11:20:46 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 11:20:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 28 Jun 2022 11:20:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 28 Jun 2022 11:20:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjTfVa3L4bdTdhZZI5QR1cbFt+K7VGK8OzE7zGh122gcKBgpZ/6a4H/BFHeGAv8uSi3ZPgdm1Lk2NBE1nfRGW4W1jsAabi/Ty5x1MZUC0rslCP0LX4hTFArqlq0dJWm3PEtMOJj9x7KX7TsuYMEJ0G43rAhPeG1Un9Dbuov8mYhUKTbyAJwYG8wzm0aCP7tvW+XMejS17JyYO6KUUZbmD5e37KyQjCrNUGblM/hUg+fieDg4eigTXandX+zBtuBU3LpWVGeKNlVXCBOJa3/uSb80O/P9ckVNkogu2aekMNRM2V5xkQkiKG0s/98v+3M9iUAyTeXmif5qQUyy40f0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwCp8UqvwVUC1J1BnmUypV6hhyZGMGJQgAnRfi3LSjc=;
 b=Z9bxZRg0XRd9SfKCildj3c/JpFSkewKCk7zujRtajuyTZbVQtBPxl/wAIMwvmK223d+Xv/PaVnOP6N15Fi4cYR1uR/YPkJxgypdZCwv22b+1QQ94uOx5GkM9TeGgVTtfY5MwlHcFgQ4p0z+zDHblBSMKU8MwAj+G8Lz8TOerc+obXS65uHOmFrh3EQnNXdjYBNEhvBe4lu407nlQ8HdTjFqit8EprCdPigL7Lkr3dxWZ1mzf8F16YVXBnUQ6U5sjq/oxrkPgpHHTABo+Y2CrBtgkghI4v6oBV0oITTsjZ7xzLUIEHBOavHiMan2CWahdqfokskInRsWo3BqSG7hJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 SA2PR11MB5033.namprd11.prod.outlook.com (2603:10b6:806:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Tue, 28 Jun
 2022 18:20:42 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::e912:6a38:4502:f207%5]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 18:20:42 +0000
Date:   Tue, 28 Jun 2022 11:20:32 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V12 3/9] PCI: Create PCIe library functions in support of
 DOE mailboxes.
Message-ID: <YrtGcNWcmzumj2gA@iweiny-desk3>
References: <20220628041527.742333-1-ira.weiny@intel.com>
 <20220628041527.742333-4-ira.weiny@intel.com>
 <20220628151626.00001c0f@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220628151626.00001c0f@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::27) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c27d5c7-bb1f-45c2-eeaf-08da5932e92c
X-MS-TrafficTypeDiagnostic: SA2PR11MB5033:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kzL3jAti8H3iVsBPlk3/Ue+8juWa836h4+kmI6AMWRifVrO3Z0G96B2C6gta5l01jZE7QhKfvoJJvr82rasp+jbeY/dTw5i0TMjWim13ZHdQDXHiYV7tsKR4CHqg2Gv1wmf8Pf1MG5seNcEajVbLqYh/J0f/7wKHowpU7HGYLfsgeH5Hy3js/QBuANAXAekREE45F9ceqnDy6fAfFfT4umJClQCSw50VW8hayIkr24d4L+HotUYTUSTvQVPA+mZWvtf74vsoeGf1T3si8gTQ9HeihjnoqLsMH34xrABcbfRaWaMnvdv5rZ4qZek1v/TgK452au7kK8/TA/zTGIf9eCsuK2QVd3WtyxpLvr8VcpV2ifdYxRauPWoUuim5KQGQYues2NTzqD4MiwEnpUAOgai8Z1JOIskzwrVbOxSTEplmaItfWWcGokCaZ1z5a3KvIsBeYPkPfA/NHHlPqkKFOE5dEnBYrIB1E1MD7Hcn5d8xXvIOXFDczSsySEkYyyyb0lravE0sa3gHZQROu+NRwZsQkm+5j2BzxcbLqe/GnR1zAOhNC7JvizqfzSiDv0vDYpOJSTXDNcmHfvmCRRB8t1p7y0dMGBoFO8iKvxU4bLZgIehZumWLyW2vjkks803OFR8ztGHoBfpeRH+HD47rEsohtzpEDe5jq9vGdxm78memAeM0IHOf/HiGO5WQh5ZMIZfXXVwtQbYHClNAI00RVDTArOYQ9LAIT7iwBpLPXQ4ZRTbDGZymAdHNpOeoKdop
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(39860400002)(346002)(396003)(366004)(376002)(33716001)(5660300002)(186003)(6666004)(2906002)(6916009)(30864003)(38100700002)(83380400001)(54906003)(15650500001)(44832011)(66476007)(66556008)(8936002)(316002)(41300700001)(8676002)(6512007)(4326008)(9686003)(6486002)(478600001)(82960400001)(86362001)(66946007)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2KAtb/PK7RWkxo72ENHOJXWXALr77lePZqAwE+y6w36A3QDHcqXy4H8ndjgH?=
 =?us-ascii?Q?olkoDGSgUdWlQmwu7/oCukxFcUKYc+IagQTPXyXW50PQmA4uvRpzpqH74jSV?=
 =?us-ascii?Q?IgcI65Efnc5iZiif8PHzmN3jUESsHNpqHNHLcRNj8yAJTC+eAB+q21Nh6SIi?=
 =?us-ascii?Q?+tpHOzDkYea+yq4uW8mrlH3LH1F441c88L9+3v8IeQJApIO+fJQC3a3whoGP?=
 =?us-ascii?Q?gDsTnYod7vU6HToQoGgRdVF57egLxie7R9zaLiNyvBGvyRkNktLt1ORZDWlZ?=
 =?us-ascii?Q?qZqMMnfIal/YVwm1uqQONkv9VUzjQ0xB8yiZaKJOdQYNFzZuoXtCHiANdLfq?=
 =?us-ascii?Q?9+UbFkDpkOTwW1JvV5nuyjtQfabnpf1iDwQADhU45qQ7Y0SNgzV7qImJqf6u?=
 =?us-ascii?Q?1ZeVOUZ8myFekUyoYtWDZA3G79/iL/Zy3PqEcWjZk1lba/1iDOIKYY/4kNc6?=
 =?us-ascii?Q?C0dQe0U8Syx7dzRknd0igFKS7qBmoWXSzIvYpEblVsLXvCj5HXRfYCS9zK3Q?=
 =?us-ascii?Q?mgTYVabIzWs52cy97RcvCOhqPkMCQmMKyANKEaGqyUe3oVFqRpIHoaJjhjJp?=
 =?us-ascii?Q?VPwu+PjtN4/rdS4tn7yNRja/sJ8KR3beNQwZT6woxAnROQ0Siga+L8pc/cYm?=
 =?us-ascii?Q?jofybngGtJi3sA1wBqWSIB2nJOGh46DHywdPC0rgXMub/ogstBY+IEasvuft?=
 =?us-ascii?Q?E4F8LvpMjKilIcIgbUWoZPpha59r9S6I+t5BrMEDXVpSUYKQUyDcgpurmv6h?=
 =?us-ascii?Q?0LXdIjO2tFWQ/EDNr0JpIwyH0merH3Yy26G/RsMDLwKcWuSOytq58ayCONHH?=
 =?us-ascii?Q?om5IdOCFF0EZXzTXFn7q+NlbUrlq2KFrS/QBkUZiFA3mXDbwI+k2yWeFEVfw?=
 =?us-ascii?Q?+7qmxq8MI/1JE4ZvCOaTq5shqGvNBvattgsj+S+S5YM3G/Q+09xJE6ziyMEN?=
 =?us-ascii?Q?hgH80GDV2Po7eF8OfvQ3lr9KqnVP/qVh2YTnr3ti4o3LwDbrml4aDB5UNRDo?=
 =?us-ascii?Q?BpIty67bKb/jqdAUxcE7Q7mn9Z+ZjvO9ECwPoaNxqk6OrYEDm/uZCVo8T381?=
 =?us-ascii?Q?MpNnLgq9AeeKXS0XKEvuBDDxAGw9t/c9Nyjb7Ft7V5BxG5rS3q4cJSzng9xt?=
 =?us-ascii?Q?2mcloNSGVZnr7ic8Px1dhQDuOuZMDRzqtaBue/hUwFwKREb/SCk2RB/GRoWS?=
 =?us-ascii?Q?Y7tlMEFfqmMSZ7iRqjd3/EVjEM0FvXXnbxvnMrPulgydIxYXEv5eHVNMNhmv?=
 =?us-ascii?Q?ML0U8fAvcy3Xeh2D1XIf72+STLDB2zEaRcho83HY1PkwBS/kePHLSe1TkvWO?=
 =?us-ascii?Q?0XGWYCF5bhs5D1RSXlB/fVrFnoAj7RD/ikK81+vGSPf75PPR7h2uSJuQEQjv?=
 =?us-ascii?Q?Y/wK5Ly7VAtaEgDvxch5LPsS1iHdew82hA9mrVV04pHi9PcTWuqdshdC3275?=
 =?us-ascii?Q?YUZ93LlblczebJyxn9cyTEw3ezRppxTSpk4DK2z2Un4DPGX1CmJRAXlmavkN?=
 =?us-ascii?Q?Cihz4SQycR04mbH4zKC75SWFWIIhUIA5RNogLuVtkWlBEeULlV2GB4irP+Nw?=
 =?us-ascii?Q?SDuTanNwHshJubTqwtHxIRj+xZcPTerWMMoTQFhQkOgvgpyyfp0prBG86Hxz?=
 =?us-ascii?Q?kxIocLGxsHjN9ov4cfPaO5xFjGImS92uoLh0P+rDBcNe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c27d5c7-bb1f-45c2-eeaf-08da5932e92c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 18:20:42.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XI8FNbMK2jejNhWVjNV+I9ePPC+GQed7QUhqr99oD/JWNn3rOsjwEOFFNMNupdFdntObTUAnEFPfcAhs7OrRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5033
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 03:16:26PM +0100, Jonathan Cameron wrote:
> On Mon, 27 Jun 2022 21:15:21 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Introduced in a PCIe r6.0, sec 6.30, DOE provides a config space based
> > mailbox with standard protocol discovery.  Each mailbox is accessed
> > through a DOE Extended Capability.
> > 
> > Each DOE mailbox must support the DOE discovery protocol in addition to
> > any number of additional protocols.
> > 
> > Define core PCIe functionality to manage a single PCIe DOE mailbox at a
> > defined config space offset.  Functionality includes iterating,
> > creating, query of supported protocol, and task submission.  Destruction
> > of the mailboxes is device managed.
> > 
> > If interrupts are desired, the interrupt number can be queried and
> > passed to the create function.  Passing a negative value disables
> > interrupts for that mailbox.  It is the caller's responsibility to ensure
> > enough interrupt vectors are allocated.
> > 
> > Cc: "Li, Ming" <ming4.li@intel.com>
> > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> Hi Ira,
> 
> Thanks for keeping at this!
> 
> I think this has reintroduced some of the races around that annoying
> interrupt source form BUSY transitioning to low that has
> no explicit 'cause' flag.  I think we'd hammered all those out in the
> previous version but maybe there were still some there...

Well I really tried hard not to introduce races which would be a problem.  But
I would not be surprised.

> 
> I 'think' it will work as is, but depending on the timing a given DOE
> implementation has, the interrupt may be completely pointless as it
> will be signaling the wrong event.

:-/

There is a chance that an IRQ comes in just after we timeout waiting for it.  I
think that has always been the case and the IRQ will effectively be missed I
_think_.

> 
> Jonathan
> 

[snip]

> 
> > +/*
> > + * Returned from the wait functions to indicate that an abort has been issued
> > + */
> > +#define DOE_WAIT_ABORT 1
> > +
> > +static int pci_doe_arm_wait(struct pci_doe_mb *doe_mb)
> 
> Feels like there should be a naming to convey the return value as
> a boolean rather than pushing through a flag value.

Something like?

static bool pci_doe_arm_abort_seen(struct pci_doe_mb *doe_mb)
{
	if (test_and_clear_bit(PCI_DOE_FLAG_ABORT, &doe_mb->flags))
		return true;
	clear_bit(PCI_DOE_FLAG_IRQ, &doe_mb->flags);
	return false;
}

...
	if (pci_doe_arm_abort_seen(mb))
		... Process abort ...
...

> 
> > +{
> > +	if (test_and_clear_bit(PCI_DOE_FLAG_ABORT, &doe_mb->flags))
> > +		return DOE_WAIT_ABORT;
> > +	clear_bit(PCI_DOE_FLAG_IRQ, &doe_mb->flags);
> > +	return 0;
> > +}
> > +
> 
> > +static void pci_doe_write_ctrl(struct pci_doe_mb *doe_mb, u32 val)
> > +{
> > +	struct pci_dev *pdev = doe_mb->pdev;
> > +	int offset = doe_mb->cap_offset;
> > +
> > +	if (pci_doe_irq_enabled(doe_mb))
> > +		val |= PCI_DOE_CTRL_INT_EN;
> > +	pci_write_config_dword(pdev, offset + PCI_DOE_CTRL, val);
> > +}
> > +
> > +static int pci_doe_issue_abort(struct pci_doe_mb *doe_mb)
> Can we rename this as it does more than simply issue the abort,
> it waits for it to finish

Sure.

How about just pci_doe_abort()?  I'm probably going to open code that call now.

> 
> > +{
> > +	struct pci_dev *pdev = doe_mb->pdev;
> > +	int offset = doe_mb->cap_offset;
> > +	unsigned long timeout_jiffies;
> > +
> > +	pci_dbg(pdev, "[%x] Issuing Abort\n", offset);
> > +
> > +	/*
> > +	 * Abort detected while aborting; something is really broken or the
> > +	 * mailbox is being destroyed.
> > +	 */
> > +	if (pci_doe_arm_wait(doe_mb))
> > +		return -EIO;
> > +
> > +	timeout_jiffies = jiffies + PCI_DOE_TIMEOUT;
> > +	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_ABORT);
> > +
> > +	do {
> > +		u32 val;
> > +
> > +		/*
> > +		 * Abort detected while aborting; something is really broken or
> > +		 * the mailbox is being destroyed.
> > +		 */
> > +		if (pci_doe_wait_irq_or_poll(doe_mb))
> > +			return -EIO;
> > +		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +
> > +		/* Abort success! */
> > +		if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> > +		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> > +			return 0;
> > +
> > +	} while (!time_after(jiffies, timeout_jiffies));
> > +
> > +	/* Abort has timed out and the MB is dead */
> > +	pci_err(pdev, "[%x] ABORT timed out\n", offset);
> 
> Does this print mention it's a DOE somewhere? 

Yep, per Bjorn's suggestion I removed all the 'DOE ' strings and use the
dev_fmt specifier.

[snip]

> > +
> > +	/* First 2 dwords have already been read */
> > +	length -= 2;
> > +	payload_length = min(length, task->response_pl_sz / sizeof(u32));
> > +	/* Read the rest of the response payload */
> > +	for (i = 0; i < payload_length; i++) {
> > +		pci_read_config_dword(pdev, offset + PCI_DOE_READ,
> > +				      &task->response_pl[i]);
> > +		/* Prior to the last ack, ensure Data Object Ready */
> > +		if (i == (payload_length-1) && !pci_doe_data_obj_ready(doe_mb))
> 
> spaces around - 

Done.

> 
> > +			return -EIO;
> > +		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> > +	}
> > +
> > +	/* Flush excess length */
> > +	for (; i < length; i++) {
> > +		pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> > +		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> > +	}
> > +
> > +	/* Final error check to pick up on any since Data Object Ready */
> > +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
> > +		return -EIO;
> > +
> > +	return min(length, task->response_pl_sz / sizeof(u32)) * sizeof(u32);
> > +}
> > +
> 
> > +
> > +static void doe_statemachine_work(struct work_struct *work)
> > +{
> > +	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
> > +						 work);
> > +	struct pci_doe_mb *doe_mb = task->doe_mb;
> > +	struct pci_dev *pdev = doe_mb->pdev;
> > +	int offset = doe_mb->cap_offset;
> > +	unsigned int busy_retries = 0;
> > +	unsigned long timeout_jiffies;
> > +	u32 val;
> > +	int rc;
> > +
> > +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
> > +		signal_task_complete(task, -EIO);
> > +		return;
> > +	}
> > +
> > +	/* Send request */
> > +retry_req:
> > +	if (pci_doe_arm_wait(doe_mb)) {
> > +		signal_task_abort(task, -EIO);
> > +		return;
> > +	}
> 
> Is there a race here?  If Busy drops at this point we queue up
> a message, but IRQ bit is already set.  Hence when we hit
> wait_event_timeout() the flag is already set and IIRC we'll
> drop straight through.
>

I did not realize that the device would interrupt when Busy dropped?  I was
thinking that V11 did not respond to IRQ but indeed it did via setting the work
item to run immediately...

However, I only see this in the spec:

1) System firmware/software checks that the DOE Busy bit is Clear to ensure
   that the DOE instance is ready to receive a DOE request.

> 
> It'll probably be fine because it will end up polling below
> but doesn't look ideal.

I agree it would not be ideal but I think if we are waiting for Busy to be
cleared then the pci_doe_arm_wait() should be benign.

> 
> Upshot is that you sort of have to handle "spurious interrupts"
> cleanly and rewait on the interrupt if you get one whilst also handling
> race conditions around RW1C of the interrupt status flag.

Sorry I'm not sure what 'RW1C' means here?

Anyway, spurious interrupts was something I was concerned about but I don't
think there is anything we can do about an interrupt coming in when we are
expecting one but the device did not really send one.  AFAIK that is virtually
impossible anyway.

If we actually 'miss' one because we timed out before the device sent it then I
think we are going to ignore the PCI_DOE_FLAG_IRQ flag on the next go around.

Actually timeout is handled by the abort call and that IRQ will, depending on
timing, cause a full PCI_DOE_TIMEOUT to expire.  :-(  That is indeed not
ideal.  However, by that time the error and busy flags should be clear and we
can safely continue.  Otherwise we are going to take the mailbox down.

It may seem better to arm wait on each iteration through the abort loop.  But
this is not logically correct because the abort operation should trigger an
IRQ.  So there is always a race if we missed an IRQ because we timed out early.

> 
> 
> > +
> > +	rc = pci_doe_send_req(doe_mb, task);
> > +
> > +	/*
> > +	 * The specification does not provide any guidance on how long
> > +	 * some other entity could keep the DOE busy, so try for 1
> > +	 * second then fail. Busy handling is best effort only, because
> > +	 * there is no way of avoiding racing against another user of
> > +	 * the DOE.
> > +	 */
> > +	if (rc == -EBUSY) {
> > +		busy_retries++;
> > +		if (busy_retries == PCI_DOE_BUSY_MAX_RETRIES) {
> > +			pci_warn(pdev,
> > +				"[%x] busy for too long (> 1 sec)\n",
> > +				offset);
> > +			signal_task_complete(task, rc);
> > +			return;
> > +		}
> > +		if (pci_doe_wait_poll(doe_mb, HZ / PCI_DOE_BUSY_MAX_RETRIES)) {
> > +			signal_task_abort(task, rc);
> > +			return;
> > +		}
> > +		goto retry_req;
> > +	} else if (rc) {
> > +		signal_task_abort(task, rc);
> > +		return;
> > +	}
> > +
> > +	timeout_jiffies = jiffies + HZ;
> > +	if (pci_doe_wait_irq_or_poll(doe_mb)) {
> 
> So this may well be passed as a result of a BUSY transition to 0 very soon
> after the doe_send_req but well before the data is ready....

I think the simple fix is to make the BUSY wait on an IRQ.  Something like:

21:13:53 > git di
diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
index 12f9f8045eb7..afd326320798 100644
--- a/drivers/pci/doe.c
+++ b/drivers/pci/doe.c
@@ -352,7 +352,7 @@ static void doe_statemachine_work(struct work_struct *work)
                        signal_task_complete(task, rc);
                        return;
                }
-               if (pci_doe_wait_poll(doe_mb, HZ / PCI_DOE_BUSY_MAX_RETRIES)) {
+               if (pci_doe_wait_irq_or_poll(...)) {
                        signal_task_abort(task, rc);
                        return;
                }

> 
> 
> > +		signal_task_abort(task, -EIO);
> > +		return;
> > +	}
> > +
> > +	/* Poll for response */
> > +retry_resp:
> > +	if (pci_doe_arm_wait(doe_mb)) {
> I think we can get here between Busy drop and Object Ready which means
> this can get another IRQ_FLAG setting just after it.  Does it matter?
> Don't think so, as we don't use that bit again in this run through
> and it will be cleared at beginning of next one,

Yea basically I agree.

> but if so why is
> this call here?

Seemed like the right thing to do at the time...  ;-)  j/k

> I think it's only useful for detecting an abort, if
> so do that explicitly.

Actually it is the right thing to do...  However, the wait poll below also
needs to be an IRQ or poll.  I'm not sure how I missed that logic.

> 
> > +		signal_task_abort(task, -EIO);
> > +		return;
> > +	}
> > +
> > +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> > +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> > +		signal_task_abort(task, -EIO);
> > +		return;
> > +	}
> > +
> > +	if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
> > +		if (time_after(jiffies, timeout_jiffies)) {
> > +			signal_task_abort(task, -ETIMEDOUT);
> > +			return;
> > +		}
> > +		if (pci_doe_wait_poll(doe_mb, PCI_DOE_POLL_INTERVAL)) {
> 
> Following on from above....
> As a result of the interrupt having fired on the BUSY off transition,
> I think we will almost always end up spinning here until Object Ready
> is set.  Fine, but seems a shame we don't let an interrupt do this
> for us in most cases.  (note in QEMU response is instantaneous so
> when the interrupt for Busy drop is set, object ready also true so
> by the time we get here data ready will already be sent).

This needs to be pci_doe_wait_irq_or_poll() as well and the arm wait above
ensures we continue to look for that interrupt.

I'm starting to see how I got confused.  The timeout values all vary and
mod_delayed_work() made it very easy for you to interrupt any of those.

I tried to bundle the poll vs interrupt modes in pci_doe_wait_irq_or_poll() and
got confused.  :-(

> 
> > +			signal_task_abort(task, -EIO);
> > +			return;
> > +		}
> > +		goto retry_resp;
> > +	}
> > +
> > +	rc  = pci_doe_recv_resp(doe_mb, task);
> > +	if (rc < 0) {
> > +		signal_task_abort(task, rc);
> > +		return;
> > +	}
> > +
> > +	signal_task_complete(task, rc);
> > +}
> > +
> 
> 
> > +static void pci_doe_free_mb(struct pci_doe_mb *doe_mb)
> > +{
> > +	if (doe_mb->work_queue)
> 
> I'm not a great fan of free functions that check a bunch of conditions
> because they may be called before things are set up.

I'll see what I can do.  I do kind of like this but I think it gets muddled and
I'm not dead set on either way.

> To my
> mind that generally means we should be calling individual cleanup
> in the appropriate error handlers.
> 
> Either that or just use devm handling for each item. Sure
> it's a few more lines of code, but I find it a lot easier to go
> 
> Oh look that thing we just set up is cleaned up by this.
> 
> 
> > +		destroy_workqueue(doe_mb->work_queue);
> > +	if (pci_doe_irq_enabled(doe_mb))
> > +		pci_free_irq(doe_mb->pdev, doe_mb->int_msg_num, doe_mb);
> > +	xa_destroy(&doe_mb->prots);
> > +	kfree(doe_mb);
> > +}
> > +
> 
> ...
> 
> > +
> > +static void pci_doe_destroy_mb(void *mb)
> > +{
> > +	struct pci_doe_mb *doe_mb = mb;
> > +
> > +	/* Mark going down */
> > +	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> > +
> > +	/* Abort any in progress work items */
> > +	pci_doe_abort(doe_mb);
> 
> Abort is getting used for two things in here. Perhaps
> rename this one to 
> pci_doe_abort_tasks() or something like that?

What do you mean two things?  Oh I think I see.  You mean abort the work item
vs abort sent to the hardware?

This no longer aborts all the tasks just the one which may be in progress.
Because the work queue is ordered only one task may be in progress.  I'll clean
up the comment too.

This sets the abort flag and wakes it up if it is sleeping.  If not then the
abort flag will be detected in the next arm.

FWIW I think I may just remove this call and open code it here.

> 
> > +
> > +	/* Flush remaining work items */
> > +	flush_workqueue(doe_mb->work_queue);
> > +
> > +	pci_doe_free_mb(doe_mb);
> > +}
> > +
> > +/**
> > + * pcim_doe_create_mb() - Create a DOE mailbox object
> > + *
> > + * @pdev: PCI device to create the DOE mailbox for
> > + * @cap_offset: Offset of the DOE mailbox
> > + * @int_msg_num: Interrupt message number to use; a negative value means don't
> > + *		 use interrupts
> > + *
> > + * Create a single mailbox object to manage the mailbox protocol at the
> > + * cap_offset specified.
> > + *
> > + * Caller should allocate PCI IRQ vectors before passing a possitive value for
> 
> positive

Thanks fixed.

> 
> > + * int_msg_num.
> > + *
> > + * RETURNS: created mailbox object on success
> > + *	    ERR_PTR(-errno) on failure
> > + */
> > +struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset,
> > +				      int int_msg_num)
> > +{
> > +	struct pci_doe_mb *doe_mb;
> > +	int rc;
> > +
> > +	doe_mb = kzalloc(sizeof(*doe_mb), GFP_KERNEL);
> > +	if (!doe_mb)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	doe_mb->pdev = pdev;
> > +	doe_mb->int_msg_num = -1;
> > +	doe_mb->cap_offset = cap_offset;
> > +
> > +	xa_init(&doe_mb->prots);
> > +	init_waitqueue_head(&doe_mb->wq);
> > +
> > +	if (int_msg_num >= 0) {
> > +		rc = pci_doe_enable_irq(doe_mb, int_msg_num);
> > +		if (rc)
> > +			pci_err(pdev,
> > +				"[%x] enable requested IRQ (%d) failed : %d\n",
> > +				doe_mb->cap_offset, int_msg_num, rc);
> 
> If we are printing an error, I'd argue we should not continue.
> Or at very least we should a comment here to say why we should do so...
> 

Not continue seems reasonable.

> 
> > +	}
> > +
> > +	doe_mb->work_queue = alloc_ordered_workqueue("DOE: [%x]", 0,
> > +						     doe_mb->cap_offset);
> > +	if (!doe_mb->work_queue) {
> > +		pci_err(pdev, "[%x] failed to allocate work queue\n",
> > +			doe_mb->cap_offset);
> > +		pci_doe_free_mb(doe_mb);
> 
> As above, I'd rather this explicitly freed what has been set up
> and only that rather than calling a free function that does a bunch of
> stuff conditionally.

I think I can make that work.  This is the only conditional in free however,
because the other conditional is the IRQ support which may not be set up.

Thanks again for the in depth review!
Ira

> 
> 
> > +		return ERR_PTR(-ENOMEM);
> > +	}
> > +
> > +	/* Reset the mailbox by issuing an abort */
> > +	rc = pci_doe_issue_abort(doe_mb);
> > +	if (rc) {
> > +		pci_err(pdev, "[%x] failed to reset : %d\n",
> > +			doe_mb->cap_offset, rc);
> > +		pci_doe_free_mb(doe_mb);
> > +		return ERR_PTR(rc);
> > +	}
> > +
> > +	if (devm_add_action_or_reset(&pdev->dev, pci_doe_destroy_mb, doe_mb))
> > +		return ERR_PTR(-EIO);
> > +
> > +	rc = pci_doe_cache_protocols(doe_mb);
> > +	if (rc) {
> > +		pci_err(pdev, "[%x] failed to cache protocols : %d\n",
> > +			doe_mb->cap_offset, rc);
> > +		return ERR_PTR(rc);
> > +	}
> > +
> > +	return doe_mb;
> > +}
> > +EXPORT_SYMBOL_GPL(pcim_doe_create_mb);
> > +
> 
> 
> 
