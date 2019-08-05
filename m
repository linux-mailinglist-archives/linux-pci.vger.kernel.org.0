Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D42C81FC5
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 17:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbfHEPIG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 11:08:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:43084 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727259AbfHEPIG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 11:08:06 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 08:08:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,350,1559545200"; 
   d="scan'208";a="192438041"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 05 Aug 2019 08:08:04 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 05 Aug 2019 18:08:03 +0300
Date:   Mon, 5 Aug 2019 18:08:03 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Matthias Andree <matthias.andree@gmx.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: regression: PCIe resume from suspend stalls I/O and causes
 interrupt storms in Linux 5.3-rc2 (5.2.5, 5.1.20) on Ryzen 7 1700/AMD X370
 MSI board since 5817d78eba34f6c86f5462ae2c5212f80a013357, 5.2/5.3 w/ pcieIRQ
 loop.
Message-ID: <20190805150803.GU2640@lahna.fi.intel.com>
References: <935c6fd8-c606-836a-9e59-772b9111d5d6@gmx.de>
 <20190805122751.GL2640@lahna.fi.intel.com>
 <20190805124704.GP151852@google.com>
 <20190805130039.GP2640@lahna.fi.intel.com>
 <0d234153-3c30-c0da-7419-220528897fbf@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d234153-3c30-c0da-7419-220528897fbf@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 05, 2019 at 04:01:11PM +0200, Matthias Andree wrote:
> Am 05.08.19 um 15:00 schrieb Mika Westerberg:
> > On Mon, Aug 05, 2019 at 07:47:05AM -0500, Bjorn Helgaas wrote:
> >> On Mon, Aug 05, 2019 at 03:27:51PM +0300, Mika Westerberg wrote:
> >>> Are you able to get dmesg after resume or is it completely dead? It
> >>> would help you we could see how long it tries to wait for the downstream
> >>> link by passing "pciepordrv.dyndbg" to the kernel command line.
> >> "pcieportdrv.dyndbg" (with "t"), I think.
> > Right, thanks for the correction.
> 
> Hi Mika, Bjorn,
> 
> thanks for picking this up. I have used pcieportdrv.dyndbg=+p (not sure
> if something else would have worked) and was lucky that I could transfer
> dmesg to a USB stick before the machine went completely unusable.
> 
> $ grep pcieport dmesg.txt
> 
> [    0.698739] pcieport 0000:00:01.3: Signaling PME with IRQ 28
> [    0.698799] pcieport 0000:00:01.3: AER: enabled with IRQ 28
> [    0.698966] pcieport 0000:00:03.1: Signaling PME with IRQ 29
> [    0.699017] pcieport 0000:00:03.1: AER: enabled with IRQ 29
> [    0.699188] pcieport 0000:00:07.1: Signaling PME with IRQ 30
> [    0.699230] pcieport 0000:00:07.1: AER: enabled with IRQ 30
> [    0.699816] pcieport 0000:00:08.1: Signaling PME with IRQ 31
> [    0.699860] pcieport 0000:00:08.1: AER: enabled with IRQ 31
> [  119.637492] pcieport 0000:00:03.1: waiting downstream link for 100 ms
> [  119.649285] pcieport 0000:00:08.1: waiting downstream link for 100 ms
> [  119.649287] pcieport 0000:00:07.1: waiting downstream link for 100 ms
> [  119.649376] pcieport 0000:00:01.3: waiting downstream link for 100 ms
> [  119.803025] pcieport 0000:16:08.0: waiting downstream link for 100 ms
> [  119.803031] pcieport 0000:16:01.0: waiting downstream link for 100 ms

Can you also attach the dmesg.txt to the bugzilla entry?
