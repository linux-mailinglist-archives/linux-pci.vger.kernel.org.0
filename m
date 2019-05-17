Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D479421DBD
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 20:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfEQSsW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 May 2019 14:48:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53562 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfEQSsW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2019 14:48:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C2F5A61892; Fri, 17 May 2019 18:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558118900;
        bh=35zZ5q4uMp/3q4Z0JDCSvFDAAIE0REjNe04GsZlSd9s=;
        h=From:To:Cc:Subject:Date:From;
        b=aJziovqK9JqfOz+VdzLUlLoZzJq7MpPBgTKdfPh4KjQN1WlFQdJrcVmdyDgeBFuDn
         rbo6VsoEGhC0sfP5CHF5kBvY8jSYbN4swXbH29meixv5Pzt7opn32mZcMG/H+WQkhR
         PsF/k7nTKCeSTHpc3TD7cvKDW401LvWHOmYHnUXY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from isaacm-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 736716179C;
        Fri, 17 May 2019 18:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558118891;
        bh=35zZ5q4uMp/3q4Z0JDCSvFDAAIE0REjNe04GsZlSd9s=;
        h=From:To:Cc:Subject:Date:From;
        b=SOz/6r03g7SCcJGbSThbJKQnFy/ydy//GRaazg08v/2nnzbeA2kfwt+7DU/h5VOl4
         xXmNB0yQSIchcnRZzMOY3UoRMEbtrWtzv2tggQZPxIPf3+VznmC4rVcRLPMToj7grj
         pn7Xia0PvsazfTd/chmiqRi5k+mz1Ap3FJqYLL18=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 736716179C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=isaacm@codeaurora.org
From:   "Isaac J. Manjarres" <isaacm@codeaurora.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, robh+dt@kernel.org,
        frowand.list@gmail.com, bhelgaas@google.com, joro@8bytes.org,
        robin.murphy@arm.com, will.deacon@arm.com, kernel-team@android.com,
        pratikp@codeaurora.org, lmark@codeaurora.org
Subject: [RFC/PATCH 0/4] Initial support for modular IOMMU drivers
Date:   Fri, 17 May 2019 11:47:33 -0700
Message-Id: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds initial support for being able to use the ARM
SMMU driver as a loadable kernel module. The series also adds
to the IOMMU framework, so that it can defer probing for devices
that depend on an IOMMU driver that may be a loadable module.

The primary reason behind these changes is that having the ARM
SMMU driver as a module allows for the same kernel image to be
used across different platforms. For example, if one platform
contains an IOMMU that implements one version of the ARM SMMU
specification, and another platform simply does not have an
IOMMU, the only way that these platforms can share the same
kernel image is if the ARM SMMU driver is compiled into the
kernel image.

This solution is not scalable, as it will lead to bloating the
kernel image with support for several future versions of the
SMMU specification to maintain a common kernel image that works
across all platforms. Having the ARM SMMU driver as a module allows
for a common kernel image to be supported across all platforms,
while yielding a smaller kernel image size, since the correct
SMMU driver can be loaded at runtime, if necessary.

Patchset Summary:

1. Since the ARM SMMU driver depends on symbols being exported from
several subsystems, the first three patches are dedicated to exporting
the necessary symbols.

2. Similar to how the pinctrl framework handles deferring probes,
the subsequent patch makes it so that the IOMMU framework will defer
probes indefinitely if there is a chance that the IOMMU driver that a
device is waiting for is a module. Otherwise, it upholds the current
behavior of stopping probe deferrals once all of the builtin drivers
have finished probing.

The ARM SMMU driver currently has support for the deprecated
"mmu-masters" binding, which relies on the notion of initcall
ordering for setting the bus ops to ensure that all SMMU devices
have been bound to the driver. This poses a problem with
making the driver a module, as there is no such notion with
loadable modules. Will support for this be completely deprecated?
If not, might it be useful to leverage the device tree ordering,
and assign a property to the last SMMU device, and set the bus ops
at that point? Or perhaps have some deferred timer based approach
to know when to set the bus ops? 

Thanks,
Isaac

Isaac J. Manjarres (4):
  of: Export of_phandle_iterator_args() to modules
  PCI: Export PCI ACS and DMA searching functions to modules
  iommu: Export core IOMMU functions to kernel modules
  iommu: Add probe deferral support for IOMMU kernel modules

 drivers/iommu/iommu-sysfs.c | 3 +++
 drivers/iommu/iommu.c       | 6 ++++++
 drivers/iommu/of_iommu.c    | 8 ++++++--
 drivers/of/base.c           | 1 +
 drivers/pci/pci.c           | 1 +
 drivers/pci/search.c        | 1 +
 6 files changed, 18 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

