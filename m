Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E064A5385
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 00:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiAaXsP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 18:48:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:61910 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbiAaXsN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 18:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643672893; x=1675208893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eDPeWOjMherCcGDr1JOeWJR93GZStedgJ56UblsLTQM=;
  b=KxIOAH/2jQchPLqrblBMrljqJriuYrkQJSGSLjl9qdinIbmOliv8rJoO
   a/pXzoH8ckXdoWLPiYqW96A5WzN2Q4eZxUOEsu/eo0vP11AS1ZE8ck1Y1
   dlhC9kQWZbQAa3k2l4RtfckWGkKHA0TW6rlnHK3XXgICG2ULvkmnTvTTi
   XckAaj6LxXQ6Hp5zZ5keIuu1zT9TqVzErNGzBo19NoXmPkrYqQCat4Lk3
   Vet6TC9ItglsHeBWoAIppLxUdw+CnKJeMuNpIsEhb0E5++5jwltBQQUd1
   tRqsJx1yrfDukrFGMeO6ZzmEO3Fkl9Rp684+urrXRZK4CDCO4VPD9rsN8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="231148489"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="231148489"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:48:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="630198344"
Received: from sssheth-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.130.247])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:48:11 -0800
Date:   Mon, 31 Jan 2022 15:48:10 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 20/40] cxl/pci: Rename pci.h to cxlpci.h
Message-ID: <20220131234810.5ebiyq56zpve6zhr@intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298422510.3018233.14693126572756675563.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164298422510.3018233.14693126572756675563.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-23 16:30:25, Dan Williams wrote:
> Similar to the mem.h rename, if the core wants to reuse definitions from
> drivers/cxl/pci.h it is unable to use <pci.h> as that collides with
> archs that have an arch/$arch/include/asm/pci.h, like MIPS.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Ben Widawsky <ben.widawsky@intel.com>

[snip]
