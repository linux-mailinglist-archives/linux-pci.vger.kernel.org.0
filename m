Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5168C349763
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 17:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhCYQ4e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 12:56:34 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:45034 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCYQ4O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 12:56:14 -0400
Received: by mail-io1-f42.google.com with SMTP id v26so2558963iox.11;
        Thu, 25 Mar 2021 09:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=+Byms4pK4Tr8p9R8BbBdKHq/oMBldoupWVsIn9Ftc2U=;
        b=DkAZn/8PB6QpGcfGryvjMVDp9WjScHfECraFXPAtkNLAZlaZmWSQXI/aXXoPl5R7Xs
         pOVN1RXS2in3NkE794/1AGLYjsofORC3ZZWj9b3No5Piao7B3YTBlJQd45ERwYUFMHIS
         ZUB+EYJQu0tIS2Ly970kjj01rvkZDNzMopsdXKDqrr4RYRv4s6U72yoft/dezDHYL4bl
         59AP/rjb6jahA5RxSJWtDopfu6oZbHxHVqpGMd4TSDbQauQP5ZB0xCR+h6ieQvyBSZWr
         2QFevOf49I9Yo1Ct1KRhWK9TiP0k5UsoyS9jW+X2mV9HBgtpwV3eryUaO6kCwifudntb
         Vj/Q==
X-Gm-Message-State: AOAM531s6IAULgOycODLWwLuW8XQ9u826TZcjtsfx7ebhVML2Hv6RcfG
        C6nlOfDYLmPRoLuOUCT3CQIhJyMN+g==
X-Google-Smtp-Source: ABdhPJxyw7HD5gin3k4/HN2QE7YpG8aa4kqpYdKljz5sArazZpNs7Hl/KxaTDan9f5FMYUtPEI2+jw==
X-Received: by 2002:a05:6602:2018:: with SMTP id y24mr7304821iod.74.1616691373920;
        Thu, 25 Mar 2021 09:56:13 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o23sm2994475ioo.24.2021.03.25.09.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 09:56:12 -0700 (PDT)
Received: (nullmailer pid 1321893 invoked by uid 1000);
        Thu, 25 Mar 2021 16:56:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-omap@vger.kernel.org, Tom Joseph <tjoseph@cadence.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
In-Reply-To: <20210325090936.9306-2-kishon@ti.com>
References: <20210325090936.9306-1-kishon@ti.com> <20210325090936.9306-2-kishon@ti.com>
Subject: Re: [PATCH 1/4] dt-bindings: PCI: ti, j721e: Add bindings to specify legacy interrupts
Date:   Thu, 25 Mar 2021 10:56:01 -0600
Message-Id: <1616691361.062216.1321892.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 25 Mar 2021 14:39:33 +0530, Kishon Vijay Abraham I wrote:
> Add bindings to specify interrupt controller for legacy interrupts.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml  | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/pci/ti,j721e-pci-host.example.dts:59.39-40 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:349: Documentation/devicetree/bindings/pci/ti,j721e-pci-host.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1458255

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

