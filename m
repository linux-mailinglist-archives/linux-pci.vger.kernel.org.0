Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6306124D31
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2019 12:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfEUKwB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 May 2019 06:52:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52393 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEUKwB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 May 2019 06:52:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id y3so2481290wmm.2;
        Tue, 21 May 2019 03:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HBcDMKCLoxH9JY160lWGF8D+AoJf2h9sY0HtKRx1ARI=;
        b=Gk8AMrS6UzHlFPo2QVg1y3zeVjWzbW2RZ659opvhClCtlY8/k6aYWj/M8yDixP4yxX
         cKj8keaIu3Eb8nfEyQNP4cMIqlcqpz6I9CopYT4b8haSqbRXpI3FdIEwWMqhO5cKEbxF
         MEm5ZCVOzRDcmGfRRrgaYuMwl2Z6M5+0ZKveNxtSRcNDQAaXsUUKtU3Q29KJvQParRKG
         AGcXRV8fA6vVVNTk7P60iMvG5htvzWWEmkjy4uUQDPRLWGgQR76mcPY7mwJKXqQBwGP4
         2fAHNuJpVLR7ZapVHPEfq2C7MgZEPSztQnscyeSn1tDgpbU/IHP7JV0XWz473rdNIq7U
         eKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HBcDMKCLoxH9JY160lWGF8D+AoJf2h9sY0HtKRx1ARI=;
        b=nvg+9zV712YUoRKEmXIveGSy7TODV+B6gEAqHLZB2QzKA0r/sgyyJkk+x6CkaKskRF
         GyIKETOAQ9Sshs/5fSS7WCCHBI/60IPMZA9Ju/FhFfbrRccr87otMozLvgqwP7w6F7gM
         6KPyhMBYhwQmIICphNvX//9spguv4xfDvfDJ58GKeZE8mQmk6hDXn7vUFAVDEVndL7gs
         rW0WTZF88NhwZaC4LYIR44imwui5JJ1pYTwOIIO6NUg5u7aR9htJgCwTFMlWxQTW5aLw
         JNx3Pdqe/4kBc/b6K1uApIxF9FRin22f7QgNhO7e/zMMU6BYt+5CXd9Uh1ULl1+A/ZjR
         QxYg==
X-Gm-Message-State: APjAAAXt0bsWorB9H2XHFEYaeggXisjcFC3w8meKgP81dVGh8FbxBD3r
        ZD2Laq1Sn539/Ig4xhkRjWA=
X-Google-Smtp-Source: APXvYqzQ9NR+3sx3iS2dl05Sv1JlhuBHyb/XnFrcv32mSv4hkJ962qmqmBdC4mZgy+TkXS2DEuEQYQ==
X-Received: by 2002:a1c:c1c8:: with SMTP id r191mr2624904wmf.99.1558435917381;
        Tue, 21 May 2019 03:51:57 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id x187sm3098357wmg.11.2019.05.21.03.51.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 03:51:56 -0700 (PDT)
Date:   Tue, 21 May 2019 12:51:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, kishon@ti.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mperttunen@nvidia.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V7 09/15] dt-bindings: PCI: tegra: Add device tree
 support for Tegra194
Message-ID: <20190521105155.GI29166@ulmo>
References: <20190517123846.3708-1-vidyas@nvidia.com>
 <20190517123846.3708-10-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YrQNB5Deg1WGKZi3"
Content-Disposition: inline
In-Reply-To: <20190517123846.3708-10-vidyas@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--YrQNB5Deg1WGKZi3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2019 at 06:08:40PM +0530, Vidya Sagar wrote:
> Add support for Tegra194 PCIe controllers. These controllers are based
> on Synopsys DesignWare core IP.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes since [v6]:
> * Changed description of the property "nvidia,bpmp".
> * Removed property "nvidia,disable-aspm-states".
>=20
> Changes since [v5]:
> * Removed 'max-link-speed' as it is going to be a common sub-system prope=
rty
> * Removed 'nvidia,init-link-speed' as there isn't much value addition
> * Removed 'nvidia,wake-gpios' for now
> * Addressed review comments from Thierry and Rob in general
>=20
> Changes since [v4]:
> * None
>=20
> Changes since [v3]:
> * None
>=20
> Changes since [v2]:
> * Using only 'Cx' (x-being controller number) format to represent a contr=
oller
> * Changed to 'value: description' format where applicable
> * Changed 'nvidia,init-speed' to 'nvidia,init-link-speed'
> * Provided more documentation for 'nvidia,init-link-speed' property
> * Changed 'nvidia,pex-wake' to 'nvidia,wake-gpios'
>=20
> Changes since [v1]:
> * Added documentation for 'power-domains' property
> * Removed 'window1' and 'window2' properties
> * Removed '_clk' and '_rst' from clock and reset names
> * Dropped 'pcie' from phy-names
> * Added entry for BPMP-FW handle
> * Removed offsets for some of the registers and added them in code and wo=
uld be pickedup based on
>   controller ID
> * Changed 'nvidia,max-speed' to 'max-link-speed' and is made as an option=
al
> * Changed 'nvidia,disable-clock-request' to 'supports-clkreq' with invert=
ed operation
> * Added more documentation for 'nvidia,update-fc-fixup' property
> * Removed 'nvidia,enable-power-down' and 'nvidia,plat-gpios' properties
> * Added '-us' to all properties that represent time in microseconds
> * Moved P2U documentation to a separate file
>=20
>  .../bindings/pci/nvidia,tegra194-pcie.txt     | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194=
-pcie.txt
>=20
> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.t=
xt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
> new file mode 100644
> index 000000000000..0119f40bbd11
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
> @@ -0,0 +1,158 @@
> +NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
> +
> +This PCIe host controller is based on the Synopsis Designware PCIe IP
> +and thus inherits all the common properties defined in designware-pcie.t=
xt.
> +
> +Required properties:
> +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
> +- device_type: Must be "pci"
> +- power-domains: A phandle to the node that controls power to the respec=
tive
> +  PCIe controller and a specifier name for the PCIe controller. Followin=
g are
> +  the specifiers for the different PCIe controllers
> +    TEGRA194_POWER_DOMAIN_PCIEX8B: C0
> +    TEGRA194_POWER_DOMAIN_PCIEX1A: C1
> +    TEGRA194_POWER_DOMAIN_PCIEX1A: C2
> +    TEGRA194_POWER_DOMAIN_PCIEX1A: C3
> +    TEGRA194_POWER_DOMAIN_PCIEX4A: C4
> +    TEGRA194_POWER_DOMAIN_PCIEX8A: C5
> +  these specifiers are defined in
> +  "include/dt-bindings/power/tegra194-powergate.h" file.
> +- reg: A list of physical base address and length pairs for each set of
> +  controller registers. Must contain an entry for each entry in the reg-=
names
> +  property.
> +- reg-names: Must include the following entries:
> +  "appl": Controller's application logic registers
> +  "config": As per the definition in designware-pcie.txt
> +  "atu_dma": iATU and DMA registers. This is where the iATU (internal Ad=
dress
> +             Translation Unit) registers of the PCIe core are made avail=
able
> +             for SW access.
> +  "dbi": The aperture where root port's own configuration registers are
> +         available
> +- interrupts: A list of interrupt outputs of the controller. Must contai=
n an
> +  entry for each entry in the interrupt-names property.
> +- interrupt-names: Must include the following entries:
> +  "intr": The Tegra interrupt that is asserted for controller interrupts
> +  "msi": The Tegra interrupt that is asserted when an MSI is received
> +- bus-range: Range of bus numbers associated with this controller
> +- #address-cells: Address representation for root ports (must be 3)
> +  - cell 0 specifies the bus and device numbers of the root port:
> +    [23:16]: bus number
> +    [15:11]: device number
> +  - cell 1 denotes the upper 32 address bits and should be 0
> +  - cell 2 contains the lower 32 address bits and is used to translate t=
o the
> +    CPU address space
> +- #size-cells: Size representation for root ports (must be 2)
> +- ranges: Describes the translation of addresses for root ports and stan=
dard
> +  PCI regions. The entries must be 7 cells each, where the first three c=
ells
> +  correspond to the address as described for the #address-cells property
> +  above, the fourth and fifth cells are for the physical CPU address to
> +  translate to and the sixth and seventh cells are as described for the
> +  #size-cells property above.
> +  - Entries setup the mapping for the standard I/O, memory and
> +    prefetchable PCI regions. The first cell determines the type of regi=
on
> +    that is setup:
> +    - 0x81000000: I/O memory region
> +    - 0x82000000: non-prefetchable memory region
> +    - 0xc2000000: prefetchable memory region
> +  Please refer to the standard PCI bus binding document for a more detai=
led
> +  explanation.
> +- #interrupt-cells: Size representation for interrupts (must be 1)
> +- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping propert=
ies
> +  Please refer to the standard PCI bus binding document for a more detai=
led
> +  explanation.
> +- clocks: Must contain an entry for each entry in clock-names.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Must include the following entries:
> +  - core
> +- resets: Must contain an entry for each entry in reset-names.
> +  See ../reset/reset.txt for details.
> +- reset-names: Must include the following entries:
> +  - core_apb

Perhaps leave away the "core_" prefix here and simply call this "apb"?

> +  - core
> +- phys: Must contain a phandle to P2U PHY for each entry in phy-names.
> +- phy-names: Must include an entry for each active lane.
> +  "p2u-N": where N ranges from 0 to one less than the total number of la=
nes
> +- nvidia,bpmp: Must contain a pair of phandle to BPMP controller node fo=
llowed
> +  by controller-id. Following are the controller ids for each controller.
> +    0: C0
> +    1: C1
> +    2: C2
> +    3: C3
> +    4: C4
> +    5: C5
> +- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
> +
> +Optional properties:
> +- supports-clkreq: Refer to Documentation/devicetree/bindings/pci/pci.txt
> +- nvidia,update-fc-fixup: This is a boolean property and needs to be pre=
sent to
> +    improve perf when a platform is designed in such a way that it satis=
fies at

This is a descriptive text, so it makes sense to spell out "performance"
for better readability.

> +    least one of the following conditions thereby enabling root port to
> +    exchange optimum number of FC (Flow Control) credits with downstream=
 devices
> +    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and M=
PS)
> +    2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths =
and
> +       a) speed is Gen-2 and MPS is 256B
> +       b) speed is >=3D Gen-3 with any MPS

I'm not sure if I asked this before, but can we not determine that the
configuration matches one of these conditions and select FC fixup mode
at runtime in that case?

> +- "nvidia,aspm-cmrt-us": Common Mode Restore time for proper operation o=
f ASPM

You can drop the quotes around the property names. Also, perhaps also
capitalize "Time" since it's part of the acronym expansion for CMRT.

> +   to be specified in microseconds
> +- "nvidia,aspm-pwr-on-t-us": Power On time for proper operation of ASPM =
to be
> +   specified in microseconds
> +- "nvidia,aspm-l0s-entrance-latency-us": ASPM L0s entrance latency to be
> +   specified in microseconds
> +
> +Examples:
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Tegra194:
> +--------
> +
> +SoC DTSI:

The example below looks like it's got board specific bits in it, so
perhaps just drop the "SoC DTSI:" caption.

> +
> +	pcie@14180000 {
> +		compatible =3D "nvidia,tegra194-pcie", "snps,dw-pcie";
> +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
> +		reg =3D <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)    =
  */
> +		       0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) =
*/
> +		       0x00 0x38040000 0x0 0x00040000>; /* iATU_DMA reg space (256K)  =
*/
> +		reg-names =3D "appl", "config", "atu_dma";
> +
> +		#address-cells =3D <3>;
> +		#size-cells =3D <2>;
> +		device_type =3D "pci";
> +		num-lanes =3D <8>;
> +		linux,pci-domain =3D <0>;
> +
> +		clocks =3D <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
> +		clock-names =3D "core";
> +
> +		resets =3D <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
> +			 <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
> +		reset-names =3D "core_apb", "core";
> +
> +		interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,	/* controller interru=
pt */
> +			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
> +		interrupt-names =3D "intr", "msi";
> +
> +		#interrupt-cells =3D <1>;
> +		interrupt-map-mask =3D <0 0 0 0>;
> +		interrupt-map =3D <0 0 0 0 &gic 0 72 0x04>;

Use the symbolic definitions GIC_SPI and IRQ_TYPE_LEVEL_HIGH here as
well.

> +
> +		nvidia,bpmp =3D <&bpmp>;

This should contain a controller ID according to the bindings.

> +
> +		supports-clkreq;
> +		nvidia,disable-aspm-states =3D <0xf>;

This is no longer documented above.

> +		nvidia,controller-id =3D <0>;

This is no longer documented above.

> +		nvidia,aspm-cmrt-us =3D <60>;
> +		nvidia,aspm-pwr-on-t-us =3D <20>;
> +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> +
> +		bus-range =3D <0x0 0xff>;
> +		ranges =3D <0x81000000 0x0 0x38100000 0x0 0x38100000 0x0 0x00100000   =
   /* downstream I/O (1MB) */
> +			  0x82000000 0x0 0x38200000 0x0 0x38200000 0x0 0x01E00000      /* non=
-prefetchable memory (30MB) */
> +			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>;  /* pre=
fetchable memory (16GB) */

Perhaps align the individual cells to make this more readable?

> +
> +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> +
> +		phys =3D <&p2u_hsio_2>, <&p2u_hsio_3>, <&p2u_hsio_4>,
> +		       <&p2u_hsio_5>;
> +		phy-names =3D "p2u-0", "p2u-1", "p2u-2", "p2u-3";
> +	};

Thanks,
Thierry

--YrQNB5Deg1WGKZi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzj2EgACgkQ3SOs138+
s6F9Tg/8DULF5J6wf4eLdR6TpIhskN1tAT8nstaTXpMBEHmwMjcwaqwuaftOvwam
/hNUDZL2yRsp5AmMcxgPVxQ7yxEIKDT37QLce+U636G79pcXQfPoRoqeuwq7QgcU
dPGUkN+qI/E9XLojwtL/T6yO4ZSxaySuRmedsTdMqT5TcppXkULGqrWQtAMdv5T4
J0uIayb9tuqcVVkYPLVeMnaCaaAiRsD6BBnPFBcDe+LE2W8EJeJBOdMbDNp0YdBN
ut/qrVdhzz6nwE71ZzmJLZ8LPHJqX0+uZc8ohApqt4JtTMv3shnwGYIYhnOfo0wI
hSe+oM2E1jiVokxl5hPqvLve+KZIMilHHDjhuSB+JMh25md/I9PoVB4XEd3WrEOw
can1kZgM/SOK5SOxMFDAWuSLMkFJzeG78rlBvdhWVukW+TCk1moLkhCzeDvtcFRl
0wEXGfC/tlQ0CLDMQYJJqYZSxBDSdVpGVXWplX1y2fyH4R4BqGY8cvtc1yLXG3F1
W6yspptSYmYX1BsnSwKQpifyC/eAyuuzk7ux8pPfyKObiglX+XNjJR5VkaJ8jcZQ
UzDRamMhNNnnGQNU4OTgnQccI1GqBZfSI1yUQVkSkouC7HVSYXDRGnIdHVc9eait
1aMstvSz0U1Zld6Qpvys0LI8X+rms4cgJ+8leovTNo+hyBEscTY=
=onc4
-----END PGP SIGNATURE-----

--YrQNB5Deg1WGKZi3--
