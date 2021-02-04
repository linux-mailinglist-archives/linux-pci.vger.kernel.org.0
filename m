Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A8630F662
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 16:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbhBDPdG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 10:33:06 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:44999 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbhBDPVs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 10:21:48 -0500
Received: by mail-oo1-f44.google.com with SMTP id n19so827328ooj.11;
        Thu, 04 Feb 2021 07:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=P7JarkNG0Jr4x/lj1itZ7BSEgkDgo9dz5ORdHCgfdk8=;
        b=Zo0NmWhlaKEdDnz60vg4clm2uM+qfG+TmAsZm9uWAvERLScDh4aCBssmqQmhsnkvXV
         /KQr2iMRTO/5k7QcFS6a7Wmgc4frscHFgJ/Z49Spim8GruSrTb3q5oGm2o/AthpH6U6a
         Hu06U+3yLqV/fGfYkgWDEzNGkzrRZ2k7YNkUb1CaIGUEPIbiLPMfQiaG+1mVl7CznLH+
         QrWpqhtMpGgkBss750HPJDA9UsMCWfSHsT7A+ekoJqIA2Y595xd9RyZeA/ApKwpiy8dD
         0JqJCXvBMJ75aDILVkggF62iWKAVWqWt34UGrPUQU4e9F4fypVNbtyAqqtT5sFmgLdAs
         6EXQ==
X-Gm-Message-State: AOAM533IhD3MzlLMZgW2JJ2jxZvgpOGejP280jVFylV82VZMS/tWJ7Ax
        3At+zr8vNQY/6C3jFuEKlw==
X-Google-Smtp-Source: ABdhPJzM3kHORViPede34wMD/uUSw98pduiPbhxgxRYTa/nSc0pWIAtPIW3tqD1eZiyu3WZiHYs1VA==
X-Received: by 2002:a4a:d50d:: with SMTP id m13mr52826oos.2.1612452060739;
        Thu, 04 Feb 2021 07:21:00 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 33sm1139125ota.69.2021.02.04.07.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 07:20:59 -0800 (PST)
Received: (nullmailer pid 452035 invoked by uid 1000);
        Thu, 04 Feb 2021 15:20:57 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@axis.com, Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        devicetree@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-omap@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        linux-amlogic@lists.infradead.org,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
In-Reply-To: <bf3d0a5683c50062a55182922daeec5cfdbe00cc.1612335031.git.mchehab+huawei@kernel.org>
References: <cover.1612335031.git.mchehab+huawei@kernel.org> <bf3d0a5683c50062a55182922daeec5cfdbe00cc.1612335031.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH v2 01/11] doc: bindings: PCI: designware-pcie.txt: convert it to YAML
Date:   Thu, 04 Feb 2021 09:20:57 -0600
Message-Id: <1612452057.699681.452034.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 03 Feb 2021 08:01:45 +0100, Mauro Carvalho Chehab wrote:
> Convert the file into a DT schema.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../bindings/pci/amlogic,meson-pcie.txt       |   4 +-
>  .../bindings/pci/axis,artpec6-pcie.txt        |   2 +-
>  .../bindings/pci/designware-pcie.txt          |  77 ----------
>  .../bindings/pci/fsl,imx6q-pcie.txt           |   2 +-
>  .../bindings/pci/hisilicon-histb-pcie.txt     |   2 +-
>  .../bindings/pci/hisilicon-pcie.txt           |   2 +-
>  .../devicetree/bindings/pci/kirin-pcie.txt    |   2 +-
>  .../bindings/pci/layerscape-pci.txt           |   2 +-
>  .../bindings/pci/nvidia,tegra194-pcie.txt     |   4 +-
>  .../devicetree/bindings/pci/pci-armada8k.txt  |   2 +-
>  .../devicetree/bindings/pci/pci-keystone.txt  |  10 +-
>  .../devicetree/bindings/pci/pcie-al.txt       |   2 +-
>  .../devicetree/bindings/pci/qcom,pcie.txt     |  14 +-
>  .../bindings/pci/samsung,exynos-pcie.yaml     |   2 +-
>  .../devicetree/bindings/pci/snps,pcie.yaml    | 139 ++++++++++++++++++
>  .../pci/socionext,uniphier-pcie-ep.yaml       |   2 +-
>  .../devicetree/bindings/pci/ti-pci.txt        |   4 +-
>  .../devicetree/bindings/pci/uniphier-pcie.txt |   2 +-
>  MAINTAINERS                                   |   2 +-
>  19 files changed, 169 insertions(+), 107 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/snps,pcie.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,pcie.yaml: properties:snps,enable-cdm-check: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
	Additional properties are not allowed ('$ref' was unexpected)
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,pcie.yaml: properties:snps,enable-cdm-check: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
	'/schemas/types.yaml#definitions/flag' does not match 'types.yaml#/definitions/'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,pcie.yaml: ignoring, error in schema: properties: snps,enable-cdm-check
warning: no schema found in file: ./Documentation/devicetree/bindings/pci/snps,pcie.yaml

See https://patchwork.ozlabs.org/patch/1435145

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

