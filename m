Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398E07D5704
	for <lists+linux-pci@lfdr.de>; Tue, 24 Oct 2023 17:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343956AbjJXP4y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Oct 2023 11:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343963AbjJXP4x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Oct 2023 11:56:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CBED7A;
        Tue, 24 Oct 2023 08:56:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB363C433CB;
        Tue, 24 Oct 2023 15:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698163010;
        bh=r5Sa3tUW2/ACs5PkqUuCw3ezccmcgEsbeiCxzhS4PFA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WvRBAcpH1TFHbhuDbryiydv0Hkm3NYAO14s3oLc5nlfxpatDGN9CPW9ygpmLARYG0
         0nfPpk8obxuzT9GVMn9b7ETsaFBXhL2rG2L5b8qqCSxLp/t/m5GyDEkRRoX9Cdd0ga
         Fnn2CDbno+LXjaWsQXkF+eql6AfrYKb5k5TrtDU1f24h2arM+RqDo/CYGN1n3OA7L7
         1mPmsCgXTCSORYYUI/ADd76TfqdfNuwMxuKR5Pi8FpEwESJF10HsLypnnEFzc1tuma
         2JO6r00oVHdAZ0Xccd9ss/n/vUosMr7OUqSci6cVvMIMrPuDdc4GyBOWz0RU3xkiaz
         tpgO96ewDO/Cw==
Date:   Tue, 24 Oct 2023 10:56:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] PCI: dwc: Use FIELD_GET/PREP()
Message-ID: <20231024155649.GA1655811@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231024110336.26264-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 24, 2023 at 02:03:36PM +0300, Ilpo Järvinen wrote:
> Convert open-coded variants of PCI field access into FIELD_GET/PREP()
> to make the code easier to understand.
> 
> Add two missing defines into pci_regs.h. Logically, the Max No-Snoop
> Latency Register is a separate word sized register in the PCIe spec,
> but the pre-existing LTR defines in pci_regs.h with dword long values
> seem to consider the registers together (the same goes for the only
> user). Thus, follow the custom and make the new values also take both
> word long LTR registers as a joint dword register.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Replaced the previous "PCI: dwc: Use FIELD_GET/PREP()" patch on
pci/field-get, thanks!

Here's the diff from a1a3a781d0ba (the previous head of pci/field-get)
to the current head:

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 12d5ab2f5219..f2a515b639ab 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -126,6 +126,7 @@
 
 #define APPL_LTR_MSG_1				0xC4
 #define LTR_MSG_REQ				BIT(15)
+#define LTR_NOSNOOP_MSG_REQ			BIT(31)
 
 #define APPL_LTR_MSG_2				0xC8
 #define APPL_LTR_MSG_2_LTR_MSG_REQ_STATE	BIT(3)
@@ -495,8 +496,12 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 		ktime_t timeout;
 
 		/* 110us for both snoop and no-snoop */
-		val = 110 | FIELD_PREP(PCI_LTR_SCALE_SHIFT, 2) | LTR_MSG_REQ;
-		val |= FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, val);
+		val = FIELD_PREP(PCI_LTR_VALUE_MASK, 110) |
+		      FIELD_PREP(PCI_LTR_SCALE_MASK, 2) |
+		      LTR_MSG_REQ |
+		      FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, 110) |
+		      FIELD_PREP(PCI_LTR_NOSNOOP_SCALE, 2) |
+		      LTR_NOSNOOP_MSG_REQ;
 		appl_writel(pcie, val, APPL_LTR_MSG_1);
 
 		/* Send LTR upstream */

> ---
> 
> This patch REPLACES the previous patch which caused the build fail on
> arm and also failed to copy the entire value into nosnoop register
> like the original code did.
> 
> v2:
> - Correct define name used in FIELD_PREP()
> - Correctly copy the contents of the full register, not just the
>   Max Latency Value field.
> - Wrap also the 110 literal into FIELD_PREP()
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c |  7 ++++---
>  drivers/pci/controller/dwc/pcie-tegra194.c      | 10 +++++++---
>  include/uapi/linux/pci_regs.h                   |  2 ++
>  3 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f9182f8d552f..20bef1436bfb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -6,6 +6,7 @@
>   * Author: Kishon Vijay Abraham I <kishon@ti.com>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  
> @@ -334,7 +335,7 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
>  	if (!(val & PCI_MSI_FLAGS_ENABLE))
>  		return -EINVAL;
>  
> -	val = (val & PCI_MSI_FLAGS_QSIZE) >> 4;
> +	val = FIELD_GET(PCI_MSI_FLAGS_QSIZE, val);
>  
>  	return val;
>  }
> @@ -357,7 +358,7 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	reg = ep_func->msi_cap + func_offset + PCI_MSI_FLAGS;
>  	val = dw_pcie_readw_dbi(pci, reg);
>  	val &= ~PCI_MSI_FLAGS_QMASK;
> -	val |= (interrupts << 1) & PCI_MSI_FLAGS_QMASK;
> +	val |= FIELD_PREP(PCI_MSI_FLAGS_QMASK, interrupts);
>  	dw_pcie_dbi_ro_wr_en(pci);
>  	dw_pcie_writew_dbi(pci, reg, val);
>  	dw_pcie_dbi_ro_wr_dis(pci);
> @@ -584,7 +585,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  	reg = ep_func->msix_cap + func_offset + PCI_MSIX_TABLE;
>  	tbl_offset = dw_pcie_readl_dbi(pci, reg);
> -	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
> +	bir = FIELD_GET(PCI_MSIX_TABLE_BIR, tbl_offset);
>  	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
>  
>  	msix_tbl = ep->epf_bar[bir]->addr + tbl_offset;
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 248cd9347e8f..f2a515b639ab 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -126,7 +126,7 @@
>  
>  #define APPL_LTR_MSG_1				0xC4
>  #define LTR_MSG_REQ				BIT(15)
> -#define LTR_MST_NO_SNOOP_SHIFT			16
> +#define LTR_NOSNOOP_MSG_REQ			BIT(31)
>  
>  #define APPL_LTR_MSG_2				0xC8
>  #define APPL_LTR_MSG_2_LTR_MSG_REQ_STATE	BIT(3)
> @@ -496,8 +496,12 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
>  		ktime_t timeout;
>  
>  		/* 110us for both snoop and no-snoop */
> -		val = 110 | (2 << PCI_LTR_SCALE_SHIFT) | LTR_MSG_REQ;
> -		val |= (val << LTR_MST_NO_SNOOP_SHIFT);
> +		val = FIELD_PREP(PCI_LTR_VALUE_MASK, 110) |
> +		      FIELD_PREP(PCI_LTR_SCALE_MASK, 2) |
> +		      LTR_MSG_REQ |
> +		      FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, 110) |
> +		      FIELD_PREP(PCI_LTR_NOSNOOP_SCALE, 2) |
> +		      LTR_NOSNOOP_MSG_REQ;
>  		appl_writel(pcie, val, APPL_LTR_MSG_1);
>  
>  		/* Send LTR upstream */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index e5f558d96493..495f0ae4ecd5 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -975,6 +975,8 @@
>  #define  PCI_LTR_VALUE_MASK	0x000003ff
>  #define  PCI_LTR_SCALE_MASK	0x00001c00
>  #define  PCI_LTR_SCALE_SHIFT	10
> +#define  PCI_LTR_NOSNOOP_VALUE	0x03ff0000 /* Max No-Snoop Latency Value */
> +#define  PCI_LTR_NOSNOOP_SCALE	0x1c000000 /* Scale for Max Value */
>  #define PCI_EXT_CAP_LTR_SIZEOF	8
>  
>  /* Access Control Service */
> -- 
> 2.30.2
> 
