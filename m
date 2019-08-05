Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE1481948
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 14:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbfHEM1z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 08:27:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:3709 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbfHEM1z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 08:27:55 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2019 05:27:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,349,1559545200"; 
   d="scan'208";a="192409924"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 05 Aug 2019 05:27:52 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 05 Aug 2019 15:27:51 +0300
Date:   Mon, 5 Aug 2019 15:27:51 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Matthias Andree <matthias.andree@gmx.de>
Cc:     linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: regression: PCIe resume from suspend stalls I/O and causes
 interrupt storms in Linux 5.3-rc2 (5.2.5, 5.1.20) on Ryzen 7 1700/AMD X370
 MSI board since 5817d78eba34f6c86f5462ae2c5212f80a013357, 5.2/5.3 w/ pcieIRQ
 loop.
Message-ID: <20190805122751.GL2640@lahna.fi.intel.com>
References: <935c6fd8-c606-836a-9e59-772b9111d5d6@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <935c6fd8-c606-836a-9e59-772b9111d5d6@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 02, 2019 at 09:03:06PM +0200, Matthias Andree wrote:
> Greetings, 

Hi,

> Commit 5817d78eba34f6c86f5462ae2c5212f80a013357 (written by Mika
> Westerberg) causes regressions on resume from S3 suspend on my MSI X370
> w/ Ryzen 7 1700, which is, TTBOMK, a PCI Express 3.0 platform.
> Consequences are hung disk and net I/O although re-login to GNOME works
> on 5.1.20, albeit very slowly. The machine is unusable after resume from
> that point.
> 
> 5.2.5 and 5.3-rc2 will go into a tight loop of pcieport 0000:00:01.3:
> PME: Spurious native interrupt! and need to be rebooted.
> 
> bad: v5.3-rc2
> 
> good: v5.3-rc2-111-g97b00aff2c45 + "git revert 5817d78eba"
> 
> Reverting that commit shown above restores suspend functionality for me,
> two S3 suspend/resume cycles work.
> 
> For details, more information (lspci, versions found) is at:
> 
> * Kernel Bugzilla, https://bugzilla.kernel.org/show_bug.cgi?id=204413
> 
> * Fedora/Redhat Bugzilla,
> https://bugzilla.redhat.com/show_bug.cgi?id=1737046
> 
> 
> Same findings for v5.2.5 on stable kernel, reverting the relevant commit
> (SHA is 5817d78eba34f6c86f5462ae2c5212f80a013357 there) also fixes
> suspend/resume problems for me.
> 
> Let me know if you need me to pull out any further hardware or kernel
> debug info, but please be specific with instructions - I am not a kernel
> hacker (although I have been exposed to C for nearly 30 years and
> Linux/FreeBSD for some 20 years). Pointing me to relevant URLs with
> debug instructions is fine. I have a Git tree handy and this octocore
> sitting here compiles a kernel in < 10 minutes.

Are you able to get dmesg after resume or is it completely dead? It
would help you we could see how long it tries to wait for the downstream
link by passing "pciepordrv.dyndbg" to the kernel command line.

Can you also try to revert 00ebf1348cb332941dab52948f29480592bfbe6a
("PCI/PME: Replace dev_printk(KERN_DEBUG) with dev_info()") so that it
does not spam dmesg too much?

Thanks!
