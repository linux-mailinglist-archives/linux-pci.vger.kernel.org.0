Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3DA46D4A9
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 14:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbhLHNsT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 08:48:19 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:41550 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbhLHNsR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 08:48:17 -0500
Received: by mail-oi1-f176.google.com with SMTP id u74so4158659oie.8;
        Wed, 08 Dec 2021 05:44:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ceS8DOyVWiqDmyJJ3O1SxSQy6Mk9Il1x095szsCVvCw=;
        b=bZGe2vU78QTb9s3gnXeasjw+G64aKNlMPkEPxdDdQDsyrNJjCh3d7UeVQ+7rdZYub9
         MyoQaSHCfAWF+IdOY/c9wc+9h0bnaKHXsZyMO9/bhuFR6u3XZYlFTevbtAcDekVbehTM
         uZbIROjtFwKuCsjWmAWR0nHF5j5+Q2az0Ryoq1hraUJH+JaeuQzpUpyXydT4tIFNhIR8
         lrB/rXjhtoOslrO5aeLHFNoEetWTqNO3A6UG77a4J1aQAaFKqpmQqDqM2MILggi6B1J7
         nqdsH2hRKZim+lDBqBeChmqU3aTjPQHONAkXSiTIbCHZIe72nObFPboLB47I6l/e/MI9
         JKBw==
X-Gm-Message-State: AOAM530+IjbG+iHX/AnHYmA9IcqLY1g0mR4XYKB/CEjyfSUtmiWwk8a2
        bweYWt5Vy/PQyPkcTMuHIQ==
X-Google-Smtp-Source: ABdhPJxec+HLy8UT+2rjcGw7AHcsngceV3o3idoapO24k1Xgr43VxBA9b+cmmsDjrWI29eG6b2EffA==
X-Received: by 2002:a54:4693:: with SMTP id k19mr12076076oic.125.1638971084934;
        Wed, 08 Dec 2021 05:44:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c41sm509087otu.7.2021.12.08.05.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 05:44:44 -0800 (PST)
Received: (nullmailer pid 3857738 invoked by uid 1000);
        Wed, 08 Dec 2021 13:44:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Ray Jui <rjui@broadcom.com>, devicetree@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211208040432.3658355-7-f.fainelli@gmail.com>
References: <20211208040432.3658355-1-f.fainelli@gmail.com> <20211208040432.3658355-7-f.fainelli@gmail.com>
Subject: Re: [PATCH v3 6/6] dt-bindings: pci: Convert iProc PCIe to YAML
Date:   Wed, 08 Dec 2021 07:44:28 -0600
Message-Id: <1638971068.781821.3857737.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 07 Dec 2021 20:04:32 -0800, Florian Fainelli wrote:
> Conver the iProc PCIe controller Device Tree binding to YAML now that
> all DTS in arch/arm and arch/arm64 have been fixed to be compliant.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/pci/brcm,iproc-pcie.txt          | 133 -------------
>  .../bindings/pci/brcm,iproc-pcie.yaml         | 176 ++++++++++++++++++
>  2 files changed, 176 insertions(+), 133 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1565076


pcie@18012000: msi-controller: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dt.yaml
	arch/arm/boot/dts/bcm911360_entphn.dt.yaml
	arch/arm/boot/dts/bcm911360k.dt.yaml
	arch/arm/boot/dts/bcm958300k.dt.yaml
	arch/arm/boot/dts/bcm958305k.dt.yaml
	arch/arm/boot/dts/bcm958522er.dt.yaml
	arch/arm/boot/dts/bcm958525er.dt.yaml
	arch/arm/boot/dts/bcm958525xmc.dt.yaml
	arch/arm/boot/dts/bcm958622hr.dt.yaml
	arch/arm/boot/dts/bcm958623hr.dt.yaml
	arch/arm/boot/dts/bcm958625hr.dt.yaml
	arch/arm/boot/dts/bcm958625k.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml
	arch/arm/boot/dts/bcm988312hr.dt.yaml

pcie@18012000: ranges: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/bcm911360_entphn.dt.yaml
	arch/arm/boot/dts/bcm911360_entphn.dt.yaml
	arch/arm/boot/dts/bcm911360k.dt.yaml
	arch/arm/boot/dts/bcm911360k.dt.yaml
	arch/arm/boot/dts/bcm958300k.dt.yaml
	arch/arm/boot/dts/bcm958300k.dt.yaml
	arch/arm/boot/dts/bcm958305k.dt.yaml
	arch/arm/boot/dts/bcm958305k.dt.yaml

pcie@18012000: Unevaluated properties are not allowed ('linux,pci-domain', 'bus-range', '#address-cells', '#size-cells', 'device_type' were unexpected)
	arch/arm/boot/dts/bcm911360_entphn.dt.yaml
	arch/arm/boot/dts/bcm911360k.dt.yaml
	arch/arm/boot/dts/bcm958300k.dt.yaml
	arch/arm/boot/dts/bcm958305k.dt.yaml

pcie@18013000: msi-controller: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/bcm53340-ubnt-unifi-switch8.dt.yaml
	arch/arm/boot/dts/bcm911360_entphn.dt.yaml
	arch/arm/boot/dts/bcm911360k.dt.yaml
	arch/arm/boot/dts/bcm958300k.dt.yaml
	arch/arm/boot/dts/bcm958305k.dt.yaml
	arch/arm/boot/dts/bcm958522er.dt.yaml
	arch/arm/boot/dts/bcm958525er.dt.yaml
	arch/arm/boot/dts/bcm958525xmc.dt.yaml
	arch/arm/boot/dts/bcm958622hr.dt.yaml
	arch/arm/boot/dts/bcm958623hr.dt.yaml
	arch/arm/boot/dts/bcm958625hr.dt.yaml
	arch/arm/boot/dts/bcm958625k.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml
	arch/arm/boot/dts/bcm988312hr.dt.yaml

pcie@18013000: ranges: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/bcm911360_entphn.dt.yaml
	arch/arm/boot/dts/bcm911360_entphn.dt.yaml
	arch/arm/boot/dts/bcm911360k.dt.yaml
	arch/arm/boot/dts/bcm911360k.dt.yaml
	arch/arm/boot/dts/bcm958300k.dt.yaml
	arch/arm/boot/dts/bcm958300k.dt.yaml
	arch/arm/boot/dts/bcm958305k.dt.yaml
	arch/arm/boot/dts/bcm958305k.dt.yaml

pcie@18013000: Unevaluated properties are not allowed ('linux,pci-domain', 'bus-range', '#address-cells', '#size-cells', 'device_type' were unexpected)
	arch/arm/boot/dts/bcm911360_entphn.dt.yaml
	arch/arm/boot/dts/bcm911360k.dt.yaml
	arch/arm/boot/dts/bcm958300k.dt.yaml
	arch/arm/boot/dts/bcm958305k.dt.yaml

pcie@18014000: msi-controller: 'oneOf' conditional failed, one must be fixed:
	arch/arm/boot/dts/bcm958522er.dt.yaml
	arch/arm/boot/dts/bcm958525er.dt.yaml
	arch/arm/boot/dts/bcm958525xmc.dt.yaml
	arch/arm/boot/dts/bcm958622hr.dt.yaml
	arch/arm/boot/dts/bcm958623hr.dt.yaml
	arch/arm/boot/dts/bcm958625hr.dt.yaml
	arch/arm/boot/dts/bcm958625k.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64-a0.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64w-a0.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx64w.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx65.dt.yaml
	arch/arm/boot/dts/bcm958625-meraki-mx65w.dt.yaml
	arch/arm/boot/dts/bcm988312hr.dt.yaml

