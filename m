Return-Path: <linux-pci+bounces-40263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E006C327CC
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 18:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F22188F91B
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 17:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7E833DEDD;
	Tue,  4 Nov 2025 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUYOI44R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FF733C536;
	Tue,  4 Nov 2025 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279019; cv=none; b=BJs+WYzFCIag3TdXX/0D3IUeW7d8AY0eBmtNveyxkC0D5xsHeolfsIJyeuke3jDs5PeDhZL3k/NN0IemV/9YpHrzuujaekIz5f1aqdTqXONDtbKJrMJjSSi63B0pP85OCmNcSs3bZR0JnbNrGmZ1BGxtdSZf7Lr7fm5tPSvC/xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279019; c=relaxed/simple;
	bh=FPJNCK36jeHaFc1F2/my5gol5g27q/q15TOBmvBhpLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HKu8wH0b0qbmwWh/Ijpza05WCEDLmUhYO3s99lpOEdDy/+rKNeLkfPwdMbvQuvbNO0YkY3p/njtjwZs99VOckk4kFTVBRyoD+J7qYOlhg08DMWBchkHyYUW7IYRq2A9Nc6iAsgqdje7vbiDhdBRWMSacmxpGDVXnXwkpAdGTdZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUYOI44R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B01BC4CEF7;
	Tue,  4 Nov 2025 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762279019;
	bh=FPJNCK36jeHaFc1F2/my5gol5g27q/q15TOBmvBhpLI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XUYOI44RTyjRBqzyfx5pZQyjxjb4vwf4LIUkuvw1TjImbYnmAzrxylg6fAqmwOBgX
	 sgq6sujIcuF+vAoW30Z/m53ZlrSJ2h1F3fvfTJDDRQ98Nj5QAc6hoWg4U00qJcqtgD
	 HbITB5nHuLYJonTOp/WwzSE0DohR7wia/xxjOAtvES9K3PkNdhPOT5kxk1+CrDVB3i
	 hMUCRMU0d3gEDNXFuDE/davvSwrbzTEox42zUMdIeIC+lYK6h6s9LHMOHEgX9ckIHu
	 lriqJ3z/VPA7yMqhf4BtXp+bmOpU8G+e9buCFMuhGI+1FrFpZdEg28+NBYlCw1qElV
	 FF3DQMGaFCvaQ==
Date: Tue, 4 Nov 2025 11:56:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mayank.rana@oss.qualcomm.com,
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH] PCI: qcom: Program correct T_POWER_ON value for L1.2
 exit timing
Message-ID: <20251104175657.GA1861670@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251104-t_power_on_fux-v1-1-eb5916e47fd7@oss.qualcomm.com>

On Tue, Nov 04, 2025 at 05:42:45PM +0530, Krishna Chaitanya Chundru wrote:
> The T_POWER_ON indicates the time (in μs) that a Port requires the port
> on the opposite side of Link to wait in L1.2.Exit after sampling CLKREQ#
> asserted before actively driving the interface. This value is used by
> the ASPM driver to compute the LTR_L1.2_THRESHOLD.
> 
> Currently, the root port exposes a T_POWER_ON value of zero in the L1SS
> capability registers, leading to incorrect LTR_L1.2_THRESHOLD calculations.
> This can result in improper L1.2 exit behavior and can trigger AER's.
> 
> To address this, program the T_POWER_ON value to 80us (scale = 1,
> value = 8) in the PCI_L1SS_CAP register during host initialization. This
> ensures that ASPM can take the root port's T_POWER_ON value into account
> while calculating the LTR_L1.2_THRESHOLD value.

I think the question is whether the value depends on the circuit
design of a particular platform (and should therefore come from DT),
or whether it depends solely on the qcom device.

PCIe r7.0, sec 5.5.4, says:

  The T_POWER_ON and Common_Mode_Restore_Time fields must be
  programmed to the appropriate values based on the components and AC
  coupling capacitors used in the connection linking the two
  components. The determination of these values is design
  implementation specific.

That suggests to me that maybe there should be devicetree properties
related to these.  Obviously these would not be qcom-specific since
this is standard PCIe stuff.

Use "μs" or "us" consistently; there's a mix above.

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index c48a20602d7fa4c50056ccf6502d3b5bf0a8287f..52a3412bd2584c8bf5d281fa6a0ed22141ad1989 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1252,6 +1252,27 @@ static bool qcom_pcie_link_up(struct dw_pcie *pci)
>  	return val & PCI_EXP_LNKSTA_DLLLA;
>  }
>  
> +static void qcom_pcie_program_t_pwr_on(struct dw_pcie *pci)
> +{
> +	u16 offset;
> +	u32 val;
> +
> +	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> +	if (offset) {
> +		dw_pcie_dbi_ro_wr_en(pci);
> +
> +		val = readl(pci->dbi_base + offset + PCI_L1SS_CAP);
> +		/* Program T power ON value to 80us */
> +		val &= ~(PCI_L1SS_CAP_P_PWR_ON_SCALE | PCI_L1SS_CAP_P_PWR_ON_VALUE);
> +		val |= FIELD_PREP(PCI_L1SS_CAP_P_PWR_ON_SCALE, 1);
> +		val |= FIELD_PREP(PCI_L1SS_CAP_P_PWR_ON_VALUE, 8);
> +
> +		writel(val, pci->dbi_base + offset + PCI_L1SS_CAP);
> +
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	}
> +}
> +
>  static void qcom_pcie_phy_power_off(struct qcom_pcie *pcie)
>  {
>  	struct qcom_pcie_port *port;
> @@ -1302,6 +1323,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  			goto err_disable_phy;
>  	}
>  
> +	qcom_pcie_program_t_pwr_on(pci);
> +
>  	qcom_ep_reset_deassert(pcie);
>  
>  	if (pcie->cfg->ops->config_sid) {
> 
> ---
> base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
> change-id: 20251104-t_power_on_fux-70dc68377941
> 
> Best regards,
> -- 
> Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> 

