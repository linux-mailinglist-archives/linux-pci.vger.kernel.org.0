Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32AA49C839
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 12:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbiAZLDI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 06:03:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:23299 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233170AbiAZLDI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jan 2022 06:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643194988; x=1674730988;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Q3gBcQGz/pjxvxeA6YutlHYOEjH1VZ/sW0EYV1FVls=;
  b=XeGkmbtDKP3G1PdfHmBXm2537aF6sXuxHc2Yujz2OLT6ZahlcVyqmq5Q
   wV1UVlxvK+PcFh3gi7R8wdXWlSa4CyYmCfI5kZk2arW3PSyZ7UxI4hb+X
   rkqxb9ynK6xVN8AnllMJoBnkrX9Zw2D067EAcViCr7RxRQ5AmQVcX7U25
   JuKxbO2ky8gRJ020Ye/RBFGZYl3Ts5ipVfzXR1MMr4duQwHp8vadHKunz
   9bWbohBudL5tzOFNgexNygIz73yTXjAf/9/al6cuZ3vQdjN5X91EH3T4g
   HXLCn0eBeUYhW1pxbcUNyu+Dcg1YCJsv52Agzn1wRxSGiYBwSCn1iP4A1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246305773"
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="246305773"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 03:03:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,317,1635231600"; 
   d="scan'208";a="563378278"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 03:03:03 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 26 Jan 2022 13:03:00 +0200
Date:   Wed, 26 Jan 2022 13:03:00 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/AER: Disable AER when link is in L2/L3 ready, L2
 and L3 state
Message-ID: <YfEqZMUS9jyiErmF@lahna>
References: <20220126071853.1940111-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126071853.1940111-1-kai.heng.feng@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Wed, Jan 26, 2022 at 03:18:51PM +0800, Kai-Heng Feng wrote:
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

Is this really because of the above commit of due the fact that AER
"service" never implemented the PM hooks in the first place ;-)
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
> Since PCIe spec "5.2 Link State Power Management" states that TLP and DLLP
> transmission is disabled for a Link in L2/L3 Ready (D3hot), L2 (D3cold with aux
> power) and L3 (D3cold), so disable AER to avoid the noises from turning power
> rails on/off.

I think more accurate here is to say when the topology behind the root
port enters low power states. Reason here is that you can't really tell
from the OS standpoint whether the link went into L1 or L2/3 before the
ACPI power resource is turned off.

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209149
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
> Fixes: 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Thanks for fixing this!

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
