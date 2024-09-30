Return-Path: <linux-pci+bounces-13657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B18398AAB5
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 19:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A60B26D6A
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2024 17:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AE2194096;
	Mon, 30 Sep 2024 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXcJQt8F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70BD193418;
	Mon, 30 Sep 2024 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716263; cv=none; b=jd5scSLgwd0cI0ycfQDQGlfz4muhgrpXXpKYoP9+lwuNxekUoXqnoQ9JZ3IYqtGlaH1qCuFeh8XaxQs8s4F2JX2JW+7OnyAAWopTMGPvb4Xjk10Ll6itnq0fbInbagmPrk8kbpLlXolI3ng34v3AmZQsnTW9HgRvGjQrPX/P3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716263; c=relaxed/simple;
	bh=Tuc19cZt8pASN1cS3Vmu7tFxdzk2Z6Kwbjf+vvjqIE0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l/5xeKkgGbWI9fUDvYijYENReAHW8acwErTSuPmFjiXkU1aZl0+3B0BHwturdjcsm2p7rdQgAJ7844Bu88RbgF+T7BNKn6G/INsxN3h1Ltn7DOgKP7FLryWJhzFL+qKcnkqQVs2AEZDZcntMCXSt1wN79xrh6nu1lQlOr6K14jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXcJQt8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B72AC4CEC7;
	Mon, 30 Sep 2024 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727716263;
	bh=Tuc19cZt8pASN1cS3Vmu7tFxdzk2Z6Kwbjf+vvjqIE0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uXcJQt8FVIoKNnyxtENcKSApJ6kdEGqExSDTm1cWSv7M6h/opy64lHWGTscYaTdN9
	 eMqA9XMaKF4QYB1H5Hs2dgqPmfLyr/ir6aJaQdIMXOPVk/I7StnCLSBMRkbnebr9Ps
	 a1mdJ8Fk9XIm5NOWx9OZBWWUmh9PE1rxl8BZ7RVkyOCEG3RqVSpnL7fYGWP8iDU7H/
	 l+HM4w8nyi+TUYBmzPS69ObUzLlItedk7CbQW1+KdHUt9cXZNY/06QO5j15wnlq+BA
	 Xa9WO+OuBvnn5u9UgDAa1X58g8j7+7f1guj4HH1DI6reaPXUB/rLwQrwf7ZNiK19VE
	 sevCZd6+LQlDQ==
Date: Mon, 30 Sep 2024 12:11:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_qianyu@quicinc.com, Konrad Dybcio <konradybcio@kernel.org>
Subject: Re: [PATCH] PCI: qcom: Enable MSI interrupts together with Link up
 if global IRQ is supported
Message-ID: <20240930171101.GA180132@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930134409.168494-1-manivannan.sadhasivam@linaro.org>

On Mon, Sep 30, 2024 at 07:14:09PM +0530, Manivannan Sadhasivam wrote:
> Currently, if global IRQ is supported by the platform, only the Link up
> interrupt is enabled in the PARF_INT_ALL_MASK register. But on some Qcom
> platforms like SM8250, and X1E80100, MSIs are getting masked due to this.
> They require enabling the MSI interrupt bits in the register to unmask
> (enable) the MSIs.

"global IRQ" is a very generic name.  If that's the official name, it
should at least be capitalized, e.g., "Global IRQ", to show that it is
a proper noun that refers to a specific IRQ.

> Even though the MSI interrupt enable bits in PARF_INT_ALL_MASK are
> described as 'diagnostic' interrupts in the internal documentation,
> disabling them masks MSI on these platforms. Due to this,

> MSIs were not
> reported to be received these platforms while supporting global IRQ.

I'm trying to parse "while supporting global IRQ."  We basically
support global IRQ by installing qcom_pcie_global_irq_thread(), but of
course the device doesn't see that, so I assume it would be more
informative to say that MSIs are masked by some register setting.

The patch suggests that MSIs are masked internally unless
PARF_INT_MSI_DEV_0_7 is set in PARF_INT_ALL_MASK.

Are you saying that prior to 4581403f6792, MSIs did work?  Does that
mean PARF_INT_MSI_DEV_0_7 was set by a bootloader or something, so
MSIs worked?  And then 4581403f6792 came along and implicitly cleared
PARF_INT_MSI_DEV_0_7, so MSIs were then masked?

> So enable the MSI interrupts along with the Link up interrupt in the
> PARF_INT_ALL_MASK register if global IRQ is supported. This ensures that
> the MSIs continue to work and also the driver is able to catch the Link
> up interrupt for enumerating endpoint devices.
> 
> Fixes: 4581403f6792 ("PCI: qcom: Enumerate endpoints based on Link up event in 'global_irq' interrupt")
> Reported-by: Konrad Dybcio <konradybcio@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/9a692c98-eb0a-4d86-b642-ea655981ff53@kernel.org/
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ef44a82be058..2b33d03ed054 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -133,6 +133,7 @@
>  
>  /* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
>  #define PARF_INT_ALL_LINK_UP			BIT(13)
> +#define PARF_INT_MSI_DEV_0_7			GENMASK(30, 23)
>  
>  /* PARF_NO_SNOOP_OVERIDE register fields */
>  #define WR_NO_SNOOP_OVERIDE_EN			BIT(1)
> @@ -1716,7 +1717,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  			goto err_host_deinit;
>  		}
>  
> -		writel_relaxed(PARF_INT_ALL_LINK_UP, pcie->parf + PARF_INT_ALL_MASK);
> +		writel_relaxed(PARF_INT_ALL_LINK_UP | PARF_INT_MSI_DEV_0_7,
> +			       pcie->parf + PARF_INT_ALL_MASK);
>  	}
>  
>  	qcom_pcie_icc_opp_update(pcie);
> -- 
> 2.25.1
> 

