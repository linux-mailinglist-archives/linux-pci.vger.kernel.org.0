Return-Path: <linux-pci+bounces-36571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFC6B8C18B
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 09:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC926223EC
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 07:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755FA26773C;
	Sat, 20 Sep 2025 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvVfkc9p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC66A55;
	Sat, 20 Sep 2025 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758354140; cv=none; b=tg3vp0qIGXxtk6d+VD/kA3rwL2qoZ4tUOa4Sdy5mWvlN3CGcQtAzQzDFkg3xCp4k0/YoCPCU5CqLG9s8AEqOANOpgJdrJGl7+l+YBkHUunwpJETJ02kQTmT5bAo5dpbUh0bTW3gOli5NPiNk1whAH0S/3DQvZ++q5tnEuH630G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758354140; c=relaxed/simple;
	bh=00/ZcdeScyYNhHtGZfw/xJV1F83XgBgalo+slKN3fjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnpNnZEFNkYggMObW/wi7SjBbkNOolFNAQLj63hxdOVqRQUXKh0XPar7KLyazyH2LjzMQYNzdUQyGO0ydURP86BH+Yo/e3tcJSf7ommhJGGbDEvg9x9vnJRn+nBGv9t9dSyRLEXyYCyGJQF+UsavEsxozH5FfWUy0TNDW7bE59o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvVfkc9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEC7C4CEEB;
	Sat, 20 Sep 2025 07:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758354139;
	bh=00/ZcdeScyYNhHtGZfw/xJV1F83XgBgalo+slKN3fjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvVfkc9p1DQkPQGO6GvJxUSVuzwQyG0dxhdApalfEBZOdOBtSMcgKk0xJmK0jQuSI
	 XJCEEZuu3VbGnRULFowmzwbchAXvDXUvZpGCmgsUuRslFce1oMhKt7E6EcErgv28Wg
	 RyDp2qZDwjG2Y7kOPZXACiBEAOHtVl6rlsUUxQlC6lUi8rMdwh/6e79eUW49+2FUBX
	 zok+//sVZGZwSXAqgmZu4pmzJgNCWIVHVs9xQdvaFa/JRRaTL3wxR+jFonqq5Il91m
	 VOjFZP0Pokvf691m8TEg6SZgdo3SFE65v43VtPDUquAzoW0lGYueiwehQWKtAPNC5C
	 znSjsF7BW7Udg==
Date: Sat, 20 Sep 2025 13:12:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: kwilczynski@kernel.org, u.kleine-koenig@baylibre.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, arnd@arndb.de, bwawrzyn@cisco.com, 
	bhelgaas@google.com, unicorn_wang@outlook.com, conor+dt@kernel.org, 
	18255117159@163.com, inochiama@gmail.com, kishon@kernel.org, krzk+dt@kernel.org, 
	lpieralisi@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org, 
	s-vadapalli@ti.com, tglx@linutronix.de, thomas.richard@bootlin.com, 
	sycamoremoon376@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, sophgo@lists.linux.dev, 
	rabenda.cn@gmail.com, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
	fengchun.li@sophgo.com, jeffbai@aosc.io
Subject: Re: [PATCH v3 4/7] riscv: sophgo: dts: add PCIe controllers for
 SG2042
Message-ID: <cwc3hnre3s3rvzcgzjdbdrhlrizz4obifwragusrixa5owj5qg@yotfd3l3qxf4>
References: <cover.1757643388.git.unicorn_wang@outlook.com>
 <828860951ec4973285fe92fceb4b6f0ecb365a2f.1757643388.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <828860951ec4973285fe92fceb4b6f0ecb365a2f.1757643388.git.unicorn_wang@outlook.com>

On Fri, Sep 12, 2025 at 10:36:50AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add PCIe controller nodes in DTS for Sophgo SG2042.
> Default they are disabled.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Signed-off-by: Han Gao <rabenda.cn@gmail.com>
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  arch/riscv/boot/dts/sophgo/sg2042.dtsi | 88 ++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> index b3e4d3c18fdc..b521f674283e 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -220,6 +220,94 @@ clkgen: clock-controller@7030012000 {
>  			#clock-cells = <1>;
>  		};
>  
> +		pcie_rc0: pcie@7060000000 {
> +			compatible = "sophgo,sg2042-pcie-host";
> +			device_type = "pci";
> +			reg = <0x70 0x60000000  0x0 0x00800000>,
> +			      <0x40 0x00000000  0x0 0x00001000>;
> +			reg-names = "reg", "cfg";
> +			linux,pci-domain = <0>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0  0xc0000000  0x40 0xc0000000  0x0 0x00400000>,

PCI address of the I/O port starts from 0. So this should be:

				<0x01000000 0x0  0x00000000  0x40 0xc0000000  0x0 0x00400000>,

Same comment for other nodes.

With this fixed,

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> +				 <0x42000000 0x0  0xd0000000  0x40 0xd0000000  0x0 0x10000000>,
> +				 <0x02000000 0x0  0xe0000000  0x40 0xe0000000  0x0 0x20000000>,
> +				 <0x43000000 0x42 0x00000000  0x42 0x00000000  0x2 0x00000000>,
> +				 <0x03000000 0x41 0x00000000  0x41 0x00000000  0x1 0x00000000>;
> +			bus-range = <0x0 0xff>;
> +			vendor-id = <0x1f1c>;
> +			device-id = <0x2042>;
> +			cdns,no-bar-match-nbits = <48>;
> +			msi-parent = <&msi>;
> +			status = "disabled";
> +		};
> +
> +		pcie_rc1: pcie@7060800000 {
> +			compatible = "sophgo,sg2042-pcie-host";
> +			device_type = "pci";
> +			reg = <0x70 0x60800000  0x0 0x00800000>,
> +			      <0x44 0x00000000  0x0 0x00001000>;
> +			reg-names = "reg", "cfg";
> +			linux,pci-domain = <1>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0  0xc0400000  0x44 0xc0400000  0x0 0x00400000>,
> +				 <0x42000000 0x0  0xd0000000  0x44 0xd0000000  0x0 0x10000000>,
> +				 <0x02000000 0x0  0xe0000000  0x44 0xe0000000  0x0 0x20000000>,
> +				 <0x43000000 0x46 0x00000000  0x46 0x00000000  0x2 0x00000000>,
> +				 <0x03000000 0x45 0x00000000  0x45 0x00000000  0x1 0x00000000>;
> +			bus-range = <0x0 0xff>;
> +			vendor-id = <0x1f1c>;
> +			device-id = <0x2042>;
> +			cdns,no-bar-match-nbits = <48>;
> +			msi-parent = <&msi>;
> +			status = "disabled";
> +		};
> +
> +		pcie_rc2: pcie@7062000000 {
> +			compatible = "sophgo,sg2042-pcie-host";
> +			device_type = "pci";
> +			reg = <0x70 0x62000000  0x0 0x00800000>,
> +			      <0x48 0x00000000  0x0 0x00001000>;
> +			reg-names = "reg", "cfg";
> +			linux,pci-domain = <2>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0  0xc0800000  0x48 0xc0800000  0x0 0x00400000>,
> +				 <0x42000000 0x0  0xd0000000  0x48 0xd0000000  0x0 0x10000000>,
> +				 <0x02000000 0x0  0xe0000000  0x48 0xe0000000  0x0 0x20000000>,
> +				 <0x03000000 0x49 0x00000000  0x49 0x00000000  0x1 0x00000000>,
> +				 <0x43000000 0x4a 0x00000000  0x4a 0x00000000  0x2 0x00000000>;
> +			bus-range = <0x0 0xff>;
> +			vendor-id = <0x1f1c>;
> +			device-id = <0x2042>;
> +			cdns,no-bar-match-nbits = <48>;
> +			msi-parent = <&msi>;
> +			status = "disabled";
> +		};
> +
> +		pcie_rc3: pcie@7062800000 {
> +			compatible = "sophgo,sg2042-pcie-host";
> +			device_type = "pci";
> +			reg = <0x70 0x62800000  0x0 0x00800000>,
> +			      <0x4c 0x00000000  0x0 0x00001000>;
> +			reg-names = "reg", "cfg";
> +			linux,pci-domain = <3>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			ranges = <0x01000000 0x0  0xc0c00000  0x4c 0xc0c00000  0x0 0x00400000>,
> +				 <0x42000000 0x0  0xf8000000  0x4c 0xf8000000  0x0 0x04000000>,
> +				 <0x02000000 0x0  0xfc000000  0x4c 0xfc000000  0x0 0x04000000>,
> +				 <0x43000000 0x4e 0x00000000  0x4e 0x00000000  0x2 0x00000000>,
> +				 <0x03000000 0x4d 0x00000000  0x4d 0x00000000  0x1 0x00000000>;
> +			bus-range = <0x0 0xff>;
> +			vendor-id = <0x1f1c>;
> +			device-id = <0x2042>;
> +			cdns,no-bar-match-nbits = <48>;
> +			msi-parent = <&msi>;
> +			status = "disabled";
> +		};
> +
>  		clint_mswi: interrupt-controller@7094000000 {
>  			compatible = "sophgo,sg2042-aclint-mswi", "thead,c900-aclint-mswi";
>  			reg = <0x00000070 0x94000000 0x00000000 0x00004000>;
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

