Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE87432CEA
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 06:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhJSEvd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 00:51:33 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:47921 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229649AbhJSEvc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Oct 2021 00:51:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xuesong.chen@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Usprolt_1634618956;
Received: from localhost(mailfrom:xuesong.chen@linux.alibaba.com fp:SMTPD_---0Usprolt_1634618956)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Oct 2021 12:49:17 +0800
Date:   Tue, 19 Oct 2021 12:49:16 +0800
From:   Xuesong Chen <xuesong.chen@linux.alibaba.com>
To:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xuesong.chen@linux.alibaba.com
Subject: [PATCH v3 0/2] PCI MCFG consolidation and APEI resource filterin
Message-ID: <YW5OTMz+x8zrsqkF@Dennis-MBP.local>
Reply-To: Xuesong Chen <xuesong.chen@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello All,

The idea of this patch set is very strainforward, it's somehow a refactor
of the original codes to share some ones that they should do. Based on that,
we can resolve the MCFG address access issue in APEI module on x86 in a 
command way instead of the current arch-dependent one, while this issue also
does happen on ARM64 platform.

The logic of the series is very clear(IMO it's even time-wasting to explain that):

Patch #1: Escalating the 'pci_mmcfg_list' and 'pci_mmcfg_region' to the
pci.[c,h] which will shared by all the arches. A common sense, in some degree.

Patch #2: Since the 'pci_mmcfg_list' now can be shared across all arches,
the arch-specific fix method can be replaced by the new solution naturally.

Now the v3 patch has been finalized, can we move forward to the next step? -
either give the concerns/objections or pick it up.

Xuesong Chen (2):
  PCI: MCFG: Consolidate the separate PCI MCFG table entry list
  ACPI: APEI: Filter the PCI MCFG address with an arch-agnostic method

 arch/x86/include/asm/pci_x86.h | 17 +---------------
 arch/x86/pci/mmconfig-shared.c | 30 ----------------------------
 drivers/acpi/apei/apei-base.c  | 45 ++++++++++++++++++++++++++++--------------
 drivers/acpi/pci_mcfg.c        | 34 ++++++++++++-------------------
 drivers/pci/pci.c              |  2 ++
 include/linux/pci.h            | 17 ++++++++++++++++
 6 files changed, 63 insertions(+), 82 deletions(-)

-- 
1.8.3.1

