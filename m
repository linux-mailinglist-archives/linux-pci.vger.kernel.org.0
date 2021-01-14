Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FC12F6931
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 19:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbhANSO2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 13:14:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:58735 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbhANSO0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Jan 2021 13:14:26 -0500
IronPort-SDR: OqeFCVaXTzV1DGZVJNTXZ03NA0VzlymYAnJNjv9VK2G3yJn5ubsxE8Tzv2qgag89Cn/9tF74JJ
 EYw2ut7FdAsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="178507166"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="178507166"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 10:13:43 -0800
IronPort-SDR: xL4xBAKjZcRZBQEhKqDdwC1/z+HSv8naXDj7/u685D//MTPoNOnCkvzwXS1x9be1oS9XDSZNQ2
 JbTStUKYA9/g==
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="405238644"
Received: from jdquesad-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.128.180])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 10:13:42 -0800
Date:   Thu, 14 Jan 2021 10:13:40 -0800
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
Message-ID: <20210114181340.fgybdchzfxiiqwhr@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
 <20210111225121.820014-16-ben.widawsky@intel.com>
 <20210114180211.00007852@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114180211.00007852@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-01-14 18:02:11, Jonathan Cameron wrote:
> On Mon, 11 Jan 2021 14:51:19 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > The Command Effects Log (CEL) is specified in the CXL 2.0 specification.
> > The CEL is one of two types of logs, the other being vendor specific.
> > They are distinguished in hardware/spec via UUID. The CEL is immediately
> > useful for 2 things:
> > 1. Determine which optional commands are supported by the CXL device.
> > 2. Enumerate any vendor specific commands
> > 
> > The CEL can be used by the driver to determine which commands are
> > available in the hardware (though it isn't, yet). That set of commands
> > might itself be a subset of commands which are available to be used via
> > CXL_MEM_SEND_COMMAND IOCTL.
> > 
> > Prior to this, all commands that the driver exposed were explicitly
> > enabled. After this, only those commands that are found in the CEL are
> > enabled.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> This patch made me wonder if the model for the command in quite right.
> I think it would end up simpler with a pair of payload pointers for send
> and receive (that can be equal when it makes sense).
> 
> A few other things inline.
> 
> Jonathan

I'll address the others separately, but could you elaborate on this? I'm not
sure I follow your meaning.

[snip]


