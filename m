Return-Path: <linux-pci+bounces-33162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E218B15CE5
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 11:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE25E5A2817
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 09:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E7F2957AD;
	Wed, 30 Jul 2025 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvn1vn5J"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA592957C3;
	Wed, 30 Jul 2025 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753868814; cv=none; b=b2UrZs+rbGRxKK90CizWte+yZnPwKtzW3q5+l2TVeN133kZQjbw+Rl74AsESUqHOrSj3iHpcr5OMwZNal4xnNF4WX4ljnqx3xdmEgCzwp6XzDj4krZocPBpME+Va7+VKr4MJI2YQkpUmg4bax8dstbIsHngXlIFUpEg7RXOXyWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753868814; c=relaxed/simple;
	bh=ZsuZO+RMew8FjNZ63X1kweLqkn98ggjS7FcHOVhGvxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ja85eWh0kHL5Jr2mhPdpR4gvr7II5QQ9CdaWnAGqZBEwi44VdiK1Q7vZB2Fn+m3wxr/okvty7frEzxApE7PqL8ctweSzpcrLTxYVmu/6W7SMJU+OLYbeE0fIGYn6//1pvhQ55t8Syk1hK1Lpc0puW0NlSbBECp1khrh4KkPjPD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvn1vn5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78473C4CEFA;
	Wed, 30 Jul 2025 09:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753868814;
	bh=ZsuZO+RMew8FjNZ63X1kweLqkn98ggjS7FcHOVhGvxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kvn1vn5JOED55dY/l8REYApdhPJFhwa8B14ciG2x2pqM17BMyJaus7UiVgCfYUM7S
	 +5gFSxmDtONn3mnl+rMfhAlyTyE3yOibUODYATM0RpdhXgAJTGJajNeazmjRHVy2So
	 z8UhRgjqfoIQy3WiE3v3OmkRPRyhVKD0AOHVeP7hhro6FpaAU1tykCYhqhaoznCeEM
	 zaGke4QnNtAt2uLtse8Rofzxu98JuC8CdEp2h/v1/bXRZ4528Zbpa1vIknBdNzZ2UF
	 bSMmJQzOELCh9T9DjrOdIWT3Et4uRgjuKs4W/XGhqs0wRSRdRxqYSsg8If3qPnEvit
	 gRVzETZa/De9A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uh3Oh-000000006BH-0ATp;
	Wed, 30 Jul 2025 11:46:55 +0200
Date: Wed, 30 Jul 2025 11:46:55 +0200
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
Subject: Re: [PATCH v6 2/3] arm64: dts: qcom: sa8775p: remove aux clock from
 pcie phy
Message-ID: <aInqD8DeqRe8V_H2@hovoldconsulting.com>
References: <20250725095302.3408875-1-ziyue.zhang@oss.qualcomm.com>
 <20250725095302.3408875-3-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250725095302.3408875-3-ziyue.zhang@oss.qualcomm.com>

On Fri, Jul 25, 2025 at 05:53:01PM +0800, Ziyue Zhang wrote:
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

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

