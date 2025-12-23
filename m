Return-Path: <linux-pci+bounces-43590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F87CD95F7
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 13:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BAAE300DB87
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 12:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7AA32AAA9;
	Tue, 23 Dec 2025 12:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M803tHby"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE2527F4F5;
	Tue, 23 Dec 2025 12:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766494460; cv=none; b=sGQc4PitDVyNDRvSEPzAUE810j17w4X8RllYOH+8nL5q6r3GBjQzutWiStBfzq/Poz3FJWqCu2PMyL9PAUboRGFW9G3sb12VWJvmNYyJ7D+5V/+mmUXx85wID6q6UVnMwUkKh4Fc7ZxWddJir3vdXkQh5LdQ5debud+4bQIMdYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766494460; c=relaxed/simple;
	bh=KHfodc6xnjl4ekjBVCgvm0UOgXTUzxfnIsD/WyuNdgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xb7SWB8JdU4Ueva8jm33RN823rf06/JbGBiArZz3BSnNqlUNOHexLwR7z5Htk1OCcxFrfFQj97AZkxeoKK4ytfmLzUMOcbL0HU/MjPe35R1HnQcLPv9m5trisDyxsyrVskd3we00m+vfvNI2Mcl0mae/Lt8zGc5ZRfB2xzISrRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M803tHby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A7EC113D0;
	Tue, 23 Dec 2025 12:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766494459;
	bh=KHfodc6xnjl4ekjBVCgvm0UOgXTUzxfnIsD/WyuNdgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M803tHbyEDczI6AoP2oQUbt7vkta82oKc8iQ2rxcAtF2sU8GZ8Z4nqT/beSqoDNXe
	 jq+q+ssebnPTVbD8hGniUE8HZ9DwrF2giNznZ4wWbkbaCTVd7EVJjHXazWtwIYP0aj
	 ebAxvXyvXeOc2w9rA2YVEjeFZ84730adPbC0B99SyjV58HXyghQWBgHEW35Or5CPJh
	 ZQiii4SerjDex2sChT9NqykoxFmB8zYSi1wMOFY7hmgisycXbkxg4BRkBAd6dqyvzz
	 p9FwlcQRhIipQyRhvYz3QjZXSv1XektgW6hT2cwhkJssnAdK47JsaICXtyF50vUBBc
	 q5oQ44Doazcnw==
Date: Tue, 23 Dec 2025 13:54:15 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, quic_vbadigan@quicinc.com, quic_shazhuss@quicinc.com, 
	konrad.dybcio@oss.qualcomm.com, Rama Krishna <quic_ramkri@quicinc.com>, 
	Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>, Nitesh Gupta <quic_nitegupt@quicinc.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: qcom,sa8255p-pcie-ep: Document
 firmware managed PCIe endpoint
Message-ID: <20251223-glorious-goose-from-betelgeuse-b5b91b@quoll>
References: <20251223-firmware_managed_ep-v4-0-7f7c1b83d679@oss.qualcomm.com>
 <20251223-firmware_managed_ep-v4-1-7f7c1b83d679@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251223-firmware_managed_ep-v4-1-7f7c1b83d679@oss.qualcomm.com>

On Tue, Dec 23, 2025 at 02:46:20PM +0530, Mrinmay Sarkar wrote:
> Document the required configuration to enable the PCIe Endpoint controller
> on SA8255p which is managed by firmware using power-domain based handling.
> 
> Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
> ---
>  .../bindings/pci/qcom,sa8255p-pcie-ep.yaml         | 110 +++++++++++++++++++++
>  1 file changed, 110 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


