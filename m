Return-Path: <linux-pci+bounces-29032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8D0ACF0C3
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 15:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 974B37A71A5
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 13:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A693A25A655;
	Thu,  5 Jun 2025 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC0PUAhy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AA925A624;
	Thu,  5 Jun 2025 13:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130482; cv=none; b=pddAxoBbNe9B1F1uEpcQ9aRTgtTJ1CCTkBu1W0Bw5xpLxTjlWmi7JiCR9VasTIkwxP1t3kP9E1U7DyStzlL0OudWnMGGymSpWSgFlbluG9VZYFhPVoJDH6/q+JieTLfTBPI42VhhiSOUPLf4mxw+Pv+7uKcXIIDmqRDVjscYzp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130482; c=relaxed/simple;
	bh=tIUVMv9gs+dT5DU2bOwZUxjG0y4WXjj+4BeBzl2tPts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOSFF/yzwAcdH9njS1gZIgK8IYMjQpgSjEwcUSHBrCo7GDX9w7jFQ7u3nuYpZB+WV8xt/WyBp4WUBFWNnXiZFZzKharqiQWuHobH3RJ+XtSZcc6IJXUooABUa7J6vJYBqQe9ymOVceqJwO5CXy7DdMRGaJj/XYYlM70JDtaWxXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC0PUAhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0F1C4CEEF;
	Thu,  5 Jun 2025 13:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749130480;
	bh=tIUVMv9gs+dT5DU2bOwZUxjG0y4WXjj+4BeBzl2tPts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HC0PUAhyROtLa2OOpAHNKL39NlYBvzxnXVVC+ivp0a5rof1kfP0qVahziS/ovyo6J
	 v7n1k62ZFSTHrHhcH7+vYrrbmeteZR/ZEmvX3uHaLdZ3pmYikN9DFatfgm3tWAOD1C
	 h7DyXrXXRWJYt0ppKWIWXx7ncIeFaeD7b9wVkvXNhsrokbom1A2OKMC57C5cfYbDyJ
	 v5HWGA7RQZonl6aRUi8ZliMPw4nq4K5sar7aiz68poMlhsZ0E83S9mEqlK40CfHPJ6
	 +VP8fykgEyM7cwrn3rdxOKiNPvKOO8Lxg/i+B9SLTooE2rADXza5hLwoOQyeDZCDBt
	 CT/Pj3+dyVJ1g==
Date: Thu, 5 Jun 2025 08:34:37 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Qiang Yu <quic_qianyu@quicinc.com>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Ziyue Zhang <quic_ziyuzhan@quicinc.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH 2/4] dt-bindings: PCI: qcom,pcie-sm8150: Drop unrelated
 clocks from PCIe hosts
Message-ID: <174913047568.2427981.15606055766469582469.robh@kernel.org>
References: <20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com>
 <20250521-topic-8150_pcie_drop_clocks-v1-2-3d42e84f6453@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521-topic-8150_pcie_drop_clocks-v1-2-3d42e84f6453@oss.qualcomm.com>


On Wed, 21 May 2025 15:38:11 +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The TBU clock belongs to the Translation Buffer Unit, part of the SMMU.
> The ref clock is already being driven upstream through some of the
> branches.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml          | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


