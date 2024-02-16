Return-Path: <linux-pci+bounces-3582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC27B857AB2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 11:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6931528614D
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 10:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05DB5380D;
	Fri, 16 Feb 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZxKMAMl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855DF535A2;
	Fri, 16 Feb 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080772; cv=none; b=ofZBhUu3AKa13W9TTf42Rc2/9HuOp6FbtoHVbP1uDxvXUkuUAUvEZV90ZzxtgpxFirt0j/NkknVpxx6oc0NbFgBOVy1m+ZVARv8KRpmKzm3OHo+/2ap7xIuqwS7P7uAVtMm+kFOe5IcqTd85uO8rONGAhyaTF9rgKrYI42jfugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080772; c=relaxed/simple;
	bh=8VkaDPezDLyOsFDWG7YISAHY6yzoxdeio9M6WtqjSaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fph5odDwzzAIxy5jkyl0UqSPnSu+73Fmg5t9SQUgEe936FhY38YpmDrBIpgxKBs59+QbCuUnvjR8AP1yYJjooi3KuHE6dOA3HPT5pBRu8qeHD6+2RHfyavfB0vXuif6+b/NDjU3A5tR04+jM7J0SbHPnlqzevmw05ZtfxhTN8vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZxKMAMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B92C433C7;
	Fri, 16 Feb 2024 10:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708080772;
	bh=8VkaDPezDLyOsFDWG7YISAHY6yzoxdeio9M6WtqjSaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dZxKMAMlNEItXdf+sah3f0Cyw5u24xo2zCc00T3+8mqhBrqpOxyetDPgOL9e8avxx
	 mv22lD1sEPmBEmFDSHApj6JOize1TuBT4VPWM4jBcJrKvhYj92EzTyN60eKdNNzhIt
	 7yYcEj66TVVTE8xrrDPoK4urjCLlNNUpfQPba/TWUvl/7TT12Yr5dVPI/+323QCq7F
	 TmaGxLvOhmIVwApJw/9MbnTbjlaCsq1ZAzy8dZAgR6x9rfcpnVf2SuuJSE3GDx4sNQ
	 FBP2KsLyjT8nx4N4tU/0WxdWlWFnesGH9gIGZWVbjblrTWsB7Pb2DROPyjsNu9MQZD
	 b6BSnB9vI28LQ==
Date: Fri, 16 Feb 2024 16:22:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	konrad.dybcio@linaro.org, mani@kernel.org, robh+dt@kernel.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	dmitry.baryshkov@linaro.org, robh@kernel.org,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	quic_parass@quicinc.com, quic_schintav@quicinc.com,
	quic_shijjose@quicinc.com, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v9 0/5] arm64: qcom: sa8775p: add support for EP PCIe
Message-ID: <20240216105241.GB2559@thinkpad>
References: <1701432377-16899-1-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1701432377-16899-1-git-send-email-quic_msarkar@quicinc.com>

On Fri, Dec 01, 2023 at 05:36:11PM +0530, Mrinmay Sarkar wrote:
> This series adds the relavent DT bindings, new compatible string,
> add support to EPF driver and add EP PCIe node in dtsi file for
> ep pcie0 controller.
> 

Applied patches 3 and 4 to pci/endpoint!

- Mani

> v8 -> v9:
> - update author in "Add pci_epf_mhi_ prefix to the function" patch.
> - add ack by and reviewed by tag in commit message.
> 
> v7 -> v8:
> - Add new patch PCI: epf-mhi: Add "pci_epf_mhi_" prefix to the function
>   names
> - Update PCI: epf-mhi: Add support for SA8775P patch on top of the new
>   patch and update commit message.
> 
> v6 -> v7:
> - add reviewed by tag in commit message in all patches.
> - update commit message in patch 2 as per comment.
> - update reason for reusing PID in commit message.
> 
> v5 -> v6:
> - update cover letter.
> 
> v4 -> v5:
> - add maxItems to the respective field to constrain io space and
>   interrupt in all variants.
> 
> v3 -> v4:
> - add maxItems field in dt bindings
> - update comment in patch2
> - dropped PHY driver patch as it is already applied [1]
> - update comment in EPF driver patch
> - update commect in dtsi and add iommus instead of iommu-map
> 
> [1] https://lore.kernel.org/all/169804254205.383714.18423881810869732517.b4-ty@kernel.org/
> 
> v2 -> v3:
> - removed if/then schemas, added minItems for reg,
>   reg-bnames, interrupt and interrupt-names instead.
> - adding qcom,sa8775p-pcie-ep compitable for sa8775p
>   as we have some specific change to add.
> - reusing sm8450's pcs_misc num table as it is same as sa8775p.
>   used appropriate namespace for pcs.
> - remove const from sa8775p_header as kernel test robot
>   throwing some warnings due to this.
> - remove fallback compatiable as we are adding compatiable for sa8775p.
> 
> v1 -> v2:
> - update description for dma
> - Reusing qcom,sdx55-pcie-ep compatibe so remove compaitable
>   for sa8775p
> - sort the defines in phy header file and remove extra defines
> - add const in return type pci_epf_header and remove MHI_EPF_USE_DMA
>   flag as hdma patch is not ready
> - add fallback compatiable as qcom,sdx55-pcie-ep, add iommu property
> 
> 
> Manivannan Sadhasivam (1):
>   PCI: epf-mhi: Add "pci_epf_mhi_" prefix to the function names
> 
> Mrinmay Sarkar (4):
>   dt-bindings: PCI: qcom-ep: Add support for SA8775P SoC
>   PCI: qcom-ep: Add support for SA8775P SOC
>   PCI: epf-mhi: Add support for SA8775P
>   arm64: dts: qcom: sa8775p: Add ep pcie0 controller node
> 
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 64 +++++++++++++++++++++-
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi              | 46 ++++++++++++++++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c          |  1 +
>  drivers/pci/endpoint/functions/pci-epf-mhi.c       | 21 ++++++-
>  4 files changed, 128 insertions(+), 4 deletions(-)
> 
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

