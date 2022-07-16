Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0434B576B73
	for <lists+linux-pci@lfdr.de>; Sat, 16 Jul 2022 05:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiGPD1L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 23:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGPD1K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 23:27:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9B8709AB;
        Fri, 15 Jul 2022 20:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657942028; x=1689478028;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ycaxM5Ky+y0cS59B6B0DABpegEM78vc9O2RIB+J59cY=;
  b=ew8v38YlPtdzbkRm/FLTdcuxbTZDpXJxrBAW4mwvmvWiON1PU4/AtTdI
   HdCAPV8ExvCp0ma4NmlAodhD4JyuUYtoPz7sCqCsWH/69feprWtMds94T
   5L3clahOkvJyxO5vac/b5Ca8wH+b2RficOns0aE1sC3ZyECgjgBD1eyHu
   5Fd87a7igEMyxtd+W9eVxy61Z5m5M5McONyjzhDfr803/sLTRoDk0Yx5J
   WO/snVy9V9YPzhghhh+7sbAQoHpuredHxTufcNdKHQYeAQIHVLvXh1z2j
   AoWz2b5GoXr/XDAzctYDxnRipJ/eV+9P1uc/ldqFa7rD61V7qki0dt5uE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="265730428"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="265730428"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 20:27:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="629331438"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 15 Jul 2022 20:27:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 15 Jul 2022 20:27:06 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 15 Jul 2022 20:27:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 15 Jul 2022 20:27:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhN5kQL5wc5ZpEUJXXgbV4WvQwNA3182NufK+yBr5bMySlk37gfVajCpw7sMLcv9VCP2Bo4seTpgC1qPal5SQpBqAmKWhEMHfdPb3Hw1M50oiE3QgaPGkhVCaodb6KuWBXio5ncqlB0eRG0ugcddwun35vGFiz5lDIaWXl9u+sqNY6Vlf0HmAffZ9oZE11FV0RFz7MF+Pm4JeORrEuVXn4evo6Eg8ttsNkTXypR28OodbOglyfgDEp9cCtf2iCPCaOR9oyE/KyeUQqJWgFoTGY0lr1dAmskO6Wrrj+PaJInNn/AWbL3R0M0ZZlj7JzWNLJ2AKgoqotu+h6tK9BYj4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojUMuo3TndTPiBJT2rjwBLWLJIchdr9lWySaEizmuK4=;
 b=mTF9v/hiy+dCbO2vc7NDIOyAJKKA6ZOKe/p6x9xUXIPJnPx/j2v5Y/o1e0iKicEph2BDKhJ+yKGDGw5qMUfX7/+AnBoWVrcp8rPkc/PiV9toVCl4AkK5My5jSR9cH52KSCQuOwWcYX0XSJjAw3BctV2xeGVQ2VVBU/gYaPwYS8a4lUSgzDChwHth1u/tDu/SnVUg3WalZqP+dljNyyFbEAY+zwbHYX70852Y1iUnmIEku0W2RiJ8GpE1UMFlo/Miii8Jewm2N0nQua2K5D7HodjObe8wYLjOBN4e5Vg+PBTUD161ui8nw7PcuN1A4ovde6C/TyJ/7ZKxC5qJQqX/nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MWHPR1101MB2333.namprd11.prod.outlook.com
 (2603:10b6:300:70::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sat, 16 Jul
 2022 03:27:04 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5438.018; Sat, 16 Jul
 2022 03:27:04 +0000
Date:   Fri, 15 Jul 2022 20:27:02 -0700
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
Message-ID: <62d2300621b42_242d294dc@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220715030424.462963-1-ira.weiny@intel.com>
 <20220715030424.462963-7-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220715030424.462963-7-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::17) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd38b57d-9910-432a-ad1f-08da66db0de8
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2333:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XT0lh+0WjkY8ab94q9a/qEKPY6x0U+jFK9RluZMvCcgSNYLG5JRlTa/LfZWsAICwlGSbRg0H0ZplBKLuJTOZmBGZxDoMlLZyKSfxjNd6440pRXyXgurZ2Je16Q9GrIBXetSvBUiDW8juvfiZSHxnVh9tSTzJRsk58wl3GQdZSMe0PQ9/pVtQeGEzSjmQTrActpjdcbTc8QIJ/W6JbTO+6Ke78mWWJvkECPs8/83EgmujnTDFJ2IDHfqX4l5SfUo5Tat1IZVNCfs1LVFSSjDDLgEu/hjWZ3DXYFUzMF3trQyY30qA/EMaacJ4mEscSQlKXfPLkVZiBNZ7xbHBat4qjE8xyp/mkbf0p17posauyfK2vkkNf5SFGEFwtIJzniY2mNF5AI80tOq3+aY3MMJyTCQWFH4L5d4i6NQEB36I8rFtwTKgpGhPtr1EfEIlnnMjTgmJEJFlLGKu8ROmP9D6dht7RJKKCAhzMiupUkr0TlqZ1uGdz3vlD/CVpOClMuvNgmq2kZ5vgMNcuK51xbgEBDTP5fAMlAJD1fn+L5tVn6rovc3ipeLIUiGanTJug/HXqqd6oXbDlCZBzRKxqc2IKhGwsPyhjakgq0kR2/5KF9UaukvqTK5ol2CODwEMNSYTxOmE20QhTrgHvVVBgniMnw7DyZUGuEcei9RzwWq50Tpr5QtKqavJgSZhSpM1DzL3GPpNEvwb/SiXUbwFXKJQudtwYlM/k//0Y2IkFX8O560tr4ftnlCS8eI2fe40zdJrnylmGWq/cD3+KGDXK+pUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(136003)(346002)(396003)(30864003)(5660300002)(8936002)(8676002)(66556008)(316002)(54906003)(110136005)(66946007)(66476007)(2906002)(86362001)(41300700001)(4326008)(38100700002)(26005)(9686003)(478600001)(6486002)(6512007)(186003)(83380400001)(82960400001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tfBH7vXlJxeoSIbe4QdLPg2SclqXrBkVZFyCx2v+yB/UX1xKL2F/U1pPGuKy?=
 =?us-ascii?Q?YP1CsN21H+HNeaN0jKq1SQuJHfwjqAdCUiSSzprubyaKhSYntMg7uM3O87lB?=
 =?us-ascii?Q?LPri6lGWC8ySjt8gClI8taYxQZ4n3+A9ASyfhruBskLkfbmonqPWu4KOq1/r?=
 =?us-ascii?Q?COm3KfbKadUAk8OKUeSNEMaekaPConjhrYtzMzTcC0SsKuFHZsusOfVEdj2n?=
 =?us-ascii?Q?RRsfth6V/UgAfG2jeAG2gUN/p8pI2gBWn+BJ20bSOR/r3UMGhoxk2+M0745u?=
 =?us-ascii?Q?OKFvRV1FjFaWoEZpd/5AemKFlk8+a9R2WRae6Ige9uPnW1lJLWs5UJZJK3f4?=
 =?us-ascii?Q?EBKf0X9VgEVsZ+O0tn5v3YhrNurbqRc2UVRF2it1s5hDVxMtqn5w0Nn64MKR?=
 =?us-ascii?Q?mKdtpuLN6kAwt6vO1Fb5LpWC+RiIkj/He3aAUPBmUKZ9kOHaHcxcfCigPc28?=
 =?us-ascii?Q?MQ7yqmRpe+jujbceQZiwdJl1AGPKu00yprHagBFeZBuEpquV4+qj5vUR3mTL?=
 =?us-ascii?Q?tLsbVLgg3DpAD23Oa9SDOZzfxndm3l4Pll1ZLUXmDBjVkr/xIQ6BSzG5uls6?=
 =?us-ascii?Q?61RYN6iiVLBVBRdQqmuZKSo/NYz5GERgzCIseOmJtU3Zu3RA+Dq24nmfCs5n?=
 =?us-ascii?Q?Hf6jN5Xl/JCpPDhKDJ5bzuILJyLdmpQ6y46vCtxekDbLfvo0TmKGpEokpqux?=
 =?us-ascii?Q?H7A03OuoSOOomvJPh29TFrR3722wFqisWm1gnTVYr5IbuIQdmCgqBXSGU5Kt?=
 =?us-ascii?Q?e6qofBuNd33iFpLJXoSt3WekAPuhPl9ezn8VVt+kPqEbonbNMwa5ONKDDuAN?=
 =?us-ascii?Q?hx/l5d/rzALPNlJmLMsRcB64a9z9CbM62rnhYtM8Mcy9J0RaUoFqeEbZO2T8?=
 =?us-ascii?Q?hE11sHvgvAgchC8kqQHqxC+oizQOlj2T+kmmbKZ5dCBwWJDAnc6Tp/lHXunM?=
 =?us-ascii?Q?1dxm6IBAIvmIlVEH+41EEBRThC1pFdBMJSkprK3pNuKpEtEQmOLwTyZtESG8?=
 =?us-ascii?Q?CtVd696KzW6gVYQdSyClB3Q0CN3Jx4mMU/KokTNBlk1HJgKsLsiiqAEq6kXs?=
 =?us-ascii?Q?sODZeQ2r/iL7IxfzFVWcKYXUgCHmuToTuf6hKKy9rVPuEZNunOQ88R+bRoqj?=
 =?us-ascii?Q?2DC7ytSKunN+dgZ1IMGxCU487gXHsj/657xThs0q0joS61iEEybvzgG6bl8e?=
 =?us-ascii?Q?geYgNRz9lgcgcysRMkp5SXnDkH+OvqcUZNYTobLvXW6hQU5CazjNS69RPwL1?=
 =?us-ascii?Q?Hk4X+RH2YS8Nce64kRiOBjzgaN+LNoQOrrSSwtKa6ohG4pTq5nhx+oDehzhw?=
 =?us-ascii?Q?KCmukqd0jV2uq9vfuYqBDfa+F/soAXgZ8kkHQWAzPn6vw+F37EkXHDj4mov4?=
 =?us-ascii?Q?8tq6/hssz/JASpQZi58WBZpw98KKTiu7bZYGoH+Q3RJt1J72Q8vPSv1rTN/u?=
 =?us-ascii?Q?ymolk9kxnB+bGNC9XxoyB1LYs9t+afbUwsj3jh9NMZsG38mVFFhJWIXWHOhE?=
 =?us-ascii?Q?KvvVIEHYd2YRMB09b/8uYGOyQkZdLN0lB7ujqHpZr/U+sWbNHp83cvSENRHD?=
 =?us-ascii?Q?d36gW9OLMNhKxXnUxopGSR/WFQLihyLlIpsX6XDi1bJuCB40oFQqflaYqA3A?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd38b57d-9910-432a-ad1f-08da66db0de8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2022 03:27:04.6069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pxq4k17I5n0tPErLa81dvJa9u6QCBWiKp2XYSzXOeeTXeZMohBC6k7Hf4QAudeA+DxdNJvGwUHXNpk/5/1OU+jE8I7khJMRtqIl+k3oq+hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2333
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
> index 7672789c3225..dd5d1da412ca 100644
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
> @@ -452,3 +454,170 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
> +
> +static struct pci_doe_mb *find_cdat_doe(struct device *uport)
> +{
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_dev_state *cxlds;
> +	unsigned long index;
> +	void *entry;
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
> +#define CDAT_DOE_TASK(req, req_sz, rsp, rsp_sz, comp)	\

I was hoping this could save some more typing by calculating sizes of
the buffers internally. I'll take a shot at that as I apply it.

> +{							\
> +	.prot.vid = PCI_DVSEC_VENDOR_ID_CXL,		\
> +	.prot.type = CXL_DOE_PROTOCOL_TABLE_ACCESS,	\
> +	.request_pl = req,				\
> +	.request_pl_sz = req_sz,			\
> +	.response_pl = rsp,				\
> +	.response_pl_sz = rsp_sz,			\
> +	.complete = cxl_doe_task_complete,		\
> +	.private = comp,			\

...and since this one is DOE specific the completion can be declared
internally to the macro as well. Acutally, the request and response
payloads are identical in all usages so this can make the call sites
even smaller.


> +}
> +
> +static int cxl_cdat_get_length(struct device *dev,
> +			       struct pci_doe_mb *cdat_doe,
> +			       size_t *length)
> +{
> +	u32 cdat_request_pl = CDAT_DOE_REQ(0);
> +	u32 cdat_response_pl[32];
> +	DECLARE_COMPLETION_ONSTACK(c);
> +	struct pci_doe_task task = CDAT_DOE_TASK(&cdat_request_pl,
> +						 sizeof(cdat_request_pl),
> +						 cdat_response_pl,
> +						 sizeof(cdat_response_pl),
> +						 &c);
> +	int rc;
> +
> +	rc = pci_doe_submit_task(cdat_doe, &task);
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
> +			       struct pci_doe_mb *cdat_doe,
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
> +		struct pci_doe_task task = CDAT_DOE_TASK(&cdat_request_pl,
> +							 sizeof(cdat_request_pl),
> +							 cdat_response_pl,
> +							 sizeof(cdat_response_pl),
> +							 &c);
> +		size_t entry_dw;
> +		u32 *entry;
> +		int rc;
> +
> +		rc = pci_doe_submit_task(cdat_doe, &task);
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
> +	static struct pci_doe_mb *cdat_doe;

Why is this variable static?

> +	struct device *dev = &port->dev;
> +	struct device *uport = port->uport;
> +	size_t cdat_length;
> +	int rc;
> +
> +	cdat_doe = find_cdat_doe(uport);
> +	if (!cdat_doe) {
> +		dev_dbg(dev, "No CDAT mailbox\n");
> +		return;
> +	}
> +
> +	port->cdat_available = true;
> +
> +	if (cxl_cdat_get_length(dev, cdat_doe, &cdat_length)) {
> +		dev_dbg(dev, "No CDAT length\n");
> +		return;
> +	}
> +
> +	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
> +	if (!port->cdat.table)
> +		return;
> +
> +	port->cdat.length = cdat_length;
> +	rc = cxl_cdat_read_table(dev, cdat_doe, &port->cdat);
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
> index 570bd9f8141b..64ea8c80b917 100644
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
> @@ -289,6 +290,8 @@ struct cxl_nvdimm {
>   * @component_reg_phys: component register capability base address (optional)
>   * @dead: last ep has been removed, force port re-creation
>   * @depth: How deep this port is relative to the root. depth 0 is the root.
> + * @cdat: Cached CDAT data
> + * @cdat_available: Should a CDAT attribute be available in sysfs
>   */
>  struct cxl_port {
>  	struct device dev;
> @@ -301,6 +304,8 @@ struct cxl_port {
>  	resource_size_t component_reg_phys;
>  	bool dead;
>  	unsigned int depth;
> +	struct cxl_cdat cdat;
> +	bool cdat_available;
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
> index 3cf308f114c4..08b8ac76f87b 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -53,6 +53,9 @@ static int cxl_port_probe(struct device *dev)
>  		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
>  		struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  
> +		/* Cache the data early to ensure is_visible() works */
> +		read_cdat_data(port);
> +
>  		get_device(&cxlmd->dev);
>  		rc = devm_add_action_or_reset(dev, schedule_detach, cxlmd);
>  		if (rc)
> @@ -78,10 +81,61 @@ static int cxl_port_probe(struct device *dev)
>  	return 0;
>  }
>  
> +static ssize_t cdat_read(struct file *filp, struct kobject *kobj,
> +			 struct bin_attribute *bin_attr, char *buf,
> +			 loff_t offset, size_t count)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_port *port = to_cxl_port(dev);
> +
> +	if (!port->cdat_available)
> +		return -ENXIO;
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
> +	if ((attr == &bin_attr_cdat) && port->cdat_available)
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

Why does it need its own directory? I'll just fix this up to drop the
extra CDAT directory, and rename the attribute file to CDAT directly.

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


