Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ED55741C8
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 05:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiGNDRc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 23:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiGNDRV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 23:17:21 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C4125588;
        Wed, 13 Jul 2022 20:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657768621; x=1689304621;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GdwQUtFHiktXd2mlMRTWfWTpNkrtjwm7p7oqFINVWL4=;
  b=C/vAZHED6h0nA+WbCE5pwfjvSkEmuamcn5Vx58SxsKJUgaEwZ61hDZw1
   ZsYCnb9FY4gng8761NdInM4I5ZKFJnnBx7dbyuy4PLWzpkbrSCE5ydsZa
   N17BJDw5MGUxLMi9vY9pg7rTNuQiA2GX9CR/+W61PO+DF28jYRvXH3PH2
   bK0aEHA7o3CgcSkMD4B6Umorqh+CNVg8Ket05X8AEN5INXDSgeeAi+8xH
   dPXbpsgYsDZ7UMNASov5MFy0CC3o7Ar5yUUCVARiUbbAAvoHG0n11W8f5
   5qWWJY4EOyy9Z+ZGOOB2J2XSl8y5D5CWHj/agF6CPW1No/1pyCYJuXYxe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="286145818"
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="286145818"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 20:17:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,269,1650956400"; 
   d="scan'208";a="738114757"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jul 2022 20:17:00 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Jul 2022 20:16:59 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Jul 2022 20:16:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 13 Jul 2022 20:16:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 13 Jul 2022 20:16:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxlwNv9eFpGpJPVqWMg3oSuxaBsjLAmiK/QC0PxLrYpDx2z12PDbNJGUq5nb3eGxIkIYEQF0DC5ihIm+v4XHYXq9jEExZXmDsvL8ohrH/CBqcvq6BGMk2GB4vAS0UFs2IeGks8Ub9LDOUIWTvYpvrVNQbFfd37DCZROqBKIWf2IktpDFcx3mosfWwlg7TT2AoXGTmW6WkMlo9RWdMHXCM9eah65Dd5+3THJE74QApj7129DvWEf0pqXPz9DcQUxzHCI5SkjY15LDshGJ8fLUvfqPMpkDr55mTh6wJftdqEuaBok9oJBTh3aHE67mDDj8FByTSC12j55gkqnZGcwaJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x23w7wNHkNhGkCidr1d3tkrJVx6VDzp/11oG+ERZbGs=;
 b=blCQWxDhHjWDq1DQQO4W7nAaZ1PdNL11AcIiYKvboMSM9w/9TLnSWrCIy9WmBMTfghra+SbMqOPC1ajIuXf+O+IRBHea5pm3y7yCBK4aPG42VXfEFlmoli+gPITHVtEXqxfjLAYDtsVtn5tq9wHnmBWBay70zwsiacoJrZ0yig1J0tATb1TEpl3cXYagcnHKWm/GUkjS+wKJp0gyRRP0szo0r9ssbcVdOCIShBxKqTfs7IG+A7QmQ2PMo5/NCcEz1QxC8JQQsAFDD9VyuTxYQIlKXYQ98p3YKCbqk64IS0HXMAc2efpCA3xVyhrukTcuc88jJLVGMdtbccnwM/1YHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN6PR11MB2702.namprd11.prod.outlook.com
 (2603:10b6:805:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 14 Jul
 2022 03:16:56 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5417.027; Thu, 14 Jul
 2022 03:16:56 +0000
Date:   Wed, 13 Jul 2022 20:16:53 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "Li, Ming" <ming4.li@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Ira Weiny" <ira.weiny@intel.com>, Lukas Wunner <lukas@wunner.de>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: RE: [PATCH V13 3/9] PCI: Create PCIe library functions in support of
 DOE mailboxes.
Message-ID: <62cf8aa560ecf_1643dc2945c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
 <20220705154932.2141021-4-ira.weiny@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220705154932.2141021-4-ira.weiny@intel.com>
X-ClientProxiedBy: SJ0PR05CA0133.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22f71fb6-f634-4842-7116-08da65474e7e
X-MS-TrafficTypeDiagnostic: SN6PR11MB2702:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBbK2Ywu2t/5Iy6lm8IXvG54AKCRK5qOVoiKnSAd8nHoZC1/DlJkvq+SmvhcobKzBvcdxQsH7p1spmmpay9mH3UrKeE7mpRwLmng7bEmpPvlDG5kZ599mN84I21Jl3vtpGRS4ST0CMUg5t/n92i0LOleSYgwtUplGvt8TvIg8VrmnhJlRFYd+Rugq5MSBenEsBnfHCVqke3UHdX+cDu0bcMxo3jO+yzZuxamKTmuEar2v6ezmisK6EWGUKgmferO6ZG1f4kBX3CDUaQzh+vy8R7KUK5xuJSxKAIcs3dJGZm5CLqsIpQZhnz63ZiBPeB2hOwrONEQmgVWJ58ili8cS1JmqcD9bDi0PH7VBug7fWXQ6F4EGkuLgsfkD4KexJuTuAzX+uK6HBjalN78wFirvb8ZR4mJRNqkIWH4JzF6o6q+UcCVupWVW8MjbU4QZ51pq6FGf14XX1lHcpzBG4BPoOUg1XFRyCyFzK4K77JhTFdtRlWMZeBDswa5ethkDBFynsiJJlYmOhkJrv8RHcEgEFjXGyK7Uo5X5P8UtenadBv6fuV0WonjVpZ/e8ecscVztKXb90wgyEZF0rEOCZp8ed4GyFBqEEsLDpi76k8RGK4I0I1OBupDUM5WosLLVROV4xP9KR7B9BxreKrr+nitlS/7QbJA/eKXS6rJlDXz9u0R5lunBSWgGGVmxi+tLUkWNwFLMx/PIDXW3COzcM1FuP43q0iQTZy7SyDAqIyYY/QzmpTTr+bOyFxntM5XkLmkc/hivvx6x5hAzjGfczBl8no2ExGsL1ke7hDb4+bQbj4LHY0OZlDL+uhvQ1yJGnoIdhwh+tZyfJx/b4hcFJnSQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(366004)(346002)(376002)(136003)(41300700001)(6666004)(5660300002)(8936002)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(2906002)(186003)(38100700002)(15650500001)(6486002)(966005)(82960400001)(478600001)(6506007)(30864003)(86362001)(110136005)(316002)(54906003)(9686003)(26005)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tKfPGQcq0PArdQ3xwK6+t1FbagKa8UUXFhXQJBHcwFjr3cIWCjmLApkA3nkv?=
 =?us-ascii?Q?Z/zRvnD8SMiwX6sO9OGkh9y/0Fat3R6XQGaK33qIwPk8LITViW6h6Lhh2FQt?=
 =?us-ascii?Q?ZO19z2ieiKSqidJ8wzLehKKu8SnuomutWzaeY7Z0b752bYapq4KiiQ0NuPUZ?=
 =?us-ascii?Q?brKs4ZdwVRPd1ZUm9d4qovbqmm1LYzXiU0tkR6C/BnSbkBfl/3TPBCMfmMek?=
 =?us-ascii?Q?Ua9X3/3RoUICEDCsb5nOukvhAkKjoqwNHuOoAzKfXyU/fz+5mGPO7NWTNGZN?=
 =?us-ascii?Q?BPS2yKLnUhPVGFhjctKX1NK7At2bewZ2yENgqtl63jEeac4n869EXtHl7YIM?=
 =?us-ascii?Q?UTvSUAtbpqR212rebNP7Vv9Cpu4AFrv8s56U5X5GMc4vuaTRLpnwxs7yOgFM?=
 =?us-ascii?Q?erN6pw1C63OL8r+ZEYrBZWUeov6e1T2YJUJH3uE+JwkpZrjDOnwT8HOsDggt?=
 =?us-ascii?Q?TkXrsqaEkhq4xk0c6VgPMUA/vUoqBF47XTvJsXyqLVLMk3cpopvNka9sg7TG?=
 =?us-ascii?Q?tzOWrwLm+gHbfqkGQCA7uplJwiyxlIDRsdpWLtZdjssfTzcH3x+A3VQNXV4Q?=
 =?us-ascii?Q?epSPrJIvvHt1yg2K8vWyP5vDc6t7gEeoTwbhVUp4H0RoVlIUHHqgBLFTjlJV?=
 =?us-ascii?Q?Qk1DV1Qeq3+oAZjb8pyHTNhAM1l8IC1ECBDVHt+8UiBmC5MeLrLoQ0LKnK00?=
 =?us-ascii?Q?RK940Kl8VuRgs/s1JQw2xqf7fTGhrBD2fCMCN352gbQqiaJfDge08My/E7Y/?=
 =?us-ascii?Q?GSK1SWk+THux67OnjSX/7aSSS0i24dD33Oumg3RDprnLZF2J1RCZQftCK+x4?=
 =?us-ascii?Q?vMvoXxljsJ5GmwMZOyRXyk92iB5YnScpm9VFpphh36xUvYCpZYu61PrvNbO8?=
 =?us-ascii?Q?OukoNDxCP1z6Ve/oJl0ZGeyUMCJEFOEZ2ndYlcerrEW52k7I0VFjK07Z12uA?=
 =?us-ascii?Q?Q1A2monqm8QtdSmA+9VfLezPJV35DcICTyx0Zf4vnPIA+kD1ZTsRgzCGBFOP?=
 =?us-ascii?Q?929RM3h81uQcTNhS2VuGP9cgYrGhRdNkhV0TBpEnNnBEOA+k7sUYLWwCbc8+?=
 =?us-ascii?Q?AoOBgBAFS+ZhEvmkP8xr08p9h2pj5R5QQIcKd2EKv1OTtIZJHRKN5pdn4XLz?=
 =?us-ascii?Q?ZfJGYTb8UrvFLbliqWshlfsh/7gLSwQLcqO94O9sM8s4p901LQS18lUHNyHY?=
 =?us-ascii?Q?+qSrNBBV5D1FTomUnzI0awzcO8u+p+QYWXL2qBc58EQZiCuCzCCcE+WZ+PZP?=
 =?us-ascii?Q?ao8XfalijtjX9jX9syRYlwXi7Doz0KBKqpXFkSJhwZspwgc/boVNqhn/6ROM?=
 =?us-ascii?Q?UURo5V20KiCesMczmpVNe4hXAqsMvac7A7vlFwQMnk1KysKowV3JFTE1nU4t?=
 =?us-ascii?Q?jzMhLZMSar+Ikcrm8nTFO6+tM5dJT2EFSzdd3j74LBbV8SgmHoij8uiD44yc?=
 =?us-ascii?Q?YgI1+X9zCu+UeeJE0oKzpNa9v29uX/LwHOvhkKZH+/0u3VppzI9pi0kKHa3A?=
 =?us-ascii?Q?tcMIBNSxIOU6qaqVVxiJIGSmBEzEzIXBM4jeUIurtluSqM5TNl03Os8H3fTs?=
 =?us-ascii?Q?6nWguiEGesyqAmY0JwzH8SQCgDU6W20s4PZpdPK1sHQgsm2BTQ1z/ZXRHZFl?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f71fb6-f634-4842-7116-08da65474e7e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 03:16:56.2526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7NsNJfMBB5yKbxdc6legtU2GDjKEgYVdEUsyjVfKYr6/Mn9Yv2EDGbuELoKZ6jcidgxI/bMrQmUMSPmmRfVeoH/8Bj/wUTwDUEwauJ+eDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2702
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ira.weiny@ wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Introduced in a PCIe r6.0, sec 6.30, DOE provides a config space based
> mailbox with standard protocol discovery.  Each mailbox is accessed
> through a DOE Extended Capability.
> 
> Each DOE mailbox must support the DOE discovery protocol in addition to
> any number of additional protocols.
> 
> Define core PCIe functionality to manage a single PCIe DOE mailbox at a
> defined config space offset.  Functionality includes iterating,
> creating, query of supported protocol, and task submission.  Destruction
> of the mailboxes is device managed.
> 
> Cc: "Li, Ming" <ming4.li@intel.com>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V12
> 	Remove busy retries
> 	s/pci_doe_xa_entry/pci_doe_xa_prot_entry
> 	Open code pci_doe_abort call
> 	s/ABORT/CANCEL
> 		Clarify canceling a task by using a cancel flag instead
> 		of 'abort' flag
> 	Clean up comments
> 	Jonathan:
> 		use xa_mk_value() for XArray value
> 		spaces around '-' operator
> 		s/possitive/positive
> 		s/pci_doe_issue_abort/pci_doe_abort
> 		Remove pci_doe_free_mb() and use devm_* exclusively in pci_doe_create_mb()
> 		s/ret/rc to be consistent
> 		Remove irq support.
> 			Clean up timeout values and ensure waits values are correct
> 			Remove unnecessary arm_wait function
> 
> Changes from V11
> 	Bjorn: s/PCI/PCIe
> 		use dev_fmt
> 		move cap_offset in struct pci_doe_mb
> 		use break and return from a central place
> 		fix interrupt prints
> 		s/PCI_DOE_CAP_IRQ/PCI_DOE_CAP_INT_MSG_NUM
> 		s/irq_msg_num/int_msg_num
> 			when the value is not an irq but rather the
> 			interrupt message number for the DOE
> 		s/irq/IRQ in comments
> 		Clarify request and response payload size units
> 			In addition clarify the rv units Check for
> 			invalid response payload size (must be at least
> 			1 DW)
> 	Dan: s/EOPNOTSUPP/ENXIO/
> 		Add pci_doe_for_each_off to .clang-format
> 		use xarray for supported protocols
> 		s/pci_doe_create_mb/pcim_doe_create_mb/
> 			Remove pci_doe_destroy_mb
> 
> 	Dan: Convert the statemachine to process tasks as work items
> 		Define pci_doe_write_ctrl()
> 		Introduce pci_doe_irq_enabled()
> 		issue a stand alone abort
> 			Don't go through the state machine for the abort.  Just
> 			poll/irq until the response comes back.
> 		Remove Wait Abort state
> 			A wait abort can just be triggered from outside and stop
> 			the state machine from whatever loop it may be in.
> 			Let the state machine issue the abort itself and wait
> 			for it to return or not.
> 		Remove Wait abort on error
> 			Issue the abort directly before returning.  Abort
> 			failure will flag the MB dead.
> 		Remove workqueue processing from state machine
> 		clean up function locations in the file
> 		Move abort flag/document it
> 			React to an abort while aborting and bail.  This will
> 			mark the mailbox dead.
> 		Convert task to a work item
> 			Create a workqueue in the mailbox.  Remove cur_task and
> 			locking.  Set DEAD when taking mailbox down.
> 		print error on marking mailbox dead
> 		Introduce signal_task_abort
> 		flatten out the state machine
> 
> Changes from V9
> 	Lukas Wunner
> 		Update comments
> 		Move private doe structures and defines from pci-doe.h to doe.c
> 		check Data Obj Ready prior to last ack
> 	Davidlohr
> 		make task_lock a spinlock
> 	Lukas/Jonathan
> 		Remove special case of error in irq handler
> 	Fix potential race with the scheduling of a task when one is ending.
> 		The current task can't be retired until the state
> 		machine is idle.  Otherwise a new task work item may run
> 		and the state machine would be out of sync.
> 
> Changes from V8
> 	Remove Bjorn's ack
> 	Expose a function to find the irq number for a mailbox based on
> 	offset.  This is the code Jonathan proposed for finding the irq
> 	number here:
> 	https://lore.kernel.org/linux-cxl/20220503153449.4088-2-Jonathan.Cameron@huawei.com/
> 		This removes funky bool parameter to create.
> 	Move pci_set_master() within the pci_doe_enable_irq()
> 	Per Bjorn
> 		Clean up commit messages
> 		move pci-doe.c to doe.c
> 		Clean up PCI spec references
> 		Ensure all messages use pci_*()
> 		Add offset to error messages to distinguish mailboxes
> 			use hex for DOE offsets
> 		Print 4 nibbles for Vendor ID and 2 for type.
> 		s/irq/IRQ in comments
> 		Fix long lines
> 		Fix typos
> 
> Changes from V7
> 	Add a Kconfig for this functionality
> 	Fix bug in pci_doe_supports_prot()
> 	Rebased on cxl-pending
> 
> Changes from V6
> 	Clean up signed off by lines
> 	Make this functionality all PCI library functions
> 	Clean up header files
> 	s/pci_doe_irq/pci_doe_irq_handler
> 	Use pci_{request,free}_irq
> 		Remove irq_name (maintained by pci_request_irq)
> 	Fix checks to use an irq
> 	Consistently use u16 for cap_offset
> 	Cleanup kdocs and comments
> 	Create a helper retire_cur_task() to handle locking of the
> 		current task pointer.
> 	Remove devm_ calls from PCI layer.
> 		The devm_ calls do not allow for the pci_doe_mb objects
> 		to be tied to an auxiliary device.  Leave it to the
> 		caller to use devm_ if desired.
> 	From Dan Williams
> 		s/cb/end_task/; Pass pci_doe_task to end_task
> 		Clarify exchange/task/request/response.
> 			Merge pci_doe_task and pci_doe_exchange into
> 			pci_doe_task which represents a single
> 			request/response task for the state machine to
> 			process.
> 		Simplify submitting work to the mailbox
> 			Replace pci_doe_exchange_sync() with
> 			pci_doe_submit_task() Consumers of the mailbox
> 			are now responsible for setting up callbacks
> 			within a task object and submitting them to the
> 			mailbox to be processed.
> 		Remove WARN_ON when task != NULL and be sure to abort that task.
> 		Convert abort/dead to atomic flags
> 		s/state_lock/task_lock to better define what the lock is
> 			protecting
> 		Remove all the auxiliary bus code from the PCI layer
> 			The PCI layer provides helpers to use the DOE
> 			Mailboxes.  Each subsystem can then use the
> 			helpers as they see fit.  The CXL layer in this
> 			series uses aux devices to manage the new
> 			pci_doe_mb objects.
> 
> 	From Bjorn
> 		Clarify the fact that DOE mailboxes are capabilities of
> 			the device.
> 		Code clean ups
> 		Cleanup Makefile
> 		Update references to PCI SIG spec v6.0
> 		Move this attribution here:
> 		This code is based on Jonathan's V4 series here:
> 		https://lore.kernel.org/linux-cxl/20210524133938.2815206-1-Jonathan.Cameron@huawei.com/
> 
> Changes from V5
> 	From Bjorn
> 		s/pci_WARN/pci_warn
> 			Add timeout period to print
> 		Trim to 80 chars
> 		Use Tabs for DOE define spacing
> 		Use %#x for clarity
> 	From Jonathan
> 		Addresses concerns about the order of unwinding stuff
> 		s/doe/doe_dev in pci_doe_exhcnage_sync
> 		Correct kernel Doc comment
> 		Move pci_doe_task_complete() down in the file.
> 		Rework pci_doe_irq()
> 			process STATUS_ERROR first
> 			Return IRQ_NONE if the irq is not processed
> 			Use PCI_DOE_STATUS_INT_STATUS explicitly to
> 				clear the irq
> 	Clean up goto label s/err_free_irqs/err_free_irq
> 	use devm_kzalloc for doe struct
> 	clean up error paths in pci_doe_probe
> 	s/pci_doe_drv/pci_doe
> 	remove include mutex.h
> 	remove device name and define, move it in the next patch which uses it
> 	use devm_kasprintf() for irq_name
> 	use devm_request_irq()
> 	remove pci_doe_unregister()
> 		[get/put]_device() were unneeded and with the use of
> 		devm_* this function can be removed completely.
> 	refactor pci_doe_register and s/pci_doe_register/pci_doe_reg_irq
> 		make this function just a registration of the irq and
> 		move pci_doe_abort() into pci_doe_probe()
> 	use devm_* to allocate the protocol array
> 
> Changes from Jonathan's V4
> 	Move the DOE MB code into the DOE auxiliary driver
> 	Remove Task List in favor of a wait queue
> 
> Changes from Ben
> 	remove CXL references
> 	propagate rc from pci functions on error
> ---
>  .clang-format                 |   1 +
>  drivers/pci/Kconfig           |   3 +
>  drivers/pci/Makefile          |   1 +
>  drivers/pci/doe.c             | 552 ++++++++++++++++++++++++++++++++++
>  include/linux/pci-doe.h       |  79 +++++
>  include/uapi/linux/pci_regs.h |  29 +-
>  6 files changed, 664 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/doe.c
>  create mode 100644 include/linux/pci-doe.h
> 
> diff --git a/.clang-format b/.clang-format
> index fa959436bcfd..7bebb066f2a2 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -420,6 +420,7 @@ ForEachMacros:
>    - 'of_property_for_each_string'
>    - 'of_property_for_each_u32'
>    - 'pci_bus_for_each_resource'
> +  - 'pci_doe_for_each_off'
>    - 'pcl_for_each_chunk'
>    - 'pcl_for_each_segment'
>    - 'pcm_for_each_format'
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 133c73207782..b2f2e588a817 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -121,6 +121,9 @@ config XEN_PCIDEV_FRONTEND
>  config PCI_ATS
>  	bool
>  
> +config PCI_DOE
> +	bool
> +
>  config PCI_ECAM
>  	bool
>  
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 0da6b1ebc694..2680e4c92f0a 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_PCI_ECAM)		+= ecam.o
>  obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
> +obj-$(CONFIG_PCI_DOE)		+= doe.o
>  
>  # Endpoint library must be initialized before its users
>  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> new file mode 100644
> index 000000000000..0b02f33ef994
> --- /dev/null
> +++ b/drivers/pci/doe.c
> @@ -0,0 +1,552 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Data Object Exchange
> + *	PCIe r6.0, sec 6.30 DOE
> + *
> + * Copyright (C) 2021 Huawei
> + *	Jonathan Cameron <Jonathan.Cameron@huawei.com>
> + *
> + * Copyright (C) 2022 Intel Corporation
> + *	Ira Weiny <ira.weiny@intel.com>
> + */
> +
> +#define dev_fmt(fmt) "DOE: " fmt
> +
> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/jiffies.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pci-doe.h>
> +#include <linux/workqueue.h>
> +
> +#define PCI_DOE_PROTOCOL_DISCOVERY 0
> +
> +#define PCI_DOE_BUSY_MAX_RETRIES 16
> +
> +/* Timeout of 1 second from 6.30.2 Operation, PCI Spec r6.0 */
> +#define PCI_DOE_TIMEOUT HZ
> +#define PCI_DOE_POLL_INTERVAL	(PCI_DOE_TIMEOUT / 128)
> +
> +#define PCI_DOE_FLAG_CANCEL	0
> +#define PCI_DOE_FLAG_DEAD	1
> +
> +/**
> + * struct pci_doe_mb - State for a single DOE mailbox
> + *
> + * This state is used to manage a single DOE mailbox capability.  All fields
> + * should be considered opaque to the consumers and the structure passed into
> + * the helpers below after being created by devm_pci_doe_create()
> + *
> + * @pdev: PCI device this mailbox belongs to
> + * @cap_offset: Capability offset
> + * @prots: Array of protocols supported (encoded as long values)
> + * @wq: Wait queue for work item
> + * @work_queue: Queue of pci_doe_work items
> + * @flags: Bit array of PCI_DOE_FLAG_* flags
> + *
> + * Note: @prots can't be allocated with struct size because the number of
> + * protocols is not known until after this structure is in use.  However, the
> + * single discovery protocol is always required to query for the number of
> + * protocols.
> + */
> +struct pci_doe_mb {
> +	struct pci_dev *pdev;
> +	u16 cap_offset;
> +	struct xarray prots;
> +
> +	wait_queue_head_t wq;
> +	struct workqueue_struct *work_queue;
> +	unsigned long flags;
> +};
> +
> +static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
> +{
> +	if (wait_event_timeout(doe_mb->wq,
> +			       test_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags),
> +			       timeout))
> +		return -EIO;
> +	return 0;
> +}
> +
> +static void pci_doe_write_ctrl(struct pci_doe_mb *doe_mb, u32 val)
> +{
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +
> +	pci_write_config_dword(pdev, offset + PCI_DOE_CTRL, val);
> +}
> +
> +static int pci_doe_abort(struct pci_doe_mb *doe_mb)
> +{
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	unsigned long timeout_jiffies;
> +
> +	pci_dbg(pdev, "[%x] Issuing Abort\n", offset);
> +
> +	timeout_jiffies = jiffies + PCI_DOE_TIMEOUT;
> +	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_ABORT);
> +
> +	do {
> +		u32 val;
> +
> +		if (pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL))
> +			return -EIO;

nit, why translate the pci_doe_wait() return value? Not worth respinning
just for this though.

> +		pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +
> +		/* Abort success! */
> +		if (!FIELD_GET(PCI_DOE_STATUS_ERROR, val) &&
> +		    !FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> +			return 0;
> +
> +	} while (!time_after(jiffies, timeout_jiffies));
> +
> +	/* Abort has timed out and the MB is dead */
> +	pci_err(pdev, "[%x] ABORT timed out\n", offset);
> +	return -EIO;
> +}
> +
> +static int pci_doe_send_req(struct pci_doe_mb *doe_mb,
> +			    struct pci_doe_task *task)
> +{
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	u32 val;
> +	int i;
> +
> +	/*
> +	 * Check the DOE busy bit is not set. If it is set, this could indicate
> +	 * someone other than Linux (e.g. firmware) is using the mailbox. Note
> +	 * it is expected that firmware and OS will negotiate access rights via
> +	 * an, as yet to be defined method.
> +	 */
> +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +	if (FIELD_GET(PCI_DOE_STATUS_BUSY, val))
> +		return -EBUSY;
> +
> +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
> +		return -EIO;
> +
> +	/* Write DOE Header */
> +	val = FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_VID, task->prot.vid) |
> +		FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, task->prot.type);
> +	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE, val);
> +	/* Length is 2 DW of header + length of payload in DW */
> +	pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> +			       FIELD_PREP(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH,
> +					  2 + task->request_pl_sz /
> +						sizeof(u32)));
> +	for (i = 0; i < task->request_pl_sz / sizeof(u32); i++)
> +		pci_write_config_dword(pdev, offset + PCI_DOE_WRITE,
> +				       task->request_pl[i]);
> +
> +	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_GO);
> +
> +	/* Request is sent - now wait for poll or IRQ */
> +	return 0;
> +}
> +
> +static bool pci_doe_data_obj_ready(struct pci_doe_mb *doe_mb)
> +{
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +	if (FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val))
> +		return true;
> +	return false;
> +}
> +
> +static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> +{
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	size_t length, payload_length;
> +	u32 val;
> +	int i;
> +
> +	/* Read the first dword to get the protocol */
> +	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> +	if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) != task->prot.vid) ||
> +	    (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) != task->prot.type)) {
> +		pci_err(pdev,
> +			"[%x] expected [VID, Protocol] = [%04x, %02x], got [%04x, %02x]\n",
> +			doe_mb->cap_offset,
> +			task->prot.vid, task->prot.type,
> +			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val),
> +			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val));

Is this an error that happens when userspace collides DOE accesses with
the kernel? Or is this a "*should* never happen" error?

If this has the potential to spam the log it probably deserves to be
pci_err_ratelimited() (dev_err_ratelimited()).

...but just a question not a request to change.

> +		return -EIO;
> +	}
> +
> +	pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +	/* Read the second dword to get the length */
> +	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> +	pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +
> +	length = FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH, val);
> +	if (length > SZ_1M || length < 2)
> +		return -EIO;
> +
> +	/* First 2 dwords have already been read */
> +	length -= 2;
> +	payload_length = min(length, task->response_pl_sz / sizeof(u32));
> +	/* Read the rest of the response payload */
> +	for (i = 0; i < payload_length; i++) {
> +		pci_read_config_dword(pdev, offset + PCI_DOE_READ,
> +				      &task->response_pl[i]);
> +		/* Prior to the last ack, ensure Data Object Ready */
> +		if (i == (payload_length - 1) && !pci_doe_data_obj_ready(doe_mb))
> +			return -EIO;
> +		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +	}
> +
> +	/* Flush excess length */
> +	for (; i < length; i++) {
> +		pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> +		pci_write_config_dword(pdev, offset + PCI_DOE_READ, 0);
> +	}
> +
> +	/* Final error check to pick up on any since Data Object Ready */
> +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val))
> +		return -EIO;
> +
> +	return min(length, task->response_pl_sz / sizeof(u32)) * sizeof(u32);
> +}
> +
> +static void signal_task_complete(struct pci_doe_task *task, int rv)
> +{
> +	task->rv = rv;
> +	task->complete(task);
> +}
> +
> +static void signal_task_abort(struct pci_doe_task *task, int rv)
> +{
> +	struct pci_doe_mb *doe_mb = task->doe_mb;
> +	struct pci_dev *pdev = doe_mb->pdev;
> +
> +	if (pci_doe_abort(doe_mb)) {
> +		/*
> +		 * If the device can't process an abort; set the mailbox dead
> +		 *	- no more submissions
> +		 */
> +		pci_err(pdev, "[%x] Abort failed marking mailbox dead\n",
> +			doe_mb->cap_offset);

Feels like a dev_dbg(), no?

> +		set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> +	}
> +	signal_task_complete(task, rv);
> +}
> +
> +static void doe_statemachine_work(struct work_struct *work)
> +{
> +	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
> +						 work);
> +	struct pci_doe_mb *doe_mb = task->doe_mb;
> +	struct pci_dev *pdev = doe_mb->pdev;
> +	int offset = doe_mb->cap_offset;
> +	unsigned long timeout_jiffies;
> +	u32 val;
> +	int rc;
> +
> +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags)) {
> +		signal_task_complete(task, -EIO);
> +		return;
> +	}
> +
> +	/* Send request */
> +	rc = pci_doe_send_req(doe_mb, task);
> +
> +	if (rc) {
> +		/*
> +		 * The specification does not provide any guidance on how to
> +		 * resolve conflicting requests from other entities.
> +		 * Furthermore, it is likely that busy will not be detected
> +		 * most of the time.  Flag any detection of status busy with an
> +		 * error.
> +		 */
> +		if (rc == -EBUSY) {
> +			pci_err(pdev,
> +				"[%x] busy detected; another entity is sending conflicting requests\n",
> +				offset);

This definitely feels like something that needs to be ratelimited.

> +		}
> +		signal_task_abort(task, rc);
> +		return;
> +	}
> +
> +	timeout_jiffies = jiffies + PCI_DOE_TIMEOUT;
> +	rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> +	if (rc) {
> +		signal_task_abort(task, rc);
> +		return;
> +	}
> +
> +	/* Poll for response */
> +retry_resp:
> +	pci_read_config_dword(pdev, offset + PCI_DOE_STATUS, &val);
> +	if (FIELD_GET(PCI_DOE_STATUS_ERROR, val)) {
> +		signal_task_abort(task, -EIO);
> +		return;
> +	}
> +
> +	if (!FIELD_GET(PCI_DOE_STATUS_DATA_OBJECT_READY, val)) {
> +		if (time_after(jiffies, timeout_jiffies)) {
> +			signal_task_abort(task, -EIO);
> +			return;
> +		}
> +		rc = pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL);
> +		if (rc) {
> +			signal_task_abort(task, rc);
> +			return;
> +		}
> +		goto retry_resp;
> +	}
> +
> +	rc  = pci_doe_recv_resp(doe_mb, task);
> +	if (rc < 0) {
> +		signal_task_abort(task, rc);
> +		return;
> +	}
> +
> +	signal_task_complete(task, rc);
> +}
> +
> +static void pci_doe_task_complete(struct pci_doe_task *task)
> +{
> +	complete(task->private);
> +}
> +
> +static int pci_doe_discovery(struct pci_doe_mb *doe_mb, u8 *index, u16 *vid,
> +			     u8 *protocol)
> +{
> +	u32 request_pl = FIELD_PREP(PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX,
> +				    *index);
> +	u32 response_pl;
> +	DECLARE_COMPLETION_ONSTACK(c);
> +	struct pci_doe_task task = {
> +		.prot.vid = PCI_VENDOR_ID_PCI_SIG,
> +		.prot.type = PCI_DOE_PROTOCOL_DISCOVERY,
> +		.request_pl = &request_pl,
> +		.request_pl_sz = sizeof(request_pl),
> +		.response_pl = &response_pl,
> +		.response_pl_sz = sizeof(response_pl),
> +		.complete = pci_doe_task_complete,
> +		.private = &c,
> +	};
> +	int rc;
> +
> +	rc = pci_doe_submit_task(doe_mb, &task);
> +	if (rc < 0)
> +		return rc;
> +
> +	wait_for_completion(&c);
> +
> +	if (task.rv != sizeof(response_pl))
> +		return -EIO;
> +
> +	*vid = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID, response_pl);
> +	*protocol = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL,
> +			      response_pl);
> +	*index = FIELD_GET(PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX,
> +			   response_pl);
> +
> +	return 0;
> +}
> +
> +static void *pci_doe_xa_prot_entry(u16 vid, u8 prot)
> +{
> +	return xa_mk_value(((unsigned long)vid << 16) | prot);
> +}
> +
> +static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
> +{
> +	u8 index = 0;
> +	u8 xa_idx = 0;
> +
> +	do {
> +		int rc;
> +		u16 vid;
> +		u8 prot;
> +
> +		rc = pci_doe_discovery(doe_mb, &index, &vid, &prot);
> +		if (rc)
> +			return rc;
> +
> +		pci_dbg(doe_mb->pdev,
> +			"[%x] Found protocol %d vid: %x prot: %x\n",
> +			doe_mb->cap_offset, xa_idx, vid, prot);
> +
> +		rc = xa_insert(&doe_mb->prots, xa_idx++,
> +			       pci_doe_xa_prot_entry(vid, prot), GFP_KERNEL);
> +		if (rc)
> +			return -ENOMEM;

Why translate the xa_insert() return value when xa_insert() can also
report -EBUSY?

> +	} while (index);
> +
> +	return 0;
> +}
> +
> +static void pci_doe_xa_destroy(void *mb)
> +{
> +	struct pci_doe_mb *doe_mb = mb;
> +
> +	xa_destroy(&doe_mb->prots);
> +}
> +
> +static void pci_doe_destroy_workqueue(void *mb)
> +{
> +	struct pci_doe_mb *doe_mb = mb;
> +
> +	destroy_workqueue(doe_mb->work_queue);
> +}
> +
> +static void pci_doe_flush_mb(void *mb)
> +{
> +	struct pci_doe_mb *doe_mb = mb;
> +
> +	/* Stop all pending work items from starting */
> +	set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> +
> +	/* Cancel an in progress work item, if necessary */
> +	set_bit(PCI_DOE_FLAG_CANCEL, &doe_mb->flags);
> +	wake_up(&doe_mb->wq);
> +
> +	/* Flush all work items */
> +	flush_workqueue(doe_mb->work_queue);
> +}
> +
> +/**
> + * pcim_doe_create_mb() - Create a DOE mailbox object
> + *
> + * @pdev: PCI device to create the DOE mailbox for
> + * @cap_offset: Offset of the DOE mailbox
> + *
> + * Create a single mailbox object to manage the mailbox protocol at the
> + * cap_offset specified.
> + *
> + * RETURNS: created mailbox object on success
> + *	    ERR_PTR(-errno) on failure
> + */
> +struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	struct device *dev = &pdev->dev;
> +	int rc;
> +
> +	doe_mb = devm_kzalloc(dev, sizeof(*doe_mb), GFP_KERNEL);
> +	if (!doe_mb)
> +		return ERR_PTR(-ENOMEM);
> +
> +	doe_mb->pdev = pdev;
> +	doe_mb->cap_offset = cap_offset;
> +	init_waitqueue_head(&doe_mb->wq);
> +
> +	xa_init(&doe_mb->prots);
> +	rc = devm_add_action(dev, pci_doe_xa_destroy, doe_mb);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	doe_mb->work_queue = alloc_ordered_workqueue("DOE: [%x]", 0,
> +						     doe_mb->cap_offset);

I don't see much in the way of end user useful information in that name.
Not that the thread names matter all that much, but for debug it might
be nice to be able to tie queue threads back to the corresponding
device. So maybe put the PCI device name and dev_driver_string() in the
name?

> +	if (!doe_mb->work_queue) {
> +		pci_err(pdev, "[%x] failed to allocate work queue\n",
> +			doe_mb->cap_offset);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	rc = devm_add_action_or_reset(dev, pci_doe_destroy_workqueue, doe_mb);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	/* Reset the mailbox by issuing an abort */
> +	rc = pci_doe_abort(doe_mb);
> +	if (rc) {
> +		pci_err(pdev,
> +			"[%x] failed to reset mailbox with abort command : %d\n",
> +			doe_mb->cap_offset, rc);
> +		return ERR_PTR(rc);
> +	}
> +
> +	/*
> +	 * The state machine and the mailbox should be in sync now;
> +	 * Set up mailbox flush prior to using the mailbox to query protocols.
> +	 */
> +	rc = devm_add_action_or_reset(dev, pci_doe_flush_mb, doe_mb);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	rc = pci_doe_cache_protocols(doe_mb);
> +	if (rc) {
> +		pci_err(pdev, "[%x] failed to cache protocols : %d\n",
> +			doe_mb->cap_offset, rc);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return doe_mb;
> +}
> +EXPORT_SYMBOL_GPL(pcim_doe_create_mb);
> +
> +/**
> + * pci_doe_supports_prot() - Return if the DOE instance supports the given
> + *			     protocol
> + * @doe_mb: DOE mailbox capability to query
> + * @vid: Protocol Vendor ID
> + * @type: Protocol type
> + *
> + * RETURNS: True if the DOE mailbox supports the protocol specified
> + */
> +bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type)
> +{
> +	unsigned long index;
> +	void *entry;
> +
> +	/* The discovery protocol must always be supported */
> +	if (vid == PCI_VENDOR_ID_PCI_SIG && type == PCI_DOE_PROTOCOL_DISCOVERY)
> +		return true;
> +
> +	xa_for_each(&doe_mb->prots, index, entry)
> +		if (entry == pci_doe_xa_prot_entry(vid, type))
> +			return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(pci_doe_supports_prot);
> +
> +/**
> + * pci_doe_submit_task() - Submit a task to be processed by the state machine
> + *
> + * @doe_mb: DOE mailbox capability to submit to
> + * @task: task to be queued
> + *
> + * Submit a DOE task (request/response) to the DOE mailbox to be processed.
> + * Returns upon queueing the task object.  If the queue is full this function
> + * will sleep until there is room in the queue.
> + *
> + * task->complete will be called when the state machine is done processing this
> + * task.
> + *
> + * Excess data will be discarded.
> + *
> + * RETURNS: 0 when task has been successful queued, -ERRNO on error
> + */
> +int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> +{
> +	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
> +		return -EINVAL;
> +
> +	/*
> +	 * DOE requests must be a whole number of DW
> +	 * and the response needs to be big enough for at least 1 DW
> +	 */
> +	if (task->request_pl_sz % sizeof(u32) ||
> +	    task->response_pl_sz < sizeof(u32))
> +		return -EINVAL;
> +
> +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
> +		return -EIO;
> +
> +	task->doe_mb = doe_mb;
> +	INIT_WORK(&task->work, doe_statemachine_work);

Would be nice to move all init to the callers and, similar to
submit_bio(), rely on the task already knowing all its submit
parameters. Can be a follow-on cleanup.

> +	queue_work(doe_mb->work_queue, &task->work);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_doe_submit_task);
> diff --git a/include/linux/pci-doe.h b/include/linux/pci-doe.h
> new file mode 100644
> index 000000000000..c77f6258c996
> --- /dev/null
> +++ b/include/linux/pci-doe.h
> @@ -0,0 +1,79 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Data Object Exchange
> + *	PCIe r6.0, sec 6.30 DOE
> + *
> + * Copyright (C) 2021 Huawei
> + *     Jonathan Cameron <Jonathan.Cameron@huawei.com>
> + *
> + * Copyright (C) 2022 Intel Corporation
> + *	Ira Weiny <ira.weiny@intel.com>
> + */
> +
> +#ifndef LINUX_PCI_DOE_H
> +#define LINUX_PCI_DOE_H
> +
> +#include <linux/completion.h>
> +
> +struct pci_doe_protocol {
> +	u16 vid;
> +	u8 type;
> +};
> +
> +struct pci_doe_mb;
> +
> +/**
> + * struct pci_doe_task - represents a single query/response
> + *
> + * @prot: DOE Protocol
> + * @request_pl: The request payload
> + * @request_pl_sz: Size of the request payload (bytes)
> + * @response_pl: The response payload
> + * @response_pl_sz: Size of the response payload (bytes)
> + * @rv: Return value.  Length of received response or error (bytes)
> + * @complete: Called when task is complete
> + * @private: Private data for the consumer
> + * @work: Used internally by the mailbox
> + * @doe_mb: Used internally by the mailbox
> + *
> + * The payload sizes and rv are specified in bytes with the following
> + * restrictions concerning the protocol.
> + *
> + *	1) The request_pl_sz must be a multiple of double words (4 bytes)
> + *	2) The response_pl_sz must be >= a single double word (4 bytes)
> + *	3) rv is returned as bytes but it will be a multiple of double words
> + *
> + * NOTE there is no need for the caller to initialize work or doe_mb.
> + */
> +struct pci_doe_task {
> +	struct pci_doe_protocol prot;
> +	u32 *request_pl;
> +	size_t request_pl_sz;
> +	u32 *response_pl;
> +	size_t response_pl_sz;
> +	int rv;
> +	void (*complete)(struct pci_doe_task *task);
> +	void *private;
> +
> +	/* No need for the user to initialize these fields */
> +	struct work_struct work;
> +	struct pci_doe_mb *doe_mb;
> +};
> +
> +/**
> + * pci_doe_for_each_off - Iterate each DOE capability
> + * @pdev: struct pci_dev to iterate
> + * @off: u16 of config space offset of each mailbox capability found
> + */
> +#define pci_doe_for_each_off(pdev, off) \
> +	for (off = pci_find_next_ext_capability(pdev, off, \
> +					PCI_EXT_CAP_ID_DOE); \
> +		off > 0; \
> +		off = pci_find_next_ext_capability(pdev, off, \
> +					PCI_EXT_CAP_ID_DOE))
> +
> +struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset);
> +bool pci_doe_supports_prot(struct pci_doe_mb *doe_mb, u16 vid, u8 type);
> +int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task);
> +
> +#endif
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index bee1a9ed6e66..9d50678f3f62 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -736,7 +736,8 @@
>  #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
>  #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
>  #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_16GT
> +#define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
>  
>  #define PCI_EXT_CAP_DSN_SIZEOF	12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> @@ -1102,4 +1103,30 @@
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_MASK		0x000000F0
>  #define  PCI_PL_16GT_LE_CTRL_USP_TX_PRESET_SHIFT	4
>  
> +/* Data Object Exchange */
> +#define PCI_DOE_CAP		0x04    /* DOE Capabilities Register */
> +#define  PCI_DOE_CAP_INT_SUP			0x00000001  /* Interrupt Support */
> +#define  PCI_DOE_CAP_INT_MSG_NUM		0x00000ffe  /* Interrupt Message Number */
> +#define PCI_DOE_CTRL		0x08    /* DOE Control Register */
> +#define  PCI_DOE_CTRL_ABORT			0x00000001  /* DOE Abort */
> +#define  PCI_DOE_CTRL_INT_EN			0x00000002  /* DOE Interrupt Enable */
> +#define  PCI_DOE_CTRL_GO			0x80000000  /* DOE Go */
> +#define PCI_DOE_STATUS		0x0c    /* DOE Status Register */
> +#define  PCI_DOE_STATUS_BUSY			0x00000001  /* DOE Busy */
> +#define  PCI_DOE_STATUS_INT_STATUS		0x00000002  /* DOE Interrupt Status */
> +#define  PCI_DOE_STATUS_ERROR			0x00000004  /* DOE Error */
> +#define  PCI_DOE_STATUS_DATA_OBJECT_READY	0x80000000  /* Data Object Ready */
> +#define PCI_DOE_WRITE		0x10    /* DOE Write Data Mailbox Register */
> +#define PCI_DOE_READ		0x14    /* DOE Read Data Mailbox Register */
> +
> +/* DOE Data Object - note not actually registers */
> +#define PCI_DOE_DATA_OBJECT_HEADER_1_VID		0x0000ffff
> +#define PCI_DOE_DATA_OBJECT_HEADER_1_TYPE		0x00ff0000
> +#define PCI_DOE_DATA_OBJECT_HEADER_2_LENGTH		0x0003ffff
> +
> +#define PCI_DOE_DATA_OBJECT_DISC_REQ_3_INDEX		0x000000ff
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_VID		0x0000ffff
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
> +#define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
> +
>  #endif /* LINUX_PCI_REGS_H */
> -- 
> 2.35.3
> 

Hey, this looks pretty good, thanks for all the hard work on this.
