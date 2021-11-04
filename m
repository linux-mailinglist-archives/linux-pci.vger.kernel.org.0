Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C214455F1
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 16:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhKDPDg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 11:03:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229920AbhKDPDc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Nov 2021 11:03:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67CD661108;
        Thu,  4 Nov 2021 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636038054;
        bh=uL12ryXgNUH1YHpwEqn23MZF95Lc2Z8MYbcCpnXHCLE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jfAThr0n/flvXkmtk55BjcSgst/6t3kaxrFp73k6DPxuoQcRUW/anmuR70kWJJeun
         jWZeT5gb3zrvW1Ts3ZCD7sM/XL6mysoO0A7CyngXfgPYa7HijIHCy4TTZvRhqXh/u4
         tga3yjeTosv/uHNrnfPZW13nPhRyQvfujTO8NaR1Rg6svUPLzp+MqEwgdClvaIE0Mc
         fON2XttXPlp6eZend025rY676uDu2Dm6p8wBr0K0CT33YyFjomWyZrQOn8bR0JYIoa
         FUpxslFzOEUc0KG9kElZis3xUSLwYnWOwFLcAxguULKlbf8hLe/axV80Pr15JbtDJy
         hCMUbUhNauwEg==
Date:   Thu, 4 Nov 2021 10:00:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xuesong Chen <xuesong.chen@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, ying.huang@intel.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] PCI MCFG consolidation and APEI resource filtering
Message-ID: <20211104150053.GA774800@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104105715.47396-1-xuesong.chen@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 04, 2021 at 06:57:15PM +0800, Xuesong Chen wrote:
> The issue of commit d91525eb8ee6 ("ACPI, EINJ: Enhance error injection tolerance
> level") on x86 is also happened on our own ARM64 platform. We sent a patch[1]
> trying to fix this issue in an arch-specific way as x86 does at first, but
> according to the suggestion from Lorenzo Pieralisi and Catalin Marinas, we can
> consolidate the PCI MCFG part then fix it in a more common way, that's why this
> patch series comes.
> 
> [1] https://marc.info/?l=linux-arm-kernel&m=163108478627166&w=2

Thanks.  I see this and will look at it after getting the v5.16
changes merged.

> ---
> Change from v4 to v5:
>   - Fix the warning: no previous prototype for 'remove_quirk_mcfg_res' warning
>     reported by the kernel test robot.
> 
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
> -- 
> 2.9.5
> 
