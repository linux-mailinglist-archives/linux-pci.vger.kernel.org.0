Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F746489C8
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 22:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLIVAv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 16:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIVAu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 16:00:50 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633EAAC6D2;
        Fri,  9 Dec 2022 13:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670619648; x=1702155648;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zZ366gHkpaTngRTb4s0mw9safFsXmubLXfFv02C0W2Q=;
  b=TcDRLeuMyyVK0hBcQQlEyj1ZHkyV6gYRnWjaX81dviF7AKUrQdFNgAwt
   UjyuNXG+HEztr3UzNXSQbRBHFCHFAlMzHkk9BBAAwQyQ/LD0KEohSj6D/
   ZE3PsWCk4BJEVKk1bPU819l0BbdnvKuISQcQuVS0LPKp0YGII7Hv20ME9
   Mxuuc+WthGwlFDmFQJwMBQw2pq7sodQCDkTAKHZr0IGFUZWhxAnvrjHts
   BTqzonxoSNw2Z5GtKDMnPiDI7o5TZmyXY0ZpE85VwU6tOcEwFq5YY/flp
   /A+31UllMdD5799XzgBLuc7V9yiwFxY3uI9aq7PpdAba+FpF7dSYUa/j3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="297226141"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="297226141"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 13:00:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="597843175"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="597843175"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 09 Dec 2022 13:00:47 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 13:00:47 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 9 Dec 2022 13:00:46 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 9 Dec 2022 13:00:46 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 9 Dec 2022 13:00:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSEds/3P7GU85Rf8aOl4ndMh6oc9NwsntoDYhjyoCUCA/9ujgj63f6fZyjuXYozgP5cFhNyq9F/htgI9EjOOcXQC5zFhhf9SsmiGt2nsDhrDEwn6WsGPB+IdoX/rZ32ho1YbbSytlMasm9P6MCEzqd3d5oWv9jMCRPSin7+TIPX40QfytiEyCQYQ3oYBCIhIb7BuhTEeI23E5ulDRfsfDGBnBnR939x4/Aqslti4KQgKCjjvFWytq2MynXYvFXkgZMbNsV4ZfB91vjTaSXepDt0HKWIB8V+CxHZYirN73tbqSU69g5MgXPo6zoQq74N9ddOjuik6XOk0hHgef7RONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZylsSxHLENUqV5DXfQYjtHMyS51u9iy8IISFRevefI=;
 b=Dd/XSkOlStsmTxFuGG1A0dY6xnEShsP60aUVyoGBxaXmZ9DovJQ66ajwB65KAbTOVLX2jkkI2x0MieKzPkCPYi1BdHo6wttA2Pwz/ayfYbDXxCuAo2JcDtedE29O6zxzSmHkUFa+MeVtwh0mxgW/Z/IzfkwrRwb1hO+bY3gxyxI0ZWTdna8YncI/JC6E3uZXohWPvlkttNm4B+VX+mA5J8YhubSrLNq5kcIA2PF6yJChaMk1wAYY8ChHTXm4gjYeSWN9YL/OtTs2ZygvkoRlcUK0XHjZzF8MdIV12rrslz8Echu614aWk2OWqasnnR105R7JEYdj8LI+Ah38s8nC0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB5012.namprd11.prod.outlook.com (2603:10b6:303:90::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 21:00:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::5236:c530:cc10:68f%5]) with mapi id 15.20.5880.014; Fri, 9 Dec 2022
 21:00:41 +0000
Date:   Fri, 9 Dec 2022 13:00:35 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH V3 1/8] cxl/mem: Read, trace, and clear events on driver
 load
Message-ID: <Y5Oh89JFAWYIITUV@iweiny-desk3>
References: <20221208052115.800170-1-ira.weiny@intel.com>
 <20221208052115.800170-2-ira.weiny@intel.com>
 <639376e1452bd_579c12945c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <639376e1452bd_579c12945c@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:a03:332::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB5012:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c1cde3-dbe4-4954-fc39-08dada286e5a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H076+DWH/ip12zq/jAa/VEY50D1d5dYJRfJa7e1y3Y0HUkfm3D3MYZvWmBRwZWHXzcWSeT8pGRGN1gWMa+do4eF75BFk+0YkqOlYGENhUKehODkJOWp7C5elwJf3+160bEhQfvGigKxt1muiqTNYhMVMKP7Ixel4Dp2F5AFO7o1J6eeE7PXLldz2O5gZvTdH/P4CLuZslc3hz8mln69TXo+Xf+3g2Zn74UdPUBjU5x4dPN9QoeJkbSqzG59xn7sss0W75Bzf4fBbPp92dlhvclKXik/DDn7+r1dS9UEwqDrUf1m0FIF5D00BrU0biEhd3r+WUYTSfdLavv+xJym1deBx08E8EvGa3jIL5aEm7sgaxOJ/AhGpdxcp2vAVlgXaRxR5eU4rakQ3PNnNYv2nhWClcnncrC/NcQSuiSuYmZhIGbzPxf12GoRNGS9Mx+hWG6/ySsHjW1pEeH9/QWqyyUEocskYcdCKeBsqgYfxwAllMYHqJ/36PNbVtAcuj5BEz2SQXDW4fmKkkjG2+f8BKJI/YS3Cby+/OOaKzjP3cnEA9D237LedkQG1jkhl/Kcs6t2M0MAlf3sYCPNMT1Vpr1GbG5ntV25Q8l/7bqiaHdINf46qU2q+JWlUMg3qSvt6pfjuNWl9chjy1E1xLGXA5S0eppt7hEzJlpVXL4Nk96/XG0onTuHg1tmBazyJhcFL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199015)(316002)(6506007)(83380400001)(5660300002)(9686003)(8936002)(6862004)(86362001)(2906002)(30864003)(26005)(54906003)(6636002)(186003)(41300700001)(33716001)(6512007)(4326008)(8676002)(66946007)(66476007)(66556008)(38100700002)(6666004)(6486002)(44832011)(478600001)(82960400001)(47845001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gjukFwo7JIBMSswvteiwJVdxpW633oT3aG99r2VgYfe6wsmNCUorl+mwjyC7?=
 =?us-ascii?Q?9N7L48GwcMcGqNftC84sHbVyg6JhQkbrXmi2+dr3au6d9gq+HkXFgz8lpzjj?=
 =?us-ascii?Q?rFDFM7TOpWIKOrJEVrfedbwXjgz01lkryYjWmhAIe740N+BCeE/NF8TeO6T3?=
 =?us-ascii?Q?BguyshVCm392qjApb/FqL9j5bRs0g5V+of8EIAwSEdlJvP3f2CbaDV3l9yBL?=
 =?us-ascii?Q?wHWgbrrwIsYDOm40ZlZm52Q+DNxBTh1+Qtt5RRhzQknZs8VLo4ARXeiQO4tB?=
 =?us-ascii?Q?40fZbo2BL+MG2XtCNkD5a6lpUJJWDsqT6ewjhdHP+IDkBYGKULKV6mK9Hb4E?=
 =?us-ascii?Q?rWiYrFxdBdSilmSy8h/dYVLJ04xXDAIpfrFmki/cWiWBOy6hxquXdF0xLrJO?=
 =?us-ascii?Q?niSpSC8nUvkNQ/mS7L0Bw+9rNtNLzuGeKPo5Sgf6O1X8ej3LWWVsWPRWHUCi?=
 =?us-ascii?Q?8kW6WibsQzlI8+l5caLgRDfiut7/o6thCQW6UjjTxxDyczcrzN/Xwg74l5em?=
 =?us-ascii?Q?5u9cVuMmGvbT7Ie6wIOhxfZUfQKBu6D68wq9a7+Biy+LqwtJd1F3ByfhZhrF?=
 =?us-ascii?Q?O2pMvGUgpjREELOngux5BYe57dV/2Ro0Jjzw1T3HLwy1nFl3duhqBuIfPxjv?=
 =?us-ascii?Q?RBIVxGAEiJt+g2Uo+GZXUnFI1xACR2oV9YCDYs5zK4oz/3hYQ5Ls/UBuSyXB?=
 =?us-ascii?Q?PtuDvge1n8rOnGwNcswSKIRE6GFA/9XytRp5nWmIlneL63gaSEIPr7Caoway?=
 =?us-ascii?Q?8p+DhYUpin+TtfYU2cn3iXD45Oi3T9CqrTi3lyNGuOBq56At76kY5R8tnPSB?=
 =?us-ascii?Q?wKtPAM+81X6h3OvLH7DxFo7hELf1wILDDYxIvNmwkTUlQ3jj2KTR0EFo9Pyu?=
 =?us-ascii?Q?6t+55r9ryKzGkSwIeQWJZvblVDLqvgN0gppuGjoA3SysbNjOnvYFRcL6E7fS?=
 =?us-ascii?Q?bsuuN0ZZRPyCtyY3Ahzuo2FdU63i+3pjONsWWksD9Bwagz4j14OCbhAaAdYo?=
 =?us-ascii?Q?7AwYngyL2881NWDDsibppk9pyMbuLlzO1H9eNgC/LzDnW9IJlkzj6FRcMArg?=
 =?us-ascii?Q?oBzc/vIhq+4w02FWZ0TqanINQW1dAc46WC66QDtgN8B/X3AO5JmDabPQamZQ?=
 =?us-ascii?Q?usbPVCaZYrguKYN6nPgVDbOzSXZIZshkm/d/1oEBEI8+rDQnvyAhK7N+zJLP?=
 =?us-ascii?Q?TiY8YOFRdzjFd4IiBTra9+AF6iw1PiWbPCZ9qK24xja/RPBXRt4xAeIY4bkj?=
 =?us-ascii?Q?oYUaGggzAm2b/F5/HFGsuEy1WCirHGkX96iEf08w9gtY709cDm9L4nQteUdB?=
 =?us-ascii?Q?nlpPT+tS1gQ9G6kTwLIOBWWEj3KKNwH3gJypy/DtDFkJZKwphBKsZDMev+kw?=
 =?us-ascii?Q?+CF3yYMp01L9nPvPrh0/yWk0UdMfebcD1Qyp9vNMf9Jg4V2RU9cZgLg8gIVK?=
 =?us-ascii?Q?ydkpPK8tgJsW65+8VkwmqKZicfSlfhe8x2DmX6uupXY4mp8vQaD9weDFkCRt?=
 =?us-ascii?Q?8a44jjV54RBdIIu5Cq5BrT6kvWtN7lPxHnsHnkYCiJcCq/CWvOrZcfla3xbU?=
 =?us-ascii?Q?msS1ZHUiZPZYrkoTBYib30//nGBuNRivwAh1F+U3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c1cde3-dbe4-4954-fc39-08dada286e5a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 21:00:41.4162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfGejaWc6GmqiygxPm3XuLmNYj6NP9wKucl/XbJe120749qJbnRNntShC2hEZC/ex6gXkID9+W0v5L5YZCdSrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5012
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 09:56:49AM -0800, Dan Williams wrote:
> ira.weiny@ wrote:
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
> > CXL _OSC Error Reporting Control is used by the OS to determine if
> > Firmware has control of various error reporting capabilities including
> > the event logs.
> > 
> > Expose the result of negotiating CXL Error Reporting Control in struct
> > pci_host_bridge for consumption by the CXL drivers.  If support is
> > controlled by the OS read and clear all event logs on driver load.
> > 
> > Ensure a clean slate of events by reading and clearing the events on
> > driver load.  The operation is performed twice to ensure that any prior
> > partial readings are completed and a fresh read from the start is done
> > at least one time.  This is done even if rogue reads cause clear errors.
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
> > 
> > ---
> > Changes from V2:
> > 	Rebased on 6.3 pending changes
> > 	Move cxl_mem_alloc_event_buf() to pci.c
> > 	Define and use CXLDEV_EVENT_STATUS_ALL
> > 	Fix error flow on clear failure
> > 	Remove tags
> > 	Jonathan/Dan
> > 		Add in OSC Error Reporting Control check
> > 	Dan (Jonathan in previous version)
> > 		Squash Clear events and the driver load patch into this one.
> > 	Dan
> > 		Make event device status a separate structure
> > 		Move tracing to within cxl core
> > 		Reduce clear double loop to a single loop
> > 		Pass struct device to trace points
> > 		Adjust to new cxl_internal_send_cmd()
> > 		Query error logs in order of severity fatal -> Info
> > 		Remove uapi defines entirely
> > 		pass total via get_pl
> > 		fix 'Clearning' spelling
> > 		Better clarify event_buf singular allocation
> > 		Use decimal for command payload array sizes
> > 		Remove trace_*_enabled() optimization
> > 		Put GET/CLEAR macros at the end of the user enum to
> > 		preserve compatibility
> > 		Add Get/Clear Events to kernel exclusive commands
> > 		Remove cxl_event_log_type_str() outside of tracing
> > 		Add cond_resched() to event log processing
> > 	Jonathan
> > 		s/event_buf_lock/event_log_lock
> > 		Read through all logs two times to ensure partial reads are
> > 			covered.
> > 		Pass buffer to cxl_mem_free_event_buffer()
> > 		kdoc for event buf
> > 		Account for cxlds->payload_size limiting the max handles
> > 		Don't use min_t as it was used incorrectly
> > 
> > Changes from V1:
> > 	Clear Event Record allows for u8 handles while Get Event Record
> > 	allows for u16 records to be returned.  Based on Jonathan's
> > 	feedback; allow for all event records to be handled in this
> > 	clear.  Which means a double loop with potentially multiple
> > 	Clear Event payloads being sent to clear all events sent.
> > 
> > Changes from RFC:
> > 	Jonathan
> > 		Clean up init of payload and use return code.
> > 		Also report any error to clear the event.
> > 		s/v3.0/rev 3.0
> 
> This is a lot of text to skip over. The cover letter has the summary of
> the changes and a link to v2 and that has the link to v1. Why does each
> patch need the full history of changes all over again?

I've seen this done elsewhere and just copied it.  But I think the use of b4
send will help me in future.  I agree it is unneeded.  Even in the cover
letter.

> 
> > 
> > squash: make event device state a separate structure.
> > ---
> >  drivers/acpi/pci_root.c  |   3 +
> >  drivers/cxl/core/mbox.c  | 138 +++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/trace.h | 120 ++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h        |  12 ++++
> >  drivers/cxl/cxlmem.h     |  84 ++++++++++++++++++++++++
> >  drivers/cxl/pci.c        |  42 ++++++++++++
> >  include/linux/pci.h      |   1 +
> >  7 files changed, 400 insertions(+)
> > 
> > diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> > index b3c202d2a433..cee8f56fb63a 100644
> > --- a/drivers/acpi/pci_root.c
> > +++ b/drivers/acpi/pci_root.c
> 
> I do appreciate that this patch has a full thought about error handling
> implementing the full cycle of retrieve and clear, but I think these
> drivers/acpi/ changes can stand on their own as a lead-in patch if only
> so that Bjorn and Rafael do not need to dig through the CXL details.

Split it out.  That was my inclination anyway.  ;-)

> 
> 
> > @@ -1047,6 +1047,9 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> >  	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
> >  		host_bridge->native_dpc = 0;
> >  
> > +	if (root->osc_ext_control_set & OSC_CXL_ERROR_REPORTING_CONTROL)
> > +		host_bridge->native_cxl_error = 1;
> > +
> 
> Copy the existing style and init the flag to 1 in pci_init_host_bridge()
> and clear it in acpi_pci_root_create() upon fail to take control.

Ah good point.  Done.

> 
> >  	/*
> >  	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
> >  	 * exists and returns 0, we must preserve any PCI resource
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index b03fba212799..815da3aac081 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -8,6 +8,7 @@
> >  #include <cxl.h>
> >  
> >  #include "core.h"
> > +#include "trace.h"
> >  
> >  static bool cxl_raw_allow_all;
> >  
> > @@ -717,6 +718,142 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
> >  
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
> > +	}
> > +
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_CLEAR_EVENT_RECORD,
> > +		.payload_in = &payload,
> > +		.size_in = pl_size,
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
> > +
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
> > +		int rc;
> > +
> > +		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> > +		if (rc) {
> > +			dev_err(cxlds->dev, "Event log '%d': Failed to query event records : %d",
> > +				type, rc);
> > +			goto unlock_buffer;
> > +		}
> > +
> > +		nr_rec = le16_to_cpu(payload->record_count);
> > +		if (nr_rec > 0) {
> 
> Can save some indentation here and just do:
> 
> 	if (!nr_rec)
> 		break;
> 
> ...and then out-indent this below:

:-/

I suppose that does make sense.  Somehow I thought the overflow flag might be
set here.  But that should not be the case if nr_rec == 0.

> 
> > +			int i;
> > +
> > +			for (i = 0; i < nr_rec; i++)
> > +				trace_cxl_generic_event(cxlds->dev, type,
> > +							&payload->records[i]);
> > +
> > +			rc = cxl_clear_event_record(cxlds, type, payload);
> > +			if (rc) {
> > +				dev_err(cxlds->dev, "Event log '%d': Failed to clear events : %d",
> > +					type, rc);
> 
> This and the other dev_err() above should be dev_err_ratelimited() because if
> these ever fire they'll probably start firing in bunches.

Yea good catch.  Previously, exited from the loop and would effectively stop.
But now there is a loop on the status and this will keep printing.  Effectively
this may be forever because if something is wrong and the log is not clearing
out the status won't clear...  :-/

Thinking about this I was tempted to make this dev_err_once().  But there are
some error which would correct themselves and could make progress.

FWIW I know you mentioned that this error could be a trace point as well.  But
I opted not to do that because if no one is listening to the trace points and
there is an error the admin will have no idea this device is going haywire for
apparently no reason.  This is especially true on start up.

> 
> > +				goto unlock_buffer;
> 
> Nit, but how about just "break;" here? No need for a label.

Just my style.  The goto is more explicit.  Especially with this much logic in
the while loop.  Also an 'unlock_buffer' label is pretty standard as the
'exception' case.

> 
> > +			}
> > +		}
> > +
> > +		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> > +			trace_cxl_overflow(cxlds->dev, type, payload);
> 
> I'm worried about this potentially looping and causing softlockups
> without a cond_resched(), but lets wait and see if more complexity is
> needed.

I did have a cond_resched() here but opted to have it at the status level
rather than here.  So reading of _all_ the logs will not loop without a pause.
This was partly because I want this loop to drop out to read the other logs and
I'm worried that if we delay here we may end up never empting the individual
logs.  Of course then we have other problems too.  So... yea I'd like to wait
and see.  I feel like the OS should be able to keep up with normal errors.

> 
> > +	} while (nr_rec);
> > +
> > +unlock_buffer:
> > +	mutex_unlock(&cxlds->event.log_lock);
> > +}
> > +
> > +/**
> > + * cxl_mem_get_event_records - Get Event Records from the device
> > + * @cxlds: The device data for the operation
> > + *
> > + * Retrieve all event records available on the device, report them as trace
> > + * events, and clear them.
> > + *
> > + * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
> > + * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
> > + */
> > +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status)
> > +{
> > +	dev_dbg(cxlds->dev, "Reading event logs: %x\n", status);
> > +
> > +	if (status & CXLDEV_EVENT_STATUS_FATAL)
> > +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);
> > +	if (status & CXLDEV_EVENT_STATUS_FAIL)
> > +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
> > +	if (status & CXLDEV_EVENT_STATUS_WARN)
> > +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
> > +	if (status & CXLDEV_EVENT_STATUS_INFO)
> > +		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
> > +
> >  /**
> >   * cxl_mem_get_partition_info - Get partition info
> >   * @cxlds: The device data for the operation
> > @@ -868,6 +1005,7 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
> >  	}
> >  
> >  	mutex_init(&cxlds->mbox_mutex);
> > +	mutex_init(&cxlds->event.log_lock);
> >  	cxlds->dev = dev;
> >  
> >  	return cxlds;
> > diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> > index 20ca2fe2ca8e..24eef6909f13 100644
> > --- a/drivers/cxl/core/trace.h
> > +++ b/drivers/cxl/core/trace.h
> > @@ -6,7 +6,9 @@
> >  #if !defined(_CXL_EVENTS_H) || defined(TRACE_HEADER_MULTI_READ)
> >  #define _CXL_EVENTS_H
> >  
> > +#include <asm-generic/unaligned.h>
> >  #include <cxl.h>
> > +#include <cxlmem.h>
> >  #include <linux/tracepoint.h>
> >  
> >  #define CXL_RAS_UC_CACHE_DATA_PARITY	BIT(0)
> > @@ -103,6 +105,124 @@ TRACE_EVENT(cxl_aer_correctable_error,
> >  	)
> >  );
> >  
> > +#include <linux/tracepoint.h>
> > +
> > +#define cxl_event_log_type_str(type)				\
> > +	__print_symbolic(type,					\
> > +		{ CXL_EVENT_TYPE_INFO, "Informational" },	\
> > +		{ CXL_EVENT_TYPE_WARN, "Warning" },		\
> > +		{ CXL_EVENT_TYPE_FAIL, "Failure" },		\
> > +		{ CXL_EVENT_TYPE_FATAL, "Fatal" })
> > +
> > +TRACE_EVENT(cxl_overflow,
> > +
> > +	TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
> > +		 struct cxl_get_event_payload *payload),
> > +
> > +	TP_ARGS(dev, log, payload),
> > +
> > +	TP_STRUCT__entry(
> > +		__string(dev_name, dev_name(dev))
> > +		__field(int, log)
> > +		__field(u64, first_ts)
> > +		__field(u64, last_ts)
> > +		__field(u16, count)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__assign_str(dev_name, dev_name(dev));
> > +		__entry->log = log;
> > +		__entry->count = le16_to_cpu(payload->overflow_err_count);
> > +		__entry->first_ts = le64_to_cpu(payload->first_overflow_timestamp);
> > +		__entry->last_ts = le64_to_cpu(payload->last_overflow_timestamp);
> > +	),
> > +
> > +	TP_printk("%s: EVENT LOG OVERFLOW log=%s : %u records from %llu to %llu",
> 
> The tracepoint is already called "cxl_overflow", seems redundant to also
> print "EVENT LOG OVERFLOW".

Fair enough.  Deleted.

> 
> > +		__get_str(dev_name), cxl_event_log_type_str(__entry->log),
> > +		__entry->count, __entry->first_ts, __entry->last_ts)
> > +
> > +);
> > +
> > +/*
> > + * Common Event Record Format
> > + * CXL 3.0 section 8.2.9.2.1; Table 8-42
> > + */
> > +#define CXL_EVENT_RECORD_FLAG_PERMANENT		BIT(2)
> > +#define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED	BIT(3)
> > +#define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
> > +#define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
> > +#define show_hdr_flags(flags)	__print_flags(flags, " | ",			   \
> > +	{ CXL_EVENT_RECORD_FLAG_PERMANENT,	"PERMANENT_CONDITION"		}, \
> > +	{ CXL_EVENT_RECORD_FLAG_MAINT_NEEDED,	"MAINTENANCE_NEEDED"		}, \
> > +	{ CXL_EVENT_RECORD_FLAG_PERF_DEGRADED,	"PERFORMANCE_DEGRADED"		}, \
> > +	{ CXL_EVENT_RECORD_FLAG_HW_REPLACE,	"HARDWARE_REPLACEMENT_NEEDED"	}  \
> 
> Nit, I know this does not matter for parsing since tooling will use the
> raw TP_STRUCT__entry fields, but why are these "CAPITAL_UNDERSCORE" and
> other symbols are just "Capitalized term"?

The conclusion before was that all 'flags' values should be all caps.  In
addition, because they are flags (vs the other symbols being enums) I used
underscores to allow for clear parsing of each flag within the field output.

> 
> > +)
> > +
> > +/*
> > + * Define macros for the common header of each CXL event.
> > + *
> > + * Tracepoints using these macros must do 3 things:
> > + *
> > + *	1) Add CXL_EVT_TP_entry to TP_STRUCT__entry
> > + *	2) Use CXL_EVT_TP_fast_assign within TP_fast_assign;
> > + *	   pass the dev, log, and CXL event header
> > + *	3) Use CXL_EVT_TP_printk() instead of TP_printk()
> > + *
> > + * See the generic_event tracepoint as an example.
> > + */
> > +#define CXL_EVT_TP_entry					\
> > +	__string(dev_name, dev_name(dev))			\
> > +	__field(int, log)					\
> > +	__field_struct(uuid_t, hdr_uuid)			\
> > +	__field(u32, hdr_flags)					\
> > +	__field(u16, hdr_handle)				\
> > +	__field(u16, hdr_related_handle)			\
> > +	__field(u64, hdr_timestamp)				\
> > +	__field(u8, hdr_length)					\
> > +	__field(u8, hdr_maint_op_class)
> > +
> > +#define CXL_EVT_TP_fast_assign(dev, l, hdr)					\
> > +	__assign_str(dev_name, dev_name(dev));					\
> > +	__entry->log = (l);							\
> > +	memcpy(&__entry->hdr_uuid, &(hdr).id, sizeof(uuid_t));			\
> > +	__entry->hdr_length = (hdr).length;					\
> > +	__entry->hdr_flags = get_unaligned_le24((hdr).flags);			\
> > +	__entry->hdr_handle = le16_to_cpu((hdr).handle);			\
> > +	__entry->hdr_related_handle = le16_to_cpu((hdr).related_handle);	\
> > +	__entry->hdr_timestamp = le64_to_cpu((hdr).timestamp);			\
> > +	__entry->hdr_maint_op_class = (hdr).maint_op_class
> > +
> > +#define CXL_EVT_TP_printk(fmt, ...) \
> > +	TP_printk("%s log=%s : time=%llu uuid=%pUb len=%d flags='%s' "		\
> > +		"handle=%x related_handle=%x maint_op_class=%u"			\
> > +		" : " fmt,							\
> > +		__get_str(dev_name), cxl_event_log_type_str(__entry->log),	\
> > +		__entry->hdr_timestamp, &__entry->hdr_uuid, __entry->hdr_length,\
> > +		show_hdr_flags(__entry->hdr_flags), __entry->hdr_handle,	\
> > +		__entry->hdr_related_handle, __entry->hdr_maint_op_class,	\
> > +		##__VA_ARGS__)
> > +
> > +TRACE_EVENT(cxl_generic_event,
> > +
> > +	TP_PROTO(const struct device *dev, enum cxl_event_log_type log,
> > +		 struct cxl_event_record_raw *rec),
> > +
> > +	TP_ARGS(dev, log, rec),
> > +
> > +	TP_STRUCT__entry(
> > +		CXL_EVT_TP_entry
> > +		__array(u8, data, CXL_EVENT_RECORD_DATA_LENGTH)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		CXL_EVT_TP_fast_assign(dev, log, rec->hdr);
> > +		memcpy(__entry->data, &rec->data, CXL_EVENT_RECORD_DATA_LENGTH);
> > +	),
> > +
> > +	CXL_EVT_TP_printk("%s",
> > +		__print_hex(__entry->data, CXL_EVENT_RECORD_DATA_LENGTH))
> > +);
> > +
> >  #endif /* _CXL_EVENTS_H */
> >  
> >  #define TRACE_INCLUDE_FILE trace
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index aa3af3bb73b2..5974d1082210 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -156,6 +156,18 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
> >  #define CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX 0x3
> >  #define CXLDEV_CAP_CAP_ID_MEMDEV 0x4000
> >  
> > +/* CXL 3.0 8.2.8.3.1 Event Status Register */
> > +#define CXLDEV_DEV_EVENT_STATUS_OFFSET		0x00
> > +#define CXLDEV_EVENT_STATUS_INFO		BIT(0)
> > +#define CXLDEV_EVENT_STATUS_WARN		BIT(1)
> > +#define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
> > +#define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> > +
> > +#define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
> > +				 CXLDEV_EVENT_STATUS_WARN |	\
> > +				 CXLDEV_EVENT_STATUS_FAIL |	\
> > +				 CXLDEV_EVENT_STATUS_FATAL)
> > +
> >  /* CXL 2.0 8.2.8.4 Mailbox Registers */
> >  #define CXLDEV_MBOX_CAPS_OFFSET 0x00
> >  #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index ab138004f644..dd9aa3dd738e 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -4,6 +4,7 @@
> >  #define __CXL_MEM_H__
> >  #include <uapi/linux/cxl_mem.h>
> >  #include <linux/cdev.h>
> > +#include <linux/uuid.h>
> >  #include "cxl.h"
> >  
> >  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> > @@ -193,6 +194,17 @@ struct cxl_endpoint_dvsec_info {
> >  	struct range dvsec_range[2];
> >  };
> >  
> > +/**
> > + * struct cxl_event_state - Event log driver state
> > + *
> > + * @event_buf: Buffer to receive event data
> > + * @event_log_lock: Serialize event_buf and log use
> > + */
> > +struct cxl_event_state {
> > +	struct cxl_get_event_payload *buf;
> > +	struct mutex log_lock;
> > +};
> > +
> >  /**
> >   * struct cxl_dev_state - The driver device state
> >   *
> > @@ -266,12 +278,16 @@ struct cxl_dev_state {
> >  
> >  	struct xarray doe_mbs;
> >  
> > +	struct cxl_event_state event;
> > +
> >  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> >  };
> >  
> >  enum cxl_opcode {
> >  	CXL_MBOX_OP_INVALID		= 0x0000,
> >  	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> > +	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
> > +	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
> >  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
> >  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> >  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
> > @@ -347,6 +363,73 @@ struct cxl_mbox_identify {
> >  	u8 qos_telemetry_caps;
> >  } __packed;
> >  
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
> > +		(sizeof(struct cxl_mbox_clear_event_payload) -		\
> > +		 (sizeof(__le16) * CXL_CLEAR_EVENT_MAX_HANDLES))) /	\
> > +		sizeof(__le16))
> > +
> >  struct cxl_mbox_get_partition_info {
> >  	__le64 active_volatile_cap;
> >  	__le64 active_persistent_cap;
> > @@ -441,6 +524,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
> >  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
> >  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> >  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> > +void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status);
> >  #ifdef CONFIG_CXL_SUSPEND
> >  void cxl_mem_active_inc(void);
> >  void cxl_mem_active_dec(void);
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 3a66aadb4df0..86c84611a168 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -417,8 +417,44 @@ static void disable_aer(void *pdev)
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
> > +static void cxl_mem_alloc_event_buf(struct cxl_dev_state *cxlds)
> > +{
> > +	struct cxl_get_event_payload *buf;
> > +
> > +	dev_dbg(cxlds->dev, "Allocating event buffer size %zu\n",
> > +		cxlds->payload_size);
> > +
> > +	buf = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> > +	if (WARN_ON_ONCE(!buf))
> 
> No, why is event init so special that it behaves differently than all
> the other init-time allocations this driver does?

Previous review agreed that a warn on once would be printed if this universal
buffer was not allocated.

> 
> > +		return;
> 
> return -ENOMEM;
> 
> > +
> > +	if (WARN_ON_ONCE(devm_add_action_or_reset(cxlds->dev,
> > +			 cxl_mem_free_event_buffer, buf)))
> > +		return;
> 
> ditto.

I'll change both of these with a dev_err() and bail during init.

> 
> > +
> > +	cxlds->event.buf = buf;
> > +}
> > +
> > +static void cxl_clear_event_logs(struct cxl_dev_state *cxlds)
> > +{
> > +	/* Force read and clear of all logs */
> > +	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> > +	/* Ensure prior partial reads are handled, by starting over again */
> 
> What partial reads? cxl_mem_get_event_records() reads every log until
> each returns an empty result. Any remaining events after this returns
> are events that fired during the retrieval.

Jonathan was concerned that something could read part of the log and because of
the statefullness of the log processing this reading of the log could start in
the beginning.  Perhaps from a previous driver unload while reading?

I guess I was also thinking the BIOS could leave things this way?  But I think
we should not be here if the BIOS was ever involved right?

> 
> So I do not think cxl_clear_event_logs() needs to exist, just call
> cxl_mem_get_event_records(CXLDEV_EVENT_STATUS_ALL) once and that's it.

That was my inclination but Jonathan's comments got me thinking I was wrong.

I'll change it back.

> 
> 
> > +	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> > +}
> > +
> >  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> > +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> >  	struct cxl_register_map map;
> >  	struct cxl_memdev *cxlmd;
> >  	struct cxl_dev_state *cxlds;
> > @@ -494,6 +530,12 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (IS_ERR(cxlmd))
> >  		return PTR_ERR(cxlmd);
> >  
> > +	if (host_bridge->native_cxl_error) {
> 
> Probably deserves a small comment about why this flag matters for event
> init. Something like: "When BIOS maintains CXL error reporting control,
> it will also reap event records. Only one agent can interface with the
> event mechanism."

Sure. Done.

> 
> > +		cxl_mem_alloc_event_buf(cxlds);
> > +		if (cxlds->event.buf)
> 
> No need for this conditional here since this whole block is skipped if
> !native_cxl_error and cxl_mem_alloc_event_buf() will fail driver load if
> it fails to init.

Done.

> 
> > +			cxl_clear_event_logs(cxlds);
> > +	}
> > +
> >  	if (cxlds->regs.ras) {
> >  		pci_enable_pcie_error_reporting(pdev);
> >  		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 1f81807492ef..7fe3752a204e 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -580,6 +580,7 @@ struct pci_host_bridge {
> >  	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
> >  	unsigned int	size_windows:1;		/* Enable root bus sizing */
> >  	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
> > +	unsigned int	native_cxl_error:1;	/* OS CXL Error reporting */
> 
> I would group this with the other native_ flags and copy the comment
> style "OS may use CXL RAS + Events", or somesuch.

Done.

Ira
