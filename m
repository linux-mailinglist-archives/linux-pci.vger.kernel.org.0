Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE3F81A23
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 15:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfHENAm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 09:00:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:17745 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbfHENAm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 09:00:42 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 06:00:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="192414726"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 05 Aug 2019 06:00:40 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 05 Aug 2019 16:00:39 +0300
Date:   Mon, 5 Aug 2019 16:00:39 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Matthias Andree <matthias.andree@gmx.de>,
        linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: regression: PCIe resume from suspend stalls I/O and causes
 interrupt storms in Linux 5.3-rc2 (5.2.5, 5.1.20) on Ryzen 7 1700/AMD X370
 MSI board since 5817d78eba34f6c86f5462ae2c5212f80a013357, 5.2/5.3 w/ pcieIRQ
 loop.
Message-ID: <20190805130039.GP2640@lahna.fi.intel.com>
References: <935c6fd8-c606-836a-9e59-772b9111d5d6@gmx.de>
 <20190805122751.GL2640@lahna.fi.intel.com>
 <20190805124704.GP151852@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805124704.GP151852@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 05, 2019 at 07:47:05AM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 05, 2019 at 03:27:51PM +0300, Mika Westerberg wrote:
> > Are you able to get dmesg after resume or is it completely dead? It
> > would help you we could see how long it tries to wait for the downstream
> > link by passing "pciepordrv.dyndbg" to the kernel command line.
> 
> "pcieportdrv.dyndbg" (with "t"), I think.

Right, thanks for the correction.
