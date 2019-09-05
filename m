Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21E5DA99A3
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 06:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfIEEcR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 00:32:17 -0400
Received: from alpha.anastas.io ([104.248.188.109]:33281 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfIEEcR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 00:32:17 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id B366F7F36F;
        Wed,  4 Sep 2019 23:22:36 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1567657357; bh=K6Ul0Tf6WBGzJ3DDSMKISfwTd9Ljf7uLpT71uwUiykg=;
        h=From:To:Cc:Subject:Date:From;
        b=OZFbCn8M3hBjC8mHFPqH+pxxDD0whlm+XYT+LQWGi/JbN4iE5ONkE1ZWaUvPp9v8z
         xRyRe4ukehqLk2vBr3OKyu8ECMmNamJgCaHX6u9MXkIuoOo4OorTrZGyGNMr+DKxRe
         Zyt81X1TreZRBFNYDinjUIOzvoIBecFVwyLDQlET1cv722hifFvHKu22ZTalQG7c8/
         mxrJyo/gWlvWh3lRiAtx+KJ280OdyM9ODQMv540j/pMeJBajW0YnuK9fUMOCfL5kYs
         NbzrH/z0/JOYam2OKUkTPA8LuxMdnS34dlanNTy/0OCWv1pdrMJV/fiVlJzdaSbIhG
         MSKjGjbqi2Ynw==
From:   Shawn Anastasio <shawn@anastas.io>
To:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     bhelgaas@google.com, mpe@ellerman.id.au, aik@ozlabs.ru,
        benh@kernel.crashing.org, sbobroff@linux.ibm.com, oohall@gmail.com
Subject: [PATCH 0/2] Fix IOMMU setup for hotplugged devices on pseries
Date:   Wed,  4 Sep 2019 23:22:13 -0500
Message-Id: <20190905042215.3974-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On pseries QEMU guests, IOMMU setup for hotplugged PCI devices is currently
broken for all but the first device on a given bus. The culprit is an ordering
issue in the pseries hotplug path (via pci_rescan_bus()) which results in IOMMU
group assigment occuring before device registration in sysfs. This triggers
the following check in arch/powerpc/kernel/iommu.c:

/*
 * The sysfs entries should be populated before
 * binding IOMMU group. If sysfs entries isn't
 * ready, we simply bail.
 */
if (!device_is_registered(dev))
	return -ENOENT;

This fails for hotplugged devices since the pcibios_add_device() call in the
pseries hotplug path (in pci_device_add()) occurs before device_add().
Since the IOMMU groups are set up in pcibios_add_device(), this means that a
sysfs entry will not yet be present and it will fail.

There is a special case that allows the first hotplugged device on a bus to
succeed, though. The powerpc pcibios_add_device() implementation will skip
initializing the device if bus setup is not yet complete.
Later, the pci core will call pcibios_fixup_bus() which will perform setup
for the first (and only) device on the bus and since it has already been
registered in sysfs, the IOMMU setup will succeed.

My current solution is to introduce another pcibios function, pcibios_fixup_dev,
which is called after device_add() in pci_device_add(). Then in powerpc code,
pcibios_setup_device() was moved from pcibios_add_device() to this new function
which will occur after sysfs registration so IOMMU assignment will succeed.

I added a new pcibios function rather than moving the pcibios_add_device() call
to after the device_add() call in pci_add_device() because there are other
architectures that use it and it wasn't immediately clear to me whether moving
it would break them.

If anybody has more insight or a better way to fix this, please let me know.

Shawn Anastasio (2):
  PCI: Introduce pcibios_fixup_dev()
  powerpc/pci: Fix IOMMU setup for hotplugged devices on pseries

 arch/powerpc/kernel/pci-common.c | 13 ++++++-------
 drivers/pci/probe.c              | 14 ++++++++++++++
 include/linux/pci.h              |  1 +
 3 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.20.1

