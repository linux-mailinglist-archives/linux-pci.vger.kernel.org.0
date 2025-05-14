Return-Path: <linux-pci+bounces-27745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59CDAB7189
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 18:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD1416FFF1
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 16:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14AB1DF990;
	Wed, 14 May 2025 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fn4THqlg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722A427A112
	for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240507; cv=none; b=Jt8HIsho+aIP5pLU3SIhQlX+WTcvWhAFXWtlfZMwwnxH2P2B9T8q73Za2m5s2RSUIUVfdcm+wIMakjv9q5/Wg75gXiMq5nPOvcC9qzU+neVmfy+zrAXYxUWDVK0Vv0vzW2FEiL+QH2Ll6Sd2MtGFuqbazd8hwTmzx8gVEJbvGeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240507; c=relaxed/simple;
	bh=jMqaj7CoSlKge6w9ihSGG6969e9NHdD3WrG9K31ZQaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwmHqShCbcxD3fSq1B3oYdSkZzgujv0xNm4xyUSTNTaCk5CCFblcIAckl5J0KiqvZMxyrinkBKQYkNBTNyy5Y1rbpD7waIybXq399z0nzXefABwoz2BvewkWrmoUrJs81tuCoKmMr6IfUk/eOkZtUrZFza1XOkyA5Xl/61gaaQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fn4THqlg; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a0b135d18eso4056729f8f.2
        for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747240503; x=1747845303; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AOckZ8P9OykpU46zTLvu6zDFwY48KuX591SKzhfoGSE=;
        b=fn4THqlgGxgP9fH1cN0T9bNgMhxYOQCUJLm30Ny3R86vjZ8FK7iHDoqR6jF+/Z4xSU
         5YCSvxlVxMvDYdu19y6owG6phma5ZbzM8wH7ebQy/3RszIvu4IUP2CcFlKimxUyMgKfO
         pAxpZl5KnF4Nivt8JaxFkTb27DiHng+W6VF4rkatMhaLid7BJnr9mHlXp9HoY8NInTgd
         +0BgHeWu7S6+/IUWVOpZ4bsEVSr2EhL1OR+Rf98Oe8aq/C6WlOirftc32yRXHO1DZetO
         8u4CjdC2LtgLAsl7Y7W/BQCbArWUPwQ+q/rSO4MCp/zLGJDa7XD/6BOgTfPkyc9Z7YUf
         1Y1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747240503; x=1747845303;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOckZ8P9OykpU46zTLvu6zDFwY48KuX591SKzhfoGSE=;
        b=Xk3l3mEASxWmObgt4w8Bm8jJ2OhEaaxomF4WnKE/sZoiFAc6ttBnXIBt6yw48Y/CfF
         TuiZDuINg/6iBJrt0XV/Qv6rw529ApV/Q8d5Wn0oz8wGeUMTUObHY2X0EIPOuETLexmN
         Kt1FnNE5WyDhJjwYqPZOsg79gAA6O3s3FjtK2imSAteZyRBswDQQaFSnIQihv+4gGYFO
         eSfbwhLit7fgqeDCuJbHpup9p2DDdAEdH2WGayw4KXj3Zq0wiiAJL2tpzWr3YSeYAnVj
         zn7LFl8mughRe7BcX4nCE7WvO2KTDfpjc9CmxABu0+qhgpz/zejVep6DcV/zViopv0/A
         Om2w==
X-Forwarded-Encrypted: i=1; AJvYcCWJ2kFTQTlkw9aJwDzuo1Aj1aQqlnPC1j7T9zx9418c99+i2fY/08zRcL8WIPmunSzPU4Qu3LG6ZBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+/2k2zOqN8Eyh+yt/CfpZYFPgCPEinSpkYcZeZFL9jZr2ZyS1
	/CmM103/jx3MJW1WaE9EYShiWuK6iLGQj69HcTNL9EaJpZjwumrIfox6NQh/eA==
X-Gm-Gg: ASbGncv7ltPtAQSxFRH0YTaBlAWgpYi2hvn7pjE3GWCZljzGuU8shdrJioUNj+YYFvg
	vY0bYhPt+nAFdFXioEkml58FuymwWceAUXUvnQQhYHdlPNynR9oBa5Vn3lF0Nb6qLPDyvlAJKJz
	Xu+VSaSAgaGEnb4XWu3PAuIEMO586lKJ7TdADLZyRb6HaooeIbeiW+3R0snHyTbYmWi2fOitU7N
	pCJzXjtDUJ6404eGoZ3ZnAkRcjqNN+zoDLi/LL5g7IvJXv6E70TTwdCIFuVtN1HfpdcKcSxC6Mh
	vWvC7Fi3gT2S2KDqqyO4BCpxVE/yhDJ2hVIYybWPsY0erA+h2xhwCxkjruma3dG3hyI2JZ13MbX
	tBWJw3vB5+3vxSw==
X-Google-Smtp-Source: AGHT+IGj3+htGnEIyMivpivIivCnjfIy6Tideg6ovbKdF3ZUejVVtTS1+sX05zRZKNfgj9Ou9ozS3A==
X-Received: by 2002:a05:6000:1848:b0:3a0:b4f1:8bb8 with SMTP id ffacd0b85a97d-3a3496c38b8mr3799664f8f.34.1747240502599;
        Wed, 14 May 2025 09:35:02 -0700 (PDT)
Received: from thinkpad (112.8.30.213.rev.vodafone.pt. [213.30.8.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d2d3sm20577369f8f.63.2025.05.14.09.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 09:35:02 -0700 (PDT)
Date: Wed, 14 May 2025 17:35:00 +0100
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, 
	Will Deacon <will@kernel.org>, Robert Richter <rric@kernel.org>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Marc Zyngier <maz@kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	dingwei@marvell.com, cassel@kernel.org, Lukas Wunner <lukas@wunner.de>, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v4 5/5] PCI: qcom: Add support for resetting the slot due
 to link down event
Message-ID: <sotge26h35mcijcu3eqkbf7aimkwnxzhbgltoz74nfnefc7fjd@xct54hpv5ane>
References: <20250508-pcie-reset-slot-v4-0-7050093e2b50@linaro.org>
 <20250508-pcie-reset-slot-v4-5-7050093e2b50@linaro.org>
 <1b4b7ee5-1d7e-573c-0647-44aad654354a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b4b7ee5-1d7e-573c-0647-44aad654354a@oss.qualcomm.com>

On Wed, May 14, 2025 at 11:52:13AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 5/8/2025 12:40 PM, Manivannan Sadhasivam wrote:
> > The PCIe link can go down under circumstances such as the device firmware
> > crash, link instability, etc... When that happens, the PCIe slot needs to
> > be reset to make it operational again. Currently, the driver is not
> > handling the link down event, due to which the users have to restart the
> > machine to make PCIe link operational again. So fix it by detecting the
> > link down event and resetting the slot.
> > 
> > Since the Qcom PCIe controllers report the link down event through the
> > 'global' IRQ, enable the link down event by setting PARF_INT_ALL_LINK_DOWN
> > bit in PARF_INT_ALL_MASK register.
> > 
> > Then in the case of the event, call pci_host_handle_link_down() API
> > in the handler to let the PCI core handle the link down condition. Note
> > that both link up and link down events could be set at a time when the
> > handler runs. So always handle link down first.
> > 
> > The API will internally call, 'pci_host_bridge::reset_slot()' callback to
> > reset the slot in a platform specific way. So implement the callback to
> > reset the slot by first resetting the PCIe core, followed by reinitializing
> > the resources and then finally starting the link again.
> > 
> Only one comment see below.
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> > ---
> >   drivers/pci/controller/dwc/Kconfig     |   1 +
> >   drivers/pci/controller/dwc/pcie-qcom.c | 112 ++++++++++++++++++++++++++++++---
> >   2 files changed, 105 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index d9f0386396edf66ad0e514a0f545ed24d89fcb6c..ce04ee6fbd99cbcce5d2f3a75ebd72a17070b7b7 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -296,6 +296,7 @@ config PCIE_QCOM
> >   	select PCIE_DW_HOST
> >   	select CRC8
> >   	select PCIE_QCOM_COMMON
> > +	select PCI_HOST_COMMON
> >   	help
> >   	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
> >   	  PCIe controller uses the DesignWare core plus Qualcomm-specific
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index dc98ae63362db0422384b1879a2b9a7dc564d091..e577619d0f8ceddf0955139ae6b939842f8cb7be 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -34,6 +34,7 @@
> >   #include <linux/units.h>
> >   #include "../../pci.h"
> > +#include "../pci-host-common.h"
> >   #include "pcie-designware.h"
> >   #include "pcie-qcom-common.h"
> > @@ -55,6 +56,7 @@
> >   #define PARF_INT_ALL_STATUS			0x224
> >   #define PARF_INT_ALL_CLEAR			0x228
> >   #define PARF_INT_ALL_MASK			0x22c
> > +#define PARF_STATUS				0x230
> >   #define PARF_SID_OFFSET				0x234
> >   #define PARF_BDF_TRANSLATE_CFG			0x24c
> >   #define PARF_DBI_BASE_ADDR_V2			0x350
> > @@ -130,9 +132,14 @@
> >   /* PARF_LTSSM register fields */
> >   #define LTSSM_EN				BIT(8)
> > +#define SW_CLEAR_FLUSH_MODE			BIT(10)
> > +#define FLUSH_MODE				BIT(11)
> >   /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
> > -#define PARF_INT_ALL_LINK_UP			BIT(13)
> > +#define INT_ALL_LINK_DOWN			1
> > +#define INT_ALL_LINK_UP				13
> > +#define PARF_INT_ALL_LINK_DOWN			BIT(INT_ALL_LINK_DOWN)
> > +#define PARF_INT_ALL_LINK_UP			BIT(INT_ALL_LINK_UP)
> >   #define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
> >   /* PARF_NO_SNOOP_OVERRIDE register fields */
> > @@ -145,6 +152,9 @@
> >   /* PARF_BDF_TO_SID_CFG fields */
> >   #define BDF_TO_SID_BYPASS			BIT(0)
> > +/* PARF_STATUS fields */
> > +#define FLUSH_COMPLETED				BIT(8)
> > +
> >   /* ELBI_SYS_CTRL register fields */
> >   #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
> > @@ -169,6 +179,7 @@
> >   						PCIE_CAP_SLOT_POWER_LIMIT_SCALE)
> >   #define PERST_DELAY_US				1000
> > +#define FLUSH_TIMEOUT_US			100
> >   #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
> > @@ -274,11 +285,14 @@ struct qcom_pcie {
> >   	struct icc_path *icc_cpu;
> >   	const struct qcom_pcie_cfg *cfg;
> >   	struct dentry *debugfs;
> > +	int global_irq;
> >   	bool suspended;
> >   	bool use_pm_opp;
> >   };
> >   #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> > +static int qcom_pcie_reset_slot(struct pci_host_bridge *bridge,
> > +				  struct pci_dev *pdev);
> >   static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
> >   {
> > @@ -1263,6 +1277,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> >   			goto err_assert_reset;
> >   	}
> > +	pp->bridge->reset_slot = qcom_pcie_reset_slot;
> > +
> >   	return 0;
> >   err_assert_reset:
> > @@ -1517,6 +1533,74 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
> >   	}
> >   }
> > +static int qcom_pcie_reset_slot(struct pci_host_bridge *bridge,
> > +				  struct pci_dev *pdev)
> > +{
> > +	struct pci_bus *bus = bridge->bus;
> > +	struct dw_pcie_rp *pp = bus->sysdata;
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > +	struct device *dev = pcie->pci->dev;
> > +	u32 val;
> > +	int ret;
> > +
> > +	/* Wait for the pending transactions to be completed */
> > +	ret = readl_relaxed_poll_timeout(pcie->parf + PARF_STATUS, val,
> > +					 val & FLUSH_COMPLETED, 10,
> > +					 FLUSH_TIMEOUT_US);
> > +	if (ret) {
> > +		dev_err(dev, "Flush completion failed: %d\n", ret);
> > +		goto err_host_deinit;
> > +	}
> > +
> > +	/* Clear the FLUSH_MODE to allow the core to be reset */
> > +	val = readl(pcie->parf + PARF_LTSSM);
> > +	val |= SW_CLEAR_FLUSH_MODE;
> > +	writel(val, pcie->parf + PARF_LTSSM);
> > +
> > +	/* Wait for the FLUSH_MODE to clear */
> > +	ret = readl_relaxed_poll_timeout(pcie->parf + PARF_LTSSM, val,
> > +					 !(val & FLUSH_MODE), 10,
> > +					 FLUSH_TIMEOUT_US);
> > +	if (ret) {
> > +		dev_err(dev, "Flush mode clear failed: %d\n", ret);
> > +		goto err_host_deinit;
> > +	}
> > +
> > +	qcom_pcie_host_deinit(pp);
> > +
> > +	ret = qcom_pcie_host_init(pp);
> > +	if (ret) {
> > +		dev_err(dev, "Host init failed\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = dw_pcie_setup_rc(pp);
> > +	if (ret)
> > +		goto err_host_deinit;
> > +
> > +	/*
> > +	 * Re-enable global IRQ events as the PARF_INT_ALL_MASK register is
> > +	 * non-sticky.
> > +	 */
> > +	if (pcie->global_irq)
> > +		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_ALL_LINK_DOWN |
> > +			       PARF_INT_MSI_DEV_0_7, pcie->parf + PARF_INT_ALL_MASK);
> > +
> > +	qcom_pcie_start_link(pci);
> > +	if (!dw_pcie_wait_for_link(pci))
> > +		qcom_pcie_icc_opp_update(pcie);
> This icc opp update can we removed as this can updated from the global
> IRQ.

Right. I forgot to remove it after keeping link up IRQ change. Removed it while
applying.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

