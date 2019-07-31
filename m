Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 164547D015
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2019 23:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfGaVaK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Jul 2019 17:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:39904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfGaVaJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 31 Jul 2019 17:30:09 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EF1E20679;
        Wed, 31 Jul 2019 21:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564608608;
        bh=oGnVpX4dVrD+Qozo8zDA1ZPwnhAHqFMVwK0fzQ1mFIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GsHIIfWm8iROi366bFleIDVx8TuDAQ/JvQk8TqpznFLhj3NbKvFq927w/uQR2pA3g
         sANKPraFKMDiKLp4beYs+dKfgz8KDH+fTcPkhcND/J2vzdUQvyjMX5aDm7P7yyi6M5
         RwsVnvuqMelMzMi9+Y4CwkZO5lIAcdnIF+lCJBfY=
Date:   Wed, 31 Jul 2019 16:30:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: Re: [Regression] Commit "ACPI: PM: Allow transitions to D0 to occur
 in special cases"
Message-ID: <20190731213001.GC151852@google.com>
References: <578BD3F1-B185-471B-A3EB-FF71BA34B822@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <578BD3F1-B185-471B-A3EB-FF71BA34B822@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Thunderbolt folks, see
https://lore.kernel.org/r/578BD3F1-B185-471B-A3EB-FF71BA34B822@canonical.com
for beginning of thread]

On Thu, Aug 01, 2019 at 12:04:29AM +0800, Kai-Heng Feng wrote:
> Hi,
> 
> After commit "ACPI: PM: Allow transitions to D0 to occur in special cases”,

This is f850a48a0799 ("ACPI: PM: Allow transitions to D0 to occur in
special cases").

> Thunderbolt on XPS 9380 spews the following when it runtime resumes:
> [   36.136554] pci_raw_set_power_state: 25 callbacks suppressed
> [   36.136558] pcieport 0000:03:00.0: Refused to change power state,
> currently in D3

We really should be smarter about what we print here, maybe something
like the patch below?

pci_raw_set_power_state() prints "Refused to change power state" if
(in this case) the value of (PCI_PM_CTRL & PCI_PM_CTRL_STATE_MASK) is
0x3.  Most likely we got 0xffff from PCI_PM_CTRL because the device is
in D3cold.  If the device is in D3cold, pci_raw_set_power_state() has
no hope of doing anything because it only uses PCI PM config
registers, and they're inaccessible in D3cold.

Presumably there's some platform PM method that is supposed to take
the device out of D3cold, and maybe we're missing that somehow?

Based on an lspci I found at [1], I suspect 03:00.0 is a Thunderbolt
switch leading to [bus 04-6d].  From your log, it looks like these
devices don't work:

  03:00.0 Thunderbolt Upstream Port
  04:00.0 Thunderbolt Downstream Port
  04:01.0 Thunderbolt Downstream Port (Slot 1)
  04:02.0 Thunderbolt Downstream Port
  04:04.0 Thunderbolt Downstream Port (Slot 4)
  05:00.0 Thunderbolt NHI
  39:00.0 XHCI USB

If 03:00.0 is stuck in D3cold, that would explain why none of these
things work.

[1] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1826125


diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 29ed5ec1ac27..63ca963ebff9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -851,6 +852,11 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 		return -EIO;
 
 	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
+	if (pmcsr == (u16) ~0) {
+		pci_err(dev, "device not responding; can't change to power state D%d\n",
+			state);
+		return -EIO;
+	}
 
 	/*
 	 * If we're (effectively) in D3, force entire word to 0.
