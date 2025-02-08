Return-Path: <linux-pci+bounces-21015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72228A2D57C
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 11:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B87216337F
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 10:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB40523C8D4;
	Sat,  8 Feb 2025 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vc2Xt8ep"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5A11AF0A4
	for <linux-pci@vger.kernel.org>; Sat,  8 Feb 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739010477; cv=none; b=J1vz2Wnn41D7LnchOMjwAT9vJ+MSQ/ZQwD77sJBtlKw+PzXUSoW4aRzwvP5RfAjH4V2h+C2bsnhS+OC8tOJTOkRHlF+/zkBoBdqgk0Sl5d19QIeuE4l5ONd4myl92syTxXOeqehTBG19adSZ5e8VNfpsYdrzm3/Alvm7vWaIXTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739010477; c=relaxed/simple;
	bh=L0YGLr2g3TdOaaz1htV2+TIuwVXY1WwkgnLL5Q9hX00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGmGU212Al6nVRmHYiHZ/6mVgj3FlECtrkzkbbMLshjX7CV+KrZnVuuZ6EkEZZ5nYCvV/IJ71cvFnLcsN8CMz4OydDnq8zM6DHDLNy7QPOpw4Ny6Cu+QDL6XWtgI18RnvxmceuTcbmVrDVreArdnjXgRpInQXElRyM0vqODTY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vc2Xt8ep; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21f3c119fe6so62195895ad.0
        for <linux-pci@vger.kernel.org>; Sat, 08 Feb 2025 02:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739010475; x=1739615275; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BH2sRsuQDKCFUwxkFxdc6jRskjBX6B+g7JIWjIU6MHM=;
        b=Vc2Xt8epxRNHYF5f6LZr/7DkVGv9p5TxcRU+olXTcG9L8xrJcjg3Bn3gWPm29XLp1n
         zNKqcb1JGqBBuCLFpuoWLmC/G2RrePnR23cXVec5EPWMZZ/dm0ONDYlSGWoN6XpHLWv3
         zSAoj7lSSFiYAc6Ssnve46E/Ts3mCfCya2Mukye4vCvgWigoC0jnxpoMi/JovBDYWMi2
         T57+QP/ClDRFlvHPXzP9INPIY9eqYWSmTOrT6in1YVS3vnT6FiCV+2tUn5s4XJGgpuWh
         H4T7zEKcu8dP37C1AcP4CBJh6eWBhXttWXFIIbzn+bPQ4jcy65UoMbPUK5LL/vV0l5Fa
         oY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739010475; x=1739615275;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BH2sRsuQDKCFUwxkFxdc6jRskjBX6B+g7JIWjIU6MHM=;
        b=b/ANMMcg6GUDArN/M2dC2LqNqvanRA29xkD5l1TvhGGH+tfYE9QfMj9+Dychzwfdu0
         VRvNCbqM7pOK6F0QIh2Uo0uCKd8+uHvl7piXs+Pww4NGZeF7WZnaXgzMpb2EauyIq+6F
         atnB3O+ZccAoaJ0M3EETYYmLaJe+63jDjBodevF36N5z7MJPy/Agiw0mXtFUYaandobk
         8tqRIwYAuoE40EKe2E8UOKIiXsZUGpnl0fyUFL07TPeZK/xbGvF3vbIXQBhT5T+JcM8d
         N9tuVhQY1cTED5bZq+vhc9TFQBaX7OiDqP4tThXdiE3PQZlczqSIlZB+5CI0NnonI1Mr
         kLGw==
X-Forwarded-Encrypted: i=1; AJvYcCXzWK43xBvgXcNunzmautEfgFmtw2kAXx2kjzTyOIUDyt5WkXEWuOycS5PTlG13a8R5XiB9+mkcqUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxcDBWEk7AYVVQAIYb2kRJFrnziMsKQG+J++bsV88iq6E/32lM
	sAHetVRgr5Ts+X+9rsa0UrvpsYmMirdDtIY38Awxxx4MA5MvZbXkZbV5mYW2gg==
X-Gm-Gg: ASbGncuZM92Ubqq7x/OjOUcZ0fNZz2XbDthX0V8GPT2VDmHFaoedylKJ6SwbUzzlRq5
	6K7bhU5agcnxLbJyJKLu/e2dGnrIOKTLR93Gugv/tVTD0xE1yGw1pztUayp1+b/UONs+Q2pt7cJ
	zUZi9gowOqUh5VFaekj6SaWSnZVe+VwcDCPhMZ+ZBi7g8sEq465UbJhrYZtUz0pgC8YYpruxa78
	7yDcE88gN92rwjmI3Xee64M63plIeF5oxxoi9UqUzbVQA718qN7BTawSqRhIWuY0/jD9hhoKjT0
	O/QxzcMHDoS4A+sYKJq8dech
X-Google-Smtp-Source: AGHT+IGUNe1cmqKWgJdr+fVDu2jVqtRunfHrv/+wQ1RGFBGWqyXmtmbiQqDh/EPUsA/NiaPcsxvF1w==
X-Received: by 2002:a05:6a00:6f1a:b0:730:74f8:25b9 with SMTP id d2e1a72fcca58-73074f8430cmr2616103b3a.17.1739010475341;
        Sat, 08 Feb 2025 02:27:55 -0800 (PST)
Received: from thinkpad ([120.60.69.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c1622esm4450247b3a.141.2025.02.08.02.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 02:27:54 -0800 (PST)
Date: Sat, 8 Feb 2025 15:57:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh@kernel.org>, Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-kernel@lists.infradead.org,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: brcmstb: Adjust message if L23 cannot be entered
Message-ID: <20250208102748.2aytlzgzbvm6u4vi@thinkpad>
References: <20250201121420.32316-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250201121420.32316-1-wahrenst@gmx.net>

On Sat, Feb 01, 2025 at 01:14:20PM +0100, Stefan Wahren wrote:
> The entering of L23 lower-power state is optional, because the
> connected endpoint might doesn't support it. So pcie-brcmstb shouldn't
> print an error if it fails.
> 

Which part of the PCIe spec states that the L23 Ready state is optional?

- Mani

> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index e733a27dc8df..9e7c5349c6c2 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1399,7 +1399,10 @@ static void brcm_pcie_remove_bus(struct pci_bus *bus)
>  	pcie->sr = NULL;
>  }
> 
> -/* L23 is a low-power PCIe link state */
> +/*
> + * Try to enter L23 ( low-power PCIe link state )
> + * This might fail if connected endpoint doesn't support it.
> + */
>  static void brcm_pcie_enter_l23(struct brcm_pcie *pcie)
>  {
>  	void __iomem *base = pcie->base;
> @@ -1422,7 +1425,7 @@ static void brcm_pcie_enter_l23(struct brcm_pcie *pcie)
>  	}
> 
>  	if (!l23)
> -		dev_err(pcie->dev, "failed to enter low-power link state\n");
> +		dev_dbg(pcie->dev, "Unable to enter low-power link state\n");
>  }
> 
>  static int brcm_phy_cntl(struct brcm_pcie *pcie, const int start)
> --
> 2.34.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

