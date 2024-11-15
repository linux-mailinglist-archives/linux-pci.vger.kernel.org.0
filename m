Return-Path: <linux-pci+bounces-16878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B129CE06F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 14:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0C71288F5B
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 13:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4511CF7AA;
	Fri, 15 Nov 2024 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V6i5qnmO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8641CEAD7
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678158; cv=none; b=bP/HKf5PpJ43hFrjfJLhGBLWtJVJSj/xx+Bx7WiKlIR4+rPHm4hGnght5XrnynGNiTSsVMxnd+MQc3/+Q1WIklt/65p6RJx1pZc2lt8djXf5YGhfrFqOC+M1Gt0OOwU45cEqMbhUW4FWLvHfPyDH6VJ0bgm40D/mWyfvrJFJ50E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678158; c=relaxed/simple;
	bh=mW3MuLmfbgIMEqgVEGW9baS2AV3fJYbovPzK3y5vOSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+hJczLeGPvpnJqQe0Z/nKTCBoFxiZPwyVs0TfE1XWqtu9//Xuaaq7B6nqZYVt5n9iYZ5DxgMugGNDJtuViHrVc6SWArSvZoTlkx7GWeU9C+Zff2FQXnaOw+GlL+HbpIg+Dy3ee8fxNHM3cs0zW6zg9vvDeTf17LoOEwazG474I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V6i5qnmO; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7eb0bc007edso382835a12.3
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 05:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731678156; x=1732282956; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1FkyVdlsRATShGE8GfRS5lqV1OLED0nfmhN50QSZ3W4=;
        b=V6i5qnmOEksL3X37vmLJT+98Tr24N10KWRVNBSW4ulKU9POP2zVc+v/3+7RwwpRCPk
         fWaz3fsJHONVmf+6lP0933+wva7g9M3gR/4ytjlOJOCSwU0NOCZ9CftSP1gyfjgNCqOJ
         t3FOr9kkL+GzqWlTsgnBYx+WydaL2KNybDEXVzorDBBkdJXClZErMEWn78qxr42IEkv1
         I5ZSMbHwKd3zXBJPqK5aeQ11e2kjOwKdOGro12dBgnNU0PFtcB0UAiF/CoDgwCpt8gGT
         s67mCcH0/WYC4PiRy5b3Fdol/O26WXr1ulUwX2dlEyhVsEq7+Koq5q5Bmt+r0Gu/0PCE
         vSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731678156; x=1732282956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1FkyVdlsRATShGE8GfRS5lqV1OLED0nfmhN50QSZ3W4=;
        b=V9PGrftmL8a5EImfQDgQ1v5+8gIA3tHGb1b+YyaylbRNOXAs7nA28uQHYipH7jLvpD
         mj4S3ZOi5B1qsSdzlX0rbOLK8ROFnjP6ehME3Ei8I3ZtWa6YwzMuHPCqHGRLoCFjjeH0
         G79Gpx4T7EuNDNlGV3J4jPjBG7X5rMDgPrsTBJO/pfquFyDW5Uhro8bhDLDNxKZnLuys
         uXuJYaz+TdnHzKu6YSJ3kMPRpdhjvEL61Oht51wCeloaEpufxLRAo8Oy3jmXL0Ylk7uV
         pIL8WuZCgbia7KLoiFUhqECXPSHbMxWA0eqcepRKTabTcjkeR9+c6nTvVqXp0BKDnaC+
         7cng==
X-Forwarded-Encrypted: i=1; AJvYcCXnH3JLvFlWnllB4RCVqgRGs/B1rRnDdjx+YD+VFuyMbgyUvAfMJRMZhIkpRo/FdP/5Sd97vgTBqzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtrQDaaHfiK1W3sOB/YWXe5PQHkgTlOPkQlpZbiJRC3Db3tIo
	hJ97WOgYKr2H0cIh5+DHJX4YWafwxl9+66YSF5JEK1ki0FvkM/SVa3KI2sbvZg==
X-Google-Smtp-Source: AGHT+IGp/OjSmn7NxjC0IsG1rKt5fpJ1gFFvGf7ngcn+SVF2YiP5ayY+G6aeEVN7i6XGfOtMHxDk0Q==
X-Received: by 2002:a05:6a20:12d1:b0:1c6:fb66:cfe with SMTP id adf61e73a8af0-1dc90b51f1fmr2758521637.21.1731678155980;
        Fri, 15 Nov 2024 05:42:35 -0800 (PST)
Received: from thinkpad ([117.193.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771c0cb9sm1360035b3a.121.2024.11.15.05.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 05:42:35 -0800 (PST)
Date: Fri, 15 Nov 2024 19:12:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: jingoohan1@gmail.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, frank.li@nxp.com,
	imx@lists.linux.dev, kernel@pengutronix.de,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Message-ID: <20241115134226.w27n244spddoavqt@thinkpad>
References: <20241115090321.527694-1-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115090321.527694-1-hongxing.zhu@nxp.com>

On Fri, Nov 15, 2024 at 05:03:21PM +0800, Richard Zhu wrote:
> Before sending PME_TURN_OFF, don't test the LTSSM stat. Since it's safe

s/stat/state

here and below

> to send PME_TURN_OFF message regardless of whether the link is up or
> down. So, there would be no need to test the LTSSM stat before sending
> PME_TURN_OFF message.
> 
> Only dump the message when ltssm_stat is not in DETECT and POLL.

s/dump/print

> In the other words, there isn't a notification when no endpoint is

s/notification/error message

> connected at all.
> 
> When the endpoint is connected and after PME_TURN_OFF is issued. Just
> print out one information instead of an error and exit, if the link
> doesn't entry DW_PCIE_LTSSM_L2_IDLE stat. Since the recovery would be
> done in the following closely dw_pcie_resume_noirq().
> 

How about,

"Also, when the endpoint is connected and PME_TURN_OFF is sent, do not return
error if the link doesn't enter L2. Just print a warning and continue with the
suspend as the link will be recovered in dw_pcie_resume_noirq(). "

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 37 ++++++++++---------
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  2 files changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f7ceeb785fb0..c2053555c44b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -927,23 +927,26 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>  		return 0;
>  
> -	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
> -		/* Only send out PME_TURN_OFF when PCIE link is up */
> -		if (pci->pp.ops->pme_turn_off)
> -			pci->pp.ops->pme_turn_off(&pci->pp);
> -		else
> -			ret = dw_pcie_pme_turn_off(pci);
> -
> -		if (ret)
> -			return ret;
> +	if (pci->pp.ops->pme_turn_off)
> +		pci->pp.ops->pme_turn_off(&pci->pp);
> +	else
> +		ret = dw_pcie_pme_turn_off(pci);
> +	if (ret)
> +		return ret;
>  
> -		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> -					PCIE_PME_TO_L2_TIMEOUT_US/10,
> -					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> -		if (ret) {
> -			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -			return ret;
> -		}
> +	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
> +				PCIE_PME_TO_L2_TIMEOUT_US/10,
> +				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> +	if (ret && (val > DW_PCIE_LTSSM_DETECT_WAIT))
> +		/* Only dump message when ltssm_stat isn't in DETECT and POLL */
> +		dev_info(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);

dev_warn() would be more appropriate.

- Mani

> +	else
> +		/*
> +		 * Refer to r6.0, sec 5.3.3.2.1, software should wait at least
> +		 * 100ns after L2/L3 Ready before turning off refclock and
> +		 * main power. It's harmless too when no endpoint connected.
> +		 */
> +		udelay(1);
>  	}
>  
>  	dw_pcie_stop_link(pci);
> @@ -952,7 +955,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  
>  	pci->suspended = true;
>  
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 347ab74ac35a..bf036e66717e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -330,6 +330,7 @@ enum dw_pcie_ltssm {
>  	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
>  	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
>  	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
> +	DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
>  	DW_PCIE_LTSSM_L0 = 0x11,
>  	DW_PCIE_LTSSM_L2_IDLE = 0x15,
>  
> -- 
> 2.37.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

