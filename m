Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03019E39F6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfJXR1e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:27:34 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:49744 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394016AbfJXR1d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:27:33 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 3149142F15;
        Thu, 24 Oct 2019 17:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received:received; s=mta-01; t=1571938050; x=
        1573752451; bh=aHxTFcPy9x4pTAr3BLyPjqx9Bb7cTzN8Ohp8fzqtGRM=; b=V
        5ncIXvgIrFSfY2JH4868INccGQW3Iv0zO9FAFgNPOrhPxMPot3CMWy7qZC08QAo/
        Ym9q2FiqRVmzeqKIsCiz3gCDlNMvE5MByO9R7lyuxEcsIxb1gKXmyYV/jS8QVK4U
        HMCwujMSTsNo18vEPSGIOmD0myKNLRQe7PQjCMIEEg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WfW085DNjnxR; Thu, 24 Oct 2019 20:27:30 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 0E62742F14;
        Thu, 24 Oct 2019 20:27:30 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:27:29 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: [PATCH] PCI: pciehp: Don't wait for Command Completed if this interrupt is disabled
Date:   Thu, 24 Oct 2019 20:27:21 +0300
Message-ID: <20191024172721.879226-1-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pcie_init() invokes pcie_disable_notification() for empty slots, which in
turn disables the Command Complete interrupt (unset PCI_EXP_SLTCTL_CCIE)
and right after that waits for Command Complete event (PCI_EXP_SLTSTA_CC).

Add a quirk for the PLX 8796 switch, which after disabling CCIE also stops
setting the PCI_EXP_SLTSTA_CC bit.

This quirk fixes the longer boot time - 4 seconds of delay for each empty
slot:

[    4.200325] pciehp 0042:04:08.0:pcie204: Slot #40 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
[    4.200607] pciehp 0042:04:08.0:pcie204: pciehp_get_power_status: SLOTCTRL 80 value read 1c0
[    6.217938] pciehp 0042:04:08.0:pcie204: Timeout on hotplug command 0x01c0 (issued 2020 msec ago)
[    6.217966] pciehp 0042:04:08.0:pcie204: pcie_disable_notification: SLOTCTRL 80 write cmd 0
[    6.237938] pciehp 0042:04:08.0:pcie204: Timeout on hotplug command 0x01c0 (issued 2040 msec ago)
[    8.257939] pciehp 0042:04:08.0:pcie204: Timeout on hotplug command 0x05c0 (issued 2020 msec ago)
[    8.257974] pciehp 0042:04:08.0:pcie204: pciehp_power_off_slot: SLOTCTRL 80 write cmd 400
[    8.258034] pci_bus 0042:07: dev 00, created physical slot 40
[    8.277941] pciehp 0042:04:08.0:pcie204: Timeout on hotplug command 0x05c0 (issued 2040 msec ago)
[    8.277967] pciehp 0042:04:08.0:pcie204: pcie_enable_notification: SLOTCTRL 80 write cmd 1031

Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 18 ++++++++++++++++++
 include/linux/pci.h              |  1 +
 2 files changed, 19 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 1a522c1c4177..971258576be1 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -173,6 +173,10 @@ static void pcie_do_write_cmd(struct controller *ctrl, u16 cmd,
 	    (slot_ctrl_orig & CC_ERRATUM_MASK) == (slot_ctrl & CC_ERRATUM_MASK))
 		ctrl->cmd_busy = 0;
 
+	if (pdev->no_cmd_compl_wo_ccie &&
+	    !(ctrl->slot_ctrl & PCI_EXP_SLTCTL_CCIE))
+		ctrl->cmd_busy = 0;
+
 	/*
 	 * Optionally wait for the hardware to be ready for a new command,
 	 * indicating completion of the above issued command.
@@ -901,6 +905,18 @@ static void quirk_cmd_compl(struct pci_dev *pdev)
 			pdev->broken_cmd_compl = 1;
 	}
 }
+
+static void quirk_no_cmd_compl_wo_ccie(struct pci_dev *pdev)
+{
+	u32 slot_cap;
+
+	if (pci_is_pcie(pdev)) {
+		pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
+		if (slot_cap & PCI_EXP_SLTCAP_HPC &&
+		    !(slot_cap & PCI_EXP_SLTCAP_NCCS))
+			pdev->no_cmd_compl_wo_ccie = 1;
+	}
+}
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0400,
@@ -909,3 +925,5 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_QCOM, 0x0401,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
 DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_HXT, 0x0401,
 			      PCI_CLASS_BRIDGE_PCI, 8, quirk_cmd_compl);
+DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_PLX, 0x8796,
+			      PCI_CLASS_BRIDGE_PCI, 8, quirk_no_cmd_compl_wo_ccie);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b5821134bdae..e61b92a15b19 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -437,6 +437,7 @@ struct pci_dev {
 
 #ifdef CONFIG_HOTPLUG_PCI_PCIE
 	unsigned int	broken_cmd_compl:1;	/* No compl for some cmds */
+	unsigned int	no_cmd_compl_wo_ccie:1;	/* No compl if CCIE is unset */
 #endif
 #ifdef CONFIG_PCIE_PTM
 	unsigned int	ptm_root:1;
-- 
2.23.0

