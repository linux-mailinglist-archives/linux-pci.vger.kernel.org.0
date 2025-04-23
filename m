Return-Path: <linux-pci+bounces-26559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C88BA99408
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07801BA1DA7
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48E5288CBD;
	Wed, 23 Apr 2025 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T01Ahhfn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FAD28A1DB;
	Wed, 23 Apr 2025 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422695; cv=none; b=OJednE2wUBZx9a/27uDu1vs4C63y2swrKQSXfWrW4mfRUsL9PQxSEaQv3qctIT/eHEtqrPM8bQ1eAH+CSB37x+PWqhE4LU2dL2rkC+AS4YClQJbxAlAulkP3oGUHb3bSQ4ojDREDClfwtQDvdMxOiMlf1rfYRGM/RYOOv50qu2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422695; c=relaxed/simple;
	bh=IaaWKmBkn5xlCdfV5Tc/lHW54iBmhXUi5MviWMueOo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ipm5vX45SDktW1ZtLrgNZqfb5bQkwrpSgjb1qiv8ZOqa0L/EzUKVsAsDZ3J6rDsuUw5DpMAcy/fXnTjeO5uSuUF77NXWbLkN61mG5PE7RL3Lc4ZBwDec7dZe7LRWyCAbZdqJKs09DqZKZ3+EJLRNOXSfQ3vx+bDXecRyUDWTRb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T01Ahhfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E47EC4CEE2;
	Wed, 23 Apr 2025 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745422695;
	bh=IaaWKmBkn5xlCdfV5Tc/lHW54iBmhXUi5MviWMueOo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T01Ahhfn32j66N81kHE9Doy0oHXEWbktmsfLpFjf0g8br7wl8u/uOvsaF0mRueV1X
	 I/UXtyC/A3ZUqAkMCJhRbFpqRaGXvQEPfXdZwUGqA1sWn/+AMlh2+fJwDAw2V0MPeG
	 MbarfDODtoomYQ/bgLi2wFxZfeaoQL/dpzSlZtwNAcJAWkcXtdJfDshpDhesq8bXqj
	 0maEsfIIaPbJrttTYSEMbiKFJ7NEnYOeDbL8mosiviPh8oN+FKnuEtdaXfYtT5IU84
	 8SVKlJ7CHBnoO9TZHa6e9Jidvv9FRj62pnFB0h1sRbLthBTF5+BBc0t3omXq0ktcDd
	 OEX+ZTYJnzFkw==
Date: Wed, 23 Apr 2025 10:38:13 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: quic_vbadigan@quicinc.com, Bjorn Helgaas <bhelgaas@google.com>,
	cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, quic_mrana@quicinc.com,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: PCI: qcom: Move phy, wake & reset
 gpio's to root port
Message-ID: <174542269294.567149.8123466089628259520.robh@kernel.org>
References: <20250419-perst-v3-0-1afec3c4ea62@oss.qualcomm.com>
 <20250419-perst-v3-1-1afec3c4ea62@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419-perst-v3-1-1afec3c4ea62@oss.qualcomm.com>


On Sat, 19 Apr 2025 10:49:24 +0530, Krishna Chaitanya Chundru wrote:
> Move the phy, phy-names, wake-gpio's to the pcie root port node instead of
> the bridge node, as agreed upon in multiple places one instance is[1].
> 
> Update the qcom,pcie-common.yaml to include the phy, phy-names, and
> wake-gpios properties in the root port node. There is already reset-gpios
> defined for PERST# in pci-bus-common.yaml, start using that property
> instead of perst-gpio.
> 
> For backward compatibility, do not remove any existing properties in the
> bridge node.
> 
> [1] https://lore.kernel.org/linux-pci/20241211192014.GA3302752@bhelgaas/
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-common.yaml  | 36 ++++++++++++++++++++--
>  .../devicetree/bindings/pci/qcom,pcie-sc7280.yaml  | 16 +++++++---
>  2 files changed, 46 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


