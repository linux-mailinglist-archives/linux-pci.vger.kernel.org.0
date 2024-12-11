Return-Path: <linux-pci+bounces-18086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8409EC457
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 06:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E13284017
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 05:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39404C85;
	Wed, 11 Dec 2024 05:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FgO4q6GU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADD74A0A
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 05:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733895083; cv=none; b=T0v5F1p/xitQR0ZJddTxIL3r/Tf7Y7w0YEBK/20cwUgTn+5Chhneq56J8dgRzrGCD/DKZDoGMkHrrWx6s/GHLHB+Mhj9gbBua/0STSk9WoikNvtrXgcdXd+XOafBXxSn1tKKMalM1RpokfTB9PPwwK730esBICs/6hLs678kXws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733895083; c=relaxed/simple;
	bh=LwmFQ1K60anudGXuzE07q64ODZGW3EJEBtjT/fIBzhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzguE768mPX5ZvcVB/b/jItD3ket/esdWJmkBqEObQW3jo2ude3/28NUfVVFj9GkcUxVE+/ljjA3Cn+k5GkSZneUweExXWAVIYAD9/RSDswT+YqJDvSkmFEHbEP5P4Imwpclid/YQISxU3HivkSp0b6GhYO/u+yjdzoUmJV5pjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FgO4q6GU; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-728e3826211so1098712b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 10 Dec 2024 21:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733895081; x=1734499881; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ShdzjtGZM9vxO89zHijgFIz+FSCJs3Ns3QmxUQPrD+U=;
        b=FgO4q6GU1rkqUauzNI0mdbP5ReJoPp4I+czsjGQWNt4FhUiZ0iGcM9e+90L2PqyDgJ
         U/eOyqP+LgOFQGuTOb9Y6Ky8WCSONKhA0EY07D6hZTb+C26rCBZ+CUKVE5OJV7KSA9qj
         2AtIvHuHAA39FQQMdLV4QqjVZyrIqOEvgMFh2hEXm5iZ/MRq8mLl2HFnyb8/7reT5s/w
         UrtilCCRBkmVL0Zf1gaNsthp8dZICCZwRhCOXPDa8wXZxaCRvOkaZ2lpVb8Ba4/G0tSg
         D8wABMCvKBQiURFKinDlfVcLIo6KPqul17rSOWV9OBB/cgGCi1Hu2hLBvK2PfYwNPAgF
         MXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733895081; x=1734499881;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShdzjtGZM9vxO89zHijgFIz+FSCJs3Ns3QmxUQPrD+U=;
        b=BnhnxYOkHr40bJ8dVnieGcISY6NoS0FXlB7bxgXgISHyMpEXIYmfGDAsoB0ifOStG2
         SYo+tLGnUmDDlH3Z/g96rInlHE4zKPr8t4uElceJcvk16dUp6PfJoxvw3Q1cSfggYImu
         uOVL1LJNSTylqkXPJfnUxycl5vnoBJCImZgIZ+DhK66iySpGzQrlmENEZA5/r/E8OrTt
         yXvsONL7COKEh1XnFdmEjhyQUnQjMcxQeoxj7WQp8hjJuCISAvY0E+XtwCzwmZZC0sZW
         9RyGuBeJR89NTAtkOhBVABIqUZK+kfBj/Iqli9l6A3lsRgr6epD0VhcIxijs0fRzQryy
         P+JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW2qpEUyPJLRbN2X9cdpeR1etpApArZFIc+e6E8dg/k5pqnDysGoqcKslsyHzghUEmKqbKCRV7uVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY/qUcB+eA6jEdAlzQoTNTizABq3Lie4oCJP6rjIFp+tCB0siu
	3Lqjl127WlIeZ+ioLfvHCh/LvKTdOCiZ+UCs/U9cqSmR9QZINmvPhtfUMxOiL7kPbEtDLDBDid0
	=
X-Gm-Gg: ASbGncs+r6nhUQ/Nk1qr+nW9qufBRBna3EZ1WFsP0r2PSkp6AbkQKbM9p04d/0Ku/1j
	2mOdTxB0FtkeN5gU5MRS5gF6earJwHE5eKm3RG9FguonC0V3E0qZIbyE1Y1bcyF6qx3iFnGSZz0
	fegmKDv2mEj9U/PrqKvqqzMN6RJeQKLCrJTC2mKtXNEj/9XnE95uNgupt3BwEopJwNJ/MB70Ahu
	glvLRU/cAOXFxHvFgUj+tKS5XicUn/QF1m6kOLgzivt/OFh5MKZRhlio5PBNsY=
X-Google-Smtp-Source: AGHT+IHlZIECQ8fR8OzlEjAgvv5+ugAv4twpl5gKRHvFmE0YNk28z5fm5WtdfPPNmIaOYwFm0uxSKg==
X-Received: by 2002:a05:6a21:9990:b0:1e1:a829:bfb6 with SMTP id adf61e73a8af0-1e1c129474emr3076160637.3.1733895080678;
        Tue, 10 Dec 2024 21:31:20 -0800 (PST)
Received: from thinkpad ([120.60.55.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725ec2c2b7esm4993746b3a.182.2024.12.10.21.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 21:31:20 -0800 (PST)
Date: Wed, 11 Dec 2024 11:01:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Enumerate endpoints based on
 dll_link_up irq in the combined sys irq
Message-ID: <20241211053104.7sgo5bmmjnolwvhh@thinkpad>
References: <20241127145041.3531400-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241127145041.3531400-2-cassel@kernel.org>

On Wed, Nov 27, 2024 at 03:50:42PM +0100, Niklas Cassel wrote:
> Most boards using the pcie-dw-rockchip PCIe controller lack standard
> hotplug support.
> 
> Thus, when an endpoint is attached to the SoC, users have to rescan the bus
> manually to enumerate the device. This can be avoided by using the
> 'dll_link_up' interrupt in the combined system interrupt 'sys'.
> 
> Once the 'dll_link_up' irq is received, the bus underneath the host bridge
> is scanned to enumerate PCIe endpoint devices.
> 
> This commit implements the same functionality that was implemented in the
> DWC based pcie-qcom driver in commit 4581403f6792 ("PCI: qcom: Enumerate
> endpoints based on Link up event in 'global_irq' interrupt").
> 
> The Root Complex specific device tree binding for pcie-dw-rockchip already
> has the 'sys' interrupt marked as required, so there is no need to update
> the device tree binding. This also means that we can request the 'sys' IRQ
> unconditionally.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 62 +++++++++++++++++--
>  1 file changed, 58 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 1170e1107508..ce4b511bff9b 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -389,6 +389,34 @@ static const struct dw_pcie_ops dw_pcie_ops = {
>  	.stop_link = rockchip_pcie_stop_link,
>  };
>  
> +static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
> +{
> +	struct rockchip_pcie *rockchip = arg;
> +	struct dw_pcie *pci = &rockchip->pci;
> +	struct dw_pcie_rp *pp = &pci->pp;
> +	struct device *dev = pci->dev;
> +	u32 reg, val;
> +
> +	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
> +	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
> +
> +	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
> +	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
> +
> +	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
> +		val = rockchip_pcie_get_ltssm(rockchip);
> +		if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
> +			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
> +			/* Rescan the bus to enumerate endpoint devices */
> +			pci_lock_rescan_remove();
> +			pci_rescan_bus(pp->bridge->bus);
> +			pci_unlock_rescan_remove();
> +		}
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
>  {
>  	struct rockchip_pcie *rockchip = arg;
> @@ -418,14 +446,31 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> -static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
> +static int rockchip_pcie_configure_rc(struct platform_device *pdev,
> +				      struct rockchip_pcie *rockchip)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct dw_pcie_rp *pp;
> +	int irq, ret;
>  	u32 val;
>  
>  	if (!IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_HOST))
>  		return -ENODEV;
>  
> +	irq = platform_get_irq_byname(pdev, "sys");
> +	if (irq < 0) {
> +		dev_err(dev, "missing sys IRQ resource\n");
> +		return irq;
> +	}
> +
> +	ret = devm_request_threaded_irq(dev, irq, NULL,
> +					rockchip_pcie_rc_sys_irq_thread,
> +					IRQF_ONESHOT, "pcie-sys-rc", rockchip);
> +	if (ret) {
> +		dev_err(dev, "failed to request PCIe sys IRQ\n");
> +		return ret;
> +	}
> +
>  	/* LTSSM enable control mode */
>  	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
>  	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> @@ -436,7 +481,16 @@ static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
>  	pp = &rockchip->pci.pp;
>  	pp->ops = &rockchip_pcie_host_ops;
>  
> -	return dw_pcie_host_init(pp);
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host\n");
> +		return ret;
> +	}
> +
> +	/* unmask DLL up/down indicator */
> +	rockchip_pcie_writel_apb(rockchip, 0x20000, PCIE_CLIENT_INTR_MASK_MISC);
> +
> +	return ret;
>  }
>  
>  static int rockchip_pcie_configure_ep(struct platform_device *pdev,
> @@ -457,7 +511,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
>  
>  	ret = devm_request_threaded_irq(dev, irq, NULL,
>  					rockchip_pcie_ep_sys_irq_thread,
> -					IRQF_ONESHOT, "pcie-sys", rockchip);
> +					IRQF_ONESHOT, "pcie-sys-ep", rockchip);
>  	if (ret) {
>  		dev_err(dev, "failed to request PCIe sys IRQ\n");
>  		return ret;
> @@ -553,7 +607,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  
>  	switch (data->mode) {
>  	case DW_PCIE_RC_TYPE:
> -		ret = rockchip_pcie_configure_rc(rockchip);
> +		ret = rockchip_pcie_configure_rc(pdev, rockchip);
>  		if (ret)
>  			goto deinit_clk;
>  		break;
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

