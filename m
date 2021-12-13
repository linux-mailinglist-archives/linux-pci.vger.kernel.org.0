Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484FB47385E
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 00:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244174AbhLMXXw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 18:23:52 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:33436 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbhLMXXv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Dec 2021 18:23:51 -0500
Received: by mail-ot1-f53.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso19213916otf.0;
        Mon, 13 Dec 2021 15:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=xh0Ia+KIQrUoGbHMEfnzPM6PyEcucK4RBRTve5vYfEs=;
        b=DEVWe2z5npRYsSvzsAd4yKaa30njfWJFdTOrQ0ZE/UWEs2HqehKEpkruZweU19UgDd
         u8ROkW4MG3wu8KoI3jfcG15gw+0s2HfRU719Z2iQtFL2WcYR+CP1CCQginJrPaBex6vr
         L5dQcMvCJ8qSeqs0936NfCndsCLMbNjO8Lz+IB+t5HYgSaG2knhDhuif+FeUTlXpzbWr
         UmW+e8478fAbTGojOlYzpp1JAFcZG8lFZoyp9v6r5s/r257gSqq5C0Tn3Lz/mvIx0vFt
         dFCml/kPwzLaelCy+XbBM15mbK8lUi/FTcHBymHK31ejtuNvBQ1/Rs/jaWjlGLUaMSq7
         ozdg==
X-Gm-Message-State: AOAM5314E6LZPgUz3d8SVyjgNuE7hh2rtmHQ4HNA4XyC018Mr16dfyyT
        SjIlhCYqMKsNC7pd7P3/XA==
X-Google-Smtp-Source: ABdhPJxmXUhSaMbG0tAtg0CKpHFhMXfX10P0J1yjFavh5SniuuDF5GSwM8Aa068A5X6jOnKk51sLEQ==
X-Received: by 2002:a9d:6d86:: with SMTP id x6mr1270938otp.263.1639437831105;
        Mon, 13 Dec 2021 15:23:51 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n6sm2458478otj.78.2021.12.13.15.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 15:23:50 -0800 (PST)
Received: (nullmailer pid 1773611 invoked by uid 1000);
        Mon, 13 Dec 2021 23:23:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20211213190221.355678-7-f.fainelli@gmail.com>
References: <20211213190221.355678-1-f.fainelli@gmail.com> <20211213190221.355678-7-f.fainelli@gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: pci: Convert iProc PCIe to YAML
Date:   Mon, 13 Dec 2021 17:23:49 -0600
Message-Id: <1639437829.333710.1773610.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 13 Dec 2021 11:02:21 -0800, Florian Fainelli wrote:
> Conver the iProc PCIe controller Device Tree binding to YAML now that
> all DTS in arch/arm and arch/arm64 have been fixed to be compliant.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/pci/brcm,iproc-pcie.txt          | 133 -------------
>  .../bindings/pci/brcm,iproc-pcie.yaml         | 184 ++++++++++++++++++
>  2 files changed, 184 insertions(+), 133 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml:97:34: [warning] too few spaces after comma (commas)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.example.dt.yaml: pcie@18012000: 'brcm' is a dependency of 'brcm,pcie-ob-axi-offset'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.example.dt.yaml: pcie@18012000: 'pcie-ob' is a dependency of 'brcm,pcie-ob-axi-offset'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1567483

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

