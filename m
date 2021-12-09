Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD21246F4BF
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 21:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbhLIUSZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 15:18:25 -0500
Received: from mga07.intel.com ([134.134.136.100]:39922 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229522AbhLIUSW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Dec 2021 15:18:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="301580819"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="301580819"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 12:14:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="503633893"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 12:14:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mvPnY-004FLD-1A;
        Thu, 09 Dec 2021 22:13:48 +0200
Date:   Thu, 9 Dec 2021 22:13:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Joe Perches <joe@perches.com>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2 1/1] PCI: Introduce pci_bus_*() printing macros when
 device is not available
Message-ID: <YbJje4JnzH9BPUIe@smile.fi.intel.com>
References: <20211209182711.28709-1-andriy.shevchenko@linux.intel.com>
 <411886e9e89f797d3f9513245f94b2a5f4a33e7d.camel@perches.com>
 <YbJaFM0vlkdTwxUS@smile.fi.intel.com>
 <47d32a2f648281c6a1731266d1a5d00da3d1a875.camel@perches.com>
 <YbJgXKf6NkbHgy5A@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YbJgXKf6NkbHgy5A@rocinante>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 09, 2021 at 09:00:28PM +0100, Krzysztof Wilczyński wrote:
> Hi Andy and Joe,

...

> I think both things look nice!
> 
> So perhaps meet in-between here?  Two patches in a small series: one adds
> new useful macros from Andy, and the other updates current macros as per
> Joe's feedback/preference?  I am sure Bjorn wouldn't mind (hopefully).

Thanks, I agree that these changes should be separated, otherwise I'm
fine if pci.h switches to __VA_ARGS__.

-- 
With Best Regards,
Andy Shevchenko


