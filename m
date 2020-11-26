Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966072C5BD6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 19:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404443AbgKZSSg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 13:18:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:47796 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404410AbgKZSSg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Nov 2020 13:18:36 -0500
IronPort-SDR: GvCSfZUpbSkDVTEhTXL3sHh9aAtD7KX7pxVcoZLW86b3MasG52AGELz48z6G5L0MM0KTcppNWg
 AYRaz1FxlF9A==
X-IronPort-AV: E=McAfee;i="6000,8403,9817"; a="236444183"
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="236444183"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 10:18:32 -0800
IronPort-SDR: vdQ1+pws1U/kQy6TK9565q+kQyvWDS9RVechhAiifqXPwZXH5wH40M4m8TnJHPwj/jb1y9d7zF
 As4zxj88a1Ng==
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="371353169"
Received: from tsundar1-t480s.amr.corp.intel.com (HELO intel.com) ([10.252.131.217])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 10:18:31 -0800
Date:   Thu, 26 Nov 2020 10:18:29 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jon Masters <jcm@jonmasters.org>
Cc:     linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 5/9] cxl/mem: Find device capabilities
Message-ID: <20201126181829.vy3was5c42ixtwxm@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-6-ben.widawsky@intel.com>
 <8d332852-9c54-95e0-58c7-72939f347aa6@jonmasters.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d332852-9c54-95e0-58c7-72939f347aa6@jonmasters.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20-11-26 01:05:56, Jon Masters wrote:
> On 11/11/20 12:43 AM, Ben Widawsky wrote:
> 
> > +		case CXL_CAPABILITIES_CAP_ID_SECONDARY_MAILBOX:
> > +			dev_dbg(&cxlm->pdev->dev,
> > +				   "found UNSUPPORTED Secondary Mailbox capability\n");
> 
> Per spec, the secondary mailbox is intended for use by platform firmware, so
> Linux should never be using it anyway. Maybe that message is slightly
> misleading?

Yeah, I think the message could be reworded, but it is dev_dbg, so I wasn't too
worried about the wording in the first place. I think it is a mistake in this
case for the spec to describe the intended purpose. If the expectation is for
platform firmware to use it, but there is no negotiation mechanism in place,
it's essentially useless.

> 
> Jon.
> 
> P.S. Related - I've severe doubts about the mailbox approach being proposed
> by CXL and have begun to push back through the spec org.

Any reason not to articulate that here? Now that the spec is public, I don't see
any reason not to disclose that publicly.
