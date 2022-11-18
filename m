Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C8662FC3E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 19:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiKRSOr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 13:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiKRSOq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 13:14:46 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F6487551;
        Fri, 18 Nov 2022 10:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668795285; x=1700331285;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CTUGAiDCa9MHdNg0dX6Y5Xs9ttxR5HlwNiLG5J5HpTU=;
  b=Pvj48/6Gjswl3TyggAanCCG5lzMgaCF1rDPaSLIfswm/HZR0qzqDi++5
   5SbIF/lp5Hny5ifJ5LsmMm9/QRfZblYWIzCdVkjNDrDNv3o+cV16KuIT9
   vhHeXdTimI72FIv1BNK2Rfdz8e08t3ON6jO9fuMmuM1FmNjTLtuMIRMkk
   zSsj7liVjhtx37WNIfpoi5VvQaG1YEPmJZDIRLuw3g5nzLi6MpWUSKZOV
   7KgCxuDIEFUbn/6WAph10mA/GEjvD+jNyxc1XHSdmbN99p5nbjTjcsXTb
   naoG/Jy97wIDe69N8McBA6/aSvgBEgVbNqbtG0JAdT8p2xTAWqY1KVrRC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="293588580"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="293588580"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:14:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="746092967"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="746092967"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 18 Nov 2022 10:14:43 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 10:14:43 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 10:14:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 18 Nov 2022 10:14:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 18 Nov 2022 10:14:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5UX2vEz8fpuUfSIl+dm1/D8AZ6zjY17ohiJP79zdf4h1jyEtbaeH6WWzFPLYGOn91hitIyYlXl1T2qlvMlZByrT3uLzaH8htmZBD+F8hrtYywURrCaO0bPFczYTSM/UpNzrJofonSIUh4almfv1G3Tz6l2PQOAm0SGDBUKqNEkYBxVf+cPCrKut2CFAYgPbd3jvx8tSgvwfmgdLvQJ4462gL950Eph1x7U8XPOjTU3zkOIeUSm9gfAnFUTMV3FC6IWpOmL6asyhRH0ZorD0no39VeF1iroyI7ELYDgq/OWG1WAdZo1BkBdXEg1A7ZCyO+NNZ6a1MjKjge4u6pYYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DF0Uqq5pw31E+S4/c6Il74k7cd9DX0gcF2XAit07nQw=;
 b=FLpFDHiy7JhglM/e2gENu5fiEaJ9jSOXFOa4QtKlHU+PSt3a9UODsiwvO0exB+bTpFofCEJ9hzJSnKDDVoUsb9vlLA5wHPeYJzGdsVS3icWOdsesLCYXDpoTD0rS0Mh+MXswio78RCLWP6kYQwGSFlwk3YNEX3oeCCncIIdjdGXAHEyz4uy4YcVElZ/n/0q1mXmuOilrYMndZzoHqRmr9zbAHuwv+igh3o5/+8hO9c4raQDr0OWVtqKYhUojhqZrSBbEdkO0qkxvoHucU7OLdznW6Ec/pKjuRkQj2dVhYdSkNREBw+JnxJ2gZqceysJvCGy8zLbv/kFMgMuHrTIaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM4PR11MB5423.namprd11.prod.outlook.com
 (2603:10b6:5:39b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 18:14:40 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::b058:673:c228:3e95%9]) with mapi id 15.20.5834.009; Fri, 18 Nov 2022
 18:14:39 +0000
Date:   Fri, 18 Nov 2022 10:14:37 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     David Laight <David.Laight@aculab.com>,
        "'ira.weiny@intel.com'" <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH V2] PCI/DOE: Detect on stack work items automatically
Message-ID: <6377cb8d32422_12cdff294e7@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221118000524.1477383-1-ira.weiny@intel.com>
 <e59f83f3ca4149d098efe43b48fecd1b@AcuMS.aculab.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e59f83f3ca4149d098efe43b48fecd1b@AcuMS.aculab.com>
X-ClientProxiedBy: SJ0PR03CA0138.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::23) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM4PR11MB5423:EE_
X-MS-Office365-Filtering-Correlation-Id: 064335ad-8667-492b-a2d4-08dac990c220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6cKu13oh9axkyBtBjwOioBTF0ygBt82phe2OXsBgAUo6WBnTLq722APSm8TzubEN+1qeeO19qNeCL0glz/H+TeYs58ctHFNgtydF70W7HIECZq60Q3BueopBC3cDUJm1IYKf6bx5RIA9mjmZuOqQQxZqWCqWGyj4fM7P8yuMXYWnLeMtQy3wz+OqWbp56RCyrA86xgKC2XWGI4OptEc3iivonTiDX4XppWRWBlteHBZog1njoo2Mhv3X98vt81+1vR9xzP6kkTZRmywHTchiQxBH5wgGoJlSSwFSRvzFeISeqQ6JO5sUiVZQ91thABzKXoozGd/p7+z4Kt6GQEJjhuqn1V5IglaYPYNmbc8nB2n8LEodDJvxHk7boSgNTCby/ndZK6sidLNNpRCn0NtUWZYxsbqQtJhj/1RQuYTBWqOG3YsLLGQ8iJl+FencfooFRRgU6i9tbz/J+ZYGE8lY8q3OKozCOSkBBv+8u9XBuoZflVfkP+q0hjZI3f/SZ4q23L73Q2UPdXp4DJ4GngqR1YWNzCScXDwVe4Y9hKPR6ciW5rQBQ+oUoaEAWj494yv76IplOVxSPSahsZsOXsZejHYjZAJVy4xMhBAAKv7hGJAgTO5kiryT7yTWe3UXYBIEjQknkPIZwviR7+RihqdJrpo3JDDknycjEKKfUA3XN8P09OtCv4VeERaTKAVMMjjC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(376002)(136003)(39860400002)(396003)(451199015)(86362001)(5660300002)(8936002)(6486002)(82960400001)(38100700002)(41300700001)(186003)(54906003)(6506007)(2906002)(9686003)(26005)(6512007)(110136005)(478600001)(66946007)(316002)(66476007)(83380400001)(66556008)(8676002)(4326008)(491001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zc2xZtmt6MvBnsKMBMuFQPtQuyvXAHjZJRKjRUUv35IhH0nrv11AvburegOp?=
 =?us-ascii?Q?/EaHVy3IB5Hswj8QSCHBOyW4mlkBB9NG4edK/xrJeioeCefTfy5MMrYAuDR/?=
 =?us-ascii?Q?qYEquH1mRtPTEdBVtc/am4cZrdzE6UrHuT3irO1vDqymx0Q4sOVicbDTzjih?=
 =?us-ascii?Q?JjFrqJCnJl8UjgQTVrwlPWOiLGEfKrAQ86S4BBO/tg22wb7zT9/3+ymmF5MF?=
 =?us-ascii?Q?U+6T73vkfyjrbRlc5ipjJNxqZ6fqUS4aDv3pcsEsAEy2dOKU/ZdNHBuX9NRq?=
 =?us-ascii?Q?F9C0cli5zlR7AMK4ktLjARDpsXyDiakpNDpEHy/kG2/ktCL7jgtqi5EKhf3g?=
 =?us-ascii?Q?Kra9G78UfJ7Wkju7VQRGYlGS8VnagD+FFZcxeziPW1vR+o5GGgQPQFJgBx4x?=
 =?us-ascii?Q?34cI/yUaZcdhLu61hCisOATz7cCKrEvB/rxa2ZP7DVxOAxdVUfxIq9HmU65W?=
 =?us-ascii?Q?/fQ/Hjbv0QRkJeOIroMLXCqdf9H8OSxuascxIFjXcZilI5qNztlMhANeoUQz?=
 =?us-ascii?Q?XD4rJVc/x1ig1pBSjyZA3wWQbaePwmMBQaHHf4LvQUmPRHHZAtfvCMR02eMF?=
 =?us-ascii?Q?ENFVbQ1NOzeMZSCXTu5aGS5rQWLAhvG70piUv/VhlIZAvif1ytt2ptBeRvRG?=
 =?us-ascii?Q?ITiJElNsfggYB01uRMJv6s/ATB8vQaHmry9qmb2P/SqJXo9R4+kEtSQvHCKW?=
 =?us-ascii?Q?zPKF5bVRXV2/QSfPbaB7KZ6MSR+H/3P0RtNqR7hZEmRUYOvxgHysIAhKp9eF?=
 =?us-ascii?Q?MyPJfckRcLGzOCmISw2xq1qAF+rppgdOvOqMVltAXyczKEyNpr7v7Jz1V1MR?=
 =?us-ascii?Q?mrOhUD7xeY9c6X5V2w3/WyPfBSh3g50YeywSS4GSf+3Cp/UsS4CfmNNrt8/h?=
 =?us-ascii?Q?3PqmjcKPfqxRfnEuXX3LoDijLF+KitXlgGEPryYuFFefnoV4gGD435BWwTGD?=
 =?us-ascii?Q?sZIZ1QSOUDTvOjnbg8VUreNiWh0H5TvWEl28jnBvLCrjzMWWB1HPmsi0tA9O?=
 =?us-ascii?Q?TO7p3FpMdnOcwAEEp8XA3FaqPzarsWHkCJJQ/IOO/JspTmNHKKRKJ/+zzBew?=
 =?us-ascii?Q?8nSuntOVbHEwtUzU95/qBte1lMK6IooZqjsTpSVykFtK8FP0q0bpsxfVx6jN?=
 =?us-ascii?Q?6DHQKSousa9OWCIWhyD/VaJ3R5N3ojMZGhr+8oDXXEym9CvIVg2tMJ0b+D/c?=
 =?us-ascii?Q?qtZP5/3jik62RDFUwttAxKT7FKKL8xf33d2VL6WCz22LTiBc4boDvf+ZUvOM?=
 =?us-ascii?Q?j/yoLl2/SMBvdcr9VcMciBO9TN4DwtNDxAhLezauwP3ogt+aA/ySe9OzCkeD?=
 =?us-ascii?Q?0vHV8fPThZ9fdK++NF62HJq1wAFtu0LOaSn5dYtKcl1zB1ACPsyb3hPocX79?=
 =?us-ascii?Q?i1vz4Yt3B/iIcsbBS168iK7ijYkgVibmnNE5Igkf/BCQQRZMubM0zBTBdqQU?=
 =?us-ascii?Q?/Bvbj7V3YGiyLRLL31yeRYia3BBdecsWeqk6BQz7VA+YNB9tQ+b4RgpY8eCT?=
 =?us-ascii?Q?3GEQy84moXEnBTM7T4UUEWL8t35A/kekBEtcfJTCO8xNN7ZT97uhcMZz3Mcp?=
 =?us-ascii?Q?407bbCCOuxrQyAmCP/95zUBijf0u4S9kHohovmZF59vYuI1qrCkfwLRBsuAt?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 064335ad-8667-492b-a2d4-08dac990c220
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 18:14:39.8238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oVNUasR+dcWD87VF3A/EeZSwBGP0+FC22gG7EKJ8UUNRFapv+DSMTUGO++8QmsleJKDrUkJCRfTuVmT2fXnlr7Prg1FtCGWC2E0fzJoarQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5423
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

David Laight wrote:
> From: ira.weiny@intel.com
> > Sent: 18 November 2022 00:05
> > 
> > Work item initialization needs to be done with either
> > INIT_WORK_ONSTACK() or INIT_WORK() depending on how the work item is
> > allocated.
> > 
> > The callers of pci_doe_submit_task() allocate struct pci_doe_task on the
> > stack and pci_doe_submit_task() incorrectly used INIT_WORK().
> > 
> > Jonathan suggested creating doe task allocation macros such as
> > DECLARE_CDAT_DOE_TASK_ONSTACK().[1]  The issue with this is the work
> > function is not known to the callers and must be initialized correctly.
> > 
> > A follow up suggestion was to have an internal 'pci_doe_work' item
> > allocated by pci_doe_submit_task().[2]  This requires an allocation which
> > could restrict the context where tasks are used.
> > 
> > Another idea was to have an intermediate step to initialize the task
> > struct with a new call.[3]  This added a lot of complexity.
> > 
> > Lukas pointed out that object_is_on_stack() is available to detect this
> > automatically.
> > 
> > Use object_is_on_stack() to determine the correct init work function to
> > call.
> 
> This is all a bit strange.
> The 'onstack' flag is needed for the diagnostic check:
> 	is_on_stack = object_is_on_stack(addr);
> 	if (is_on_stack == onstack)
> 		return;
> 	pr_warn(...);
> 	WARN_ON(1);
> 
> So setting the flag to the location of the buffer just subverts the check.
> It that is sane there ought to be a proper way to do it.
> 
> OTOH using an on-stack structure for INIT_WORK seems rather strange.
> Since the kernel thread must sleep waiting for the 'work' to complete
> why not just perform the required code there.

To have the option to support both async and sync flows through this
driver interface. It is similar to the internal distinction between:

submit_bio_wait()

...and:

submit_bio()

Where the former just layers an on on-stack completion over the
asynchronous submit_bio().

> Also you really don't want to OOPS with anything from the stack
> linked into global kernel data structures.
> While wait queues are pretty limited in scope and probably ok,
> this looks like a big accident waiting to happen.

I do not see the cause for alarm, this sync-wait design pattern is not
new.
