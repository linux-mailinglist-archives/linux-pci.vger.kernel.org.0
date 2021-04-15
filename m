Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60750361690
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 01:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbhDOXvI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 19:51:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:33031 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234865AbhDOXvI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 19:51:08 -0400
IronPort-SDR: KmwtaRebBo2bdqPswYdYZ1/Pyb9DRWMH57WfrWk00tmDEQjBBNIG2o0ET6cBXwHksMEl+yevMX
 6N4XN6qhLSlw==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="192837295"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="192837295"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:50:44 -0700
IronPort-SDR: 1mWxw8Rnkx3kT7ECOBmUb+AGl708AnhCVQ/PJ97ZYiX4sav8dKW5dGOB/4utFcOWgx3oHvh2wO
 x3nAMtB1AKlg==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="384168737"
Received: from oamoninu-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.130.91])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:50:44 -0700
Date:   Thu, 15 Apr 2021 16:50:43 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH 3/3] cxl/mem: Demarcate vendor specific capability IDs
Message-ID: <20210415235043.xo7hkxftrxkzhix5@intel.com>
References: <20210415232610.603273-3-ben.widawsky@intel.com>
 <20210415232750.604112-1-ben.widawsky@intel.com>
 <2e570a62f540557d4dda66d90ff73fa841362b45.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e570a62f540557d4dda66d90ff73fa841362b45.camel@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-04-15 16:37:01, Verma, Vishal L wrote:
> On Thu, 2021-04-15 at 16:27 -0700, Ben Widawsky wrote:
> > Vendor capabilities occupy 0x8000 to 0xFFFF according to CXL 2.0 spec
> > 8.2.8.2.1 CXL Device Capabilities. While they are not defined by the
> > spec, they are allowed and not "unknown". Call this detail out in the
> > logs to let users easily distinguish the difference.
> >
> > v2: Should be greater than or equal to (Ben)
> 
> If there's a v3, drop this to below the '---'. Otherwise note for Dan to
> drop when applying I guess :)
> 

Thanks... This one is an old habit. I'll point out too I messed up the subject
here.

> >
> > Fixes: 8adaf747c9f0b ("cxl/mem: Find device capabilities")
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > ---
> >  drivers/cxl/mem.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > index c05617b0ba4b..28c7c29567b3 100644
> > --- a/drivers/cxl/mem.c
> > +++ b/drivers/cxl/mem.c
> > @@ -939,7 +939,10 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> >  cxlm->memdev_regs = register_block;
> >  break;
> >  default:
> > -dev_dbg(dev, "Unknown cap ID: %x (0x%x)\n", cap_id, offset);
> > +if (cap_id >= 0x8000)
> > +dev_dbg(dev, "Vendor cap ID: %x (0x%x)\n", cap_id, offset);
> > +else
> > +dev_dbg(dev, "Unknown cap ID: %x (0x%x)\n", cap_id, offset);
> >  break;
> >  }
> >  }
> 
