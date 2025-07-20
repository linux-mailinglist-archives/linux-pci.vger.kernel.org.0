Return-Path: <linux-pci+bounces-32596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A4FB0B324
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jul 2025 04:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E93097ABAC8
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jul 2025 02:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDF614F9FB;
	Sun, 20 Jul 2025 02:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj4EYbdL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF381F92E;
	Sun, 20 Jul 2025 02:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752977232; cv=none; b=qjtjWIrwJ5wglv6znR3OBHW+IWbaEs+ZmZAj+Ho52h1/LAhRzFhzfRmeGeqxDvfAjRitl+xGBsfWvzVAjyrfl5Km1P9DIWI5EyPmT/2GMP+J2f92pTSxtcXm8GgDSAmi5rydSskVia4JFufDI7n6mND26sWwjjBcJ82skKiuoGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752977232; c=relaxed/simple;
	bh=duEgnSqN7VZ25CtEj1NJ+N/NS03iMSFE94CX4KQIj90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrNkforNtBA/gODs3uXGNY1iFlUUnq+RgKahKihechlVtmzxb20d4KRQZCMjg7aAhDWwXIQ5ImxAN9T5QeGdtWvs3XMUB/g4K/FW3hmv2UTZeofqQQr5wp+xrEwroLD960+LCgQ2KqUEgfEq9IWy0u3buUBvalLs8Z/KD2cnbzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gj4EYbdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64EEC4CEE3;
	Sun, 20 Jul 2025 02:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752977232;
	bh=duEgnSqN7VZ25CtEj1NJ+N/NS03iMSFE94CX4KQIj90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gj4EYbdLYW+0r+owZYcELTUhXlaUjLr6Z+7bF3/8LIkSXQHLgGU86NwXD8JxhvHjF
	 iyEhoMfCa1PRRXRY3VkvEwZaVk7Q8UXalKZQGaQdQwQc8r2AFfOwyduSTA7rpU3zl7
	 qkI8Mju7wlzV46xYJTMA5gSYgo+GFCzZcIVaiZ/hxuzl/r3F3Dw9nMycQGRt5to/Gw
	 bYsvIsY9wRnNpqoxYTu7slDPax6L21oPIfMgZslKdhRJoSw0w5D3mtv0DCcwQRGJgz
	 FNjm0kuUgeUswCmHXRnUCvfTnsB9zoUJgfnclaJwEGsoIwut/2Ld3kjbSA3J+YsCvb
	 SyaEvYjC0bhFA==
Date: Sat, 19 Jul 2025 21:07:11 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, jingoohan1@gmail.com,
	qiang.yu@oss.qualcomm.com, johan+linaro@kernel.org,
	quic_vbadigan@quicinc.com, krzk+dt@kernel.org, bhelgaas@google.com,
	linux-arm-msm@vger.kernel.org, quic_krichai@quicinc.com,
	kishon@kernel.org, andersson@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kwilczynski@kernel.org, lpieralisi@kernel.org, mani@kernel.org,
	neil.armstrong@linaro.org, conor+dt@kernel.org, kw@linux.com,
	konradybcio@kernel.org, vkoul@kernel.org,
	devicetree@vger.kernel.org, abel.vesa@linaro.org
Subject: Re: [PATCH v5 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings
Message-ID: <175297718511.927073.3298628726286160154.robh@kernel.org>
References: <20250718081718.390790-1-ziyue.zhang@oss.qualcomm.com>
 <20250718081718.390790-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718081718.390790-2-ziyue.zhang@oss.qualcomm.com>


On Fri, 18 Jul 2025 16:17:15 +0800, Ziyue Zhang wrote:
> The gcc_aux_clk is required by the PCIe controller but not by the PCIe
> PHY. In PCIe PHY, the source of aux_clk used in low-power mode should
> be gcc_phy_aux_clk. Hence, remove gcc_aux_clk and replace it with
> gcc_phy_aux_clk.
> 
> Removed the phy_aux clock from the PCIe PHY binding as it is no longer
> used by any instance.
> 
> Fixes: fd2d4e4c1986 ("dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe PHY")
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

Missing tags:

Acked-by: Rob Herring (Arm) <robh@kernel.org>




