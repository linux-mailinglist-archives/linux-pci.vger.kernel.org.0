Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1727D9D9E
	for <lists+linux-pci@lfdr.de>; Fri, 27 Oct 2023 17:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346308AbjJ0P5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Oct 2023 11:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346224AbjJ0P5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Oct 2023 11:57:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17611CE
        for <linux-pci@vger.kernel.org>; Fri, 27 Oct 2023 08:57:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD84EC433C9;
        Fri, 27 Oct 2023 15:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698422224;
        bh=GNGO9Dy7lzklLJ0376C9oy3DviV7FdG3YmJvVG6RcJU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MDiCaM3t2THhJi7+cn47CasKWbC8pAVOfWCAjNYsIusrJ60gyEtXM1m6Dw7O7hAsR
         afCid2ZmkgQMfoxVPboGgJGiQxWC9ulUvVasMUtZgYRyi1JQ2H6xe4Xthksx4KUE08
         lBSInXSgJjM6NVYPLy+JStqPeUhVBJO4i2aTIp+HG1Cl0IS6byl9boIORYO38iXQa5
         kSqnBqF83ktKU5QSx8lt51x9n/k9yk62dJPK0Rce8cQ4i7L0nldbjBIJSDCBT/ChZt
         BQbKS73oixYAQIguSc20zSV3bFsPKimSJnYdFnBeu97Rtgr3yKHXloSP9bRI4M/WJv
         8YqZADn7PQTYA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so29514721fa.3;
        Fri, 27 Oct 2023 08:57:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YxXNKPLkvVAp+FD4R1v+axY6Ld39G5jrUZwl4hVCDd8cGjEkUeg
        J1T6dmkw8GcN61LIV7UpKOPn0/7mxSedp9tK3g==
X-Google-Smtp-Source: AGHT+IEwlNZ95i/dFoxCnlHoH5+6/K3HPIFaerat8lMtZIKbwrzp3SFQx76pV2pk3V3UCLFHaP2Fj7ehg6iUmiep7DU=
X-Received: by 2002:ac2:4d90:0:b0:507:a6b6:e5de with SMTP id
 g16-20020ac24d90000000b00507a6b6e5demr2084401lfe.23.1698422222865; Fri, 27
 Oct 2023 08:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231024151014.240695-1-nks@flawful.org> <20231024151014.240695-2-nks@flawful.org>
 <20231024-zoology-preteen-5627e1125ae0@spud> <ZTl0VwdFYt9kqxtp@x1-carbon>
 <20231026183501.GB4122054-robh@kernel.org> <ZTvKeeYpfX57A+yd@x1-carbon>
In-Reply-To: <ZTvKeeYpfX57A+yd@x1-carbon>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 27 Oct 2023 10:56:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLvBuFcbXR-2OHLwQ1a28DwTGXUgAOgsmWofSFrmTsNJw@mail.gmail.com>
Message-ID: <CAL_JsqLvBuFcbXR-2OHLwQ1a28DwTGXUgAOgsmWofSFrmTsNJw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: PCI: dwc: rockchip: Add atu property
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Conor Dooley <conor@kernel.org>, Niklas Cassel <nks@flawful.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 27, 2023 at 9:35=E2=80=AFAM Niklas Cassel <Niklas.Cassel@wdc.co=
m> wrote:
>
> Hello Rob,
>
> On Thu, Oct 26, 2023 at 01:35:01PM -0500, Rob Herring wrote:
> > On Wed, Oct 25, 2023 at 08:02:32PM +0000, Niklas Cassel wrote:
> > > Hello Conor,
> > >
> > > On Tue, Oct 24, 2023 at 05:29:28PM +0100, Conor Dooley wrote:
> > > > On Tue, Oct 24, 2023 at 05:10:08PM +0200, Niklas Cassel wrote:
> > > > > From: Niklas Cassel <niklas.cassel@wdc.com>
> > > > >
> > > > > Even though rockchip-dw-pcie.yaml inherits snps,dw-pcie.yaml
> > > > > using:
> > > > >
> > > > > allOf:
> > > > >   - $ref: /schemas/pci/snps,dw-pcie.yaml#
> > > > >
> > > > > and snps,dw-pcie.yaml does have the atu property defined, in orde=
r to be
> > > > > able to use this property, while still making sure 'make CHECK_DT=
BS=3Dy'
> > > > > pass, we need to add this property to rockchip-dw-pcie.yaml.
> > > > >
> > > > > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > > > ---
> > > > >  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 4 =
++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/pci/rockchip-dw-pc=
ie.yaml b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > > > index 1ae8dcfa072c..229f8608c535 100644
> > > > > --- a/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > > > +++ b/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> > > > > @@ -29,16 +29,20 @@ properties:
> > > > >            - const: rockchip,rk3568-pcie
> > > > >
> > > > >    reg:
> > > > > +    minItems: 3
> > > > >      items:
> > > > >        - description: Data Bus Interface (DBI) registers
> > > > >        - description: Rockchip designed configuration registers
> > > > >        - description: Config registers
> > > > > +      - description: iATU registers
> > > >
> > > > Is this extra register only for the ..88 or for the ..68 and for th=
e
> > > > ..88 models?
> > >
> > > Looking at the rk3568 Technical Reference Manual (TRM):
> > > https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%=
20Part2%20V1.1-20210301.pdf
> > >
> > > The iATU register register range exists for all 3 PCIe controllers
> > > found on the rk3568.
> > >
> > > This register range is currently not defined in the rk3568.dtsi, so t=
he driver
> > > will currently use the default register offset (which is correct), bu=
t with
> > > the driver fallback register size that is only big enough to cover 8 =
inbound
> > > and 8 outbound iATUs (internal Address Translation Units).
> >
> > We should probably make the driver smarter instead or in addition. We
> > have the DBI size, Just make atu_size =3D dbi_size - DEFAULT_DBI_ATU_OF=
FSET.
>
> I though about that, but it seems that some drivers don't use
> res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi")
>
> but instead set pci->dbi_base from non-common code, e.g.:
> drivers/pci/controller/dwc/pci-dra7xx.c:        pci->dbi_base =3D devm_pl=
atform_ioremap_resource_byname(pdev, "ep_dbics");
> drivers/pci/controller/dwc/pci-dra7xx.c:        pci->dbi_base =3D devm_pl=
atform_ioremap_resource_byname(pdev, "rc_dbics");
> drivers/pci/controller/dwc/pci-imx6.c:  pci->dbi_base =3D devm_platform_g=
et_and_ioremap_resource(pdev, 0, &dbi_base);
> drivers/pci/controller/dwc/pci-keystone.c:      pci->dbi_base =3D base;
> drivers/pci/controller/dwc/pci-layerscape-ep.c: dbi_base =3D platform_get=
_resource_byname(pdev, IORESOURCE_MEM, "regs");
> drivers/pci/controller/dwc/pci-layerscape-ep.c: pci->dbi_base =3D devm_pc=
i_remap_cfg_resource(dev, dbi_base);
> drivers/pci/controller/dwc/pci-layerscape.c:    dbi_base =3D platform_get=
_resource_byname(pdev, IORESOURCE_MEM, "regs");
> drivers/pci/controller/dwc/pci-layerscape.c:    pci->dbi_base =3D devm_pc=
i_remap_cfg_resource(dev, dbi_base);
> drivers/pci/controller/dwc/pci-meson.c: pci->dbi_base =3D devm_platform_i=
oremap_resource_byname(pdev, "elbi");
> drivers/pci/controller/dwc/pcie-al.c:   void __iomem *dbi_base =3D pcie->=
dbi_base;
> drivers/pci/controller/dwc/pcie-al.c:   al_pcie->dbi_base =3D devm_pci_re=
map_cfg_resource(dev, res);
> drivers/pci/controller/dwc/pcie-armada8k.c:     pci->dbi_base =3D devm_pc=
i_remap_cfg_resource(dev, base);
> drivers/pci/controller/dwc/pcie-designware.c:           pci->dbi_base =3D=
 devm_pci_remap_cfg_resource(pci->dev, res);
> drivers/pci/controller/dwc/pcie-histb.c:        pci->dbi_base =3D devm_pl=
atform_ioremap_resource_byname(pdev, "rc-dbi");
> drivers/pci/controller/dwc/pcie-qcom-ep.c:      pci->dbi_base =3D devm_pc=
i_remap_cfg_resource(dev, res);
> drivers/pci/controller/dwc/pcie-tegra194-acpi.c:        pcie_ecam->dbi_ba=
se =3D cfg->win + SZ_512K;
>
> So I don't think that we can always get the size of the dbi.
> And a solution that does not work for all platforms is not
> that appealing.

Do I get a chance to respond before you send a new version?

Does something like the patch below not work for everyone? We could
store the DBI size as well if we want more than 8 regions to work
without a 'dbi' nor 'atu' region defined. We shouldn't have new users
doing that though.

diff --git a/drivers/pci/controller/dwc/pcie-designware.c
b/drivers/pci/controller/dwc/pcie-designware.c
index 250cf7f40b85..3dc71ea7fa76 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -105,11 +105,13 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
        struct platform_device *pdev =3D to_platform_device(pci->dev);
        struct device_node *np =3D dev_of_node(pci->dev);
        struct resource *res;
+       size_t dbi_size =3D DEFAULT_DBI_ATU_OFFSET + SZ_4K;
        int ret;

        if (!pci->dbi_base) {
                res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, =
"dbi");
                pci->dbi_base =3D devm_pci_remap_cfg_resource(pci->dev, res=
);
+               dbi_size =3D resource_size(res);
                if (IS_ERR(pci->dbi_base))
                        return PTR_ERR(pci->dbi_base);
        }
@@ -136,13 +138,10 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
                                return PTR_ERR(pci->atu_base);
                } else {
                        pci->atu_base =3D pci->dbi_base + DEFAULT_DBI_ATU_O=
FFSET;
+                       pci->atu_size =3D dbi_size - DEFAULT_DBI_ATU_OFFSET=
;
                }
        }

-       /* Set a default value suitable for at most 8 in and 8 out windows =
*/
-       if (!pci->atu_size)
-               pci->atu_size =3D SZ_4K;
-
        /* eDMA region can be mapped to a custom base address */
        if (!pci->edma.reg_base) {
                res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, =
"dma");
