Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E119E5750A1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 16:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiGNOTs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 10:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239521AbiGNOTq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 10:19:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A25643CB;
        Thu, 14 Jul 2022 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657808385; x=1689344385;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GmrS+N2YU3RlPZUc5NbDt3k15hB2TV826DuGAau9Z4A=;
  b=daPVzTGivhR8mgdRoqrRZUIFIwU9wu0NF+0R025aek0i3v+G0RW5vpRf
   I7STQu2q4BiDGkBW0d4U+ljt6TUX/6F49Hku9Dmu8Wy84GXgIXWIw3tj9
   LMF26HQlK6iaOLCpdx5snUDHEJoHp2DOKbmCtbxrSGj8yUkuQAY6/BK2G
   oP/QgPTeKRxLDNMX2mg9VIEpc4dETWPIt7lAHON24QNQZD9UqtcaVPXf3
   D357e/g03l+Vt8wjgH8jF0/ocsp3IDmCe0Z3iGsBhUGC2Ji7Zqu+aYAHB
   VV63ro2JDxty4aOs6jeUHjZ4ARYDuEPjIZYBQCkiuSgPznZ3OHHUcdVxI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="265311420"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="265311420"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 07:19:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="571110571"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 14 Jul 2022 07:19:44 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 07:19:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 07:19:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 07:19:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuvwNgO1oNEm/yspGNs6VKUS+WsKtWRaHSk0ou51EfoN/dcLWixxrHbyELXISQH9+pXp+3SRG/6QV1+hyHzFvHOvERvcAk222RBfnUto6w76zoqkzarv4REy+dFYZB/kOaw9Vgx+omfmxByTLDc94RDhz6FGvAtHyJcU3Zml3Tgxd8tIf/9HU0TMT7hdNojFyo2PC0xn4TRzAK2NHkArt9UUU71tkQm4LUi4atoLU5mNZuT8wgRgpcTDAsbz1RZ71Vs8VcSrIGSwWBYeVUcl5FajRh4qcsRHNry63wzbBIUKxrFVlpJxcqNwZANtnvnrNpNL2g2n19yKo0Vd1MJRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhbRcupQWVJ91b9cTtxRvdJvEhwGPGFVvuc/IpXRjK8=;
 b=N2zvN8Z9C+O1SJP/allo7D0NQAR2muvSM9UpAf5kMu9ybRRjyutQ/rcOxUcpEOL5ljwSxFs0FDZPREqTDuQLmVcP0Zzm+ZWHKviH+5S7rLTm0MoR813TsjO0p4v1198X+JJCBp7uIj61f6VcJpvn43JfgJsdWpC0bpAcHmQY4zg+eNWlGsufB1orupbrxVOtsIAUFPbZTgx5aanvXYCr0mWg6Nf9SrwmfJ3T3nK7eIeOV3tqKKvbeYJA3BoOZsmg7pvFcTcWf4HdxdYxNHbZGxoFUG79oKDA2bU7WoOxr/cTvRbc6/cHoU/5qC7F53tshDr94giE+dcoOmJBCjzLqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BN6PR1101MB2355.namprd11.prod.outlook.com (2603:10b6:404:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Thu, 14 Jul
 2022 14:19:42 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6%5]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 14:19:42 +0000
Date:   Thu, 14 Jul 2022 07:19:33 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Li, Ming" <ming4.li@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V13 3/9] PCI: Create PCIe library functions in support of
 DOE mailboxes.
Message-ID: <YtAl9WlqbiCFslcD@iweiny-desk3>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
 <20220705154932.2141021-4-ira.weiny@intel.com>
 <62cf8aa560ecf_1643dc2945c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62cf8aa560ecf_1643dc2945c@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::34) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9100611e-df05-4cd6-9a18-08da65a3e4a2
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2355:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8snP5PMrvCaQ5tDJAZNU1qwlY+HqP3w+x1SFavxkoML6F5APMwnSBUlijFeEKSwE42e8wyKS538H/Qb8Jj09Rnhn/mIWFvYZAFseXJ9QrU23TX2Q8o+JYWClRsyC+xlNT4gCVwNgElmNNT7eAZVW/gQor3odwb9VUwGUa2HLYED78gC2M1bnoPpDxQDYjH6CZAul5Lo0/gtGg1PEvhdO7j7W77wUviJXifekhGZsNVOGK98dgTTV0/ocQ+GR+/rMslumHY81Djoo0T8wiFA9avW5ISwMDFklLaXmxTuW3H5Uu+Q68I6MjUHmQU1YPj5xT+rbsJNoqTM5AW8x7Xyo5A9qS3VJzGDNGKhDgSfy38WoSA+tKS6+Vk62LZi0aZCTbMUf1ZxZY8m4m8yL2Uyp0TYUY8gNh6KGby4kqAPahGkQY7vnMg5Kd+I0/kOj9UOxKKjOEa92+lX7Ra4OreJf9cKcHGlEmpYCk6oHxjsUZAq0j/RU3GeWzGB5x3nBnazulvzEl3WOX1QcPnploKxfaIUkTe+p8+abJXRC+psh7hlaHMKi8TjfCFAb6Ux8ILZt++8hF/PTk4yxsQghnZi6xoE2lxD1/OjRZgDnDPwRp2U4tMrUXoSYUeKW+uKhpF5aebLRQJ7L6SIxsF77zvftFmvEe0ZgJuUbfLCSNpq+YSzMD0JNmdp1boe3hHoPgwjx5eEYAfhDN4jbg0iQwytrzdOFg7ZG3GAwbpJD/NReP3WBrPnQY5Xdz6qgStNDDG2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(376002)(136003)(346002)(366004)(396003)(15650500001)(38100700002)(2906002)(82960400001)(5660300002)(86362001)(8936002)(6862004)(44832011)(54906003)(6636002)(6506007)(66946007)(66556008)(6512007)(9686003)(478600001)(6666004)(41300700001)(316002)(6486002)(66476007)(33716001)(83380400001)(186003)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QxmUJuHJKntgfn/Vc2r1h7iotU2qmReDygO1ugPC4cNFNOSN0hOSAEZYDCtV?=
 =?us-ascii?Q?LhrE1BVpwrF5F+/PNqYXo177zoBC9rVa1kK7KMTUFlLo9ZnGVC8cTdWtsL5O?=
 =?us-ascii?Q?1T2DnLrojV3el2Id5SzGQX5odMWTNCIPEm1Sr+sVlkJ+GHnHtfRKtApHGuuh?=
 =?us-ascii?Q?E63dwQ6Uy+A4gECyuJhqRgsy/mE1+XmN8o7COmOXxTzJhwBlETBzsLaKW06x?=
 =?us-ascii?Q?u7CDkqOcmac5x2yhw7SjTXwmuauyP4GJjl0EP80X6slql156G6KINYViDIGt?=
 =?us-ascii?Q?HUqNGFUG4CTUZw2O/5a2LYK8R0ku75RdLhgSgML5D0voI97XC2crBoINHtLp?=
 =?us-ascii?Q?v/GbV0E30kqwTxDheTm/QlK83RJHA3NTLlLI/DBhTMVN8HoF/BXakDnXK3Sa?=
 =?us-ascii?Q?5Rh6giohElQ0GustB0vpbmKVc5KwsXmhotYZc3Kn2IHxTe2Il309seS8S8h6?=
 =?us-ascii?Q?GAIsZw6s66/g2skVAslotxq3+TDMx0s133CYX9J62PfQ1MhJOzrIJAtZQJjz?=
 =?us-ascii?Q?Iil2c0HNdj1UE9o9GSSpvuBabB2IlMpuwH7B3NgoIrsUHhnt/I+ffgb3HzNA?=
 =?us-ascii?Q?s4QefSi/wASl8Bo02GvHA0emQUcVVlY0je6B8kc04PH+A3j+XeVu1NDm+WH1?=
 =?us-ascii?Q?RUhQFTWehYSCD+2jxRBG0ajgP8fcoqLU32of0j00UDYSC0lSlcm36h4XFl12?=
 =?us-ascii?Q?pzjc38rTiUJfpCH0PSsGCUXzzbgQcWZjET8WvBUigO05ffnCYUT/c7pDGUBK?=
 =?us-ascii?Q?gmVXb3CLTXgVRBoi8DcOhRmunqA1BeMw7tf3rioL2uISd1ZMUNX5pqf0nQ8R?=
 =?us-ascii?Q?wAE1dy7PVn2ozHjPODtEXN+wwOmomQup9RZU+CN4bvLLe5mp3am5E6mJU+MF?=
 =?us-ascii?Q?O56bKYLKw2keBEqEHMoRXHdjagBvhyneWFQHdJsZjndmiQtJwjBMV7ExU4sW?=
 =?us-ascii?Q?qp/DSaALUJMOakG93NsI3Q1OtlOr2u1Ic0erbYgMmKRcSyBKf3lVyu5WQV/Q?=
 =?us-ascii?Q?S06Wc5bVq8uWB+Te0qhTMPE8qT9FE78leum02Vr8/BjmlXuLr20itiC5vrRk?=
 =?us-ascii?Q?3VWolviPcmm/H7oklw61mVxV1RZPyVFSAzg3Ep4g2cBtR4cQOe3qrPSqi/A+?=
 =?us-ascii?Q?aK9RnLUkMC4uaq6XWXMbkN//os+YY73jmr+ZBCj9rUaK5aTZ48KHX5om6uqD?=
 =?us-ascii?Q?yCYZSCtRPs4wMXV8l60l/g8FpPcM9IHaS/Z1Tp0uHvd8jptu97avP0LG3hwK?=
 =?us-ascii?Q?T34bYXu2dSl/C7o3BhArUp8OsiV61/gVf87eUXbpipTdbh4AM8NR8vDrsWnT?=
 =?us-ascii?Q?pAHT9fd4sW9/bAanVmDIXm88yZQBhqSrfV72PIynSSjrgyUn4Rb/63dnBFt+?=
 =?us-ascii?Q?PZI5ZY7Yh6hDye4XC6yXEmkdUm2huCa/AArExPmn+PlM8rlby5ck02llTetB?=
 =?us-ascii?Q?uhMeQDuQje+4QyTLeBTmfrqUnP+OfNCd9wpfQngeTFRwvWs/blh7WOl9SfU+?=
 =?us-ascii?Q?u5D8D+AxCvGHflHzrxxT+AzL0CeFLNt6+9DJCrXV/rt6hUrJt0soQiWrKvAK?=
 =?us-ascii?Q?CLDzV5x40dKrcjjhStMYLQ/jdRmAsm8IFVPFYr05fSW/qdTNUReyRVME8fzE?=
 =?us-ascii?Q?edaNlFNBi7aNoeplMJ33QX+mEtN8wouaYG/EXbIfvtgV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9100611e-df05-4cd6-9a18-08da65a3e4a2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 14:19:41.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5I85Dr9GDDox8Wz58d9UavjBuKINoLiV4yU0Klbukk42wxPRT3xUMyhccjoJTJFP22qKB6Sa4e2qc9ySBeOKYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2355
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 13, 2022 at 08:16:53PM -0700, Dan Williams wrote:
> ira.weiny@ wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 

[snip]

> > +
> > +static int pci_doe_abort(struct pci_doe_mb *doe_mb)
> > +{
> > +	struct pci_dev *pdev = doe_mb->pdev;
> > +	int offset = doe_mb->cap_offset;
> > +	unsigned long timeout_jiffies;
> > +
> > +	pci_dbg(pdev, "[%x] Issuing Abort\n", offset);
> > +
> > +	timeout_jiffies = jiffies + PCI_DOE_TIMEOUT;
> > +	pci_doe_write_ctrl(doe_mb, PCI_DOE_CTRL_ABORT);
> > +
> > +	do {
> > +		u32 val;
> > +
> > +		if (pci_doe_wait(doe_mb, PCI_DOE_POLL_INTERVAL))
> > +			return -EIO;
> 
> nit, why translate the pci_doe_wait() return value? Not worth respinning
> just for this though.

Ok.

[snip]

> > +static int pci_doe_recv_resp(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > +{
> > +	struct pci_dev *pdev = doe_mb->pdev;
> > +	int offset = doe_mb->cap_offset;
> > +	size_t length, payload_length;
> > +	u32 val;
> > +	int i;
> > +
> > +	/* Read the first dword to get the protocol */
> > +	pci_read_config_dword(pdev, offset + PCI_DOE_READ, &val);
> > +	if ((FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val) != task->prot.vid) ||
> > +	    (FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val) != task->prot.type)) {
> > +		pci_err(pdev,
> > +			"[%x] expected [VID, Protocol] = [%04x, %02x], got [%04x, %02x]\n",
> > +			doe_mb->cap_offset,
> > +			task->prot.vid, task->prot.type,
> > +			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_VID, val),
> > +			FIELD_GET(PCI_DOE_DATA_OBJECT_HEADER_1_TYPE, val));
> 
> Is this an error that happens when userspace collides DOE accesses with
> the kernel? Or is this a "*should* never happen" error?
> 
> If this has the potential to spam the log it probably deserves to be
> pci_err_ratelimited() (dev_err_ratelimited()).
> 
> ...but just a question not a request to change.

I was originally viewing other actors as BIOS or something like an FM.  But
thinking about it yea userspace could be poking at this.

Of course we still need to close on restricting user space access.

Yes, ratelimited would be best.

[snip]

> > +static void signal_task_abort(struct pci_doe_task *task, int rv)
> > +{
> > +	struct pci_doe_mb *doe_mb = task->doe_mb;
> > +	struct pci_dev *pdev = doe_mb->pdev;
> > +
> > +	if (pci_doe_abort(doe_mb)) {
> > +		/*
> > +		 * If the device can't process an abort; set the mailbox dead
> > +		 *	- no more submissions
> > +		 */
> > +		pci_err(pdev, "[%x] Abort failed marking mailbox dead\n",
> > +			doe_mb->cap_offset);
> 
> Feels like a dev_dbg(), no?

No.  If this happens we are stopping all processing on the mailbox.  So I think
it needs to be an error such that the admin knows what happened.

> 
> > +		set_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags);
> > +	}
> > +	signal_task_complete(task, rv);
> > +}
> > +
> > +static void doe_statemachine_work(struct work_struct *work)
> > +{
> > +	struct pci_doe_task *task = container_of(work, struct pci_doe_task,
> > +						 work);
> > +	struct pci_doe_mb *doe_mb = task->doe_mb;
> > +	struct pci_dev *pdev = doe_mb->pdev;
> > +	int offset = doe_mb->cap_offset;
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
> > +	rc = pci_doe_send_req(doe_mb, task);
> > +
> > +	if (rc) {
> > +		/*
> > +		 * The specification does not provide any guidance on how to
> > +		 * resolve conflicting requests from other entities.
> > +		 * Furthermore, it is likely that busy will not be detected
> > +		 * most of the time.  Flag any detection of status busy with an
> > +		 * error.
> > +		 */
> > +		if (rc == -EBUSY) {
> > +			pci_err(pdev,
> > +				"[%x] busy detected; another entity is sending conflicting requests\n",
> > +				offset);
> 
> This definitely feels like something that needs to be ratelimited.

I think you are right with the potential for user space to be poking at the
registers.

[snip]

> > +
> > +static int pci_doe_cache_protocols(struct pci_doe_mb *doe_mb)
> > +{
> > +	u8 index = 0;
> > +	u8 xa_idx = 0;
> > +
> > +	do {
> > +		int rc;
> > +		u16 vid;
> > +		u8 prot;
> > +
> > +		rc = pci_doe_discovery(doe_mb, &index, &vid, &prot);
> > +		if (rc)
> > +			return rc;
> > +
> > +		pci_dbg(doe_mb->pdev,
> > +			"[%x] Found protocol %d vid: %x prot: %x\n",
> > +			doe_mb->cap_offset, xa_idx, vid, prot);
> > +
> > +		rc = xa_insert(&doe_mb->prots, xa_idx++,
> > +			       pci_doe_xa_prot_entry(vid, prot), GFP_KERNEL);
> > +		if (rc)
> > +			return -ENOMEM;
> 
> Why translate the xa_insert() return value when xa_insert() can also
> report -EBUSY?

By definition there will never be a entry present because xa_idx is being
incremented.  But I think you are correct on principle that it is best to let
the error flow up.  Especially if this call is ever used for other purposes.

[snip]

> > +
> > +/**
> > + * pcim_doe_create_mb() - Create a DOE mailbox object
> > + *
> > + * @pdev: PCI device to create the DOE mailbox for
> > + * @cap_offset: Offset of the DOE mailbox
> > + *
> > + * Create a single mailbox object to manage the mailbox protocol at the
> > + * cap_offset specified.
> > + *
> > + * RETURNS: created mailbox object on success
> > + *	    ERR_PTR(-errno) on failure
> > + */
> > +struct pci_doe_mb *pcim_doe_create_mb(struct pci_dev *pdev, u16 cap_offset)
> > +{
> > +	struct pci_doe_mb *doe_mb;
> > +	struct device *dev = &pdev->dev;
> > +	int rc;
> > +
> > +	doe_mb = devm_kzalloc(dev, sizeof(*doe_mb), GFP_KERNEL);
> > +	if (!doe_mb)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	doe_mb->pdev = pdev;
> > +	doe_mb->cap_offset = cap_offset;
> > +	init_waitqueue_head(&doe_mb->wq);
> > +
> > +	xa_init(&doe_mb->prots);
> > +	rc = devm_add_action(dev, pci_doe_xa_destroy, doe_mb);
> > +	if (rc)
> > +		return ERR_PTR(rc);
> > +
> > +	doe_mb->work_queue = alloc_ordered_workqueue("DOE: [%x]", 0,
> > +						     doe_mb->cap_offset);
> 
> I don't see much in the way of end user useful information in that name.
> Not that the thread names matter all that much, but for debug it might
> be nice to be able to tie queue threads back to the corresponding
> device. So maybe put the PCI device name and dev_driver_string() in the
> name?

Good point.  I got too used to the pci_* calls including that.

[snip]

> > +
> > +/**
> > + * pci_doe_submit_task() - Submit a task to be processed by the state machine
> > + *
> > + * @doe_mb: DOE mailbox capability to submit to
> > + * @task: task to be queued
> > + *
> > + * Submit a DOE task (request/response) to the DOE mailbox to be processed.
> > + * Returns upon queueing the task object.  If the queue is full this function
> > + * will sleep until there is room in the queue.
> > + *
> > + * task->complete will be called when the state machine is done processing this
> > + * task.
> > + *
> > + * Excess data will be discarded.
> > + *
> > + * RETURNS: 0 when task has been successful queued, -ERRNO on error
> > + */
> > +int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > +{
> > +	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * DOE requests must be a whole number of DW
> > +	 * and the response needs to be big enough for at least 1 DW
> > +	 */
> > +	if (task->request_pl_sz % sizeof(u32) ||
> > +	    task->response_pl_sz < sizeof(u32))
> > +		return -EINVAL;
> > +
> > +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
> > +		return -EIO;
> > +
> > +	task->doe_mb = doe_mb;
> > +	INIT_WORK(&task->work, doe_statemachine_work);
> 
> Would be nice to move all init to the callers and, similar to
> submit_bio(), rely on the task already knowing all its submit
> parameters.

That could work.  But I think that is awkward.  doe_statemachine_work() is not
exported and is an internal implementation detail of the way the MB processes
the task.  The doe_mb parameter could be set up.  But again seems safer to deal
with it here.

I thought about wrapping struct pci_doe_task with an internal structure but it
seemed overly complex.

> Can be a follow-on cleanup.

Maybe I'll wrap struct pci_doe_task with an internal structure as a follow on.

[snip]

> > 
> 
> Hey, this looks pretty good, thanks for all the hard work on this.

I'll spin soon thanks,
Ira

