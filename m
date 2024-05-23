Return-Path: <linux-pci+bounces-7785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 645FC8CD698
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 17:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F28991F21A42
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 15:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787B2B645;
	Thu, 23 May 2024 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gW2U8MdR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457C76AAD;
	Thu, 23 May 2024 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476631; cv=none; b=qsxJTUyZs3lEQK8VE3QCJyQ8t9g5YrSnxLRBsvw4iKd3Ys3/ClgjKIvN0Kmi2w7M+EpC34xVCMTW50zdYo90xaEAE22iNWVVyCMLtveI+wn2gZfCgnxFj3TIX5cAvHBhJglxE5+yZcm1EqJ9TP8yeZeOHpWw/Q05Y8oMGINCh3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476631; c=relaxed/simple;
	bh=N9nB2TabRE0ILucieRrFr8EiEb/dKAQ/M2yQBgPFKY4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Z87W8GHpVK5Vb9Qt8nD3q0GLVRLtWqgqKRCBpUqTjDUHPBl8VSp0THVKN+dYURbbjst5AlPp6vLUcGHZUFEuDRUWeG75eflg6j/fqFCfmXbGyAPvmigdkbiRQQLLcSVM+jLcUM4bKC0ZA3hCW/NSPxWDwS7dMLCYyRcalUcojHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gW2U8MdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92849C32786;
	Thu, 23 May 2024 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716476630;
	bh=N9nB2TabRE0ILucieRrFr8EiEb/dKAQ/M2yQBgPFKY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gW2U8MdRupSPlhuIc29ggUoj8CTuq45vPyAXx5ABrUNtyXvTUbQSRF2zpB4eQouNp
	 GlkNuZ4aBBLWujz1PHNOnhrFaNmZ1Fd69hmHs5ULylOlusqbVi46htoPXgEv1Ytkvc
	 u6KwMlvcPJk6UfrvRuemSoDHsSYaSs8aTo2y2WN1qNXZtVmojFSlDKmMueuCquFvRn
	 KtgmZg4QYYUunhZqmq8VDcs/KDde/9YVdwTkSDzEQE1PH7K/GKViOkcFT6Q88rL01g
	 vtC+SRY9iD3M5CS8wx678JB2jCL4LcGYaSADnP3xUlM2M1jFQAAK9QWtqm+E07sqWc
	 5p82lad0gqy9Q==
Date: Thu, 23 May 2024 10:03:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: devi priya <quic_devipriy@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	mturquette@baylibre.com, sboyd@kernel.org,
	manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH V5 1/6] Add PCIe pipe clock definitions for IPQ9574 SoC.
Message-ID: <20240523150349.GA118633@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512082858.1806694-2-quic_devipriy@quicinc.com>

On Sun, May 12, 2024 at 01:58:53PM +0530, devi priya wrote:

Please run "git log --oneline include/dt-bindings/clock/qcom,ipq9574-gcc.h"
and follow the subject line style there:

  - prefix "dt-bindings: clock: "
  - no trailing period
  - perhaps add commit log text if there's anything else useful to put
    there

> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> ---
>  Changes in V5:
> 	- No changes
> 
>  include/dt-bindings/clock/qcom,ipq9574-gcc.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
> index 08fd3a37acaa..52123c5a09fa 100644
> --- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
> +++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
> @@ -216,4 +216,8 @@
>  #define GCC_CRYPTO_AHB_CLK				207
>  #define GCC_USB0_PIPE_CLK				208
>  #define GCC_USB0_SLEEP_CLK				209
> +#define GCC_PCIE0_PIPE_CLK				210
> +#define GCC_PCIE1_PIPE_CLK				211
> +#define GCC_PCIE2_PIPE_CLK				212
> +#define GCC_PCIE3_PIPE_CLK				213
>  #endif
> -- 
> 2.34.1
> 

