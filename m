Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1126BA6B91
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2019 16:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbfICOcp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Sep 2019 10:32:45 -0400
Received: from mga03.intel.com ([134.134.136.65]:33380 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728992AbfICOcp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Sep 2019 10:32:45 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 07:32:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,463,1559545200"; 
   d="scan'208";a="198783088"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 03 Sep 2019 07:32:40 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 03 Sep 2019 17:32:40 +0300
Date:   Tue, 3 Sep 2019 17:32:40 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: lockdep warning on thunderbolt docking
Message-ID: <20190903143240.GH2691@lahna.fi.intel.com>
References: <20190830125848.GA25929@owl.dominikbrodowski.net>
 <20190831130317.GL3177@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190831130317.GL3177@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Aug 31, 2019 at 04:03:21PM +0300, Mika Westerberg wrote:
> Hi Dominik,
> 
> On Fri, Aug 30, 2019 at 02:58:48PM +0200, Dominik Brodowski wrote:
> > When connecting a thunderbolt-enabled docking station to my work laptop,
> > the following lockdep warning is reported on v5.3.0-rc6+ as of Thursday
> > morning (can look up the exact git id if so required):
> 
> Thanks for reporting. No need to dig for the commit ID.
> 
> I'll take a look at this next week.

This seems to be impossible case. The two code paths cannot run at the
same time (on different CPUs) because device authorization is only
possible after the domain itself has been added and we've got firmware
notification that there is a device connected.

This was added by me in commit a03e828915c0 ("thunderbolt: Serialize
PCIe tunnel creation with PCI rescan") claiming that it prevents PCI
rescan code to find connected devices too early but now that I have
gotten bit more experience in PCIe, I think this is not the case. I
think I probably actually saw some issue in PCI stack that may even be
fixed already. I'm going to try to reproduce the original issue and see
if we can get rid of the whole pci_rescan_remove_lock in the driver.
