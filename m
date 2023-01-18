Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BEE670F97
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 02:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjARBJi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Jan 2023 20:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjARBJS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jan 2023 20:09:18 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3093C392A2;
        Tue, 17 Jan 2023 17:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674003827; x=1705539827;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zJVlri1NXNGX9x//G3jPCjDABwfWIYbG8pqClT85T04=;
  b=QkQndSYNteyKnPgv/qckkFG4yMOMwyYt9Tlr+Cl+b6QSX29tUoE3VO3/
   TPI7HLpvm/YWBRUoiwUezR8rZBhcxFY7k3m7r9C2EGiAhh4jrTNBKom3M
   6K/oUL2YmiA/9XNTG5X3p2F0cZoUVe6IF+DBE8eaGUYWeMD+ahtESIUgZ
   OTnQu224SD9+eczik8PFR3bViZgHAygB36Udxwl97nKvzlwbRwsof/i1s
   fzRh00aZzIZBnMKeuwpouT7qAbULSsHS2Y4isl+3nI1bwCCJX1Lcde+CU
   Ulo3RALXtB0HlOPwRTRAeEYSKkiHfLHOLR1jWzV4uCExlIQhfG7XF9o/N
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="387216487"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="387216487"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 17:03:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="691785210"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="691785210"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 17 Jan 2023 17:03:44 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 17:03:44 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 17:03:43 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 17:03:43 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 17:03:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQ+T2K/3zeBeAQGA1JCNUDDG6tePAdRMy8x/NVI+1Ki7SaxceO5Bo+YpL36p3PbkQCaUDhhuv6JrMJ8euxZW9MLArkwtLgwD/w8hoJkY2svs7toPNa4G3g7uPJzwswHga7TjzzmZ9VW8zd174zssB4p8tpMGJuczKOG2MersThZPPhkVBI2vZfnVGPZz8YJeSliH6J+Jil/YuoP9mV44/ozhoI7mlW1KovcrHrMQhIDUIoW6GZUnjAAg76/yruZUVuvPEwZDTwtPfWZAFwdRCbwkd4o/nfqcye4mWiWxmRPt9xwTdjxyO0eaF1AHenYZxgundk5+P7RofJHMB5dkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfvJyEyZRclqzHA75+8z01DnIDc+3sh9GfH/Cnwy7nE=;
 b=cFKsNvLAWcO3abR6XGKt1/YgvxJlrMTdUDyJaygVF/IDEdNlla72iGoleKixFSUCqNcQLfSrWJqHALtLThsnu7k53AUlAEnBXqKj4arRT14lotEPm+rS4btKjeGqsKmIh6HRCTuOLZD07FFMX/I5BWTkO1bSL0r9sdBvAKdMO3NO/ng2AXR0nmMULceKb0GkghdrR8275YST5mka2tDM4hlDfK/+L2PH0230/9o7xe/ZiryjdYDC/MgHVS8lrMOxvHbow8Q58/q/v2HAbwKnf6+7usaNpYrP8JJiKJ0YzwJb8jmmNlHKky3X6R+Dgk+sbfYGckqJBDSP1mOfA73BDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 01:03:39 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%8]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 01:03:39 +0000
Date:   Tue, 17 Jan 2023 17:03:35 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v6 1/8] cxl/mem: Read, trace, and clear events on driver
 load
Message-ID: <63c74567c9645_66c3129491@iweiny-mobl.notmuch>
References: <20221216-cxl-ev-log-v6-0-346583105b30@intel.com>
 <20221216-cxl-ev-log-v6-1-346583105b30@intel.com>
 <20230113122258.00000eeb@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230113122258.00000eeb@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::28) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 43164362-ef17-4d13-4044-08daf8efd5b9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yf84zvgZtugNRGnjj95lVGLjKhGFpSJyltVqgmllANUynA+fww0+iPBXFpIhQ+f7Dk7hdGV4/4jJkXcYqBggIwnQGEdCZX1NFxez26+eapT3iXoeurkSbFir5okMD4kG3goNu5Mg+8qDsqnIkMQvQ5XTlq0luQM2XsMqDmrM1t0ZaNxqmi2S9PsyG8DqVIFG4cH3zu0dp3jL1f4C2/pHBuQh1ybjBINKoJYpipql6hl0YL7SBlQlOU7WBYHv7Oy8b9Wpmubi+oRawng7eWh603jh44/o7gVCeblf0DZP/z0dBygEilMdAIlVLAf9gkizptuiFeEdVVCvYM1urh4KLT7sJS++BO2qOJjghX4N2IIqwyH1mJ0TZ7dFx0OzI2itpmYpW+EkF8y9apuQcIRuNEefPSdyD4tr7XPPWkL4OzYwg1esZMkZ58YVxt9T+BGVJDd/uF6iel7SlKa/eINMoITADNrT7Ii7cCd74wS4aDGCORTJFb1fSjEDvor1jazQE2NfHGu09b4uSx3oAFi5g1EG+s+8Ra4DyIHiBvutIEprCw08jxEli4FU86jlMwsj0MYLIiTqTslZ8iLveskyn5IuLO9DEfjsxPekXzEnmLHMf6F4TGfnrsdsV2b479PeEOficG0eZ00G/0EF85M+Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(83380400001)(38100700002)(86362001)(4326008)(5660300002)(2906002)(82960400001)(8676002)(66556008)(66476007)(8936002)(44832011)(66946007)(41300700001)(26005)(186003)(6506007)(9686003)(6512007)(6486002)(110136005)(54906003)(316002)(6666004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8DMAVHvF5qMNBzJr5pHd7bqp4Ax1evjMMx+NNzXZfLKrtswVXyOWPHKEcaqh?=
 =?us-ascii?Q?JwKJ3MA1d/G5MNE4HWx/Dp1peVOS+Z0Pnuk3LC7jEOEu0vIgLlBQjdHUc+Tf?=
 =?us-ascii?Q?Mp6Tg+p5F5YrYj4zJVn3VXPbj6Wy+sCopq/2MFxEDDK7lB1K8ntwp/l9l7yi?=
 =?us-ascii?Q?p9Twdu3iq+x/sMNm5iFBp2t4hAPYHpp6qDKafbBmG9GQQ9xjU1Q70PzvlWem?=
 =?us-ascii?Q?qMLdgciUdxrmvkhxBP1CK1vAFydp2+CbMFoh5dE3sTobMiJET/E+e3uARBp0?=
 =?us-ascii?Q?6wkqEamPwoQaYJ7dXhSvAZ28zXtVwLJBXaW30fHA/e5zT3kmOFLzQETIj9N1?=
 =?us-ascii?Q?37AgvV8UWckNxn/qzb3s/E6wqtFk1Hecl37COFaIkb/ONGyAJzKdrqgiFOuF?=
 =?us-ascii?Q?ADgW2pjiCFRf+HMN9OLeHPSh8XY0wV+SlJg4jo0+BLavIexWJoto+5Z4V+/I?=
 =?us-ascii?Q?hIHhuUtWhyRE/bik7HbossewMrCwxYOCSjCDXLNB1nawdT6jQbMLKIw0HATB?=
 =?us-ascii?Q?raOSNvxpLB2VSzlhuteO3CZfdj6qX20bI8HFaIUZHzvR4BzsUUKOG5hyvBVp?=
 =?us-ascii?Q?8qJ8UE443r7XrN5q3OO6/vP+RKPkuwaS0BgsmXDQwQ6zR9B6/qRYqWJerx9C?=
 =?us-ascii?Q?w+8cIjJmSeoyVUro3+4dE+hv3hgURbXQHviJv1gUofkMicdX1ixU0Ilp/c0E?=
 =?us-ascii?Q?NCCqtG4csCTY5s/jEowNFN1jFDV+2LtBt6ePjyP5uYE238N2tJeYbVugAqEN?=
 =?us-ascii?Q?sK0NCBk/VDnZu/YLO+Tn3DptOLjbp0Dmmq/Axv5s84CWnzGSv/PADF+hKbTI?=
 =?us-ascii?Q?jt3tNQei18K3jAZu6G5agOOZYofEr1uCl4cIANYxgVOQg5zc/8kJrQoC59Rk?=
 =?us-ascii?Q?iEVpvA7T6jIUUM1p15lpxcqTnyiIY1GzWyTc9zF7cRNDHBAngqmt12nHkh2C?=
 =?us-ascii?Q?9+K3hZp56G6mptnbjAEsPtnaH+VuWGpFcs8vFvyFF/fBXB6CyE8Eil/qRCym?=
 =?us-ascii?Q?9Q+nZMVT53uccYuvlRiavi7e2A35/Gjbqrk42yX2pvU1gHhNXWWZgoPUrTU+?=
 =?us-ascii?Q?ws4g+kR5VKtcyozP3JRJuP53SNmDBPitdiKy5wqZ4fpnuvQ2euXTSRKXgfUz?=
 =?us-ascii?Q?AFGvv40QUJb+Zjk34bojPj4a8dDgLorHI7KEbhlLlMw93wEFljWVjYLmFJ5Q?=
 =?us-ascii?Q?yU7OGt902lAVXYnsfBJYafj/YXayY2yyK+DkhuCV894JHKnSlgGrKA0i911P?=
 =?us-ascii?Q?lr5HbbfykqUXUSIl1b0IrJJ4kGErseoLSBlcDa26eX44trDQhok1WLKQfa6u?=
 =?us-ascii?Q?ORKkqTFkO9Y1veiJ2i3vMQRE6z40qi3Ztn34j7DEFohtLHInf3xi2BQp2Fmg?=
 =?us-ascii?Q?bbP0d5Urtdj4KtRC4i61DtjY3BIlFqq6apxPxualF6CwSDKF0q9OWzbVbcTa?=
 =?us-ascii?Q?CV7FI+9khdb7BH5RH+DMlU+1iQNvDwJu8gdbaDGS5FXxsT4nD81Y8pk64L9t?=
 =?us-ascii?Q?FC9ZqdAVIwTULdNkz13Mhi1XdxggXiwIv3DDBYAeTMUtGqbR0R/DQuOEUH5y?=
 =?us-ascii?Q?mGiBBZ8PXmtOOaIjJaVsuNgJNerNWSu0NI4ayGpN?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43164362-ef17-4d13-4044-08daf8efd5b9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 01:03:39.4636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+flezwR/MsVZupbfnYkYcHMVQIDiTerzipfXFcovrJn7R/ud/0C1sfQt4bGH4z00NVFuASn94Sop2DdwLYLng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Mon, 09 Jan 2023 11:42:20 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > CXL devices have multiple event logs which can be queried for CXL event
> > records.  Devices are required to support the storage of at least one
> > event record in each event log type.
> > 
> > Devices track event log overflow by incrementing a counter and tracking
> > the time of the first and last overflow event seen.
> > 
> > Software queries events via the Get Event Record mailbox command; CXL
> > rev 3.0 section 8.2.9.2.2 and clears events via CXL rev 3.0 section
> > 8.2.9.2.3 Clear Event Records mailbox command.
> > 
> > If the result of negotiating CXL Error Reporting Control is OS control,
> > read and clear all event logs on driver load.
> > 
> > Ensure a clean slate of events by reading and clearing the events on
> > driver load.
> > 
> > The status register is not used because a device may continue to trigger
> > events and the only requirement is to empty the log at least once.  This
> > allows for the required transition from empty to non-empty for interrupt
> > generation.  Handling of interrupts is in a follow on patch.
> > 
> > The device can return up to 1MB worth of event records per query.
> > Allocate a shared large buffer to handle the max number of records based
> > on the mailbox payload size.
> > 
> > This patch traces a raw event record and leaves specific event record
> > type tracing to subsequent patches.  Macros are created to aid in
> > tracing the common CXL Event header fields.
> > 
> > Each record is cleared explicitly.  A clear all bit is specified but is
> > only valid when the log overflows.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> A few trivial comments inline, but whether you act on them or not lookjs
> good to me.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

I poked Dan about these comments.  He agreed with you about the dynamic
struct.  So thanks for the review and I'll pick it up.  More responses
below.

> 
> > +static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> > +				    enum cxl_event_log_type type)
> > +{
> > +	struct cxl_get_event_payload *payload;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	u8 log_type = type;
> > +	u16 nr_rec;
> > +
> > +	mutex_lock(&cxlds->event.log_lock);
> > +	payload = cxlds->event.buf;
> > +
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
> > +		.payload_in = &log_type,
> > +		.size_in = sizeof(log_type),
> > +		.payload_out = payload,
> > +		.size_out = cxlds->payload_size,
> > +		.min_out = struct_size(payload, records, 0),
> > +	};
> > +
> > +	do {
> > +		int rc, i;
> > +
> > +		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > +		if (rc) {
> > +			dev_err_ratelimited(cxlds->dev, "Event log '%d': Failed to query event records : %d",
> 
> Might as well have slightly shorter line by adding a break after dev,
> Same with other case below. If nothing else it will reduce bot warnings slightly I think.

Sure since I'm respining.

[snip]

> 
> > +/*
> > + * Common Event Record Format
> > + * CXL rev 3.0 section 8.2.9.2.1; Table 8-42
> > + */
> > +struct cxl_event_record_hdr {
> > +	uuid_t id;
> > +	u8 length;
> > +	u8 flags[3];
> > +	__le16 handle;
> > +	__le16 related_handle;
> > +	__le64 timestamp;
> > +	u8 maint_op_class;
> > +	u8 reserved[15];
> > +} __packed;
> > +
> > +#define CXL_EVENT_RECORD_DATA_LENGTH 0x50
> > +struct cxl_event_record_raw {
> > +	struct cxl_event_record_hdr hdr;
> > +	u8 data[CXL_EVENT_RECORD_DATA_LENGTH];
> > +} __packed;
> 
> Mostly to avoid ugly casts in patch 3, I would consider
> a union of all the defined record types.  That way you could
> just pick the right one based on a uuid match and keep type
> safety etc.

Each of the trace points dump information from the common header.

So I don't think this is worth the effort of adding another pointer into
the trace point for the other structures.


I'm going to accept your review on this one if that is ok.


> 
> > +
> > +/*
> > + * Get Event Records output payload
> > + * CXL rev 3.0 section 8.2.9.2.2; Table 8-50
> > + */
> > +#define CXL_GET_EVENT_FLAG_OVERFLOW		BIT(0)
> > +#define CXL_GET_EVENT_FLAG_MORE_RECORDS		BIT(1)
> > +struct cxl_get_event_payload {
> > +	u8 flags;
> > +	u8 reserved1;
> > +	__le16 overflow_err_count;
> > +	__le64 first_overflow_timestamp;
> > +	__le64 last_overflow_timestamp;
> > +	__le16 record_count;
> > +	u8 reserved2[10];
> > +	struct cxl_event_record_raw records[];
> > +} __packed;
> > +
> > +/*
> > + * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
> > + */
> > +enum cxl_event_log_type {
> > +	CXL_EVENT_TYPE_INFO = 0x00,
> > +	CXL_EVENT_TYPE_WARN,
> > +	CXL_EVENT_TYPE_FAIL,
> > +	CXL_EVENT_TYPE_FATAL,
> > +	CXL_EVENT_TYPE_MAX
> > +};
> > +
> > +/*
> > + * Clear Event Records input payload
> > + * CXL rev 3.0 section 8.2.9.2.3; Table 8-51
> > + */
> > +#define CXL_CLEAR_EVENT_MAX_HANDLES (0xff)
> > +struct cxl_mbox_clear_event_payload {
> > +	u8 event_log;		/* enum cxl_event_log_type */
> > +	u8 clear_flags;
> > +	u8 nr_recs;
> > +	u8 reserved[3];
> > +	__le16 handle[CXL_CLEAR_EVENT_MAX_HANDLES];
> > +} __packed;
> > +#define CXL_CLEAR_EVENT_LIMIT_HANDLES(payload_size)			\
> > +	(((payload_size) -						\
> > +	  offsetof(struct cxl_mbox_clear_event_payload, handle)) /	\
> > +	 sizeof(__le16))
> > +#define CXL_CLEAR_EVENT_PL_SIZE(nr_handles)				\
> > +	(offsetof(struct cxl_mbox_clear_event_payload, handle) +	\
> > +	 (nr_handles * sizeof(__le16)))
> > +
> 
> Still ugly, but I guess I can live with it though it's a bit of
> large structure to put on the stack and if you used the heap then
> a simple struct_size() allocation and having a variable length
> array for last element would make this neater.
> 

Ok I'm going to change this but I think the code will still be 'ugly'.
But Dan's justification was that the spec defines what looks like a
dynamic struct and it will be easier to follow if this structure is
defined that way as well.  Even though the handles are limited by nr_recs.

> 
> 
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 3a66aadb4df0..a2d8382bc593 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -417,8 +417,37 @@ static void disable_aer(void *pdev)
> >  	pci_disable_pcie_error_reporting(pdev);
> >  }
> >  
> > +static void cxl_mem_free_event_buffer(void *buf)
> > +{
> > +	kvfree(buf);
> > +}
> > +
> > +/*
> > + * There is a single buffer for reading event logs from the mailbox.  All logs
> > + * share this buffer protected by the cxlds->event_log_lock.
> > + */
> > +static int cxl_mem_alloc_event_buf(struct cxl_dev_state *cxlds)
> > +{
> > +	struct cxl_get_event_payload *buf;
> > +
> > +	dev_dbg(cxlds->dev, "Allocating event buffer size %zu\n",
> > +		cxlds->payload_size);
> > +
> > +	buf = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	if (devm_add_action_or_reset(cxlds->dev, cxl_mem_free_event_buffer,
> > +				     buf))
> > +		return -ENOMEM;
> trivial:
> 
> Should return the error code from devm_add_action_or_reset.
> Sure it's always -ENOMEM today, but it might not be in future ;)

Done.

> 
> > +
> > +	cxlds->event.buf = buf;
> > +	return 0;
> > +}
> > +
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> > +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> >  	struct cxl_register_map map;
> >  	struct cxl_memdev *cxlmd;
> >  	struct cxl_dev_state *cxlds;
> > @@ -494,6 +523,17 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> >  
> > +	rc = cxl_mem_alloc_event_buf(cxlds);
> 
> I'm in two minds about this.  For current support, makes little sense to have
> this unless host_bridge->native_cxl_error is true, but then we'll end up moving
> it for DCD.
> 
> On balance I'd rather today's code made sense and we had to modify a bit more when
> adding DCD support though, so better to move it under the if below.
> (unless I'm missing something of course!)

I really want to say that Dan told me to just allocate the buffer all the
time in a previous review.  But I've not found it ATM.

Ira
