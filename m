Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF363DEB02
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 13:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfJULd7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 07:33:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:58087 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfJULd7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 07:33:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 04:33:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,323,1566889200"; 
   d="scan'208";a="209427634"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 21 Oct 2019 04:33:54 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 21 Oct 2019 14:33:53 +0300
Date:   Mon, 21 Oct 2019 14:33:53 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Daniel Drake <drake@endlessm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] PCI: increase D3 delay for AMD Ryzen5/7 XHCI controllers
Message-ID: <20191021113353.GX2819@lahna.fi.intel.com>
References: <20191014061355.29072-1-drake@endlessm.com>
 <20191014154322.GA190693@google.com>
 <CAD8Lp45hmYhrj9v-=7NKrG2YHmxZKFExDsHCL67hap+Y2iM-uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8Lp45hmYhrj9v-=7NKrG2YHmxZKFExDsHCL67hap+Y2iM-uw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

Sorry for the delay. I was on vacation last week.

On Tue, Oct 15, 2019 at 01:31:32PM +0800, Daniel Drake wrote:
> On Mon, Oct 14, 2019 at 11:43 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > Can you tell if this is because the Ryzen7 XHCI controller is out of
> > spec, or is the Linux PCI core missing some delay?  If the latter,
> > fixing the core might fix other devices as well.
> >
> > Mika has this patch:
> > https://lore.kernel.org/r/20190821124519.71594-1-mika.westerberg@linux.intel.com
> > for similar issues, but I think that patch fixes D3cold->D0
> > transitions, and your patch appears to be concerned with D3hot->D0
> > transitions.
> 
> It's actually coming out of D3cold here, however what happens right
> before this is that __pci_start_power_transition() calls
> pci_platform_power_transition(D0) to leave D3cold state, then
> pci_update_current_state() reads PMCSR and updates dev->current_state
> to D3hot.
> 
> The 20ms delay for these XHCI controllers is needed precisely at this
> point - after writing PMCSR to move to D0, and before reading it back
> to check the result.
> I tried moving the delay immediately before writing PMCSR, but that
> doesn't work. Based on that, it seems like it's just a little out of
> spec.
> 
> With Mika's patch, pcie_wait_downstream_accessible() is called for
> these devices after the state transition has already failed. It also
> doesn't do any delaying at that point because pci_pcie_type(pdev) ==
> 0.

Just to be sure, did you try the patch or just looked at it? Because
what the patch does is that it does the delay when the downstream/root
port is resumed, not the xHCI itself.
