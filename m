Return-Path: <linux-pci+bounces-5516-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142F3894AF2
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 07:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E8C81C22025
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 05:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269C31803A;
	Tue,  2 Apr 2024 05:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgEyTcHA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA82CA6F;
	Tue,  2 Apr 2024 05:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712036874; cv=none; b=kt5jzgXBuBip/x5F9wZOx222x8D5ZQzaw2IKj2/WTZ0sIM3iV+jAjJb81LiZsOuXGmn5cVQ8vo2fsseLYLCl+Cqy/UacXkIXsI0cxPMAHodH/YfIbnzypfvCaQgoLT+FQcWpm19AzCtOwPQeYLmq5woSlDkRh4mcm0aL4eZQdsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712036874; c=relaxed/simple;
	bh=zXPakjJ2DckR/x2jHlfc1cEl8Lm1K6qgdabV8nrqeMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSPU7GQiXNRk0mVYI7+5k4b7K1e9q3EJoNhtbjrM7gXaPaGfrxZRiBhaXXHM9miJaWIKKP0ccz0MQT1UnLcQytBi7ivdHXV5wUXEOsB9uJT6B5RLrcxCbW4wpLxhdYAi7pNec/3KoXoZDo2z87SObaq9r4ILTNRbG4GutEmH6oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgEyTcHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C10FC433F1;
	Tue,  2 Apr 2024 05:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712036873;
	bh=zXPakjJ2DckR/x2jHlfc1cEl8Lm1K6qgdabV8nrqeMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rgEyTcHA8nvqp5CpxkRw+PajIM+nTNglkN1Sh8ryp4T5XJmZqjK03HabsKNz9s80L
	 eaIKCD2P9GyhYhRWLBWm/PPsKWPCb5oNMtwodhgMMSdoVLX12sIxw47C55LpXUQAuu
	 SY9KO1nluGN5YG9Mo1cPDrcd1fUS/lglkKd+ZesY0mq4a+enePp0aL+Fi/sK6GNacd
	 xw2515FRoylqAMSMwwb3NfKPNAcxBb0GKalUWBgqAsehK/S+0H9LtKFFS2X+THfoSB
	 ZNnQPgGECfCrFIIkIkaJxsCxEuP4zpdN1/uxv/nbkTgehEHxCCLrBnGRl4XSu7OSTS
	 sI9bDPFIhhvtw==
Date: Tue, 2 Apr 2024 11:17:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
	quic_msarkar@quicinc.com, quic_kraravin@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] PCI: qcom: Add rx margining settings for gen4
Message-ID: <20240402054745.GK2933@thinkpad>
References: <20240320071527.13443-1-quic_schintav@quicinc.com>
 <20240320071527.13443-4-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320071527.13443-4-quic_schintav@quicinc.com>

On Wed, Mar 20, 2024 at 12:14:47AM -0700, Shashank Babu Chinta Venkata wrote:
> Add rx margining settings for gen4 operation.
> 

What is 'rx margining'? As mentioned in the previous patch, use 16 GT/s.

> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.h | 23 +++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-cmn.c   | 35 ++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-cmn.h   | 11 +++++-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c    |  4 ++-
>  drivers/pci/controller/dwc/pcie-qcom.c       |  4 ++-
>  5 files changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 064744bfe35a..ce1c5f9c406a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -206,6 +206,29 @@
>  
>  #define PCIE_PL_CHK_REG_ERR_ADDR			0xB28
>  
> +/*
> + * GEN4 lane margining register definitions
> + */
> +#define GEN4_LANE_MARGINING_1_OFF		0xb80
> +#define MARGINING_MAX_VOLTAGE_OFFSET_MASK	GENMASK(29, 24)
> +#define MARGINING_NUM_VOLTAGE_STEPS_MASK	GENMASK(22, 16)
> +#define MARGINING_MAX_TIMING_OFFSET_MASK	GENMASK(13, 8)
> +#define MARGINING_NUM_TIMING_STEPS_MASK		GENMASK(5, 0)
> +#define MARGINING_MAX_VOLTAGE_OFFSET_SHIFT	24
> +#define MARGINING_NUM_VOLTAGE_STEPS_SHIFT	16
> +#define MARGINING_MAX_TIMING_OFFSET_SHIFT	8
> +
> +#define GEN4_LANE_MARGINING_2_OFF		0xb84
> +#define MARGINING_IND_ERROR_SAMPLER		BIT(28)
> +#define MARGINING_SAMPLE_REPORTING_METHOD	BIT(27)
> +#define MARGINING_IND_LEFT_RIGHT_TIMING		BIT(26)
> +#define MARGINING_IND_UP_DOWN_VOLTAGE		BIT(25)
> +#define MARGINING_VOLTAGE_SUPPORTED		BIT(24)
> +#define MARGINING_MAXLANES_MASK			GENMASK(20, 16)
> +#define MARGINING_SAMPLE_RATE_TIMING_MASK	GENMASK(13, 8)
> +#define MARGINING_SAMPLE_RATE_VOLTAGE_MASK	GENMASK(5, 0)
> +#define MARGINING_MAXLANES_SHIFT		16
> +#define MARGINING_SAMPLE_RATE_TIMING_SHIFT	8

Add a newline

>  /*
>   * iATU Unroll-specific register definitions
>   * From 4.80 core version the address translation will be made by unroll
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-cmn.c b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
> index 208a55e8e9a1..bf6b27ee8327 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-cmn.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-cmn.c
> @@ -53,6 +53,41 @@ void qcom_pcie_cmn_set_16gt_eq_settings(struct dw_pcie *pci)
>  }
>  EXPORT_SYMBOL_GPL(qcom_pcie_cmn_set_16gt_eq_settings);
>  
> +void qcom_pcie_cmn_set_16gt_rx_margining_settings(struct dw_pcie *pci)
> +{
> +	u32 reg;
> +
> +	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_1_OFF);
> +	reg &= ~MARGINING_MAX_VOLTAGE_OFFSET_MASK;
> +	reg |= (MARGINING_MAX_VOLTAGE_OFFSET_VAL <<
> +		MARGINING_MAX_VOLTAGE_OFFSET_SHIFT);

Same comment as previous patch to use FIELD_* macros.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

