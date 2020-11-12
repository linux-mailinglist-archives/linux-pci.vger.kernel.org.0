Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B161C2B092A
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 16:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgKLP6c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 10:58:32 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53998 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728883AbgKLP6b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 10:58:31 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACFwP2p010590;
        Thu, 12 Nov 2020 09:58:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605196705;
        bh=5EME1Y5wxtn8yJOfd69sUQV7FxdOrY9kzzIdVjXXO1M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=In6V1hrwcRwcNLW/ydQ6LG1p7Cqb58kedqGtYRW7eGhLK+1r2x2fu72dvXyZNVUrb
         HZVDe8B+d3iuOYQz8UN8BTdgnXmVugk4BwA5OcoXoCiiPQBjUeg7DixnCglgs+Odzg
         ja4GTOdrpA13ammWra26o+mzedyH9sAzVszVZdq8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACFwP1i072911
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 09:58:25 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 09:58:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 09:58:25 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACFwLbH004118;
        Thu, 12 Nov 2020 09:58:22 -0600
Subject: Re: [PATCH v2 6/7] arm64: dts: ti: k3-j7200-common-proc-board: Enable
 SERDES0
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>, Lee Jones <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201109170409.4498-1-kishon@ti.com>
 <20201109170409.4498-7-kishon@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <e7b2b4e7-fb5e-8504-a1b1-70dc10771264@ti.com>
Date:   Thu, 12 Nov 2020 21:28:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201109170409.4498-7-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/9/20 10:34 PM, Kishon Vijay Abraham I wrote:
> Add sub-nodes to SERDES0 DT node to represent SERDES0 is connected
> to PCIe and QSGMII (multi-link SERDES).
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../dts/ti/k3-j7200-common-proc-board.dts     | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index ef03e7636b66..65a2e5aeb050 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -8,6 +8,7 @@
>  #include "k3-j7200-som-p0.dtsi"
>  #include <dt-bindings/net/ti-dp83867.h>
>  #include <dt-bindings/mux/ti-serdes.h>
> +#include <dt-bindings/phy/phy.h>
>  
>  / {
>  	chosen {
> @@ -213,3 +214,25 @@
>  	dr_mode = "otg";
>  	maximum-speed = "high-speed";
>  };
> +
> +&serdes_refclk {
> +	clock-frequency = <100000000>;
> +};

Since this is a reference clk from the board, should the entire node be
here instead of in k3-j7200-main.dtsi?

> +
> +&serdes0 {
> +	serdes0_pcie_link: phy@0 {
> +		reg = <0>;
> +		cdns,num-lanes = <2>;
> +		#phy-cells = <0>;
> +		cdns,phy-type = <PHY_TYPE_PCIE>;
> +		resets = <&serdes_wiz0 1>, <&serdes_wiz0 2>;
> +	};
> +
> +	serdes0_qsgmii_link: phy@1 {
> +		reg = <2>;
> +		cdns,num-lanes = <1>;
> +		#phy-cells = <0>;
> +		cdns,phy-type = <PHY_TYPE_QSGMII>;
> +		resets = <&serdes_wiz0 3>;
> +	};
> +};
> 
