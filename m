Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208BD34975D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 17:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhCYQ4c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 12:56:32 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:38900 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbhCYQ4K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 12:56:10 -0400
Received: by mail-io1-f41.google.com with SMTP id e8so2582692iok.5;
        Thu, 25 Mar 2021 09:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=/9bA5Jr6nBNzEDVNyBoXSb1uufBPuYO8ogYWDnbdKho=;
        b=gDpNn0uhp0VEWBTUh6K0pW8PSn7jNh+yO1bIRfMoWFntlRFdmCDBgWB8ZYKoJPor5q
         PVUcbAQiwGpuhk+QFnPr9BiiixZfGOxGfQCBpMHcMIQ0UzDTmKahxTQBSL/yVqO2h8jQ
         GlFn0YFIrHgq6OIcsoJ++n7Sjxnx0izO6rpbgY84ZEGOkWqZcmXjwQS2ZAX9Av29+a8M
         7qXzRjksWl9na1uMEDOcBq97hcz1OLY/ilcrzw7rCpKBIaR3x4CoMSYXSkWRB5i17v4F
         n87DVmE61kivy2P0mbuXhLQUUomACnVKMjpf4AuW4QcOCqQYun2L+S19tuyRIdt5NL+0
         MOPw==
X-Gm-Message-State: AOAM533GOIauYqeZAeTd9Xdgdd2ubKfSQf3Vk5E1ykxtq5qtuBzsuwJD
        fUX0LCnT3szduZ7Nn+e7Rg==
X-Google-Smtp-Source: ABdhPJx8qw/p2/OTtJmxZY8i7gZ67jrTFFrG8AnyWvJl91ABfd66Uhoya1//ywm0WOR4p7W5tlk5Kw==
X-Received: by 2002:a5e:d901:: with SMTP id n1mr7232684iop.84.1616691370334;
        Thu, 25 Mar 2021 09:56:10 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s16sm2864094ioe.44.2021.03.25.09.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 09:56:09 -0700 (PDT)
Received: (nullmailer pid 1321889 invoked by uid 1000);
        Thu, 25 Mar 2021 16:56:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lokesh Vutla <lokeshvutla@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>
In-Reply-To: <20210325090026.8843-2-kishon@ti.com>
References: <20210325090026.8843-1-kishon@ti.com> <20210325090026.8843-2-kishon@ti.com>
Subject: Re: [PATCH 1/6] dt-bindings: PCI: ti, am65: Add PCIe host mode dt-bindings for TI's AM65 SoC
Date:   Thu, 25 Mar 2021 10:56:01 -0600
Message-Id: <1616691361.046934.1321888.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 25 Mar 2021 14:30:21 +0530, Kishon Vijay Abraham I wrote:
> Add PCIe host mode dt-bindings for TI's AM65 SoC.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../bindings/pci/ti,am65-pci-host.yaml        | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/ti,am65-pci-host.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/pci/ti,am65-pci-host.example.dts:44.35-36 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:349: Documentation/devicetree/bindings/pci/ti,am65-pci-host.example.dt.yaml] Error 1
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1458243

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

