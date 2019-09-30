Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E314C2967
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 00:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfI3WWY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 18:22:24 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41607 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfI3WWX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 18:22:23 -0400
Received: by mail-oi1-f195.google.com with SMTP id w17so12608437oiw.8;
        Mon, 30 Sep 2019 15:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3gV+N2q4c7xBEndHGGNd7K/X6ylfrBjCj+XYgXjqaaA=;
        b=Wns2nT6l/0DkBpdTMWZ6/sMZEVB6orNisApsbrrPoj+xQEfjPDtaxkb1u+pmx6XKk9
         hH3rPZORYwVqnEx9tIbqCIqEu+rUTPyiQhtGpd6JVllmalf1Sv3vNffOZrAdLtd0OSiI
         9XqBiFFdHAIJ8DsVS0y8m/qzL0/SXunvevbzNBVSOHzjM0Cm4L12Rlnbi9eLo5r/xjZH
         3YchIqw5DJXsFqpbqQdFloiMNTybV+yKFgHqjUC9dpqH5ssdCwFN/k9f6BOk2inAo7D2
         BbRrybKB0b2dgT2qbCNK9NqnspmAkKPHxbhEmW7vbCK0E1Z6g0u6ioDOK9596RBfJohN
         1RzA==
X-Gm-Message-State: APjAAAXFT8gBI6t3OByehkaxleBIJa4/T3LhpLd5tXNA1Vsq8Ik+UNzQ
        1UMjqj5VdNBJ/NOxIHlh2g==
X-Google-Smtp-Source: APXvYqxVlkZ7EqGOYTrAdHZlOQJmcXo93WrERqOQtRgYQpwCMDU3zVOggGVnVmoHHdYMkoNNmQkgxA==
X-Received: by 2002:aca:3387:: with SMTP id z129mr1221964oiz.65.1569882142647;
        Mon, 30 Sep 2019 15:22:22 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t82sm4686884oie.12.2019.09.30.15.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 15:22:22 -0700 (PDT)
Date:   Mon, 30 Sep 2019 17:22:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     Zhiqiang.Hou@nxp.com, bhelgaas@google.com, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, Minghuan.Lian@nxp.com,
        andrew.murray@arm.com, mingkai.hu@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: Add DT binding for PCIE GEN4 EP of the
 layerscape
Message-ID: <20190930222221.GA13251@bogus>
References: <20190916021742.22844-1-xiaowei.bao@nxp.com>
 <20190916021742.22844-3-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916021742.22844-3-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 16, 2019 at 10:17:38AM +0800, Xiaowei Bao wrote:
> Add the documentation for the Device Tree binding of the layerscape
> PCIe GEN4 controller with EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
>  .../bindings/pci/layerscape-pcie-gen4.txt          | 28 +++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt b/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
> index b40fb5d..414a86c 100644
> --- a/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
> +++ b/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
> @@ -3,6 +3,8 @@ NXP Layerscape PCIe Gen4 controller
>  This PCIe controller is based on the Mobiveil PCIe IP and thus inherits all
>  the common properties defined in mobiveil-pcie.txt.
>  
> +HOST MODE
> +=========
>  Required properties:
>  - compatible: should contain the platform identifier such as:
>    "fsl,lx2160a-pcie"
> @@ -23,7 +25,20 @@ Required properties:
>  - msi-parent : See the generic MSI binding described in
>    Documentation/devicetree/bindings/interrupt-controller/msi.txt.
>  
> -Example:
> +DEVICE MODE
> +=========
> +Required properties:
> +- compatible: should contain the platform identifier such as:
> +  "fsl,lx2160a-pcie-ep"
> +- reg: base addresses and lengths of the PCIe controller register blocks.
> +  "regs": PCIe controller registers.
> +  "addr_space" EP device CPU address.
> +- apio-wins: number of requested apio outbound windows.
> +
> +Optional Property:
> +- max-functions: Maximum number of functions that can be configured (default 1).
> +
> +RC Example:
>  
>  	pcie@3400000 {
>  		compatible = "fsl,lx2160a-pcie";
> @@ -50,3 +65,14 @@ Example:
>  				<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
>  				<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
>  	};
> +
> +EP Example:
> +
> +	pcie_ep@3400000 {

pcie-endpoint@...

> +		compatible = "fsl,lx2160a-pcie-ep";
> +		reg = <0x00 0x03400000 0x0 0x00100000
> +		       0x80 0x00000000 0x8 0x00000000>;
> +		reg-names = "regs", "addr_space";
> +		apio-wins = <8>;
> +		status = "disabled";

Don't show status in examples.

> +	};
> -- 
> 2.9.5
> 
