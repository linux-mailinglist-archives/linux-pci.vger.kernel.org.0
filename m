Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24AEC3C7BD3
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 04:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237561AbhGNCbm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jul 2021 22:31:42 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:45051 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237422AbhGNCbm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jul 2021 22:31:42 -0400
Received: by mail-il1-f172.google.com with SMTP id r16so55445ilt.11;
        Tue, 13 Jul 2021 19:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uPhI6R4g3txHpQracoqfXeG0O0NmHZsOBtb8VJZ/KSE=;
        b=YeeOotCs+lZjCv3ySUYD8K7EtusosqSVfjTn4deYRHI7IqAl5PK/97DQtdIeuYW1Ex
         1IBA3Nh6cOWsAWH3xPG+38T0KDp305Mvhqc+Cjs7+4KyqQL38VWExp/A+tikWn29mReA
         QMicN+LkohJ5olLtYVttjAJwzfLaiubdkT90kdtHJH0qpvKNJwOYycQBxZs++t9Ak7qV
         dBpfLtuiYSTx6Es1C7UVqeDp9/0llIEMR9nlSoU6qsuQWfguflxGnrQhSm8cQhgR7UN9
         6z75/olEgTbUOA43RVELyyWSBdB/t6FUOALLnJh732vKQAijpXp3Xuh9sYLO49uQuEOa
         ci2g==
X-Gm-Message-State: AOAM533EXPbP+MW8ILQc9GU8/CoLo5tByMxujlTeNG6O0yDz+RcsOADM
        t7xyHT1b/d4pJd2PEHvpZA==
X-Google-Smtp-Source: ABdhPJyUPkTxtzkmyu8wOE5G5Y26j6e1VhACWo8dUIVd9hhTg2D4jmYokwK7CDioBWy0/VSvJWaa0w==
X-Received: by 2002:a05:6e02:e82:: with SMTP id t2mr5156384ilj.218.1626229731609;
        Tue, 13 Jul 2021 19:28:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r16sm465316iln.30.2021.07.13.19.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 19:28:51 -0700 (PDT)
Received: (nullmailer pid 1333200 invoked by uid 1000);
        Wed, 14 Jul 2021 02:28:49 -0000
Date:   Tue, 13 Jul 2021 20:28:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, Manivannan Sadhasivam <mani@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 4/8] dt-bindings: PCI: kirin: Drop PHY properties
Message-ID: <20210714022849.GA1330659@robh.at.kernel.org>
References: <cover.1626157454.git.mchehab+huawei@kernel.org>
 <a04c9c92187ceaee0fd4b8d4721e2a3275d97518.1626157454.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a04c9c92187ceaee0fd4b8d4721e2a3275d97518.1626157454.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 13, 2021 at 08:28:37AM +0200, Mauro Carvalho Chehab wrote:
> There are several properties there that belong to the PHY
> interface. Drop them, as a new binding file will describe
> the PHY properties for Kirin 960.

Folks are okay with an incompatible change on hikey960?

> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../devicetree/bindings/pci/kirin-pcie.txt       | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/kirin-pcie.txt b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> index 71cac2b74002..a93a8cfa1afb 100644
> --- a/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/kirin-pcie.txt
> @@ -10,13 +10,11 @@ Additional properties are described here:
>  Required properties
>  - compatible:
>  	"hisilicon,kirin960-pcie"
> -- reg: Should contain rc_dbi, apb, phy, config registers location and length.
> +- reg: Should contain rc_dbi, apb, config registers location and length.
>  - reg-names: Must include the following entries:
>    "dbi": controller configuration registers;
>    "apb": apb Ctrl register defined by Kirin;
> -  "phy": apb PHY register defined by Kirin;
>    "config": PCIe configuration space registers.
> -- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
>  
>  Optional properties:
>  
> @@ -25,8 +23,8 @@ Example based on kirin960:
>  	pcie@f4000000 {
>  		compatible = "hisilicon,kirin960-pcie";
>  		reg = <0x0 0xf4000000 0x0 0x1000>, <0x0 0xff3fe000 0x0 0x1000>,
> -		      <0x0 0xf3f20000 0x0 0x40000>, <0x0 0xF4000000 0 0x2000>;
> -		reg-names = "dbi","apb","phy", "config";
> +		      <0x0 0xF4000000 0 0x2000>;
> +		reg-names = "dbi","apb", "config";
>  		bus-range = <0x0  0x1>;
>  		#address-cells = <3>;
>  		#size-cells = <2>;
> @@ -39,12 +37,4 @@ Example based on kirin960:
>  				<0x0 0 0 2 &gic 0 0 0  283 4>,
>  				<0x0 0 0 3 &gic 0 0 0  284 4>,
>  				<0x0 0 0 4 &gic 0 0 0  285 4>;
> -		clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
> -			 <&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
> -			 <&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
> -			 <&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
> -			 <&crg_ctrl HI3660_ACLK_GATE_PCIE>;
> -		clock-names = "pcie_phy_ref", "pcie_aux",
> -			      "pcie_apb_phy", "pcie_apb_sys", "pcie_aclk";
> -		reset-gpios = <&gpio11 1 0 >;
>  	};
> -- 
> 2.31.1
> 
> 
