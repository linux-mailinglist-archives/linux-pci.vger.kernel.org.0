Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9250E2E31FD
	for <lists+linux-pci@lfdr.de>; Sun, 27 Dec 2020 17:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgL0Q5Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Dec 2020 11:57:16 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:44491 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgL0Q5P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Dec 2020 11:57:15 -0500
Received: by mail-oi1-f180.google.com with SMTP id d189so9333641oig.11;
        Sun, 27 Dec 2020 08:57:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=reFvH6ludnBqDbOySLtt2v8BCeYwui82hdt4SyxpeVY=;
        b=q15PXmQnZxuyXOxKQDdcW3Kn+EfoTkZ0B3icQUWIbuiCI/E/JKro2DOdVZuGNt7pI3
         harcT07LYv34ppxlnMbEHcLSCYsIxmnznYu14T7a8IQJkes7GRYzvxJd79yM6+1BVGm6
         L/GzR7G6Ei2N0pFAxR3V2SmmU0RDaIYaVDhdQciWMD6jhXrmGXS8iXpQYdgjgIUkzg6X
         Vu3gbssXL/2O/8nHIDF5oPVw4mPPbkdz8WqELGTWeAfYdUMllmpgPmtZUxozeNrED57w
         Tn2/c4YWYn99Fvn8KZLXgL5XjwkdlilaxieUxbFzxFgQ3HjV9Jf0fo5pXWzY25l8+/0w
         HS3Q==
X-Gm-Message-State: AOAM532k+dm63Zshy12DWPUQL5pJfX5dXbH0Z3frM30IWiRux+/nFgS7
        400wB4cCFMXR9Qnsfwsc+g==
X-Google-Smtp-Source: ABdhPJwfAMhyd8OC3ESW9dB5fPdGEXeM0BeBYLt25oNUcFljJ2aWn7U0+ZXQdvfR3rw7xJB6nfKZUw==
X-Received: by 2002:aca:edd7:: with SMTP id l206mr9774411oih.99.1609088194686;
        Sun, 27 Dec 2020 08:56:34 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 39sm8691436otu.6.2020.12.27.08.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 08:56:33 -0800 (PST)
Received: (nullmailer pid 1338178 invoked by uid 1000);
        Sun, 27 Dec 2020 16:56:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hongtao Wu <wuht06@gmail.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Hongtao Wu <billows.wu@unisoc.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-pci@vger.kernel.org
In-Reply-To: <1609074734-9336-2-git-send-email-wuht06@gmail.com>
References: <1609074734-9336-1-git-send-email-wuht06@gmail.com> <1609074734-9336-2-git-send-email-wuht06@gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: PCI: sprd: Document Unisoc PCIe RC host controller
Date:   Sun, 27 Dec 2020 09:56:21 -0700
Message-Id: <1609088181.508512.1338177.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 27 Dec 2020 21:12:13 +0800, Hongtao Wu wrote:
> From: Hongtao Wu <billows.wu@unisoc.com>
> 
> This series adds PCIe bindings for Unisoc SoCs.
> This controller is based on DesignWare PCIe IP.
> 
> Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
> ---
>  .../devicetree/bindings/pci/sprd-pcie.yaml         | 91 ++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/sprd-pcie.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/sprd-pcie.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/sprd-pcie.yaml: ignoring, error in schema: 
warning: no schema found in file: ./Documentation/devicetree/bindings/pci/sprd-pcie.yaml

See https://patchwork.ozlabs.org/patch/1420734

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

