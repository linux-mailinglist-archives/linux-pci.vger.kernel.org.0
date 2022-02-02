Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84754A76A3
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 18:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiBBRSn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 12:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiBBRSm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 12:18:42 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD164C061714;
        Wed,  2 Feb 2022 09:18:42 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id b13so202093edn.0;
        Wed, 02 Feb 2022 09:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=8ZoifPL9k2IkYJ2rOwXV9s+gL+QWVkXsi/bflJbVNGE=;
        b=SQRDQg86WqLE7eMqHazeyMcVAiXex5mZXzs/r1HLIj+V5WKW49DeSBlgkVs6JKKpBq
         YWHd0pZiIubPBB8LhyraD8Iju3h18yepteIggBM3HsIUgs/rFke0/jC2aiBtcpOP9EfK
         Ty2D/U5BHjRt+K9ICGaMklSzVIYYzZGPNd26GSgZT5TXqipbAAi100inTJaI8rIvKEht
         SOpBb96sXsjWSswsQgR/oVylqKBRuM9jXZgbHAO+qkoYhpuLqXh8glji0yOA+bOT10Fs
         1zGs+1VJCY2d38czyQQXuairAm0IejAVj9Q/THCiaQZRnaizxopnKvXHzaMRf3LvzD6t
         oLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=8ZoifPL9k2IkYJ2rOwXV9s+gL+QWVkXsi/bflJbVNGE=;
        b=eG3FnQXfsmObAi9Rdh35zmVhV3/+AqaEW0SqNpcsWoh1v3eD9/mNBVqYSRdZhIQMSG
         QK1a8lmRT5f1RmMUvSUkdrwv19bToKsxCzmwDOua4XNH99kkMF8WIwW1PqNk+dV+WOhT
         TEdM15VoPp7I9p/hG+z36uPaOuQF8bvmXgAme0XTX/8aBvns+fWIQYduIq65wbdSTtvj
         vxrHIL9xVUAwRp1KnXcqGdgM80y2rDRgYgQ1S0yd4I6ZlWKIm60zVKgfuGxsW9EnM758
         G57oSwlEDEMewgK+ZVJ8o8fJfcEvoRR8U12ugerDe8LCljmP14FEqyCR9Vg1w8NmkGXg
         oJHg==
X-Gm-Message-State: AOAM531NzaARe0Td5Ag10Wx3WMy+etSTpR5Rp/QhThyjtlzdLJwI3An+
        qR08o0kcldaBU4Ih+tSSQbQ=
X-Google-Smtp-Source: ABdhPJwNJqi7u47Ybr76o3uAhYwS9CHNqP4rTCCatremGTisy5+f8yeqzd9Y7ebqP1eCAX7xQNWW0A==
X-Received: by 2002:a05:6402:26c9:: with SMTP id x9mr31137370edd.151.1643822321123;
        Wed, 02 Feb 2022 09:18:41 -0800 (PST)
Received: from ubuntu-laptop (p4fd5939b.dip0.t-ipconnect.de. [79.213.147.155])
        by smtp.googlemail.com with ESMTPSA id x12sm19847774edv.57.2022.02.02.09.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 09:18:40 -0800 (PST)
Message-ID: <2d41d08a9501597fd9c9d2aaa024cfe1f201cf65.camel@gmail.com>
Subject: Re: [PATCH] PCI: kirin: Fix kirin960-pcie probe failure issue
From:   Bean Huo <huobean@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, ffclaire1224@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com
Date:   Wed, 02 Feb 2022 18:18:40 +0100
In-Reply-To: <20220202162659.GA12603@bhelgaas>
References: <20220202162659.GA12603@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2022-02-02 at 10:26 -0600, Bjorn Helgaas wrote:
> [+cc Fan]
> 
> If you're fixing a previous commit, please cc the author of that
> commit.
> 
> I'd prefer the patch below because it avoids the casts of .data and
> the of_device_get_match_data() result, it doesn't silently default to
> PCIE_KIRIN_INTERNAL_PHY if a device without a .data is added, and
> it's 
> the most common design pattern in drivers/pci/.
> 
> What do you think?

Hi Bjorn,

The below change looks good to me. thanks.

Bean
> 
> On Tue, Feb 01, 2022 at 10:59:41PM +0100, Bean Huo wrote:
> > From: Bean Huo <beanhuo@micron.com>
> > 
> > of_device_get_match_data() will return 'enum pcie_kirin_phy_type'
> > type
> > value, and most likely the return value will be
> > PCIE_KIRIN_INTERNAL_PHY == 0.
> > This will cause the PCI probe to fail. And
> > of_device_get_match_data() does not
> > require error checking on its return on devicetree based platform.
> > 
> > So,this patch is to remove unnecessary error checking to fix
> > kirin960-pcie
> > probe failure issue.
> > 
> > Fixes: a622435fbe1a ("PCI: kirin: Prefer
> > of_device_get_match_data()")
> > Signed-off-by: Bean Huo <beanhuo@micron.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-kirin.c | 7 +------
> >  1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-kirin.c
> > b/drivers/pci/controller/dwc/pcie-kirin.c
> > index fa6886d66488..e102aa6efb7f 100644
> > --- a/drivers/pci/controller/dwc/pcie-kirin.c
> > +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> > @@ -781,12 +781,7 @@ static int kirin_pcie_probe(struct
> > platform_device *pdev)
> >  		return -EINVAL;
> >  	}
> >  
> > -	phy_type = (long)of_device_get_match_data(dev);
> > -	if (!phy_type) {
> > -		dev_err(dev, "OF data missing\n");
> > -		return -EINVAL;
> > -	}
> > -
> > +	phy_type = (enum
> > pcie_kirin_phy_type)of_device_get_match_data(dev);
> >  
> >  	kirin_pcie = devm_kzalloc(dev, sizeof(struct kirin_pcie),
> > GFP_KERNEL);
> >  	if (!kirin_pcie)
> 
> commit 3e21687be135 ("PCI: kirin: Add dev struct for
> of_device_get_match_data()")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Wed Feb 2 09:52:41 2022 -0600
> 
>     PCI: kirin: Add dev struct for of_device_get_match_data()
>     
>     a622435fbe1a ("PCI: kirin: Prefer of_device_get_match_data()")
> broke
>     kirin_pcie_probe() because it assumed match data of 0 was a
> failure when in
>     fact, it meant the match data was "(void
> *)PCIE_KIRIN_INTERNAL_PHY".
>     
>     Therefore, probing of "hisilicon,kirin960-pcie" devices failed
> with -EINVAL
>     and an "OF data missing" message.
>     
>     Add a struct kirin_pcie_data to encode the PHY type.  Then the
> result of
>     of_device_get_match_data() should always be a non-NULL pointer to
> a struct
>     kirin_pcie_data that contains the PHY type.
>     
>     Fixes: a622435fbe1a ("PCI: kirin: Prefer
> of_device_get_match_data()")
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c
> b/drivers/pci/controller/dwc/pcie-kirin.c
> index fa6886d66488..0dc4e3395b37 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -756,21 +756,27 @@ static int __exit kirin_pcie_remove(struct
> platform_device *pdev)
>  	return 0;
>  }
>  
> +struct kirin_pcie_data {
> +	enum pcie_kirin_phy_type	phy_type;
> +};
> +
> +static const struct kirin_pcie_data kirin_960_data = {
> +	.phy_type = PCIE_KIRIN_INTERNAL_PHY;
> +};
> +
> +static const struct kirin_pcie_data kirin_970_data = {
> +	.phy_type = PCIE_KIRIN_EXTERNAL_PHY;
> +};
> +
>  static const struct of_device_id kirin_pcie_match[] = {
> -	{
> -		.compatible = "hisilicon,kirin960-pcie",
> -		.data = (void *)PCIE_KIRIN_INTERNAL_PHY
> -	},
> -	{
> -		.compatible = "hisilicon,kirin970-pcie",
> -		.data = (void *)PCIE_KIRIN_EXTERNAL_PHY
> -	},
> +	{ .compatible = "hisilicon,kirin960-pcie", .data =
> &kirin_960_data },
> +	{ .compatible = "hisilicon,kirin970-pcie", .data =
> &kirin_970_data },
>  	{},
>  };
>  
>  static int kirin_pcie_probe(struct platform_device *pdev)
>  {
> -	enum pcie_kirin_phy_type phy_type;
> +	struct kirin_pcie_data *data;
>  	struct device *dev = &pdev->dev;
>  	struct kirin_pcie *kirin_pcie;
>  	struct dw_pcie *pci;
> @@ -781,13 +787,12 @@ static int kirin_pcie_probe(struct
> platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	phy_type = (long)of_device_get_match_data(dev);
> -	if (!phy_type) {
> +	data = of_device_get_match_data(dev);
> +	if (!data) {
>  		dev_err(dev, "OF data missing\n");
>  		return -EINVAL;
>  	}
>  
> -
>  	kirin_pcie = devm_kzalloc(dev, sizeof(struct kirin_pcie),
> GFP_KERNEL);
>  	if (!kirin_pcie)
>  		return -ENOMEM;
> @@ -800,7 +805,7 @@ static int kirin_pcie_probe(struct
> platform_device *pdev)
>  	pci->ops = &kirin_dw_pcie_ops;
>  	pci->pp.ops = &kirin_pcie_host_ops;
>  	kirin_pcie->pci = pci;
> -	kirin_pcie->type = phy_type;
> +	kirin_pcie->type = data->phy_type;
>  
>  	ret = kirin_pcie_get_resource(kirin_pcie, pdev);
>  	if (ret)

