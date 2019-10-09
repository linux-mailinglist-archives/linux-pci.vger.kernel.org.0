Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C60BCD063B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2019 06:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbfJIEFi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Oct 2019 00:05:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:4247 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfJIEFi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Oct 2019 00:05:38 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 21:05:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; 
   d="scan'208";a="206790574"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 08 Oct 2019 21:05:35 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 09 Oct 2019 07:05:35 +0300
Date:   Wed, 9 Oct 2019 07:05:34 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        AceLan Kao <acelan@gmail.com>
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 205119] New: It takes
 long time to wake up from s2idle on Dell XPS 7390 2-in-1]
Message-ID: <20191009040534.GL2819@lahna.fi.intel.com>
References: <20191008164232.GA173643@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008164232.GA173643@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Most likely not a regression as Ice Lake support was just added in
v5.4-rc1.

@AceLan, I've seen similar issue before and that was fixed by a BIOS/FW
upgrade. Can you check if there is newer BIOS/FW for that system and see
if it helps?

Let's continue debugging on bugzilla.

On Tue, Oct 08, 2019 at 11:42:32AM -0500, Bjorn Helgaas wrote:
> AceLan, do you know if this is a regression and if so, when it was
> introduced?
> 
> ----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----
> 
> Date: Tue, 08 Oct 2019 02:56:27 +0000
> From: bugzilla-daemon@bugzilla.kernel.org
> To: bjorn@helgaas.com
> Subject: [Bug 205119] New: It takes long time to wake up from s2idle on Dell
> 	XPS 7390 2-in-1
> Message-ID: <bug-205119-41252@https.bugzilla.kernel.org/>
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=205119
> 
>             Bug ID: 205119
>            Summary: It takes long time to wake up from s2idle on Dell XPS
>                     7390 2-in-1
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 5.4-rc2
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: acelan@gmail.com
>         Regression: No
> 
> Created attachment 285395
>   --> https://bugzilla.kernel.org/attachment.cgi?id=285395&action=edit
> dmesg log
> 
> 1. Enter s2idle at 28.39s
> 2. Press power button at 246.10s
> 3. The machine stuck until 412.30s and spit out thunderbolt warning messages
> 4. thunderbolt port keeps working after s2idle, plug-in Dell WD19TB
> dock(472.45s), and the "boltctl list" shows the dock info correctly.
> 
> BTW, I also found that there are 2 tbt ports on the machine, and if I plug in
> one TBT dock, and the wakeup time could be reduced by 80 seconds. And if I plug
> in 2 docks in both TBT ports, the machine wakes up from s2idle quick enough as
> the normal system.
> 
> I believe the 2 lines are related.
> [  330.388604] thunderbolt 0000:00:0d.3: failed to send driver ready to ICM
> [  412.308083] thunderbolt 0000:00:0d.2: failed to send driver ready to ICM
> 
> -- 
> You are receiving this mail because:
> You are watching the assignee of the bug.
> 
> ----- End forwarded message -----
