Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0C49F190
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 03:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiA1C5B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 21:57:01 -0500
Received: from mga17.intel.com ([192.55.52.151]:38587 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbiA1C5B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 21:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643338621; x=1674874621;
  h=cc:subject:to:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=lQzpVBgtczAn5sAewXENYJpIAUiWWZKcbyftWJFiTnk=;
  b=ehMl2PURoXyAUIkUlgHTDB9BfqLsE4sspvkPQVACKG3fMoT1qSWUKllw
   2CjWsx9+Rpb/sGPje+6nsSQOjezlC7QUoVik6ZsK9Nva+NxDPFoB8Liyj
   ZFtJsuBfCIbmv8OZ1AaLXYS+MwUKNBXxfxvA0fcQ3PaWbPYxMbv8mX3hz
   qf5Alo7q3jUg415JJtnPD6g6weBww45mXJwG/kGFXNYETs2BoJGiukWrJ
   Tv3GAK5BrdXHbwfJjZcHkGNAceX3ztWz1KdFa7dnTD+fw1zS59zBeNvi9
   UNB+x8HPkTCXo3Ddd5F5ByVfqnEgBm2FkLqcpt+UdA8zETFZedAREtipE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="227699932"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="227699932"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 18:54:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="535953637"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2022 18:54:10 -0800
Cc:     baolu.lu@linux.intel.com, bhelgaas@google.com,
        mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Lalithambika Krishnakumar <lalithambika.krishnakumar@intel.com>,
        Joerg Roedel <jroedel@suse.de>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI/AER: Disable AER service when link is in L2/L3
 ready, L2 and L3 state
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
References: <20220127025418.1989642-1-kai.heng.feng@canonical.com>
 <0259955f-8bbb-1778-f234-398f1356db8b@linux.intel.com>
 <CAAd53p6+KPAJchh9Jx59Fkkj5FidSxsW0yHjLqooFjvu-Y9u7w@mail.gmail.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <11891652-40c6-f111-46b7-e96d1729815e@linux.intel.com>
Date:   Fri, 28 Jan 2022 10:53:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAAd53p6+KPAJchh9Jx59Fkkj5FidSxsW0yHjLqooFjvu-Y9u7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/27/22 7:14 PM, Kai-Heng Feng wrote:
> On Thu, Jan 27, 2022 at 3:01 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> On 2022/1/27 10:54, Kai-Heng Feng wrote:
>>> Commit 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in
>>> hint") enables ACS, and some platforms lose its NVMe after resume from
>>> S3:
>>> [   50.947816] pcieport 0000:00:1b.0: DPC: containment event, status:0x1f01 source:0x0000
>>> [   50.947817] pcieport 0000:00:1b.0: DPC: unmasked uncorrectable error detected
>>> [   50.947829] pcieport 0000:00:1b.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Receiver ID)
>>> [   50.947830] pcieport 0000:00:1b.0:   device [8086:06ac] error status/mask=00200000/00010000
>>> [   50.947831] pcieport 0000:00:1b.0:    [21] ACSViol                (First)
>>> [   50.947841] pcieport 0000:00:1b.0: AER: broadcast error_detected message
>>> [   50.947843] nvme nvme0: frozen state error detected, reset controller
>>>
>>> It happens right after ACS gets enabled during resume.
>>>
>>> There's another case, when Thunderbolt reaches D3cold:
>>> [   30.100211] pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
>>> [   30.100251] pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
>>> [   30.100256] pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
>>> [   30.100262] pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
>>> [   30.100267] pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
>>> [   30.100372] thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
>>> [   30.100401] xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
>>> [   30.100427] pcieport 0000:00:1d.0: AER: device recovery failed
>>>
>>> So disable AER service to avoid the noises from turning power rails
>>> on/off when the device is in low power states (D3hot and D3cold), as
>>> PCIe spec "5.2 Link State Power Management" states that TLP and DLLP
>>> transmission is disabled for a Link in L2/L3 Ready (D3hot), L2 (D3cold
>>> with aux power) and L3 (D3cold).
>>>
>>> Bugzilla:https://bugzilla.kernel.org/show_bug.cgi?id=209149
>>> Bugzilla:https://bugzilla.kernel.org/show_bug.cgi?id=215453
>>> Fixes: 50310600ebda ("iommu/vt-d: Enable PCI ACS for platform opt in hint")
>>
>> I don't know what this fix has to do with the commit 50310600ebda.
> 
> Commit 50310600ebda only exposed the underlying issue. Do you think
> "Fixes:" tag should change to other commits?
> 
>> Commit 50310600ebda only makes sure that PCI ACS is enabled whenever
>> Intel IOMMU is on. Before this commit, PCI ACS could also be enabled
>> and result in the same problem. Or anything I missed?
> 
> The system in question didn't enable ACS before commit 50310600ebda.

This commit exposed the issue on your configuration doesn't mean the
fix should be back ported as far as that commit. I believe if you add
intel-iommu=on in the kernel parameter, the issue still exists even you
revert commit 50310600ebda or checkout a tag before it.

Best regards,
baolu
