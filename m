Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70415F1727
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 14:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfKFNbo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 08:31:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:21090 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfKFNbo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 08:31:44 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 05:31:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,274,1569308400"; 
   d="scan'208";a="212774039"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 06 Nov 2019 05:31:38 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 06 Nov 2019 15:31:37 +0200
Date:   Wed, 6 Nov 2019 15:31:37 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: Add missing link delays required by the PCIe
 spec
Message-ID: <20191106133137.GN2552@lahna.fi.intel.com>
References: <20191105125818.GW2552@lahna.fi.intel.com>
 <20191105200105.GA239884@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105200105.GA239884@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 05, 2019 at 02:01:05PM -0600, Bjorn Helgaas wrote:
> > I feel that the following is the right place to perform the delay but if
> > you think we can ignore the above, I will just do what you say and do it
> > in pci_pm_default_resume_early() (and pci_restore_standard_config() for
> > runtime path).
> > 
> > [The below diff does not have check for pci_dev->skip_bus_pm because I
> >  was planning to move it inside pci_bridge_wait_for_secondary_bus() itself.]
> 
> What do you gain by moving it?  IIUC we want them to be the same
> condition, and if one is in pci_pm_resume_noirq() and another is
> inside pci_bridge_wait_for_secondary_bus(), it's hard to see that
> they're connected.  I'd rather have pci_pm_resume_noirq() check it
> once, save the result, and test that result before calling
> pci_pm_default_resume_early() and pci_bridge_wait_for_secondary_bus().

Fair enough :)
