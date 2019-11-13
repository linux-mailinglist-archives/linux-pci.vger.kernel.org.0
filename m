Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99A5CFAF30
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 12:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfKMLAP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Nov 2019 06:00:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:31895 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfKMLAP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 06:00:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 03:00:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,300,1569308400"; 
   d="scan'208";a="216350769"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 13 Nov 2019 03:00:10 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1iUqNd-0001Y6-H6; Wed, 13 Nov 2019 13:00:09 +0200
Date:   Wed, 13 Nov 2019 13:00:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     gustavo.pimentel@synopsys.com, lorenzo.pieralisi@arm.com,
        andrew.murray@arm.com, helgaas@kernel.org, jingoohan1@gmail.com,
        robh@kernel.org, martin.blumenstingl@googlemail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Subject: Re: [PATCH v6 2/3] dwc: PCI: intel: PCIe RC controller driver
Message-ID: <20191113110009.GC32742@smile.fi.intel.com>
References: <cover.1573613534.git.eswara.kota@linux.intel.com>
 <897ef494f39291797a92efb87a59961d36384019.1573613534.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <897ef494f39291797a92efb87a59961d36384019.1573613534.git.eswara.kota@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 13, 2019 at 03:21:21PM +0800, Dilip Kota wrote:
> Add support to PCIe RC controller on Intel Gateway SoCs.
> PCIe controller is based of Synopsys DesignWare PCIe core.
> 
> Intel PCIe driver requires Upconfigure support, Fast Training
> Sequence and link speed configurations. So adding the respective
> helper functions in the PCIe DesignWare framework.
> It also programs hardware autonomous speed during speed
> configuration so defining it in pci_regs.h.

> +#include <linux/of_irq.h>

> +#include <linux/of_platform.h>

I hardly see the use of above...

> +	if (device_property_read_u32(dev, "reset-assert-ms", &lpp->rst_intrvl))
> +		lpp->rst_intrvl = RESET_INTERVAL_MS;

...perhaps you need to add

#include <linux/property.h>

instead.

-- 
With Best Regards,
Andy Shevchenko


