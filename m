Return-Path: <linux-pci+bounces-33161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 122B7B15CB5
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 11:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C11797B2272
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 09:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D844293C4E;
	Wed, 30 Jul 2025 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZJdT2gL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3C928DF0B;
	Wed, 30 Jul 2025 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868688; cv=none; b=SCpxZyL6QmKpguR3tyRxTKVJ621H8CvSY0jp7gq4cSEJWKO4IlEuv2EzM3Bj70tLwd2srdXvgSXHGnbNJvufAFV0ct0iZUK1GtznRrVGo57Dojy1x+G2JrKUf+pxSS8FadVPlcchaaRrTYFkROp08lsrsIXoNt8ta4w6PLQRFIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868688; c=relaxed/simple;
	bh=3gbYmPhcx8qD++tA3CAoIbyGPx2C4HSjIfSsdy3LXHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aev2KspDkCa6W3tT8DNPuxF90iJKaBJZQMzeq0I0HZwji/8VXbcu5DXkIE5G3O7Hrkxf+BKeo1sWcomBXri//TOfsErnxNwWQsPq4nk2zvUaB6mvvk9R2pytRX/oCo6Ck0FAbTyQ2h91wIylhBx3nOIqGXd67l9qwPfLfRf8jaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZJdT2gL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A945C4CEF8;
	Wed, 30 Jul 2025 09:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753868688;
	bh=3gbYmPhcx8qD++tA3CAoIbyGPx2C4HSjIfSsdy3LXHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZJdT2gLcJWX1FifCJ1BZjfIUx6sOM97Gyq6ZIrg7xeDEJCinPLTMZorl8mQEG5dF
	 sYQxun9szJ2zXtYqVeDYvH6RnIQmQcQ/S6lUkgingAB4J6uEtrE1WCctb9/gXmnQwk
	 DF/jrGQTVDQQv52Pu5RWW4Jz95m8MRudbR/0v4wjwtmfvqrghwUUxXKl+naBIJmdlh
	 1WignbenJNKbPwc5qFIWiGOOUj199t2wk3eBRBB0TRwb/VeP28yL6et7bC/oVw4jxz
	 6Su+SYzk3YHAt+9rLx+8wMYmCzj1Y32P3A24tqXPWTdQvrViKIhcL8PMrtM8UZNsh9
	 EphX/U1ML9xug==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uh3Me-0000000069K-2uuW;
	Wed, 30 Jul 2025 11:44:48 +0200
Date: Wed, 30 Jul 2025 11:44:48 +0200
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
Subject: Re: [PATCH v6 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings
Message-ID: <aInpkGotRQcsRBdo@hovoldconsulting.com>
References: <20250725095302.3408875-1-ziyue.zhang@oss.qualcomm.com>
 <20250725095302.3408875-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725095302.3408875-2-ziyue.zhang@oss.qualcomm.com>

On Fri, Jul 25, 2025 at 05:53:00PM +0800, Ziyue Zhang wrote:
> The gcc_aux_clk is required by the PCIe controller but not by the PCIe
> PHY. In PCIe PHY, the source of aux_clk used in low-power mode should
> be gcc_phy_aux_clk. Hence, remove gcc_aux_clk and replace it with
> gcc_phy_aux_clk.
> 
> Fixes: fd2d4e4c1986 ("dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe PHY")
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

