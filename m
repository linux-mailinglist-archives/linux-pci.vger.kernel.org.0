Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA152B401D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 10:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgKPJpq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 04:45:46 -0500
Received: from mga01.intel.com ([192.55.52.88]:5891 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgKPJpq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Nov 2020 04:45:46 -0500
IronPort-SDR: NJatGgd18tVl4SD2dQ1+yZDspB9P9R7Rhp3QTpWy+3TBcKAV3b4FOJUqkSc/KCnIebohfMnnFa
 fN3Q4VmcV4wA==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="188765839"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="188765839"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 01:45:45 -0800
IronPort-SDR: gIP0rCAo4mkKsHuXyuTnpVM7aQjYg9hJrCd7ALKlccfDca1wa+Y3bWgMN9LX3BAFEUWhyuiBDj
 SdijufW3CLdw==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="475465999"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 01:45:42 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1keb5w-0072IO-Mb; Mon, 16 Nov 2020 11:46:44 +0200
Date:   Mon, 16 Nov 2020 11:46:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        johan@kernel.org, linux-usb@vger.kernel.org,
        alberto.vignani@fastwebnet.it
Subject: Re: [PATCH v2 1/2] PCI: Disable MSI for Pericom PCIe-USB adapter
Message-ID: <20201116094644.GP4077@smile.fi.intel.com>
References: <20201106100526.17726-1-andriy.shevchenko@linux.intel.com>
 <20201113232138.GA1141907@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113232138.GA1141907@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 13, 2020 at 05:21:38PM -0600, Bjorn Helgaas wrote:
> On Fri, Nov 06, 2020 at 12:05:25PM +0200, Andy Shevchenko wrote:
> > Pericom PCIe-USB adapter advertises MSI, but documentation says
> > "The MSI Function is not implemented on this device." in the chapters
> > 7.3.27, 7.3.29-7.3.31.
> > 
> > Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> > Datasheet: https://www.diodes.com/assets/Datasheets/PI7C9X440SL.pdf
> > Reported-by: alberto.vignani@fastwebnet.it
> 
> Is there a URL to a problem report we can include here?

You mean URL to email archives or something else?

-- 
With Best Regards,
Andy Shevchenko


