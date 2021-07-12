Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5213C5E08
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jul 2021 16:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhGLOPu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Jul 2021 10:15:50 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:37730 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbhGLOPt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Jul 2021 10:15:49 -0400
Received: by mail-io1-f53.google.com with SMTP id l18so17849862iow.4;
        Mon, 12 Jul 2021 07:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=h/6h0UaJMVg2aWVUlChzhWyuF5oxMGeyK9DMCIo1kac=;
        b=HRFk4AA1/h0VKpOeA2lIKQKw6xyvd1+h/qgAgJWG3EnA6DNCoAlFWXCzyk5rzY4HGr
         5ND72s/0eslgib1hC88C1U90DxjWG/FAYXYv8P3UzL0NHy90kClzK1v9vIe6AlNOyhhR
         XanPohNdcjDJ4kQlV1yJpeV0qdo0NROuszEXqevmE5YWrqAI0azBwANxWKZHOgsLyDZl
         ajs/hOOlE+npasydfCYOiCLIwrt/Q1mVh/FGbFdKhdgidWHHUtD1k65Q0pUHJclVm5Eh
         3XyPL5KmNmySAqu8lyfj9EAU2eETwwWDzuT3Gino4PPJNfcWloF/PAK0OQOgX+zK/WhQ
         mqdw==
X-Gm-Message-State: AOAM530bZ3fIXMyIzHSUuVh2MKnWdAtB7GLIzejPxQbgpdL5AR9fxc05
        rXiO7I5tzL9mDmZ5wGpHVw==
X-Google-Smtp-Source: ABdhPJzuceYJTODmyK39U/Ix01ehe/gL8uY9ss4zcLfaiWqtvKuO9aUo1PaMhbGijJhZFJrCm9lhCw==
X-Received: by 2002:a5e:9306:: with SMTP id k6mr41405170iom.157.1626099180376;
        Mon, 12 Jul 2021 07:13:00 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z70sm7921281iof.13.2021.07.12.07.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 07:12:59 -0700 (PDT)
Received: (nullmailer pid 1850542 invoked by uid 1000);
        Mon, 12 Jul 2021 14:12:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        mauro.chehab@huawei.com, linux-arm-msm@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>, linuxarm@huawei.com,
        linux-arm-kernel@axis.com, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Chocron <jonnyc@amazon.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-omap@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Andy Gross <agross@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Shawn Guo <shawnguo@kernel.org>
In-Reply-To: <fa846c83165894accdac1715c3fddfbdcb060958.1625838920.git.mchehab+huawei@kernel.org>
References: <cover.1625838920.git.mchehab+huawei@kernel.org> <fa846c83165894accdac1715c3fddfbdcb060958.1625838920.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: designware-pcie.txt: convert it to yaml
Date:   Mon, 12 Jul 2021 08:12:53 -0600
Message-Id: <1626099173.609840.1850541.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 09 Jul 2021 15:57:42 +0200, Mauro Carvalho Chehab wrote:
> Convert the file to DT schema.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/pci/amlogic,meson-pcie.txt       |   4 +-
>  .../bindings/pci/axis,artpec6-pcie.txt        |   2 +-
>  .../bindings/pci/designware-pcie.txt          |  77 ----------
>  .../bindings/pci/fsl,imx6q-pcie.txt           |   2 +-
>  .../bindings/pci/hisilicon-histb-pcie.txt     |   2 +-
>  .../devicetree/bindings/pci/kirin-pcie.txt    |   2 +-
>  .../bindings/pci/layerscape-pci.txt           |   2 +-
>  .../bindings/pci/nvidia,tegra194-pcie.txt     |   4 +-
>  .../devicetree/bindings/pci/pci-armada8k.txt  |   2 +-
>  .../devicetree/bindings/pci/pcie-al.txt       |   2 +-
>  .../devicetree/bindings/pci/qcom,pcie.txt     |  14 +-
>  .../bindings/pci/samsung,exynos-pcie.yaml     |   2 +-
>  .../bindings/pci/sifive,fu740-pcie.yaml       |   2 +-
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml | 135 ++++++++++++++++++
>  .../pci/socionext,uniphier-pcie-ep.yaml       |   2 +-
>  .../devicetree/bindings/pci/ti-pci.txt        |   4 +-
>  .../devicetree/bindings/pci/uniphier-pcie.txt |   2 +-
>  MAINTAINERS                                   |   2 +-
>  18 files changed, 160 insertions(+), 102 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dt.yaml: pcie@d0e00000: '#address-cells', '#interrupt-cells', '#size-cells', 'bus-range', 'clocks', 'device_type', 'interrupt-map', 'interrupt-map-mask', 'linux,pci-domain', 'max-link-speed', 'phy-names', 'phys', 'ranges', 'reset-assert-ms', 'reset-gpios', 'resets' do not match any of the regexes: 'pcie?@[0-9a-f]+$', 'pcie?_ep@[0-9a-f]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dt.yaml: pcie@dfc00000: '#address-cells', '#interrupt-cells', '#size-cells', 'device_type', 'interrupts', 'ranges' do not match any of the regexes: 'pcie?@[0-9a-f]+$', 'pcie?_ep@[0-9a-f]+$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
\ndoc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/pci/pci-keystone.txt: Documentation/devicetree/bindings/pci/designware-pcie.txt
Documentation/devicetree/bindings/pci/pci-keystone.txt: Documentation/devicetree/bindings/pci/designware-pcie.txt
Documentation/devicetree/bindings/pci/pci-keystone.txt: Documentation/devicetree/bindings/pci/designware-pcie.txt
Documentation/devicetree/bindings/pci/pci-keystone.txt: Documentation/devicetree/bindings/pci/designware-pcie.txt
Documentation/devicetree/bindings/pci/pci-keystone.txt: Documentation/devicetree/bindings/pci/designware-pcie.txt
MAINTAINERS: Documentation/devicetree/bindings/pci/designware-pcie.txt

See https://patchwork.ozlabs.org/patch/1503171

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

