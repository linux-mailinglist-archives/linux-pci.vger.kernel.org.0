Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E634D30CFAF
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 00:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbhBBXJW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 18:09:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:15680 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236289AbhBBXJR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 18:09:17 -0500
IronPort-SDR: YSXWVtQ8t/oOfO8uqMp6VPr2erN29afTqwzsJlPmF1b9/LcCOfxb5tmQMT4dEk1C0Y+EJhFgii
 ptr2P+R2nPGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="178387793"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="178387793"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 15:08:32 -0800
IronPort-SDR: uvrOannQqhqlOwrNnhCC1hvrm+4Xaz4XoWFfXifM9FKmsSIw6EhYpJCdn/HNAfJ/c8FF94qDis
 TMF+mDTxUshg==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="391916200"
Received: from aisallax-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.131.184])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 15:08:31 -0800
Date:   Tue, 2 Feb 2021 15:08:29 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        daniel.lll@alibaba-inc.com,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 07/14] cxl/mem: Add send command
Message-ID: <20210202230829.sondt7xrpixpv7vz@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
 <20210130002438.1872527-8-ben.widawsky@intel.com>
 <20210201181535.GI197521@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201181535.GI197521@fedora>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-01 13:15:35, Konrad Rzeszutek Wilk wrote:
> > +/**
> > + * struct cxl_send_command - Send a command to a memory device.
> > + * @id: The command to send to the memory device. This must be one of the
> > + *	commands returned by the query command.
> > + * @flags: Flags for the command (input).
> > + * @rsvd: Must be zero.
> > + * @retval: Return value from the memory device (output).
> > + * @size_in: Size of the payload to provide to the device (input).
> > + * @size_out: Size of the payload received from the device (input/output). This
> > + *	      field is filled in by userspace to let the driver know how much
> > + *	      space was allocated for output. It is populated by the driver to
> > + *	      let userspace know how large the output payload actually was.
> > + * @in_payload: Pointer to memory for payload input (little endian order).
> > + * @out_payload: Pointer to memory for payload output (little endian order).
> > + *
> > + * Mechanism for userspace to send a command to the hardware for processing. The
> > + * driver will do basic validation on the command sizes. In some cases even the
> > + * payload may be introspected. Userspace is required to allocate large
> > + * enough buffers for size_out which can be variable length in certain
> > + * situations.
> > + */
> I think (and this would help if you ran `pahole` on this structure) has
> some gaps in it:
> 
> > +struct cxl_send_command {
> > +	__u32 id;
> > +	__u32 flags;
> > +	__u32 rsvd;
> > +	__u32 retval;
> > +
> > +	struct {
> > +		__s32 size_in;
> 
> Here..Maybe just add:
> 
> __u32 rsv_2;
> > +		__u64 in_payload;
> > +	};
> > +
> > +	struct {
> > +		__s32 size_out;
> 
> And here. Maybe just add:
> __u32 rsv_2;
> > +		__u64 out_payload;
> > +	};
> > +};
> 
> Perhaps to prepare for the future where this may need to be expanded, you
> could add a size at the start of the structure, and
> maybe what version of structure it is?
> 
> Maybe for all the new structs you are adding?

Thanks for catching the holes. It broke somewhere in the earlier RFC changes.

I don't think we need to size or version. Reserved fields are good enough near
term future proofing and if we get to a point where the command is woefully
incompetent, I think it'd be time to just make cxl_send_command2.

Generally, I think cxl_send_command is fairly future proof because it's so
simple. As you get more complex, you might need better mechanisms, like deferred
command completion for example. It's unclear to me whether we'll get to that
point though, and if we do, I think a new command is warranted.
