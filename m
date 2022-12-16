Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2176F64F383
	for <lists+linux-pci@lfdr.de>; Fri, 16 Dec 2022 22:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiLPVyP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Dec 2022 16:54:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLPVyN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Dec 2022 16:54:13 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E065C5F402;
        Fri, 16 Dec 2022 13:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671227650; x=1702763650;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t3Vu/noh8b2xkUTYr3GyFciGdUUIh2goT+BWNSzJc/o=;
  b=PnhMsQvi490j3zyMXS7778eb/idYzS1dmMNDCL8kMPd11pW0gH0HOaew
   kKk78jgmznSFReT621OTuxkcry0CoXWRY/7/AvNEEsE3mv5gcrX79g6d7
   2s7cSwGyHgX8NY/mu3LZJsRi3dQRr1+ajexfMLoN1Wqpnll8N+Gk7YpV5
   MYykpv5VhHrwKb1OM00uMxplZ5yVMA/SU+xv+5TyBBZ8Mw5d9/ZiPgXM8
   SvRR1y7BRTNDEcOEmNiZu8V+Nvdh90BJMAsVtH24loiMbJFMuQpRyoxUG
   pvETK0FSLcUPSKLg70vKw8HdRkbRJVucD4W0lcv1x6dae+cpVHdI87sp0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="317756401"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="317756401"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 13:54:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="627692147"
X-IronPort-AV: E=Sophos;i="5.96,251,1665471600"; 
   d="scan'208";a="627692147"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2022 13:54:09 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 13:54:09 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 13:54:09 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 13:54:09 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 13:54:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTwX55XlRAlFQ6adsLqyyQKsQRMwE9FQjrgSfm+synjkhw22KdGTnrpJ8fZJHBNGD1C6MShF1stULM52/ZRLkRJNHV0OH1+12urhFZeI+7mI3jG9H++izYj+ObPkozkkj9Ttp846nOPlMrQbyHvZQZGSEXgfYgzIjsLjABF0ypnQNZ36S8yOGmx7p+SRNNU3G3GfWAocqVpe9Xy9D9O2aODUnnS5YqGr8hhXFEW0PVhdBXv8tMz6FuQ/qcmTL1HpRGBhOleswlddlREOMC+xEuwb3TJ3qVursfQXX0D0tjo93zljcp+EQmtaKg7mHy+6qhYOgowvlMcSCMsoOYipUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIJjmKHryFM2I8FYI/FE/sDSPf7u2es4/XQR31ZfmVU=;
 b=LGPpw7B5TSWrd5SY6FJbBII4w0nkEykadHCRcrL1QCLm3laNTG35pZNX7Zi2cKeWX0KhNjqAcOhqq7gVibdE1mCTo/xP+IgGz9lfCC9yimQBVmHu3Vyrwei9PDQDle2yDcRkGbXz1e8ld7nqXPRV4Z2lck3c7aJHTXUvm8mrFSRmEwtU/TPi2pSaaQX+OAlZbcZuQCoJ+1vfxR9JPoFMr9zV00OlU8m1gnCRHrUCe7Nio+LlrbZEMEqPdTxEsEXW03t5JaqpY82AORTrS8dooMCRUpoqM9QhL7fwoVer3c3GUimARZ4jrS5GKVfQ6cDf1dtCvugD0qdyRmETmoxrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB7909.namprd11.prod.outlook.com (2603:10b6:208:407::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 21:54:06 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 21:54:05 +0000
Date:   Fri, 16 Dec 2022 13:54:01 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Dave Jiang" <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V4 2/9] cxl/mem: Read, trace, and clear events on driver
 load
Message-ID: <Y5zo+UqOmGCE4ObC@iweiny-desk3>
References: <20221212070627.1372402-1-ira.weiny@intel.com>
 <20221212070627.1372402-3-ira.weiny@intel.com>
 <20221216153939.00007c41@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221216153939.00007c41@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::9) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: f63f6bff-db95-4a22-6275-08dadfb00d4e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FwtbHQ/X7+2curu+ag10y1IRGd3HXXR6CKP34Ex4IlLze+x+wqUAgUUNhSa8ap3M6GkutG5YoJWP9d6T+Nt8sCYfenIZim3FeXAT9MC1O1E8k/KkeMAG5KzFAlezkG1PEL+30pHxRK/s+JYDvFXYQOrA/bWKKseH6PvRHVFQ4OxufdOmdjNGJTlFpF6TQtDbDq4yPTdJ3G78whFruh77ztD9ODyHIpTA2hv4cksuTUx7xQSIz33MwXR39DZgVvOxZG/3U8aZu9hPNtNeM+43jZcW09L07H1eriuGNXJGB4qAXdQ41Yr/24QnucTuyVPQtHZdn0ZEhRCyt5Rfis/GQyajrYqHDoQzxiANtw7mcNCkcAcvKql9CoJ5ml/ahHrenRtTsBCQtIdQGkkM+GrxtaLOoKTcZLizJpisyG7Nd2MXnAWn1IUKp6zXPFqqkuoq7eyBa32MsLBVatQDxf+1x+N+/kvXjwK/pdhWLths1efh7V5o4KPT5mP4AO4WXN0LN64uTRgUmw4UAJfhckUDrwVWQnmWnvklZqsY6Gjw9i7OdVSdWzu2m86KauBxn2ZjGwVBRNWmQnGCC89+9QjzWSEZvCil4YmEBOCPN4oDpQpz5n89EM3PjhcoDCUYr+dXG5Db4tdW6b6szwKYoZ97ZcKC+QY4bDdUNbcQ9Q69Rjf7kZJ9R9ebgnwIoZqA4IqL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199015)(6486002)(33716001)(478600001)(82960400001)(38100700002)(6666004)(41300700001)(86362001)(6506007)(186003)(26005)(8936002)(4326008)(66476007)(8676002)(66946007)(2906002)(66556008)(316002)(5660300002)(44832011)(9686003)(6916009)(6512007)(54906003)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xyY3dioahmWaoDRKqnakW+Kg7TEWJmB7Od2frDsPaRMoLg+fzsDhCPSeRdYX?=
 =?us-ascii?Q?li47w5K8dxp9MGqtQRM8lrK4G5ivShUN+8es2nJY2EtHPUf1RLkYqkqq2fZX?=
 =?us-ascii?Q?vyAk9MeDgOyRhKywK0SOvSiB86foItKfpXwvSNjpRwKaK3/r5+1yhjfSAxX2?=
 =?us-ascii?Q?61YzU59DW4oFpAOz2uH22jTE+hRjvv8gMVOkz9Y2WtZBvgaDvRU7QU27ZUHY?=
 =?us-ascii?Q?lSW2uY2VW9VxVJqQROhLvVYnVBIGpPsGbyoyYCHNzAWESzd/AgRsXGKr4S4i?=
 =?us-ascii?Q?1Pj5B+DIh/6VNQTeD8ubPLGSZho9I9I+iS36l4pEIlsys1/kjpjz1D/hL11O?=
 =?us-ascii?Q?/rznyq4QybTeuLLUVFCPJ0/tVkEaISWedWbzIHxzwPIFThQTLWaJAaJ2RFhS?=
 =?us-ascii?Q?KPaJucExy5FfGkWldGlI9vjSV6HAK5PCl7ZcBKszB96ADdqMOaivRREj0V+d?=
 =?us-ascii?Q?zMNVS0mFyxIFVInpnKHlS/J7qbSkgdmOaBqwjkcdZvJJ9VBxoxBsOxoL1Z15?=
 =?us-ascii?Q?wQ2vxSSS/glfPMBdCh1dqol2t/F3QTg3CX0LtReRZxC/A4MmuAblkVTfmrq1?=
 =?us-ascii?Q?mmrlRqOIJ3FmcJBfyIIcYH7txxZo8zDoRtAU7h0fC/av8XSpGamky6TM6lfn?=
 =?us-ascii?Q?yCrNoc+ck+O8lyhZHlg0tCXNB84Eq27Cch7Ou3IBayyrfmiji869edEaJNZf?=
 =?us-ascii?Q?p3VhrWTOpS1JO9oQgy1qwrtc+ObnwCRyL94Dwfu8viNCQQLBz//fdI6Uak/F?=
 =?us-ascii?Q?hE9REoqkfg9IujyOA0TDJN/uSAtoqKJPjYvU5+HHv/0zdRWwUtIUZfEka2ji?=
 =?us-ascii?Q?gdrzGAfdHSLJZ+vdAKJLA+zS6M844oK7eh01i2b8Ha2mMzSqpXtSlUYVsaW+?=
 =?us-ascii?Q?pI0l8X04mNscDrnTvfQmDkc8mEk6lpU6TQqDLC5WfNAC5eRkMj7TYZyH38PL?=
 =?us-ascii?Q?VOnTIIflL6jwjC8bs23NH7fT3pwSRNGBVADzCUeTqjtIfRsQa3u04rTfmHqu?=
 =?us-ascii?Q?8iibPki5pSkRHKcW1miZE2rNmPxSmAjd7+EfcYgZ9npLU2fWjJ/0IQHOpTJI?=
 =?us-ascii?Q?iZVlhvFJFPX9Drt+2SoovPeJuQCC+3GzdQw3F6zd0/VOhBLvbiSs5d4lVJ5p?=
 =?us-ascii?Q?7bhpLNl//CwykTuBOtHI6xUTgeCVz5lhFhma8RAPGaUHVssZgDRrXqGtnmGW?=
 =?us-ascii?Q?i6cPblYGvuvuENSV7d8YRbxS5aT6iYrmpe97uSBuY9C17Y5OZjrZVb1OjshM?=
 =?us-ascii?Q?8qmXvGBPkB2FDVL97c+flc1jBp62g0yFdimtGlGB0Fb/8x+cc9re0z7m8ihm?=
 =?us-ascii?Q?6iyYel4Y4bBSCvUddv4gQo4I5qn5CKP37FV7pfakQlchtUtWlZKzwGJZ0gNz?=
 =?us-ascii?Q?U93v9xfSK5JYUFgJu7tGXFm25IV9cakbdv5dZCEbbLOfLKJLCN7UcNki+U5b?=
 =?us-ascii?Q?iU9Fr3aW+LPVFz39Xj3KZOB0b7FfU5QQjz1A2NBAB7uaRv+ernGx4i0Txk2K?=
 =?us-ascii?Q?35sbC6LtNDt2vesT4rCiMcTK6Y/HKz5TiXK9FhcqH8RyGWvnkZkLmony2KN0?=
 =?us-ascii?Q?MMQuqPUBPOmcVpSxr9M1GP0JxmlFdq2yo9jwib0tJO6LQSNYeKGpY7bipOGb?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f63f6bff-db95-4a22-6275-08dadfb00d4e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 21:54:05.8543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YT387RgsRHC+cI2qOGJKUaadvK4QJ8vju+WNuo19Qj1UtnbkCBoJLMlhVvhGQyHuoP/mVMO6QZgzr/HVSkrYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7909
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 16, 2022 at 03:39:39PM +0000, Jonathan Cameron wrote:
> On Sun, 11 Dec 2022 23:06:20 -0800
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
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
> 
> A few things noticed inline.  I've tightened the QEMU code to reject the
> case of the input payload claims to be bigger than the mailbox size
> and hacked the size down to 256 bytes so it triggers the problem
> highlighted below.

I'm not sure what you did here.

> 
> > 
> > ---
> > Changes from V3:
> > 	Dan
> > 		Split off _OSC pcie bits
> > 			Use existing style for host bridge flag in that
> > 			patch
> > 		Clean up event processing loop
> > 		Use dev_err_ratelimited()
> > 		Clean up version change log
> > 		Delete 'EVENT LOG OVERFLOW'
> > 		Remove cxl_clear_event_logs()
> > 		Add comment for native cxl control
> > 		Fail driver load on event buf allocation failure
> > 		Comment why events are not processed without _OSC flag
> > ---
> >  drivers/cxl/core/mbox.c  | 136 +++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/trace.h | 120 ++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h        |  12 ++++
> >  drivers/cxl/cxlmem.h     |  84 ++++++++++++++++++++++++
> >  drivers/cxl/pci.c        |  40 ++++++++++++
> >  5 files changed, 392 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index b03fba212799..9fb327370e08 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> 
> > +static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
> > +				  enum cxl_event_log_type log,
> > +				  struct cxl_get_event_payload *get_pl)
> > +{
> > +	struct cxl_mbox_clear_event_payload payload = {
> > +		.event_log = log,
> > +	};
> > +	u16 total = le16_to_cpu(get_pl->record_count);
> > +	u8 max_handles = CXL_CLEAR_EVENT_MAX_HANDLES;
> > +	size_t pl_size = sizeof(payload);
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	u16 cnt;
> > +	int rc;
> > +	int i;
> > +
> > +	/* Payload size may limit the max handles */
> > +	if (pl_size > cxlds->payload_size) {
> > +		max_handles = CXL_CLEAR_EVENT_LIMIT_HANDLES(cxlds->payload_size);
> > +		pl_size = cxlds->payload_size;

pl_size is only the max size possible if that size was smaller than the size of
the record [sizeof(payload) above].

> > +	}
> > +
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_CLEAR_EVENT_RECORD,
> > +		.payload_in = &payload,
> > +		.size_in = pl_size,
> 
> This payload size should be whatever we need to store the records,
> not the max size possible.  Particularly as that size is currently
> bigger than the mailbox might be.

But the above check and set ensures that does not happen.

> 
> It shouldn't fail (I think) simply because a later version of the spec might
> add more to this message and things should still work, but definitely not
> good practice to tell the hardware this is much longer than it actually is.

I don't follow.

The full payload is going to be sent even if we are just clearing 1 record
which is inefficient but it should never overflow the hardware because it is
limited by the check above.

So why would this be a problem?

> 
> 
> > +	};
> > +
> > +	/*
> > +	 * Clear Event Records uses u8 for the handle cnt while Get Event
> > +	 * Record can return up to 0xffff records.
> > +	 */
> > +	i = 0;
> > +	for (cnt = 0; cnt < total; cnt++) {
> > +		payload.handle[i++] = get_pl->records[cnt].hdr.handle;
> > +		dev_dbg(cxlds->dev, "Event log '%d': Clearing %u\n",
> > +			log, le16_to_cpu(payload.handle[i]));
> > +
> > +		if (i == max_handles) {
> > +			payload.nr_recs = i;
> > +			rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > +			if (rc)
> > +				return rc;
> > +			i = 0;
> > +		}
> > +	}
> > +
> > +	/* Clear what is left if any */
> > +	if (i) {
> > +		payload.nr_recs = i;
> > +		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> 
> ...
> 
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index ab138004f644..dd9aa3dd738e 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> 
> ...
> 
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
> 
> Doesn't fit in the smallest possible payload buffer.
> It's 526 bytes long.  Payload buffer might be 256 bytes in total.
> (8.2.8.4.3 Mailbox capabilities)
> 
> Lazy approach, make this smaller and do more loops when clearing.
> If we want to optimize this later can expand it to this size.

I agree but the code already checks for and adjusts this on the fly based on
cxlds->payload_size?

 +	/* Payload size may limit the max handles */
 +	if (pl_size > cxlds->payload_size) {
 +		max_handles = CXL_CLEAR_EVENT_LIMIT_HANDLES(cxlds->payload_size);
 +		pl_size = cxlds->payload_size;
 +	}

Why is this not ok?  [Other than being potentially inefficient.]

Do you have a patch to qemu which causes this?

Ira

> > +} __packed;
> > +#define CXL_CLEAR_EVENT_LIMIT_HANDLES(payload_size)			\
> > +	(((payload_size) -						\
> > +		(sizeof(struct cxl_mbox_clear_event_payload) -		\
> > +		 (sizeof(__le16) * CXL_CLEAR_EVENT_MAX_HANDLES))) /	\
> > +		sizeof(__le16))
> > +
> 
> ...
> 
