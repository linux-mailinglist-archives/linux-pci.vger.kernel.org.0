Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 158B1199CF3
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 19:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgCaRdx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 13:33:53 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:47072 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgCaRdx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 13:33:53 -0400
Received: by mail-io1-f65.google.com with SMTP id i3so13463177ioo.13;
        Tue, 31 Mar 2020 10:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1kD178IJWLF7OrXvGCPAuwYTFKdbiIs5uu5/dy92+bw=;
        b=KOn0F2+S7x8D2vARZeltg5HDUNyM2vS63C7Yce53FrPEzQq0KWRUq72Wde3GcvrRpe
         cmBYkev12oZb8iyuAOge2bQIw+nQHQXZ2XQjUr5bSlTS+n98e3kZVRDqbChGKpzGY6iD
         xoTl6F2yFPh4wx2yyGn5Mu8C/Hp7pAu2vYBV0xd8K2O8Utk5EFux4sqUvkwLBqRd//JO
         +JN1boPkU1EMkotUg5tOxfYnPyC14MfYx5v7MtFuiP3jPOWNA2Sm/KAwbd99tC2omD31
         0Adaensf6trexpOmQuCpe/19POgDzISvJE42HOyiSs7RSWojPwp0WOyWkM+f3m1poB2X
         xPTA==
X-Gm-Message-State: ANhLgQ1C9mgXAglculW9dIkK96Dksmz2Y6yRwZzylYjLNuOKCdpyEXFV
        XLQRswIvCW6JCbkPNzapNg==
X-Google-Smtp-Source: ADFU+vveQiIwjf4EHvPqSOhmyd+ZXcJTf30ZEWVFUmCOi01Fq+DbZTOdBdosmijz/0SQTw4Ka76TcQ==
X-Received: by 2002:a6b:c9d2:: with SMTP id z201mr16653446iof.169.1585676030822;
        Tue, 31 Mar 2020 10:33:50 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y1sm5127603ioq.47.2020.03.31.10.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:33:50 -0700 (PDT)
Received: (nullmailer pid 29165 invoked by uid 1000);
        Tue, 31 Mar 2020 17:33:48 -0000
Date:   Tue, 31 Mar 2020 11:33:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] devicetree: bindings: pci: add force_gen1 for
 qcom,pcie
Message-ID: <20200331173348.GA28253@bogus>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
 <20200320183455.21311-11-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320183455.21311-11-ansuelsmth@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 20, 2020 at 07:34:53PM +0100, Ansuel Smith wrote:
> Document force_gen1 optional definition to limit pcie
> line to GEN1 speed
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index 8c1d014f37b0..766876465c42 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -260,6 +260,11 @@
>  	Definition: If not defined is 0. In ipq806x is set to 7. In newer
>  				revision (v2.0) the offset is zero.
>  
> +- force_gen1:
> +	Usage: optional
> +	Value type: <u32>
> +	Definition: Set 1 to force the pcie line to GEN1
> +

I believe we have a standard property 'link-speed' for this purpose.

>  * Example for ipq/apq8064
>  	pcie@1b500000 {
>  		compatible = "qcom,pcie-apq8064", "qcom,pcie-ipq8064", "snps,dw-pcie";
> -- 
> 2.25.1
> 
