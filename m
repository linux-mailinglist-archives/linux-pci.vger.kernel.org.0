Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319AE6F0760
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 16:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243466AbjD0O3P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 10:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243711AbjD0O3O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 10:29:14 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AE23583;
        Thu, 27 Apr 2023 07:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1682605752; x=1714141752;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gDC05yJnrnxFiM5XBTdbnuSpAwRc7QmiD7yubr33lrw=;
  b=VlojAe6eGavB43APGf+xxlOO1/CmMlySs2khdb8mkD8nlRtpWVe2u9Xm
   ylL/X8WLlwP9GL7ia9GyJxFMbfsrRH5LsRxg6cFtY/nlYyP/ybxaoLnFV
   84MkFUDIvrEgqtpi2Gz1b6d4Z4XYfM+if4+7EYoSgIZCXTYb4RZRbgZ69
   v2GjlQeDFd7+52kjAHmPXZUTzftzI05JWGr8VF5fvoJJtDUZOFwPwt6dy
   250vJD9znWx3VljQyVGl1See2b80R4RoM/A9UuVlcrWx8C/EtKbFoZP9l
   tbuYdCKvdrt9u65NJLakgHJ2hUWDo9O4f+aAD3hdqXvlGf4WiMxO6N/KY
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,230,1677538800"; 
   d="scan'208";a="30607875"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 27 Apr 2023 16:29:08 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 27 Apr 2023 16:29:08 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 27 Apr 2023 16:29:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1682605748; x=1714141748;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gDC05yJnrnxFiM5XBTdbnuSpAwRc7QmiD7yubr33lrw=;
  b=OeLCYW5HuNcKptNsYjf9i/CTOQbYTUA4Z+EMpPSK0MMLr6+McuEKGQTT
   09XDqUv8O3r5u15fI7aTo0rd6ImysXMaf1+qxxLijpV8hjaVr6At4azER
   T/nO6ku/E9x1euOW9gaOeNW0ZFZ6fIff9+1PsgkAf+4iv8f9tuFxnazCn
   Y0LADPAgYCfJGhEKkcQJ6x9sZltE1wa+OGfZT/VNUH+eM58SgcfRZnS/8
   2ZcVQ/YaSn9qMpuLlUF03Q5ErNpzyGu784s2L5xtdtS+LOKc1B30ZfGYZ
   FRH8iqPrRD8P2O8gmy6rVM+/lF6naHwexztzwiyGViF3ykv+RRwbSEb3x
   w==;
X-IronPort-AV: E=Sophos;i="5.99,230,1677538800"; 
   d="scan'208";a="30607873"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 27 Apr 2023 16:29:08 +0200
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 20979280056;
        Thu, 27 Apr 2023 16:29:08 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Korneliusz Osmenda <korneliuszo@gmail.com>,
        Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 0/3] PCI: Fix race condition upon sysfs init
Date:   Thu, 27 Apr 2023 16:28:58 +0200
Message-Id: <20230427142901.3570536-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi everyone,

this series is a totally different approach for fixing the sysfs init race
condition. The initial problem is stated at [1]. Previous proposals were
rejected ([2] and [3]). Here is what's happening


        CPU 0                                  CPU 1

                                        imx6_pcie_probe()
                                        dw_pcie_host_init()
                                        pci_host_probe()
                                        pci_scan_root_bus_bridge()
                                          pci_scan_child_bus_extend()
                                          pci_scan_slot()
                                          pci_scan_single_device()
                                          pci_device_add()
pci_sysfs_init()                          device_add()
  sysfs_initialized = 1;                  bus_add_device()
  for_each_pci_dev()                          ...
    pci_create_sysfs_dev_files()                  
                                        pci_bus_add_devices()
                                        pci_bus_add_device()
                                        pci_create_sysfs_dev_files()

Eventually calling pci_create_sysfs_dev_files() twice on the same pci_dev.
It's a very tight window, deeper PCIe trees increase that window during
host probe. Asynchronous PCIe host probe is a necessity
(PROBE_PREFER_ASYNCHRONOUS).

The first two patches are preparations for the last one actually fixing
the race. As functions like pci_create_sysfs_dev_files() are called from
externtal and internal to pci-sysfs, an internal version without checking
for sysfs_initialized is required.
For the fix a wait queue is introduced where all callers from external
callsites (regarding pci-sysfs.c) are waiting until pci_sysfs_init
initcall has finished and woken up all waiters.

A subtlety is that within __pci_create_sysfs_dev_files the resource files
(created by pci_sysfs_init) need to be removed, so they can be created
again from pci_host_probe call.

Best regards,
Alexander

Links:
[1] https://bugzilla.kernel.org/show_bug.cgi?id=215515
[2] https://lore.kernel.org/linux-pci/20230316091540.494366-1-alexander.stein@ew.tq-group.com/
[3] https://lore.kernel.org/linux-pci/20230316103036.1837869-1-alexander.stein@ew.tq-group.com/

Alexander Stein (3):
  PCI/sysfs: sort headers alphabetically
  PCI/sysfs: create private functions for
    pci_create_legacy_files/pci_create_sysfs_dev_files
  PCI/sysfs: Fix sysfs init race condition

 drivers/pci/pci-sysfs.c | 87 +++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 34 deletions(-)

-- 
2.34.1

