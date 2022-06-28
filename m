Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4223655E358
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbiF1DNH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 23:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiF1DM4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 23:12:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E98A25291;
        Mon, 27 Jun 2022 20:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656385971; x=1687921971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q9oVw6/GMZy/Vws24GjHpyW1vsg9MEk5gQhF+q9kszE=;
  b=QQRCAi6W/XabJ0V7J1mQ+mZ0aGez1eJi91tmJn2NbvGOCOg66fxeCbEi
   U5GOBm6L3Id0+kU2OiAFbSDctG7yB+vcr856RJTR4y+TFA/w7aMmBnVCk
   xcZqtzufu9KXXR6mbboaQAhy8Mc/iVXR4pR7T6zzcIG8Ag3gP0ajs6MR+
   dJa4HyNn+Yso3K9wEqRTm2gfTUI71M9efXX+g3YBFNQnzYBixDJQMVoQQ
   DFEkE7Z/diGz1el+BRMlLPbH/unQAgMK6rvlF0Yi4Xw3ccT9LiLPUC/KH
   tH7vaU4BlXA7+e/BSXYBV6IWvbrGHA1CoyHWwSOv9KsbhzyAo9438ql3X
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="264661299"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="264661299"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 20:12:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="657951487"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 20:12:50 -0700
Date:   Mon, 27 Jun 2022 20:12:05 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH 00/46] CXL PMEM Region Provisioning
Message-ID: <20220628031205.GA1575206@alison-desk>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


-snipped everything

These are commit message typos followed by one tidy-up request.

[PATCH 00/46] CXL PMEM Region Provisioning
s/usersapce/userspace
s/mangage/manage

[PATCH 09/46] cxl/acpi: Track CXL resources in iomem_resource
s/accurracy/accuracy

[PATCH 11/46] cxl/core: Define a 'struct cxl_endpoint_decoder' for tracking DPA resources
s/platfom/platforma

[PATCH 14/46] cxl/hdm: Enumerate allocated DPA
s/provisioining/provisioning
s/comrpised/comprised
s/volaltile-ram/volatile-ram

[PATCH 23/46] tools/testing/cxl: Add partition support
s/mecahinisms/mechanisms

[PATCH 25/46] cxl/port: Record dport in endpoint references
s/endoint/endpoint

[PATCH 30/46] cxl/hdm: Add sysfs attributes for interleave ways + granularity
s/userpace/userspace
s/resonsible/responsible

[PATCH 35/46] cxl/region: Add a 'uuid' attribute
s/is operation/its operation

[PATCH 42/46] cxl/hdm: Commit decoder state to hardware
s/base-addres/base-address
s/intereleave/interleave

How about shortening the commit messages of Patch 10 & 11? They make my
git pretty one liner output ugly.


