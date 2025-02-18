Return-Path: <linux-pci+bounces-21765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA91A3AB77
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 23:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6FD1897502
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 22:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3791D0F5A;
	Tue, 18 Feb 2025 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBWsNAQn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B91C701A;
	Tue, 18 Feb 2025 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739916450; cv=none; b=bQPC7pVxyP+cYy3TnOm0IYoXkonIrRdfXFposG9A2h8idOupj/Hi8pjQDJfyIlh09yPgwyGj+mlDEbeEKd5W7nT6iK0olRP6r+g7R35XAEL9lfdmO7ntUAlwzWMZtZ2n2Czeahk/dgPNYvndlbKbKtaOhmmD+o3/mnLuxJaXZ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739916450; c=relaxed/simple;
	bh=NZOWiC+glLsY8qZo0mE4K4nGd+wVcIoNUq4I6bumeiU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=co6zHLJAKma3Bq5y/xrnI4pawUOktAtQODf3yAPxPn0IjUDYOmO1VCy2eTsu6o/QOT6EKGJFFYAJbmhpDy2wUlo0v8NIl3W1NNb36+vazkgJx5R+rMvhKsDRkOBS6TFRx7awesjLv0VFzcMB66ELLogXq7f4cmjmvoNPd3JpLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBWsNAQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A86C4CEE2;
	Tue, 18 Feb 2025 22:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739916450;
	bh=NZOWiC+glLsY8qZo0mE4K4nGd+wVcIoNUq4I6bumeiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XBWsNAQnXEBFVzMi2wOxo+aI15uZwNSrE7WK8dzWdCzuS131u3gCjVmwyiEFHMNm3
	 pM6H8UtOGiaVKAMtsQvc6PPBZ1SJOTiF9SXc0SzOe2qKqNznBRCwvGn2bAaxNUkvqL
	 o1Eeab/OepqaasRX0QMayV8ABDywbK5xFer3PEHM760RpbkNoqIytbQmtzqryOuX/V
	 x10DlupQiN7JHfUdErs+Ya7QroonPr2jf2IZa0qJRneU1f/r509POY5CNCt2i49Czm
	 sMG+SJDZ4n6lgQGEnnhWhiCjXSSk4SXGH4V3LRpDeCEkchs49lb/kxYshH3Hi6D1l+
	 bodSzda7o3FvA==
Date: Tue, 18 Feb 2025 16:07:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, quic_jjohnson@quicinc.com,
	quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com,
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH 4/8] PCI: dwc: qcom: Update ICC & OPP votes based upon
 the requested speed
Message-ID: <20250218220728.GA194681@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-mhi_bw_up-v1-4-9bad1e42bdb1@oss.qualcomm.com>

Make subject line match history for this file.

On Mon, Feb 17, 2025 at 12:04:11PM +0530, Krishna Chaitanya Chundru wrote:
> QCOM PCIe controllers needs to disable ASPM before initiating link
> re-train. So as part of pre_bw_scale() disable ASPM and as part of
> post_scale_bus_bw() enable ASPM back.

s/needs/need/

Why does Qcom need to disable ASPM?  Is there a PCIe spec restriction
about this that should be applied to all PCIe host bridges?  Or is
this a Qcom defect?

> Update ICC & OPP votes based on the requested speed so that RPMh votes
> gets updated based on the speed.

s/gets/get/

> Bring out the core logic from qcom_pcie_icc_opp_update() to new function
> qcom_pcie_set_icc_opp().

This refactoring possibly could be a separate patch to make the meat
of this change clearer.

> +static int qcom_pcie_set_icc_opp(struct qcom_pcie *pcie, int speed, int width)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	unsigned long freq_kbps;
> +	struct dev_pm_opp *opp;
> +	int ret, freq_mbps;
> +
> +	if (pcie->icc_mem) {
> +		ret = icc_set_bw(pcie->icc_mem, 0,
> +				 width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> +		if (ret) {
> +			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
> +				ret);
> +		}
> +	} else if (pcie->use_pm_opp) {
> +		freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
> +		if (freq_mbps < 0)
> +			return -EINVAL;
> +
> +		freq_kbps = freq_mbps * KILO;
> +		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
> +						 true);
> +		if (!IS_ERR(opp)) {
> +			ret = dev_pm_opp_set_opp(pci->dev, opp);
> +			if (ret)
> +				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
> +					freq_kbps * width, ret);
> +			dev_pm_opp_put(opp);
> +		}
> +	}
> +
> +	return ret;

Looks uninitialized in some paths.

