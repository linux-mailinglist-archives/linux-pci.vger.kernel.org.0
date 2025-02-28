Return-Path: <linux-pci+bounces-22673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE67A4A4AA
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 22:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D4C3A1463
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 21:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4541CD210;
	Fri, 28 Feb 2025 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfju4vdz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCE11CAA9E;
	Fri, 28 Feb 2025 21:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777243; cv=none; b=Kzp4BEOfhox4QGx8EKCiPNGa9cEIllaH7GAQ96iKBlrhZheYyOHobHJRxUYL4vnge46oLSzakain1tyFHyD3jyBUAFVIIeN4XLjooDYQxLHexDiPoLgcw2ocvQsVkswKhsPPLrnn4P96f0ap2b5ENBw+VoMTnzORcRlouUuGGbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777243; c=relaxed/simple;
	bh=iiVLRVRvwtG9C/U3fkPsSBqoFvOaF2ydSySSg+P/hkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjvLEEUK3cqK8tUYzY3ucN9Et7/b7m/beKi1rplCHyzBtI6YbxaCnt6tp7JZhN7awwJYLaeKSOPu0/ecOyap9z/dECk6MhvW1vYZcEO1C5jJ5KW6G9Q2Yyct8/1TMa9KPJEjHnbPN1aQN8/meZiVqXwtjKANmjyPi4pItD1VRy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfju4vdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B58C4CED6;
	Fri, 28 Feb 2025 21:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777242;
	bh=iiVLRVRvwtG9C/U3fkPsSBqoFvOaF2ydSySSg+P/hkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hfju4vdzrJ4XVLUIKU/GDDvn7vmw/MZq75jv8UXKZhofO3Sb2Td3in9G5F74RpPwn
	 z89+tvaqOgI7zF8poUk6olVjUSOdQm5SiIEV8yvCqS2uQim8ddD6hag3p0ft1kUL6I
	 K3Xv6bwqP3FFTRZ7dUuqOC4zwGzrZSuiykHpBTWEtCmCi41XIF1LWt+D4G5M+dYPjq
	 2Fyx4q49WjVcTuRWXxNLoiYdh1bpOpJ8O0UwrptM8vmqw/4Z6CiShhACkJtOhKbNIx
	 jTK0ncIgSv9qPW1C+qUlrtGiMxZIaSVUZkiZT/lyR2WAVCzWVSB83GyDgNm8VWWifk
	 YS6TqI0zqxlAA==
Date: Fri, 28 Feb 2025 15:14:00 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-kernel@vger.kernel.org, cros-qcom-dts-watchers@chromium.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 16/23] dt-bindings: PCI: qcom: Allow IPQ8074 to use 8 MSI
 and one 'global' interrupt
Message-ID: <174077724015.3729445.10389825081905367942.robh@kernel.org>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-16-2b70a7819d1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-pcie-global-irq-v1-16-2b70a7819d1e@linaro.org>


On Thu, 27 Feb 2025 19:10:58 +0530, Manivannan Sadhasivam wrote:
> IPA8074 has 8 MSI SPI and one 'global' interrupt.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


