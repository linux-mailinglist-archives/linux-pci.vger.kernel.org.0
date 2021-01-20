Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0E72FD724
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jan 2021 18:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbhATReS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jan 2021 12:34:18 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:38474 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388346AbhATOIX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jan 2021 09:08:23 -0500
Received: by mail-oi1-f175.google.com with SMTP id n186so17216423oia.5;
        Wed, 20 Jan 2021 06:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=zcKgwjky9crKlWMGPybKhU6+7gIFQmOWdjIZJmpIFjc=;
        b=ldJKrjxRZsxJP49FyRZDGTqQvYYSa3QBLdR5VUTUo9yUCmrmj76pmHHiWTCOcfuCkT
         lNogw8/NboJLhkeR2BavznQCBMH+vKRZo+/ZfcSAhr+lrGvvlvjf8hArf+hGN13G5vrU
         uFp+w3URccZl318BcKVV3z4qd0eL9Mow2XBxkchNwa3hwiob/X/qknBm1LHXAQEhfv68
         r8QQGuMEXXy7BCEfeWwjMKvJppH39/+j0WEklmbWpxNChhtGNqGm8EhYEi08MWwyrsIx
         0scvAVNM8BchWzvYH7+vXcoc0M+JhvBVe2yWxKhY9vUkLuQqbspH2XoG4kgcTpYTMRYF
         m2CQ==
X-Gm-Message-State: AOAM533Tn+p6hZPsNMP/kt/Qkyr4Wdq0r3BPgdAhjFXXhIf31XsphihX
        wu9OKRbiHntKzREfchcjtQ==
X-Google-Smtp-Source: ABdhPJzcEAq7/9jtYgE52EsiAT1br27RsunNbC2p9kjwtyWOTE98FYW9E/oOsC5otWdKb86kBgxzuA==
X-Received: by 2002:aca:c74d:: with SMTP id x74mr3006218oif.177.1611151656166;
        Wed, 20 Jan 2021 06:07:36 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d10sm360682ooh.32.2021.01.20.06.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 06:07:35 -0800 (PST)
Received: (nullmailer pid 31593 invoked by uid 1000);
        Wed, 20 Jan 2021 14:07:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Simon Xue <xxm@rock-chips.com>
Cc:     Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        robh+dt@kernel.org, linux-rockchip@lists.infradead.org
In-Reply-To: <20210120101554.241029-1-xxm@rock-chips.com>
References: <20210120101554.241029-1-xxm@rock-chips.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: rockchip: Add DesignWare based PCIe controller
Date:   Wed, 20 Jan 2021 08:07:34 -0600
Message-Id: <1611151654.051365.31592.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 20 Jan 2021 18:15:53 +0800, Simon Xue wrote:
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> ---
>  .../bindings/pci/rockchip-dw-pcie.yaml        | 140 ++++++++++++++++++
>  1 file changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml:39:7: [warning] wrong indentation: expected 4 but found 6 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml: properties:interrupt: [{'description': 'system information'}, {'description': 'power management control'}, {'description': 'PCIe message'}, {'description': 'legacy interrupt'}, {'description': 'error report'}] is not of type 'object', 'boolean'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml: properties:compatible: Additional properties are not allowed ('item' was unexpected)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml: properties:compatible: 'item' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml: properties:compatible: Additional properties are not allowed ('item' was unexpected)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml: ignoring, error in schema: properties: interrupt
warning: no schema found in file: ./Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
Documentation/devicetree/bindings/pci/rockchip-dw-pcie.example.dts:19:18: fatal error: dt-bindings/clock/rk3568-cru.h: No such file or directory
   19 |         #include <dt-bindings/clock/rk3568-cru.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:344: Documentation/devicetree/bindings/pci/rockchip-dw-pcie.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1370: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1429132

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

