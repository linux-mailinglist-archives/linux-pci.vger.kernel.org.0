Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC4B9B2FC
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2019 17:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732923AbfHWPF7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Aug 2019 11:05:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:20136 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732530AbfHWPF7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Aug 2019 11:05:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 08:05:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,421,1559545200"; 
   d="scan'208";a="186890433"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Aug 2019 08:05:58 -0700
Date:   Fri, 23 Aug 2019 09:04:03 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/3] PCI: Add PCI_ERROR_RESPONSE, check for errors
Message-ID: <20190823150403.GB16605@localhost.localdomain>
References: <20190822200551.129039-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822200551.129039-1-helgaas@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
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

Series looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
