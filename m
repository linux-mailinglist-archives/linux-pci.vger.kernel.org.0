Return-Path: <linux-pci+bounces-42207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0D6C8EAE5
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 15:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888903BC953
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 13:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42B13321AD;
	Thu, 27 Nov 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq8rj2y0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A78E2459D9;
	Thu, 27 Nov 2025 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251765; cv=none; b=hI39x+9BdUkIfAK1EWqW3tAyVPcxVTxuDw5k7jLBAe5O34pw27ziLowwWc00HYQHABdmY6Qy2WiT+P9fRIp/pLbuIOPIKdz4/lz3soekFAY0tT7Wh/g2zvr76N/gxcnUViuWvdsg8dAjfK35A510p3DRmRZvY+Ke/Z0YBlY9eew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251765; c=relaxed/simple;
	bh=slQ0FUMlfWpug2ojIQ3eKo3jBLV25dlvDH1ZoCbw/0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xd4zNX5ewxZE/FNuzguK8s5Eqpxs9rKXn+DvyG46lAqe/OUarpu15sNtPJGqgCDQ8rdBAt1VkKQXyZXI1ciC4nMzeT5CaOCXIPmk1sd3Pn2eyIZjNZd/mtsHODScnbaqgfIp8roI2tLzgI4OjpuEQZwST0iBdmOBsn0Xnw2Len4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq8rj2y0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB927C4CEF8;
	Thu, 27 Nov 2025 13:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764251764;
	bh=slQ0FUMlfWpug2ojIQ3eKo3jBLV25dlvDH1ZoCbw/0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nq8rj2y0730CXMKh+a7f826U2797wqed/V9cR4JtgHRTBTsoYov320HmSP7rSTgaA
	 10C1AYOopAac7vlTHC0IoNZcQzKOXQMrFxT2mMDTzTn27MHRRIsNOGiiOostzE6f8q
	 xZKjuCR2lbGJwh/F96P8bVojNJ6vU1XYbLmNo4i+VG0oPIxx97k+nMFJeX4OauKcwi
	 7tegUH4xtrkg1NkauvHknKEsKf+fgIifxR620Ey1no9RES1d2BzXt/UIXRB8QV3Wk9
	 ZR6IriJKFrm8XPOKzKpaaCOAua2ZGgRPqxsws+yC8thoZzBawMGt/tU61q/fUTNeYg
	 sCakIUyeMQ8sg==
Date: Thu, 27 Nov 2025 19:25:52 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, robh@kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH] PCI: qcom: Clear ASPM L0s CAP for MSM8996 SoC
Message-ID: <7rmiof6lxrr27vd4rnilc6ynxj7c2eiv33uw62lt4sheylpjny@6m2nuqnbnifc>
References: <20251126081718.8239-1-mani@kernel.org>
 <bcc61dc3-80ab-4ac4-b9a5-7fc42cff9ab5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcc61dc3-80ab-4ac4-b9a5-7fc42cff9ab5@oss.qualcomm.com>

On Thu, Nov 27, 2025 at 11:55:15AM +0100, Konrad Dybcio wrote:
> On 11/26/25 9:17 AM, Manivannan Sadhasivam wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > Though I couldn't confirm the ASPM L0s support with the Qcom hardware team,
> > bug report from Dmitry suggests that L0s is broken on this legacy SoC.
> > Hence, clear the L0s CAP for the Root Ports in this SoC.
> 
> FWIW if we trust the downstream DT, we have this hunk:
> 
> arch/arm64/boot/dts/qcom/msm8996.dtsi
> 1431:           qcom,l1-supported;
> 1432:           qcom,l1ss-supported;
> 1586:           qcom,l1-supported;
> 1587:           qcom,l1ss-supported;
> 1739:           qcom,l1-supported;
> 1740:           qcom,l1ss-supported;
> 
> But also funnily enough, msm8996auto boards specifically manually
> do a /delete-property/ on those..
> 
> (there exists one 'qcom,l0s-supported', but it's NOT set for 8996, 98,
> or 845)
> 
> On msm-4.14, this became "qcom,no-l0s/l1/l1ss-supported". This forbids L0s
> on at least 8150 and 8250.
> 
> Later, both hosts on SM8350 and SM8450-PCIe0 (not 1) forbid L0s.
> 

Thanks for digging in. Unfortunately, I have to rely on word of mouth to get the
ASPM capability as there is no proper doc that says which SoC supports which
state. And, I'm quite nervous to trust downstream DTS as they were not very
accurate in describing the hardware capabilities. But I think we should atleast
consider the 'no-l0s' properties seriously.

Let me go through all DTS and build try to build a sane ASPM compatibility
table. But just be clear, the above exercise should not block this patch as it
fixes a real issue that has been reported.

> SM8350-PCIe0 sets 'qcom,l1ss-sleep-disable' which influences some RPMh
> things, but also prevents some clock ops wrt the CLKREF source
> 

We can ignore 'qcom,l1ss-sleep-disable' as it is a Qcom low power feature built
around PCIe L1ss, which is not yet supported in upstream.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

