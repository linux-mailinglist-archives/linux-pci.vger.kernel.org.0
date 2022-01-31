Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D564A5270
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 23:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiAaWe0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 17:34:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:18669 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbiAaWeZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 17:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643668465; x=1675204465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=guc+t4X8qIxtDZg/LzaCnykg5raQFyS2HDN3b5+XTRY=;
  b=k6X0Ccedzm4YEZlYqegkEXXhaLOjNTJF60B8FOLULYRinENx5thWaIvi
   /BRsQYnmS4ed4ni+J234C2fUGrNg/aIAWzq6YRsj+RWsRdw0Q5iOWh4ry
   a+HSS7ZTDQUJ5WQy12/o0Oocc6OSeY/tJGafsmxGGK8QN/5d+25d3+6T8
   k1vnokq0KDrH+V5NoS5FHBU9F4NdeWVb2k5kXxOmEJMMPyhcR4T7hlF/W
   j+KgNHprNjoqo0rEyb5mIx1IEU8ssjtRoli4Fg1Dm6ElwSSbVQKhS1c2i
   r7yx57OmPWXfhEOADRD9Kb2DRC/54qTEXbEA3rp1o309LLsPeke4QN28r
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="308297152"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="308297152"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 14:34:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="598981452"
Received: from sssheth-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.130.247])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 14:34:08 -0800
Date:   Mon, 31 Jan 2022 14:34:06 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 08/40] cxl/core/port: Rename bus.c to port.c
Message-ID: <20220131223406.cbtqnytamfy5jsdx@intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298416136.3018233.15442880970000855425.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164298416136.3018233.15442880970000855425.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-23 16:29:21, Dan Williams wrote:
> Given it is dominated by port infrastructure, and will only acquire
> more, rename bus.c to port.c.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>

[snip]

I wouldn't be opposed to keep bus.c for some of the core functionality, but that
file would be so small at this point it's fine to save for later.
