Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7B5DB6BF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 21:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407138AbfJQTDN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Oct 2019 15:03:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46659 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfJQTDN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2019 15:03:13 -0400
Received: by mail-ot1-f68.google.com with SMTP id 89so2809374oth.13;
        Thu, 17 Oct 2019 12:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+qxiN1i8NgnAmFnuqifw0bfYtiKy3k77tTLRGy5BhP4=;
        b=O/Oo1gEpAcxCAUaEZll3xiDTGBUIoSZ1NVehn4WYIm1NtaLjVvATVLLo6pFsC3h4Zs
         zM85mFFFlMqweP1HA9fTcrfhtrtjBmhbltqaTsC67MGqL+DNXveEIi1USe1PgW3jEFtc
         Nq4EMSJ1o8G5YTZzljQZb18LpRwz/S6CD/L6TSHaNYSUIhEQnsh3O194wPuGc/qJbeVH
         tP/T/sk89Fv4/+w1ixzjV7skQd7jcU7bSS92CqNfgxbVoMhAiLhcEVdIYimW6PNCw/kv
         MvKBwCMpWdxtO3w8iw93TMu5I0a9HdGHhB7tdGjq3qN0WgMtyd+x5qBW4S97S1/bSeqa
         cwmg==
X-Gm-Message-State: APjAAAWDSNyhpevYkqiMq33+xeGuTSj6STCH0GZBD/+kUaNpsbNQz5wd
        lmjgWm9VaDBVgk2cJaPIrQ==
X-Google-Smtp-Source: APXvYqwfC0xQT9R4BEm53I1uAtAHkdVvYNYiviZLIvLVL5SP8gE5++QtXNV/rJ83zRkat6VY30bZIw==
X-Received: by 2002:a9d:6c0a:: with SMTP id f10mr4511862otq.155.1571338992427;
        Thu, 17 Oct 2019 12:03:12 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m14sm799068otl.26.2019.10.17.12.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 12:03:10 -0700 (PDT)
Date:   Thu, 17 Oct 2019 14:03:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     Zhiqiang.Hou@nxp.com, bhelgaas@google.com, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, Minghuan.Lian@nxp.com,
        andrew.murray@arm.com, mingkai.hu@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: Add DT binding for PCIE GEN4 EP of
 the layerscape
Message-ID: <20191017190310.GA32063@bogus>
References: <20191015083702.21792-1-xiaowei.bao@nxp.com>
 <20191015083702.21792-3-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015083702.21792-3-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 15, 2019 at 04:36:58PM +0800, Xiaowei Bao wrote:
> Add the documentation for the Device Tree binding of the layerscape
> PCIe GEN4 controller with EP mode.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2: 
>  - remove the status entry in EP Example.
> 
>  .../bindings/pci/layerscape-pcie-gen4.txt          | 27 +++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt b/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
> index b40fb5d..06f9309 100644
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
> @@ -50,3 +65,13 @@ Example:
>  				<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
>  				<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
>  	};
> +
> +EP Example:
> +
> +	pcie_ep@3400000 {

To repeat my previous comment:

pcie-endpoint@...

> +		compatible = "fsl,lx2160a-pcie-ep";
> +		reg = <0x00 0x03400000 0x0 0x00100000
> +		       0x80 0x00000000 0x8 0x00000000>;
> +		reg-names = "regs", "addr_space";
> +		apio-wins = <8>;
> +	};
> -- 
> 2.9.5
> 
