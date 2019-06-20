Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 252E64CC6B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 12:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfFTKzc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 06:55:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40911 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFTKzc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 06:55:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id p11so2534572wre.7;
        Thu, 20 Jun 2019 03:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kqe9E3+jlognAO6wUNNXZTXhhMAD9nOK8RG9T+jeHBk=;
        b=cX4XZ66uaU5zznshkg+T0qt1o2BVCeFzU1maJ0wF2K+pmad4rfWSNDAa7cV4mCLIoT
         IYcio5Xb7b8xk/6K/qgtZdIZpkocxI5unHxHtQBRWYPoTFT3d0HfGjBsMML+cZDxOlTp
         O3DiWZKzsO+MZkHHsDdCVQiByqC7MSyHatuaFCk1K1+UPg8MsoAHZDDemr1T2qi13xqh
         2XSGIcPpRIejhHuPzPYlwsKkWeS3B1PlmI9bQ4/FtAUkRM8dNM5gFQh92ttj8c4DiroM
         THknTAlsnWC/SvynxvYny3wZZ6nFbOAVWbv6U4jHKf+K9rpx4/rthojCAsXhzmhQ0Wrk
         XnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kqe9E3+jlognAO6wUNNXZTXhhMAD9nOK8RG9T+jeHBk=;
        b=k1niXxJQhnOttWDcQ6q42MYmwTNolgIi7e8ZWEKWFRUl/ibjxPbM/gaylcmCcG9IqY
         Nr2G7cF7tywadLRFXMThrUtvVrd/iAWRq6QZbdGC8kCkFbIj0lnzz0sIIxh+t8a0RyDM
         N0HstWcmKOx4rPPqfkc7ihAnkZ1WEIN0DkzBTJviqROnvjgvmTKSvXR4jnk0gGumDfj+
         zw83CS0mIkQLLWSUQk/c07XFCC5HQKEi1dzLaq6UQD/kcJ1DDzdPqvIFeDCyF+ABvmTc
         KpeNpgkFTTB4H52KCqtSx9L8syhnBa5aRLdBrVseKXjhGWc1HtUCAzWYFegJZr2Bs/BI
         Q8xg==
X-Gm-Message-State: APjAAAX0OwtrPy4ARbL/XPvE5zbEVpuPGRytKKAoa9SPDDk26cFs1lVZ
        9AyR9LwURUXL6paWv8tQQ5I=
X-Google-Smtp-Source: APXvYqx8kZIjomeCz504MIjjvici2144egj/BM64OCZ91s1ZZRslW819o3cXd+7fwTcr6rug3OxScg==
X-Received: by 2002:adf:ee03:: with SMTP id y3mr13171516wrn.128.1561028128102;
        Thu, 20 Jun 2019 03:55:28 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id i128sm1488520wmi.16.2019.06.20.03.55.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:55:27 -0700 (PDT)
Date:   Thu, 20 Jun 2019 12:55:25 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, digetx@gmail.com,
        mperttunen@nvidia.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V10 11/15] arm64: tegra: Add P2U and PCIe controller
 nodes to Tegra194 DT
Message-ID: <20190620105525.GA15892@ulmo>
References: <20190612095339.20118-1-vidyas@nvidia.com>
 <20190612095339.20118-12-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20190612095339.20118-12-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2019 at 03:23:35PM +0530, Vidya Sagar wrote:
> Add P2U (PIPE to UPHY) and PCIe controller nodes to device tree.
> The Tegra194 SoC contains six PCIe controllers and twenty P2U instances
> grouped into two different PHY bricks namely High-Speed IO (HSIO-12 P2Us)
> and NVIDIA High Speed (NVHS-8 P2Us) respectively.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v9]:
> * None
>=20
> Changes since [v8]:
> * None
>=20
> Changes since [v7]:
> * Replaced 'core_apb' with 'apb' in reset names
> * Used macros instead of hardcoded numbers in 'interrupt-map' property
> * Aligned 'ranges' entries
>=20
> Changes since [v6]:
> * Removed properties "nvidia,disable-aspm-states" & "nvidia,controller-id=
".
> * Modified property "nvidia,bpmp" to include controller-id as well.
>=20
> Changes since [v5]:
> * Changes 'p2u@xxxxxxxx' to 'phy@xxxxxxxx'
> * Arranged all PCIe nodes in the order of their addresses
>=20
> Changes since [v4]:
> * None
>=20
> Changes since [v3]:
> * None
>=20
> Changes since [v2]:
> * Included 'hsio' or 'nvhs' in P2U node's label names to reflect which br=
ick
>   they belong to
> * Removed leading zeros in unit address
>=20
> Changes since [v1]:
> * Flattened all P2U nodes by removing 'hsio-p2u' and 'nvhs-p2u' super nod=
es
> * Changed P2U nodes compatible string from 'nvidia,tegra194-phy-p2u' to '=
nvidia,tegra194-p2u'
> * Changed reg-name from 'base' to 'ctl'
> * Updated all PCIe nodes according to the changes made to DT documentatio=
n file
>=20
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 437 +++++++++++++++++++++++
>  1 file changed, 437 insertions(+)

Applied to for-5.3/arm64/dt, thanks.

I did end up sorting the new nodes differently so that they are ordered
according to the general rules (sort by unit-address, then
alphabetically). That's slightly complicated by the fact that the PCI
controllers have registers that seem to be right in the middle of the
host1x aperture, so I had to bend the rules a little.

Thierry

> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra194.dtsi
> index c77ca211fa8f..feba034f26f0 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -884,6 +884,166 @@
>  				nvidia,interface =3D <3>;
>  			};
>  		};
> +
> +		p2u_hsio_0: phy@3e10000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03e10000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_hsio_1: phy@3e20000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03e20000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_hsio_2: phy@3e30000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03e30000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_hsio_3: phy@3e40000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03e40000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_hsio_4: phy@3e50000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03e50000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_hsio_5: phy@3e60000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03e60000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_hsio_6: phy@3e70000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03e70000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_hsio_7: phy@3e80000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03e80000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_hsio_8: phy@3e90000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03e90000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_hsio_9: phy@3ea0000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03ea0000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_nvhs_0: phy@3eb0000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03eb0000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_nvhs_1: phy@3ec0000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03ec0000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_nvhs_2: phy@3ed0000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03ed0000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_nvhs_3: phy@3ee0000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03ee0000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_nvhs_4: phy@3ef0000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03ef0000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_nvhs_5: phy@3f00000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03f00000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_nvhs_6: phy@3f10000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03f10000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_nvhs_7: phy@3f20000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03f20000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_hsio_10: phy@3f30000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03f30000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
> +
> +		p2u_hsio_11: phy@3f40000 {
> +			compatible =3D "nvidia,tegra194-p2u";
> +			reg =3D <0x03f40000 0x10000>;
> +			reg-names =3D "ctl";
> +
> +			#phy-cells =3D <0>;
> +		};
>  	};
> =20
>  	sysram@40000000 {
> @@ -1054,4 +1214,281 @@
>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>  		interrupt-parent =3D <&gic>;
>  	};
> +
> +	pcie@14100000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
> +		reg =3D <0x00 0x14100000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x30000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x30040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x30080000 0x0 0x00040000>; /* DBI reg space (256K)       =
*/
> +		reg-names =3D "appl", "config", "atu_dma", "dbi";
> +
> +		status =3D "disabled";
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		device_type =3D "pci";
> +		num-lanes =3D <1>;
> +		num-viewport =3D <8>;
> +		linux,pci-domain =3D <1>;
> +
> +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_1>;
> +		clock-names =3D "core";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_1_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_1>;
> +		reset-names =3D "apb", "core";
> +
> +		interrupts =3D <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,	/* controller interru=
pt */
> +			     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> +		interrupt-names =3D "intr", "msi";
> +
> +		#interrupt-cells =3D <1>;
> +		interrupt-map-mask =3D <0 0 0 0>;
> +		interrupt-map =3D <0 0 0 0 &gic GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		nvidia,bpmp =3D <&bpmp 1>;
> +
> +		supports-clkreq;
> +		nvidia,aspm-cmrt-us =3D <60>;
> +		nvidia,aspm-pwr-on-t-us =3D <20>;
> +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0  0x30100000 0x0  0x30100000 0x0 0x00100000 =
  /* downstream I/O (1MB) */
> +			  0xc2000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000   /* pref=
etchable memory (768MB) */
> +			  0x82000000 0x0  0x40000000 0x12 0x30000000 0x0 0x10000000>; /* non-=
prefetchable memory (256MB) */
> +	};
> +
> +	pcie@14120000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
> +		reg =3D <0x00 0x14120000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x32000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x32040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x32080000 0x0 0x00040000>; /* DBI reg space (256K)       =
*/
> +		reg-names =3D "appl", "config", "atu_dma", "dbi";
> +
> +		status =3D "disabled";
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		device_type =3D "pci";
> +		num-lanes =3D <1>;
> +		num-viewport =3D <8>;
> +		linux,pci-domain =3D <2>;
> +
> +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_2>;
> +		clock-names =3D "core";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_2_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_2>;
> +		reset-names =3D "apb", "core";
> +
> +		interrupts =3D <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,	/* controller interru=
pt */
> +			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> +		interrupt-names =3D "intr", "msi";
> +
> +		#interrupt-cells =3D <1>;
> +		interrupt-map-mask =3D <0 0 0 0>;
> +		interrupt-map =3D <0 0 0 0 &gic GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		nvidia,bpmp =3D <&bpmp 2>;
> +
> +		supports-clkreq;
> +		nvidia,aspm-cmrt-us =3D <60>;
> +		nvidia,aspm-pwr-on-t-us =3D <20>;
> +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0  0x32100000 0x0  0x32100000 0x0 0x00100000 =
  /* downstream I/O (1MB) */
> +			  0xc2000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000   /* pref=
etchable memory (768MB) */
> +			  0x82000000 0x0  0x40000000 0x12 0x70000000 0x0 0x10000000>; /* non-=
prefetchable memory (256MB) */
> +	};
> +
> +	pcie@14140000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
> +		reg =3D <0x00 0x14140000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x34000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x34040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x34080000 0x0 0x00040000>; /* DBI reg space (256K)       =
*/
> +		reg-names =3D "appl", "config", "atu_dma", "dbi";
> +
> +		status =3D "disabled";
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		device_type =3D "pci";
> +		num-lanes =3D <1>;
> +		num-viewport =3D <8>;
> +		linux,pci-domain =3D <3>;
> +
> +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_3>;
> +		clock-names =3D "core";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_3_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_3>;
> +		reset-names =3D "apb", "core";
> +
> +		interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,	/* controller interru=
pt */
> +			     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> +		interrupt-names =3D "intr", "msi";
> +
> +		#interrupt-cells =3D <1>;
> +		interrupt-map-mask =3D <0 0 0 0>;
> +		interrupt-map =3D <0 0 0 0 &gic GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		nvidia,bpmp =3D <&bpmp 3>;
> +
> +		supports-clkreq;
> +		nvidia,aspm-cmrt-us =3D <60>;
> +		nvidia,aspm-pwr-on-t-us =3D <20>;
> +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0  0x34100000 0x0  0x34100000 0x0 0x00100000 =
  /* downstream I/O (1MB) */
> +			  0xc2000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000   /* pref=
etchable memory (768MB) */
> +			  0x82000000 0x0  0x40000000 0x12 0xb0000000 0x0 0x10000000>; /* non-=
prefetchable memory (256MB) */
> +	};
> +
> +	pcie@14160000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX4A>;
> +		reg =3D <0x00 0x14160000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x36000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x36040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x36080000 0x0 0x00040000>; /* DBI reg space (256K)       =
*/
> +		reg-names =3D "appl", "config", "atu_dma", "dbi";
> +
> +		status =3D "disabled";
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		device_type =3D "pci";
> +		num-lanes =3D <4>;
> +		num-viewport =3D <8>;
> +		linux,pci-domain =3D <4>;
> +
> +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_4>;
> +		clock-names =3D "core";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_4_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_4>;
> +		reset-names =3D "apb", "core";
> +
> +		interrupts =3D <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,	/* controller interru=
pt */
> +			     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> +		interrupt-names =3D "intr", "msi";
> +
> +		#interrupt-cells =3D <1>;
> +		interrupt-map-mask =3D <0 0 0 0>;
> +		interrupt-map =3D <0 0 0 0 &gic GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		nvidia,bpmp =3D <&bpmp 4>;
> +
> +		supports-clkreq;
> +		nvidia,aspm-cmrt-us =3D <60>;
> +		nvidia,aspm-pwr-on-t-us =3D <20>;
> +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0  0x36100000 0x0  0x36100000 0x0 0x00100000 =
  /* downstream I/O (1MB) */
> +			  0xc2000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000   /* pref=
etchable memory (13GB) */
> +			  0x82000000 0x0  0x40000000 0x17 0x40000000 0x0 0xc0000000>; /* non-=
prefetchable memory (3GB) */
> +	};
> +
> +	pcie@14180000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
> +		reg =3D <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x38040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x38080000 0x0 0x00040000>; /* DBI reg space (256K)       =
*/
> +		reg-names =3D "appl", "config", "atu_dma", "dbi";
> +
> +		status =3D "disabled";
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		device_type =3D "pci";
> +		num-lanes =3D <8>;
> +		num-viewport =3D <8>;
> +		linux,pci-domain =3D <0>;
> +
> +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
> +		clock-names =3D "core";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
> +		reset-names =3D "apb", "core";
> +
> +		interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,	/* controller interru=
pt */
> +			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> +		interrupt-names =3D "intr", "msi";
> +
> +		#interrupt-cells =3D <1>;
> +		interrupt-map-mask =3D <0 0 0 0>;
> +		interrupt-map =3D <0 0 0 0 &gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		nvidia,bpmp =3D <&bpmp 0>;
> +
> +		supports-clkreq;
> +		nvidia,aspm-cmrt-us =3D <60>;
> +		nvidia,aspm-pwr-on-t-us =3D <20>;
> +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0  0x38100000 0x0  0x38100000 0x0 0x00100000 =
  /* downstream I/O (1MB) */
> +			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000   /* pref=
etchable memory (13GB) */
> +			  0x82000000 0x0  0x40000000 0x1b 0x40000000 0x0 0xc0000000>; /* non-=
prefetchable memory (3GB) */
> +	};
> +
> +	pcie@141a0000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
> +		reg =3D <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x3a000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  =
*/
> +		       0x00 0x3a080000 0x0 0x00040000>; /* DBI reg space (256K)       =
*/
> +		reg-names =3D "appl", "config", "atu_dma", "dbi";
> +
> +		status =3D "disabled";
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		device_type =3D "pci";
> +		num-lanes =3D <8>;
> +		num-viewport =3D <8>;
> +		linux,pci-domain =3D <5>;
> +
> +		clocks =3D <&bpmp TEGRA194_CLK_PEX1_CORE_5>,
> +			<&bpmp TEGRA194_CLK_PEX1_CORE_5M>;
> +		clock-names =3D "core", "core_m";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
> +		reset-names =3D "apb", "core";
> +
> +		interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,	/* controller interru=
pt */
> +			     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> +		interrupt-names =3D "intr", "msi";
> +
> +		nvidia,bpmp =3D <&bpmp 5>;
> +
> +		#interrupt-cells =3D <1>;
> +		interrupt-map-mask =3D <0 0 0 0>;
> +		interrupt-map =3D <0 0 0 0 &gic GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> +
> +		supports-clkreq;
> +		nvidia,aspm-cmrt-us =3D <60>;
> +		nvidia,aspm-pwr-on-t-us =3D <20>;
> +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0  0x3a100000 0x0  0x3a100000 0x0 0x00100000 =
  /* downstream I/O (1MB) */
> +			  0xc2000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000   /* pref=
etchable memory (13GB) */
> +			  0x82000000 0x0  0x40000000 0x1f 0x40000000 0x0 0xc0000000>; /* non-=
prefetchable memory (3GB) */
> +	};
>  };
> --=20
> 2.17.1
>=20

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0LZggACgkQ3SOs138+
s6GwZxAAq5W6zJdxJRSieZ+uENXBhZuCsPNWd0HeuWsr1WP8Yyr8Gj48Lr6hRTQn
nJOLOs1YyKLq7m6q2bIdMU+NDVRPqb1+A0Eu/lCWgVloaErSpL05sRr+xxmkoEdh
3bL6lhUJWAw3kX+V0ZaNJ5exT8K8IKphqHp9wZdFhsb6NNUgJ9QgxhjOHSg5INHP
DyquKdeMqZam5tq5j0kyzXZgqD7gFmHVEZNRmwo0uVt6+2OmNaXRvK0lWPOXjZjE
IFbQJTUs60feyvz0G4NFYCdVfE3+5BUutVIOXsHg0HLpIJ7hS6UOz2iLvZrpB/Ce
WrEcp03fzXoh3FQ5EiaAHmwmgx79crVxflfjeu4LcGqNnnxvtVX3Hk9aJWcPWDcz
+3oxhyPZtMIHsG/klT3YMxJ855/U4MoiRUUReUaOdQGGirJpnvF0PqW3eNVjw+NW
tCxqO1yo8cUy9yvduG/9k3V1JPxPRZEwxVE2EeH02Cdv54zVIGrtmpeEJD5J+0k1
Hu67piaXkhDThr3ALxJa2hACoprCE9DofSju2ZREPNMI1N3tQl/RzotpFgpAaWNE
6CVf7Xx9O+HRbCvxmhMVZbRyiHx1yH4gp3/CCRpb6RmE6ulaTqovlDWo4cMpPQaB
v0aPahCfjZFO5uLGiacKw9liXSUk9mnxlW3DbbMSQYezri3p2KU=
=Lsn4
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
