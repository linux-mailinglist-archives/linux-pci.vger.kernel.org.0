Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81040578FC9
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 03:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbiGSBTx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jul 2022 21:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiGSBTw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jul 2022 21:19:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73D7B4AA;
        Mon, 18 Jul 2022 18:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658193591; x=1689729591;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0HkuR2HHu490pHaWgshxeDw/QSlELlhZn1IQq7UmjHY=;
  b=NJgw7O/E6O/zwNK9ehEruyz1GUTTAeqYBfLpZKT6FcPXlKo43AMZNZ6t
   R71geGf1soN87IR9NoGCnMo8Guvkqs7PToWyAWr3U2sm6FPm4YlUp5Oku
   kDBn0ybo5Te0oFfxm+arBLk5H1yAi5wtqmZgkjMNDdklmO8cgiLD1FYjK
   P5HONB9Ggrpv9O6/HsRP1npmBwYMYfj8Cyqfk4ZbJRZxZomfNy2REykG/
   upj9ZVRDcbvUMZxRE3QIHJyBsTCbD32FjqnJJgw4esI/KnS40syrFy+LG
   l/wpYsmWnF9oAsei1WsY2/Sfvt0CvEUOnyJ7OUn0YMSdMno1lJqUgJQ6o
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="269382375"
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="269382375"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 18:19:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,282,1650956400"; 
   d="scan'208";a="773942203"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga005.jf.intel.com with ESMTP; 18 Jul 2022 18:19:50 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Jul 2022 18:19:50 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Jul 2022 18:19:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 18 Jul 2022 18:19:49 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 18 Jul 2022 18:19:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvZDQ6qinU2m3vihgp3fUA4GRp9SkVXYa28Epn43Mc1tgiTSp1CYzDokhjjFU2efO39jDKO4mSs6E/FHVVvTcPKMu7UiYsLPNcmKb7DBamGHTNUZTAiIN6NOi4O0gzvjx1pvI12LL1eEbn/wD3u4SdvM3Ia6KS18fvnDL+dZmRswHya/e3xMvoce342tFlS9MynPPKfFJVSUNE4qs/j+2bNcs9afiFowun8KdP2y18JTmaKwfZOPEn+wwi0NU8ayrlhNf5G539NPGBn+GHkfEwDPcnn6JRcgybUyReXXVceuaTeo859z6VPYGf83FIUTQ/ZmQVhVx9KsgczksuM60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpDpuDWLq4b7yWZciYq4zdSOCZV82M+b7FAnskCxHH4=;
 b=HNlfgo327wmsXLZnOgSB+xhvt+h24uXEnwP0IRBqC6GQOENFAydO+UPqorWrMJkOOXoKGOao+yrEGzK2CFzen/XlT4ZfSFklzS44KX9nykvg6mBsoCdtTLqQdvbiDtPyFEW8Ifjs5uXGTarneqLQmCkgsIuGPafWueoSh8arcjy43BG+qv9/JSPhsGCuHo8Wn09rxZ9On5AbG/J6GID705eUaNZNvXnxUIHIU0t/ZVghe4YCB7eIXWflo0ZD9S+3RHZNEFQOFWToLnCfbF8yx7NbnMV1IQ3OlQ+sCcQWcT71oVTs1Ihcpw6Rt4AM94rlEVfm4ZeOSEeVEGFXaZjXOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CY4PR1101MB2311.namprd11.prod.outlook.com
 (2603:10b6:910:23::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Tue, 19 Jul
 2022 01:19:47 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.023; Tue, 19 Jul
 2022 01:19:47 +0000
Date:   Mon, 18 Jul 2022 18:19:45 -0700
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
Subject: RE: [PATCH V14 6/7] cxl/port: Read CDAT table
Message-ID: <62d606b0f0a9c_97b64294d9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220715030424.462963-1-ira.weiny@intel.com>
 <20220715030424.462963-7-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220715030424.462963-7-ira.weiny@intel.com>
X-ClientProxiedBy: BY5PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::28) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 018df670-3ed1-407a-3767-08da6924c523
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2311:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISbz0PBNOtTzXBxtHETTYVEwL+dO8JJu8lyyx+uLB21Lj+wnE1BdGMzkZdH6vrE7b3Op8bPktWaGQJZ9Xvc31JFON95zLilCbjl0gNxwdjkal0SheA1N/u3b7R4yECpDGWQmpa2cSVlxAcOvR7FpAYuPR7z6VRW809Yc6y/3IDKZ3wfFbEqofD/5psxi6vq0iBeNUoUvLdnNCe0FzFCDhUpTuGmwf8R8+dx7bip4vIGUlwsQOnpLgLAYIi+WaQo6tlXUhf4e7F1W+pZ55QG8RDFIz8LloKNVssWzI3w6+Qwxh7MC8JpVYVQr9RxR40z3WL0H9pPzDjXuWKGwz0Y37jHETRcTMjIZKMl3H5nnHgeQgYKTPlt3gfuYoY4Ft2PMKHxtAgKwgh1M6Q1c4y96qMXAgn38RRfdRcGcbyssxr6o9wTCfi5uTWfF/5yQwNr/voGoCYDsLdaVkW2+OuQ3brwbfEOCNgevpr/HEA2kVTgMGKY9t9sq9SXJJHY/SDVEIpfbgspapSpBVyg8rddpto8lBV//aT8C35wPFR+LnCWtt3wuo2221UqYaJ1dTS45yAXdadHTMMl0cGhrfNotOIxRYIetY3gh+K+0/faNlV1995TBAkEUlFWLNpaAbOEmlILfk2f/yv+aH2RNKrP5pc67zcywcD4If1hhv+Z++IYb/sMV906UKnKANOm7VO2EZqxlqI5MM4pVAJFK5fzZ/fQDMxs+bQWF5v9rrNtz3DBqy4c5A78F8TNfIX5/w6mD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(396003)(346002)(136003)(8936002)(86362001)(66946007)(8676002)(4326008)(66476007)(66556008)(38100700002)(110136005)(6506007)(54906003)(316002)(82960400001)(9686003)(41300700001)(26005)(186003)(83380400001)(478600001)(5660300002)(6486002)(2906002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ItCKcNk6WhIcF6s/M2CyMYK8ifqLAPlVWj0mibjMq1GJlskk89eIjLmyw3nt?=
 =?us-ascii?Q?u+EtowBkRbAnB37NuPiOXVJIp/0cdNEaMZhsNeT3sEcn4o0TkTxhVFg0/uOK?=
 =?us-ascii?Q?LzVps4eBaHXMAjHizFNbSvGMIj7V4i2Ct46UQ47vusawplNYaf13WScfZTZQ?=
 =?us-ascii?Q?j6xDuOqKy3Q09eVZZNbE++Q7Y6zHtgl1QWvAkrrbbs3ZVwN2RnI3OweyApFB?=
 =?us-ascii?Q?BE1UKwpFqxipIXk3guixdBGts/BcZPcbSLiRA0luErzLRZBCRlL5IS5BOcKP?=
 =?us-ascii?Q?ezKZHxBJ2+ApyAVEQ44LjgCzhP32LfF+0GaGV0pAbHRZTD42a1XLgC7BFP7N?=
 =?us-ascii?Q?wKEdFIWMOffFHcX8o9akGasc961pwOqSL+nEyNkC0nNiydyYCeo1QbhoK07p?=
 =?us-ascii?Q?7SzeLrpAzZAaoxGhrZi300iOcs9soLOr5CG4SYEqDLO/a0kmIniOGjUmVMNq?=
 =?us-ascii?Q?4/OVnzkhUk7gAR5G1tobLE4PktFgkF4hCzCvaloqi82AA/kOHBnVU2sOr3a+?=
 =?us-ascii?Q?CY4byaERdE5A41ZxqQGz2lR8vwCO+xLyimMh5ZOjRFwvGK6dS7ZdCN2SeaSL?=
 =?us-ascii?Q?it1ETnKpedMaSpp5GViW8X0J9EmfbDAngNf7qAgA4qqsjmiwzkbnjbfZoo3a?=
 =?us-ascii?Q?fZshHTaoPPdSKaPOv9jzE3PRPIrJUrsEhni829/KPlZP7s9Oo+Hmyze89yre?=
 =?us-ascii?Q?sf9aP31rYVZsxMRqmDpopKYtAphQ22kh75CE+lFHWadoNAfQ3T4PWyZxo2Yc?=
 =?us-ascii?Q?/Cdi/WLIKCkr72bUlsUFVApH2R1CWX5gmroDQgHighjcuwgqZoVX7hvVdwny?=
 =?us-ascii?Q?G6lgu1t09t5vHrgQkQ+yBDhX86lFDkP38BSrYXgwr7CC+o73kk8nhxGrmccU?=
 =?us-ascii?Q?uk4BSPt3zBcvhHFrN5uLv44CtFn44NEfSaMKFwmRo1ykgC4rARCe1770i7lJ?=
 =?us-ascii?Q?NC8vBFazhv8rBO40LD0wycWFnJKGRCmfn5idqyx5uDXzpcS7/uGIoz3GfhRF?=
 =?us-ascii?Q?F1llgGGqzy1OEIYfnnzOlv6QiFiu1T+0pvoJAuLLtrKi7rcJS1arTbn9T4x0?=
 =?us-ascii?Q?uZ9jhgZzoFlM5DssyN1jLeIKeQOomI48dPC0sTQFzFBC/ERZ4/AuComrUDlp?=
 =?us-ascii?Q?tHVovTpG9w6rXuebx5KoWh67LwHfFTY1FRZZsM4z+qBy0+TqtPch5xLj4G5h?=
 =?us-ascii?Q?FfAvRo1cvBDS5xQzOvUlNkzoffsTq50CY/5aHUnLMVrJjYoC/6lFdMCiLbzL?=
 =?us-ascii?Q?sA//S0CnzffjySIJa7IzHS7kh+kI0YVp+KCizjn8SeSNRJ4wHVoWxEv4fdn9?=
 =?us-ascii?Q?1t7cT2FAF3eS0rrcU5NX31sTT7kuT9BWyoa2JJG8wrychmHfRjJiixKBM/Hr?=
 =?us-ascii?Q?b2XDBYT28RB1zsE3Ccxzlp5z0d09ZuaXSe4FAttpLq7Z/Sig0ExWtZYq6DJD?=
 =?us-ascii?Q?oQMuspeeJ+7noWnjEPCBa/A1eijqlHK8IZLXEYtHUUHNFYW21+RLNhRPzEHP?=
 =?us-ascii?Q?fGUD7JcvcNatGNfD30XrKsh9KW7coMxay/jTbMLBQGw3/Fnajyo71uUxuKPL?=
 =?us-ascii?Q?xvYZwaIJTTtmWbxCLgyA5pXMYDxTvVj2XLNDFuNhGEPpehYFCEGOlU3w2ILJ?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 018df670-3ed1-407a-3767-08da6924c523
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 01:19:47.4755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abx7i98XzCdjxLPlOaOEKx+0qzBFHAR5iw05gmsn/Xa3hUIlW6l+86RnrB52m9LFEpz1NatIWaN7ppL2Wi712xiQS73fg5wbtv0nkOO7QmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2311
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
> Changes from V13:
> 	Dan:
> 		Add entry in Documentation/ABI/testing/sysfs-bus-cxl
> 		Remove table parsing defines.
> 		s/cdat_sup/cdat_available
> 		s/cdat_mb/cdat_doe/
> 		Don't check endpoint in find_cdat_doe()
> 		Create CDAT_DOE_TASK macro
> 
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
>  Documentation/ABI/testing/sysfs-bus-cxl |  10 ++
>  drivers/cxl/cdat.h                      |  61 +++++++++
>  drivers/cxl/core/pci.c                  | 169 ++++++++++++++++++++++++
>  drivers/cxl/cxl.h                       |   5 +
>  drivers/cxl/cxlpci.h                    |   1 +
>  drivers/cxl/port.c                      |  54 ++++++++
>  6 files changed, 300 insertions(+)
>  create mode 100644 drivers/cxl/cdat.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 1fd5984b6158..6fb6459466f8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -164,3 +164,13 @@ Description:
>  		expander memory (type-3). The 'target_type' attribute indicates
>  		the current setting which may dynamically change based on what
>  		memory regions are activated in this decode hierarchy.
> +
> +What:		/sys/bus/cxl/devices/endpointX/CDAT/cdat
> +Date:		July, 2022
> +KernelVersion:	v5.19
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) If this sysfs entry is not present no DOE mailbox was
> +		found to support CDAT data.  If it is present and the length of
> +		the data is 0 reading the CDAT data failed.  Otherwise the CDAT
> +		data is reported.
> diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
> new file mode 100644
> index 000000000000..67010717ffca
> --- /dev/null
> +++ b/drivers/cxl/cdat.h
> @@ -0,0 +1,61 @@
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

I do not get this... the PCI ops on big endian machines are already
handling the fact that PCI config space is in le-order. So you should be
able to use data structure definitions directly just like any other PCI
config data payload.

I dropped this along with the other revisions I spotted for this patch.

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

Dropped these too since they are unused.
