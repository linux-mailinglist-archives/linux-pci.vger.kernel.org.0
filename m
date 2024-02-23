Return-Path: <linux-pci+bounces-3954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86289861F19
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 22:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A56C1F27187
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 21:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7EC1493A5;
	Fri, 23 Feb 2024 21:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGbKUQxd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D255D90A;
	Fri, 23 Feb 2024 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708724255; cv=none; b=Qk3dIhFn2BRvem7/E9V70yXe6N8zqD03F/oczO45AtxvabsQmtoh0u3/st+EnDB2v/Ym3KnyGxf2iHOF9m3w0z1Hmu7VDC6GhAYDh72h2EEeWmui6t+3X6Nb/eCW1o/sIbVuT8ODufmFSlyLVXoTrpii2WWT/xIQLO6EU9FTUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708724255; c=relaxed/simple;
	bh=nP1XVtTKobALHJllafckrGoqJY1gjcMjisX4Im2RJss=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UkPjryufcoUPc/GXiaSraMVH0ZUWuIkQI64AiFDVgy+pDWQjYIgBdIHl/U1dwrSfAMWUVlAScABSlNSYMbOvdEKsDTxFvh1X8jqVmVw+XyFk8KoxqRfEZjSPb7/wryKc6br6CEuTkm6KjzPZwKXphb06Q6uxFn8A+iSMg7z8S/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGbKUQxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C172C433F1;
	Fri, 23 Feb 2024 21:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708724254;
	bh=nP1XVtTKobALHJllafckrGoqJY1gjcMjisX4Im2RJss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hGbKUQxdEVDYDaevBCFZqWHiQ9TG1XmtGz+718IUKYLRj7k1FcEn+MkbBwljtPxET
	 SAD5etqitgb414ej2yix3Cg4LF61ynvfcqHWPrpTC8nLYqjw63wNAiC596+Mhkfy2D
	 a1APxx0NbNHupYObcuT/onqzStaxTUC5PfPsAbjeoXCGSb/46DhoDGfj8DHbBFKKqU
	 MtNM7ZIcsemv3m+WXYDaNDk607wtql9eBVIjfcQBXMrtdrH1q3adhGWrvNVMmtpDKf
	 oECLyyGo0R/1CwG/t/3rUtLdSJLT8qLULb7FCWC5ikIp6OEq4Wz2+WAJef+0acxS8r
	 GJgVwfjJ94C/g==
Date: Fri, 23 Feb 2024 15:37:33 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"David E . Box" <david.e.box@linux.intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Tasev Nikola <tasev.stefanoska@skynet.be>,
	Mark Enriquez <enriquezmark36@gmail.com>,
	Thomas Witt <kernel@witt.link>,
	Werner Sembach <wse@tuxedocomputers.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Ricky Wu <ricky_wu@realtek.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Koba Ko <koba.ko@canonical.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 4/5] PCI/ASPM: Save L1 PM Substates Capability for
 suspend/resume
Message-ID: <20240223213733.GA115410@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223205851.114931-5-helgaas@kernel.org>

On Fri, Feb 23, 2024 at 02:58:50PM -0600, Bjorn Helgaas wrote:
> From: "David E. Box" <david.e.box@linux.intel.com>
> 
> 4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for
> suspend/resume") restored the L1 PM Substates Capability after resume,
> which reduced power consumption by making the ASPM L1.x states work after
> resume.
> 
> a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability for
> suspend/resume"") reverted 4ff116d0d5fd because resume failed on some
> systems, so power consumption after resume increased again.
> 
> a7152be79b62 mentioned that we restore L1 PM substate configuration even
> though ASPM L1 may already be enabled. This is due the fact that the
> pci_restore_aspm_l1ss_state() was called before pci_restore_pcie_state().
> 
> Save and restore the L1 PM Substates Capability, following PCIe r6.1, sec
> 5.5.4 more closely by:
> 
>   1) Do not restore ASPM configuration in pci_restore_pcie_state() but
>      do that after PCIe capability is restored in pci_restore_aspm_state()
>      following PCIe r6.1, sec 5.5.4.
> 
>   2) If BIOS reenables L1SS, particularly L1.2, we need to clear the
>      enables in the right order, downstream before upstream. Defer
>      restoring the L1SS config until we are at the downstream component.
>      Then update the config for both ends of the link in the prescribed
>      order.
> 
>   3) Program ASPM L1 PM substate configuration before L1 enables.
> 
>   4) Program ASPM L1 PM substate enables last, after rest of the fields
>      in the capability are programmed.

> @@ -1645,12 +1647,23 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
>  
>  	cap = (u16 *)&save_state->cap.data[0];
>  	pcie_capability_write_word(dev, PCI_EXP_DEVCTL, cap[i++]);
> -	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++]);
> +
> +	/* Restore LNKCTL register with ASPM control field clear */
> +	lnkctl = cap[i++];
> +	pcie_capability_write_word(dev, PCI_EXP_LNKCTL,
> +				   lnkctl & ~PCI_EXP_LNKCTL_ASPMC);
> +
>  	pcie_capability_write_word(dev, PCI_EXP_SLTCTL, cap[i++]);
>  	pcie_capability_write_word(dev, PCI_EXP_RTCTL, cap[i++]);
>  	pcie_capability_write_word(dev, PCI_EXP_DEVCTL2, cap[i++]);
>  	pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, cap[i++]);
>  	pcie_capability_write_word(dev, PCI_EXP_SLTCTL2, cap[i++]);
> +
> +	pci_restore_aspm_l1ss_state(dev);
> +
> +	/* Restore ASPM control after restoring L1SS state */
> +	pcie_capability_set_word(dev, PCI_EXP_LNKCTL,
> +				 lnkctl & PCI_EXP_LNKCTL_ASPMC);
>  }

This part makes me wonder if the PCI_EXP_LNKCTL restore could be
simplified by moving the L0s/L1 disable into
pci_restore_aspm_l1ss_state() as in the patch below.

It would be nice if the knowledge about L0s/L1 being disabled while
restoring L1SS state were encapsulated in
pci_restore_aspm_l1ss_state() instead of doing this dance in
pci_restore_pcie_state().

I didn't include this in the v7 posting because it changes the
sequence and I don't have a way to test it, and this whole thing is
awfully tricky to get right.

Bjorn

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 4ea98665172d..5a4b501a3f41 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1633,13 +1633,14 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 {
 	int i = 0;
 	struct pci_cap_saved_state *save_state;
-	u16 *cap, lnkctl;
+	u16 *cap;
 
 	/*
 	 * Restore max latencies (in the LTR capability) before enabling
 	 * LTR itself in PCI_EXP_DEVCTL2.
 	 */
 	pci_restore_ltr_state(dev);
+	pci_restore_aspm_l1ss_state(dev);
 
 	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_EXP);
 	if (!save_state)
@@ -1654,23 +1655,12 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 
 	cap = (u16 *)&save_state->cap.data[0];
 	pcie_capability_write_word(dev, PCI_EXP_DEVCTL, cap[i++]);
-
-	/* Restore LNKCTL register with ASPM control field clear */
-	lnkctl = cap[i++];
-	pcie_capability_write_word(dev, PCI_EXP_LNKCTL,
-				   lnkctl & ~PCI_EXP_LNKCTL_ASPMC);
-
+	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_SLTCTL, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_RTCTL, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_DEVCTL2, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_LNKCTL2, cap[i++]);
 	pcie_capability_write_word(dev, PCI_EXP_SLTCTL2, cap[i++]);
-
-	pci_restore_aspm_l1ss_state(dev);
-
-	/* Restore ASPM control after restoring L1SS state */
-	pcie_capability_set_word(dev, PCI_EXP_LNKCTL,
-				 lnkctl & PCI_EXP_LNKCTL_ASPMC);
 }
 
 static int pci_save_pcix_state(struct pci_dev *dev)
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index c89ef87ed1c4..46352132bb14 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -105,6 +105,7 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
 	struct pci_dev *parent = pdev->bus->self;
 	u32 *cap, pl_ctl1, pl_ctl2, pl_l1_2_enable;
 	u32 cl_ctl1, cl_ctl2, cl_l1_2_enable;
+	u16 clnkctl, plnkctl;
 
 	/*
 	 * In case BIOS enabled L1.2 when resuming, we need to disable it first
@@ -129,6 +130,17 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
 	pl_ctl2 = *cap++;
 	pl_ctl1 = *cap;
 
+	/* Make sure L0s/L1 are disabled before updating L1SS config */
+	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &clnkctl);
+	pcie_capability_read_word(parent, PCI_EXP_LNKCTL, &plnkctl);
+	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, clnkctl) ||
+	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, plnkctl)) {
+		pcie_capability_write_word(pdev, PCI_EXP_LNKCTL,
+					   clnkctl & ~PCI_EXP_LNKCTL_ASPMC);
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL,
+					   plnkctl & ~PCI_EXP_LNKCTL_ASPMC);
+	}
+
 	/*
 	 * Disable L1.2 on this downstream endpoint device first, followed
 	 * by the upstream
@@ -161,6 +173,13 @@ void pci_restore_aspm_l1ss_state(struct pci_dev *pdev)
 		pci_write_config_dword(pdev, pdev->l1ss + PCI_L1SS_CTL1,
 				       cl_ctl1 | cl_l1_2_enable);
 	}
+
+	/* Restore L0s/L1 if they were enabled */
+	if (FIELD_GET(PCI_EXP_LNKCTL_ASPMC, clnkctl) ||
+	    FIELD_GET(PCI_EXP_LNKCTL_ASPMC, plnkctl)) {
+		pcie_capability_write_word(parent, PCI_EXP_LNKCTL, clnkctl);
+		pcie_capability_write_word(pdev, PCI_EXP_LNKCTL, plnkctl);
+	}
 }
 
 #ifdef CONFIG_PCIEASPM

