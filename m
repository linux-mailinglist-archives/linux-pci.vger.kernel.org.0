Return-Path: <linux-pci+bounces-34925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA88B3858A
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 16:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4815E1D60
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 14:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5FF22A4D6;
	Wed, 27 Aug 2025 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5PjSZHf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3A2264B8;
	Wed, 27 Aug 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306554; cv=none; b=Mx75j6fRgKH6kpw5/VYHx0n/XjIIvEsDevIEpnM1te7Wr6pV2auVIadyaSLX0aB1aEr9BGaHht5C55ODk1UwD3UpzbYJIVq6UYv0P3vIoiyeudhR1JTpf+ExQVfLtfesj0MErwjilVl4QDHnzYAQTNLNzs3P41dSYC/OlRpTDs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306554; c=relaxed/simple;
	bh=xbPlbWZ1yiRh8RKfwrSHlxyRVFlZFQiAJnB8nMi7yVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vB3ltxnbRd0Mjub8T5iJpCOCsjG7Ge0ObSMGTpl1SRYP8RBTwHIZXs136CodDVkAIEgQAyi1qfH5dGgXXOlUa2dN5aD8jAqNcJhneScoBi0u/dlN3DFzdjKCDR8jaXXhGxN/BabVqwoOpyj3IfeQ/YtAtiMEBsuzjVOA4bXleqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5PjSZHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE257C4CEF0;
	Wed, 27 Aug 2025 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756306553;
	bh=xbPlbWZ1yiRh8RKfwrSHlxyRVFlZFQiAJnB8nMi7yVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p5PjSZHf8jLqQsSCutsrupvBsZFRXAamiT2YoaUF/U2uiCLOEWQTVP0xXIbza8Ug/
	 Dfw6DkF5xN3/v0wdE+8QrZfEGDQ4VzniUJHDqiBAR+VAHQTfS4kxe6GZCZSiCd2zyw
	 Dk9vCMkMCMrYxe5ENHnZoMivmCRZ2N63AgW5vWu6VUNtURiBffOhNsAUHSyA5izpBE
	 8Pqm7zQAAzX5E1jQkCV9V7+iflbBa7LmbZ1by0QJT7lbkLPPErQVnnuCILJkE3KXMj
	 M2d9PaNK3xenS1S4WOWOy2YQj52DBXjDJChFgRpuVQks/E4RcpSLalksfgJywvMWj1
	 R1UcO1YK3tn2w==
Date: Wed, 27 Aug 2025 20:25:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v3 0/3] arm64: dts: qcom: Add PCIe Support for sm8750
Message-ID: <55lm2trwh3l62om2ozjmywfy6cj4l7iiy5sx66rqawjqcnn6ix@ycqbusd7pi5v>
References: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826-pakala-v3-0-721627bd5bb0@oss.qualcomm.com>

On Tue, Aug 26, 2025 at 04:32:52PM GMT, Krishna Chaitanya Chundru wrote:
> Describe PCIe controller and PHY. Also add required system resources like
> regulators, clocks, interrupts and registers configuration for PCIe.
> 
> The qcom_pcie_parse_ports() function currently iterates over all available
> child nodes of the PCIe controller's device tree node. This includes
> unrelated nodes such as OPP (Operating Performance Points) nodes, which do
> not contain the expected 'reset' and 'phy' properties. As a result, parsing
> fails and the driver falls back to the legacy method of parsing the
> controller node directly. However, this fallback also fails when properties
> are shifted to the root port, leading to probe failure.
> 
> Fix this by restricting the parsing logic to only consider child nodes with
> device_type = "pci", which is the expected and required property for PCIe
> ports as defined in pci-bus-common.yaml.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
> Changes in v3:
> - Use device_type to find pci node or not instead of node name.
> - Link to v2: https://lore.kernel.org/r/20250826-pakala-v2-0-74f1f60676c6@oss.qualcomm.com
> 
> Changes in v2:
> - Follow the x1e80100.dtsi pcie node description (Konrad).
> - define phy & perst, wake in port node as per latest bindings.
> - Add check in the driver to parse only pcie child nodes.
> - Added acked by tag(Rob).
> - Removed dtbinding and phy driver patches as they got applied.
> - Link to v1: https://lore.kernel.org/r/20250809-pakala-v1-0-abf1c416dbaa@oss.qualcomm.com
> 
> ---
> Krishna Chaitanya Chundru (3):
>       dt-bindings: PCI: qcom,pcie-sm8550: Add SM8750 compatible
>       arm64: dts: qcom: sm8750: Add PCIe PHY and controller node
>       PCI: qcom: Restrict port parsing only to pci child nodes

Applied patches 1 and 3, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

