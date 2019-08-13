Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 218048BD2E
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 17:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfHMPat (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 11:30:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42958 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbfHMPat (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Aug 2019 11:30:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id j7so29264014ota.9;
        Tue, 13 Aug 2019 08:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F3iDcqciF20w4Uv8REvfNc176GVhGh7FqmfmhGEIDug=;
        b=ktib7JqQ/X+/nRNIN4zRyXNI0NRx3BHTDfwBLQGNjbA42HdXk4rhTX/SfA7bUgm7rQ
         v2aWZBdeAGQOJixwZx87TNVLtX9EvdzEQea8T+8pptTQim+omwr+0/9XEbVrBuh6zp75
         dQWU3BNAb9FLugZIY3ctf2TV4bj/51uBpiNNr0/Nd3TZ5Wv4dWzHI3w99cXjTg3pOnqe
         hFeukAQDfmdP60eLo/Blib3Tjhlov2IFUff4YAxu14k4fqUAOWaavHr2npK56XBlnwSj
         QxRMz3zXFtYBflcgAF/b9eAEMKHQd4Y/F6kP10Ani9j70FDE/jmdLy8h+1HY5eyJT/LD
         a1Iw==
X-Gm-Message-State: APjAAAUmt0DDgqEmu2fUyQx6EHiozgqip5s2owvWsz+HuITqEtpnDD1s
        eXF/yxTtJsV7ZGnjB1g6Xw==
X-Google-Smtp-Source: APXvYqxS/NE+2RYGWfGfwrPDfgjfsNpT/w8j9CnFNaWvIovgfq7VOv6gYIztL7DJlY/jL6n/EmqHvg==
X-Received: by 2002:a6b:7a0a:: with SMTP id h10mr1727905iom.45.1565710247972;
        Tue, 13 Aug 2019 08:30:47 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id l2sm21851157ioq.83.2019.08.13.08.30.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 08:30:47 -0700 (PDT)
Date:   Tue, 13 Aug 2019 09:30:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Chocron <jonnyc@amazon.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        mark.rutland@arm.com, dwmw@amazon.co.uk, benh@kernel.crashing.org,
        alisaidi@amazon.com, ronenk@amazon.com, barakw@amazon.com,
        talel@amazon.com, hanochu@amazon.com, hhhawa@amazon.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 5/8] dt-bindings: PCI: Add Amazon's Annapurna Labs
 PCIe host bridge binding
Message-ID: <20190813153046.GA31480@bogus>
References: <20190723092529.11310-1-jonnyc@amazon.com>
 <20190723092711.11786-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723092711.11786-1-jonnyc@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 23, 2019 at 12:27:08PM +0300, Jonathan Chocron wrote:
> Document Amazon's Annapurna Labs PCIe host bridge.
> 
> Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
> ---
>  .../devicetree/bindings/pci/pcie-al.txt       | 45 +++++++++++++++++++
>  MAINTAINERS                                   |  3 +-
>  2 files changed, 47 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/pcie-al.txt
> 
> diff --git a/Documentation/devicetree/bindings/pci/pcie-al.txt b/Documentation/devicetree/bindings/pci/pcie-al.txt
> new file mode 100644
> index 000000000000..89876190eb5a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/pcie-al.txt
> @@ -0,0 +1,45 @@
> +* Amazon Annapurna Labs PCIe host bridge
> +
> +Amazon's Annapurna Labs PCIe Host Controller is based on the Synopsys DesignWare
> +PCI core.
> +It shares common functions with the PCIe DesignWare core driver and inherits

Driver details are irrelevant to the binding.

> +common properties defined in Documentation/devicetree/bindings/pci/designware-pcie.txt.
> +Properties of the host controller node that differ from it are:
> +
> +- compatible:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: Value should contain
> +			- "amazon,al-pcie"

Needs to be SoC specific.

> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: Register ranges as listed in the reg-names property
> +
> +- reg-names:
> +	Usage: required
> +	Value type: <stringlist>
> +	Definition: Must include the following entries
> +			- "config"	PCIe ECAM space
> +			- "controller"	AL proprietary registers
> +			- "dbi"		Designware PCIe registers
> +
> +Example:
> +
> +	pcie-external0: pcie@fb600000 {
> +		compatible = "amazon,al-pcie";
> +		reg = <0x0 0xfb600000 0x0 0x00100000
> +		       0x0 0xfd800000 0x0 0x00010000
> +		       0x0 0xfd810000 0x0 0x00001000>;
> +		reg-names = "config", "controller", "dbi";
> +		bus-range = <0 255>;
> +		device_type = "pci";
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		#interrupt-cells = <1>;
> +		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-map-mask = <0x00 0 0 7>;
> +		interrupt-map = <0x0000 0 0 1 &gic GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>; /* INTa */
> +		ranges = <0x02000000 0x0 0xc0010000 0x0 0xc0010000 0x0 0x07ff0000>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5a6137df3f0e..29cca14a05a6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12201,10 +12201,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
>  S:	Supported
>  F:	drivers/pci/controller/
>  
> -PCIE DRIVER FOR ANNAPURNA LABS
> +PCIE DRIVER FOR AMAZON ANNAPURNA LABS
>  M:	Jonathan Chocron <jonnyc@amazon.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/pci/pcie-al.txt
>  F:	drivers/pci/controller/dwc/pcie-al.c
>  
>  PCIE DRIVER FOR AMLOGIC MESON
> -- 
> 2.17.1
> 
