Return-Path: <linux-pci+bounces-29031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F5FACF0CB
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 15:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE863A8F7D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 13:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3E2255F55;
	Thu,  5 Jun 2025 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A71k7a57"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5904C2550D2;
	Thu,  5 Jun 2025 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749130467; cv=none; b=u8BDb8jiIHmr9epagxUZVYmNVYpIsK1BlLa6/0Ob4d4D6YY5snwgspulqi3Q3v+xJCtB93SCctE5j/BndpPk8NEhc4SOxeqKYd9eP4cOSXSrUkDzMRLp2p8wIJRxl0J5l8Vb/m7GbPpMhyJ0BVeHUCO5zdhcE7DcfPS8n3N6OtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749130467; c=relaxed/simple;
	bh=iDQyDqaMZzD+KwhPTYZgckpOuUb9ZIO+TRLpfY+1e54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tR42MqDaJBeWA4C9VIPlvl/YGPwaIPJ/VA6yDjIrp4JVhup3/WAyP4KnpDeMN6Nnj6xpLtxQZEDhar51SJXKtjTb+lopSoHlvQt71og26nDk8i2UoTvcgMKn5+7FtGATE4nj8v9GlL+2+cfAk+kT2zCPYa7ENw8wAP0VcurL8ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A71k7a57; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4F1C4CEE7;
	Thu,  5 Jun 2025 13:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749130466;
	bh=iDQyDqaMZzD+KwhPTYZgckpOuUb9ZIO+TRLpfY+1e54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A71k7a57mJm5O/QCRNip7OFitnYaQQERbWmKct5HWfhQTUtcTz6a1g50WnDiKzhwb
	 z1w73Sbcf13kYA4xkuCtXszG49AbmjylSVYr79gUNbeSn6E88g50U/0CTsl39qR3cW
	 dfOhK5juDFF1HFbvHfWmD6n9bQdw9EduP5X92eOzGqHAuth+eyvh3I3rnDoH3EzstH
	 zbiCdxYFoEnS5dCtPQKNNH/ng+R3n2OJo+b+aemCMmOjDuotDdxElcle5uAY6J6xyi
	 ktxaKmWstgN75KUFC5cyTkv1nK1BxMqv6Bct7fGOXm5u7iGChEYm2eH+jMgh5Smgx+
	 nOgKO1DQpOZQw==
Date: Thu, 5 Jun 2025 08:34:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	devicetree@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>,
	Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Subject: Re: [PATCH 1/4] dt-bindings: PCI: qcom,pcie-sc8180x: Drop unrelated
 clocks from PCIe hosts
Message-ID: <174913046189.2427423.8082975472516161400.robh@kernel.org>
References: <20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com>
 <20250521-topic-8150_pcie_drop_clocks-v1-1-3d42e84f6453@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521-topic-8150_pcie_drop_clocks-v1-1-3d42e84f6453@oss.qualcomm.com>


On Wed, 21 May 2025 15:38:10 +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The TBU clock belongs to the Translation Buffer Unit, part of the SMMU.
> The ref clock is already being driven upstream through some of the
> branches.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml         | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


