Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F08B1C98F5
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 20:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgEGSKx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 14:10:53 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:42285 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgEGSKr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 14:10:47 -0400
Received: by mail-oo1-f66.google.com with SMTP id e18so1547996oot.9;
        Thu, 07 May 2020 11:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hKmS6Bg4CcoosQWiCpcHNn0plXy0Vmb8kMKxS1isGgw=;
        b=sB9QsRKIsc6mIBliJh/cPtUWn3H2/sF9AQq37CefkmlVvK34H0ariRfEPltO6CS4a7
         /wL+gR7U/5UE6c0YlqfKyz0ev/0I4w52GMy1979fPhtaHaEHKaytaVzrfFmI4SOrJuUm
         hM/vmqML2nTYBn8KMbkFPpzktFc7I9Lz+l50+EubdKLBP8RqP3ZOGikd1a0ooqP4AIK7
         /Pu9wLMJGSBNOVDtrpmHEBVulEddBiiRTg6JyH05w05jYAbV9dJTTEr5WW4rDpI3s96P
         Jzc7Gb0AqHIw5D6+ohcwtYcY2sDVmc+up3mUgpd70f8PuFFQ+pMDb1tC5F2QjRzli9yY
         OdGg==
X-Gm-Message-State: AGi0Pub1z5B0U3aU2ZsYF6KZFHVAE+i0qSVI8OeQiwPQU1LZ3SOeAODu
        XjNktwcI0PZFbescDdsnDqDMewE=
X-Google-Smtp-Source: APiQypLxLD7Z5qjpV5iAc4Sn8XItc1HRXVZlZO0OIEuf4nO+dnJ4UizUwjUtv7qPrOmi8Gvmnca0cQ==
X-Received: by 2002:a4a:92d1:: with SMTP id j17mr12892021ooh.13.1588875045762;
        Thu, 07 May 2020 11:10:45 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t9sm1548864oie.24.2020.05.07.11.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 11:10:45 -0700 (PDT)
Received: (nullmailer pid 19680 invoked by uid 1000);
        Thu, 07 May 2020 18:10:44 -0000
Date:   Thu, 7 May 2020 13:10:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/11] devicetree: bindings: pci: document PARF params
 bindings
Message-ID: <20200507181044.GA15159@bogus>
References: <20200430220619.3169-1-ansuelsmth@gmail.com>
 <20200430220619.3169-9-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430220619.3169-9-ansuelsmth@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 01, 2020 at 12:06:15AM +0200, Ansuel Smith wrote:
> It is now supported the editing of Tx De-Emphasis, Tx Swing and
> Rx equalization params on ipq8064. Document this new optional params.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.txt     | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index 6efcef040741..8cc5aea8a1da 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -254,6 +254,42 @@
>  			- "perst-gpios"	PCIe endpoint reset signal line
>  			- "wake-gpios"	PCIe endpoint wake signal line
>  
> +- qcom,tx-deemph-gen1:
> +	Usage: optional (available for ipq/apq8064)
> +	Value type: <u32>
> +	Definition: Gen1 De-emphasis value.
> +		    For ipq806x should be set to 24.

Unless these need to be tuned per board, then the compatible string for 
ipq806x should imply all these settings.

> +
> +- qcom,tx-deemph-gen2-3p5db:
> +	Usage: optional (available for ipq/apq8064)
> +	Value type: <u32>
> +	Definition: Gen2 (3.5db) De-emphasis value.
> +		    For ipq806x should be set to 24.
> +
> +- qcom,tx-deemph-gen2-6db:
> +	Usage: optional (available for ipq/apq8064)
> +	Value type: <u32>
> +	Definition: Gen2 (6db) De-emphasis value.
> +		    For ipq806x should be set to 34.
> +
> +- qcom,tx-swing-full:
> +	Usage: optional (available for ipq/apq8064)
> +	Value type: <u32>
> +	Definition: TX launch amplitude swing_full value.
> +		    For ipq806x should be set to 120.
> +
> +- qcom,tx-swing-low:
> +	Usage: optional (available for ipq/apq8064)
> +	Value type: <u32>
> +	Definition: TX launch amplitude swing_low value.
> +		    For ipq806x should be set to 120.
> +
> +- qcom,rx0-eq:
> +	Usage: optional (available for ipq/apq8064)
> +	Value type: <u32>
> +	Definition: RX0 equalization value.
> +		    For ipq806x should be set to 4.
> +
>  * Example for ipq/apq8064
>  	pcie@1b500000 {
>  		compatible = "qcom,pcie-apq8064", "qcom,pcie-ipq8064", "snps,dw-pcie";
> -- 
> 2.25.1
> 
