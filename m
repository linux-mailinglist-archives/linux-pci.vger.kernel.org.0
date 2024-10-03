Return-Path: <linux-pci+bounces-13751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0095898E9A0
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 08:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA83B2870E1
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 06:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AE959B71;
	Thu,  3 Oct 2024 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ht6wX2wf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20441760
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 06:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727935469; cv=none; b=HC0gGM7MTI/KkEvEKraPBpkZFrbXPuU/NomIo5zONd9IX0Nb3tRlR8VK5+ao/dPygkHk3jkYGCYRGyC3/fIeNTYkb8xpWN78rU2lyjNW9CoNVmUcSeIgTgDAy3CrnaFYpcGC/kfFlMlVsi8XSdnDUa50jhVO7Vl9uRDKIc8JE1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727935469; c=relaxed/simple;
	bh=X2pDXwzUvcJDk5paVKoKsB3r0vt+Ai0zPt8NKqANJkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUi5zWHhsJfXXTGMbjGKZBPUu1xwlqxXAr54xUDpwBDADPxkGgvZmZ3QEq9MUq4LvmfKvKfV6oM5l+SS6AJ9HC6kY38epeaAU+rVmbZmrYH6bCzPZXMp1FgSb7s6bNnof211s7G0e+vAJ/9avKk5chRgEd34ohvI6HIk3AAwinc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ht6wX2wf; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20b01da232aso4569855ad.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Oct 2024 23:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727935466; x=1728540266; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DSlA9LdetpttvG342s77JyTcYN0Pv4f2/NSU0/ow4Vw=;
        b=Ht6wX2wfDGgz3wQelQ0XKVD09/6r+8mupGmSSgpDeDmMBB6AhdqwnyOrKCQ2OTt1Ll
         4PAlUnVBIIod7kPew3xOkOqJIZ2KoWzZQiFd0zXJp5k60uXrhDZWilvt0AbFyY9pNlJL
         rVqAVy6v/ApYViN+iEyiAwKUgwwL+WZYfgLh4jgfwrZiDqs9XGwCaDEpFd4m/kxwQNbe
         HetlW2DxpIcUXcnwbLjj0OwtqUxA031MmGjUjuNtIJqG2Hw6RT74yikInAv8eRr6gCdD
         0vM2ih03tdtu/NbNU5RC8diAskJKMwunkj5vhWOAhnunY8+0t9LFS/RsiaCoL8a+p3Ym
         OMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727935466; x=1728540266;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DSlA9LdetpttvG342s77JyTcYN0Pv4f2/NSU0/ow4Vw=;
        b=bjt6TxgV3b0RaRRWIZCEeKz9L4z79Rh2JxWW8C3JqIy7+se4Z4pEm2Hzw8ZZ9u30mT
         5sziBrqVD2eYhViUX5HoGK5TtgvgQVDhfbSgQjmSdNww6FFrj1QXYRa96xgnlZ0R+5TA
         sY7+tPzAq1/tLsTe8zJpCnLJQ2vV6K7dlA+UF+MYGgC9gvE6rHJzqiGl/g76rBCPAO0x
         IGkWAb9hCY4gAfWovJ5WC5lXZaJMkJ1++HIYr4SQUEFemjB3ObdAFeOzyD6OvkdZOBLv
         1PbrADLD7/cN1xTnO6YshDbD8OXp1kucOiYbVf4Si23eT1XuF5yL5stP3Kc7pyE85mOg
         GUqw==
X-Forwarded-Encrypted: i=1; AJvYcCW/Skd4OygpH8MCvHm25IuPGmuEnLFBVWG5rIWHqImwMw6GifAoGBqoPmtOLezACjS+eGWTnK4p8QI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7bXPwV9/C3XnwjZ/kJyTUCVXTPs5JbyIEaQPw/JJNx8ByFLY
	sYnGyBBE26hi/K+CZXFa1hoKKSDsjpjVmzTxvYHWXWYz4EhqTWfFM4v9Tx6iXg==
X-Google-Smtp-Source: AGHT+IEbkU9RN3nbPopsmQ73+roAKVA+VXZZkTBotV2rwtzyji8m7LBm5NKo07zHuz5P5iw5DLR6+A==
X-Received: by 2002:a17:903:11c3:b0:20b:59ae:fe1d with SMTP id d9443c01a7336-20be193af84mr29711125ad.25.1727935466244;
        Wed, 02 Oct 2024 23:04:26 -0700 (PDT)
Received: from thinkpad ([36.255.17.222])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bef7fd9casm2384025ad.245.2024.10.02.23.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 23:04:25 -0700 (PDT)
Date: Thu, 3 Oct 2024 11:34:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: jingoohan1@gmail.com, kwilczynski@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, frank.li@nxp.com, robh@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v1 1/2] PCI: dwc: Fix resume failure if no EP is
 connected on some platforms
Message-ID: <20241003060421.lartgrmpabw2noqg@thinkpad>
References: <1727243317-15729-1-git-send-email-hongxing.zhu@nxp.com>
 <1727243317-15729-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1727243317-15729-2-git-send-email-hongxing.zhu@nxp.com>

On Wed, Sep 25, 2024 at 01:48:36PM +0800, Richard Zhu wrote:
> The dw_pcie_suspend_noirq() function currently returns success directly
> if no endpoint (EP) device is connected. However, on some platforms, power
> loss occurs during suspend, causing dw_resume() to do nothing in this case.
> This results in a system halt because the DWC controller is not initialized
> after power-on during resume.
> 
> Change call to deinit() in suspend and init() at resume regardless of

s/Change call to/Call

> whether there are EP device connections or not. It is not harmful to
> perform deinit() and init() again for the no power-off case, and it keeps
> the code simple and consistent in logic.
> 
> Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 30 +++++++++----------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index a0822d5371bc..cb8c3c2bcc79 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -933,23 +933,23 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>  		return 0;
>  

There is one more condition above. It checks whether the link is in L1ss state
or not and if it is, the just returns 0. Going by your case, if the power goes
off during suspend, then it will be an issue, right?

> -	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
> -		return 0;
> -
> -	if (pci->pp.ops->pme_turn_off)
> -		pci->pp.ops->pme_turn_off(&pci->pp);
> -	else
> -		ret = dw_pcie_pme_turn_off(pci);
> +	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
> +		/* Only send out PME_TURN_OFF when PCIE link is up */

Move this comment above the 'if' condition.

- Mani

> +		if (pci->pp.ops->pme_turn_off)
> +			pci->pp.ops->pme_turn_off(&pci->pp);
> +		else
> +			ret = dw_pcie_pme_turn_off(pci);
>  
> -	if (ret)
> -		return ret;
> +		if (ret)
> +			return ret;
>  
> -	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> -				PCIE_PME_TO_L2_TIMEOUT_US/10,
> -				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> -	if (ret) {
> -		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -		return ret;
> +		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> +					PCIE_PME_TO_L2_TIMEOUT_US/10,
> +					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> +		if (ret) {
> +			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> +			return ret;
> +		}
>  	}
>  
>  	if (pci->pp.ops->deinit)
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

