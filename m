Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204102A3024
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 17:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgKBQmc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 11:42:32 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46626 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgKBQmb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 11:42:31 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A2GgGSo023795;
        Mon, 2 Nov 2020 10:42:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604335336;
        bh=x+tyR6fP9WKVbjUiVjfKW+ZwHBtSovlLDSYOMaR4IEg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=azl9puHdhASIGZkeOm73EbM5Tgm3iurp0KS7wGgLNgBUyQpNXS0mjX9O6U1asiqKC
         /GgABxzuPpV/BVKNq5ezEvranj07KeoJSg+hA43srAcGFyRlH2OJVHZDo9Xe9pYs69
         EByddWvafnIlf4aOADQl9+c/a0Hez5qKfZxpEE8k=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A2GgGrB017089
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 10:42:16 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 10:41:39 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 10:41:39 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A2Gfc4h073505;
        Mon, 2 Nov 2020 10:41:38 -0600
Date:   Mon, 2 Nov 2020 10:41:37 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Tero Kristo <t-kristo@ti.com>, Roger Quadros <rogerq@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 8/8] arm64: dts: ti: k3-j721e-main: Fix PCIe maximum
 outbound regions
Message-ID: <20201102164137.ntl3v6gu274ek2r2@gauze>
References: <20201102101154.13598-1-kishon@ti.com>
 <20201102101154.13598-9-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201102101154.13598-9-kishon@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15:41-20201102, Kishon Vijay Abraham I wrote:
> PCIe controller in J721E supports a maximum of 32 outbound regions.
> commit 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree
> nodes") incorrectly added maximum number of outbound regions to 16. Fix
> it here.
> 
> Fixes: 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes")
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index e2a96b2c423c..61b533130ed1 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -652,7 +652,7 @@
>  		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 239 1>;
>  		clock-names = "fck";
> -		cdns,max-outbound-regions = <16>;
> +		cdns,max-outbound-regions = <32>;
>  		max-functions = /bits/ 8 <6>;
>  		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
>  		dma-coherent;
> @@ -701,7 +701,7 @@
>  		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 240 1>;
>  		clock-names = "fck";
> -		cdns,max-outbound-regions = <16>;
> +		cdns,max-outbound-regions = <32>;
>  		max-functions = /bits/ 8 <6>;
>  		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
>  		dma-coherent;
> @@ -750,7 +750,7 @@
>  		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 241 1>;
>  		clock-names = "fck";
> -		cdns,max-outbound-regions = <16>;
> +		cdns,max-outbound-regions = <32>;
>  		max-functions = /bits/ 8 <6>;
>  		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
>  		dma-coherent;
> @@ -799,7 +799,7 @@
>  		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 242 1>;
>  		clock-names = "fck";
> -		cdns,max-outbound-regions = <16>;
> +		cdns,max-outbound-regions = <32>;
>  		max-functions = /bits/ 8 <6>;
>  		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
>  		dma-coherent;
> -- 
> 2.17.1
> 

Does this need to be part of this series? If NOT, please pull this  out
and repost so that it can be independently picked up since there is no
dependency on the bindings or any part of this series?


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
