Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE1334975F
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 17:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhCYQ4f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 12:56:35 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:38423 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhCYQ4R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 12:56:17 -0400
Received: by mail-il1-f180.google.com with SMTP id d10so2700313ils.5;
        Thu, 25 Mar 2021 09:56:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2A4tbmbq/41lPUQud924tGYWb6rVXt0+nLh9EtTJUIs=;
        b=Gx8JQ99xeRQKct814235jhazLTeAdaOlE6Blj94r+0Htz5zkj6j8SRPr2xML6OBdwS
         7EDceu/o82mccUgA/IAsLTe/JfQ3t1i6kyJN4D0HfDe5IB/b8T5kKSlqAZoeBD3XrOnE
         aiBoIh1EzZQyXB9h1ko7fAKYDZI1WNyKx6RIzU87ZhBUOYn6ErXIfrppbdRNzwwyqswk
         BAHvxRoMm7rf1+o92ILRgo5hu8VmsPpPJaiWIKV69KOTZBaSJ1I0Fmhu6lcDgQZ3Y6U0
         vsNsSAjzvqZwDLDDaHhS6u/ejml3UljQvvp+WtHErvAAuqmqVXTAXfj3I79KZ3JYpZ0n
         nQjw==
X-Gm-Message-State: AOAM531qem8zbwF9Uet0sFju4lX5VOsE3Ax2W8LMtv8CCOQuUDVdtHR0
        MrR5Cgk6l6/UV1Xr+T4xVQ==
X-Google-Smtp-Source: ABdhPJwvTpZrdakIzdAbZU+rQsbt+Q0Gp7/AOLG2hNGChXtVEKRLKt5/c7vW66dGZ25HeqtS9CKuoQ==
X-Received: by 2002:a92:cda1:: with SMTP id g1mr7594851ild.141.1616691376369;
        Thu, 25 Mar 2021 09:56:16 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q8sm2908657ilv.55.2021.03.25.09.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 09:56:15 -0700 (PDT)
Received: (nullmailer pid 1321891 invoked by uid 1000);
        Thu, 25 Mar 2021 16:56:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <20210325090026.8843-3-kishon@ti.com>
References: <20210325090026.8843-1-kishon@ti.com> <20210325090026.8843-3-kishon@ti.com>
Subject: Re: [PATCH 2/6] dt-bindings: PCI: ti, am65: Add PCIe endpoint mode dt-bindings for TI's AM65 SoC
Date:   Thu, 25 Mar 2021 10:56:01 -0600
Message-Id: <1616691361.054847.1321890.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 25 Mar 2021 14:30:22 +0530, Kishon Vijay Abraham I wrote:
> Add PCIe endpoint mode dt-bindings for TI's AM65 SoC.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/ti,am65-pci-ep.yaml          | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-ep.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/pci/ti,am65-pci-ep.example.dts:39.35-36 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:349: Documentation/devicetree/bindings/pci/ti,am65-pci-ep.example.dt.yaml] Error 1
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1458245

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

