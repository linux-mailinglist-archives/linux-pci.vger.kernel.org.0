Return-Path: <linux-pci+bounces-9977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1F692AF58
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 07:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5411C214BE
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 05:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B47E12F37F;
	Tue,  9 Jul 2024 05:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NiZY5C6O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF1D12DDAE
	for <linux-pci@vger.kernel.org>; Tue,  9 Jul 2024 05:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720502106; cv=none; b=IHqobRzLpCxVFY9rKl0J5EuJW6e+rz8iEFyOK3QDYFLkJUjJbf+1pCILFME0QZGzE1iqmCW/27UsAyUQVqeYLtRV4Nw9gQdvx1YYapAaLIiP5jNqN49TNAdM88/57u4mpisSQhOPj76RlNSNutFJDtrxKyIXACaUDQ1iytsBHoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720502106; c=relaxed/simple;
	bh=t7jsp+2AhCj4302LaXnCltCJorzxGApkgadG8T3SGZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFERtkb8kzcd5rNUUcPuUEMZrMimnTa3XkZG4bvoDi25EcJjbfOrBbgOHVTpnP+Jkk2AUIUBafk/rZMNR/TzaJe3mOMA38133liYGYhRftleia5IRXEd9Hzd9avAIPDnr8mNFk5t7WrmVaqYQXL7ZeauvZg6lgfGL+3Z5Hb3YFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NiZY5C6O; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c927152b4bso3207257a91.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2024 22:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720502104; x=1721106904; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sOxAsVn43J6UpGnYmdp9+zQbgWtHk77XaVfxeI89xW0=;
        b=NiZY5C6OQMuNb6zxCZb5x+IUbLlJdeKErjVXzpvJTpQ/Kfh76XiQZrvdWGEE82BQXh
         Bw10gJFSU78rGF5Wtpku0BPNlHBYje6RS2WuOphrZOm1ZYbs853jvDKS+xjDEMO7rhwI
         BC+Qg+rm92zwu4ZRMv9xa7RM6GFuNylSHphPqCMK3y5PnMR20YjO0iGhdgC2TF8Gzji9
         Oix9A0vGmVS5YJ8W8wxaKswsO1m9ThCnepfl+0E4+adAVeC3klT1b26fvrGWlmEovbfm
         s4tJR8kmrV/Wvu2ne3cx2WXbX0wkKp1bjXoL8vd9cC0lo50hYiL/UdNf/iasRBW0Iylp
         MAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720502104; x=1721106904;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sOxAsVn43J6UpGnYmdp9+zQbgWtHk77XaVfxeI89xW0=;
        b=gYrwOjssHFjte3EDT2ekWcTGUA1oF4T4uhiu9GUcNhiwHIaIz3DcFlnaP+CUFZg0Mb
         QDojX4prPKBJfptNQ1ssBPVrpRrycfb9+d2hytGsx+Wj31EC/M+/2Q7Amma86k4jrnZU
         vngtnp5/yb2EDcV8MWJ9b1U0zyub7Hk5RTcACXZr7TKJ7anMCrweEKt43XVBMaTIn0Qo
         Yc1WkqBjH/fIoSA8uxy8/phZqwFxXYtdJ1dZ4xPHiMrG/+pQl5FFQxKLz6R+Lpr4HtLZ
         Kduk9Ox7wnHLR5jA9GsgPHWTRd1AXjOYOsUgYC1P5AtyQwlVOkCksb4+zjK76Khetj9J
         vtKw==
X-Forwarded-Encrypted: i=1; AJvYcCVG+pNN51dCL9rEO0bcdZGTP3gVIFAyKkoAnbm4nmhggakMEi+OQDLge7LNVKzHLWoUKN60qM0j7ostsy9V7Zg8UcNmxOe47ivU
X-Gm-Message-State: AOJu0YwyzyddDHAl05MvQBqvLCn9Px1yk4EAaYaRMS2DV4Nt5/GeuIaU
	8xkrPr7F3ORB4llzv4+vbL/cgm7cV738pzUvA9VYNzEGlb5VyfLjC37V+Gyq+Q==
X-Google-Smtp-Source: AGHT+IFMPt2WcyXDbYXxbpB1uFGYlWS51hUTnzsaIrD7vrfdxxoFcZTdu7U1ZXRjpWQLeduAHLq8ig==
X-Received: by 2002:a17:90b:1049:b0:2c9:649c:5e10 with SMTP id 98e67ed59e1d1-2ca35bca181mr1425092a91.10.1720502104337;
        Mon, 08 Jul 2024 22:15:04 -0700 (PDT)
Received: from thinkpad ([117.193.209.237])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca352c5bd2sm912487a91.40.2024.07.08.22.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 22:15:04 -0700 (PDT)
Date: Tue, 9 Jul 2024 10:44:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: qcom: Prevent potential error pointer
 dereference
Message-ID: <20240709051455.GH3820@thinkpad>
References: <20240708180539.1447307-1-dan.carpenter@linaro.org>
 <20240708180539.1447307-3-dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708180539.1447307-3-dan.carpenter@linaro.org>

On Mon, Jul 08, 2024 at 01:05:37PM -0500, Dan Carpenter wrote:
> Only call dev_pm_opp_put() if dev_pm_opp_find_freq_exact() succeeds.
> Otherwise it leads to an error pointer dereference.
> 
> Fixes: 78b5f6f8855e ("PCI: qcom: Add OPP support to scale performance")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 1d36311f9adb..e06c4ad3a72a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1443,8 +1443,8 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>  			if (ret)
>  				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
>  					freq_kbps * width, ret);
> +			dev_pm_opp_put(opp);
>  		}
> -		dev_pm_opp_put(opp);
>  	}
>  }
>  
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

