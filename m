Return-Path: <linux-pci+bounces-33164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D1CB15D3D
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 11:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E4D564651
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jul 2025 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9FA26D4F9;
	Wed, 30 Jul 2025 09:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqi+/lTL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05AA275AE9;
	Wed, 30 Jul 2025 09:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869093; cv=none; b=q6Iyb9DGPuCicMrQ93/9WFieqdq/QbY9SkjmCnyJ5NCkh7NoYc4CnsrhVE6aP14SDEF8OhOMWUa1wp51Taru0fDkvw7mK2GRUwd9Q7ROaW6TfyMsd1p4ItYvhKltWi/tufa0euvIsKZJwR4VkOqhqNT8PTm0KeNE9UqiBFzDHF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869093; c=relaxed/simple;
	bh=uUO5w+7fXASYNU9Kt8APciPnhPDC3kbEVI7LeC/Sc4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXGMKIl9X8hly3UrHgmUQERq5UcZB7+KKNAIWb/nLfl03ISZgLmIVWwYY+JRbkxz2y9OJJkipmYremS4sz/d4kot+d34BopxVc+NzIIrkh/sDx+3J1XDTljz+a2isrej9NRGePHAS0FsIB5QBjoTU0qWOauCRf9xenXXQnUe36U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqi+/lTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0DAC4CEF5;
	Wed, 30 Jul 2025 09:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753869092;
	bh=uUO5w+7fXASYNU9Kt8APciPnhPDC3kbEVI7LeC/Sc4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zqi+/lTLLKqTT3gUTKNdXehod98TDjxVREm0tnOYwfqqbR9mv/KBI4JWcyEDPCVHw
	 O3QTfI7RmT5L4nX22c8XHVf8ZkW97GFLYZNQ1BjndCHwOOHmyPj0tyCVIwZUGBBcv/
	 B4P3bQg829uFoSmX9dEigr9agioqbZlqfcoHfnbZGZKtqz464YUSXQzoj5lWWT+wAx
	 z2zwsmn39eVS1hjGOhoMKmUGMRHXRYwF2DSDXxbVCbumq11pULQBhLpi3gSfA/3JMW
	 wPxQfbYuBdTkyAsdvTxHJyt0Fnw7C+4c9LztCSJS3AN7rwYApLCna/kDNsIF43PaNd
	 cprISPI3KpLew==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uh3TB-000000006FV-1CuA;
	Wed, 30 Jul 2025 11:51:33 +0200
Date: Wed, 30 Jul 2025 11:51:33 +0200
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
Subject: Re: [PATCH v7 1/3] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings
Message-ID: <aInrJT5A0EZwzwrb@hovoldconsulting.com>
References: <20250725102231.3608298-1-ziyue.zhang@oss.qualcomm.com>
 <20250725102231.3608298-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725102231.3608298-2-ziyue.zhang@oss.qualcomm.com>

On Fri, Jul 25, 2025 at 06:22:29PM +0800, Ziyue Zhang wrote:
> The gcc_aux_clk is required by the PCIe controller but not by the PCIe
> PHY. In PCIe PHY, the source of aux_clk used in low-power mode should
> be gcc_phy_aux_clk. Hence, remove gcc_aux_clk and replace it with
> gcc_phy_aux_clk.
> 
> Fixes: fd2d4e4c1986 ("dt-bindings: phy: qcom,qmp: Add sa8775p QMP PCIe PHY")
> Signed-off-by: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

