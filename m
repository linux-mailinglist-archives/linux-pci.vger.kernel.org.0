Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6680752E737
	for <lists+linux-pci@lfdr.de>; Fri, 20 May 2022 10:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346946AbiETIXl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 May 2022 04:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346932AbiETIXj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 May 2022 04:23:39 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CB3140423;
        Fri, 20 May 2022 01:23:36 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C419E6000A;
        Fri, 20 May 2022 08:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1653035014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7ftNRkOl2hUKqnVw602ufHyZi8yLfc1Zwyuxj3PqQU=;
        b=c5I6dSsQESldKWX+KVZzuJkA3YahNJqcYefiVUApmUcel4osp4QtbFBDjObK519OFyoB0b
        os093WMhtAX9vCqQWn9bpcqSHketvksEQDVpyhjh9JSEGfJ25AzoCD77dkKqtWgEMQH1M4
        wBwDPOxYf74MqjtEZm16M9mbRv7CE2Fm9scfGZc1RCSgkX4DL/imWLpspuxsUlVb0smNZe
        +H3HswE4E9m6q7mi7pmOhhnQEAf3vMEwXJoqvjGFWG3uuWTcERGPzrrYQuUl3FuQFlJrpO
        hiCnIwdpd6UMi2XAwQOV1IeQXuahbdqG0oLzN4xjgpL5jk9rkYbmdLaKGWVSUQ==
Date:   Fri, 20 May 2022 10:23:29 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v5 2/6] dt-bindings: PCI: renesas,pci-rcar-gen2: Add
 device tree support for r9a06g032
Message-ID: <20220520102329.6b0a58d0@bootlin.com>
In-Reply-To: <29ba3db6-e5c7-06d3-29d9-918ee5b34555@linaro.org>
References: <20220429134143.628428-1-herve.codina@bootlin.com>
        <20220429134143.628428-4-herve.codina@bootlin.com>
        <29ba3db6-e5c7-06d3-29d9-918ee5b34555@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On Sun, 1 May 2022 10:51:43 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

[...]
> >    resets:
> >      maxItems: 1
> > @@ -106,13 +106,45 @@ required:
> >    - interrupt-map
> >    - interrupt-map-mask
> >    - clocks
> > -  - resets
> >    - power-domains
> >    - bus-range
> >    - "#address-cells"
> >    - "#size-cells"
> >    - "#interrupt-cells"
> > =20
> > +if: =20
>=20
> allOf.
>=20
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:

I Have an issue with this allOf.

The yaml has the following structure and so has 2 AllOf:
  ...
  allOf:
  - $ref: /schemas/pci/pci-bus.yaml#
 =20
  properties:
    compatible:
  ...
  allOf:
  - if:
      properties:
        compatible:
          contains:
  ...


make dt_binding_check failed with the following error:
    $ make dt_binding_check DT_SCHEMA_FILES=3Drenesas,pci-rcar-gen2.yaml
      LINT    Documentation/devicetree/bindings
    ./Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml:115:=
1: [error] duplication of key "allOf" in mapping (key-duplicates)
      CHKDT   Documentation/devicetree/bindings/processed-schema.json
    Traceback (most recent call last):
      File "/home/hcodina/.local/bin/dt-doc-validate", line 25, in check_doc
        testtree =3D dtschema.load(filename, line_number=3Dline_number)
      File "/home/hcodina/.local/lib/python3.10/site-packages/dtschema/lib.=
py", line 912, in load
        return yaml.load(f.read())
      File "/home/hcodina/.local/lib/python3.10/site-packages/ruamel/yaml/m=
ain.py", line 434, in load
        return constructor.get_single_data()
      File "/home/hcodina/.local/lib/python3.10/site-packages/ruamel/yaml/c=
onstructor.py", line 121, in get_single_data
        return self.construct_document(node)
      File "/home/hcodina/.local/lib/python3.10/site-packages/ruamel/yaml/c=
onstructor.py", line 131, in construct_document
        for _dummy in generator:
      File "/home/hcodina/.local/lib/python3.10/site-packages/ruamel/yaml/c=
onstructor.py", line 674, in construct_yaml_map
        value =3D self.construct_mapping(node)
      File "/home/hcodina/.local/lib/python3.10/site-packages/ruamel/yaml/c=
onstructor.py", line 445, in construct_mapping
        return BaseConstructor.construct_mapping(self, node, deep=3Ddeep)
      File "/home/hcodina/.local/lib/python3.10/site-packages/ruamel/yaml/c=
onstructor.py", line 263, in construct_mapping
        if self.check_mapping_key(node, key_node, mapping, key, value):
      File "/home/hcodina/.local/lib/python3.10/site-packages/ruamel/yaml/c=
onstructor.py", line 294, in check_mapping_key
        raise DuplicateKeyError(*args)
    ruamel.yaml.constructor.DuplicateKeyError: while constructing a mapping
      in "<unicode string>", line 4, column 1
    found duplicate key "allOf" with value "[]" (original value: "[]")
      in "<unicode string>", line 115, column 1
   =20
    To suppress this check see:
        http://yaml.readthedocs.io/en/latest/api.html#duplicate-keys
   =20
   =20
    During handling of the above exception, another exception occurred:
   =20
    Traceback (most recent call last):
      File "/home/hcodina/.local/bin/dt-doc-validate", line 74, in <module>
        ret =3D check_doc(f)
      File "/home/hcodina/.local/bin/dt-doc-validate", line 30, in check_doc
        print(filename + ":", exc.path[-1], exc.message, file=3Dsys.stderr)
    AttributeError: 'DuplicateKeyError' object has no attribute 'path'
      SCHEMA  Documentation/devicetree/bindings/processed-schema.json
    /home/hcodina/project/xxxx/dev/linux/upstream_usb_host/Documentation/de=
vicetree/bindings/pci/renesas,pci-rcar-gen2.yaml: ignoring, error parsing f=
ile
      DTEX    Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.e=
xample.dts
    Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml: found=
 duplicate key "allOf" with value "[]" (original value: "[]")
    make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentat=
ion/devicetree/bindings/pci/renesas,pci-rcar-gen2.example.dts] Error 1
    make[1]: *** Deleting file 'Documentation/devicetree/bindings/pci/renes=
as,pci-rcar-gen2.example.dts'
    make: *** [Makefile:1401: dt_binding_check] Error 2
    [hcodina@localhost upstream_usb_host]$=20
   =20
    [hcodina@localhost upstream_usb_host]$ make ARCH=3Darm CROSS_COMPILE=3D=
/home/hcodina/toolchain/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf=
/bin/arm-linux-gnueabihf- dt_binding_check DT_SCHEMA_FILES=3Drenesas,pci-rc=
ar-gen2.yaml
      DTEX    Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.e=
xample.dts
    Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml: found=
 duplicate key "allOf" with value "[]" (original value: "[]")
    make[1]: *** [Documentation/devicetree/bindings/Makefile:26: Documentat=
ion/devicetree/bindings/pci/renesas,pci-rcar-gen2.example.dts] Error 1
    make[1]: *** Deleting file 'Documentation/devicetree/bindings/pci/renes=
as,pci-rcar-gen2.example.dts'
    make: *** [Makefile:1401: dt_binding_check] Error 2


Is having a 'allOf' for schemas inclusion and a 'allOf' for conditionnal
parts allowed ?


Regards,
Herv=C3=A9

