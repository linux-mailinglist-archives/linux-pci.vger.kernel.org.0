Return-Path: <linux-pci+bounces-10839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2469993D2AD
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 14:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB81C1F222DF
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 12:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A1117BB1E;
	Fri, 26 Jul 2024 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HuZlufqB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6FB17BB06
	for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721995238; cv=none; b=mRQurWM53kM/KzmIfT7jcu47czQ4n1/+HYnc21xwnS7+lJzOVfsgb+qMPykOSHqT34NaUBryKGOTE/fo/jZNOCwhMcoBSvrlcHxokDMILsz6JF8CZgOaacSnw980C7T4rkSC8uRX5OT2n3IiIjZRFYeOPxPMXyLnRFpnu+fUziU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721995238; c=relaxed/simple;
	bh=t3NW53ZkPecb65g7j6b0wRbYmlTbwnDzeBcUWc6cKiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2jKKHNgshZlTmcNI4K4dZn9pfIKR+npOYefqM/kpIRvY16xBPvELaXmdSId+8bvJge6FRbn4DbtLLleuCOekKTpWtJT6opa9fSAmPQpimg3U4mPiUOZFEeXdKutfsvDX/uQxy73D4km7TFpSwrVYTKrf++Abd9k4JN7v0p+CAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HuZlufqB; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-8046f65536dso50114539f.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 05:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721995236; x=1722600036; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EPFRRW8AIlKuxP8Q7EZWY4b5/1cZ7kF3YNc7kBeCMNA=;
        b=HuZlufqBGFtw5tz/HtAUy969P3ORfDrEf4aXeT6Lbmre3BuoKNM/hpUGZGKgpVNw2y
         wklD9Bqi6jEGxv+g0qcBqbgAanr0FXJH/9i3Q9Dq4WJxDJHJIyvjEH84BZdOE8FCB0QJ
         U9LyRQT74gisK1+hEEjRnxFkEzbG8jfyRCKoKGVlnyJstNkjY9Xda3YV+VVWfJHUS+my
         4RlpQFpt4ClhjjBZ+O1no0SsOOJrZFDrMVMUMbdowyyZC4kXSKAUEWgt7UummJRyZpit
         nelCah4mh/Pt4qomvrJCBNNKp2RUKibjW0mhO34WR3nMqn+knFzuggwpdrdBjGO84MHF
         24gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721995236; x=1722600036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPFRRW8AIlKuxP8Q7EZWY4b5/1cZ7kF3YNc7kBeCMNA=;
        b=uXkf7+584W6rvD8cDHpyT505bPqM6zH/K5lCUvpFEbKTO+RcBkXGkgC3mHK3w1OClF
         ih3MGUzlwff0BKUPQBfUwAe8xyXwUWy7AXyy1H2UKP81Cc86HYweBB3j6hgn3/oQtZG5
         x/54pUt68V4Ha+hZvOWSc+r1NuRGwTv9XF0IkCOaIJmBaC3WO5Jzt7N/ygbyfAWjGMyW
         XzwUsgC4irEH/fZjqVW6BlKzPxij7o3xsmJuNLqG72paXlLCCgeXmVc4wI5jlXPWyjfQ
         gsqonOJJAbWEBLwUM+vkcFxH2/iPbtDrpR7XECqK1rB7zENZmkZc6Z/jX5mLjne8EEnN
         pwUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9c2J0q7l8r/otmYnclDZXT8xZB7qhz+0AZLG7J42V1qdP2SVNCseEBT6mMn+7RWpgGXDIUqyjJ567YqDWdo8peRxuoRuLaQlO
X-Gm-Message-State: AOJu0YxVRFPQizrB4a0bAH8mPmkw2SYV3LHhcZQ+Vc3AJENZvZ/4Ed2R
	/M0Yar82wC8qNV9f1DBTQ4jgAA09DYzTYMiM9HvGMVVBbOlwyeIeuC2wNp/zXQ==
X-Google-Smtp-Source: AGHT+IGF1Vy8+vSXqTOa6id6FOH6iP3wriAe5OvwBBfxhoWQnfblL/Mji+X+LUi4afRVv7DXfGZn1w==
X-Received: by 2002:a05:6602:6d8e:b0:803:85ba:3cf9 with SMTP id ca18e2360f4ac-81f7e43ed89mr685325739f.10.1721995235684;
        Fri, 26 Jul 2024 05:00:35 -0700 (PDT)
Received: from thinkpad ([2409:40f4:201d:928a:9e8:14a5:7572:42b6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead72bd1esm2623180b3a.96.2024.07.26.05.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 05:00:35 -0700 (PDT)
Date: Fri, 26 Jul 2024 17:30:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Disable ASPM L0s on x1e801800
Message-ID: <20240726120029.GH2628@thinkpad>
References: <20240726-x1e80100-pcie-disable-l0s-v1-1-8291e133a534@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240726-x1e80100-pcie-disable-l0s-v1-1-8291e133a534@linaro.org>

On Fri, Jul 26, 2024 at 09:54:13AM +0300, Abel Vesa wrote:
> Confirmed by Qualcomm that the L0s should be disabled on this platform
> as well. So use the sc8280xp config instead.
> 

What are the implications of not disabling L0s? Is it not supported on this
platform or the PHY sequence doesn't support L0s?

Please add these info in commit message.

- Mani

> Fixes: 6d0c39324c5f ("PCI: qcom: Add X1E80100 PCIe support")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 0180edf3310e..04fe624b49c1 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1739,7 +1739,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> -	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
> +	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_sc8280xp },
>  	{ }
>  };
>  
> 
> ---
> base-commit: 864b1099d16fc7e332c3ad7823058c65f890486c
> change-id: 20240725-x1e80100-pcie-disable-l0s-548a2f316eec
> 
> Best regards,
> -- 
> Abel Vesa <abel.vesa@linaro.org>
> 

-- 
மணிவண்ணன் சதாசிவம்

