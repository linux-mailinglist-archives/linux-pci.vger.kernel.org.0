Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6A549DAA5
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jan 2022 07:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiA0Gaf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 01:30:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:35640 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233098AbiA0Gae (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 01:30:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643265034; x=1674801034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5xkXNqIJZXAQJoOj8MLSU7e7o3znFMZWmFhFcf1BPvU=;
  b=k+9Y247g7eJ2smQRmXUKBik+5VXK+bRPGbYepRLUFOCyHCn81og3a+8U
   fZ7KAbKTCcCnBV2DgKs1w8JCUH36nlomOf0Ht9rFSWRevPAWQkG2KHv54
   rLJXSR3ZKd4hbzB4r5CGPiaeve7Gc5bcbPaR5bH7CChPjjrMoxOIgNihT
   BHgbdeL//uFV0jvg6fF8rR1jsvyaFY1v8nTNzA7kDyajmm9tgdzr3Ak+2
   1JtYRGm7oYtVs5qg2YPz7/g2iNPuZqisekrcNeNKPHeCiqbmiLAoxnI75
   hYe42QSkyMaKgnhdLP1jjP9T8kOvSfBiq+Afd9IcRRO3IIhXxL3Xs7mNj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="244363240"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="244363240"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 22:30:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="521096220"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 22:30:24 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 27 Jan 2022 08:30:21 +0200
Date:   Thu, 27 Jan 2022 08:30:21 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI/AER: Disable AER service when link is in
 L2/L3 ready, L2 and L3 state
Message-ID: <YfI7/X15bl+Ac19A@lahna>
References: <20220127025418.1989642-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127025418.1989642-1-kai.heng.feng@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 27, 2022 at 10:54:17AM +0800, Kai-Heng Feng wrote:
> Commit 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in
> hint") enables ACS, and some platforms lose its NVMe after resume from
> S3:
> [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
> [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
> [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
> [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
> [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
> [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
> [   50.947843] nvme nvme0: frozen state error detected, reset controller
> 
> It happens right after ACS gets enabled during resume.
> 
> There's another case, when Thunderbolt reaches D3cold:
> [   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> [   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> [   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> [   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> [   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> [   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> [   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> [   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed
> 
> So disable AER service to avoid the noises from turning power rails
> on/off when the device is in low power states (D3hot and D3cold), as
> PCIe spec "5.2 Link State Power Management" states that TLP and DLLP
> transmission is disabled for a Link in L2/L3 Ready (D3hot), L2 (D3cold
> with aux power) and L3 (D3cold).
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209149
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
> Fixes: 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
