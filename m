Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8A5423610
	for <lists+linux-pci@lfdr.de>; Wed,  6 Oct 2021 04:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhJFCrq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 22:47:46 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39994 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230261AbhJFCrp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 22:47:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=xuesong.chen@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0UqhYNOD_1633488351;
Received: from localhost(mailfrom:xuesong.chen@linux.alibaba.com fp:SMTPD_---0UqhYNOD_1633488351)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 06 Oct 2021 10:45:51 +0800
Date:   Wed, 6 Oct 2021 10:45:51 +0800
From:   Xuesong Chen <xuesong.chen@linux.alibaba.com>
To:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@redhat.com,
        bhelgaas@google.com
Cc:     steve.capper@arm.com, mark.rutland@arm.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xuesong.chen@linux.alibaba.com
Subject: [PATCH 0/2] PCI MCFG consolidation and APEI resource filtering
Message-ID: <YV0N38mxpetB1pbo@Dennis-MBP.local>
Reply-To: Xuesong Chen <xuesong.chen@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The issue of commit d91525eb8ee6 ("ACPI, EINJ: Enhance error injection tolerance
level") on x86 is also happened on our own arm64 platform. We sent a patch[1]
trying to fix this issue in an arch-specific way as x86 does, but according to
the suggestion from Lorenzo and Catalin, we can consolidate the PCI MCFG part
then fix it in a more common way.
 
[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2021-September/682292.html

Xuesong Chen (2):
  PCI: MCFG: Consolidate the separate PCI MCFG table entry list
  ACPI: APEI: Filter the PCI MCFG address with an arch-agnostic method

 arch/x86/include/asm/pci_x86.h | 17 +----------------
 arch/x86/pci/mmconfig-shared.c | 30 ------------------------------
 drivers/acpi/apei/apei-base.c  | 42 ++++++++++++++++++++++++++----------------
 drivers/acpi/pci_mcfg.c        | 34 +++++++++++++---------------------
 drivers/pci/pci.c              |  2 ++
 include/linux/pci.h            | 17 +++++++++++++++++
 6 files changed, 59 insertions(+), 83 deletions(-)

-- 
1.8.3.1

