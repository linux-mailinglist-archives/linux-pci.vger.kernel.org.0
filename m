Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A5E30C84F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 18:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbhBBRrz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 12:47:55 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:45119 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbhBBRpm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 12:45:42 -0500
Received: by mail-ot1-f45.google.com with SMTP id n42so20625703ota.12;
        Tue, 02 Feb 2021 09:45:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=dXcV2lusAKjpXaSjnWl/fIkigGZVjdMH0wGYu3s5F9U=;
        b=rEWf50QU9nJKa9FiBZqL558aMY84huNuzE7Xo4Mh1cOQi6tKdzXwPOuBF/gVNBsTzu
         Fv6y7eKK93cJ6KQe7xzgLP3sIbBWZXifO5xHFtSiO0hIRLkZY32bU5244isZdzQWLHJn
         GoqIWzfJBSjY4do1ryn05Xj+oLK9wpIYiU6lFDXUZHCEEcPx3G9uQBEaONlgU1UNCG9Q
         ZmH6XNrE2ptnpihGu8UZMpBsmoOiAOd0UTyn6lWmRuqHSou3jGNgnU5XTTkWCm7eZdk0
         2FODmQ3MWgq/Slhqk3jNEBpmwf1SKWqOSIjB+ZxoB8z5U/Tb6e8+IZbcnNdM58bku7i3
         St/A==
X-Gm-Message-State: AOAM531I5qDEF8RrqSpSpuyrQH6ZlqFKFap8qtgEktvnIzvYDqSbFH3E
        rU22CIVvuM4Jholl0+MhPg==
X-Google-Smtp-Source: ABdhPJwFA1zAuUMqn+6HziXpCsNLVDtNJm8XRkxO4ss2xfBlEqm8gKWEdsb6buTK11ZNUr94TWTkaQ==
X-Received: by 2002:a9d:6c9a:: with SMTP id c26mr15987302otr.96.1612287900437;
        Tue, 02 Feb 2021 09:45:00 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a71sm4919072oob.48.2021.02.02.09.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 09:44:59 -0800 (PST)
Received: (nullmailer pid 3887348 invoked by uid 1000);
        Tue, 02 Feb 2021 17:44:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Andy Gross <agross@kernel.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-samsung-soc@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@axis.com, Richard Zhu <hongxing.zhu@nxp.com>,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pci@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-omap@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        linux-tegra@vger.kernel.org, Jonathan Chocron <jonnyc@amazon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <706e684f571e142362d7be74eb1dcee2c8558052.1612271903.git.mchehab+huawei@kernel.org>
References: <cover.1612271903.git.mchehab+huawei@kernel.org> <706e684f571e142362d7be74eb1dcee2c8558052.1612271903.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH 01/13] doc: bindings: pci: designware-pcie.txt: convert it to yaml
Date:   Tue, 02 Feb 2021 11:44:54 -0600
Message-Id: <1612287895.001149.3887347.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 02 Feb 2021 14:29:46 +0100, Mauro Carvalho Chehab wrote:
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

See https://patchwork.ozlabs.org/patch/1434686

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

