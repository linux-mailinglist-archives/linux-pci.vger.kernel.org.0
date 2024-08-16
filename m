Return-Path: <linux-pci+bounces-11744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D3895427C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 09:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED9A1C2416F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 07:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D546C12C474;
	Fri, 16 Aug 2024 07:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jhEhrDR1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4464B127B56
	for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 07:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723792481; cv=none; b=g2uqFEAeUn5US/qlFubxGu1H2XFnuJuZj/U4ibf13U6icHD363vBab2dkvNqun0xuhNzr7PgNkJ+l9EK8aPnB+8sZfyjfTu1IItfjfJ9nlMc0dQuYgcDhQdh8EKf9SG/bdwczHfDZ/wc2GUggSgPsvblTdRnKWp0Y0G3bzen5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723792481; c=relaxed/simple;
	bh=Tye5lc15FhyuFHWJS52ywhOiKNMq2cc7/bt+U8IvG+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcP28n5GKHwWaljh3pV/Uw5RCQtzwXNrGOaK/+YJxk5YDlLKl2gBLq70U8a8kUvmY/yNS3UAGms5yb8An9xwPp+GIHsdAQfQ0SFjeeUg1p4rHe1Pwigk9/1atKaLpZJmOiFNhQ99rcebp5bDRly7VfOkXnyyK97JGSx3aneOFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jhEhrDR1; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d1d6369acso1816305b3a.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 00:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723792479; x=1724397279; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1go7sx0ECg3Nrbun5bUntSM8dbrApaP82pTFnxOeNLY=;
        b=jhEhrDR1Yo1HaB0zifEI+fZaGoTfwkphLH07ieo+VmtnTXBw/jULms0N2n7YAK4JOx
         +RxiZCEX5osZRViU2A4MPHRVn/hgzQ6c8XO0YAb7zUlyjfSdSl2ZrP5GEixy6lhekpdJ
         vZfoMdgVngkEavGSazWrv/YAPF0Ybt315smv+W8xeWJtNnK70r6VJu6kynjNN6EUG0dp
         BlNMcLjoZZCUhRuTunyPqs7TZvmc8/IZAm7Mxv8lPPOE99Up3xqYbP+3lTc4U8eQTpwd
         RUXniizs8ZCi1IvYJWJryH+h+WspAaqtsEjQSrB/1ss6/Qog5JDYPI4jitm3J7xC8hgt
         n7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723792479; x=1724397279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1go7sx0ECg3Nrbun5bUntSM8dbrApaP82pTFnxOeNLY=;
        b=C9A7iIfNxQfMU3QFCwfmgKryL0N6SAqqTbqF5N71jtu16DPsjOTuDbSzwEfCaXyahO
         XnzTmJl4tYenl2nn7djGCdBwWUW2/3+21BgAPugbjjLZFqxBYtTFo5nOcyV0PB+jXfRT
         9N+08a/ETX0JoOTAXo3MXb6CcbOzez/s4OLxLPjKUHVVl3LuGbEp2qST12y8u9/NCyoI
         Ll+0bPXY9AG79gBC4wplch2Uic4+2V7eiVV9vATAM1Gcu+pIOP9wUqFuBB5TKxxVJpkz
         ihFtIjqCPpkvV1KJYx5dcOA3y/MGdTUw0xuROTIbZ8CM0nwUpw+YDJ4REuNQMFfCYxm+
         dk5g==
X-Gm-Message-State: AOJu0YyyDv37IDniN/4we7DgxpHjVkM0UynSkm3VrdMtyBSuo7fRmqhS
	CXtSZhkej6hU6eq+005DSub5cZAwPEb6Uy9GI9YSeigVG0U8yLIGqiK0k0TjKQ==
X-Google-Smtp-Source: AGHT+IEs7skbPukuQ+QD2T4e30incfTrK+bKIykg7J49EQF5T/hlK5KpRQ9P3b2QajFbL/ijk8kb7g==
X-Received: by 2002:a05:6a00:6803:b0:706:938a:5d49 with SMTP id d2e1a72fcca58-71277094499mr6925763b3a.14.1723792479465;
        Fri, 16 Aug 2024 00:14:39 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae07e41sm2054202b3a.65.2024.08.16.00.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 00:14:39 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:44:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 11/13] PCI: brcmstb: Check return value of all
 reset_control_xxx calls
Message-ID: <20240816071433.GM2331@thinkpad>
References: <20240815225731.40276-1-james.quinlan@broadcom.com>
 <20240815225731.40276-12-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815225731.40276-12-james.quinlan@broadcom.com>

On Thu, Aug 15, 2024 at 06:57:24PM -0400, Jim Quinlan wrote:
> Always check the return value for invocations of reset_control_xxx() and
> propagate the error to the next level.  Although the current functions
> in reset-brcmstb.c cannot fail, this may someday change.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

But one comment below.

> Reviewed-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 102 ++++++++++++++++++--------
>  1 file changed, 73 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c5d3a5e9e0fc..d19eeeed623b 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c

[...]

>  static int pci_dev_may_wakeup(struct pci_dev *dev, void *data)
> @@ -1479,9 +1515,12 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct brcm_pcie *pcie = dev_get_drvdata(dev);
>  	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> -	int ret;
> +	int ret, rret;
> +
> +	ret = brcm_pcie_turn_off(pcie);
> +	if (ret)
> +		return ret;
>  
> -	brcm_pcie_turn_off(pcie);
>  	/*
>  	 * If brcm_phy_stop() returns an error, just dev_err(). If we
>  	 * return the error it will cause the suspend to fail and this is a
> @@ -1510,7 +1549,10 @@ static int brcm_pcie_suspend_noirq(struct device *dev)
>  						     pcie->sr->supplies);
>  			if (ret) {
>  				dev_err(dev, "Could not turn off regulators\n");
> -				reset_control_reset(pcie->rescal);
> +				rret = reset_control_reset(pcie->rescal);
> +				if (rret)
> +					dev_err(dev, "failed to reset 'rascal' controller ret=%d\n",

Do you really mean to say 'rascal'? ;)

- Mani

-- 
மணிவண்ணன் சதாசிவம்

