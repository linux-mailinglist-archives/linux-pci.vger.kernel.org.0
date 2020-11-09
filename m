Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D07E2AB7BB
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 13:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbgKIMGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 07:06:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:13017 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729504AbgKIMGU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Nov 2020 07:06:20 -0500
IronPort-SDR: nPtuPPQmV6olgwBD0TbZlOVX/yIDdaFGG5WU+voTY+o0EWBkKHv3T9Sw/jQ51EMvxF8vnUxpnI
 fTuGp3XDM80w==
X-IronPort-AV: E=McAfee;i="6000,8403,9799"; a="169942299"
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="169942299"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 04:06:20 -0800
IronPort-SDR: aDKjMFMphfV5jlQG3j5+FtIr//mEwonXrVOGpePBLCiOpdKfVkYmM0s1TUE10Qh/6FMvEoARbO
 BH8qMM8ve5UA==
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="472946435"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 04:06:18 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kc5xA-005AhI-PQ; Mon, 09 Nov 2020 14:07:20 +0200
Date:   Mon, 9 Nov 2020 14:07:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     alberto.vignani@fastwebnet.it
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        johan@kernel.org, linux-usb@vger.kernel.org
Subject: Re: R: [PATCH v2 1/2] PCI: Disable MSI for Pericom PCIe-USB adapter
Message-ID: <20201109120720.GB4077@smile.fi.intel.com>
References: <33436598.119601604676865427.JavaMail.root@pr006msr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33436598.119601604676865427.JavaMail.root@pr006msr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 06, 2020 at 04:34:25PM +0100, alberto.vignani@fastwebnet.it wrote:
> Tested-by: alberto.vignani@fastwebnet.it

Thanks!

JFYI: it seems somewhere your mail lost References: and In-Reply-To: headers.
The above message probably won't be seen by bots.

-- 
With Best Regards,
Andy Shevchenko


