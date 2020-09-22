Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B626F273E0A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 11:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIVJFi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 05:05:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:61127 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgIVJFh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 05:05:37 -0400
IronPort-SDR: v2qZTfNqUKhPh7xjN3A77Hvk4QllSkHw35yM0K2yBL7aHACeGHNbTlj2QNdvvdB1XuSHiLnFT3
 qYJGO+Q5aR7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="140045727"
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="140045727"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 02:05:24 -0700
IronPort-SDR: Jsl9DCS/hPVmwthOsbR03+pZRME6c/YF2AEh4YLsSQYZT7RRa8R7CSwZuzgEnd4Y6+vanEsxf7
 9B+XSjpffGoA==
X-IronPort-AV: E=Sophos;i="5.77,290,1596524400"; 
   d="scan'208";a="485875870"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 02:05:20 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 22 Sep 2020 12:05:18 +0300
Date:   Tue, 22 Sep 2020 12:05:18 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: Re: [bugzilla-daemon@bugzilla.kernel.org: [Bug 209323] New: pcieport
 devices take longer than 1 second in resume]
Message-ID: <20200922090518.GR2495@lahna.fi.intel.com>
References: <20200921215846.GA2137712@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921215846.GA2137712@bjorn-Precision-5520>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Yes I think it is the same issue.

On Mon, Sep 21, 2020 at 04:58:46PM -0500, Bjorn Helgaas wrote:
> Is this related to https://lore.kernel.org/r/20200831093147.36775-1-mika.westerberg@linux.intel.com/ ?
> 
> ----- Forwarded message from bugzilla-daemon@bugzilla.kernel.org -----
> 
> Date: Fri, 18 Sep 2020 21:20:38 +0000
> From: bugzilla-daemon@bugzilla.kernel.org
> To: bjorn@helgaas.com
> Subject: [Bug 209323] New: pcieport devices take longer than 1 second in resume
> Message-ID: <bug-209323-41252@https.bugzilla.kernel.org/>
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=209323
> 
>             Bug ID: 209323
>            Summary: pcieport devices take longer than 1 second in resume
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 5.8.0
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: todd.e.brandt@linux.intel.com
>             Blocks: 178231
>         Regression: No
> 
> Created attachment 292541
>   --> https://bugzilla.kernel.org/attachment.cgi?id=292541&action=edit
> otcpl-dell-9380-cfl_freeze.html
> 
> pcieport devices are taking longer than 1 second across several machines. This
> bug is there to monitor which machines and kernel release this happens on.
> 
> 
> Referenced Bugs:
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=178231
> [Bug 178231] Meta-bug: Linux suspend-to-mem and freeze performance optimization
> -- 
> You are receiving this mail because:
> You are watching the assignee of the bug.
> 
> ----- End forwarded message -----
