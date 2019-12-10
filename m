Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31361118159
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 08:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfLJH2E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 02:28:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:52144 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbfLJH2E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 02:28:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 23:28:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,298,1571727600"; 
   d="scan'208";a="220151589"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 09 Dec 2019 23:28:01 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 10 Dec 2019 09:28:00 +0200
Date:   Tue, 10 Dec 2019 09:28:00 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Linux v5.5 serious PCI bug
Message-ID: <20191210072800.GY2665@lahna.fi.intel.com>
References: <PSXP216MB0438BFEAA0617283A834E11580580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191209131239.GP2665@lahna.fi.intel.com>
 <PSXP216MB043809A423446A6EF2C7909A80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB043809A423446A6EF2C7909A80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 01:33:49PM +0000, Nicholas Johnson wrote:
> On Mon, Dec 09, 2019 at 03:12:39PM +0200, mika.westerberg@linux.intel.com wrote:
> > On Mon, Dec 09, 2019 at 12:34:04PM +0000, Nicholas Johnson wrote:
> > > Hi,
> > > 
> > > I have compiled Linux v5.5-rc1 and thought all was good until I 
> > > hot-removed a Gigabyte Aorus eGPU from Thunderbolt. The driver for the 
> > > GPU was not loaded (blacklisted) so the crash is nothing to do with the 
> > > GPU driver.
> > > 
> > > We had:
> > > - kernel NULL pointer dereference
> > > - refcount_t: underflow; use-after-free.
> > > 
> > > Attaching dmesg for now; will bisect and come back with results.
> > 
> > Looks like something related to iommu. Does it work if you disable it?
> > (intel_iommu=off in the command line).
> On Mon, Dec 09, 2019 at 03:12:39PM +0200, mika.westerberg@linux.intel.com wrote:
> > On Mon, Dec 09, 2019 at 12:34:04PM +0000, Nicholas Johnson wrote:
> > > Hi,
> > > 
> > > I have compiled Linux v5.5-rc1 and thought all was good until I 
> > > hot-removed a Gigabyte Aorus eGPU from Thunderbolt. The driver for the 
> > > GPU was not loaded (blacklisted) so the crash is nothing to do with the 
> > > GPU driver.
> > > 
> > > We had:
> > > - kernel NULL pointer dereference
> > > - refcount_t: underflow; use-after-free.
> > > 
> > > Attaching dmesg for now; will bisect and come back with results.
> > 
> > Looks like something related to iommu. Does it work if you disable it?
> > (intel_iommu=off in the command line).
> I thought it could be that, too.
> 
> The attachment "dmesg-4" from the original email is with iommu parameters.
> The attachment "dmesg-5" from the original email is with no iommu parameters.
> Attaching here "dmesg-6" with the iommu explicitly set off like you said.
> 
> No difference, still broken. Although, with iommu off, there are less stack traces.
> 
> Could it be sysfs-related?

Bisect would probably be the best option to find the culprit commit.
There are couple of commits done for pciehp so reverting them one by one
may help as well:

  87d0f2a5536f PCI: pciehp: Prevent deadlock on disconnect
  75fcc0ce72e5 PCI: pciehp: Do not disable interrupt twice on suspend
  b94ec12dfaee PCI: pciehp: Refactor infinite loop in pcie_poll_cmd()
  157c1062fcd8 PCI: pciehp: Avoid returning prematurely from sysfs requests
