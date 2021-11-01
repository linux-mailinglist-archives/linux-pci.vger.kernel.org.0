Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3448441218
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 03:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhKACVL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 31 Oct 2021 22:21:11 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:51190 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230233AbhKACVK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 31 Oct 2021 22:21:10 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xuesong.chen@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0UuPi-hG_1635733115;
Received: from 30.225.212.104(mailfrom:xuesong.chen@linux.alibaba.com fp:SMTPD_---0UuPi-hG_1635733115)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Nov 2021 10:18:36 +0800
Message-ID: <e387413f-dbe8-e0f1-257b-141362d74e3a@linux.alibaba.com>
Date:   Mon, 1 Nov 2021 10:18:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH v4 0/4] PCI MCFG consolidation and APEI resource filtering
To:     helgaas@kernel.org
Cc:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <YW5OTMz+x8zrsqkF@Dennis-MBP.local>
 <20211027081035.53370-1-xuesong.chen@linux.alibaba.com>
From:   Xuesong Chen <xuesong.chen@linux.alibaba.com>
In-Reply-To: <20211027081035.53370-1-xuesong.chen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

How about the status of this series, it's really bad, bad and still bad... to wait long
time for the final judgement, especially you take extremely serious to rework it round
by round, finaly you receive nothing. Everyone's work should be repected!

Technically, I don't think it's very hard to say yes or no (what's your concerns) for
the patch set. If you give your objections and convince me, then I will drop it, that's
nothing. Hopefully our maintainers can take the responsibility that they should take,
I totally understand that our maintainers are very busy and will face tens of thousands
of mails. But, YOU ARE THE MAINTAINER! 

Responsiblity!Responsiblity!! Still TMD f*cking FucResponsiblity!!!

On 27/10/2021 16:10, Xuesong Chen wrote:
> The issue of commit d91525eb8ee6 ("ACPI, EINJ: Enhance error injection tolerance
> level") on x86 is also happened on our own ARM64 platform. We sent a patch[1]
> trying to fix this issue in an arch-specific way as x86 does at first, but
> according to the suggestion from Lorenzo Pieralisi and Catalin Marinas, we can
> consolidate the PCI MCFG part then fix it in a more common way, that's why this
> patch series comes.
> 
> [1] https://marc.info/?l=linux-arm-kernel&m=163108478627166&w=2
> 
> ---
> Change from v3 to v4:
>   - Add a new patch (patch #3) to address the quirk ECAM access issue. Because
>     the normal ECAM config space can be accessed in a lockless way, so we don't
>     need the mutual exclusion with the EINJ action. But those quirks maybe break
>     this rule and corrupt the configuration access, reserve its MCFG address
>     regions in this case to avoid that happens. 
>   
>   - Add another patch (patch #4) to log the PCI MCFG entry parse message per
>     the suggestion from Bjorn Helgaas. The output on ARM64 as:
>     ACPI: MCFG entry for domain 0000 [bus 00-0f] at [mem 0x50000000-0x50ffffff] (base 0x50000000)
>   
>   - Commit message updated with more details of patch #2
> 
> Change from v2 to v3:
>   - Address the comments of Lorenzo Pieralisi about the CONFIG_PCI
>     dependence issue in APEI module (patch #2)
> 
> Change from v1 to v2:
>   - Fix the "undefined reference to `pci_mmcfg_list'" build error in case
>     of PCI_CONFIG=n, reported by the kernel test robot
> 
> Xuesong Chen (4):
>   PCI: MCFG: Consolidate the separate PCI MCFG table entry list
>   ACPI: APEI: Filter the PCI MCFG address with an arch-agnostic method
>   ACPI: APEI: Reserve the MCFG address for quirk ECAM implementation
>   PCI: MCFG: Add the MCFG entry parse log message
> 
>  arch/x86/include/asm/pci_x86.h | 17 +----------
>  arch/x86/pci/mmconfig-shared.c | 30 -------------------
>  drivers/acpi/apei/apei-base.c  | 68 ++++++++++++++++++++++++++++++++----------
>  drivers/acpi/pci_mcfg.c        | 46 +++++++++++++++-------------
>  drivers/pci/pci.c              |  2 ++
>  drivers/pci/quirks.c           |  2 ++
>  include/linux/pci.h            | 18 +++++++++++
>  7 files changed, 101 insertions(+), 82 deletions(-)
> 
