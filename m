Return-Path: <linux-pci+bounces-31835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3BBAFFE5D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 11:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE24F1BC42AE
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 09:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5B22D3ED2;
	Thu, 10 Jul 2025 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pvzNd9W7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7572F2D0298;
	Thu, 10 Jul 2025 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752140643; cv=none; b=gPzQlNvneb6FxcK2Maq1QMjaLr/PiiJ7Jkb8eQS7rzUrdUrZdc98KcjhSgcJEvJ2uSwJOnv1PRIX/WpjgM2FYKN/DaU9AT3xCuz0woHf44VUPdmPbBL13LpyhawCqUzKsA7n1gN0APFa8ElshzzTa/5Vng7lwNHpL1rY7cjTB98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752140643; c=relaxed/simple;
	bh=OU/QsfAeucBR7oxpGsODCpofrzQWdr3cYK9kvHOY4ZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPppLUjJr+E7rm7Z74ur2pbxzrL/INX12YUQcDtR96BcBtr6yjd4DbKHmZpjPAg4EYuFF66sUAm4K3UGopBYh9V7EwJEfkTgSin1eb3hZ4gQrTUCAKu0i/k1tQpYSi530hrNKz3fxo5VesTyeRN7mKPDYK5YJneqDJOoy1lUXr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pvzNd9W7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BF7C4CEE3;
	Thu, 10 Jul 2025 09:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752140643;
	bh=OU/QsfAeucBR7oxpGsODCpofrzQWdr3cYK9kvHOY4ZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pvzNd9W7F14LZ3NMVuHlyMTdYHIrwMlvFjwNtGXVr4y167/5oI1u7CcdXC/sjHx71
	 hUQtWyFvsO9ZuR2nf10JExVRH+94fBSNGCHWwJ+42/sl9pTzeEnvcGMoFQY2k2JRu0
	 z4SqFNbCK1nBpztddMsK1cV97KkcJz/xxpxctuMFxXGDMP00Oe3P+r5z7Z7QSBMuiH
	 BmPTJaERj5540O+cAS0L8YzdbfBiwglRH+jR470UksWJGPCZApPAwTlygv0mdGphjj
	 kcDiEe0VAJsfOx42rnaiIei/vb6JzitZnmxk5ceHRQ/S+cfYqqpZnF9U2/gGTecjCb
	 tUdHzPBAIN1yA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uZnop-000000007hu-3HaY;
	Thu, 10 Jul 2025 11:43:55 +0200
Date: Thu, 10 Jul 2025 11:43:55 +0200
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Ziyue Zhang <quic_ziyuzhan@quicinc.com>
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
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: sa8775p: remove aux clock from
 pcie phy
Message-ID: <aG-LWxKE11Ah_GS0@hovoldconsulting.com>
References: <20250625090048.624399-1-quic_ziyuzhan@quicinc.com>
 <20250625090048.624399-4-quic_ziyuzhan@quicinc.com>
 <25ddb70a-7442-4d63-9eff-d4c3ac509bbb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25ddb70a-7442-4d63-9eff-d4c3ac509bbb@oss.qualcomm.com>

On Fri, Jun 27, 2025 at 04:50:57PM +0200, Konrad Dybcio wrote:
> On 6/25/25 11:00 AM, Ziyue Zhang wrote:
> > gcc_aux_clk is used in PCIe RC and it is not required in pcie phy, in
> > pcie phy it should be gcc_phy_aux_clk, so remove gcc_aux_clk and
> > replace it with gcc_phy_aux_clk.
> 
> GCC_PCIE_n_PHY_AUX_CLK is a downstream of the PHY's output..
> are you sure the PHY should be **consuming** it too?

Could we get a reply here, please? 

A bunch of Qualcomm SoCs in mainline do exactly this currently even
though it may not be correct (and some downstream dts do not use these
clocks).

Johan

