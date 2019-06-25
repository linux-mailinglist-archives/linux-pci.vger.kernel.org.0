Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCDE524DD
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 09:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbfFYHdR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 03:33:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50310 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727813AbfFYHdR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2019 03:33:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id c66so1716198wmf.0;
        Tue, 25 Jun 2019 00:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4L8jWpgpRoRFlWj8KS2xl7Z08afaUsYJAa3YKcB1ch4=;
        b=rIPjFWyRu2kk6+mcHZkPmumdbKRzCNEN1YWuQc3fGGs+QyFhNhW4F59mtx85xomKTA
         kvyK9xwOFskKduSHJV0kpdyyoOhvG3zP6D38kTbKG6jK0BHrHBm7Oj4Rb6OcONAeONl2
         7ktOf5/yQznqmOB4YdIYjr5fc/d3+9RTUJTU1qPB8Fdl0pSqqL1a0FM2JzVdKKMOEQCK
         HNBV7ornDFoOW8aTpQxeT+AbpwXFFMOw7luafQ25Jwppkf2yv9/af84aM0Ju0CfJieoQ
         kqOZ6iAINZmbn3fJmLaUtk7OAGv+eg+Eaiz/08Q9jDsm+gaBdVm5eavgrZzvhy9xJRev
         dCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4L8jWpgpRoRFlWj8KS2xl7Z08afaUsYJAa3YKcB1ch4=;
        b=NZLAFueNfBJAjdLvfZR5TWDyDJfronWCtiBXFnWuDs+IXeRLaCEUiNUFQJN3uqvHPn
         F8gwMIzssz74Ztscv1UeCdetcl34AU6zloY6oFDJXrenSy6aqx15zHvB6Bp/IEIqydbz
         lUzvp16YcM8lWhQPEEsoljFIu7SXT0968T+tC226VjFhsgzB5UxP1KBInYBMAv9rauNv
         FOjU8UjxGa65qsdmPbyr78PIZ+yIyb9V8ukjS3h8IEWozBt9s/WxeadiVQr4h4XpW1Wx
         PVxjtasVqjN7/JGzV5oM02wPTtyWAi0hKb4TnWT+JbnjB/LUL+WTVU/JS83v6+l9NRAf
         MVuw==
X-Gm-Message-State: APjAAAXq7O+KlXDd74IgoVBetn4+8G3P4p8Lh62f7/iZlI3CEnCtHxfY
        kPTNxcmdmWwHChuc3n00Tdo=
X-Google-Smtp-Source: APXvYqwV2rtrF92xMKWhxZG9GLTn1JdtlWyF2OB2EVpYGW0pj8to/Dp62dRF5qehpxJ1Z/iB+MAguQ==
X-Received: by 2002:a1c:be05:: with SMTP id o5mr1460743wmf.52.1561447992329;
        Tue, 25 Jun 2019 00:33:12 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id y6sm1750279wmd.16.2019.06.25.00.33.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 00:33:11 -0700 (PDT)
Date:   Tue, 25 Jun 2019 09:33:10 +0200
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
Message-ID: <20190625073310.GA1516@ulmo>
References: <20190612095339.20118-1-vidyas@nvidia.com>
 <20190612095339.20118-12-vidyas@nvidia.com>
 <20190620105525.GA15892@ulmo>
 <a3c4e151-9fd3-9368-1498-b8f225da62d9@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <a3c4e151-9fd3-9368-1498-b8f225da62d9@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2019 at 01:02:06PM +0530, Vidya Sagar wrote:
> On 6/20/2019 4:25 PM, Thierry Reding wrote:
> > On Wed, Jun 12, 2019 at 03:23:35PM +0530, Vidya Sagar wrote:
> > > Add P2U (PIPE to UPHY) and PCIe controller nodes to device tree.
> > > The Tegra194 SoC contains six PCIe controllers and twenty P2U instanc=
es
> > > grouped into two different PHY bricks namely High-Speed IO (HSIO-12 P=
2Us)
> > > and NVIDIA High Speed (NVHS-8 P2Us) respectively.
> > >=20
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > ---
> > > Changes since [v9]:
> > > * None
> > >=20
> > > Changes since [v8]:
> > > * None
> > >=20
> > > Changes since [v7]:
> > > * Replaced 'core_apb' with 'apb' in reset names
> > > * Used macros instead of hardcoded numbers in 'interrupt-map' property
> > > * Aligned 'ranges' entries
> > >=20
> > > Changes since [v6]:
> > > * Removed properties "nvidia,disable-aspm-states" & "nvidia,controlle=
r-id".
> > > * Modified property "nvidia,bpmp" to include controller-id as well.
> > >=20
> > > Changes since [v5]:
> > > * Changes 'p2u@xxxxxxxx' to 'phy@xxxxxxxx'
> > > * Arranged all PCIe nodes in the order of their addresses
> > >=20
> > > Changes since [v4]:
> > > * None
> > >=20
> > > Changes since [v3]:
> > > * None
> > >=20
> > > Changes since [v2]:
> > > * Included 'hsio' or 'nvhs' in P2U node's label names to reflect whic=
h brick
> > >    they belong to
> > > * Removed leading zeros in unit address
> > >=20
> > > Changes since [v1]:
> > > * Flattened all P2U nodes by removing 'hsio-p2u' and 'nvhs-p2u' super=
 nodes
> > > * Changed P2U nodes compatible string from 'nvidia,tegra194-phy-p2u' =
to 'nvidia,tegra194-p2u'
> > > * Changed reg-name from 'base' to 'ctl'
> > > * Updated all PCIe nodes according to the changes made to DT document=
ation file
> > >=20
> > >   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 437 ++++++++++++++++++++=
+++
> > >   1 file changed, 437 insertions(+)
> >=20
> > Applied to for-5.3/arm64/dt, thanks.
> >=20
> > I did end up sorting the new nodes differently so that they are ordered
> > according to the general rules (sort by unit-address, then
> > alphabetically). That's slightly complicated by the fact that the PCI
> > controllers have registers that seem to be right in the middle of the
> > host1x aperture, so I had to bend the rules a little.
> >=20
> > Thierry
>=20
> I see that you moved all PCIe nodes under CBB node. There is an issue wit=
h that.
> PCIe nodes have apertures defined in both 32-bit region and 64-bit region=
 which
> are mentioned through "ranges" property. Apertures defined in 64-bit regi=
on do not
> fit within "ranges" defined for CBB region which can handle only 32-bit "=
ranges" of
> CBB sub-nodes and ends @ 0x40000000. It is because of this reason that I =
kept PCIe
> nodes outside of CBB master node. Do you agree with my understanding? If =
yes, can
> you please move PCIe nodes out of CBB node? (Also in platform dts file)

Yeah, I noticed this discrepancy while doing the final builds and before
pushing things out. I think the problem here is that we restricted the
CBB region to #address-cells =3D <1> where it really should've been 2
cells for the addresses given the size of the addressable region. I've
reverted my changes for now, but I think eventually we'll want to adjust
CBB to be #address-cells =3D <2> and maybe even #size-cells =3D <2> to take
into account the PCIe ranges.

Another possibility might be that PCI is actually on a different "bus"
(i.e. not CBB) in which case it'd be best to model that. But the TRM is
not very clear about the bus hierarchy.

Thierry

>=20
> Thanks,
> Vidya Sagar
>=20
> >=20
> > > diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/bo=
ot/dts/nvidia/tegra194.dtsi
> > > index c77ca211fa8f..feba034f26f0 100644
> > > --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> > > +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> > > @@ -884,6 +884,166 @@
> > >   				nvidia,interface =3D <3>;
> > >   			};
> > >   		};
> > > +
> > > +		p2u_hsio_0: phy@3e10000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03e10000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_hsio_1: phy@3e20000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03e20000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_hsio_2: phy@3e30000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03e30000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_hsio_3: phy@3e40000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03e40000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_hsio_4: phy@3e50000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03e50000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_hsio_5: phy@3e60000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03e60000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_hsio_6: phy@3e70000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03e70000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_hsio_7: phy@3e80000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03e80000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_hsio_8: phy@3e90000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03e90000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_hsio_9: phy@3ea0000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03ea0000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_nvhs_0: phy@3eb0000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03eb0000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_nvhs_1: phy@3ec0000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03ec0000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_nvhs_2: phy@3ed0000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03ed0000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_nvhs_3: phy@3ee0000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03ee0000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_nvhs_4: phy@3ef0000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03ef0000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_nvhs_5: phy@3f00000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03f00000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_nvhs_6: phy@3f10000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03f10000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_nvhs_7: phy@3f20000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03f20000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_hsio_10: phy@3f30000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03f30000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > > +
> > > +		p2u_hsio_11: phy@3f40000 {
> > > +			compatible =3D "nvidia,tegra194-p2u";
> > > +			reg =3D <0x03f40000 0x10000>;
> > > +			reg-names =3D "ctl";
> > > +
> > > +			#phy-cells =3D <0>;
> > > +		};
> > >   	};
> > >   	sysram@40000000 {
> > > @@ -1054,4 +1214,281 @@
> > >   				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> > >   		interrupt-parent =3D <&gic>;
> > >   	};
> > > +
> > > +	pcie@14100000 {
> > > +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> > > +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
> > > +		reg =3D <0x00 0x14100000 0x0 0x00020000   /* appl registers (128K)=
      */
> > > +		       0x00 0x30000000 0x0 0x00040000   /* configuration space (25=
6K) */
> > > +		       0x00 0x30040000 0x0 0x00040000   /* iATU_DMA reg space (256=
K)  */
> > > +		       0x00 0x30080000 0x0 0x00040000>; /* DBI reg space (256K)   =
    */
> > > +		reg-names =3D "appl", "config", "atu_dma", "dbi";
> > > +
> > > +		status =3D "disabled";
> > > +
> > > +		#address-cells =3D <3>;
> > > +		#size-cells =3D <2>;
> > > +		device_type =3D "pci";
> > > +		num-lanes =3D <1>;
> > > +		num-viewport =3D <8>;
> > > +		linux,pci-domain =3D <1>;
> > > +
> > > +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_1>;
> > > +		clock-names =3D "core";
> > > +
> > > +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_1_APB>,
> > > +			 <&bpmp TEGRA194_RESET_PEX0_CORE_1>;
> > > +		reset-names =3D "apb", "core";
> > > +
> > > +		interrupts =3D <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,	/* controller int=
errupt */
> > > +			     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> > > +		interrupt-names =3D "intr", "msi";
> > > +
> > > +		#interrupt-cells =3D <1>;
> > > +		interrupt-map-mask =3D <0 0 0 0>;
> > > +		interrupt-map =3D <0 0 0 0 &gic GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +		nvidia,bpmp =3D <&bpmp 1>;
> > > +
> > > +		supports-clkreq;
> > > +		nvidia,aspm-cmrt-us =3D <60>;
> > > +		nvidia,aspm-pwr-on-t-us =3D <20>;
> > > +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> > > +
> > > +		bus-range =3D <0x0 0xff>;
> > > +		ranges =3D <0x81000000 0x0  0x30100000 0x0  0x30100000 0x0 0x00100=
000   /* downstream I/O (1MB) */
> > > +			  0xc2000000 0x12 0x00000000 0x12 0x00000000 0x0 0x30000000   /* =
prefetchable memory (768MB) */
> > > +			  0x82000000 0x0  0x40000000 0x12 0x30000000 0x0 0x10000000>; /* =
non-prefetchable memory (256MB) */
> > > +	};
> > > +
> > > +	pcie@14120000 {
> > > +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> > > +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
> > > +		reg =3D <0x00 0x14120000 0x0 0x00020000   /* appl registers (128K)=
      */
> > > +		       0x00 0x32000000 0x0 0x00040000   /* configuration space (25=
6K) */
> > > +		       0x00 0x32040000 0x0 0x00040000   /* iATU_DMA reg space (256=
K)  */
> > > +		       0x00 0x32080000 0x0 0x00040000>; /* DBI reg space (256K)   =
    */
> > > +		reg-names =3D "appl", "config", "atu_dma", "dbi";
> > > +
> > > +		status =3D "disabled";
> > > +
> > > +		#address-cells =3D <3>;
> > > +		#size-cells =3D <2>;
> > > +		device_type =3D "pci";
> > > +		num-lanes =3D <1>;
> > > +		num-viewport =3D <8>;
> > > +		linux,pci-domain =3D <2>;
> > > +
> > > +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_2>;
> > > +		clock-names =3D "core";
> > > +
> > > +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_2_APB>,
> > > +			 <&bpmp TEGRA194_RESET_PEX0_CORE_2>;
> > > +		reset-names =3D "apb", "core";
> > > +
> > > +		interrupts =3D <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>,	/* controller int=
errupt */
> > > +			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> > > +		interrupt-names =3D "intr", "msi";
> > > +
> > > +		#interrupt-cells =3D <1>;
> > > +		interrupt-map-mask =3D <0 0 0 0>;
> > > +		interrupt-map =3D <0 0 0 0 &gic GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +		nvidia,bpmp =3D <&bpmp 2>;
> > > +
> > > +		supports-clkreq;
> > > +		nvidia,aspm-cmrt-us =3D <60>;
> > > +		nvidia,aspm-pwr-on-t-us =3D <20>;
> > > +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> > > +
> > > +		bus-range =3D <0x0 0xff>;
> > > +		ranges =3D <0x81000000 0x0  0x32100000 0x0  0x32100000 0x0 0x00100=
000   /* downstream I/O (1MB) */
> > > +			  0xc2000000 0x12 0x40000000 0x12 0x40000000 0x0 0x30000000   /* =
prefetchable memory (768MB) */
> > > +			  0x82000000 0x0  0x40000000 0x12 0x70000000 0x0 0x10000000>; /* =
non-prefetchable memory (256MB) */
> > > +	};
> > > +
> > > +	pcie@14140000 {
> > > +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> > > +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX1A>;
> > > +		reg =3D <0x00 0x14140000 0x0 0x00020000   /* appl registers (128K)=
      */
> > > +		       0x00 0x34000000 0x0 0x00040000   /* configuration space (25=
6K) */
> > > +		       0x00 0x34040000 0x0 0x00040000   /* iATU_DMA reg space (256=
K)  */
> > > +		       0x00 0x34080000 0x0 0x00040000>; /* DBI reg space (256K)   =
    */
> > > +		reg-names =3D "appl", "config", "atu_dma", "dbi";
> > > +
> > > +		status =3D "disabled";
> > > +
> > > +		#address-cells =3D <3>;
> > > +		#size-cells =3D <2>;
> > > +		device_type =3D "pci";
> > > +		num-lanes =3D <1>;
> > > +		num-viewport =3D <8>;
> > > +		linux,pci-domain =3D <3>;
> > > +
> > > +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_3>;
> > > +		clock-names =3D "core";
> > > +
> > > +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_3_APB>,
> > > +			 <&bpmp TEGRA194_RESET_PEX0_CORE_3>;
> > > +		reset-names =3D "apb", "core";
> > > +
> > > +		interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,	/* controller int=
errupt */
> > > +			     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> > > +		interrupt-names =3D "intr", "msi";
> > > +
> > > +		#interrupt-cells =3D <1>;
> > > +		interrupt-map-mask =3D <0 0 0 0>;
> > > +		interrupt-map =3D <0 0 0 0 &gic GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +		nvidia,bpmp =3D <&bpmp 3>;
> > > +
> > > +		supports-clkreq;
> > > +		nvidia,aspm-cmrt-us =3D <60>;
> > > +		nvidia,aspm-pwr-on-t-us =3D <20>;
> > > +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> > > +
> > > +		bus-range =3D <0x0 0xff>;
> > > +		ranges =3D <0x81000000 0x0  0x34100000 0x0  0x34100000 0x0 0x00100=
000   /* downstream I/O (1MB) */
> > > +			  0xc2000000 0x12 0x80000000 0x12 0x80000000 0x0 0x30000000   /* =
prefetchable memory (768MB) */
> > > +			  0x82000000 0x0  0x40000000 0x12 0xb0000000 0x0 0x10000000>; /* =
non-prefetchable memory (256MB) */
> > > +	};
> > > +
> > > +	pcie@14160000 {
> > > +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> > > +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX4A>;
> > > +		reg =3D <0x00 0x14160000 0x0 0x00020000   /* appl registers (128K)=
      */
> > > +		       0x00 0x36000000 0x0 0x00040000   /* configuration space (25=
6K) */
> > > +		       0x00 0x36040000 0x0 0x00040000   /* iATU_DMA reg space (256=
K)  */
> > > +		       0x00 0x36080000 0x0 0x00040000>; /* DBI reg space (256K)   =
    */
> > > +		reg-names =3D "appl", "config", "atu_dma", "dbi";
> > > +
> > > +		status =3D "disabled";
> > > +
> > > +		#address-cells =3D <3>;
> > > +		#size-cells =3D <2>;
> > > +		device_type =3D "pci";
> > > +		num-lanes =3D <4>;
> > > +		num-viewport =3D <8>;
> > > +		linux,pci-domain =3D <4>;
> > > +
> > > +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_4>;
> > > +		clock-names =3D "core";
> > > +
> > > +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_4_APB>,
> > > +			 <&bpmp TEGRA194_RESET_PEX0_CORE_4>;
> > > +		reset-names =3D "apb", "core";
> > > +
> > > +		interrupts =3D <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,	/* controller int=
errupt */
> > > +			     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> > > +		interrupt-names =3D "intr", "msi";
> > > +
> > > +		#interrupt-cells =3D <1>;
> > > +		interrupt-map-mask =3D <0 0 0 0>;
> > > +		interrupt-map =3D <0 0 0 0 &gic GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +		nvidia,bpmp =3D <&bpmp 4>;
> > > +
> > > +		supports-clkreq;
> > > +		nvidia,aspm-cmrt-us =3D <60>;
> > > +		nvidia,aspm-pwr-on-t-us =3D <20>;
> > > +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> > > +
> > > +		bus-range =3D <0x0 0xff>;
> > > +		ranges =3D <0x81000000 0x0  0x36100000 0x0  0x36100000 0x0 0x00100=
000   /* downstream I/O (1MB) */
> > > +			  0xc2000000 0x14 0x00000000 0x14 0x00000000 0x3 0x40000000   /* =
prefetchable memory (13GB) */
> > > +			  0x82000000 0x0  0x40000000 0x17 0x40000000 0x0 0xc0000000>; /* =
non-prefetchable memory (3GB) */
> > > +	};
> > > +
> > > +	pcie@14180000 {
> > > +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> > > +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
> > > +		reg =3D <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)=
      */
> > > +		       0x00 0x38000000 0x0 0x00040000   /* configuration space (25=
6K) */
> > > +		       0x00 0x38040000 0x0 0x00040000   /* iATU_DMA reg space (256=
K)  */
> > > +		       0x00 0x38080000 0x0 0x00040000>; /* DBI reg space (256K)   =
    */
> > > +		reg-names =3D "appl", "config", "atu_dma", "dbi";
> > > +
> > > +		status =3D "disabled";
> > > +
> > > +		#address-cells =3D <3>;
> > > +		#size-cells =3D <2>;
> > > +		device_type =3D "pci";
> > > +		num-lanes =3D <8>;
> > > +		num-viewport =3D <8>;
> > > +		linux,pci-domain =3D <0>;
> > > +
> > > +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
> > > +		clock-names =3D "core";
> > > +
> > > +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
> > > +			 <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
> > > +		reset-names =3D "apb", "core";
> > > +
> > > +		interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,	/* controller int=
errupt */
> > > +			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> > > +		interrupt-names =3D "intr", "msi";
> > > +
> > > +		#interrupt-cells =3D <1>;
> > > +		interrupt-map-mask =3D <0 0 0 0>;
> > > +		interrupt-map =3D <0 0 0 0 &gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +		nvidia,bpmp =3D <&bpmp 0>;
> > > +
> > > +		supports-clkreq;
> > > +		nvidia,aspm-cmrt-us =3D <60>;
> > > +		nvidia,aspm-pwr-on-t-us =3D <20>;
> > > +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> > > +
> > > +		bus-range =3D <0x0 0xff>;
> > > +		ranges =3D <0x81000000 0x0  0x38100000 0x0  0x38100000 0x0 0x00100=
000   /* downstream I/O (1MB) */
> > > +			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x3 0x40000000   /* =
prefetchable memory (13GB) */
> > > +			  0x82000000 0x0  0x40000000 0x1b 0x40000000 0x0 0xc0000000>; /* =
non-prefetchable memory (3GB) */
> > > +	};
> > > +
> > > +	pcie@141a0000 {
> > > +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> > > +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
> > > +		reg =3D <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)=
      */
> > > +		       0x00 0x3a000000 0x0 0x00040000   /* configuration space (25=
6K) */
> > > +		       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256=
K)  */
> > > +		       0x00 0x3a080000 0x0 0x00040000>; /* DBI reg space (256K)   =
    */
> > > +		reg-names =3D "appl", "config", "atu_dma", "dbi";
> > > +
> > > +		status =3D "disabled";
> > > +
> > > +		#address-cells =3D <3>;
> > > +		#size-cells =3D <2>;
> > > +		device_type =3D "pci";
> > > +		num-lanes =3D <8>;
> > > +		num-viewport =3D <8>;
> > > +		linux,pci-domain =3D <5>;
> > > +
> > > +		clocks =3D <&bpmp TEGRA194_CLK_PEX1_CORE_5>,
> > > +			<&bpmp TEGRA194_CLK_PEX1_CORE_5M>;
> > > +		clock-names =3D "core", "core_m";
> > > +
> > > +		resets =3D <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
> > > +			 <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
> > > +		reset-names =3D "apb", "core";
> > > +
> > > +		interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,	/* controller int=
errupt */
> > > +			     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> > > +		interrupt-names =3D "intr", "msi";
> > > +
> > > +		nvidia,bpmp =3D <&bpmp 5>;
> > > +
> > > +		#interrupt-cells =3D <1>;
> > > +		interrupt-map-mask =3D <0 0 0 0>;
> > > +		interrupt-map =3D <0 0 0 0 &gic GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> > > +
> > > +		supports-clkreq;
> > > +		nvidia,aspm-cmrt-us =3D <60>;
> > > +		nvidia,aspm-pwr-on-t-us =3D <20>;
> > > +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> > > +
> > > +		bus-range =3D <0x0 0xff>;
> > > +		ranges =3D <0x81000000 0x0  0x3a100000 0x0  0x3a100000 0x0 0x00100=
000   /* downstream I/O (1MB) */
> > > +			  0xc2000000 0x1c 0x00000000 0x1c 0x00000000 0x3 0x40000000   /* =
prefetchable memory (13GB) */
> > > +			  0x82000000 0x0  0x40000000 0x1f 0x40000000 0x0 0xc0000000>; /* =
non-prefetchable memory (3GB) */
> > > +	};
> > >   };
> > > --=20
> > > 2.17.1
> > >=20
>=20

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0RzjUACgkQ3SOs138+
s6EEyg/7BJPYgJNxpVpRxw4T2GOAYfa6SvKjYjgVwKz64lCOs9ob5AVZVvb1AMbk
ArxbHhFVDmKyC3wRDR+xGRETaKiTHbUGzJjjNVTYRREWbnmQVEzZnUITCiZDQIbr
MEC4wM1qsIEDeH4p9SXhhvTshZBciJSFK/PCuK8A7LOND5XnzZYG4c4kYd2K6XmA
K1P0UgGwXukwkhkmWqJrejGQfkqoWW3ZeQB/LIkSe39vZ6cVJyNSgqfuhAMERWOk
NNdyKDe3vjAfkyKlNUHvp1oVeDfApldczUSaU0eN6SJ2Xja7Iq1W4rOjybI0WwrY
wwoWCEoSQ5xXZqjwbGhqNOIVk6UycK/oNei6mtwjCYbulnYCsvMV1y42/OSz7HfR
OOX/unuiDFFBf0aajf33wE0PgdUmflBPHZLJFZ8p0/BA3R3506cIhM3hrO8rkE/W
g6SkuOSubDoYQ892ZXkAGCX66fO9q/2bJdMWy6aE7ptVRXg9Bm5CuEZz12c1YVHa
1tIx9mQD0nHAaeZ2YfZAG56Awn9q6uhwuWuw7SAVovpRtU5q1VRzkrmRZ1m7KpL0
pDXHEi5kOKWLqA1Z4kpwuoOGLFajUCglYQ7bjQ3DJzCoh9ehA9EgfW8Zg6exKfeH
oBcZh0lEiyuPn5RxzjAByNAot444n0k2xles1LxNWBGaTW/meQs=
=wjcX
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
