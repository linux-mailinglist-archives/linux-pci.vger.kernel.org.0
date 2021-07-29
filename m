Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5E03DA76C
	for <lists+linux-pci@lfdr.de>; Thu, 29 Jul 2021 17:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237661AbhG2PWA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 11:22:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237851AbhG2PV3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Jul 2021 11:21:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78F5660F6F;
        Thu, 29 Jul 2021 15:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627572028;
        bh=0qRItNNqVu8zfNEhkI6lQ1f99lsFwPpdEwh6oAob7zg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LgOdWV6wH+oSwuXgfbHVWS5VuXIOmPutB22ujAKjF2LYIUXWe3lghgaLG1y+YnbSj
         jPSpbu9CapaCtZSwvP9nNo8SN7EsEMQJoma6RaOhB++QQ6gb9KztT4xFcitxW6ESeS
         NcHHmfMf1MHTPdmDMMpsK3RKdjSfJnJ8RWsGe7AhHmiN9DKTzBixJjPgM4RUuhmuxy
         6SWaDZvQ1Lv3d368fSVjJA+5OIIy8huEQvA5Ui7g9dyXpLcOn9yWkOkYB8eWpp491K
         gwbxeweG237cCEYkEF5rzDM0YgJsQzAuOz3A5k7UhLlbLeISRaGB2NeQQ8J0Sfyf4o
         ffv+dfwDlbcOA==
Received: by mail-ej1-f42.google.com with SMTP id go31so11315252ejc.6;
        Thu, 29 Jul 2021 08:20:28 -0700 (PDT)
X-Gm-Message-State: AOAM532lX434hLhoA6KihgIOu20tbl1BfkzOtRidDeYsAx35mfZ5Fifd
        bTHS3BeMLEiGNx6siGbkXhYJZrd+O/IGYhhzrw==
X-Google-Smtp-Source: ABdhPJzIzmyTxtOz/wextmHAw+KU5WQry2z11p9/WrOUFwGXVTXlS25TsvwKMcGrTXjTJ+rAWonhQ+kNbp+O9zDwciY=
X-Received: by 2002:a17:906:95ce:: with SMTP id n14mr4797386ejy.130.1627572027002;
 Thu, 29 Jul 2021 08:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627559126.git.mchehab+huawei@kernel.org> <2cf7bd80d0b54f7658a64febf79d3a36e70aba86.1627559126.git.mchehab+huawei@kernel.org>
In-Reply-To: <2cf7bd80d0b54f7658a64febf79d3a36e70aba86.1627559126.git.mchehab+huawei@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 29 Jul 2021 09:20:15 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+JgWMf8XPdHQ9GRdA+7EODJ47vwuz0jGkkyeETZPXz9Q@mail.gmail.com>
Message-ID: <CAL_Jsq+JgWMf8XPdHQ9GRdA+7EODJ47vwuz0jGkkyeETZPXz9Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] dt-bindings: PCI: kirin: Add support for Kirin970
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 29, 2021 at 5:56 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Add a new compatible, plus the new bindings needed by
> HiKey970 board.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/pci/hisilicon,kirin-pcie.yaml    | 61 ++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> index 90cab09e8d4b..bb0c3a081d68 100644
> --- a/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
> @@ -24,11 +24,13 @@ properties:
>      contains:
>        enum:
>          - hisilicon,kirin960-pcie
> +        - hisilicon,kirin970-pcie
>
>    reg:
>      description: |
>        Should contain dbi, apb, config registers location and length.
> -      For HiKey960, it should also contain phy.
> +      For HiKey960, it should also contain phy. All other devices
> +      should use a separate phy driver.
>      minItems: 3
>      maxItems: 4
>
> @@ -47,6 +49,7 @@ examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/clock/hi3660-clock.h>
> +    #include <dt-bindings/clock/hi3670-clock.h>
>
>      soc {
>        #address-cells = <2>;
> @@ -83,4 +86,60 @@ examples:
>          clock-names = "pcie_phy_ref", "pcie_aux", "pcie_apb_phy",
>                        "pcie_apb_sys", "pcie_aclk";
>        };
> +
> +      pcie@f5000000 {
> +        compatible = "hisilicon,kirin970-pcie";
> +        reg = <0x0 0xf4000000 0x0 0x1000000>,
> +              <0x0 0xfc180000 0x0 0x1000>,
> +              <0x0 0xf5000000 0x0 0x2000>;
> +        reg-names = "dbi", "apb", "config";
> +        bus-range = <0x0  0x1>;
> +        msi-parent = <&its_pcie>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        device_type = "pci";
> +        phys = <&pcie_phy>;
> +        ranges = <0x02000000 0x0 0x00000000
> +                  0x0 0xf6000000
> +                  0x0 0x02000000>;
> +        num-lanes = <1>;
> +        #interrupt-cells = <1>;
> +        interrupts = <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "msi";
> +        interrupt-map-mask = <0 0 0 7>;
> +        interrupt-map = <0x0 0 0 1 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0x0 0 0 2 &gic GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0x0 0 0 3 &gic GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
> +                        <0x0 0 0 4 &gic GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
> +        pcie@4,0 { // Lane 4: M.2
> +          reg = <0 0 0 0 0>;
> +          compatible = "pciclass,0604";
> +          device_type = "pci";
> +          reset-gpios = <&gpio7 1 0>;
> +          clkreq-gpios = <&gpio27 3 0 >;

Looking at the schematics some more, this is not right. CLKREQ# is an
input from the device, and they are not connected to any GPIO (just
pulled high) on hikey970. These GPIOs are simply clock enables and
very much specific to hikey. So I'd call this 'hisilicon,clken-gpios'
and you can just stick them in the host bridge node.

I think the way the board should have been designed is the CLKREQ#
signals to the clock driver chip OE signals. Then there'd be no s/w
control needed.

Rob
