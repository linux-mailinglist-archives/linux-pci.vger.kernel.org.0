Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73693026A3
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 16:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbhAYO4J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 09:56:09 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:36354 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729817AbhAYOwW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jan 2021 09:52:22 -0500
Received: by mail-ot1-f50.google.com with SMTP id d7so5224054otf.3;
        Mon, 25 Jan 2021 06:52:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=t6AjeOuEVABHdAQoH+abbWUN78XuGNp/FJaAukBK/cE=;
        b=FIztdjuXPL6AI9z6kgM+v+P9A4Jc9fFpx6tP4AzPoTAIIefC2aT/xeDaglA7FZ/3k8
         gXE1B95p4J35Hxn85nxcw1HGqNLt848u68pG/CRDN+DzoTWmFOzp+NhVRQfjvlN5jiVx
         iBcM17cyoPuKypy6YQYgJ3HHwqmVNmxZgdvF47PTyCB7oba9/bSf3VVgvB1XBIhnv7+J
         Fy5zd8dZoya2EtM62DgOidRYc656eerBai1qfBl96qPfCAEdAB4OPbuGuyt0WwzNjIdk
         G3/HKERkSmtMJfhxcT8d5pxHKxhxcR0uMTG29plPU6FtvvAR5OvTNrHpFexpLx2pdmf2
         2iCA==
X-Gm-Message-State: AOAM533OoAWGPD0C9l90uBG6/UezdPfqBJe2tLC/W6tXAI+EwrBHxZMX
        p+6k3huIFvS1wgRqiXU1jzxedZbqhQ==
X-Google-Smtp-Source: ABdhPJyh75is8MUYkM1d0LK6XFWMdy79UP8Cp982xu3Hn3yFCOuUkWG0Yo23WM7csu9NmZ36m1oMzw==
X-Received: by 2002:a9d:5544:: with SMTP id h4mr732610oti.104.1611586301690;
        Mon, 25 Jan 2021 06:51:41 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z8sm3258726oon.10.2021.01.25.06.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 06:51:40 -0800 (PST)
Received: (nullmailer pid 327906 invoked by uid 1000);
        Mon, 25 Jan 2021 14:51:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Simon Xue <xxm@rock-chips.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, robh+dt@kernel.org,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
In-Reply-To: <20210125024824.634583-1-xxm@rock-chips.com>
References: <20210125024824.634583-1-xxm@rock-chips.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: rockchip: Add DesignWare based PCIe controller
Date:   Mon, 25 Jan 2021 08:51:35 -0600
Message-Id: <1611586295.665555.327905.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 25 Jan 2021 10:48:24 +0800, Simon Xue wrote:
> Document DT bindings for PCIe controller found on Rockchip SoC.
> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> ---
>  .../bindings/pci/rockchip-dw-pcie.yaml        | 133 ++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.example.dt.yaml: pcie@fe280000: ranges: 'oneOf' conditional failed, one must be fixed:
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.example.dt.yaml: pcie@fe280000: ranges: 'oneOf' conditional failed, one must be fixed:
		[[2048, 0, 2147483648, 3, 2147483648, 0, 8388608], [2164260864, 0, 2155872256, 3, 2155872256, 0, 1048576], [2197815296, 0, 2156920832, 3, 2156920832, 0, 1064304640]] is not of type 'boolean'
		True was expected
		[[2048, 0, 2147483648, 3, 2147483648, 0, 8388608], [2164260864, 0, 2155872256, 3, 2155872256, 0, 1048576], [2197815296, 0, 2156920832, 3, 2156920832, 0, 1064304640]] is not of type 'null'
	2048 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.example.dt.yaml: pcie@fe280000: ranges: 'oneOf' conditional failed, one must be fixed:
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/rockchip-dw-pcie.example.dt.yaml: pcie@fe280000: ranges: 'oneOf' conditional failed, one must be fixed:
		[[2048, 0, 2147483648, 3, 2147483648, 0, 8388608], [2164260864, 0, 2155872256, 3, 2155872256, 0, 1048576], [2197815296, 0, 2156920832, 3, 2156920832, 0, 1064304640]] is not of type 'boolean'
		True was expected
		[[2048, 0, 2147483648, 3, 2147483648, 0, 8388608], [2164260864, 0, 2155872256, 3, 2155872256, 0, 1048576], [2197815296, 0, 2156920832, 3, 2156920832, 0, 1064304640]] is not of type 'null'
	2048 is not one of [16777216, 33554432, 50331648, 1107296256, 1124073472, 2164260864, 2181038080, 2197815296, 3254779904, 3271557120]
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/pci/pci-bus.yaml

See https://patchwork.ozlabs.org/patch/1431082

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

