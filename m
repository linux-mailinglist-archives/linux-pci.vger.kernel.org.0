Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3E44A5320
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 00:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiAaXXL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 18:23:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:20188 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229447AbiAaXXL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 18:23:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643671391; x=1675207391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dy1IpN9IEISxqrNoPZcZ3U4oxJFmkyXZhsr1zERpkv0=;
  b=HbFUeeLp7Rmm6IadqgUjVtEdpqn95GvKDMtrs0jYgCgM1/Ts3BSAgvfK
   2W8biKTr3BYNjYSBf45f33FyqhPaNRBHLVMW7jdLk62T2lad34czi6Rjw
   L4yn3vBMgga3KnsLzJ0Y/ybU00fihmIWfPiFUS7pG4Tx9CmTPG6NgjdYr
   LZKdV9FZZnLZ6WcaftkVp2J3tV6gxotUFtgsBR3mTnynRSkyRiJc7xKg7
   WN8Fyy7Kh8ap+Cx/XOpSnLVBMBjYcMGywqF0rqKwWMZ/kbrGatHVGNyXb
   jG8mSZYl20vAiEv1iJgUwU4vJP8qSYevG219A0UELlARXhV5shHLI/wSL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="333930206"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="333930206"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:23:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="626535764"
Received: from sssheth-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.130.247])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:23:10 -0800
Date:   Mon, 31 Jan 2022 15:23:08 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH v4 15/40] cxl: Prove CXL locking
Message-ID: <20220131232308.fobdqy2lv5makwto@intel.com>
References: <164298419875.3018233.7880727408723281411.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164365853422.99383.1052399160445197427.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164365853422.99383.1052399160445197427.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-31 11:50:09, Dan Williams wrote:
> When CONFIG_PROVE_LOCKING is enabled the 'struct device' definition gets
> an additional mutex that is not clobbered by
> lockdep_set_novalidate_class() like the typical device_lock(). This
> allows for local annotation of subsystem locks with mutex_lock_nested()
> per the subsystem's object/lock hierarchy. For CXL, this primarily needs
> the ability to lock ports by depth and child objects of ports by their
> parent parent-port lock.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>

[snip]
