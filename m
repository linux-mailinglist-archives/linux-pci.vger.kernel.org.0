Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1A4D105B57
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 21:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKUUt2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 15:49:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:55762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfKUUt2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 15:49:28 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BD242068D;
        Thu, 21 Nov 2019 20:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574369366;
        bh=5De6lyHZUeIRTKocUVUZWotA5hsrs6wr64RApzhHGgI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RxqRR/wsuytn/Fk9HzlloMcfWPyCmZvWj4q5D85e7WnL/HwjE6sSpXaCPt5ezzfHP
         hx/jsG8D4t+dyh/UgLYDBunGpDfNo6DiRQO9HG1UlrYGlkIXA2O8vSBaqnwpANHKV9
         Oqy0KvYY0UM3dpvN+VOgNPO9C1kXgK+k9Abhx2DU=
Date:   Thu, 21 Nov 2019 14:49:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Frederick Lawler <fred@fredlawl.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wong Vee Khee <vee.khee.wong@ni.com>,
        Hui Chun Ong <hui.chun.ong@ni.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/5] PCI/ASPM: Add sysfs attributes for controlling
 ASPM link states
Message-ID: <20191121204924.GA81030@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1c83f8a-9bf6-eac5-82d0-cf5b90128fbf@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Rafael, Mika, Wong, Hui, Rajat, Keith, LKML, original patch at [5]]

On Sat, Oct 05, 2019 at 02:07:56PM +0200, Heiner Kallweit wrote:

> +What:		/sys/bus/pci/devices/.../link_pm/clkpm
> +		/sys/bus/pci/devices/.../link_pm/l0s_aspm
> +		/sys/bus/pci/devices/.../link_pm/l1_aspm
> +		/sys/bus/pci/devices/.../link_pm/l1_1_aspm
> +		/sys/bus/pci/devices/.../link_pm/l1_2_aspm
> +		/sys/bus/pci/devices/.../link_pm/l1_1_pcipm
> +		/sys/bus/pci/devices/.../link_pm/l1_2_pcipm
> +Date:		October 2019
> +Contact:	Heiner Kallweit <hkallweit1@gmail.com>
> +Description:	If ASPM is supported for an endpoint, then these files
> +		can be used to disable or enable the individual
> +		power management states. Write y/1/on to enable,
> +		n/0/off to disable.

This is queued up for the v5.5 merge window, so if we want to tweak
anything (path names or otherwise), now is the time.

I think I might be inclined to change the directory from "link_pm" to
"link", e.g.,

  - /sys/bus/pci/devices/0000:00:1c.0/link_pm/clkpm
  + /sys/bus/pci/devices/0000:00:1c.0/link/clkpm

because there are other things that haven't been merged yet that could
go in link/ as well:

  * Mika's "link disable" control [1]
  * Dilip's link width/speed controls [2,3]

The max_link_speed, max_link_width, current_link_speed,
current_link_width files could also logically be in link/, although
they've already been merged at the top level.

Rajat's AER statistics change [4] is also coming.  Those stats aren't
link-related, so they wouldn't go in link/.  The current strawman is
an "aer_stats" directory, but I wonder if we should make a more
generic directory like "errors" that could be used for both AER and
DPC and potentially other error-related things.

For example, we could have these link-related things:

  /sys/.../0000:00:1c.0/link/clkpm            # RW ASPM stuff
  /sys/.../0000:00:1c.0/link/l0s_aspm
  /sys/.../0000:00:1c.0/link/...
  /sys/.../0000:00:1c.0/link/disable          # RW Mika
  /sys/.../0000:00:1c.0/link/speed            # RW Dilip's control
  /sys/.../0000:00:1c.0/link/width            # RW Dilip's control
  /sys/.../0000:00:1c.0/link/max_speed        # RO possible rework
  /sys/.../0000:00:1c.0/link/max_width        # RO possible rework

With these backwards compatibility symlinks:

  /sys/.../0000:00:1c.0/max_link_speed     -> link/max_speed
  /sys/.../0000:00:1c.0/current_link_speed -> link/speed

Rajat's current patch puts the AER stats here at the top level:

  /sys/.../0000:00:1c.0/aer_stats/fatal_bit4_DLP

But maybe we could push them down like this:

  /sys/.../0000:00:1c.0/errors/aer/stats/unc_04_dlp
  /sys/.../0000:00:1c.0/errors/aer/stats/unc_26_poison_tlb_blocked
  /sys/.../0000:00:1c.0/errors/aer/stats/cor_00_rx_err
  /sys/.../0000:00:1c.0/errors/aer/stats/cor_15_hdr_log_overflow

There are some AER-related things we don't have at all today that
could go here:

  /sys/.../0000:00:1c.0/errors/aer/ecrc_gen
  /sys/.../0000:00:1c.0/errors/aer/ecrc_check
  /sys/.../0000:00:1c.0/errors/aer/unc_err_status
  /sys/.../0000:00:1c.0/errors/aer/unc_err_mask
  /sys/.../0000:00:1c.0/errors/aer/unc_err_sev

And we might someday want DPC knobs like this:

  /sys/.../0000:00:1c.0/errors/dpc/status
  /sys/.../0000:00:1c.0/errors/dpc/error_source

Any thoughts?

Bjorn

[1] https://lore.kernel.org/r/20190529104942.74991-1-mika.westerberg@linux.intel.com
[2] https://lore.kernel.org/r/d8574605f8e70f41ce1e88ccfb56b63c8f85e4df.1571638827.git.eswara.kota@linux.intel.com
[3] https://lore.kernel.org/r/20191030221436.GA261632@google.com/
[4] https://lore.kernel.org/r/20190827222145.32642-2-rajatja@google.com
[5] https://lore.kernel.org/r/b1c83f8a-9bf6-eac5-82d0-cf5b90128fbf@gmail.com
