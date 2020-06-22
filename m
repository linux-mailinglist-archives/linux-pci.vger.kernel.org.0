Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66EF2035CD
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jun 2020 13:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgFVLfl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Jun 2020 07:35:41 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2350 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727060AbgFVLfl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Jun 2020 07:35:41 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 107D28207B97897BE5EE;
        Mon, 22 Jun 2020 12:35:40 +0100 (IST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 22 Jun 2020 12:35:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-pci@vger.kernel.org>
CC:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Sean Kelley <sean.v.kelley@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linuxarm@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2] PCI/AER: Do not reset the port device status if doing firmware first handling.
Date:   Mon, 22 Jun 2020 19:35:23 +0800
Message-ID: <20200622113523.891666-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_aer_clear_device_status() currently resets the device status
(PCI_EXP_DEVSTA) on the downstream port above a device, or the port itself
if the port is the reported AER error source.  This happens even when error
handling is firmware first.

Our interpretation is that firmware first handling means that the firmware
will deal with clearing all relevant error reporting registers
including this one.

Bjorn Helgaas reports that this has been clarified in sec 4.5.1 of:

  System Firmware Intermediary (SFI) _OSC and DPC Updates ECN, Feb 24,
    2020, affecting PCI Firmware Specification, Rev. 3.2
      https://members.pcisig.com/wg/PCI-SIG/document/14076

The call path that triggers this unwanted clear is:

ghes_do_proc->
ghes_handle_aer->
aer_recover_queue->
aer_recover_work_func->
pcie_do_recovery->
pci_aer_clear_device_status

I believe this extra status clear is probably harmless so probably not
worth backporting.  I'm not aware of any reports of issues caused by
this and only identified it as incorrect during some emulated reset
flow testing.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

Changes since v1:

* As this is independent of the RCiEP APEI error handling patch
  I have separated them.
* Rebase on mainline including changing to new handling of firmware
  first vs native handling.
* More detail added to patch description including the reference
  Bjorn suggested.

 drivers/pci/pcie/aer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 3acf56683915..c7cdeaff4350 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -245,6 +245,9 @@ void pci_aer_clear_device_status(struct pci_dev *dev)
 {
 	u16 sta;
 
+	if (!pcie_aer_is_native(dev))
+		return;
+
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
-- 
2.19.1

