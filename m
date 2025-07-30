Return-Path: <linux-pci+bounces-33163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6D9B15D02
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 11:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CF018C4495
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 09:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6330293454;
	Wed, 30 Jul 2025 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hiBXEMap"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94314292B5F;
	Wed, 30 Jul 2025 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868887; cv=none; b=tu/ND2DyUKWqg3l4d3rGiDIFA8F3SYaf5k5TVVuF5ekRLXYEWSO9fuVA06kKOxF9GEE8v6kgghABDtTCQBIefVUuZMSHjlN/CZpprDqUB7Cex0Pan3VUKFfmVDJj0DpO/E6tkNDQ1EoakMCRHTOjhD2xUqd9+7qhwYMIgVMkypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868887; c=relaxed/simple;
	bh=8YrxCuXCK98kwQnH2GEjHBy78tJhFnVfKZEbIqP+f1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sR+l7no+eTtEzpL4UY1BuXzb1naYKoXYJVYvt8WpwI86zhaKOy7cx+zw/pMIjKvvWtdSD49h7mciWBKjsu9ptMx2uQKp+bUi5zdWTBgCo6WZTmFIA3dLvRmOvA4fumJ3J7jGtVDTbzgN4Pl/qJhTJe46RawHPjxLsBlNokc+Jt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiBXEMap; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCA3C4CEF5;
	Wed, 30 Jul 2025 09:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753868887;
	bh=8YrxCuXCK98kwQnH2GEjHBy78tJhFnVfKZEbIqP+f1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hiBXEMapNuIohdzdO4nE/XGyfIAfvbU+vj/sOuZJ1kJ/A5OYjPQ0aKr0A39hxjDPV
	 mpqQBILoTuVqQwmtPQq2tPcC8SUW71oZM1LYputhKCJCTNe7tilQHbwEZuHJ2JsfgH
	 KRcnQ+aJRZ1I+ZVBkuskWnXuimg9qHmwix44evQABHp/NS4SXHhFbbKLPkiBKYGtRe
	 tfCxh5jzs/2EYYaI/ywEwZGjCMPXQGGsnzoS8onVL1d424nd6vuzeaSzsj591aY37a
	 quDhI8p1oprtEWTvjTRim6rxYXqpdjaDWwwLGl7EuelWl+1Mz08R/wNtt+//eFa09t
	 FLnnUDqcxLdVg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uh3Pr-000000006CL-3rL5;
	Wed, 30 Jul 2025 11:48:07 +0200
Date: Wed, 30 Jul 2025 11:48:07 +0200
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
Subject: Re: [PATCH v9 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for qcs8300
Message-ID: <aInqV5IEAN9LRvFV@hovoldconsulting.com>
References: <20250725104037.4054070-1-ziyue.zhang@oss.qualcomm.com>
 <20250725104037.4054070-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725104037.4054070-2-ziyue.zhang@oss.qualcomm.com>

On Fri, Jul 25, 2025 at 06:40:33PM +0800, Ziyue Zhang wrote:
> The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
> specified in the device tree node. Hence, move the qcs8300 phy
> compatibility entry into the list of PHYs that require six clocks.
> 
> Removed the phy_aux clock from the PCIe PHY binding as it is no longer
> used by any instance.
> 
> Fixes: e46e59b77a9e ("dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the QCS8300 QMP PCIe PHY Gen4 x2")
> 
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

