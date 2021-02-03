Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C5E30D381
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 07:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhBCGty (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 01:49:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:41294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231186AbhBCGty (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 01:49:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9CFC64F5D;
        Wed,  3 Feb 2021 06:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612334952;
        bh=TbVrfhRWcP0NLWkcKrc9dypvQJV2iCyeSCaii6eG9Ro=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k4bNSi5Yrb/h0nIFSc5i07chfgyRveavNrYx6tXmNY4YUVo71kjXoj58WpoS26hCk
         uCrxhKvd/JINpBt6xI4aRXzjzz0q2z0b4Jpzn88TxH1VbIs3gYWdkh1niFtlVTB1kX
         1CopGTwzJ5CvVY/GK5gLvjC7egUIna+Cj+SOrhEItOX6sdcbHz1w+Nh+oBPKLN80iR
         MAuh85U3/Rg8T1TN+INLzWRfCb3TxylBCkTR64tAC9G6v3tO+CoRnnf+ZhwJu7Jcg/
         G4h6hht8I6O6OBd5bMopuYFgBepcOY61dAfTEygpm5fHjmekUW6Se249HLVv84fyTP
         /oH1Bp1Y1nkKg==
Date:   Wed, 3 Feb 2021 07:49:00 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
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
Subject: Re: [PATCH 01/13] doc: bindings: pci: designware-pcie.txt: convert
 it to yaml
Message-ID: <20210203074900.6d581153@coco.lan>
In-Reply-To: <1612287895.001149.3887347.nullmailer@robh.at.kernel.org>
References: <cover.1612271903.git.mchehab+huawei@kernel.org>
        <706e684f571e142362d7be74eb1dcee2c8558052.1612271903.git.mchehab+huawei@kernel.org>
        <1612287895.001149.3887347.nullmailer@robh.at.kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Em Tue, 02 Feb 2021 11:44:54 -0600
Rob Herring <robh@kernel.org> escreveu:

> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,pcie.yaml: properties:snps,enable-cdm-check: 'oneOf' conditional failed, one must be fixed:
> 	'type' is a required property
> 	Additional properties are not allowed ('$ref' was unexpected)
> 	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,pcie.yaml: properties:snps,enable-cdm-check: 'oneOf' conditional failed, one must be fixed:
> 		'enum' is a required property
> 		'const' is a required property
> 	'/schemas/types.yaml#definitions/flag' does not match 'types.yaml#/definitions/'
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/snps,pcie.yaml: ignoring, error in schema: properties: snps,enable-cdm-check
> warning: no schema found in file: ./Documentation/devicetree/bindings/pci/snps,pcie.yaml
> 
> See https://patchwork.ozlabs.org/patch/1434686
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.

I've no idea why the bot is hitting those. My tree is based on
staging-testing[1], as I need the regulator patches merged there.
Such tree is based on v5.11-rc5.

There, dt_binding_check doesn't get any warnings on this schema:

$ pip3 install dtschema --upgrade --user
Requirement already up-to-date: dtschema in /home/mchehab/.local/lib/python3.9/site-packages (2020.12)
Requirement already satisfied, skipping upgrade: ruamel.yaml>0.15.69 in /usr/lib/python3.9/site-packages (from dtschema) (0.16.6)
Requirement already satisfied, skipping upgrade: jsonschema>=3.0.1 in /usr/lib/python3.9/site-packages (from dtschema) (3.2.0)
Requirement already satisfied, skipping upgrade: rfc3987 in /home/mchehab/.local/lib/python3.9/site-packages (from dtschema) (1.3.8)
Requirement already satisfied, skipping upgrade: attrs>=17.4.0 in /usr/lib/python3.9/site-packages (from jsonschema>=3.0.1->dtschema) (19.3.0)
Requirement already satisfied, skipping upgrade: pyrsistent>=0.14.0 in /usr/lib64/python3.9/site-packages (from jsonschema>=3.0.1->dtschema) (0.16.0)
Requirement already satisfied, skipping upgrade: setuptools in /usr/lib/python3.9/site-packages (from jsonschema>=3.0.1->dtschema) (49.1.3)
Requirement already satisfied, skipping upgrade: six>=1.11.0 in /usr/lib/python3.9/site-packages (from jsonschema>=3.0.1->dtschema) (1.15.0)

$ make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm64 DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/snps,pcie.yaml dt_binding_check
  LINT    Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/pci/snps,pcie.example.dts
./Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml:10:4: [warning] wrong indentation: expected 2 but found 3 (indentation)
./Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml:102:10: [warning] wrong indentation: expected 10 but found 9 (indentation)
  CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
  DTC     Documentation/devicetree/bindings/pci/snps,pcie.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/pci/snps,pcie.example.dt.yaml

$ git merge v5.11-rc6
Merge made by the 'recursive' strategy.
...
$ make CROSS_COMPILE=aarch64-linux-gnu- dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/snps,pcie.yaml 
  LINT    Documentation/devicetree/bindings
./Documentation/devicetree/bindings/pinctrl/microchip,sparx5-sgpio.yaml:102:10: [warning] wrong indentation: expected 10 but found 9 (indentation)
  CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
  DTC     Documentation/devicetree/bindings/pci/snps,pcie.example.dt.yaml
  CHECK   Documentation/devicetree/bindings/pci/snps,pcie.example.dt.yaml

Thanks,
Mauro
