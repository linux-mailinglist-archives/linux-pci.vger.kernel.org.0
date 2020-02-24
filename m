Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA09169FDF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 09:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgBXISt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 03:18:49 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:60135 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBXISs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 03:18:48 -0500
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Feb 2020 03:18:48 EST
Received: from mwalle01.sab.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7C5B122ED5;
        Mon, 24 Feb 2020 09:11:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582531878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uunZrjy3s12DlnbMOTQxFCthmdhavGDhtf/Hy0AGfm4=;
        b=m9o9jxnJg36uapNHQq8CiIPZZ86tRsoXEi2xbTjK5WeVWxg1a1X3z/QkoZVdwrQgymsIsx
        YNvAOcuus8KyqKkUNvDDZQrM8CyYSbKuSUyS/Tq+PQ5SNfwbAA0dVxjM3YQkUOmp16v8SO
        pBdHRGdFQ157gdiJUdjz9ZF7weMgNA8=
From:   Michael Walle <michael@walle.cc>
To:     xiaowei.bao@nxp.com
Cc:     Zhiqiang.Hou@nxp.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lorenzo.pieralisi@arm.com, mark.rutland@arm.com,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, robh+dt@kernel.org,
        roy.zang@nxp.com, shawnguo@kernel.org,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v6 2/3] arm64: dts: ls1028a: Add PCIe controller DT nodes
Date:   Mon, 24 Feb 2020 09:11:05 +0100
Message-Id: <20200224081105.13878-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190902034319.14026-2-xiaowei.bao@nxp.com>
References: <20190902034319.14026-2-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
X-Rspamd-Server: web
X-Spam-Status: Yes, score=6.40
X-Spam-Score: 6.40
X-Rspamd-Queue-Id: 7C5B122ED5
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_SPAM(0.00)[0.765];
         DKIM_SIGNED(0.00)[];
         DBL_PROHIBIT(0.00)[0.51.225.64:email,0.53.103.224:email];
         RCPT_COUNT_TWELVE(0.00)[17];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:12941, ipnet:213.135.0.0/19, country:DE];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Xiaowei, Hi Shawn,

> LS1028a implements 2 PCIe 3.0 controllers.

Patch 1/3 and 3/3 are in Linus' tree but nobody seems to care about this patch
anymore :(

This doesn't work well with the IOMMU, because the iommu-map property is
missing. The bootloader needs the &smmu phandle to fixup the entry. See
below.

Shawn, will you add this patch to your tree once its fixed, considering it
just adds the device tree node for the LS1028A?

> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> v2:
>  - Fix up the legacy INTx allocate failed issue.
> v3:
>  - No change.
> v4:
>  - Remove the num-lanes property.
> v5:
>  - Add the num-viewport property.
> v6:
>  - move num-viewport to 8.
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 52 ++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 72b9a75..c043b1d 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -625,6 +625,58 @@
>  			};
>  		};
>  
> +		pcie@3400000 {
> +			compatible = "fsl,ls1028a-pcie";
> +			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
> +			       0x80 0x00000000 0x0 0x00002000>; /* configuration space */
> +			reg-names = "regs", "config";
> +			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
> +				     <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
> +			interrupt-names = "pme", "aer";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			dma-coherent;
> +			num-viewport = <8>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x81000000 0x0 0x00000000 0x80 0x00010000 0x0 0x00010000   /* downstream I/O */
> +				  0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent = <&its>;
iommu-map = <0 &smmu 0 0>; /* fixed up by bootloader */

> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		pcie@3500000 {
> +			compatible = "fsl,ls1028a-pcie";
> +			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
> +			       0x88 0x00000000 0x0 0x00002000>; /* configuration space */
> +			reg-names = "regs", "config";
> +			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "pme", "aer";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			dma-coherent;
> +			num-viewport = <8>;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x81000000 0x0 0x00000000 0x88 0x00010000 0x0 0x00010000   /* downstream I/O */
> +				  0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
> +			msi-parent = <&its>;
likewise


With these two fixes:

Tested-by: Michael Walle <michael@walle.cc>

-michael

> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 2 &gic 0 0 GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 3 &gic 0 0 GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +					<0000 0 0 4 &gic 0 0 GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
>  		pcie@1f0000000 { /* Integrated Endpoint Root Complex */
>  			compatible = "pci-host-ecam-generic";
>  			reg = <0x01 0xf0000000 0x0 0x100000>;
> -- 
> 2.9.5
> 
> 
