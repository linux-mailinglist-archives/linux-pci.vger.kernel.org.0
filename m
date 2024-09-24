Return-Path: <linux-pci+bounces-13443-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D00039847EC
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 16:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 693D3B2259E
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 14:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37801AAE1C;
	Tue, 24 Sep 2024 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0iYzkAl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC0B1A4F1A;
	Tue, 24 Sep 2024 14:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727189017; cv=none; b=khLjaQjxXW7ixQNLH/gM5D7pvt7txwzVwIEeTcXPysrqowK8C2hFTq99nVbEWrIKKCXrN6DyefTWNHp6jURKyUuyqSHX52Heq4kqchF5UsZWiQTjgmksCbokYVLSCvHVdMt7VTWqTiEAV2N+i/lpv67sUEE1NeshfBKc7B/HJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727189017; c=relaxed/simple;
	bh=pOaHZ6plz4suPJ1XBTKEDW62gJ6vaUp6YI0Xg5UnEJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqMuglUylRT+90kly95Jm08uE1rdj+uHDtLA+aXlh79a4UkOFVt+Z71BTw7yQFlyXZCYTjYcrC6F4I0c5BM/4uFKco+idWhTawuQxsJ7pHQdB/th+3lMfTAO140/YDqAsiuFGfcmjqwd3WJKjidEcSkMyIH0W5ejL9e7bwW76G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0iYzkAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7016C4CEC4;
	Tue, 24 Sep 2024 14:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727189017;
	bh=pOaHZ6plz4suPJ1XBTKEDW62gJ6vaUp6YI0Xg5UnEJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0iYzkAlrug1n0IlZLSOlXgS7VzKLvmGRnHbPrFvuk1ebJ2jfkbjAt7RDSNQu8cEY
	 6xew5dKI+u1EluWlLX9zdJayzHIF8FecsHZ0sNBdbHFo0yLbhprKzkGsC9FkzYKMtc
	 wMwBvwnlX3JtI4W6LILP1OBBY58nmCRuFLCRoFjhscmGbdRB0hSx1+mX9G0V54WpIG
	 VcnGgbQr+RU7MzypMtniDWpGsOQzruhSyD74Ffvkepuxk4ZIgJKjIfy4DS/OR4FWEf
	 sCB6d7EwemR6SE3FQApy6cvIKM7crIC0laMKlXN2DWgsGBmmcFcLNPj0lUU5xln6ZN
	 uDsypDFZm0XPw==
Received: from johan by theta with local (Exim 4.98)
	(envelope-from <johan@kernel.org>)
	id 1st6lJ-000000001KR-1x2Y;
	Tue, 24 Sep 2024 16:43:33 +0200
Date: Tue, 24 Sep 2024 16:43:33 +0200
From: Johan Hovold <johan@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: x1e80100: Add support for PCIe3
 on x1e80100
Message-ID: <ZvLQFSjwR-TvHbm_@hovoldconsulting.com>
References: <20240924101444.3933828-1-quic_qianyu@quicinc.com>
 <20240924101444.3933828-7-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924101444.3933828-7-quic_qianyu@quicinc.com>

On Tue, Sep 24, 2024 at 03:14:44AM -0700, Qiang Yu wrote:
> Describe PCIe3 controller and PHY. Also add required system resources like
> regulators, clocks, interrupts and registers configuration for PCIe3.

> @@ -2907,6 +2907,208 @@ mmss_noc: interconnect@1780000 {
>  			#interconnect-cells = <2>;
>  		};
>  
> +		pcie3: pcie@1bd0000 {
> +			device_type = "pci";
> +			compatible = "qcom,pcie-x1e80100";

> +			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 769 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 671 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi0",
> +					  "msi1",
> +					  "msi2",
> +					  "msi3",
> +					  "msi4",
> +					  "msi5",
> +					  "msi6",
> +					  "msi7",
> +					  "global";

This ninth "global" interrupt is not described by the bindings, which
would also need to be updated. What is it used for?

Johan

