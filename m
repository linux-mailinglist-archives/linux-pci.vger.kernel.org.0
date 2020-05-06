Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7941C6838
	for <lists+linux-pci@lfdr.de>; Wed,  6 May 2020 08:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgEFGOn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 May 2020 02:14:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:13733 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgEFGOm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 May 2020 02:14:42 -0400
IronPort-SDR: Aea8bJ0TPKSGcD2+YdR056vVwmezCMYnZNc80YCGOkgY80P0/ClkoH5fuIy38WYW8/isyxkgmZ
 WLdX2Fwf4M4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 23:14:42 -0700
IronPort-SDR: 8SU0ZqGeDxAqRO3wxKhezSMu6O2lsRivPI+hZNxm7YSA4YXKFMebS7DjQxzKlx6yRlYm9rM62J
 4aPiWNDugCFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,358,1583222400"; 
   d="scan'208";a="369691803"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 05 May 2020 23:14:39 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 06 May 2020 09:14:38 +0300
Date:   Wed, 6 May 2020 09:14:38 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, Heiner Kallweit <hkallweit1@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] PCI/ASPM: Enable ASPM for bridge-to-bridge link
Message-ID: <20200506061438.GR487496@lahna.fi.intel.com>
References: <20200505122801.12903-1-kai.heng.feng@canonical.com>
 <20200505173423.26968-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505173423.26968-1-kai.heng.feng@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 06, 2020 at 01:34:21AM +0800, Kai-Heng Feng wrote:
> The TI PCIe-to-PCI bridge prevents the Intel SoC from entering power
> state deeper than PC3 due to disabled ASPM, consumes lots of unnecessary
> power. On Windows ASPM L1 is enabled on the device and its upstream
> bridge, so it can make the Intel SoC reach PC8 or PC10 to save lots of
> power.
> 
> In short, ASPM always gets disabled on bridge-to-bridge link.

Excelent finding :) I've heard several reports complaining that we can't
enter PC10 when TBT is enabled and I guess this explains it.

> The special case was part of first ASPM introduction patch, commit
> 7d715a6c1ae5 ("PCI: add PCI Express ASPM support"). However, it didn't
> explain why ASPM needs to be disabled in special bridge-to-bridge case.
> 
> Let's remove the the special case, as PCIe spec already envisioned ASPM
> on bridge-to-bridge link.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207571
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
