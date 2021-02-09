Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A676D315584
	for <lists+linux-pci@lfdr.de>; Tue,  9 Feb 2021 19:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbhBIRz0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 12:55:26 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:34275 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbhBIRqk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Feb 2021 12:46:40 -0500
Received: by mail-ot1-f51.google.com with SMTP id y11so18262711otq.1;
        Tue, 09 Feb 2021 09:46:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g9ou2r2uOk1p7jZj1nuZ6tXYHwtGvuF9zt0EteXz9iI=;
        b=iXHZzXnB6sashZ2DlJUPYnMIOv70QLKU6UULvHAg3AQTcu4ly/wjnFYBkTIRKoSQ9e
         a62KyCalEB2ycucSM9DxQlyM+7m5RIrs+QbZG7c2xQ9mcm0GcEjiv0MCqhevlCwCo7PT
         ctTxnaVp4fzuu/3fH7ss/LZO26KUWIWL+NrYU8X5pZeP8ix1JQB9XmxGvOBlaoeUuSef
         UgAPgt7Lp8CT4DMYZkpX0Eu4dYsGJlW2XglUizhNAa7lK56ExkcznB782eTdkUPEYpg5
         jzanLnse7lUjAf2cAn93F2xTJ/yB3+GjuMKrU+yoTmkigscHzAd1eLdXa0yrmCFYrUao
         2J3g==
X-Gm-Message-State: AOAM530r2NRC0C85Pxfvfh/j8pgzmgQLENEeSVPqBnLPde+C+n05lfgY
        zeWKWFv7bb5t47KijtN21A==
X-Google-Smtp-Source: ABdhPJyD9wSsTphvRQqPgcANSdzEQZOZFn0KtsoMnVgF3Lga/h8BDQMhXRKkLBVeCJe9FLssgiVuJA==
X-Received: by 2002:a9d:4c83:: with SMTP id m3mr17146800otf.353.1612892759469;
        Tue, 09 Feb 2021 09:45:59 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m22sm4293003ooj.43.2021.02.09.09.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 09:45:54 -0800 (PST)
Received: (nullmailer pid 4020954 invoked by uid 1000);
        Tue, 09 Feb 2021 17:45:53 -0000
Date:   Tue, 9 Feb 2021 11:45:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] dt: pci: kirin-pcie.txt: convert it to yaml
Message-ID: <20210209174553.GA4017550@robh.at.kernel.org>
References: <cover.1611645945.git.mchehab+huawei@kernel.org>
 <30795b4a1cea54292d49881d5843e2bdbc496e4d.1611645945.git.mchehab+huawei@kernel.org>
 <CAL_JsqJrkvkBMzyAf_Wbv8tbEWbfTwjgwLYKf=Cr8S5mo_URfQ@mail.gmail.com>
 <20210202104537.0ad3f8a7@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202104537.0ad3f8a7@coco.lan>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 02, 2021 at 10:45:37AM +0100, Mauro Carvalho Chehab wrote:
> Em Tue, 26 Jan 2021 09:49:18 -0600
> Rob Herring <robh+dt@kernel.org> escreveu:
> 
> > On Tue, Jan 26, 2021 at 1:35 AM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> > >
> > > Convert the file into a JSON description at the yaml format.
> > >
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  .../bindings/pci/hisilicon,kirin-pcie.yaml    | 98 +++++++++++++++++++
> > >  .../devicetree/bindings/pci/kirin-pcie.txt    | 50 ----------
> > >  MAINTAINERS                                   |  2 +-
> > >  3 files changed, 99 insertions(+), 51 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> > > new file mode 100644
> > > index 000000000000..8d8112b2aca0
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> > > @@ -0,0 +1,98 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/pci/hisilicon,kirin-pcie.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: HiSilicon Kirin SoCs PCIe host DT description
> > > +
> > > +maintainers:
> > > +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > +
> > > +description: |
> > > +  Kirin PCIe host controller is based on the Synopsys DesignWare PCI core.
> > > +  It shares common functions with the PCIe DesignWare core driver and
> > > +  inherits common properties defined in
> > > +  Documentation/devicetree/bindings/pci/designware-pcie.yaml.  
> > 
> > Drop this and move the $ref to here.
> 
> That doesn't pass at dt_binding_check. If I do either:
> 
>   allOf:
>     - $ref: snps,pcie.yaml#
> 
> or:
> 
>   allOf:
>     - $ref: /schemas/pci/pci-bus.yaml#
>     - $ref: snps,pcie.yaml#
> 
> Then dt-binding-check starts to think that this DT is for a pinctrl:
> 
> 	make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> 	  LINT    Documentation/devicetree/bindings
> 	  DTEX    Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dts
> 	./Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml:10:4: [warning] wrong indentation: expected 2 but found 3 (indentation)
> 	./Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml:102:10: [warning] wrong indentation: expected 10 but found 9 (indentation)
> 	  CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
> 	  SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
> 	  DTC     Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml
> 	  CHECK   Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml
> 	.../Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml: pcie@f4000000: '#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'interrupt-names', 'interrupts', 'num-lanes', 'ranges', 'reg-names', 'reset-gpios' do not match any of the regexes: 'pinctrl-[0-9]+'
> 		From schema: .../Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> 
> No idea why. Perhaps something broken at pinctrl schema?

You'll need to use unevaluatedProperties instead of 
additionalProperties.

Rob
