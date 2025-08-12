Return-Path: <linux-pci+bounces-33857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EC2B224A9
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 12:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2EC03B84F9
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 10:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9D42EB5D4;
	Tue, 12 Aug 2025 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/18jpML"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6932E9EA1;
	Tue, 12 Aug 2025 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754994812; cv=none; b=sZQDluAw+1eOLvGdT2ADRZGb8a93slPJTCALIxIL3R+bafEdQhjW/3N9Tm3tA6jzJETGUNPdlUZ9C9XBf5TQOBBaVpg0VPC6rQ0Sv8Sm58xi0KbqaX0qstgcar+Mtf+9citFIAJw5me+sfDk+hDFmPCqz6WHuKGFddEQ1IJa/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754994812; c=relaxed/simple;
	bh=NrSTn5crAr7ZLQY3cQ0AurAdvBSzrxB5k9V4PIfyaq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSwiZGvTU+ZwflaY75rANR1RIBKbzvDEzdJ71OKFFg1o/q64VA7TsUzu+7PcOiJsn8fErW8HotSlHz4k/wSGVOgZoBFnzNKtpXtm6H+rBSBW5ItaCUY7aYa+LMGTY94M99UpcsJRXn5Cbbvk0M7hV3d3nMNBpjshcE1e5CF3NNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/18jpML; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87345C4CEF0;
	Tue, 12 Aug 2025 10:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754994812;
	bh=NrSTn5crAr7ZLQY3cQ0AurAdvBSzrxB5k9V4PIfyaq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/18jpMLrqn95RuAHTMYpKZPJOBjQyZ4el76bHIQazX7WMYQoQ5Yk6d8A3ZMGAjHt
	 WEL0KBSv7Bu2+e09B+gKCc8g6OWgo44VsZCzYor7Nv87ruSTLQzzvdT5D0B8KqCQ98
	 hdYJnPxtxZ+o0F+c91uK7rdyH4ttGaVt1lIxOJe9Hl6iPIW57UW3AOyXWfiAly5M00
	 Izvc33f7lBmLueiB8l/bts/Jgo/L3Nup8tcuAeSUpRyGSiNp+T0AiTRggdI3A4YNOS
	 2zmDnx3KuIajgNIC7I8eijwXPoU+2sCN2U3ZQQ26ZRUcVbasi9PiRQYGHBdNpAFco6
	 vkQrMwPKItBig==
Date: Tue, 12 Aug 2025 16:03:27 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com,
	mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, johan+linaro@kernel.org, kishon@kernel.org,
	neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v10 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Update pcie phy bindings for qcs8300
Message-ID: <aJsYd7tAi4CdOfZ9@vaman>
References: <20250811071131.982983-1-ziyue.zhang@oss.qualcomm.com>
 <20250811071131.982983-2-ziyue.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811071131.982983-2-ziyue.zhang@oss.qualcomm.com>

On 11-08-25, 15:11, Ziyue Zhang wrote:
> The gcc_aux_clk is not required by the PCIe PHY on qcs8300 and is not
> specified in the device tree node. Hence, move the qcs8300 phy
> compatibility entry into the list of PHYs that require six clocks.
> 
> Removed the phy_aux clock from the PCIe PHY binding as it is no longer
> used by any instance.

This does not apply on phy tree, please rebase

-- 
~Vinod

