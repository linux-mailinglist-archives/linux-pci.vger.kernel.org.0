Return-Path: <linux-pci+bounces-28481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E772FAC6036
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 05:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFA73BFF56
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 03:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C141F19A;
	Wed, 28 May 2025 03:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vxwDB50Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538C919DF7A
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 03:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404065; cv=none; b=awpJgSdOgoWXD5qnIaZ7CaUQURxG1vpspHfXpYE3XEOhIvIW2XLfoS4bNxEztYty/YZ3zMSlW+ASvPVNNE2xFUSACamYgWcIazjzFDoN8HTV4R1o7gDO7tIXUXUBXyurp+WxuAY5zdzMco3xjQ0F4is+5VkP09iCXwKQB80iVD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404065; c=relaxed/simple;
	bh=0HTZFtHMrvPYujqgmjuwhl6vU5hlKIj8uruAkgobmM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHq7qEHEyvbjY50JxNasTcEByOKpqKyrYAuKRBynNMpMgj76PqdO1TBK6MqafwC9QRvoXFGisCyycuN5uj03Y2bcpiIyDwxtQY6PWfrM30LnAOg9Q4qEj3jp5xby3u6k1vWlt5FR0SO0d8EBeMGdPLQmGvTfyxI9w8egEHbRNxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vxwDB50Y; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23211e62204so26567345ad.3
        for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 20:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748404062; x=1749008862; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h+9g0jjRqmhF0kN4jpC6BzKtxGKIexmnwr+kN5DjlRU=;
        b=vxwDB50YWJ5P8J4Aqvo9CBsmcbDt07Tn3knKGmQxmGGCNrt+4QYwF9JNIqPCRJ9ChM
         fTKBVqsnUDtuSvWFMkaDVCeM3W4F2Dtlp0EoCM3+0IeHTys+qKkc7D96JhGMzCkIGYw4
         +A1l53odIboduFEjDOZSgRcp/7X43wrgmQrY6q+8Wmp2AQD2+7Vri+TPzietMvOy8/aE
         ek/mYLsiWRQBe5w92B4Nog9oQpYxArnTsB6UKyuGEhkYquvMEtr9ek7K3m7MmRJgmXcY
         RWecShJQr9jrB1dYcZIKC6t3fQ7ENGfJ1HPQZVgb5FjY0bqGjk3X3JZh8K00ANDJh/fM
         yC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404062; x=1749008862;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+9g0jjRqmhF0kN4jpC6BzKtxGKIexmnwr+kN5DjlRU=;
        b=gJKQ0ZZxmUGYjg87ab1PhJGbTpDzvHeY7uK8UOEIjmOwNl0wEttQsbHKGejYI8I74H
         bVqC1V3caSX75b9+kHKV8uHgi42eW+JHufMwOymNcjoz0gH7p6Orq3QgeptQCEjlpCfl
         i2SJKjtdR6EOIS0u5eHVihNannavGZN6qHVoKSXSoetmlCDZmhx8Wl5A5Adl1rM4Vlix
         Ek3EBQa6vKiSfq2T2rlMp3KCoTr38gMSeV3bOREAxiGVCvCHK7X2I/mBeON6ZLD6BpYz
         a5tkFo+Be4NydkwxDJQcNSrHpdtl/TUgUUC6flBWHEYwjIs6WQ8x/328RXjfOd8RqSZT
         bE0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6vgwAbFy6v81ckzdUE11Bf8oy9btP3OQboO4ED0NjBcssirhf0FIUhtSbBfEY/WMgPSAdJqDpbtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf902YcT5xYS/GseDms1c2TOws2RlNOBI7EiTgmb5GjNmfPU3f
	7YQwbuUXO5hG0KFTqIZlu4Gad14cyw2ZcJ9e0pLp/wW1ldURkJ8LKcN2EC2nafkjRw==
X-Gm-Gg: ASbGncvG6c+LGITXBKufkl9WMsm6uZY9qeQ029E793t1buCXQrLoJdGsPt6Tg0bMhC0
	bGyUivGYTdNRy7oBQz8ccb2vJjXuDntPANivlnPFXROpAgaXUsh1y1BY8CCbcAfOydm8NejHdB4
	Un43KNgq3o09g8MkgfD9aVM4UZk2kfUJlCZAb7Ck5jgJb9QbJJdHKmz61a2LvNvvwL4KH9C7gzm
	MU3w8wnINa83TlyzXsVbvqkHOCrzEQ5jED+NFH4RGTUw5JDlpRvM2cSyB59Oz17tYGSF07zRkBR
	voD8+fwRIvXS1ef8D2zcULlyB91m+maes+b/HS7UjUlAs5BVy8B+fveG5M8+HLdjhKUOzelewQ=
	=
X-Google-Smtp-Source: AGHT+IEUi6A5S8uES4iHZMououSHKnzCTcxXGhYKA42ZvuULMyc2nhVY5fjwE6TvUPYSQWctHRzSFQ==
X-Received: by 2002:a17:902:f686:b0:234:a44c:18d with SMTP id d9443c01a7336-234a44c034bmr78425935ad.22.1748404062477;
        Tue, 27 May 2025 20:47:42 -0700 (PDT)
Received: from thinkpad ([120.56.198.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d3590bf8sm2056925ad.129.2025.05.27.20.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:47:42 -0700 (PDT)
Date: Wed, 28 May 2025 09:17:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI/pwrctrl: Add optional slot clock to pwrctrl
 driver for PCI slots
Message-ID: <rvfkojyooqg7unr4i2izx4hmb24ppsx7tn65pbtfmlbrga76iu@dvsg74hlspzu>
References: <20250525160513.83029-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250525160513.83029-1-marek.vasut+renesas@mailbox.org>

On Sun, May 25, 2025 at 06:04:03PM +0200, Marek Vasut wrote:
> Add the ability to enable optional slot clock into the pwrctrl driver.
> This is used to enable slot clock in split-clock topologies, where the
> PCIe host/controller supply and PCIe slot supply are not provided by
> the same clock. The PCIe host/controller clock should be described in
> the controller node as the controller clock, while the slot clock should
> be described in controller bridge/slot subnode.
> 
> Example DT snippet:
> &pcicontroller {
>     clocks = <&clk_dif 0>;             /* PCIe controller clock */
> 
>     pci@0,0 {
>         #address-cells = <3>;
>         #size-cells = <2>;
>         reg = <0x0 0x0 0x0 0x0 0x0>;
>         compatible = "pciclass,0604";
>         device_type = "pci";
>         clocks = <&clk_dif 1>;         /* PCIe slot clock */
>         vpcie3v3-supply = <&reg_3p3v>;
>         ranges;
>     };
> };
> 
> Example clock topology:
>  ____________                    ____________
> |  PCIe host |                  | PCIe slot  |
> |            |                  |            |
> |    PCIe RX<|==================|>PCIe TX    |
> |    PCIe TX<|==================|>PCIe RX    |
> |            |                  |            |
> |   PCIe CLK<|======..  ..======|>PCIe CLK   |
> '------------'      ||  ||      '------------'
>                     ||  ||
>  ____________       ||  ||
> |  9FGV0441  |      ||  ||
> |            |      ||  ||
> |   CLK DIF0<|======''  ||
> |   CLK DIF1<|==========''
> |   CLK DIF2<|
> |   CLK DIF3<|
> '------------'
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-renesas-soc@vger.kernel.org
> ---
>  drivers/pci/pwrctrl/slot.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
> index 18becc144913e..222c14056cfae 100644
> --- a/drivers/pci/pwrctrl/slot.c
> +++ b/drivers/pci/pwrctrl/slot.c
> @@ -4,6 +4,7 @@
>   * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> @@ -30,6 +31,7 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>  {
>  	struct pci_pwrctrl_slot_data *slot;
>  	struct device *dev = &pdev->dev;
> +	struct clk *clk;
>  	int ret;
>  
>  	slot = devm_kzalloc(dev, sizeof(*slot), GFP_KERNEL);
> @@ -50,6 +52,13 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>  		goto err_regulator_free;
>  	}
>  
> +	clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(clk)) {
> +		ret = PTR_ERR(clk);
> +		dev_err_probe(dev, ret, "Failed to enable slot clock\n");
> +		goto err_regulator_disable;
> +	}
> +
>  	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
>  				       slot);
>  	if (ret)
> -- 
> 2.47.2
> 

-- 
மணிவண்ணன் சதாசிவம்

