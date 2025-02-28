Return-Path: <linux-pci+bounces-22666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1D5A4A48E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 22:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0867A170413
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 21:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F65B1D6DD8;
	Fri, 28 Feb 2025 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiFeNkU7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F61C54B2;
	Fri, 28 Feb 2025 21:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777109; cv=none; b=Ekg2tvbfFfHdtxRSmFXVx51ZgWGcjHgJIJ/NgGIfS2ysvhfKSTjU7TB/ICaxoaFRhaTlsP+5BD4o6bH3rIfSaj5ujyjAYv+xM6RHVPghca2lOhW0E5WR9RgnT6LMInWlw3+8ze6DctQV7/J99jwF0OEuiPCg+Ec0msmjefSly0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777109; c=relaxed/simple;
	bh=lbTeoZhiHyXZ/EkZombLNohj9+RmtxRsFsW43SkPrag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTL+bMHlgQyLXG6gx5RTY3WJZG5Jq8ArLSW0LLhCF1fYSFfMwR2REjJ4sDfyRNqQw7B1oSDGhNHrH6/HMbuBF4AyOLAw/yUWpDF+V0F4S4oZ3gTashoDJGZ1TtCvRzZ89MrZYJ3+cQksJShXJE+5k4zSiMH1CjOCIJ38jp6IJro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiFeNkU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1123FC4CED6;
	Fri, 28 Feb 2025 21:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777109;
	bh=lbTeoZhiHyXZ/EkZombLNohj9+RmtxRsFsW43SkPrag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IiFeNkU74gtWQ4y6gO0Ai4C8usvmO7yfZXwt1muhSlR8+Z32NRfHicrKzfhahmVfd
	 EuUZUqxtanS1xIY/JvdivinlK2OBjEdybv97w/hT57RKxfdWE0JXfarUQhZfSrFopK
	 bbTTww8d8BIpP+6wWCQ+Nx2HJ54Wfy3QlmpJyfcz+SNFjhyhMPtliILzrdNsqzLCGx
	 /mUzFmF/+UUH1imBcvFfBG/U8h//xgEplXjnjZqEwsHfpkZ3j4GA7n72GyMGF30Sek
	 SczLcS/NI91J93TXfbpm/hCnb9n+lulUInP62VtPpQfnaMze8X8k1gEVG6zNoHEpzm
	 TTNA10ON3FGaw==
Date: Fri, 28 Feb 2025 15:11:47 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	cros-qcom-dts-watchers@chromium.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 01/23] dt-bindings: PCI: qcom,pcie-sm8150: Add 'global'
 interrupt
Message-ID: <174077710657.3725596.9645506289202151299.robh@kernel.org>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-1-2b70a7819d1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-pcie-global-irq-v1-1-2b70a7819d1e@linaro.org>


On Thu, 27 Feb 2025 19:10:43 +0530, Manivannan Sadhasivam wrote:
> 'global' interrupt is used to receive PCIe controller and link specific
> events.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


