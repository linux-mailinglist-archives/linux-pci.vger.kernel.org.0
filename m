Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33B54487ED
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 17:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfFQPxC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 11:53:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44945 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbfFQPxC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 11:53:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id n2so6041564pgp.11
        for <linux-pci@vger.kernel.org>; Mon, 17 Jun 2019 08:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S7ngWg/dGvSzj0XneHYvcMjpcrrpDF4uBht8DDV+QYs=;
        b=G4LBGiEmM7N7aIJmmY1skkNswt4oG70FpRVD37PbcmRquCrnzjUdp2lCOY99RwIVHX
         N1mdEC594UDi6fzJ+aobJJhRKLxZCZVXfJWnoEHWNsf1mo51QN2L4z/cOQLA+2dITEB2
         dlQgw4SrB3hrlWzDcEdh2on6KV3JfJCjVO2H82FqUJgMY02jsR3N/PN1r5xkFB8mtAN+
         APq4ct77N64uWRwcdYjo3ijnDphMDR4rdoAsyZo5KWJRyI4i+W0ll9UYvIbt8MB1hH2W
         Z6NztCa2ZolulhfNm7OBhdi0+UYBf9nGSSy1AIKbEVLXzak6W/XmxFs4gckV9CtbWpzh
         yMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S7ngWg/dGvSzj0XneHYvcMjpcrrpDF4uBht8DDV+QYs=;
        b=LY2HHVwrY5SUmy9/9jihlCujOWoUTrnba+7i9Np3/t8VJGut2RpAQVnWcpcqxqnsPq
         eCVB3hcW/crBRlOfTmwNL2oDVrimgRt5dS4G745AtuafB5e1lVycN36aZafMmUygyuj7
         X9TMmhrTyP44GR7q8iZVyO9T5ady6tayjhDxqwLFaSfHKfxPtkX/ej9JVHv5Nq/WdwAN
         m6yULcM8rcfwH4J6vZ+NBBe/c0iP6GZMsa/O1NxaRHczl34nMDWDtlts/B/sh0g4jx3z
         Zfu1hXVNyHxGcBjtK9WMDj6WoR+ozT4lAj/LupBShAcC4QUO3n+BD4FeodFqZPoU3Jts
         sYnA==
X-Gm-Message-State: APjAAAURVCYSMKnq3NAdv+5ulxC7yEbyCextTd2zk1+ohQehIGP2I8zD
        9tfhb8dBz+dZtiWE0FHGvu2Fow==
X-Google-Smtp-Source: APXvYqybOZhxiXhuBUOnJwTzhWqMpnNpfp4se+O2qoQaSVz1X3cfFIsxYq6MSI4nIqECK5Zcufg0Cg==
X-Received: by 2002:a62:fb0a:: with SMTP id x10mr8950272pfm.224.1560786781740;
        Mon, 17 Jun 2019 08:53:01 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l68sm8871042pjb.8.2019.06.17.08.52.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 08:53:01 -0700 (PDT)
Date:   Mon, 17 Jun 2019 08:53:51 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3] arm64: dts: qcom: msm8998: Add PCIe PHY and RC nodes
Message-ID: <20190617155351.GG31088@tuxbook-pro>
References: <f9d9afc3-06cb-a0bf-e420-8188f8255a88@free.fr>
 <c41c4057-8352-3b8e-1bdb-631df1ec3cd8@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c41c4057-8352-3b8e-1bdb-631df1ec3cd8@free.fr>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu 11 Apr 01:50 PDT 2019, Marc Gonzalez wrote:

> Add MSM8998 PCIe QMP PHY and PCIe root complex DT nodes.
> 
> Based on the following DTS downstream:
> https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm8998.dtsi?h=LE.UM.1.3.r3.25#n2537
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Applied

Thanks,
Bjorn

> ---
> Changes from v2:
> 	- Move all X-names props *after* corresponding X(s) prop
> 	- Drop comments
> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 69 +++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index f807ea3e2c6e..dab3333e21f4 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -621,6 +621,75 @@
>  				<GIC_SPI 369 IRQ_TYPE_EDGE_RISING>;
>  		};
>  
> +		pcie0: pci@1c00000 {
> +			compatible = "qcom,pcie-msm8996";
> +			reg =	<0x01c00000 0x2000>,
> +				<0x1b000000 0xf1d>,
> +				<0x1b000f20 0xa8>,
> +				<0x1b100000 0x100000>;
> +			reg-names = "parf", "dbi", "elbi", "config";
> +			device_type = "pci";
> +			linux,pci-domain = <0>;
> +			bus-range = <0x00 0xff>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			num-lanes = <1>;
> +			phys = <&pciephy>;
> +			phy-names = "pciephy";
> +
> +			ranges = <0x01000000 0x0 0x1b200000 0x1b200000 0x0 0x100000>,
> +				 <0x02000000 0x0 0x1b300000 0x1b300000 0x0 0xd00000>;
> +
> +			#interrupt-cells = <1>;
> +			interrupts = <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map =	<0 0 0 1 &intc 0 135 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 136 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 138 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 139 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
> +				 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_0_AUX_CLK>;
> +			clock-names = "pipe", "bus_master", "bus_slave", "cfg", "aux";
> +
> +			power-domains = <&gcc PCIE_0_GDSC>;
> +			iommu-map = <0x100 &anoc1_smmu 0x1480 1>;
> +			perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		phy@1c06000 {
> +			compatible = "qcom,msm8998-qmp-pcie-phy";
> +			reg = <0x01c06000 0x18c>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			clocks = <&gcc GCC_PCIE_PHY_AUX_CLK>,
> +				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
> +				 <&gcc GCC_PCIE_CLKREF_CLK>;
> +			clock-names = "aux", "cfg_ahb", "ref";
> +
> +			resets = <&gcc GCC_PCIE_0_PHY_BCR>, <&gcc GCC_PCIE_PHY_BCR>;
> +			reset-names = "phy", "common";
> +
> +			vdda-phy-supply = <&vreg_l1a_0p875>;
> +			vdda-pll-supply = <&vreg_l2a_1p2>;
> +
> +			pciephy: lane@1c06800 {
> +				reg = <0x01c06200 0x128>, <0x01c06400 0x1fc>, <0x01c06800 0x20c>;
> +				#phy-cells = <0>;
> +
> +				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
> +				clock-names = "pipe0";
> +				clock-output-names = "pcie_0_pipe_clk_src";
> +				#clock-cells = <0>;
> +			};
> +		};
> +
>  		tcsr_mutex_regs: syscon@1f40000 {
>  			compatible = "syscon";
>  			reg = <0x1f40000 0x20000>;
> -- 
> 2.17.1
