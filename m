Return-Path: <linux-pci+bounces-17386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 791449DA1E8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 07:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390C2284D90
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 06:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAEF1465A5;
	Wed, 27 Nov 2024 06:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgCuCjMg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4285913B2AF
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 06:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732687306; cv=none; b=hqt4nqhiTOylAjcQ7b4HgeBJpG/TSYeSFPJlwxI5LRKd4C3nu/laEVZQYuqUJywTd5ucNFPup6DLEuGO9fRaRbiSLvIUneOBZ10//ZE7LM95ori/zl4Qt4mXLUMUCdZYl1CoRtwCUaJ5jSwUsaGX5epDDGQTA6T0etDJHkpkuqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732687306; c=relaxed/simple;
	bh=+pmdwmmhZdYr6Apa02nMXEwsIq+I1rZk5qVaZg/xJpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZDcIh6vspRQVyu5hZihDA6kebkktBi/s3teHBlyzjXEdM2WEy81hhOpCSfXBeVpzz1/Vheun5MB6nLKB/ADoUHELHDy3waahSEUTf2ZOspvtKWoYu1OYwpXQDaNp60FCNdapzcfYSGH5N+waUOst/GUZRGG4peEAzeRtjK1498=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lgCuCjMg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2129fd7b1a5so46505105ad.1
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 22:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732687302; x=1733292102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ykkZstOa8bXXD8shy4Wz7LF8azAidbDjZzgBbS7DJo4=;
        b=lgCuCjMg8lt1ERGSh/I/g2XeWt2DRWH1Mq3gosmavMfNPvHDDWXkQuvGq2e5Z0QfiZ
         VWRCCbJaOlOXEkxiKgCp/rNXRd4pEsWY4otUnmEPDuDdxi3Ow66VZOidmq5kMymMV/5r
         y2eWcrZaL8rCIhQtO4Tj32MxfG8nfAukJF0qeXgUzeFREEr2ZFRWI0nV949Sg1jAR63+
         iOJwjBHXtpkB+O1vOtXRSnHezy0o5eznT6VsMxI8YmJ1OGMLOWz8uCdiufPAYRpMU9SP
         kTg8dIty4ScvJe2iFU/kt/NPNh8zZOvZ4RWWcI/9/IELd2Y4GI5e571IanmqH5eZG/nZ
         /kvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732687302; x=1733292102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykkZstOa8bXXD8shy4Wz7LF8azAidbDjZzgBbS7DJo4=;
        b=ogWlA8ShnR43OWmS3hX/Kn+SUqqn6WCAibJ6+WrRR+QgsHLuyIjh9piD2IMS+DKDFC
         GZgwXSP/ndvusgEdTbgXIcwSUuKzliDxlllhdPrbrPfqbFnk7rK6/5Vk3gC658SKm6O+
         ooUWyjoK9WCHn/0QZKEAvKfHVg8Jk8awhzCR22oTG/ONgm+1yDakBuG0e3E9QelmVpPH
         2/8HzDnooFOYP8dcK5cdqCo3OwqdFEg8nT4t10FDKbim/3T75QuklKIWS01U+2NWybac
         FW4f5lwkYQbBHWynDWZrebbL0ZrTd/DUlWayXCe5vgGfHHUSL6cI9Px7B97QGa1guhoS
         TGAg==
X-Forwarded-Encrypted: i=1; AJvYcCWz5cy727ECOIT4DSBJ2bx/Rf+Np7TPz/bfB+TEgDonkpbGWtpCY97nEB0Gwq1XCw+bfaCxhd3NmGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZPIxuf8R7s1laeAV75x5RuyCQlDWQf2tRcvnBlvVfTfsFrNP
	UU8mQCjehjlKjPPUqMon6me98US8/8KpWkdaUqMXSl3xr+TtIKoB6xUnI7Iq0g==
X-Gm-Gg: ASbGncu2c6/5KTe/WTRPm/eaAepDjIYWQAY8Zl8DzYcfOtKI16b6hpdxArh8KnWQQZn
	lgfoPvbrVTo0XHq+9vnl+9r6viUqtlmKx199iSMxu+YY88mFS/zSskYXuAzlx70MF+O0WQP11QX
	8RJeb4RgGl8T5+pt2P3RcMPVba+FhJU9tJPCRUrUS8zXuFpDBEu6WN2aKV4KcoTwLuQ//hGfz6F
	LcaGCtQ/8E629us1qYRnpa0/87etFLBeNLaFyd3o2qvGESJUyuY0lPB4elK
X-Google-Smtp-Source: AGHT+IElcgtOc9MKuqCcQKs788nAqHcwj4F+w9zIfHU7WoZTfiySo28O12pa/pXEa3gpawHEreJy/w==
X-Received: by 2002:a17:902:d4c4:b0:212:48f2:9be9 with SMTP id d9443c01a7336-2150185797bmr20448515ad.30.1732687302401;
        Tue, 26 Nov 2024 22:01:42 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba345asm95076825ad.97.2024.11.26.22.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 22:01:41 -0800 (PST)
Date: Wed, 27 Nov 2024 11:31:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: jingoohan1@gmail.com, bhelgaas@google.com, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, frank.li@nxp.com,
	quic_krichai@quicinc.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI: dwc: Clean up some unnecessary codes in
 dw_pcie_suspend_noirq()
Message-ID: <20241127060132.hsawrwlkxkgvvji5@thinkpad>
References: <20241126073909.4058733-1-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126073909.4058733-1-hongxing.zhu@nxp.com>

On Tue, Nov 26, 2024 at 03:39:09PM +0800, Richard Zhu wrote:
> Before sending PME_TURN_OFF, don't test the LTSSM state. Since it's safe
> to send PME_TURN_OFF message regardless of whether the link is up or
> down. So, there would be no need to test the LTSSM state before sending
> PME_TURN_OFF message.
> 
> Only print the message when ltssm_stat is not in DETECT and POLL.
> In the other words, there isn't an error message when no endpoint is
> connected at all.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> v5 changes:
> - Remove the redundant check "(val > DW_PCIE_LTSSM_DETECT_WAIT)".
> v4 changes:
> - Keep error return when L2 entry is failed and the endpoint is
>   connected refer to Krishna' comments. Thanks.
> v3 changes:
> - Refine the commit message refer to Manivannan's comments.
> - Regarding Frank's comments, avoid 10ms wait when no link up.
> v2 changes:
> - Don't remove L2 poll check.
> - Add one 1us delay after L2 entry.
> - No error return when L2 entry is timeout
> - Don't print message when no link up.
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 38 +++++++++++--------
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  2 files changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 24e89b66b772..bbd0ee862c12 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -927,25 +927,31 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>  		return 0;
>  
> -	/* Only send out PME_TURN_OFF when PCIE link is up */
> -	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
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
> +	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
> +				val == DW_PCIE_LTSSM_L2_IDLE ||
> +				val <= DW_PCIE_LTSSM_DETECT_WAIT,
> +				PCIE_PME_TO_L2_TIMEOUT_US/10,
> +				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> +	if (ret) {
> +		/* Only dump message when ltssm_stat isn't in DETECT and POLL */
> +		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> +		return ret;
>  	}
>  
> +	/*
> +	 * Refer to r6.0, sec 5.3.3.2.1, software should wait at least
> +	 * 100ns after L2/L3 Ready before turning off refclock and
> +	 * main power. It's harmless too when no endpoint connected.
> +	 */
> +	udelay(1);
> +
>  	dw_pcie_stop_link(pci);
>  	if (pci->pp.ops->deinit)
>  		pci->pp.ops->deinit(&pci->pp);
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

-- 
மணிவண்ணன் சதாசிவம்

