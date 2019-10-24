Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12DA5E2DA1
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 11:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438659AbfJXJiJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 05:38:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:1200 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438652AbfJXJiJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 05:38:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 02:38:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,224,1569308400"; 
   d="scan'208";a="210117869"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 24 Oct 2019 02:38:04 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 24 Oct 2019 12:38:03 +0300
Date:   Thu, 24 Oct 2019 12:38:03 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: pciehp: Prevent deadlock on disconnect
Message-ID: <20191024093803.GU2819@lahna.fi.intel.com>
References: <20190812143133.75319-2-mika.westerberg@linux.intel.com>
 <20191022230006.GA46791@google.com>
 <20191023075248.GO2819@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023075248.GO2819@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 10:52:53AM +0300, Mika Westerberg wrote:
> > Shouldn't we check for slot_status being an error response (~0)
> > instead of looking for PCIBIOS_DEVICE_NOT_FOUND?  There are 7 RsvdP
> > bits in Slot Status, so ~0 is not a valid value for the register.
> > 
> > All 16 bits of Link Status are defined, but ~0 is still an invalid
> > value because the Current Link Speed and Negotiated Link Width fields
> > only define a few valid encodings.
> 
> Indeed that's a good point. I'll try that.

Just checking if I understand correctly what you are suggesting.

Currently we use pcie_capability_read_word() and check the return value.
If the device is gone it returns an error and resets *val to 0. That
only works if pci_dev_is_disconnected() is true so we would need to do
something like below.

pciehp_check_link_active():

	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
	if (ret == PCIBIOS_DEVICE_NOT_FOUND || lnk_status == (u16)~0)
		return -ENODEV;

Or you mean that we check only for ~0 in which case we either need to
use pci_read_config_word() directly here or modify pcie_capability_read_word()
return ~0 instead of clearing it?
