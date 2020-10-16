Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39FA290CF8
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 22:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391662AbgJPU7F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Oct 2020 16:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409663AbgJPU7F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Oct 2020 16:59:05 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F188C205CB;
        Fri, 16 Oct 2020 20:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602881944;
        bh=F4FI3M6mItVNvniJE2pyrbO0nTzbZGlLkoouiOrBsFo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UcdqvLrtol1n3v0Kv7X4zZkTm2jxN8DMm0ifnuKFFD6SGkWKnnTq5B10eNR5b6xF8
         KILcQVyk1Wa0PkQwz7WlLbJkk9rW4kVVd1YigpX5iPpKTbDXDBTbB98FkjWzMvnFrz
         qMpAnVErKk0s3wSchujSF9lNH1W6aPxCYzNiZmek=
Date:   Fri, 16 Oct 2020 15:59:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O . Bolarinwa" <refactormyself@gmail.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 12/12] PCI/ASPM: Remove struct pcie_link_state.l1ss
Message-ID: <20201016205902.GA107669@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015193039.12585-13-helgaas@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 15, 2020 at 02:30:39PM -0500, Bjorn Helgaas wrote:
> From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
> 
> Previously we computed L1.2 parameters in the enumeration path, saved them
> in struct pcie_link_state.l1ss, and programmed them into the devices
> whenever we enabled or disabled L1.2 on the link.  But these parameters are
> constant and don't need to be updated when enabling/disabling L1.2.
> 
> Compute and program the L1.2 parameters once during enumeration and remove
> the struct pcie_link_state.l1ss member.  No functional change intended.
> 
> [bhelgaas: rework to program L1.2 parameters during enumeration]
> Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aspm.c | 55 +++++++++++++++--------------------------
>  1 file changed, 20 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index d76f23908d67..361eaa0c615d 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -74,12 +74,6 @@ struct pcie_link_state {
>  	 * has one slot under it, so at most there are 8 functions.
>  	 */
>  	struct aspm_latency acceptable[8];
> -
> -	/* L1 PM Substate info */
> -	struct {
> -		u32 ctl1;		/* value to be programmed in ctl1 */
> -		u32 ctl2;		/* value to be programmed in ctl2 */
> -	} l1ss;
>  };
>  
>  static int aspm_disabled, aspm_force;
> @@ -461,8 +455,7 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  	struct pci_dev *child = link->downstream, *parent = link->pdev;
>  	u32 val1, val2, scale1, scale2;
>  	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
> -
> -	link->l1ss.ctl1 = link->l1ss.ctl2 = 0;
> +	u32 ctl1 = 0, ctl2 = 0;
>  
>  	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
>  		return;
> @@ -480,10 +473,10 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  
>  	if (calc_l1ss_pwron(parent, scale1, val1) >
>  	    calc_l1ss_pwron(child, scale2, val2)) {
> -		link->l1ss.ctl2 |= scale1 | (val1 << 3);
> +		ctl2 |= scale1 | (val1 << 3);
>  		t_power_on = calc_l1ss_pwron(parent, scale1, val1);
>  	} else {
> -		link->l1ss.ctl2 |= scale2 | (val2 << 3);
> +		ctl2 |= scale2 | (val2 << 3);
>  		t_power_on = calc_l1ss_pwron(child, scale2, val2);
>  	}
>  
> @@ -499,7 +492,23 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  	 */
>  	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
>  	encode_l12_threshold(l1_2_threshold, &scale, &value);
> -	link->l1ss.ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
> +	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
> +
> +	/* Program T_POWER_ON times in both ports */
> +	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, ctl2);
> +	pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2, ctl2);
> +
> +	/* Program Common_Mode_Restore_Time in upstream device */
> +	pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
> +				PCI_L1SS_CTL1_CM_RESTORE_TIME, ctl1);
> +
> +	/* Program LTR_L1.2_THRESHOLD time in both ports */
> +	pci_clear_and_set_dword(parent,	parent->l1ss + PCI_L1SS_CTL1,
> +				PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> +				PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
> +	pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
> +				PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> +				PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);

I think this is slightly problematic because L1.2 must be disabled
while updating T_POWER_ON, Common_Mode_Restore_Time, and
LTR_L1.2_THRESHOLD.  Updated patch to address this attached below.

>  }
>  
>  static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
> @@ -679,30 +688,6 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
>  						   PCI_EXP_LNKCTL_ASPM_L1, 0);
>  	}
>  
> -	if (enable_req & ASPM_STATE_L1_2_MASK) {
> -
> -		/* Program T_POWER_ON times in both ports */
> -		pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2,
> -				       link->l1ss.ctl2);
> -		pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2,
> -				       link->l1ss.ctl2);
> -
> -		/* Program Common_Mode_Restore_Time in upstream device */
> -		pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
> -					PCI_L1SS_CTL1_CM_RESTORE_TIME,
> -					link->l1ss.ctl1);
> -
> -		/* Program LTR_L1.2_THRESHOLD time in both ports */
> -		pci_clear_and_set_dword(parent,	parent->l1ss + PCI_L1SS_CTL1,
> -					PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> -					PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
> -					link->l1ss.ctl1);
> -		pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
> -					PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
> -					PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
> -					link->l1ss.ctl1);
> -	}
> -
>  	val = 0;
>  	if (state & ASPM_STATE_L1_1)
>  		val |= PCI_L1SS_CTL1_ASPM_L1_1;
> -- 
> 2.25.1
> 

commit df8f10587d3d ("PCI/ASPM: Remove struct pcie_link_state.l1ss")
Author: Saheed O. Bolarinwa <refactormyself@gmail.com>
Date:   Thu Oct 15 14:30:39 2020 -0500

    PCI/ASPM: Remove struct pcie_link_state.l1ss
    
    Previously we computed L1.2 parameters in the enumeration path, saved them
    in struct pcie_link_state.l1ss, and programmed them into the devices
    whenever we enabled or disabled L1.2 on the link.  But these parameters are
    constant and don't need to be updated when enabling/disabling L1.2.
    
    Compute and program the L1.2 parameters once during enumeration and remove
    the struct pcie_link_state.l1ss member.  No functional change intended.
    
    [bhelgaas: rework to program L1.2 parameters during enumeration]
    Link: https://lore.kernel.org/r/20201015193039.12585-13-helgaas@kernel.org
    Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index d76f23908d67..ac0557a305af 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -74,12 +74,6 @@ struct pcie_link_state {
 	 * has one slot under it, so at most there are 8 functions.
 	 */
 	struct aspm_latency acceptable[8];
-
-	/* L1 PM Substate info */
-	struct {
-		u32 ctl1;		/* value to be programmed in ctl1 */
-		u32 ctl2;		/* value to be programmed in ctl2 */
-	} l1ss;
 };
 
 static int aspm_disabled, aspm_force;
@@ -461,8 +455,9 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	struct pci_dev *child = link->downstream, *parent = link->pdev;
 	u32 val1, val2, scale1, scale2;
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
-
-	link->l1ss.ctl1 = link->l1ss.ctl2 = 0;
+	u32 ctl1 = 0, ctl2 = 0;
+	u32 pctl1, pctl2, cctl1, cctl2;
+	u32 pl1_2_enables, cl1_2_enables;
 
 	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
 		return;
@@ -480,10 +475,10 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 
 	if (calc_l1ss_pwron(parent, scale1, val1) >
 	    calc_l1ss_pwron(child, scale2, val2)) {
-		link->l1ss.ctl2 |= scale1 | (val1 << 3);
+		ctl2 |= scale1 | (val1 << 3);
 		t_power_on = calc_l1ss_pwron(parent, scale1, val1);
 	} else {
-		link->l1ss.ctl2 |= scale2 | (val2 << 3);
+		ctl2 |= scale2 | (val2 << 3);
 		t_power_on = calc_l1ss_pwron(child, scale2, val2);
 	}
 
@@ -499,7 +494,50 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	 */
 	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
 	encode_l12_threshold(l1_2_threshold, &scale, &value);
-	link->l1ss.ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
+	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
+
+	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, &pctl1);
+	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, &pctl2);
+	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL1, &cctl1);
+	pci_read_config_dword(child, child->l1ss + PCI_L1SS_CTL2, &cctl2);
+
+	if (ctl1 == pctl1 && ctl1 == cctl1 &&
+	    ctl2 == pctl2 && ctl2 == cctl2)
+		return;
+
+	/* Disable L1.2 while updating.  See PCIe r5.0, sec 5.5.4, 7.8.3.3 */
+	pl1_2_enables = pctl1 & PCI_L1SS_CTL1_L1_2_MASK;
+	cl1_2_enables = cctl1 & PCI_L1SS_CTL1_L1_2_MASK;
+
+	if (pl1_2_enables || cl1_2_enables) {
+		pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
+					PCI_L1SS_CTL1_L1_2_MASK, 0);
+		pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+					PCI_L1SS_CTL1_L1_2_MASK, 0);
+	}
+
+	/* Program T_POWER_ON times in both ports */
+	pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2, ctl2);
+	pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2, ctl2);
+
+	/* Program Common_Mode_Restore_Time in upstream device */
+	pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
+				PCI_L1SS_CTL1_CM_RESTORE_TIME, ctl1);
+
+	/* Program LTR_L1.2_THRESHOLD time in both ports */
+	pci_clear_and_set_dword(parent,	parent->l1ss + PCI_L1SS_CTL1,
+				PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+				PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
+	pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
+				PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
+				PCI_L1SS_CTL1_LTR_L12_TH_SCALE, ctl1);
+
+	if (pl1_2_enables || cl1_2_enables) {
+		pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1, 0,
+					pl1_2_enables);
+		pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1, 0,
+					cl1_2_enables);
+	}
 }
 
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
@@ -679,30 +717,6 @@ static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 						   PCI_EXP_LNKCTL_ASPM_L1, 0);
 	}
 
-	if (enable_req & ASPM_STATE_L1_2_MASK) {
-
-		/* Program T_POWER_ON times in both ports */
-		pci_write_config_dword(parent, parent->l1ss + PCI_L1SS_CTL2,
-				       link->l1ss.ctl2);
-		pci_write_config_dword(child, child->l1ss + PCI_L1SS_CTL2,
-				       link->l1ss.ctl2);
-
-		/* Program Common_Mode_Restore_Time in upstream device */
-		pci_clear_and_set_dword(parent, parent->l1ss + PCI_L1SS_CTL1,
-					PCI_L1SS_CTL1_CM_RESTORE_TIME,
-					link->l1ss.ctl1);
-
-		/* Program LTR_L1.2_THRESHOLD time in both ports */
-		pci_clear_and_set_dword(parent,	parent->l1ss + PCI_L1SS_CTL1,
-					PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-					PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
-					link->l1ss.ctl1);
-		pci_clear_and_set_dword(child, child->l1ss + PCI_L1SS_CTL1,
-					PCI_L1SS_CTL1_LTR_L12_TH_VALUE |
-					PCI_L1SS_CTL1_LTR_L12_TH_SCALE,
-					link->l1ss.ctl1);
-	}
-
 	val = 0;
 	if (state & ASPM_STATE_L1_1)
 		val |= PCI_L1SS_CTL1_ASPM_L1_1;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 06846ec2e071..c7e0acba0e20 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1058,6 +1058,7 @@
 #define  PCI_L1SS_CTL1_PCIPM_L1_1	0x00000002  /* PCI-PM L1.1 Enable */
 #define  PCI_L1SS_CTL1_ASPM_L1_2	0x00000004  /* ASPM L1.2 Enable */
 #define  PCI_L1SS_CTL1_ASPM_L1_1	0x00000008  /* ASPM L1.1 Enable */
+#define  PCI_L1SS_CTL1_L1_2_MASK	0x00000005
 #define  PCI_L1SS_CTL1_L1SS_MASK	0x0000000f
 #define  PCI_L1SS_CTL1_CM_RESTORE_TIME	0x0000ff00  /* Common_Mode_Restore_Time */
 #define  PCI_L1SS_CTL1_LTR_L12_TH_VALUE	0x03ff0000  /* LTR_L1.2_THRESHOLD_Value */
