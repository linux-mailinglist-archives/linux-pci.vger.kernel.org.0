Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFC230D4A8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 09:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhBCIGz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 03:06:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:50097 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232433AbhBCIGy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 03:06:54 -0500
IronPort-SDR: 0SMHToqfLyMlkAwjsM10JRHnfkp64H1i+wb3j6oofTcwGfxOS+dBc2iU8fpMKNSkcSZeSijVhD
 HqtV5zRmyzqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="245079974"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="245079974"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 00:05:25 -0800
IronPort-SDR: 9A720OnrUfEV+anxHhtqm10DSp8wmVjx7uYFX9jMxPNWfTI8taECRSPJnuBCUhu2UZ2daKhvUN
 YD8IaYrM64sg==
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="356645477"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 00:05:21 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 03 Feb 2021 10:05:18 +0200
Date:   Wed, 3 Feb 2021 10:05:18 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mingchuang Qiao <mingchuang.qiao@mediatek.com>
Cc:     bhelgaas@google.com, matthias.bgg@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, haijun.liu@mediatek.com,
        lambert.wang@mediatek.com, kerun.zhu@mediatek.com,
        alex.williamson@redhat.com, rjw@rjwysocki.net,
        utkarsh.h.patel@intel.com
Subject: Re: [v3] PCI: Avoid unsync of LTR mechanism configuration
Message-ID: <20210203080518.GP2542@lahna.fi.intel.com>
References: <20210129071137.8743-1-mingchuang.qiao@mediatek.com>
 <20210201113217.GL2542@lahna.fi.intel.com>
 <1612318441.5980.142.camel@mcddlt001>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612318441.5980.142.camel@mcddlt001>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 03, 2021 at 10:14:01AM +0800, Mingchuang Qiao wrote:
> Hi,
> 
> On Mon, 2021-02-01 at 13:32 +0200, Mika Westerberg wrote:
> > Hi,
> > 
> > On Fri, Jan 29, 2021 at 03:11:37PM +0800, mingchuang.qiao@mediatek.com wrote:
> > > From: Mingchuang Qiao <mingchuang.qiao@mediatek.com>
> > > 
> > > In bus scan flow, the "LTR Mechanism Enable" bit of DEVCTL2 register is
> > > configured in pci_configure_ltr(). If device and bridge both support LTR
> > > mechanism, the "LTR Mechanism Enable" bit of device and bridge will be
> > > enabled in DEVCTL2 register. And pci_dev->ltr_path will be set as 1.
> > > 
> > > If PCIe link goes down when device resets, the "LTR Mechanism Enable" bit
> > > of bridge will change to 0 according to PCIe r5.0, sec 7.5.3.16. However,
> > > the pci_dev->ltr_path value of bridge is still 1.
> > > 
> > > For following conditions, check and re-configure "LTR Mechanism Enable" bit
> > > of bridge to make "LTR Mechanism Enable" bit mtach ltr_path value.
> > 
> > Typo mtach -> match.
> > 
> > >    -before configuring device's LTR for hot-remove/hot-add
> > >    -before restoring device's DEVCTL2 register when restore device state
> > > 
> > > Signed-off-by: Mingchuang Qiao <mingchuang.qiao@mediatek.com>
> > > ---
> > > changes of v2
> > >  -modify patch description
> > >  -reconfigure bridge's LTR before restoring device DEVCTL2 register
> > > changes of v3
> > >  -call pci_reconfigure_bridge_ltr() in probe.c
> > 
> > Hmm, which part of this patch takes care of the reset path? It is not
> > entirely clear to me at least.
> > 
> 
> When device resets and link goes down, there seems to have two methods
> to recover for software. 
>    -One is that trigger device removal and rescan.
>    -The other is that restore device with pci_restore_state() after link
> comes back up.
> For above both scenarios, we need check and reconfigure "LTR Mechanism
> Enable" bit of bridge. It's also this patch intends to do.
>    -For the rescan scenario, it's done in pci_configure_ltr().
>    -For the restore scenario, it's done in pci_restore_pcie_state().

Okay, thanks for the clarification!
