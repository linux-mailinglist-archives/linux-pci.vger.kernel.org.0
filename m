Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1F546024F
	for <lists+linux-pci@lfdr.de>; Sun, 28 Nov 2021 00:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhK0XSr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Nov 2021 18:18:47 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:45568 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243219AbhK0XQr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 27 Nov 2021 18:16:47 -0500
Received: by mail-ot1-f45.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso19635027otf.12;
        Sat, 27 Nov 2021 15:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=0CqooEwQjaQ6d3gyq3QtixiAuZ8rOkpxDhFLWQnaq8I=;
        b=0EsM/EESmQyT//gZOzYmpL+1CVhirCkjv2ns7put4GHCBCIQ6md/213fhwIJknzreD
         i6OTfj8gijrt4TNr+wE9G/oKtZwWQ5n5Vrm5BrS5yFH8N8/BCyIUFyoOar+yzaLHGLSL
         K2Fzy6lzoFWznVV+qgrHR/LnmbLf7BGz21VAQz3zTHFAEHCdTglMHe0RhaZTpqlzPHWa
         YPiQcmDyAqv0XrzVhRzIp9iXNJeOkSxZxsJYzmg4IAarTfFNK8VEbcdBIAxRVDAA0dlq
         HK6GmymuFMdF4ldxwHhK/JKg0wayIdgZiLnjj8zXTzb+KA+ufexRQUCohJ86cIuximDz
         VdDg==
X-Gm-Message-State: AOAM530zElf7t9HtRnAXKuZSonp/PiDePW6/TRsvXp1uYLi9YSXyXSCB
        Xxit7ELP3X4CvBIkxrPs6RJIqARB0g==
X-Google-Smtp-Source: ABdhPJy9vXn484UCM2Yea/IT95p+SQqinlq5jlXR5HBqiZxXNrBZxOHg/PXNNxuJ8DVyTcEerSy5yw==
X-Received: by 2002:a05:6830:1004:: with SMTP id a4mr36593613otp.294.1638054811926;
        Sat, 27 Nov 2021 15:13:31 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l39sm1825525otv.63.2021.11.27.15.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 15:13:31 -0800 (PST)
Received: (nullmailer pid 1973547 invoked by uid 1000);
        Sat, 27 Nov 2021 23:13:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211126083119.16570-2-kishon@ti.com>
References: <20211126083119.16570-1-kishon@ti.com> <20211126083119.16570-2-kishon@ti.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: PCI: ti,am65: Fix "ti,syscon-pcie-id"/"ti,syscon-pcie-mode" to take argument
Date:   Sat, 27 Nov 2021 16:13:22 -0700
Message-Id: <1638054802.141849.1973546.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 26 Nov 2021 14:01:15 +0530, Kishon Vijay Abraham I wrote:
> Fix binding documentation of "ti,syscon-pcie-id" and "ti,syscon-pcie-mode"
> to take phandle with argument. The argument is the register offset within
> "syscon" used to configure PCIe controller. Similar change for j721e is
> discussed in [1]
> 
> [1] -> http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/ti,am65-pci-ep.yaml  |  8 ++++++--
>  .../bindings/pci/ti,am65-pci-host.yaml           | 16 ++++++++++++----
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1559994


pcie@21020000: compatible: Additional items are not allowed ('snps,dw-pcie' was unexpected)
	arch/arm/boot/dts/keystone-k2e-evm.dt.yaml

pcie@21020000: compatible: ['ti,keystone-pcie', 'snps,dw-pcie'] is too long
	arch/arm/boot/dts/keystone-k2e-evm.dt.yaml

pcie@21020000: reg: [[553783296, 8192], [553779200, 4096], [39977256, 4]] is too short
	arch/arm/boot/dts/keystone-k2e-evm.dt.yaml

pcie@21800000: compatible: Additional items are not allowed ('snps,dw-pcie' was unexpected)
	arch/arm/boot/dts/keystone-k2e-evm.dt.yaml
	arch/arm/boot/dts/keystone-k2hk-evm.dt.yaml
	arch/arm/boot/dts/keystone-k2l-evm.dt.yaml

pcie@21800000: compatible: ['ti,keystone-pcie', 'snps,dw-pcie'] is too long
	arch/arm/boot/dts/keystone-k2e-evm.dt.yaml
	arch/arm/boot/dts/keystone-k2hk-evm.dt.yaml
	arch/arm/boot/dts/keystone-k2l-evm.dt.yaml

pcie@21800000: reg: [[562040832, 8192], [562036736, 4096], [39977256, 4]] is too short
	arch/arm/boot/dts/keystone-k2e-evm.dt.yaml
	arch/arm/boot/dts/keystone-k2hk-evm.dt.yaml
	arch/arm/boot/dts/keystone-k2l-evm.dt.yaml

pcie@5500000: ti,syscon-pcie-id:0: [52] is too short
	arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml

pcie@5500000: ti,syscon-pcie-id:0: [60] is too short
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml

pcie@5500000: ti,syscon-pcie-id:0: [61] is too short
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

pcie@5500000: ti,syscon-pcie-mode:0: [53] is too short
	arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml

pcie@5500000: ti,syscon-pcie-mode:0: [61] is too short
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml

pcie@5500000: ti,syscon-pcie-mode:0: [62] is too short
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

pcie@5600000: ti,syscon-pcie-id:0: [52] is too short
	arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml

pcie@5600000: ti,syscon-pcie-id:0: [60] is too short
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml

pcie@5600000: ti,syscon-pcie-id:0: [61] is too short
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

pcie@5600000: ti,syscon-pcie-mode:0: [55] is too short
	arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml

pcie@5600000: ti,syscon-pcie-mode:0: [63] is too short
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml

pcie@5600000: ti,syscon-pcie-mode:0: [64] is too short
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

pcie-ep@5500000: ti,syscon-pcie-mode:0: [53] is too short
	arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml

pcie-ep@5500000: ti,syscon-pcie-mode:0: [61] is too short
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml

pcie-ep@5500000: ti,syscon-pcie-mode:0: [62] is too short
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

pcie-ep@5600000: ti,syscon-pcie-mode:0: [55] is too short
	arch/arm64/boot/dts/ti/k3-am654-base-board.dt.yaml

pcie-ep@5600000: ti,syscon-pcie-mode:0: [63] is too short
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dt.yaml

pcie-ep@5600000: ti,syscon-pcie-mode:0: [64] is too short
	arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.dt.yaml
	arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-pg2.dt.yaml

