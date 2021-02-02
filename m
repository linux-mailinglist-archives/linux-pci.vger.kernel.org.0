Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C968B30BB52
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 10:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhBBJrV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 04:47:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229849AbhBBJq3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 04:46:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0F9664E94;
        Tue,  2 Feb 2021 09:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612259142;
        bh=/3wBee0pqs3JwOxQ0vT4NIdhUCan+Iy4DyZ9FHq3dB0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rfy1aCZbgeLpvEp1bjyoE6tPtFevMedzHcR0QMRWt1O6DmZnj16nIJE035rz0rmM2
         lG8tVKFO0fz3E60keLy5bgMs08UYfYQAIDUfz4NYHnD9VOdT11jOLblF8Uyo7kGY4k
         TkEe+yH1aMSctZ+CqmRA7rs34bzE8tzIwfGP78YBHlYIvUKVWk3Se81kawhb4R9TUY
         MpLqeur9Kok+XFakNdPG2qZ2qiAt3ftGYAk3dCFp4B00jitmDtoPtB460piwIPnrKx
         20sFhLQi367Rob2m3tATzDJrRxFvM8qiSIOkQwO+u7k9D14knrb0omz28lkEQXB4c7
         7bG4VML52erNQ==
Date:   Tue, 2 Feb 2021 10:45:37 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH RFC 2/2] dt: pci: kirin-pcie.txt: convert it to yaml
Message-ID: <20210202104537.0ad3f8a7@coco.lan>
In-Reply-To: <CAL_JsqJrkvkBMzyAf_Wbv8tbEWbfTwjgwLYKf=Cr8S5mo_URfQ@mail.gmail.com>
References: <cover.1611645945.git.mchehab+huawei@kernel.org>
        <30795b4a1cea54292d49881d5843e2bdbc496e4d.1611645945.git.mchehab+huawei@kernel.org>
        <CAL_JsqJrkvkBMzyAf_Wbv8tbEWbfTwjgwLYKf=Cr8S5mo_URfQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Tue, 26 Jan 2021 09:49:18 -0600
Rob Herring <robh+dt@kernel.org> escreveu:

> On Tue, Jan 26, 2021 at 1:35 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Convert the file into a JSON description at the yaml format.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../bindings/pci/hisilicon,kirin-pcie.yaml    | 98 +++++++++++++++++++
> >  .../devicetree/bindings/pci/kirin-pcie.txt    | 50 ----------
> >  MAINTAINERS                                   |  2 +-
> >  3 files changed, 99 insertions(+), 51 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> > new file mode 100644
> > index 000000000000..8d8112b2aca0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> > @@ -0,0 +1,98 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pci/hisilicon,kirin-pcie.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: HiSilicon Kirin SoCs PCIe host DT description
> > +
> > +maintainers:
> > +  - Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > +
> > +description: |
> > +  Kirin PCIe host controller is based on the Synopsys DesignWare PCI core.
> > +  It shares common functions with the PCIe DesignWare core driver and
> > +  inherits common properties defined in
> > +  Documentation/devicetree/bindings/pci/designware-pcie.yaml.  
> 
> Drop this and move the $ref to here.

That doesn't pass at dt_binding_check. If I do either:

  allOf:
    - $ref: snps,pcie.yaml#

or:

  allOf:
    - $ref: /schemas/pci/pci-bus.yaml#
    - $ref: snps,pcie.yaml#

Then dt-binding-check starts to think that this DT is for a pinctrl:

	make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
	  LINT    Documentation/devicetree/bindings
	  DTEX    Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dts
	./Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml:10:4: [warning] wrong indentation: expected 2 but found 3 (indentation)
	./Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml:102:10: [warning] wrong indentation: expected 10 but found 9 (indentation)
	  CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
	  SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
	  DTC     Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml
	  CHECK   Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml
	.../Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.example.dt.yaml: pcie@f4000000: '#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'interrupt-names', 'interrupts', 'num-lanes', 'ranges', 'reg-names', 'reset-gpios' do not match any of the regexes: 'pinctrl-[0-9]+'
		From schema: .../Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml

No idea why. Perhaps something broken at pinctrl schema?

Thanks,
Mauro
