Return-Path: <linux-pci+bounces-25510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0518CA81293
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 18:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FD63B46DD
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F4422DFB1;
	Tue,  8 Apr 2025 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubdRKC5X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6EA22F3B8
	for <linux-pci@vger.kernel.org>; Tue,  8 Apr 2025 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130162; cv=none; b=gE2+4VL1fqEf9AL23lUtib+IKNtf8FZnqCSzcv8tIFpJcWwpEmAmn0bPCjfFcJPdyGQSnKuowqvDrpwSerjXZDsgbmGiEiRTHTrU2nwqv/b1gn9FTX5CrDnDpX9jo8be/wMjcExgfu9h7CAzRQ1y+wTeA/7fyz5v7BGCCuFUVjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130162; c=relaxed/simple;
	bh=00A5pSAj4q5FEcB3H5HQ7k3EUdvbnl6kl/w6qZejtHY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qonsxjUEKyWURUvrd0DPGVI+77Q7XtdrMJnCZDIROjzndAykDaUzLAKNxDU/gYjUB0z+/RpIHuT09kNFn7IPh6iAXyJOdfGOSxSMpBqzLp0KKgpk28S2sNrgSs8phqC3f2C3Z93ShJMA/37wpH+5wFGn4g2ZVp+Infgxc6Jnr98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubdRKC5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC78C4CEE5;
	Tue,  8 Apr 2025 16:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744130162;
	bh=00A5pSAj4q5FEcB3H5HQ7k3EUdvbnl6kl/w6qZejtHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ubdRKC5XVdDiJmQ81lfhxJs7OEnmrMAaIPEfsA6y7cySPT2vaDjHyF26IWgRoxld8
	 D5OOHPCnxuXBFqqItraWRIo9N4720uC0u8fWRwv3GPnqgzgrTyRroOLa75W8WFanWx
	 V176JKWojR47Q+wwj+m+im0G2zI0TPKEJ187ga7cYEFo16nuN0Ewstp1TSI07DJJbF
	 slqp2qKExT+GnI4twKx7aIYRTSQSU3eJuqhX1lJkBZ0FQwIhA9KQ/srsc/bLUSD3cx
	 rewti8fNzcCFyzz0UL34RWMmfKsFvpu7KaCmjlcW2l/d+IIGPRfIrW4TVBcez68pVK
	 kWpJD+Z0aqKVQ==
Date: Tue, 8 Apr 2025 11:36:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Dolgov <sergey.v.dolgov@gmail.com>
Cc: linux-pci@vger.kernel.org,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Artem S. Tashkinov" <aros@gmx.com>
Subject: Re: [Bug 219984] New: [BISECTED] High power usage since 'PCI/ASPM:
 Correct LTR_L1.2_THRESHOLD computation'
Message-ID: <20250408163600.GA238676@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONYan8F-WokoVpX9HpooeMYnHeOa+Wq6EfbketRJH3dZBoY7g@mail.gmail.com>

On Mon, Apr 07, 2025 at 07:33:31PM +0100, Sergey Dolgov wrote:
> Dear Bjorn,
> 
> both attached.

Thank you very much.  Most of the differences are that the
LTR1.2_Threshold values are increased with 7afeb84d14ea ("PCI/ASPM:
Correct LTR_L1.2_THRESHOLD computation"):

  02:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge [Titan Ridge 4C 2018]
    Bus: primary=02, secondary=03, subordinate=6c, sec-latency=0
    Capabilities: [a00 v1] L1 PM Substates
-     T_CommonMode=40us LTR1.2_Threshold=65536ns
+     T_CommonMode=40us LTR1.2_Threshold=90112ns

  6d:00.0 Non-Volatile memory controller: Intel Corporation Optane NVME SSD H10 with Solid State Storage
    Capabilities: [180 v1] L1 PM Substates
-     T_CommonMode=0us LTR1.2_Threshold=3145728ns
+     T_CommonMode=0us LTR1.2_Threshold=3211264ns

  70:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A PCI Express Card Reader
    Capabilities: [160 v1] L1 PM Substates
-     T_CommonMode=0us LTR1.2_Threshold=98304ns
+     T_CommonMode=0us LTR1.2_Threshold=126976ns


In addition, I wonder if there's something wrong with link training
because the 00:1d.0 - 6d:00.0 link claims training is in progress, and
the 00:1d.2 - 6e:00.0 link is only x1 when it should be x2:

  00:1d.0 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root Port #9
      LnkSta: Speed 8GT/s, Width x2
-       TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
+       TrErr- Train+ SlotClk+ DLActive+ BWMgmt- ABWMgmt-

  00:1d.2 PCI bridge: Intel Corporation Cannon Lake PCH PCI Express Root Port #11
-     LnkSta: Speed 8GT/s, Width x2
+     LnkSta: Speed 8GT/s, Width x1


I don't see the problem right off, so could you please add the patch
below and collect the dmesg logs again?

Bjorn


diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 29fcb0689a91..bd9322bde53a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -647,12 +647,19 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
 	val2 = FIELD_GET(PCI_L1SS_CAP_CM_RESTORE_TIME, child_l1ss_cap);
 	t_common_mode = max(val1, val2);
 
+	pci_info(child, "parent CMRT %#04x child CMRT %#04x\n", val1, val2);
+
 	/* Choose the greater of the two Port T_POWER_ON times */
 	val1   = FIELD_GET(PCI_L1SS_CAP_P_PWR_ON_VALUE, parent_l1ss_cap);
 	scale1 = FIELD_GET(PCI_L1SS_CAP_P_PWR_ON_SCALE, parent_l1ss_cap);
 	val2   = FIELD_GET(PCI_L1SS_CAP_P_PWR_ON_VALUE, child_l1ss_cap);
 	scale2 = FIELD_GET(PCI_L1SS_CAP_P_PWR_ON_SCALE, child_l1ss_cap);
 
+	pci_info(child, "parent T_POWER_ON %#04x usec (val %#02x scale %x)\n",
+		 calc_l12_pwron(parent, scale1, val1), val1, scale1);
+	pci_info(child, "child  T_POWER_ON %#04x usec (val %#02x scale %x)\n",
+		 calc_l12_pwron(child, scale2, val2), val2, scale2);
+
 	if (calc_l12_pwron(parent, scale1, val1) >
 	    calc_l12_pwron(child, scale2, val2)) {
 		ctl2 |= FIELD_PREP(PCI_L1SS_CTL2_T_PWR_ON_SCALE, scale1) |
@@ -675,7 +682,11 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
 	 * least 4us.
 	 */
 	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
+	pci_info(child, "t_common_mode %#04x t_power_on %#04x l1_2_threshold %#04x\n",
+		 t_common_mode, t_power_on, l1_2_threshold);
 	encode_l12_threshold(l1_2_threshold, &scale, &value);
+	pci_info(child, "encoded LTR_L1.2_THRESHOLD value %#04x scale %x\n",
+		 value, scale);
 	ctl1 |= FIELD_PREP(PCI_L1SS_CTL1_CM_RESTORE_TIME, t_common_mode) |
 		FIELD_PREP(PCI_L1SS_CTL1_LTR_L12_TH_VALUE, value) |
 		FIELD_PREP(PCI_L1SS_CTL1_LTR_L12_TH_SCALE, scale);
@@ -686,6 +697,11 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
 	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1, &cctl1);
 	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL2, &cctl2);
 
+	pci_info(child, "L1SS_CTL1 %#08x (parent %#08x child %08x)\n",
+		 ctl1, pctl1, cctl1);
+	pci_info(child, "L1SS_CTL2 %#08x (parent %#08x child %08x)\n",
+		 ctl2, pctl2, cctl2);
+
 	if (ctl1 == pctl1 && ctl1 == cctl1 &&
 	    ctl2 == pctl2 && ctl2 == cctl2)
 		return;
@@ -703,14 +719,27 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
 					       PCI_L1SS_CTL1_L1_2_MASK, 0);
 	}
 
+	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, &pctl1);
+	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1, &cctl1);
+	pci_info(child, "L1SS_CTL1 parent %#08x child %#08x (L1.2 disabled)\n",
+		 pctl1, cctl1);
+
 	/* Program T_POWER_ON times in both ports */
 	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, ctl2);
 	pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2, ctl2);
 
+	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, &pctl2);
+	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL2, &cctl2);
+	pci_info(child, "L1SS_CTL2 parent %#08x child %#08x (T_POWER_ON updated)\n",
+		 pctl2, cctl2);
+
 	/* Program Common_Mode_Restore_Time in upstream device */
 	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
 				       PCI_L1SS_CTL1_CM_RESTORE_TIME, ctl1);
 
+	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, &pctl1);
+	pci_info(child, "L1SS_CTL1 parent %#08x (CMRT updated)\n", pctl1);
+
 	/* Program LTR_L1.2_THRESHOLD time in both ports */
 	pci_clear_and_set_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
 				       PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
@@ -721,6 +750,11 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
 				       PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
 				       ctl1);
 
+	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, &pctl1);
+	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1, &cctl1);
+	pci_info(child, "L1SS_CTL1 parent %#08x child %#08x (LTR_L1.2_THRESHOLD updated)\n",
+		 pctl1, cctl1);
+
 	if (pl1_2_enables || cl1_2_enables) {
 		pci_clear_and_set_config_dword(parent,
 					       parent->l1ss + PCI_L1SS_CTL1, 0,
@@ -729,6 +763,11 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
 					       child->l1ss + PCI_L1SS_CTL1, 0,
 					       cl1_2_enables);
 	}
+
+	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, &pctl1);
+	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1, &cctl1);
+	pci_info(child, "L1SS_CTL1 parent %#08x child %#08x (L1.2 restored)\n",
+		 pctl1, cctl1);
 }
 
 static void aspm_l1ss_init(struct pcie_link_state *link)

