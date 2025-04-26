Return-Path: <linux-pci+bounces-26813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A2A9DC43
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 18:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB37C16D0FA
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02392BD04;
	Sat, 26 Apr 2025 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P1Km1ydp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8E86FC5
	for <linux-pci@vger.kernel.org>; Sat, 26 Apr 2025 16:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745685536; cv=none; b=QZiGtIb9pEqEbdVKFjJiokt3nqsoM/PavucoA2l7mb3rGRJJKxRi9eWkvQJJ+EbB9E2GwZ0dO1emFsPrNUdEe9ZUJg+HZiVKpjx116YYrLZ4WEXxnu8x3itWZaZA7pFF/dFDMqXho2NglaBE+PUR3isnqxLajQfQNhjayHPjk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745685536; c=relaxed/simple;
	bh=8NmQ31JIOCwm9eDKD+EV0AeZzEhaUvdpHkVyhmqMPrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mh6XyAmlgwW2dbv1ZUXVIShKdF59OvVzoD13Yv+azkuB24sW5IhUzBrHmoQSClsj4TqgNSPwqLPd5BTKltybJho9TtW39SU63WBn4w7SrARdsmLPNlg8lABaJremCvKBw6higdHlCx0DTMeuwxiUWf5xX7nt4agzzGY7ycuv1F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P1Km1ydp; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso3204747b3a.2
        for <linux-pci@vger.kernel.org>; Sat, 26 Apr 2025 09:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745685533; x=1746290333; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0wfc1VqSeVbmVhsH2U0jIGnvId3nw503zH5VDDWhWLQ=;
        b=P1Km1ydpdzQHq0BsUk+2kdJ9IiXdY/tO2D1dQO0biPrXOM1JiwiNxEU4tcu3/6GiZj
         R6HrDthJDXulm8gaWpLP10GZ4+xk+t/2bqNkEgqquiotYorbwUFPsvKu+Li71ln9q/vR
         JUt/3FbsHg9lGevfp2Oqd1/RI5ZWisW+pJLwDaGQViP1ZAEVIP354z00FEdJt2eeSib1
         Y1PwlOOs/gE3aZDTnaL26ksNdjoCvZudE/fzrKdHmv5eWl8KgDXT2EPwxxKAQ45SxHIO
         VDXQwF8uSrKoRF+t7cY24QujcmjVE19MeHZ9cKKW8DR4GneCR9zOmQ+n9qXLt/dhwePt
         uWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745685533; x=1746290333;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wfc1VqSeVbmVhsH2U0jIGnvId3nw503zH5VDDWhWLQ=;
        b=aL7rLBibX+Q0ivYREcAf7oNHUnvlybWKFZuyJsj8ZN29bfl0AZDe+yPPXAJN/Eh2W8
         hvva95X3EGoTeSbuYs1ZeWWddzFfqVtNWW7sqH7FnngR/biI1l/u/dhHzn76QuEWJ3/A
         Z+DNngppxAlefiuqLfo1Ml8nD8KgxLOVPbzDOMxMIVxlo83OMjnEa8qcLNLp7bb9X/tg
         OFy3WAkmP+8R4RJ0rG5xRt4vEVneuG2+WVxALjhy1HKcKPZb1V7S/Pu8+MI52PsT1Hfk
         pFgM0LNmXriUhx90lcIb9GV0hJBXanPpYfNUx/qiGS40ugEXWcb2DE7U1UCaVQT/JXb/
         8+4g==
X-Forwarded-Encrypted: i=1; AJvYcCWIaBmD+dXptVuNbm6PzNS7+E1e60znG1Q0TFX8itk9ZJI38bwhfKw9ljYJGnHxxN+Ggqt7XhHT5e0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySBHzyV0sFw9K25TXf91oNKgtu02vNSAeQhLGuiD88PxhkwEqy
	7z+0S19tYLj334+qY4lpeypDj/25N7uZlyzrxKlFqc/JsBWj8dyHUmknjRH+7g==
X-Gm-Gg: ASbGncuQDR7heSc9Sid69c0kMKGRUAyJqx+cX7ETPUqJtNra0v0mQl8UmXgaE4JiWz+
	HwhgPDylrvU8HHsUrveRJa2cEqxKUaz5l+R/eoPzVAp1ewAn0FqpuZG/pQwG3JZY1NU+JoqGHN7
	ncGpex42LbpwDyZD+k2loBToM3MgOBQAtt7J1NG6hYhnAmammx/SMT0vVLRiqr6jTrh7zXn+lK/
	2QcbW9AOMfzGN9xNU8SC0V8uukRgE/4D2Is9Is9n8KlTZrAM19AY6nJlHw1K4Dcud/a7w5LO2ct
	yJzUJcHgm7mk1m1tsx1kxsY9iavolKV59HMw7S1XLY9FMcwqRCbS
X-Google-Smtp-Source: AGHT+IEc27jG/DGwOoH4jKHwCMogOEml1REPJvuYp82y+3VBMRgJF0QNzNBYww14N5kJQs7N1n0m4A==
X-Received: by 2002:a05:6a00:2286:b0:739:4a93:a5db with SMTP id d2e1a72fcca58-73ff7396ad8mr4159447b3a.22.1745685533022;
        Sat, 26 Apr 2025 09:38:53 -0700 (PDT)
Received: from thinkpad ([120.60.143.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a66dsm5170138b3a.102.2025.04.26.09.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 09:38:52 -0700 (PDT)
Date: Sat, 26 Apr 2025 22:08:48 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 3/3] PCI: dw-rockchip: Move
 rockchip_pcie_ep_hide_broken_ats_cap_rk3588() to .init()
Message-ID: <oppgjbuagt44e46esmm4tqdc5moitym3jwaj5psagng55exz7f@4eqwbit5yi6w>
References: <1744850111-236269-1-git-send-email-shawn.lin@rock-chips.com>
 <1744850111-236269-3-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1744850111-236269-3-git-send-email-shawn.lin@rock-chips.com>

On Thu, Apr 17, 2025 at 08:35:11AM +0800, Shawn Lin wrote:
> There is no reason to call rockchip_pcie_ep_hide_broken_ats_cap_rk3588()
> from the pre_init() callback, instead of the normal init() callback.
> 
> Thus, move the rockchip_pcie_ep_hide_broken_ats_cap_rk3588() call from
> the pre_init() callback to the init() callback, as:
> 1) init() will still be called before link training is enabled, so the
>    quirk will still be applied before the host has can see our device.
> 2) This allows us to remove the pre_init() callback, as it is now unused.
> 3) It is a more robust design, as the init() callback is called by
>    dw_pcie_ep_init_registers(), which will always be called after a core
>    reset. The pre_init() callback is only called once, at probe time.
> 
> No functional changes.
> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Changes in v4:
> - rewrite commit message
> 
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index e4519c0..7790a9f 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -278,17 +278,13 @@ static void rockchip_pcie_ep_hide_broken_ats_cap_rk3588(struct dw_pcie_ep *ep)
>  		dev_err(dev, "failed to hide ATS capability\n");
>  }
>  
> -static void rockchip_pcie_ep_pre_init(struct dw_pcie_ep *ep)
> -{
> -	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
> -}
> -
>  static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar;
>  
>  	rockchip_pcie_enable_l0s(pci);
> +	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
>  
>  	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
>  		dw_pcie_ep_reset_bar(pci, bar);
> @@ -359,7 +355,6 @@ rockchip_pcie_get_features(struct dw_pcie_ep *ep)
>  
>  static const struct dw_pcie_ep_ops rockchip_pcie_ep_ops = {
>  	.init = rockchip_pcie_ep_init,
> -	.pre_init = rockchip_pcie_ep_pre_init,
>  	.raise_irq = rockchip_pcie_raise_irq,
>  	.get_features = rockchip_pcie_get_features,
>  };
> -- 
> 2.7.4
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

