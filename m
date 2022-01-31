Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39964A536F
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 00:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiAaXlz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 18:41:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:61134 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbiAaXly (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 18:41:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643672514; x=1675208514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yjQHh0Yfr1scPww3LtRFqwgJl85g3BYaKqA4/Bg6Km4=;
  b=KRvRTMRlaUgvrNa+98dqdbmH3kFYTJtkeae038/h/+J1FnqaLBkDgY4w
   B4JPmtF88h6s1LHrO3yWjsbEwUI3Abkn7Za0KL7M5hl3l2Wm21hSFX3r6
   UW65t/zmZeNdXMQ2sV+aWe+33eVRzRaKZWTH0q7yC+64Y814JjT7ZICyU
   obRxGWs5iD72SkHGNU3nufBohPvlF1KOujg6+apbE+KF7/GwCwAgE8R5o
   b8gUIz8/bGyVcgbZSKFXOyHz+XWmZFfOTK3hsgZuINIEGxdRGA+rbe/B3
   wdm7ulinVDX5ZQ4+CK6jeJ9TkdgzD9KALcskM9Hash6QUttxqOI6QAjpO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="310884504"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="310884504"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:41:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="522844661"
Received: from sssheth-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.130.247])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:41:54 -0800
Date:   Mon, 31 Jan 2022 15:41:52 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH v4 17/40] cxl/port: Introduce cxl_port_to_pci_bus()
Message-ID: <20220131234152.ttpp5xkiunrxv3zp@intel.com>
References: <164298420951.3018233.1498794101372312682.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164364745633.85488.9744017377155103992.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164364745633.85488.9744017377155103992.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-31 08:44:52, Dan Williams wrote:
> Add a helper for converting a PCI enumerated cxl_port into the pci_bus
> that hosts its dports. For switch ports this is trivial, but for root
> ports there is no generic way to go from a platform defined host bridge
> device, like ACPI0016 to its corresponding pci_bus. Rather than spill
> ACPI goop outside of the cxl_acpi driver, just arrange for it to
> register an xarray translation from the uport device to the
> corresponding pci_bus.
> 
> This is in preparation for centralizing dport enumeration in the core.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>

[snip]
