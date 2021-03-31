Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009C134F56F
	for <lists+linux-pci@lfdr.de>; Wed, 31 Mar 2021 02:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhCaAZE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 20:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhCaAY2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Mar 2021 20:24:28 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA21C061765
        for <linux-pci@vger.kernel.org>; Tue, 30 Mar 2021 17:24:28 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id v10so12892360pgs.12
        for <linux-pci@vger.kernel.org>; Tue, 30 Mar 2021 17:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ub28FHj/nP801IQO46xUZahOb4byvrwZQUANAPDaSEA=;
        b=SOcvf/tGl+Al4KoWwPZq+DDeyAcVz2fMNFsevwb00+4IxVKFLY+T5o5h3mSdiCgM7k
         yEp5mEg+0He6/AbTRXBrdnSBU4NV3EcOCdNyLAEZvBB8EPDiFZxQtUm+BkcumlwvtIP/
         sqDp6BioT6jIx6uD800hvxx44tUtOxEat2QFdqDjEkIRMajE74l1SvLgmtrObxlHts4I
         X77DrWlnbT5DziL+Kuc6jou+0BVCxNs3Q/+6rUG+LgsZl82QRMYcmKi9cVaH/gyVp7ea
         Rm+3z87LxjdEc2Onwmr8NVrkPCh07y3jLu3F05NpbZFz3X6urGoDTtoOKgvIlvnV7RO2
         BvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ub28FHj/nP801IQO46xUZahOb4byvrwZQUANAPDaSEA=;
        b=AANRS9f4EsYtV4tYU9IUCYZUMuKTUKVj1+aWwBhcttmW3TAucp99MPIiS1JiSSQ/qa
         N3ZLKrahUnCawunAka2c5dwVAJaJqSYGbAmfaIV2Y6ZV3xZf5e9hOGA9amgvbEYnZFcZ
         owHIHEdvTJPJei/xdHe65A4YeFah7Ouq1XxMpF1gFmNtuTQ09QiFfdbgZYaeC/ClQtXp
         GEwjTk/XjoKuc45VMwDa+T0JDA20OkFSqydoqHWuqi8ein+LL5CPJT49Rwb0xA7XnAUY
         qIm6IcPLPgAl/KczrHANKZ9TGk5oAfHL+R8m477jU02H9J8DoanRYxZM8dGwnAP/jKFw
         GB6Q==
X-Gm-Message-State: AOAM533dPdrZD5D5lQWHIPIKrrBejd2CgjKJNvgymft3KM0JOCCdqenD
        wDFDiOIai6/g4EY7HmgI50WKbQ==
X-Google-Smtp-Source: ABdhPJybsZFi/2pN93X3ZjdAqDBFgjVrY3uiPHLxNABzi4IU4lfFKhHkaqZRMkHbJDl9onKr2z/Byg==
X-Received: by 2002:a62:8103:0:b029:1ef:26e4:494f with SMTP id t3-20020a6281030000b02901ef26e4494fmr461898pfd.41.1617150267976;
        Tue, 30 Mar 2021 17:24:27 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id f21sm238126pjj.52.2021.03.30.17.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 17:24:27 -0700 (PDT)
Date:   Tue, 30 Mar 2021 17:24:27 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Mar 2021 17:16:56 PDT (-0700)
Subject:     Re: [PATCH v2 6/6] riscv: dts: Add PCIe support for the SiFive FU740-C000 SoC
In-Reply-To: <17994571deaf703e65ece7e44c742f82c988cf39.1615954046.git.greentime.hu@sifive.com>
CC:     greentime.hu@sifive.com, Paul Walmsley <paul.walmsley@sifive.com>,
        hes@sifive.com, erik.danie@sifive.com, zong.li@sifive.com,
        bhelgaas@google.com, robh+dt@kernel.org, aou@eecs.berkeley.edu,
        mturquette@baylibre.com, sboyd@kernel.org,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        alex.dewar90@gmail.com, khilman@baylibre.com,
        hayashi.kunihiko@socionext.com, vidyas@nvidia.com,
        jh80.chung@samsung.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        helgaas@kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-30f397a9-b7af-4247-baa0-d8e1d30c6b97@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 17 Mar 2021 23:08:13 PDT (-0700), greentime.hu@sifive.com wrote:
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/boot/dts/sifive/fu740-c000.dtsi | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> index d1bb22b11920..d0839739b425 100644
> --- a/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> +++ b/arch/riscv/boot/dts/sifive/fu740-c000.dtsi
> @@ -158,6 +158,7 @@ prci: clock-controller@10000000 {
>  			reg = <0x0 0x10000000 0x0 0x1000>;
>  			clocks = <&hfclk>, <&rtcclk>;
>  			#clock-cells = <1>;
> +			#reset-cells = <1>;
>  		};
>  		uart0: serial@10010000 {
>  			compatible = "sifive,fu740-c000-uart", "sifive,uart0";
> @@ -288,5 +289,38 @@ gpio: gpio@10060000 {
>  			clocks = <&prci PRCI_CLK_PCLK>;
>  			status = "disabled";
>  		};
> +		pcie@e00000000 {
> +			#address-cells = <3>;
> +			#interrupt-cells = <1>;
> +			#num-lanes = <8>;
> +			#size-cells = <2>;
> +			compatible = "sifive,fu740-pcie";
> +			reg = <0xe 0x00000000 0x1 0x0
> +			       0xd 0xf0000000 0x0 0x10000000
> +			       0x0 0x100d0000 0x0 0x1000>;
> +			reg-names = "dbi", "config", "mgmt";
> +			device_type = "pci";
> +			dma-coherent;
> +			bus-range = <0x0 0xff>;
> +			ranges = <0x81000000  0x0 0x60080000  0x0 0x60080000 0x0 0x10000        /* I/O */
> +				  0x82000000  0x0 0x60090000  0x0 0x60090000 0x0 0xff70000      /* mem */
> +				  0x82000000  0x0 0x70000000  0x0 0x70000000 0x0 0x1000000      /* mem */
> +				  0xc3000000 0x20 0x00000000 0x20 0x00000000 0x20 0x00000000>;  /* mem prefetchable */
> +			num-lanes = <0x8>;
> +			interrupts = <56 57 58 59 60 61 62 63 64>;
> +			interrupt-names = "msi", "inta", "intb", "intc", "intd";
> +			interrupt-parent = <&plic0>;
> +			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
> +			interrupt-map = <0x0 0x0 0x0 0x1 &plic0 57>,
> +					<0x0 0x0 0x0 0x2 &plic0 58>,
> +					<0x0 0x0 0x0 0x3 &plic0 59>,
> +					<0x0 0x0 0x0 0x4 &plic0 60>;
> +			clock-names = "pcie_aux";
> +			clocks = <&prci PRCI_CLK_PCIE_AUX>;
> +			pwren-gpios = <&gpio 5 0>;
> +			perstn-gpios = <&gpio 8 0>;
> +			resets = <&prci 4>;
> +			status = "okay";
> +		};
>  	};
>  };

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

I'm happy to take these all through the RISC-V tree if that helps, but 
as usual I'd like reviews or acks from the subsystem maintainers.  It 
looks like there are some issues so I'm going to drop this from my 
inbox.
