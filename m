Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564B1445D76
	for <lists+linux-pci@lfdr.de>; Fri,  5 Nov 2021 02:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhKEBsv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 21:48:51 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:38825 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231186AbhKEBsv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Nov 2021 21:48:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xuesong.chen@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Uv4y7ad_1636076769;
Received: from 30.225.212.33(mailfrom:xuesong.chen@linux.alibaba.com fp:SMTPD_---0Uv4y7ad_1636076769)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 05 Nov 2021 09:46:09 +0800
Message-ID: <e1a6fa17-106d-6b0b-8974-5a96bb33086e@linux.alibaba.com>
Date:   Fri, 5 Nov 2021 09:46:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v5 0/4] PCI MCFG consolidation and APEI resource filtering
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, ying.huang@intel.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211104150053.GA774800@bhelgaas>
From:   Xuesong Chen <xuesong.chen@linux.alibaba.com>
In-Reply-To: <20211104150053.GA774800@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 04/11/2021 23:00, Bjorn Helgaas wrote:
> On Thu, Nov 04, 2021 at 06:57:15PM +0800, Xuesong Chen wrote:
>> The issue of commit d91525eb8ee6 ("ACPI, EINJ: Enhance error injection tolerance
>> level") on x86 is also happened on our own ARM64 platform. We sent a patch[1]
>> trying to fix this issue in an arch-specific way as x86 does at first, but
>> according to the suggestion from Lorenzo Pieralisi and Catalin Marinas, we can
>> consolidate the PCI MCFG part then fix it in a more common way, that's why this
>> patch series comes.
>>
>> [1] https://marc.info/?l=linux-arm-kernel&m=163108478627166&w=2
> 
> Thanks.  I see this and will look at it after getting the v5.16
> changes merged.

Ah, Bjorn, I also notice this series is in your patchwork now, hmmm, I don't know why
the previous iterations are not there either, seems something doesn't work as expected
in my side. Probably my fault for the unpeaceful interlude :-)

Thanks,
Xuesong

> 
>> ---
>> Change from v4 to v5:
>>   - Fix the warning: no previous prototype for 'remove_quirk_mcfg_res' warning
>>     reported by the kernel test robot.
>>
>> Change from v3 to v4:
>>   - Add a new patch (patch #3) to address the quirk ECAM access issue. Because
>>     the normal ECAM config space can be accessed in a lockless way, so we don't
>>     need the mutual exclusion with the EINJ action. But those quirks maybe break
>>     this rule and corrupt the configuration access, reserve its MCFG address
>>     regions in this case to avoid that happens.
>>
>>   - Add another patch (patch #4) to log the PCI MCFG entry parse message per
>>     the suggestion from Bjorn Helgaas. The output on ARM64 as:
>>     ACPI: MCFG entry for domain 0000 [bus 00-0f] at [mem 0x50000000-0x50ffffff] (base 0x50000000)
>>
>>   - Commit message updated with more details of patch #2
>>
>> Change from v2 to v3:
>>   - Address the comments of Lorenzo Pieralisi about the CONFIG_PCI
>>     dependence issue in APEI module (patch #2)
>>
>> Change from v1 to v2:
>>   - Fix the "undefined reference to `pci_mmcfg_list'" build error in case
>>     of PCI_CONFIG=n, reported by the kernel test robot
>>
>> Xuesong Chen (4):
>>   PCI: MCFG: Consolidate the separate PCI MCFG table entry list
>>   ACPI: APEI: Filter the PCI MCFG address with an arch-agnostic method
>>   ACPI: APEI: Reserve the MCFG address for quirk ECAM implementation
>>   PCI: MCFG: Add the MCFG entry parse log message
>>
>>  arch/x86/include/asm/pci_x86.h | 17 +----------
>>  arch/x86/pci/mmconfig-shared.c | 30 -------------------
>>  drivers/acpi/apei/apei-base.c  | 68 ++++++++++++++++++++++++++++++++----------
>>  drivers/acpi/pci_mcfg.c        | 46 +++++++++++++++-------------
>>  drivers/pci/pci.c              |  2 ++
>>  drivers/pci/quirks.c           |  2 ++
>>  include/linux/pci.h            | 18 +++++++++++
>>  7 files changed, 101 insertions(+), 82 deletions(-)
>>
>> -- 
>> 2.9.5
>>
