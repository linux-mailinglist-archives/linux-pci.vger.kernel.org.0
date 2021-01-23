Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D23F301183
	for <lists+linux-pci@lfdr.de>; Sat, 23 Jan 2021 01:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbhAWAQ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jan 2021 19:16:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:39737 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbhAWAOy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Jan 2021 19:14:54 -0500
IronPort-SDR: z3MJtM6PSHWL0U3Kw5DnTfxEx8Dxm4BIDW4uALIuhNJzK08s2Shlk0Dwa8d4jAno8cN1wjOxIT
 Nj5IbMdQStGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="179672180"
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="179672180"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 16:14:12 -0800
IronPort-SDR: N5kp8Xf4PuIgr1k1zffyDukM7ZhAjh3Bm8v1TU3l63SII4HFzrPCh1KaBbD/rf8AOvEVPlbBdq
 9vOhpzUgVJZg==
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="367639894"
Received: from mdabbott-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.131.138])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 16:14:12 -0800
Date:   Fri, 22 Jan 2021 16:14:10 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com
Subject: Re: [RFC PATCH v3 15/16] cxl/mem: Add limited Get Log command (0401h)
Message-ID: <20210123001410.hbcotbj2gz3iypek@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
 <20210111225121.820014-17-ben.widawsky@intel.com>
 <20210114180826.000072f0@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114180826.000072f0@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-01-14 18:08:26, Jonathan Cameron wrote:
> On Mon, 11 Jan 2021 14:51:20 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > The Get Log command returns the actual log entries that are advertised
> > via the Get Supported Logs command (0400h). CXL device logs are selected
> > by UUID which is part of the CXL spec. Because the driver tries to
> > sanitize what is sent to hardware, there becomes a need to restrict the
> > types of logs which can be accessed by userspace. For example, the
> > vendor specific log might only be consumable by proprietary, or offline
> > applications, and therefore a good candidate for userspace.
> > 
> > The current driver infrastructure does allow basic validation for all
> > commands, but doesn't inspect any of the payload data. Along with Get
> > Log support comes new infrastructure to add a hook for payload
> > validation. This infrastructure is used to filter out the CEL UUID,
> > which the userspace driver doesn't have business knowing, and taints on
> > invalid UUIDs being sent to hardware.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> Just a minor question for this one.
> 
> Thanks, J
> ...                                              \
> > @@ -515,6 +529,15 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev *cxlmd,
> >  	int rc;
> >  
> >  	if (cmd->info.size_in) {
> > +		if (cmd->validate_payload) {
> > +			rc = cmd->validate_payload(u64_to_user_ptr(in_payload),
> > +						   cmd->info.size_in);
> 
> Is it worth moving this out of the region in which we hold the mbox?
> (after fixing the bug that I think means we don't actually hold it at this point)
> 
> Perhaps not, but it does feel odd to do validation under the lock.
> 
> 

When moving to a bounce buffer the locking resolves itself and ultimately this
doesn't happen under lock anymore.


        if (cmd->info.size_in) {
                if (cmd->validate_payload) {
                        rc = cmd->validate_payload(u64_to_user_ptr(in_payload),
                                                   cmd->info.size_in);
                        if (rc)
                                goto out;
                }

                mbox_cmd.payload_in = kvzalloc(cmd->info.size_in, GFP_KERNEL);
                if (!mbox_cmd.payload_in) {
                        rc = -ENOMEM;
                        goto out;
                }

                if (copy_from_user(mbox_cmd.payload_in,
                                   u64_to_user_ptr(in_payload),
                                   cmd->info.size_in)) {
                        rc = -EFAULT;
                        goto out;
                }
        }

	rc = cxl_mem_mbox_get(cxlm, true);

> > +			if (rc) {
> > +				cxl_mem_mbox_put(cxlmd->cxlm);
> > +				return -EFAULT;
> > +			}
> > +		}
> > +
> >  		/*
> >  		 * Directly copy the userspace payload into the hardware. UAPI
> >  		 * states that the buffer must already be little endian.
