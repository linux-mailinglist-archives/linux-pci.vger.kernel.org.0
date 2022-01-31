Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275824A5271
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 23:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbiAaWer (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 17:34:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:5142 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbiAaWer (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 17:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643668487; x=1675204487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kQ4KxMmJablIpkLr13hEY7eq2UJchis/VYe9JDslcWA=;
  b=eWKSBi6e3ru/FhtL/ORZ8VUe2hNp7c+oKwN9v1rIxCYyWiq/2l+ft4T0
   BJIADs54OCaRUN78VtJIMJIeYxFvZXCixJpIs5mMG8imoZQozRQkonZtx
   5ghsnJyQZOeIRZp6+JFBUDpUKPsVZBGSDRitTZ6u4ZeISVpJxVgaNyLpw
   1l1V80xGusVlpdyVoisnS6l0STe7r+BcBEA7EoF80sdx6KEX9iuhTp45j
   +UUHzg77sjSUFCOK9znZnI7+pCvl15rkwWgB9iq5GzbEWSIMPZ1V+QCq3
   ixB6Ldmrn/rD4u3ZSEevjmc7nemihzsXhv1JVdelrzIP9al+ftEeo+qv0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="245156217"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="245156217"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 14:34:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="619538129"
Received: from sssheth-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.130.247])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 14:34:46 -0800
Date:   Mon, 31 Jan 2022 14:34:44 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 09/40] cxl/decoder: Hide physical address information
 from non-root
Message-ID: <20220131223444.ffhtruwae5uwx23l@intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298416650.3018233.450720006145238709.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164298416650.3018233.450720006145238709.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-23 16:29:26, Dan Williams wrote:
> Just like /proc/iomem, CXL physical address information is reserved for
> root only.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>

[snip]
