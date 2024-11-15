Return-Path: <linux-pci+bounces-16842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC7A9CDAEF
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6505A282CCD
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D0718C03E;
	Fri, 15 Nov 2024 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zE9WKfYd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA4E18E351
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660740; cv=none; b=jk+vu3F+JOxBaxX5qWUQoEj5gJ4GlFcFDFdRh9dS6BOR9AGSJHKJnlOuCMyOjVVDyeUy5vRcobzh63+Y7fZVirmDa/8TXFq8mRqmUt/bMLLJbxwfLv5usMuOIS1REYi6ZSTev4qOO9DPw9h6FPVXFIc5fnktPnxa+OTPmUccVGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660740; c=relaxed/simple;
	bh=jUi5A9hFS2voYtG3izFiwvB700vd8289DJU9iQKwF0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsxMWyia0i4+5EgZBLI5ljoMvhR0RITuK5GNsV+lQ8ALMucsFAsElh7IyV4xayHjGR5Ozagngi8v+WfgFel5LXeC1hTpBvjqaIhojDmzH57YrTWvB9pNHBu6r/urBJXv41uPVfg8X7+6I181Gg6fs+jiMbkqE6Tj5fuQOY5VQrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zE9WKfYd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20caccadbeeso5045645ad.2
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 00:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731660738; x=1732265538; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ib8VZEqrv/1oaZ9/wInvIKIw+crJoKvU0ii4qjb2l6A=;
        b=zE9WKfYdW1nULzleel519Lub38iToq7xa3BUh39NYSi+sinCGqbnZlMyIWZ0aXBDmD
         TD7O3XvkHkE3T1m1cUF29zp/oFvLU7Wq1ZYBka225YKDjiLnzvcgcr6KOThA1WVetVR5
         t6bR/+yej+Fi5Ixq1Aup9g+rDMI2JVLOkY6KAhXmgpEMIrfq95n263s9yo2CpDcQ8KTz
         ae2rGZAxodYxUiimQvsj02Lc956QtI9KE7bJgKfl/NHeTpcOv4+9PQsfFRiCHIp9e4U0
         tpXiVjNCD2/QvcL6RxHO+G2kqS88NB4WNipRDyxP4UNofzgzaNrVsynqkvamxjCrkZd2
         Oulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731660738; x=1732265538;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib8VZEqrv/1oaZ9/wInvIKIw+crJoKvU0ii4qjb2l6A=;
        b=Qxs3ce12LVNuI0sUqEkVgTBbhhb5ANSgckeGEMIYuXotnpXHbc/VmBgRMBORnjSdYJ
         uhaZr/abu8Iw2xdACIW6Grj9Sjivvj/XgK6bscD7Sz6BIT784/lI9EaTQKnCpVSP10IS
         WoRvqo+16FP02SH0TqoBuVMhbLaQVYGS4rgXz/BA5bfAQrDlBE5qdw592X69QtMygwtf
         xRfodqe/u8yiT7nLgNKgDXOb5mqbWQFotj8bG4JvpE79f2Qn6tNZb4au7tNh4VF7vz5V
         bDWYImVznQ5XGv4MNx69jvyh3EGb3x07IHjMiflhrcOPwRkCwkRC11SYdhekou0qHTnd
         RJXA==
X-Forwarded-Encrypted: i=1; AJvYcCXUNlwAnHeUmPPnA5B6Z9kymc8p37ysR6voKgbEWrildkT99o58ZRPDtdKzHor0GmBdGNaoKd3KJUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzvODLLFCsUkWQ28v8yGl+F+gDDHKnHvnWomIBdCPaYg+U0sLp
	A3XCt6qbJXtk8DJ8hSNDOITBo/J/YXVDiVqOZHy1LZjiHUKenRaOycvb3O84zQ==
X-Google-Smtp-Source: AGHT+IHdGj34kZwTu+86oRWdYE8Hh+iSzm8/CcDrLHSTWam/KJWm+8OMU1/DV2v8HzbHvL2Xyw2aBA==
X-Received: by 2002:a17:902:cf10:b0:20c:ea0a:9665 with SMTP id d9443c01a7336-211d0d83a21mr33312155ad.32.1731660738461;
        Fri, 15 Nov 2024 00:52:18 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc51a1sm8044215ad.57.2024.11.15.00.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 00:52:17 -0800 (PST)
Date: Fri, 15 Nov 2024 14:22:09 +0530
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
Subject: Re: [PATCH v2 1/4] PCI: mediatek-gen3: Add missing
 reset_control_deassert() for mac_rst in mtk_pcie_en7581_power_up()
Message-ID: <20241115085209.v3tyiybaaeoeu6t4@thinkpad>
References: <20241109-pcie-en7581-fixes-v2-0-0ea3a4af994f@kernel.org>
 <20241109-pcie-en7581-fixes-v2-1-0ea3a4af994f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241109-pcie-en7581-fixes-v2-1-0ea3a4af994f@kernel.org>

On Sat, Nov 09, 2024 at 10:28:37AM +0100, Lorenzo Bianconi wrote:
> Even if this is not a real issue since Airoha EN7581 SoC does not require
> the mac reset line, add missing reset_control_deassert() for mac reset
> line in mtk_pcie_en7581_power_up() callback.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 66ce4b5d309bb6d64618c70ac5e0a529e0910511..0fac0b9fd785e463d26d29d695b923db41eef9cc 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -897,6 +897,9 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  	 */
>  	mdelay(PCIE_EN7581_RESET_TIME_MS);
>  
> +	/* MAC power on and enable transaction layer clocks */
> +	reset_control_deassert(pcie->mac_reset);
> +
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  
> @@ -931,6 +934,7 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  err_clk_prepare:
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
> +	reset_control_assert(pcie->mac_reset);
>  	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
>  err_phy_deassert:
>  	phy_power_off(pcie->phy);
> 
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

