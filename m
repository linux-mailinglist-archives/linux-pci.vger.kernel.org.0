Return-Path: <linux-pci+bounces-8624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB11904A1F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 06:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC8BB21A8C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 04:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9104D22092;
	Wed, 12 Jun 2024 04:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ap3df75/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7529179B7
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 04:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718167257; cv=none; b=RCss6wRrbhZTApksq/QT2Rfv3yCyJu/9sV4TVo9caNC5FNZXjclrf7jg0MUndG27wWQUy4BkWNKGRLodYGScO2F31INIbd2YhR7NOkOEaReUy5wm28+lqSxd4rp1mklr8i3K9208gH8oBri2sXpukbxwT329NzXeg+gZ0F7/0ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718167257; c=relaxed/simple;
	bh=1gLwKb9OxHOVAk7+EmjyO/V2qkvJVd8cvMeHIOPMXRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOka7lbOtBNXAV1qj5PKMcStt8M4T9PK/PwSIU5bcd/n/ECC1i1UzQhTOvAdrLXk3vbUjDno1rxmdKgwJherDYnYJKaZxp/eQw9SNoyj4JyOg8R4c+F1RycT9Q07rP05V17FKAEvfRVA6Gx1vXs/MidwS7Rz010q1RL4kRjxbIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ap3df75/; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6e57506bb2dso1451474a12.0
        for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2024 21:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718167255; x=1718772055; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AGgkSoW1xRk7TfsRGt2QaxlKvCEt9TPGalxUOEqx2iw=;
        b=ap3df75/wCXHU8qY0th7cbYD8vX89MLozR6Jnx63zmSY4pBM2FmlqKDnJTzBtyGTZr
         LC4geehH3tM8YbltezthqKLxZJTEuot/ZnrsjBiFoC/hgpivtPNJOIHW2+bB7QewMI8W
         qRTQw4dvEM5NdiRStba1wiNO7Pz9CrA5VhvrXPzerWqFMReXKPDuUGqkrlRNx7RZxuog
         TYvOMvN5jmnqvd2BSY4mWJZKanlpfveXskXpJ0GpUk0mMHo+mMaQfy1w5F28NhAJV+v8
         qrvtFslvuqZFUobC6ENOdfv29V+AWmfpFdEYgAGErDjeiZEoProFKA90MQwyf+s36NkA
         BwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718167255; x=1718772055;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AGgkSoW1xRk7TfsRGt2QaxlKvCEt9TPGalxUOEqx2iw=;
        b=PTsV78YEQlFTHH3FWrmEGAvXXg5nDCt4anJApmkZRdQ79uPEH9seI+jimyUa6FHOsu
         ftuf+HwfBoR9Uu1SoBypLitWONAS7pjB8XmFWkfLGTt82RReaXsr7MEGIVm1Pj6BN/Nw
         gAlqH6s5GZc0eIXdg+maONaAaed7lliDIm7r1ihaqLI4YtS2x+JCZ18AUwm0UrktVvZf
         JBHMoXA6syz69Gy0J9eZDXpHZifXn5WF0ynn2JX6GlYfKNGlWp8sONRhWNLUMeZ65bEu
         5q00deiv7WLiyhJgTG9dn7Aakzg+uxIY/SGRLM+yj9HOOAHcvuiueMVu9cwGXAHNu1BS
         lkDw==
X-Forwarded-Encrypted: i=1; AJvYcCUrgbtz+HrPpvoRbwOhpiM6GwSGQHhpKouw7uqmIc4PA/cHG/cDVnsPn015T9HdWzncZU7O2vTtbZ/aO9r51VnLSXOWk2y8qU/y
X-Gm-Message-State: AOJu0Yxzlur2mdgStoAI1W4fruE7H3cvPwOqmhc1sKKJyyu/nO+Ke2fr
	+g4K+PMVH+JmqXwFiboqQFc5PX978BCnq3OQJUzmgqwO2XEaoh7KlOUL5rlzUQ==
X-Google-Smtp-Source: AGHT+IHjmwXkPl2CoS61MVk4s0QUMvhfjSBZVGN5YFxLjxkMoDt0N5w7V28ODjcUkdbko4OD0lbEsQ==
X-Received: by 2002:a05:6a20:8417:b0:1b5:d143:72e7 with SMTP id adf61e73a8af0-1b8a9b8c091mr959952637.32.1718167254831;
        Tue, 11 Jun 2024 21:40:54 -0700 (PDT)
Received: from thinkpad ([120.60.129.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a9c2fa34sm481444a91.38.2024.06.11.21.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 21:40:54 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:10:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: kirin: fix memory leak in kirin_pcie_parse_port()
Message-ID: <20240612044047.GD2645@thinkpad>
References: <20240609-pcie-kirin-memleak-v1-1-62b45b879576@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240609-pcie-kirin-memleak-v1-1-62b45b879576@gmail.com>

On Sun, Jun 09, 2024 at 12:56:14PM +0200, Javier Carrasco wrote:
> The conversion of this file to use the agnostic GPIO API has introduced
> a new early return where the refcounts of two device nodes (parent and
> child) are not decremented.
> 
> Given that the device nodes are not required outside the loops where
> they are used, and to avoid potential bugs every time a new error path
> is introduced to the loop, the _scoped() versions of the macros have
> been applied. The bug was introduced recently, and the fix is not
> relevant for old stable kernels that might not support the scoped()
> variant.
> 
> Fixes: 1d38f9d89f85 ("PCI: kirin: Convert to use agnostic GPIO API")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
> This bug was found while analyzing the code and I don't have hardware to
> validate it beyond compilation and static analysis. Any test with real
> hardware to make sure there are no regressions is always welcome.
> 
> The dev_err() messages have not been converted into dev_err_probe() to
> keep the current format, but I am open to convert them if preferred.

Sure, please do it in a separate patch.

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index d1f54f188e71..0a29136491b8 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -403,11 +403,10 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  				 struct device_node *node)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *parent, *child;
>  	int ret, slot, i;
>  
> -	for_each_available_child_of_node(node, parent) {
> -		for_each_available_child_of_node(parent, child) {
> +	for_each_available_child_of_node_scoped(node, parent) {
> +		for_each_available_child_of_node_scoped(parent, child) {
>  			i = pcie->num_slots;
>  
>  			pcie->id_reset_gpio[i] = devm_fwnode_gpiod_get_index(dev,
> @@ -424,14 +423,13 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  			pcie->num_slots++;
>  			if (pcie->num_slots > MAX_PCI_SLOTS) {
>  				dev_err(dev, "Too many PCI slots!\n");
> -				ret = -EINVAL;
> -				goto put_node;
> +				return -EINVAL;
>  			}
>  
>  			ret = of_pci_get_devfn(child);
>  			if (ret < 0) {
>  				dev_err(dev, "failed to parse devfn: %d\n", ret);
> -				goto put_node;
> +				return ret;
>  			}
>  
>  			slot = PCI_SLOT(ret);
> @@ -439,10 +437,8 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  			pcie->reset_names[i] = devm_kasprintf(dev, GFP_KERNEL,
>  							      "pcie_perst_%d",
>  							      slot);
> -			if (!pcie->reset_names[i]) {
> -				ret = -ENOMEM;
> -				goto put_node;
> -			}
> +			if (!pcie->reset_names[i])
> +				return -ENOMEM;
>  
>  			gpiod_set_consumer_name(pcie->id_reset_gpio[i],
>  						pcie->reset_names[i]);
> @@ -450,11 +446,6 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  	}
>  
>  	return 0;
> -
> -put_node:
> -	of_node_put(child);
> -	of_node_put(parent);
> -	return ret;
>  }
>  
>  static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
> 
> ---
> base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
> change-id: 20240609-pcie-kirin-memleak-18c83a31d111
> 
> Best regards,
> -- 
> Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 

-- 
மணிவண்ணன் சதாசிவம்

