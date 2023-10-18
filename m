Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FF77CDFCC
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 16:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345674AbjJRO3h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 10:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345659AbjJRO3T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 10:29:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B828256;
        Wed, 18 Oct 2023 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697638797; x=1729174797;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XjapHZdAAIXb/r8LmmNmC/q9/lNmCHm8wGhPv3dzY2Q=;
  b=JWndZsc0XLQmqFOb5jaJjcDjpUbYzO1Sbe6+yNEC2zniuCyO+LYHL+jI
   I7DRAotzHN+hukxOuuicNWNpmQriutc2rc93/KKmCLCuaHguMeev3w5f/
   EU48s/d5dHlhZfJqblVoSgSBXSo7zIgz/MFkPoyadwR+UNPMzMsdBjGB5
   7h+CIozq6E6dmD6gHPJurt2pllHgWQ1Kexp0x/VbFOLS81uGRo/5DX9d8
   +N8wmD39f1VyRC75Z4wVK7Y2texfOG7vLiCxAg1qlQYeqbdK/a3vLyeU4
   RsWQOLb14lZ3Jzvw+jcqB3r7+WK1dJuRpxrH4/Kg2b1ZLr1uGevyWDiUL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="389898425"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="389898425"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 07:16:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="873034283"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="873034283"
Received: from gruberda-mobl1.ger.corp.intel.com ([10.252.62.52])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 07:16:39 -0700
Date:   Wed, 18 Oct 2023 17:16:36 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 2/7] PCI: dwc: Use FIELD_GET/PREP()
In-Reply-To: <3o4neokfqofk42zrx5t5su72qmdu2x62rq5u2ywfobqyyg23rc@aksd3afajhwr>
Message-ID: <293b90ca-dab1-eef3-e718-c93295442d9@linux.intel.com>
References: <20231018113254.17616-1-ilpo.jarvinen@linux.intel.com> <20231018113254.17616-3-ilpo.jarvinen@linux.intel.com> <3o4neokfqofk42zrx5t5su72qmdu2x62rq5u2ywfobqyyg23rc@aksd3afajhwr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-849054604-1697638602=:2178"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-849054604-1697638602=:2178
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 18 Oct 2023, Serge Semin wrote:

> On Wed, Oct 18, 2023 at 02:32:49PM +0300, Ilpo Järvinen wrote:
> > Convert open-coded variants of PCI field access into FIELD_GET/PREP()
> > to make the code easier to understand.
> > 
> > Add two missing defines into pci_regs.h. Logically, the Max No-Snoop
> > Latency Register is a separate word sized register in the PCIe spec,
> > but the pre-existing LTR defines in pci_regs.h with dword long values
> > seem to consider the registers together (the same goes for the only
> > user). Thus, follow the custom and make the new values also take both
> > word long LTR registers as a joint dword register.
> 
> Nice work. Thanks! Could you also have a look at
> drivers/pci/controller/dwc/pcie-designware.c
> ?
> It contains two open-coded patterns:
> (bar << 8) - FIELD_PREP()
> next_cap_ptr = (reg & 0xff00) >> 8; - FIELD_GET().
> next_cap_ptr = (reg & 0x00ff); - FIELD_GET().
> At least the later two statements concern the generic PCIe capability CSR.

The problem with cap id / next cap is that there are currently no defines 
for them AFAICT, at least not in pci_regs.h. And pci_regs.h defines those 
as different registers so if I'm to add defines from them, I don't know 
which size would be the most appropriate since that 0xff00 goes across 
that register boundary. I've not had time to study the related core code 
yet but I intend to take a look at it to see what's the best course of 
action forward.

-- 
 i.


> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c | 7 ++++---
> >  drivers/pci/controller/dwc/pcie-tegra194.c      | 5 ++---
> >  include/uapi/linux/pci_regs.h                   | 2 ++
> >  3 files changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index f9182f8d552f..20bef1436bfb 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -6,6 +6,7 @@
> >   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> >   */
> >  
> > +#include <linux/bitfield.h>
> >  #include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  
> > @@ -334,7 +335,7 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
> >  	if (!(val & PCI_MSI_FLAGS_ENABLE))
> >  		return -EINVAL;
> >  
> > -	val = (val & PCI_MSI_FLAGS_QSIZE) >> 4;
> > +	val = FIELD_GET(PCI_MSI_FLAGS_QSIZE, val);
> >  
> >  	return val;
> >  }
> > @@ -357,7 +358,7 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  	reg = ep_func->msi_cap + func_offset + PCI_MSI_FLAGS;
> >  	val = dw_pcie_readw_dbi(pci, reg);
> >  	val &= ~PCI_MSI_FLAGS_QMASK;
> > -	val |= (interrupts << 1) & PCI_MSI_FLAGS_QMASK;
> > +	val |= FIELD_PREP(PCI_MSI_FLAGS_QMASK, interrupts);
> >  	dw_pcie_dbi_ro_wr_en(pci);
> >  	dw_pcie_writew_dbi(pci, reg, val);
> >  	dw_pcie_dbi_ro_wr_dis(pci);
> > @@ -584,7 +585,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  
> >  	reg = ep_func->msix_cap + func_offset + PCI_MSIX_TABLE;
> >  	tbl_offset = dw_pcie_readl_dbi(pci, reg);
> > -	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
> > +	bir = FIELD_GET(PCI_MSIX_TABLE_BIR, tbl_offset);
> >  	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
> >  
> >  	msix_tbl = ep->epf_bar[bir]->addr + tbl_offset;
> > diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> > index 248cd9347e8f..12d5ab2f5219 100644
> > --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> > +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> > @@ -126,7 +126,6 @@
> >  
> >  #define APPL_LTR_MSG_1				0xC4
> >  #define LTR_MSG_REQ				BIT(15)
> > -#define LTR_MST_NO_SNOOP_SHIFT			16
> >  
> >  #define APPL_LTR_MSG_2				0xC8
> >  #define APPL_LTR_MSG_2_LTR_MSG_REQ_STATE	BIT(3)
> > @@ -496,8 +495,8 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
> >  		ktime_t timeout;
> >  
> >  		/* 110us for both snoop and no-snoop */
> > -		val = 110 | (2 << PCI_LTR_SCALE_SHIFT) | LTR_MSG_REQ;
> > -		val |= (val << LTR_MST_NO_SNOOP_SHIFT);
> > +		val = 110 | FIELD_PREP(PCI_LTR_SCALE_SHIFT, 2) | LTR_MSG_REQ;
> > +		val |= FIELD_PREP(PCI_LTR_NOSNOOP_VALUE, val);
> >  		appl_writel(pcie, val, APPL_LTR_MSG_1);
> >  
> >  		/* Send LTR upstream */
> > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > index e5f558d96493..495f0ae4ecd5 100644
> > --- a/include/uapi/linux/pci_regs.h
> > +++ b/include/uapi/linux/pci_regs.h
> > @@ -975,6 +975,8 @@
> >  #define  PCI_LTR_VALUE_MASK	0x000003ff
> >  #define  PCI_LTR_SCALE_MASK	0x00001c00
> >  #define  PCI_LTR_SCALE_SHIFT	10
> > +#define  PCI_LTR_NOSNOOP_VALUE	0x03ff0000 /* Max No-Snoop Latency Value */
> > +#define  PCI_LTR_NOSNOOP_SCALE	0x1c000000 /* Scale for Max Value */
> >  #define PCI_EXT_CAP_LTR_SIZEOF	8
> >  
> >  /* Access Control Service */
> > -- 
> > 2.30.2
> > 
> 
--8323329-849054604-1697638602=:2178--
