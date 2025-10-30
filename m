Return-Path: <linux-pci+bounces-39838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75464C21876
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 18:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E903D1A66C4C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F6536A5FA;
	Thu, 30 Oct 2025 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="KeQETYzR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D49365D21
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846057; cv=none; b=NvYbW0ELSeBS/+u3nvoT7UuBMUSDRzPts72eaGP4s10AaQWB47CpsMcsKUwB8fCdmt3xKWgx4wHEmufU2Y+e+9nZr64YzZE/feHm2FjhlhRDRW27ip6cjRyma7PbNfiAWX+DF14llI52J3uY00MRuRP7NKysQmhlLP6oOprHlto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846057; c=relaxed/simple;
	bh=m/ntmb/Nr5XTaAoFpnI3XGWj4UVbw7mUq1L0Jecd/Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuRhCEao9TkbSJmlTwP3fPXQ/2APmsRbPumJnQu8Bt8ZNOCFNigk1qfCzE4+m5v5Wh1rYrTSC1YQkC81Oj0rsD+HwhuBm6LnRW5IRmlPa+rHkXyBNNokJlHuC38RZdFE+B/4LRPQ8kv7WcQVjyDu2/QXWjHDUFl5h5YZe6blzAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=KeQETYzR; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-433010fdfbbso12126185ab.2
        for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 10:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761846054; x=1762450854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/22pqQ5hwp4Fzi994om9q5KGyGnCNdWdbuYVMsnFBOM=;
        b=KeQETYzRUj/5F25ISREZW79vifauKna9hMNIBP8Pud3YRglQxMs8o8vEwONSJFZwVw
         OHdQjZ1Ne+i0p+7BKavxShwvwGqTyor4DByWO4iDIpN9ONz6vfxbdAzcO7fZsqfdj3SW
         t89/1kMGSBY+H35j6UV+K0MAqY0gn+hvQTNOVFKY3pE6swZLiFiq90hlhctzGKv/Gzs7
         plvQuaKgXuNtnK3WzeO8t/YCcEnUzc4S5mc6mm32OXLSGN4r4tQHXsVZ5fNDr8+3+NGX
         oIOgd0HO8cl8H0dfBgXhciDTGJIzxQSnjo+aJSJoXByUJcf6wXDbgrCQNuPV61u0zeNj
         vHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846054; x=1762450854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/22pqQ5hwp4Fzi994om9q5KGyGnCNdWdbuYVMsnFBOM=;
        b=b7sNKt0LTINfTwyIIvqU5hXiO8ypfbGJKPAlM2T0cAVv9YyX2lDlooUTpmcuB88tNv
         ohGG6EGMOAzhSsEy89paJ+riM78jHtIJPHedDjz8DAKgT1QEz4C4inE1rmiMaLibrBsG
         DRXbmBoFoYXrnBdOMlgPKOaphXkV5XeoCpWfJN2L+wtj+vm2WzjkfrDLLKM8e4HPTctL
         rD+bjvEkPlDoPGe7nn+7I9/JMzrAerfZfrKMjbCwd5c45ek28HY7sT+QciMaWJtTN2Hr
         Q1+gFv5z73Cnf1eQFxeftWJjIlyzUGepQqB1w+nWV+q4TkaLaR4vf8nutHjMywrBFCzY
         28MA==
X-Forwarded-Encrypted: i=1; AJvYcCUY5osG6zFy+IPtFdpUtLw2YXz+B0T7/XhGgVUaOgk9Uv8lkVMuCoKhJCJoJGJ+6zGzaGbI0HtJBdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyimKhWiVlk4nNKUiRmisSAAMPT8jrqr8Yq7ZBLP/DfQpzPS5u2
	fEOSO3dVPz3iyCWOgI7rOvOo4H3o/H4nbkolY2SZ8DQQ8hS7LNVtrwHG3wP2/wNjyLI=
X-Gm-Gg: ASbGncvB9ooBVQrfXhxSMOstCfk+XwsI6o2AGRnZF/FzyQhNkRqmq/EM6sUGWQ0jgob
	8igErHTxmUt6c2JYpmyV+vRlwB35qYTj964/UwmuOWNyVY0BkJQRxFc/nlRRxjJWS7eSBDfal9u
	z3D+NT8Sl/84eCpcSJl3S0MWeEOKX6pOhWis2/FI66Ad50dRsQClx9rSu2rJpjSPz8uavSo+b5T
	I8k0ZMrk/gMcQeZtlWJK8uIlbZ00Wn7fnugu4zoIDNM29R44BO4quAMqpxbnMYbhbBtpr46o7ie
	uFKNsAnQPlGl3ptVjTwZrtKIWWtWQPtkqEz2nIStFZqe/6M82yipwPshJxnxKQRIaEeTaXXzLUx
	2P9lNpbIZ3EORUjYFxp8ry8r2VqU7ts8yABuIImvlveSIhS0CI8ivZSSpgFReDyVmdLt6T2PoK2
	Kw9UnZbepg8xfUzPh44YDc50hMY386aNKvGxYO34yK
X-Google-Smtp-Source: AGHT+IG0aVGPP4r/NKWIuJVfbyDvqDCX0k5Xe21gfoqAbmkB04rb+6Q12tuONUjEXsT6ELB2rdCzfA==
X-Received: by 2002:a05:6e02:1a28:b0:432:fbe2:35f2 with SMTP id e9e14a558f8ab-4330d125b9dmr9455495ab.4.1761846054513;
        Thu, 30 Oct 2025 10:40:54 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4330a6ffddesm2802175ab.27.2025.10.30.10.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 10:40:53 -0700 (PDT)
Message-ID: <43333e1f-dcc2-4691-9551-3c35ba04bf7b@riscstar.com>
Date: Thu, 30 Oct 2025 12:40:52 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Warn if the MSI ctrl doesn't have an associated
 platform IRQ in DT
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251030171346.5129-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20251030171346.5129-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/25 12:13 PM, Manivannan Sadhasivam wrote:
> The internal MSI controller in DWC IPs supports multiple MSI ctrls, each
> capable of receiving 32 MSI vectors per ctrl. And each MSI ctrl requires a
> dedicated MSI platform IRQ in devicetree to function. Otherwise, MSIs won't
> be received from the endpoints.
> 
> Currently, dw_pcie_msi_host_init() only registers the IRQ handler if the
> MSI ctrl has the associated MSI platform IRQ in DT. But it doesn't warn if
> the IRQ is not available. This may cause developers/users to believe that
> the platform supports MSI vectors from all MSI ctrls, but it doesn't.
> 
> This discrepancy can happen due to two reasons:
> 
> 1. Controller driver incorrectly set the dw_pcie_rp::num_vectors field.
> 2. DT missed specifying the MSI IRQs
> 
> To catch these, add a warning so that the above mentioned discrepancies
> could be reported and fixed accordingly.
> 
> Fixes: db388348acff ("PCI: dwc: Convert struct pcie_port.msi_irq to an array")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


Reviewed-by: Alex Elder <elder@riscstar.com>
Tested-by: Alex Elder <elder@riscstar.com>


> ---
>   drivers/pci/controller/dwc/pcie-designware-host.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c..f163f5b6ad3d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -357,6 +357,8 @@ int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>   		if (pp->msi_irq[ctrl] > 0)
>   			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
>   						    dw_chained_msi_isr, pp);
> +		else
> +			dev_warn(dev, "MSI ctrl %d doesn't have platform IRQ in DT", ctrl);
>   	}
>   
>   	/*


