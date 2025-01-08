Return-Path: <linux-pci+bounces-19557-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C06A0647D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 19:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B38C53A6DCD
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 18:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57501202F8F;
	Wed,  8 Jan 2025 18:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHD4sULt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C72D202F80;
	Wed,  8 Jan 2025 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361158; cv=none; b=GQIbNoh+LyaTjMdumW7/xRlLUhAk7Bb5Y2XmOoh2o4PpUQFVgdWOwnYud+hxcF+U2gZtavDITfV35CSHod5Y1R2HgBS9UIibylh+sxV+IqbMCAkzYmCuzSDGpuD2sGxANri76oELlMCawen8yWwRL145+H41CJy0VqUd914tV1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361158; c=relaxed/simple;
	bh=Z/FqmlnQQ8Fa68j6bChFWC2DGBjzCnP8xsatoFHrFa0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TP4d3E7eLHVsalBM7d/FfRHyF5hyJ1CN4USzwgPkMwTYmlxXNGyLH4I/7UmIljSbj3WZRfHEaKYvMpsvwF34OefmgD9GR7MfBtqbouZ9ukwJavpn0iuFX8v4T82txlezueFNjJ4+aAHGrSrH0xHeqpXu08cLq8586VMbONtv0wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHD4sULt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552D0C4CED3;
	Wed,  8 Jan 2025 18:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736361157;
	bh=Z/FqmlnQQ8Fa68j6bChFWC2DGBjzCnP8xsatoFHrFa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iHD4sULtcyZpUayPhFv//GcGoNSqVRYgJYE9OKm5cbptvdlJ25utVjJ16eJHkr8q7
	 YQaZkhGDSMeS+BDw39V0F8H4M55gcqks3fNM8e+ugbd6/fv+LHq/x2SGRwHfJ1rnpn
	 iijBj0rfqdehYltGY6K2pGlFEyz1hfNGslo3V/tAdm8QMTswXGIteTclvIwz4zNKuH
	 n4kItXVF/sjHioGsqhafWgZzQP7UtYfQ2tBXTxwmjwzyVPrZD36YQJGgFcGR4w/fPy
	 MieYAlJNDLzlSAq70NftG/76gIto5sLe6w/j4KxIgHPIDMxBkO/kZhBU18/Tqppuvd
	 z+BDbheJqLOdQ==
Date: Wed, 8 Jan 2025 12:32:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com,
	dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Praveenkumar I <quic_ipkumar@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/5] arm64: dts: qcom: ipq5332: Add PCIe related nodes
Message-ID: <20250108183235.GA220566@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250102113019.1347068-5-quic_varada@quicinc.com>

On Thu, Jan 02, 2025 at 05:00:18PM +0530, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Add phy and controller nodes for pcie0_x1 and pcie1_x2.

> +		pcie1: pcie@18000000 {
> +			compatible = "qcom,pcie-ipq5332", "qcom,pcie-ipq9574";
> +			reg = <0x00088000 0x3000>,
> +			      <0x18000000 0xf1d>,
> +			      <0x18000f20 0xa8>,
> +			      <0x18001000 0x1000>,
> +			      <0x18100000 0x1000>,
> +			      <0x0008b000 0x1000>;
> +			reg-names = "parf",
> +				    "dbi",
> +				    "elbi",
> +				    "atu",
> +				    "config",
> +				    "mhi";
> +			device_type = "pci";
> +			linux,pci-domain = <1>;
> +			bus-range = <0x00 0xff>;

This bus-range isn't needed, is it?  pci_parse_request_of_pci_ranges()
should default to 0x00-0xff if no bus-range property is present.

> +			num-lanes = <2>;
> +			phys = <&pcie1_phy>;
> +			phy-names = "pciephy";

I think num-lanes and PHY info are per-Root Port properties, not a
host controller properties, aren't they?  Some of the clock and reset
properties might also be per-Root Port.

Ideally, I think per-Root Port properties should be in a child device
as they are here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/pci/mvebu-pci.txt?id=v6.12#n137
but it looks like the num-lanes parsing is done in
dw_pcie_get_resources(), which can only handle a single num-lanes per
DWC controller, so maybe it's impractical to add a child device here.

But I wonder if it would be useful to at least group the per-Root Port
things together in the binding to help us start thinking about the
difference between the controller and the Root Port(s).

Bjorn

