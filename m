Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1C2546F1A
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 23:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350890AbiFJVOC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 17:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350911AbiFJVN4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 17:13:56 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D022117063;
        Fri, 10 Jun 2022 14:13:48 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w20so328625lfa.11;
        Fri, 10 Jun 2022 14:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+WVVm9hcoQebKnMQEz2CUXNeS0i4uoyXlCrD4W7Sr0Y=;
        b=V+C4pC8SqzfTH6Iaawp235DJRVIZS2N+cxDdEhKxufC6aX/MVOofRtzAsGmEcQqWYt
         5ERGOdbaJp1itw1qIzfQUh+JLcAjur4jNg4sWYw5V/4qA09WNrkGIWGJPAm7UkbELFth
         O5Y+nvF+WVyVK0im9nRCrlbdkEMp9BZWj669wmcCdK2PJK8ECBNqVlldHpX4v+qjxoOp
         lYcoGNHCVpqfYHo3MCy2VyZRnJ7eQFqOf9jXQa3PNN5CFQV6PXJ1uIFlw0V9okWriudB
         TwB4Vw7UJihm1CwcZTxYI2x2F2nsF0BWBCKvlNV/j5sTQLnde27LbBiSN5SOv++SK/0p
         S8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+WVVm9hcoQebKnMQEz2CUXNeS0i4uoyXlCrD4W7Sr0Y=;
        b=t9sYggZYApVTSXKN5MbeZLT5xgIEtlM9GXLMrxcL2z+nhGQvWXAcf7MoNHPl/xM6Ur
         7XZXHtuquovUQ5xqv17slQFZSWGpyMR2skdtOJG7iWCtybOR0oPASjXgjHskG5KWTh6Q
         FyJteVBSJdimKKHjil6i2vZqCzgup6K37FVUdVHRJUPi4tu/0sfCyH4KEb1MoBGv/FyF
         dfPkOCRCAG53tlwvfsRIzedSTuDmPJY1xbkzfqRZiwpFWt+CzxOqp+Xhg0XmCdYZstsi
         DjeEaW0cUVCpr8CanU/5ggKMdflBIWnzsOmJJKjI1QipnSCtd/blqAsvEGetrFXE7rsZ
         0yCg==
X-Gm-Message-State: AOAM532bUs/L3j2+vekXkvMIVT4DEWLtRqnC5ajW4gMYzX62Zu39JPlv
        dCYazlqkZzG1UOc9QEaCyoE=
X-Google-Smtp-Source: ABdhPJyvXYy81hLj3UEhHeroA/LIfcCYk32cRQExNWN/ZtgSuCtg+aV3gMvcTrIshMT4Ye6IERCMhQ==
X-Received: by 2002:a05:6512:92c:b0:479:7a74:8427 with SMTP id f12-20020a056512092c00b004797a748427mr8940890lft.126.1654895627234;
        Fri, 10 Jun 2022 14:13:47 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id x15-20020a2e9dcf000000b0025572941cc0sm79014ljj.113.2022.06.10.14.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 14:13:46 -0700 (PDT)
Date:   Sat, 11 Jun 2022 00:13:44 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Frank Li <Frank.Li@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Simon Xue <xxm@rock-chips.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Subject: Re: [PATCH v3 11/17] dt-bindings: PCI: dwc: Apply common schema to
 Rockchip DW PCIe nodes
Message-ID: <20220610211344.xpax4ao3m22dwsyo@mobilestation>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-12-Sergey.Semin@baikalelectronics.ru>
 <1654866755.753412.1529404.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1654866755.753412.1529404.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 10, 2022 at 07:12:35AM -0600, Rob Herring wrote:
> On Fri, 10 Jun 2022 11:56:59 +0300, Serge Semin wrote:
> > As the DT-bindings description states the Rockchip PCIe controller is
> > based on the DW PCIe RP IP-core thus its DT-nodes are supposed to be
> > compatible with the common DW PCIe controller schema. Let's make sure t=
hey
> > evaluated against it by referring to the snps,dw-pcie-common.yaml schema
> > in the allOf sub-schemas composition.
> >=20
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >=20
> > ---
> >=20
> > Changelog v3:
> > - This is a new patch created on v3 lap of the series.
> > ---
> >  Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20
> yamllint warnings/errors:
>=20

> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml: Unable to =
find schema file matching $id: http://devicetree.org/schemas/pci/snps,dw-pc=
ie-common.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/=
rockchip-dw-pcie.example.dtb: pcie@fe280000: False schema does not allow {'=
compatible': ['rockchip,rk3568-pcie'], 'reg': [[3, 3229614080, 0, 3735552],=
 [0, 4264034304, 0, 65536], [3, 2147483648, 0, 1048576]], 'reg-names': ['db=
i', 'apb', 'config'], 'bus-range': [[32, 47]], 'clocks': [[4294967295, 143]=
, [4294967295, 144], [4294967295, 145], [4294967295, 146], [4294967295, 147=
]], 'clock-names': ['aclk_mst', 'aclk_slv', 'aclk_dbi', 'pclk', 'aux'], 'de=
vice_type': ['pci'], 'linux,pci-domain': [[2]], 'max-link-speed': [[2]], 'm=
si-map': [[8192, 4294967295, 8192, 4096]], 'num-lanes': [[2]], 'phys': [[42=
94967295]], 'phy-names': ['pcie-phy'], 'power-domains': [[4294967295, 15]],=
 'ranges': [[2164260864, 0, 2155872256, 3, 2155872256, 0, 1048576], [219781=
5296, 0, 2156920832, 3, 2156920832, 0, 1064304640]], 'resets': [[4294967295=
, 193]], 'reset-names': ['pipe'], '#address-cells': [[3]], '#size-cells': [=
[2]], '$nodename': ['pcie@fe280000']}
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree=
/bindings/pci/rockchip-dw-pcie.yaml

It's added in the framework of the patch:
[PATCH v3 1/17] dt-bindings: PCI: dwc: Detach common RP/EP DT bindings
of this series.

>=20
> doc reference errors (make refcheckdocs):
>=20
> See https://patchwork.ozlabs.org/patch/
>=20
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>=20

> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade

Checked. No problem has been spotted:
[fancer@mobilestation] kernel $ pip3 show dtschema | grep Version
Version: 2022.5
[fancer@mobilestation] kernel $ yamllint -v
yamllint 1.25.0
[fancer@mobilestation] kernel $ make -j8 ARCH=3Dmips CROSS_COMPILE=3Dmipsel=
-baikal-linux- dt_binding_check DT_SCHEMA_FILES=3DDocumentation/devicetree/=
bindings/pci/rockchip-dw-pcie.yaml
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/pci/rockchip-dw-pcie.example.dts
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  DTC     Documentation/devicetree/bindings/pci/rockchip-dw-pcie.example.dtb
  CHECK   Documentation/devicetree/bindings/pci/rockchip-dw-pcie.example.dtb
[fancer@mobilestation] kernel $

-Sergey

>=20
> Please check and re-submit.
>=20
