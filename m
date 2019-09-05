Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9D2AABC4
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 21:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbfIETN4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 15:13:56 -0400
Received: from alpha.anastas.io ([104.248.188.109]:46521 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfIETN4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 15:13:56 -0400
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id 4C99D7F933;
        Thu,  5 Sep 2019 14:13:55 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1567710836; bh=pStf8QitHKtVk+JbUuAJMaaI3Anph/8j3/5AIldlk/4=;
        h=From:To:Cc:Subject:Date:From;
        b=hzr4Wy1fotVM803whVZsLqBQAQcXKXnEMQMdCWaFK4BTPDZ5yFAALkqd5Dr0YXXAi
         t8JNJIwFOl3dpR2+jwBVSydz+qa0tNj/WZdVb/4UfCZBg9V0XgwMxB82bm/ixlN6GN
         T53TCrRJVDLz5S50SGT20MQCTxrnhDro7I/vvtbVf6J6B0EGYVBPo5mqQUToasnSKF
         E/NZ9ikPeTl6GNbunAVH9nTGiz4aeA5SmCM02Vb0ezuINo6eijMVaiFmXXpl3KA43m
         oGnBN6U16BlXJI/IvtEz9lVZ63PfCRhtuws2XiOz5YLTUsBPw9clECuc4KVLJnfat2
         qYxFyrotT4czg==
From:   Shawn Anastasio <shawn@anastas.io>
To:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     bhelgaas@google.com, mpe@ellerman.id.au, aik@ozlabs.ru,
        benh@kernel.crashing.org, sbobroff@linux.ibm.com, oohall@gmail.com,
        lukas@wunner.de
Subject: [PATCH v2 0/1] Fix IOMMU setup for hotplugged devices on pseries
Date:   Thu,  5 Sep 2019 14:13:42 -0500
Message-Id: <20190905191343.2919-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes from v2:
  - Remove pcibios_fixup_dev()
  - Remove pcibios_setup_bus_device() call in pcibios_fixup_bus() since
all device setup will now be handled in pcibios_bus_add_device()

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

The current solution is to move all device setup to pcibios_bus_add_device()
which will occur after all devices have been registered.

Shawn Anastasio (1):
  powerpc/pci: Fix pcibios_setup_device() ordering

 arch/powerpc/kernel/pci-common.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

-- 
2.20.1

