Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D973230E82
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 17:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbgG1PyO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 11:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731164AbgG1PyO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 11:54:14 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62C6D20809;
        Tue, 28 Jul 2020 15:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595951653;
        bh=geGOpmuJBayngowsjLPNX2sbYfZomv1ccf9LWNqVwKM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=En2lNNu0u7wbRApCKOaffuq6dP9kx4/IPMKFXpxUTW+HRDP84Fv0Pu2Rw8DCVsS6/
         O4dZZP49UyoGnI0XeoWRDYWIr8ksIoMdMMFBa0A6CiJQTUVBiy54CRPFJ1GBdRsZkz
         +oARxSml34pPR4hJaCztC+/w4pZJ3u3ptx2tn3lk=
Received: by mail-ot1-f43.google.com with SMTP id h1so15201141otq.12;
        Tue, 28 Jul 2020 08:54:13 -0700 (PDT)
X-Gm-Message-State: AOAM5306GGPyMXRYKis696z7sWDMtgO2gHkpg0hzg12IdlBAWtpQ+byI
        zg6BwUaKyKafGRttnRJ9tDWQ8lnfOUSv9pnSiA==
X-Google-Smtp-Source: ABdhPJx82k8TTvlFZONBnoZqE1yfGmt/Rj673jv6bffnQQRS5e4kUUr99MautRkzOYsWD25L09MzQ/hMWZDy0tuxnvw=
X-Received: by 2002:a9d:46c:: with SMTP id 99mr25143787otc.192.1595951652672;
 Tue, 28 Jul 2020 08:54:12 -0700 (PDT)
MIME-Version: 1.0
References: <1595776013-12877-1-git-send-email-sivaprak@qti.qualcomm.com> <CAL_Jsq+-rwG73mEkYmMQcnxHoBpbFMWHKDvzUK=6-fMAo77-9w@mail.gmail.com>
In-Reply-To: <CAL_Jsq+-rwG73mEkYmMQcnxHoBpbFMWHKDvzUK=6-fMAo77-9w@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 28 Jul 2020 09:54:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJU81U5CNSia3Lrzwb2VpPy3YMK=tJfXgU49TuGn1eRyQ@mail.gmail.com>
Message-ID: <CAL_JsqJU81U5CNSia3Lrzwb2VpPy3YMK=tJfXgU49TuGn1eRyQ@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: pci: convert QCOM pci bindings to YAML
To:     Sivaprakash Murugesan <sivaprak@qti.qualcomm.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 28, 2020 at 9:27 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Sun, Jul 26, 2020 at 9:07 AM Sivaprakash Murugesan
> <sivaprak@qti.qualcomm.com> wrote:
> >
> > From: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> >
> > Convert QCOM pci bindings to YAML schema
> >
> > Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> > ---
> > [v2]
> >   - Referenced pci-bus.yaml
> >   - removed duplicate properties already referenced by pci-bus.yaml
> >   - Addressed comments from Rob
> >  .../devicetree/bindings/pci/qcom,pcie.txt          | 330 ---------------
> >  .../devicetree/bindings/pci/qcom,pcie.yaml         | 447 +++++++++++++++++++++
> >  2 files changed, 447 insertions(+), 330 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.txt
> >  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>
>
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > new file mode 100644
> > index 000000000000..ddb84f49ac1c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> > @@ -0,0 +1,447 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/pci/qcom,pcie.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Qualcomm PCI express root complex
> > +
> > +maintainers:
> > +  - Sivaprakash Murugesan <sivaprak@codeaurora.org>
> > +
> > +description:
> > +  QCOM PCIe controller uses Designware IP with Qualcomm specific hardware
> > +  wrappers.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,pcie-apq8064
> > +      - qcom,pcie-apq8084
> > +      - qcom,pcie-ipq4019
> > +      - qcom,pcie-ipq8064
> > +      - qcom,pcie-ipq8074
> > +      - qcom,pcie-msm8996
> > +      - qcom,pcie-qcs404
> > +      - qcom,pcie-sdm845
> > +
> > +  reg:
> > +    description: Register ranges as listed in the reg-names property
>
> Can drop this.
>
> > +    maxItems: 4
> > +
> > +  reg-names:
> > +    items:
> > +      - const: dbi
> > +      - const: elbi
> > +      - const: parf
> > +      - const: config
> > +
> > +  ranges:
> > +    maxItems: 2
> > +
> > +  interrupts:
> > +    items:
> > +      - description: MSI interrupts
> > +
> > +  interrupt-names:
> > +    const: msi
> > +
> > +  "#interrupt-cells":
>
> In pci-bus.yaml, so you can drop.
>
> > +    const: 1
> > +
> > +  interrupt-map-mask:
>
> In pci-bus.yaml, so you can drop.

Actually, you'll need to do 'interrupt-map-mask: true' on these.

>
> > +    items:
> > +      - description: standard PCI properties to define mapping of PCIe
> > +                     interface to interrupt numbers.
> > +
> > +  interrupt-map:
> > +    maxItems: 4
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 7
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 7
> > +
> > +  resets:
> > +    minItems: 1
> > +    maxItems: 12
> > +
> > +  reset-names:
> > +    minItems: 1
> > +    maxItems: 12
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  vdda-supply:
> > +    description: phandle to power supply
> > +
> > +  vdda_phy-supply:
> > +    description: phandle to the power supply to PHY
> > +
> > +  vdda_refclk-supply:
> > +    description: phandle to power supply for ref clock generator
> > +
> > +  vddpe-3v3-supply:
> > +    description: PCIe endpoint power supply
> > +
> > +  phys:
> > +    maxItems: 1
> > +    items:
> > +      - description: phandle to the PHY block
>
> Can drop 'items'.
>
> With those fixed,
>
> Reviewed-by: Rob Herring <robh@kernel.org>
