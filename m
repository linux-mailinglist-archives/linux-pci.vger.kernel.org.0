Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BAD45ACB0
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 20:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240135AbhKWTlA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 14:41:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:2105 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239308AbhKWTkx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Nov 2021 14:40:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="233834797"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="233834797"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 11:37:43 -0800
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="509543633"
Received: from sshetty1-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.143.221])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 11:37:42 -0800
Date:   Tue, 23 Nov 2021 11:37:41 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 18/23] cxl/pci: Implement wait for media active
Message-ID: <20211123193741.eberq6qmg44rab4a@intel.com>
References: <20211123160413.pprxwlhan2qypjtv@intel.com>
 <20211123174853.GA2230542@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123174853.GA2230542@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-23 11:48:53, Bjorn Helgaas wrote:
> On Tue, Nov 23, 2021 at 08:04:13AM -0800, Ben Widawsky wrote:
> > On 21-11-23 11:09:34, Jonathan Cameron wrote:
> > > On Mon, 22 Nov 2021 14:57:51 -0800
> > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > 
> > > > On 21-11-22 17:03:35, Jonathan Cameron wrote:
> > > > > On Fri, 19 Nov 2021 16:02:45 -0800
> > > > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > > > >   
> > > > > > CXL 2.0 8.1.3.8.2 defines "Memory_Active: When set,
> > > > > > indicates that the CXL Range 1 memory is fully initialized
> > > > > > and available for software use.  Must be set within Range 1.
> > > > > > Memory_Active_Timeout of deassertion of  
> > > ...
> > > Ah, got it. Maybe Range 1: Memory Active timeout ?
> > 
> > I can, but this is just quoted from the spec. Would this be better:
> > 
> > The CXL Type 3 Memory Device Software Guide (Revision 1.0) describes the
> > need to check media active before using HDM. CXL 2.0 8.1.3.8.2 states:
> > 
> >   Memory_Active: When set, indicates that the CXL Range 1 memory is
> >   fully initialized and available for software use. Must be set within
> >   Range 1. Memory_Active_Timeout of deassertion of reset to CXL device
> >   if CXL.mem HwInit Mode=1
> 
> That is some weird wording.  I stumbled over that, too.  I like the
> quote format better, but I still don't know what it means.
> 
> That last piece ("Memory_Active_Timeout of deassertion ...") purports
> to be a sentence, but is not.

I've reported this to the person locally who drives spec changes. Since it's now
confused multiple people, I will rewrite it with my interpretation if people
think that is more optimal.

"Memory Active bit must be set within Memory_Active_Timeout amount of time
after reset."
