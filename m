Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D2D2ED6E0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 19:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbhAGSot (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 13:44:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbhAGSot (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 13:44:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D566233CE;
        Thu,  7 Jan 2021 18:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610045048;
        bh=TUvWD6mNsKBSzVYyTWlbLFY73PiTiMp2lBOWR6edq/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ctLT+flodW3Vqt+tqCSLAvA2CQosG++HuVdsMBMlW92ezEORXE2b7N1OVfYNma3G1
         fQ8zspUJlG1s9mnnxhJChMr9DIYTS70mPlXPJzDrg+veBa171WUrlquUEYppI2GWN/
         EJrj8EEGoYpaiqFRalTrhSgaqBTPvEBvtwluivFzN061ha/tJTxNHTt7HcJQDoQ8uF
         tRyHBbd8uPGgXusZYStpyrf10fVUvmMGhIILjZuLiR3sF/e2cg98BwTa4+GUfo1nmI
         8isOUkNb3fbdvwELj+7iI+cOaGVaLBOEzmz0sVHW8k3esuDjo5CpReNyqL/d+IgnJO
         fGkfi86qOfcRw==
Date:   Thu, 7 Jan 2021 12:44:06 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shradha Todi <shradha.t@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, pankaj.dubey@samsung.com,
        sriram.dash@samsung.com, niyas.ahmed@samsung.com,
        p.rajanbabu@samsung.com, l.mehra@samsung.com, hari.tv@samsung.com,
        Anvesh Salveru <anvesh.salveru@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 2/5] PCI: dwc: add support to handle ZRX-DC Compliant
 PHYs
Message-ID: <20210107184406.GA1372915@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610033323-10560-3-git-send-email-shradha.t@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Capitalize subject to match the rest of the series.

"Add support to handle .." is redundant; "Add support for ..." would
be equivalent and shorter.

But this patch actually doesn't add anything at all by itself, since
it checks pci->phy_zrxdc_compliant but never sets it.

On Thu, Jan 07, 2021 at 08:58:40PM +0530, Shradha Todi wrote:
> From: Pankaj Dubey <pankaj.dubey@samsung.com>
> 
> Many platforms use DesignWare controller but the PHY can be different in
> different platforms. If the PHY is compliant is to ZRX-DC specification it
> helps in low power consumption during power states.

s/is to/to/

Even with that, this sentence doesn't quite parse correctly.  Do you
mean something like this?

  If the PHY is compliant to the ZRX-DC specification, it reduces
  power consumption in low power Link states.

(I assume this is related to Link power states (L0, L1, etc), not
device power states (D0, D3hot, etc)).

> If current data rate is 8.0 GT/s or higher and PHY is not compliant to
> ZRX-DC specification, then after every 100ms link should transition to
> recovery state during the low power states.

Not sure this makes sense.  If the Link is in a low power state for 10
seconds, it must transition to the Recovery state every 100ms during
that 10 seconds, i.e., 100 times?

> DesignWare controller provides GEN3_ZRXDC_NONCOMPL field in
> GEN3_RELATED_OFF to specify about ZRX-DC compliant PHY.
> 
> Platforms with ZRX-DC compliant PHY can set phy_zrxdc_compliant variable to
> specify this property to the controller.

If this is a DesignWare-generic register and the "phy-zrxdc-compliant"
property can be used by any DesignWare-based driver, why isn't the
code to look for it in the DesignWare-generic part?

Is there a link to the ZRX-DC specification you can mention somewhere
in this series?

> Signed-off-by: Anvesh Salveru <anvesh.salveru@gmail.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 6 ++++++
>  drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 645fa18..74590c7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -722,4 +722,10 @@ void dw_pcie_setup(struct dw_pcie *pci)
>  		       PCIE_PL_CHK_REG_CHK_REG_START;
>  		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
>  	}
> +
> +	if (pci->phy_zrxdc_compliant) {
> +		val = dw_pcie_readl_dbi(pci, PCIE_PORT_GEN3_RELATED);
> +		val &= ~PORT_LOGIC_GEN3_ZRXDC_NONCOMPL;
> +		dw_pcie_writel_dbi(pci, PCIE_PORT_GEN3_RELATED, val);
> +	}
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 0207840..8b905a2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -74,6 +74,9 @@
>  #define PCIE_MSI_INTR0_MASK		0x82C
>  #define PCIE_MSI_INTR0_STATUS		0x830
>  
> +#define PCIE_PORT_GEN3_RELATED		0x890
> +#define PORT_LOGIC_GEN3_ZRXDC_NONCOMPL	BIT(0)
> +
>  #define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
>  #define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
>  
> @@ -273,6 +276,7 @@ struct dw_pcie {
>  	u8			n_fts[2];
>  	bool			iatu_unroll_enabled: 1;
>  	bool			io_cfg_atu_shared: 1;
> +	bool			phy_zrxdc_compliant;

I raise my eyebrows a little at "bool xx : 1".  I think it's probably
*correct*, but "unsigned int xx : 1" is the overwhelming favorite and
I doubt bool gives any advantage.

  $ git grep -E "int\s+\S+\s*:\s*1" | egrep "^\S*\.[ch]" | wc -l
  3129
  $ git grep -E "bool\s+\S+\s*:\s*1" | egrep "^\S*\.[ch]" | wc -l
  637

pcie-designware.h is the only user in drivers/pci.  But you're
following the existing style in the file, which is good.

>  };
>  
>  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> -- 
> 2.7.4
> 
