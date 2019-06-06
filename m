Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECDF36A83
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 05:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfFFDee (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jun 2019 23:34:34 -0400
Received: from ozlabs.ru ([107.173.13.209]:53092 "EHLO ozlabs.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726331AbfFFDee (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jun 2019 23:34:34 -0400
X-Greylist: delayed 514 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jun 2019 23:34:34 EDT
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id 4315FAE80017;
        Wed,  5 Jun 2019 23:25:59 -0400 (EDT)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     linux-kernel@vger.kernel.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-doc@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: PCI: Correct the resource_alignment parameter example
Date:   Thu,  6 Jun 2019 13:25:57 +1000
Message-Id: <20190606032557.107542-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The option description requires an order and so does the option
parsing code, however the example uses a size, fix this.

Fixes: 8b078c603249 ("PCI: Update "pci=resource_alignment" documentation")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90bb644..dcb53d64ad74 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3340,27 +3340,28 @@
 		resource_alignment=
 				Format:
 				[<order of align>@]<pci_dev>[; ...]
 				Specifies alignment and device to reassign
 				aligned memory resources. How to
 				specify the device is described above.
 				If <order of align> is not specified,
 				PAGE_SIZE is used as alignment.
 				PCI-PCI bridge can be specified, if resource
 				windows need to be expanded.
 				To specify the alignment for several
 				instances of a device, the PCI vendor,
 				device, subvendor, and subdevice may be
-				specified, e.g., 4096@pci:8086:9c22:103c:198f
+				specified, e.g., 12@pci:8086:9c22:103c:198f
+				for the 4096 alignment.
 		ecrc=		Enable/disable PCIe ECRC (transaction layer
 				end-to-end CRC checking).
 				bios: Use BIOS/firmware settings. This is the
 				the default.
 				off: Turn ECRC off
 				on: Turn ECRC on.
 		hpiosize=nn[KMG]	The fixed amount of bus space which is
 				reserved for hotplug bridge's IO window.
 				Default size is 256 bytes.
 		hpmemsize=nn[KMG]	The fixed amount of bus space which is
 				reserved for hotplug bridge's memory window.
 				Default size is 2 megabytes.
 		hpbussize=nn	The minimum amount of additional bus numbers
-- 
2.17.1

