Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72479228099
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jul 2020 15:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGUNIx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 09:08:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:7211 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgGUNIw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jul 2020 09:08:52 -0400
IronPort-SDR: 7Puqgciov1Y2cQvXkpK7HqKoiWHRsA7ZXQe1PwdsF7rLr8kwgWPsOqUsdAD1i+kMNCKVjdWg36
 d2UCubrrC1xA==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="137610798"
X-IronPort-AV: E=Sophos;i="5.75,378,1589266800"; 
   d="scan'208";a="137610798"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 06:08:51 -0700
IronPort-SDR: FscKyFSJYpwm0edcPqe8S2lioAjregQkXbQ0CxU62nEOHXi0ZBMcv3DeLh85gLVtyKSo/Tichb
 A0h4lCsEzetA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,378,1589266800"; 
   d="scan'208";a="392343948"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 21 Jul 2020 06:08:47 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 21 Jul 2020 16:08:47 +0300
Date:   Tue, 21 Jul 2020 16:08:47 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Lyude Paul <lyude@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
        Karol Herbst <kherbst@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        Patrick Volkerding <volkerdi@gmail.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: nouveau regression with 5.7 caused by "PCI/PM: Assume ports
 without DLL Link Active train links in 100 ms"
Message-ID: <20200721130847.GK5180@lahna.fi.intel.com>
References: <20200716235440.GA675421@bjorn-Precision-5520>
 <ec6623032131fc3e656713b8ec644cdff89a8066.camel@redhat.com>
 <20200717195209.vmtyfmgweoo645lh@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717195209.vmtyfmgweoo645lh@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 17, 2020 at 09:52:09PM +0200, Lukas Wunner wrote:
> On Fri, Jul 17, 2020 at 03:04:10PM -0400, Lyude Paul wrote:
> > Isn't it possible to tell whether a PCI device is connected through
> > thunderbolt or not? We could probably get away with just defaulting
> > to 100ms for thunderbolt devices without DLL Link Active specified,
> > and then default to the old delay value for non-thunderbolt devices.
> 
> pci_is_thunderbolt_attached()

That only works with some devices. I think we should try to keep the
fact that some PCIe links may be tunneled over TBT/USB4 transparent to
the PCI core and try to treat them as "standard" PCIe links if possible
at all :)
