Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4B022C4F0
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 14:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgGXMRk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 08:17:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:14038 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgGXMRk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 08:17:40 -0400
IronPort-SDR: hymydJP0ZFSSws7fLxC44KuZRyZesJi86UZTpulGY1e19r8ZtLp1GzPKlSYjXOUBD21yB+0jXF
 0Ns/pC6AjEaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="150684438"
X-IronPort-AV: E=Sophos;i="5.75,390,1589266800"; 
   d="scan'208";a="150684438"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 05:17:39 -0700
IronPort-SDR: QQQu+DgdSARCQ5/VmmnjlZrL7cW1iyhfIQwdbxY6CB/y5sWIlCbH7hS8RhIZ86kEHSj3xYsRxV
 LUFZ8oeW/V9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,390,1589266800"; 
   d="scan'208";a="288975674"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 24 Jul 2020 05:17:35 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jywdq-003nw4-Ql; Fri, 24 Jul 2020 15:17:34 +0300
Date:   Fri, 24 Jul 2020 15:17:34 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        Linuxarm <linuxarm@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>
Subject: Re: [PATCH v13 0/2] ACPI / APEI: Add support to notify the vendor
 specific HW errors
Message-ID: <20200724121734.GC3703480@smile.fi.intel.com>
References: <20200722104245.1060-1-shiju.jose@huawei.com>
 <20200723232301.GA1468407@bjorn-Precision-5520>
 <5c86b434fe3a47eaabf488dea14efd25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c86b434fe3a47eaabf488dea14efd25@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 24, 2020 at 09:08:16AM +0000, Shiju Jose wrote:
> >-----Original Message-----
> >From: Bjorn Helgaas [mailto:helgaas@kernel.org]
> >Sent: 24 July 2020 00:23
> >On Wed, Jul 22, 2020 at 11:42:43AM +0100, Shiju Jose wrote:

...

> >This series is ill-formed:

I confirm this.

> >  - Jul 22  5:39 Shiju Jose      [PATCH v13 0/2] ACPI / APEI: Add support to not
> >  - Jul 22  5:39 Shiju Jose      └─>[PATCH v13 1/2] ACPI / APEI: Add a notifier
> >  - Jul 22  5:42 Shiju Jose      [PATCH v13 0/2] ACPI / APEI: Add support to not
> >  - Jul 22  5:42 Shiju Jose      └─>[PATCH v13 2/2] PCI: hip: Add handling of Hi
> git send-email failed to send out one patch each time in the patch series
> due to some internal error. 

You have to fix your tools...

-- 
With Best Regards,
Andy Shevchenko


