Return-Path: <linux-pci+bounces-15974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F179BB8AA
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 16:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94531F22712
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9501BD504;
	Mon,  4 Nov 2024 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nls8Z+aZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE481C07CF
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733133; cv=none; b=lS9sgiVmcaEOZxLoCLa7cM5Aq23b6X4HeKfJOYf7OectFEc3bvxi2CE9/k3QjboyBxrf/uzO8F482A2uQR6/kKcpiH5tC7Wxm94A4GNoX5eXDs51G8PtjmyY0+1ta9aJROH9uwWkPQbFGhfFaL0wXP903DjhxZV/4228qL0ja0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733133; c=relaxed/simple;
	bh=TjGtaE+LQxifGKsMsXRpdf+jrPSEjvUZi5NAZ2+Y6dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPLaLYhrMP05/9tkW05Lb98CmabxoIJNOSZZCGNlO++HyfzzY8ga7bz5jLQfAUOpTH9YY+M62X1Guq7hLV31cp6EJbB5qY9qc913MQV7jie8EsdxwQKzXL8MpZXjWRK8jYHz9uDyq3nBeNUnY4GodhlUcLH1wdwmLxqNflV2IKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nls8Z+aZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cceb8d8b4so27801865ad.1
        for <linux-pci@vger.kernel.org>; Mon, 04 Nov 2024 07:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730733130; x=1731337930; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IWAz5TdjV0s3G3j5HR50h22mQFRBfFcqS1CejLxUMh4=;
        b=nls8Z+aZHhEyydGpZb4RZyFMNJKyDxHlz8rnIhnVlQf8jzqWHfXJWHRwLwadwZhpDD
         vWq2FY+tOc4uYEBlsCWzXjTYnNcIKgfZaWVp6e7dJWz1z4dUqDFDwtLLS7mmlAZ+hz6y
         /sWgJUzvegpXWDMDigELwdUN5h6ZnsQ9k9FTGU3bDbzA9h5TUx8G98gOsDBw2HDh2hPg
         oDAGxez/je2UJIkIsAr25S3T+9tbtgYzezbsj3zAH9tzj7OFqTQe4f5TuG/OpLo0D5cA
         ii3xmqwldGsEo2Rstc0WUKl5Ihg44nRO1V+HplujtpUaoFqHQ3DaCgCkGJbtNsbzzyFS
         w1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733130; x=1731337930;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IWAz5TdjV0s3G3j5HR50h22mQFRBfFcqS1CejLxUMh4=;
        b=coIyUbAIc1DXVqn/w64mx93TKIaO8EwCebGOyO1d0KgDQJuoBuQzHjYuYb/DGxbs+G
         C2HQ1QMSGvWnyzG+3ELD9tZnU6ICwtcicP+98Iu0xHcAKkBnH81GpcaDwWtLVv4fGWGD
         tAEjKztEguHmWMW8n8C/DqNkNCcgnIvEcHXgl1nR1peuVpzLtx0UpOeYMuuwy/pjQjwk
         IIlDmlwuLl9JUZggBDtTrfuO8L8PMdFJ6TQttXDA8fD0bBDhJ+D4xLlRc285UWDYSAtO
         whdz8pAS1maLpHS5We2XmRg9y8sHeKeroUp8D96478//PcT3hUyWMLR96gW5iDU2H2GO
         k0Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWydrosYtPb1lnGfLaKowJTnUvJwpcL0Cwa3MBb7K05L+cQidg7J5Thgh2Gok2ZzNr3BLwecDENYSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGFPzhTpwquLPrlikjJolAmEpt3gU1zbhZLX0U0wmvhLR3WrB+
	BEk6U2HTx1rTD06QuRx9IY7X0q7YOCwagw2iQFUcu7yDxTzATx1hqUxIQLkO+w==
X-Google-Smtp-Source: AGHT+IF/DA7LNyMgu1pnTQkftl5jvkj6Flffim544TjwWV+oZb0jj3oRtdO+6se3chWJxM92S10XOw==
X-Received: by 2002:a17:902:ccd2:b0:20c:9026:93a with SMTP id d9443c01a7336-2111946831emr213769535ad.19.1730733130510;
        Mon, 04 Nov 2024 07:12:10 -0800 (PST)
Received: from thinkpad ([2409:40f4:3049:1cc7:217b:63a:40ce:2e01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105707e12sm62411805ad.82.2024.11.04.07.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:12:09 -0800 (PST)
Date: Mon, 4 Nov 2024 20:42:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com, Frank.li@nxp.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v4] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <20241104151202.k6v6fxwyb44n7qw6@thinkpad>
References: <20241030103250.83640-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241030103250.83640-1-eichest@gmail.com>

On Wed, Oct 30, 2024 at 11:32:45AM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The suspend/resume functionality is currently broken on the i.MX6QDL
> platform, as documented in the NXP errata (ERR005723):
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf
> 
> This patch addresses the issue by sharing most of the suspend/resume
> sequences used by other i.MX devices, while avoiding modifications to
> critical registers that disrupt the PCIe functionality. It targets the
> same problem as the following downstream commit:
> https://github.com/nxp-imx/linux-imx/commit/4e92355e1f79d225ea842511fcfd42b343b32995
> 
> Unlike the downstream commit, this patch also resets the connected PCIe
> device if possible. Without this reset, certain drivers, such as ath10k
> or iwlwifi, will crash on resume. The device reset is also done by the
> driver on other i.MX platforms, making this patch consistent with
> existing practices.
> 
> Without this patch, suspend/resume will fail on i.MX6QDL devices if a
> PCIe device is connected. Upon resuming, the kernel will hang and
> display an error. Here's an example of the error encountered with the
> ath10k driver:
> ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0, device inaccessible
> Unhandled fault: imprecise external abort (0x1406) at 0x0106f944
> 
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Changes in v4:
> - Improve commit message (Bjorn)
> - Fix style issue on comments (Bjorn)
> - s/msi/MSI (Bjorn)
> 
> Changes in v3:
> - Added a new flag to the driver data to indicate that the suspend/resume
>   is broken on the i.MX6QDL platform. (Frank)
> - Fix comments to be more relevant (Mani)
> - Use imx_pcie_assert_core_reset in suspend (Mani)
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 57 +++++++++++++++++++++------
>  1 file changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 808d1f1054173..c8d5c90aa4d45 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -82,6 +82,11 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
>  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
>  #define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
> +/*
> + * Because of ERR005723 (PCIe does not support L2 power down) we need to
> + * workaround suspend resume on some devices which are affected by this errata.
> + */
> +#define IMX_PCIE_FLAG_BROKEN_SUSPEND		BIT(9)
>  
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>  
> @@ -1237,9 +1242,19 @@ static int imx_pcie_suspend_noirq(struct device *dev)
>  		return 0;
>  
>  	imx_pcie_msi_save_restore(imx_pcie, true);
> -	imx_pcie_pm_turnoff(imx_pcie);
> -	imx_pcie_stop_link(imx_pcie->pci);
> -	imx_pcie_host_exit(pp);
> +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
> +		/*
> +		 * The minimum for a workaround would be to set PERST# and to
> +		 * set the PCIE_TEST_PD flag. However, we can also disable the
> +		 * clock which saves some power.
> +		 */
> +		imx_pcie_assert_core_reset(imx_pcie);
> +		imx_pcie->drvdata->enable_ref_clk(imx_pcie, false);
> +	} else {
> +		imx_pcie_pm_turnoff(imx_pcie);
> +		imx_pcie_stop_link(imx_pcie->pci);
> +		imx_pcie_host_exit(pp);
> +	}
>  
>  	return 0;
>  }
> @@ -1253,14 +1268,32 @@ static int imx_pcie_resume_noirq(struct device *dev)
>  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
>  		return 0;
>  
> -	ret = imx_pcie_host_init(pp);
> -	if (ret)
> -		return ret;
> -	imx_pcie_msi_save_restore(imx_pcie, false);
> -	dw_pcie_setup_rc(pp);
> +	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
> +		ret = imx_pcie->drvdata->enable_ref_clk(imx_pcie, true);
> +		if (ret)
> +			return ret;
> +		ret = imx_pcie_deassert_core_reset(imx_pcie);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * Using PCIE_TEST_PD seems to disable MSI and powers down the
> +		 * root complex. This is why we have to setup the rc again and
> +		 * why we have to restore the MSI register.
> +		 */
> +		ret = dw_pcie_setup_rc(&imx_pcie->pci->pp);
> +		if (ret)
> +			return ret;
> +		imx_pcie_msi_save_restore(imx_pcie, false);
> +	} else {
> +		ret = imx_pcie_host_init(pp);
> +		if (ret)
> +			return ret;
> +		imx_pcie_msi_save_restore(imx_pcie, false);
> +		dw_pcie_setup_rc(pp);
>  
> -	if (imx_pcie->link_is_up)
> -		imx_pcie_start_link(imx_pcie->pci);
> +		if (imx_pcie->link_is_up)
> +			imx_pcie_start_link(imx_pcie->pci);
> +	}
>  
>  	return 0;
>  }
> @@ -1485,7 +1518,9 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX6Q] = {
>  		.variant = IMX6Q,
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
> -			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE,
> +			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
> +			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  		.clk_names = imx6q_clks,
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

