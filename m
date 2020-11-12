Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25172B0910
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 16:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgKLP45 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 10:56:57 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60634 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728581AbgKLP45 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 10:56:57 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0ACFuofO113289;
        Thu, 12 Nov 2020 09:56:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605196610;
        bh=S008qvsun6qsq/GxVe34JQfnAp0QKeuQcS7I7Sd4MIw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=x/QWqJM+Jlr3TgEJa/R7p9cIfh9AgqVCjd5xZ17FGOagAD2AO5UNRlydZH8YXv15T
         kbbfcbL8Trzfpe+AUZnQK/lj7KEdFB9Fcqi7Epd23cbG030l8okgXy2+OSdwCav45A
         CfQzQG4/SQcxs8p6lmY2/GwSZ7T4U85nlEjDlffI=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0ACFunhI070088
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 09:56:49 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 12
 Nov 2020 09:56:49 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 12 Nov 2020 09:56:49 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0ACFujK7000640;
        Thu, 12 Nov 2020 09:56:46 -0600
Subject: Re: [PATCH v2 7/7] arm64: dts: ti: k3-j7200-common-proc-board: Enable
 PCIe
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>, Lee Jones <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201109170409.4498-1-kishon@ti.com>
 <20201109170409.4498-8-kishon@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <40cc8bd1-54c0-54de-6f4d-f20ad4f90164@ti.com>
Date:   Thu, 12 Nov 2020 21:26:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201109170409.4498-8-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/9/20 10:34 PM, Kishon Vijay Abraham I wrote:
> x2 lane PCIe slot in the common processor board is enabled and connected to
> j7200 SOM. Add PCIe DT node in common processor board to reflect the
> same.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

>  .../boot/dts/ti/k3-j7200-common-proc-board.dts    | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index 65a2e5aeb050..174a55a18522 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -6,6 +6,7 @@
>  /dts-v1/;
>  
>  #include "k3-j7200-som-p0.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/net/ti-dp83867.h>
>  #include <dt-bindings/mux/ti-serdes.h>
>  #include <dt-bindings/phy/phy.h>
> @@ -236,3 +237,17 @@
>  		resets = <&serdes_wiz0 3>;
>  	};
>  };
> +
> +&pcie1_rc {
> +	reset-gpios = <&exp1 2 GPIO_ACTIVE_HIGH>;
> +	phys = <&serdes0_pcie_link>;
> +	phy-names = "pcie-phy";
> +	num-lanes = <2>;
> +};
> +
> +&pcie1_ep {
> +	phys = <&serdes0_pcie_link>;
> +	phy-names = "pcie-phy";
> +	num-lanes = <2>;
> +	status = "disabled";
> +};
> 
