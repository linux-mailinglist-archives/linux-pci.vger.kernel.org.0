Return-Path: <linux-pci+bounces-26656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DE9A9A06F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 07:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041385A7491
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 05:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67341A9B40;
	Thu, 24 Apr 2025 05:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xriiRtkx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7CE1B0F30
	for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2025 05:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745472433; cv=none; b=MosiwFDR4l4U92bV86e+94aVNUdgydBvG93uyiYz2qivavCPideu2TMC7R36Jzw+36TzYhpAzPF520gD5pyRQwjtXHsx4rCYTDgU7KuvAYhQRAaJW0FVk9lCp5bMDbcTk5tjIivthCOZrJlIeDzXvLCYrDQo+I3n/F+IWHR8hDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745472433; c=relaxed/simple;
	bh=QVve6SNFxQ7c7t5apaYCSIxKah6vut+7W/vl9gX9VUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVmw9cmN+K9gh0PIMt/5OTho/147DReqrVSt4Lfw51GTHrL+i1kWC2U96kMXZ4/taP6PHcJO98zLU7JPtWNY1LAZjVl0qcWRWERCsfz3mmJzofaB3LHaj3A1+jWEJScuw0Im8Cel8wl46Lvn3cBOQm1TRdti+OwjMyczSzorxz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xriiRtkx; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30549dacd53so495435a91.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 22:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745472431; x=1746077231; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cZUPcM2JRXU1EZUeYvnEV+B9VdnBQw7RuAghQfhbC98=;
        b=xriiRtkxxm0kjh+F4DHHvxldPNPL4fcvEUhzYMNIh++uvqEFYuMZh8znb1bQxm5b85
         OhtIlENpFeS5cFrNYe2EWYqdyy49AWpHBAMwaKASNg04rjI4bYA+ihax4x0yFUcYI24t
         jzgq/qslOn/ymlxiHA18zkxhBvBJQRRCdafUfgG6ZYth0pKKYGRWgHZnkTxUixKlbwE9
         hru2CE2FZ24m4EkbeuO1ZhZT7hnLup9Ay5uJy7Z6p+dDkK7h5OEYhoakeOTpPQJhRrCT
         xIhxaeFS5ALbacJ/Gk36YSIZqqM956HBXdKrFKnBcr1gU4bOdpw6e15Z4EvNl/1VD62n
         blfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745472431; x=1746077231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZUPcM2JRXU1EZUeYvnEV+B9VdnBQw7RuAghQfhbC98=;
        b=E2rV+V7Uuhn4UD7x7JVjlkRX6PCvQtCu4StNe1WOpMNL9Qy1UJQQLsxgHRWemcUjIK
         ykUhyh0/sPAYDmnXboRF3Ll45Xn+sJgYQOQa/IK/xMG+S4AgAOnbY05JRtXBZoMG52hg
         00gzmIVLjjoPccw0NrgRhn+wCE2B8bhQN/Xo/2CaUW3zuhodoCSVEtuWqbRLK1dIxJa2
         Ap0jIOgBS3qu/ZsEaAGnHTXjtXu8i6uTFRU3Vs3VttLHx4pHMxiBowUvTm0z3nRVB8Ht
         AWfPqJd0lYEtqCcyHSmy8xocfzKyjauCK+9E3axrhcv2vy2D6HuBLH8KNmPM6Io36nFr
         LwRw==
X-Forwarded-Encrypted: i=1; AJvYcCUAs0fYVpFG6xBgTuhmPUgY7K1gzGzG3OENXwrv8OxEIxL8CLFqyYLT1Yast79uGOTAGitKbFBX6qY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycq14gPCzOQeSOQSFfYYWmOrUmcs+GMiUrD0QjEB5OH+MLJprG
	buSD13HNBXKafgFj/ptWJ2EZ1ZiFYbAXldlIGK9FRgsYscthPG5T2YFAzk7efQ==
X-Gm-Gg: ASbGncsmsINfKq6BXS3Uu8NpJSx0JuTaWIT1pzhL9ONYs+3upX778fYjGS9Wo2g84Kl
	D0nLxVw0jRQ9r83zRKcjL98xIDHCmYNXshwzmoqDlQCHUj/JMVb/KtkhdBsPk0rxQjx6vs7HVhd
	liAz0DWfLrwLNYNEGeVHiDwSx3yfyBm3fdz8ipSpzGW3If6B+hb5n88i/+um+NJ9vAAtdQ4JwJn
	SmIxfg/8fZqHuPyfORGCLbLVKTgl/QjBbPoQ9CY+32qf6bY+V3K9DVjwNK8JJjk+dpm5AkPHKr+
	waKZfY0DncluzHeuTtZsmCcXJov0SdOhK+FEV7rJaBV7vpiXnvU=
X-Google-Smtp-Source: AGHT+IEwbpxTA4Qj4NM5rAHZdl1TYE4GZFHTARebZEX16BK4YArP6CGqoSYBRcTbYJYiLhgXJ62sqw==
X-Received: by 2002:a17:90b:45:b0:2f9:d0cd:3403 with SMTP id 98e67ed59e1d1-309ee3b5de0mr1568292a91.16.1745472430905;
        Wed, 23 Apr 2025 22:27:10 -0700 (PDT)
Received: from thinkpad ([120.60.139.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef1385d2sm347425a91.41.2025.04.23.22.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 22:27:10 -0700 (PDT)
Date: Thu, 24 Apr 2025 10:57:02 +0530
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
Subject: Re: [PATCH v3 5/5] PCI: qcom: Add support for resetting the slot due
 to link down event
Message-ID: <mr5kunnsv5syckqbclcw2xi6es36fnsnfvrvughqlmv2kblxof@tltliisb5upf>
References: <20250417-pcie-reset-slot-v3-0-59a10811c962@linaro.org>
 <20250417-pcie-reset-slot-v3-5-59a10811c962@linaro.org>
 <f32b2ece-f7ed-45ab-2867-9d276b88cf62@oss.qualcomm.com>
 <hmyeha6ygi6mxzsdivo2z5ccpvl5l2xietr3axxpl4zwojiavo@wuli4qazg446>
 <31f071d7-db56-f032-749e-92bc387238b8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31f071d7-db56-f032-749e-92bc387238b8@oss.qualcomm.com>

On Thu, Apr 24, 2025 at 10:41:24AM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 4/24/2025 10:30 AM, Manivannan Sadhasivam wrote:
> > On Fri, Apr 18, 2025 at 08:11:47AM +0530, Krishna Chaitanya Chundru wrote:
> > > 
> > > 
> > > On 4/17/2025 10:46 PM, Manivannan Sadhasivam via B4 Relay wrote:
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > 
> > > > The PCIe link can go down under circumstances such as the device firmware
> > > > crash, link instability, etc... When that happens, the PCIe slot needs to
> > > > be reset to make it operational again. Currently, the driver is not
> > > > handling the link down event, due to which the users have to restart the
> > > > machine to make PCIe link operational again. So fix it by detecting the
> > > > link down event and resetting the slot.
> > > > 
> > > > Since the Qcom PCIe controllers report the link down event through the
> > > > 'global' IRQ, enable the link down event by setting PARF_INT_ALL_LINK_DOWN
> > > > bit in PARF_INT_ALL_MASK register.
> > > > 
> > > > Then in the case of the event, call pci_host_handle_link_down() API
> > > > in the handler to let the PCI core handle the link down condition.
> > > > 
> > > > The API will internally call, 'pci_host_bridge::reset_slot()' callback to
> > > > reset the slot in a platform specific way. So implement the callback to
> > > > reset the slot by first resetting the PCIe core, followed by reinitializing
> > > > the resources and then finally starting the link again.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >    drivers/pci/controller/dwc/Kconfig     |  1 +
> > > >    drivers/pci/controller/dwc/pcie-qcom.c | 90 +++++++++++++++++++++++++++++++++-
> > > >    2 files changed, 89 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > > index d9f0386396edf66ad0e514a0f545ed24d89fcb6c..ce04ee6fbd99cbcce5d2f3a75ebd72a17070b7b7 100644
> > > > --- a/drivers/pci/controller/dwc/Kconfig
> > > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > > @@ -296,6 +296,7 @@ config PCIE_QCOM
> > > >    	select PCIE_DW_HOST
> > > >    	select CRC8
> > > >    	select PCIE_QCOM_COMMON
> > > > +	select PCI_HOST_COMMON
> > > >    	help
> > > >    	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
> > > >    	  PCIe controller uses the DesignWare core plus Qualcomm-specific
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index dc98ae63362db0422384b1879a2b9a7dc564d091..6b18a2775e7fcde1d634b3f58327ecc7d028e4ec 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > @@ -34,6 +34,7 @@
> > > >    #include <linux/units.h>
> > > >    #include "../../pci.h"
> > > > +#include "../pci-host-common.h"
> > > >    #include "pcie-designware.h"
> > > >    #include "pcie-qcom-common.h"
> > > > @@ -55,6 +56,7 @@
> > > >    #define PARF_INT_ALL_STATUS			0x224
> > > >    #define PARF_INT_ALL_CLEAR			0x228
> > > >    #define PARF_INT_ALL_MASK			0x22c
> > > > +#define PARF_STATUS				0x230
> > > >    #define PARF_SID_OFFSET				0x234
> > > >    #define PARF_BDF_TRANSLATE_CFG			0x24c
> > > >    #define PARF_DBI_BASE_ADDR_V2			0x350
> > > > @@ -130,8 +132,11 @@
> > > >    /* PARF_LTSSM register fields */
> > > >    #define LTSSM_EN				BIT(8)
> > > > +#define SW_CLEAR_FLUSH_MODE			BIT(10)
> > > > +#define FLUSH_MODE				BIT(11)
> > > >    /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
> > > > +#define PARF_INT_ALL_LINK_DOWN			BIT(1)
> > > >    #define PARF_INT_ALL_LINK_UP			BIT(13)
> > > >    #define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
> > > > @@ -145,6 +150,9 @@
> > > >    /* PARF_BDF_TO_SID_CFG fields */
> > > >    #define BDF_TO_SID_BYPASS			BIT(0)
> > > > +/* PARF_STATUS fields */
> > > > +#define FLUSH_COMPLETED				BIT(8)
> > > > +
> > > >    /* ELBI_SYS_CTRL register fields */
> > > >    #define ELBI_SYS_CTRL_LT_ENABLE			BIT(0)
> > > > @@ -169,6 +177,7 @@
> > > >    						PCIE_CAP_SLOT_POWER_LIMIT_SCALE)
> > > >    #define PERST_DELAY_US				1000
> > > > +#define FLUSH_TIMEOUT_US			100
> > > >    #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
> > > > @@ -274,11 +283,14 @@ struct qcom_pcie {
> > > >    	struct icc_path *icc_cpu;
> > > >    	const struct qcom_pcie_cfg *cfg;
> > > >    	struct dentry *debugfs;
> > > > +	int global_irq;
> > > >    	bool suspended;
> > > >    	bool use_pm_opp;
> > > >    };
> > > >    #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
> > > > +static int qcom_pcie_reset_slot(struct pci_host_bridge *bridge,
> > > > +				  struct pci_dev *pdev);
> > > >    static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
> > > >    {
> > > > @@ -1263,6 +1275,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> > > >    			goto err_assert_reset;
> > > >    	}
> > > > +	pp->bridge->reset_slot = qcom_pcie_reset_slot;
> > > > +
> > > >    	return 0;
> > > >    err_assert_reset:
> > > > @@ -1300,6 +1314,73 @@ static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
> > > >    	.post_init	= qcom_pcie_host_post_init,
> > > >    };
> > > > +static int qcom_pcie_reset_slot(struct pci_host_bridge *bridge,
> > > > +				  struct pci_dev *pdev)
> > > > +{
> > > > +	struct pci_bus *bus = bridge->bus;
> > > > +	struct dw_pcie_rp *pp = bus->sysdata;
> > > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> > > > +	struct device *dev = pcie->pci->dev;
> > > > +	u32 val;
> > > > +	int ret;
> > > > +
> > > > +	/* Wait for the pending transactions to be completed */
> > > > +	ret = readl_relaxed_poll_timeout(pcie->parf + PARF_STATUS, val,
> > > > +					 val & FLUSH_COMPLETED, 10,
> > > > +					 FLUSH_TIMEOUT_US);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Flush completion failed: %d\n", ret);
> > > > +		goto err_host_deinit;
> > > > +	}
> > > > +
> > > > +	/* Clear the FLUSH_MODE to allow the core to be reset */
> > > > +	val = readl(pcie->parf + PARF_LTSSM);
> > > > +	val |= SW_CLEAR_FLUSH_MODE;
> > > > +	writel(val, pcie->parf + PARF_LTSSM);
> > > > +
> > > > +	/* Wait for the FLUSH_MODE to clear */
> > > > +	ret = readl_relaxed_poll_timeout(pcie->parf + PARF_LTSSM, val,
> > > > +					 !(val & FLUSH_MODE), 10,
> > > > +					 FLUSH_TIMEOUT_US);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Flush mode clear failed: %d\n", ret);
> > > > +		goto err_host_deinit;
> > > > +	}
> > > > +
> > > > +	qcom_pcie_host_deinit(pp);
> > > > +
> > > > +	ret = qcom_pcie_host_init(pp);
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Host init failed\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	ret = dw_pcie_setup_rc(pp);
> > > > +	if (ret)
> > > > +		goto err_host_deinit;
> > > > +
> > > > +	/*
> > > > +	 * Re-enable global IRQ events as the PARF_INT_ALL_MASK register is
> > > > +	 * non-sticky.
> > > > +	 */
> > > > +	if (pcie->global_irq)
> > > > +		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_ALL_LINK_DOWN |
> > > > +			       PARF_INT_MSI_DEV_0_7, pcie->parf + PARF_INT_ALL_MASK);
> > > do we need to enable linkup again here, since all the devices are
> > > enumerated previously, the linkup irq will do a rescan again which is
> > > not needed.
> > 
> > Right. I was trying to keep the irq enablement on par with probe(), but LINK_UP
> > is strictly not needed. I will drop it.
> > 
> > > Instead of linkup we update icc & opp bandwidths after
> > > dw_pcie_wait_for_link() in the below.
> > > 
> > 
> > Why do we need to update ICC and OPP?
> After link retrain, if the link data rate has reduced due to some
> electrical issue or some other reason we may need to update the icc and
> opp votings here.
> 

Hmm, I was not expecting it to get changed, but considering the fact that the
link down might be happening due to any link stability issues, it is plausible.

I will add a call to qcom_pcie_icc_opp_update().

- Mani

-- 
மணிவண்ணன் சதாசிவம்

