Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD735199CEE
	for <lists+linux-pci@lfdr.de>; Tue, 31 Mar 2020 19:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgCaRco (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Mar 2020 13:32:44 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43855 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgCaRco (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Mar 2020 13:32:44 -0400
Received: by mail-io1-f65.google.com with SMTP id x9so16146683iom.10;
        Tue, 31 Mar 2020 10:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vPjWnezOFCbPjkimVREtFrZweZBkX4AZCv7e/dhIDEA=;
        b=PL/GZ3A7NRpRRUGOKK1Yn5W6EIAPj3Pz60Kwa97uupv+9SYpXVop+aFG7azcNqN0QO
         KyWh8q24KLYC6k1Rvc57HMtVsumr1cQ4AJH1TrEOvioHg3NuN8kassiCdZp1j3WKk+vw
         rUbNoOskrLRXRvxkMeORZSIkuMeSQxbRqJ9gOAvkdMpvLplaz0jop7ejBxfDU3UCZAPZ
         VF0iu8q+JC+B9+DaeYTZ4w6F2PbItpTOnNKs/3JLuNfPE1SBhjnWtbFmOFF6fGCfRX1X
         qSoYIAep2u4sRdN4RYEeAN1XCFcsbinYHWhdHV1IG/GQ+V7ufSMglBjMkvqt6GSxR3fp
         1DYg==
X-Gm-Message-State: ANhLgQ3qtV95f96ExQ8uf5XVrM41fg9IFuA4hfSVTRP5YXcHC+DYMzpU
        2q9M0UFjz3BjJEJbIFfEFBKv7sY=
X-Google-Smtp-Source: ADFU+vst4wZKDtasDsNpPn50nDRlEwtrpiYuD99OqXixa4fa/0G57dQhjqx1+LiKIYGOubIP3Jzvhw==
X-Received: by 2002:a05:6638:120c:: with SMTP id n12mr5374260jas.32.1585675963133;
        Tue, 31 Mar 2020 10:32:43 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id 79sm6191571ila.54.2020.03.31.10.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:32:42 -0700 (PDT)
Received: (nullmailer pid 27604 invoked by uid 1000);
        Tue, 31 Mar 2020 17:32:41 -0000
Date:   Tue, 31 Mar 2020 11:32:41 -0600
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
Subject: Re: [PATCH 08/12] devicetree: bindings: pci: add phy-tx0-term-offset
 to qcom,pcie
Message-ID: <20200331173241.GA25681@bogus>
References: <20200320183455.21311-1-ansuelsmth@gmail.com>
 <20200320183455.21311-8-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320183455.21311-8-ansuelsmth@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 20, 2020 at 07:34:50PM +0100, Ansuel Smith wrote:
> Document phy-tx0-term-offset propriety to qcom pcie driver

propriety?

> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.txt b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> index 6efcef040741..8c1d014f37b0 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.txt
> @@ -254,6 +254,12 @@
>  			- "perst-gpios"	PCIe endpoint reset signal line
>  			- "wake-gpios"	PCIe endpoint wake signal line
>  
> +- phy-tx0-term-offset:

Needs a vendor prefix.

> +	Usage: optional
> +	Value type: <u32>
> +	Definition: If not defined is 0. In ipq806x is set to 7. In newer
> +				revision (v2.0) the offset is zero.
> +
>  * Example for ipq/apq8064
>  	pcie@1b500000 {
>  		compatible = "qcom,pcie-apq8064", "qcom,pcie-ipq8064", "snps,dw-pcie";
> @@ -293,6 +299,7 @@
>  		reset-names = "axi", "ahb", "por", "pci", "phy", "ext";
>  		pinctrl-0 = <&pcie_pins_default>;
>  		pinctrl-names = "default";
> +		phy-tx0-term-offset = <7>;
>  	};
>  
>  * Example for apq8084
> -- 
> 2.25.1
> 
