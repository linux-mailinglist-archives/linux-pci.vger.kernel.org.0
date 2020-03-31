Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC643199CE1
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 19:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgCaRaG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 13:30:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40281 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgCaRaG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 13:30:06 -0400
Received: by mail-io1-f68.google.com with SMTP id k9so22637876iov.7;
        Tue, 31 Mar 2020 10:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HKCovC9xLsfIwIFk+fUxWjRBDXP8T45DhGFFED05nmY=;
        b=BFp5rKaagCsENXHjBM8wjpYRAZROEA0q8dROnq66UPi4QbOEoO5X+9QxjphbIDpFPt
         hgwFxPVtCEDJM64nx+CrLdru+t0jNrXlWsjRnGHbF7KDYUkuT0bdtHmz8hOrOeO9E11o
         199dy0YkUlObIuPZfu2Bis4pI148pX4zMzY1kv1J33CDMPrIo1X5C6S6e7kuRCvWo3ZI
         Yjw/7lzzl/rLlJMPWJioGlzSpoHODxMZyZwucYsecqx+0E4P2CgnZtnMyO4/I4aeMz+F
         q68v8E9NsIgT7rKDiAFfBHEWEnwxUxkX8EiV/Pyr5ny1OVR/5DdZA/PFsGqStIfqLcgb
         1oPQ==
X-Gm-Message-State: ANhLgQ2tZrfq1FVb5MEtLP4KhyENrhH+DxqiHORatxNS/Rx+9S8vKjYG
        h43fGrQ9UrWsjSzEaPplDw==
X-Google-Smtp-Source: ADFU+vtSSBHVcGK4a02z+wVet8UBPD1M05x5YCKlQ7E+i4cL038q15XFj5WhDlRy9WkKKSsJUoGzBA==
X-Received: by 2002:a02:cd2d:: with SMTP id h13mr16403354jaq.46.1585675803691;
        Tue, 31 Mar 2020 10:30:03 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id x15sm6124878ilg.29.2020.03.31.10.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:30:02 -0700 (PDT)
Received: (nullmailer pid 23804 invoked by uid 1000);
        Tue, 31 Mar 2020 17:30:01 -0000
Date:   Tue, 31 Mar 2020 11:30:01 -0600
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
Subject: Re: [PATCH 02/12] devicetree: bindings: pci: add missing clks to
 qcom,pcie
Message-ID: <20200331173001.GA16751@bogus>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
 <20200320183455.21311-2-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320183455.21311-2-ansuelsmth@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 20, 2020 at 07:34:44PM +0100, Ansuel Smith wrote:
> Document missing clks used in ipq806x soc
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

What a mess the clocks are for this binding... 

Oh well,

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index 981b4de12807..becdbdc0fffa 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -90,6 +90,8 @@
>  	Definition: Should contain the following entries
>  			- "core"	Clocks the pcie hw block
>  			- "phy"		Clocks the pcie PHY block
> +			- "aux" 	Clocks the pcie AUX block
> +			- "ref" 	Clocks the pcie ref block
>  - clock-names:
>  	Usage: required for apq8084/ipq4019
>  	Value type: <stringlist>
> @@ -277,8 +279,10 @@
>  				<0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>  		clocks = <&gcc PCIE_A_CLK>,
>  			 <&gcc PCIE_H_CLK>,
> -			 <&gcc PCIE_PHY_CLK>;
> -		clock-names = "core", "iface", "phy";
> +			 <&gcc PCIE_PHY_CLK>,
> +			 <&gcc PCIE_AUX_CLK>,
> +			 <&gcc PCIE_ALT_REF_CLK>;
> +		clock-names = "core", "iface", "phy", "aux", "ref";
>  		resets = <&gcc PCIE_ACLK_RESET>,
>  			 <&gcc PCIE_HCLK_RESET>,
>  			 <&gcc PCIE_POR_RESET>,
> -- 
> 2.25.1
> 
