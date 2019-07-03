Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE0255E3FC
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 14:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfGCMal (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 08:30:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:12291 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfGCMak (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 08:30:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 05:30:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="184735341"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 03 Jul 2019 05:30:37 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 03 Jul 2019 15:30:37 +0300
Date:   Wed, 3 Jul 2019 15:30:36 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Add sysfs attribute for disabling PCIe link to
 downstream component
Message-ID: <20190703123036.GT2640@lahna.fi.intel.com>
References: <20190529104942.74991-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529104942.74991-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 29, 2019 at 01:49:42PM +0300, Mika Westerberg wrote:
> PCIe root and downstream ports have link control register that can be
> used disable the link from software. This can be useful for instance
> when performing "software" hotplug on systems that do not support real
> PCIe/ACPI hotplug.
> 
> For example when used with FPGA card we can burn a new FPGA image
> without need to reboot the system.
> 
> First we remove the FGPA device from Linux PCI stack:
> 
>   # echo 1 > /sys/bus/pci/devices/0000:00:01.1/0000:02:00.0/remove
> 
> Then we disable the link:
> 
>   # echo 1 > /sys/bus/pci/devices/0000:00:01.1/link_disable
> 
> By doing this we prevent the kernel from accessing the hardware while we
> burn the new FPGA image. Once the new FPGA is burned we can re-enable
> the link and rescan the new and possibly different device:
> 
>   # echo 0 > /sys/bus/pci/devices/0000:00:01.1/link_disable
>   # echo 1 > /sys/bus/pci/devices/0000:00:01.1/rescan
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Hi,

Any comments on this?
