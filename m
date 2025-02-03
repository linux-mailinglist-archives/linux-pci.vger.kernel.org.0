Return-Path: <linux-pci+bounces-20663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4548AA25FDE
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 17:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A7107A2DBA
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E00720ADC1;
	Mon,  3 Feb 2025 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WSit5eS9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833B720ADC3
	for <linux-pci@vger.kernel.org>; Mon,  3 Feb 2025 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738599986; cv=none; b=QpIyAlGWVijXZyAktYvgzXazyhZvT9aEg/eYvM67SbnyNOqWevExi4qc6AZ7rsIPFud3SOPalsefbv/yXmUHnG//iwCAcJpzPYu8KL2G2UH133N0ii5mJixo3AUayvs6cTwoiLp1jAzjOY5zczX6vTW7b50oHUurilTP1vpegk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738599986; c=relaxed/simple;
	bh=OVibP8ReQyd3HQmntDn0iiGBJZzdEqwa87ZWcwRodw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IFVgt7R4O7ManciesvBc4J7ZDgSyRxnbjf8ZYBVg92kZgmPht7KBh6O+J+8W1oaEwuLA/HjcEKxhklO8JEeRAVFatfvwEp0FS7eOlCD+Bzaf7CBISpcCxs1nG4CtLlxa38wdjwtpTYzd5NIEZiXIzwin78NQeXzzxcn5XLZXqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WSit5eS9; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21680814d42so77930355ad.2
        for <linux-pci@vger.kernel.org>; Mon, 03 Feb 2025 08:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738599984; x=1739204784; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fpVOevLK/nWn6zp5PxG8PfTYQAwpuKIZhTQ2q8JK1sU=;
        b=WSit5eS9RXGVOCTJ3Sf5kWBU2jEnJtiLb2D33Jc9Fzs4GRqZg+EycRTOA9O1CIJ0bN
         sOAiQfW4sp2VOnxF8AAUuD4ao5paRh5xkz73HC868qZvza6H5dFzFL5zvg0xuDEcFgnn
         l0iuXzPwRvAqeusDkzxbelsPpSnPde+Nae6xU3Kq96zoXEH0Tv3mgUKxDXMpIACO9AYh
         tXi+qaajoQYgkQhjS+yVk91rq6q6/K9NOo2N+g1W6nMyrb+WimMzKd9zmApa8cKMPYYa
         0zf4aSdOfvmfh/h3QX0ldaflPIKJGJzUfYEvgqkkJRFywKOWi3894COOjLhkpL6sNM67
         6zSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738599984; x=1739204784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fpVOevLK/nWn6zp5PxG8PfTYQAwpuKIZhTQ2q8JK1sU=;
        b=o+2hsJ/yWBZnJycipIisfIBCPWIRwVkm2hkSCKfvolZc6Rp+N01PygDiKYhjJBZY+4
         A8RoqnIt6d6oKiazrkGHTsxYAGSw2tc7tAqKDE3sdsFwQYLkfwEltx3++GMZ/6yCt0Og
         3OOFeEk/9Rjq2SIFmM+rAoO1iO+kXmJ9MB5MV80UgCUt1HvdARE039TtB3/ZSVTEEZ+S
         Oyl7Dm/FAt2hdE39twfD0ygF/H7S2wgdREBu71skSHSvd5nD8Gs50C+KCdjrHQKawF+0
         d5/gFQFe6DjWejEVrOCvQWEe7U/kj/fQWZXf15euFn4v9xgfqdlSNObBdzwUdKEnkXLQ
         GtIw==
X-Forwarded-Encrypted: i=1; AJvYcCXchMvqZsfrHxuwHtdV3RoC6IdrVzfta7D3FpdfInoOc0F5w3KGfEotws77/sm15d+X0IpF6Lr+k1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvTe8AbuY61A09Qco2Q7bqEp9MalRVLoPTfMU2233GGwf28Bq6
	Qjkj6qY0cBa0QhJJgxsLZfkLW6ZBE/v6CAq+eKPKLWwws3pIHv7yuiG8UFjJdA==
X-Gm-Gg: ASbGncsd514AraxWfOIBK4J73UWQwYEB3UNrChyynKyoRvDvzCDu1P9RsrM5ecZbK2p
	s5ogQ6OqC/PtawgenxsrLA5qfP5gmmHNFuith3Kw5DvfsXKXoadeTRLHeRqdIgU+3kDQ5gCPgVj
	lpcbB5uh2NJXDiye2mChFBq630g7tjAD+v9pv+9+/fGWGem7cA2510N5u5GsGy1gmUx4jZ7lTrI
	Msfditg1v2Bn0aSxJr/4rxR8Ovu9IkMpwcZGRNLDdl/NpXob2rxhMZCF8FpIzHhPh9VVvxdQgaU
	ch7BV1ViWqy+wGS29ylsruQRJw==
X-Google-Smtp-Source: AGHT+IFOuXKAdtxhNw7CHCzZkSB+L34XynX4lNUCqGi6tRRgVguTo3ptD/9ETnLqXyet7OFZO69Avw==
X-Received: by 2002:a17:902:f68a:b0:21a:8769:302e with SMTP id d9443c01a7336-21dd7c65746mr352286105ad.14.1738599983682;
        Mon, 03 Feb 2025 08:26:23 -0800 (PST)
Received: from thinkpad ([120.60.129.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31ee1fasm78854315ad.44.2025.02.03.08.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:26:23 -0800 (PST)
Date: Mon, 3 Feb 2025 21:56:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, p.zabel@pengutronix.de,
	dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	Praveenkumar I <quic_ipkumar@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v7 6/7] arm64: dts: qcom: ipq5332: Add PCIe related nodes
Message-ID: <20250203162617.sstmdvv7d3k53izf@thinkpad>
References: <20250122063411.3503097-1-quic_varada@quicinc.com>
 <20250122063411.3503097-7-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250122063411.3503097-7-quic_varada@quicinc.com>

On Wed, Jan 22, 2025 at 12:04:10PM +0530, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> Add phy and controller nodes for pcie0_x1 and pcie1_x2.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

One minor comment below.


[...]

> +			assigned-clocks = <&gcc GCC_PCIE3X2_AUX_CLK>,
> +					<&gcc GCC_PCIE3X2_AXI_M_CLK>,
> +					<&gcc GCC_PCIE3X2_AXI_S_BRIDGE_CLK>,
> +					<&gcc GCC_PCIE3X2_AXI_S_CLK>,
> +					<&gcc GCC_PCIE3X2_RCHG_CLK>;
> +
> +			assigned-clock-rates = <2000000>,
> +						<266666666>,
> +						<240000000>,
> +						<240000000>,
> +						<100000000>;
> +

Does the drivers really need to set clock rate for these many clocks?

No, as per the reply to my similar question to IPQ5424:
https://lore.kernel.org/linux-arm-msm/9206e44c-da4f-4bdb-850f-fac511f4ddc7@quicinc.com/

- Mani

-- 
மணிவண்ணன் சதாசிவம்

