Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3D949DB1A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jan 2022 08:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbiA0HBf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 02:01:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:37559 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237030AbiA0HBe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 02:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643266894; x=1674802894;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=PLFjvjJZ1+L8VTRJtrYhTLsi/UU8pUGMt6QmxvWQWRE=;
  b=L5qQayAs3RsXg8aVv6HSCH9qfKwLcvQezquWlK3qex5LKeVZ0vcj2Ev1
   PDsq4vjyD9YKSm4iIoApe8oe81GS7WL2LrmO0dNxR1NSQU4AwuNh+S2hr
   71FViCZfypO6UUVOvRo2yZ2mhj37H3ERvKPt34QH6O6JOOPKmwcqrOUpJ
   qFyKtiqcn7i4fAPHOQt8ldFu5GGLDuHzmfCpPvBVTQZ2gNYaSXetPe+4U
   /qvBPsB3rNpOhIx0bgR8X2Qz7ZyccyQXKcIMNa9TeU3RWHraTs+dYfjpH
   xLIJ5yZbEjS8AiZMYvPpaKXA8EJE52dAyXIO/5QAkXBKozSCeCJWi09Z7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="244368521"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="244368521"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 23:01:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="480181330"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.18]) ([10.254.214.18])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 23:01:30 -0800
Message-ID: <0259955f-8bbb-1778-f234-398f1356db8b@linux.intel.com>
Date:   Thu, 27 Jan 2022 15:01:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, mika.westerberg@linux.intel.com,
        koba.ko@canonical.com, Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Joerg Roedel <jroedel@suse.de>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, bhelgaas@google.com
References: <20220127025418.1989642-1-kai.heng.feng@canonical.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 1/2] PCI/AER: Disable AER service when link is in L2/L3
 ready, L2 and L3 state
In-Reply-To: <20220127025418.1989642-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022/1/27 10:54, Kai-Heng Feng wrote:
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
> Bugzilla:https://bugzilla.kernel.org/show_bug.cgi?id=209149
> Bugzilla:https://bugzilla.kernel.org/show_bug.cgi?id=215453
> Fixes: 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint")

I don't know what this fix has to do with the commit 50310600ebda.
Commit 50310600ebda only makes sure that PCI ACS is enabled whenever
Intel IOMMU is on. Before this commit, PCI ACS could also be enabled
and result in the same problem. Or anything I missed?

Best regards,
baolu
