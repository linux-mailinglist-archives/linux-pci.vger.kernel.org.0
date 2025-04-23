Return-Path: <linux-pci+bounces-26558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A498A99435
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07581BC28A5
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 15:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46AF28CF7F;
	Wed, 23 Apr 2025 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJJkdLwJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00AF28CF7E;
	Wed, 23 Apr 2025 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422669; cv=none; b=rb8h8vX12dfWccEATroYWrWSVIUgSjMua/VH+QMfBUpM3yFjfOOY/W31BG5ZpQ9llkYCM+OW0QUavHV8eddYIpAD24dJBYbry+hOtYeOuvl4srLaCWeub6UbDFcs70OQgXANqi7skkuEGOwVUsBN1tKk2+tzvPsCQuHqLB1Cg50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422669; c=relaxed/simple;
	bh=DYSy+qmwiF957Xw7JoDarN4VF8dIzkd7/mjUvvdeY5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTlNvjw/PsBpiSq0sukujkrkOu+XAhFlBSKJXJVwzi7KSsvJzL7bI9AyFj+t9Rw/M4dmeckcVDpHQMJfPIsaWk2W6TgjFBacjBuD+2wJWBjP+H5ejowTJf6cAYMadLRekYolvBVpbLHBiz8bFl8RKB7eBrpjKyefZX3HUBM/9HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJJkdLwJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FE7C4CEE2;
	Wed, 23 Apr 2025 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745422669;
	bh=DYSy+qmwiF957Xw7JoDarN4VF8dIzkd7/mjUvvdeY5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rJJkdLwJOCMRstGGmc5r5k7rkhC04hkgGDk6y9hYds+TGO5XNWc8qGdeY+wy81xrN
	 7I7SGj4NeKrWN3/TxicsXBusj0u16vm8S7O8WudeSsjF69QSAA3RpDpLpSusEfIBXn
	 P8sE8ys/t+ikBkOqHQJ6zYBqGDGXkQk/5rAl78mf2ALmKZCWPBg9WKr28txRcFJAqv
	 KKW+IKQMTE6jmKpOPAnJ3tcgCwlQ0ISBup3bct9xyQ6/3m4J21nBKAJzZrdvPJcvET
	 F9zA9HNag8y5dgQVYbd6bcihIvGuFz4n5f0RfTwDAaqbLTy0JGNYCWqR1zHh/xoE/r
	 q0gnCRcnqHx0g==
Date: Wed, 23 Apr 2025 10:37:47 -0500
From: Rob Herring <robh@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_mrana@quicinc.com
Subject: Re: [PATCH v3 3/3] arm64: qcom: sc7280: Move phy, perst to root port
 node
Message-ID: <20250423153747.GA563929-robh@kernel.org>
References: <20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com>
 <20250419-perst-v3-3-1afec3c4ea62@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419-perst-v3-3-1afec3c4ea62@oss.qualcomm.com>

On Sat, Apr 19, 2025 at 10:49:26AM +0530, Krishna Chaitanya Chundru wrote:
> There are many places we agreed to move the wake and perst gpio's
> and phy etc to the pcie root port node instead of bridge node[1].
> 
> So move the phy, phy-names, wake-gpio's in the root port.
> There is already reset-gpio defined for PERST# in pci-bus-common.yaml,
> start using that property instead of perst-gpio.

Moving the properties will break existing kernels. If that doesn't 
matter for these platforms, say so in the commit msg.

> 
> [1] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts   | 5 ++++-
>  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 5 ++++-
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi       | 5 ++++-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi           | 6 ++----
>  4 files changed, 14 insertions(+), 7 deletions(-)

