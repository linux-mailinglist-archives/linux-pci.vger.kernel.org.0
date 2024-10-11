Return-Path: <linux-pci+bounces-14318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC84D99A535
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 15:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A0BAB214CB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 13:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B95218D79;
	Fri, 11 Oct 2024 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIqsoIKv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D90804
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653821; cv=none; b=mOUZXjWM28p7YQ0XDxWP4Wbw16ZF1f2c5kKkgL+48NCfhcQ6fOumrMP6hE1mmjso2pZhDs+3HhJQzJWaBEv8ICK4+qsqo+5RStG2xveAMz187kLt/WlCUWGljTJio1As8BSYWM5W+b4/MCh+s/NSt8BtO67gSugfJHCxeHheWK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653821; c=relaxed/simple;
	bh=SAhP6ZeDNEgR1+A/kJ8320h3rWrwnh7Se7+LoNaV7jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4FlW5GY/BpDQhf6xsPdHq5qUzrpf2xLdDZMNpacBWOfR0ITp3AC5dnIiMqrpi4SRoo9jjTlJ1oEnUEM1FSxNrxC4AEwlUuTB/pEl7vU8ImLalxmFU54O0wNPR/9BGnsulO37FqAtrkEfCpVJpoqhP5R4k2bs1jk4nagarVEAtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NIqsoIKv; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5398939d29eso2676657e87.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728653818; x=1729258618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LLXvMXXy+onUMhQ6b0XOwwTzakrzaQZRd+ecTFnJkKU=;
        b=NIqsoIKvGCOiBxo4kTXCl82SIZkw+wuf10CVrZKHd0xPjQF0vzj0uCDPHsPxrXi0ZC
         jNMIbXt+pexLbk/3+7r398dDmFfKy/DuoilR2dfTaVNI7jfAKbU09uTOrT8Ba8U76y/6
         A437J+sgDnAp/QlXhkdSN8UradIivahY7Da++nacnILZ9JRZnrroR76187QlaisAhA04
         cELrfuOcdsn4XD+0T46NjpDGK9Bz362OVQekKgZyX83l7lamBR/PBQclrPeT3JD22Y2X
         8kr3XY75PXwCDnk20uoVKskLAiggKXbLtRdmmfCY5WCNXPMUduWcKrwW/CdpeAOKKmZu
         vKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728653818; x=1729258618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLXvMXXy+onUMhQ6b0XOwwTzakrzaQZRd+ecTFnJkKU=;
        b=o/p5NlFrxNot6G0yxD75j5nlElF+yu1Q8U3AAaQjMj8+xXjxGyJ+Mexfty7dmScuJO
         mvLAFFoQinuwYMFi3Q+jfWCGi75rSVYaVQVnqbRrK+jjQSFVnBtSeZAnzOQp0IjmBSPp
         +PEOQysISGpSFaMPBjL89y4D1FE5LxR7HKQpzdlNBdCXZn8d6Vf8pn4ZOv1YrmNTtscH
         488mwlSGzSIrSik2+jvuA+K9bsb9uFGIg/zDszvCuXJKyKAPni48l3C6S3GcbxOTwKmP
         q6i25luAEDU6Eaczsmo8bG4nfDLGC8YMwqtBaaELfgnDDRAyeWBAlVzTheeHay1NusT5
         XC+w==
X-Forwarded-Encrypted: i=1; AJvYcCUzrKva/O1EV7SMbNj0Rmbme4xj4anP0KyPZIOn+PjEmNYyscWMGoQh2ZzYVg6QOf1WUgeDe8kPLnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/PyIhwE+PEhuYCcwI1SuYPXe4ht+si2p0ji2mTUPEwnPDWAL6
	xcSWctTkIgDAuN78LJ379HdZCZAM+PKTBLjO3FRlKZaO3hERlfqOd5v6/IlNWo0=
X-Google-Smtp-Source: AGHT+IGntTefT/PAzN87k4mxkHYGpta3nc0hWK276rYQ9gJXg9bf9uIR3RGfaMXE2WNaM7hpJi69bw==
X-Received: by 2002:a05:6512:39ce:b0:534:5453:ecc8 with SMTP id 2adb3069b0e04-539da5abc3cmr1478285e87.52.1728653817689;
        Fri, 11 Oct 2024 06:36:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539cb90527dsm605226e87.248.2024.10.11.06.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 06:36:57 -0700 (PDT)
Date: Fri, 11 Oct 2024 16:36:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org, 
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org, 
	quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, kw@linux.com, lpieralisi@kernel.org, 
	neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 6/8] PCI: qcom: Fix the ops for SC8280X family SoC
Message-ID: <wfwswubquat7a7rprv2oqqzywiiosvmvhefty4tlfe63rlgzl4@6ckw7xrttqnt>
References: <20241011104142.1181773-1-quic_qianyu@quicinc.com>
 <20241011104142.1181773-7-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011104142.1181773-7-quic_qianyu@quicinc.com>

On Fri, Oct 11, 2024 at 03:41:40AM -0700, Qiang Yu wrote:
> On SC8280X family SoC, PCIe controllers are connected to SMMUv3, hence
> they don't need the config_sid() callback in ops_1_9_0 struct. Fix it by
> introducing a new ops struct, namely ops_1_21_0, so that BDF2SID mapping
> won't be configured during init.
> 
> Fixes: d1997c987814 ("PCI: qcom: Disable ASPM L0s for sc8280xp, sa8540p and sa8295p")
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

