Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1682E33FA
	for <lists+linux-pci@lfdr.de>; Mon, 28 Dec 2020 05:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgL1EF5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Dec 2020 23:05:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:46410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgL1EF5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Dec 2020 23:05:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 180E8206D4;
        Mon, 28 Dec 2020 04:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609128316;
        bh=MdjD7BH+41KU7Oxxv0Urq2PeP/eYK+mpFjsS8iyMIHo=;
        h=Date:From:To:Cc:Subject:From;
        b=Yd7HBr0ZBUEp/nRAC1TCrR02b2boWh7wSdnwYTFz1kjS2TZkVhHYBClyzzRPiTy74
         XOgC6LrxYEO1gzprhBfOqMXENxFl2kq8T+0hDqZj/OhRkA9ETsHnpFuvzVHx3AozAA
         blq1yhrkjPFgRD1/GphflJFFq79laiaOgSTQ2XmSg7hITM8cUQ43WJpR/IPl0e0s/w
         GKcLRgn1d2r+zbkOv3OomZra5vGy0qmbpblqO1v5F1P7UkY2IyaitYE0Xq/2AY0KH9
         Mqw5E89rf/a8SpFaoqmPfBBL798GCPZsOvCfOUBRoIMIEKA9nylSVgvF2y/rtNGpBr
         Phvuf1ee1KF2w==
Date:   Sun, 27 Dec 2020 22:05:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Commit 4257f7e0 ("PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume") causing hibernate resume failures
Message-ID: <20201228040513.GA611645@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> From: Kenneth R. Crudup <kenny@panix.com>
> 
> I've been running Linus' master branch on my laptop (Dell XPS 13
> 2-in-1).  With this commit in place, after resuming from hibernate
> my machine is essentially useless, with a torrent of disk I/O errors
> on my NVMe device (at least, and possibly other devices affected)
> until a reboot.
> 
> I do use tlp to set the PCIe ASPM to "performance" on AC and
> "powersupersave" on battery.

Thanks a lot for the report, and sorry for the breakage.

4257f7e008ea restores PCI_L1SS_CTL1, then PCI_L1SS_CTL2.  I think it
should do those in the reverse order, since the Enable bits are in
PCI_L1SS_CTL1.  It also restores L1SS state (potentially enabling
L1.x) before we restore the PCIe Capability (potentially enabling ASPM
as a whole).  Those probably should also be in the other order.

If it's convenient, can you try the patch below?  If the debug patch
doesn't help:

  - Are you seeing the hibernate/resume problem when on AC or on
    battery?

  - What if you don't use tlp?  Does hibernate/resume work fine then?
    If tlp makes a difference, can you collect "sudo lspci -vv" output
    with and without using tlp (before hibernate)?

  - If you revert 4257f7e008ea, does hibernate/resume work fine?  Both
    with the tlp tweak and without?

  - Collect "sudo lspci -vv" output before hibernate and (if possible)
    after resume when you see the problem.

I guess tlp only uses /sys/module/pcie_aspm/parameters/policy, so it
sets the same ASPM policy system-wide.

Bjorn

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b9fecc25d213..6598b5cd3154 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1665,9 +1665,8 @@ void pci_restore_state(struct pci_dev *dev)
 	 * LTR itself (in the PCIe capability).
 	 */
 	pci_restore_ltr_state(dev);
-	pci_restore_aspm_l1ss_state(dev);
-
 	pci_restore_pcie_state(dev);
+	pci_restore_aspm_l1ss_state(dev);
 	pci_restore_pasid_state(dev);
 	pci_restore_pri_state(dev);
 	pci_restore_ats_state(dev);
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index a08e7d6dc248..c4a99274b4bb 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -752,8 +752,8 @@ void pci_save_aspm_l1ss_state(struct pci_dev *dev)
 		return;
 
 	cap = (u32 *)&save_state->cap.data[0];
-	pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
 	pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, cap++);
+	pci_read_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, cap++);
 }
 
 void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
@@ -774,8 +774,8 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *dev)
 		return;
 
 	cap = (u32 *)&save_state->cap.data[0];
-	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
 	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL2, *cap++);
+	pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++);
 }
 
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
