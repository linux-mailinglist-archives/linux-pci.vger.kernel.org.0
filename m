Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD422B7F2D
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 15:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgKROKy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 09:10:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:52064 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgKROKx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 09:10:53 -0500
IronPort-SDR: 6no06CTw0MwqiduRF1R2qRjquOppJwM4oWiYpeK+ZNtZoWLYmq0O4dToppUIF6TyoQGG+c4YAv
 vXZL+/KgPz9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="168547997"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="168547997"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 06:10:49 -0800
IronPort-SDR: jH2F7/AOrkFHJyvp4yNNlSaVwwN/y5TqkFiYty20BzWIrmtNx7Ouc238D/Ph+j4UARUxnCgSdk
 4qeCHYlVEKiQ==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="532716712"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 06:10:48 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kfOBa-007e3g-Ea; Wed, 18 Nov 2020 16:11:50 +0200
Date:   Wed, 18 Nov 2020 16:11:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        johan@kernel.org, linux-usb@vger.kernel.org,
        alberto.vignani@fastwebnet.it
Subject: Re: [PATCH v2 1/2] PCI: Disable MSI for Pericom PCIe-USB adapter
Message-ID: <20201118141150.GT4077@smile.fi.intel.com>
References: <20201106100526.17726-1-andriy.shevchenko@linux.intel.com>
 <20201117233252.GA21051@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117233252.GA21051@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 17, 2020 at 05:32:52PM -0600, Bjorn Helgaas wrote:
> On Fri, Nov 06, 2020 at 12:05:25PM +0200, Andy Shevchenko wrote:

...

> I added the URL you sent and applied both of these, thanks!

Thank you!

-- 
With Best Regards,
Andy Shevchenko


