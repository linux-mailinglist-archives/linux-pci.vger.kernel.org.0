Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477261F7EA1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 23:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgFLV70 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jun 2020 17:59:26 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:34029 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgFLV7Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jun 2020 17:59:25 -0400
Received: by mail-il1-f196.google.com with SMTP id x18so10190730ilp.1;
        Fri, 12 Jun 2020 14:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2F5uGqx/WgH/DEdF5jL50sJc6KALUC66tcH1BXMzDQg=;
        b=Bw1pu/bowRtt5reFrrJppCdvsXTKsZ/3XOIEo/I8ncBHvEV2JMvQdgPEnO4CoRU5w4
         NcWvVMOuK7w60YNunnziQRF6bgAoDp1cMHMoTMD6LoEjN/2lrmc+3fDbUE7UCoe8h1It
         uODOyhPWrhkpQRB2kAraTEMDPghpA7C6ZNR6pI3mD+Lu+O+SwL4yNd69ybRStg4XTaNl
         jLvQ43vRf1xvoX39LU4YiI6aeUo47kE8RpY6oU6e0Zb9S0IO2KkDYddwhbZttOTPeOdZ
         Pks+qqVxV6mI+PBswpjUaQofU1mBqRcZTRkICYReAbhtfwSKTjjTK9hYBmS8VEYqm/MD
         GxfQ==
X-Gm-Message-State: AOAM533FsYAsL8YZjMvY6WBRJfnVZwW/UW0iNdORfp8Fs/jpgp2u16Jb
        ZEJxyt/auqQ8UQxpO8qb51gs+Eg=
X-Google-Smtp-Source: ABdhPJywVx2eakgVkkGLPkb5txGKoTOWYRUqrcf8/RkjN9bEr/ESVtSbdMes1Woh+ZCHmJELA+GZwQ==
X-Received: by 2002:a05:6e02:dc5:: with SMTP id l5mr14757952ilj.216.1591999162983;
        Fri, 12 Jun 2020 14:59:22 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id y5sm3784445ilp.57.2020.06.12.14.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 14:59:22 -0700 (PDT)
Received: (nullmailer pid 3887640 invoked by uid 1000);
        Fri, 12 Jun 2020 21:59:21 -0000
Date:   Fri, 12 Jun 2020 15:59:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daire.McNamara@microchip.com
Cc:     amurray@thegoodpenguin.co.uk, linux-pci@vger.kernel.org,
        robh+dt@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        devicetree@vger.kernel.org, david.abdurachmanov@gmail.com
Subject: Re: [PATCH v11 1/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20200612215921.GB3886706@bogus>
References: <bb21af9144fe624a42ddc3ea302667fa9a46a4c8.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb21af9144fe624a42ddc3ea302667fa9a46a4c8.camel@microchip.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 11 Jun 2020 18:20:11 +0000, Daire.McNamara@microchip.com wrote:
> 
> add device tree bindings for the Microchip PCIe PolarFire PCIe controller
> when configured in host (Root Complex) mode.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> ---
>  .../bindings/pci/microchip,pcie-host.yaml     | 93 +++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/microchip,pcie-host.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/pci/microchip,pcie-host.example.dts:24.25-25.55: Warning (reg_format): /example-0/soc/pcie@2030000000:reg: property has invalid length (32 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/pci/microchip,pcie-host.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/pci/microchip,pcie-host.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/pci/microchip,pcie-host.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/pci/microchip,pcie-host.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/pci/microchip,pcie-host.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'


See https://patchwork.ozlabs.org/patch/1307687

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

