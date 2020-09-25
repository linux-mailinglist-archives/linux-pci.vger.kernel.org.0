Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5048B278ED5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 18:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgIYQkW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 12:40:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:44646 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728353AbgIYQkW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 12:40:22 -0400
IronPort-SDR: CHDeJUsVZvy3PQ43INxcT1lcdZZijBYSbDd5fSP6CNGBygw2RZ/G2dbBA15+FzF05BO/sHWZsN
 qQUZnhmjysmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="179655316"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="179655316"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 09:40:16 -0700
IronPort-SDR: Qz8UptCdPjaACMrQab4Cq1l0NWLpyR8p73aa1nGo2XuyBzjl6yTtTlD7rN3WbmJY1RkB8oJnjW
 5pecNSJHP5JQ==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="323440246"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 09:40:13 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kLmzG-001v06-Ax; Fri, 25 Sep 2020 15:38:06 +0300
Date:   Fri, 25 Sep 2020 15:38:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ethan Zhao <haifeng.zhao@intel.com>
Cc:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, pei.p.jia@intel.com
Subject: Re: [PATCH 4/5] PCI: only return true when dev io state is really
 changed
Message-ID: <20200925123806.GG3956970@smile.fi.intel.com>
References: <20200925023423.42675-1-haifeng.zhao@intel.com>
 <20200925023423.42675-5-haifeng.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925023423.42675-5-haifeng.zhao@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 10:34:22PM -0400, Ethan Zhao wrote:
> When uncorrectable error happens, AER driver and DPC driver interrupt
> handlers likely call
>    pcie_do_recovery()->pci_walk_bus()->report_frozen_detected() with
> pci_channel_io_frozen the same time.

Call chains are better to read if they split like

   foo() ->
     bar() ->
       baz()

>    If pci_dev_set_io_state() return true even if the original state is
> pci_channel_io_frozen, that will cause AER or DPC handler re-enter
> the error detecting and recovery procedure one after another.
>    The result is the recovery flow mixed between AER and DPC.
> So simplify the pci_dev_set_io_state() function to only return true
> when dev->error_state is changed.

...

> +	if (dev->error_state != new) {
>  		dev->error_state = new;
> +		changed = true;
> +	}
>  	return changed;

Perhaps
	if (dev->error_state == new)
		return changed;

	dev->error_state = new;
	return true;

?


-- 
With Best Regards,
Andy Shevchenko


