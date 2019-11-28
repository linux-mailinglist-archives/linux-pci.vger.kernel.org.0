Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F20210C4F9
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2019 09:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfK1IXR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Nov 2019 03:23:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:53174 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbfK1IXR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Nov 2019 03:23:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 00:23:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,252,1571727600"; 
   d="scan'208";a="217551530"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 28 Nov 2019 00:23:14 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 28 Nov 2019 10:23:14 +0200
Date:   Thu, 28 Nov 2019 10:23:14 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Vidya Sagar <vidyas@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: Issue with 395f121e6199 ("PCI/PM: Wait for device to become
 ready after power-on")
Message-ID: <20191128082314.GD2665@lahna.fi.intel.com>
References: <20191127153433.GA2665@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127153433.GA2665@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

For some reason I don't see this in linux-pci archives. Maybe it was not
accepted because of the attachment? In any case the full dmesg can be
found here as well:

  https://gist.github.com/westeri/ca2574a4e48dc6e3eb76184922e103e5

On Wed, Nov 27, 2019 at 05:34:37PM +0200, Mika Westerberg wrote:
> Hi,
> 
> I noticed that latest Bjorn's pci/pm branch breaks native PCIe hotplug
> so that when I unplug a device (connected over TBT) the pciehp notices
> it but then the core PCI code starts waiting for all the devices that
> are now gone:
> 
> [  160.344476] pcieport 0000:04:04.0: pciehp: pciehp_check_link_active: lnk_status = 5041
> [  160.344531] pcieport 0000:04:04.0: pciehp: Slot(4): Card not present
> [  160.346004] pcieport 0000:04:04.0: pciehp: pciehp_unconfigure_device: domain:bus:dev = 0000:3a:00
> [  161.421569] pcieport 0000:3a:00.0: not ready 1023ms after Switch to D0; waiting
> [  162.509610] pcieport 0000:3a:00.0: not ready 2047ms after Switch to D0; waiting
> [  164.621620] pcieport 0000:3a:00.0: not ready 4095ms after Switch to D0; waiting
> [  169.165529] pcieport 0000:3a:00.0: not ready 8191ms after Switch to D0; waiting
> [  177.869521] pcieport 0000:3a:00.0: not ready 16383ms after Switch to D0; waiting
> [  194.765581] pcieport 0000:3a:00.0: not ready 32767ms after Switch to D0; waiting
> ...
> 
> It seems to continue forever so the devices are not removed from the
> system.
> 
> The test system used here is Dell XPS 9380 but it happens also on other
> systems that support native PCIe hotplug.
> 
> Reverting 395f121e6199 ("PCI/PM: Wait for device to become ready after
> power-on") makes the problem go away.
> 
> I've attached full dmesg from the system. The way I reproduce this is
> that I boot the system up (no device connected yet), the I connect TBT
> dock that includes the PCIe switch etc. Then I unplug the dock. The
> unplug happens around 160.335355 in the dmesg.
