Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C532594EA9
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 04:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiHPC2a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Aug 2022 22:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiHPC2N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Aug 2022 22:28:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB002728FD;
        Mon, 15 Aug 2022 15:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660603413; x=1692139413;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PhHwNmp9SCxFqvsJrs3OlTbnj9kJs1xFFTBfUuxKPHw=;
  b=O6w8PWcm1Ak1psqDEbw0T+C/WOKkv5cR/5gDNjsCvGmLsBjR9XbKzt98
   fyfJjRrCueIrVdAOQWgIRxxTCLqbeBca1v6hqohIlU3tzXRTOeMvmV/VP
   NolBLx6RDa2kGij60KpglAxXLb2uK0vZ/AkMo/nQmB9SCldXk93c0XVv+
   r4trLWSjgFbDIyU9LhfUeR2TZXhoiHiZEWdRWyXgeMSFsLjNbs05POHJM
   c6YRNtjFdgqUWP/14uCjh1zE25BefVXrArrP8egXRf7OExEHfVHQ/ccOI
   edWcbcx/F+opa+vD5Vqxn2ZK3xPm1R59q99kZSj72fFiRqruLblYVwREt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="272464457"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="272464457"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 15:43:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="674984532"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 15 Aug 2022 15:43:04 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 15:43:03 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 15:43:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 15:43:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 15:43:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCZHkui/5ycn1O8bKWJ1o/L8RpHRvbq9O5I5zOImBeThBXjXm6iDnkzSbwLj7ubMpL6Y/K4RLkUWQdjQK7exCYCM+wsmN//zyQe+G/HKbHJntaC+PjQHnWgOQ6hYTyprC5nRaFuNgN7kXaYzWey1sVu1ArwcuwNfBn1ceu9fgyP5pq7aL3ffP9gbn8klwDJASGzmTAy8sIcEQ7AxZVnIbVDo3tWpWaFwI9RjiAmkaUTaghPyRz+yp1ZS3zsifPaMXHmLfPysF8YTVARw+8nzu3QaVOQeW5Uxf0nsbWwbHaZ0L4dyKVPRkYeDY3OzFZ/CwBlGEbdTy4UziulwV8cVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHxoE0YjhCgN9rwPYWRMCuNBBhKQt3Jiy5cgQ9s1MnQ=;
 b=WwWwI8UHnL0PYufCh1vG7zJ92K1a2OW6EeEoejnc7v8AVwugHPcxf20ilt+XlbwnDbSFvoPBG+fsoJBXVi9xk+VmhMQ5/mBuGV8jxRlizurxnBw83MWgEDzfMu68R6XJR95qM0Z7d0lq/t4kgMMXUgMkZ9p6/e86NKHngDGIrxJJ6u2H5pOw0e2nlCfDNfkxlyjDToC8sQjmSpyhB3b3f5klxSBRwn7VbtSZ3zl2/Bfo+bdKSmdfrLi6oO0p4AGCj7jXCFgh+Pj4TEwW2v23/tHZuAskieJvcBLbTl1eHwEcnnKhcfIBtZ1AeOYWebkTFmBFCjEYOPwNFDMVF+XrPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM4PR11MB6213.namprd11.prod.outlook.com
 (2603:10b6:8:ae::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Mon, 15 Aug
 2022 22:43:01 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 22:43:00 +0000
Date:   Mon, 15 Aug 2022 15:42:57 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Li, Ming" <ming4.li@intel.com>
CC:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Matthew Wilcox" <willy@infradead.org>,
        Lukas Wunner <lukas@wunner.de>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V16 3/6] PCI/DOE: Add DOE mailbox support functions
Message-ID: <62facbf166698_dfbc1294ad@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220719205249.566684-1-ira.weiny@intel.com>
 <20220719205249.566684-4-ira.weiny@intel.com>
 <a3f72cdd-884d-efa1-89e8-f9d6660bf760@intel.com>
 <20220815105038.00000336@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220815105038.00000336@huawei.com>
X-ClientProxiedBy: BYAPR01CA0062.prod.exchangelabs.com (2603:10b6:a03:94::39)
 To MWHPR1101MB2126.namprd11.prod.outlook.com (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 960048cc-0002-4df9-4927-08da7f0f81d0
X-MS-TrafficTypeDiagnostic: DM4PR11MB6213:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NOHzI8IsAuQPoZFMdTMYxT8kujEYk/XvEEWqcOwZryBDmjtq1KsUmnMwD16YxeMVbXAH9D8giq12/n5Yv4RZ78wcQvITYo+rVr+SZTgAZtGHvZ6GdXmmN6JlOQysT163AZ2oVZN58qEHjaPp8D++exPLrP1AD9Qw1+7HGzdBdk+MAJZZupn++T+7uYE2I8iR6QqNCF+Aj08odnUskf2tg/fI/ojy8NFHMr2mnOiL3LMa8ULi5wxCBIsYtZi2IfPwVEGSjvQpSHtgtGHQHimFhc0eE2lbodQ+ebxelW+j4mYm2qVs8uSbcJqcVS7dOuyTRQGCrqyFNALpMLa9Adwqf818yQsccFlXNfpNS4VRv87K6JkpIFMmfaSZelf4l9TXBot1TbeLi2hnTobGqWeU3rXCNNpgU2OBdf7ZtP6JWGf4o131hqtgIcJrV6jnAUa9ZIpJAdA1LIXb1bmuEsLjeWKUynmJ/IFqlaHZVN7MHgZhTib7M0QXT1uteSVwi9ZcWHuNQKvvz/OiFoWyk1ftZqhTHgqV286+Pm62J1klEmcSuu6yIPLJQJBG7gmLEyzZvxWlNUsb4ynatiDnVTDi1FjIRm2FGl/PGH8uzuXIEG5yo4Y8D5a/ucd7hQO/W081domZcIcUSu7HBQPoEgM6PkJsMTDIWw3NEmygAD7Iomgip87U5kMa7zmVF08gw46v5HcQCykfUc2UOreEaPnsZ7Yt0gYl4RQOM/fhjSpm8VMI+TG6/M/ty0K0iC1TgOx3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(396003)(346002)(136003)(366004)(6506007)(8676002)(86362001)(9686003)(4326008)(26005)(478600001)(38100700002)(6486002)(6512007)(41300700001)(6666004)(53546011)(83380400001)(186003)(2906002)(15650500001)(8936002)(82960400001)(5660300002)(6636002)(54906003)(316002)(110136005)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w1QXbvrh9pkDZqC8D6tg34mBxlxJgfqBcrvaOn7V+xQloA/Sk3iXjwlM91J8?=
 =?us-ascii?Q?i+8XilYXbc4JkwFfGafXcFMT8uRtKO9uDzJc4+BNrQSeaM5jikYFqR6bSXPO?=
 =?us-ascii?Q?j+8SfcWNJF6LY9cp05wGuYw7THO1WSE3ZmrCFHc2CfveUimhKJniuCmwAQRc?=
 =?us-ascii?Q?teyoZlaPRPij6R2Jx4pVTAhclCyq7Fg3UOyiX+f2ML+A6GzokwV/WLRZEdjW?=
 =?us-ascii?Q?fnwrEKnhyY55fhL9nu6xH0JfVPN2Nop3cO2TGRd2dWaA/w2sicY0XWtPU2RV?=
 =?us-ascii?Q?GLFJ4bN2YkajLJA2IHH2JkONYnA+759kon5lk378/HA0kR1CZT8QpYx3texZ?=
 =?us-ascii?Q?rJrTNiHmKdObQ00WSOf0QM9xVeXNhZ1Q/axNC9/KjsWQdlbM1kCbdQj1kS9J?=
 =?us-ascii?Q?dIbcl0IVK7nSKVPFukbLonQJpe6dYXtP7ZkpcHJmHywZ65Kctd73gSOxsyJx?=
 =?us-ascii?Q?dG+n36ro5VdlUDpwBmhiTVGJWOM/y6hbimUYpMN9vrX3ga0gNmIufJRJNgQQ?=
 =?us-ascii?Q?HLQGuDfrNdxYg36Vyo66Nm6P7+8O8FQZRK9TOfbAZ0UTqQOPsSBzQxcawKIs?=
 =?us-ascii?Q?fDTNDkj4zci36wUh97b8GbJgL3/aaVBkx7YPRj8+Qq8FIsB7k3jo2PO8Npng?=
 =?us-ascii?Q?80vfEKeoLNJ78Wx+oKZljJ7b2MlYluT98qt6jvmpKDMSgjFsZp0MNHqzllux?=
 =?us-ascii?Q?m6CPeIJvl+ioIbQl/sJjXSG72lG5oYFo47fQk6Xg6C6SHem+/jqdrLNOhRKS?=
 =?us-ascii?Q?4sF184fsaQ29MZCMb6XqhgFvV0wtB1vUC0YPT4tE6IC3s+OjriJt7Q8Nf+ra?=
 =?us-ascii?Q?69D5kA3pZJjiYLS46y1+U18vkJTjI8sFJabDKgdslfmUiKTQZBjW1qHoSzxr?=
 =?us-ascii?Q?RySHWmAITJhuomA5aeeiMQdiVeotJU/sIHdWS8cu0SRZLmgtNgFUvvoDFvhp?=
 =?us-ascii?Q?GhWWOdPMcbYoH3jlO2ViZW3ytFxh3dBbbXiiqvfOP4cDoWBNLxFq11Os/EVZ?=
 =?us-ascii?Q?DM+4tClbHzRNinhOOuQWmd1l5ws4JRpzN3I1P1R974PxYGtghIqskISNM56V?=
 =?us-ascii?Q?Aq4eZdDNfG2MC5zFzX8JMw0136b8dcBRoQMvEG0D6cvG5L29g07EfIua5FFw?=
 =?us-ascii?Q?v3xGmLbVkY7i3UcHAdtU0Z2FURdRgaAkOUyFGoPEvKwZTHIJA5xIqXW+QIHd?=
 =?us-ascii?Q?T61tbYiuZ9NX2Z/Y1JbibyM+LnTj87x7AEK1pvahUlbnfkZf+Mz9EXoyY0v3?=
 =?us-ascii?Q?RH0/ndcS9zjpzIR35k23C7pzuY2pB27vsWX8X0GIOOP2urkug9bLPSsbtFZi?=
 =?us-ascii?Q?JPHNtlBLStpCdlUUy3QdoxTn0EaIUCVYOB5ns9rbNfSzPZ+qwRXZ6WNrkXv6?=
 =?us-ascii?Q?D1MwuF9UQOg45BGu1lYZe3Ej+12L8eUBXr5+m49lF7Kw02/xwqTU/g1xG2cJ?=
 =?us-ascii?Q?eGu+XUjmWbci+903W0RSz5vkmNHHrdpor+IiPrnj8hR2EYVDGfu3THtnHmkr?=
 =?us-ascii?Q?q4ATGONkGMQ5Vevzma5FwsR/2kKtxj++jIc/VnpBZ4whJ+DYa5CsdJ4KZvWq?=
 =?us-ascii?Q?Lhm+GVIW3iYr4Vmal0xiZ7z23wyyUKeNFIgI4IH+etviV/2HEMihvtS7LL7k?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 960048cc-0002-4df9-4927-08da7f0f81d0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 22:43:00.7213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1j1OaKRP4gTzd2XxRD+30VVczT5wbjgaQcsGjrvh52F+UZGysynvCcuX5Jcu3sdAuHCYSh2/LoNLSqa+emuhvArz80q+k2IBN4wb8uS048=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6213
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jonathan Cameron wrote:
> On Mon, 15 Aug 2022 10:17:00 +0800
> "Li, Ming" <ming4.li@intel.com> wrote:
> 
> > On 7/20/2022 4:52 AM, ira.weiny@intel.com wrote:
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Introduced in a PCIe r6.0, sec 6.30, DOE provides a config space based
> > > mailbox with standard protocol discovery.  Each mailbox is accessed
> > > through a DOE Extended Capability.
> > > 
> > > Each DOE mailbox must support the DOE discovery protocol in addition to
> > > any number of additional protocols.
> > > 
> > > Define core PCIe functionality to manage a single PCIe DOE mailbox at a
> > > defined config space offset.  Functionality includes iterating,
> > > creating, query of supported protocol, and task submission.  Destruction
> > > of the mailboxes is device managed.
> > > 
> > > Cc: "Li, Ming" <ming4.li@intel.com>
> > > Cc: Bjorn Helgaas <helgaas@kernel.org>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Acked-by: Bjorn Helgaas <helgaas@kernel.org>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > ---  
> > 
> > > +/**
> > > + * pci_doe_submit_task() - Submit a task to be processed by the state machine
> > > + *
> > > + * @doe_mb: DOE mailbox capability to submit to
> > > + * @task: task to be queued
> > > + *
> > > + * Submit a DOE task (request/response) to the DOE mailbox to be processed.
> > > + * Returns upon queueing the task object.  If the queue is full this function
> > > + * will sleep until there is room in the queue.
> > > + *
> > > + * task->complete will be called when the state machine is done processing this
> > > + * task.
> > > + *
> > > + * Excess data will be discarded.
> > > + *
> > > + * RETURNS: 0 when task has been successfully queued, -ERRNO on error
> > > + */
> > > +int pci_doe_submit_task(struct pci_doe_mb *doe_mb, struct pci_doe_task *task)
> > > +{
> > > +	if (!pci_doe_supports_prot(doe_mb, task->prot.vid, task->prot.type))
> > > +		return -EINVAL;
> > > +
> > > +	/*
> > > +	 * DOE requests must be a whole number of DW and the response needs to
> > > +	 * be big enough for at least 1 DW
> > > +	 */
> > > +	if (task->request_pl_sz % sizeof(u32) ||
> > > +	    task->response_pl_sz < sizeof(u32))
> > > +		return -EINVAL;
> > > +
> > > +	if (test_bit(PCI_DOE_FLAG_DEAD, &doe_mb->flags))
> > > +		return -EIO;
> > > +
> > > +	task->doe_mb = doe_mb;
> > > +	INIT_WORK(&task->work, doe_statemachine_work);
> > > +	queue_work(doe_mb->work_queue, &task->work);
> > > +	return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(pci_doe_submit_task);  
> > 
> 
> > I'm curious why there is not a sychronous function for DOE users. I
> > think some protocols over DOE need a DOE sychrounous interface(e.g.
> > SPDM, TDISP, IDE...). These protocols have to implement an sychronous
> > function over pci_doe_submit_task() by themselves, maybe we can
> > implement an generic sychronous function in PCI/DOE for these DOE
> > users.
> 
> This came up during discussions of earlier versions of the series.
> IIRC we decided to postpone adding a synchronous wrapper function
> until there were more use cases.

Note that as far as I can see TDISP makes no requirement of the VMM nor
TVM (trusted VM) to drive an SPDM session. All of that is handled by the
TSM (TEE / Platform Security Manager) where the VMM is outside the trust
boundary. The TVM only validates the contents of a
GET_DEVICE_INTERFACE_REPORT which the TSM had negotiated with the DSM
(Device Security Manager).

All this to say its not clear that Linux needs to grow the capabilities
listed above when it is expected to be outside the Trusted Compute
Boundary.
