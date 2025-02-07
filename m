Return-Path: <linux-pci+bounces-20921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE9DA2CA63
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB32F188B9EA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A46A18E050;
	Fri,  7 Feb 2025 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lYT30Y36"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAC12A1D8
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949898; cv=none; b=OS/5V39AGqczO7WKiMOGYfeIWidsmHyl/oghPg29x2sDVT/+9HKJigzhEet0f+7KDKp2HRdCsy2aCO9PtDqmurp16Z5zHlfu4Pm7VLWHFtf9ndlS37WfP6ysM0rhPQVgqkVE0mMatoaCMK9hXsIepVI0yheqIw8atiqMYzOxrHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949898; c=relaxed/simple;
	bh=H1BsOoUkTiYmiadBFauMCjX3WbU3l6Bqs26Ky0ZTa7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTVMEOGMvkmT+wsuYF3/AkBeVTJqyaDmLn38KueRlu9xCEola5mfGQaHwpmN996LOhYYsiH1EjGH0MQKVy/n8DMA/EbbeuCOSx/uMQ7J2A1VQ+bDrY5JbNbDu+Sl/q3WUeNHpDNjmbvcOjBsMHlU5KRZBXVKnS/bVTVY6atIcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lYT30Y36; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f9cd9601b8so4227104a91.3
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 09:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738949896; x=1739554696; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4xyFJhUKmXvISbhvlxrsKbalUZLIqSWCZyj7Xp1Z3rU=;
        b=lYT30Y36iB/BWIqyvsdFVzPcZT47Ei4khRAe+LZoGzfdNAole0/IC2oE9eF/ipKAFo
         deeMal23A6Dg1VCdo2555RxhBKcpvA06ns34F7xi3DDeAdbMrhZObfpA44DDbINp3oVM
         gnPDAaYA9JSKJd/dBwMW9Z0iqmprw1o0kcvsMabE5zN+sF1xzAk+PboR7T/f6s+ZinI/
         X+bQFxt4Cv6+ouOfCCOVSC0w0ZsjmTIkYUaUrYV5RduAKEYjf0/C+O/8IvMEkxfRE0+Y
         4XTXnDTUqPEwKAsm/SDrDGMo2Z2ef7TniORPXnZaHCqyMKYngjfGVzs6PndIcjyBBklA
         oa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738949896; x=1739554696;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4xyFJhUKmXvISbhvlxrsKbalUZLIqSWCZyj7Xp1Z3rU=;
        b=M+1TSSFRnYjiNMmq+tFc2pipCbI2aL/aDczW0KG6NjMEm7abDTuAg71L6JsiEOhS5D
         eIPJuxiWLxwd1o6b+LGwRSFC0KOEI8Lg4Wn0DhLkxmN4SYpIL0S4Lp1TyXyOcGJ5QAYz
         pm3YPEtraH/brMv0ylSwdNq9fPvaI2cS1RGI1waXrVWl2/tSGEr6jzOe5vKndtKMH5zP
         J363GcqvTHnqZFv9zyokwIzqKvjl52a6ESHxnQ1N5cpsjEapSEFdOkxwwkV51txmFMvJ
         XbBnlm2pc4DcLTxqMYGSsLkLpxStJmRT6iKHlxdWYD4+35qgqh651efQuY0WQokjH5kw
         AXjg==
X-Forwarded-Encrypted: i=1; AJvYcCUb7uE9E26XUxkddfonxdtIhcKpWnv70YPh/6LkYX4tSBu1Bfce8OMf7Y/Z0+UlyKfrnRexcjT0/Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIazzu2/WkkJ+yGDRXaIi447+5jXWe/FJK0JXKy30K+CKWgWNc
	1+UyKU2CzpJz2wsEHbWdjMH0o9s8b1NfG/tXnTrSsJQx/dUsPZX/72PmZBG0Tw==
X-Gm-Gg: ASbGnctm6Y5qAMlCQhA6Nz9m5s5plx2+YQFQq0f1LxSsyN6+3QkX/nRAA7hPoIP8T0A
	J9z0+W/NA9rvqoq+k62QUcFzWgNF5QNW9Dr5qC9X35tdMI4XxTgbsnNV4lGB+uNTqhegftME7F2
	tRTKVUU+b7UF9CJsOrXed5RAAtWJp8qrYKP0r1g7hshyBsq4w+YgPl2nngBuaGMQqA1z2M6nLxK
	73WBNuZhQFs9oKFirlporLxyde/iRGsd0aYcF7Vu9nLwA/DI/UogIndNxAdob1TFcZ70GVL9SXG
	w1zmvalr3r98CPbQJZ4Ti1y5MQ==
X-Google-Smtp-Source: AGHT+IFprNv/Fxes+yO0Is4d70/qLRRGy5XcxfptGmrec0u4U5JshNdQEzKB4xo6nsXGXHm3iHyxoQ==
X-Received: by 2002:a17:90b:3903:b0:2fa:229f:d03a with SMTP id 98e67ed59e1d1-2fa243e9e0fmr5424081a91.26.1738949896065;
        Fri, 07 Feb 2025 09:38:16 -0800 (PST)
Received: from thinkpad ([120.60.76.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa0942d30esm3647036a91.0.2025.02.07.09.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:38:15 -0800 (PST)
Date: Fri, 7 Feb 2025 23:08:09 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Remove leftover mac_reset assert
 for Airoha EN7581 SoC.
Message-ID: <20250207173809.wykxrugz3neinpru@thinkpad>
References: <20250201-pcie-en7581-remove-mac_reset-v2-1-a06786cdc683@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250201-pcie-en7581-remove-mac_reset-v2-1-a06786cdc683@kernel.org>

On Sat, Feb 01, 2025 at 12:00:18PM +0100, Lorenzo Bianconi wrote:
> Remove a leftover assert for mac_reset line in mtk_pcie_en7581_power_up().
> This is not harmful since EN7581 does not requires mac_reset and
> mac_reset is not defined in EN7581 device tree.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Changes in v2:
> - fix typo in commit log
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index aa24ac9aaecc749b53cfc4faf6399913d20cdbf2..0f64e76e2111468e6a453889ead7fbc75804faf7 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -940,7 +940,6 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  	 */
>  	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
>  				  pcie->phy_resets);
> -	reset_control_assert(pcie->mac_reset);
>  
>  	/* Wait for the time needed to complete the reset lines assert. */
>  	msleep(PCIE_EN7581_RESET_TIME_MS);
> 
> ---
> base-commit: 647d69605c70368d54fc012fce8a43e8e5955b04
> change-id: 20250201-pcie-en7581-remove-mac_reset-16e7b6e3ef06
> 
> Best regards,
> -- 
> Lorenzo Bianconi <lorenzo@kernel.org>
> 

-- 
மணிவண்ணன் சதாசிவம்

