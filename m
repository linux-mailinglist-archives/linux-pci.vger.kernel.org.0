Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF96605175
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 22:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiJSUlp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 16:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiJSUlm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 16:41:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C566162522;
        Wed, 19 Oct 2022 13:41:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E7B2619D2;
        Wed, 19 Oct 2022 20:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8912C433D6;
        Wed, 19 Oct 2022 20:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666212100;
        bh=Z44DH9O6uOt3QHqDqInc9GBIPGQQ++f33al7IoM5jWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qsGd5p7jqkQgXVTHec8LJiwk6MYBhy6eX4wSUsk2BryLFHFfsyx693Hpn5QEadjOd
         G/7n8X+9cR0rQikJ3UkLe9imHmBiVTiRnME4A6MhEkJ2Zm9uBbfqfm4+h1sfMShAK6
         LDcG9aQb5iT4/tRbdemTM+bzBoF2V9VG2zwJxbqGFHPpuTC37XIBt4dcQ32+rUgzAn
         2tzyMVFR+xZZEKX9sseHSVjDe3PnEzAihKIPAVyfxTx4gssLAl3iRoVJAjEVrGPFEr
         WWG3bL70esN3bNLjJhfs72vAuDN/oMyZLJzAZ6NQCLrRzYGnNnR1H/K1fKobxFlF1I
         1O89VhtGSRfRQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Stefan Roese <sr@denx.de>, Lukas Wunner <lukas@wunner.de>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Keith Busch <kbusch@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/3] PCI/portdrv: Unexport pcie_port_service_register(), pcie_port_service_unregister()
Date:   Wed, 19 Oct 2022 15:41:27 -0500
Message-Id: <20221019204127.44463-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221019204127.44463-1-helgaas@kernel.org>
References: <20221019204127.44463-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pcie_port_service_register() and pcie_port_service_unregister() are used
only by the pciehp, aer, dpc, and pme PCIe port service drivers, none of
which can be modules.  Unexport pcie_port_service_register() and
pcie_port_service_unregister().  No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/portdrv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index ae8da5b2e922..a6c4225505d5 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -584,7 +584,6 @@ int pcie_port_service_register(struct pcie_port_service_driver *new)
 
 	return driver_register(&new->driver);
 }
-EXPORT_SYMBOL(pcie_port_service_register);
 
 /**
  * pcie_port_service_unregister - unregister PCI Express port service driver
@@ -594,7 +593,6 @@ void pcie_port_service_unregister(struct pcie_port_service_driver *drv)
 {
 	driver_unregister(&drv->driver);
 }
-EXPORT_SYMBOL(pcie_port_service_unregister);
 
 /* If this switch is set, PCIe port native services should not be enabled. */
 bool pcie_ports_disabled;
-- 
2.25.1

