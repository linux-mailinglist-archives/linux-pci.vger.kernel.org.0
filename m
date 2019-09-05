Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7619CAAD01
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 22:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389796AbfIEUbm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 16:31:42 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35347 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387491AbfIEUbm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Sep 2019 16:31:42 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so3089316oii.2;
        Thu, 05 Sep 2019 13:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cs7pSggiA638/NENn3nXpVetu5HgwNJEQ1fDCNSetg4=;
        b=eMG14L3nTkKPDjnQt3Il0NaBunF7hnbOLozDIvNta4SyW4fjwipSZFTlImrxg1zHY0
         0Onwwwa0G8XUEDs44pARBjafSWrKm+EBrySFUIllP7h1P9ahZ6Kl1bfJja1YVVYhNT1b
         VmddePJa8cOpZje6DdalRuzzGqbXEu3jhgpWHdlZm6g1oXAByda9nbNxEIvgeO5vbjT7
         fi/9y6+Z1zxnqvu+y9wz6tzOd9CJVLCjRSYq5O8t2+1cthvMYhwbkjGQHvRbR9xYwlba
         nz3EOHFca39PoZAfRb9Whqb2DXC85+smqWFnUtn5VCoXnqhp6BA6ze4ytwKNJ7DfII/l
         ilsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cs7pSggiA638/NENn3nXpVetu5HgwNJEQ1fDCNSetg4=;
        b=YBHWhl3EwmhPfE/YX08LTSiacKiiaxb7Z286AIZGF3+FsbUEKuTsoe9tCdkx2DiOfw
         wwtjBzxgwSSX71zDE9vOrlZE7rNs29cz6RdeEVvCaQ4WvsdDQMNWpLMH5hEn1LIMDPJ3
         rj8fvSrnmA5xm84RIrvaBlxU3zHyVoPM/GYyHPnV+8uk3WKzUwVgrnnBjwsTykQG7EGI
         SJxIO7AC0Jbuk9/zPZj3MV2x/HxIS7zWIWJOgq9xQM51Fw83vz0pDvqTLyxJSIhB+QQ6
         PdDjpUJV2l+VWV3LGJ2SEed69X/hkIhzUrdyF0vOFGx2OayU3FmTPfubkOeCrVs+cu4+
         muCQ==
X-Gm-Message-State: APjAAAXV/1R/TdLEMVSo9x8gn8L2NMAAWODI2fe6fAGt/4TLSWEI+Ale
        828ZHpRA80kIjuPbjsspkRB7WBqBryyxYfQottM=
X-Google-Smtp-Source: APXvYqwUKj9QVoY719m4jv2mk0by7PXeu9zkQRWV7OtiqrYGrW3CNbjwsr5yaUuW4/iaHpW7DaBKGwSwHyEmopWn4Fo=
X-Received: by 2002:a05:6808:b14:: with SMTP id s20mr4258444oij.15.1567715500998;
 Thu, 05 Sep 2019 13:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1567585181.git.eswara.kota@linux.intel.com> <fe9549470bc06ea0d0dfc80f46a579baa49b911a.1567585181.git.eswara.kota@linux.intel.com>
In-Reply-To: <fe9549470bc06ea0d0dfc80f46a579baa49b911a.1567585181.git.eswara.kota@linux.intel.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 5 Sep 2019 22:31:29 +0200
Message-ID: <CAFBinCC5SH5OSUqOkLQhE2o7g5OhSuB_PBjsv93U2P=FNS5oPw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: intel: Add YAML schemas for the
 PCIe RC controller
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        linux-pci@vger.kernel.org, hch@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dilip,

On Wed, Sep 4, 2019 at 12:11 PM Dilip Kota <eswara.kota@linux.intel.com> wrote:
[...]
> +properties:
> +  compatible:
> +    const: intel,lgm-pcie
should we add the "snps,dw-pcie" here (and in the example below) as well?
(this is what for example
Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt does)

[...]
> +  phy-names:
> +    const: pciephy
the most popular choice in Documentation/devicetree/bindings/pci/ is "pcie-phy"
if Rob is happy with "pciephy" (which is already part of two other
bindings) then I'm happy with "pciephy" as well

> +  num-lanes:
> +    description: Number of lanes to use for this port.
are there SoCs with more than 2 lanes?
you can list the allowed values in an enum so "num-lanes = <16>"
causes an error when someone accidentally has this in their .dts (and
runs the dt-bindings validation)

[...]
> +  reset-assert-ms:
maybe add:
  $ref: /schemas/types.yaml#/definitions/uint32

> +    description: |
> +      Device reset interval in ms.
> +      Some devices need an interval upto 500ms. By default it is 100ms.
> +
> +required:
> +  - compatible
> +  - device_type
> +  - reg
> +  - reg-names
> +  - ranges
> +  - resets
> +  - clocks
> +  - phys
> +  - phy-names
> +  - reset-gpios
> +  - num-lanes
> +  - linux,pci-domain
> +  - interrupts
> +  - interrupt-map
> +  - interrupt-map-mask
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pcie10:pcie@d0e00000 {
> +      compatible = "intel,lgm-pcie";
> +      device_type = "pci";
> +      #address-cells = <3>;
> +      #size-cells = <2>;
> +      reg = <
> +            0xd0e00000 0x1000
> +            0xd2000000 0x800000
> +            0xd0a41000 0x1000
> +            >;
> +      reg-names = "dbi", "config", "app";
> +      linux,pci-domain = <0>;
> +      max-link-speed = <4>;
> +      bus-range = <0x00 0x08>;
> +      interrupt-parent = <&ioapic1>;
> +      interrupts = <67 1>;
> +      #interrupt-cells = <1>;
> +      interrupt-map-mask = <0 0 0 0x7>;
> +      interrupt-map = <0 0 0 1 &ioapic1 27 1>,
> +                      <0 0 0 2 &ioapic1 28 1>,
> +                      <0 0 0 3 &ioapic1 29 1>,
> +                      <0 0 0 4 &ioapic1 30 1>;
is the "1" in the interrupts and interrupt-map properties IRQ_TYPE_EDGE_RISING?
you can use these macros in this example as well, see
Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml for
example


Martin
