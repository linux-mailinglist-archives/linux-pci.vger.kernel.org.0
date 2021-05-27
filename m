Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163013930C4
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 16:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbhE0OZF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 10:25:05 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:34808 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbhE0OZE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 10:25:04 -0400
Received: by mail-ot1-f45.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso380304ote.1;
        Thu, 27 May 2021 07:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=kTfQEsvOqiRckcgnHQGpa18xnrPyJuZ18+L671b9Z/A=;
        b=aYUMEUgwdRKRNQZeAHwnbSmJ0yU2tMTVlJUR2EoNeJ2d5wgD/IwBP97x+i9nx3AogB
         VMYVHdSOm6lPwmHEMX08y9zzp/Z8V+bLpfUr4+vya6YKnWED78IhICZ9lJsYj13w0t4e
         mDe4iGpQH+VdxAdkrFC4BGlaiYlEBD99NYakD19NWtX92Ri78Gsy956yaA5P8caCLjAM
         pFu6cLHg29aTTcsy61cYicBxVj0iqf3SIO+CNeHrAx8BgJM7K3PYmOD7Ueaaii/35NSJ
         4/6bCZotx6L5feoM8xdKxkXtBoY2DVUvfTjS5oDepyKdJLM4rTBFcAd8+vP6mJSNKcZH
         8lFw==
X-Gm-Message-State: AOAM533TDvYnDgnozdmY2pXsszd1N4gcQmnFbp2emMadHuGNN7u0NkBA
        OP6R10uhiAp5mR6WX+WBmjoxkU2yHA==
X-Google-Smtp-Source: ABdhPJxxlebcpGQEaBTOg2ElMSHvrKL/expmt6j/VQ35c12J4xn8DgErXNCYLNGVo3pit4GyM1ITHw==
X-Received: by 2002:a9d:6548:: with SMTP id q8mr2967343otl.311.1622125411258;
        Thu, 27 May 2021 07:23:31 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y205sm464173oie.58.2021.05.27.07.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 07:23:29 -0700 (PDT)
Received: (nullmailer pid 731783 invoked by uid 1000);
        Thu, 27 May 2021 14:23:27 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20210526134708.27887-1-kishon@ti.com>
References: <20210526134708.27887-1-kishon@ti.com>
Subject: Re: [PATCH] dt-bindings: PCI: ti,am65: Convert PCIe host/endpoint mode dt-bindings to YAML
Date:   Thu, 27 May 2021 09:23:27 -0500
Message-Id: <1622125407.750797.731782.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 26 May 2021 19:17:08 +0530, Kishon Vijay Abraham I wrote:
> Convert PCIe host/endpoint mode dt-bindings for TI's AM65/Keystone SoC
> to YAML binding.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/pci-keystone.txt  | 115 ------------------
>  .../bindings/pci/ti,am65-pci-ep.yaml          |  80 ++++++++++++
>  .../bindings/pci/ti,am65-pci-host.yaml        | 105 ++++++++++++++++
>  3 files changed, 185 insertions(+), 115 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/pci-keystone.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dt.yaml: pcie@d0e00000: compatible: 'oneOf' conditional failed, one must be fixed:
	['intel,lgm-pcie', 'snps,dw-pcie'] is too long
	Additional items are not allowed ('snps,dw-pcie' was unexpected)
	'ti,am654-pcie-rc' was expected
	'ti,keystone-pcie' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dt.yaml: pcie@d0e00000: reg: [[3504340992, 4096], [3523215360, 8388608], [3500412928, 4096]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dt.yaml: pcie@d0e00000: reg-names:0: 'app' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dt.yaml: pcie@d0e00000: reg-names:1: 'dbics' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dt.yaml: pcie@d0e00000: reg-names:2: 'config' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dt.yaml: pcie@d0e00000: reg-names: ['dbi', 'config', 'app'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dt.yaml: pcie@d0e00000: 'ti,syscon-pcie-id' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/intel-gw-pcie.example.dt.yaml: pcie@d0e00000: 'ti,syscon-pcie-mode' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml

See https://patchwork.ozlabs.org/patch/1484053

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

