Return-Path: <linux-pci+bounces-197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F38B7FB115
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 06:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72DB61C20A6B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 05:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC4E748F;
	Tue, 28 Nov 2023 05:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BEwJczP2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4CC1B6
	for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 21:15:05 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b2f507c03cso3061719b6e.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 21:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701148504; x=1701753304; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2JoDhAoTR0SgWotjuFJFh8rPqxox7iwGsvE9hRWNQRY=;
        b=BEwJczP2xyMDqYZjkXdBYH1y4/RiWsFvRoKEfR4Jj5LO1TJYus3H2lPZJhQMXMbNY5
         UBK6IT/nlPA6S9e6oJTqBvwwx/kd13rcEnHRX3KpyXSVIHDNhXTZ8/q2SHh+WooYKkvK
         b0sfrt6bPajc2f+kMzxcXvi+Nrwb9flXFi6JTYqmkzkssa5uYbH4NNE1KxR5v5ZycSW+
         7FQKSSS+otz6sSQ9sUuuTGBKmMSACh5Z77H00WVpEvxirxLztLAzQKlr/hRoefGHMvc8
         adqpGrKW1szAp0nwtzuCX9uB1Sn2ODE78jM0BLd/xfqK7dnCesgneRu8WzNqHI2d0QE+
         m7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701148504; x=1701753304;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JoDhAoTR0SgWotjuFJFh8rPqxox7iwGsvE9hRWNQRY=;
        b=An2/EXn/gSclZ/wzdyAieRUzAhVlRxADnVwQn4bBy5os2I/yxbysVFnLYUxjbqkJ8Z
         B2sUyeHOIfP4XGVf7V7nv0q1/MxDWZD4gGB25mG2lHFNXzdF1sroDd65QWasw4TloU+l
         HJSHcVMkVXyGBjyQ6NhA2Ors3dh+q6RRK7AjTVVzLZYJlhw4jLJ2lVFzKywW2kx9ITPU
         VPsr3nrMW28b/0XMasfKcit/Dq9EMn8pzyjv6sHTTO1rH63L2VnriUvCBNIJE7EdlU++
         W3RepXhCKjhxT/avULaijJI0X13xZO0Ceu8T8B8IAgbbLk1Rv/LymRj5LAeO07qzMXBa
         lVHg==
X-Gm-Message-State: AOJu0YzUc/zeGVijQsE34ddkyxFSF0lrguHI/C+zjQ1EjJI/BDDrXq4T
	HaCfMX2xgr3XHopZnQE51siyewLV69J/skj4FQ==
X-Google-Smtp-Source: AGHT+IGyf/7KAwi2AXPmYeCIDQnKIhHc2XSuIyEGnblje0EJXhZBPY9aMi6CVPuB2Vd6usaT1FIhGA==
X-Received: by 2002:a05:6808:3209:b0:3b8:4ada:7d7b with SMTP id cb9-20020a056808320900b003b84ada7d7bmr19405065oib.28.1701148504384;
        Mon, 27 Nov 2023 21:15:04 -0800 (PST)
Received: from thinkpad ([117.213.103.241])
        by smtp.gmail.com with ESMTPSA id r24-20020a62e418000000b006cb9725f5fdsm8033842pfh.217.2023.11.27.21.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 21:15:03 -0800 (PST)
Date: Tue, 28 Nov 2023 10:44:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: intel-gfx@lists.freedesktop.org, helen.koike@collabora.com,
	daniels@collabora.com, linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Fix compile error
Message-ID: <20231128051456.GA3088@thinkpad>
References: <20231128042026.130442-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231128042026.130442-1-vignesh.raman@collabora.com>

On Tue, Nov 28, 2023 at 09:50:26AM +0530, Vignesh Raman wrote:
> Commit a2458d8f618a ("PCI/ASPM: pci_enable_link_state: Add argument
> to acquire bus lock") has added an argument to acquire bus lock
> in pci_enable_link_state, but qcom_pcie_enable_aspm calls it
> without this argument, resulting in below build error.
> 

Where do you see this error? That patch is not even merged. Looks like you are
sending the patch against some downstream tree.

- Mani

> drivers/pci/controller/dwc/pcie-qcom.c:973:9: error: too few arguments to function 'pci_enable_link_state'
> 
> This commit fixes the compilation error by passing the sem argument
> to pci_enable_link_state in the qcom_pcie_enable_aspm function.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 6902e97719d1..e846e3531d8e 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -970,7 +970,7 @@ static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
>  {
>  	/* Downstream devices need to be in D0 state before enabling PCI PM substates */
>  	pci_set_power_state(pdev, PCI_D0);
> -	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);
> +	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL, false);
>  
>  	return 0;
>  }
> -- 
> 2.40.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

