Return-Path: <linux-pci+bounces-28771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89790AC9C1F
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 19:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C5217EB91
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 17:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD85199FD0;
	Sat, 31 May 2025 17:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ayz/B4Bl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AA515442C
	for <linux-pci@vger.kernel.org>; Sat, 31 May 2025 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748713825; cv=none; b=qPDhgbeB6FjOlYR2K9mVRFVFdXxTatQhUjWPuenAUcBFiWvDebssV2PppwAD+grhnKzACm0bZWFRKqL6IkVTL0qSsJNY96vsZcJmb9hDC6bgOKksa6ZzMgxh8xPhbSdb7hCntvH7JHlRW2gUgclbA+aFj+Q4gRRAq9W/F+lrwtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748713825; c=relaxed/simple;
	bh=HCvJG+sgtpgwdiZu6mAcUtxYGNjIK0MPNLZyapgK+HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXEi1GggVs9JAIWUstzdUsqbkr4nNVhVCKz86iEslh/smAenUipw35ttzocGoohgRgaED8p7JVUaYTeswwI8Enf0Ftb9sfsw7EODsAniTHBWUyQkIFWFGBU5svZ32l671kh9xCqRussKJei7exFAPn8uanOeMjfl/geBK/a0FIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ayz/B4Bl; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so2289479b3a.0
        for <linux-pci@vger.kernel.org>; Sat, 31 May 2025 10:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748713822; x=1749318622; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5AbNlKkJboN5wZoU7ozNTe8jKHTn2i9ktrC3fw6ibsc=;
        b=ayz/B4Bl1f0vbCmPrEobj2Hc7pK91Xq9mBPz9GSC7upwbgD2P5zITF9x6JQaTKCAio
         cxUeeI31Xo8zGewuLV6/QBjqnrYEQMK7hcKEGTHxuoI1A/o/vpJHyhBZxFdGjzbDPidh
         dok1NZ2kamfvvsrdHpAUXOqaxwZYilk7pBtPJvmCvmWgTc0fyDzG0SXVfBmWJOAZ8E4B
         bQVi3bdzlsYZGfLp0zYYzHveSSTVauuDnk7YR/wDvzLgwGY0ha6HXFock1nOUslzE1A3
         fGti3slAHQaN3hDUz15IBsldCfLaKYMKbzkRsx8W6QEJfL3PVDaYXW51JhUDgIkU1vYP
         0Low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748713822; x=1749318622;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AbNlKkJboN5wZoU7ozNTe8jKHTn2i9ktrC3fw6ibsc=;
        b=B63cuBrnUEdPGwSG2IFxz6PuVIHJ6K84jMoKu9HZxr4z9G1YvAoEBB9yRPryVybl+4
         Yijw9SXMHUfnZ8qkUo7UyOwqpVvSKZ45229dvyX0G2MechHv6NVS6gaxYGmxqrMDJeXP
         O+9EGLzc/8i9b4GC5ssTcpCTazHsZDVK/C9fggwjSrmu+z/Vizwxr7jJBRi3NTJfbVyF
         d+IpeKS+QP0EuVRLzTFex49jRSmsdUOd3KEqLAFJKpaFPFILebeIpqUUX00Qw7d+BnpS
         iO/1qkplqfXCKesandTRiVn1tytt8dHuxiy6v9t6jNFj2LIwZvWnaa5VQVNDe1F3lnqA
         7CEw==
X-Forwarded-Encrypted: i=1; AJvYcCWAcFKgccn6cibe2xzxfldZ+MeHkJIjpOc+VIz1WrGRC0gDEnA2knDh/mTmY4fzA/z7+yr3DFHDE0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwlfUnic8bDziTfYvw57iB9P20lFHAW4t1yjD0BGyGgmmiJY0s
	TRuTKRkVgQnGPXxXuKVvTsuVcBYoeLDmv3vUv2H+loadeGMxm62wafXRsQ3rI9vVKg==
X-Gm-Gg: ASbGnctpyoPRVxZivOG2qCNEbvQy4P/VO2JHYUzgPvSZdAgBO+C8u+r8U75auWDAQZ/
	SgOx29NORdSse2a0PI3FeM0TWXIKy9wz2ssaxRC+qIIdmVzzepWNRbGK+avhozfEabynpTkDrfO
	gro0J4V42cGJnuVMDS6oTDqLhGqR/5k047Tpi1hNyWeF7qrC0hSPXRMzMC8IeSoLAfzj0FcGCBC
	81XixDGRuJPWuQ7qldhqipxlHUavSsL3soiH6QBMEc7cLQ0hp6kyv03lE6FxToVwM7tR1tdwDPq
	+1MKeZqwjfSPLHgSdNyOMoSU+RVN7TNGolCydHf2I6VNpxyOTYgMSom7Vw7hyg==
X-Google-Smtp-Source: AGHT+IEdPK+JHZ+t44u8hV+Tuwo0Dn5k2WtHvYf+YRYNtFb+Y0T4pf/Gas2+IG+qUK9yX+xyBHPdxg==
X-Received: by 2002:a05:6a20:1583:b0:218:76dd:a66 with SMTP id adf61e73a8af0-21ad95636d1mr11124498637.13.1748713822539;
        Sat, 31 May 2025 10:50:22 -0700 (PDT)
Received: from thinkpad ([120.56.204.95])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2ecebb4834sm2748724a12.74.2025.05.31.10.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 10:50:20 -0700 (PDT)
Date: Sat, 31 May 2025 23:20:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: jingoohan1@gmail.com, frank.li@nxp.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] PCI: dwc: Add quirk to fix hang issue when send
 out PME_Turn_Off Msg TLP
Message-ID: <xq6ojgyh5tpm4zbpymb2wvtf4at3xq7bai3ztuublgh63e7qdn@vfxan6mew3os>
References: <20250408065221.1941928-1-hongxing.zhu@nxp.com>
 <20250408065221.1941928-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250408065221.1941928-3-hongxing.zhu@nxp.com>

On Tue, Apr 08, 2025 at 02:52:19PM +0800, Richard Zhu wrote:
> When no endpoint is connected on i.MX7D PCIe, chip would be freeze when do
> the dummy write in dw_pcie_pme_turn_off() to issue a PME_Turn_Off Msg TLP.
> 
> Add one quirk to issue the PME_Turn_Off only when link is up to avoid
> this problem on the PME_Turn_Off handshake broken platform, for example
> the i.MX7D.
> 

Why do we need to send PME_Turn_Off if there is no endpoint connected? We should
skip PME_Turn_Off and L2/L3 Ready transitions in that case.

- Mani

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c    | 16 +++++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h     |  1 +
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 0817df5b8a59..a62bf7e0ade8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -956,12 +956,18 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
>  		return 0;
>  
> -	if (pci->pp.ops->pme_turn_off) {
> -		pci->pp.ops->pme_turn_off(&pci->pp);
> +	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_WAIT &&
> +	    dwc_check_quirk(pci, QUIRK_NOLINK_NOPME)) {
> +		/* Don't send the PME_TURN_OFF when link is down. */
> +		;
>  	} else {
> -		ret = dw_pcie_pme_turn_off(pci);
> -		if (ret)
> -			return ret;
> +		if (pci->pp.ops->pme_turn_off) {
> +			pci->pp.ops->pme_turn_off(&pci->pp);
> +		} else {
> +			ret = dw_pcie_pme_turn_off(pci);
> +			if (ret)
> +				return ret;
> +		}
>  	}
>  
>  	if (!dwc_check_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 05fe654d7761..d752af660e95 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -283,6 +283,7 @@
>  #define DMA_LLP_MEM_SIZE		PAGE_SIZE
>  
>  #define QUIRK_NOL2POLL_IN_PM		BIT(0)
> +#define QUIRK_NOLINK_NOPME		BIT(1)
>  #define dwc_check_quirk(pci, val)	(pci->quirk_flag & val)
>  
>  struct dw_pcie;
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

