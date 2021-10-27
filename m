Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940AA43C23A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Oct 2021 07:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239323AbhJ0FcS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Oct 2021 01:32:18 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:44516 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238185AbhJ0FcS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Oct 2021 01:32:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xuesong.chen@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0Utr8L.._1635312590;
Received: from 30.225.212.53(mailfrom:xuesong.chen@linux.alibaba.com fp:SMTPD_---0Utr8L.._1635312590)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Oct 2021 13:29:51 +0800
Message-ID: <b392f501-e9fb-2c75-42b6-d94e8b8e6ace@linux.alibaba.com>
Date:   Wed, 27 Oct 2021 13:29:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH v3 2/2] ACPI: APEI: Filter the PCI MCFG address with an
 arch-agnostic method
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        xuesong.chen@linux.alibaba.com
References: <20211026204722.GA158130@bhelgaas>
From:   Xuesong Chen <xuesong.chen@linux.alibaba.com>
In-Reply-To: <20211026204722.GA158130@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 27/10/2021 04:47, Bjorn Helgaas wrote:
> On Tue, Oct 26, 2021 at 05:16:47PM +0800, Xuesong Chen wrote:
>> On 26/10/2021 07:37, Bjorn Helgaas wrote:
> 
>>> My point was that when ECAM is implemented correctly, a CPU does a
>>> single MMIO load to do a PCI config read and a single MMIO store to do
>>> a PCI config write.  In that case there no need for any locking, so
>>> there's no need for APEI to reserve those resources.
>>
>> Ah, got it. That means the PCI ECAM has a implicit mutual exclusion with EINJ
>> if the hardware implemention is correct, so we can remove the MCFG from
>> the APEI's safely.
> 
> Well, not quite.  ECAM doesn't *need* mutual exclusion.  Single loads
> and stores are atomic by definition.
> 

OK, because ECAM config access has intrinsic atomic primitive, so no need to
reserve those ECAM config space resources for APEI, that's why commit d91525eb8ee6 
("ACPI, EINJ: Enhance error injection tolerance level") fix make sense... 

>>> I think apei_resources_request() should continue to reserve MCFG areas
>>> on tegra194 and xgene, but it does not need to reserve them on other
>>> ARM64 platforms.
>>
>> As a summary: we need to reserve the MCFG areas on those platforms with a
>> quirk ECAM implementation since there's no lockless method to access the
>> configuration space, on other platforms we don't need to reserve the MCFG
>> resources (so can remove it safely).
>>
>> So we need to add another patch to handle the case of tegra194 and xgene...
>> I will try to figure it out. 
> 
> I looked through these again and found another problem case (thunder).
> Here are my notes from my research.
> 
> Normal ECAM users require no device-specific support.  The platform
> supplies an MCFG table, the generic code works, no mutual exclusion is
> required, and APEI doesn't need to reserve the MCFG areas.
> 
> The problem cases are platforms that supply an MCFG table but require
> some device-specific workarounds.  We can identify these because they
> have quirks in pci-mcfg.c.  Here are the existing quirks and the
> pci_ecam_ops structs they supply:
> 
>   AL_ECAM             al_pcie_ops                 # OK
>   QCOM_ECAM32         pci_32b_ops                 # OK
>   HISI_QUAD_DOM       hisi_pcie_ops               # OK
>   THUNDER_PEM_QUIRK   thunder_pem_ecam_ops        # problem
>   THUNDER_PEM_QUIRK   thunder_pem_ecam_ops        # problem
>   THUNDER_ECAM_QUIRK  pci_thunder_ecam_ops        # OK
>   tegra               tegra194_pcie_ops           # problem
>   XGENE_V1_ECAM_MCFG  xgene_v1_pcie_ecam_ops      # problem
>   XGENE_V2_ECAM_MCFG  xgene_v2_pcie_ecam_ops      # problem
>   ALTRA_ECAM_QUIRK    pci_32b_read_ops            # OK
> 
> The ones marked "OK" have .map_bus(), .read(), and .write() methods
> that need no mutual exclusion because they boil down to just a single
> MMIO load or store.  These are fine and there shouldn't be a problem
> if an EINJ action accesses the ECAM space.
> 
> The others do require mutual exclusion:
> 
>   - thunder_pem_ecam_ops: thunder_pem_config_read() calls
>     thunder_pem_bridge_read(), which does a writeq() to PEM_CFG_RD
>     followed by a readq().  The writeq() and readq() must be atomic to
>     avoid corruption.
> 
>   - tegra194_pcie_ops: tegra194_map_bus() programs the ATU.  This and
>     the subsequent ECAM read/write must be atomic.
> 
>   - xgene_v1_pcie_ecam_ops and xgene_v2_pcie_ecam_ops:
>     xgene_pcie_map_bus() sets the RTID.  This and the subsequent ECAM
>     read/write must be atomic.
> 
> I had to look at all these ops individually to find them, so I don't
> see an easy way to identify these problem cases at run-time.
> 
> I personally would not have an issue with having APEI try to reserve
> the MCFG regions for any platform that has an MCFG quirk.  That would
> prevent the al, qcom, hisi, thunder-ecam, and altra drivers from using
> EINJ even though it would probably be safe for them.  But we already
> know those platforms are not really ACPI-compliant, so ...

OK, understood. Since those platforms are not really ACPI-compliant, so
we can unify all the quirks together. Let me send an inital solution about
this for your review and see if there's room for further improvement...

Thanks,
Xuesong

> 
> Bjorn
> 
