Return-Path: <linux-pci+bounces-13752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55CE98E9AA
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 08:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D40287775
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 06:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76186E2BE;
	Thu,  3 Oct 2024 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DxlSw8G5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DC23D551
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727935788; cv=none; b=FxPdE5IR6mB+vp1VE7RGuS/T0vTh4AWtVImrEz9TFSCWJAmopi5VX9h6KSBV+v/anS33cxv7ufOUV9AVWXVUtmfd6lopfqEgE66coaq8DkqGgbWmFFpE+kXKec6zbK8A0bbvgV3q6SgI63cBfy+Iu04wrmGjJ9mKnUrGsInW2WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727935788; c=relaxed/simple;
	bh=5qE7r2zF9aYX4kmLqkW5oVwtgaulZIS8B+W0wm0ojXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdW/ezIqMbFNg/D+SRBQG6+m7Uak9IOAvcgiTqsR6Z5xQ9zvyMmY2UeRsUTfLeb0vNRruifANuqAOkwTQ8OJFG08Hvl/oC94dq3E+RgpNmov9qqT5beUqvzY+xgz2sy7Uxselgx8Dq1Qytplp5bVsPv5avzdNLjo21qH69YrjnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DxlSw8G5; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b90ab6c19so5951805ad.0
        for <linux-pci@vger.kernel.org>; Wed, 02 Oct 2024 23:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727935787; x=1728540587; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z+l/BNMu/LG26jO3LSFHUD/mLYE9z78MrYoZ9LI74D4=;
        b=DxlSw8G5gySctd8N79YpdkB5vUMtzT2uBZiMADxbmy+kLqV3DG+DuPGSY3e3rmLS/2
         XSu9ExDt4IA4zIaqctHQHwWIWjkLBhSDXfZ/iJxgfvmSV4zDIIDS36SdCWzXS24UWisP
         UQJwiK/xtzR7nSyc6593gxDrjn6G53yIUH9IQKIiC3JAJQd3QmKjz4ptDa+brGg44AfY
         c+cHSpI/mogGhKXAR1HduiB5srZyDezRvpVE74REdahsHu3vQuRi+GV5I2lF1k2oslJG
         Pzd5u1msRn2kLxxPnfgBFsneLrowRYDWU/AsbGrvU5mEJ35HwsfcObWE7xDEOo/skb7D
         qTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727935787; x=1728540587;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+l/BNMu/LG26jO3LSFHUD/mLYE9z78MrYoZ9LI74D4=;
        b=TeXrPdThtAEtoFhbEbF1b9uc2bZpt1/74bjNBJ7UicON9cu61T9Im+5KVzDhkXPmhT
         VtigWkSZkmqvaLEfHcGLrHr5YPPXg5lhZe3/Yahqd5lHFSzq3SXj2F5ViWLUmf3QXvnW
         VhzdoROwZsuOx1qki09Wt/1IfaAer7r2Qpi3v2FKNsJhRHiCQVjHuVoylAQdqnnK/D8k
         ABuU7vwFXCP2f70JQSF5g3BocrngcnxtaSvBpPu/KF1vfzAFU6yYfjo8up6tZ0Q2XJFL
         SLEznJawVQdV77Tvwl2WFfmp3MlStLG6vYwPKtiujFk89U+/Z0Gb+qT0Ay1Z0SHfdWqF
         52WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCM6BppWYytTlNKIyDwYJb8R2Y8/4ZVfTjI6LHr4XZbkFL7xUVGonhFhK4HkXIxvkFZwM3gXwhfjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6OW8zd9mRD0kYQNWwe+QHHFVOq6ed2SzstsNUOkYCQ7p+pF8C
	D+8Rgnd4lS2NN5+ZBcpV6sjZAmEkECS9g3AC9wvtgl2Fy+S+2ySwkposUU5Siw==
X-Google-Smtp-Source: AGHT+IFigsn8XaXeeugwLxzQiUgwK2EEtzyoYGufQ0g6YwMrdXB5m+uDhfgnjNBLbesB2OvjVs5uNw==
X-Received: by 2002:a17:902:e54d:b0:20b:6457:31e3 with SMTP id d9443c01a7336-20bc59ec8b5mr85235575ad.3.1727935786729;
        Wed, 02 Oct 2024 23:09:46 -0700 (PDT)
Received: from thinkpad ([36.255.17.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beefb3b5fsm2513775ad.237.2024.10.02.23.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 23:09:46 -0700 (PDT)
Date: Thu, 3 Oct 2024 11:39:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: jingoohan1@gmail.com, kwilczynski@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, frank.li@nxp.com, robh@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v1 2/2] PCI: dwc: Do stop link in the
 dw_pcie_suspend_noirq
Message-ID: <20241003060942.af3nycevgtspzigj@thinkpad>
References: <1727243317-15729-1-git-send-email-hongxing.zhu@nxp.com>
 <1727243317-15729-3-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1727243317-15729-3-git-send-email-hongxing.zhu@nxp.com>

In subject,

s/Do/Always

On Wed, Sep 25, 2024 at 01:48:37PM +0800, Richard Zhu wrote:
> On i.MX8QM, PCIe link can't be re-established again in
> dw_pcie_resume_noirq(), if the LTSSM_EN bit is not cleared properly in
> dw_pcie_suspend_noirq().
> 
> Add dw_pcie_stop_link() into dw_pcie_suspend_noirq() to fix this issue and
> keep symmetric in suspend/resume function since there is
> dw_pcie_start_link() in dw_pcie_resume_noirq().
> 
> Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index cb8c3c2bcc79..9ca33895456f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -952,6 +952,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  		}
>  	}
>  
> +	dw_pcie_stop_link(pci);
>  	if (pci->pp.ops->deinit)
>  		pci->pp.ops->deinit(&pci->pp);
>  
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

