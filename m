Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7732F9A8A6
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 09:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbfHWHWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Aug 2019 03:22:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:21539 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731211AbfHWHWO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Aug 2019 03:22:14 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 00:22:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,420,1559545200"; 
   d="scan'208";a="196424280"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 23 Aug 2019 00:22:10 -0700
Received: by lahna (sSMTP sendmail emulation); Fri, 23 Aug 2019 10:22:09 +0300
Date:   Fri, 23 Aug 2019 10:22:09 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/3] PCI: Add PCI_ERROR_RESPONSE, check for errors
Message-ID: <20190823072209.GR19908@lahna.fi.intel.com>
References: <20190822200551.129039-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822200551.129039-1-helgaas@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 22, 2019 at 03:05:48PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Reads from a PCI device may fail if the device has been turned off (put
> into D3cold), removed, or if some other error occurs.  The PCI host bridge
> typically fabricates ~0 data to complete the CPU's read.
> 
> We check for that in a few places, but not in a consistent way.  This
> series adds a PCI_ERROR_RESPONSE definition to make the checks more
> consistent and easier to find.  Note that ~0 may indicate a PCI error, but
> it may also be valid read data, so you need more information (such as
> knowing that a register can never contain ~0) before concluding that it's
> an error.
> 
> This series also adds a new check for PCI_ERROR_RESPONSE in the power
> management code because that code frequently encounters devices in D3cold,
> where we previously misinterpreted ~0 data.  It also uses pci_power_name()
> to print D-state names more consistently.
> 
> Rafael, I didn't add your Reviewed-by to "PCI / PM: Return error when
> changing power state from D3cold" because I made small changes to try to
> make the messages more consistent, and I didn't want to presume they'd be
> OK with you.
> 
> Changes since v1:
>   - Add Rafael's Reviewed-By to the first two patches
>   - Drop "PCI / PM: Check for error when reading PME status" because Rafael
>     pointed out that some devices can signal PME even when in D3cold, so
>     this would require additional rework
>   - Drop "PCI / PM: Check for error when reading Power State" because
>     Rafael thinks it's mostly redundant
> 
> Bjorn Helgaas (3):
>   PCI: Add PCI_ERROR_RESPONSE definition
>   PCI / PM: Decode D3cold power state correctly
>   PCI / PM: Return error when changing power state from D3cold

For the whole series,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
