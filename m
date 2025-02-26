Return-Path: <linux-pci+bounces-22410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F20A456BA
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 08:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F163A42EB
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 07:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219FF267711;
	Wed, 26 Feb 2025 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZnSOWrc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2052158DD4;
	Wed, 26 Feb 2025 07:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740555166; cv=none; b=I461/mGzz8t4A0fS0+nteazJqitF0bD1lYyfor/FiuU4FMv7SNafmZ05+MIz/Io/YlAiwmYwZpgS9NbdaYXQ+Dj2cE1ORXpd8UofLF8C7dxrBBxWHtHWAXfWngAquO2uOXwNhubwDHFhMhjruwJLVuMmmpPd1QzXidEthJxSRzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740555166; c=relaxed/simple;
	bh=i3yBUJwWR2nHLbnkwSKlJvBidp8N1zKCYReFcAUDAhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fk0DqwQR2aZxH/d+WfweiMLq4PeoPhqMjo4vhysWa63/JusyADlyGPLsxyF1jVenqqPMUNEYu1nsx+10H8DSra9QEbl0IoMiw6+1yOE9X+pJ5G2v54Dzq6ffwWdSgKAiDaz56/FiAGQKQW4CTBBgfJlYHHQicijg6PQY4ngV/qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZnSOWrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8B4C4CED6;
	Wed, 26 Feb 2025 07:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740555165;
	bh=i3yBUJwWR2nHLbnkwSKlJvBidp8N1zKCYReFcAUDAhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZnSOWrc0534guOCFWF3FoGRqYV1GlyUmFrwgIbROiK9rLsd0ayqM1xEdlPXMAqSh
	 HniEWuVBoyAGumLibd0DuSPosEoXMpfbgMy5KQxi7KDzAaqyN7eVmKBodgCv20Pfty
	 gdLuTRnR34nSWCaiNJBkLSN8KuYktv5wvP0hSbGe2LV3C2BtSo+3RMmciVN7cCGvW6
	 Od9ERN5yet2XqQOuCGRz4VZdEeL8bYVo0jKNJ5cmbRL5Pw65Yd1umqkbUNW2x0v5kc
	 bbzqTcI9mp+unBHvd6ZBQnKcCT2KUKZtCHo0IHiTjWTkGsYQR1rOz20OFb7YRgkf/u
	 xSI/Z6WfjK0IA==
Date: Wed, 26 Feb 2025 08:32:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	chaitanya chundru <quic_krichai@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
	Jingoo Han <jingoohan1@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicnic.com, 
	amitk@kernel.org, dmitry.baryshkov@linaro.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	jorge.ramirez@oss.qualcomm.com
Subject: Re: [PATCH v4 09/10] dt-bindings: PCI: qcom,pcie-sc7280: Add
 'global' interrupt
Message-ID: <20250226-enlightened-chachalaca-of-artistry-2de5ea@krzk-bin>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
 <20250225-qps615_v4_1-v4-9-e08633a7bdf8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225-qps615_v4_1-v4-9-e08633a7bdf8@oss.qualcomm.com>

On Tue, Feb 25, 2025 at 03:04:06PM +0530, Krishna Chaitanya Chundru wrote:
> Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
> to the host CPU. This interrupt can be used by the device driver to handle
> PCIe link specific events such as Link up and Link down, which give the
> driver a chance to start bus enumeration on its own when link is up and
> initiate link training if link goes to a bad state. The PCIe driver can
> still work without this interrupt but it will provide a nice user
> experience when device gets plugged and removed.
> 
> Hence, document it in the binding along with the existing MSI interrupts.
> Global interrupt is parsed as optional in driver, so adding it in bindings
> will not break the ABI.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
> index 76cb9fbfd476..7ae09ba8da60 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc7280.yaml
> @@ -54,7 +54,7 @@ properties:
>  
>    interrupts:
>      minItems: 8
> -    maxItems: 8
> +    maxItems: 9
>  
>    interrupt-names:
>      items:
> @@ -66,6 +66,7 @@ properties:
>        - const: msi5
>        - const: msi6
>        - const: msi7
> +      - const: global

Either context is missing or these are not synced with interrupts.

Best regards,
Krzysztof


