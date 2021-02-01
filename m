Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325C630B345
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 00:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhBAXSC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 18:18:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:63595 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230054AbhBAXSB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Feb 2021 18:18:01 -0500
IronPort-SDR: XxpHcgwfhLO72dOaNzOwNxHGnF8CEeyJnZ9Y+xdpaJ7l62FezQorP9ZVfrLBi0CHQuj960+P88
 GO2TtFqmv2mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="179991041"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="179991041"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 15:17:20 -0800
IronPort-SDR: 8bdJnMFA0kHmvh7DoPbPCnHbnphnf3MPu4bPVWxPwJfsCqN+WEedY9p8s+2FeZLVcRrs3sUus2
 AQqkT0yDaSbg==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="575281971"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.133.15])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 15:17:20 -0800
Date:   Mon, 1 Feb 2021 15:17:18 -0800
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
Message-ID: <20210201231718.2hwaqgn2f7kc7usw@intel.com>
References: <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com>
 <20210201165352.wi7tzpnd4ymxlms4@intel.com>
 <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
 <20210201215857.ud5cpg7hbxj2j5bx@intel.com>
 <b46ed01-3f1-6643-d371-7764c3bde4f8@google.com>
 <20210201222859.lzw3gvxuqebukvr6@intel.com>
 <20210201223314.qh24uxd7ajdppgfl@intel.com>
 <f86149f8-3aea-9d8c-caa9-62771bf22cb5@google.com>
 <20210201225052.vrrvuxrsgmddjzbb@intel.com>
 <79b98f60-151b-6c80-65c3-91a37699d121@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79b98f60-151b-6c80-65c3-91a37699d121@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-01 15:09:45, David Rientjes wrote:
> On Mon, 1 Feb 2021, Ben Widawsky wrote:
> 
> > > I think that's what 8.2.8.4.3 says, no?  And then 8.2.8.4.5 says you 
> > > can use up to Payload Size.  That's why my recommendation was to enforce 
> > > this in cxl_mem_setup_mailbox() up front.
> > 
> > Yeah. I asked our spec people to update 8.2.8.4.5 to make it clearer. I'd argue
> > the intent is how you describe it, but the implementation isn't.
> > 
> > My argument was silly anyway because if you specify greater than 1M as your
> > payload, you will get EINVAL at the ioctl.
> > 
> > The value of how it works today is the driver will at least bind and allow you
> > to interact with it.
> > 
> > How strongly do you feel about this?
> > 
> 
> I haven't seen the update to 8.2.8.4.5 to know yet :)
> 
> You make a good point of at least being able to interact with the driver.  
> I think you could argue that if the driver binds, then the payload size is 
> accepted, in which case it would be strange to get an EINVAL when using 
> the ioctl with anything >1MB.
> 
> Concern was that if we mask off the reserved bits from the command 
> register that we could be masking part of the payload size that is being 
> passed if the accepted max is >1MB.  Idea was to avoid any possibility of 
> this inconsistency.  If this is being checked for ioctl, seems like it's 
> checking reserved bits.
> 
> But maybe I should just wait for the spec update.

Well, I wouldn't hold your breath (it would be an errata in this case anyway).
My preference would be to just allow allow mailbox payload size to be 2^31 and
not deal with this.

My question was how strongly do you feel it's an error that should prevent
binding.
