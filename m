Return-Path: <linux-pci+bounces-33165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 461F2B15D5E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 11:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECEBE166C9E
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 09:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3669D293C47;
	Wed, 30 Jul 2025 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBFMp/Qt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0364D293B5F;
	Wed, 30 Jul 2025 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869186; cv=none; b=tAtN9Ku0egDeIkg+bGuc0JTX3cAxrHaWYEaeP/RiPpAM0C1QXQTzb+os7ISaaYliNHkOITxKUpwUPJpZ3W8EksR/C84VPfspLN34JjJD/BfoIDuee6B8PWH2TUI9UWQvbZqB/cBY7C/Hf8xZOMqab7HGDBRDZTI6wBlhdmXtiaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869186; c=relaxed/simple;
	bh=5Mrrxi9bNBL8D/ee8NRHVOpef29mu452vpZ0ynsESPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4ghz3QOxrQGdQ/BvQy2ljlgQc4VJBl2ATueZwimoZkx4z/+/sKWxPKt54FKGb66uXAlIBPrEXhuZaB6JQHjKdtmIWSFBPlDLaaMGqvCuEuDL71wslRNam4tspxXontRz7AYkmQoNlsoCmvLTuR4P1b2dUJAY6B02JcL1JWl9S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBFMp/Qt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800FEC4CEF5;
	Wed, 30 Jul 2025 09:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753869185;
	bh=5Mrrxi9bNBL8D/ee8NRHVOpef29mu452vpZ0ynsESPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBFMp/QttoquzlQynDEx48o4qachvu35Xu5wgZEi84KHfxF4/7NqsilYzjh3g2E0P
	 sTWvy+MuYy8KQX/MM1bm4VvGV1Re+e6/YkCDfkl9dHJJBoQeg1SOKrsZ5TiGlBwmWj
	 +AHIZbOIQcpQLrLyq9f9WXlHZwt6RbsI1JG2ypJ9YkZaLh5upPYBOCyIR4dv28xPt/
	 Z6ykRMiyzfbqpEkQLGU8OZictU0I76H5hlEsSK5rBP6tguIm2HHDhvJDMKBVL4n/zL
	 c0ExIvaQ2ayGvunrFFAcOFcg2eRK1dg6XfrmlZU/3SS2ydvN0p2sM+GKvBk7C+YI/P
	 QODw0LxLr1CXQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uh3Ug-000000006Gw-0XOb;
	Wed, 30 Jul 2025 11:53:06 +0200
Date: Wed, 30 Jul 2025 11:53:06 +0200
From: Johan Hovold <johan@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, neil.armstrong@linaro.org, abel.vesa@linaro.org,
	kw@linux.com, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org,
	qiang.yu@oss.qualcomm.com, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com
Subject: Re: [PATCH v7 2/3] arm64: dts: qcom: sa8775p: remove aux clock from
 pcie phy
Message-ID: <aInrgnGsBSVpxrWE@hovoldconsulting.com>
References: <20250725102231.3608298-1-ziyue.zhang@oss.qualcomm.com>
 <20250725102231.3608298-3-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250725102231.3608298-3-ziyue.zhang@oss.qualcomm.com>

On Fri, Jul 25, 2025 at 06:22:30PM +0800, Ziyue Zhang wrote:
> The gcc_aux_clk is used by the PCIe Root Complex (RC) and is not required
> by the PHY. The correct clock for the PHY is gcc_phy_aux_clk, which this
> patch uses to replace the incorrect reference.
> 
> The distinction between AUX_CLK and PHY_AUX_CLK is important: AUX_CLK is
> typically used by the controller, while PHY_AUX_CLK is required by certain
> PHYs—particularly Gen4 QMP PHYs—for internal operations such as clock
> gating and power management. Some non-Gen4 Qualcomm PHYs also use
> PHY_AUX_CLK, but they do not require AUX_CLK.
> 
> This change ensures proper clock configuration and avoids unnecessary
> dependencies.
> 
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>

With the fixes tag added (Konrad's comment should be picked up by the
maintainer/tooling, no need to resend for that):

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

