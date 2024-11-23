Return-Path: <linux-pci+bounces-17232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA3B9D684A
	for <lists+linux-pci@lfdr.de>; Sat, 23 Nov 2024 10:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2997161103
	for <lists+linux-pci@lfdr.de>; Sat, 23 Nov 2024 09:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E0C172BB9;
	Sat, 23 Nov 2024 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5z6K4dz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F8165F01
	for <linux-pci@vger.kernel.org>; Sat, 23 Nov 2024 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732352822; cv=none; b=tIDAYhjLREGEgf6nGelKtbY10w1q+ZTkmC1KX0uW+yK9A1bKOJ5CKpCwjMzm919mQqaeONl1g6ZUQkG1C7BgZKW04oRBPDBZpj+zFPoUwpoiMVd/fDVjl7xD+o/xTamqiSqHgTD/q6Oueqk41jz8zXe92MCYnqHQv2n+Y9DbehU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732352822; c=relaxed/simple;
	bh=zsSAW+XK5JeI5gVARmUmgZjByt9qyUKUI9oqemfJ5zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+Nxy3+c4VE93mvKHlLRjSZ4JSzLVzVbCsnAIxfcssWqO48h5F/XMkihlU4VboRQxQ3F9xdHsX8rNYqttYFj4gwP7yThFlCkUQZA6NRmMmE+kfraeaezlu9oAmBHNEcOpBFWRVvJhCV3PHzTyqErZP/49QT2m9nkYemdZcC3C90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r5z6K4dz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7240d93fffdso2435804b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 23 Nov 2024 01:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732352820; x=1732957620; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yZTqoEwTktGmXK3Qx5NYMXzlUej11tS8qvukucVyF4s=;
        b=r5z6K4dz2ThFAUpZARN7/Cz8+YXfgxfx1yEPU3MFFlzoUNCKZIVodxbKlEjei5RBhX
         WqvVYHirdp8LZGNrGJDOrg5IatX0w9Ru+w15IiiFy9wcZBM8AdSfVZC7mtzU15efPzdx
         Zjbhe+PzZHhrGwa6We190XyzVczZWArvp1U5UEgoCBi9vMPYusiOE9WOhZyykik2D86v
         63CHSMVEIovx/VJeVQRXJt+jxtjKmAW75nbI3Jq8wIUfMc4CmoVxKTh04/FMrhXoyZui
         1jh+x3SsMGghMRv5y/6hvGqSA9XYgGeD9XwDbgdqHH/xTQ/ArVdnZDsAi9insLk3YNYu
         Ei7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732352820; x=1732957620;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZTqoEwTktGmXK3Qx5NYMXzlUej11tS8qvukucVyF4s=;
        b=mmN2+WeOTvymnrzZlYCiiqqxUvMdPpibWCwp53eVatX2HUbj2e8F/i3zSKesMYiAeX
         86Js7IkspM40tzosJKq/CmZHmuZZaNPBmU1TknFJ6mGLy/J1znCe5LH43ps9IAFRU1LA
         kEImQLhUlNWJZAwV72nGLts6p3RT3HXAMKCTd0yNF/9n2KRzO7qt3o9Pt51nX/TBLChQ
         PipqzzifU9OXiwKbOhwrRjplxdzphbdYFtUD5gxQNKtaFXqos3g/2RJ8YWo9s2GeT4zm
         M3HL7zNLBhhidcH6Gjf197wwnnmVA6BPTZ/Xf6wQInbFHsCVPKSsfoTH9XGnTQ+6+kOA
         Etig==
X-Forwarded-Encrypted: i=1; AJvYcCUPGUacUYdLGYtfpGvh2JXlpPXpcLfr7h59TII4Hzu7g+JEVDBli6w23gzR5y3cV6cpRRO3PNFMe6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVZn5LatRKDWpLmRz2iXljR6gnJjx/mNQumMDOPtrRpwUeohbu
	5zIxxNs9IUNgGqMlXcsyGDp66SdGQqCrgIvHszg3oXS+6Pyva99t7/IatiuzOA==
X-Gm-Gg: ASbGncsU5oEcAIWYy1KFMcy+r/+4w0hMy7Fh6mqV1NRtJduohCkrUN4/CykEt0Mv4Ut
	KE6+U/h++6cct1SsiBulpL4bGrK7/221WS2AcJPcvwFDLR9dOfNxHiV6uRpNfRa6UBNKxYnQW9u
	8wUB0MRskHbbVzjNkvdx3b1YjH6pYI+dNm3PGUFGpV3x/7EGvasyD6tkY82yAgrgYdW0LIF5lBT
	CK52qbBWMkRpCTRtXSx9gpalqMY57RyvJ8oe3pSPok95fYF1e71trUSDClglaj5rQ==
X-Google-Smtp-Source: AGHT+IEpLHPVaJh+gwdLw83uetAfenPlalM1R5vdNmWHzoapvFpd0b11woYH7NFKGd9VPGuqxv2wQg==
X-Received: by 2002:a05:6a00:3ccc:b0:71e:64fe:965f with SMTP id d2e1a72fcca58-724df666260mr9268664b3a.20.1732352819705;
        Sat, 23 Nov 2024 01:06:59 -0800 (PST)
Received: from thinkpad ([2409:40f2:101e:13d7:85cf:a1c4:6490:6f75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de55503bsm2966517b3a.142.2024.11.23.01.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 01:06:58 -0800 (PST)
Date: Sat, 23 Nov 2024 14:36:50 +0530
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
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 3/6] PCI: mediatek-gen3: Move reset/assert callbacks
 in .power_up()
Message-ID: <20241123090650.imccksnmovmt2pps@thinkpad>
References: <20241118-pcie-en7581-fixes-v4-0-24bb61703ad7@kernel.org>
 <20241118-pcie-en7581-fixes-v4-3-24bb61703ad7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241118-pcie-en7581-fixes-v4-3-24bb61703ad7@kernel.org>

On Mon, Nov 18, 2024 at 09:04:55AM +0100, Lorenzo Bianconi wrote:
> In order to make the code more readable, the reset_control_bulk_assert()
> for PHY reset lines is moved to make it pair with
> reset_control_bulk_deassert() in mtk_pcie_power_up() and
> mtk_pcie_en7581_power_up(). The same change is done for
> reset_control_assert() used to assert MAC reset line.
> 
> Introduce PCIE_MTK_RESET_TIME_US macro for the time needed to
> complete PCIe reset on MediaTek controller.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 3cfcb45d31508142d28d338ff213f70de9b4e608..2b80edd4462ad4e9f2a5d192db7f99307113eb8a 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -125,6 +125,8 @@
>  
>  #define MAX_NUM_PHY_RESETS		3
>  
> +#define PCIE_MTK_RESET_TIME_US		10
> +
>  /* Time in ms needed to complete PCIe reset on EN7581 SoC */
>  #define PCIE_EN7581_RESET_TIME_MS	100
>  
> @@ -912,6 +914,14 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  	int err;
>  	u32 val;
>  
> +	/*
> +	 * The controller may have been left out of reset by the bootloader
> +	 * so make sure that we get a clean start by asserting resets here.
> +	 */
> +	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> +				  pcie->phy_resets);
> +	reset_control_assert(pcie->mac_reset);
> +
>  	/*
>  	 * Wait for the time needed to complete the bulk assert in
>  	 * mtk_pcie_setup for EN7581 SoC.
> @@ -986,6 +996,15 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
>  	struct device *dev = pcie->dev;
>  	int err;
>  
> +	/*
> +	 * The controller may have been left out of reset by the bootloader
> +	 * so make sure that we get a clean start by asserting resets here.
> +	 */
> +	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> +				  pcie->phy_resets);
> +	reset_control_assert(pcie->mac_reset);
> +	usleep_range(PCIE_MTK_RESET_TIME_US, 2 * PCIE_MTK_RESET_TIME_US);
> +
>  	/* PHY power on and enable pipe clock */
>  	err = reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
>  	if (err) {
> @@ -1070,14 +1089,6 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>  	 * counter since the bulk is shared.
>  	 */
>  	reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
> -	/*
> -	 * The controller may have been left out of reset by the bootloader
> -	 * so make sure that we get a clean start by asserting resets here.
> -	 */
> -	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
> -
> -	reset_control_assert(pcie->mac_reset);
> -	usleep_range(10, 20);
>  
>  	/* Don't touch the hardware registers before power up */
>  	err = pcie->soc->power_up(pcie);
> 
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

