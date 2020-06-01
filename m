Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F84B1EB133
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jun 2020 23:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgFAVnG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jun 2020 17:43:06 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:38459 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbgFAVnF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jun 2020 17:43:05 -0400
Received: by mail-il1-f193.google.com with SMTP id b5so4720446iln.5;
        Mon, 01 Jun 2020 14:43:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h6bmu3CJcmV/9le9YJQNFFMA2nIiHEqBi68n/JP+HZg=;
        b=GIBpUgXLGNQtvFt1EWaoJF3RlvYpSbbvRcJ0vLAJkJ9CWrSptqT1gHLtcB0/6T0k0v
         reao62fnjV0XRf5TCK4DpU+XtH7ep1fKtL0A/DbGVMgeKnlbEWjmEMwjmhzphAWRqmXO
         Oop1FBDbk4TACltLAzmMSOqbUlw3475yR7dQ6bFIEM0q5nu2bRLWgOa60dIT4gG6yjyR
         etKx1r4fmvInn7F/8YXDofYZIWHPzYi66JD50XyHm/a9/sehxaYlrgkue4vOFo900r8T
         S9u9rTBYj6IVRZDdm2eW/HrkyT4ES3PrqDA+0ZEEQ1AOrdpt4fi3LqZVRdtkf2UFBrxW
         zC3g==
X-Gm-Message-State: AOAM533467UdltmP5nTId3MNKEV26T91g75gVlFZScGmlxOmEQz7JJC1
        aw4zBLAsTa4hFB+02hOumw==
X-Google-Smtp-Source: ABdhPJyjdTs1k1AJmK5ghDCtRiwra/ZwCyc7YXPiOjDJbc7itj5xSqUIw+cqQ9LzQTmIn5vJwpBTSQ==
X-Received: by 2002:a05:6e02:e53:: with SMTP id l19mr5346647ilk.96.1591047783964;
        Mon, 01 Jun 2020 14:43:03 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g4sm387323ilj.45.2020.06.01.14.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 14:43:03 -0700 (PDT)
Received: (nullmailer pid 1554558 invoked by uid 1000);
        Mon, 01 Jun 2020 21:43:02 -0000
Date:   Mon, 1 Jun 2020 15:43:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v2 5/5] PCI: uniphier: Add error message when failed to
 get phy
Message-ID: <20200601214302.GA1538223@bogus>
References: <1589536743-6684-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1589536743-6684-6-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589536743-6684-6-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 15, 2020 at 06:59:03PM +0900, Kunihiko Hayashi wrote:
> Even if phy driver doesn't probe, the error message can't be distinguished
> from other errors. This displays error message caused by the phy driver
> explicitly.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pcie-uniphier.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> index 493f105..7ae9688 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -468,8 +468,11 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->rst);
>  
>  	priv->phy = devm_phy_optional_get(dev, "pcie-phy");
> -	if (IS_ERR(priv->phy))
> -		return PTR_ERR(priv->phy);
> +	if (IS_ERR(priv->phy)) {
> +		ret = PTR_ERR(priv->phy);
> +		dev_err(dev, "Failed to get phy (%d)\n", ret);

This will print an error on EPROBE_DEFERRED which isn't an error.

> +		return ret;
> +	}
>  
>  	platform_set_drvdata(pdev, priv);
>  
> -- 
> 2.7.4
> 
