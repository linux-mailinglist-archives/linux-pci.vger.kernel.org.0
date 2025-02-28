Return-Path: <linux-pci+bounces-22672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A714A4A4A5
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 22:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90FC3BB1E7
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2025 21:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AE31CD210;
	Fri, 28 Feb 2025 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJ8W5dV/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BA21CB9F0;
	Fri, 28 Feb 2025 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777222; cv=none; b=YAAmmlJphP1XSN7Fn6x9tUrt8FZrq+wOg6BRaFvUzOzEmhA3o/KEOEtW0mNWdF1sEmHMFfWXLFT5WMXOiJvZ0bETAH0dc7VCRVKjUWv05wVpBrKo5KU+wocV+66HegvRnr19Wlb1VNmkKUCMUL/AHKuXvoCwWYevox2ecr9k5s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777222; c=relaxed/simple;
	bh=5oNwJ0ZjEOTPyN4LnoybbvOFf1Wi5s8IonPm3ILKUFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhvtaWTjVU7RRlR6547QAdpB+RRxyfYbCMXzyOmMC0CGE7xemRv8zTXQ/9UTozgOMTasNcM7IqoZumYZ2z81TdDQ5ZLfcprGSZIDvFhyhViNLmuRe/pGYYyG2eEcSbwHdCMqujQzF98Cr0T1SqbspcOWI+cui2+U62k6kd7JXCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJ8W5dV/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE5FC4CEE2;
	Fri, 28 Feb 2025 21:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740777222;
	bh=5oNwJ0ZjEOTPyN4LnoybbvOFf1Wi5s8IonPm3ILKUFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mJ8W5dV/2pe7yqU7RrjjdirQq0gpwthQMOoGnJ7sX0Ya9/wLAomu7pW4FNkNOszpQ
	 N99XDoyB5lI5zq2Pl1rcX/6suZX/FnMPE0h1uNkJSy1eBIC4aUdUQ72equNe5sKT5J
	 paWmHichTZHJW2nNSgE6rmObksd/6sPX9Uc41Xru067gTTe8sIdyiWRpxiH1KO+2pI
	 DxKLyU1iWYWfXL2EyNUGZFZKY4j+07MsGoRjF170YzLLeVSNWJdxhwK4gJxNUuZbJO
	 QORMhJgdikIhAxQdbydvczAnNZlvpuTD8+RGNBMrt8XC8pWF5BqH33kZcum6pJrd0T
	 oCUYe5OTMZTFw==
Date: Fri, 28 Feb 2025 15:13:40 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Andersson <andersson@kernel.org>, devicetree@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 14/23] dt-bindings: PCI: qcom: Allow MSM8998 to use 8 MSI
 and one 'global' interrupt
Message-ID: <174077721969.3728847.4227858959605236884.robh@kernel.org>
References: <20250227-pcie-global-irq-v1-0-2b70a7819d1e@linaro.org>
 <20250227-pcie-global-irq-v1-14-2b70a7819d1e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227-pcie-global-irq-v1-14-2b70a7819d1e@linaro.org>


On Thu, 27 Feb 2025 19:10:56 +0530, Manivannan Sadhasivam wrote:
> MSM8998 has 8 MSI SPI and one 'global' interrupt.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


