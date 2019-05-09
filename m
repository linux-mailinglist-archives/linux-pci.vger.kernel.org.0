Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31CA9192E2
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 21:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfEIT1d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 15:27:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbfEIT1c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 15:27:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91B2E81112;
        Thu,  9 May 2019 19:27:32 +0000 (UTC)
Received: from gimli.home (ovpn-117-92.phx2.redhat.com [10.3.117.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CEBD5C582;
        Thu,  9 May 2019 19:27:22 +0000 (UTC)
Subject: [PATCH] PCI: Always allow probing with driver_override
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, linux-kernel@vger.kernel.org,
        myron.stowe@redhat.com, bodong@mellanox.com, eli@mellanox.com,
        laine@redhat.com
Date:   Thu, 09 May 2019 13:27:22 -0600
Message-ID: <155742996741.21878.569845487290798703.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 09 May 2019 19:27:32 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control
VF driver binding") introduced the sriov_drivers_autoprobe attribute
which allows users to prevent the kernel from automatically probing a
driver for new VFs as they are created.  This allows VFs to be spawned
without automatically binding the new device to a host driver, such as
in cases where the user intends to use the device only with a meta
driver like vfio-pci.  However, the current implementation prevents any
use of drivers_probe with the VF while sriov_drivers_autoprobe=0.  This
blocks the now current general practice of setting driver_override
followed by using drivers_probe to bind a device to a specified driver.

The kernel never automatically sets a driver_override therefore it seems
we can assume a driver_override reflects the intent of the user.  Also,
probing a device using a driver_override match seems outside the scope
of the 'auto' part of sriov_drivers_autoprobe.  Therefore, let's allow
driver_override matches regardless of sriov_drivers_autoprobe, which we
can do by simply testing if a driver_override is set for a device as a
'can probe' condition.

Fixes: 0e7df22401a3 ("PCI: Add sysfs sriov_drivers_autoprobe to control VF driver binding")
Link: https://lore.kernel.org/linux-pci/155672991496.20698.4279330795743262888.stgit@gimli.home/T/#u
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---

 drivers/pci/pci-driver.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index da7b82e56c83..9b9e9c63cde8 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -399,7 +399,8 @@ void __weak pcibios_free_irq(struct pci_dev *dev)
 #ifdef CONFIG_PCI_IOV
 static inline bool pci_device_can_probe(struct pci_dev *pdev)
 {
-	return (!pdev->is_virtfn || pdev->physfn->sriov->drivers_autoprobe);
+	return (!pdev->is_virtfn || pdev->physfn->sriov->drivers_autoprobe ||
+		pdev->driver_override);
 }
 #else
 static inline bool pci_device_can_probe(struct pci_dev *pdev)

