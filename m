Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38654437FE1
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 23:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhJVVRe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 17:17:34 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:35344 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhJVVRd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 17:17:33 -0400
Received: by mail-oi1-f178.google.com with SMTP id r6so6644286oiw.2;
        Fri, 22 Oct 2021 14:15:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=SuKbx3l8/3Tb+8asLIIggnjcIA0EB5OZape1jN9uKws=;
        b=7IFYczMajKcifQ3nduB9Ovwnj8qEgHV3u5pDGiRFN2pfe6UEGE/wDJqKUtSVuPkULn
         VzoMeShKYKQf38Kn7pwD2vDt0eb36Wqjb7l2h13Fk88hdV1QX8PKO4H2tp5ZaxSCrPa8
         YZRs+uhQevVX0v55grLYKJlbS/J/RQsOTGUB0Hg3akJ8+boeoRAGzNFFqot15PNQYSq7
         PcEsHBFz1cV1eA2akn4TPk7EnY98e6BbyH7JqDqhXh7dfKhVbxxEnFj2M0hKqNmnyelP
         mGCAwXjyHIDaphrrUj31kz8ZbwYr9DOaZfzPNkAKxyjahn3JxdoipytqCD+hZJhPsoPu
         N5+A==
X-Gm-Message-State: AOAM530ioI4oz0art21+4wlfw42xkcTadsh1z39C3RNrhi3OJce77J6p
        nzw0O6OiL//OjZUAHzxmgw==
X-Google-Smtp-Source: ABdhPJyfbGTc/n/GfKJoH0JNZeeP/r9GRYDLNhD4cV5kxaOaMFhGneAVaQ0b5spRIPRg6lPdQ/DKlw==
X-Received: by 2002:aca:1b03:: with SMTP id b3mr1573515oib.173.1634937315231;
        Fri, 22 Oct 2021 14:15:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j4sm2045461oia.56.2021.10.22.14.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 14:15:14 -0700 (PDT)
Received: (nullmailer pid 3183548 invoked by uid 1000);
        Fri, 22 Oct 2021 21:15:13 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        james.quinlan@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-pci@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Saenz Julienne <nsaenzjulienne@suse.de>
In-Reply-To: <20211022140714.28767-2-jim2101024@gmail.com>
References: <20211022140714.28767-1-jim2101024@gmail.com> <20211022140714.28767-2-jim2101024@gmail.com>
Subject: Re: [PATCH v5 1/6] dt-bindings: PCI: Add bindings for Brcmstb EP voltage regulators
Date:   Fri, 22 Oct 2021 16:15:13 -0500
Message-Id: <1634937313.387025.3183547.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 22 Oct 2021 10:06:54 -0400, Jim Quinlan wrote:
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
>  .../bindings/pci/brcm,stb-pcie.yaml           | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml:169:111: [warning] line too long (111 > 110 characters) (line-length)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1544972

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

