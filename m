Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE44108938
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2019 08:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfKYHeG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Nov 2019 02:34:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39487 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfKYHeF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Nov 2019 02:34:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so13443148wrt.6;
        Sun, 24 Nov 2019 23:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YT4DCAvfATgR6WiJSH9oEhxHmjOZ2KQa6ZaeUOZBcbk=;
        b=PfRfZ/RQUx7/gqOjnpDtZje356GSO6QGGtvB00Exccz93sZKtaFiu7PS52ImhxGT2e
         KDYEIytFxMJusOXPeKvxOVQy2rdanDNVkNaFOi7dBmSeVCcsGZLlFfFLsNIJOiowd4Ib
         zBxPYLssYFHXm69sxNA6hpzGm0t9aT73qwsC3ma0JIKFoLh/QiBunAZT/pgQaRqYxC6f
         VhvE29K7tIaH+HHXLjAVElBsaXvYFNWq6aCCoCnXYXLtSXYzCyLk1VsWnArEPWaEPlcV
         75YotyKnmv4MROdtDp2jiSyj1/pXLNbTF8q2bfKWYgSvEL2Ezy+qxanSwO4DFX38RO1R
         Mwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YT4DCAvfATgR6WiJSH9oEhxHmjOZ2KQa6ZaeUOZBcbk=;
        b=kp5IA9cDmyyn4QV/XGC03ZFg83iVZfPYeJJME7lped6THXDyT2Vw+G3DWW2J2lS/YF
         0MyFITO2f2N5C7yvTJ8kD+vgPCQiUbb5rQQ+bmIp+iqedpmtCzNOQWZJAITud4vv/JbA
         YcLoIeZ4OhBD6CFMBcz2TofqbgrxSIe/86X7BIOrsQxrlysWpKABhNS3HmDJWoDzWxGH
         F/upjMl7lSd+MFLWJr5oEKPk1yfRDoDqIS80ZG8pmeb9VIpq2lU/c5PUDNazlAv1FI+3
         yo0N4dvOzXyjfOt11J0MxzZdTgUF9cw1hG1FKbZi7JgAb2Nae074l68IbEp9j9jwPAGw
         Nw6Q==
X-Gm-Message-State: APjAAAViy6P+zs8SnIHAoEZMPcSJvQvfmQvHk1QAd5CoXFjcPZjcF3vA
        5MfqbtMGmRk03nRxsd+4Mjk=
X-Google-Smtp-Source: APXvYqwzxBA2/T+lo3fqmD59s7Rx3Lv2mB2aC9cr+Z3hjNfb0tzer/qYNniZe9Xhw5DaOn+PYf7uOA==
X-Received: by 2002:adf:f504:: with SMTP id q4mr30031752wro.160.1574667241420;
        Sun, 24 Nov 2019 23:34:01 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id w12sm7548373wmi.17.2019.11.24.23.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 23:34:00 -0800 (PST)
Date:   Mon, 25 Nov 2019 08:33:59 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     Rob Herring <robh+dt@kernel.org>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, jonathanh@nvidia.com, andrew.murray@arm.com,
        kishon@ti.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH 2/6] dt-bindings: PCI: tegra: Add DT support for PCIe EP
 nodes in Tegra194
Message-ID: <20191125073359.GD1409040@ulmo>
References: <20191122104505.8986-1-vidyas@nvidia.com>
 <20191122104505.8986-3-vidyas@nvidia.com>
 <20191122131931.GB1315704@ulmo>
 <8fbdda8e-84af-576c-e240-61c381c85a8f@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <8fbdda8e-84af-576c-e240-61c381c85a8f@nvidia.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2019 at 12:53:42PM +0530, Vidya Sagar wrote:
> On 11/22/2019 6:49 PM, Thierry Reding wrote:
> > On Fri, Nov 22, 2019 at 04:15:01PM +0530, Vidya Sagar wrote:
> > > Add support for PCIe controllers that can operate in endpoint mode
> > > in Tegra194.
> > >=20
> > > Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> > > ---
> > >   .../bindings/pci/nvidia,tegra194-pcie-ep.txt  | 138 +++++++++++++++=
+++
> > >   1 file changed, 138 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/pci/nvidia,teg=
ra194-pcie-ep.txt
> >=20
> > The vast majority of this is a duplication of the host mode device tree
> > bindings. I think it'd be best to combine both and only highlight where
> > both modes differ.
> >=20
> > The designware-pcie.txt binding does something similar.
> Ok. I'll merge this into the host mode bindings file and in that differen=
tiate between
> root mode and endpoint mode.
>=20
> >=20
> > > diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pc=
ie-ep.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.t=
xt
> > > new file mode 100644
> > > index 000000000000..4676ccf7dfa5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.t=
xt
> > > @@ -0,0 +1,138 @@
> > > +NVIDIA Tegra PCIe Endpoint mode controller (Synopsys DesignWare Core=
 based)
> > > +
> > > +Some of the PCIe controllers which are based on Synopsys DesignWare =
PCIe IP
> > > +are dual mode i.e. they can work in root port mode or endpoint mode =
but one
> > > + at a time. Since they are based on DesignWare IP, they inherit all =
the common
> > > +properties defined in designware-pcie.txt.
> > > +
> > > +Required properties:
> > > +- compatible: For Tegra19x, must contain "nvidia,tegra194-pcie".
> >=20
> > The device tree snippets that you added have "nvidia,tegra194-pcie-ep"
> > for EP mode controllers. So either this is wrong or the DTS files are
> > wrong.
> DTS file are correct. This is a mistake in this file. I'll correct this.
>=20
> >=20
> > This device tree binding describes the exact same hardware, so I don't
> > think we necessarily need two different compatible strings. It's fairly
> > easy to distinguish between which mode to run in by looking at which
> > properties exist. EP mode for example is the only one that uses the
> > "addr_space" reg entry.
> >=20
> > Rob, do you know why a different compatible string was chosen for the EP
> > mode? Looking at the driver, there are only a handful of differences in
> > the programming, but most of the driver remains identical. An extra DT
> > compatible string seems a bit exaggerated since it suggests that this is
> > actually different hardware, where it clearly isn't.
> Since all other implementations have done it this way, I just followed to=
 be in sync
> with them. Even I would also like to hear from Rob on the rationale behin=
d this.
>=20
> >=20
> > > +  Tegra194: Only C0, C4 & C5 controllers are dual mode controllers.
> > > +- power-domains: A phandle to the node that controls power to the re=
spective
> > > +  PCIe controller and a specifier name for the PCIe controller. Foll=
owing are
> > > +  the specifiers for the different PCIe controllers
> > > +    TEGRA194_POWER_DOMAIN_PCIEX8B: C0
> > > +    TEGRA194_POWER_DOMAIN_PCIEX4A: C4
> > > +    TEGRA194_POWER_DOMAIN_PCIEX8A: C5
> > > +  these specifiers are defined in
> > > +  "include/dt-bindings/power/tegra194-powergate.h" file.
> > > +- reg: A list of physical base address and length pairs for each set=
 of
> > > +  controller registers. Must contain an entry for each entry in the =
reg-names
> > > +  property.
> > > +- reg-names: Must include the following entries:
> > > +  "appl": Controller's application logic registers
> > > +  "atu_dma": iATU and DMA registers. This is where the iATU (interna=
l Address
> > > +             Translation Unit) registers of the PCIe core are made a=
vailable
> > > +             for SW access.
> > > +  "dbi": The aperture where root port's own configuration registers =
are
> > > +         available
> > > +  "addr_space": Used to map remote RC address space
> > > +- interrupts: A list of interrupt outputs of the controller. Must co=
ntain an
> > > +  entry for each entry in the interrupt-names property.
> > > +- interrupt-names: Must include the following entry:
> > > +  "intr": The Tegra interrupt that is asserted for controller interr=
upts
> > > +- clocks: Must contain an entry for each entry in clock-names.
> > > +  See ../clocks/clock-bindings.txt for details.
> > > +- clock-names: Must include the following entries:
> > > +  - core
> > > +- resets: Must contain an entry for each entry in reset-names.
> > > +  See ../reset/reset.txt for details.
> > > +- reset-names: Must include the following entries:
> > > +  - apb
> > > +  - core
> > > +- phys: Must contain a phandle to P2U PHY for each entry in phy-name=
s.
> > > +- phy-names: Must include an entry for each active lane.
> > > +  "p2u-N": where N ranges from 0 to one less than the total number o=
f lanes
> > > +- nvidia,bpmp: Must contain a pair of phandle to BPMP controller nod=
e followed
> > > +  by controller-id. Following are the controller ids for each contro=
ller.
> > > +    0: C0
> > > +    4: C4
> > > +    5: C5
> > > +- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
> > > +- nvidia,pex-rst-gpio: Must contain a phandle to a GPIO controller f=
ollowed by
> > > +  GPIO that is being used as PERST signal
> >=20
> > Why is this NVIDIA specific? Do other instantiations of the DW IP not
> > also need a means to define which GPIO is the reset?
> I'm not sure. At least I didn't find anything like this in other implemen=
tations.
> My understanding is that, controller handles assert/de-assert on the PERS=
T line
> automatically without SW intervention. I think it is for the same reason =
that other
> implementations don't wait for the REFCLK to flow in from host to configu=
re the IP.
> I think they just use some internal clock for the configuration and switc=
h to
> running the core based on REFCLK as and when it is available
> (i.e. whenever a de-assert is perceived on PERST line by the controller)

That would be somewhat surprising, though. The IP used in Tegra must be
pretty close to the IP used in other SoCs, and the code that we need in
pex_ep_event_pex_rst_{assert,deassert}() is pretty significant. Why the
other instantiations wouldn't need something similar seems unlikely to
me.

Perhaps Jingoo or Gustavo can shed some light on this.

Thierry

>=20
> >=20
> > > +
> > > +Optional properties:
> > > +- pinctrl-names: A list of pinctrl state names.
> > > +  It is mandatory for C5 controller and optional for other controlle=
rs.
> > > +  - "default": Configures PCIe I/O for proper operation.
> > > +- pinctrl-0: phandle for the 'default' state of pin configuration.
> > > +  It is mandatory for C5 controller and optional for other controlle=
rs.
> > > +- supports-clkreq: Refer to Documentation/devicetree/bindings/pci/pc=
i.txt
> > > +- nvidia,update-fc-fixup: This is a boolean property and needs to be=
 present to
> > > +    improve performance when a platform is designed in such a way th=
at it
> > > +    satisfies at least one of the following conditions thereby enabl=
ing root
> > > +    port to exchange optimum number of FC (Flow Control) credits with
> > > +    downstream devices
> > > +    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed a=
nd MPS)
> > > +    2. If C0/C4/C5 operate at their respective max link widths and
> > > +       a) speed is Gen-2 and MPS is 256B
> > > +       b) speed is >=3D Gen-3 with any MPS
> > > +- nvidia,aspm-cmrt-us: Common Mode Restore Time for proper operation=
 of ASPM
> > > +   to be specified in microseconds
> > > +- nvidia,aspm-pwr-on-t-us: Power On time for proper operation of ASP=
M to be
> > > +   specified in microseconds
> > > +- nvidia,aspm-l0s-entrance-latency-us: ASPM L0s entrance latency to =
be
> > > +   specified in microseconds
> > > +
> > > +NOTE:- On Tegra194's P2972-0000 platform, only C5 controller can be =
enabled to
> > > +operate in the endpoint mode because of the way the platform is desi=
gned.
> > > +There is a mux that needs to be programmed to let the REFCLK from th=
e host to
> > > +flow into C5 controller when it operates in the endpoint mode. This =
mux is
> > > +controlled by the GPIO (AA, 5) and it needs to be driven 'high'. For=
 this to
> > > +happen, set status of "pex-refclk-sel-high" node under "gpio@c2f0000=
" node to
> > > +'okay'.
> > > +	When any dual mode controller is made to operate in the endpoint mo=
de,
> > > +please make sure that its respective root port node's status is set =
to
> > > +'disabled'.
> >=20
> > This seems very brittle to me. There's no good way how we can detect
> > such misconfigurations. If instead we only have one node describing the
> > hardware fully, the chances of configuring things wrong (by for example
> > enabling both the host and EP mode device tree nodes) can be reduced.
> >=20
> > So I think instead of duplicating all of the device tree content to have
> > both a host and an EP node for each controller, it'd be better to just
> > have a single node and let the device tree bindings specify which
> > changes to apply to switch into EP mode.
> >=20
> > For example, there should be nothing wrong with specifying some of the
> > EP-only properties (like num-ib-windows and num-ob-windows) all the time
> > and only use them when we actually run in EP mode.
> >=20
> > As I mentioned earlier, there are a couple of easy ways to distinguish
> > the modes. The presence of the "addr_space" reg entry is one example,
> > but we could also key off the nvidia,pex-rst-gpio property, since that
> > (presumably) wouldn't be needed for host mode.
> >=20
> > That way we can just add default, host mode entries to tegra194.dtsi and
> > whenever somebody wants to enable EP mode, they can just override the
> > node in the board-level DTS file, like so:
> >=20
> > 	pcie@141a0000 {
> > 		reg =3D <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)   =
   */
> > 		       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K) =
 */
> > 		       0x00 0x3a080000 0x0 0x00040000   /* DBI reg space (256K)      =
 */
> > 		       0x1c 0x00000000 0x4 0x00000000>; /* Address Space (16G)       =
 */
> > 		reg-names =3D "appl", "atu_dma", "dbi", "addr_space";
> >=20
> > 		nvidia,pex-rst-gpio =3D <&gpio TEGRA194_MAIN_GPIO(GG, 1) GPIO_ACTIVE_=
LOW>;
> > 	};
> >=20
> > Thierry
> I like it and fine with making these modifications also but would like to=
 hear from Rob
> also on this.
>=20
> - Vidya Sagar
> >=20
> > > +
> > > +Examples:
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +Tegra194:
> > > +--------
> > > +
> > > +	pcie_ep@141a0000 {
> > > +		compatible =3D "nvidia,tegra194-pcie-ep", "snps,dw-pcie-ep";
> > > +		power-domains =3D <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
> > > +		reg =3D <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)=
      */
> > > +		       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256=
K)  */
> > > +		       0x00 0x3a080000 0x0 0x00040000   /* DBI reg space (256K)   =
    */
> > > +		       0x1c 0x00000000 0x4 0x00000000>; /* Address Space (16G)    =
    */
> > > +		reg-names =3D "appl", "atu_dma", "dbi", "addr_space";
> > > +
> > > +		num-lanes =3D <8>;
> > > +		num-ib-windows =3D <2>;
> > > +		num-ob-windows =3D <8>;
> > > +
> > > +		pinctrl-names =3D "default";
> > > +		pinctrl-0 =3D <&clkreq_c5_bi_dir_state>;
> > > +
> > > +		clocks =3D <&bpmp TEGRA194_CLK_PEX1_CORE_5>;
> > > +		clock-names =3D "core";
> > > +
> > > +		resets =3D <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
> > > +			 <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
> > > +		reset-names =3D "apb", "core";
> > > +
> > > +		interrupts =3D <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;	/* controller int=
errupt */
> > > +		interrupt-names =3D "intr";
> > > +
> > > +		nvidia,bpmp =3D <&bpmp 5>;
> > > +
> > > +		nvidia,aspm-cmrt-us =3D <60>;
> > > +		nvidia,aspm-pwr-on-t-us =3D <20>;
> > > +		nvidia,aspm-l0s-entrance-latency-us =3D <3>;
> > > +
> > > +		vddio-pex-ctl-supply =3D <&vdd_1v8ao>;
> > > +
> > > +		nvidia,pex-rst-gpio =3D <&gpio TEGRA194_MAIN_GPIO(GG, 1)
> > > +					GPIO_ACTIVE_LOW>;
> > > +
> > > +		phys =3D <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
> > > +		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
> > > +		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
> > > +
> > > +		phy-names =3D "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
> > > +			    "p2u-5", "p2u-6", "p2u-7";
> > > +	};
> > > --=20
> > > 2.17.1
> > >=20
>=20

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3bg+cACgkQ3SOs138+
s6F2rA/+LhCCW6FCAVjhVBNBX/iT9SfPQHkVzYjswIIG+Hurfw7+9NxJT4zjdq3A
564s9q6RPRWOILRh/p3tqMbRRTroHZLpWdsp2J10dMBjlw0ESDUgwFJNJsolLO6Y
TTkijTkWAAh2YZ8caB1V60UHMSv1CUweQFx0FsJ7t7VD3XVKgq9fCKRxHcO+dAzw
EQ1lDenqqChS/JSkVeF7VUJ5IgUhmmJHtKn2fUqeOTEi9BhRnFRHuZcBrd1V2zFX
hM87CKhngsdVwa+9YfO5yag8OktZQ9MVQcGO3s4EafjRVVB0AwoGvaEIPydP2G8B
qhuMU7toH2dASP971SzG3R7GYLFZB00W/CGiYajaxXduR7UxBq0kSHV4PGIzyV5W
rMDfvilSek3q4uOM3y4q89ZXZggN5hHUtKFiiNU5ouOtW9mMI+NbwU+mQTe2pJK+
uZUOokBsqgp0YylrAxOt8xRhT+AZq2iq81k3d9sPBjmUR8DZPXfKwAlRGmAtmlNc
bDr8sByh7jnYcPsNpM89CJi22DX1K7K5zK+d5MORFAem8LLRBV7rxADlU9ci4AF7
EuWzAnKSx4GFqnp5MPGe64KClx/gCLx+Drgsahx8PqbW25qc5TB+Pj2qy55wcg4v
zOLM9UkXCtcwpDn3zF4A8+MSk2ke8PmEiN9VIGQJA0cO10xOYRc=
=Iz3N
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
