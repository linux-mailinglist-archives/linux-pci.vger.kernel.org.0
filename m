Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174A72F6A78
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 20:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbhANTFL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 14:05:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:49586 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728813AbhANTFL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Jan 2021 14:05:11 -0500
IronPort-SDR: kksxgN36eAdwWvLlFYCwNIUyxyr0epWQLZlM+M5PWJNkch3InjVq8qFJKBC+xMJxgMpc0zHuHp
 DsX/YQrx588w==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="158199869"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="158199869"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 11:04:28 -0800
IronPort-SDR: RVMlgzAllMO97D6rxUMR104YFghec33pshXFLgKHCzfbi7LgAPPWxpq54DcbkDu9g8DmaCYp/K
 OMhtqo8LV1cw==
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="382373646"
Received: from jdquesad-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.128.180])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 11:04:27 -0800
Date:   Thu, 14 Jan 2021 11:04:25 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>,
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
Subject: Re: [RFC PATCH v3 14/16] cxl/mem: Use CEL for enabling commands
Message-ID: <20210114190425.rxupmrjm3jfjorj4@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
 <20210111225121.820014-16-ben.widawsky@intel.com>
 <20210114180211.00007852@Huawei.com>
 <20210114181340.fgybdchzfxiiqwhr@intel.com>
 <20210114183217.0000154c@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114183217.0000154c@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-01-14 18:32:17, Jonathan Cameron wrote:
> On Thu, 14 Jan 2021 10:13:40 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > On 21-01-14 18:02:11, Jonathan Cameron wrote:
> > > On Mon, 11 Jan 2021 14:51:19 -0800
> > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >   
> > > > The Command Effects Log (CEL) is specified in the CXL 2.0 specification.
> > > > The CEL is one of two types of logs, the other being vendor specific.
> > > > They are distinguished in hardware/spec via UUID. The CEL is immediately
> > > > useful for 2 things:
> > > > 1. Determine which optional commands are supported by the CXL device.
> > > > 2. Enumerate any vendor specific commands
> > > > 
> > > > The CEL can be used by the driver to determine which commands are
> > > > available in the hardware (though it isn't, yet). That set of commands
> > > > might itself be a subset of commands which are available to be used via
> > > > CXL_MEM_SEND_COMMAND IOCTL.
> > > > 
> > > > Prior to this, all commands that the driver exposed were explicitly
> > > > enabled. After this, only those commands that are found in the CEL are
> > > > enabled.
> > > > 
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>  
> > > 
> > > This patch made me wonder if the model for the command in quite right.
> > > I think it would end up simpler with a pair of payload pointers for send
> > > and receive (that can be equal when it makes sense).
> > > 
> > > A few other things inline.
> > > 
> > > Jonathan  
> > 
> > I'll address the others separately, but could you elaborate on this? I'm not
> > sure I follow your meaning.
> 
> Further down in the review..
> "
> The fact that you end up bypassing the payload transfer stuff in mbox_cmd
> rather suggests it's not a particularly good model.  + it keeps confusing
> me.
> 
> While the hardware uses a single region for the payload, there is nothing
> saying the code has to work that way.   Why not have separate payload_in and
> payload_out pointers?  Occasionally you might set them to the same buffer, but
> elsewhere you could avoid the direct memcpy()s you are doing around the
> send_cmd(). 
> 
> "
> 
> Jonathan
> 
> 

Ah I was confused if that was a separate statement.

Can you specify the function prototype you're hoping for (or modification to the
structure)?

I really like the lowest level function to simply model the hardware. I get to
write the 8 steps out and clearly implement them.

I personally don't think it's so awkward, but again, give me something more
specific and I'll consider it.
