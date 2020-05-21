Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297771DD7B5
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 21:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgEUT45 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 15:56:57 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42865 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgEUT45 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 15:56:57 -0400
Received: by mail-il1-f196.google.com with SMTP id 18so8480374iln.9;
        Thu, 21 May 2020 12:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xls1vclQRjbQcOpkeb+5oUhFhnSglpOdCVnWY3AbSAE=;
        b=D9377LO4ba0U0jgrRXam5wDBNhE/OqeQBrkHYh1C4sV6EyFpkes04xzHii6cKVg+da
         0qNr/EE0P2mJOhJ4l1WbV+TDjCJdhCASllaD0AsiFI7bcfVNrBQdFpXJ4bTzDAscb7uz
         gr8QXD1aaAoDlL/xZYJCxKyrNX2dQXcqHT3tZUIEJwMtn7ypSPYRtqB76hZXbw16i3j3
         dvyEeYR1Zr2HhJ+qlS2bLsVoEYFnuKJHmu62odujN1FsG/nRkhtbtFfeV1H9OCgmcaF3
         6APT5K9f8fUbgwVA5g8Ehz3gvJhz4DdqFJ42C8zpUE3HkOJlZGNQssuynVrdMya7eaOv
         g82g==
X-Gm-Message-State: AOAM530z4OB3ZfLRWn7GDckJLGZVeI6ZB/pC9UOWILoXMUpxrBOyPc5l
        kmLMR1yb9JSzIDZiMiPM4Q==
X-Google-Smtp-Source: ABdhPJwr85EAhtCi307L09dPTjH8IqIjxMZ3rQRxiNImivZZuWELxD4Ur5YuEWDXteTY2+WkMCHN2g==
X-Received: by 2002:a05:6e02:503:: with SMTP id d3mr10309527ils.208.1590091014869;
        Thu, 21 May 2020 12:56:54 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v14sm3338717ilm.66.2020.05.21.12.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 12:56:54 -0700 (PDT)
Received: (nullmailer pid 2795143 invoked by uid 1000);
        Thu, 21 May 2020 19:56:53 -0000
Date:   Thu, 21 May 2020 13:56:53 -0600
From:   robh@kernel.org
To:     Daire.McNamara@microchip.com
Cc:     amurray@thegoodpenguin.co.uk, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, robh-dt@kernel.org,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com
Subject: Re: [PATCH v9 1/2] PCI: Microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20200521195653.GA2793927@bogus>
References: <5dc3002680da40400b083748329d8b736219952e.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc3002680da40400b083748329d8b736219952e.camel@microchip.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 20 May 2020 11:44:36 +0000, Daire.McNamara@microchip.com wrote:
> 
> This patch adds device tree bindings for the Microchip
> PCIe PolarFire PCIe controller when configured in
> host (Root Complex) mode.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  .../bindings/pci/microchip,pcie-host.yaml     | 94 +++++++++++++++++++
>  1 file changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml: properties:interrupts: {'minItems': 1, 'maxItems': 1, 'items': [{'description': 'PCIe host controller and builtin MSI controller'}]} is not valid under any of the given schemas (Possible causes of the failure):
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml: properties:interrupts: 'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'default', '$ref']
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml: properties:interrupts:maxItems: 1 is less than the minimum of 2

Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/pci/microchip,pcie-host.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/pci/microchip,pcie-host.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml: ignoring, error in schema: properties: interrupts
warning: no schema found in file: ./Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml: ignoring, error in schema: properties: interrupts
warning: no schema found in file: ./Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
Makefile:1300: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1294277

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

