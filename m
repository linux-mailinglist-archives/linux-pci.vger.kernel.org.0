Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1098C2A937F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 10:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgKFJ4d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 04:56:33 -0500
Received: from mga03.intel.com ([134.134.136.65]:16239 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgKFJ4d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Nov 2020 04:56:33 -0500
IronPort-SDR: ZVzZVOJi8qdcDLkvDN2x7HOIcR7JDPo9ByZhLb91bDTxmJlpk1M+5hM/gvsNHrQ9N6MFRmkDYK
 8MQ7f0Uifo9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9796"; a="169637066"
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="169637066"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 01:56:32 -0800
IronPort-SDR: TtwNFTBBvfR0+0Mhd2ChS+MDQxpr/8FCMIpGrGTcMWAS1062acKzBcCWlzfU/NLlIL7komJas9
 aFeW52Uhy3vQ==
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="321542744"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 01:56:30 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kayUu-004Is0-QO; Fri, 06 Nov 2020 11:57:32 +0200
Date:   Fri, 6 Nov 2020 11:57:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        johan@kernel.org, linux-usb@vger.kernel.org,
        alberto.vignani@fastwebnet.it
Subject: Re: [PATCH v1 1/2] PCI: Disable MSI for Pericom PCIe-USB adapter
Message-ID: <20201106095732.GF4077@smile.fi.intel.com>
References: <20201105180644.42862-1-andriy.shevchenko@linux.intel.com>
 <0c48dd87-82a2-3dfa-6b00-57ccf9d5dd0b@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c48dd87-82a2-3dfa-6b00-57ccf9d5dd0b@codethink.co.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 05, 2020 at 08:42:03PM +0000, Ben Dooks wrote:
> On 05/11/2020 18:06, Andy Shevchenko wrote:
> > Pericom PCIe-USB adapter ambiguously advertises MSI, but documentation says
> > "The MSI Function is not implemented on this device." in the chapters 7.3.27,
> > 7.3.29-7.3.31.

Thanks for review.

> > +	pci_info(dev, "The MSI Function is not implemented on this device, disabling it\n");
> > +	dev->no_msi = 1;
> > +
> >   	pci_info(dev, "PME# is unreliable, disabling it\n");
> >   	dev->pme_support = 0;
> 
> idea: one pci_info() print of:
> 
> pci_info(dev, "PME# is unreliable, MSI not implemented, disabling both\n");

I am not in favour of it. Perhaps I can do #ifdef CONFIG_PCI_MSI for those two.

> > -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400e, pci_fixup_no_pme);
> > -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400f, pci_fixup_no_pme);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400e, pci_fixup_no_msi_no_pme);
> > +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400f, pci_fixup_no_msi_no_pme);

-- 
With Best Regards,
Andy Shevchenko


