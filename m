Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F32834EB8B
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 17:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhC3PIg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 11:08:36 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:45983 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbhC3PIV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Mar 2021 11:08:21 -0400
Received: by mail-oo1-f49.google.com with SMTP id s1-20020a4ac1010000b02901cfd9170ce2so1948035oop.12;
        Tue, 30 Mar 2021 08:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OERH4SlfSJi/bQ1a0OGx4vJZa22yHS7mOblk/gNxhCk=;
        b=LroQUxNk2SzNV96DXGhO53nhbhHXfiDnZRz2DJMBRpmj85zCBXqalYZQqg4ynQVMIU
         Sz7/EM6TgQOa2shTQRIaEK66X9V7kODyropDu9rwEcXyvv2CleejnQjdGGVEwFBLubEB
         fnvIidEQsqdwnG0LD27I++JAePuA7V0/PC/jlGbM3ibDarLDR5JiDk+1my5DQeBsCvOW
         wccfc9HBeiNZNHKNu+cUXNmdVd6dd1c8QLVc6/CzD3JRhvU2xW8tZllgl9ij+XAR/ZRq
         9Gd4oHm07Z5znP65K2aeo7EuauSQKUoB1nyRXwyDbUrhf7S8ePQNZkEYiVZVItKVyf0l
         Br7g==
X-Gm-Message-State: AOAM532gIoDsZ5S1y3LjesEv2VmOojwNH+rwwT0xkzm8ANPg58KiTdYK
        306t38OyN7+ws2OVaRUAHA==
X-Google-Smtp-Source: ABdhPJxzTiT8Yx157v6YJmaw23rt6BCKJqe/1FjRziNV4+JIAfVmGBZdQjozMJwv7LdnO9EwUUdQxw==
X-Received: by 2002:a05:6820:129:: with SMTP id i9mr25919449ood.80.1617116900980;
        Tue, 30 Mar 2021 08:08:20 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.136])
        by smtp.gmail.com with ESMTPSA id u7sm4467781ooq.13.2021.03.30.08.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 08:08:20 -0700 (PDT)
Received: (nullmailer pid 312816 invoked by uid 1000);
        Tue, 30 Mar 2021 15:08:16 -0000
Date:   Tue, 30 Mar 2021 10:08:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
Message-ID: <20210330150816.GA306420@robh.at.kernel.org>
References: <20210326191906.43567-1-jim2101024@gmail.com>
 <20210326191906.43567-2-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326191906.43567-2-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 26, 2021 at 03:18:59PM -0400, Jim Quinlan wrote:
> Similar to the regulator bindings found in "rockchip-pcie-host.txt", this
> allows optional regulators to be attached and controlled by the PCIe RC
> driver.  That being said, this driver searches in the DT subnode (the EP
> node, eg pci@0,0) for the regulator property.
> 
> The use of a regulator property in the pcie EP subnode such as
> "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> file at
> 
> https://github.com/devicetree-org/dt-schema/pull/54
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> ---
>  Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> index f90557f6deb8..ea3e6f55e365 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> @@ -156,5 +156,11 @@ examples:
>                                   <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
>                      brcm,enable-ssc;
>                      brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
> +
> +                    pcie-ep@0,0 {
> +                            reg = <0x0 0x0 0x0 0x0 0x0>;
> +                            compatible = "pci14e4,1688";
> +                            vpcie12v-supply: <&vreg12>;

For other cases, these properties are in the host bridge node. If these 
are standard PCI rails, then I think that's where they belong unless we 
define slot nodes.

Rob
