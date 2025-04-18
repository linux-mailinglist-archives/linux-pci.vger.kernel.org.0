Return-Path: <linux-pci+bounces-26257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 875E1A94012
	for <lists+linux-pci@lfdr.de>; Sat, 19 Apr 2025 00:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F067A64C5
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 22:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F488253351;
	Fri, 18 Apr 2025 22:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spxIQW0X"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A672417E6
	for <linux-pci@vger.kernel.org>; Fri, 18 Apr 2025 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745016929; cv=none; b=AsGaZHUc1EkgO1ocOfrcoqT6cHdmL3e0bb/m9MrLLmpYE1IPku06jt/hZPJAeUmUu4/h531Ud5SaJuAE2H5Bj6q/wwgnbEeDN4UDsogCMEDrUTZ/pGxHuD9io7s7+qGT/pDysD6HukY/mkV950lOz9nJnGDYcge612p8A1tGPp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745016929; c=relaxed/simple;
	bh=GpHpgTBprt4uTvLPkdbmgD+6g7nL03U15xObvhb5x+M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uxfWGd1rxBsyVWHznn6x/ISJlK3cJmXZaFmGlYH7HoWVCGWvRozeuUqSqk3fOlaTfzvSTHyWU7uKNX2LoYRuV9dvmnwP1aSKB8Xsj8bDh80EPf7m5cBhieIkHCubCNMhu5ZzF0/s+GzPf0IdO/xgYXO5cxKApyIqDDSKoQ9Kmp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spxIQW0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E905C4CEE2;
	Fri, 18 Apr 2025 22:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745016928;
	bh=GpHpgTBprt4uTvLPkdbmgD+6g7nL03U15xObvhb5x+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=spxIQW0XCfi3ImubYjbiFLX6XMjV0RnkFwpa579zl/Wdqq+PrOaY87bMVyZVZZJqL
	 aZZZzbY/DdacucVxZuyHQFLAYgLy8C0I8lLn9LoxhIQQbXlOX9UhlqGVDBjqwEbSPt
	 PR6cYMdVsS6jQtJDYju7bl0dRO3YHd9VMP/+zoWyH71hkwx28num4E3xth/qDMf6O0
	 4M7hAPDtiXXzsHeo1/z4QUOUjPkqQI8uoBO/votAYcPRL58SkhLUY/E4zulCxqLA9g
	 SEkbGPqB0kZ1hPIrZtTJVR0ahZ1xnMRaDfDSXNGgGBkeMud6pKmBp8Upkcs7SQzbqa
	 oAy6QtzE/7H2g==
Date: Fri, 18 Apr 2025 17:55:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Dolgov <sergey.v.dolgov@gmail.com>
Cc: linux-pci@vger.kernel.org,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Artem S. Tashkinov" <aros@gmx.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"David E. Box" <david.e.box@linux.intel.com>
Subject: Re: [Bug 219984] New: [BISECTED] High power usage since 'PCI/ASPM:
 Correct LTR_L1.2_THRESHOLD computation'
Message-ID: <20250418225527.GA169820@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONYan-M5KxdHCdsY2+J-VVQXh_9ukQyRy84ZrneBtTLtXH-rg@mail.gmail.com>

On Sun, Apr 13, 2025 at 12:59:07PM +0100, Sergey Dolgov wrote:
> Dear Bjorn,
> 
> I've compiled pciutils-3.13.0 with MinGW and run it with WinDBG, and
> it managed to display how Windows sets LTR1.2_Threshold. The trick is
> that it does NOT! I've removed all the actual reprogramming in
> aspm_calc_l12_info to see the devices' default thresholds, and they've
> come out exactly the same as in Windows (81920ns for all devices
> except 0 for NVIDIA, but it should have its own dynamic power
> management). I've collected these logs also after booting the original
> 6.14.0 kernel to make sure the devices haven't just kept the values
> set by Windows - nope, the devices (or maybe BIOS/Firmware) do reset
> LTR_L1.2_THRESHOLD to 81920ns every reboot.
> 
> I tried to read latencies from PCI_EXT_CAP_ID_LTR (see the new
> function pcie_log_runtime_ltr in l12debug.patch), but it bails out at
> "No LTR capability found" for all devices.
> 
> The idle power usage has increased slightly to 0.916 W due to about
> 80% PC10 residency and 60-70% SYS%LPI residency (in contrast to 90%+
> PC10 and 80%+ SYS%LPI with pre 7afeb84d14ea thresholds), but that's
> still much more power efficient than the mainline kernel.
> 
> So the question is why the OS has to reprogram T_POWER_ON, CMRT and
> LTR_L1.2_THRESHOLD at all, instead of trusting the device defaults? Is
> there any statistics on broken devices reporting bogus values, and
> frequently running out of buffer?

Great question.  I think you're right that if the BIOS has programmed
L1.2 settings, it's very unlikely that the OS can do a better job.

This is really ugly, but since I won't have more time for this until
Monday, could you try the patch below?  (Replace the previous debug
patch with this one)


diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 29fcb0689a91..e6e9d6faa028 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -563,6 +563,27 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
 	}
 }
 
+static u64 decode_l12_threshold(u32 scale, u32 value)
+{
+	u32 mpy;
+
+	/*
+	 * LTR_L1.2_THRESHOLD_Value ("value") is a 10-bit field with max
+	 * value of 0x3ff.
+	 */
+	switch (scale) {
+	case 0: mpy = 1; break;
+	case 1: mpy = 32; break;
+	case 2: mpy = 1024; break;
+	case 3: mpy = 32768; break;
+	case 4: mpy = 1048576; break;
+	case 5: mpy = 33554432; break;
+	default: mpy = 0;
+	}
+
+	return (u64) value * mpy;
+}
+
 static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 {
 	u32 latency, encoding, lnkcap_up, lnkcap_dw;
@@ -641,18 +662,29 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
 	u32 ctl1 = 0, ctl2 = 0;
 	u32 pctl1, pctl2, cctl1, cctl2;
 	u32 pl1_2_enables, cl1_2_enables;
+	u32 cmrt;
+	u32 p_ltr_val, p_ltr_scale;
+	u32 c_ltr_val, c_ltr_scale;
+	u64 p_ltr_threshold, c_ltr_threshold;
 
 	/* Choose the greater of the two Port Common_Mode_Restore_Times */
 	val1 = FIELD_GET(PCI_L1SS_CAP_CM_RESTORE_TIME, parent_l1ss_cap);
 	val2 = FIELD_GET(PCI_L1SS_CAP_CM_RESTORE_TIME, child_l1ss_cap);
 	t_common_mode = max(val1, val2);
 
+	pci_info(child, "cap: parent CMRT %#04x child CMRT %#04x\n", val1, val2);
+
 	/* Choose the greater of the two Port T_POWER_ON times */
 	val1   = FIELD_GET(PCI_L1SS_CAP_P_PWR_ON_VALUE, parent_l1ss_cap);
 	scale1 = FIELD_GET(PCI_L1SS_CAP_P_PWR_ON_SCALE, parent_l1ss_cap);
 	val2   = FIELD_GET(PCI_L1SS_CAP_P_PWR_ON_VALUE, child_l1ss_cap);
 	scale2 = FIELD_GET(PCI_L1SS_CAP_P_PWR_ON_SCALE, child_l1ss_cap);
 
+	pci_info(child, "cap: parent T_POWER_ON %#06x usec (val %#04x scale %x)\n",
+		 calc_l12_pwron(parent, scale1, val1), val1, scale1);
+	pci_info(child, "cap: child  T_POWER_ON %#06x usec (val %#04x scale %x)\n",
+		 calc_l12_pwron(child, scale2, val2), val2, scale2);
+
 	if (calc_l12_pwron(parent, scale1, val1) >
 	    calc_l12_pwron(child, scale2, val2)) {
 		ctl2 |= FIELD_PREP(PCI_L1SS_CTL2_T_PWR_ON_SCALE, scale1) |
@@ -675,7 +707,11 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
 	 * least 4us.
 	 */
 	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
+	pci_info(child, "t_common_mode %#04x t_power_on %#04x l1_2_threshold %#06x\n",
+		 t_common_mode, t_power_on, l1_2_threshold);
 	encode_l12_threshold(l1_2_threshold, &scale, &value);
+	pci_info(child, "encoded LTR_L1.2_THRESHOLD value %#06x scale %x\n",
+		 value, scale);
 	ctl1 |= FIELD_PREP(PCI_L1SS_CTL1_CM_RESTORE_TIME, t_common_mode) |
 		FIELD_PREP(PCI_L1SS_CTL1_LTR_L12_TH_VALUE, value) |
 		FIELD_PREP(PCI_L1SS_CTL1_LTR_L12_TH_SCALE, scale);
@@ -686,6 +722,28 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
 	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1, &cctl1);
 	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL2, &cctl2);
 
+	pci_info(child, "L1SS_CTL1 %#08x (parent %#010x child %#010x)\n",
+		 ctl1, pctl1, cctl1);
+	pci_info(child, "L1SS_CTL2 %#08x (parent %#010x child %#010x)\n",
+		 ctl2, pctl2, cctl2);
+
+	cmrt = FIELD_GET(PCI_L1SS_CTL1_CM_RESTORE_TIME, pctl1);
+	p_ltr_val = FIELD_GET(PCI_L1SS_CTL1_LTR_L12_TH_VALUE, pctl1);
+	p_ltr_scale = FIELD_GET(PCI_L1SS_CTL1_LTR_L12_TH_SCALE, pctl1);
+	p_ltr_threshold = decode_l12_threshold(p_ltr_scale, p_ltr_val);
+	c_ltr_val = FIELD_GET(PCI_L1SS_CTL1_LTR_L12_TH_VALUE, cctl1);
+	c_ltr_scale = FIELD_GET(PCI_L1SS_CTL1_LTR_L12_TH_SCALE, cctl1);
+	c_ltr_threshold = decode_l12_threshold(c_ltr_scale, c_ltr_val);
+	if (cmrt || p_ltr_threshold || c_ltr_threshold) {
+		pci_info(child, "cur: parent CMRT %d usec\n", cmrt);
+		pci_info(child, "cur: parent LTR_L1.2_THRESHOLD value %#06x scale %x decoded %#012llx ns\n",
+			 p_ltr_val, p_ltr_scale, p_ltr_threshold);
+		pci_info(child, "cur: child  LTR_L1.2_THRESHOLD value %#06x scale %x decoded %#012llx ns\n",
+			 c_ltr_val, c_ltr_scale, c_ltr_threshold);
+		pci_info(child, "skipping L1.2 config\n");
+		return;
+	}
+
 	if (ctl1 == pctl1 && ctl1 == cctl1 &&
 	    ctl2 == pctl2 && ctl2 == cctl2)
 		return;
@@ -703,14 +761,27 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
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
@@ -721,6 +792,11 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
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
@@ -729,6 +805,11 @@ static void aspm_calc_l12_info(struct pcie_link_state *link,
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

