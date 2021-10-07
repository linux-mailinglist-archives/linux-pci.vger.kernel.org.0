Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2298E425CAB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Oct 2021 21:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbhJGTzK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Oct 2021 15:55:10 -0400
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:44849 "EHLO
        rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbhJGTxM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Oct 2021 15:53:12 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Oct 2021 15:53:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1595; q=dns/txt; s=iport;
  t=1633636278; x=1634845878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k13Cw5+zbxwgiD4aylr0j/1M7dK7iSjh8VSPRVa9fUI=;
  b=Ya8fNvbtY4sgglFWJYIGUISNsbvyL3cd+v2aZjwj2ia4BohsLq0qtdBI
   teUuhesGTzdlPc0G6LzHS0hE43WKN7FIiEh9g2U7B5ay4JlXzIVdTTiGn
   clpIg1XBlXxdtmiIudaiztgbZlKAIvymFLqlzKOo/MvgneWxOWwcGyCL8
   Y=;
IronPort-Data: =?us-ascii?q?A9a23=3AlPV2vqpVkGTgvbBUXZKDT6gaG29eBmKvZxIvg?=
 =?us-ascii?q?KrLsJaIsI4StFCztgarIBmCbqrZYWH2KYwnO9uw8BtUvsDVn9NlGwdsr3xkH?=
 =?us-ascii?q?isT8ePIVI+TRqvS04x+DSFioHqKZKzyU/GYRCwPZiKa9krF3oTJ9yEmjPjQH?=
 =?us-ascii?q?uWkU4YoBwgoLeNaYHZ54f5cs7ZRbr5A2bBVMivV0T/Ai5S31GyNg1aYBlkpB?=
 =?us-ascii?q?5er83uDihhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251?=
 =?us-ascii?q?juxExYFENiplPPwdVcHB+OUNgmVgX0QUK+n6vRAjnVtieBga7xNMgEO1mvhc?=
 =?us-ascii?q?9NZkL2hsbS8QAEoM6nTkcwWUgJTFGd1OqguFLrvcCTj4ZHJnhGXG5fr67A0Z?=
 =?us-ascii?q?K0sBqUc++BqESRN+OYeJTQlcB+OnaS1zai9R+0qgd4sROHvPYUCqjR4xjDxE?=
 =?us-ascii?q?/krW9bATr/M6Nse2y0/7uhEHfvaaMMQchJgaxPPZxAJMVASYLolk+C1mnn2d?=
 =?us-ascii?q?hVdoUiLqK4zpWPUyWRZ27PtOcTLc/SPTN9Lk0Kc4GnB+gzRGR4TLtWHwCaE2?=
 =?us-ascii?q?nelnPHCmSe9U4UXfJWx9eZvqFmSwHEDTRMRSF23qOW4jUj4XMhQQ3H4UAJGQ?=
 =?us-ascii?q?bMa7kenSJz2WAe15SPCtR8HUN0WGOo/gDxhA5H8u26xblXohBYdADD+iPILe?=
 =?us-ascii?q?A=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Am4meTKyWGSa0vPxccS+FKrPwJb1zdoMgy1?=
 =?us-ascii?q?knxilNoNJuHvBw8Pre/sjzuiWbtN98YhsdcLO7Scq9qA3nlKKdiLN5VdyftW?=
 =?us-ascii?q?Ld11dAQrsO0WKb+V3d8+mUzJ846U+mGJIObeHNMQ=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BpAACrTV9h/5xdJa1aHQEBAQEJARI?=
 =?us-ascii?q?BBQUBggYHAQsBgiiBTQE6MZVTnB2BfAsBAQEPQQQBAYR+gkoCJTUIDgECBAE?=
 =?us-ascii?q?BARIBAQUBAQECAQYEgREThXWGcAsBRikHbiATgnGDCKx6gXkygQGIFYFjgTo?=
 =?us-ascii?q?BiQ+FIByBSUSBFYJ6bopCBIs+AYENgTGBDyOSGI56nS6DOoE4nRgaMYNqkjG?=
 =?us-ascii?q?Qe7dMhEeBYgE5gVkzGggbFYMkURkPnRAhAzA4AgYLAQEDCZRxAQE?=
X-IronPort-AV: E=Sophos;i="5.85,355,1624320000"; 
   d="scan'208";a="944852949"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 07 Oct 2021 19:44:10 +0000
Received: from zorba.lan ([10.24.18.63])
        by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTP id 197Ji9j9009280;
        Thu, 7 Oct 2021 19:44:10 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suneel Garapati <sgarapati@marvell.com>,
        Chandrakala Chavva <cchavva@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH-RFC] drivers: pci: pcieport: Allow AER service only on root ports
Date:   Thu,  7 Oct 2021 12:44:09 -0700
Message-Id: <20211007194409.3641467-1-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.24.18.63, [10.24.18.63]
X-Outbound-Node: rcdn-core-5.cisco.com
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Suneel Garapati <sgarapati@marvell.com>

Some AER interrupt capability registers may not be present on
non Root ports. Since there is no way to check presence of
ROOT_ERR_COMMAND and ROOT_ERR_STATUS registers. Allow AER
service only on root ports.
Otherwise AER interrupt message number is read incorrectly
causing MSIX vector registration to fail and fallback to legacy
unnecessarily.

Signed-off-by: Suneel Garapati <sgarapati@marvell.com>
Reviewed-by: Chandrakala Chavva <cchavva@marvell.com>
Reviewed-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
---
 drivers/pci/pcie/portdrv_core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 3ee63968deaa..edc355971a32 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -221,7 +221,16 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 
 #ifdef CONFIG_PCIEAER
+	/*
+	 * Some AER interrupt capability registers may not be present on
+	 * non Root ports. Since there is no way to check presence of
+	 * ROOT_ERR_COMMAND and ROOT_ERR_STATUS registers. Allow AER
+	 * service only on root ports. Refer PCIe rev5.0 spec v1.0 7.8.4.
+	 * Otherwise AER interrupt message number is read incorrectly
+	 * causing MSIX vector registration to fail and fallback to legacy.
+	 */
 	if (dev->aer_cap && pci_aer_available() &&
+	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
 	    (pcie_ports_native || host->native_aer)) {
 		services |= PCIE_PORT_SERVICE_AER;
 
-- 
2.25.1

