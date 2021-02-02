Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014AC30B3EB
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 01:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhBBAMK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 19:12:10 -0500
Received: from mga05.intel.com ([192.55.52.43]:42310 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230000AbhBBAMK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Feb 2021 19:12:10 -0500
IronPort-SDR: PyJHAgQg4fiWg8qKhrkazx/iFCm1f0t4ZZls8B2wzuXatFaO4p8t8nEaEyK8pYUO8E7f6r7HsF
 nA9Qa5neIb2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="265604696"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="265604696"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 16:11:26 -0800
IronPort-SDR: VzCZkMjvd6oUv7MNieUe2e7I+dES0FyqOvVWnfelSzqiIeNsGRdJQJu2QgfUS1x1onWe/SB/dx
 QzU9THSVHXcg==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="405945596"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 16:11:25 -0800
Date:   Mon, 1 Feb 2021 16:11:20 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     David Rientjes <rientjes@google.com>
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
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
Message-ID: <20210202001120.vr6mos7ylnbqytxh@intel.com>
References: <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
 <20210201215857.ud5cpg7hbxj2j5bx@intel.com>
 <b46ed01-3f1-6643-d371-7764c3bde4f8@google.com>
 <20210201222859.lzw3gvxuqebukvr6@intel.com>
 <20210201223314.qh24uxd7ajdppgfl@intel.com>
 <f86149f8-3aea-9d8c-caa9-62771bf22cb5@google.com>
 <20210201225052.vrrvuxrsgmddjzbb@intel.com>
 <79b98f60-151b-6c80-65c3-91a37699d121@google.com>
 <20210201231718.2hwaqgn2f7kc7usw@intel.com>
 <a789317e-2ac2-10a1-dedd-1851972e3d6b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a789317e-2ac2-10a1-dedd-1851972e3d6b@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-01 15:58:09, David Rientjes wrote:
> On Mon, 1 Feb 2021, Ben Widawsky wrote:
> 
> > > I haven't seen the update to 8.2.8.4.5 to know yet :)
> > > 
> > > You make a good point of at least being able to interact with the driver.  
> > > I think you could argue that if the driver binds, then the payload size is 
> > > accepted, in which case it would be strange to get an EINVAL when using 
> > > the ioctl with anything >1MB.
> > > 
> > > Concern was that if we mask off the reserved bits from the command 
> > > register that we could be masking part of the payload size that is being 
> > > passed if the accepted max is >1MB.  Idea was to avoid any possibility of 
> > > this inconsistency.  If this is being checked for ioctl, seems like it's 
> > > checking reserved bits.
> > > 
> > > But maybe I should just wait for the spec update.
> > 
> > Well, I wouldn't hold your breath (it would be an errata in this case anyway).
> > My preference would be to just allow allow mailbox payload size to be 2^31 and
> > not deal with this.
> > 
> > My question was how strongly do you feel it's an error that should prevent
> > binding.
> > 
> 
> I don't have an objection to binding, but doesn't this require that the 
> check in cxl_validate_cmd_from_user() guarantees send_cmd->size_in cannot 
> be greater than 1MB?

You're correct. I'd need to add:
cxlm->mbox.payload_size =
    min_t(size_t, 1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE), 1<<20)
