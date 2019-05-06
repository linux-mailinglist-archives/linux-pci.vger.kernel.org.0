Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2301464E
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2019 10:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEFI3i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 May 2019 04:29:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:4122 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfEFI3i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 May 2019 04:29:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 01:29:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,437,1549958400"; 
   d="scan'208";a="229830002"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga001.jf.intel.com with ESMTP; 06 May 2019 01:29:35 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hNZ0A-00086o-9W; Mon, 06 May 2019 11:29:34 +0300
Date:   Mon, 6 May 2019 11:29:34 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frederick Lawler <fred@fredlawl.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
        lukas@wunner.de, keith.busch@intel.com, mr.nuke.me@gmail.com,
        liudongdong3@huawei.com, thesven73@gmail.com
Subject: Re: [PATCH v2 6/9] PCI: hotplug: Prefix dmesg logs with PCIe service
 name
Message-ID: <20190506082934.GI9224@smile.fi.intel.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
 <20190503035946.23608-7-fred@fredlawl.com>
 <20190503200437.GD180403@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503200437.GD180403@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 03, 2019 at 03:04:37PM -0500, Bjorn Helgaas wrote:
> On Thu, May 02, 2019 at 10:59:43PM -0500, Frederick Lawler wrote:

> > +#define pr_fmt(fmt) "pciehp: " fmt
> > +#define dev_fmt pr_fmt
> 
> Can these go in pciehp.h?

In general, no, it can't. The pr_fmt() / dev_fmt() macro must precede any
header inclusion, thus it makes them position dependent.

Otherwise, one has to guarantee above by accurately keeping a header inclusion
ordering.

-- 
With Best Regards,
Andy Shevchenko


