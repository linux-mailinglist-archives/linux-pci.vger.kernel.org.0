Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B822B15E3
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 07:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgKMGkE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 01:40:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:9609 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgKMGkE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Nov 2020 01:40:04 -0500
IronPort-SDR: NsOVMQZzdG+0aV2F16RQKU92+yy1AKjkU0Qkvkfw1ws0qFmhNZm9HVCvnZkwmPAllURS82tPEA
 kMux22oI0jpA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="169651995"
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="169651995"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 22:40:01 -0800
IronPort-SDR: gVja1r05S/zpD++fjaITdG3QWID/wvTPv9Gxkq7552CWqu3BJj98LWRq7V+xBjJv5v3B5DWVxF
 Bf2r7H8p9KYQ==
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="357401369"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 22:39:57 -0800
Received: by lahna (sSMTP sendmail emulation); Fri, 13 Nov 2020 08:37:45 +0200
Date:   Fri, 13 Nov 2020 08:37:45 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Lukas Wunner <lukas@wunner.de>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Utkarsh Patel <utkarsh.h.patel@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Do not generate wakeup event when runtime
 resuming bus
Message-ID: <20201113063745.GH2495@lahna.fi.intel.com>
References: <20201029092453.69869-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029092453.69869-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Oct 29, 2020 at 12:24:53PM +0300, Mika Westerberg wrote:
> When a PCI bridge is runtime resumed from D3cold the underlying bus is
> walked and the attached devices are runtime resumed as well. However, in
> addition to that we also generate a wakeup event for these devices even
> though this actually is not a real wakeup event coming from the
> hardware.
> 
> Normally this does not cause problems but when combined with
> /sys/power/wakeup_count like using the steps below:
> 
>   # count=$(cat /sys/power/wakeup_count)
>   # echo $count > /sys/power/wakeup_count
>   # echo mem > /sys/power/state
> 
> The system suspend cycle might get aborted at this point if a PCI bridge
> that was runtime suspended (D3cold) was runtime resumed for any reason.
> The runtime resume calls pci_wakeup_bus() and that generates wakeup
> event increasing wakeup_count.
> 
> Since this is not a real wakeup event we can prevent the above from
> happening by removing the call to pci_wakeup_event() in
> pci_wakeup_bus(). While there rename pci_wakeup_bus() to
> pci_resume_bus() to better reflect what it does.

Any comments on this?

Thanks!
