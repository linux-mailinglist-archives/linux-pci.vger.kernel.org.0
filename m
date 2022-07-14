Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F48575202
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 17:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239924AbiGNPiw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 11:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240048AbiGNPil (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 11:38:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0018DEE0C;
        Thu, 14 Jul 2022 08:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657813116; x=1689349116;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gAuPlcydZtDNMg5Yk4y4WDN6Vf7mWiB9ImcS5uKWzec=;
  b=EctEJtwuwPos6sQXGhCZtzGj+q+mPhzdDnTXf/G9Kdd3b8xMbAZRKbVL
   qRsdL2su158Xo6kiLOo3k6IAWpfyjP1YKXRDnoPaeroCP/8VvgHQMkiB+
   3hmq9alop+5GT1KxiVwy0/HLxstV/RR3DprH76SRU7/hNO67mOHK9+utC
   s8gKwwKxNPArjYsKypylZnCe4AHE4azrW4moA2ehlE4UOcyFRsHcUBwVK
   Tu+JhhJ4kgF7CxH+CWi8QXNRIqaRE54wg3yo2pnVgTkq71Gy4z1DpNDLf
   fYDC4Mns29RZHskWHUTesR/hgAXrKrHnBRmODWnU5C9syUPIiE1ChlkzZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="285569959"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="285569959"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 08:38:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="571139803"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2022 08:38:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 08:38:35 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 08:38:35 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 08:38:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 08:38:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNBtaXfNpPhzw760lOoSreqMVEWnnIp07VsvChtmrX78vsNwHUneXl9HiYoi7Yd2hTllXIkU3y9xy2jUXBrh3/YzF86dyIk4evSG63+Wx6Ybbji+WlURlHB/zjuLh9gR68laz7Pod7YTix0etE30AqsmfDRlWKspsJBiAE22d2AqPz6gHBIIhhYsjBzd8ip0DSH37AAnqpNLCVN8A8YPFx+O9tFsL8Mg5pnAFQW4mtAtmwasghhM6xO1vJj03dsGOrdkMIxx0Eq0IUkoH+foFe5hwpi/wNjjTrR7Ojui8pryUDI7LXzyZ0fH6eb52GWNw5S3zk+v08otOSyMnwLxXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6X80jVIu99nDurvuIsHGkfftyP4Nv90o5IIT44gXDBw=;
 b=BnjLRCuXTqQjHIXdR1DqqJMxW1iaoAAizfMJ+hjkequUqM/D/fGuBrXz/FG6HgfaWXhKEAIsGzq7wGl+IzHt/CJv7FErjNb6lVqdZ5XgfQThWNoWW60Q6fWi9oGcjrXvVK41aasD2hR87vYN3BBwBWBQyN/W9cEjDPxIxLA2QlDQ4J6MnIFY6gkTnFPcFJ/rV9ALDtGyCqNsW5xVJDixCQDKL/cbyZST23B3+BJQ8wpc9QeI6kBhdvjcdECpow/cj3PjC946MweW5iPoxE0yR/d0Mwynq/QssnIyzGCMN+G8AQYM9ELf89q1iZK8WP/xktVCwO8ks0Dt9qjpk2mhug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB5210.namprd11.prod.outlook.com
 (2603:10b6:806:fa::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Thu, 14 Jul
 2022 15:38:32 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.014; Thu, 14 Jul
 2022 15:38:32 +0000
Date:   Thu, 14 Jul 2022 08:38:29 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Ira Weiny <ira.weiny@intel.com>, Lukas Wunner <lukas@wunner.de>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V13 6/9] cxl/port: Read CDAT table
Message-ID: <62d0387522e5b_16fb9729432@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
 <20220705154932.2141021-7-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220705154932.2141021-7-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0PR13CA0127.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::12) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd94b7dc-3d4e-46c4-432c-08da65aee7f8
X-MS-TrafficTypeDiagnostic: SA2PR11MB5210:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ijrqfxVK//3AvWabtXNx7vgE7BZucGbvIzEMYw2gGIL2Xzirls0q6LLG7n91zouTPVBBnB5TJsdMCSiKbFH3obaiK65wtNarJE/H+Qc4x5hn9+MxULW67+NHIf0R4I01p3DKyZcRg0CWopJKO4+tUuxbQ+cZE8/m6DJ2Zl45RrqTePhTqe+CWAbyoqxpys5AtCu3EER6RUDDVK92TkJtO6eWi/iToVowFVcRMw/RmRN1mF09kUDIGiOjKSSFKIg9RncS1l7jadMT63MB3AhwlCWRYh+cZUsFyM0CD3iQwL2HXkrz+RQ+l5ReqbtsMoAo0XdwZ8uRDrP06Yqe8YrsX9DvjPyCgk8ZBkCLWext29BL23sIvdrQ5o0VgpSCgGxRiz38uFgFbytd0YGh+O+waO0pfhB6fyDCIWqxmpW0f/fGyF3sd3SCVY5ZYqjh+TvrskbI2E5eik2EqKQGRX1+9sFcZgVFIjMrev99I95PC6NMpNKfpmXl57mT5WK386FemUgSOlPXZxogRa3L1ubu/9Y4kJYu41TC5HN0GnBAzz8sGttWkm/v8PtsGDcwxFCkJduGNTWP1jV1f0qAjVlOaG3dBFkkn6tY0HVyNmHvjZf/rQ/OUKFAIccXoSZY5UnuBGrfGv0nEHGQZesPmwcH06Ge6ybOsxzszPtqgHLcI4aPZH8B41AkWe8Qkg5Y9hPdGQSAMplijM159eFOR8RzW51HzWvAzrMt5IGJKmbpTZ9poEFdn1uA1wK/c9y6RQ5u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(39860400002)(346002)(396003)(316002)(6666004)(83380400001)(8936002)(9686003)(26005)(6486002)(5660300002)(6506007)(86362001)(2906002)(478600001)(66476007)(41300700001)(186003)(30864003)(38100700002)(82960400001)(6512007)(8676002)(4326008)(66556008)(110136005)(66946007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QOwwithwK0MfRhDAILktCkxhrXQkpNbmQdRBqaXN5Rq5pST57GtMm1GPJMTc?=
 =?us-ascii?Q?Xss0w8BNjzWYRgmUR9cw5a7vn0HOkWbRbopN2T0+ukjSLL5VIBTJoBWDg2+k?=
 =?us-ascii?Q?91ToMll5dNUngsE091VrabRWJfhnQwfxGtuM4UdYMex6YtVVQSutj1tdxijf?=
 =?us-ascii?Q?EtavK5mF5IbW4xkxoHx9SZLBfjViScwe+sZfTjksIitWy+Yqf5MJUCUcnHNO?=
 =?us-ascii?Q?62tB36D0YGV+stvkoEtlwzqSm9/e0HwZqJ3VwLwNqhbnRm1hjKMPT7CNCga5?=
 =?us-ascii?Q?9fMv8l00ZSt9wrA1EdZ7afHJL+mY8MiMtv4Xo9q6BMHlJfDXuHtKKyyd/mlh?=
 =?us-ascii?Q?JKRJuIq6g3x87rmPYN/LnmhRs7Kp4WQm+Fb523Ncb8HzJ2UffbPq0rTzmQRg?=
 =?us-ascii?Q?t3K2oco7CwlNYMmLg37PnCJ0ng92Jj/ZMFpIzZqwXxQtacuZvluv3+qBN9Zw?=
 =?us-ascii?Q?8QW/KdOumt1JTohCo6uVcKD8enaG3gDLzORQfcFmPJ7u8v0pPcF22tx8ymBW?=
 =?us-ascii?Q?fn2Cus2y0LcIE1n4CepxZPLIleLdRzhEtUHS0T/JRXcge4fMQ/olZBmW4I90?=
 =?us-ascii?Q?200Rs99yUwPh7nMEEV+rirBWfWa1FNIr0cBxe1vn1YVTp8UVzS/TMg0aSptI?=
 =?us-ascii?Q?NDOiYInw1AQ7q2s0T7heTkp80Dl36zQ/2WZ7SgcBHrqF5Zh3efZYQzaXxYaX?=
 =?us-ascii?Q?i14o6tT8UwMcVINlA2eB7ShkylK+f0wIrPR1WAnOvQdaISbD8oX2Wzqr+U9m?=
 =?us-ascii?Q?+OlRqWR1M9msZ+Ts8CxG7i5Lae9hQyDtFimG5bDWl6ilYxJig3IJOiIlswzl?=
 =?us-ascii?Q?xZ9I6BT499SHBewn8dooYLY5v1AgH4/boGgwYaUNmgQPuXq0undwLiXJnEEV?=
 =?us-ascii?Q?cM3r15N4BMWTgYGNpWPvFXoykDspV5ewgnNEC1I7SK+ycRjDJddhhPQXt4Y1?=
 =?us-ascii?Q?rR8h0YtpeC9vBJUDPT5x+KEm94VftynQD7maIj8KBT203lxZCnxNSMbSOB/m?=
 =?us-ascii?Q?RQ+WLHp6dW3eMn8GvOhU1JQE+RNUF68nYiOI4ZKsJzsD7TBgyFobqWWauoap?=
 =?us-ascii?Q?t3jr81RSO0deWKsQcqgcU2aJp1zwES+k4rE/BPaiB1Y/BV9KTqx93dGQUfqP?=
 =?us-ascii?Q?/4uYlUVwwJffELhoPTUnUz+VTaSg0zFBBzx7QQhRRiRkorHqB6UOygv3KUo9?=
 =?us-ascii?Q?4qxH9FIFddskLLVb4eO8pXqAUVU2O4omzCqhs1yjWSfHXKsi4YmvUS8x85Ol?=
 =?us-ascii?Q?A8dA49iXthHfA59zWWDHJPMnpmPnEuvuupaPdMnxaHDxBL9pUr+Iz7JMqwoL?=
 =?us-ascii?Q?L994ozX3SrW3GS2aprKmQI0VuFpvMFjrkKheEk7aZkkwYtiV2QqJwb/xjs0T?=
 =?us-ascii?Q?I5gK70od+RbOxqR3Mq90dBJrsnX1s6n57cioVJdMiQZfG+UNbCWPE/lMArpB?=
 =?us-ascii?Q?WjX/ubwLZgtT8ZiOpdIHKH2QVW3T7ER1aUcKNK0MWHhI64FP3r36SVT4U+Mw?=
 =?us-ascii?Q?K3TXNplMYKWL0dImM3Kid6YohRpJlrreeSL1OIXKdbc2bth/nwm3rw8iBJpe?=
 =?us-ascii?Q?cH8yCLJ0vy/QHGBNchpnFke4nB9b9Jeqtiwz0Mfcg20X3TiMnvZtCLYMV/xV?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd94b7dc-3d4e-46c4-432c-08da65aee7f8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 15:38:31.9524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYj3KHM1kfjvOlIkVYbUmNnn03PZQyNR04vz+DQCENdfF2fKQT2eqyhIm9OEc+M9S5JpIHG5MTEX5slJbLDmcny/Osxl3W61SwdPv1gZi9s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5210
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ira.weiny@ wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The OS will need CDAT data from CXL devices to properly set up
> interleave sets.  Currently this is supported through a DOE mailbox
> which supports CDAT.
> 
> Search the DOE mailboxes available, query CDAT data, and cache the data
> for later parsing.
> 
> Provide a sysfs binary attribute to allow dumping of the CDAT.
> 
> Binary dumping is modeled on /sys/firmware/ACPI/tables/
> 
> The ability to dump this table will be very useful for emulation of real
> devices once they become available as QEMU CXL type 3 device emulation will
> be able to load this file in.
> 
> This does not support table updates at runtime. It will always provide
> whatever was there when first cached. Handling of table updates can be
> implemented later.
> 
> Finally create a complete list of CDAT defines within cdat.h for code
> wishing to decode the CDAT table.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V12:
> 	Fix checking for task.rv for errors
> 	Ensure no over run of non-DW aligned buffer length's
> 
> Changes from V11:
> 	Adjust for the use of DOE mailbox xarray
> 	Dan Williams:
> 		Remove unnecessary get/put device
> 		Use new BIN_ATTR_ADMIN_RO macro
> 		Flag that CDAT was supported
> 			If there is a read error then the CDAT sysfs
> 			will return a 0 length entry
> 
> Changes from V10:
> 	Ben Widawsky
> 		Failure to find CDAT should be a debug message not error
> 		Remove reference to cdat_mb from the port object
> 	Dropped [PATCH V10 5/9] cxl/port: Find a DOE mailbox which supports
> 		CDAT
> 		Iterate the mailboxes for the CDAT one each time.
> 	Define CXL_DOE_TABLE_ACCESS_LAST_ENTRY and add comment about
> 		it's use.
> 
> Changes from V9:
> 	Add debugging output
> 	Jonathan Cameron
> 		Move read_cdat to port probe by using dev_groups for the
> 		sysfs attributes.  This avoids issues with using devm
> 		before the driver is loaded while making sure the CDAT
> 		binary is available.
> 
> Changes from V8:
> 	Fix length print format
> 	Incorporate feedback from Jonathan
> 	Move all this to cxl_port which can help support switches when
> 	the time comes.
> 
> Changes from V6:
> 	Fix issue with devm use
> 		Move cached cdat data to cxl_dev_state
> 	Use new pci_doe_submit_task()
> 	Ensure the aux driver is locked while processing tasks
> 	Rebased on cxl-pending
> 
> Changes from V5:
> 	Add proper guards around cdat.h
> 	Split out finding the CDAT DOE mailbox
> 	Use cxl_cdat to group CDAT data together
> 	Adjust to use auxiliary_find_device() to find the DOE device
> 		which supplies the CDAT protocol.
> 	Rebased to latest
> 	Remove dev_dbg(length)
> 	Remove unneeded DOE Table access defines
> 	Move CXL_DOE_PROTOCOL_TABLE_ACCESS define into this patch where
> 		it is used
> 
> Changes from V4:
> 	Split this into it's own patch
> 	Rearchitect this such that the memdev driver calls into the DOE
> 	driver via the cxl_mem state object.  This allows CDAT data to
> 	come from any type of cxl_mem object not just PCI DOE.
> 	Rebase on new struct cxl_dev_state
> ---
>  drivers/cxl/cdat.h     | 100 ++++++++++++++++++++++++
>  drivers/cxl/core/pci.c | 170 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |   5 ++
>  drivers/cxl/cxlpci.h   |   1 +
>  drivers/cxl/port.c     |  51 +++++++++++++
>  5 files changed, 327 insertions(+)
>  create mode 100644 drivers/cxl/cdat.h

The bin_attr additions to CXL sysfs need to be added to
Documentation/ABI/testing/sysfs-bus-cxl.

> 
> diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
> new file mode 100644
> index 000000000000..c6a48ab326bf
> --- /dev/null
> +++ b/drivers/cxl/cdat.h
> @@ -0,0 +1,100 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __CXL_CDAT_H__
> +#define __CXL_CDAT_H__
> +
> +/*
> + * Coherent Device Attribute table (CDAT)
> + *
> + * Specification available from UEFI.org
> + *
> + * Whilst CDAT is defined as a single table, the access via DOE maiboxes is
> + * done one entry at a time, where the first entry is the header.
> + */
> +
> +#define CXL_DOE_TABLE_ACCESS_REQ_CODE		0x000000ff
> +#define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ	0
> +#define CXL_DOE_TABLE_ACCESS_TABLE_TYPE		0x0000ff00
> +#define   CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA	0
> +#define CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE	0xffff0000
> +#define CXL_DOE_TABLE_ACCESS_LAST_ENTRY		0xffff
> +
> +/*
> + * CDAT entries are little endian and are read from PCI config space which
> + * is also little endian.
> + * As such, on a big endian system these will have been reversed.
> + * This prevents us from making easy use of packed structures.
> + * Style form pci_regs.h
> + */
> +
> +#define CDAT_HEADER_LENGTH_DW 4
> +#define CDAT_HEADER_LENGTH_BYTES (CDAT_HEADER_LENGTH_DW * sizeof(u32))
> +#define CDAT_HEADER_DW0_LENGTH		0xffffffff
> +#define CDAT_HEADER_DW1_REVISION	0x000000ff
> +#define CDAT_HEADER_DW1_CHECKSUM	0x0000ff00
> +/* CDAT_HEADER_DW2_RESERVED	*/
> +#define CDAT_HEADER_DW3_SEQUENCE	0xffffffff
> +
> +/* All structures have a common first DW */
> +#define CDAT_STRUCTURE_DW0_TYPE		0x000000ff
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSMAS 0
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSLBIS 1
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSMSCIS 2
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSIS 3
> +#define   CDAT_STRUCTURE_DW0_TYPE_DSEMTS 4
> +#define   CDAT_STRUCTURE_DW0_TYPE_SSLBIS 5
> +
> +#define CDAT_STRUCTURE_DW0_LENGTH	0xffff0000
> +
> +/* Device Scoped Memory Affinity Structure */
> +#define CDAT_DSMAS_DW1_DSMAD_HANDLE	0x000000ff
> +#define CDAT_DSMAS_DW1_FLAGS		0x0000ff00
> +#define CDAT_DSMAS_DPA_OFFSET(entry) ((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_DSMAS_DPA_LEN(entry) ((u64)((entry)[5]) << 32 | (entry)[4])
> +#define CDAT_DSMAS_NON_VOLATILE(flags)  ((flags & 0x04) >> 2)
> +
> +/* Device Scoped Latency and Bandwidth Information Structure */
> +#define CDAT_DSLBIS_DW1_HANDLE		0x000000ff
> +#define CDAT_DSLBIS_DW1_FLAGS		0x0000ff00
> +#define CDAT_DSLBIS_DW1_DATA_TYPE	0x00ff0000
> +#define CDAT_DSLBIS_BASE_UNIT(entry) ((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_DSLBIS_DW4_ENTRY_0		0x0000ffff
> +#define CDAT_DSLBIS_DW4_ENTRY_1		0xffff0000
> +#define CDAT_DSLBIS_DW5_ENTRY_2		0x0000ffff
> +
> +/* Device Scoped Memory Side Cache Information Structure */
> +#define CDAT_DSMSCIS_DW1_HANDLE		0x000000ff
> +#define CDAT_DSMSCIS_MEMORY_SIDE_CACHE_SIZE(entry) \
> +	((u64)((entry)[3]) << 32 | (entry)[2])

This looks sketchy for 2 reasons, there is no type safety on @entry, so
it could be anything, and it is referenced twice which is a bug waiting
to happen if this or any of the other macros that copy this pattern pass
a statement argument with side-effects like:
CDAT_DSMSCIS_MEMORY_SIDE_CACHE_SIZE(entry++).

> +#define CDAT_DSMSCIS_DW4_MEMORY_SIDE_CACHE_ATTRS 0xffffffff
> +
> +/* Device Scoped Initiator Structure */
> +#define CDAT_DSIS_DW1_FLAGS		0x000000ff
> +#define CDAT_DSIS_DW1_HANDLE		0x0000ff00
> +
> +/* Device Scoped EFI Memory Type Structure */
> +#define CDAT_DSEMTS_DW1_HANDLE		0x000000ff
> +#define CDAT_DSEMTS_DW1_EFI_MEMORY_TYPE_ATTR	0x0000ff00
> +#define CDAT_DSEMTS_DPA_OFFSET(entry)	((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_DSEMTS_DPA_LENGTH(entry)	((u64)((entry)[5]) << 32 | (entry)[4])

More sketchy double array derefernces against an unspecified type. No
need to invent a new way to parse ACPI-like table data. CDAT parsing
should end up looking a lot like: drivers/acpi/numa/hmat.c. I.e. I would
expect the helpers in drivers/acpi/tables.c are repurposed to parse a
passed in CDAT data buffer rather than using acpi_get_table()
internally.

Lets drop patch 9 for now and all of these definitions. Leave all the
parsing to userspace via the bin_attr. Then we can circle back and build
up the CDAT parsing code when its ready to consume the data for QTG
assignment, and reuse the ACPI parsing code.

> +
> +/* Switch Scoped Latency and Bandwidth Information Structure */
> +#define CDAT_SSLBIS_DW1_DATA_TYPE	0x000000ff
> +#define CDAT_SSLBIS_BASE_UNIT(entry)	((u64)((entry)[3]) << 32 | (entry)[2])
> +#define CDAT_SSLBIS_ENTRY_PORT_X(entry, i) ((entry)[4 + (i) * 2] & 0x0000ffff)
> +#define CDAT_SSLBIS_ENTRY_PORT_Y(entry, i) (((entry)[4 + (i) * 2] & 0xffff0000) >> 16)
> +#define CDAT_SSLBIS_ENTRY_LAT_OR_BW(entry, i) ((entry)[4 + (i) * 2 + 1] & 0x0000ffff)

Yeah, all of these unused CDAT defintions can be deleted from this
patch.

> +
> +#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
> +
> +/**
> + * struct cxl_cdat - CXL CDAT data
> + *
> + * @table: cache of CDAT table
> + * @length: length of cached CDAT table
> + */
> +struct cxl_cdat {
> +	void *table;
> +	size_t length;
> +};
> +
> +#endif /* !__CXL_CDAT_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c4c99ff7b55e..9232b806d051 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -4,10 +4,12 @@
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/pci.h>
> +#include <linux/pci-doe.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
>  #include "core.h"
> +#include "cdat.h"
>  
>  /**
>   * DOC: cxl core pci
> @@ -458,3 +460,171 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
> +
> +static struct pci_doe_mb *find_cdat_mb(struct device *uport)

small naming nit, probably more places than this, but
s/find_cdat_mb/find_cdat_doe/ to make it clearly distinct from the
drivers/cxl/core/mbox.c infrastructure. I.e. I think "mailbox" is
implied by "doe".

> +{
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_dev_state *cxlds;
> +	unsigned long index;
> +	void *entry;
> +
> +	if (!is_cxl_memdev(uport))
> +		return NULL;

If this only supports endpoints just call this from the part of
cxl_port_probe() that does:

  	if (is_cxl_endpoint(port)) {
  		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
		...

...and let the person who adds CDAT support for switches refactor it
later. I.e. find_cdat_doe() can just take a @cxlmd arg directly. It's
enough that this patch located the cdat cached buffer on 'struct
cxl_port' and the 'CDAT' sysfs attribute under
/sys/bus/cxl/device/cxl_portX.

> +
> +	cxlmd = to_cxl_memdev(uport);
> +	cxlds = cxlmd->cxlds;
> +
> +	xa_for_each(&cxlds->doe_mbs, index, entry) {
> +		struct pci_doe_mb *cur = entry;
> +
> +		if (pci_doe_supports_prot(cur, PCI_DVSEC_VENDOR_ID_CXL,
> +					  CXL_DOE_PROTOCOL_TABLE_ACCESS))
> +			return cur;

This has me thinking the doe_mbs xarray is overkill if all the other
DOEs are just enumerated and then ignored. When / if more DOEs need to
be handled then we can think about instantiating all of them and keeping
them aruond.  Otherwise, just do this pci_doe_supports_prot() check in
cxl_pci and throw away the rest. Then cxlds would just carry a single
@cdat_doe attribute for this first use of DOE capabilities in the
kernel.

> +	}
> +
> +	return NULL;
> +}
> +
> +#define CDAT_DOE_REQ(entry_handle)					\
> +	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
> +		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
> +	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_TABLE_TYPE,			\
> +		    CXL_DOE_TABLE_ACCESS_TABLE_TYPE_CDATA) |		\
> +	 FIELD_PREP(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE, (entry_handle)))
> +
> +static void cxl_doe_task_complete(struct pci_doe_task *task)
> +{
> +	complete(task->private);
> +}
> +
> +static int cxl_cdat_get_length(struct device *dev,
> +			       struct pci_doe_mb *cdat_mb,
> +			       size_t *length)
> +{
> +	u32 cdat_request_pl = CDAT_DOE_REQ(0);
> +	u32 cdat_response_pl[32];
> +	DECLARE_COMPLETION_ONSTACK(c);
> +	struct pci_doe_task task = {
> +		.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
> +		.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> +		.request_pl = &cdat_request_pl,
> +		.request_pl_sz = sizeof(cdat_request_pl),
> +		.response_pl = cdat_response_pl,
> +		.response_pl_sz = sizeof(cdat_response_pl),
> +		.complete = cxl_doe_task_complete,
> +		.private = &c,
> +	};

I think this wants to be macro'ized to something like:

#define DECLARE_PCI_DOE_TASK(vid, type, req, rsp, priv)

> +	int rc;
> +
> +	rc = pci_doe_submit_task(cdat_mb, &task);
> +	if (rc < 0) {
> +		dev_err(dev, "DOE submit failed: %d", rc);
> +		return rc;
> +	}
> +	wait_for_completion(&c);
> +	if (task.rv < sizeof(u32))
> +		return -EIO;
> +
> +	*length = cdat_response_pl[1];
> +	dev_dbg(dev, "CDAT length %zu\n", *length);
> +
> +	return 0;
> +}
> +
> +static int cxl_cdat_read_table(struct device *dev,
> +			       struct pci_doe_mb *cdat_mb,
> +			       struct cxl_cdat *cdat)
> +{
> +	size_t length = cdat->length;
> +	u32 *data = cdat->table;
> +	int entry_handle = 0;
> +
> +	do {
> +		u32 cdat_request_pl = CDAT_DOE_REQ(entry_handle);
> +		u32 cdat_response_pl[32];
> +		DECLARE_COMPLETION_ONSTACK(c);
> +		struct pci_doe_task task = {
> +			.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,
> +			.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,
> +			.request_pl = &cdat_request_pl,
> +			.request_pl_sz = sizeof(cdat_request_pl),
> +			.response_pl = cdat_response_pl,
> +			.response_pl_sz = sizeof(cdat_response_pl),
> +			.complete = cxl_doe_task_complete,
> +			.private = &c,
> +		};
> +		size_t entry_dw;
> +		u32 *entry;
> +		int rc;
> +
> +		rc = pci_doe_submit_task(cdat_mb, &task);
> +		if (rc < 0) {
> +			dev_err(dev, "DOE submit failed: %d", rc);
> +			return rc;
> +		}
> +		wait_for_completion(&c);
> +		/* 1 DW header + 1 DW data min */
> +		if (task.rv < (2 * sizeof(u32)))
> +			return -EIO;
> +
> +		/* Get the CXL table access header entry handle */
> +		entry_handle = FIELD_GET(CXL_DOE_TABLE_ACCESS_ENTRY_HANDLE,
> +					 cdat_response_pl[0]);
> +		entry = cdat_response_pl + 1;
> +		entry_dw = task.rv / sizeof(u32);
> +		/* Skip Header */
> +		entry_dw -= 1;
> +		entry_dw = min(length / sizeof(u32), entry_dw);
> +		/* Prevent length < 1 DW from causing a buffer overflow */
> +		if (entry_dw) {
> +			memcpy(data, entry, entry_dw * sizeof(u32));
> +			length -= entry_dw * sizeof(u32);
> +			data += entry_dw;
> +		}
> +	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
> +
> +	return 0;
> +}
> +
> +/**
> + * read_cdat_data - Read the CDAT data on this port
> + * @port: Port to read data from
> + *
> + * This call will sleep waiting for responses from the DOE mailbox.
> + */
> +void read_cdat_data(struct cxl_port *port)
> +{
> +	static struct pci_doe_mb *cdat_mb;
> +	struct device *dev = &port->dev;
> +	struct device *uport = port->uport;
> +	size_t cdat_length;
> +	int rc;
> +
> +	cdat_mb = find_cdat_mb(uport);
> +	if (!cdat_mb) {
> +		dev_dbg(dev, "No CDAT mailbox\n");
> +		return;
> +	}
> +
> +	port->cdat_sup = true;
> +
> +	if (cxl_cdat_get_length(dev, cdat_mb, &cdat_length)) {
> +		dev_dbg(dev, "No CDAT length\n");
> +		return;
> +	}
> +
> +	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
> +	if (!port->cdat.table)
> +		return;
> +
> +	port->cdat.length = cdat_length;
> +	rc = cxl_cdat_read_table(dev, cdat_mb, &port->cdat);
> +	if (rc) {
> +		/* Don't leave table data allocated on error */
> +		devm_kfree(dev, port->cdat.table);
> +		port->cdat.table = NULL;
> +		port->cdat.length = 0;
> +		dev_err(dev, "CDAT data read error\n");
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 140dc3278cde..9a08379000a0 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -8,6 +8,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/io.h>
> +#include "cdat.h"
>  
>  /**
>   * DOC: cxl objects
> @@ -267,6 +268,8 @@ struct cxl_nvdimm {
>   * @component_reg_phys: component register capability base address (optional)
>   * @dead: last ep has been removed, force port re-creation
>   * @depth: How deep this port is relative to the root. depth 0 is the root.
> + * @cdat: Cached CDAT data
> + * @cdat_sup: Is CDAT supported

That does not provide more information than the member name, how about?

"should a CDAT attribute be published in sysfs"

>   */
>  struct cxl_port {
>  	struct device dev;
> @@ -278,6 +281,8 @@ struct cxl_port {
>  	resource_size_t component_reg_phys;
>  	bool dead;
>  	unsigned int depth;
> +	struct cxl_cdat cdat;
> +	bool cdat_sup;

Just spell out "supported", no need to save characters on this used once
attribute.

>  };
>  
>  /**
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index fce1c11729c2..eec597dbe763 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -74,4 +74,5 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
> +void read_cdat_data(struct cxl_port *port);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 3cf308f114c4..1ec34a159657 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -49,6 +49,9 @@ static int cxl_port_probe(struct device *dev)
>  	if (IS_ERR(cxlhdm))
>  		return PTR_ERR(cxlhdm);
>  
> +	/* Cache the data early to ensure is_visible() works */
> +	read_cdat_data(port);
> +
>  	if (is_cxl_endpoint(port)) {
>  		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
>  		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> @@ -78,10 +81,58 @@ static int cxl_port_probe(struct device *dev)
>  	return 0;
>  }
>  
> +static ssize_t cdat_read(struct file *filp, struct kobject *kobj,
> +			 struct bin_attribute *bin_attr, char *buf,
> +			 loff_t offset, size_t count)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_port *port = to_cxl_port(dev);

Just for completeness you can have an:

    if (!port->cdat_supported)
	return -ENXIO;

...to document expectations / backstop the is_bin_visible().

> +
> +	if (!port->cdat.table)
> +		return 0;
> +
> +	return memory_read_from_buffer(buf, count, &offset,
> +				       port->cdat.table,
> +				       port->cdat.length);
> +}
> +
> +static BIN_ATTR_ADMIN_RO(cdat, 0);
> +
> +static umode_t cxl_port_bin_attr_is_visible(struct kobject *kobj,
> +					      struct bin_attribute *attr, int i)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_port *port = to_cxl_port(dev);
> +
> +	if ((attr == &bin_attr_cdat) && port->cdat_sup)
> +		return attr->attr.mode;
> +
> +	return 0;
> +}
> +
> +static struct bin_attribute *cxl_cdat_bin_attributes[] = {
> +	&bin_attr_cdat,
> +	NULL,
> +};
> +
> +static struct attribute_group cxl_cdat_attribute_group = {
> +	.name = "CDAT",
> +	.bin_attrs = cxl_cdat_bin_attributes,
> +	.is_bin_visible = cxl_port_bin_attr_is_visible,
> +};
> +
> +static const struct attribute_group *cxl_port_attribute_groups[] = {
> +	&cxl_cdat_attribute_group,
> +	NULL,
> +};
> +
>  static struct cxl_driver cxl_port_driver = {
>  	.name = "cxl_port",
>  	.probe = cxl_port_probe,
>  	.id = CXL_DEVICE_PORT,
> +	.drv = {
> +		.dev_groups = cxl_port_attribute_groups,
> +	},
>  };
>  
>  module_cxl_driver(cxl_port_driver);
> -- 
> 2.35.3
> 


